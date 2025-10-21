
unit BtrTable;

interface

uses
  {IdentCode} IcDate, IcTools, IcConv, IcTypes, IcVariab, IcFiles,
              BtrStruct, BtrHand, BtrTools,
              DefFile, FpTools, NexMsg, DDFTools, NexError, TxtWrap, TxtCut,
  {Pervasive} BtrConst, BtrAPI32,
  {Delphi}    DB, Classes, Controls, Forms, SysUtils, Windows, Variants, DateUtils, Dialogs;

const
  cExtension = 'BTR';   //Zakladne nastavenie rozsirenia databaze
  cNoSerNTblNames:string='CBH|TOA|TIA|TOH|TIH|ASCITM|TNP|TNS';
  BEFORE_FIRST = -1;
  BETVEEN      =  0;
  AFTER_LAST   =  1;
  gShowBadIndexName : boolean = FALSE;
  gStatistic2       : boolean = True;
  gBtrErrorLogfile  : boolean = FALSE;

type
    TFilterCond=record                             { 12.11.1997 EK        }
                  Cond  : byte;                    { Filtrovacie pole pre }
                  Fld1  : byte;                    { vytvorenie Temporary }
                  Rel   : byte;                    { databazy pri pouziti }
                  FldC  : boolean;                 { procedur FilterTempOn}
                  Fld2  : byte;                    { a FilterTempOff      }
                  Val   : String[30];
                  Next  : byte;
                end;

    TFilterInd=record                             { 12.11.1997 EK        }
                  Fld   : byte;
                  Min   : String[30];
                  Max   : String[30];
                end;

    TFiltCondArray= Array [1..100] of TFilterCond;
    TFiltIndArray = Array [1..100] of TFilterInd;

//Ezt az recordot inkabb majd valahogy dinamikusan kene megoldani
  TMyIndexSegment = packed record
    Pos: integer;
    Len: integer;
  end;
  TMyIndexDef = packed record
    IndexSegmentsNum: integer;
    IndexSegment: array[0..cMaxIndexSegmentsNumBtr] of TMyIndexSegment;
  end;
  TMyIndexDefs = array[0..cMaxIndexesNumBtr] of TMyIndexDef;

  TErrInfo = record
    Error:boolean;
    TblRecordLen:longint;
    DefRecordLen:longint;
    TblIndexCount:word;
    DefIndexCount:word;
    BadIndexQnt:word;
  end;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


  PRecInfo = ^TRecInfo;
  TRecInfo = packed record
    Bookmark: Integer;
    BookmarkFlag: TBookmarkFlag;
    BookmarkPosition: TBtrPosition;
  end;
  TStatusRec = packed record
    IndexNumber: integer;
    Position   : TBtrPosition;
    Filter     : string;
    Filtered   : boolean;
    EOF        : boolean;
  end;

  TExBufRec = array [0..65535] of byte;

  TBtrieveTable = class(TDataSet)
  private
    oDataBaseName : string;
    oTableName    : string;  // Uplne nazov datanazoveho suboru napr. STKM000
    oTableNameExt : string;
    oFixedName    : string;  // Cast mena databazoveho suboru, ktora sa nemeno napr STKM
    oPosBlock     : string[128];
    oDataLen      : word;
    oKeyNum       : smallint;
    oClient       : CLIENT_ID;

    oDuplic       : boolean;  // TRUE v pripade DuplicitError (Status=5)
    oIsTableOpen  : boolean;
    oCurRec       : integer;
    oRecCnt       : integer;
    oSegCnt       : word;
    oRecordLen    : word;    // Velkost jedneho rekordu
    oRecBufSize   : integer;

    oSaveChanges  : boolean;
    oReadOnly     : boolean;
    oNumOfIndexes : integer;
    oACSNumber    : integer;
    oDOSStrings   : boolean;
    oDefBaseName  : string;

    oIndexDefs    : TIndexDefs;
    oStoreDefs    : Boolean;
    oIndexFieldNames: string;
    oIndexName    : string;
    oIndexNames   : string;
    oFiltered     : boolean;
    oFilter       : string;
    oActFilters   : string;   // tu je oFilter po 1. volani setfilter
    oRecFilterStr : string;   // tu je oFilter po 1. volani RecordCount
    oFiltRecCnt   : longint;
    oActFilter    : boolean;  // ci uz bol volani SetFilter
    oFiltBuffer   : TExBufRec;
    oAutoCreate   : boolean;
    oStatusRec    : array [1..10] of TStatusRec;
    oSwapNum      : byte;
    eBeforePost   : TDataSetNotifyEvent;
    oOpenMode     : smallint;
    oShowErrMsg   : boolean;
    oBtrErrorLogfile  : byte;
    oDelToTXT     : boolean;

    function  IndexDefsStored: Boolean; //1999.12.20.
    procedure SetIndexDefs(Value: TIndexDefs); //1999.12.20.
    function  GetIndexFieldNames: string; //1999.12.20.
    procedure SetIndexFieldNames(const Value: string); //1999.12.20.
    procedure SetIndexName(const Value: string); //2000.08.22.
    procedure AddToLogFile (pFileName,pProces:string); // 2003.07.30 Prida zaznam do LOG suboru
    procedure ClearErrInfo;
    procedure SetMyFiltered(pValue:boolean);
    procedure DeltoDTX;
  protected
    function  GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;
    function  AllocRecordBuffer: PChar; override;
    procedure FreeRecordBuffer(var Buffer: PChar); override;
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
    function  GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;
    function  GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function  GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function  GetRecordSize: Word; override;
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    procedure InternalHandleException; override;
    procedure InternalInitRecord(Buffer: PChar); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalSetToRecord(Buffer: PChar); override;
    function  IsCursorOpen: Boolean; override;
    procedure SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag); override;
    procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;

    //AgySoft section begin
    function GotoDirect(pPosition: TBtrPosition): boolean;
    procedure Unlock;
    procedure Statistic;
    procedure Statistic2;

    procedure InternalFind;
    function  InternalFindKey: boolean;
    function  InternalFindNearest: boolean;
    procedure SetFilter(var pBuffer; pEG_UC: boolean;pRecCount:longint;pFields:String); //2000.5.5.
    function  GetTableFileName: string;
    function  GetDefFileName: string;
    procedure InternalInitFieldDefs; override;
    procedure TableBeforePost(DataSet: TDataset); //2000.5.9.
    //AgySoft section end
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; override;
    procedure InternalRefresh; override;

  protected
    function  GetPosition:TBtrPosition;
    procedure SetKeyFields(const pValues: array of const);
    function  InternalInitIndexDefs: boolean;
    procedure UpdateIndexDefs; //1999.12.20.
    function  IndexsegmentPosToFieldNo(pPos: integer): integer; //1999.12.27.
  public
    // EK 02.11.2000 kvoli TEMP filtrovaniu
    oStatus       : smallint; // Stav po vykonani operacie
    oFieldOffset  : TList;
    oFieldWidth   : TList;
    oFieldICCType : TList;
    oFieldDEFType : TList;
    oFieldFullName: TStringlist;
    oKeyBuf       : string[255];
    oMyIndexDefs  : TMyIndexDefs;
    oFilterInd    : byte;               // filtrovaci index
    oFilterIndFlds: string;             //  zoznam poli filtrovacieho indexu napr: 1;8;12
    oFiltCondFlds : string;             //  zoznam poli filtrovacej podmienky
    oFilterCond   : TFiltCondArray;     // filtrovacie podmienky
    oFiltIndArray : TFiltIndArray;      // podmienky  pre filtrovanie podla indexov
    oDefName      : string;             // Meno databazoveho suboru
    oCrtDat       : boolean;            // Ak je FALSE system pri ulozeni zaznamu nemodifikuje CrtName, CrtDate, CrtTime
    oModify       : boolean;            // Ak je FALSE system pri ulozeni zaznamu nemodifikuje ModName, ModDate, ModTime
    oSended       : boolean;            // Ak je FALSE system pri ulozeni zaznamu nemodifikuje priznak Sended
    oArchive      : boolean;            // Ak je FALSE system pri ulozeni zaznamu nemodifikuje priznak Archive
    oErrInfo      : TErrInfo;           // Inform·cie o rozdielov medzi datab·zov˝m s˙borom a definiËn˝m s˙borom

    constructor Create(AOwner: TComponent); override; //1999.12.20.
    destructor Destroy; override; //1999.12.20.
    function  AddFilter (pFldName,pValue:string;pAND:boolean):boolean; overload;
    function  AddFilter (pFldName,pInt1,pInt2:string;pAND:boolean):boolean; reintroduce; overload;
    procedure ClearFilter;
    procedure CalcField (pType:byte;pFld:integer;var pSum: double;var pCount:longint;var pMin,pMax:double);
    function  GetRecordCount: Integer; override;
    function  GetRecordCountNoSwap: Integer;
    procedure SetKeyNum(pKeyNum:smallint);
    procedure ClrKeyNum;
    function  FindKey(const pKeyValues: array of const): boolean;
    function  FindNearest (const pKeyValues: array of const): boolean;
    function  Exists: Boolean; //2000.5.9.
    procedure CreateTable; //2000.5.9.
    procedure SwapStatus; //2000.5.12.
    procedure RestoreStatus; //2000.5.12.
    procedure SwapIndex; //2002.18.11.
    procedure RestoreIndex; //2000.18.11.
    function ActPos: integer; //2000.5.14.
    function GotoPos(pActPos: integer):boolean; //2000.8.14.
    function GetRecordBuffer:PChar;
    procedure SetRecordBuffer(pBuffer:PChar);
    procedure ShowBtrError(pOp:Str20;pStatus: Integer);
    procedure SetFilterOn (pFilter:string);
    procedure SetFilterOff;
    procedure IndFlds(pInd:byte; var pFlags:string);
    PROCEDURE SearchFiltInd ;
    FUNCTION  SetFiltInd(pFiltInd:byte):boolean;
    PROCEDURE FirstFiltInd;
    FUNCTION  IsInFiltInd:boolean;
    FUNCTION  CheckFiltRec:boolean;
    function  DeleteTable:boolean; virtual;
    function  GetRecordLen: longint;  // Dlazka vety v bytoch
    function  IsFirstRec: boolean; // TRUE al zaznam je prvy
    function  IsLastRec: boolean; // TRUE al zaznam je posledny
    function  GetVersion:string;
    procedure DTX2Btr;
    procedure SearchFields (pType:byte;pCnt,pFld:integer;pSrchStr:Str30;var pPositions: String;var pCount:longint;pUperCase:byte);
    procedure GetField (pType:byte;pCnt,pFld:integer;var pValues: String;var pCount:longint);
    procedure GetFields (pType:byte;pCnt:integer;var pValues: String;var pCount:longint;pFields:String);
    // pUpperCase : 0=nic 1=odstrani diakritiku 2=konvertuje na velke 3=1+2
    // prikald pouzitia je na konci

  published
    property DelToTXT:boolean read oDelToTXT write oDelToTXT;
    property BtrErrorLogfile:byte read oBtrErrorLogfile write oBtrErrorLogfile;
    property ShowErrMsg:boolean read oShowErrMsg write oShowErrMsg;
    property OpenMode:smallint read oOpenMode write oOpenMode;
    property RecNo: Integer read GetRecNo write SetRecNo;
    property DataBaseName: string read oDataBaseName write oDataBaseName;
    property FixedName: string read oFixedName write oFixedName;
    property TableName: string read oTableName write oTableName;
    property TableNameExt: string read oTableNameExt write oTableNameExt;
    property DOSStrings: boolean read oDOSStrings write oDOSStrings;
    property IndexNumber: smallint read oKeyNum write SetKeyNum default 0;
    property DefPath: string read oDefBaseName write oDefBaseName;
    property DefName: string read oDefName write oDefName;
    property IndexDefs: TIndexDefs read oIndexDefs write SetIndexDefs stored IndexDefsStored; //1999.12.20.
    property StoreDefs: Boolean read oStoreDefs write oStoreDefs default False; //1999.12.20.
    property IndexFieldNames: string read oIndexFieldNames write SetIndexFieldNames; //1999.12.20.
    property IndexName: string read oIndexName write SetIndexName; //2000.08.22.
    property Filtered: boolean read oFiltered write SetMyFiltered default False; //2000.5.4.
    property Filter: string read oFilter write oFilter; //2000.5.4.
    property AutoCreate: boolean read oAutoCreate write oAutoCreate;  //2000.5.11.
    property CrtDat: boolean read oCrtDat write oCrtDat;  //2003.20.02.- Ak je FALSE system pri ulozeni zaznamu nemodifikuje CrtName, CrtDate, CrtTime
    property Modify: boolean read oModify write oModify;  //2003.20.02.- Ak je FALSE system pri ulozeni zaznamu nemodifikuje ModName, NodDate, ModTime
    property Sended: boolean read oSended write oSended;  //2003.20.02.- Ak je FALSE system pri ulozeni zaznamu nemodifikuje priznak Sended
    property Archive: boolean read oArchive write oArchive;  //2003.20.02. - Ak je FALSE system pri ulozeni zaznamu nemodifikuje priznak Archive
    property BeforePost: TDataSetNotifyEvent read eBeforePost write eBeforePost;

    property Active;
    property FieldDefs;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnNewRecord;
    property OnPostError;
    property Duplic: boolean read oDuplic;
  end;

  PROCEDURE CreateIntervalStr(pBtr:TBtrieveTable;pFld:Str20;var pStr:string);

  procedure Register;

implementation


/////////////////////////////// EK 2000-11-02 for TEMP Filter
  procedure TBtrieveTable.IndFlds(pInd:byte; var pFlags:string);
  var mI,mFld:byte;
  begin
    pFlags:='';
    for mI:=0 to LineElementNum(IndexDefs.Items[pInd].Fields,';')-1 do begin
      mFld:=FindMyFldName(Self,LineElement(IndexDefs.Items[pInd].Fields,mI,';') );
      pFlags:=pFlags+';'+StrInt(mFld,0);
    end;
    If pFlags[1]=';' then System.Delete (pFlags,1,1);
  end;

  PROCEDURE  TBtrieveTable.SearchFiltInd;
    var
      mFind,mOK,mF : boolean;
      mCount,mI,mJ,mK,mNum: byte;
      mFld,mFlags:String;
    BEGIN
      mNum:=0; { pocet existujucich segmentov vo filtri }
      oFilterInd:=0;
      For mI:=0 to IndexDefs.Count-1 do begin { Indexy }
        mJ:=0;mFind:=TRUE;
        IndFlds(mI,mFlags);
        mCount:=LineElementNum(mFlags,';');
        While (mJ<mCount) and mFind do begin
          mFld:=LineElement(mFlags,mJ,';');
          mK:=1;mF:=FALSE; {segment je vo filtrovacom poli}
          While (oFilterCond [mK].Cond<>0) and not mF do begin
          { existencia segmentu vo filtrovacom poli 1..mK }
            mF:=LineElementPos(StrInt(oFilterCond [mK].Fld1,0),mFld,';')>-1;
            Inc (mK);
          end;
          mFind:=mF;
          If mFind then Inc (mJ); { pocet existujucich prvych ˛mJ˛ segmentov }
        end;
