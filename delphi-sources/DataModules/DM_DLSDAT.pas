unit DM_DLSDAT;

interface

uses
  IcConv, IcTypes, IcVariab, NexPath, NexBtrTable, PxTmpTable, NexText,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, BtrTable, NexTmpTable, IBCustomDataSet, IBTable, IBDatabase,
  LinkBtrTable, DBTables, PxTable, NexPxTable, ExtCtrls;

type
  TdmDLS = class(TDataModule)
    btSTALST: TNexBtrTable;
    btCTYLST: TNexBtrTable;
    btPAYLST: TNexBtrTable;
    btTRSLST: TNexBtrTable;
    btBANKLST: TNexBtrTable;
    btPABLST: TNexBtrTable;
    btPABCAT: TNexBtrTable;
    btPAB: TNexBtrTable;
    btPABACC: TNexBtrTable;
    ttPABACC: TPxTmpTable;
    btPACNTC: TNexBtrTable;
    ttPACNTC: TPxTmpTable;
    btPASUBC: TNexBtrTable;
    btPAGLST: TNexBtrTable;
    btMSULST: TNexBtrTable;
    btWRILST: TNexBtrTable;
    btPANOTI: TNexBtrTable;
    btCRDLST: TNexBtrTable;
    btEUSTAT: TNexBtrTable;
    ptPABACC: TNexPxTable;
    btDLRLST: TNexBtrTable;
    ptPASUBC: TNexPxTable;
    ptPAB: TNexPxTable;
    ptPACNTC: TNexPxTable;
    btDSCLST: TNexBtrTable;
    btWGSLST: TNexBtrTable;
    btWGI: TNexBtrTable;
    btWGN: TNexBtrTable;
    btWRICLS: TNexBtrTable;
    btBON: TNexBtrTable;
    btBONLST: TNexBtrTable;
    btDLRDSC: TNexBtrTable;
    btREFLST: TNexBtrTable;
    btDRVLST: TNexBtrTable;
    btPABOTN: TNexBtrTable;
    T_DlsDat: TTimer;
    btCNTLST: TNexBtrTable;
    btCRDBON: TNexBtrTable;

    procedure DataModuleCreate(Sender: TObject);
    procedure btPABLSTAfterOpen(DataSet: TDataSet);
    procedure ttPABACCBeforeOpen(DataSet: TDataSet);
    procedure ttPACNTCBeforeOpen(DataSet: TDataSet);
    procedure btPAGLSTAfterOpen(DataSet: TDataSet);
    procedure T_DlsDatTimer(Sender: TObject);
    procedure btWRILSTAfterOpen(DataSet: TDataSet);
  private
    oActPabNum: longint;

  public
    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);

    procedure OpenPAB (pBookNum:longint);

    function GetActPabNum: longint;
  end;

var
  dmDLS: TdmDLS;

implementation

{$R *.DFM}

procedure TdmDLS.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.DlsPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

procedure TdmDLS.btPABLSTAfterOpen(DataSet: TDataSet);
begin
  If btPABLST.RecordCount=0 then begin
     gNT.SetSection ('PABLST');
     btPABLST.Insert;
     btPABLST.FieldByName ('BookNum').AsInteger := 0;
     btPABLST.FieldByName ('BookName').AsString := gNT.GetText('BookName0','Zoznam všetkých firiem');
     btPABLST.Post;
     btPABLST.Insert;
     btPABLST.FieldByName ('BookNum').AsInteger := 1;
     btPABLST.FieldByName ('BookName').AsString := gNT.GetText('BookName1','Dodávatelia');
     btPABLST.Post;
     btPABLST.Insert;
     btPABLST.FieldByName ('BookNum').AsInteger := 2;
     btPABLST.FieldByName ('BookName').AsString := gNT.GetText('BookName2','Ve¾koobchodné odberaatelia');
     btPABLST.Post;
     btPABLST.Insert;
     btPABLST.FieldByName ('BookNum').AsInteger := 3;
     btPABLST.FieldByName ('BookName').AsString := gNT.GetText('BookName3','Maloobchodné zákazníci');
     btPABLST.Post;
  end;
end;

