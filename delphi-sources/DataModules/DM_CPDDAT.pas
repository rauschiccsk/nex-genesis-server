unit DM_CPDDAT;

interface

uses
  IcConv, IcTypes, IcVariab, BtrTable, NexBtrTable, NexTmpTable, PxTmpTable,
  NexPath, NexText,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  LinkBtrTable, DBTables, DbfTable, PxTable, NexPxTable;

type
  TdmCPD = class(TDataModule)
    btMABCAT: TNexBtrTable;
    btMABLST: TNexBtrTable;
    btMAB: TNexBtrTable;
    btEQBLST: TNexBtrTable;
    btEQBCAT: TNexBtrTable;
    btEQB: TNexBtrTable;
    btEQHOLE: TNexBtrTable;
    btEQNOTI: TNexBtrTable;
    htEQB: TNexBtrTable;
    btEQREPD: TNexBtrTable;
    ptEQREPD: TPxTable;
    btEQGRP: TNexBtrTable;
    ptEQBMOD: TPxTable;
    ptEQBDIS: TPxTable;
    ptEQBDelGrp: TPxTable;
    ptEQBFILT: TPxTable;
    ptGRPEQL: TPxTable;
    ptNOTICE: TPxTable;
    btMABDEL: TNexBtrTable;
    ptMAB: TNexPxTable;
    btMABMOD: TNexBtrTable;
    btITBLST: TNexBtrTable;
    btITBCAT: TNexBtrTable;
    btITB: TNexBtrTable;
    btITBMOD: TNexBtrTable;
    btITHOLE: TNexBtrTable;
    btITNOTI: TNexBtrTable;
    btITGRP: TNexBtrTable;
    ptITB: TNexPxTable;
    btITBDEL: TNexBtrTable;
    ptITBMOD: TNexPxTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure btMABLSTAfterOpen(DataSet: TDataSet);
    procedure ptEQREPDBeforeOpen(DataSet: TDataSet);
    procedure ptEQBMODBeforeOpen(DataSet: TDataSet);
    procedure ptEQBDISBeforeOpen(DataSet: TDataSet);
    procedure ptEQBDelGrpBeforeOpen(DataSet: TDataSet);
    procedure ptEQBFILTBeforeOpen(DataSet: TDataSet);
    procedure ptGRPEQLBeforeOpen(DataSet: TDataSet);
    procedure ptNOTICEBeforeOpen(DataSet: TDataSet);
    procedure btITBLSTAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    oAbtMabNum: longint;
    oAbtEqbNum: longint;
    oAbtItbNum: longint;
  public
    { Public declarations }
    procedure OpenMAB (pBookNum:longint);
    procedure OpenEQB (pBookNum:longint);
    procedure OpenITB (pBookNum:longint);

    function GetActMabNum: longint;
    function GetActEqbNum: longint;
    function GetActItbNum: longint;

    procedure ITB_To_TMP; // Ulozi zaznam z btITB do ptITB
  end;

var
  dmCPD: TdmCPD;

implementation

{$R *.DFM}

procedure TdmCPD.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.CpdPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

procedure TdmCPD.OpenMAB(pBookNum: longint);
begin
  oAbtMabNum := pBookNum;
  If btMAB.Active then btMAB.Close;
  btMAB.TableName := btMAB.FixedName+StrIntZero(pBookNum,5);
  btMAB.Open;
end;

procedure TdmCPD.OpenEQB(pBookNum: longint);
begin
  oAbtEqbNum := pBookNum;
  If btEQB.Active then btEQB.Close;
  btEQB.TableName := btEQB.FixedName+StrIntZero(pBookNum,5);
  btEQB.Open;
end;

procedure TdmCPD.OpenITB(pBookNum: longint);
begin
  oAbtItbNum := pBookNum;
  If btITB.Active then btITB.Close;
  btITB.TableName := btITB.FixedName+StrIntZero(pBookNum,5);
  btITB.Open;
end;

//*****************************************************************************

