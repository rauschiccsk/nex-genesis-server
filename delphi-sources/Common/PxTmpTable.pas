unit PxTmpTable;

interface

uses
  IcTypes, IcConv, IcFiles, BtrTable, NexPath, NexMsg, IcTools,CntWin,PxTable, NexTmpTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db;

type

  TPxTmpTable = class(TPxTable)
    BT_MAINTABLE: TBtrieveTable;
  private
    oOwner: TComponent;
    oTableName: Str12;
    function GetTmpTableName: Str12;
  public
    constructor Create(pOwner: TComponent); override;
    procedure   LoadItems    (pKeyNum:integer; const pKeyNames,pKeyValues: array of const);
    procedure   LoadItemsM   (pKeyNum:integer; const pEqNames,pEqValues,pKeyNames,pKeyValues: array of const);
    procedure   LoadItemsFilt(pKeyNum:byte;pFilt: TFiltStrArray;pNum:byte);
    procedure   Open; overload;
    procedure   Close; overload;
    procedure   Insert; overload;
    procedure   Edit; overload;
    procedure   Post; overload;
    procedure   Delete; overload;
    procedure   SetKeyNum(pKeyNum:smallint); overload;
  published
    { Published declarations }
  end;

  procedure BtrRecToPxRec(pBtr: TBtrieveTable; pPx : TPxTable);
  procedure PxRecToBtrRec(pPx : TPxTable;      pBtr: TBtrieveTable);

  procedure Register;

var
  gFilt: TFiltStrArray;

implementation

uses DM_SYSTEM;

constructor TPxTmpTable.Create;
begin
  inherited Create (pOwner);
//  AutoCreate := TRUE;
  oOwner := pOwner;
end;

function TPxTmpTable.GetTmpTableName: Str12;
var mTableName: Str12;  mCnt:byte;
    mNotExists: boolean;
begin
  mCnt := 0;
  Repeat
    Inc (mCnt);
    mTableName := oTableName+'.$'+StrIntZero(mCnt,2);
    mNotExists := not FileExistsI (DatabaseName+mTableName);
  until mNotExists or (mCnt=99);
  If mNotExists then begin
    Result := mTableName;
  end
  else begin
    ShowMsg (10,'');
    Result := oTableName+'.$$$';
  end;
end;

procedure TPxTmpTable.LoadItems;
 function  EqualFields (const pKeyNames,pKeyValues: array of const): boolean;
 var mNoEqual:boolean; I:byte;
     mKeyName:string; mKeyValue:string;
 begin
   mNoEqual := FALSE;      {Btrtable}
   For I:=0 to High(pKeyNames) do begin
     mKeyName := string(pKeyNames[I].VVariant);
//   mKeyValue := string(pKeyValues[I].VVariant);
//   EK 12-10-2000
     with pKeyValues[i] do begin
       case VType of
         vtInteger:    mKeyValue:= IntToStr(VInteger);
//         vtBoolean:    mKeyValue:= BoolChars[VBoolean];
         vtChar:       mKeyValue:= VChar;
         vtExtended:   mKeyValue:= FloatToStr(VExtended^);
         vtString:     mKeyValue:= VString^;
         vtPChar:      mKeyValue:= VPChar;
         vtObject:     mKeyValue:= VObject.ClassName;
         vtClass:      mKeyValue:= VClass.ClassName;
         vtAnsiString: mKeyValue:= string(VAnsiString);
         vtCurrency:   mKeyValue:= CurrToStr(VCurrency^);
         vtVariant:    mKeyValue:= string(VVariant^);
         vtInt64:      mKeyValue:= IntToStr(VInt64^);
       end;
     end;

     If BT_MAINTABLE.FieldByName(mKeyName).AsString<>mKeyValue then mNoEqual := TRUE;
   end;
   Result := not mNoEqual;
 end;

begin
  BT_MAINTABLE.SetKeyNum (pKeyNum);
  BT_MAINTABLE.FindNearest (pKeyValues);
  While not (BT_MAINTABLE.Eof) and EqualFields(pKeyNames,pKeyValues) do begin
    inherited Insert;
    BtrRecToPxRec(BT_MainTable,Self);
    FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
    inherited Post;
    BT_MAINTABLE.Next;
  end;
