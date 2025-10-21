unit DM_STKDAT;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, StkGlob, Key, Plc,
  NexText, NexPath, NexGlob, NexIni,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, BtrTable, NexTmpTable, DBTables, PxTable, PxTmpTable, ImgList,
  NexPxTable, HdsBtrTable, ExtCtrls, NexBtrTable, LinkBtrTable;

type
  TOutFifData=record // Zoznam fifokariet z ktorych sa vydava
    FifNum: longint;     // »Ìslo Fifo karty
    PaCode: longint;     // Kod partnera, ktory dodal tovar
    ActPos: longint;     // PoziËn˝ blik Fifo karty v datab·zovom s˙bore
    OutQnt: double;      // Mnoûstvo, ktorÈ bude vydanÈ
    OutPrice: double;    // Cena z danej fifo karty
    AcqStat: Str1;       // Priznak obstarania tovaru
    DocDate: TDateTime;  // Datum prijmu
    DrbDate: TDateTime;  // Datum ukoncenia trvanlivosti
    RbaDate: TDateTime;  // D·tum vyrobnej sarze
    RbaCode: Str30;      // Vyrobna sarza
  end;

  TdmSTK=class(TDataModule)
    btSTK: TNexBtrTable;
    btSTKLST: TNexBtrTable;
    btSTM: TNexBtrTable;
    btFIF: TNexBtrTable;
    btBARCODE: TNexBtrTable;
    btSGRLST: TNexBtrTable;
    ptFIF: TNexPxTable;
    ptSTP: TNexPxTable;
    btSTP: TNexBtrTable;
    ptSTM: TNexPxTable;
    btGSPART: TNexBtrTable;
    ptSPALST: TNexPxTable;
    ptSAPLST: TNexPxTable;
    btPLSLST: TNexBtrTable;
    ptMINLST: TNexPxTable;
    ptMAXLST: TNexPxTable;
    ptSTO: TNexPxTable;
    ptSTK: TNexPxTable;
    ptSTEVAL: TNexPxTable;
    ptSMEVAL: TNexPxTable;
    btMSLST: TNexBtrTable;
    btMGLST: TNexBtrTable;
    btGSNOTI: TNexBtrTable;
    ptGSCAT: TNexPxTable;
    btGSMOD: TNexBtrTable;
    ptSTCLST: TNexPxTable;
    btGSCATx: THdsBtrTable;
    ptGSMOD: TNexPxTable;
    ptBARCODE: TPxTable;
    btPLSMOD: TNexBtrTable;
    ptPLSMOD: TNexPxTable;
    ptPLS: TNexPxTable;
    ptPLSHIS: TNexPxTable;
    ptPLSREF: TNexPxTable;
    T_StkDat: TTimer;
    btTCH: TNexBtrTable;
    btTCI: TNexBtrTable;
    ptTCI: TNexPxTable;
    btTSH: TNexBtrTable;
    btTSI: TNexBtrTable;
    ptTSI: TNexPxTable;
    btTCN: TNexBtrTable;
    btIVDLST: TNexBtrTable;
    btIVC: TNexBtrTable;
    btIVL: TNexBtrTable;
    btIVI: TNexBtrTable;
    ptIVI: TNexPxTable;
    btIVD: TNexBtrTable;
    btIVN: TNexBtrTable;
    ptIVMGSUM: TPxTable;
    btIVP: TNexBtrTable;
    ptIVM: TNexPxTable;
    btIVM: TNexBtrTable;
    btPCBLST: TNexBtrTable;
    btPCH: TNexBtrTable;
    btPCI: TNexBtrTable;
    ptPCI: TNexPxTable;
    btPCN: TNexBtrTable;
    ptTCH: TNexPxTable;
    btFGLST: TNexBtrTable;
    btFGPALST: TNexBtrTable;
    btFGPADSC: TNexBtrTable;
    ptFGPADSC: TNexPxTable;
    btSMLST: TNexBtrTable;
    btMCH: TNexBtrTable;
    btMCI: TNexBtrTable;
    ptMCI: TNexPxTable;
    btMCN: TNexBtrTable;
    btTSN: TNexBtrTable;
    ptPLCDIF: TNexPxTable;
    btIMH: TNexBtrTable;
    btIMI: TNexBtrTable;
    btIMN: TNexBtrTable;
    ptIMI: TNexPxTable;
    ptSTOMOD: TNexPxTable;
    btOMH: TNexBtrTable;
    btOMI: TNexBtrTable;
    btOMN: TNexBtrTable;
    ptOMI: TNexPxTable;
    ptSTMDOC: TNexPxTable;
    ptTSH: TNexPxTable;
    ptSALHIS: TNexPxTable;
    btCMH: TNexBtrTable;
    btCMI: TNexBtrTable;
    btCMN: TNexBtrTable;
    ptCMI: TNexPxTable;
    btREBLST: TNexBtrTable;
    btREH: TNexBtrTable;
    btREI: TNexBtrTable;
    ptREI: TNexPxTable;
    btCMSPEC: TNexBtrTable;
    btSPCINF: TNexBtrTable;
    btSPMEAT: TNexBtrTable;
    btSPWINE: TNexBtrTable;
    btTSP: TNexBtrTable;
    btIMP: TNexBtrTable;
    btOMP: TNexBtrTable;
    btTCP: TNexBtrTable;
    ptBUYHIS: TNexPxTable;
    ptSTVTRN: TNexPxTable;
    btRMH: TNexBtrTable;
    btRMI: TNexBtrTable;
    btRMN: TNexBtrTable;
    ptRMI: TNexPxTable;
    btRMP: TNexBtrTable;
    btPSH: TNexBtrTable;
    btPSI: TNexBtrTable;
    btPSN: TNexBtrTable;
    ptPSI: TNexPxTable;
    ptPSH: TNexPxTable;
    ptIMH: TNexPxTable;
    ptOMH: TNexPxTable;
    ptRMH: TNexPxTable;
    ptCMH: TNexPxTable;
    btSTS: TNexBtrTable;
    btGSCIMG: TNexBtrTable;
    btACH: TNexBtrTable;
    btACI: TNexBtrTable;
    ptACI: TNexPxTable;
    btPKH: TNexBtrTable;
    btPKI: TNexBtrTable;
    ptPKI: TNexPxTable;
    btSEBLST: TNexBtrTable;
    btSEG: TNexBtrTable;
    btPCCGSC: TNexBtrTable;
    btPCCLST: TNexBtrTable;
    ptPCCGSC: TNexPxTable;
    btCRALST: TNexBtrTable;
    btPCCHIS: TNexBtrTable;
    btACDTMP: TNexBtrTable;
    ptACPLST: TNexPxTable;
    btPLH: TNexBtrTable;
    ptPLH: TNexPxTable;
    btPLS: TNexBtrTable;
    btACPLST: TLinkBtrTable;
    ptSTC: TNexPxTable;
    btMCRLST: TNexBtrTable;
    ptSTMCMP: TNexPxTable;
    ptFIFVER: TNexPxTable;
    btSEP: TNexBtrTable;
    btAFC: TNexBtrTable;
    btWRSLST: TNexBtrTable;
    btSCH: TNexBtrTable;
    btSCI: TNexBtrTable;
    ptSCI: TNexPxTable;
    btSCN: TNexBtrTable;
    btSCS: TNexBtrTable;
    ptSCS: TNexPxTable;
    btDMH: TNexBtrTable;
    ptDMH: TNexPxTable;
    btDMI: TNexBtrTable;
    ptDMI: TNexPxTable;
    btDMN: TNexBtrTable;
    btDMSPEC: TNexBtrTable;
    ptSAPGSL: TNexPxTable;
    btCLBLST: TNexBtrTable;
    btCLH: TNexBtrTable;
    ptSTCFIF: TNexPxTable;
    btPLD: TNexBtrTable;
    btWSBLST: TNexBtrTable;
    btWSH: TNexBtrTable;
    btWSI: TNexBtrTable;
    ptWSI: TNexPxTable;
    btMPL: TNexBtrTable;
    btALBLST: TNexBtrTable;
    btALH: TNexBtrTable;
    btALI: TNexBtrTable;
    btALN: TNexBtrTable;
    ptALI: TNexPxTable;
    btALPLST: TNexBtrTable;
    ptALIOUT: TNexPxTable;
    btBCSPAL: TNexBtrTable;
    btBCSGSL: TNexBtrTable;
    btWSGLST: TNexBtrTable;
    btDMPCLC: TNexBtrTable;
    ptSCDTRN: TNexPxTable;
    ptSCDEQU: TNexPxTable;
    ptSCDSPT: TNexPxTable;
    ptSMGEVL: TNexPxTable;
    btSMGGRP: TNexBtrTable;
    btSMGDEF: TNexBtrTable;
    btUDBLST: TNexBtrTable;
    btUDH: TNexBtrTable;
    btUDI: TNexBtrTable;
    ptUDI: TNexPxTable;
    btUDN: TNexBtrTable;
    btCPH: TNexBtrTable;
    btCPI: TNexBtrTable;
    ptCPI: TNexPxTable;
    btCPBLST: TNexBtrTable;
    btPNBLST: TNexBtrTable;
    btPND: TNexBtrTable;
    btAPLLST: TNexBtrTable;
    btAPLITM: TNexBtrTable;
    ptSCH: TNexPxTable;
    ptSCDSUM: TNexPxTable;
    ptCADWSI: TNexPxTable;
    btPKCLST: TNexBtrTable;
    ptAQOITM: TNexPxTable;
    ptAQOQTC: TNexPxTable;
    ptWSH: TNexPxTable;
    btAGRLST: TNexBtrTable;
    btAGRITM: TNexBtrTable;
    ptSTKOPG: TNexPxTable;
    ptSTKOP: TNexPxTable;
    btGSCOTN: TNexBtrTable;
    btGSLANG: TNexBtrTable;
    btBOOKOTN: TNexBtrTable;
    ptPND: TNexPxTable;
    ptPALST: TNexPxTable;
    btGSCAT: TNexBtrTable;
    btSTS2: TNexBtrTable;
    btALC: TNexBtrTable;
    ptCDI: TNexPxTable;
    ptCDMPDS: TNexPxTable;
    ptCDMSUM: TNexPxTable;
    ptCDMCPS: TNexPxTable;
    btCDH: TNexBtrTable;
    btCDI: TNexBtrTable;
    btCDM: TNexBtrTable;
    btCDN: TNexBtrTable;
    ptIVD: TNexPxTable;
    btTRDINC: TNexBtrTable;
    btTRDINV: TNexBtrTable;
    btTRDOUT: TNexBtrTable;
    btSTB: TNexBtrTable;
    btSGLST: TNexBtrTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure btSTKBeforePost(DataSet: TDataSet);
    procedure ptSMEVALBeforePost(DataSet: TDataSet);
    procedure ptBARCODEBeforeOpen(DataSet: TDataSet);
    procedure T_StkDatTimer(Sender: TObject);
    procedure btFIFBeforePost(DataSet: TDataSet);
    procedure ptIVIBeforePost(DataSet: TDataSet);
    procedure btIVDBeforePost(DataSet: TDataSet);
    procedure ptIVMGSUMBeforeOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure btOCIxBeforeDelete(DataSet: TDataSet);
    procedure ptALIAfterScroll(DataSet: TDataSet);
    procedure ptALIBeforePost(DataSet: TDataSet);
    procedure btSTKLSTAfterOpen(DataSet: TDataSet);
    procedure btPLSLSTAfterOpen(DataSet: TDataSet);
  private
    oOutFifos:TList;  // Fifo karty a mnoûstv· ktorÈ bud˙ vydahÈ zo skladu
    oSlcFifos:TList;  // Fifo karty a mnoûstv· ktorÈ boli vybrane
    oOutFifData:^TOutFifData;  // Datov· zloûka zoznamu oOutFifos
    oSlcFifData:^TOutFifData;  // Datov· zloûka vybranej fifo karty

    oActStkNum  :longint;  // »Ìslo otvoreneho skladu
    oActPlsNum  :longint;  // »Ìslo otvoreneho cennika
    oActOcbNum  :Str5;  // »Ìslo otvorenej knihy odberatelskych objednavok
    oActPcbNum  :Str5;  // »Ìslo otvorenej knihy odberatelskych zalohovych FA
    oActImbNum  :Str5;  // »Ìslo otvorenej knihy internych prijemok
    oActOmbNum  :Str5;  // »Ìslo otvorenej knihy internych vydajok
  public
    procedure OpenStkFiles  (pStkNum:longint);
    procedure CloseStkFiles; // Uzatvori STK, STM a DID

    procedure LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
    procedure OpenBase (var pTable:TNexBtrTable);
    procedure OpenList (var pTable:TNexBtrTable; pListNum:longint);
    procedure OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);

    procedure ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
    procedure AddToOutFifos (pFifNum,pActPos:longint; pOutQnt,pOutPrice:double;pAcqStat:Str1;pDocDate,pDrbDate:TDateTime);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
    procedure PutOutFifQnt (pIndex:word;pValue:double); // UloûÌ zadanÈ mnoûstvo na do zadanej fifo karty
    procedure ClearSlcFifos; // Vymazanie ˙dajov vybranych Fifo kariet
    procedure AddToSlcFifos (pFifNum,pActPos:longint; pOutQnt,pOutPrice:double;pAcqStat:Str1;pDocDate,pDrbDate:TDateTime);  // Prid· z·znam do zoznamu vybranych Fifo kariet
    procedure AddSlcToOutFif; // Ak boli vyrane nejake FIFO karty prida do zoznamu ktore budu odpocitane

    function GetOutFifNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
    function GetOutPaCode(pIndex:word): longint; // PoradovÈ ËÌslo firmy, ktora dodala tovar
    function GetOutFifPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
    function GetOutFifQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
    function GetOutFifDat(pIndex:word): TDateTime; // D·tum prÌjmu
    function GetOutAcqStat(pIndex:word): Str1; // Priznak obstarania tovaru
    function GetOutActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
    function GetOutFifosQnt: double; // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
    function GetOutFifValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
    function GetOutFifCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj
    function GetOutDrbDate: TDateTime; // Datum nejmensej trvanlivosti

    procedure OpenSTK  (pStkNum:longint);
    procedure OpenSTM  (pStkNum:longint);
    procedure OpenFIF  (pStkNum:longint);
    procedure OpenSTP  (pStkNum:longint);
    procedure OpenSTB  (pStkNum:longint);