//        Dec(mJ);
        If mJ>mNum then begin     { lepsi index }
          oFilterInd:=mI;
          mNum:=mJ;
        end;
      end;  {for}
    END;     { *** SearchFiltInd *** }


  FUNCTION   TBtrieveTable.SetFiltInd (pFiltInd:byte):boolean;
    var                               // BtrTable
      mFind,mOK,mOne: boolean;
      mI,mJ,j,mCount,mFld : byte;
      mFlags,mStr   : string;
      mFieldICCType,mDefOpType:integer;
    BEGIN
      mI:=1;
      oFilterInd:=pFiltInd;
      If oFilterInd=255 then SearchFiltInd;
      mOK:=oFilterInd>=0;
      If mOK then begin
        IndFlds(oFilterInd,oFilterIndFlds);
      end;
      mCount:=LineElementNum(oFilterIndFlds,';');
      while mOK and (mI<=mCount) do begin
        mFld:=ValInt(LineElement(oFilterIndFlds,mI-1,';'));
        oFiltIndArray[mI].Fld:=mFld;
        mDefOpType    := Integer(oFieldDEFType[oFiltIndArray[mI].Fld]);
        mFieldICCType := Integer(oFieldICCType[oFiltIndArray[mI].Fld]);
        case mFieldICCType of
  {1}     INTEGER_TYPE: begin oFiltIndArray[mI].Min:='0';            oFiltIndArray[mI].Max:='32767';          end;
  {2}     IEEE_TYPE   : begin oFiltIndArray[mI].Min:='-9999999999.9';oFiltIndArray[mI].Max:='9999999999.9';   end;
  {3}     DATE_TYPE   : begin oFiltIndArray[mI].Min:='0';            oFiltIndArray[mI].Max:='31.12.2020';     end;
  {4}     TIME_TYPE   : begin oFiltIndArray[mI].Min:='0';            oFiltIndArray[mI].Max:='23:59';          end;

  {5}     DECIMAL_TYPE: begin oFiltIndArray[mI].Min:='0';            oFiltIndArray[mI].Max:='2147483647';     end;
  {6}     MONEY_TYPE  : begin oFiltIndArray[mI].Min:='-9999999999.9';oFiltIndArray[mI].Max:='9999999999.9';   end;
  {7}     LOGICAL_TYPE: ;
  {8}     NUMERIC_TYPE: ;
  {9}     BFLOAT_TYPE : begin oFiltIndArray[mI].Min:='-9999999999.9';oFiltIndArray[mI].Max:='9999999999.9';   end;
  {10}    LSTRING_TYPE: begin
                          Fillchar (oFiltIndArray[mI].Max,30,#0);  oFiltIndArray[mI].Min[0]:=#0;
                          Fillchar (oFiltIndArray[mI].Max,30,#255);oFiltIndArray[mI].Max[0]:=#30;
                        end;
  {11}    ZSTRING_TYPE: ;
  {14}    UNSIGNED_BINARY_TYPE: begin oFiltIndArray[mI].Min:='0';            oFiltIndArray[mI].Max:='2147483647';     end;
          else begin
            Fillchar (oFiltIndArray[mI].Max,30,#0);  oFiltIndArray[mI].Min[0]:=#0;
            Fillchar (oFiltIndArray[mI].Max,30,#255);oFiltIndArray[mI].Max[0]:=#30;
          end;
        end; {case }
        mJ:=1;mFind:=FALSE;mOne:=mFind;
        While (oFilterCond [mJ].Cond<>0) do begin
          mOne:=oFilterCond [mJ].Fld1=oFiltIndArray [mI].Fld;
          If mOne and not oFilterCond [mJ].FldC then begin
            If (oFilterCond [mJ].Rel=0) then begin
              oFiltIndArray [mI].Min:=oFilterCond [mJ].Val;
              oFiltIndArray [mI].Max:=oFilterCond [mJ].Val;
            end;
            If (oFilterCond [mJ].Rel=1) or (oFilterCond [mJ].Rel=3) then begin
              oFiltIndArray [mI].Min:=oFilterCond [mJ].Val;
            end;
            If (oFilterCond [mJ].Rel=2) or (oFilterCond [mJ].Rel=4) then begin
              oFiltIndArray [mI].Max:=oFilterCond [mJ].Val;
            end;
          end;
          mFind:=mOne or mFind;
          Inc (mJ);
        end;
        If mI=1 then mOK:=mFind;
        Inc (mI);
      end;
      SetFiltInd:=mOK;
    END;     { *** SetFiltInd *** }

  PROCEDURE   TBtrieveTable.FirstFiltInd;
    var
      mI,mFlag : byte;
      mInteger, mFieldNo, mPos, mDEFOpType, mFieldICCType: integer;
      mDesc:boolean;
      mValueStr:string;
      mLen,mWord:word;
      mLongint: longint;
      mDouble:double;
      mStr255: string[255];
    BEGIN
      mPos:=1;mI:=1;
      SetKeyNum(oFilterInd);
      First;
      while (mI<=LineElementNum(oFilterIndFlds,';')) do begin
//        mDesc:=Pos(Fields[uFiltInd].FieldName ,IndexDefs.Items[uFiltInd].DescInfields)>0;
        mDesc:=FALSE;
        if mDesc then begin
          If oFiltIndArray[mI].Max[Length (oFiltIndArray[mI].Max)]='*'
            then mValueStr := Copy (oFiltIndArray[mI].Max,1,Length (oFiltIndArray[mI].Max)-1)
            else mValueStr := oFiltIndArray[mI].Max;
        end else begin
          If oFiltIndArray[mI].Min[Length (oFiltIndArray[mI].Min)]='*'
            then mValueStr := Copy (oFiltIndArray[mI].Min,1,Length (oFiltIndArray[mI].Max)-1)
            else mValueStr := oFiltIndArray[mI].Min;
        end;
        mFieldNo := ValInt(LineElement(oFilterIndFlds,mI-1,';'));
        If (mFieldNo >= 0) then begin
          mDEFOpType    := Integer(oFieldDEFType[mFieldNo]);
          mFieldICCType := Integer(oFieldICCType[mFieldNo]); //??? vagy mFieldNo-1
          mLen          := Integer(oFieldWidth  [mFieldNo]);
          If (mDefOpType = 3) then mValueStr:=IntToStr(Date_To_FPDate( StrToDate(mValueStr)))
            else  If (mDefOpType = 4) then mValueStr:=IntToStr(TIME_To_FPTIME( StrToTIME(mValueStr)));
          case mFieldICCType of
            IEEE_TYPE:  begin
                          mDouble:=StrtoFloat(mvalueStr);
                          Move(mDouble,oKeyBuf[mPos], 8);
                        end;
            LSTRING_TYPE :
              begin
                mStr255 := mValueStr;
                move(mStr255, oKeyBuf[mPos], length(mStr255)+1);
              end;
            UNSIGNED_BINARY_TYPE :
              begin
                If mlen = 2 then begin
                  If mValueStr <> ''
                    then mWord := StrToInt(mValueStr)
                    else mWord := 0;
                  move(mWord, oKeyBuf[mPos], 2);
                end else begin
                  If mValueStr <> ''
                    then mInteger := StrToInt(mValueStr)
                    else mInteger := 0;
                  move(mInteger, oKeyBuf[mPos], 4);
                end;
              end;
            else
              begin
                mInteger := StrToInt(mValueStr);
                move(mInteger, oKeyBuf[mPos], 4);
              end;
          end;
        end;
        mPos := mPos + oMyIndexDefs[oFilterInd].IndexSegment[mI-1].Len;
        Inc (mI);
      end;
      If not InternalFindNearest then Last;
    END;     { *** FirstFiltInd *** }

  FUNCTION    TBtrieveTable.IsInFiltInd:boolean;
    var
      mI   : byte;
      mOK  : boolean;
      mStr1,mStr2:string[30];
      mD1,mD2: TFpDate;
      mTime  : TFpTime;
      mErr   : integer;
      mLen,mWord : word;
      mInteger, mFieldNo, mPos, mDEFOpType, mFieldICCType: integer;
    BEGIN
      mI :=1;
      mOK:=TRUE;
      while (mI<=1) do begin
//      while (mI<=LineElementNum(oFilterIndFlds,';')) do begin
        mFieldNo      := ValInt(LineElement(oFilterIndFlds,mI-1,';'));
        mDEFOpType    := Integer(oFieldDEFType[mFieldNo]);
        mFieldICCType := Integer(oFieldICCType[mFieldNo]); //??? vagy mFieldNo-1
        mLen          := Integer(oFieldWidth  [mFieldNo]);

          case mFieldICCType of
            IEEE_TYPE:  begin
                          mStr1:=FloatToStr(Fields[mFieldNo].AsFloat);
                        end;
            LSTRING_TYPE :
                        begin
                          mStr1:=Fields[mFieldNo].AsString;
                        end;
            UNSIGNED_BINARY_TYPE :
                        begin
                          If mDefOpType in [3,4] then begin
                            mStr1:=DateToStr(Fields[mFieldNo].AsDateTime);
                            If (mDefOpType = 3) then mStr1:=IntToStr(Date_To_FPDate( StrToDate(mStr1)))
                            else  If (mDefOpType = 4) then mStr1:=IntToStr(TIME_To_FPTIME( StrToTIME(mStr1)));
                          end else mStr1:=IntToStr(Fields[mFieldNo].AsInteger);
                        end;
            else mStr1:=IntToStr(Fields[mFieldNo].AsInteger);
          end; // case
        mStr1:=AlignLeft (mStr1,30);
        case mDEFOpType of
           1,2,5..9,14..20: mStr2:= AlignLeft (FloatToStr(StrToFloat(oFiltIndArray[mI].Max)),30);
           3: begin
                mD1:=Date_To_FPDate(StrTodate(oFiltIndArray[mI].Max));
                If mD1<32873 then mD1:=Date_To_FPDate(ChangeDate(FpDate_To_Date(mD1),0,0,100));
                mStr2:= AlignLeft (Strint (mD1,0),30);
              end;
           4: begin
                mTime:=Time_To_FPTime(StrToTime(oFiltIndArray[mI].Max));
                mStr2:= AlignLeft (StrInt (mTime,0),30);
              end;
          else begin // sem patri 10 = LString a 11 = ZString
            If (Pos('*', oFiltIndArray[mI].Max) > 0)
            and(Pos('..',oFiltIndArray[mI].Max) = 0) then begin
              mStr1:=AlignLeft (Copy (RemSpaces (mStr1),  1,Pos ('*',oFiltIndArray[mI].Max)-1),30);
              mStr2:=AlignLeft (Copy (oFiltIndArray[mI].Max, 1,Pos ('*',oFiltIndArray[mI].Max)-1),30);
            end else begin
              If (Pos('..',oFiltIndArray[mI].Max) > 0)
                then mStr2:= mStr1
                else mStr2:= AlignLeft (oFiltIndArray[mI].Max,30);
            end;
          end;
        end; {case}

        case mDEFOpType   of
          1,2,5..9,14..20 :
          begin
            mOK := StrToFloat (mStr1) <= StrToFloat (mStr2);
          end;
          3,4 :  // doplnil som aj 9  EK 2000-11-02
          begin
            mOK := StrToInt (mStr1) <= StrToInt (mStr2);
{
            ValDate (RemSpaces (mStr1),mD1,mErr);ValDate (RemSpaces (mStr2),mD2,mErr);
            If mD1<32873 then mD1:=ChangeDate(mD1,0,0,100);
            If mD2<32873 then mD2:=ChangeDate(mD2,0,0,100);
            mOK := mD1 <= mD2;
}
          end;
          else begin // 10,11
            mOK := mStr1 <= mStr2;
          end;
        end;
        Inc (mI);
      end;
      ISInFiltInd:=mOK;
    END;     { *** ISInFiltInd *** }

FUNCTION   TBtrieveTable.CheckFiltRec:boolean;
    var
      mOK    : boolean;
      mEnd   : boolean;
      mFull  : boolean;
      mStr1  : String[80];
      mStr2  : String[80];
      mD1,mD2: TFPDate;
      mTime  : TFPTime;
      mErr   : integer;
      mI     : byte;
      mStr   : String;
      mLen,mWord : word;
      mInteger, mFieldNo, mPos, mDEFOpType, mFieldICCType: integer;
    BEGIN
//      If ExProc then oFilterStop:=TRUE;
      mOK := TRUE;mEnd:=FALSE;mFull:=TRUE;
      mI  := 1;
      While (oFilterCond[mI].Cond<>0)and not mEnd do begin

        mFieldNo      := oFilterCond[mI].Fld1;
        mDEFOpType    := Integer(oFieldDEFType[mFieldNo]);
        mFieldICCType := Integer(oFieldICCType[mFieldNo]); //??? vagy mFieldNo-1
        mLen          := Integer(oFieldWidth  [mFieldNo]);

          case mFieldICCType of
            IEEE_TYPE:  begin
                          mStr1:=FloatToStr(Fields[mFieldNo].AsFloat);
                        end;
            LSTRING_TYPE :
                        begin
                          mStr1:=Fields[mFieldNo].AsString;
                        end;
            UNSIGNED_BINARY_TYPE :
                        begin
                          If mDefOpType in [3,4] then begin
                            mStr1:=DateToStr(Fields[mFieldNo].AsDateTime);
                            If (mDefOpType = 3) then mStr1:=IntToStr(Date_To_FPDate( StrToDate(mStr1)))
                            else  If (mDefOpType = 4) then mStr1:=IntToStr(TIME_To_FPTIME( StrToTIME(mStr1)));
                          end else mStr1:=IntToStr(Fields[mFieldNo].AsInteger);
                        end;
            else mStr1:=IntToStr(Fields[mFieldNo].AsInteger);
          end; // case
        mStr1:=AlignLeft (mStr1,80);

        If oFilterCond[mI].FldC then begin
          mFieldNo      := oFilterCond[mI].Fld2;
          mDEFOpType    := Integer(oFieldDEFType[mFieldNo]);
          mFieldICCType := Integer(oFieldICCType[mFieldNo]); //??? vagy mFieldNo-1
          mLen          := Integer(oFieldWidth  [mFieldNo]);
          case mFieldICCType of
            IEEE_TYPE:  begin
                          mStr2:=FloatToStr(Fields[mFieldNo].AsFloat);
                        end;
            LSTRING_TYPE :
                        begin
                          mStr2:=Fields[mFieldNo].AsString;
                        end;
            UNSIGNED_BINARY_TYPE :
                        begin
                          If mDefOpType in [3,4] then begin
                            mStr2:=DateToStr(Fields[mFieldNo].AsDateTime);
                            If (mDefOpType = 3) then mStr2:=IntToStr(Date_To_FPDate( StrToDate(mStr2)))
                            else  If (mDefOpType = 4) then mStr2:=IntToStr(TIME_To_FPTIME( StrToTIME(mStr2)));
                          end else mStr2:=IntToStr(Fields[mFieldNo].AsInteger);
                        end;
            else mStr2:=IntToStr(Fields[mFieldNo].AsInteger);
          end; // case
          mStr2:=AlignLeft (mStr2,80);
        end else begin
          case mDEFOpType of
             1,2,5..9,14..20: mStr2:= AlignLeft (FloatToStr(StrToFloat(oFilterCond[mI].Val)),80);
             3: begin
                  mD1:=Date_To_FPDate(StrTodate(oFilterCond[mI].Val));
                  If mD1<32873 then mD1:=Date_To_FPDate(ChangeDate(FpDate_To_Date(mD1),0,0,100));
                  mStr2:= AlignLeft (Strint (mD1,0),80);
                end;
             4: begin
                  mTime:=Time_To_FPTime(StrToTime(oFilterCond[mI].Val));
                  mStr2:= AlignLeft (StrInt (mTime,0),80);
                end;
            else begin
              If (Pos('*', oFilterCond[mI].Val) > 0)
              and(Pos('..',oFilterCond[mI].Val) = 0) then begin
                mStr1:=AlignLeft (Copy (RemSpaces (mStr1),  1,Pos ('*',oFilterCond[mI].Val)-1),80);
                mStr2:=AlignLeft (Copy (oFilterCond[mI].Val,1,Pos ('*',oFilterCond[mI].Val)-1),80);
              end else begin
                If (Pos('..',oFilterCond[mI].Val) > 0)
                 and (oFilterCond[mI].Rel=0)then begin
                  mStr2:= UpperCase (oFilterCond[mI].Val);
                  If Pos('*',mStr2) > 0 then mStr2:=Copy (mStr2,1,Pos('*',mStr2)-1);
                  mStr2:=Copy (mStr2,3,length (mStr2)-2);
                  If Pos (mStr2,Uppercase(mStr1))=0 then mStr2:=#254+#254+#254+#254+#254 else mStr2:=mStr1;
                end else begin
                  mStr2:= AlignLeft (oFilterCond[mI].Val,80);
                end;
              end;
            end;
          end;
        end;
        case mDEFOpType  of
          1,2,5..9,14..20 :
          begin
            Case oFilterCond[mI].Rel of
              0: mOK := StrToFloat(mStr1) =  StrToFloat(mStr2);
              1: mOK := StrToFloat(mStr1) >  StrToFloat(mStr2);
              2: mOK := StrToFloat(mStr1) <  StrToFloat(mStr2);
              3: mOK := StrToFloat(mStr1) >= StrToFloat(mStr2);
              4: mOK := StrToFloat(mStr1) <= StrToFloat(mStr2);
              5: mOK := StrToFloat(mStr1) <> StrToFloat(mStr2);
            end;
          end;
          3,4 :  // doplnil som aj 9  EK 2000-11-02
          begin
            Case oFilterCond[mI].Rel of
              0: mOK := StrToInt  (mStr1) =  StrToInt  (mStr2);
              1: mOK := StrToInt  (mStr1) >  StrToInt  (mStr2);
              2: mOK := StrToInt  (mStr1) <  StrToInt  (mStr2);
              3: mOK := StrToInt  (mStr1) >= StrToInt  (mStr2);
              4: mOK := StrToInt  (mStr1) <= StrToInt  (mStr2);
              5: mOK := StrToInt  (mStr1) <> StrToInt  (mStr2);
            end;
          end;
          else begin
            Case oFilterCond[mI].Rel of
              0: mOK := mStr1 =  mStr2;
              1: mOK := mStr1 >  mStr2;
              2: mOK := mStr1 <  mStr2;
              3: mOK := mStr1 >= mStr2;
              4: mOK := mStr1 <= mStr2;
              5: mOK := mStr1 <> mStr2;
            end;
          end;
        end;
        If mI>1then begin
          If oFilterCond[mI-1].Next=2 then mFull:=mFull or  mOK
                                           else mFull:=mFull and mOK;
        end else mFull:=mOK;
        If mFull     and (oFilterCond[mI].Next=2) then mEnd:= TRUE;
        If not mFull and (oFilterCond[mI].Next=1) then mEnd:= TRUE;
        Inc (mI);
      end;
      CheckFiltRec:=mFull
    END;     { *** CheckFiltRec *** }

/////////////////////////////// EK 2000-11-02 for TEMP Filter

procedure TBtrieveTable.ClearFilter;
begin
  oFilter:='';
  oFiltered:=FALSE;
end;

function  TBtrieveTable.AddFilter (pFldName,pValue:string;pAND:boolean):boolean;
begin
  If FindField(pFldName)<>nil then begin
    If pAnd
      then oFilter:=oFilter+'^'+'['+IntToStr(FieldDefs.Find(pFldName).FieldNo-1)+']={'+pValue+'}'
      else oFilter:=oFilter+'@'+'['+IntToStr(FieldDefs.Find(pFldName).FieldNo-1)+']={'+pValue+'}';
    If oFilter[1]<>'[' then system.Delete (oFilter,1,1);
    result:=true;
  end else result:=false;
end;

function   TBtrieveTable.AddFilter (pFldName,pInt1,pInt2:string;pAND:boolean):boolean;
var mStr:string;
begin
  If FindField(pFldName)<>nil then begin
    If (pInt1<>'') or (pInt2<>'') then begin
      mStr:='['+IntToStr(FieldDefs.Find(pFldName).FieldNo-1)+']';
      If (pInt1<>'') and (pInt2<>'') then
      begin
        If pInt1=pInt2
          then mStr:=mStr+'={'+pInt1+'}'
          else mStr:=mStr+'>={'+pInt1+'}^'+mStr+'<={'+pInt2+'}';
      end else begin
       If (pInt1='')
         then mStr:=mStr+'<={'+pInt2+'}'
         else mStr:=mStr+'>={'+pInt1+'}';
      end;
      If pAnd then oFilter:=oFilter+'^'+mStr else oFilter:=oFilter+'@'+mStr;
      If oFilter[1]<>'[' then System.Delete (oFilter,1,1);
    end;
    result:=true;
  end else result:=false;
end;

function  TBtrieveTable.DeleteTable:boolean;
var mTable:string;
begin
  Result := TRUE;
  If TableNameExt<>''
    then mTable := TableName+'.'+TableNameExt
    else mTable := TableName;
  If Pos ('.',mTable)=0 then mTable := mTable+'.'+cExtension;
  mTable := DatabaseName+mTable;
  If FileExistsI(mTable) then begin
    AddToLogFile (mTable,'Delete File');
    Result := SysUtils.DeleteFile (mTable);
  end;
end;

function  TBtrieveTable.GetRecordLen: longint;  // Dlazka vety v bytoch
begin
  Result := oRecordLen;
end;

function  TBtrieveTable.IsFirstRec: boolean; // TRUE al zaznam je prvy
begin
  SwapStatus;
  Prior;
  Result := Bof;
  RestoreStatus;
end;

function  TBtrieveTable.IsLastRec: boolean; // TRUE al zaznam je posledny
begin
  SwapStatus;
  Next;
  Result := Eof;
  RestoreStatus;
end;

function  TBtrieveTable.GetVersion:string;
var mVersion:string;
begin
  oStatus := BtrVersion(oPosBlock,mVersion);
  Result := mVersion;
end;

constructor TBtrieveTable.Create(AOwner: TComponent);
begin
  fillchar(oClient.networkAndNode, sizeof(oClient.networkAndNode), #0);
  oClient.applicationID := 'IC'+#0; //'MT' + #0;  { must be greater than "AA" }
  oClient.threadID := MY_THREAD_ID;
//  oClient:=gClient;
  inherited Create(AOwner);
  oBtrErrorLogfile:=0;
  oDelToTXT    := True;
  oIndexDefs   := TIndexDefs.Create(Self);
  oDOSStrings  := TRUE;
  oFiltered    := FALSE;
  oActFilter   := FALSE;
  oFilter      := '';
  oActFilters  := '';
  oRecFilterStr:='';
  oFiltRecCnt  :=0;
  oCrtDat      := TRUE;
  oModify      := TRUE;
  oSended      := TRUE;
  oArchive     := TRUE;
  oOpenMode    := cbtrOpen;
  oShowErrMsg  := TRUE;
  oSwapNum     := 0;
  inherited BeforePost := TableBeforePost;
end;

destructor TBtrieveTable.Destroy;
begin
// *TIBI*  oIndexDefs.Free;
  FreeAndNil(oIndexDefs);
  inherited Destroy;
end;

procedure TBtrieveTable.InternalRefresh;
begin
//
end;

function TBtrieveTable.Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
var mIndexNumber:byte;   mDim,mDimm:integer;
    mInt:array [0..5] of variant;
begin
  mIndexNumber:=IndexNumber;
  SetIndexFieldNames(KeyFields);
  Fillchar(mInt,SizeOf(mInt),#0);
  mDimm:=VarArrayDimCount(KeyValues);
  If mDimm>0 then begin
    mDimm:=VarArrayHighBound(KeyValues,1);
    try
      If mDimm >0 then begin
        for mDim:=0 to mDimm do
          mInt[mDim]:=KeyValues[mDim];
        case mDimm of
          1: RESULT:=FindKey([mInt[0],mInt[1]]);
          2: RESULT:=FindKey([mInt[0],mInt[1],mInt[2]]);
          3: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3]]);
          4: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3],mInt[4]]);
          5: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3],mInt[4],mInt[5]]);
        end;
      end else begin
        mInt[0]:=KeyValues[0];
        RESULT:=FindKey([mInt[0]]);
      end;
    except
      Result:=FALSE;
    end;
  end else begin
    mDimm:=LineElementNum(KeyValues,';');
    try
      If mDimm >1 then begin
        for mDim:=0 to mDimm-1 do
          mInt[mDim]:=lineElement (KeyValues,mDim,';');
        case mDim of
          2: RESULT:=FindKey([mInt[0],mInt[1]]);
          3: RESULT:=FindKey([mInt[0],mInt[1],mInt[2]]);
          4: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3]]);
          5: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3],mInt[4]]);
          6: RESULT:=FindKey([mInt[0],mInt[1],mInt[2],mInt[3],mInt[4],mInt[5]]);
        end;
      end else begin
        mInt[0]:=KeyValues;
        RESULT:=FindKey([mInt[0]]);
      end;
    except
      Result:=FALSE;
    end;
  end;
  IndexNumber:=mIndexNumber;
