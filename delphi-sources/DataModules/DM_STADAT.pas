unit DM_STADAT;

interface

uses 
  IcTypes, IcConv, IcTools, IcDate, NexIni, NexPath,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, PxTable, DbfTable, BtrTable, NexBtrTable, NexPxTable;

type
  TdmSTA = class(TDataModule)
    dtGSCAT: TDbfTable;
    dtMGCAT: TDbfTable;
    dtGSD: TDbfTable;
    dtSADC: TDbfTable;
    dtSAWC: TDbfTable;
    dtSAMC: TDbfTable;
    dtSAYC: TDbfTable;
    dtSADP: TDbfTable;
    dtSAWP: TDbfTable;
    dtSAMP: TDbfTable;
    dtSAYP: TDbfTable;
    ptSAMGSUM: TPxTable;
    dtSAMG: TDbfTable;
    ptSACASSUM: TPxTable;
    dtGSM: TDbfTable;
    ptSAGSSUM: TPxTable;
    dtMSALST: TDbfTable;
    dtMSA: TDbfTable;
    ptDAYSTM: TNexPxTable;
    ptCUSGSL: TNexPxTable;
    ptMGEVAL: TNexPxTable;
    ptFGEVAL: TNexPxTable;
    btCSTSALGS: TNexBtrTable;
    btCSTSALMG: TNexBtrTable;
    ptCSTSALMG: TNexPxTable;
    ptCSTTOPPA: TNexPxTable;
    btCSTPACAX: TNexBtrTable;
    btCSTPACMN: TNexBtrTable;
    ptREWDLR: TNexPxTable;
    btCSTSTMGS: TNexBtrTable;
    ptCSTSALFG: TNexPxTable;
    btCSTSALFG: TNexBtrTable;
    procedure dtGSCATBeforeOpen(DataSet: TDataSet);
    procedure dtMGCATBeforeOpen(DataSet: TDataSet);
    procedure dtGSDBeforeOpen(DataSet: TDataSet);
    procedure dtSADCBeforeOpen(DataSet: TDataSet);
    procedure dtSAWCBeforeOpen(DataSet: TDataSet);
    procedure dtSAYCBeforeOpen(DataSet: TDataSet);
    procedure dtSAMCBeforeOpen(DataSet: TDataSet);
    procedure dtSADPBeforeOpen(DataSet: TDataSet);
    procedure dtSAMPBeforeOpen(DataSet: TDataSet);
    procedure dtSAWPBeforeOpen(DataSet: TDataSet);
    procedure dtSAYPBeforeOpen(DataSet: TDataSet);
    procedure ptSAMGSUMBeforeOpen(DataSet: TDataSet);
    procedure dtSAMGBeforeOpen(DataSet: TDataSet);
    procedure ptSACASSUMBeforeOpen(DataSet: TDataSet);
    procedure dtSAMCBeforePost(DataSet: TDataSet);
    procedure dtSAYCBeforePost(DataSet: TDataSet);
    procedure dtSADCBeforePost(DataSet: TDataSet);
    procedure dtSADPBeforePost(DataSet: TDataSet);
    procedure dtSAMPBeforePost(DataSet: TDataSet);
    procedure dtSAYPBeforePost(DataSet: TDataSet);
    procedure dtSAWCBeforePost(DataSet: TDataSet);
    procedure dtSAWPBeforePost(DataSet: TDataSet);
    procedure dtGSMBeforeOpen(DataSet: TDataSet);
    procedure ptSAGSSUMBeforeOpen(DataSet: TDataSet);
    procedure dtMSALSTBeforeOpen(DataSet: TDataSet);
    procedure dtMSABeforeOpen(DataSet: TDataSet);
  private
    oActYear: Str4;  // Aktualny rok na ktory su otvorene databaze
    oActMsaNum: integer; // Aktualny model predaja
  public
    procedure OpenGSD (pDate:TDateTime);  // Predane tovarove polozky vesekych pokladni podla datumu
    procedure OpenGSM (pYear:Str4);  // predane tovarove polozky vsetkych pokladni kumulativne od zaciatku roka

    procedure OpenSADC (pYear:Str4);
    procedure OpenSAWC (pYear:Str4);
    procedure OpenSAMC (pYear:Str4);
    procedure OpenSAYC (pYear:Str4);
    procedure OpenSADP (pYear:Str4);
    procedure OpenSAWP (pYear:Str4);
    procedure OpenSAMP (pYear:Str4);
    procedure OpenSAYP (pYear:Str4);

    procedure OpenMSA (pSerNum:integer);  // Model maloochodn0ho predaja

    function GetActYear:Str4; // Aktualny rok na ktory su otvorene databaze
    function GetActMsaNum:integer; // Aktualny model predaja
  end;

var
  dmSTA: TdmSTA;

implementation

{$R *.DFM}

procedure TdmSTA.OpenGSD (pDate:TDateTime);
var mYear:Str4;  mMth:Str2; mTableName:Str12;
begin
  mYear := YearS (pDate);
  mMth := Mth(pDate);
  oActYear := mYear;
  mTableName := 'GSD'+mMth+mYear;
  If not dtGSD.Active or (dtGSD.TableName<>mTableName) then begin
    If dtGSD.Active then dtGSD.Close;
    dtGSD.DataBaseName := gIni.GetStaPath;
    dtGSD.TableName := mTableName;
    dtGSD.Open;
  end;
end;

procedure TdmSTA.OpenGSM (pYear:Str4);
begin
  oActYear := pYear;
  dtGSM.DataBaseName := gIni.GetStaPath;
  dtGSM.TableName := 'GSM'+pYear;
  dtGSM.Open;
end;

procedure TdmSTA.OpenSADC (pYear:Str4);
begin
  oActYear := pYear;
  dtSADC.TableName := 'SADC'+pYear;
  dtSADC.Open;
end;

procedure TdmSTA.OpenSAWC (pYear:Str4);
begin
  oActYear := pYear;
  dtSAWC.TableName := 'SAWC'+pYear;
  dtSAWC.Open;
end;

procedure TdmSTA.OpenSAMC (pYear:Str4);
begin
  oActYear := pYear;
  dtSAMC.TableName := 'SAMC'+pYear;
  dtSAMC.Open;
end;

procedure TdmSTA.OpenSAYC (pYear:Str4);
begin
  oActYear := pYear;
  dtSAYC.TableName := 'SAYC'+pYear;
  dtSAYC.Open;
end;

procedure TdmSTA.OpenSADP (pYear:Str4);
begin
  oActYear := pYear;
  dtSADP.TableName := 'SADP'+pYear;
  dtSADP.Open;
end;

procedure TdmSTA.OpenSAWP (pYear:Str4);
begin
  oActYear := pYear;
  dtSAWP.TableName := 'SAWP'+pYear;
  dtSAWP.Open;
end;

procedure TdmSTA.OpenSAMP (pYear:Str4);
begin
  oActYear := pYear;
  dtSAMP.TableName := 'SAMP'+pYear;
  dtSAMP.Open;
end;

procedure TdmSTA.OpenSAYP (pYear:Str4);
begin
  oActYear := pYear;
  dtSAYP.TableName := 'SAYP'+pYear;
  dtSAYP.Open;
end;

procedure TdmSTA.OpenMSA (pSerNum:integer);  // Model maloochodn0ho predaja
begin
  If pSerNum=0 then pSerNum :=1;
  oActMsaNum := pSerNum;
  If dtMSA.Active then dtMSA.Close;
  dtMSA.TableName := 'MSA'+StrIntZero(pSerNum,5);
  dtMSA.Open;
end;

function TdmSTA.GetActYear:Str4; // Aktualny rok na ktory su otvorene databaze
begin
  Result := oActYear;
end;

function TdmSTA.GetActMsaNum:integer; // Aktualny model predaja
begin
  Result := oActMsaNum;
end;

