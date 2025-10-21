unit DM_LDGDAT;

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, IcDate, NexPath, NexIni, BtrTable, NexText, NexGlob,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, NexBtrTable, NexTmpTable, PxTable, PxTmpTable, ImgList,
  NexPxTable, ExtCtrls;

type
  TdmLDG = class(TDataModule)
    btSACLST: TNexBtrTable;
    btSACITM: TNexBtrTable;
    ptSACITM: TNexPxTable;
    ptJRNHEAD: TPxTable;
    btICH: TNexBtrTable;
    btICI: TNexBtrTable;
    ptICI: TNexPxTable;
    btJOURNAL: TNexBtrTable;
    btICN: TNexBtrTable;
    T_LdgDat: TTimer;
    ptICH: TNexPxTable;
    btFXBLST: TNexBtrTable;
    btFXA: TNexBtrTable;
    btFXN: TNexBtrTable;
    btFXT: TNexBtrTable;
    ptFXT: TNexPxTable;
    btFXL: TNexBtrTable;
    ptFXL: TNexPxTable;
    btFXC: TNexBtrTable;
    ptFXC: TNexPxTable;
    btFXAGRP: TNexBtrTable;
    btFXTGRP: TNexBtrTable;
    ptICIHIS: TNexPxTable;
    ptNOPVAT: TNexPxTable;
    btSPBLST: TNexBtrTable;
    btSPD: TNexBtrTable;
    btISH: TNexBtrTable;
    ptSPBLST: TNexPxTable;
    ptSPD: TNexPxTable;
    btISI: TNexBtrTable;
    btISN: TNexBtrTable;
    btFINJRN: TNexBtrTable;
    ptFINJOUR: TNexPxTable;
    btACCANL: TNexBtrTable;
    btCSH: TNexBtrTable;
    btCSI: TNexBtrTable;
    btCSN: TNexBtrTable;
    btPMBLSTx: TNexBtrTable;
    btSOHx: TNexBtrTable;
    btSOIx: TNexBtrTable;
    ptSOIx: TNexPxTable;
    btPMIx: TNexBtrTable;
    btSPV: TNexBtrTable;
    ptCSI: TNexPxTable;
    btCSOINC: TNexBtrTable;
    btCSOEXP: TNexBtrTable;
    btACCSNT: TNexBtrTable;
    ptISI: TNexPxTable;
    btIDH: TNexBtrTable;
    btIDI: TNexBtrTable;
    btIDN: TNexBtrTable;
    ptIDI: TNexPxTable;
    btIDMLST: TNexBtrTable;
    btSOMLSTx: TNexBtrTable;
    btACCTRN: TNexBtrTable;
    btISRLST: TNexBtrTable;
    ptISH: TNexPxTable;
    ptACC: TNexPxTable;
    ptSPDSUM: TNexPxTable;
    btICRLST: TNexBtrTable;
    btVTBLST: TNexBtrTable;
    btVTBDOC: TNexBtrTable;
    ptVTBDOC: TNexPxTable;
    ptJOURNAL: TNexPxTable;
    btSNTINV: TNexBtrTable;
    ptVTBSUM: TNexPxTable;
    btSRDOC: TNexBtrTable;
    btSRMOV: TNexBtrTable;
    btSRSTA: TNexBtrTable;
    btSRCAT: TNexBtrTable;
    ptSRMOV: TNexPxTable;
    ptSRSTA: TNexPxTable;
    ptSPV: TNexPxTable;
    btPQH: TNexBtrTable;
    btPQI: TNexBtrTable;
    ptPQI: TNexPxTable;
    ptCSH: TNexPxTable;
    ptSRPRNS: TNexPxTable;
    ptSRPRNM: TNexPxTable;
    ptSRPRNH: TNexPxTable;
    btSUVDEF: TNexBtrTable;
    btVYSDEF: TNexBtrTable;
    btSUVCALC: TNexBtrTable;
    btVYSCALC: TNexBtrTable;
    btBLCLST: TNexBtrTable;
    btSUV: TNexBtrTable;
    btVYS: TNexBtrTable;
    ptSUVCALC: TNexPxTable;
    ptVYSCALC: TNexPxTable;
    ptIDH: TNexPxTable;
    imLedger: TImageList;
    ptACCTRNH: TNexPxTable;
    ptACCTRNI: TNexPxTable;
    btVTBAWR: TNexBtrTable;
    btVTC: TNexBtrTable;
    btMTBSTC: TNexBtrTable;
    btMTBIMD: TNexBtrTable;
    btMTBOMD: TNexBtrTable;
    ptMTBSTM: TNexPxTable;
    ptMTBIMD: TNexPxTable;
    ptMTBSTC: TNexPxTable;
    ptMTBOMD: TNexPxTable;
    ptSRPRN: TNexPxTable;
    ptSRPAL: TPxTable;
    btICDPEN: TNexBtrTable;
    ptVTBVER: TNexPxTable;
    ptFXSUI: TPxTable;
    ptFXACRDI: TPxTable;
    ptFXACRDH: TPxTable;
    ptFXSUH: TPxTable;
    btFXM: TNexBtrTable;
    ptFXM: TNexPxTable;
    ptJRNVER: TPxTable;
    btRCHS: TNexBtrTable;
    btRCIS: TNexBtrTable;
    ptRCIS: TNexPxTable;
    btRCHC: TNexBtrTable;
    btRCIC: TNexBtrTable;
    ptRCIC: TNexPxTable;
    btCRSHIS: TNexBtrTable;
    btCRSLST: TNexBtrTable;
    ptABODOC: TNexPxTable;
    ptABOITM: TNexPxTable;
    ptVATVER: TNexPxTable;
    ptACCBLC: TNexPxTable;
    btOWH: TNexBtrTable;
    btOWI: TNexBtrTable;
    btOWN: TNexBtrTable;
    ptOWI: TNexPxTable;
    ptOWH: TNexPxTable;
    ptFXTGRP: TNexPxTable;
    ptFXA: TNexPxTable;
    ptVTBSRL: TNexPxTable;
    ptVTBSRW: TNexPxTable;
    btVTCSPCx: TNexBtrTable;
    ptACCVER: TNexPxTable;
    ptPAYVER: TNexPxTable;
    btPMQ: TNexBtrTable;
    btREWDOC: TNexBtrTable;
    btREWITM: TNexBtrTable;
    ptREWITM: TNexPxTable;
    ptREWHIS: TNexPxTable;
    ptCSFREP: TNexPxTable;
    btICDSPC: TNexBtrTable;
    btISDSPC: TNexBtrTable;
    ptSRPRH: TNexPxTable;
    btVTRLST: TNexBtrTable;
    btVTR: TNexBtrTable;
    btVTDSPC: TNexBtrTable;
    btVTRAWR: TNexBtrTable;
    ptVTRSUM: TNexPxTable;
    btACT: TNexBtrTable;
    btACTLST: TNexBtrTable;
    btICPDEF: TNexBtrTable;
    ptICPEVL: TNexPxTable;
    btICC: TNexBtrTable;
    btVTRANL: TNexBtrTable;
    ptVTR: TNexPxTable;
    btABODAT: TNexBtrTable;
    btFXAASD: TNexBtrTable;
    ptVTRAWR: TNexPxTable;
    ptISPEVL: TNexPxTable;
    btISPDEF: TNexBtrTable;
    ptICPITM: TNexPxTable;
    btWABLST: TNexBtrTable;
    btWAH: TNexBtrTable;
    btWAI: TNexBtrTable;
    btWARDEF: TNexBtrTable;
    ptCSBLST: TNexPxTable;
    btVTI: TNexBtrTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure T_LdgDatTimer(Sender: TObject);
    procedure ptJRNHEADBeforeOpen(DataSet: TDataSet);
    procedure btICHBeforePost(DataSet: TDataSet);
    procedure btFXBLSTAfterOpen(DataSet: TDataSet);
    procedure btSPBLSTBeforePost(DataSet: TDataSet);
    procedure ptSRPALBeforeOpen(DataSet: TDataSet);
    procedure ptFXSUIBeforeOpen(DataSet: TDataSet);
    procedure ptFXSUHBeforeOpen(DataSet: TDataSet);
    procedure ptFXACRDHBeforeOpen(DataSet: TDataSet);
    procedure ptFXACRDIBeforeOpen(DataSet: TDataSet);
    procedure ptJRNVERBeforeOpen(DataSet: TDataSet);
    procedure btCRSLSTAfterOpen(DataSet: TDataSet);
  private
    oActIcbNum: str5;
    oActCsbNum: str5;
    oActFxbNum: str5;
    oActSpbNum: longint;
  public
    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);

    procedure OpenSPD (pPaCode:longint);
    procedure OpenSPV (pBookNum:Str5);
    procedure OpenPMI (pYear:Str4;pPayDate:TDateTime);
    procedure OpenVTR (pYear:Str2;pClsNum:integer);

    procedure OpenFXA (pBookNum:Str5);
    procedure OpenFXN (pBookNum:Str5);
    procedure OpenFXT (pBookNum:Str5);
    procedure OpenFXL (pBookNum:Str5);
    procedure OpenFXC (pBookNum:Str5);

    procedure SACITM_To_Tmp;
    procedure SPD_To_Tmp;
    procedure ICI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
    procedure ISI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
    procedure CSI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
    procedure IDI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);

    procedure FXA_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
    procedure FXT_To_Tmp;
    procedure FXL_To_Tmp;
    procedure FXC_To_Tmp;
    procedure FXM_To_Tmp;

    procedure SOI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
    procedure PQI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);

    function GetActFxbNum: Str5;
    function GetActSpbNum: longint;

    // Specialne funkcie pre databazu ACCANL
    function GetAccAnlCTrnVal (pMth:byte): double; // Hodnota funkcie je obrat strany MD v mesiaci pMth
    function GetAccAnlDTrnVal (pMth:byte): double; // Hodnota funkcie je obrat strany Dal v mesiaci pMth
    function GetAccAnlCTrnSum (pMth:byte): double; // Hodnota funkcie je  kumulativny obrat strany MD do mesiaca pMth - vratane mesiaca pMth
    function GetAccAnlDTrnSum (pMth:byte): double; // Hodnota funkcie je  kumulativny obrat strany Dal do mesiaca pMth - vratane mesiaca pMth
  end;