end;

function  TBtrieveTable.ActPos: integer; //2000.5.14.
begin
  Result := PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition;
end;

function  TBtrieveTable.GetRecordBuffer;
begin
  Result:=ActiveBuffer;
end;

procedure TBtrieveTable.SetRecordBuffer;
var mDest : PChar;
begin
  mDest:=ActiveBuffer;
  Move (pBuffer[0],mDest[0],oRecordLen);
end;

procedure TBtrieveTable.SetMyFiltered;
begin
  oFiltered:=pValue and (oFilter<>'');
  oRecFilterStr:='';
  GetRecordCount;
end;

function TBtrieveTable.GotoPos(pActPos: integer): boolean; //2000.8.14.
var mActPos: integer;
    mActPosO: integer;
begin
  mActPosO:=pActPos;
  Result := GotoDirect(mActPosO);
  If not Result and (mActPosO=0) then begin
    mActPosO:=-2147483648;
    Result := GotoDirect(mActPosO);
  end;
//  Refresh;
    { EK 25.5.2002 odtialto }
  If Result then begin
    { EK 25.5.2002 som to presunul sem }
    with PRecInfo(ActiveBuffer + oRecordLen)^ do begin
      BookmarkFlag     := bfCurrent;
      Bookmark         := BETVEEN;
      BookmarkPosition := mActPosO;
    end;
    mActPos := ActPos;
    Result := (mActPos=mActPosO);//or(mActPos=-2147483648);
    Refresh;
  end;
end;

procedure TBtrieveTable.SwapStatus; //2000.5.12.
begin
  Inc (oSwapNum);
  oStatusRec[oSwapNum].EOF         := EOF;
  oStatusRec[oSwapNum].IndexNumber := IndexNumber;
  oStatusRec[oSwapNum].Position    := ActPos;
  oStatusRec[oSwapNum].Filter      := Filter;
  oStatusRec[oSwapNum].Filtered    := Filtered;
end;

procedure TBtrieveTable.RestoreStatus; //2000.5.12.
begin
  IndexNumber := oStatusRec[oSwapNum].IndexNumber;
  GotoPos(oStatusRec[oSwapNum].Position);
  If (oStatusRec[oSwapNum].Filter<>Filter) or (oStatusRec[oSwapNum].Filtered<>Filtered) then begin
    Filter      := oStatusRec[oSwapNum].Filter;
    Filtered    := oStatusRec[oSwapNum].Filtered;
  end;
  oActFilter  := FALSE;
  Dec(oSwapNum);
  Refresh;
  If oStatusRec[oSwapNum+1].EOF then begin
    Last;
  end;
end;

procedure TBtrieveTable.SwapIndex; //2002.18.11.
begin
  Inc(oSwapNum);
  oStatusRec[oSwapNum].IndexNumber := IndexNumber;
end;

procedure TBtrieveTable.RestoreIndex; //2002.18.11.
begin
  IndexNumber := oStatusRec[oSwapNum].IndexNumber;
  Dec(oSwapNum);
  Refresh;
end;

procedure TBtrieveTable.TableBeforePost(DataSet: TDataset);
var I: integer; mSS:longint; mYS,mDocNum,mStr: string; mFoundedField: TField; mSE,mY,mYE:boolean;
  function NoSerNTblNames:boolean;
  var mI:integer;mName:Str8;
  begin
    Result:=False;
    mI:=LineElementNum(cNoSerNTblNames,'|');
    while not Result and (mI>0) do begin
      Dec(mI);
      mName:=LineElement(cNoSerNTblNames,mI,'|');
      Result:=Pos(mName,oTableName)>0;
    end;
  end;

begin
//  RZ 20.02.2003 BtrTools.AllBeforePost(DataSet);
  mSE:=False;mYE:=False;mY:=False;mYS:='';mSS:=0;
  for i:=0 to DataSet.FieldCount-1 do begin
    mStr := DataSet.Fields[i].FieldName;
    mStr := Uppercase(mStr); //2000.5.9.
    If (mStr = 'DOCNUM') then begin
      mDocNum:=(DataSet.Fields[i] as TStringField).AsString;
    end;
    If (mStr = 'YEAR') and (DataSet.Fields[i] is TStringField)and((DataSet.Fields[i] as TStringField).AsString = '') then begin
      mYE:=True;
    end;
    If (mStr = 'SERNUM') then begin
      mSE:=True;mSS:=(DataSet.Fields[i] as TIntegerField).AsInteger;
    end;
    If (mStr = 'YEAR') and (DataSet.Fields[i] is TStringField)and ((DataSet.Fields[i] as TStringField).AsString <> '') then begin
      mY:=True;mYS:=(DataSet.Fields[i] as TStringField).AsString;
    end;
    If (mStr = 'ARCHIVE') and oArchive then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TIntegerField).AsInteger := 1;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
(* RZ 14.04.2016
    If (mStr = 'SENDED') and oSended then begin
      If (DataSet.Fields[i] as TIntegerField).AsInteger=1 then begin
        DataSet.Fields[i].ReadOnly := FALSE;
        (DataSet.Fields[i] as TIntegerField).AsInteger := 0;
        DataSet.Fields[i].ReadOnly := TRUE;
      end
    end;
*)
    If oCrtDat and (mStr='CRTUSER') and (DataSet.Fields[I].AsString='') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TStringField).AsString := gvSys.LoginName;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If oCrtDat and (mStr='CRTDATE') and (DataSet.Fields[I].AsDateTime=0) then begin
      DataSet.Fields[I].ReadOnly := FALSE;
      (DataSet.Fields[I] as TDateTimeField).AsDateTime := Now;
      DataSet.Fields[I].ReadOnly := TRUE;
    end;
    If oCrtDat and (mStr='CRTTIME') and (DataSet.Fields[I].AsDateTime=0) then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TDateTimeField).AsString := TimeToStr(now);
      DataSet.Fields[i].ReadOnly := TRUE;
    end;

    If oModify and (mStr = 'MODDATE') then begin
      DataSet.Fields[I].ReadOnly := FALSE;
      (DataSet.Fields[I] as TDateTimeField).AsDateTime := Now;
      DataSet.Fields[I].ReadOnly := TRUE;
    end;
    If oModify and (mStr = 'MODTIME') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TDateTimeField).AsString := TimeToStr(now);
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If oModify and (mStr = 'MODUSER') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TStringField).AsString := gvSys.LoginName;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If mStr[length(mStr)] = '_' then begin
      mFoundedField := DataSet.FindField(copy(mStr,1,length(mStr)-1));
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=IcConv.StrToAlias(mFoundedField.AsString);
    end;
  end;
  If mY and (mDocNum<>'')and(Copy(mDocNum,3,2)<>mYS)then begin
    If oTableName<>'VTI' then begin
      WriteToLogFile(oDatabaseName+'YEAR_BAD.LOG',oTableName+'.'+oTableNameExt+'|'+mDocNum+'|'+mYS+'|');
      FieldByName('Year').AsString:=Copy(mDocNum,3,2);
    end;
  end;
  If mYE then begin
    WriteToLogFile(oDatabaseName+'YEAR_NUL.LOG',oTableName+'.'+oTableNameExt+'|'+mDocNum+'|');
    If mDocNum<>'' then FieldByName('Year').AsString:=Copy(mDocNum,3,2);
  end;
  If mSE and (mDocNum<>'')and(ValInt(Copy(mDocNum,8,5))<>mSS) and not NoSerNTblNames then begin
    WriteToLogFile(oDatabaseName+'SERN_BAD.LOG',oTableName+'.'+oTableNameExt+'|'+mDocNum+'|'+IntToStr(mSS)+'|');
  end;
  If Assigned (eBeforePost) then eBeforePost (DataSet);
end;

procedure TBtrieveTable.CreateTable;
var mDefFile: TDefFile;  mTableName: string;  mRecSize: word;
    mPosBlock: BTR_Position_Block; mKeyNum: SmallInt;
    mOK:boolean; mTimeout,mT:TDateTime; mSR:TSearchRec;
begin
  mTableName := GetTableFileName;
  If not FileExistsI(mTableName) then begin
    AddToLogFile (mTableName,'Create Table');
    mDefFile := TDefFile.Create;
    If TableNameExt='TMP' then mDefFile.oDuplic:=True;
    mDefFile.ReadFile (GetDefFileName);
    mRecSize := mDefFile.GetRecLen;
    mRecSize := SizeOf (mDefFile.oFileSpec^);
    {^^^^^^^^^ EK 28.09.2000 pri malych subroch hlasil Error 22  }
    mKeyNum := 0;
//    oClient := gClient;
    oStatus := BtrCreate(mPosBlock, mDefFile.oFileSpec^,mRecSize,mTableName,mKeyNum);
    ShowBtrError ('CreateTable',oStatus);
    FreeAndNil (mDefFile);

// Tibi 29.1.2018 PoËk·, k˝m cez FileExist sa d· detekovaù vytvoren˝ s˙bor
// Pri Windows Server novo vytvoren˝ s˙bor sa zobrazÌ len po 10 sekund·ch
    mTimeout:=IncSecond(Now,15);
    mT:=Now;
    System.Delete(mTableName,Length(mTableName),1);
    Repeat
      mOK:=SysUtils.FileExists(mTableName);
      Application.ProcessMessages;
    until mOK or (mTimeout<Now);
  end;
end;

function  TBtrieveTable.Exists: Boolean;
begin
  Result := FileExistsI(GetTableFileName);
end;

procedure TBtrieveTable.SetFilter;
var
  mExBufRec: TExBufRec absolute pBuffer;
  mByte,mOpType,mDefOpType,mActCond,mCondNum,i,j,k,mFld,mFld2:byte;
  mPos,mLen,mOffs,mWord:word;
  mLongint: longint;
  mDouble:double;
  mC:char;
  mLString: string[255];
  mStr,mSubStr,mOperator:String;