procedure TdmCPD.btMABLSTAfterOpen(DataSet: TDataSet);
begin
  If btMABLST.RecordCount=0 then begin
     gNT.SetSection ('CPD-DATABASE');
     // 0 Vsetky materialy
     btMABLST.Insert;
     btMABLST.FieldByName ('BookNum').AsInteger := 0;
     btMABLST.FieldByName ('BookName').AsString := gNT.GetText('btMABLST.DefaultBookName_0','Všetky materiály');
     btMABLST.FieldByName ('BegNum').AsInteger := 0;
     btMABLST.Post;
     // 1 Nakupene suroviny
     btMABLST.Insert;
     btMABLST.FieldByName ('BookNum').AsInteger := 1;
     btMABLST.FieldByName ('BookName').AsString := gNT.GetText('btMABLST.DefaultBookName_1','Nakúpené suroviny');
     btMABLST.FieldByName ('BegNum').AsInteger := 0;
     btMABLST.Post;
     // 1 Nakupene polovýrobky
     btMABLST.Insert;
     btMABLST.FieldByName ('BookNum').AsInteger := 2;
     btMABLST.FieldByName ('BookName').AsString := gNT.GetText('btMABLST.DefaultBookName_2','Nakúpené polovýrobky');
     btMABLST.FieldByName ('BegNum').AsInteger := 0;
     btMABLST.Post;
     // 1 Nakupene výrobky
     btMABLST.Insert;
     btMABLST.FieldByName ('BookNum').AsInteger := 3;
     btMABLST.FieldByName ('BookName').AsString := gNT.GetText('btMABLST.DefaultBookName_1','Nakúpené výrobky');
     btMABLST.FieldByName ('BegNum').AsInteger := 0;
     btMABLST.Post;
  end;
end;

//********************************** Cisla otvorenych knih *********************************
function TdmCPD.GetActMabNum: longint;
begin
  Result := oAbtMabNum;
end;

function TdmCPD.GetActEqbNum: longint;
begin
  Result := oAbtEqbNum;
end;

function TdmCPD.GetActItbNum: longint;
begin
  Result := oAbtItbNum;
end;

procedure TdmCPD.ptEQREPDBeforeOpen(DataSet: TDataSet);
begin
  ptEQRepD.FieldDefs.Clear;
  ptEQRepD.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptEQRepD.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptEQRepD.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptEQRepD.FieldDefs.Add ('BegTime',ftTime,0,FALSE);
  ptEQRepD.FieldDefs.Add ('EndDate',ftDate,0,FALSE);
  ptEQRepD.FieldDefs.Add ('EndTime',ftTime,0,FALSE);
  ptEQRepD.FieldDefs.Add ('RepVal',ftFloat,0,FALSE);
  ptEQRepD.FieldDefs.Add ('Describe',ftString,30,FALSE);

  ptEQRepD.IndexDefs.Clear;
  ptEQRepD.IndexDefs.Add ('','EqCode;SerNum',[ixPrimary]);
  ptEQRepD.CreateTable;
end;