procedure TdmSTA.dtGSCATBeforeOpen(DataSet: TDataSet);
begin
  dtGSCAT.DatabaseName := gIni.GetStaPath;
  If not dtGSCAT.Exists then begin
    dtGSCAT.FieldDefs.Clear;
    dtGSCAT.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);
    dtGSCAT.FieldDefs.Add ('GsName',ftString,30,FALSE);
    dtGSCAT.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
    dtGSCAT.FieldDefs.Add ('BarCode',ftString,15,FALSE);
    dtGSCAT.FieldDefs.Add ('StCode',ftString,15,FALSE);
    dtGSCAT.FieldDefs.Add ('VatPrc',ftFloat,0,FALSE);
    dtGSCAT.FieldDefs.Add ('MsCode',ftInteger,0,FALSE);
    dtGSCAT.FieldDefs.Add ('MsName',ftString,10,FALSE);

    dtGSCAT.IndexDefs.Clear;
    dtGSCAT.IndexDefs.Add ('GsCode','GsCode',[ixPrimary]);
    dtGSCAT.CreateTable;
  end;
end;

procedure TdmSTA.dtMGCATBeforeOpen(DataSet: TDataSet);
begin
  dtMGCAT.DatabaseName := gIni.GetStaPath;
  If not dtMGCAT.Exists then begin
    dtMGCAT.FieldDefs.Clear;
    dtMGCAT.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
    dtMGCAT.FieldDefs.Add ('MgName',ftString,30,FALSE);

    dtMGCAT.IndexDefs.Clear;
    dtMGCAT.IndexDefs.Add ('MgCode','MgCode',[ixPrimary]);
    dtMGCAT.CreateTable;
  end;
end;

procedure TdmSTA.dtGSDBeforeOpen(DataSet: TDataSet);
var I:byte;
begin
  dtGSD.DatabaseName := gIni.GetStaPath;
  If not dtGSD.Exists then begin
    dtGSD.FieldDefs.Clear;
    dtGSD.FieldDefs.Add ('SalDate',ftDateTime,0,FALSE);
    dtGSD.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);
    dtGSD.FieldDefs.Add ('VatPrc',ftFloat,0,FALSE);
    dtGSD.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);
    dtGSD.FieldDefs.Add ('CValue',ftFloat,0,FALSE);
    dtGSD.FieldDefs.Add ('BValue',ftFloat,0,FALSE);
    dtGSD.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);

    dtGSD.IndexDefs.Clear;
    dtGSD.IndexDefs.Add ('','SalDate;GsCode',[ixPrimary]);
    dtGSD.IndexDefs.Add ('GsCode','GsCode',[]);
    dtGSD.IndexDefs.Add ('MgCode','MgCode',[]);
    dtGSD.CreateTable;
  end;
end;

procedure TdmSTA.dtGSMBeforeOpen(DataSet: TDataSet);
var I:word;
begin
  dtGSM.DatabaseName := gIni.GetStaPath;
  If not dtGSM.Exists then begin
    dtGSM.FieldDefs.Clear;
    dtGSM.FieldDefs.Add ('MthNum',ftInteger,0,FALSE);
    dtGSM.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);
    dtGSM.FieldDefs.Add ('GsName',ftString,30,FALSE);
    dtGSM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
    dtGSM.FieldDefs.Add ('VatPrc',ftFloat,0,FALSE);
    dtGSM.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);
    dtGSM.FieldDefs.Add ('CValue',ftFloat,0,FALSE);
    dtGSM.FieldDefs.Add ('ProfPrc',ftFloat,0,FALSE);
    dtGSM.FieldDefs.Add ('ProfVal',ftFloat,0,FALSE);
    dtGSM.FieldDefs.Add ('BValue',ftFloat,0,FALSE);

    dtGSM.IndexDefs.Clear;
    dtGSM.IndexDefs.Add ('','MthNum`GsCode',[ixPrimary]);
    dtGSM.CreateTable;
  end;
end;

procedure TdmSTA.dtSADCBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSADC.DatabaseName := gIni.GetStaPath;
  If not dtSADC.Exists then begin
    dtSADC.FieldDefs.Clear;
    dtSADC.FieldDefs.Add ('Day',ftDate,0,FALSE);
    For I:=0 to 15 do
      dtSADC.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 15 do
      dtSADC.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 15 do
      dtSADC.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSADC.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSADC.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSADC.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSADC.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSADC.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSADC.IndexDefs.Clear;
    dtSADC.IndexDefs.Add ('Day','Day',[ixPrimary]);
    dtSADC.CreateTable;
  end;
end;