begin
  If (oFilter<>oActFilterS)then oActFilter:=FALSE;
  If oActFilter then begin
    mExBufRec:=oFiltBuffer;
    oActFilter:=TRUE;
  end else begin
    mWord:=65535;                           // 2000.6.2 *EK*
    move(mWord, mExBufRec[4], 2);
    mStr := oFilter;
    mCondNum:=LineElementNum(mStr,'^')+LineElementNum(mStr,'@')-1;
    If not oFiltered then mCondNum:=0;
    mWord := mCondNum;
    move(mWord, mExBufRec[6], 2);

    mActCond:=0;
    mPos:=8;
    while (mActCond<mCondNum) do begin
      Inc (mActCond);
      If (Pos('@',mStr)>0) and (Pos('^',mStr)>0) then begin
        if Pos('@',mStr) < Pos('^',mStr) then mC:='@' else mC:='^';
      end else If Pos('@',mStr)>0 then mC:='@'
        else If Pos('^',mStr)>0 then mC:='^' else mC:='_';

      If mActCond<mCondNum
        then mSubStr:=LineElement(mStr,0,mC)
        else mSubStr:=mStr;
      mStr:=Copy(mStr,Pos(mC,mStr)+1,Length (mStr));
      i:=Pos('[',mSubStr);j:=Pos(']',mSubStr);
      mFld:=StrToInt (Copy(mSubStr,i+1,j-2));
      mSubStr:=Copy(mSubStr,j+1,Length (mSubStr)-j);
      If mSubStr[2] in ['>','<','='] then begin
         mOperator:= Copy (mSubStr,1,2);
         If mOperator[2]='>' then mOpType:=4
           else If mOperator[1]='>' then mOpType:=5 else mOpType:=6;
         mSubStr  := Copy (mSubStr,3,Length (mSubStr)-2);
      end else begin
        mOperator:= Copy (mSubStr,1,1);
        If mOperator[1]='>' then mOpType:=2
           else If mOperator[1]='<' then mOpType:=3 else mOpType:=1;
        mSubStr  := Copy (mSubStr,2,Length (mSubStr)-1);
      end;
      mByte:=Integer(oFieldICCType[mFld]);
      Move (mByte,mExBufRec[mPos],1);
      Inc (mPos);
      mWord:=Integer(oFieldWidth[mFld]);
      If mByte=10 then Inc(mWord);
      Move (mWord,mExBufRec[mPos],2);
      Inc (mPos,2);
      mWord:=Integer(oFieldOffset[mFld]);
      Move (mWord,mExBufRec[mPos],2);
      Inc (mPos,2);
      If (Pos ('[',mSubStr)>0) then Inc (mOpType,64);
      Move (mOpType,mExBufRec[mPos],1);
      Inc (mPos);
      If mC='@' then mByte:=2 else If mC='^' then mByte:=1 else mByte:=0;
      Move (mByte,mExBufRec[mPos],1);
      Inc (mPos);

      If (Pos ('[',mSubStr)>0) then begin
        Inc (mOpType,64);
        i:=Pos('[',mSubStr);j:=Pos(']',mSubStr);
        mFld2:=StrToInt (Copy(mSubStr,i+1,j-2));
        mWord:=Integer(oFieldOffset[mFld2]);
        Move (mWord,mExBufRec[mPos],2);
        Inc (mPos,2);
      end else begin
        mDEFOpType      :=Integer(oFieldDEFType[mFld]);
        mOpType         :=Integer(oFieldICCType[mFld]);
        mLen            :=Integer(oFieldWidth  [mFld]);
        mSubStr         :=Copy (mSubStr,2,Length(mSubStr)-2);
        If (mDefOpType = 3) then mSubStr:=IntToStr(Date_To_FPDate( StrToDate(mSubsTr)))
        else  If (mDefOpType = 4) then mSubStr:=IntToStr(TIME_To_FPTIME( StrToTIME(mSubsTr)));
        // sem by mohol ista asi radsej case mDEFOpType
        case mOpType of
          UNSIGNED_BINARY_TYPE: begin
                                  if mLen = 2 then begin
                                    mWord:=StrToInt(mSubStr);
                                    Move(mWord,mExBufRec[mPos], mLen);
                                  end else if mLen=4 then begin
                                    mLongint := StrToInt(mSubStr);
                                    Move(mLongint, mExBufRec[mPos], mLen);
                                  end;
                                end;
          IEEE_TYPE:            begin
                                  mDouble:=StrtoFloat(mSubStr);
                                  Move(mDouble,mExBufRec[mPos], mLen);
                                end;
          STRING_TYPE:          begin
                                  mbyte:=Strtoint(mSubStr);
                                  Move(mbyte,mExBufRec[mPos], mLen);
                                end;
          LSTRING_TYPE:         begin
                                  mLString := mSubStr;
                                  Move(mLString[0], mExBufRec[mPos], mLen+1);
                                  Inc(mPos);
                                end;
        end;
        Inc(mPos,mLen);
      end;
    end; {While for Conditions}
    mWord:=pRecCount;
    move (mWord,mExBufRec[mPos], 2);Inc (mPos,2);{record number}
    If pFields<>'' then begin
      mWord:=length(pFields);
      move (mWord,mExBufRec[mPos], 2);Inc (mPos,2);{field number}
      for k:=1  to length(pFields) do begin
        mWord:=Integer(oFieldWidth[ord(pFields[k])]);
        mOffs:=Integer(oFieldOffset[ord(pFields[k])]);
        move (mWord,mExBufRec[mPos], 2);Inc (mPos,2);{fld len}
        move (mOffs,mExBufRec[mPos], 2);Inc (mPos,2);{fld offs}
      end;
      move (mPos,mExBufRec[0], 2);
    end else begin
      mWord:=1;
      move (mWord,mExBufRec[mPos], 2);Inc (mPos,2);{field number}
      mWord:= oRecordLen;
      mOffs:=0;
      move (mWord,mExBufRec[mPos], 2);Inc (mPos,2);{fld len}
      move (mOffs,mExBufRec[mPos], 2);Inc (mPos,2);{fld offs}
      move (mPos,mExBufRec[0], 2);
    end;
    oFiltBuffer:=mExBufRec;
    oActFilters:=oFilter;
    oActFilter:=TRUE;
  end;
  if pEG_UC
    then move ('EG', mExBufRec[2], 2)
    else move ('UC', mExBufRec[2], 2);
end;

function  TBtrieveTable.IndexSegmentPosToFieldNo(pPos: integer): integer;
var I: integer;
begin
  Result := -1; //Mindjart a legrosszabra gondolok.
  If (FieldDefs.Count > 0) then begin
    i := 0;
    repeat
      If (Integer(oFieldOffset[i]) = pPos) then Result := i;
      inc(i);
    until (i >= FieldDefs.Count) or (Result >= 0);
  end else Result := -1; //Hat igy nem nagyon lehet ha nincsenek fieldek.
end;

function  TBtrieveTable.GetIndexFieldNames: string;
begin
//  If FFieldsIndex then Result := FIndexName else Result := '';
end;

procedure TBtrieveTable.SetIndexFieldNames(const Value: string);
var I, mIndexNum: integer;
begin
  mIndexNum := -1;
  If (IndexDefs.Count > 0) then for i:= 0 to IndexDefs.Count-1 do begin
    If (IndexDefs[i].Fields = Value) then mIndexNum := i;
  end;
  If (mIndexNum>=0) then begin
    IndexNumber := mIndexNum;
  end;
end;

procedure TBtrieveTable.SetIndexName(const Value: string);
var I, mIndexNum: integer;
begin
  mIndexNum := -1;
  If (IndexDefs.Count > 0) then begin
    for i:= 0 to IndexDefs.Count-1 do begin
      If (IndexDefs[i].Name = Value) then mIndexNum := i;
    end;
  end;
  If (mIndexNum>=0) then begin
    IndexNumber := mIndexNum;
  end else begin
    If gShowBadIndexName and oShowErrMsg then ShowMsg (ecBtrIndexNameIsBad,oTableName+'.'+oTableNameExt+' - '+Value);
    WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|IndexNameError|'+Value);
  end;
end;

procedure TBtrieveTable.AddToLogFile (pFileName,pProces:string); // 2003.07.30 Prida zaznam do LOG suboru
var mBtrLog:TStrings; mFileName:string;
begin
  mFileName := gvSys.SysPath+'BTRLOG.TXT';
  mBtrLog := TStringList.Create;
  If FileExistsI (mFileName) then mBtrLog.LoadFromFile(mFileName);
  mBtrLog.Add (DateToStr(Date)+' '+TimeToStr(Time)+' '+pFileName+' - '+pProces);
  mBtrLog.SaveToFile(mFileName);
  FreeAndNil (mBtrLog);
end;

procedure TBtrieveTable.ClearErrInfo;
begin
  oErrInfo.Error := FALSE;
  oErrInfo.TblRecordLen := 0;
  oErrInfo.DefRecordLen := 0;
  oErrInfo.TblIndexCount := 0;
  oErrInfo.DefIndexCount := 0;
  oErrInfo.BadIndexQnt := 0;
end;

procedure TBtrieveTable.SetIndexDefs(Value: TIndexDefs);
begin
  IndexDefs.Assign(Value);
end;

function TBtrieveTable.IndexDefsStored: Boolean;
begin
  Result := StoreDefs and (IndexDefs.Count > 0);
end;

procedure TBtrieveTable.UpdateIndexDefs; //1999.12.20.
var I, J: integer;   mFields: string;   mFieldNo: integer; mErr,mOK:boolean; mIndexName:string;
begin
  mErr := FALSE;
  oIndexDefs.Clear;
  If (oNumOfIndexes > 0) then for i := 0 to oNumOfIndexes-1 do begin
    If (oMyIndexDefs[i].IndexSegmentsNum > 0) then begin
      mFields := '';
      for j := 0 to oMyIndexDefs[i].IndexSegmentsNum-1 do begin
        mFieldNo := IndexsegmentPosToFieldNo(oMyIndexDefs[i].IndexSegment[j].pos-1);// minusz egy mivel a btrievben a nnulladik pozicio az egyes
        If (mFieldNo >= 0) and (mFieldNo < FieldDefs.Count) then begin
          If (mFields <> '') then mFields := mFields + ';';
          mFields := mFields + FieldDefs[mFieldNo].Name;
        end;
      end;
//      oIndexDefs.Add(IntToStr(i), mFields, [ixCaseInsensitive]);
      mOK := UpString (ReplaceStr (mFields,'_',''))=UpString (ReplaceStr (uDDFIndexFields[I+1].IndexFields,'_',''));
      If not mErr then mErr := not mOK;
      If not mOK then oErrInfo.BadIndexQnt := oErrInfo.BadIndexQnt+1;
      mIndexName := LineElement(oIndexNames,i,';');
      If mIndexName='' then mIndexName := 'I'+StrInt (I,0);
      oIndexDefs.Add(mIndexName, mFields, [ixCaseInsensitive]);
    end;
  end;
  If not mErr then mErr := oNumOfIndexes<>uDDFIndexQnt;
  oErrInfo.TblIndexCount := oNumOfIndexes;
  oErrInfo.DefIndexCount := uDDFIndexQnt;
  If mErr then begin
    oErrInfo.Error := TRUE;
    If oShowErrMsg then ShowMsg (999998,oTableName+'.'+oTableNameExt);
    If gBtrErrorLogfile or (oBtrErrorLogfile=1) then WriteToLogFile(oDatabaseName+oTableName+'.LOG',oTableName+'.'+oTableNameExt+'|IndexDefsError|'+IntToStr(999998));
    If gBtrErrorLogfile or (oBtrErrorLogfile=2) then WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|IndexDefsError|'+IntToStr(999998));
  end;
end;

function  TBtrieveTable.GetPosition: TBtrPosition;
var mPosition: TBtrPosition;
begin
  oStatus := BtrGetPosition(oPosBlock, oClient, mPosition);
  ShowBtrError ('GetPosition',oStatus);
  Result := mPosition;
end;

procedure TBtrieveTable.SetKeyFields(const pValues: array of const);
var I, mPos: integer;   mStr255  : string[255];   mLen,mWord: word;
    mInteger: integer;  mValueStr: string;
    mFieldNo, mFieldICCType, mDefOpType: integer;
    mDouble:double;
begin
  mPos := 1;
  fillchar(oKeyBuf,255,0);
  for i := 0 to High(pValues) do begin
    // minden bejovo indexvaluet eloszor leforditok string formatumra
    with pValues[i] do begin
      case VType of
        vtInteger:    mValueStr := IntToStr(VInteger);
//        vtBoolean:    mValueStr := BoolChars[VBoolean];
        vtChar:       mValueStr := VChar;
        vtExtended:   mValueStr := FloatToStr(VExtended^);
        vtString:     mValueStr := VString^;
        vtPChar:      mValueStr := VPChar;
        vtObject:     mValueStr := VObject.ClassName;
        vtClass:      mValueStr := VClass.ClassName;
        vtAnsiString: mValueStr := string(VAnsiString);
        vtCurrency:   mValueStr := CurrToStr(VCurrency^);
        vtVariant:    mValueStr := string(VVariant^);
        vtInt64:      mValueStr := IntToStr(VInt64^);
      end;
    end;
    //kesobb pedig a strinng formatumu valuet betoltom a kereso bufferbe
    mFieldNo := IndexsegmentPosToFieldNo(oMyIndexDefs[oKeyNum].IndexSegment[i].Pos-1); //minus egy mivel a btrievben az elso az egyes
    If (mFieldNo >= 0) then begin
      mFieldICCType := Integer(oFieldICCType[mFieldNo]); //??? vagy mFieldNo-1
      mDEFOpType    := Integer(oFieldDEFType[mFieldNo]);
      mLen          := Integer(oFieldWidth  [mFieldNo]);
      case mFieldICCType of
        LSTRING_TYPE:
          begin
            mStr255 := mValueStr;
            move(mStr255, oKeyBuf[mPos], length(mStr255)+1);
          end;
        UNSIGNED_BINARY_TYPE:
          begin
            If mValueStr <> '' then begin
              If Pos (DateSeparator,mvalueStr) > 0 then begin
                mWord:=date_To_FPDate(StrToDate (mValueStr));
              end else begin
                If mLen = 2 then begin
                  mWord := StrToInt(mValueStr);
                  If mDEFOpType = 3 then Dec(mWord); // TDate je vlastene FPDate +1
                end else begin
                  mInteger := StrToInt(mValueStr);
                end;
              end;
            end else begin mWord := 0;mInteger := 0;end;
            If mLen=2
              then move(mWord,   oKeyBuf[mPos], 2)
              else move(mInteger,oKeyBuf[mPos], 4);
          end;
        IEEE_TYPE: begin
            mValueStr := ReplaceStr (mValueStr,'.',',');
            mDouble := StrToFloat(mValueStr);
            move(mDouble, oKeyBuf[mPos], 8);
          end;

        else
          begin
            mInteger := StrToInt(mValueStr);
            move(mInteger, oKeyBuf[mPos], 4);
          end;
      end;
    end;
    mPos := mPos + oMyIndexDefs[oKeyNum].IndexSegment[i].Len;
  end;
end;

function  TBtrieveTable.InternalInitIndexDefs: boolean;
begin
  UpdateIndexDefs;
end;

procedure TBtrieveTable.InternalFind;
var mPosition: TBtrPosition;
begin
  mPosition := GetPosition;
  with PRecInfo(ActiveBuffer + oRecordLen)^ do begin
    BookmarkFlag := bfCurrent;
    Bookmark := BETVEEN;
    BookmarkPosition := mPosition;
  end;
end;

function  TBtrieveTable.InternalFindKey: boolean;
var mPos:longint;
begin
  Result := TRUE;
  oStatus := BtrGetEqual(oPosBlock, ActiveBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient);
  ShowBtrError ('GetEqual',oStatus);
  If (oStatus=0) then begin
    InternalFind;
    Result := TRUE;
  end else begin
    Result := FALSE;
  end;
end;

function  TBtrieveTable.InternalFindNearest: boolean;
begin
  oStatus := BtrGetGE(oPosBlock, ActiveBuffer^, oRecordlen, oKeyBuf[1], oKeyNum, oClient);
  ShowBtrError ('GetGrearEqual',oStatus);
  If (oStatus = 0) or (oStatus = 4) then begin
    InternalFind;
    Result := TRUE;
  end else begin
    Result := FALSE;
  end;
end;

function  TBtrieveTable.FindKey(const pKeyValues: array of const): boolean;
var mPos:longint;
begin
  Result := False;
  If High(pKeyValues) <> oMyIndexDefs[oKeyNum].IndexSegmentsNum-1 then exit;
  SetKeyFields(pKeyValues);// oKeyBuf:=  aaaaaaaaaaaaaa';//'1000'+#0;
  Result := InternalFindKey;
  mPos:=Actpos;
  Refresh;
  If result then Result := mPos=ActPos;
end;

function  TBtrieveTable.FindNearest(const pKeyValues: array of const): boolean;
var mPos:longint;
begin
  Result := TRUE;
  SetKeyFields(pKeyValues);
  Result := InternalFindNearest;
  mPos:=Actpos;
  Refresh;
  If result then Result := mPos=ActPos;
