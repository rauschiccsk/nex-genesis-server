unit DM_SYSTEM;

interface

uses
  IcVariab, IcTypes, BtrTable, IcConv, NexPath, NexText, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ImgList, Registry, DBTables, PxTable, NexPxTable;

type
  TRights=record
    FncCode: word;
    Modify: boolean;
    Insert: boolean;
    Delete: boolean;
    Print: boolean;
  end;

  TdmSYS = class(TDataModule)
    IL_BookList: TImageList;
    btDBLST: TBtrieveTable;
    im_Buttons: TImageList;
    btFMENU: TNexBtrTable;
    btUSRGRP: TNexBtrTable;
    IL_SmallIcons: TImageList;
    btLASTREP: TNexBtrTable;
    btQMENU: TNexBtrTable;
    IL_TreeView: TImageList;
    IL_FncImages: TImageList;
    btPFRONT: TNexBtrTable;
    imLrgIco: TImageList;
    imSmlIco: TImageList;
    btLASTBOOK: TNexBtrTable;
    btUPGLST: TNexBtrTable;
    btUPG: TNexBtrTable;
    btBKUSRG: TNexBtrTable;
    btUSRLST: TNexBtrTable;
    btOPENDOC: TNexBtrTable;
    btPGUSRG: TNexBtrTable;
    btDOCPRN: TNexBtrTable;
    btYEARS: TNexBtrTable;
    btSYSTEM: TNexBtrTable;
    ptDEVICES: TPxTable;
    ptDVCLST: TPxTable;
    btMYCONTO: TNexBtrTable;
    ptDOCERR: TNexPxTable;
    ptDOCLST: TPxTable;
    btWDCDEF: TNexBtrTable;
    btWDCLST: TNexBtrTable;
    btMSGDIS: TNexBtrTable;
    btSNDDEF: TNexBtrTable;
    imBut: TImageList;
    imMnu: TImageList;
    ImageList1: TImageList;
    procedure btDBLSTBeforeOpen(DataSet: TDataSet);
    procedure btUSRGRPAfterOpen(DataSet: TDataSet);
    procedure btUSRLSTAfterOpen(DataSet: TDataSet);
    procedure btYEARSAfterOpen(DataSet: TDataSet);
    procedure ptDEVICESBeforeOpen(DataSet: TDataSet);
    procedure ptDVCLSTBeforeOpen(DataSet: TDataSet);
    procedure ptDOCLSTBeforeOpen(DataSet: TDataSet);
  private
  public
    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenUPG (pUpgNum:word);
  end;

var dmSYS: TdmSYS;

implementation

{$R *.DFM}