end;

procedure TPxTmpTable.LoadItemsM;
 function  EqualFields (const pKeyNames,pKeyValues: array of const): boolean;
 var mNoEqual:boolean; I:byte;
     mKeyName:string; mKeyValue:string;
 begin
   mNoEqual := FALSE;      {Btrtable}
   For I:=0 to High(pKeyNames) do begin
     mKeyName := string(pKeyNames[I].VVariant);
//     mKeyValue := string(pKeyValues[I].VVariant);
//   EK 12-10-2000
     with pKeyValues[i] do begin
       case VType of
         vtInteger:    mKeyValue:= IntToStr(VInteger);
//         vtBoolean:    mKeyValue:= BoolChars[VBoolean];
         vtChar:       mKeyValue:= VChar;
         vtExtended:   mKeyValue:= FloatToStr(VExtended^);
         vtString:     mKeyValue:= VString^;
         vtPChar:      mKeyValue:= VPChar;
         vtObject:     mKeyValue:= VObject.ClassName;
         vtClass:      mKeyValue:= VClass.ClassName;
         vtAnsiString: mKeyValue:= string(VAnsiString);
         vtCurrency:   mKeyValue:= CurrToStr(VCurrency^);
         vtVariant:    mKeyValue:= string(VVariant^);
         vtInt64:      mKeyValue:= IntToStr(VInt64^);
       end;
     end;

     If BT_MAINTABLE.FieldByName(mKeyName).AsString<>mKeyValue then mNoEqual := TRUE;
   end;
   Result := not mNoEqual;
 end;

begin
  BT_MAINTABLE.SetKeyNum (pKeyNum);
  BT_MAINTABLE.FindNearest (pKeyValues);
  While not (BT_MAINTABLE.Eof) and EqualFields(pKeyNames,pKeyValues) do begin
    If EqualFields(pEqNames,pEqValues) then begin
      inherited Insert;
      BtrRecToPxRec(BT_MainTable,Self);
      FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
      inherited Post;
    end;
    BT_MAINTABLE.Next;
  end;
end;

procedure TPxTmpTable.LoadItemsFilt;
var mSetInd : boolean;
begin
  F_CntWinF:=TF_CntWinF.Create(Self);
  CalcFilterCond(pFilt,pNum,BT_MAINTABLE.oFilterCond,BT_MAINTABLE.oFiltCondFldS);
  mSetInd:=BT_MAINTABLE.SetFiltInd(pKeyNum);
  BT_MAINTABLE.First;
  F_CntWinF.Execute(BT_MAINTABLE.RecordCount,'Filter');
  If mSetInd then BT_MAINTABLE.FirstFiltInd;
  While not BT_MAINTABLE.EOF and (not mSetInd or(mSetInd and BT_MAINTABLE.IsInFiltInd)) do begin
    F_CntWinF.RefCnt;
    If BT_MAINTABLE.CheckFiltRec then begin
      inherited Insert;
      BtrRecToPxRec(BT_MainTable,Self);
      FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
      inherited Post;
    end;
    BT_MAINTABLE.Next;
  end;
  FreeAndNil(F_CntWinF);
end;

procedure TPxTmpTable.Open;
var mPos: byte;
begin
  mPos := Pos('.',TableName);
  If mPos>0
    then oTableName := copy(TableName,1,mPos-1)
    else oTableName := TableName;
  DataBaseName := gPath.SubPrivPath;
//  DEFPath := GetDefPath;
//  TableName := GetTmpTableName;
//  CreateTable;
  inherited Open;

  BT_MAINTABLE := TBtrieveTable.Create (Self);
  If oOwner.Name='dmSYS'  then BT_MAINTABLE.DataBaseName := gPath.SysPath;
  If oOwner.Name='dmDLS'  then BT_MAINTABLE.DataBaseName := gPath.DlsPath;
  If oOwner.Name='dmPDP'  then BT_MAINTABLE.DataBaseName := gPath.PdpPath;
  If oOwner.Name='dmTPDP' then BT_MAINTABLE.DataBaseName := gPath.PdpPath;
  If oOwner.Name='dmLDG'  then BT_MAINTABLE.DataBaseName := gPath.LdgPath;
  If oOwner.Name='dmSTK'  then BT_MAINTABLE.DataBaseName := gPath.StkPath;
  BT_MAINTABLE.DEFPath := gPath.DefPath;
  BT_MAINTABLE.TableName := oTableName;
  BT_MAINTABLE.AutoCreate := TRUE;
  BT_MAINTABLE.DefName := oTableName+'.BDF';
  BT_MAINTABLE.Open;