end;

procedure TBtrieveTable.SetKeyNum(pKeyNum:smallint);
begin
  If oNumOfIndexes = 0 then Exit;   // Doplnit chybove hlasenie
  If pKeyNum in [0..oNumOfIndexes-1] then begin
    oIndexFieldNames := IndexDefs[pKeyNum].Fields;
    oIndexName := IndexDefs[pKeyNum].Name;
    oKeyNum := pKeyNum;
    Refresh;
  end;
end;

procedure TBtrieveTable.ClrKeyNum;
begin
  oKeyNum := 0;
end;

function TBtrieveTable.GotoDirect(pPosition: TBtrPosition): boolean;
var mBuffer: pointer;
begin
  mBuffer := nil;
  oStatus := BtrGetDirect(pPosition, oPosBlock, mBuffer, oRecordLen, oKeyNum, oClient);
  Result := oStatus=0;
  ShowBtrError ('GetDirect',oStatus);
end;

procedure TBtrieveTable.Statistic;
var
  mBuffer: STAT_REC;
  mDataLen: word;
  mI: integer;
  mIndexCnt: integer;
  mSegCnt: integer;
  mActCnt: integer;
begin
  mDataLen := sizeof(mBuffer);
  oStatus := BtrStat(oPosBlock, mBuffer, mDataLen, oKeyBuf[1], oKeyNum);
  ShowBtrError ('Statistic',oStatus);
  If oStatus = B_NO_ERROR then begin
    If oRecFilterStr=''
      then oFiltRecCnt  := mBuffer.FileSpecs.RecordCount;
    oRecCnt      := mBuffer.FileSpecs.RecordCount;
    oRecordLen   := mBuffer.FileSpecs.RecordLength;
    oSegCnt      := mBuffer.FileSpecs.SegmentCount;
    oNumOfIndexes:= 0;
    oACSNumber := 0;
    //******************************************************
    mIndexCnt := oSegCnt;
    mSegCnt := 0;
    for mI := 0 to mIndexCnt-1 do begin  // Az oSegCnt valojaban az IndexCnt
      mActCnt := 0;
      repeat
        oMyIndexDefs[mI].IndexSegment[mActCnt].Pos := integer(mBuffer.KeySpecs[mSegCnt].position);
        oMyIndexDefs[mI].IndexSegment[mActCnt].Len := integer(mBuffer.KeySpecs[mSegCnt].length);
        Inc(mActCnt);
        Inc(mSegCnt);
      until ((mBuffer.KeySpecs[mSegCnt-1].flags AND 16) = 0);
      oMyIndexDefs[mI].IndexSegmentsNum := mActCnt
    end;
    oSegCnt := mSegCnt;
    oNumOfIndexes := mIndexCnt;
  end;
end;

procedure TBtrieveTable.Statistic2;
var
  mBuffer: STAT_REC;
  mDataLen: word;
  mI: integer;
  mIndexCnt: integer;
  mSegCnt: integer;
  mActCnt: integer;
begin
  If gStatistic2 or (oRecCnt < 1)then begin
    mDataLen := sizeof(mBuffer);
    oStatus := BtrStat(oPosBlock, mBuffer, mDataLen, oKeyBuf[1], oKeyNum);
    ShowBtrError ('Statistic',oStatus);
    If oStatus = B_NO_ERROR then begin
      If oRecFilterStr=''
        then oFiltRecCnt  := mBuffer.FileSpecs.RecordCount;
      oRecCnt      := mBuffer.FileSpecs.RecordCount;
      oRecordLen   := mBuffer.FileSpecs.RecordLength;
      oSegCnt      := mBuffer.FileSpecs.SegmentCount;
    end;
  end;
end;

procedure TBtrieveTable.Unlock;
var
  mBuffer: STAT_REC;
  mDataLen: word;
  mI: integer;
  mIndexCnt: integer;
  mSegCnt: integer;
  mActCnt: integer;
begin
    mDataLen := sizeof(mBuffer);
    oStatus := BtrStat(oPosBlock, mBuffer, mDataLen, oKeyBuf[1], oKeyNum);
    ShowBtrError ('Statistic',oStatus);
end;

function TBtrieveTable.GetTableFileName: string;
var mS:string;
begin
  If oTableName='' then oTableName := oFixedName;
  If oTableNameExt<>''
    then mS := oDataBaseName +'\'+oTableName+'.'+oTableNameExt+#0
    else mS := oDataBaseName +'\'+oTableName+'.'+cExtension+#0;
  While (POS('\\',mS)>0) do System.Delete (mS,POS('\\',mS),1);
  Result:=mS;
end;

procedure TBtrieveTable.InternalOpen;
var mFileName: string;  mExt:Str3;
begin
//  oClient:=gClient;
  ClearErrInfo;
  oCurRec := BEFORE_FIRST; //-1;
  oDataLen := 0;
  oSwapNum := 0;
{
  oKeyNum := 0;
  oIndexFieldNames := '';
  oIndexName := '';
}
  mFileName := GetTableFileName;
  If TableNameExt=''
    then mExt := 'BTR'
    else mExt := TableNameExt;
  If FileExistsI (DatabaseName+TableName+'.'+mExt) then begin
    oStatus := BtrOpen(mFileName, oPosBlock, oOpenMode);
    ShowBtrError ('Open',oStatus);
    If oStatus = B_NO_ERROR then begin
      oIsTableOpen := TRUE;
      Statistic;
      InternalInitFieldDefs;
      InternalInitIndexDefs;
      oRecBufSize := oRecordLen + SizeOf(TRecInfo);
    end;
    { Create TField components when no persistent fields have been created }
    If DefaultFields then CreateFields;
    { Bind the TField components to the physical fields }
    BindFields(True);
  end
  else begin
    If oAutoCreate then begin
      If not FileExistsI (DatabaseName+TableName+'.'+mExt{'.BTR'}) then begin
        CreateTable;
      end;
      Open;
    end else begin
      ShowMsg(ecBtrDatabaseIsNotExist,oDatabaseName+oTableName+'.'+oTableNameExt);
      If gBtrErrorLogfile or (oBtrErrorLogfile=1) then WriteToLogFile(oDatabaseName+oTableName+'.LOG',oTableName+'.'+oTableNameExt+'|NotCreatedOnOpen|'+IntToStr(999997));
      If gBtrErrorLogfile or (oBtrErrorLogfile=2) then WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|NotCreatedOnOpen|'+IntToStr(999997));
    end;
  end;
  oActFilter:= FALSE;
  oActFilters:= '';
  oRecFilterStr:='';
  oFiltRecCnt:=0;
  oFiltered  := FALSE;
  oFilter    := '';
  oKeyNum := 0;
  oIndexFieldNames := IndexDefs[oKeyNum].Fields;
  oIndexName := IndexDefs[oKeyNum].Name;
end;

procedure TBtrieveTable.InternalClose;
begin
  oStatus := BtrClose(oPosBlock);
  ShowBtrError ('Close',oStatus);
  If (oStatus = B_NO_ERROR) then oIsTableOpen := FALSE;
  { Destroy the TField components If no persistent fields }
  If DefaultFields then DestroyFields;

  BindFields(True);

// *TIBI*
  FreeAndNil(oFieldOffset);
  FreeAndNil(oFieldWidth);
  FreeAndNil(oFieldICCType);
  FreeAndNil(oFieldDEFType);
  FreeAndNil(oFieldFullname);
(*
  If Assigned(oFieldOffset) then oFieldOffset.Free;
  oFieldOffset := nil;
  If Assigned(oFieldWidth) then oFieldWidth.Free;
  oFieldWidth := nil;
  If Assigned(oFieldICCType) then oFieldICCType.Free;
  oFieldICCType := nil;
  If Assigned(oFieldDEFType) then oFieldDEFType.Free;
  oFieldDEFType := nil;
  If Assigned(oFieldFullname) then oFieldFullName.Free;
  oFieldFullName:= nil;
*)
  If oSwapNum>0 then WriteToLogFile(oDatabaseName+'SWAP_BAD.LOG',oTableName+'.'+oTableNameExt+'|'+IntToStr(oSwapNum)+'|');
end;

function TBtrieveTable.IsCursorOpen: Boolean;
begin
  Result := oIsTableOpen;
end;

function  TBtrieveTable.GetDefFileName: string;
var mS: string;
begin
  If DefName='' then begin
    mS := TableName_To_DefFileName(oTableName);
    If (oDefBaseName = '')
      then mS := oDataBaseName + '\'+ mS
      else mS := oDefBaseName  + '\'+ mS;
    While (POS('\\',mS)>0) do System.Delete (mS,POS('\\',mS),1);
    Result:=mS;
  end
  else Result := oDefBaseName+DefName;
end;

procedure TBtrieveTable.InternalInitFieldDefs;
var
  mName: string;
  mFieldType: TFieldType;
  mDataType : byte;
  mSize     : word;
  mOffset   : word;
  i         : integer;
  mBuffer   : TList;
  mBufferI  : TList;
  mDEFList  : TStringList;
  mFullList : TStringList;
  mICCDataType: byte;
  mICCSelector: word;
  mDefFileName: string;
  mRecordLen:longint;
begin
  mRecordLen := 0;
  FieldDefs.Clear;

  If not (assigned(oFieldOffset)) then oFieldOffset := TList.Create;
  oFieldOffset.Clear;
  If not (assigned(oFieldWidth))  then oFieldWidth  := TList.Create;
  oFieldWidth.Clear;
  If not (assigned(oFieldICCType))  then oFieldICCType  := TList.Create;
  oFieldICCType.Clear;
  If not (assigned(oFieldDEFType))  then oFieldDEFType  := TList.Create;
  oFieldDEFType.Clear;
  If not (assigned(oFieldFullName))  then oFieldFullName  := TStringlist.Create;
  oFieldFullName.Clear;

  mBuffer  := TList.Create;
  mBufferI := TList.Create;
  mDEFList := TStringList.Create;
  mFullList:= TStringList.Create;
  try
    mDefFileName := GetDEFFileName;
    If FileExistsI(mDefFileName)
      then mDefList.LoadFromFile(mDefFileName)
      else begin
        ShowMsg(ecBtrDefFileIsNotExist,mDefFileName);
        If gBtrErrorLogfile or (oBtrErrorLogfile=1) then WriteToLogFile(oDatabaseName+oTableName+'.LOG',oTableName+'.'+oTableNameExt+'|DefNotExist|'+IntToStr(999996));
        If gBtrErrorLogfile or (oBtrErrorLogfile=2) then WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|DefNotExist|'+IntToStr(999996));
      end;
    If (mDEFList.Count > 0) and (mDEFList[0]='')
      then mDEFList.Delete(0);
    If (mDEFList.Count > 0) then mDEFList.Delete(0); //Kitorli az elso sort
    If (mDEFList.Count > 0) then mDEFList.Delete(0); //Kitorli a masodik sort

    DEF_To_FieldList  (mDEFList, mBuffer, $FFFF, 0,mFullList); //itt az FFFF nek es a nullanak fontos a szerepe az allitja be hogy figyelje az adatok ICCs tulajdonsagait
    DEF_To_IndexNames (mDEFList, oIndexNames);
  except end;
// *TIBI*
//  mDEFList.Free;
  FreeAndNil(mDEFList);

  If mBuffer.Count > 0 then begin
    for i:= 0 to mBuffer.Count-1 do begin
      mICCDataType := PField_DDF_Rec(mBuffer.Items[i])^.Xe_Id;
      mICCSelector := PField_DDF_Rec(mBuffer.Items[i])^.Xe_File;

      mName     := PField_DDF_Rec(mBuffer.Items[i])^.Xe_Name;
      mName     := LineElement(mName, 0, ' ');
      mDataType := PField_DDF_Rec(mBuffer.Items[i])^.Xe_DataType;
      mSize     := PField_DDF_Rec(mBuffer.Items[i])^.Xe_Size;
      mOffset   := PField_DDF_Rec(mBuffer.Items[i])^.Xe_Offset;
      mRecordLen := mRecordLen+mSize;
      If (mSize <> 0) then begin //ez egy FieldName
        If mDataType=10 then Dec(mSize);
        If (mICCSelector = $FFFF) then begin
          //Ez akkor van ha ICC adatbazis
          mFieldType := BtrDataTypeToFieldType(mICCDataType, mSIZE);
          If mFieldType = ftUnknown then mFieldType := ftString; ///
          If mFieldType in [ftString, ftBCD, ftBytes, ftVarBytes, ftBlob, ftMemo ,ftGraphic] then begin
            FieldDefs.Add(mName, mFieldType, mSize, FALSE);
          end else begin
            FieldDefs.Add(mName, mFieldType, 0, FALSE);
          end;
//          FieldDefs[i].DisplayName := mFullList.Strings[I];
          oFieldOffset.Add(Pointer(mOffset));
          oFieldWidth.Add(Pointer(mSize));
          oFieldICCType.Add(Pointer(mDataType));
          oFieldDEFType.Add(Pointer(mICCDataType));
          oFieldFullName.Add(mFullList.Strings[I]);
        end else begin
          //Ez akkor van ha normaladatbazis nem pedig ICC
          mFieldType := BtrDataTypeToFieldType(mDataType, mSIZE);
          If mFieldType = ftUnknown then mFieldType := ftString; ///
          If mFieldType in [ftString, ftBCD, ftBytes, ftVarBytes, ftBlob, ftMemo ,ftGraphic] then begin
            FieldDefs.Add(mName, mFieldType, mSize, FALSE);
          end else begin
            FieldDefs.Add(mName, mFieldType, 0, FALSE);
          end;
          oFieldOffset.Add(Pointer(mOffset));
          oFieldWidth.Add(Pointer(mSize));
          oFieldICCType.Add(Pointer(mDataType));
          oFieldDEFType.Add(Pointer(mDataType));
          oFieldFullName.Add(mFullList.Strings[I]);
        end;
      end else begin // ez egy IndexName
        //ez most egy index neve
        beep(440,200);
      end;
    end;
  end;
// *TIBI*
  FreeAndNil(mFullList);
  FreeAndNil(mBuffer);
  FreeAndNil(mBufferI);

//  mFullList.Free;
//  mBuffer.Free;
//  mBufferI.Free;
  oErrInfo.TblRecordLen := oRecordLen;
  oErrInfo.DefRecordLen := mRecordLen;
  If mRecordLen<>oRecordLen then begin
    oErrInfo.Error := TRUE;
    If oShowErrMsg then ShowMsg (999999,oDatabaseName+oTableName+'.'+oTableNameExt+'|'+StrInt (oRecordLen,0)+'|'+StrInt (mRecordLen,0));
    If gBtrErrorLogfile or (oBtrErrorLogfile=1) then WriteToLogFile(oDatabaseName+oTableName+'.LOG',oTableName+'.'+oTableNameExt+'|RecordLengthError'+IntToStr(999999));
    If gBtrErrorLogfile or (oBtrErrorLogfile=2) then WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|RecordLengthError|'+IntToStr(999999));
  end;
end;

procedure TBtrieveTable.InternalHandleException;
begin
  Application.HandleException(Self);
end;

{ Bookmarks }
{ ========= }

{ In this sample the bookmarks are stored in the Object property of the
  TStringList holding the data.  Positioning to a bookmark just requires
  finding the offset of the bookmark in the TStrings.Objects and using that
  value as the new current record pointer. }

procedure TBtrieveTable.InternalGotoBookmark(Bookmark: Pointer);
var mIndex: Integer;  mPosition: TBtrPosition;  mBuffer: PChar;
begin
  mIndex := PInteger(Bookmark)^;
  mPosition := PRecInfo(Bookmark)^.BookmarkPosition;
//  If (mIndex >= 0) and (mIndex < oRecCnt) then begin
  If mIndex = BETVEEN then begin
    GotoDirect(mPosition);
//    If oStatus = B_NO_ERROR
//      then oCurRec := mIndex;
      //else DatabaseError('Bookmark not found');
  end else DatabaseError('Bookmark not found');
end;

{ This function does the same thing as InternalGotoBookmark, but it takes
  a record buffer as a parameter instead }

procedure TBtrieveTable.InternalSetToRecord(Buffer: PChar);
begin
  InternalGotoBookmark(@PRecInfo(Buffer + oRecordLen).Bookmark);
end;

{ Bookmark flags are used to indicate If a particular record is the first
  or last record in the dataset.  This is necessary for "crack" handling.
  If the bookmark flag is bfBOF or bfEOF then the bookmark is not actually
  used; InternalFirst, or InternalLast are called instead by TDataSet. }

function TBtrieveTable.GetBookmarkFlag(Buffer: PChar): TBookmarkFlag;
begin
  Result := PRecInfo(Buffer + oRecordLen).BookmarkFlag;
end;