//    procedure OpenSTO  (pStkNum:longint);

    procedure OpenPCH  (pBookNum:Str5);
    procedure OpenPCI  (pBookNum:Str5);
    procedure OpenPCN  (pBookNum:Str5);

    procedure OpenIVC  (pSerNum:word);
    procedure OpenIVL  (pSerNum:word);
    procedure OpenIVI  (pSerNum:word);
    procedure OpenIVD  (pSerNum:word);
    procedure OpenIVN  (pSerNum:word);
    procedure OpenIVP  (pSerNum:word);
    procedure OpenIVM  (pSerNum:word);

    procedure GSCAT_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btGSCAT do ptGSCAT
    procedure GSCAT_To_PLS (var btPLS:TNexBtrTable); // Ulozi zaznam z btGSCAT do btPLS
    procedure GSCAT_To_STK (var btSTK:TNexBtrTable); // Ulozi zaznam z btGSCAT do btSTK
    procedure STP_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btSTK do ptSTK
    procedure FIF_To_TMP; // Ulozi zaznam z btFIF do ptFIF
    procedure STM_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btSTM do ptSTM
    procedure TCI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTCI do ptTCI
    procedure MCI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btMCI do ptMCI
    procedure REI_To_TMP; // Ulozi zaznam z btREI do ptREI
    procedure ACI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btACI do ptACI
    procedure TSI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSI do ptTSI
    procedure IMI_To_TMP; // Ulozi zaznam z btIMI do ptIMI
    procedure OMI_To_TMP; // Ulozi zaznam z btOMI do ptOMI
    procedure FGPADSC_To_TMP; // Ulozi zaznam z btFGPADSC do ptFGPADSC

    function GetActStkNum: longint;
  end;

var dmSTK: TdmSTK;

implementation

{$R *.DFM}

//***************************** SYSTEM ******************************
procedure TdmSTK.DataModuleCreate(Sender: TObject);
var I: longint;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TNexBtrTable) then begin
      (Components[I] as TNexBtrTable).DatabaseName:=gPath.StkPath;
      (Components[I] as TNexBtrTable).DefPath:=gPath.DefPath;
    end;
    If (Components[I] is TNexTmpTable) then begin
      (Components[I] as TNexTmpTable).DatabaseName:=gPath.SubPrivPath;
      (Components[I] as TNexTmpTable).DefPath:=gPath.DefPath;
    end;
    If (Components[I] is TPxTmpTable) then (Components[I] as TPxTmpTable).DatabaseName:=gPath.SubPrivPath;
  end;
  oOutFifos:=TList.Create;
  oSlcFifos:=TList.Create;
end;

procedure TdmSTK.T_StkDatTimer(Sender: TObject);
var I: integer;
begin
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TBtrieveTable) then begin
      If (Components[I] as TBtrieveTable).Active and ((Components[I] as TBtrieveTable).State = dsBrowse) then (Components[I] as TBtrieveTable).Refresh;
    end;
   end;
end;

procedure TdmSTK.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil (oSlcFifos);
  FreeAndNil (oOutFifos);
end;

//*******************************************************************
procedure TdmSTK.OpenStkFiles (pStkNum:longint); // Otvoori STK, STM a DID
begin
  If cNexStart then pStkNum:=1;
  If (oActStkNum<>pStkNum) or not dmSTK.btSTK.Active then begin
    oActStkNum:=pStkNum;
    dmSTK.OpenSTK (pStkNum);
    dmSTK.OpenSTM (pStkNum);
    dmSTK.OpenSTB (pStkNum);
    dmSTK.OpenFIF (pStkNum);