end;

procedure TPxTmpTable.Close;
begin
  inherited Close;
  Deletetable;

  BT_MAINTABLE.Close;
  BT_MAINTABLE.Free;
end;

procedure TPxTmpTable.Insert;
begin
  inherited Insert;
  BT_MAINTABLE.Insert;
end;

procedure TPxTmpTable.Edit;
begin
  inherited Edit;
  BT_MAINTABLE.GotoPos (FieldByName('ActPos').AsInteger);
  BT_MAINTABLE.Edit;
end;

procedure TPxTmpTable.Post;
begin
  PxRecToBtrRec(Self,BT_MainTable);
  BT_MAINTABLE.Post;
  FieldByName ('ActPos').AsInteger := BT_MAINTABLE.ActPos;
  inherited Post;
end;

procedure TPxTmpTable.Delete;
begin
  BT_MAINTABLE.GotoPos (FieldByName('ActPos').AsInteger);
  BT_MAINTABLE.Delete;
  inherited Delete;
end;

procedure TPxTmpTable.SetKeyNum(pKeyNum:smallint);
begin
  IndexName:=IndexDefs[pKeyNum].Name;
//  BT_MAINTABLE.SetKeyNum (pKeyNum);
end;

procedure PxRecToBtrRec;
var I: integer;
begin
  For I:= 0 to pPx.FieldDefs.Count-1 do begin
    If FindMyFldName(pBTR,pPx.FieldDefs[i].Name)>=0 then begin
      case pPx.FieldDefs[i].DataType of
        ftFloat   : pBtr.FieldbyName(pPx.FieldDefs[i].Name).Asfloat   :=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsFloat;
        ftString  : pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsString  :=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsString;
        ftDate    : pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime:=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftTime    : pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime:=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftDateTime: pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsdateTime:=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftInteger : pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsInteger :=pPx.FieldbyName(pPx.FieldDefs[i].Name).AsInteger;
{        ftCurrency,ftFmtMemo,ftAutoInc,ftSmallint,ftBCD,ftMemo,
        ftBlob,ftBytes,ftGraphic,ftParadoxOle,ftBoolean: NIC}
      end
    end;
  end;
end;

procedure BtrRecToPxRec;
var I: integer;
begin
  For I:= 0 to pPx.FieldDefs.Count-1 do begin
    If pPx.FieldDefs[i].Name='ItmNum' then pPx.FieldbyName('ItmNum').AsInteger := pPx.RecordCount+1;
    If FindMyFldName(pBTR,pPx.FieldDefs[i].Name)>=0 then begin
      case pPx.FieldDefs[i].DataType of
        ftFloat   : pPx.FieldbyName(pPx.FieldDefs[i].Name).Asfloat   :=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsFloat;
        ftString  : pPx.FieldbyName(pPx.FieldDefs[i].Name).AsString  :=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsString;
        ftDate    : pPx.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime:=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftTime    : pPx.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime:=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftDateTime: pPx.FieldbyName(pPx.FieldDefs[i].Name).AsdateTime:=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsDateTime;
        ftInteger : pPx.FieldbyName(pPx.FieldDefs[i].Name).AsInteger :=pBtr.FieldbyName(pPx.FieldDefs[i].Name).AsInteger;
{        ftCurrency,ftFmtMemo,ftAutoInc,ftSmallint,ftBCD,ftMemo,
        ftBlob,ftBytes,ftGraphic,ftParadoxOle,ftBoolean: NIC}
      end
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TPxTmpTable]);
end;

end.
