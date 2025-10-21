unit NexBtrTable;

interface

uses
  IcFiles, BtrTable, NexPath, IcTypes, IcConv, IcVariab, BtrLst, BtrTools,
  NexMsg, NexError, 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db;

type
  PFieldDesign = ^TFieldDesign;
  TFieldDesign = record
    Visible: boolean;
    DisplayLabel: Str80;
    DisplayWidth: word;
    Alignment: TAlignment;
  end;

  TNexBtrTable = class(TBtrieveTable)
  private
    oInsEnab: boolean;
    oGroupName: Str5;
    oMoreOpen: boolean; // TRUE ak databazovy subor uz bol otvoreny
    oFieldsDesign: TList;
    oBookNum: Str5; // Cislo knihy ak databaza je kniha nejakych dokladov
    oListNum: longint; // Cislo knihy (zoznamu) ak databaza je kniha nejakych dokladov
    procedure SwapFieldsDesign;
    procedure RestoreFieldsDesign;
    procedure MyAfterInsert (DataSet: TDataSet);
  public
    constructor Create(pOwner: TComponent); override;
    procedure   Open; overload;
    procedure   Open(pBookNum:Str5); overload;
    procedure   Open(pListNum:word); overload;
    procedure   Close; overload;
    function    DeleteTable:boolean; override;
    procedure   SetDefDatabaseName;
    function    GetDefDatabaseName:String;
    procedure   LoadFields (pSrcTable:TBtrieveTable);

    //03.04.2019 TIBI Pri príkaze Next a Prior sa robí Refresh
    procedure   Next;
    procedure   Prior;

    property BookNum:Str5 read oBookNum write oBookNum;
    property ListNum:longint read oListNum write oListNum;
    property InsEnab: boolean write oInsEnab;
  published
  end;

procedure Register;

implementation

uses
  DM_SYSTEM;

constructor TNexBtrTable.Create;
begin
  inherited Create (pOwner);
  inherited AfterInsert := MyAfterInsert;
  If pOwner<>NIL then oGroupName := pOwner.Name else oGroupName := '';
  AutoCreate := TRUE;
  oMoreOpen := False;
  oInsEnab := TRUE;
  oBookNum := '';
end;

procedure TNexBtrTable.Open;
var mFileName:Str12; mExist,mCreate:boolean;
begin
  mExist := TRUE;
  If Active then Close;
  SetDefDatabaseName;      
  If TableNameExt=''
    then mFileName := TableName+'.BTR'
    else mFileName := TableName+'.'+TableNameExt;
  If not FileExistsI (DataBaseName+mFileName) then begin
    If TableNameExt='TMP' then mCreate:=True else begin
      dmSYS.btDBLST.Open;
      dmSYS.btDBLST.SetKeyNum (6);
      If not dmSYS.btDBLST.FindKey ([DataBaseName,mFileName]) then begin
        mCreate := TRUE; // Ak databazovy subor este predtym nebo vytvoreny potom bez dotazu
        dmSYS.btDBLST.Insert;
        dmSYS.btDBLST.FieldByName ('DBPath').AsString := UpString (DataBaseName);
        dmSYS.btDBLST.FieldByName ('DBName').AsString := UpString (mFileName);
        dmSYS.btDBLST.FieldByName ('CrtName').AsString := gvSys.LoginName;
        dmSYS.btDBLST.FieldByName ('CrtDate').AsDateTime := Date;
        dmSYS.btDBLST.FieldByName ('CrtTime').AsDateTime := Time;
        dmSYS.btDBLST.FieldByName ('CrtNum').AsInteger := 1;
        dmSYS.btDBLST.Post;
      end
      else begin
        mCreate := AskYes (acSysYourCanCreateTable,DataBaseName+mFileName);
        dmSYS.btDBLST.Edit;
        dmSYS.btDBLST.FieldByName ('CrtNum').AsInteger := dmSYS.btDBLST.FieldByName ('CrtNum').AsInteger+1;
        dmSYS.btDBLST.Post;
      end;
      dmSYS.btDBLST.Close;
    end;
    If mCreate
      then CreateTable
      else mExist := FALSE;
  end;
  If mExist and (TableNameExt='TMP') then begin
    Modify:=False;
    CrtDat:=False;
  end;
  If mExist then inherited Open;
  If oMoreOpen then RestoreFieldsDesign;
end;

procedure TNexBtrTable.Open(pBookNum:Str5);
begin
  if gvSys.TestMode and (pBookNum='')then ShowMsg(ecSysNotBookDefined,TableName);
  if (pBookNum='')then WriteToLogFile(DataBaseName+'BTRERR.LOG',TableName+'.'+TableNameExt+'|OPEN.EmptyBook|0');
  BookNum := pBookNum;
  TableName := FixedName+pBookNum;
  Open;
end;

procedure TNexBtrTable.Open(pListNum:word);
begin
  ListNum := pListNum;
  BookNum := StrInt(pListNum,0);
  TableName := FixedName+StrIntZero(pListNum,5);
  Open;