procedure TdmSTA.dtSAWCBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAWC.DatabaseName := gIni.GetStaPath;
  If not dtSAWC.Exists then begin
    dtSAWC.FieldDefs.Clear;
    dtSAWC.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('Week',ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAWC.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 15 do
      dtSAWC.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 15 do
      dtSAWC.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAWC.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAWC.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAWC.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSAWC.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAWC.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAWC.IndexDefs.Clear;
    dtSAWC.IndexDefs.Add ('','Year;Week',[ixPrimary]);
    dtSAWC.CreateTable;
  end;
end;

procedure TdmSTA.dtSAMCBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAMC.DatabaseName := gIni.GetStaPath;
  If not dtSAMC.Exists then begin
    dtSAMC.FieldDefs.Clear;
    dtSAMC.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('Mounth',ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAMC.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 15 do
      dtSAMC.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 15 do
      dtSAMC.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAMC.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAMC.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAMC.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSAMC.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAMC.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAMC.IndexDefs.Clear;
    dtSAMC.IndexDefs.Add ('','Year;Mounth',[ixPrimary]);
    dtSAMC.CreateTable;
  end;
end;

procedure TdmSTA.dtSAYCBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAYC.DatabaseName := gIni.GetStaPath;
  If not dtSAYC.Exists then begin
    dtSAYC.FieldDefs.Clear;
    dtSAYC.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAYC.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 15 do
      dtSAYC.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 15 do
      dtSAYC.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAYC.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAYC.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 15 do
      dtSAYC.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSAYC.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAYC.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAYC.IndexDefs.Clear;
    dtSAYC.IndexDefs.Add ('','Year',[ixPrimary]);
    dtSAYC.CreateTable;
  end;
end;

procedure TdmSTA.dtSADPBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSADP.DatabaseName := gIni.GetStaPath;
  If not dtSADP.Exists then begin
    dtSADP.FieldDefs.Clear;
    dtSADP.FieldDefs.Add ('Day',ftDate,0,FALSE);
    For I:=0 to 24 do
      dtSADP.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 24 do
      dtSADP.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 24 do
      dtSADP.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 24 do
      dtSADP.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 24 do
      dtSADP.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 24 do
      dtSADP.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSADP.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSADP.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSADP.IndexDefs.Clear;
    dtSADP.IndexDefs.Add ('Day','Day',[ixPrimary]);
    dtSADP.CreateTable;
  end;
end;

procedure TdmSTA.dtSAWPBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAWP.DatabaseName := gIni.GetStaPath;
  If not dtSAWP.Exists then begin
    dtSAWP.FieldDefs.Clear;
    dtSAWP.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('Week',ftInteger,0,FALSE);
    For I:=0 to 7 do
      dtSAWP.FieldDefs.Add ('CValue'+StrIntZero(I,1),ftInteger,0,FALSE);
    For I:=1 to 7 do
      dtSAWP.FieldDefs.Add ('ProfPrc'+StrIntZero(I,1),ftFloat,0,FALSE);
    For I:=0 to 7 do
      dtSAWP.FieldDefs.Add ('ProfVal'+StrIntZero(I,1),ftInteger,0,FALSE);
    For I:=0 to 7 do
      dtSAWP.FieldDefs.Add ('AValue'+StrIntZero(I,1),ftInteger,0,FALSE);
    For I:=0 to 7 do
      dtSAWP.FieldDefs.Add ('BValue'+StrIntZero(I,1),ftInteger,0,FALSE);
    For I:=0 to 7 do
      dtSAWP.FieldDefs.Add ('DocCnt'+StrIntZero(I,1),ftInteger,0,FALSE);

    dtSAWP.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAWP.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAWP.IndexDefs.Clear;
    dtSAWP.IndexDefs.Add ('','Year;Week',[ixPrimary]);
    dtSAWP.CreateTable;
  end;
end;

procedure TdmSTA.dtSAMPBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAMP.DatabaseName := gIni.GetStaPath;
  If not dtSAMP.Exists then begin
    dtSAMP.FieldDefs.Clear;
    dtSAMP.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('Mounth',ftInteger,0,FALSE);
    For I:=0 to 31 do
      dtSAMP.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 31 do
      dtSAMP.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 31 do
      dtSAMP.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 31 do
      dtSAMP.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 31 do
      dtSAMP.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 31 do
      dtSAMP.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSAMP.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAMP.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAMP.IndexDefs.Clear;
    dtSAMP.IndexDefs.Add ('','Year;Mounth',[ixPrimary]);
    dtSAMP.CreateTable;
  end;
end;

procedure TdmSTA.dtSAYPBeforeOpen(DataSet: TDataSet);
var I: byte;
begin
  dtSAYP.DatabaseName := gIni.GetStaPath;
  If not dtSAYP.Exists then begin
    dtSAYP.FieldDefs.Clear;
    dtSAYP.FieldDefs.Add ('Year',ftInteger,0,FALSE);
    For I:=0 to 12 do
      dtSAYP.FieldDefs.Add ('CValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=1 to 12 do
      dtSAYP.FieldDefs.Add ('ProfPrc'+StrIntZero(I,2),ftFloat,0,FALSE);
    For I:=0 to 12 do
      dtSAYP.FieldDefs.Add ('ProfVal'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 12 do
      dtSAYP.FieldDefs.Add ('AValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 12 do
      dtSAYP.FieldDefs.Add ('BValue'+StrIntZero(I,2),ftInteger,0,FALSE);
    For I:=0 to 12 do
      dtSAYP.FieldDefs.Add ('DocCnt'+StrIntZero(I,2),ftInteger,0,FALSE);

    dtSAYP.FieldDefs.Add ('AvgCValue',ftInteger,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgProfPrc',ftFloat,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgProfVal',ftInteger,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgAValue',ftInteger,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgBValue',ftInteger,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgDocCnt',ftInteger,0,FALSE);
    dtSAYP.FieldDefs.Add ('AvgKoef',ftInteger,0,FALSE);

    dtSAYP.IndexDefs.Clear;
    dtSAYP.IndexDefs.Add ('Year','Year',[ixPrimary]);
    dtSAYP.CreateTable;
  end;
end;

procedure TdmSTA.ptSAMGSUMBeforeOpen(DataSet: TDataSet);
begin
  ptSAMGSUM.FieldDefs.Clear;
  ptSAMGSUM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);  // Kod tovarovej skupiny
  ptSAMGSUM.FieldDefs.Add ('MgName',ftString,30,FALSE);  // Nazov tovarovej skupiny
  ptSAMGSUM.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);  // Mnozstvo vsetkych predanych tovarov z tejto tovarovej skupiny
  ptSAMGSUM.FieldDefs.Add ('CValue',ftFloat,0,FALSE);  // Hodnota predaja v NC bez DPH
  ptSAMGSUM.FieldDefs.Add ('ProfPrc',ftFloat,0,FALSE);  // Zisk v %
  ptSAMGSUM.FieldDefs.Add ('ProfVal',ftFloat,0,FALSE);  // Zisk v SK
  ptSAMGSUM.FieldDefs.Add ('AvgProf',ftFloat,0,FALSE); // Priemerny zisk v SK na jeden vyrobok Profval/GsQnt
  ptSAMGSUM.FieldDefs.Add ('AValue',ftFloat,0,FALSE);  // Hodnota predaja v PC bez DPH
  ptSAMGSUM.FieldDefs.Add ('BValue',ftFloat,0,FALSE); // Hodnota predaja v PC s DPH
  ptSAMGSUM.FieldDefs.Add ('BValSerNum',ftInteger,0,FALSE);  // Poradove cislo podla BValSepPrc
  ptSAMGSUM.FieldDefs.Add ('BValSepPrc',ftFloat,0,FALSE);  // Percentualna cast hodnoty tovarovej skupiny z celkoveho predaja
  ptSAMGSUM.FieldDefs.Add ('BValCumPrc',ftFloat,0,FALSE); // Percentualna cast hodnoty tovarovej skupiny - kumulativne
  ptSAMGSUM.FieldDefs.Add ('ProfSerNum',ftInteger,0,FALSE);  // Poradove cislo podla ProfSepPrc
  ptSAMGSUM.FieldDefs.Add ('ProfSepPrc',ftFloat,0,FALSE);  // Percentualna cast zisku zo zisku z celkoveho predaja
  ptSAMGSUM.FieldDefs.Add ('ProfCumPrc',ftFloat,0,FALSE); // Percentualna cast zisku - kumulativne
  ptSAMGSUM.FieldDefs.Add ('QntSerNum',ftInteger,0,FALSE);  // Poradove cislo podla QntSepPrc
  ptSAMGSUM.FieldDefs.Add ('QntSepPrc',ftFloat,0,FALSE);  // Percentualna cast podielu z celkoveho predaneho mnozstva
  ptSAMGSUM.FieldDefs.Add ('QntCumPrc',ftFloat,0,FALSE); // Percentualna cast kumulativneho podielu mnozstva
  ptSAMGSUM.FieldDefs.Add ('MgGsCnt',ftInteger,0,FALSE); // Pocet poloziek v tovarovej skupine
  ptSAMGSUM.FieldDefs.Add ('AvgGsQnt',ftFloat,0,FALSE); // Priemerne mnozstvo
  ptSAMGSUM.FieldDefs.Add ('AvgCValue',ftFloat,0,FALSE); // Priemerna nakupna cena

  ptSAMGSUM.IndexDefs.Clear;
  ptSAMGSUM.IndexDefs.Add ('','MgCode',[ixPrimary]);
  ptSAMGSUM.IndexDefs.Add ('ProfPrc','ProfPrc',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('AvgProf','AvgProf',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('BValue','BValue',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('BValSerNum','BValSerNum',[]);
  ptSAMGSUM.IndexDefs.Add ('BValSepPrc','BValSepPrc',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('ProfVal','ProfVal',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('ProfSerNum','ProfSerNum',[]);
  ptSAMGSUM.IndexDefs.Add ('ProfSepPrc','ProfSepPrc',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('GsQnt','GsQnt',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('CValue','CValue',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('QntSerNum','QntSerNum',[]);
  ptSAMGSUM.IndexDefs.Add ('QntSepPrc','QntSepPrc',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('MgGsCnt','MgGsCnt',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('AvgGsQnt','AvgGsQnt',[ixDescending]);
  ptSAMGSUM.IndexDefs.Add ('AvgCValue','AvgCValue',[ixDescending]);
  ptSAMGSUM.CreateTable;
end;

procedure TdmSTA.dtSAMGBeforeOpen(DataSet: TDataSet);
begin
  dtSAMG.DatabaseName := gIni.GetStaPath;
  If not dtSAMG.Exists then begin
    dtSAMG.FieldDefs.Clear;
    dtSAMG.FieldDefs.Add ('SalDate',ftDate,0,FALSE);
    dtSAMG.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
    dtSAMG.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);
    dtSAMG.FieldDefs.Add ('CValue',ftFloat,0,FALSE);
    dtSAMG.FieldDefs.Add ('AValue',ftFloat,0,FALSE);
    dtSAMG.FieldDefs.Add ('BValue',ftFloat,0,FALSE);

    dtSAMG.IndexDefs.Clear;
    dtSAMG.IndexDefs.Add ('','SalDate;MgCode',[ixPrimary]);
    dtSAMG.CreateTable;
  end;
end;

procedure TdmSTA.ptSACASSUMBeforeOpen(DataSet: TDataSet);
begin
  ptSACASSUM.FieldDefs.Clear;
  ptSACASSUM.FieldDefs.Add ('CasNum',ftInteger,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('CValue',ftFloat,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('ProfPrc',ftFloat,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('ProfVal',ftFloat,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('AValue',ftFloat,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('BValue',ftFloat,0,FALSE);
  ptSACASSUM.FieldDefs.Add ('DocCnt',ftInteger,0,FALSE);

  ptSACASSUM.IndexDefs.Clear;
  ptSACASSUM.IndexDefs.Add ('','CasNum',[ixPrimary]);
  ptSACASSUM.CreateTable;
end;

procedure TdmSTA.dtSADCBeforePost(DataSet: TDataSet);
var mCasNum:Str2; I:byte;
begin
  dtSADC.FieldByName ('CValue00').AsInteger := 0;
  dtSADC.FieldByName ('ProfVal00').AsInteger := 0;
  dtSADC.FieldByName ('AValue00').AsInteger := 0;
  dtSADC.FieldByName ('BValue00').AsInteger := 0;
  dtSADC.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 15 do begin
    mCasNum := StrIntZero (I,2);
    If dtSADC.FieldByName('CValue'+mCasNum).AsInteger>0
      then dtSADC.FieldByName ('ProfPrc'+mCasNum).AsFloat := Rd2(((dtSADC.FieldByName ('AValue'+mCasNum).AsInteger/dtSADC.FieldByName('CValue'+mCasNum).AsInteger)-1)*100);
    dtSADC.FieldByName ('ProfVal'+mCasNum).AsInteger := dtSADC.FieldByName ('AValue'+mCasNum).AsInteger-dtSADC.FieldByName ('CValue'+mCasNum).AsInteger;

    dtSADC.FieldByName ('CValue00').AsInteger := dtSADC.FieldByName ('CValue00').AsInteger+dmSTA.dtSADC.FieldByName ('CValue'+mCasNum).AsInteger;
    dtSADC.FieldByName ('ProfVal00').AsInteger := dtSADC.FieldByName ('ProfVal00').AsInteger+dmSTA.dtSADC.FieldByName ('ProfVal'+mCasNum).AsInteger;
    dtSADC.FieldByName ('AValue00').AsInteger := dtSADC.FieldByName ('AValue00').AsInteger+dmSTA.dtSADC.FieldByName ('AValue'+mCasNum).AsInteger;
    dtSADC.FieldByName ('BValue00').AsInteger := dtSADC.FieldByName ('BValue00').AsInteger+dmSTA.dtSADC.FieldByName ('BValue'+mCasNum).AsInteger;
    dtSADC.FieldByName ('DocCnt00').AsInteger := dtSADC.FieldByName ('DocCnt00').AsInteger+dmSTA.dtSADC.FieldByName ('DocCnt'+mCasNum).AsInteger;
  end;
  If dtSADC.FieldByName('CValue00').AsInteger>0 then begin
    dtSADC.FieldByName ('AvgCValue').AsInteger := Round (dtSADC.FieldByName ('CValue00').AsInteger/dtSADC.FieldByName ('AvgKoef').AsInteger);
    dtSADC.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSADC.FieldByName ('AValue00').AsInteger/dtSADC.FieldByName('CValue00').AsInteger)-1)*100);
    dtSADC.FieldByName ('AvgProfVal').AsInteger := Round (dtSADC.FieldByName ('ProfVal00').AsInteger/dtSADC.FieldByName ('AvgKoef').AsInteger);
    dtSADC.FieldByName ('AvgAValue').AsInteger := Round (dtSADC.FieldByName ('AValue00').AsInteger/dtSADC.FieldByName ('AvgKoef').AsInteger);
    dtSADC.FieldByName ('AvgBValue').AsInteger := Round (dtSADC.FieldByName ('BValue00').AsInteger/dtSADC.FieldByName ('AvgKoef').AsInteger);
    dtSADC.FieldByName ('AvgDocCnt').AsInteger := Round (dtSADC.FieldByName ('DocCnt00').AsInteger/dtSADC.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAWCBeforePost(DataSet: TDataSet);
var mCasNum:Str2; I:byte;
begin
  dtSAWC.FieldByName ('CValue00').AsInteger := 0;
  dtSAWC.FieldByName ('ProfVal00').AsInteger := 0;
  dtSAWC.FieldByName ('AValue00').AsInteger := 0;
  dtSAWC.FieldByName ('BValue00').AsInteger := 0;
  dtSAWC.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 15 do begin
    mCasNum := StrIntZero (I,2);
    If dtSAWC.FieldByName('CValue'+mCasNum).AsInteger>0
      then dtSAWC.FieldByName ('ProfPrc'+mCasNum).AsFloat := Rd2(((dtSAWC.FieldByName ('AValue'+mCasNum).AsInteger/dtSAWC.FieldByName('CValue'+mCasNum).AsInteger)-1)*100)
      else dtSAWC.FieldByName ('ProfPrc'+mCasNum).AsFloat := 0;
    dtSAWC.FieldByName ('ProfVal'+mCasNum).AsInteger := dtSAWC.FieldByName ('AValue'+mCasNum).AsInteger-dtSAWC.FieldByName ('CValue'+mCasNum).AsInteger;

    dtSAWC.FieldByName ('CValue00').AsInteger := dtSAWC.FieldByName ('CValue00').AsInteger+dmSTA.dtSAWC.FieldByName ('CValue'+mCasNum).AsInteger;
    dtSAWC.FieldByName ('ProfVal00').AsInteger := dtSAWC.FieldByName ('ProfVal00').AsInteger+dmSTA.dtSAWC.FieldByName ('ProfVal'+mCasNum).AsInteger;
    dtSAWC.FieldByName ('AValue00').AsInteger := dtSAWC.FieldByName ('AValue00').AsInteger+dmSTA.dtSAWC.FieldByName ('AValue'+mCasNum).AsInteger;
    dtSAWC.FieldByName ('BValue00').AsInteger := dtSAWC.FieldByName ('BValue00').AsInteger+dmSTA.dtSAWC.FieldByName ('BValue'+mCasNum).AsInteger;
    dtSAWC.FieldByName ('DocCnt00').AsInteger := dtSAWC.FieldByName ('DocCnt00').AsInteger+dmSTA.dtSAWC.FieldByName ('DocCnt'+mCasNum).AsInteger;
  end;
  If dtSAWC.FieldByName ('CValue00').AsInteger>0 then begin
    dtSAWC.FieldByName ('AvgCValue').AsInteger := Round (dtSAWC.FieldByName ('CValue00').AsInteger/dtSAWC.FieldByName ('AvgKoef').AsInteger);
    dtSAWC.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAWC.FieldByName ('AValue00').AsInteger/dtSAWC.FieldByName('CValue00').AsInteger)-1)*100);
    dtSAWC.FieldByName ('AvgProfVal').AsInteger := Round (dtSAWC.FieldByName ('ProfVal00').AsInteger/dtSAWC.FieldByName ('AvgKoef').AsInteger);
    dtSAWC.FieldByName ('AvgAValue').AsInteger := Round (dtSAWC.FieldByName ('AValue00').AsInteger/dtSAWC.FieldByName ('AvgKoef').AsInteger);
    dtSAWC.FieldByName ('AvgBValue').AsInteger := Round (dtSAWC.FieldByName ('BValue00').AsInteger/dtSAWC.FieldByName ('AvgKoef').AsInteger);
    dtSAWC.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAWC.FieldByName ('DocCnt00').AsInteger/dtSAWC.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAMCBeforePost(DataSet: TDataSet);
var mCasNum:Str2; I:byte;
begin
  dtSAMC.FieldByName ('CValue00').AsInteger := 0;
  dtSAMC.FieldByName ('ProfVal00').AsInteger := 0;
  dtSAMC.FieldByName ('AValue00').AsInteger := 0;
  dtSAMC.FieldByName ('BValue00').AsInteger := 0;
  dtSAMC.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 15 do begin
    mCasNum := StrIntZero (I,2);
    If dmSTA.dtSAMC.FieldByName('CValue'+mCasNum).AsInteger>0
      then dtSAMC.FieldByName ('ProfPrc'+mCasNum).AsFloat := Rd2(((dtSAMC.FieldByName ('AValue'+mCasNum).AsInteger/dmSTA.dtSAMC.FieldByName('CValue'+mCasNum).AsInteger)-1)*100);
    dtSAMC.FieldByName ('ProfVal'+mCasNum).AsInteger := dtSAMC.FieldByName ('AValue'+mCasNum).AsInteger-dtSAMC.FieldByName ('CValue'+mCasNum).AsInteger;

    dtSAMC.FieldByName ('CValue00').AsInteger := dtSAMC.FieldByName ('CValue00').AsInteger+dtSAMC.FieldByName ('CValue'+mCasNum).AsInteger;
    dtSAMC.FieldByName ('ProfVal00').AsInteger := dtSAMC.FieldByName ('ProfVal00').AsInteger+dtSAMC.FieldByName ('ProfVal'+mCasNum).AsInteger;
    dtSAMC.FieldByName ('AValue00').AsInteger := dtSAMC.FieldByName ('AValue00').AsInteger+dtSAMC.FieldByName ('AValue'+mCasNum).AsInteger;
    dtSAMC.FieldByName ('BValue00').AsInteger := dtSAMC.FieldByName ('BValue00').AsInteger+dtSAMC.FieldByName ('BValue'+mCasNum).AsInteger;
    dtSAMC.FieldByName ('DocCnt00').AsInteger := dtSAMC.FieldByName ('DocCnt00').AsInteger+dtSAMC.FieldByName ('DocCnt'+mCasNum).AsInteger;
  end;
  If dtSAMC.FieldByName ('CValue00').AsInteger>0 then begin
    dtSAMC.FieldByName ('AvgCValue').AsInteger := Round (dtSAMC.FieldByName ('CValue00').AsInteger/dtSAMC.FieldByName ('AvgKoef').AsInteger);
    dtSAMC.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAMC.FieldByName ('AValue00').AsInteger/dtSAMC.FieldByName('CValue00').AsInteger)-1)*100);
    dtSAMC.FieldByName ('AvgProfVal').AsInteger := Round (dtSAMC.FieldByName ('ProfVal00').AsInteger/dtSAMC.FieldByName ('AvgKoef').AsInteger);
    dtSAMC.FieldByName ('AvgAValue').AsInteger := Round (dtSAMC.FieldByName ('AValue00').AsInteger/dtSAMC.FieldByName ('AvgKoef').AsInteger);
    dtSAMC.FieldByName ('AvgBValue').AsInteger := Round (dtSAMC.FieldByName ('BValue00').AsInteger/dtSAMC.FieldByName ('AvgKoef').AsInteger);
    dtSAMC.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAMC.FieldByName ('DocCnt00').AsInteger/dtSAMC.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAYCBeforePost(DataSet: TDataSet);
var mCasNum:Str2; I:byte;
begin
  dtSAYC.FieldByName ('CValue00').AsInteger := 0;
  dtSAYC.FieldByName ('ProfVal00').AsInteger := 0;
  dtSAYC.FieldByName ('AValue00').AsInteger := 0;
  dtSAYC.FieldByName ('BValue00').AsInteger := 0;
  dtSAYC.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 15 do begin
    mCasNum := StrIntZero (I,2);
    If dtSAYC.FieldByName('CValue'+mCasNum).AsInteger>0
      then dtSAYC.FieldByName ('ProfPrc'+mCasNum).AsFloat := Rd2(((dtSAYC.FieldByName ('AValue'+mCasNum).AsInteger/dmSTA.dtSAYC.FieldByName('CValue'+mCasNum).AsInteger)-1)*100);
    dtSAYC.FieldByName ('ProfVal'+mCasNum).AsInteger := dtSAYC.FieldByName ('AValue'+mCasNum).AsInteger-dtSAYC.FieldByName ('CValue'+mCasNum).AsInteger;

    dtSAYC.FieldByName ('CValue00').AsInteger := dtSAYC.FieldByName ('CValue00').AsInteger+dtSAYC.FieldByName ('CValue'+mCasNum).AsInteger;
    dtSAYC.FieldByName ('ProfVal00').AsInteger := dtSAYC.FieldByName ('ProfVal00').AsInteger+dtSAYC.FieldByName ('ProfVal'+mCasNum).AsInteger;
    dtSAYC.FieldByName ('AValue00').AsInteger := dtSAYC.FieldByName ('AValue00').AsInteger+dtSAYC.FieldByName ('AValue'+mCasNum).AsInteger;
    dtSAYC.FieldByName ('BValue00').AsInteger := dtSAYC.FieldByName ('BValue00').AsInteger+dtSAYC.FieldByName ('BValue'+mCasNum).AsInteger;
    dtSAYC.FieldByName ('DocCnt00').AsInteger := dtSAYC.FieldByName ('DocCnt00').AsInteger+dtSAYC.FieldByName ('DocCnt'+mCasNum).AsInteger;
  end;
  If dtSAYC.FieldByName ('CValue00').AsInteger>0 then begin
    dtSAYC.FieldByName ('AvgCValue').AsInteger := Round (dtSAYC.FieldByName ('CValue00').AsInteger/dtSAYC.FieldByName ('AvgKoef').AsInteger);
    dtSAYC.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAYC.FieldByName ('AValue00').AsInteger/dtSAYC.FieldByName('CValue00').AsInteger)-1)*100);
    dtSAYC.FieldByName ('AvgProfVal').AsInteger := Round (dtSAYC.FieldByName ('ProfVal00').AsInteger/dtSAYC.FieldByName ('AvgKoef').AsInteger);
    dtSAYC.FieldByName ('AvgAValue').AsInteger := Round (dtSAYC.FieldByName ('AValue00').AsInteger/dtSAYC.FieldByName ('AvgKoef').AsInteger);
    dtSAYC.FieldByName ('AvgBValue').AsInteger := Round (dtSAYC.FieldByName ('BValue00').AsInteger/dtSAYC.FieldByName ('AvgKoef').AsInteger);
    dtSAYC.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAYC.FieldByName ('DocCnt00').AsInteger/dtSAYC.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSADPBeforePost(DataSet: TDataSet);
var mHour:Str2;  I:byte;
begin
  dtSADP.FieldByName ('CValue00').AsInteger := 0;
  dtSADP.FieldByName ('ProfVal00').AsInteger := 0;
  dtSADP.FieldByName ('AValue00').AsInteger := 0;
  dtSADP.FieldByName ('BValue00').AsInteger := 0;
  dtSADP.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 24 do begin
    mHour := StrIntZero (I,2);
    If dtSADP.FieldByName('CValue'+mHour).AsInteger>0
      then dtSADP.FieldByName ('ProfPrc'+mHour).AsFloat := Rd2(((dtSADP.FieldByName ('AValue'+mHour).AsInteger/dtSADP.FieldByName('CValue'+mHour).AsInteger)-1)*100);
    dtSADP.FieldByName ('ProfVal'+mHour).AsInteger := dtSADP.FieldByName ('AValue'+mHour).AsInteger-dtSADP.FieldByName ('CValue'+mHour).AsInteger;

    dtSADP.FieldByName ('CValue00').AsInteger := dtSADP.FieldByName ('CValue00').AsInteger+dtSADP.FieldByName ('CValue'+mHour).AsInteger;
    dtSADP.FieldByName ('ProfVal00').AsInteger := dtSADP.FieldByName ('ProfVal00').AsInteger+dtSADP.FieldByName ('ProfVal'+mHour).AsInteger;
    dtSADP.FieldByName ('AValue00').AsInteger := dtSADP.FieldByName ('AValue00').AsInteger+dtSADP.FieldByName ('AValue'+mHour).AsInteger;
    dtSADP.FieldByName ('BValue00').AsInteger := dtSADP.FieldByName ('BValue00').AsInteger+dtSADP.FieldByName ('BValue'+mHour).AsInteger;
    dtSADP.FieldByName ('DocCnt00').AsInteger := dtSADP.FieldByName ('DocCnt00').AsInteger+dtSADP.FieldByName ('DocCnt'+mHour).AsInteger;
  end;
  If dtSADP.FieldByName ('CValue00').AsInteger>0 then begin
    dtSADP.FieldByName ('AvgCValue').AsInteger := Round (dtSADP.FieldByName ('CValue00').AsInteger/dtSADP.FieldByName ('AvgKoef').AsInteger);
    dtSADP.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSADP.FieldByName ('AValue00').AsInteger/dtSADP.FieldByName('CValue00').AsInteger)-1)*100);
    dtSADP.FieldByName ('AvgProfVal').AsInteger := Round (dtSADP.FieldByName ('ProfVal00').AsInteger/dtSADP.FieldByName ('AvgKoef').AsInteger);
    dtSADP.FieldByName ('AvgAValue').AsInteger := Round (dtSADP.FieldByName ('AValue00').AsInteger/dtSADP.FieldByName ('AvgKoef').AsInteger);
    dtSADP.FieldByName ('AvgBValue').AsInteger := Round (dtSADP.FieldByName ('BValue00').AsInteger/dtSADP.FieldByName ('AvgKoef').AsInteger);
    dtSADP.FieldByName ('AvgDocCnt').AsInteger := Round (dtSADP.FieldByName ('DocCnt00').AsInteger/dtSADP.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAWPBeforePost(DataSet: TDataSet);
var mDayNum:Str1;  I:byte;
begin
  dtSAWP.FieldByName ('CValue0').AsInteger := 0;
  dtSAWP.FieldByName ('ProfVal0').AsInteger := 0;
  dtSAWP.FieldByName ('AValue0').AsInteger := 0;
  dtSAWP.FieldByName ('BValue0').AsInteger := 0;
  dtSAWP.FieldByName ('DocCnt0').AsInteger := 0;
  For I:=1 to 7 do begin
    mDayNum := StrIntZero (I,1);
    If dtSAWP.FieldByName('CValue'+mDayNum).AsInteger>0
      then dtSAWP.FieldByName ('ProfPrc'+mDayNum).AsFloat := Rd2(((dtSAWP.FieldByName ('AValue'+mDayNum).AsInteger/dtSAWP.FieldByName('CValue'+mDayNum).AsInteger)-1)*100);
    dtSAWP.FieldByName ('ProfVal'+mDayNum).AsInteger := dtSAWP.FieldByName ('AValue'+mDayNum).AsInteger-dtSAWP.FieldByName ('CValue'+mDayNum).AsInteger;

    dtSAWP.FieldByName ('CValue0').AsInteger := dtSAWP.FieldByName ('CValue0').AsInteger+dtSAWP.FieldByName ('CValue'+mDayNum).AsInteger;
    dtSAWP.FieldByName ('ProfVal0').AsInteger := dtSAWP.FieldByName ('ProfVal0').AsInteger+dtSAWP.FieldByName ('ProfVal'+mDayNum).AsInteger;
    dtSAWP.FieldByName ('AValue0').AsInteger := dtSAWP.FieldByName ('AValue0').AsInteger+dtSAWP.FieldByName ('AValue'+mDayNum).AsInteger;
    dtSAWP.FieldByName ('BValue0').AsInteger := dtSAWP.FieldByName ('BValue0').AsInteger+dtSAWP.FieldByName ('BValue'+mDayNum).AsInteger;
    dtSAWP.FieldByName ('DocCnt0').AsInteger := dtSAWP.FieldByName ('DocCnt0').AsInteger+dtSAWP.FieldByName ('DocCnt'+mDayNum).AsInteger;
  end;
  If dtSAWP.FieldByName ('CValue0').AsInteger>0 then begin
    dtSAWP.FieldByName ('AvgCValue').AsInteger := Round (dtSAWP.FieldByName ('CValue0').AsInteger/dtSAWP.FieldByName ('AvgKoef').AsInteger);
    dtSAWP.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAWP.FieldByName ('AValue0').AsInteger/dtSAWP.FieldByName('CValue0').AsInteger)-1)*100);
    dtSAWP.FieldByName ('AvgProfVal').AsInteger := Round (dtSAWP.FieldByName ('ProfVal0').AsInteger/dtSAWP.FieldByName ('AvgKoef').AsInteger);
    dtSAWP.FieldByName ('AvgAValue').AsInteger := Round (dtSAWP.FieldByName ('AValue0').AsInteger/dtSAWP.FieldByName ('AvgKoef').AsInteger);
    dtSAWP.FieldByName ('AvgBValue').AsInteger := Round (dtSAWP.FieldByName ('BValue0').AsInteger/dtSAWP.FieldByName ('AvgKoef').AsInteger);
    dtSAWP.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAWP.FieldByName ('DocCnt0').AsInteger/dtSAWP.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAMPBeforePost(DataSet: TDataSet);
var mDayNum:Str2;  I:byte;
begin
  dtSAMP.FieldByName ('CValue00').AsInteger := 0;
  dtSAMP.FieldByName ('ProfVal00').AsInteger := 0;
  dtSAMP.FieldByName ('AValue00').AsInteger := 0;
  dtSAMP.FieldByName ('BValue00').AsInteger := 0;
  dtSAMP.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 31 do begin
    mDayNum := StrIntZero (I,2);
    If dtSAMP.FieldByName('CValue'+mDayNum).AsInteger>0
      then dtSAMP.FieldByName ('ProfPrc'+mDayNum).AsFloat := Rd2(((dtSAMP.FieldByName ('AValue'+mDayNum).AsInteger/dtSAMP.FieldByName('CValue'+mDayNum).AsInteger)-1)*100);
    dtSAMP.FieldByName ('ProfVal'+mDayNum).AsInteger := dtSAMP.FieldByName ('AValue'+mDayNum).AsInteger-dtSAMP.FieldByName ('CValue'+mDayNum).AsInteger;

    dtSAMP.FieldByName ('CValue00').AsInteger := dtSAMP.FieldByName ('CValue00').AsInteger+dtSAMP.FieldByName ('CValue'+mDayNum).AsInteger;
    dtSAMP.FieldByName ('ProfVal00').AsInteger := dtSAMP.FieldByName ('ProfVal00').AsInteger+dtSAMP.FieldByName ('ProfVal'+mDayNum).AsInteger;
    dtSAMP.FieldByName ('AValue00').AsInteger := dtSAMP.FieldByName ('AValue00').AsInteger+dtSAMP.FieldByName ('AValue'+mDayNum).AsInteger;
    dtSAMP.FieldByName ('BValue00').AsInteger := dtSAMP.FieldByName ('BValue00').AsInteger+dtSAMP.FieldByName ('BValue'+mDayNum).AsInteger;
    dtSAMP.FieldByName ('DocCnt00').AsInteger := dtSAMP.FieldByName ('DocCnt00').AsInteger+dtSAMP.FieldByName ('DocCnt'+mDayNum).AsInteger;
  end;
  If dtSAMP.FieldByName ('CValue00').AsInteger>0 then begin
    dtSAMP.FieldByName ('AvgCValue').AsInteger := Round (dtSAMP.FieldByName ('CValue00').AsInteger/dtSAMP.FieldByName ('AvgKoef').AsInteger);
    dtSAMP.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAMP.FieldByName ('AValue00').AsInteger/dtSAMP.FieldByName('CValue00').AsInteger)-1)*100);
    dtSAMP.FieldByName ('AvgProfVal').AsInteger := Round (dtSAMP.FieldByName ('ProfVal00').AsInteger/dtSAMP.FieldByName ('AvgKoef').AsInteger);
    dtSAMP.FieldByName ('AvgAValue').AsInteger := Round (dtSAMP.FieldByName ('AValue00').AsInteger/dtSAMP.FieldByName ('AvgKoef').AsInteger);
    dtSAMP.FieldByName ('AvgBValue').AsInteger := Round (dtSAMP.FieldByName ('BValue00').AsInteger/dtSAMP.FieldByName ('AvgKoef').AsInteger);
    dtSAMP.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAMP.FieldByName ('DocCnt00').AsInteger/dtSAMP.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.dtSAYPBeforePost(DataSet: TDataSet);
