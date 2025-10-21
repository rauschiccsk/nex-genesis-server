unit NexPxbTable;

(*
Tento unit obsahuje konponent NexPxbTable. Tento komponent je z TTable a má
nasledovné funkcie:
- CreateTableInDef - vytvorý databázový súbor pod¾a popisu DefName

nové vlastnosti:
- DefPath - adresár, kde sa nachádza definièný súbor. Systém automaticky
            naèíta z gPath.DefPath
- DefName - názov definièného súboru
- AutoCreate - ak je TRUE, pred otvorením databázového súboru prekontroluje, èi
            existuje daný databázový súbor, ak nie, vytvorý
- AutoDelete - ak je TRUE, po uzatvorení databázového súboru s príkazom Close
            automaticky ho zruší
*)

interface

uses
  DbiProcs, DbiTypes, DBConsts, Db, DbTables,
  NexPath, IcTypes, IcConv, IcTools, IcFiles, NumText, Nexmsg, PxTable, NexPxTable,
  Variants, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TNexPxbTable = class(TTable)
  private
    oInsEnab: boolean;
    oDefPath: string;
    oDefName: string;
    oIndexName: string;
    oTableNameExt : string;
    oFixedName: string;
    oAutoCreate: boolean;
    eBeforePost: TDataSetNotifyEvent;
    oStatusRec: array [1..10] of TPxStatusRec;
    oSwapNum: byte;

    procedure MyBeforePost (DataSet: TDataSet) ;
    procedure MyAfterInsert (DataSet: TDataSet);

    function  GetActive:boolean;
    procedure SetActive (Value:boolean);
    function  GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
    function  GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
  public
    constructor Create(pOwner: TComponent); override;
    procedure Open; overload;
    procedure Close; overload;

    procedure CreateTableInDef;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure InternalCreateTable;
    procedure DelRecs;
    function  ActPos: integer;
    function  GotoPos(pActPos: integer):boolean;
    function  FindNearest(const KeyValues: array of const):boolean;
    function  GetRecordBuffer:PChar;
    procedure SetRecordBuffer(pBuffer:PChar);
    function  GetRecordLen: longint;  // Dlazka vety v bytoch
    function  IsFirstRec: boolean; // TRUE al zaznam je prvy
    function  IsLastRec: boolean; // TRUE al zaznam je posledny
  published
    property Active:boolean read GetActive write SetActive;
    property DefPath: string read oDefPath write oDefPath;
    property DefName: string read oDefName write oDefName;
    property TableNameExt: string read oTableNameExt write oTableNameExt;
    property FixedName: string read oFixedName write oFixedName;
    property InsEnab: boolean write oInsEnab;
    property AutoCreate: boolean read oAutoCreate write oAutoCreate;
    property BeforePost: TDataSetNotifyEvent read eBeforePost write eBeforePost;
  end;

procedure Register;

implementation

procedure TNexPxbTable.SwapStatus;
begin
  Inc (oSwapNum);
  oStatusRec[oSwapNum].IndexName   := IndexName;
  oStatusRec[oSwapNum].Position    := GetBookMark;
  oStatusRec[oSwapNum].Filter      := Filter;
  oStatusRec[oSwapNum].Filtered    := Filtered;
end;

procedure TNexPxbTable.RestoreStatus;
begin
  IndexName   := oStatusRec[oSwapNum].IndexName;
  Filter      := oStatusRec[oSwapNum].Filter;
  Filtered    := oStatusRec[oSwapNum].Filtered;
  If BookmarkValid(oStatusRec[oSwapNum].Position) then GotoBookMark(oStatusRec[oSwapNum].Position);
  Dec(oSwapNum);
end;

procedure TNexPxbTable.MyBeforePost (DataSet: TDataSet) ;
var B,L,I:byte;  mStr:string;  mFoundedField: TField;
begin
  for I:=0 to DataSet.FieldCount-1 do begin
    mStr := DataSet.Fields[i].FieldName;
    mStr := Uppercase(mStr); //2000.5.9.
    If mStr[length(mStr)] = '_' then begin
      mFoundedField := DataSet.FindField(copy(mStr,1,Length(mStr)-1));
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=IcConv.StrToAlias(mFoundedField.AsString);
    end;
    If mStr[1] = '_' then begin
      mFoundedField := DataSet.FindField(copy(mStr,2,Length(mStr)-1));
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=IcConv.StrToAlias(mFoundedField.AsString);
    end;
  end;
  If Assigned (eBeforePost) then eBeforePost (DataSet);
