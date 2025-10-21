unit BaseTools;

interface

  uses
    xpComp, BaseUtils,
    DateUtils, SysUtils, Forms, TlHelp32, ShellApi, Windows, Classes, Controls,
    ExtCtrls, StdCtrls, ActnList, Dialogs, Graphics, DB,
    DBTables, TUtil32D, BDE, BDEConst;

  const
    zCR     = Chr (13);
    zLF     = Chr (10);

  type
// TIcSession
  TIcSession = class(TSession)
    public
      procedure ModifyConfigParam(pPath, pParam: string);
  end;

// TBDEUtil
  TBDEUtil = class
    CbInfo: TUVerifyCallback;
    TUProps: CURProps;
    hDb: hDBIDb;
    vhTSes: hTUSes;
    constructor Create (pPath:string);
    destructor Destroy; override;
    function GetTCursorProps(szTable: String): Boolean;
    procedure RegisterCallBack;
    procedure UnRegisterCallBack;
  end;

// TSinglePxTable
  TSinglePxTable = class(TTable)
  private
    oDefPath: string;
    oDefName: string;

    function  GetActive:boolean;
    procedure SetActive (Value:boolean);
    function  GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
    function  GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
    function  ReadDef:boolean;
  public
    constructor Create(pOwner: TComponent); override;
    procedure Open; overload;
    procedure Close; overload;

    function  StructVerify:boolean;
    procedure CreateTableInDef;
    procedure InternalCreateTable;
    procedure DelRecs;
  published
    property Active:boolean read GetActive write SetActive;
    property DefPath: string read oDefPath write oDefPath;
    property DefName: string read oDefName write oDefName;
  end;




  function StrInt (pNum:integer;pWidth:byte):ShortString;
           //Prekonvertuje celé èíslo na string
  procedure Wait (pTime:word);
            //Èaká zadaný poèet milisekúnd
  function ValDoub (pStr:ShortString):double;
           //Prekonvertuje string na reálne èíslo
  function StrDoub (pNum:double;pWidth,pDeci:byte):ShortString;
           //Prekonvertujé reálne èíslo na string
  function UpChar (pChar:Char): Char;
           // Uskutocni zmenu maleho pisma na velke podla gvSys.Language
  function UpString (pString:string): string;
           // Uskutocni zmenu retazca na velke pismena podla gvSys.Language

  function LineElement      (const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.

  function GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
           //Funcia vráti maximálnu šírku textu v pS v pixeloch
  function GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
           //Funkcia vráti šírku textu pri zadanom nastavení písmien
  function GetTextHeight(pF:TFont; pForm: TWinControl):longint;
           //Funkcia vráti výšku textu pri zadanom nastavení písmien

  function  GetFirstProcessID (pFileName:string):longint;


implementation

// ****************************************************************
// ********************       TIcSession     **********************
// ****************************************************************

procedure TIcSession.ModifyConfigParam(pPath, pParam: string);
var mParams: TStringList;
begin
  mParams := TStringList.Create;
  try
    mParams.Add(pParam);
    ModifyConfigParams(pPath, '', mParams);
  finally
    mParams.Free;
  end;
end;

// ****************************************************************
// ********************    TIcSession end    **********************
// ****************************************************************


// ****************************************************************
// ********************    TBDEUtil begin    **********************
// ****************************************************************

function GenProgressCallBack(ecbType: CBType; Data: LongInt; pcbInfo: Pointer): CBRType; stdcall;
var CBInfo: TUVerifyCallBack;
begin
  CBInfo := TUVerifyCallBack(pcbInfo^);
  if ecbType = cbGENPROGRESS then
    case CBInfo.Process of
     TUVerifyHeader: begin
//       If uPBHeaderInd<>nil then uPBHeaderInd.Position := CBInfo.percentdone;
     end;
     TUVerifyIndex: begin
//       If uPBIndexesInd<>nil then uPBIndexesInd.Position := CBInfo.percentdone;
     end;
     TUVerifyData: begin
//       If uPBDataInd<>nil then uPBDataInd.Position := CBInfo.percentdone;
     end;
     TURebuild: begin
//       If uPBRebuildInd<>nil then uPBRebuildInd.Position := CBInfo.percentdone;
     end;
    end;

  Result := cbrUSEDEF;
end;

constructor TBDEUtil.Create (pPath:string);
begin
//  LoadTUDLL (pPath);
  TUDInit(vhtSes);
end;

destructor TBDEUtil.Destroy;
begin
  TUDExit(vhtSes);
//  UnloadTUDLL;
  inherited Destroy;
end;

function TBDEUtil.GetTCursorProps(szTable: String): Boolean;
begin
  if TUDFillCURProps(vHtSes, PChar(szTable), TUProps) = DBIERR_NONE
    then Result := True
    else Result := False;
end;

procedure TBDEUtil.RegisterCallback;
begin
 DbiRegisterCallBack(nil, cbGENPROGRESS, 0, sizeof(TUVerifyCallBack), @CbInfo, GenProgressCallback);
end;

procedure TBDEUtil.UnRegisterCallback;
begin
  DbiRegisterCallBack(nil, cbGENPROGRESS, 0, sizeof(TUVerifyCallBack), @CbInfo, nil);
end;

// ****************************************************************
// ********************    TBDEUtil end      **********************
// ****************************************************************

function  StrInt (pNum:longint;pWidth:byte):ShortString;
var mStr:string;
begin
  Str (pNum:pWidth,mStr);
  Result := mStr;
end;

procedure Wait (pTime:word);
var mWaitTime:TDateTime;
begin
  mWaitTime := IncMilliSecond (Now, pTime);
  While Now<mWaitTime do begin
    Application.ProcessMessages;
  end;
end;

function  ValDoub (pStr:ShortString):double;
var mNum:double;  mErr,mPos:integer;
begin
  mPos := Pos(',',pStr);
  If mPos>0 then begin
    Delete (pStr,mPos,1);
    Insert ('.',pStr,mPos);
  end;
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;

function  StrDoub (pNum:double;pWidth,pDeci:byte):ShortString;
var mStr:string;
begin
  Str (pNum:pWidth:pDeci,mStr);
  Result := mStr;
end;

function  UpChar (pChar:Char): Char;
begin
  Result := pChar;
  If Ord(pChar) in [224..255]
    then Result := Chr(Ord(pChar)-32)
    else Result := UpCase (pChar);
end;

function  UpString (pString:string): string;
var I:longint;
begin
  Result := pString;
  For I:=1 to Length(pString) do
    Result[I] := UpChar(pString[I]);
end;

function  LineElement(const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.
var mStr: string;  I, mNum:integer;
begin
  mStr := '';  mNum := 0; I := 1;
  While (I<=Length(pStr)) and (pStr[I]<>#0) and (mNum<=pNum) do begin
    If (pStr[i] = pSeparator) then begin
      Inc(mNum)
    end else begin
      If (mNum = pNum) then mStr := mStr + pStr[i];
    end;
    Inc(I);
  end;
  Result := mStr;
end;

function  GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
var
  I:longint;
  mMax:longint;
  mC:TPaintBox;
begin
  mMax := 0;
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
//  mC.Name := 'PaintBox';
  mC.Canvas.Font := pS.Font;
  if pS.Lines.Count>0 then begin
    For I:=0 to pS.Lines.Count-1 do begin
      If mC.Canvas.TextWidth(pS.Lines[I])>mMax then mMax := mC.Canvas.TextWidth (pS.Lines[I]);
    end;
  end;
  mC.Free;
  Result := mMax;
end;

function  GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mW:longint;
begin
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
//  mC.Name := 'PaintBox';
  mC.Canvas.Font := pF;
  mW := mC.Canvas.TextWidth (pS);
  mC.Free;
  Result := mW;
end;

function  GetTextHeight(pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mH:longint;
begin
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
//  mC.Name := 'APaintBox';
  mC.Canvas.Font := pF;
  mH := mC.Canvas.TextHeight ('TextHeight');
  mC.Free;
  Result := mH;
end;


function  GetFirstProcessID (pFileName:string):longint;
var mContinueLoop: LongBool; mHandle: THandle; mProcessEntry32: TProcessEntry32;
    mSelfFile:string; mSelfProcessID:longint; mEnd:boolean;
begin
  Result := 0;
  mHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := SizeOf(mProcessEntry32);
  mContinueLoop := Process32First(mHandle, mProcessEntry32);
  mSelfProcessID := GetCurrentProcessId;
  mSelfFile := ExtractFileName(ParamStr(0));
  mEnd := FALSE;
  while (Integer(mContinueLoop) <> 0) and not mEnd do begin
    If mProcessEntry32.th32ProcessID<>0 then begin
      If UpString(pFileName)=UpString(mProcessEntry32.szExeFile) then begin
        If (UpString(mProcessEntry32.szExeFile)<>UpString(mSelfFile)) and (mProcessEntry32.th32ProcessID<>mSelfProcessID) then begin
          Result := mProcessEntry32.th32ProcessID;
          mEnd := TRUE;
        end;
      end;
    end;
    mContinueLoop := Process32Next(mHandle, mProcessEntry32);
  end;
  CloseHandle(mHandle);
end;

// TSinglePxTable

function  TSinglePxTable.GetActive:boolean;
begin
  Result := inherited Active;
end;

procedure TSinglePxTable.SetActive (Value:boolean);
begin
  If not inherited Active and Value then begin
    Open;
  end else begin
    If inherited Active and not Value then Close;
  end;
end;

function  TSinglePxTable.GetFldType (pFldName,pFldTypeS:string;var pFldType:TFieldType;var pFldSize:longint):boolean;
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
//    If not Result then ShowMsg (190002,DatabaseName+TableName+'  '+pFldName+pFldTypeS); //Nesprávný typ pola
  end;
end;

function  TSinglePxTable.GetIndOption (pIndex,pIndTypeS:string;var pIndName,pIndFields:string;var pIndType:TIndexOptions):boolean;
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
//    If not Result then ShowMsg (190003,DatabaseName+TableName+'  '+pIndex+' - '+pIndTypeS); // Chybne definovany index
  end;
end;

constructor TSinglePxTable.Create;
begin
  inherited Create (pOwner);
end;

procedure TSinglePxTable.InternalCreateTable;
var mCnt:longint;
begin
  CreateTableInDef;
end;

procedure TSinglePxTable.Open;
begin
  If Active then Close;
  If not Exists then InternalCreateTable;
  inherited Open;
end;

procedure TSinglePxTable.Close;
begin
  inherited Close;
end;

function  TSinglePxTable.ReadDef:boolean;
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
begin
  If oDefName<>'' then begin
    If FileExists(oDefPath+oDefName) then begin
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
    end;
  end;
end;

function  TSinglePxTable.StructVerify:boolean;
var  mTable:TTable; I:longint; mIndexName:string; mIndex:TIndexDef;
begin
  Result := FALSE;
  ReadDef;
  If (FieldDefs.Count>0) and (IndexDefs.Count>0) then begin
    mTable := TTable.Create(Self);
    mTable.DatabaseName:= DatabaseName;
    mTable.TableName := TableName;
    mTable.TableType := TableType;
    If mTable.Exists then begin
      try
        mTable.FieldDefs.Update;
        mTable.IndexDefs.Update;
      except end;
      If (FieldDefs.Count=mTable.FieldDefs.Count) and (IndexDefs.Count=mTable.IndexDefs.Count) then begin
        For I:=0 to FieldDefs.Count-1 do begin
          Result := (FieldDefs.Items[I].Name=mTable.FieldDefs.Items[I].Name);
          If Result then Result := (FieldDefs.Items[I].Size=mTable.FieldDefs.Items[I].Size);
          If Result then Result := (FieldDefs.Items[I].DataType=mTable.FieldDefs.Items[I].DataType);
          If not Result then Break;
        end;
        If Result then begin
          For I:=0 to IndexDefs.Count-1 do begin
            mIndex := nil;
            try
              mIndex := mTable.IndexDefs.FindIndexForFields(IndexDefs.Items[I].Fields);
            except end;
            If mIndex<>nil then begin
              mIndexName := IndexDefs.Items[I].Name;
              If ixPrimary in IndexDefs.Items[I].Options then mIndexName := '';
              Result := mIndexName=mIndex.Name;
              If Result then Result := (IndexDefs.Items[I].Fields=mIndex.Fields);
              If Result then Result := (IndexDefs.Items[I].Options=mIndex.Options-[ixUnique]);
            end else Result := FALSE;
            If not Result then Break;
          end;
        end;
      end;
    end;
    FreeAndNil (mTable);
  end;
end;

procedure TSinglePxTable.CreateTableInDef;
var  mTable:TTable;
begin
  If oDefName<>'' then begin
    If FileExists(oDefPath+oDefName) then begin
      ReadDef;
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
//      ShowMsg (190001, oDefPath+oDefName);  { Neexistujuci definicny subor }
    end;
  end;
end;

procedure TSinglePxTable.DelRecs;
var I,J:integer;
begin
  If Active then begin
    J:=RecordCount;
    First;
    For I:=1 to J do Delete;
  end else Open;
end;

end.