var mMthNum:Str2;   I:byte;
begin
  dtSAYP.FieldByName ('CValue00').AsInteger := 0;
  dtSAYP.FieldByName ('ProfVal00').AsInteger := 0;
  dtSAYP.FieldByName ('AValue00').AsInteger := 0;
  dtSAYP.FieldByName ('BValue00').AsInteger := 0;
  dtSAYP.FieldByName ('DocCnt00').AsInteger := 0;
  For I:=1 to 12 do begin
    mMthNum := StrIntZero (I,2);
    If dtSAYP.FieldByName('CValue'+mMthNum).AsInteger>0
      then dtSAYP.FieldByName ('ProfPrc'+mMthNum).AsFloat := Rd2(((dtSAYP.FieldByName ('AValue'+mMthNum).AsInteger/dtSAYP.FieldByName('CValue'+mMthNum).AsInteger)-1)*100);
    dtSAYP.FieldByName ('ProfVal'+mMthNum).AsInteger := dtSAYP.FieldByName ('AValue'+mMthNum).AsInteger-dtSAYP.FieldByName ('CValue'+mMthNum).AsInteger;

    dtSAYP.FieldByName ('CValue00').AsInteger := dtSAYP.FieldByName ('CValue00').AsInteger+dtSAYP.FieldByName ('CValue'+mMthNum).AsInteger;
    dtSAYP.FieldByName ('ProfVal00').AsInteger := dtSAYP.FieldByName ('ProfVal00').AsInteger+dtSAYP.FieldByName ('ProfVal'+mMthNum).AsInteger;
    dtSAYP.FieldByName ('AValue00').AsInteger := dtSAYP.FieldByName ('AValue00').AsInteger+dtSAYP.FieldByName ('AValue'+mMthNum).AsInteger;
    dtSAYP.FieldByName ('BValue00').AsInteger := dtSAYP.FieldByName ('BValue00').AsInteger+dtSAYP.FieldByName ('BValue'+mMthNum).AsInteger;
    dtSAYP.FieldByName ('DocCnt00').AsInteger := dtSAYP.FieldByName ('DocCnt00').AsInteger+dtSAYP.FieldByName ('DocCnt'+mMthNum).AsInteger;
  end;
  If dtSAYP.FieldByName ('CValue00').AsInteger>0 then begin
    dtSAYP.FieldByName ('AvgCValue').AsInteger := Round (dtSAYP.FieldByName ('CValue00').AsInteger/dtSAYP.FieldByName ('AvgKoef').AsInteger);
    dtSAYP.FieldByName ('AvgProfPrc').AsFloat := Rd2(((dtSAYP.FieldByName ('AValue00').AsInteger/dtSAYP.FieldByName('CValue00').AsInteger)-1)*100);
    dtSAYP.FieldByName ('AvgProfVal').AsInteger := Round (dtSAYP.FieldByName ('ProfVal00').AsInteger/dtSAYP.FieldByName ('AvgKoef').AsInteger);
    dtSAYP.FieldByName ('AvgAValue').AsInteger := Round (dtSAYP.FieldByName ('AValue00').AsInteger/dtSAYP.FieldByName ('AvgKoef').AsInteger);
    dtSAYP.FieldByName ('AvgBValue').AsInteger := Round (dtSAYP.FieldByName ('BValue00').AsInteger/dtSAYP.FieldByName ('AvgKoef').AsInteger);
    dtSAYP.FieldByName ('AvgDocCnt').AsInteger := Round (dtSAYP.FieldByName ('DocCnt00').AsInteger/dtSAYP.FieldByName ('AvgKoef').AsInteger);
  end;