end;

procedure TNexPxbTable.MyAfterInsert (DataSet: TDataSet);
begin
  If not oInsEnab then Cancel;
end;

function  TNexPxbTable.GetActive:boolean;
begin
  Result := inherited Active;
end;

procedure TNexPxbTable.SetActive (Value:boolean);
begin
  If not inherited Active and Value then begin
    Open;
  end else begin
    If inherited Active and not Value then Close;
  end;
end;

function  TNexPxbTable.GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
begin
  Result := FALSE;
  If pFldTypeS<>'' then begin
    pFldType := ftUnknown;
    pFldSize := 0;
    pFldTypeS := UpString (pFldTypeS);
    If (pFldTypeS='LONGINT') or (pFldTypeS='WORD') or (pFldTypeS='BYTE')
                                  then pFldType := ftInteger;
    If (pFldTypeS='DOUBLE')       then pFldType := ftFloat;
    If (pFldTypeS='DATETYPE')     then pFldType := ftDate;
    If (pFldTypeS='TIMETYPE')     then pFldType := ftTime;
    If (pFldTypeS='MEMO')         then pFldType := ftMemo;
    If (pFldTypeS='BLOB')         then pFldType := ftBlob;
    If (pFldTypeS='BOOLEAN')      then pFldType := ftBoolean;
    If (pFldTypeS='GRAPHIC')      then pFldType := ftGraphic;
    If (pFldTypeS='DATETIMETYPE') then pFldType := ftDateTime;
    If (pFldTypeS='CHAR') then begin
      pFldType := ftString;
      pFldSize := 0;
    end;
    If (Copy (pFldTypeS,1,3)='STR') then begin
      pFldType := ftString;
      pFldSize := ValInt (Copy (pFldTypeS,4,Length (pFldTypeS)));
    end;
    Result := (pFldType<>ftUnknown);
    If not Result then ShowMsg (190002,DatabaseName+TableName+'  '+pFldName+pFldTypeS); //Nesprávný typ pola
  end;
end;

function  TNexPxbTable.GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
begin
  Result := FALSE;
  If (pIndex<>'') and (pIndTypeS<>'') then begin
    pIndName := RemLeftSpaces (RemRightSpaces (Copy (pIndex,Pos ('=',pIndex)+1,Length (pIndex))));
    pIndFields := RemLeftSpaces (RemRightSpaces (Copy (pIndex,1,Pos ('=',pIndex)-1)));
    pIndType := [];
    pIndTypeS := UpString (pIndTypeS);
    If Pos ('CDUPLIC',pIndTypeS)=0 then pIndType := pIndType+[ixPrimary];
    If Pos ('CDESCEND',pIndTypeS)>0 then pIndType := pIndType+[ixDescending];
    If Pos ('CINSENSIT',pIndTypeS)>0 then pIndType := pIndType+[ixCaseInsensitive];
    Result := TRUE;
  end;
end;

constructor TNexPxbTable.Create;
begin
  inherited Create (pOwner);
  inherited BeforePost := MyBeforePost;
  inherited AfterInsert := MyAfterInsert;

  oInsEnab := TRUE;
  oAutoCreate := TRUE;
  oSwapNum     := 0;
end;

procedure TNexPxbTable.InternalCreateTable;
var mCnt:longint;
begin
  CreateTableInDef;
  oSwapNum  := 0;
end;

procedure TNexPxbTable.Open;
begin
  If Active then Close;
  If not Exists then begin // Ak neexistuje a je zapnute automatcike vytovrenie potom vyrvorime databazu
    If oAutoCreate then InternalCreateTable;
  end;
  oSwapNum := 0;
  inherited Open;
end;

procedure TNexPxbTable.Close;
begin
  inherited Close;
end;

procedure TNexPxbTable.CreateTableInDef;
var
  mT:TextFile;
  mS:string;
  mInd:boolean;
  mFldName:string;
  mFldTypeS:string;
  mFldType:TFieldType;
  mFldSize:longint;
  mIndexS:string;
  mIndName:string;
  mIndFields:string;
  mIndType:TIndexOptions;
  mTable:TTable;