procedure TBtrieveTable.SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag);
begin
  PRecInfo(Buffer + oRecordLen).BookmarkFlag := Value;
end;

{ These methods provide a way to read and write bookmark data into the
  record buffer without actually repositioning the current record }

procedure TBtrieveTable.GetBookmarkData(Buffer: PChar; Data: Pointer);
begin
  If Assigned(Data) then PInteger(Data)^ := PRecInfo(Buffer + oRecordLen).Bookmark;
end;

procedure TBtrieveTable.SetBookmarkData(Buffer: PChar; Data: Pointer);
begin
  If Assigned(Data) then PRecInfo(Buffer + oRecordLen).Bookmark := PInteger(Data)^;
end;

{ Record / Field Access }
{ ===================== }

{ This method returns the size of just the data in the record buffer.
  Do not confuse this with RecBufSize which also includes any additonal
  structures stored in the record buffer (such as TRecInfo). }

function TBtrieveTable.GetRecordSize: Word;
begin
  Result := oRecordlen;
end;

{ TDataSet calls this method to allocate the record buffer.  Here we use
  FRecBufSize which is equal to the size of the data plus the size of the
  TRecInfo structure. }

function  TBtrieveTable.GetRecNo: Integer;
var mBuffer:array[1..2] of word; mDataLen:word; mRecCount:longint;
begin
  Result := 0;
  If Active then begin
    mRecCount := RecordCount;
    If mRecCount>0 then begin
      mDataLen := sizeof(mBuffer);
      oStatus := BtrGetPercent(oPosBlock, mBuffer, mDataLen, oKeyBuf[1], oKeyNum, oClient);
      Result := Round (mBuffer[1]*mRecCount/10000);
      If Eof then Result := mRecCount;
      If Bof then Result := 1;
    end;
  end;
end;

procedure TBtrieveTable.SetRecNo(Value: Integer);
begin
end;