var
  dmLDG: TdmLDG;

implementation

uses  DM_STKDAT;

{$R *.DFM}

//**************************** SYSTEM ******************************
procedure TdmLDG.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName := gPath.LdgPath;
      (Components[I] as TNexBtrTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName := gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath := gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName := gPath.SubPrivPath;
  end;
end;

procedure TdmLDG.T_LdgDatTimer(Sender: TObject);
var I: integer;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TBtrieveTable) then begin
      If (Components[I] as TBtrieveTable).Active and ((Components[I] as TBtrieveTable).State = dsBrowse) then (Components[I] as TBtrieveTable).Refresh;
    end;
  end;
end;

procedure TdmLDG.btICHBeforePost(DataSet: TDataSet);
begin
  If dmLDG.btICH.FindField('AcEndVal')<>nil then begin
    dmLDG.btICH.FieldByName ('AcEndVal').AsFloat := dmLDG.btICH.FieldByName ('AcBValue').AsFloat-dmLDG.btICH.FieldByName ('AcPayVal').AsFloat-dmLDG.btICH.FieldByName ('EyCrdVal').AsFloat;
    dmLDG.btICH.FieldByName ('FgEndVal').AsFloat := dmLDG.btICH.FieldByName ('FgBValue').AsFloat-dmLDG.btICH.FieldByName ('FgPayVal').AsFloat;
    dmLDG.btICH.FieldByName ('DstPay').AsInteger := byte(Eq2(dmLDG.btICH.FieldByName ('AcEndVal').AsFloat,0) and Eq2(dmLDG.btICH.FieldByName ('FgEndVal').AsFloat,0));
  end;  
end;

//*******************************************************************