end;

procedure TNexBtrTable.Close;
begin
  SwapFieldsDesign;
  oMoreOpen := True;
  inherited Close;
  If TableNameExt='TMP' then DeleteTable;
end;

procedure TNexBtrTable.SwapFieldsDesign;
var I:word; mFieldDesign: PFieldDesign;
begin
{
  If oFieldsDesign=Nil then oFieldsDesign := TList.Create;
  For I:=0 to FieldCount-1 do begin
    New (mFieldDesign);
    mFieldDesign^.Visible := Fields[I].Visible;
    mFieldDesign^.DisplayLabel := Fields[I].DisplayLabel;
    mFieldDesign^.DisplayWidth := Fields[I].DisplayWidth;
    mFieldDesign^.Alignment := Fields[I].Alignment;
    oFieldsDesign.Add (mFieldDesign);
  end;
}
end;

procedure TNexBtrTable.RestoreFieldsDesign;
var I:word; mFieldDesign: PFieldDesign;
begin
{
  For I:=0 to FieldCount-1 do begin
    mFieldDesign := oFieldsDesign.Items[I];
    Fields[I].Visible := mFieldDesign^.Visible;
    Fields[I].DisplayLabel := mFieldDesign^.DisplayLabel;
    Fields[I].DisplayWidth := mFieldDesign^.DisplayWidth;
    Fields[I].Alignment := mFieldDesign^.Alignment;
    Dispose (mFieldDesign);
  end;
}
end;

procedure TNexBtrTable.MyAfterInsert (DataSet: TDataSet);
begin
  If not oInsEnab then Cancel;
end;

procedure TNexBtrTable.SetDefDatabaseName;
begin
  If DataBaseName='' then DataBaseName := gBtr.BtrPath(FixedName);
  If DataBaseName='' then begin
    WriteToLogFile('DB_NAME.LOG',FixedName+'|DbNameEmpty|');
    If (UpString(copy(Name,1,2))='BT') or (UpString(copy(Name,1,2))='TT') or (UpString(copy(Name,1,2))='HT') then begin
      If oGroupName='dmSYS'  then DataBaseName := gPath.SysPath;
      If oGroupName='dmDLS'  then DataBaseName := gPath.DlsPath;
      If oGroupName='dmPDP'  then DataBaseName := gPath.PdpPath;
      If oGroupName='dmLDG'  then DataBaseName := gPath.LdgPath;
      If oGroupName='dmSTK'  then DataBaseName := gPath.StkPath;
      If oGroupName='dmCAB'  then DataBaseName := gPath.CabPath;
      If oGroupName='dmCPD'  then DataBaseName := gPath.CpdPath;
      If oGroupName='dmHTL'  then DataBaseName := gPath.HtlPath;
    end else begin
      // DataBaseName := gPath.PrivPath;
    end;
    If DataBaseName='' then ShowMessage('Empty DatabaseName for '+FixedName);
  end;
  DefPath := gPath.DefPath;
  If DefName='' then DefName := FixedName+'.BDF';
  If TableName='' then TableName := FixedName;
end;

function  TNexBtrTable.DeleteTable:boolean;
begin
  SetDefDatabaseName;
  Result := inherited DeleteTable;
end;

procedure  TNexBtrTable.LoadFields (pSrcTable:TBtrieveTable);
var I:integer;
begin
  For I:= 0 to pSrcTable.FieldDefs.Count-1 do begin
    If FindMyFldName(Self,pSrcTable.FieldDefs[I].Name)>=0 then begin
      case pSrcTable.FieldDefs[i].DataType of
        ftFloat   : FieldbyName(pSrcTable.FieldDefs[I].Name).Asfloat := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsFloat;
        ftString  : FieldbyName(pSrcTable.FieldDefs[I].Name).AsString := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsString;
        ftDate    : FieldbyName(pSrcTable.FieldDefs[I].Name).AsDateTime := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsDateTime;
        ftTime    : FieldbyName(pSrcTable.FieldDefs[I].Name).AsDateTime := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsDateTime;
        ftDateTime: FieldbyName(pSrcTable.FieldDefs[I].Name).AsdateTime := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsDateTime;
        ftInteger : FieldbyName(pSrcTable.FieldDefs[I].Name).AsInteger := pSrcTable.FieldbyName(pSrcTable.FieldDefs[I].Name).AsInteger;
      end
    end;
  end;
end;

procedure TNexBtrTable.Next;
begin
  Refresh;
  inherited Next;
end;

procedure TNexBtrTable.Prior;
begin
  Refresh;
  inherited Prior;
end;

function TNexBtrTable.GetDefDatabaseName: String;
begin
  Result := gBtr.BtrPath(FixedName);
end;

procedure Register;
begin
  RegisterComponents('IcDataAccess', [TNexBtrTable]);
end;

initialization
  Classes.RegisterClass(TNexBtrTable);
finalization
  Classes.UnRegisterClass(TNexBtrTable);

end.