function TBtrieveTable.AllocRecordBuffer: PChar;
begin
  GetMem(Result, oRecBufSize);
  FillChar(Result^, oRecBufSize, #0);
end;

procedure TBtrieveTable.InternalInitRecord(Buffer: PChar);
begin
  FillChar(Buffer^, oRecBufSize, 0);
end;

procedure TBtrieveTable.FreeRecordBuffer(var Buffer: PChar);
begin
  FreeMem (Buffer, oRecBufSize);
end;

{ This multi-purpose function does 3 jobs.  It retrieves data for either
  the current, the prior, or the next record.  It must return the status
  (TGetResult), and raise an exception If DoCheck is True. }

function TBtrieveTable.GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
var
  mPosition: TBtrPosition;
  i: integer;
  mExtBuffer:PChar;
  mWord,mRecInfoOfs: word;
begin
  GetMem (mExtBuffer,65535);
//  If (oRecCnt < 1) {or (oFiltered and(oFiltRecCnt<1))} then begin
  If oFiltered and(oFiltRecCnt<1) then begin
    if GetMode=gmCurrent then  begin
      oRecFilterStr:='';
      GetRecordCountNoSwap;
    end;
  end;
  If (oRecCnt < 1) or (oFiltered and(oFiltRecCnt<1)) then begin
    Statistic2;
    Result := grEOF
  end else begin
    Result := grOK;
    case GetMode of
      gmNext:
        begin
          //ez itt egy btreaves beolvasas (B_GET_NEXT) ha van index ha nincs akkaor a B_STEP_NEXT
          if oCurRec <= BEFORE_FIRST then begin
            oStatus := BtrGetFirst(oPosBlock, Buffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
            ShowBtrError ('GetFirst',oStatus); // doplnene EK 22.09.2000
            if oFiltered then begin
              repeat
                SetFilter(mExtBuffer^,FALSE,1,'');
                mRecInfoOfs := 10*oRecordLen+8;
                oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
                If oStatus in [9,22,60,64,65] then begin
                  Move (mExtBuffer[0],mWord,2);
                  If mWord>0 then begin
                    move(mExtBuffer[8], Buffer^, oRecordLen);
                    oStatus := B_NO_ERROR;
                  end else begin
                    If oStatus <>60 then oStatus:=B_END_OF_FILE;
                  end
                end else
                if (oStatus = B_NO_ERROR) then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                  Move (mExtBuffer[0],mWord,2);
                end;
                ShowBtrError ('GetNextExtF',oStatus); // doplnene EK 22.09.2000
              until (oStatus <>60) or (mWord>0);
              Move (mExtBuffer[0],mWord,2); If mWord=0 then oFiltRecCnt:=0;
              if  (oFiltRecCnt=0) then begin
                Move (mExtBuffer[0],mWord,2);
                oFiltRecCnt:=mWord;
                If mWord>0 then oRecFilterStr:='';
              end;
            end;
          end else begin
            if oFiltered then begin
              repeat
                SetFilter(mExtBuffer^,TRUE,1,'');
                mRecInfoOfs := 10*oRecordLen+8;
                oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
                If oStatus in [9,22,60,64,65] then begin
                  Move (mExtBuffer[0],mWord,2);
                  If mWord>0 then begin
                    move(mExtBuffer[8], Buffer^, oRecordLen);
                    oStatus := B_NO_ERROR;
                  end else begin
                    If oStatus <>60 then oStatus:=B_END_OF_FILE;
                  end;
                end else
                if (oStatus = B_NO_ERROR) then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                  Move (mExtBuffer[0],mWord,2);
                end;
                ShowBtrError ('GetNextExtN',oStatus); // doplnene EK 22.09.2000
              until (oStatus <>60) or (mWord>0);
              if  (oFiltRecCnt=0) then begin
                Move (mExtBuffer[0],mWord,2);
                oFiltRecCnt:=mWord;
                If mWord>0 then oRecFilterStr:='';
              end;
            end else begin
              oStatus := BtrGetNext(oPosBlock, Buffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
              If (oStatus = 82) then oRecCnt:=0;
              ShowBtrError ('GetNext',oStatus); // doplnene EK 22.09.2000
            end;
          end;
          case oStatus of
            B_NO_ERROR    : oCurRec := BETVEEN;
            64 : Result := grEOF;
            B_END_OF_FILE : Result := grEOF;
            else Result := grError;
          end;
        end;
      gmPrior:
        begin
          if  oCurRec >= AFTER_LAST then begin
            oStatus := BtrGetLast(oPosBlock, Buffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
            ShowBtrError ('GetLast',oStatus); // doplnene EK 22.09.2000
            if oFiltered then begin
              repeat
                SetFilter(mExtBuffer^,FALSE,1,'');
                mRecInfoOfs := 10*oRecordLen+8;
                oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
                If oStatus in [9,22,60,64,65] then begin
                  Move (mExtBuffer[0],mWord,2);
                  If mWord>0 then begin
                    move(mExtBuffer[8], Buffer^, oRecordLen);
                    oStatus := B_NO_ERROR;
                  end else begin
                    If oStatus <>60 then oStatus:=B_END_OF_FILE;
                  end;
                end else
                if (oStatus = B_NO_ERROR) then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                end;
                ShowBtrError ('GetPrevExtL',oStatus); // doplnene EK 22.09.2000
              until (oStatus <>60) or (mWord>0);
              Move (mExtBuffer[0],mWord,2); If mWord=0 then oFiltRecCnt:=0;
              if  (oFiltRecCnt=0) then begin
                Move (mExtBuffer[0],mWord,2);
                oFiltRecCnt:=mWord;
                If mWord>0 then oRecFilterStr:='';
              end;
            end;
          end else begin
            If oFiltered then begin
              repeat
                SetFilter(mExtBuffer^,TRUE,1,'');
                mRecInfoOfs := 10*oRecordLen+8;
                oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
                If oStatus in [9,22,60,64,65] then begin
                  Move (mExtBuffer[0],mWord,2);
                  If mWord>0 then begin
                    move(mExtBuffer[8], Buffer^, oRecordLen);
                    oStatus := B_NO_ERROR;
                  end else begin
                    If oStatus <>60 then oStatus:=B_END_OF_FILE;
                  end;
                end else
                if (oStatus = B_NO_ERROR) then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                end;
                ShowBtrError ('GetPrevExtP',oStatus); // doplnene EK 22.09.2000
              until (oStatus <>60 ) or (mWord>0);
              if  (oFiltRecCnt=0) then begin
                Move (mExtBuffer[0],mWord,2);
                oFiltRecCnt:=mWord;
                If mWord>0 then oRecFilterStr:='';
              end;
            end else begin
              oStatus := BtrGetPrevious(oPosBlock, Buffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
              If (oStatus = 82) then oRecCnt:=0;
              ShowBtrError ('GetPrev',oStatus); // doplnene EK 22.09.2000
            end;
          end;
          case oStatus of
            B_NO_ERROR    : oCurRec := BETVEEN;
            B_END_OF_FILE : Result  := grBOF;
            64 : Result := grBOF;
            else Result   := grError;
          end;
        end;
      gmCurrent:
        begin
          If oFiltered then begin
            repeat
              SetFilter(mExtBuffer^,FALSE,1,'');
              mRecInfoOfs := 10*oRecordLen+8;
              oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
              If oStatus in [9,22,60,64,65] then begin
                Move (mExtBuffer[0],mWord,2);
                If mWord>0 then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                  oStatus := B_NO_ERROR;
                end else begin
                  If oStatus <>60 then oStatus:=B_END_OF_FILE;
                end
              end else
              if (oStatus = B_NO_ERROR) then begin
                move(mExtBuffer[8], Buffer^, oRecordLen);
              end;
              ShowBtrError ('GetNextExtC',oStatus); // doplnene EK 22.09.2000
            until (oStatus <>60 ) or (mWord>0);
            Move (mExtBuffer[0],mWord,2);
            If (mWord=0) and (oFiltRecCnt>0) then begin
              oStatus := BtrGetLast(oPosBlock, Buffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
              ShowBtrError ('GetLast',oStatus); // doplnene EK 22.09.2000
              repeat
                SetFilter(mExtBuffer^,FALSE,1,'');
                mRecInfoOfs := 10*oRecordLen+8;
                oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
                If oStatus in [9,22,60,64,65] then begin
                  Move (mExtBuffer[0],mWord,2);
                  If mWord>0 then begin
                    move(mExtBuffer[8], Buffer^, oRecordLen);
                    oStatus := B_NO_ERROR;
                  end else begin
                    If oStatus <>60 then oStatus:=B_END_OF_FILE;
                  end;
                end else
                if (oStatus = B_NO_ERROR) then begin
                  move(mExtBuffer[8], Buffer^, oRecordLen);
                end;
                ShowBtrError ('GetPrevExtL',oStatus); // doplnene EK 22.09.2000
              until (oStatus <>60) or (mWord>0);
              Move (mExtBuffer[0],mWord,2); If mWord=0 then oFiltRecCnt:=0;
            end;
            if  (oFiltRecCnt=0) then begin
              Move (mExtBuffer[0],mWord,2);
              oFiltRecCnt:=mWord;
              If mWord>0 then oRecFilterStr:='';
            end;
          end else begin
            oStatus := BtrGetCurrent(oPosBlock, pointer(Buffer), oRecordLen, oKeyNum, oClient);
            ShowBtrError ('GetCurrent',oStatus); // doplnene EK 22.09.2000
          end;
          case oStatus of
            B_NO_ERROR    : oCurRec := BETVEEN;
            else Result := grError;
          end;
        end;
    end;
    If Result = grOK then begin
      mPosition := GetPosition;
      with PRecInfo(Buffer + oRecordLen)^ do begin
        BookmarkFlag := bfCurrent;
        Bookmark := oCurRec;
        BookmarkPosition := mPosition;
      end;
    end else
      If (Result = grError) and DoCheck then DatabaseError('No Records');
  end;
  FreeMem (mExtBuffer);
end;


function TBtrieveTable.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  mFieldOffset,
  mFieldWidth  : integer;
  mSourceBuff  : PChar;
  mDestinBuff  : PChar;
  mLength, i   : integer;
  mCharCode    : byte;
  mFieldICCType: integer;
  mFPDate      : TFPDate;
  mFPTime      : TFPTime;
  mDate        : TDate;
  mTime        : TTime;
  mDatePlus    : integer;
  mTimePlus    : integer;
//  mActiveBuffer: PChar; //2000.5.28.
begin  Result := TRUE;
  mSourceBuff := ActiveBuffer;
//  mActiveBuffer := ActiveBuffer; //2000.5.28.
//  If Assigned(mActiveBuffer) //2000.5.28.
//    then mSourceBuff := mActiveBuffer
//    else mSourceBuff := AllocRecordBuffer;
  If Assigned(Buffer) //2000.5.28.
    then mDestinBuff := Buffer
    else mDestinBuff := AllocRecordBuffer;

//  If ((oRecCnt>0) or (State=dsEdit)or (State=dsInsert)) and (Field.FieldNo > 0){ and (Assigned(Buffer))} and (Assigned(mSourceBuff)) then begin
  If ((not oFiltered and(oRecCnt>0))or(oFiltered and(oFiltRecCnt>0)) or (State=dsEdit)or (State=dsInsert)) and (Field.FieldNo > 0){ and (Assigned(Buffer))} and (Assigned(mSourceBuff)) then begin
    mFieldOffset := Integer(oFieldOffset[Field.FieldNo-1]);
    mFieldWidth  := Integer(oFieldWidth[Field.FieldNo-1]);
    mFieldICCType:= Integer(oFieldICCType[Field.FieldNo-1]);

    If (Field is TStringField) then begin
      case mFieldICCType of
        LSTRING_TYPE : begin
          mLength := ord(mSourceBuff[mFieldOffset]);
          If (mLength > 0) then begin
            for i := 0 to mLength - 1 do begin
              If oDOSStrings
                then mDestinBuff[i] := DOSCharToWINChar(mSourceBuff[mFieldOffset+1+i])
                else mDestinBuff[i] := mSourceBuff[mFieldOffset+1+i];
            end;
          end;
          mDestinBuff[mLength] := #0;
        end;
        else Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
      end;
    end else If (Field is TDateField) then begin
      case mFieldICCType of
        UNSIGNED_BINARY_TYPE : begin
          Move(mSourceBuff[mFieldOffset], mFPDate, 2);
          mDate := FPDate_To_Date(mFPDate);
          mDatePlus :=  Integer(Trunc(mDate)) + DateDelta;
          If mFPDate>0 then begin
            Move(mDatePlus, PChar(mDestinBuff)^, 4);
            Result := True;
          end else begin
            Result := FALSE;
          end;
        end;
        else begin
          Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
          Result := True;
        end;
      end;
    end else If (Field is TTimeField) then begin
      case mFieldICCType of
        UNSIGNED_BINARY_TYPE : begin
          Move(mSourceBuff[mFieldOffset], mFPTime, 4);
          mTime := FPTime_To_Time(mFPTime);
          mTimePlus := Integer(Round(Frac(mTime) * MSecsPerDay));
          If (mFPTime > 0) then begin
            Move(mTimePlus, PChar(mDestinBuff)^, 4);
            Result := True;
          end else begin
            Result := FALSE;
          end;
        end;
        else begin
          Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
          Result := True;
        end;
      end;
    end else If (Field is TWordField) then begin
      case mFieldICCType of
        STRING_TYPE : begin
          fillchar(mDestinBuff^, 2, #0);
          Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
          Result := True;
        end;
        else begin
          Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
          Result := True;
        end;
      end;
    end else{UNSIGNED_BINARY_TYPE}begin
      Move(mSourceBuff[mFieldOffset], PChar(mDestinBuff)^, mFieldWidth);
      Result := True;
    end;

  end else begin
    Result := False;
  end;
//  If not Assigned(mActiveBuffer) and (oRecCnt=0) then Result := FALSE;
//  If not Assigned(mActiveBuffer) then FreeMem(mSourceBuff); //2000.5.28.
  If not Assigned(Buffer) then FreeMem(mDestinBuff); //2000.5.28.
end;

procedure TBtrieveTable.SetFieldData(Field: TField; Buffer: Pointer);
var
  mFieldOffset,
  mFieldWidth: integer;
  mDestinBuff: PChar;
  mSourceBuff: PChar;
  mLength, i : byte;
  mStr:string;
  mFieldICCType: integer;
  mFPDate      : TFPDate;
  mFPTime      : TFPTime;
  mDate        : TDate;
  mTime        : TTime;
  mDatePlus    : integer;
  mTimePlus    : integer;
begin
  mDestinBuff := ActiveBuffer;
  mSourceBuff := Buffer;
  If (oRecCnt >= 0) and (Field.FieldNo > 0) and (Assigned(mDestinBuff)) then begin
    mFieldOffset := Integer(oFieldOffset[Field.FieldNo-1]); // esetleges hasznalatra +FRecordHeaderSize;
    mFieldWidth  := Integer(oFieldWidth[Field.FieldNo-1]);
    mFieldICCType:= Integer(oFieldICCType[Field.FieldNo-1]);

    If (Field is TStringField) then begin
      If Assigned(mSourceBuff) then begin
        case mFieldICCType of
          LSTRING_TYPE : begin
            mLength := length(pChar(mSourceBuff));
            If (mLength > 0) then begin
              for i := 0 to mLength - 1 do begin
                If oDOSStrings
                  then mDestinBuff[mFieldOffset+1+i] := WINCharToDOSChar(mSourceBuff[i])
                  else mDestinBuff[mFieldOffset+1+i] := mSourceBuff[i];
              end;
            end;
            mDestinBuff[mFieldOffset] := Char(mLength);
          end;
          else Move(PChar(mSourceBuff)^, mDestinBuff[mFieldOffset], mFieldWidth);
        end;
      end;
    end else begin
      If (Field is TDateField) then begin
        case mFieldICCType of
          UNSIGNED_BINARY_TYPE : begin
            mFPDate := 0;
            If (Assigned(mSourceBuff)) then begin
              Move(PChar(mSourceBuff)^, mDatePlus, 4);
              mDate := mDatePlus - DateDelta;
              mFPDate := Date_To_FPDate(mDate);
            end;
            Move(mFPDate, mDestinBuff[mFieldOffset], 2);
          end;
          else begin
            Move(PChar(mSourceBuff)^, mDestinBuff[mFieldOffset], mFieldWidth);
          end;
        end;
      end else begin
        If (Field is TTimeField) then begin
          case mFieldICCType of
            UNSIGNED_BINARY_TYPE : begin
              mFPTime := 0;
              If (Assigned(mSourceBuff)) then begin
                Move(PChar(mSourceBuff)^, mTimePlus, 4);
                mTime := mTimePlus / MSecsPerDay;
                mFPTime := Time_To_FPTime(mTime);
              end;
              Move(mFPTime, mDestinBuff[mFieldOffset], 4);
            end;
            else begin
              Move(PChar(mSourceBuff)^, mDestinBuff[mFieldOffset], mFieldWidth);
            end;
          end;
        end else begin
          Move(PChar(mSourceBuff)^, mDestinBuff[mFieldOffset], mFieldWidth);
        end;
      end;
    end;
    DataEvent (deFieldChange, Longint(Field));
  end else begin
    DatabaseError('very bad error in set field data');
  end;
end;

{ Record Navigation / Editing }
{ =========================== }

{ This method is called by TDataSet.First.  Crack behavior is required.
  That is we must position to a special place *before* the first record.
  Otherwise, we will actually end up on the second record after Resync
  is called. }

procedure TBtrieveTable.InternalFirst;
begin
  oCurRec := BEFORE_FIRST;
end;

procedure TBtrieveTable.InternalLast;
begin
  oCurRec := AFTER_LAST;
end;

{ This method is called by TDataSet.Post.  Most implmentations would write
  the changes directly to the associated datasource, but here we simply set
  a flag to write the changes whe we close the dateset. }

procedure TBtrieveTable.InternalPost;
begin
  oSaveChanges := TRUE;
  CheckActive;
  If State = dsEdit then begin
    //B_UPDATE
    GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
    oStatus := BtrUpdate(oPosBlock, ActiveBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient);
    ShowBtrError ('Update',oStatus); // doplnene EK 22.09.2000
    If (oStatus <> B_NO_ERROR) and (oStatus <> B_CONFLICT) then begin
                                   // ^ EK 2004-08-27 kvoli concurrent transakci
    // UPDATE rovnakeho recordu - netreba nacita znovu, zapise sa posledna zmena a ostane specialne pripady sa budu riesit samosatne
      DatabaseError('update error');
    end;
  end else begin
    //B_INSERT
    oStatus := BtrInsert(oPosBlock, ActiveBuffer^, oRecordLen, oKeyBuf[1], oKeyNum);
    oDuplic := oStatus=5;
    If not oDuplic then begin
      ShowBtrError ('Insert',oStatus); // doplnene EK 22.09.2000
      If oStatus <> B_NO_ERROR then begin
        DatabaseError('insert error');
      end
      else begin
        Inc (oRecCnt);
        If oFiltered then Inc (oFiltRecCnt);
        oRecFilterStr:='';
        with PRecInfo(ActiveBuffer + oRecordLen)^ do
        begin
          BookmarkFlag := bfCurrent;
          Bookmark := oCurRec;//
          BookmarkPosition := GetPosition;
        end;
      end;
    end;
  end;
end;

{ This method is similar to InternalPost above, but the operation is always
  an insert or append and takes a pointer to a record buffer as well. }

procedure TBtrieveTable.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  oSaveChanges := True;
  If Append then InternalLast;
  oStatus := BtrInsert(oPosBlock, ActiveBuffer^, oRecordLen, oKeyBuf[1], oKeyNum);
  ShowBtrError ('Insert',oStatus); // doplnene EK 22.09.2000

  If oStatus <> B_NO_ERROR then begin
    DatabaseError('insert error');
  end else begin
    Inc (oRecCnt);
    If oFiltered then Inc (oFiltRecCnt);
    oRecFilterStr:='';
    with PRecInfo(ActiveBuffer + oRecordLen)^ do
      begin
        BookmarkFlag := bfCurrent;
        Bookmark := oCurRec;
        BookmarkPosition := GetPosition;
      end;
  end;
end;

{ This method is called by TDataSet.Delete to delete the current record }

procedure TBtrieveTable.DTX2BTR;
var mFile:string;
  procedure ReadDelFile;
  var mT:TextFile;I,mIORes:longint; mS:String;mTxtCut:TTxtCut;
  begin
    If FileExistsI(mFile) then begin
      AssignFile (mT, mFile);
      {$I-} System.Reset(mT);{$I+}
      mIORes := IOResult;
      If mIORes=0then begin
        mTxtCut := TTxtCut.Create;
        mTxtCut.SetDelimiter ('');
        mTxtCut.SetSeparator (';');
        while not System.Eof(mT) do begin
          System.Readln(mt,mS);
          If mS<>'' then begin
            mTxtCut.SetStr(mS);
    {
    1        gvSys.LoginName
    2        Date
    3        Time
    4        cPrgVer
    5        D
    }
            Insert;
            For I:=0 to FieldCount-1 do begin
              try
                FieldByName(FieldDefs[I].Name).AsString:=mTxtCut.GetText(I+6);
              except
                If (FieldDefs[I].DataType=ftInteger)or(FieldDefs[I].DataType=ftWord)
                  then FieldByName(FieldDefs[I].Name).AsInteger:=0
                  else FieldByName(FieldDefs[I].Name).AsString:='';
              end;
            end;
            If FindField('ModUser')<>NIL then FieldByName('ModUser').AsString:=mTxtCut.GetText(1);
            If FindField('ModDate')<>NIL then FieldByName('ModDate').AsString:=mTxtCut.GetText(2);
            If FindField('ModTime')<>NIL then FieldByName('ModTime').AsString:=mTxtCut.GetText(3);
            Post;
          end;
        end;
        {$I-}CloseFile(mT);{$I+}
        mIORes := IOResult;
      end;
      FreeAndNil (mTxtCut);
    end;
  end;
begin
  mFile := DatabaseName+ExtractFileName (TableName)+'.DEL';
  ReadDelFile;
  mFile := DatabaseName+ExtractFileName (TableName)+'.DTX';
  ReadDelFile;
end;

procedure TBtrieveTable.DelToDTX;
var mT:TextFile; I,mIORes:longint; mFile:string; mTxtWrap:TTxtWrap;
begin
  If oDelToTXT then begin
    mFile := DatabaseName+ExtractFileName (TableName)+'.DEL';
    AssignFile (mT, mFile);
    {$I-}
    If FileExistsI(mFile) then System.Append (mT) else Rewrite (mT);
    {$I+} mIORes := IOResult;
    If mIORes=0 then begin
      mTxtWrap := TTxtWrap.Create;
      mTxtWrap.SetDelimiter ('');
      mTxtWrap.SetSeparator (';');
      mTxtWrap.ClearWrap;
      mTxtWrap.SetText(gvSys.LoginName,0);
      mTxtWrap.SetDate(Date);
      mTxtWrap.SetTime(Time);
      mTxtWrap.SetText(cPrgVer,0);
      mTxtWrap.SetText('D',0);
      For I:=0 to FieldCount-1 do begin
        mTxtWrap.SetText(FieldByName (FieldDefs[I].Name).AsString,0);
      end;
      {$I-}WriteLn (mT, mTxtWrap.GetWrapText);{$I+}
      mIORes := IOResult;
      {$I-}CloseFile (mT);{$I+}
      mIORes := IOResult;
    end;
    FreeAndNil (mTxtWrap);
  end;
end;

procedure TBtrieveTable.InternalDelete;
var mPos,mPos2: TBtrPosition;
  mLast:boolean;
begin
  oSaveChanges := True;
  If oReadOnly then Exit;
  CheckActive;
  DeltoDTX;
  mPos:=PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition;
  GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
  DisableControls;
  If not EOF then begin
    Next;
    mPos2:=PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition;
    mLast:=FALSE;
    If mPos2=mPos then begin
      Prior;
      mPos2:=PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition;
      mLast:=TRUE;
    end;
  end else begin
    Prior;
    mPos2:=PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition;
    mLast:=TRUE;
  end;
  GotoDirect(mPos);
  oStatus := BtrDelete(oPosBlock, oClient);
  ShowBtrError ('Delete',oStatus); // doplnene EK 22.09.2000

  If oStatus <> B_NO_ERROR then begin
    DatabaseError('delete error');
  end else
  begin
    Dec(oRecCnt);
    If oFiltered then Dec (oFiltRecCnt);
    oRecFilterStr:='';
  end;
  EnableControls;
  Refresh;
//  If mLast then Last;
//  Resync([rmCenter]);
  GotoDirect(mPos2);
//  If mLast then Next;
end;

{ Optional Methods }
{ ================ }

function TBtrieveTable.GetRecordCount: Longint;
var
  mExtBuffer:PChar;
  mWord,mRecInfoOfs:word;
  mAll:longint;
  procedure SwapStatusI;
  begin
    Inc (oSwapNum);
    oStatusRec[oSwapNum].EOF         := EOF;
    oStatusRec[oSwapNum].IndexNumber := IndexNumber;
    oStatusRec[oSwapNum].Position    := ActPos;
    oStatusRec[oSwapNum].Filter      := Filter;
    oStatusRec[oSwapNum].Filtered    := Filtered;
  end;

  procedure RestoreStatusI;
  begin
//    IndexNumber := oStatusRec[oSwapNum].IndexNumber;
    GotoPos(oStatusRec[oSwapNum].Position);
    If (oStatusRec[oSwapNum].Filter<>Filter) or (oStatusRec[oSwapNum].Filtered<>Filtered) then begin
      Filter      := oStatusRec[oSwapNum].Filter;
      Filtered    := oStatusRec[oSwapNum].Filtered;
    end;
    oActFilter  := FALSE;
    Dec(oSwapNum);
//    Refresh;
    If oStatusRec[oSwapNum+1].EOF then begin
      Last;
    end;
  end;

begin
  CheckActive;
  Statistic2;
  Result := oRecCnt;
  If oFiltered then begin
    If oRecFilterStr<>oFilter then begin
      SwapStatusI;
      GetMem (mExtBuffer,65535);
      mAll:=0;
      oStatus := BtrGetFirst(oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
      ShowBtrError ('GetFirst',oStatus); // doplnene EK 22.09.2000
      oActFilter:=FALSE;
      repeat
        SetFilter(mExtBuffer^,(mAll>0),10000,#0);
        mRecInfoOfs := 60000;
        oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
        If oStatus in [0,9,22,60,64,65,97] then begin
          Move (mExtBuffer[0],mWord,2);
          If mWord>0 then begin
            mall:=mAll+mWord;
          end else begin
            If oStatus <>60 then oStatus:=B_END_OF_FILE;
          end
        end else If (oStatus = B_NO_ERROR) then begin
          mWord:=0;
        end;
      until (oStatus in [3,6,7,8,9,61,62]);
      oActFilter:=FALSE;
      oFiltRecCnt:=mAll;
      oRecFilterStr:=oFilter;
      FreeMem (mExtBuffer);
      RestoreStatusI;
      oFiltRecCnt:=mAll;
    end else begin
      mAll:=oFiltRecCnt;
    end;
    Result:=mAll;
  end;
end;

procedure TBtrieveTable.CalcField (pType:byte;pFld:integer;var pSum: double;var pCount:longint;var pMin,pMax:double);
var
  mExtBuffer:PChar;
  mByte,mOpType,mDefOpType:byte;
  mI,mLen,mWord,mRecInfoOfs:word;
  mPos,mAll,mLongint: longint;
  mSum,mDouble:double;
  mLString: string[255];
begin
  pMin:=999999999;pMax:=0-pMin;
  SwapStatus;
  GetMem (mExtBuffer,65535);
  mAll:=0;mSum:=0;
  mDEFOpType      :=Integer(oFieldDEFType[pFld]);
  mOpType         :=Integer(oFieldICCType[pFld]);
  mLen            :=Integer(oFieldWidth  [pFld]);
  GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
  If pType=0
    then oStatus := BtrGetFirst  (oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode)
    else oStatus := BtrGetCurrent(oPosBlock, Pointer(mExtBuffer), oRecordLen, oKeyNum, oClient);

  oActFilter:=FALSE;
  repeat
    SetFilter(mExtBuffer^,(mAll>0),10000,chr(pFld));
    mRecInfoOfs := 60000;
    If pType in [0,1]
      then oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode)
      else oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
    If oStatus in [0,9,22,60,64,65,97] then begin
      Move (mExtBuffer[0],mWord,2);
      If mWord>0 then begin
        mall:=mAll+mWord;
        mPos:=2;
        for mI:=1 to mWord do begin
          Move (mExtBuffer[mPos],mLen,2);       // repeated - received data length
          Move (mExtBuffer[mPos+2],mLongInt,4); // repeated - Record position in Table
          mPos:=mPos+6;
          case mOpType of
            UNSIGNED_BINARY_TYPE: begin
                                    if mLen = 2 then begin
                                      Move(mExtBuffer[mPos], mWord,mLen);
                                      mSum:=mSum+mWord;
                                      If pMin>mWord then pMin:=mWord;
                                      If pMax<mWord then pMax:=mWord;
                                    end else if mLen=4 then begin
                                      Move(mExtBuffer[mPos], mLongint,mLen);
                                      mSum:=mSum+mLongint;
                                      If pMin>mLongint then pMin:=mLongint;
                                      If pMax<mLongint then pMax:=mLongint;
                                    end;
                                  end;
            IEEE_TYPE:            begin
                                    Move(mExtBuffer[mPos], mDouble,mLen);
                                    mSum:=mSum+mDouble;
                                    If pMin>mDouble then pMin:=mDouble;
                                    If pMax<mDouble then pMax:=mDouble;
                                  end;
            LSTRING_TYPE:         begin
                                    Move(mExtBuffer[mPos],mLString[0], mLen+1);
                                    mSum:=-1;
                                  end;
          end;  // case
          mPos:=mPos+mlen;
        end; // for
      end else begin  // mWord>0
        oStatus:=B_END_OF_FILE;
      end
    end  // oStatus in [0,9,22,60,64,65,97]
    else If (oStatus = B_NO_ERROR) then begin
      mWord:=0;
    end;
  until (oStatus in [3,6,7,8,9,61,62]);
  pSum:=mSum;pCount:=mAll;
  oActFilter:=FALSE;
  FreeMem (mExtBuffer);
  RestoreStatus;
end;
(*
function TBtrieveTable.GetRecNo: Longint;
begin
  UpdateCursorPos;
  If (FCurRec = -1) and (RecordCount > 0) then
    Result := 1 else
    Result := FCurRec + 1;
end;

procedure TBtrieveTable.SetRecNo(Value: Integer);
begin
  If (Value >= 0) and (Value < FData.Count) then
  begin
    FCurRec := Value - 1;
    Resync([]);
  end;
end;
*)
{ This procedure is used to register this component on the component palette }

procedure TBtrieveTable.ShowBtrError(pOp:Str20;pStatus: Integer);
begin
  If not (pStatus in [0,4,7,8,9,B_INVALID_RECORD_ADDRESS,B_CONFLICT,B_LOST_POSITION,B_REJECT_COUNT_REACHED{,64}]) then begin
    If oShowErrMsg then ShowMsg(10000+pStatus,oDatabaseName+oTableName+'.'+oTableNameExt+'|'+pOp);
    If gBtrErrorLogfile or (oBtrErrorLogfile=1) then WriteToLogFile(oDatabaseName+oTableName+'.LOG',oTableName+'.'+oTableNameExt+'|'+pOp+'|'+IntToStr(pStatus));
    If gBtrErrorLogfile or (oBtrErrorLogfile=2) then WriteToLogFile(oDatabaseName+'BTRERR.LOG',oTableName+'.'+oTableNameExt+'|'+pOp+'|'+IntToStr(pStatus));
  end;
  //                                     43,                 80         82                    60
end;

procedure TBtrieveTable.SetFilterOn(pfilter: string);
begin
  Active   := FALSE;
  Filter   := pFilter;
  Filtered := TRUE;
  Active   := TRUE;
end;

procedure TBtrieveTable.SetFilterOff;
begin
  Active   := FALSE;
  Filtered := FALSE;
  Active   := TRUE;
end;

  PROCEDURE CreateIntervalStr(pBtr:TBtrieveTable;pFld:Str20;var pStr:string);
    var
      mJ,mK: byte;
      mF,mL: longint;
    BEGIN
        mK  :=pBtr.FindField(pFld).FieldNo;
        pBtr.SwapStatus;
        pBtr.indexName:=pFld;
        pBtr.First;
        pStr:='';
        mF:=0;mL:=0;
        While not pBtr.Eof and (length (pStr)<200)do begin
          If pBtr.FieldByName('ActPos').AsInteger=1 then begin
            mJ:=pBtr.FieldByName(pFld).AsInteger;
            If mF=0 then begin
            mF:=mJ;
            mL:=mJ-1; end;
            If mJ=mL+1 then begin
              mL:= mJ;
            end else begin
              If mL-mF=0
                then pStr:=pStr+StrInt (mF,0)+','
                else pStr:=pStr+StrInt (mF,0)+'..'+StrInt (mL,0)+',';
              mF:=mJ;
              mL:=mJ;
            end;
          end;
          pBtr.Next;
        end;
        If mL-mF>0
          then pStr:=pStr+StrInt (mF,0)+'..'+StrInt (mL,0)+','
          else pStr:=pStr+StrInt (mF,0)+',';
        If pStr<>'' then Delete (pStr,Length (pStr),1);
        pBtr.RestoreStatus;
    END;     { *** TBGAskObj.F268_CreateStr *** }

function TBtrieveTable.GetRecordCountNoSwap: Longint;
var
  mExtBuffer:PChar;
  mWord,mRecInfoOfs:word;
  mAll:longint;
begin
  GetMem (mExtBuffer,65535);
  mAll:=0;
  oStatus := BtrGetFirst(oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode);
  ShowBtrError ('GetFirst',oStatus); // doplnene EK 22.09.2000
  oActFilter:=FALSE;
  repeat
    SetFilter(mExtBuffer^,False,10000,#0);
    mRecInfoOfs := 60000;
    oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
    If oStatus in [0,9,22,60,64,65,97] then begin
      Move (mExtBuffer[0],mWord,2);
      If mWord>0 then begin
        mall:=mAll+mWord;
      end else begin
        If oStatus <>60 then oStatus:=B_END_OF_FILE;
      end
    end else If (oStatus = B_NO_ERROR) then begin
      mWord:=0;
    end;
  until (oStatus in [3,6,7,8,9,61,62]);
  oActFilter:=FALSE;
  oFiltRecCnt:=mAll;
  oRecFilterStr:=oFilter;
  FreeMem (mExtBuffer);
  oFiltRecCnt:=mAll;
  Result:=mAll;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TBtrieveTable]);
end;

procedure TBtrieveTable.SearchFields (pType:byte;pCnt,pFld:integer;pSrchStr:Str30;
          var pPositions: String;var pCount:longint;pUperCase:byte);
var
  mExtBuffer:PChar;
  mByte,mOpType,mDefOpType:byte;
  mI,mLen,mWord,mRecInfoOfs:word;
  mPos,mAll,mLongint,mPosition,mOldPosition: longint;
  mSum,mDouble:double;
  mLString: string[255];
begin
  SwapStatus;
  GetMem (mExtBuffer,65535);
  mAll:=0;mSum:=0;
  mDEFOpType      :=Integer(oFieldDEFType[pFld]);
  mOpType         :=Integer(oFieldICCType[pFld]);
  mLen            :=Integer(oFieldWidth  [pFld]);
  GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
  If pType=0
    then oStatus := BtrGetFirst  (oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode)
    else oStatus := BtrGetCurrent(oPosBlock, Pointer(mExtBuffer), oRecordLen, oKeyNum, oClient);

  oActFilter:=FALSE;
  pPositions:='';
  mOldPosition:=0;
  repeat
    mRecInfoOfs := 60000;
    If pCnt>0
      then SetFilter(mExtBuffer^,False,pCnt,chr(pFld))
      else SetFilter(mExtBuffer^,False,(mRecInfoOfs div (mLen+6)),chr(pFld));
    If pType in [0,1]
      then oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode)
      else oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
    If oStatus in [0,9,22,60,64,65,97] then begin
      Move (mExtBuffer[0],mWord,2);
      If mWord>0 then begin
        mPos:=2;
        for mI:=1 to mWord do begin
          Move (mExtBuffer[mPos],mLen,2);       // repeated - received data length
          Move (mExtBuffer[mPos+2],mPosition,4); // repeated - Record position in Table
          mPos:=mPos+6;
          If mPosition=mOldPosition then begin
            mOldPosition:=mPosition;
          end else begin
            case mOpType of
              UNSIGNED_BINARY_TYPE: begin
                                      if mLen = 2 then begin
                                        Move(mExtBuffer[mPos], mWord,mLen);
                                        If IntToStr(mWord)=pSrchStr then begin Inc (mAll);pPositions:=pPositions+'|'+IntToStr(mPosition);mOldPosition:=mPosition;end;
                                      end else if mLen=4 then begin
                                        Move(mExtBuffer[mPos], mLongint,mLen);
                                        If IntToStr(mLongint)=pSrchStr then begin Inc (mAll);pPositions:=pPositions+'|'+IntToStr(mPosition);mOldPosition:=mPosition;end;
                                      end;
                                    end;
              IEEE_TYPE:            begin
                                      Move(mExtBuffer[mPos], mDouble,mLen);
                                      If FloatToStr(mDouble)=pSrchStr then begin Inc (mAll);pPositions:=pPositions+'|'+IntToStr(mPosition);mOldPosition:=mPosition;end;
                                    end;
              LSTRING_TYPE:         begin
                                      Move(mExtBuffer[mPos],mLString[0], mLen+1);
//                                      If pUperCase then mLString:=StrToAlias(mLString);
                                      If pUperCase in [1,3] then mLString:=ConvToNoDiakr (mLString);
                                      If pUperCase in [2,3] then mLString:=UpString(mLString);
                                      If Pos(pSrchStr,mLString)>0 then begin Inc (mAll);pPositions:=pPositions+'|'+IntToStr(mPosition);mOldPosition:=mPosition;end;
                                    end;
            end;  // case
          end;
          mPos:=mPos+mlen;
        end; // for
      end else begin  // mWord>0
        oStatus:=B_END_OF_FILE;
      end
    end  // oStatus in [0,9,22,60,64,65,97]
    else If (oStatus = B_NO_ERROR) then begin
      mWord:=0;
    end;
  until (oStatus in [3,6,7,8,9,61,62]);
  If pPositions<>'' then System.Delete(pPositions,1,1);
  pCount:=mAll;
  oActFilter:=FALSE;
  FreeMem (mExtBuffer);
  RestoreStatus;
end;

procedure TBtrieveTable.GetField (pType:byte;pCnt,pFld:integer;var pValues: String;var pCount:longint);
var
  mExtBuffer:PChar;
  mByte,mOpType,mDefOpType:byte;
  mI,mLen,mWord,mRecInfoOfs:word;
  mPos,mAll,mLongint,mPosition: longint;
  mSum,mDouble:double;
  mLString: string[255];
begin
  GetMem (mExtBuffer,65535);
  mAll:=0;mSum:=0;
  mDEFOpType      :=Integer(oFieldDEFType[pFld]);
  mOpType         :=Integer(oFieldICCType[pFld]);
  mLen            :=Integer(oFieldWidth  [pFld]);
  GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
  If pType=0
    then oStatus := BtrGetFirst  (oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode)
    else begin
      oStatus := BtrGetCurrent(oPosBlock, Pointer(mExtBuffer), oRecordLen, oKeyNum, oClient);
      If pType=3 then Next;
    end;

  oActFilter:=FALSE;
  pValues:='';
//  repeat
    mRecInfoOfs := 60000;
    If pCnt>0
      then SetFilter(mExtBuffer^,False,pCnt,chr(pFld))
      else SetFilter(mExtBuffer^,False,(mRecInfoOfs div (mLen+6)),chr(pFld));
    If pType in [0,1,3]
      then oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode)
      else oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
    If oStatus in [0,9,22,60,64,65,97] then begin
      Move (mExtBuffer[0],mWord,2);
      If mWord>0 then begin
        mPos:=2;
        for mI:=1 to mWord do begin
          Move (mExtBuffer[mPos],mLen,2);       // repeated - received data length
          Move (mExtBuffer[mPos+2],mPosition,4); // repeated - Record position in Table
          mPos:=mPos+6;
          case mOpType of
            UNSIGNED_BINARY_TYPE: begin
                                    if mLen = 2 then begin
                                      Move(mExtBuffer[mPos], mWord,mLen);
                                      Inc (mAll);
                                      pValues:=pValues+'|'+IntToStr(mWord);
                                    end else if mLen=4 then begin
                                      Move(mExtBuffer[mPos], mLongint,mLen);
                                      Inc (mAll);
                                      pValues:=pValues+'|'+IntToStr(mLongint);
                                    end;
                                  end;
            IEEE_TYPE:            begin
                                    Move(mExtBuffer[mPos], mDouble,mLen);
                                    Inc (mAll);
                                    pValues:=pValues+'|'+FloatToStr(mDouble);
                                  end;
            LSTRING_TYPE:         begin
                                    Move(mExtBuffer[mPos],mLString[0], mLen+1);
                                    Inc (mAll);
                                    pValues:=pValues+'|'+mLString;
                                  end;
          end;  // case
          mPos:=mPos+mlen;
        end; // for
      end else begin  // mWord>0
        oStatus:=B_END_OF_FILE;
      end
    end  // oStatus in [0,9,22,60,64,65,97]
    else If (oStatus = B_NO_ERROR) then begin
      mWord:=0;
    end;
//  until (oStatus in [3,6,7,8,9,61,62]);
  If pValues<>'' then System.Delete(pValues,1,1);
  pCount:=mAll;
  oActFilter:=FALSE;
  FreeMem (mExtBuffer);
  GotoPos(mPosition);
end;

procedure TBtrieveTable.GetFields (pType:byte;pCnt:integer;var pValues: String;var pCount:longint;pFields:String);
var
  mExtBuffer:PChar;
  mByte,mOpType,mDefOpType:byte;
  mI,mJ,mLen,mRLen,mALen,mWord,mRecInfoOfs:word;
  mPos,mAll,mLongint,mPosition: longint;
  mSum,mDouble:double;
  mLString: string[255];
  mValues:String;
begin
  GetMem (mExtBuffer,65535);
  mAll:=0;mSum:=0;mALen:=0;
  for mJ:=1 to Length(pFields) do mAlen:=mALen+Integer(oFieldWidth  [Ord(pFields[mJ])]);
  GotoDirect(PRecInfo(ActiveBuffer+oRecordLen)^.BookmarkPosition);
  If pType=0
    then oStatus := BtrGetFirst  (oPosBlock, mExtBuffer^, oRecordLen, oKeyBuf[1], oKeyNum, oClient,oOpenMode)
    else begin
      oStatus := BtrGetCurrent(oPosBlock, Pointer(mExtBuffer), oRecordLen, oKeyNum, oClient);
      If pType=3 then Next;
    end;

  oActFilter:=FALSE;
  pValues:='';
//  repeat
    mRecInfoOfs := 60000;
    If pCnt>0
      then SetFilter(mExtBuffer^,False,pCnt,pFields)
      else SetFilter(mExtBuffer^,False,(mRecInfoOfs div (mALen+6)),pFields);
    If pType in [0,1,3]
      then oStatus := BtrGetNextExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode)
      else oStatus := BtrGetPrevExt(oPosBlock, mExtBuffer^, mRecInfoOfs, oKeyBuf[1], oKeyNum, oClient,OpenMode);
    If oStatus in [0,9,22,60,64,65,97] then begin
      Move (mExtBuffer[0],mWord,2);
      If mWord>0 then begin
        mPos:=2;
        for mI:=1 to mWord do begin
          Inc (mAll);
          Move (mExtBuffer[mPos],mRLen,2);       // repeated - received data length
          Move (mExtBuffer[mPos+2],mPosition,4); // repeated - Record position in Table
          mPos:=mPos+6;
          mALen:=0;
          pValues:=pValues+'|';
          mValues:='';
          for mJ:=1 to Length(pFields) do begin
            mDEFOpType      :=Integer(oFieldDEFType[Ord(pFields[mJ])]);
            mOpType         :=Integer(oFieldICCType[Ord(pFields[mJ])]);
            mLen            :=Integer(oFieldWidth  [Ord(pFields[mJ])]);
            case mOpType of
              UNSIGNED_BINARY_TYPE: begin
                                      if mLen = 2 then begin
                                        Move(mExtBuffer[mPos], mWord,mLen);
                                        mValues:=mValues+#255+IntToStr(mWord);
                                      end else if mLen=4 then begin
                                        Move(mExtBuffer[mPos], mLongint,mLen);
                                        mValues:=mValues+#255+IntToStr(mLongint);
                                      end;
                                    end;
              IEEE_TYPE:            begin
                                      Move(mExtBuffer[mPos], mDouble,mLen);
                                      mValues:=mValues+#255+FloatToStr(mDouble);
                                    end;
              LSTRING_TYPE:         begin
                                      Move(mExtBuffer[mPos],mLString[0], mLen+1);
                                      mValues:=mValues+#255+mLString;
                                    end;
            end;  // case
            mALen := mALen+mLen;
            mPos:=mPos+mlen;
          end; // for mJ:=1 to Lenghth(pFields)
          If mValues[1]=#255 then System.Delete(mValues,1,1);
          pValues:=pValues+mValues;
        end; // for mI:=1 to mWord do begin
      end else begin  // mWord>0
        oStatus:=B_END_OF_FILE;
      end
    end  // oStatus in [0,9,22,60,64,65,97]
    else If (oStatus = B_NO_ERROR) then begin
      mWord:=0;
    end;
//  until (oStatus in [3,6,7,8,9,61,62]);
  If pValues<>'' then System.Delete(pValues,1,1);
  pCount:=mAll;
  oActFilter:=FALSE;
  FreeMem (mExtBuffer);
  GotoPos(mPosition);
end;

end.

{ **************************
  priklad pouzitia GetFields
  **************************

struktura vrateneho retazca je nasledovna:
polia su oddelen znakom #255 a zaznamy znakom |
--------- zaznam 1 ----------- |--------- zaznam 2 -----------
Field1 #255 Field2 #255 Field3 | Field1 #255 Field2 #255 Field3 | .......

napr. pre polia SmCode,DocDate,CValue je vrateny retazec
59†42115†20.56|59†42118†41.3|900†42100†58|.....

    mMax:=10000;mF:=0;
    btSTM.First;
    // zistime maximalny pocet vratenych zaznamov aby sme vedeli kontrolovat ci sme uz na konci
    btStm.GetFields (mF, 10000, mSQ, mCnt, Chr(btStm.FieldDefs.Find('SmCode').FieldNo-1)
                                          +Chr(btStm.FieldDefs.Find('DocDate').FieldNo-1)
                                          +Chr(btStm.FieldDefs.Find('CValue').FieldNo-1));
    If mCnt<mMax then mMax:=mCnt;
    btSTM.First;
    Repeat
      btStm.GetFields (mF, mMax, mSQ, mCnt, Chr(btStm.FieldDefs.Find('SmCode').FieldNo-1)
                                            +Chr(btStm.FieldDefs.Find('DocDate').FieldNo-1)
                                            +Chr(btStm.FieldDefs.Find('CValue').FieldNo-1));
      mSQ:=mSQ+'|';
      for mI:=1 to mCnt do begin
        mSS := Copy(mSQ,1,Pos('|',mSQ)-1);Delete(mSQ,1,Pos('|',mSQ));
        mCode  := ValInt(Copy(mSS,1,Pos(#255,mSS)-1));Delete(mSS,1,Pos(#255,mSS));
        mDate  := FPDate_To_Date(StrToInt(Copy(mSS,1,Pos(#255,mSS)-1)));Delete(mSS,1,Pos(#255,mSS));
        mValue := ValDoub(mSS);

        .... spracujeme udaje

      end;
      mF:=3;
    until (mCnt=0) or (mCNT<mMax);

}
{MOD 1807029}
{MOD 1810009}