procedure TdmSYS.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;
begin
  mTable := (FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName := mTable.DefName;
    pTable.FixedName := mTable.FixedName;
    pTable.TableName := mTable.TableName;
  end;
end;

procedure TdmSYS.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.SysPath;
  pTable.Open;
end;

procedure TdmSYS.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := StrIntZero(pListNum,5);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.StkPath;
  pTable.TableName := pTable.FixedName+pTable.BookNum;
  pTable.Open;
end;

procedure TdmSYS.OpenUPG (pUpgNum:word);
begin
  If btUPG.Active then btUPG.Close;
  btUPG.TableName := btUPG.FixedName+StrIntZero(pUpgNum,5);
  btUPG.Open;
end;

procedure TdmSYS.btDBLSTBeforeOpen(DataSet: TDataSet);
begin
  btDBLST.DataBaseName := gPath.SysPath;
  btDBLST.DEFPath := gPath.DefPath;
  If not btDBLST.Exists then btDBLST.CreateTable;
end;

procedure TdmSYS.btUSRLSTAfterOpen(DataSet: TDataSet);
begin
  If btUSRLST.RecordCount=0 then begin
    gNT.SetSection ('DATABASE');
    btUSRLST.Insert;
    btUSRLST.FieldByName ('LoginName').AsString := 'CONSULTANT';
    btUSRLST.FieldByName ('UserName').AsString := gNT.GetText('NEXUSER.UserName1','Systemovy konzultant');
    btUSRLST.FieldByName ('Language').AsString := gNT.GetText('NEXUSER.Language1',gvSys.Language);
    btUSRLST.FieldByName ('GrpNum').AsInteger := 0;
    btUSRLST.Post;

    btUSRLST.Insert;
    btUSRLST.FieldByName ('LoginName').AsString := 'ADMIN';
    btUSRLST.FieldByName ('UserName').AsString := gNT.GetText('NEXUSER.UserName2','Administrator systemu');
    btUSRLST.FieldByName ('Language').AsString := gNT.GetText('NEXUSER.Language1',gvSys.Language);
    btUSRLST.FieldByName ('GrpNum').AsInteger := 0;
    btUSRLST.Post;

    btUSRLST.Insert;
    btUSRLST.FieldByName ('LoginName').AsString := '';
    btUSRLST.FieldByName ('UserName').AsString := gNT.GetText('NEXUSER.UserName3','Zakladny uzivatel');
    btUSRLST.FieldByName ('Language').AsString := gNT.GetText('NEXUSER.Language1',gvSys.Language);
    btUSRLST.FieldByName ('GrpNum').AsInteger := 1;
    btUSRLST.Post;

    btUSRLST.Insert;
    btUSRLST.FieldByName ('LoginName').AsString := 'SKLAD';
    btUSRLST.FieldByName ('UserName').AsString := gNT.GetText('NEXUSER.UserName4','Skladove hospodarstvo');
    btUSRLST.FieldByName ('Language').AsString := gNT.GetText('NEXUSER.Language1',gvSys.Language);
    btUSRLST.FieldByName ('GrpNum').AsInteger := 2;
    btUSRLST.Post;
  end;
end;

procedure TdmSYS.btUSRGRPAfterOpen(DataSet: TDataSet);
begin
  If btUSRGRP.RecordCount=0 then begin
    gNT.SetSection ('DATABASE');
    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 0;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName1','ADMINISTRATORY');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 1;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName2','CELY SYSTEM');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 2;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName3','Skladové hospodárstvo');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 3;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName3','Zásobovanie skladov');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 4;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName4','Odbyt - predaj tovaru');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 5;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName5','Podvojné úètovníctvo');
    btUSRGRP.Post;

    btUSRGRP.Insert;
    btUSRGRP.FieldByName ('GrpNum').AsInteger := 6;
    btUSRGRP.FieldByName ('GrpName').AsString := gNT.GetText('USRGRP.GrpName6','Manažment podniku');
    btUSRGRP.Post;
  end;
end;

procedure TdmSYS.btYEARSAfterOpen(DataSet: TDataSet);
begin
  If btYEARS.RecordCount=0 then begin
    btYEARS.Insert;
    btYEARS.FieldByName ('Year').AsString := gvSys.ActYear;
    btYEARS.FieldByName ('Path').AsString := gPath.StkPath;
    btYEARS.Post;
  end;
end;

procedure TdmSYS.ptDEVICESBeforeOpen(DataSet: TDataSet);
begin
  ptDEVICES.FieldDefs.Clear;
  ptDEVICES.FieldDefs.Add ('DvcNum',ftInteger,0,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcType',ftString,10,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcName',ftString,50,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcPort',ftString,4,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcBaud',ftString,6,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcData',ftString,1,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcStop',ftString,1,FALSE);
  ptDEVICES.FieldDefs.Add ('DvcParity',ftString,1,FALSE);

  ptDEVICES.IndexDefs.Clear;
  ptDEVICES.IndexDefs.Add ('','DvcNum',[ixPrimary]);
  ptDEVICES.CreateTable;
end;

procedure TdmSYS.ptDVCLSTBeforeOpen(DataSet: TDataSet);
begin
  ptDVCLST.FieldDefs.Clear;
  ptDVCLST.FieldDefs.Add ('DvcType',ftString,10,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcName',ftString,50,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcPorts',ftString,30,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcBaud',ftString,6,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcData',ftString,1,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcStop',ftString,1,FALSE);
  ptDVCLST.FieldDefs.Add ('DvcParity',ftString,1,FALSE);

  ptDVCLST.IndexDefs.Clear;
  ptDVCLST.IndexDefs.Add ('','DvcType',[ixPrimary]);
  ptDVCLST.CreateTable;
end;

procedure TdmSYS.ptDOCLSTBeforeOpen(DataSet: TDataSet);
begin
  ptDOCLST.FieldDefs.Clear;
  ptDOCLST.FieldDefs.Add ('DocNum',ftString,12,FALSE);

  ptDOCLST.IndexDefs.Clear;
  ptDOCLST.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptDOCLST.CreateTable;
end;

end.