procedure TdmCPD.ptEQBMODBeforeOpen(DataSet: TDataSet);
begin
  ptEQBMod.FieldDefs.Clear;
  ptEQBMod.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefEqName',ftString,30,FALSE);
  ptEQBMod.FieldDefs.Add ('AftEqName',ftString,30,FALSE);
  ptEQBMod.FieldDefs.Add ('BefEqGrp',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftEqGrp',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefProdNum',ftString,30,FALSE);
  ptEQBMod.FieldDefs.Add ('AftProdNum',ftString,30,FALSE);
  ptEQBMod.FieldDefs.Add ('BefIdCode',ftString,15,FALSE);
  ptEQBMod.FieldDefs.Add ('AftIdCode',ftString,15,FALSE);
  ptEQBMod.FieldDefs.Add ('BefWriNum',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftWriNum',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefPartNum',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftPartNum',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefBegDate',ftDate,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftBegDate',ftDate,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefWorkMth',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftWorkMth',ftInteger,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefRepHour',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftRepHour',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefProVal',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftProVal',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefRepVal',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('AftRepVal',ftFloat,0,FALSE);
  ptEQBMod.FieldDefs.Add ('BefStatus',ftString,1,FALSE);
  ptEQBMod.FieldDefs.Add ('AftStatus',ftString,1,FALSE);

  ptEQBMod.IndexDefs.Clear;
  ptEQBMod.IndexDefs.Add ('','EqCode;SerNum',[ixPrimary]);
  ptEQBMod.CreateTable;
end;

procedure TdmCPD.ptEQBDISBeforeOpen(DataSet: TDataSet);
begin
  ptEQBDis.FieldDefs.Clear;
  ptEQBDis.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptEQBDis.FieldDefs.Add ('EqName',ftString,30,FALSE);
  ptEQBDis.FieldDefs.Add ('EqGrp',ftInteger,0,FALSE);
  ptEQBDis.FieldDefs.Add ('ProdNum',ftString,30,FALSE);
  ptEQBDis.FieldDefs.Add ('IdCode',ftString,15,FALSE);
  ptEQBDis.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptEQBDis.FieldDefs.Add ('PartNum',ftInteger,0,FALSE);
  ptEQBDis.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptEQBDis.FieldDefs.Add ('WorkMth',ftInteger,0,FALSE);
  ptEQBDis.FieldDefs.Add ('WorkHour',ftFloat,0,FALSE);
  ptEQBDis.FieldDefs.Add ('RepHour',ftFloat,0,FALSE);
  ptEQBDis.FieldDefs.Add ('ProVal',ftFloat,0,FALSE);
  ptEQBDis.FieldDefs.Add ('RepVal',ftFloat,0,FALSE);
  ptEQBDis.FieldDefs.Add ('AmtVal',ftFloat,0,FALSE);

  ptEQBDis.IndexDefs.Clear;
  ptEQBDis.IndexDefs.Add ('','EqCode',[ixPrimary]);
  ptEQBDis.CreateTable;
end;

procedure TdmCPD.ptEQBDelGrpBeforeOpen(DataSet: TDataSet);
begin
  ptEQBDelGrp.FieldDefs.Clear;
  ptEQBDelGrp.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('EqName',ftString,30,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('EqGrp',ftInteger,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('ProdNum',ftString,30,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('IdCode',ftString,15,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('PartNum',ftInteger,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('WorkMth',ftInteger,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('WorkHour',ftFloat,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('RepHour',ftFloat,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('ProVal',ftFloat,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('RepVal',ftFloat,0,FALSE);
  ptEQBDelGrp.FieldDefs.Add ('AmtVal',ftFloat,0,FALSE);

  ptEQBDelGrp.IndexDefs.Clear;
  ptEQBDelGrp.IndexDefs.Add ('','EqCode',[ixPrimary]);
  ptEQBDelGrp.CreateTable;
end;

procedure TdmCPD.ptEQBFILTBeforeOpen(DataSet: TDataSet);
begin
  ptEQBFILT.FieldDefs.Clear;
  ptEQBFILT.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('EqName',ftString,30,FALSE);
  ptEQBFILT.FieldDefs.Add ('EqGrp',ftInteger,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('ProdNum',ftString,30,FALSE);
  ptEQBFILT.FieldDefs.Add ('IdCode',ftString,15,FALSE);
  ptEQBFILT.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('PartNum',ftInteger,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('WorkMth',ftInteger,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('WorkHour',ftFloat,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('RepHour',ftFloat,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('ProVal',ftFloat,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('RepVal',ftFloat,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('AmtVal',ftFloat,0,FALSE);
  ptEQBFILT.FieldDefs.Add ('Status',ftString,1,FALSE);
  ptEQBFILT.IndexDefs.Clear;
  ptEQBFILT.IndexDefs.Add ('','EqCode',[ixPrimary]);
  ptEQBFILT.CreateTable;
end;

procedure TdmCPD.ptGRPEQLBeforeOpen(DataSet: TDataSet);
begin
  ptGrpEql.FieldDefs.Clear;
  ptGrpEql.FieldDefs.Add ('EqCode',ftInteger,0,FALSE);
  ptGrpEql.FieldDefs.Add ('EqName',ftString,30,FALSE);
  ptGrpEql.FieldDefs.Add ('EqGrp',ftInteger,0,FALSE);
  ptGrpEql.FieldDefs.Add ('ProdNum',ftString,30,FALSE);
  ptGrpEql.FieldDefs.Add ('IdCode',ftString,15,FALSE);
  ptGrpEql.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptGrpEql.FieldDefs.Add ('PartNum',ftInteger,0,FALSE);
  ptGrpEql.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptGrpEql.FieldDefs.Add ('WorkMth',ftInteger,0,FALSE);
  ptGrpEql.FieldDefs.Add ('WorkHour',ftFloat,0,FALSE);
  ptGrpEql.FieldDefs.Add ('RepHour',ftFloat,0,FALSE);
  ptGrpEql.FieldDefs.Add ('ProVal',ftFloat,0,FALSE);
  ptGrpEql.FieldDefs.Add ('RepVal',ftFloat,0,FALSE);
  ptGrpEql.FieldDefs.Add ('AmtVal',ftFloat,0,FALSE);
  ptGrpEql.FieldDefs.Add ('Status',ftString,1,FALSE);

  ptGrpEql.IndexDefs.Clear;
  ptGrpEql.IndexDefs.Add ('','EqCode',[ixPrimary]);
  ptGrpEql.CreateTable;
end;

procedure TdmCPD.ptNOTICEBeforeOpen(DataSet: TDataSet);
begin
  ptNOTICE.FieldDefs.Clear;
  ptNOTICE.FieldDefs.Add ('LinNum',ftInteger,0,FALSE);
  ptNOTICE.FieldDefs.Add ('Notice',ftString,80,FALSE);

  ptNOTICE.IndexDefs.Clear;
  ptNOTICE.IndexDefs.Add ('','LinNum',[ixPrimary]);
  ptNOTICE.CreateTable;
end;

procedure TdmCPD.btITBLSTAfterOpen(DataSet: TDataSet);
begin
  If dmCPD.btITBLST.RecordCount=0 then begin
    dmCPD.btITBLST.Insert;
    dmCPD.btITBLST.FieldByName ('BookNum').AsInteger := 1;
    dmCPD.btITBLST.FieldByName ('BookName').AsString := gNT.GetText('btITBLST.DefaultBookName_0','Vyrobne nastroje');;
    dmCPD.btITBLST.Post;
  end;
end;

procedure TdmCPD.ITB_To_TMP; // Ulozi zaznam z btITB do ptITB
begin
  ptITB.FieldByName ('ItCode').AsInteger := btITB.FieldByName ('ItCode').AsInteger;
  ptITB.FieldByName ('ItName').AsString := btITB.FieldByName ('ItName').AsString;
  ptITB.FieldByName ('GrpNum').AsInteger := btITB.FieldByName ('GrpNum').AsInteger;
  ptITB.FieldByName ('ProdNum').AsString := btITB.FieldByName ('ProdNum').AsString;
  ptITB.FieldByName ('IdCode').AsString := btITB.FieldByName ('IdCode').AsString;
  ptITB.FieldByName ('WriNum').AsInteger := btITB.FieldByName ('WriNum').AsInteger;
  ptITB.FieldByName ('PartNum').AsInteger := btITB.FieldByName ('PartNum').AsInteger;
  If dmCPD.btITB.FieldByName ('BegDate').AsDateTime<>0 then ptITB.FieldByName ('BegDate').AsDateTime := btITB.FieldByName ('BegDate').AsDateTime;
  ptITB.FieldByName ('WorkMth').AsInteger := btITB.FieldByName ('WorkMth').AsInteger;
  ptITB.FieldByName ('WorkHour').AsFloat := btITB.FieldByName ('WorkHour').AsFloat;
  ptITB.FieldByName ('RepHour').AsFloat := btITB.FieldByName ('RepHour').AsFloat;
  ptITB.FieldByName ('ProVal').AsFloat := btITB.FieldByName ('ProVal').AsFloat;
  ptITB.FieldByName ('RepVal').AsFloat := btITB.FieldByName ('RepVal').AsFloat;
  ptITB.FieldByName ('AmtVal').AsFloat := btITB.FieldByName ('AmtVal').AsFloat;
end;

end.