begin
  If oDefName<>'' then begin
    If FileExistsI(oDefPath+oDefName) then begin
      FieldDefs.Clear;
      IndexDefs.Clear;
      AssignFile(mT, oDefPath+oDefName);
      Reset(mT);
      ReadLn (mT,mS);
      mInd := FALSE;
      Repeat
        ReadLn (mT,mS);
        If mS<>'' then begin
          If Pos ('IND ',UpString (mS))=1
            then mInd := TRUE
            else begin
              If Pos (';',mS)>0 then System.Delete (mS,Pos (';',mS),Length (mS));
              If Pos (' ',mS)>0 then begin
                mFldName := RemLeftSpaces (RemRightSpaces (Copy (mS,1,Pos (' ',mS)-1)));
                mFldTypeS := RemLeftSpaces (RemRightSpaces (Copy (mS,Pos (' ',mS)+1,Length (mS))));
                If GetFldType (mFldName,mFldTypeS,mFldType,mFldSize) then FieldDefs.Add(mFldName,mFldType,mFldSize,FALSE);
              end;
            end;
        end;
      until System.EOF (mT) or mInd;
      If mInd then begin
        Repeat
          If mS<>'' then begin
            If Pos (';',mS)>0 then System.Delete (mS,Pos (';',mS),Length (mS));
            If Pos (',',mS)>0 then mS := ReplaceStr (mS, ',', ';');
            If Pos ('IND ',UpString (mS))=1 then begin
              System.Delete (mS,1,4);
              If (Pos ('=',mS)>0) then begin
                mIndexS := mS;
                mS := '';
                If not System.EOF (mT) then ReadLn (mT,mS);
                If GetIndOption (mIndexS,mS,mIndName,mIndFields,mIndType) then IndexDefs.Add (mIndName,mIndFields,mIndType);
              end;
            end;
          end;
          If not System.EOF (mT) then ReadLn (mT,mS);
        until System.EOF (mT);
      end;
      CloseFile (mT);
      If (FieldDefs.Count>0) and (IndexDefs.Count>0) then begin
        mTable := TTable.Create(Self);
        mTable.DatabaseName:= DatabaseName;
        mTable.TableName := TableName;
        mTable.TableType := TableType;
        mTable.FieldDefs.Assign (FieldDefs);
        mTable.IndexDefs.Assign(IndexDefs);
        try
          mTable.CreateTable;
        except end;
        If not mTable.Exists then begin
          try mTable.CreateTable; except end;
        end;
        FreeAndNil (mTable);
      end;
    end else begin
      ShowMsg (190001, oDefPath+oDefName);  { Neexistujuci definicny subor }
    end;
  end;
end;

procedure TNexPxbTable.DelRecs;
var I,J:integer;
begin
  If Active then begin
    J:=RecordCount;
    First;
    For I:=1 to J do Delete;
  end else Open;
end;

procedure TNexPxbTable.SwapIndex;
begin
  oIndexName := IndexName;
end;

procedure TNexPxbTable.RestoreIndex;
begin
  If oIndexName<>IndexName then IndexName := oIndexName;
end;

function TNexPxbTable.ActPos: integer;
var
  CursorProps: CurProps;
  RecordProps: RECProps;
begin
  Result := 0;
  Check(DbiGetCursorProps(Handle, CursorProps));
  UpdateCursorPos;
  Check(DbiGetRecord(Handle, dbiNOLOCK, nil, @RecordProps));
  case CursorProps.iSeqNums of
    0: Result := RecordProps.iPhyRecNum;  { dBASE   }
    1: Result := RecordProps.iSeqNum;     { Paradox }
  end;
end;

function TNexPxbTable.GotoPos(pActPos: integer): boolean;
begin
  Check(DbiSetToRecordNo(Handle,pActPos));
  Result := pActPos=ActPos; 
end;

function TNexPxbTable.FindNearest(const KeyValues: array of const): boolean;
begin
  Inherited FindNearest(KeyValues);
  RESULT:=not EOF;
end;

function TNexPxbTable.GetRecordBuffer: PChar;
begin
  GetRecord(Result,gmCurrent,True);
end;

function TNexPxbTable.GetRecordLen: longint;
begin
  Result:=GetRecordSize;
end;

procedure TNexPxbTable.SetRecordBuffer(pBuffer: PChar);
begin
{ TODO : SetRecordBuffer }
end;

function TNexPxbTable.IsFirstRec: boolean;
begin
  SwapStatus;
  Prior;
  Result := Bof;
  RestoreStatus;
end;

function TNexPxbTable.IsLastRec: boolean;
begin
  SwapStatus;
  Next;
  Result := Eof;
  RestoreStatus;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TNexPxbTable]);
end;

initialization
  Classes.RegisterClass(TNexPxbTable);
finalization
  Classes.UnRegisterClass(TNexPxbTable);
end.