end;

procedure TdmSTA.ptSAGSSUMBeforeOpen(DataSet: TDataSet);
begin
  ptSAGSSUM.FieldDefs.Clear;
  ptSAGSSUM.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);  // Kod tovaruy
  ptSAGSSUM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);  // Kod tovarej skupin
  ptSAGSSUM.FieldDefs.Add ('GsName',ftString,30,FALSE);  // Nazov tovaru
  ptSAGSSUM.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);  // Mnozstvo predaneho tovaru
  ptSAGSSUM.FieldDefs.Add ('CValue',ftFloat,0,FALSE);  // Hodnota predaja v NC bez DPH
  ptSAGSSUM.FieldDefs.Add ('ProfPrc',ftFloat,0,FALSE);  // Zisk v %
  ptSAGSSUM.FieldDefs.Add ('ProfVal',ftFloat,0,FALSE);  // Zisk v SK
  ptSAGSSUM.FieldDefs.Add ('AvgProf',ftFloat,0,FALSE); // Priemerny zisk v SK na jeden vyrobok Profval/GsQnt
  ptSAGSSUM.FieldDefs.Add ('AValue',ftFloat,0,FALSE);  // Hodnota predaja v PC bez DPH
  ptSAGSSUM.FieldDefs.Add ('BValue',ftFloat,0,FALSE); // Hodnota predaja v PC s DPH
  ptSAGSSUM.FieldDefs.Add ('BValSerNum',ftInteger,0,FALSE);  // Poradove cislo podla BValSepPrc
  ptSAGSSUM.FieldDefs.Add ('BValSepPrc',ftFloat,0,FALSE);  // Percentualna cast hodnoty tovaru z celkoveho predaja
  ptSAGSSUM.FieldDefs.Add ('BValCumPrc',ftFloat,0,FALSE); // Percentualna cast hodnoty tovaru - kumulativne
  ptSAGSSUM.FieldDefs.Add ('ProfSerNum',ftInteger,0,FALSE);  // Poradove cislo podla ProfSepPrc
  ptSAGSSUM.FieldDefs.Add ('ProfSepPrc',ftFloat,0,FALSE);  // Percentualna cast zisku zo zisku z celkoveho predaja
  ptSAGSSUM.FieldDefs.Add ('ProfCumPrc',ftFloat,0,FALSE); // Percentualna cast zisku - kumulativne
  ptSAGSSUM.FieldDefs.Add ('QntSerNum',ftInteger,0,FALSE);  // Poradove cislo podla QntSepPrc
  ptSAGSSUM.FieldDefs.Add ('QntSepPrc',ftFloat,0,FALSE);  // Percentualna cast podielu tovaru z celkoveho predaneho mnozstva
  ptSAGSSUM.FieldDefs.Add ('QntCumPrc',ftFloat,0,FALSE); // Percentualna cast kumulativneho podielu predaneho tovaru z mnozstva

  ptSAGSSUM.IndexDefs.Clear;
  ptSAGSSUM.IndexDefs.Add ('','GsCode',[ixPrimary]);
  ptSAGSSUM.IndexDefs.Add ('ProfVal','ProfVal',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('AvgProf','AvgProf',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('CValue','CValue',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('BValue','BValue',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('BValSerNum','BValSerNum',[]);
  ptSAGSSUM.IndexDefs.Add ('BValSepPrc','BValSepPrc',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('ProfPrc','ProfPrc',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('ProfSerNum','ProfSerNum',[]);
  ptSAGSSUM.IndexDefs.Add ('ProfSepPrc','ProfSepPrc',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('GsQnt','GsQnt',[ixDescending]);
  ptSAGSSUM.IndexDefs.Add ('QntSerNum','QntSerNum',[]);
  ptSAGSSUM.IndexDefs.Add ('QntSepPrc','QntSepPrc',[ixDescending]);
  ptSAGSSUM.CreateTable;
end;

procedure TdmSTA.dtMSALSTBeforeOpen(DataSet: TDataSet);
begin
  dtMSALST.DatabaseName := gIni.GetStaPath;
  If not dtMSALST.Exists then begin
    dtMSALST.FieldDefs.Clear;
    dtMSALST.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);  // Poradove cislo modelu predaja
    dtMSALST.FieldDefs.Add ('StBegDate',ftDate,0,FALSE);  // Pociatocny datum vypoctu statistickych udajov
    dtMSALST.FieldDefs.Add ('StEndDate',ftDate,0,FALSE);  // Konecny datum vypoctu statistickych udajov
    dtMSALST.FieldDefs.Add ('ReBegDate',ftDate,0,FALSE);  // Pociatocny datum planovaneho obdobia
    dtMSALST.FieldDefs.Add ('ReEndDate',ftDate,0,FALSE);  // Konecny datum planovaneho obdobia
    dtMSALST.FieldDefs.Add ('MaxSepPrc',ftFloat,0,FALSE);  // Maximalne percento podielu tovaru zo zisku, ktory sa zapocita do dolezitych poloziek
    dtMSALST.FieldDefs.Add ('StProfValD',ftFloat,0,FALSE);  // Priemerny zisk za 1 den z daneho datumoveho obdobia - dolezity tovar
    dtMSALST.FieldDefs.Add ('StProfValN',ftFloat,0,FALSE);  // Priemerny zisk za 1 den z daneho datumoveho obdobia - nedolezity tovar
    dtMSALST.FieldDefs.Add ('PlProfValD',ftFloat,0,FALSE);  // Planovany zisk za 1 - dolezity tovar
    dtMSALST.FieldDefs.Add ('PlProfValN',ftFloat,0,FALSE);  // Planovany zisk za 1 - nedolezity tovar
    dtMSALST.FieldDefs.Add ('ReProfVal',ftFloat,0,FALSE);  // Skutocny zisk za 1
    dtMSALST.FieldDefs.Add ('DfProfVal',ftFloat,0,FALSE);  // Odchylka medzi planovanym a skutocnym ziskom
    dtMSALST.FieldDefs.Add ('StCustQnt',ftInteger,0,FALSE);  // Priemerny pocet zakaznikov za 1 den datumoveho obdobia
    dtMSALST.FieldDefs.Add ('PlCustQnt',ftInteger,0,FALSE);  // Planovany pocet zakaznikov za 1 den
    dtMSALST.FieldDefs.Add ('ReCustQnt',ftInteger,0,FALSE);  // Skutocny pocet zakaznikov za 1 den
    dtMSALST.FieldDefs.Add ('DfCustQnt',ftInteger,0,FALSE);  // Odchylka medzi planovanym a skutocnym poctom zakaznikov

    dtMSALST.IndexDefs.Clear;
    dtMSALST.IndexDefs.Add ('','SerNum',[ixPrimary]);
    dtMSALST.CreateTable;
  end;
end;

procedure TdmSTA.dtMSABeforeOpen(DataSet: TDataSet);
begin
  dtMSA.DatabaseName := gIni.GetStaPath;
  If not dtMSA.Exists then begin
    dtMSA.FieldDefs.Clear;
    dtMSA.FieldDefs.Add ('GsCode',ftInteger,0,FALSE); // Tovarove cislo
    dtMSA.FieldDefs.Add ('GsName',ftString,30,FALSE); // Nazov tovaru
    dtMSA.FieldDefs.Add ('VatPrc',ftFloat,0,FALSE);  // Sadzba DPH tovarovej polozky
    dtMSA.FieldDefs.Add ('MgCode',ftInteger,0,FALSE); // Tovarova skupina
    // Spocitane z statistiky
    dtMSA.FieldDefs.Add ('StCValue',ftFloat,0,FALSE); // Priemerna nákupná hodnota tovaru za 1 den
    dtMSA.FieldDefs.Add ('StBValue',ftFloat,0,FALSE); // Hodnota predaja v PC s DPH
    dtMSA.FieldDefs.Add ('StCPrice',ftFloat,0,FALSE); // Priemerna nakupna cena tovaru
    dtMSA.FieldDefs.Add ('StBPrice',ftFloat,0,FALSE); // Priemerna nakupna cena tovaru
    dtMSA.FieldDefs.Add ('StProfVal',ftFloat,0,FALSE); // Priemerny zisk za 1 den z daneho datumoveho obdobia
    dtMSA.FieldDefs.Add ('StGsQnt',ftFloat,0,FALSE); // Predane mnozstvo tovaru - statistika za zadane datumove obdobie
    // Vypocitane na zaklade statistiky
    dtMSA.FieldDefs.Add ('ProfSepPrc',ftFloat,0,FALSE);  // Percentualna cast zisku zo zisku z celkoveho predaja
    dtMSA.FieldDefs.Add ('ProfCumPrc',ftFloat,0,FALSE);  // Kumulativny podiel
    dtMSA.FieldDefs.Add ('StProfPrc',ftFloat,0,FALSE);  // Priemerny zisk za 1 den z daneho datumoveho obdobia
    // Planovane hodnoty
    dtMSA.FieldDefs.Add ('PlGsQnt',ftFloat,0,FALSE);  // Predane mnozstvo tovaru - planovane
    dtMSA.FieldDefs.Add ('PlCValue',ftFloat,0,FALSE); // Priemerna nákupná hodnota tovaru za 1 den
    dtMSA.FieldDefs.Add ('PlBValue',ftFloat,0,FALSE); // Hodnota predaja v PC s DPH
    dtMSA.FieldDefs.Add ('PlProfVal',ftFloat,0,FALSE);  // Planovany zisk za 1
    dtMSA.FieldDefs.Add ('PlProfPrc',ftFloat,0,FALSE);  // Planovany zisk za 1
    dtMSA.FieldDefs.Add ('PlDiffVal',ftFloat,0,FALSE);  // Rozdiel zisku
    dtMSA.FieldDefs.Add ('PlBPrice',ftFloat,0,FALSE);  // Priemerna nakupna cena tovaru
    //Skutocnost na zaklade statistiky nasledujuceho predaja
    dtMSA.FieldDefs.Add ('ReGsQnt',ftFloat,0,FALSE);  // Predane mnozstvo tovaru - skutocne
    dtMSA.FieldDefs.Add ('ReCValue',ftFloat,0,FALSE);  // Priemerna nákupná hodnota tovaru za 1 den
    dtMSA.FieldDefs.Add ('ReBValue',ftFloat,0,FALSE); // Hodnota predaja v PC s DPH
    dtMSA.FieldDefs.Add ('ReProfPrc',ftFloat,0,FALSE);  // Planovany zisk za 1
    dtMSA.FieldDefs.Add ('ReProfVal',ftFloat,0,FALSE);  // Skutocny zisk za 1
    dtMSA.FieldDefs.Add ('ReCPrice',ftFloat,0,FALSE);  // Priemerna nakupna cena tovaru
    dtMSA.FieldDefs.Add ('ReBPrice',ftFloat,0,FALSE);  // Priemerna nakupna cena tovaru
    // Odchylka od planovaneho
    dtMSA.FieldDefs.Add ('DfGsQnt',ftFloat,0,FALSE);  // Predane mnozstvo tovaru - rozdiel medzi planovanym a skutocnym mnozstvom
    dtMSA.FieldDefs.Add ('DfProfVal',ftFloat,0,FALSE);  // Odchylka medzi planovanym a skutocnym ziskom
    dtMSA.FieldDefs.Add ('DfProfPrc',ftFloat,0,FALSE);  // Odchylka medzi planovanym a skutocnym ziskom

    dtMSA.FieldDefs.Add ('StStatus',ftString,1,FALSE);  // Stav polozky pri nacitani D-duolezity, N-nedolezity
    dtMSA.FieldDefs.Add ('PlStatus',ftString,1,FALSE);  // Stav polozky pri planovani A-akciovy tovar, D-duolezity, N-nedolezity

    dtMSA.IndexDefs.Clear;
    dtMSA.IndexDefs.Add ('','GsCode',[ixPrimary]);
    dtMSA.IndexDefs.Add ('PlStatus','PlStatus',[]);
    dtMSA.IndexDefs.Add ('ProfSepPrc','ProfSepPrc',[ixDescending]);
    dtMSA.CreateTable;
  end;
end;

end.