//    dmSTK.OpenSTO (pStkNum);
  end;
  If not dmSTK.btSTK.Active or (dmSTK.btSTK.TableName <> dmSTK.btSTK.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTK (pStkNum);
  If not dmSTK.btSTM.Active or (dmSTK.btSTM.TableName <> dmSTK.btSTM.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTM (pStkNum);
  If not dmSTK.btSTB.Active or (dmSTK.btSTB.TableName <> dmSTK.btSTB.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTB (pStkNum);
  If not dmSTK.btFIF.Active or (dmSTK.btFIF.TableName <> dmSTK.btFIF.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenFIF (pStkNum);
//  If not dmSTK.btSTO.Active or (dmSTK.btSTO.TableName <> dmSTK.btSTO.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTO (pStkNum);
end;

procedure TdmSTK.CloseStkFiles; // Uzatvori STK, STM a DID
begin
  oActStkNum:=0;
  If dmSTK.btSTK.Active then dmSTK.btSTK.Close;
  If dmSTK.btSTM.Active then dmSTK.btSTM.Close;
  If dmSTK.btSTB.Active then dmSTK.btSTB.Close;
  If dmSTK.btFIF.Active then dmSTK.btFIF.Close;
//  If dmSTK.btSTO.Active then dmSTK.btSTO.Close;
end;

procedure TdmSTK.LoadDefaultProperty (var pTable:TNexBtrTable); // Ak existuje databaza na tomto datamodule pod tym istym meno procedure prekopiruje jeho zakladne parametre do pTable
var mTable:TNexBtrTable;
begin
  mTable:=(FindComponent (pTable.Name)) as TNexBtrTable;
  If mTable<>nil then begin // Nasli sme databazu
    pTable.DefName:=mTable.DefName;
    pTable.FixedName:=mTable.FixedName;
    pTable.TableName:=mTable.TableName;
  end;
end;

procedure TdmSTK.OpenBase (var pTable:TNexBtrTable);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.DefPath:=gPath.DefPath;
  pTable.DataBaseName:=gPath.StkPath;
  pTable.Open;
end;

procedure TdmSTK.OpenList (var pTable:TNexBtrTable; pListNum:longint);
begin
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.ListNum:=pListNum;
  pTable.BookNum:=StrIntZero(pListNum,5);
  pTable.DefPath:=gPath.DefPath;
  pTable.DataBaseName:=gPath.StkPath;
  pTable.TableName:=pTable.FixedName+pTable.BookNum;
  pTable.Open;
end;

procedure TdmSTK.OpenBook (var pTable:TNexBtrTable; pBookNum:Str5);
begin
  If pTable.Active and (pTable.BookNum=pBookNum) then Exit;
  If pTable.Active then pTable.Close;
  LoadDefaultProperty (pTable);
  pTable.BookNum:=pBookNum;
  pTable.DefPath:=gPath.DefPath;
  pTable.DataBaseName:=gPath.StkPath;
  pTable.TableName:=pTable.FixedName+pBookNum;
  pTable.Open;
end;

procedure TdmSTK.ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
var I:word;
begin
  If oOutFifos.Count>0 then begin
    For I:=0 to (oOutFifos.Count-1) do begin
      oOutFifData:=oOutFifos.Items[I];
      Dispose(oOutFifData);
    end;
    oOutFifos.Clear;
  end;
end;

procedure TdmSTK.AddToOutFifos(pFifNum,pActPos:longint; pOutQnt,pOutPrice:double;pAcqStat:Str1;pDocDate,pDrbDate:TDateTime);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
begin
  New (oOutFifData);
  oOutFifData^.FifNum:=pFifNum;
  oOutFifData^.PaCode:=0;
  oOutFifData^.ActPos:=pActPos;
  oOutFifData^.OutQnt:=pOutQnt;
  oOutFifData^.OutPrice:=pOutPrice;
  oOutFifData^.AcqStat:=pAcqStat;
  oOutFifData^.DocDate:=pDocDate;
  oOutFifData^.DrbDate:=pDrbDate;
  oOutFifos.Add (oOutFifData);
end;

procedure TdmSTK.ClearSlcFifos; // Vymazanie ˙dajov vybranych Fifo
var I:word;
begin
  If oSlcFifos.Count>0 then begin
    For I:=0 to (oSlcFifos.Count-1) do begin
      oSlcFifData:=oSlcFifos.Items[I];
      Dispose(oSlcFifData);
    end;
    oSlcFifos.Clear;
  end;
end;

procedure TdmSTK.AddToSlcFifos (pFifNum,pActPos:longint; pOutQnt,pOutPrice:double;pAcqStat:Str1;pDocDate,pDrbDate:TDateTime);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
begin
  New (oSlcFifData);
  oSlcFifData^.FifNum:=pFifNum;
  oSlcFifData^.PaCode:=0;
  oSlcFifData^.ActPos:=pActPos;
  oSlcFifData^.OutQnt:=pOutQnt;
  oSlcFifData^.OutPrice:=pOutPrice;
  oSlcFifData^.AcqStat:=pAcqStat;
  oSlcFifData^.DocDate:=pDocDate;
  oSlcFifData^.DrbDate:=pDrbDate;
  oSlcFifos.Add (oSlcFifData);
end;

procedure TdmSTK.AddSlcToOutFif; // Ak boli vyrane nejake FIFO karty prida do zoznamu ktore budu odpocitane
var I:word;
begin
  If oSlcFifos.Count>0 then begin
    For I:=0 to (oSlcFifos.Count-1) do begin
      oSlcFifData:=oSlcFifos.Items[I];
      AddToOutFifos (oSlcFifData^.FifNum,oSlcFifData^.ActPos,oSlcFifData^.OutQnt,oSlcFifData^.OutPrice,oSlcFifData^.AcqStat,oSlcFifData^.DocDate,oSlcFifData^.DrbDate);
    end;
    ClearSlcFifos; // Vymazanie ˙dajov vybranych Fifo
  end;
end;

procedure TdmSTK.PutOutFifQnt (pIndex:word;pValue:double);
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  oOutFifData^.OutQnt:=pValue;
end;

function TdmSTK.GetOutFifNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.FifNum;
end;

function TdmSTK.GetOutPaCode(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.PaCode;
end;

function TdmSTK.GetOutFifPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.OutPrice;
end;

function TdmSTK.GetOutFifQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.OutQnt;
end;

function TdmSTK.GetOutFifDat(pIndex:word): TDateTime; // D·tum prÌjmu
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.DocDate;
end;

function TdmSTK.GetOutAcqStat(pIndex:word): Str1; // Priznak obstarania tovaru
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.AcqStat;
end;

function TdmSTK.GetOutActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.ActPos;
end;

function TdmSTK.GetOutFifosQnt:double;  // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
var I:longint;
begin
  Result:=0;
  For I:=1 to oOutFifos.Count do begin
    Result:=Result+GetOutFifQnt(I);
  end;
end;

function TdmSTK.GetOutFifValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
var I:longint;
begin
  Result:=0;
  For I:=1 to oOutFifos.Count do
    Result:=Result+GetOutFifQnt(I)*GetOutFifPrice (I);
end;

function TdmSTK.GetOutFifCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj
begin
  Result:=oOutFifos.Count;
end;

function TdmSTK.GetOutDrbDate: TDateTime;  // Datum nejmensej trvanlivosti
var I:longint;
begin
  oOutFifData:=oOutFifos.Items[0];
  Result:=oOutFifData^.DrbDate;
  For I:=1 to oOutFifos.Count-1 do begin
    oOutFifData:=oOutFifos.Items[I];
    If Result>oOutFifData^.DrbDate then Result:=oOutFifData^.DrbDate;
  end;
end;

procedure TdmSTK.OpenSTK(pStkNum: longint);
begin
  If cNexStart then pStkNum:=1;
  oActStkNum:=pStkNum;
  If btSTK.Active then btSTK.Close;
  btSTK.TableName:=btSTK.FixedName+StrIntZero(pStkNum,5);
  btSTK.Open;
end;

procedure TdmSTK.OpenSTM(pStkNum: longint);
begin
  If cNexStart then pStkNum:=1;
  oActStkNum:=pStkNum;
  If btSTM.Active then btSTM.Close;
  btSTM.TableName:=btSTM.FixedName+StrIntZero(pStkNum,5);
  btSTM.Open;
end;

procedure TdmSTK.OpenFIF(pStkNum: longint);
begin
  If cNexStart then pStkNum:=1;
  oActStkNum:=pStkNum;
  If btFIF.Active then btFIF.Close;
  btFIF.TableName:=btFIF.FixedName+StrIntZero(pStkNum,5);
  btFIF.Open;
end;

procedure TdmSTK.OpenSTP(pStkNum: longint);
begin
  If cNexStart then pStkNum:=1;
  oActStkNum:=pStkNum;
  If btSTP.Active then btSTP.Close;
  btSTP.TableName:=btSTP.FixedName+StrIntZero(pStkNum,5);
  btSTP.Open;
end;

procedure TdmSTK.OpenSTB(pStkNum: longint);
begin
  If cNexStart then pStkNum:=1;
  oActStkNum:=pStkNum;
  If btSTB.Active then btSTB.Close;
  btSTB.TableName:=btSTB.FixedName+StrIntZero(pStkNum,5);
  btSTB.Open;
end;

procedure TdmSTK.OpenPCH (pBookNum:Str5);
begin
  oActPcbNum:=pBookNum;
  If btPCH.Active then btPCH.Close;
  btPCH.TableName:=btPCH.FixedName+pBookNum;
  btPCH.Open;
end;

procedure TdmSTK.OpenPCI (pBookNum:Str5);
begin
  If btPCI.Active then btPCI.Close;
  btPCI.TableName:=btPCI.FixedName+pBookNum;
  btPCI.Open;
end;

procedure TdmSTK.OpenPCN (pBookNum:Str5);
begin
  If btPCN.Active then btPCN.Close;
  btPCN.TableName:=btPCN.FixedName+pBookNum;
  btPCN.Open;
end;

procedure TdmSTK.OpenIVC (pSerNum:word);
begin
  If btIVC.Active then btIVC.Close;
  btIVC.TableName:=btIVC.FixedName+StrIntZero(pSerNum,5);
  btIVC.Open;
end;

procedure TdmSTK.OpenIVL (pSerNum:word);
begin
  If btIVL.Active then btIVL.Close;
  btIVL.TableName:=btIVL.FixedName+StrIntZero(pSerNum,5);
  btIVL.Open;
end;

procedure TdmSTK.OpenIVI (pSerNum:word);
begin
  If btIVI.Active then btIVI.Close;
  btIVI.TableName:=btIVI.FixedName+StrIntZero(pSerNum,5);
  btIVI.Open;
end;

procedure TdmSTK.OpenIVD (pSerNum:word);
begin
  If btIVD.Active then btIVD.Close;
  btIVD.TableName:=btIVD.FixedName+StrIntZero(pSerNum,5);
  btIVD.Open;
end;

procedure TdmSTK.OpenIVN (pSerNum:word);
begin
  If btIVN.Active then btIVN.Close;
  btIVN.TableName:=btIVN.FixedName+StrIntZero(pSerNum,5);
  btIVN.Open;
end;

procedure TdmSTK.OpenIVP (pSerNum:word);
begin
  If btIVP.Active then btIVP.Close;
  btIVP.TableName:=btIVP.FixedName+StrIntZero(pSerNum,5);
  btIVP.Open;
end;

procedure TdmSTK.OpenIVM (pSerNum:word);
begin
  If btIVM.Active then btIVM.Close;
  btIVM.TableName:=btIVM.FixedName+StrIntZero(pSerNum,5);
  btIVM.Open;
end;

procedure TdmSTK.GSCAT_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btGSCAT do ptGSCAT
begin
  pPxTable.FieldByName('GsCode').AsInteger:=pBtTable.FieldByName('GsCode').AsInteger;
  pPxTable.FieldByName('GsName').AsString:=pBtTable.FieldByName('GsName').AsString;
  pPxTable.FieldByName('MgCode').AsInteger:=pBtTable.FieldByName('MgCode').AsInteger;
  pPxTable.FieldByName('BarCode').AsString:=pBtTable.FieldByName('BarCode').AsString;
  pPxTable.FieldByName('SbcCnt').AsInteger:=pBtTable.FieldByName('SbcCnt').AsInteger;
  pPxTable.FieldByName('StkCode').AsString:=pBtTable.FieldByName('StkCode').AsString;
  pPxTable.FieldByName('MsName').AsString:=pBtTable.FieldByName('MsName').AsString;
  pPxTable.FieldByName('PackGs').AsInteger:=pBtTable.FieldByName('PackGs').AsInteger;
  pPxTable.FieldByName('GsType').AsString:=pBtTable.FieldByName('GsType').AsString;
  pPxTable.FieldByName('DrbMust').AsInteger:=pBtTable.FieldByName('DrbMust').AsInteger;
  pPxTable.FieldByName('PdnMust').AsInteger:=pBtTable.FieldByName('PdnMust').AsInteger;
  pPxTable.FieldByName('GrcMth').AsInteger:=pBtTable.FieldByName('GrcMth').AsInteger;
  pPxTable.FieldByName('VatPrc').AsFloat:=pBtTable.FieldByName('VatPrc').AsFloat;
  pPxTable.FieldByName('Volume').AsFloat:=pBtTable.FieldByName('Volume').AsFloat;
  pPxTable.FieldByName('Weight').AsFloat:=pBtTable.FieldByName('Weight').AsFloat;
  pPxTable.FieldByName('MsuQnt').AsFloat:=pBtTable.FieldByName('MsuQnt').AsFloat;
  pPxTable.FieldByName('MsuName').AsString:=pBtTable.FieldByName('MsuName').AsString;
  pPxTable.FieldByName('ModNum').AsInteger:=pBtTable.FieldByName('ModNum').AsInteger;
  pPxTable.FieldByName('ModUser').AsString:=pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime:=pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime:=pBtTable.FieldByName('ModTime').AsDateTime;
  If dmSTK.btSPMEAT.Active then begin
    If dmSTK.btSPMEAT.FindKey ([pBtTable.FieldByName('GsCode').AsInteger]) then begin
      pPxTable.FieldByName('MeType').AsString:=dmSTK.btSPMEAT.FieldByName('MeType').AsString;
      pPxTable.FieldByName('MePart').AsString:=dmSTK.btSPMEAT.FieldByName('MePart').AsString;
      pPxTable.FieldByName('MeStat').AsInteger:=dmSTK.btSPMEAT.FieldByName('MeStat').AsInteger;
      pPxTable.FieldByName('MeProc').AsString:=dmSTK.btSPMEAT.FieldByName('MeProc').AsString;
    end;
  end;
end;

procedure TdmSTK.GSCAT_To_PLS (var btPLS:TNexBtrTable); // Ulozi zaznam z btGSCAT do btPLS
begin
  btPLS.FieldByName('GsCode').AsInteger:=dmSTK.btGSCAT.FieldByName('GsCode').AsInteger;
  btPLS.FieldByName('GsName').AsString:=dmSTK.btGSCAT.FieldByName('GsName').AsString;
  btPLS.FieldByName('MgCode').AsInteger:=dmSTK.btGSCAT.FieldByName('MgCode').AsInteger;
  btPLS.FieldByName('FgCode').AsInteger:=dmSTK.btGSCAT.FieldByName('FgCode').AsInteger;
  btPLS.FieldByName('BarCode').AsString:=dmSTK.btGSCAT.FieldByName('BarCode').AsString;
  btPLS.FieldByName('StkCode').AsString:=dmSTK.btGSCAT.FieldByName('StkCode').AsString;
  btPLS.FieldByName('MsName').AsString:=dmSTK.btGSCAT.FieldByName('MsName').AsString;
  btPLS.FieldByName('PackGs').AsInteger:=dmSTK.btGSCAT.FieldByName('PackGs').AsInteger;
  btPLS.FieldByName('GsType').AsString:=dmSTK.btGSCAT.FieldByName('GsType').AsString;
  btPLS.FieldByName('PdnMust').AsInteger:=dmSTK.btGSCAT.FieldByName('PdnMust').AsInteger;
  btPLS.FieldByName('DrbMust').AsInteger:=dmSTK.btGSCAT.FieldByName('DrbMust').AsInteger;
  btPLS.FieldByName('GrcMth').AsInteger:=dmSTK.btGSCAT.FieldByName('GrcMth').AsInteger;
  btPLS.FieldByName('VatPrc').AsFloat:=dmSTK.btGSCAT.FieldByName('VatPrc').AsFloat;
end;

procedure TdmSTK.GSCAT_To_STK (var btSTK:TNexBtrTable); // Ulozi zaznam z btGSCAT do btSTK
begin
  btSTK.FieldByName('GsCode').AsInteger:=dmSTK.btGSCAT.FieldByName('GsCode').AsInteger;
  btSTK.FieldByName('GsName').AsString:=dmSTK.btGSCAT.FieldByName('GsName').AsString;
  btSTK.FieldByName('MgCode').AsInteger:=dmSTK.btGSCAT.FieldByName('MgCode').AsInteger;
  btSTK.FieldByName('FgCode').AsInteger:=dmSTK.btGSCAT.FieldByName('FgCode').AsInteger;
  btSTK.FieldByName('BarCode').AsString:=dmSTK.btGSCAT.FieldByName('BarCode').AsString;
  btSTK.FieldByName('StkCode').AsString:=dmSTK.btGSCAT.FieldByName('StkCode').AsString;
  btSTK.FieldByName('MsName').AsString:=dmSTK.btGSCAT.FieldByName('MsName').AsString;
  btSTK.FieldByName('GsType').AsString:=dmSTK.btGSCAT.FieldByName('GsType').AsString;
  btSTK.FieldByName('PdnMust').AsInteger:=dmSTK.btGSCAT.FieldByName('PdnMust').AsInteger;
  btSTK.FieldByName('DrbMust').AsInteger:=dmSTK.btGSCAT.FieldByName('DrbMust').AsInteger;
  btSTK.FieldByName('GrcMth').AsInteger:=dmSTK.btGSCAT.FieldByName('GrcMth').AsInteger;
  btSTK.FieldByName('VatPrc').AsFloat:=dmSTK.btGSCAT.FieldByName('VatPrc').AsFloat;
end;

procedure TdmSTK.STP_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btSTP do ptSTP
begin
  pPxTable.FieldByName ('ProdNum').AsString:=pBtTable.FieldByName ('ProdNum').AsString;
  pPxTable.FieldByName ('GsCode').AsInteger:=pBtTable.FieldByName ('GsCode').AsInteger;
  If pBtTable.FieldByName ('InDocNum').AsString<>'' then begin
    pPxTable.FieldByName ('InDocDate').AsDateTime:=pBtTable.FieldByName ('InDocDate').AsDateTime;
    pPxTable.FieldByName ('InDocNum').AsString:=pBtTable.FieldByName ('InDocNum').AsString;
    pPxTable.FieldByName ('InItmNum').AsInteger:=pBtTable.FieldByName ('InItmNum').AsInteger;
  end;
  pPxTable.FieldByName ('OutDocDate').AsDateTime:=pBtTable.FieldByName ('OutDocDate').AsDateTime;
  pPxTable.FieldByName ('OutDocNum').AsString:=pBtTable.FieldByName ('OutDocNum').AsString;
  pPxTable.FieldByName ('OutItmNum').AsInteger:=pBtTable.FieldByName ('OutItmNum').AsInteger;
  pPxTable.FieldByName ('Status').AsString:=pBtTable.FieldByName ('Status').AsString;
  pPxTable.FieldByName ('ActPos').AsInteger:=pBtTable.ActPos;
end;

procedure TdmSTK.FIF_To_TMP; // Ulozi zaznam z btFIF do ptFIF
begin
  dmSTK.ptFIF.FieldByName ('FifNum').AsInteger:=dmSTK.btFIF.FieldByName ('FifNum').AsInteger;
  dmSTK.ptFIF.FieldByName ('DocNum').AsString:=dmSTK.btFIF.FieldByName ('DocNum').AsString;
  dmSTK.ptFIF.FieldByName ('ItmNum').AsInteger:=dmSTK.btFIF.FieldByName ('ItmNum').AsInteger;
  dmSTK.ptFIF.FieldByName ('GsCode').AsInteger:=dmSTK.btFIF.FieldByName ('GsCode').AsInteger;
  dmSTK.ptFIF.FieldByName ('DocDate').AsDateTime:=dmSTK.btFIF.FieldByName ('DocDate').AsDateTime;
  dmSTK.ptFIF.FieldByName ('DrbDate').AsDateTime:=dmSTK.btFIF.FieldByName ('DrbDate').AsDateTime;
  dmSTK.ptFIF.FieldByName ('InPrice').AsFloat:=dmSTK.btFIF.FieldByName ('InPrice').AsFloat;
  dmSTK.ptFIF.FieldByName ('InQnt').AsFloat:=dmSTK.btFIF.FieldByName ('InQnt').AsFloat;
  dmSTK.ptFIF.FieldByName ('OutQnt').AsFloat:=dmSTK.btFIF.FieldByName ('OutQnt').AsFloat;
  dmSTK.ptFIF.FieldByName ('ActQnt').AsFloat:=dmSTK.btFIF.FieldByName ('ActQnt').AsFloat;
  dmSTK.ptFIF.FieldByName ('Status').AsString:=dmSTK.btFIF.FieldByName ('Status').AsString;
  dmSTK.ptFIF.FieldByName ('Sended').AsInteger:=dmSTK.btFIF.FieldByName ('Sended').AsInteger;
  dmSTK.ptFIF.FieldByName ('AcqStat').AsString:=dmSTK.btFIF.FieldByName ('AcqStat').AsString;
  dmSTK.ptFIF.FieldByName ('ActPos').AsInteger:=dmSTK.btFIF.ActPos;
end;

procedure TdmSTK.STM_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btSTM do ptSTM
begin
  pPxTable.FieldByName ('StmNum').AsInteger:=pBtTable.FieldByName ('StmNum').AsInteger;
  pPxTable.FieldByName ('DocNum').AsString:=pBtTable.FieldByName ('DocNum').AsString;
  pPxTable.FieldByName ('ItmNum').AsInteger:=pBtTable.FieldByName ('ItmNum').AsInteger;
  pPxTable.FieldByName ('GsCode').AsInteger:=pBtTable.FieldByName ('GsCode').AsInteger;
  pPxTable.FieldByName ('GsName').AsString:=pBtTable.FieldByName ('GsName').AsString;
  pPxTable.FieldByName ('DocDate').AsDateTime:=pBtTable.FieldByName ('DocDate').AsDateTime;
  pPxTable.FieldByName ('SmCode').AsInteger:=pBtTable.FieldByName ('SmCode').AsInteger;
  pPxTable.FieldByName ('FifNum').AsInteger:=pBtTable.FieldByName ('FifNum').AsInteger;
  pPxTable.FieldByName ('GsQnt').AsFloat:=pBtTable.FieldByName ('GsQnt').AsFloat;
  pPxTable.FieldByName ('CValue').AsFloat:=pBtTable.FieldByName ('CValue').AsFloat;
  If IsNotNul (pBtTable.FieldByName ('GsQnt').AsFloat)
    then pPxTable.FieldByName ('CPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName ('CValue').AsFloat/pBtTable.FieldByName ('GsQnt').AsFloat);
  pPxTable.FieldByName ('BValue').AsFloat:=pBtTable.FieldByName ('BValue').AsFloat;
  pPxTable.FieldByName ('OcdNum').AsString:=pBtTable.FieldByName ('OcdNum').AsString;
  pPxTable.FieldByName ('OcdItm').AsInteger:=pBtTable.FieldByName ('OcdItm').AsInteger;
  pPxTable.FieldByName ('PaCode').AsInteger:=pBtTable.FieldByName ('PaCode').AsInteger;
  pPxTable.FieldByName ('Sended').AsInteger:=pBtTable.FieldByName ('Sended').AsInteger;
  pPxTable.FieldByName ('AcqStat').AsString:=pBtTable.FieldByName ('AcqStat').AsString;
  pPxTable.FieldByName ('ModUser').AsString:=pBtTable.FieldByName ('ModUser').AsString;
  pPxTable.FieldByName ('ModDate').AsDateTime:=pBtTable.FieldByName ('ModDate').AsDateTime;
  pPxTable.FieldByName ('ModTime').AsDateTime:=pBtTable.FieldByName ('ModTime').AsDateTime;
  pPxTable.FieldByName ('ActPos').AsInteger:=pBtTable.ActPos;
end;

(*
procedure TdmSTK.OCI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btOCI do ptOCI
begin
  BTR_To_PX (pBtTable,pPxTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  // Ulozime specialne pole do docasneho suboru  OCI.tDF
  pPxTable.FieldByName('AcDPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
  pPxTable.FieldByName('AcCPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
  pPxTable.FieldByName('AcAPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
  pPxTable.FieldByName('AcBPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
  pPxTable.FieldByName('AcAValue').AsFloat:=pBtTable.FieldByName('AcAValue').AsFloat;
  pPxTable.FieldByName('AcBValue').AsFloat:=pBtTable.FieldByName('AcBValue').AsFloat;
  pPxTable.FieldByName('FgAPrice').AsFloat:=pBtTable.FieldByName('FgAPrice').AsFloat;
  pPxTable.FieldByName('FgBPrice').AsFloat:=pBtTable.FieldByName('FgBPrice').AsFloat;
  pPxTable.FieldByName('FgAValue').AsFloat:=pBtTable.FieldByName('FgAValue').AsFloat;
  pPxTable.FieldByName('FgBValue').AsFloat:=pBtTable.FieldByName('FgBValue').AsFloat;
  pPxTable.FieldByName('Volume').AsFloat:=pBtTable.FieldByName('Volume').AsFloat;
  pPxTable.FieldByName('Weight').AsFloat:=pBtTable.FieldByName('Weight').AsFloat;
  pPxTable.FieldByName('PackGs').AsInteger:=pBtTable.FieldByName('PackGs').AsInteger;
  pPxTable.FieldByName('GsType').AsString:=pBtTable.FieldByName('GsType').AsString;
  pPxTable.FieldByName('OrdQnt').AsFloat:=pBtTable.FieldByName('OrdQnt').AsFloat;
  pPxTable.FieldByName('DlrCode').AsInteger:=pBtTable.FieldByName('DlrCode').AsInteger;
  pPxTable.FieldByName('McdNum').AsString:=pBtTable.FieldByName('McdNum').AsString;
  pPxTable.FieldByName('McdItm').AsInteger:=pBtTable.FieldByName('McdItm').AsInteger;
  pPxTable.FieldByName('TcdNum').AsString:=pBtTable.FieldByName('TcdNum').AsString;
  pPxTable.FieldByName('TcdItm').AsInteger:=pBtTable.FieldByName('TcdItm').AsInteger;
  pPxTable.FieldByName('IcdNum').AsString:=pBtTable.FieldByName('IcdNum').AsString;
  pPxTable.FieldByName('IcdItm').AsInteger:=pBtTable.FieldByName('IcdItm').AsInteger;
  pPxTable.FieldByName('IcdDate').AsDateTime:=pBtTable.FieldByName('IcdDate').AsDateTime;
  pPxTable.FieldByName('StkStat').AsString:=pBtTable.FieldByName('StkStat').AsString;
  pPxTable.FieldByName('FinStat').AsString:=pBtTable.FieldByName('FinStat').AsString;
  pPxTable.FieldByName('Action').AsString:=pBtTable.FieldByName('Action').AsString;
end;
*)

procedure TdmSTK.TCI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTCI do ptTCI
begin
  BTR_To_PX (pBtTable,pPxTable);
  // Ulozime specialne pole do docasneho suboru
  If IsNotNul (pBtTable.FieldByName('GsQnt').AsFloat) then begin
//    pPxTable.FieldByName('AcDPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcCPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcAPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcBPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
  end;
end;

procedure TdmSTK.MCI_To_TMP(pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btMCI do ptMCI
begin
  BTR_To_PX (pBtTable,pPxTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  // Ulozime specialne pole do docasneho suboru
  If IsNotNul(pBtTable.FieldByName('GsQnt').AsFloat) then begin
    pPxTable.FieldByName('AcDPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcCPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcAPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcBPrice').AsFloat:=Rd2(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
  end;
  pPxTable.FieldByName('AcAValue').AsFloat:=pBtTable.FieldByName('AcAValue').AsFloat;
  pPxTable.FieldByName('AcBValue').AsFloat:=pBtTable.FieldByName('AcBValue').AsFloat;
  pPxTable.FieldByName('FgAPrice').AsFloat:=pBtTable.FieldByName('FgAPrice').AsFloat;
  pPxTable.FieldByName('FgBPrice').AsFloat:=pBtTable.FieldByName('FgBPrice').AsFloat;
  pPxTable.FieldByName('FgAValue').AsFloat:=pBtTable.FieldByName('FgAValue').AsFloat;
  pPxTable.FieldByName('FgBValue').AsFloat:=pBtTable.FieldByName('FgBValue').AsFloat;
  pPxTable.FieldByName('Volume').AsFloat:=pBtTable.FieldByName('Volume').AsFloat;
  pPxTable.FieldByName('Weight').AsFloat:=pBtTable.FieldByName('Weight').AsFloat;
  pPxTable.FieldByName('PackGs').AsInteger:=pBtTable.FieldByName('PackGs').AsInteger;
  pPxTable.FieldByName('GsType').AsString:=pBtTable.FieldByName('GsType').AsString;
  pPxTable.FieldByName('GsQnt').AsFloat:=pBtTable.FieldByName('GsQnt').AsFloat;
  pPxTable.FieldByName('OfrQnt').AsString:=pBtTable.FieldByName('OfrQnt').AsString;
  pPxTable.FieldByName('DlrCode').AsInteger:=pBtTable.FieldByName('DlrCode').AsInteger;
  pPxTable.FieldByName('ExpDate').AsDateTime:=pBtTable.FieldByName('ExpDate').AsDateTime;
  pPxTable.FieldByName('OcdNum').AsString:=pBtTable.FieldByName('OcdNum').AsString;
  pPxTable.FieldByName('OcdItm').AsInteger:=pBtTable.FieldByName('OcdItm').AsInteger;
  pPxTable.FieldByName('OcdDate').AsDateTime:=pBtTable.FieldByName('OcdDate').AsDateTime;
  pPxTable.FieldByName('TcdNum').AsString:=pBtTable.FieldByName('TcdNum').AsString;
  pPxTable.FieldByName('TcdItm').AsInteger:=pBtTable.FieldByName('TcdItm').AsInteger;
  pPxTable.FieldByName('TcdDate').AsDateTime:=pBtTable.FieldByName('TcdDate').AsDateTime;
  pPxTable.FieldByName('Status').AsString:=pBtTable.FieldByName('Status').AsString;
  pPxTable.FieldByName('DcCode').AsInteger:=pBtTable.FieldByName('DcCode').AsInteger;
  pPxTable.FieldByName('Action').AsString:=pBtTable.FieldByName('Action').AsString;
end;

procedure TdmSTK.REI_To_TMP; // Ulozi zaznam z btREI do ptREI
begin
  If dmSTK.ptREI.FieldByName('RowNum').AsInteger=0 then dmSTK.ptREI.FieldByName('RowNum').AsInteger:=dmSTK.ptREI.RecordCount;
  dmSTK.ptREI.FieldByName('DocNum').AsString:=dmSTK.btREI.FieldByName('DocNum').AsString;
  dmSTK.ptREI.FieldByName('ItmNum').AsInteger:=dmSTK.btREI.FieldByName('ItmNum').AsInteger;
  dmSTK.ptREI.FieldByName('MgCode').AsInteger:=dmSTK.btREI.FieldByName('MgCode').AsInteger;
  dmSTK.ptREI.FieldByName('GsCode').AsInteger:=dmSTK.btREI.FieldByName('GsCode').AsInteger;
  dmSTK.ptREI.FieldByName('GsName').AsString:=dmSTK.btREI.FieldByName('GsName').AsString;
  dmSTK.ptREI.FieldByName('GsName_').AsString:=StrToAlias (dmSTK.btREI.FieldByName('GsName').AsString);
  dmSTK.ptREI.FieldByName('BarCode').AsString:=dmSTK.btREI.FieldByName('BarCode').AsString;
  dmSTK.ptREI.FieldByName('StkCode').AsString:=dmSTK.btREI.FieldByName('StkCode').AsString;
  dmSTK.ptREI.FieldByName('ActQnt').AsFloat:=dmSTK.btREI.FieldByName('ActQnt').AsFloat;
  dmSTK.ptREI.FieldByName('GsQnt').AsFloat:=dmSTK.btREI.FieldByName('GsQnt').AsFloat;
  dmSTK.ptREI.FieldByName('VatPrc').AsInteger:=dmSTK.btREI.FieldByName('VatPrc').AsInteger;
  dmSTK.ptREI.FieldByName('CPrice').AsFloat:=dmSTK.btREI.FieldByName('CPrice').AsFloat;
  dmSTK.ptREI.FieldByName('OPrice').AsFloat:=dmSTK.btREI.FieldByName('OPrice').AsFloat;
  dmSTK.ptREI.FieldByName('NPrice').AsFloat:=dmSTK.btREI.FieldByName('NPrice').AsFloat;
  dmSTK.ptREI.FieldByName('CValue').AsFloat:=dmSTK.btREI.FieldByName('CValue').AsFloat;
  dmSTK.ptREI.FieldByName('OValue').AsFloat:=dmSTK.btREI.FieldByName('OValue').AsFloat;
  dmSTK.ptREI.FieldByName('NValue').AsFloat:=dmSTK.btREI.FieldByName('NValue').AsFloat;
  dmSTK.ptREI.FieldByName('DifVal').AsFloat:=dmSTK.btREI.FieldByName('NValue').AsFloat-dmSTK.btREI.FieldByName('OValue').AsFloat;
  dmSTK.ptREI.FieldByName('DocDate').AsDateTime:=dmSTK.btREI.FieldByName('DocDate').AsDateTime;
  dmSTK.ptREI.FieldByName('RevDate').AsDateTime:=dmSTK.btREI.FieldByName('RevDate').AsDateTime;
  dmSTK.ptREI.FieldByName('RevTime').AsDateTime:=dmSTK.btREI.FieldByName('RevTime').AsDateTime;
  dmSTK.ptREI.FieldByName('RevStat').AsInteger:=dmSTK.btREI.FieldByName('RevStat').AsInteger;
  dmSTK.ptREI.FieldByName('Sended').AsInteger:=dmSTK.btREI.FieldByName('Sended').AsInteger;
  dmSTK.ptREI.FieldByName('CrtName').AsString:=dmSTK.btREI.FieldByName('CrtName').AsString;
  dmSTK.ptREI.FieldByName('CrtDate').AsDateTime:=dmSTK.btREI.FieldByName('CrtDate').AsDateTime;
  dmSTK.ptREI.FieldByName('CrtTime').AsDateTime:=dmSTK.btREI.FieldByName('CrtTime').AsDateTime;
  dmSTK.ptREI.FieldByName('ModNum').AsInteger:=dmSTK.btREI.FieldByName('ModNum').AsInteger;
  dmSTK.ptREI.FieldByName('ModUser').AsString:=dmSTK.btREI.FieldByName('ModUser').AsString;
  dmSTK.ptREI.FieldByName('ModDate').AsDateTime:=dmSTK.btREI.FieldByName('ModDate').AsDateTime;
  dmSTK.ptREI.FieldByName('ModTime').AsDateTime:=dmSTK.btREI.FieldByName('ModTime').AsDateTime;
  dmSTK.ptREI.FieldByName('ActPos').AsInteger:=dmSTK.btREI.ActPos;
end;

procedure TdmSTK.ACI_To_TMP(pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btACI do ptACI
begin
  pPxTable.FieldByName('DocNum').AsString:=pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('GsCode').AsInteger:=pBtTable.FieldByName('GsCode').AsInteger;
  pPxTable.FieldByName('MgCode').AsInteger:=pBtTable.FieldByName('MgCode').AsInteger;
  pPxTable.FieldByName('GsName').AsString:=pBtTable.FieldByName('GsName').AsString;
  pPxTable.FieldByName('BarCode').AsString:=pBtTable.FieldByName('BarCode').AsString;
  pPxTable.FieldByName('StkCode').AsString:=pBtTable.FieldByName('StkCode').AsString;
  pPxTable.FieldByName('MsName').AsString:=pBtTable.FieldByName('MsName').AsString;
  pPxTable.FieldByName('StkCPrice').AsFloat:=pBtTable.FieldByName('StkCPrice').AsFloat;
  pPxTable.FieldByName('BefBPrice').AsFloat:=pBtTable.FieldByName('BefBPrice').AsFloat;
  pPxTable.FieldByName('NewBPrice').AsFloat:=pBtTable.FieldByName('NewBPrice').AsFloat;
  pPxTable.FieldByName('AftBPrice').AsFloat:=pBtTable.FieldByName('AftBPrice').AsFloat;
  pPxTable.FieldByName('BefProfit').AsFloat:=pBtTable.FieldByName('BefProfit').AsFloat;
  pPxTable.FieldByName('NewProfit').AsFloat:=pBtTable.FieldByName('NewProfit').AsFloat;
  pPxTable.FieldByName('AftProfit').AsFloat:=pBtTable.FieldByName('AftProfit').AsFloat;
  pPxTable.FieldByName('BegDate').AsDateTime:=pBtTable.FieldByName('BegDate').AsDateTime;
  pPxTable.FieldByName('EndDate').AsDateTime:=pBtTable.FieldByName('EndDate').AsDateTime;
  pPxTable.FieldByName('Status').AsString:=pBtTable.FieldByName('Status').AsString;
  pPxTable.FieldByName('CrtUser').AsString:=pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime:=pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime:=pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModUser').AsString:=pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime:=pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime:=pBtTable.FieldByName('ModTime').AsDateTime;
  pPxTable.FieldByName('ActPos').AsInteger:=pBtTable.ActPos;
end;
(*
procedure TdmSTK.OSI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btOSI do ptOSI
begin
  BTR_To_PX (pBtTable,pPxTable);
  If IsNotNul (pBtTable.FieldByName('OrdQnt').AsFloat) then begin
    pPxTable.FieldByName('AcDPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
    pPxTable.FieldByName('AcCPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
    pPxTable.FieldByName('AcEPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcEValue').AsFloat/pBtTable.FieldByName('OrdQnt').AsFloat);
  end;
  If dmSTK.btGSNOTI.Active then begin
    If dmSTK.btGSNOTI.FindKey ([pBtTable.FieldByName('GsCode').Asinteger])
      then pPxTable.FieldByName('Notice').AsString:=dmSTK.btGSNOTI.FieldByName('Notice').AsString;
  end;
end;
*)

procedure TdmSTK.TSI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable); // Ulozi zaznam z btTSI do ptTSI
begin
  BTR_To_PX (pBtTable,pPxTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  // Ulozime specialne pole do docasneho suboru TSI.TDF
  pPxTable.FieldByName('GsQnt').AsFloat:=pBtTable.FieldByName('GsQnt').AsFloat;
  If IsNotNul(pBtTable.FieldByName('GsQnt').AsFloat) then begin
    pPxTable.FieldByName('AcDPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcDValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcCPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcCValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcEPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcEValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcSPrice').AsFloat:=RoundCPrice(pBtTable.FieldByName('AcSValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcAPrice').AsFloat:=Rd3(pBtTable.FieldByName('AcAValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
    pPxTable.FieldByName('AcBPrice').AsFloat:=Rd3(pBtTable.FieldByName('AcBValue').AsFloat/pBtTable.FieldByName('GsQnt').AsFloat);
  end;
  pPxTable.FieldByName('AcEValue').AsFloat:=pBtTable.FieldByName('AcEValue').AsFloat;
  pPxTable.FieldByName('AcZValue').AsFloat:=pBtTable.FieldByName('AcZValue').AsFloat;
  pPxTable.FieldByName('AcTValue').AsFloat:=pBtTable.FieldByName('AcTValue').AsFloat;
  pPxTable.FieldByName('AcOValue').AsFloat:=pBtTable.FieldByName('AcOValue').AsFloat;
  pPxTable.FieldByName('AcSValue').AsFloat:=pBtTable.FieldByName('AcSValue').AsFloat;
  pPxTable.FieldByName('AcRndVal').AsFloat:=pBtTable.FieldByName('AcRndVal').AsFloat;
  pPxTable.FieldByName('AcAValue').AsFloat:=pBtTable.FieldByName('AcAValue').AsFloat;
  pPxTable.FieldByName('AcBValue').AsFloat:=pBtTable.FieldByName('AcBValue').AsFloat;
  pPxTable.FieldByName('FgEPrice').AsFloat:=pBtTable.FieldByName('FgEPrice').AsFloat;
  pPxTable.FieldByName('FgDscVal').AsFloat:=pBtTable.FieldByName('FgDscVal').AsFloat;
  pPxTable.FieldByName('FgRndVal').AsFloat:=pBtTable.FieldByName('FgRndVal').AsFloat;
  pPxTable.FieldByName('FgEValue').AsFloat:=pBtTable.FieldByName('FgEValue').AsFloat;
  pPxTable.FieldByName('DocDate').AsDateTime:=pBtTable.FieldByName('DocDate').AsDateTime;
  pPxTable.FieldByName('DrbDate').AsDateTime:=pBtTable.FieldByName('DrbDate').AsDateTime;
  pPxTable.FieldByName('PaCode').AsInteger:=pBtTable.FieldByName('PaCode').AsInteger;
  pPxTable.FieldByName('OsdNum').AsString:=pBtTable.FieldByName('OsdNum').AsString;
  pPxTable.FieldByName('OsdItm').AsInteger:=pBtTable.FieldByName('OsdItm').AsInteger;
  pPxTable.FieldByName('IsdNum').AsString:=pBtTable.FieldByName('IsdNum').AsString;
  pPxTable.FieldByName('IsdItm').AsInteger:=pBtTable.FieldByName('IsdItm').AsInteger;
  pPxTable.FieldByName('IsdDate').AsDateTime:=pBtTable.FieldByName('IsdDate').AsDateTime;
  pPxTable.FieldByName('StkStat').AsString:=pBtTable.FieldByName('StkStat').AsString;
  pPxTable.FieldByName('FinStat').AsString:=pBtTable.FieldByName('FinStat').AsString;
  pPxTable.FieldByName('AcqStat').AsString:=pBtTable.FieldByName('AcqStat').AsString;
  pPxTable.FieldByName('PrfPrc').AsFloat:=CalcProfPrc (pPxTable.FieldByName('AcSValue').AsFloat,pPxTable.FieldByName('AcAValue').AsFloat);
end;

procedure TdmSTK.IMI_To_TMP; // Ulozi zaznam z btIMI do ptIMI
begin
  ptIMI.FieldByName('ItmNum').AsInteger:= btIMI.FieldByName('ItmNum').AsInteger;
  ptIMI.FieldByName('DocNum').AsString:= btIMI.FieldByName('DocNum').AsString;
  ptIMI.FieldByName('MgCode').AsInteger:= btIMI.FieldByName('MgCode').AsInteger;
  ptIMI.FieldByName('GsCode').AsInteger:= btIMI.FieldByName('GsCode').AsInteger;
  ptIMI.FieldByName('GsName').AsString:= btIMI.FieldByName('GsName').AsString;
  ptIMI.FieldByName('BarCode').AsString:= btIMI.FieldByName('BarCode').AsString;
  ptIMI.FieldByName('StkCode').AsString:= btIMI.FieldByName('StkCode').AsString;
  ptIMI.FieldByName('StkNum').AsInteger:= btIMI.FieldByName('StkNum').AsInteger;
  ptIMI.FieldByName('MsName').AsString:= btIMI.FieldByName('MsName').AsString;
  ptIMI.FieldByName('GsQnt').AsFloat:= btIMI.FieldByName('GsQnt').AsFloat;
  ptIMI.FieldByName('VatPrc').AsFloat:= btIMI.FieldByName('VatPrc').AsFloat;
  ptIMI.FieldByName('CPrice').AsFloat:= btIMI.FieldByName('CPrice').AsFloat;
  ptIMI.FieldByName('EPrice').AsFloat:= btIMI.FieldByName('EPrice').AsFloat;
  ptIMI.FieldByName('CValue').AsFloat:= btIMI.FieldByName('CValue').AsFloat;
  ptIMI.FieldByName('EValue').AsFloat:= btIMI.FieldByName('EValue').AsFloat;
  ptIMI.FieldByName('AValue').AsFloat:= btIMI.FieldByName('AValue').AsFloat;
  ptIMI.FieldByName('BValue').AsFloat:= btIMI.FieldByName('BValue').AsFloat;
  If IsNotNul(btIMI.FieldByName('GsQnt').AsFloat) then begin
    ptIMI.FieldByName('APrice').AsFloat:= Rd2(btIMI.FieldByName('AValue').AsFloat/btIMI.FieldByName('GsQnt').AsFloat);
    ptIMI.FieldByName('BPrice').AsFloat:= Rd2(btIMI.FieldByName('BValue').AsFloat/btIMI.FieldByName('GsQnt').AsFloat);
  end;
  ptIMI.FieldByName('DocDate').AsDateTime:= btIMI.FieldByName('DocDate').AsDateTime;
  ptIMI.FieldByName('PaCode').AsInteger:= btIMI.FieldByName('PaCode').AsInteger;
  ptIMI.FieldByName('StkStat').AsString:= btIMI.FieldByName('StkStat').AsString;
  ptIMI.FieldByName('CrtUser').AsString:= btIMI.FieldByName('CrtUser').AsString;
  ptIMI.FieldByName('CrtDate').AsDateTime:= btIMI.FieldByName('CrtDate').AsDateTime;
  ptIMI.FieldByName('CrtTime').AsDateTime:= btIMI.FieldByName('CrtTime').AsDateTime;
  ptIMI.FieldByName('ModNum').AsInteger:= btIMI.FieldByName('ModNum').AsInteger;
  ptIMI.FieldByName('ModUser').AsString:= btIMI.FieldByName('ModUser').AsString;
  ptIMI.FieldByName('ModDate').AsDateTime:= btIMI.FieldByName('ModDate').AsDateTime;
  ptIMI.FieldByName('ModTime').AsDateTime:= btIMI.FieldByName('ModTime').AsDateTime;
  ptIMI.FieldByName('ActPos').AsInteger:= btIMI.ActPos;
  ptIMI.FieldByName('PosCode').AsString:= btIMI.FieldByName('PosCode').AsString;
  ptIMI.FieldByName('RbaCode').AsString:= btIMI.FieldByName('RbaCode').AsString;
  ptIMI.FieldByName('RbaDate').AsDateTime:= btIMI.FieldByName('RbaDate').AsDateTime;
end;

procedure TdmSTK.OMI_To_TMP; // Ulozi zaznam z btOMI do ptOMI
begin
  ptOMI.FieldByName('ItmNum').AsInteger:= btOMI.FieldByName('ItmNum').AsInteger;
  ptOMI.FieldByName('DocNum').AsString:= btOMI.FieldByName('DocNum').AsString;
  ptOMI.FieldByName('MgCode').AsInteger:= btOMI.FieldByName('MgCode').AsInteger;
  ptOMI.FieldByName('GsCode').AsInteger:= btOMI.FieldByName('GsCode').AsInteger;
  ptOMI.FieldByName('GsName').AsString:= btOMI.FieldByName('GsName').AsString;
  ptOMI.FieldByName('BarCode').AsString:= btOMI.FieldByName('BarCode').AsString;
  ptOMI.FieldByName('StkCode').AsString:= btOMI.FieldByName('StkCode').AsString;
  ptOMI.FieldByName('StkNum').AsInteger:= btOMI.FieldByName('StkNum').AsInteger;
  ptOMI.FieldByName('MsName').AsString:= btOMI.FieldByName('MsName').AsString;
  ptOMI.FieldByName('GsQnt').AsFloat:= btOMI.FieldByName('GsQnt').AsFloat;
  ptOMI.FieldByName('VatPrc').AsFloat:= btOMI.FieldByName('VatPrc').AsFloat;
  ptOMI.FieldByName('CPrice').AsFloat:= btOMI.FieldByName('CPrice').AsFloat;
  ptOMI.FieldByName('EPrice').AsFloat:= btOMI.FieldByName('EPrice').AsFloat;
  ptOMI.FieldByName('CValue').AsFloat:= btOMI.FieldByName('CValue').AsFloat;
  ptOMI.FieldByName('EValue').AsFloat:= btOMI.FieldByName('EValue').AsFloat;
  ptOMI.FieldByName('BPrice').AsFloat:= btOMI.FieldByName('BPrice').AsFloat;
  ptOMI.FieldByName('BValue').AsFloat:= Rd2(btOMI.FieldByName('BPrice').AsFloat*btOMI.FieldByName('GsQnt').AsFloat);
  ptOMI.FieldByName('AValue').AsFloat:= gPlc.ClcAPrice(Round(btOMI.FieldByName('VatPrc').AsFloat),btOMI.FieldByName('BValue').AsFloat);
  ptOMI.FieldByName('APrice').AsFloat:= btOMI.FieldByName('AValue').AsFloat/btOMI.FieldByName('GsQnt').AsFloat;
  ptOMI.FieldByName('DocDate').AsDateTime:= btOMI.FieldByName('DocDate').AsDateTime;
  ptOMI.FieldByName('StkStat').AsString:= btOMI.FieldByName('StkStat').AsString;
  ptOMI.FieldByName('CrtUser').AsString:= btOMI.FieldByName('CrtUser').AsString;
  ptOMI.FieldByName('CrtDate').AsDateTime:= btOMI.FieldByName('CrtDate').AsDateTime;
  ptOMI.FieldByName('CrtTime').AsDateTime:= btOMI.FieldByName('CrtTime').AsDateTime;
  ptOMI.FieldByName('ModNum').AsInteger:= btOMI.FieldByName('ModNum').AsInteger;
  ptOMI.FieldByName('ModUser').AsString:= btOMI.FieldByName('ModUser').AsString;
  ptOMI.FieldByName('ModDate').AsDateTime:= btOMI.FieldByName('ModDate').AsDateTime;
  ptOMI.FieldByName('ModTime').AsDateTime:= btOMI.FieldByName('ModTime').AsDateTime;
  ptOMI.FieldByName('ActPos').AsInteger:= btOMI.ActPos;
  ptOMI.FieldByName('PosCode').AsString:= btOMI.FieldByName('PosCode').AsString;
  ptOMI.FieldByName('RbaCode').AsString:= btOMI.FieldByName('RbaCode').AsString;
  ptOMI.FieldByName('RbaDate').AsDateTime:= btOMI.FieldByName('RbaDate').AsDateTime;
end;

procedure TdmSTK.FGPADSC_To_TMP; // Ulozi zaznam z btFGPADSC do ptFGPADSC
begin
  ptFGPADSC.FieldByName ('FgCode').AsInteger:=btFGPADSC.FieldByName ('FgCode').AsInteger;
  ptFGPADSC.FieldByName ('DscPrc').AsFloat:=btFGPADSC.FieldByName ('Dscprc').AsFloat;
  If btFGLST.FindKey ([btFGPADSC.FieldByName ('FgCode').AsInteger]) then begin
    ptFGPADSC.FieldByName ('FgName').AsString:=btFGLST.FieldByName ('FgName').AsString;
    ptFGPADSC.FieldByName ('Describe').AsString:=btFGLST.FieldByName ('Describe').AsString;
  end;
  ptFGPADSC.FieldByName ('ActPos').AsInteger:=btFGPADSC.ActPos;
end;

function TdmSTK.GetActStkNum: longint;
begin
  Result:=oActStkNum;
end;

procedure TdmSTK.btSTKBeforePost(DataSet: TDataSet);
begin
  btSTK.FieldByName('ActQnt').AsFloat:=btSTK.FieldByName('BegQnt').AsFloat+btSTK.FieldByName('InQnt').AsFloat-btSTK.FieldByName('OutQnt').AsFloat;
  btSTK.FieldByName('ActVal').AsFloat:=btSTK.FieldByName('BegVal').AsFloat+btSTK.FieldByName('InVal').AsFloat-btSTK.FieldByName('OutVal').AsFloat;
  btSTK.FieldByName('FreQnt').AsFloat:=btSTK.FieldByName('ActQnt').AsFloat-btSTK.FieldByName('SalQnt').AsFloat-btSTK.FieldByName('OcdQnt').AsFloat;
  btSTK.FieldByName('FroQnt').AsFloat:=btSTK.FieldByName('OsdQnt').AsFloat-btSTK.FieldByName('OsrQnt').AsFloat;
  If (btSTK.FieldByName('FreQnt').AsFloat<0) then btSTK.FieldByName('FreQnt').AsFloat:=0;
  If IsNotNul(btSTK.FieldByName('ActQnt').AsFloat) and (btSTK.FieldByName('ActQnt').AsFloat>0)
    then btSTK.FieldByName('AvgPrice').AsFloat:=btSTK.FieldByName('ActVal').AsFloat/btSTK.FieldByName('ActQnt').AsFloat
    else btSTK.FieldByName('AvgPrice').AsFloat:=btSTK.FieldByName('LastPrice').AsFloat;
  If (btSTK.FieldByName ('MaxQnt').AsFloat>0) and (btSTK.FieldByName ('FreQnt').AsFloat>btSTK.FieldByName ('MaxQnt').AsFloat) then btSTK.FieldByName ('MinMax').AsString:='X';
  If (btSTK.FieldByName ('FreQnt').AsFloat<=btSTK.FieldByName ('MinQnt').AsFloat) then btSTK.FieldByName ('MinMax').AsString:='N';
end;

procedure TdmSTK.btFIFBeforePost(DataSet: TDataSet);
begin
  btFIF.FieldByName('ActQnt').AsFloat:=btFIF.FieldByName('InQnt').AsFloat-btFIF.FieldByName('OutQnt').AsFloat;
  If IsNul (btFIF.FieldByName('ActQnt').AsFloat)
    then btFIF.FieldByName('Status').AsString:='X'
    else btFIF.FieldByName('Status').AsString:='A';
end;

procedure TdmSTK.ptSMEVALBeforePost(DataSet: TDataSet);
begin
  dmSTK.ptSMEVAL.FieldByName ('BegActVal').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegInVal').AsFloat+dmSTK.ptSMEVAL.FieldByName ('BegOutVal').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('PerActVal').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('PerInVal').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerOutVal').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndInVal').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegInVal').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerInVal').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndOutVal').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegOutVal').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerOutVal').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndActVal').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('EndInVal').AsFloat+dmSTK.ptSMEVAL.FieldByName ('EndOutVal').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('BegActAcv').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegInAcv').AsFloat+dmSTK.ptSMEVAL.FieldByName ('BegOutAcv').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('PerActAcv').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('PerInAcv').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerOutAcv').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndInAcv').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegInAcv').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerInAcv').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndOutAcv').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('BegOutAcv').AsFloat+dmSTK.ptSMEVAL.FieldByName ('PerOutAcv').AsFloat;
  dmSTK.ptSMEVAL.FieldByName ('EndActAcv').AsFloat:=dmSTK.ptSMEVAL.FieldByName ('EndInAcv').AsFloat+dmSTK.ptSMEVAL.FieldByName ('EndOutAcv').AsFloat;
end;

procedure TdmSTK.ptBARCODEBeforeOpen(DataSet: TDataSet);
begin
  ptBARCODE.FieldDefs.Clear;
  ptBARCODE.FieldDefs.Add ('BarCode',ftString,15,FALSE);

  ptBARCODE.IndexDefs.Clear;
  ptBARCODE.IndexDefs.Add ('','BarCode',[ixPrimary]);
  ptBARCODE.CreateTable;
end;

procedure TdmSTK.ptIVIBeforePost(DataSet: TDataSet);
begin
  If IsNul (ptIVI.FieldByName ('DifQnt').AsFloat)
    then ptIVI.FieldByName ('DifStat').AsString:=''
    else ptIVI.FieldByName ('DifStat').AsString:='X'
end;

procedure TdmSTK.btIVDBeforePost(DataSet: TDataSet);
begin
  btIVD.FieldByName ('EvQnt').AsFloat:=btIVD.FieldByName ('StQnt').AsFloat-btIVD.FieldByName ('NsQnt').AsFloat-btIVD.FieldByName ('CpQnt').AsFloat;
  btIVD.FieldByName ('CpVal').AsFloat:=Rd2(btIVD.FieldByName ('CpQnt').AsFloat*btIVD.FieldByName ('CPrice').AsFloat);
  btIVD.FieldByName ('EvVal').AsFloat:=btIVD.FieldByName ('StVal').AsFloat-btIVD.FieldByName ('NsVal').AsFloat-btIVD.FieldByName ('CpVal').AsFloat;
  btIVD.FieldByName ('DifVal').AsFloat:=Rd2(btIVD.FieldByName ('IvVal').AsFloat-btIVD.FieldByName ('EvVal').AsFloat);
  btIVD.FieldByName ('DifQnt').AsFloat:=btIVD.FieldByName ('IvQnt').AsFloat-btIVD.FieldByName ('EvQnt').AsFloat;
  If IsNul (btIVD.FieldByName ('DifQnt').AsFloat) then begin
    btIVD.FieldByName ('DifStat').AsString:='0';
    btIVD.FieldByName ('IvVal').AsFloat:=btIVD.FieldByName ('EvVal').AsFloat;
    btIVD.FieldByName ('DifVal').AsFloat:=0;
  end
  else begin
    If btIVD.FieldByName ('DifQnt').AsFloat>0
      then btIVD.FieldByName ('DifStat').AsString:='+'
      else btIVD.FieldByName ('DifStat').AsString:='-';
  end;
end;

procedure TdmSTK.ptIVMGSUMBeforeOpen(DataSet: TDataSet);
begin
  ptIVMGSUM.FieldDefs.Clear;
  ptIVMGSUM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('MgName',ftString,30,FALSE);
  ptIVMGSUM.FieldDefs.Add ('IvQnt',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('EvQnt',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('DifQnt',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('PDifQnt',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('NDifQnt',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('IvVal',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('EvVal',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('PDifVal',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('NDifVal',ftFloat,0,FALSE);
  ptIVMGSUM.FieldDefs.Add ('DifStat',ftString,1,FALSE);

  ptIVMGSUM.IndexDefs.Clear;
  ptIVMGSUM.IndexDefs.Add ('','MgCode',[ixPrimary]);
  ptIVMGSUM.IndexDefs.Add ('DifStat','DifStat',[]);
  ptIVMGSUM.CreateTable;
end;

procedure TdmSTK.btOCIxBeforeDelete(DataSet: TDataSet);
begin
(*
  If (btOCD<>NIL) and btOCD.Active then begin
    btOCD.Insert;
    btOCD.SetRecordBuffer(btOCI.GetRecordBuffer);
    btOCD.Post;
  end;
*)
end;

procedure TdmSTK.ptALIAfterScroll(DataSet: TDataSet);
begin
  If ptALI.Tag=1 then begin
    If btALI.GotoPos(ptALI.fieldbyname('ActPos').AsInteger) then begin
(*
      btALI.Edit;
      PX_To_BTR(ptALI,btALI);
      btALI.Post;
*)
    end;
  end;
end;

procedure TdmSTK.ptALIBeforePost(DataSet: TDataSet);
begin
  ptALI.FieldByName('NorQnt').AsFloat:=ptALI.FieldByName('GsQnt').AsFloat-ptALI.FieldByName('RcoQnt').AsFloat-ptALI.FieldByName('RdiQnt').AsFloat-ptALI.FieldByName('RduQnt').AsFloat-ptALI.FieldByName('RdnQnt').AsFloat;
  If ptALI.Tag=1 then begin
    If btALI.GotoPos(ptALI.fieldbyname('ActPos').AsInteger) then begin
      btALI.Edit;
      PX_To_BTR(ptALI,btALI);
      btALI.Post;
    end;
  end;
end;

procedure TdmSTK.btSTKLSTAfterOpen(DataSet: TDataSet);
begin
  If cNexStart and (btSTKLST.RecordCount=0) then begin
    // stklst.bdf
    btSTKLST.Insert;
    btSTKLST.FieldByName('StkNum').AsInteger:=1;
    btSTKLST.FieldByName('StkName').AsString:='Sklad';
    btSTKLST.FieldByName('StkType').AsString:='T';
    btSTKLST.FieldByName('WriNum').AsInteger:=1;
    btSTKLST.FieldByName('PlsNum').AsInteger:=1;
    btSTKLST.Post;
  end;
end;

procedure TdmSTK.btPLSLSTAfterOpen(DataSet: TDataSet);
begin
  If cNexStart and (btPLSLST.RecordCount=0) then begin
    // PLSLST.bdf
    btPLSLST.Insert;
    btPLSLST.FieldByName('PlsNum').AsInteger:=1;
    btPLSLST.FieldByName('PlsName').AsString:='Sklad';
    btPLSLST.FieldByName('StkNum').AsInteger:=1;
    btPLSLST.FieldByName('WriNum').AsInteger:=1;
    btPLSLST.Post;
  end;
end;

end.
{MOD 1809014}