procedure TdmDLS.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak exist`uje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;
begin
  mTable := (FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName := mTable.DefName;
    pTable.FixedName := mTable.FixedName;
    pTable.TableName := mTable.TableName;
  end;
end;

procedure TdmDLS.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.DlsPath;
  pTable.Open;
end;

procedure TdmDLS.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := StrInt(pListNum,0);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.DlsPath;
  pTable.TableName := pTable.FixedName+StrIntZero(pListNum,5);
  pTable.Open;
end;

procedure TdmDLS.OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := pBookNum;
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.DlsPath;
  pTable.TableName := pTable.FixedName+pBookNum;
  pTable.Open;
end;

procedure TdmDLS.OpenPAB (pBookNum: longint);
begin
  oActPabNum := pBookNum;
  If btPAB.Active then btPAB.Close;
  btPAB.TableName := btPAB.FixedName+StrIntZero(pBookNum,5);
  btPAB.Open;
end;

function TdmDLS.GetActPabNum: longint;
begin
  Result := oActPabNum;
end;


procedure TdmDLS.ttPABACCBeforeOpen(DataSet: TDataSet);
begin
  ttPABACC.FieldDefs.Clear;
  ttPABACC.FieldDefs.Add ('ContoNum',ftString,30,FALSE);
  ttPABACC.FieldDefs.Add ('BankCode',ftString,15,FALSE);
  ttPABACC.FieldDefs.Add ('BankName',ftString,30,FALSE);
  ttPABACC.FieldDefs.Add ('BankSeat',ftString,30,FALSE);
  ttPABACC.FieldDefs.Add ('Default',ftString,1,FALSE);
  ttPABACC.FieldDefs.Add ('PaCode',ftInteger,0,FALSE);
  ttPABACC.FieldDefs.Add ('ActPos',ftInteger,0,FALSE);

  ttPABACC.IndexDefs.Clear;
  ttPABACC.IndexDefs.Add ('','ContoNum',[ixPrimary]);
  ttPABACC.CreateTable;
end;

procedure TdmDLS.ttPACNTCBeforeOpen(DataSet: TDataSet);
begin
  ttPACNTC.FieldDefs.Clear;
  ttPACNTC.FieldDefs.Add ('ItmNum',ftInteger,0,FALSE);
  ttPACNTC.FieldDefs.Add ('FirstName',ftString,15,FALSE);
  ttPACNTC.FieldDefs.Add ('LastName',ftString,15,FALSE);
  ttPACNTC.FieldDefs.Add ('TitulBef',ftString,10,FALSE);
  ttPACNTC.FieldDefs.Add ('TitulAft',ftString,10,FALSE);
  ttPACNTC.FieldDefs.Add ('Function',ftString,30,FALSE);
  ttPACNTC.FieldDefs.Add ('SexMark',ftString,1,FALSE);
  ttPACNTC.FieldDefs.Add ('Accost',ftString,30,FALSE);
  ttPACNTC.FieldDefs.Add ('WorkSta',ftString,6,FALSE);
  ttPACNTC.FieldDefs.Add ('WorkCty',ftString,6,FALSE);
  ttPACNTC.FieldDefs.Add ('WorkTel',ftString,15,FALSE);
  ttPACNTC.FieldDefs.Add ('WorkSec',ftString,5,FALSE);
  ttPACNTC.FieldDefs.Add ('PrivSta',ftString,6,FALSE);
  ttPACNTC.FieldDefs.Add ('PrivCty',ftString,6,FALSE);
  ttPACNTC.FieldDefs.Add ('PrivTel',ftString,20,FALSE);
  ttPACNTC.FieldDefs.Add ('MobTel',ftString,20,FALSE);
  ttPACNTC.FieldDefs.Add ('Email',ftString,30,FALSE);
  ttPACNTC.FieldDefs.Add ('PaCode',ftInteger,0,FALSE);
  ttPACNTC.FieldDefs.Add ('ActPos',ftInteger,0,FALSE);

  ttPACNTC.IndexDefs.Clear;
  ttPACNTC.IndexDefs.Add ('','ItmNum',[ixPrimary]);
  ttPACNTC.CreateTable;
end;

procedure TdmDLS.btPAGLSTAfterOpen(DataSet: TDataSet);
begin
  If btPAGLST.RecordCount=0 then begin
     gNT.SetSection ('GLOBAL');
     btPAGLST.Insert;
     btPAGLST.FieldByName ('PagCode').AsInteger := 0;
     btPAGLST.FieldByName ('PagName').AsString := gNT.GetText('Other','Ostatné');
     btPAGLST.Post;
  end;
end;

procedure TdmDLS.T_DlsDatTimer(Sender: TObject);
var I: integer;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TBtrieveTable) then begin
      If (Components[I] as TBtrieveTable).Active and ((Components[I] as TBtrieveTable).State = dsBrowse) then (Components[I] as TBtrieveTable).Refresh;
    end;
  end;
end;

procedure TdmDLS.btWRILSTAfterOpen(DataSet: TDataSet);
begin
  If cNexStart and (btWRILST.RecordCount=0) then begin
    // WRILST.bdf
    btWRILST.Insert;
    btWRILST.FieldByName('WriNum').AsInteger   := 1;
    btWRILST.FieldByName('WriName').AsString   := 'Prevadzka';
    btWRILST.Post;
  end;
end;

end.