procedure TdmLDG.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;  mTableName:Str12;
begin
  mTable := (FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName := mTable.DefName;
    pTable.FixedName := mTable.FixedName;
    pTable.TableName := mTable.TableName;
  end
  else begin // Ak Tabulka nie je datamodule nastavime zakladne parametre podla nazvu suboru
    mTableName := pTable.Name;  Delete (mTableName,1,2);
    pTable.DefName := mTableName+'.BDF';
    pTable.FixedName := mTableName;
    pTable.TableName := mTableName;
  end;
end;

procedure TdmLDG.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.LdgPath;
  pTable.Open;
end;

procedure TdmLDG.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.LdgPath;
  pTable.TableName := pTable.FixedName+StrIntZero(pListNum,5);
  pTable.Open;
end;

procedure TdmLDG.OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum := pBookNum;
  pTable.DefPath := gPath.DefPath;
  pTable.DataBaseName := gPath.LdgPath;
  pTable.TableName := pTable.FixedName+pBookNum;
  pTable.Open;
end;

procedure TdmLDG.OpenSPD (pPaCode:longint);
begin
  oActSpbNum := pPaCode;
  If btSPD.Active then btSPD.Close;
  btSPD.TableName := 'SPD'+StrIntZero(pPaCode,5);
  btSPD.Open;
end;

procedure TdmLDG.OpenSPV (pBookNum:Str5);
begin
  If btSPV.Active then btSPV.Close;
  btSPV.TableName := 'SPV'+pBookNum;
  btSPV.Open;
end;

procedure TdmLDG.OpenPMI (pYear:Str4;pPayDate:TDateTime);
var mYear:Str4;
begin
(*
  If pYear='' then mYear:=StrInt(Year(pPayDate),0) else mYear:=pYear;
  If btPMI.Active and (btPmi.BookNum=mYear) then Exit;
  btPMI.Close;
  LoadDefaultProperty (btPMI);
  btPMI.DefPath := gPath.DefPath;
  btPMI.DataBaseName := gPath.LdgPath;
  If pYear<>'' then begin
    btPMI.TableName := 'PMI'+pYear;
    btPMI.BookNum   := pYear;
  end else begin
    btPMI.TableName := 'PMI'+mYear;
    btPMI.BookNum   := mYear;
  end;
  btPMI.Open;
*)  
end;

procedure TdmLDG.OpenVTR (pYear:Str2;pClsNum:integer);
var mYear:Str2;mBookNum:Str5;
begin
  If pYear='' then mYear:='00' else mYear:=pYear;
  mBookNum:=mYear+StrIntZero(pClsNum,3);
  If btVTR.Active and (btVTR.BookNum=mBookNum) then Exit;
  btVTR.Close;
  LoadDefaultProperty (btVTR);
  btVTR.DefPath := gPath.DefPath;
  btVTR.DataBaseName := gPath.LdgPath;
  btVTR.TableName := 'VTR'+mBookNum;
  btVTR.BookNum   := mBookNum;
  btVTR.Open;
end;

procedure TdmLDG.OpenFXA(pBookNum: Str5);
begin
  oActFxbNum := pBookNum;
  If btFXA.Active then btFXA.Close;
  btFXA.TableName := 'FXA'+pBookNum;
  btFXA.Open;
  If btFXN.Active then btFXN.Close;
  btFXN.TableName := 'FXN'+pBookNum;
  btFXN.Open;
end;

procedure TdmLDG.OpenFXN(pBookNum: Str5);
begin
  If btFXN.Active then btFXN.Close;
  btFXN.TableName := 'FXN'+pBookNum;
  btFXN.Open;
end;

procedure TdmLDG.OpenFXT(pBookNum: Str5);
begin
  If btFXT.Active then btFXT.Close;
  btFXT.TableName := btFXT.FixedName+pBookNum;
  btFXT.Open;
end;

procedure TdmLDG.OpenFXL(pBookNum: Str5);
begin
  If btFXL.Active then btFXL.Close;
  btFXL.TableName := btFXL.FixedName+pBookNum;
  btFXL.Open;
end;

procedure TdmLDG.OpenFXC(pBookNum: Str5);
begin
  If btFXC.Active then btFXC.Close;
  btFXC.TableName := btFXC.FixedName+pBookNum;
  btFXC.Open;
end;

procedure TdmLDG.SACITM_To_Tmp;
begin
  dmLDG.ptSACITM.FieldByName ('ItmNum').AsInteger := dmLDG.btSACITM.FieldByName ('ItmNum').AsInteger;
  dmLDG.ptSACITM.FieldByName ('ItmDate').AsDateTime := dmLDG.btSACITM.FieldByName ('ItmDate').AsDateTime;
  dmLDG.ptSACITM.FieldByName ('Describe').AsString := dmLDG.btSACITM.FieldByName ('Describe').AsString;
  dmLDG.ptSACITM.FieldByName ('BegVal').AsFloat := dmLDG.btSACITM.FieldByName ('BegVal').AsFloat;
  dmLDG.ptSACITM.FieldByName ('CredVal').AsFloat := dmLDG.btSACITM.FieldByName ('CredVal').AsFloat;
  dmLDG.ptSACITM.FieldByName ('DebVal').AsFloat := dmLDG.btSACITM.FieldByName ('DebVal').AsFloat;
  dmLDG.ptSACITM.FieldByName ('EndVal').AsFloat := dmLDG.btSACITM.FieldByName ('EndVal').AsFloat;
end;

procedure TdmLDG.SPD_To_Tmp;
begin
  dmLDG.ptSPD.FieldByName ('SerNum').AsInteger := dmLDG.btSPD.FieldByName('SerNum').AsInteger;
  dmLDG.ptSPD.FieldByName ('IncNum').AsInteger := dmLDG.btSPD.FieldByName ('IncNum').AsInteger;
  dmLDG.ptSPD.FieldByName ('ExpNum').AsInteger := dmLDG.btSPD.FieldByName ('ExpNum').AsInteger;
  dmLDG.ptSPD.FieldByName ('DocNum').AsString := dmLDG.btSPD.FieldByName ('DocNum').AsString;
  dmLDG.ptSPD.FieldByName ('DocDate').AsDateTime := dmLDG.btSPD.FieldByName ('DocDate').AsDateTime;
  dmLDG.ptSPD.FieldByName ('Describe').AsString := dmLDG.btSPD.FieldByName ('Describe').AsString;
  dmLDG.ptSPD.FieldByName ('DocVal').AsFloat := dmLDG.btSPD.FieldByName ('DocVal').AsFloat;
  dmLDG.ptSPD.FieldByName ('IncVal').AsFloat := dmLDG.btSPD.FieldByName ('IncVal').AsFloat;
  dmLDG.ptSPD.FieldByName ('ExpVal').AsFloat := dmLDG.btSPD.FieldByName ('ExpVal').AsFloat;
  dmLDG.ptSPD.FieldByName ('EndVal').AsFloat := dmLDG.btSPD.FieldByName ('EndVal').AsFloat;
  dmLDG.ptSPD.FieldByName ('ConDoc').AsString := dmLDG.btSPD.FieldByName ('ConDoc').AsString;
  dmLDG.ptSPD.FieldByName ('PayMode').AsString := dmLDG.btSPD.FieldByName ('PayMode').AsString;
  dmLDG.ptSPD.FieldByName ('ModNum').AsInteger := dmLDG.btSPD.FieldByName ('ModNum').AsInteger;
  dmLDG.ptSPD.FieldByName ('ModUser').AsString := dmLDG.btSPD.FieldByName ('ModUser').AsString;
  dmLDG.ptSPD.FieldByName ('ModDate').AsDateTime := dmLDG.btSPD.FieldByName ('ModDate').AsDateTime;
  dmLDG.ptSPD.FieldByName ('ModTime').AsDateTime := dmLDG.btSPD.FieldByName ('ModTime').AsDateTime;
end;

procedure TdmLDG.ICI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  BTR_To_PX (pBtTable,pPxTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  If IsNotNul (pBtTable.FieldByName('GsQnt').AsFloat) then begin
    // Ulozime specialne pole do docasneho suboru
    pPxTable.FieldByName('AcAPrice').AsFloat := Rd3(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcBPrice').AsFloat := Rd3(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('FgAPrice').AsFloat := Rd3(pBtTable.FieldByName('FgAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('FgBPrice').AsFloat := Rd3(pBtTable.FieldByName('FgBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
  end;
end;

procedure TdmLDG.ISI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  BTR_To_PX (pBtTable,pPxTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  // Ulozime specialne pole do docasneho suboru
  pPxTable.FieldByName('WriNum').AsInteger := pBtTable.FieldByName('WriNum').AsInteger;
  If IsNotNul (pBtTable.FieldByName('GsQnt').AsFloat) then begin
    pPxTable.FieldByName('AcDPrice').AsFloat := RoundCPrice(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcCPrice').AsFloat := RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcEPrice').AsFloat := RoundCPrice(pBtTable.FieldByName('AcEValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcAPrice').AsFloat := Rd2(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcBPrice').AsFloat := Rd2(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
  end;
  pPxTable.FieldByName('AcEValue').AsFloat := pBtTable.FieldByName('AcEValue').AsFloat;
  pPxTable.FieldByName('AcAValue').AsFloat := pBtTable.FieldByName('AcAValue').AsFloat;
  pPxTable.FieldByName('AcBValue').AsFloat := pBtTable.FieldByName('AcBValue').AsFloat;
  pPxTable.FieldByName('FgEPrice').AsFloat := pBtTable.FieldByName('FgEPrice').AsFloat;
  pPxTable.FieldByName('FgEValue').AsFloat := pBtTable.FieldByName('FgEValue').AsFloat;
  pPxTable.FieldByName('GsQnt').AsFloat := pBtTable.FieldByName('GsQnt').AsFloat;
  pPxTable.FieldByName('OsdNum').AsString := pBtTable.FieldByName('OsdNum').AsString;
  pPxTable.FieldByName('OsdItm').AsInteger := pBtTable.FieldByName('OsdItm').AsInteger;
  pPxTable.FieldByName('TsdNum').AsString := pBtTable.FieldByName('TsdNum').AsString;
  pPxTable.FieldByName('TsdItm').AsInteger := pBtTable.FieldByName('TsdItm').AsInteger;
  pPxTable.FieldByName('TsdDate').AsDateTime := pBtTable.FieldByName('TsdDate').AsDateTime;
  pPxTable.FieldByName('Status').AsString := pBtTable.FieldByName('Status').AsString;
  pPxTable.FieldByName('AccSnt').AsString := pBtTable.FieldByName('AccSnt').AsString;
  pPxTable.FieldByName('AccAnl').AsString := pBtTable.FieldByName('AccAnl').AsString;
end;

procedure TdmLDG.CSI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  BTR_To_PX (pBtTable,pPxTable);
  pPxTable.FieldByName ('PyVatVal').AsFloat := pBtTable.FieldByName ('PyBValue').AsFloat-pBtTable.FieldByName ('PyAValue').AsFloat;
end;

procedure TdmLDG.IDI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  If pPxTable.FieldByName ('RowNum').AsInteger=0 then pPxTable.FieldByName ('RowNum').AsInteger := pPxTable.RecordCount+1;
  pPxTable.FieldByName ('DocNum').AsString := pBtTable.FieldByName ('DocNum').AsString;
  pPxTable.FieldByName ('ItmNum').AsInteger := pBtTable.FieldByName ('ItmNum').AsInteger;
  pPxTable.FieldByName ('Describe').AsString := pBtTable.FieldByName ('Describe').AsString;
  pPxTable.FieldByName ('DocDate').AsDateTime := pBtTable.FieldByName ('DocDate').AsDateTime;
  pPxTable.FieldByName ('CredVal').AsFloat := pBtTable.FieldByName ('CredVal').AsFloat;
  pPxTable.FieldByName ('DebVal').AsFloat := pBtTable.FieldByName ('DebVal').AsFloat;
  pPxTable.FieldByName ('AccSnt').AsString := pBtTable.FieldByName ('AccSnt').AsString;
  pPxTable.FieldByName ('AccAnl').AsString := pBtTable.FieldByName ('AccAnl').AsString;
  pPxTable.FieldByName ('ConDoc').AsString := pBtTable.FieldByName ('ConDoc').AsString;
  pPxTable.FieldByName ('ConExt').AsString := pBtTable.FieldByName ('ConExt').AsString;
  pPxTable.FieldByName ('WriNum').AsInteger := pBtTable.FieldByName ('WriNum').AsInteger;
  pPxTable.FieldByName ('Status').AsString := pBtTable.FieldByName ('Status').AsString;
  pPxTable.FieldByName ('CrtUser').AsString := pBtTable.FieldByName ('CrtUser').AsString;
  pPxTable.FieldByName ('CrtDate').AsDateTime := pBtTable.FieldByName ('CrtDate').AsDateTime;
  pPxTable.FieldByName ('CrtTime').AsDateTime := pBtTable.FieldByName ('CrtTime').AsDateTime;
  pPxTable.FieldByName ('ModUser').AsString := pBtTable.FieldByName ('ModUser').AsString;
  pPxTable.FieldByName ('ModDate').AsDateTime := pBtTable.FieldByName ('ModDate').AsDateTime;
  pPxTable.FieldByName ('ModTime').AsDateTime := pBtTable.FieldByName ('ModTime').AsDateTime;
  pPxTable.FieldByName ('ActPos').AsInteger := pBtTable.ActPos;
end;

procedure TdmLDG.FXA_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  pPxTable.FieldByName ('SerNum').AsInteger := pBtTable.FieldByName ('SerNum').AsInteger;
  pPxTable.FieldByName ('DocNum').AsString := pBtTable.FieldByName ('DocNum').AsString;
  pPxTable.FieldByName ('ExtNum').AsString := pBtTable.FieldByName ('ExtNum').AsString;
  pPxTable.FieldByName ('FxaName').AsString := pBtTable.FieldByName ('FxaName').AsString;
  pPxTable.FieldByName ('DocDate').AsDateTime := pBtTable.FieldByName ('DocDate').AsDateTime;
  pPxTable.FieldByName ('WriNum').AsInteger := pBtTable.FieldByName ('WriNum').AsInteger;
  pPxTable.FieldByName ('ClasCode').AsString := pBtTable.FieldByName ('ClasCode').AsString;
  pPxTable.FieldByName ('PrvDoc').AsString := pBtTable.FieldByName ('PrvDoc').AsString;
  pPxTable.FieldByName ('PrvMode').AsInteger := pBtTable.FieldByName ('PrvMode').AsInteger;
  pPxTable.FieldByName ('PrvDate').AsDateTime := pBtTable.FieldByName ('PrvDate').AsDateTime;
  pPxTable.FieldByName ('PrvVal').AsFloat := pBtTable.FieldByName ('PrvVal').AsFloat;
  pPxTable.FieldByName ('BegDoc').AsString := pBtTable.FieldByName ('BegDoc').AsString;
  pPxTable.FieldByName ('BegDate').AsDateTime := pBtTable.FieldByName ('BegDate').AsDateTime;
  pPxTable.FieldByName ('AsdDoc').AsString := pBtTable.FieldByName ('AsdDoc').AsString;
  pPxTable.FieldByName ('AsdDate').AsDateTime := pBtTable.FieldByName ('AsdDate').AsDateTime;
  pPxTable.FieldByName ('AsdMode').AsInteger := pBtTable.FieldByName ('AsdMode').AsInteger;
  pPxTable.FieldByName ('ChgVal').AsFloat := pBtTable.FieldByName ('ChgVal').AsFloat;
  pPxTable.FieldByName ('ModVal').AsFloat := pBtTable.FieldByName ('ModVal').AsFloat;
  pPxTable.FieldByName ('SuVal').AsFloat := pBtTable.FieldByName ('SuVal').AsFloat;
  pPxTable.FieldByName ('TEndVal').AsFloat := pBtTable.FieldByName ('TEndVal').AsFloat;
  pPxTable.FieldByName ('LEndVal').AsFloat := pBtTable.FieldByName ('LEndVal').AsFloat;
  pPxTable.FieldByName ('FxaType').AsInteger := pBtTable.FieldByName ('FxaType').AsInteger;
  pPxTable.FieldByName ('TsuGrp').AsInteger := pBtTable.FieldByName ('TsuGrp').AsInteger;
  pPxTable.FieldByName ('TsuMode').AsInteger := pBtTable.FieldByName ('TsuMode').AsInteger;
  pPxTable.FieldByName ('TsuYear').AsInteger := pBtTable.FieldByName ('TsuYear').AsInteger;
  pPxTable.FieldByName ('TItmQnt').AsInteger := pBtTable.FieldByName ('TItmQnt').AsInteger;
  pPxTable.FieldByName ('LsuYear').AsInteger := pBtTable.FieldByName ('LsuYear').AsInteger;
  pPxTable.FieldByName ('LItmQnt').AsInteger := pBtTable.FieldByName ('LItmQnt').AsInteger;
  pPxTable.FieldByName ('FxaGrp').AsInteger := pBtTable.FieldByName ('FxaGrp').AsInteger;
  pPxTable.FieldByName ('Status').AsString := pBtTable.FieldByName ('Status').AsString;
end;

procedure TdmLDG.FXT_To_Tmp;
begin
  dmLDG.ptFXT.FieldByName('Year').AsInteger := dmLDG.btFXT.FieldByName('Year').AsInteger;
  dmLDG.ptFXT.FieldByName('BegVal').AsFloat := dmLDG.btFXT.FieldByName('BegVal').AsFloat;
  dmLDG.ptFXT.FieldByName('ChgVal').AsFloat := dmLDG.btFXT.FieldByName('ChgVal').AsFloat;
  dmLDG.ptFXT.FieldByName('ModVal').AsFloat := dmLDG.btFXT.FieldByName('ModVal').AsFloat;
  dmLDG.ptFXT.FieldByName('SuPrc').AsFloat := dmLDG.btFXT.FieldByName('SuPrc').AsFloat;
  dmLDG.ptFXT.FieldByName('SuVal').AsFloat := dmLDG.btFXT.FieldByName('SuVal').AsFloat;
  dmLDG.ptFXT.FieldByName('EndVal').AsFloat := dmLDG.btFXT.FieldByName('EndVal').AsFloat;
  dmLDG.ptFXT.FieldByName('Status').AsString := dmLDG.btFXT.FieldByName('Status').AsString;
  dmLDG.ptFXT.FieldByName('FxaGrp').AsInteger := dmLDG.btFXT.FieldByName('FxaGrp').AsInteger;
  dmLDG.ptFXT.FieldByName('ModUser').AsString := dmLDG.btFXT.FieldByName('ModUser').AsString;
  dmLDG.ptFXT.FieldByName('ModDate').AsDateTime := dmLDG.btFXT.FieldByName('ModDate').AsDateTime;
  dmLDG.ptFXT.FieldByName('ModTime').AsDateTime := dmLDG.btFXT.FieldByName('ModTime').AsDateTime;
  dmLDG.ptFXT.FieldByName('ActPos').AsInteger := dmLDG.btFXT.ActPos;
end;

procedure TdmLDG.FXL_To_Tmp;
begin
  dmLDG.ptFXL.FieldByName('Year').AsInteger := dmLDG.btFXL.FieldByName('Year').AsInteger;
  dmLDG.ptFXL.FieldByName('Mounth').AsInteger := dmLDG.btFXL.FieldByName('Mounth').AsInteger;
  dmLDG.ptFXL.FieldByName('BegVal').AsFloat := dmLDG.btFXL.FieldByName('BegVal').AsFloat;
  dmLDG.ptFXL.FieldByName('ChgVal').AsFloat := dmLDG.btFXL.FieldByName('ChgVal').AsFloat;
  dmLDG.ptFXL.FieldByName('ModVal').AsFloat := dmLDG.btFXL.FieldByName('ModVal').AsFloat;
  dmLDG.ptFXL.FieldByName('SuPrc').AsFloat := dmLDG.btFXL.FieldByName('SuPrc').AsFloat;
  dmLDG.ptFXL.FieldByName('SuVal').AsFloat := dmLDG.btFXL.FieldByName('SuVal').AsFloat;
  dmLDG.ptFXL.FieldByName('EndVal').AsFloat := dmLDG.btFXL.FieldByName('EndVal').AsFloat;
  dmLDG.ptFXL.FieldByName('Status').AsString := dmLDG.btFXL.FieldByName('Status').AsString;
  dmLDG.ptFXL.FieldByName('FxaGrp').AsInteger := dmLDG.btFXL.FieldByName('FxaGrp').AsInteger;
  dmLDG.ptFXL.FieldByName('ModUser').AsString := dmLDG.btFXL.FieldByName('ModUser').AsString;
  dmLDG.ptFXL.FieldByName('ModDate').AsDateTime := dmLDG.btFXL.FieldByName('ModDate').AsDateTime;
  dmLDG.ptFXL.FieldByName('ModTime').AsDateTime := dmLDG.btFXL.FieldByName('ModTime').AsDateTime;
  dmLDG.ptFXL.FieldByName('ActPos').AsInteger := dmLDG.btFXL.ActPos;
end;

procedure TdmLDG.FXC_To_Tmp;
begin
  dmLDG.ptFXC.FieldByName('ItmNum').AsInteger := dmLDG.ptFXC.RecordCount+1;
  dmLDG.ptFXC.FieldByName('ChgDate').AsDateTime := dmLDG.btFXC.FieldByName('ChgDate').AsDateTime;
  dmLDG.ptFXC.FieldByName('Describ').AsString := dmLDG.btFXC.FieldByName('Describ').AsString;
  dmLDG.ptFXC.FieldByName('ChgVal').AsFloat := dmLDG.btFXC.FieldByName('ChgVal').AsFloat;
  dmLDG.ptFXC.FieldByName('ChgYear').AsInteger := dmLDG.btFXC.FieldByName('ChgYear').AsInteger;
  dmLDG.ptFXC.FieldByName('ChgMth').AsInteger := dmLDG.btFXC.FieldByName('ChgMth').AsInteger;
  dmLDG.ptFXC.FieldByName('ModUser').AsString := dmLDG.btFXC.FieldByName('ModUser').AsString;
  dmLDG.ptFXC.FieldByName('ModDate').AsDateTime := dmLDG.btFXC.FieldByName('ModDate').AsDateTime;
  dmLDG.ptFXC.FieldByName('ModTime').AsDateTime := dmLDG.btFXC.FieldByName('ModTime').AsDateTime;
  dmLDG.ptFXC.FieldByName('ActPos').AsInteger := dmLDG.btFXC.ActPos;
end;

procedure TdmLDG.FXM_To_Tmp;
begin
  dmLDG.ptFXM.FieldByName('ItmNum').AsInteger := dmLDG.ptFXM.RecordCount+1;
  dmLDG.ptFXM.FieldByName('DocDate').AsDateTime := dmLDG.btFXM.FieldByName('DocDate').AsDateTime;
  dmLDG.ptFXM.FieldByName('DocYear').AsInteger := dmLDG.btFXM.FieldByName('DocYear').AsInteger;
  dmLDG.ptFXM.FieldByName('DocMth').AsInteger := dmLDG.btFXM.FieldByName('DocMth').AsInteger;
  dmLDG.ptFXM.FieldByName('Describ').AsString := dmLDG.btFXM.FieldByName('Describ').AsString;
  dmLDG.ptFXM.FieldByName('DocVal').AsFloat := dmLDG.btFXM.FieldByName('DocVal').AsFloat;
  dmLDG.ptFXM.FieldByName('ModUser').AsString := dmLDG.btFXM.FieldByName('ModUser').AsString;
  dmLDG.ptFXM.FieldByName('ModDate').AsDateTime := dmLDG.btFXM.FieldByName('ModDate').AsDateTime;
  dmLDG.ptFXM.FieldByName('ModTime').AsDateTime := dmLDG.btFXM.FieldByName('ModTime').AsDateTime;
  dmLDG.ptFXM.FieldByName('ActPos').AsInteger := dmLDG.btFXM.ActPos;
end;

procedure TdmLDG.SOI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  BTR_To_Px (pBtTable,pPxTable);
end;

procedure TdmLDG.PQI_To_Tmp (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  pPxTable.FieldByName('DocNum').AsString := pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('ItmNum').AsInteger := pBtTable.FieldByName('ItmNum').AsInteger;
  pPxTable.FieldByName('DocDate').AsDateTime := pBtTable.FieldByName('DocDate').AsDateTime;
  pPxTable.FieldByName('IsExtNum').AsString := pBtTable.FieldByName('IsExtNum').AsString;
  pPxTable.FieldByName('IsDocNum').AsString := pBtTable.FieldByName('IsDocNum').AsString;
  pPxTable.FieldByName('ContoNum').AsString := pBtTable.FieldByName('ContoNum').AsString;
  pPxTable.FieldByName('BankCode').AsString := pBtTable.FieldByName('BankCode').AsString;
  pPxTable.FieldByName('IbanCode').AsString := pBtTable.FieldByName('IbanCode').AsString;
  pPxTable.FieldByName('SwftCode').AsString := pBtTable.FieldByName('SwftCode').AsString;
  pPxTable.FieldByName('Describe').AsString := pBtTable.FieldByName('Describe').AsString;
  pPxTable.FieldByName('CsyCode').AsString := pBtTable.FieldByName('CsyCode').AsString;
  pPxTable.FieldByName('SpcSymb').AsString := pBtTable.FieldByName('SpcSymb').AsString;
  pPxTable.FieldByName('PayVal').AsFloat := pBtTable.FieldByName('PayVal').AsFloat;
  pPxTable.FieldByName('CrtUser').AsString := pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime := pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime := pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModUser').AsString := pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime := pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime := pBtTable.FieldByName('ModTime').AsDateTime;
  pPxTable.FieldByName('ActPos').AsInteger := pBtTable.ActPos;
end;

procedure TdmLDG.ptJRNHEADBeforeOpen(DataSet: TDataSet);
begin
  ptJRNHEAD.FieldDefs.Clear;
  ptJRNHEAD.FieldDefs.Add ('AccSnt',ftString,3,FALSE);
  ptJRNHEAD.FieldDefs.Add ('AccAnl',ftString,6,FALSE);
  ptJRNHEAD.FieldDefs.Add ('AccName',ftString,30,FALSE);
  ptJRNHEAD.FieldDefs.Add ('BegDate',ftDateTime,0,FALSE);
  ptJRNHEAD.FieldDefs.Add ('EndDate',ftDateTime,0,FALSE);
  ptJRNHEAD.FieldDefs.Add ('BegVal',ftFloat,0,FALSE);
  ptJRNHEAD.FieldDefs.Add ('CredVal',ftFloat,0,FALSE);
  ptJRNHEAD.FieldDefs.Add ('DebVal',ftFloat,0,FALSE);
  ptJRNHEAD.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);

  ptJRNHEAD.IndexDefs.Clear;
  ptJRNHEAD.IndexDefs.Add ('','AccSnt',[ixPrimary]);
  ptJRNHEAD.CreateTable;
end;

function TdmLDG.GetActFxbNum: Str5;
begin
  Result := oActFxbNum;
end;

function TdmLDG.GetActSpbNum: longint;
begin
  Result := oActSpbNum;
end;

function TdmLDG.GetAccAnlCTrnVal (pMth:byte): double; // Hodnota funkcie je obrat strany MD v mesiaci pMth
begin
  Result := btACCANL.FieldByName('CTurn'+StrIntZero(pMth,2)).AsFloat;
end;

function TdmLDG.GetAccAnlDTrnVal (pMth:byte): double; // Hodnota funkcie je obrat strany Dal v mesiaci pMth
begin
  Result := btACCANL.FieldByName('DTurn'+StrIntZero(pMth,2)).AsFloat;
end;

function TdmLDG.GetAccAnlCTrnSum (pMth:byte): double; // Hodnota funkcie je  kumulativny obrat strany MD do mesiaca pMth - vratane mesiaca pMth
var I: byte;
begin
  Result := 0;
  For I:=1 to pMth do
    Result := Result+GetAccAnlCTrnVal(I);
end;

function TdmLDG.GetAccAnlDTrnSum (pMth:byte): double; // Hodnota funkcie je  kumulativny obrat strany Dal do mesiaca pMth - vratane mesiaca pMth
var I: byte;
begin
  Result := 0;
  For I:=1 to pMth do
    Result := Result+GetAccAnlDTrnVal(I);
end;

procedure TdmLDG.btFXBLSTAfterOpen(DataSet: TDataSet);
begin
  If btFXBLST.RecordCount=0 then begin
     gNT.SetSection ('FXB');
     btFXBLST.Insert;
     btFXBLST.FieldByName ('BookNum').AsString := gvSys.ActYear2+'001';
     btFXBLST.FieldByName ('BookName').AsString := gNT.GetText('btFXBLST.DefaultBookName','Dlohodobý majetok');
     btFXBLST.Post;
  end;
end;

procedure TdmLDG.btSPBLSTBeforePost(DataSet: TDataSet);
begin
  btSPBLST.FieldByName ('EndVal').AsFloat := btSPBLST.FieldByName ('IncVal').AsFloat+btSPBLST.FieldByName ('ExpVal').AsFloat;
end;

procedure TdmLDG.ptSRPALBeforeOpen(DataSet: TDataSet);
var I:byte;
begin
  ptSRPAL.FieldDefs.Clear;
  ptSRPAL.FieldDefs.Add ('PaCode',ftInteger,0,FALSE);
  For I:=1 to 30 do
    ptSRPAL.FieldDefs.Add ('PaName'+StrIntZero(I,2),ftString,1,FALSE);
  For I:=1 to 30 do
    ptSRPAL.FieldDefs.Add ('PaAddr'+StrIntZero(I,2),ftString,1,FALSE);
  For I:=1 to 7 do
    ptSRPAL.FieldDefs.Add ('Numeric'+StrIntZero(I,1),ftString,1,FALSE);
  For I:=1 to 5 do
    ptSRPAL.FieldDefs.Add ('ZipCode'+StrIntZero(I,1),ftString,1,FALSE);
  For I:=1 to 2 do
    ptSRPAL.FieldDefs.Add ('StaCode'+StrIntZero(I,1),ftString,1,FALSE);
  For I:=1 to 30 do
    ptSRPAL.FieldDefs.Add ('CtyName'+StrIntZero(I,2),ftString,1,FALSE);

  ptSRPAL.IndexDefs.Clear;
  ptSRPAL.IndexDefs.Add ('','PaCode',[ixPrimary]);
  ptSRPAL.CreateTable;
end;

procedure TdmLDG.ptFXSUIBeforeOpen(DataSet: TDataSet);
begin
  ptFXSUI.FieldDefs.Clear;
  ptFXSUI.FieldDefs.Add ('AccGrp',ftInteger,0,FALSE);
  ptFXSUI.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptFXSUI.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptFXSUI.FieldDefs.Add ('ExtNum',ftString,12,FALSE);
  ptFXSUI.FieldDefs.Add ('FxaName',ftString,30,FALSE);
  ptFXSUI.FieldDefs.Add ('PrvVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('TBegVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('TChgVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('TModVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('TSuVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('TEndVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LsuMth',ftInteger,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LBegVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LChgVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LModVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LSuVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('LEndVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('DiffVal',ftFloat,0,FALSE);
  ptFXSUI.FieldDefs.Add ('AccSnt',ftString,3,FALSE);

  ptFXSUI.IndexDefs.Clear;
  ptFXSUI.IndexDefs.Add ('','AccGrp;SerNum;DocNum',[ixPrimary]);
  ptFXSUI.IndexDefs.Add ('DocNum','DocNum',[]);
  ptFXSUI.CreateTable;
end;

procedure TdmLDG.ptFXSUHBeforeOpen(DataSet: TDataSet);
begin
  ptFXSUH.FieldDefs.Clear;
  ptFXSUH.FieldDefs.Add ('Year',ftInteger,0,FALSE);
  ptFXSUH.FieldDefs.Add ('Mounth',ftInteger,0,FALSE);

  ptFXSUH.IndexDefs.Clear;
  ptFXSUH.IndexDefs.Add ('','Year',[ixPrimary]);
  ptFXSUH.CreateTable;
end;

procedure TdmLDG.ptFXACRDHBeforeOpen(DataSet: TDataSet);
begin
  ptFXACRDH.FieldDefs.Clear;
  ptFXACRDH.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptFXACRDH.FieldDefs.Add ('PrvMode',ftString,30,FALSE);
  ptFXACRDH.FieldDefs.Add ('AsdDate',ftDate,0,FALSE);
  ptFXACRDH.FieldDefs.Add ('AsdMode',ftString,30,FALSE);
  ptFXACRDH.FieldDefs.Add ('AsdDoc',ftString,12,FALSE);
  ptFXACRDH.FieldDefs.Add ('TYeText',ftString,10,FALSE);
  ptFXACRDH.FieldDefs.Add ('TSuMode',ftString,30,FALSE);
  ptFXACRDH.FieldDefs.Add ('LYeText',ftString,10,FALSE);
  ptFXACRDH.FieldDefs.Add ('LSuMode',ftString,30,FALSE);
  ptFXACRDH.FieldDefs.Add ('FxaType',ftString,30,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice1',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice2',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice3',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice4',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice5',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice6',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice7',ftString,200,FALSE);
  ptFXACRDH.FieldDefs.Add ('Notice8',ftString,200,FALSE);

  ptFXACRDH.IndexDefs.Clear;
  ptFXACRDH.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptFXACRDH.CreateTable;
end;

procedure TdmLDG.ptFXACRDIBeforeOpen(DataSet: TDataSet);
begin
  ptFXACRDI.FieldDefs.Clear;
  ptFXACRDI.FieldDefs.Add ('Year',ftInteger,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('ChgVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('TBegVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('TModVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('TSuPrc',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('TSuVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('TEndVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('LBegVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('LModVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('LSuPrc',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('LSuVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('LEndVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('DiffVal',ftFloat,0,FALSE);
  ptFXACRDI.FieldDefs.Add ('Status',ftString,0,FALSE);

  ptFXACRDI.IndexDefs.Clear;
  ptFXACRDI.IndexDefs.Add ('','Year',[ixPrimary]);
  ptFXACRDI.CreateTable;
end;

procedure TdmLDG.ptJRNVERBeforeOpen(DataSet: TDataSet);
begin
  ptJRNVER.FieldDefs.Clear;
  ptJRNVER.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptJRNVER.FieldDefs.Add ('JrnVal',ftFloat,0,FALSE);
  ptJRNVER.FieldDefs.Add ('VtdVal',ftFloat,0,FALSE);
  ptJRNVER.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);
  ptJRNVER.FieldDefs.Add ('JrnDate',ftDateTime,0,FALSE);
  ptJRNVER.FieldDefs.Add ('VtdDate',ftDateTime,0,FALSE);

  ptJRNVER.IndexDefs.Clear;
  ptJRNVER.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptJRNVER.CreateTable;
end;

procedure TdmLDG.btCRSLSTAfterOpen(DataSet: TDataSet);
begin
  If btCRSLST.RecordCount=0 then begin
    btCRSLST.Insert;
    btCRSLST.FieldByName ('DvzName').AsString := gIni.GetSelfDvzName;
    btCRSLST.FieldByName ('DvzDesc').AsString := btCRSLST.FieldByName ('DvzName').AsString;
    btCRSLST.FieldByName ('CrsDate').AsDateTime := FirstActYearDate; 
    btCRSLST.FieldByName ('Course').AsFloat := 1;
    btCRSLST.Post;
  end;
end;

end.
{MOD 1806012}
