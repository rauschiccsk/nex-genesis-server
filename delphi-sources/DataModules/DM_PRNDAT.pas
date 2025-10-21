unit DM_PRNDAT;

interface

uses
  IcTypes, IcConv, IcTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, PxTable, NexPxTable;

const cStaWrsEvlCnt=17;

type
  TdmPRN = class(TDataModule)
    ptMPDLST: TPxTable;
    ptSTMREP: TPxTable;
    ptSUVA: TPxTable;
    ptSUVP: TPxTable;
    ptIVITEM: TPxTable;
    ptDOCREP: TPxTable;
    ptIVMGSUM: TPxTable;
    ptSTMMGSUM: TPxTable;
    ptCSDOC: TPxTable;
    ptFIFOPRN: TPxTable;
    ptFINJOUR: TPxTable;
    ptACCOUNT: TPxTable;
    ptCOI: TPxTable;
    ptCSH: TPxTable;
    ptCSHEAD: TPxTable;
    ptFXL: TPxTable;
    ptISHEAD: TPxTable;
    ptFXA: TPxTable;
    ptNOPAIR: TPxTable;
    ptSMA: TPxTable;
    ptVYS: TPxTable;
    ptRECOPROF: TPxTable;
    ptAFTPAYIC: TPxTable;
    ptNOPAYIC: TPxTable;
    ptPLSLAB: TPxTable;
    ptICH: TPxTable;
    ptACCFNJ: TPxTable;
    ptJRNHEAD: TPxTable;
    ptJRNITEM: TPxTable;
    ptREFUND: TNexPxTable;
    ptPFRONT: TNexPxTable;
    ptDOCHEAD: TNexPxTable;
    ptDHEAD: TNexPxTable;
    btLHEAD: TNexPxTable;
    ptNOTICES: TNexPxTable;
    ptTOPCUS: TNexPxTable;
    ptSALEVL: TNexPxTable;
    ptDRBLST: TNexPxTable;
    ptSTMSUM: TNexPxTable;
    ptTOPSAP: TNexPxTable;
    ptSNTSUM: TNexPxTable;
    ptICDPRF: TNexPxTable;
    ptBOOKVER: TNexPxTable;
    ptDOCVER: TNexPxTable;
    ptMGCMOV: TNexPxTable;
    ptPCKVER: TNexPxTable;
    ptFHEAD: TNexPxTable;
    ptWRIEVL: TNexPxTable;
    ptWMGEVL: TNexPxTable;
    ptWRIEVLH: TNexPxTable;
    ptWGSEVL: TNexPxTable;
    ptCTYSAL: TNexPxTable;
    ptCNSSAL: TNexPxTable;
    ptVTD: TNexPxTable;
    ptLAPCHG: TNexPxTable;
    ptBPCVER: TNexPxTable;
    ptBACDUP: TNexPxTable;
    ptDAYGSM: TNexPxTable;
    ptCAGSSRCH: TNexPxTable;
    ptBHEAD: TNexPxTable;
    ptWRSEVL: TNexPxTable;
    ptSCIPRN: TNexPxTable;
    ptSCHPRN: TNexPxTable;
    ptREPHEAD: TNexPxTable;
    ptRWMVER: TNexPxTable;
    ptWICHVER: TNexPxTable;
    ptTMP: TNexPxTable;
    ptOPDSCP: TNexPxTable;
    ptOPDSCG: TNexPxTable;
    ptOPDSCA: TNexPxTable;
    ptDAYSUM: TNexPxTable;
    ptPACSUM: TNexPxTable;
    ptACMPAS: TNexPxTable;
    ptANLSUM: TNexPxTable;
    ptSTMACC: TNexPxTable;
    ptBLCCLVER: TNexPxTable;
    procedure ptMPDLSTBeforeOpen(DataSet: TDataSet);
    procedure ptSTMREPBeforeOpen(DataSet: TDataSet);
    procedure ptSUVABeforeOpen(DataSet: TDataSet);
    procedure ptSUVPBeforeOpen(DataSet: TDataSet);
    procedure ptIVITEMBeforeOpen(DataSet: TDataSet);
    procedure ptDOCREPBeforeOpen(DataSet: TDataSet);
    procedure ptIVMGSUMBeforeOpen(DataSet: TDataSet);
    procedure ptSTMMGSUMBeforeOpen(DataSet: TDataSet);
    procedure ptCSDOCBeforeOpen(DataSet: TDataSet);
    procedure ptFIFOPRNBeforeOpen(DataSet: TDataSet);
    procedure ptFINJOURBeforeOpen(DataSet: TDataSet);
    procedure ptACCOUNTBeforeOpen(DataSet: TDataSet);
    procedure ptCOIBeforeOpen(DataSet: TDataSet);
    procedure ptCSHBeforeOpen(DataSet: TDataSet);
    procedure ptCSHEADBeforeOpen(DataSet: TDataSet);
    procedure ptFXLBeforeOpen(DataSet: TDataSet);
    procedure ptISHEADBeforeOpen(DataSet: TDataSet);
    procedure ptFXABeforeOpen(DataSet: TDataSet);
    procedure ptNOPAIRBeforeOpen(DataSet: TDataSet);
    procedure ptSMABeforeOpen(DataSet: TDataSet);
    procedure ptVYSBeforeOpen(DataSet: TDataSet);
    procedure ptRECOPROFBeforeOpen(DataSet: TDataSet);
    procedure ptAFTPAYICBeforeOpen(DataSet: TDataSet);
    procedure ptNOPAYICBeforeOpen(DataSet: TDataSet);
    procedure ptPLSLABBeforeOpen(DataSet: TDataSet);
    procedure ptICHBeforeOpen(DataSet: TDataSet);
    procedure ptACCFNJBeforeOpen(DataSet: TDataSet);
    procedure ptJRNHEADBeforeOpen(DataSet: TDataSet);
    procedure ptWRSEVLBeforePost(DataSet: TDataSet);
    procedure ptSUVPBeforePost(DataSet: TDataSet);
    procedure ptSUVABeforePost(DataSet: TDataSet);
    procedure ptVYSBeforePost(DataSet: TDataSet);
  private
  public
  end;

var
  dmPRN: TdmPRN;

implementation

{$R *.DFM}

procedure TdmPRN.ptMPDLSTBeforeOpen(DataSet: TDataSet);
begin
  ptMPDLST.FieldDefs.Clear;
  ptMPDLST.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptMPDLST.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptMPDLST.FieldDefs.Add ('DocDate',ftDateTime,0,FALSE);
  ptMPDLST.FieldDefs.Add ('Describe',ftString,30,FALSE);
  ptMPDLST.FieldDefs.Add ('DocVal',ftFloat,0,FALSE);

  ptMPDLST.IndexDefs.Clear;
  ptMPDLST.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptMPDLST.IndexDefs.Add ('SerNum','SerNum',[]);
  ptMPDLST.IndexDefs.Add ('DocDate','DocDate',[]);
  ptMPDLST.CreateTable;
end;

procedure TdmPRN.ptSTMREPBeforeOpen(DataSet: TDataSet);
begin
  ptSTMREP.FieldDefs.Clear;
  ptSTMREP.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptSTMREP.FieldDefs.Add ('BegQnt',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('BegVal',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('InpQnt',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('InpVal',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('OutQnt',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('OutVal',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('EndQnt',ftFloat,0,FALSE);
  ptSTMREP.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);

  ptSTMREP.IndexDefs.Clear;
  ptSTMREP.IndexDefs.Add ('','DocDate',[ixPrimary]);
  ptSTMREP.CreateTable;
end;

procedure TdmPRN.ptSUVABeforeOpen(DataSet: TDataSet);
begin
  ptSUVA.FieldDefs.Clear;
  ptSUVA.FieldDefs.Add ('RowNum',ftInteger,0,FALSE);
  ptSUVA.FieldDefs.Add ('Marking',ftString,10,FALSE);
//Tibi 17.03.2015  ptSUVA.FieldDefs.Add ('Text',ftString,60,FALSE);
  ptSUVA.FieldDefs.Add ('Text',ftString,160,FALSE);
  ptSUVA.FieldDefs.Add ('ExBrutVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('ExCorrVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('ExNettVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('ExPrevVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('RdBrutVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('RdCorrVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('RdNettVal',ftFloat,0,FALSE);
  ptSUVA.FieldDefs.Add ('RdPrevVal',ftFloat,0,FALSE);

  ptSUVA.FieldDefs.Add ('RowNumS',   ftString,20,FALSE);
  ptSUVA.FieldDefs.Add ('MarkingS',  ftString,20,FALSE);
  ptSUVA.FieldDefs.Add ('TextS',     ftString,120,FALSE);
  ptSUVA.FieldDefs.Add ('ExBrutValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('ExCorrValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('ExNettValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('ExPrevValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('RdBrutValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('RdCorrValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('RdNettValS',ftString,30,FALSE);
  ptSUVA.FieldDefs.Add ('RdPrevValS',ftString,30,FALSE);

  ptSUVA.IndexDefs.Clear;
  ptSUVA.IndexDefs.Add ('','RowNum',[ixPrimary]);
  ptSUVA.CreateTable;
end;

procedure TdmPRN.ptSUVPBeforeOpen(DataSet: TDataSet);
begin
  ptSUVP.FieldDefs.Clear;
  ptSUVP.FieldDefs.Add ('RowNum',ftInteger,0,FALSE);
  ptSUVP.FieldDefs.Add ('Marking',ftString,10,FALSE);
  ptSUVP.FieldDefs.Add ('Text',ftString,160,FALSE);
  ptSUVP.FieldDefs.Add ('ExNettVal',ftFloat,0,FALSE);
  ptSUVP.FieldDefs.Add ('ExPrevVal',ftFloat,0,FALSE);
  ptSUVP.FieldDefs.Add ('RdNettVal',ftFloat,0,FALSE);
  ptSUVP.FieldDefs.Add ('RdPrevVal',ftFloat,0,FALSE);

  ptSUVP.FieldDefs.Add ('RowNumS',   ftString,20,FALSE);
  ptSUVP.FieldDefs.Add ('MarkingS',  ftString,20,FALSE);
  ptSUVP.FieldDefs.Add ('TextS',     ftString,120,FALSE);
  ptSUVP.FieldDefs.Add ('ExNettValS',ftString,30,FALSE);
  ptSUVP.FieldDefs.Add ('ExPrevValS',ftString,30,FALSE);
  ptSUVP.FieldDefs.Add ('RdNettValS',ftString,30,FALSE);
  ptSUVP.FieldDefs.Add ('RdPrevValS',ftString,30,FALSE);

  ptSUVP.IndexDefs.Clear;
  ptSUVP.IndexDefs.Add ('','RowNum',[ixPrimary]);
  ptSUVP.CreateTable;
end;

procedure TdmPRN.ptVYSBeforeOpen(DataSet: TDataSet);
begin
  ptVYS.FieldDefs.Clear;
  ptVYS.FieldDefs.Add ('RowNum',ftInteger,0,FALSE);
  ptVYS.FieldDefs.Add ('Marking',ftString,10,FALSE);
  ptVYS.FieldDefs.Add ('Text',ftString,160,FALSE);
  ptVYS.FieldDefs.Add ('ExActVal',ftFloat,0,FALSE);
  ptVYS.FieldDefs.Add ('ExPrevVal',ftFloat,0,FALSE);
  ptVYS.FieldDefs.Add ('RdActVal',ftFloat,0,FALSE);
  ptVYS.FieldDefs.Add ('RdPrevVal',ftFloat,0,FALSE);

  ptVYS.FieldDefs.Add ('RowNumS',   ftString,20,FALSE);
  ptVYS.FieldDefs.Add ('MarkingS',  ftString,20,FALSE);
  ptVYS.FieldDefs.Add ('TextS',     ftString,120,FALSE);
  ptVYS.FieldDefs.Add ('ExActValS', ftString,30,FALSE);
  ptVYS.FieldDefs.Add ('ExPrevValS',ftString,30,FALSE);
  ptVYS.FieldDefs.Add ('RdActValS', ftString,30,FALSE);
  ptVYS.FieldDefs.Add ('RdPrevValS',ftString,30,FALSE);

  ptVYS.IndexDefs.Clear;
  ptVYS.IndexDefs.Add ('','RowNum',[ixPrimary]);
  ptVYS.CreateTable;
end;

procedure TdmPRN.ptIVITEMBeforeOpen(DataSet: TDataSet);
begin
  ptIVITEM.FieldDefs.Clear;
  ptIVITEM.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);  // Tovarove cislo
  ptIVITEM.FieldDefs.Add ('GsName',ftString,30,FALSE);  // Nazov tovaru
  ptIVITEM.FieldDefs.Add ('GsName_',ftString,30,FALSE); // Nazov tovaru - kvoli yotriedeniu
  ptIVITEM.FieldDefs.Add ('BarCode',ftString,15,FALSE); // Identifikacnz kod
  ptIVITEM.FieldDefs.Add ('IvQnt',ftFloat,0,FALSE);     // Skutoèné (napoèítane) množstvo tovaru
  ptIVITEM.FieldDefs.Add ('EvQnt',ftFloat,0,FALSE);     // Evidenèné množstvo tovaru
  ptIVITEM.FieldDefs.Add ('DifQnt',ftFloat,0,FALSE);    // Inventárnz rozdiel - množstvo
  ptIVITEM.FieldDefs.Add ('IvVal',ftFloat,0,FALSE);     // Skutoèná (napoèítaná) hodnota tovaru
  ptIVITEM.FieldDefs.Add ('EvVal',ftFloat,0,FALSE);     // Evidenèná hodnota tovaru
  ptIVITEM.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);    // Inventárnz rozdiel - hodnota

  ptIVITEM.IndexDefs.Clear;
  ptIVITEM.IndexDefs.Add ('','GsCode',[ixPrimary]);
  ptIVITEM.IndexDefs.Add ('GsName','GsName',[]);
  ptIVITEM.IndexDefs.Add ('BarCode','BarCode',[]);
  ptIVITEM.CreateTable;
end;

procedure TdmPRN.ptDOCREPBeforeOpen(DataSet: TDataSet);
begin
  // Kontrolny vykz zauctovanych dokladov
  ptDOCREP.FieldDefs.Clear;
  ptDOCREP.FieldDefs.Add ('BookType',ftString,2,FALSE);  // Typove oznacenie knihy dokladov
  ptDOCREP.FieldDefs.Add ('BookNum',ftString,5,FALSE);   // Cislo knihy dokladov
  ptDOCREP.FieldDefs.Add ('BookName',ftString,30,FALSE); // Nazov knihy dokladov
  ptDOCREP.FieldDefs.Add ('BkDocQnt',ftFloat,0,FALSE);   // Pocet prvotnych dokladov
  ptDOCREP.FieldDefs.Add ('BkDocVal',ftFloat,0,FALSE);   // Hodnota prvotnych dokladov
  ptDOCREP.FieldDefs.Add ('JrDocQnt',ftFloat,0,FALSE);   // Pocet dokladov z dennika
  ptDOCREP.FieldDefs.Add ('JrCredVal',ftFloat,0,FALSE);  // Hodnota dokladov z dennika - strana MD
  ptDOCREP.FieldDefs.Add ('JrDebVal',ftFloat,0,FALSE);   // Hodnota dokladov z dennika - strana DAL
  ptDOCREP.FieldDefs.Add ('JrDocVal',ftFloat,0,FALSE);   // Hodnota dokladov z dennika

  ptDOCREP.IndexDefs.Clear;
  ptDOCREP.IndexDefs.Add ('','BookType;BookNum',[ixPrimary]);
  ptDOCREP.CreateTable;
end;

procedure TdmPRN.ptIVMGSUMBeforeOpen(DataSet: TDataSet);
begin
  // Kumulativna hodnota inventarnych rozdielov podla tovarovych skupin
  ptIVMGSUM.FieldDefs.Clear;
  ptIVMGSUM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);  // Kod tovarovej skupiny
  ptIVMGSUM.FieldDefs.Add ('MgName',ftString,30,FALSE);   // Nazov tovarovej skupiny
  ptIVMGSUM.FieldDefs.Add ('IvVal',ftFloat,0,FALSE);     // Skutoèná (napoèítaná) hodnota
  ptIVMGSUM.FieldDefs.Add ('EvVal',ftFloat,0,FALSE);     // Evidenèná hodnota
  ptIVMGSUM.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);    // Inventárnz rozdiel

  ptIVMGSUM.IndexDefs.Clear;
  ptIVMGSUM.IndexDefs.Add ('','MgCode',[ixPrimary]);
  ptIVMGSUM.CreateTable;
end;

procedure TdmPRN.ptSTMMGSUMBeforeOpen(DataSet: TDataSet);
begin
  ptSTMMGSUM.FieldDefs.Clear;
  ptSTMMGSUM.FieldDefs.Add ('MgCode',ftInteger,0,FALSE);
  ptSTMMGSUM.FieldDefs.Add ('MgName',ftString,30,FALSE);
  ptSTMMGSUM.FieldDefs.Add ('InpVal',ftFloat,0,FALSE);
  ptSTMMGSUM.FieldDefs.Add ('OutVal',ftFloat,0,FALSE);
  ptSTMMGSUM.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);

  ptSTMMGSUM.IndexDefs.Clear;
  ptSTMMGSUM.IndexDefs.Add ('','MgCode',[ixPrimary]);
  ptSTMMGSUM.CreateTable;
end;

procedure TdmPRN.ptCSDOCBeforeOpen(DataSet: TDataSet);
begin
  ptCSDOC.FieldDefs.Clear;
  ptCSDOC.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);     // Chronligické poradové èíslo dokladu
  ptCSDOC.FieldDefs.Add ('DocNum',ftString,12,FALSE);     // Úètovné èíslo èíslo dokladu
  ptCSDOC.FieldDefs.Add ('DocCnt',ftInteger,0,FALSE);     // Typové poradové èíslo dokladu
  ptCSDOC.FieldDefs.Add ('DocDate',ftDate,0,FALSE);       // Dátum vystavenia dokladu
  ptCSDOC.FieldDefs.Add ('MyPaName',ftString,30,FALSE);   // Názov užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('MyAddress',ftString,30,FALSE);  // Adresa užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('MyZipCode',ftString,6,FALSE);   // PSÈ užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('MyCtyName',ftString,30,FALSE);  // Sidlo užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('MyINO',ftString,15,FALSE);      // IÈO užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('MyTIN',ftString,15,FALSE);      // DIÈ užívate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiPaName',ftString,30,FALSE);   // Názov odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiAddress',ftString,30,FALSE);  // Adresa odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiZipCode',ftString,6,FALSE);   // PSÈ odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiCtyName',ftString,30,FALSE);  // Sidlo odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiINO',ftString,15,FALSE);      // IÈO odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('FiTIN',ftString,15,FALSE);      // DIÈ odberate¾skej firmy
  ptCSDOC.FieldDefs.Add ('TxtVal',ftString,60,FALSE);     // Hodnota dokladu slovom
  ptCSDOC.FieldDefs.Add ('Describe',ftString,30,FALSE);   // Úèel platby - popis dokladu

  ptCSDOC.IndexDefs.Clear;
  ptCSDOC.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptCSDOC.CreateTable;
end;

procedure TdmPRN.ptFIFOPRNBeforeOpen(DataSet: TDataSet);
begin
  ptFIFOPRN.FieldDefs.Clear;
  ptFIFOPRN.FieldDefs.Add ('Index',ftInteger,0,FALSE);
  ptFIFOPRN.FieldDefs.Add ('FifoNum',ftInteger,0,FALSE);
  ptFIFOPRN.FieldDefs.Add ('First',ftInteger,0,FALSE);
  ptFIFOPRN.FieldDefs.Add ('GsCode',ftString,8,FALSE);
  ptFIFOPRN.FieldDefs.Add ('GsName',ftString,30,FALSE);
  ptFIFOPRN.FieldDefs.Add ('ActQnt',ftFloat,0,FALSE);
  ptFIFOPRN.FieldDefs.Add ('InPrice',ftFloat,0,FALSE);
  ptFIFOPRN.FieldDefs.Add ('ActVal',ftFloat,0,FALSE);

  ptFIFOPRN.IndexDefs.Clear;
  ptFIFOPRN.IndexDefs.Add ('','Index;FifoNum',[ixPrimary]);
  ptFIFOPRN.IndexDefs.Add ('Index','Index;First',[]);
  ptFIFOPRN.CreateTable;
end;

procedure TdmPRN.ptFINJOURBeforeOpen(DataSet: TDataSet);
var I:byte;
begin
  ptFINJOUR.FieldDefs.Clear;
  ptFINJOUR.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptFINJOUR.FieldDefs.Add ('ConDoc',ftString,12,FALSE);
  ptFINJOUR.FieldDefs.Add ('DocDate',ftDateTime,0,FALSE);
  ptFINJOUR.FieldDefs.Add ('ItmNum',ftInteger,0,FALSE);
  ptFINJOUR.FieldDefs.Add ('Describ',ftString,30,FALSE);
  For I:=5 to 32 do
    ptFINJOUR.FieldDefs.Add ('Value'+StrIntZero(I,2),ftFloat,0,FALSE);

  ptFINJOUR.IndexDefs.Clear;
  ptFINJOUR.IndexDefs.Add ('','DocNum;ConDoc',[ixPrimary]);
  ptFINJOUR.IndexDefs.Add ('DaDo','DocDate;DocNum',[]);
  ptFINJOUR.IndexDefs.Add ('ItmNum','ItmNum',[]);
  ptFINJOUR.CreateTable;
end;

procedure TdmPRN.ptACCOUNTBeforeOpen(DataSet: TDataSet);
begin
  ptACCOUNT.FieldDefs.Clear;
  ptACCOUNT.FieldDefs.Add ('ItmNum',ftInteger,0,FALSE);
  ptACCOUNT.FieldDefs.Add ('AccSnt',ftInteger,0,FALSE);
  ptACCOUNT.FieldDefs.Add ('AccAnl',ftString,8,FALSE);
  ptACCOUNT.FieldDefs.Add ('CredVal',ftFloat,0,FALSE);
  ptACCOUNT.FieldDefs.Add ('DebVal',ftFloat,0,FALSE);

  ptACCOUNT.IndexDefs.Clear;
  ptACCOUNT.IndexDefs.Add ('','ItmNum',[ixPrimary]);
  ptACCOUNT.CreateTable;
end;

procedure TdmPRN.ptCOIBeforeOpen(DataSet: TDataSet);
begin
  ptCOI.FieldDefs.Clear;
  ptCOI.FieldDefs.Add ('TrfCode',ftString,10,FALSE);
  ptCOI.FieldDefs.Add ('StaCode',ftString,3,FALSE);
  ptCOI.FieldDefs.Add ('PrfCode',ftString,1,FALSE);
  ptCOI.FieldDefs.Add ('BarCode',ftString,15,FALSE);
  ptCOI.FieldDefs.Add ('OrdItm',ftInteger,0,FALSE);
  ptCOI.FieldDefs.Add ('TrfName',ftString,60,FALSE);
  ptCOI.FieldDefs.Add ('TrfCodeP',ftString,10,FALSE);
  ptCOI.FieldDefs.Add ('GsQnt',ftFloat,0,FALSE);
  ptCOI.FieldDefs.Add ('Weight',ftFloat,0,FALSE);
  ptCOI.FieldDefs.Add ('DvzVal',ftFloat,0,FALSE);
  ptCOI.FieldDefs.Add ('AccVal',ftFloat,0,FALSE);
  ptCOI.FieldDefs.Add ('InvNum',ftString,12,FALSE);

  ptCOI.IndexDefs.Clear;
  ptCOI.IndexDefs.Add ('','TrfCode;StaCode;PrfCode;BarCode;OrdItm',[ixPrimary]);
  ptCOI.CreateTable;
end;

procedure TdmPRN.ptCSHBeforeOpen(DataSet: TDataSet);
begin
  ptCSH.FieldDefs.Clear;
  ptCSH.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptCSH.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptCSH.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptCSH.FieldDefs.Add ('Text',ftString,30,FALSE);
  ptCSH.FieldDefs.Add ('IncVal',ftFloat,0,FALSE);
  ptCSH.FieldDefs.Add ('ExpVal',ftFloat,0,FALSE);
  ptCSH.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);
  ptCSH.FieldDefs.Add ('Notice',ftString,30,FALSE);

  ptCSH.IndexDefs.Clear;
  ptCSH.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptCSH.CreateTable;
end;

procedure TdmPRN.ptCSHEADBeforeOpen(DataSet: TDataSet);
begin
  ptCSHEAD.FieldDefs.Clear;
  ptCSHEAD.FieldDefs.Add ('BookNum',ftString,5,FALSE);
  ptCSHEAD.FieldDefs.Add ('Year',ftString,4,FALSE);
  ptCSHEAD.FieldDefs.Add ('MthNum',ftInteger,0,FALSE);
  ptCSHEAD.FieldDefs.Add ('BegVal',ftFloat,0,FALSE); // Pociatocny stav pokladne na zaciatku roka
  ptCSHEAD.FieldDefs.Add ('IncVal',ftFloat,0,FALSE); // Celkovy prijem od zaciaktku roka
  ptCSHEAD.FieldDefs.Add ('ExpVal',ftFloat,0,FALSE); // Celkovy vydaj od zaciaktku roka
  ptCSHEAD.FieldDefs.Add ('MthBegVal',ftFloat,0,FALSE); // Pociatocny stav na zaciatku zadaneho mesiaca
  ptCSHEAD.FieldDefs.Add ('MthIncVal',ftFloat,0,FALSE); // Prijem za dany mesiac
  ptCSHEAD.FieldDefs.Add ('MthExpVal',ftFloat,0,FALSE); // Vydaj za dany mesiac
  ptCSHEAD.FieldDefs.Add ('EndVal',ftFloat,0,FALSE); // Konecny stav na konci zadaneho mesiaca
  ptCSHEAD.FieldDefs.Add ('IncDocQnt',ftInteger,0,FALSE); // Pocet prijmovych dokladov
  ptCSHEAD.FieldDefs.Add ('ExpDocQnt',ftInteger,0,FALSE); // Pocet vydavkovych dokladov
  ptCSHEAD.FieldDefs.Add ('AllDocQnt',ftInteger,0,FALSE); // Pocet vsetkych pokladnicnych dokladov

  ptCSHEAD.IndexDefs.Clear;
  ptCSHEAD.IndexDefs.Add ('','BookNum',[ixPrimary]);
  ptCSHEAD.CreateTable;
end;

procedure TdmPRN.ptFXLBeforeOpen(DataSet: TDataSet);
begin
  ptFXL.FieldDefs.Clear;
  ptFXL.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptFXL.FieldDefs.Add ('Year',ftInteger,0,FALSE);
  ptFXL.FieldDefs.Add ('Mounth',ftInteger,0,FALSE);
  ptFXL.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptFXL.FieldDefs.Add ('BegVal',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('ChgVal',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('ModVal',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('SuPrc',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('SuVal',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);
  ptFXL.FieldDefs.Add ('AccGrp',ftInteger,0,FALSE);

  ptFXL.IndexDefs.Clear;
  ptFXL.IndexDefs.Add ('','DocNum;Year;Mounth',[ixPrimary]);
  ptFXL.CreateTable;
end;

procedure TdmPRN.ptISHEADBeforeOpen(DataSet: TDataSet);
begin
  ptISHEAD.FieldDefs.Clear;
  ptISHEAD.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptISHEAD.FieldDefs.Add ('VatSnt1',ftString,3,FALSE);
  ptISHEAD.FieldDefs.Add ('VatAnl1',ftString,6,FALSE);
  ptISHEAD.FieldDefs.Add ('CredVal1',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('DebVal1',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('VatSnt2',ftString,3,FALSE);
  ptISHEAD.FieldDefs.Add ('VatAnl2',ftString,6,FALSE);
  ptISHEAD.FieldDefs.Add ('CredVal2',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('DebVal2',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('VatSnt3',ftString,3,FALSE);
  ptISHEAD.FieldDefs.Add ('VatAnl3',ftString,6,FALSE);
  ptISHEAD.FieldDefs.Add ('CredVal3',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('DebVal3',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('VatSnt4',ftString,3,FALSE);
  ptISHEAD.FieldDefs.Add ('VatAnl4',ftString,6,FALSE);
  ptISHEAD.FieldDefs.Add ('CredVal4',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('DebVal4',ftFloat,0,FALSE);
  ptISHEAD.FieldDefs.Add ('PayName',ftString,30,FALSE);
  ptISHEAD.FieldDefs.Add ('PayDoc',ftString,50,FALSE);
  ptISHEAD.FieldDefs.Add ('TsdNum',ftString,50,FALSE);

  ptISHEAD.IndexDefs.Clear;
  ptISHEAD.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptISHEAD.CreateTable;
end;

procedure TdmPRN.ptFXABeforeOpen(DataSet: TDataSet);
begin
  ptFXA.FieldDefs.Clear;
  ptFXA.FieldDefs.Add ('AccGrp',ftInteger,0,FALSE);
  ptFXA.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptFXA.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptFXA.FieldDefs.Add ('ExtNum',ftString,12,FALSE);
  ptFXA.FieldDefs.Add ('FxaName',ftString,30,FALSE);
  ptFXA.FieldDefs.Add ('ClasCode',ftString,10,FALSE);
  ptFXA.FieldDefs.Add ('PrvDate',ftDateTime,0,FALSE);
  ptFXA.FieldDefs.Add ('PrvYear',ftString,4,FALSE);
  ptFXA.FieldDefs.Add ('PrvVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('TSuPrc',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('TsuGrp',ftInteger,0,FALSE);
  ptFXA.FieldDefs.Add ('TsuMode',ftString,1,FALSE);
  ptFXA.FieldDefs.Add ('TsuYear',ftInteger,0,FALSE);
  ptFXA.FieldDefs.Add ('LsuYear',ftInteger,0,FALSE);
  ptFXA.FieldDefs.Add ('TBegVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('ChgVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('TSuVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('ActTSuVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('TEndVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('LSuPrc',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('LSuVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('ActLSuVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('LEndVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('DiffVal',ftFloat,0,FALSE);
  ptFXA.FieldDefs.Add ('AccSnt',ftString,3,FALSE);

  ptFXA.IndexDefs.Clear;
  ptFXA.IndexDefs.Add ('','AccGrp;SerNum;DocNum',[ixPrimary]);
  ptFXA.IndexDefs.Add ('DocNum','DocNum',[]);
  ptFXA.CreateTable;
end;

procedure TdmPRN.ptNOPAIRBeforeOpen(DataSet: TDataSet);
begin
  ptNOPAIR.FieldDefs.Clear;
  ptNOPAIR.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptNOPAIR.FieldDefs.Add ('PaName',ftString,30,FALSE);
  ptNOPAIR.FieldDefs.Add ('PaName_',ftString,30,FALSE);
  ptNOPAIR.FieldDefs.Add ('DocVal',ftFloat,0,FALSE);
  ptNOPAIR.FieldDefs.Add ('PairVal',ftFloat,0,FALSE);
  ptNOPAIR.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);

  ptNOPAIR.IndexDefs.Clear;
  ptNOPAIR.IndexDefs.Add ('','DocNum',[ixPrimary]);
  ptNOPAIR.IndexDefs.Add ('PaName','PaName',[]);
  ptNOPAIR.CreateTable;
end;

procedure TdmPRN.ptSMABeforeOpen(DataSet: TDataSet);
begin
  ptSMA.FieldDefs.Clear;
  ptSMA.FieldDefs.Add ('Year',ftInteger,0,FALSE);
  ptSMA.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptSMA.FieldDefs.Add ('SmaName',ftString,30,FALSE);
  ptSMA.FieldDefs.Add ('BarCode',ftString,15,FALSE);
  ptSMA.FieldDefs.Add ('ProdNum',ftString,30,FALSE);
  ptSMA.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptSMA.FieldDefs.Add ('PrvVal',ftFloat,0,FALSE);
  ptSMA.FieldDefs.Add ('PrvDate',ftDate,0,FALSE);
  ptSMA.FieldDefs.Add ('PrvDoc',ftString,12,FALSE);
  ptSMA.FieldDefs.Add ('PrvMode',ftString,30,FALSE);
  ptSMA.FieldDefs.Add ('BegDate',ftDate,0,FALSE);
  ptSMA.FieldDefs.Add ('BegDoc',ftString,12,FALSE);
  ptSMA.FieldDefs.Add ('EndDate',ftDate,0,FALSE);
  ptSMA.FieldDefs.Add ('EndDoc',ftString,12,FALSE);

  ptSMA.IndexDefs.Clear;
  ptSMA.IndexDefs.Add ('','Year;DocNum',[ixPrimary]);
  ptSMA.CreateTable;
end;

procedure TdmPRN.ptRECOPROFBeforeOpen(DataSet: TDataSet);
begin
  // Tabyulka obsahuje udaje kontroly doporuceneho zisku STV_RecoProf
  ptRECOPROF.FieldDefs.Clear;
  ptRECOPROF.FieldDefs.Add ('GsCode',ftInteger,0,FALSE);
  ptRECOPROF.FieldDefs.Add ('GsName',ftString,30,FALSE);
  ptRECOPROF.FieldDefs.Add ('GsName_',ftString,30,FALSE);
  ptRECOPROF.FieldDefs.Add ('VatPrc',ftFloat,0,FALSE);
  ptRECOPROF.FieldDefs.Add ('CValue',ftFloat,0,FALSE);  // Celkova hodnota prijmu v NC
  ptRECOPROF.FieldDefs.Add ('MovQnt',ftFloat,0,FALSE); // Prijate mnozstvo
  ptRECOPROF.FieldDefs.Add ('CPrice',ftFloat,0,FALSE);  // Nakupna cena tovaru podla skutocneho prijmu
  ptRECOPROF.FieldDefs.Add ('MgBPrice',ftFloat,0,FALSE); // Predajna cena, ktoru by mala byt podla doporuceneho zisku MG
  ptRECOPROF.FieldDefs.Add ('PlBPrice',ftFloat,0,FALSE); // Predajna cena podla predajneho cennika
  ptRECOPROF.FieldDefs.Add ('DfBPrice',ftFloat,0,FALSE); // Rozdiel PlBPrice-MgBPrice
  ptRECOPROF.FieldDefs.Add ('MgProfPrc',ftFloat,0,FALSE);  // Doporuceny zisk podla MG
  ptRECOPROF.FieldDefs.Add ('PlProfPrc',ftFloat,0,FALSE);  // Zisk ppodla cennikovej ceny
  ptRECOPROF.FieldDefs.Add ('DfProfPrc',ftFloat,0,FALSE);  // Rozdiel PlProfPrc-MgProfPrc
  ptRECOPROF.FieldDefs.Add ('Status',ftString,1,FALSE);  // Stav polozky X-tovar nie je v cenniku

  ptRECOPROF.IndexDefs.Clear;
  ptRECOPROF.IndexDefs.Add ('','GsCode',[ixPrimary]);
  ptRECOPROF.IndexDefs.Add ('GsName','GsName',[]);
  ptRECOPROF.IndexDefs.Add ('Status','Status',[]);
  ptRECOPROF.CreateTable;
end;

procedure TdmPRN.ptAFTPAYICBeforeOpen(DataSet: TDataSet);
begin
  ptAFTPAYIC.FieldDefs.Clear;
  ptAFTPAYIC.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('ExtNum',ftString,12,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('OcdNum',ftString,12,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('PaName',ftString,30,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('PayName',ftString,20,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('BValue0',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('PayVal',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('CrdVal',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('PdfVal',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('DvzVal',ftFloat,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('ExrDate',ftDate,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('VatDate',ftDate,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('PayDate',ftDate,0,FALSE);
  ptAFTPAYIC.FieldDefs.Add ('SendDate',ftDate,0,FALSE);

  ptAFTPAYIC.IndexDefs.Clear;
  ptAFTPAYIC.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptAFTPAYIC.CreateTable;
end;

procedure TdmPRN.ptNOPAYICBeforeOpen(DataSet: TDataSet);
begin
  ptNOPAYIC.FieldDefs.Clear;
  ptNOPAYIC.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptNOPAYIC.FieldDefs.Add ('ExtNum',ftString,12,FALSE);
  ptNOPAYIC.FieldDefs.Add ('OcdNum',ftString,12,FALSE);
  ptNOPAYIC.FieldDefs.Add ('PaName',ftString,30,FALSE);
  ptNOPAYIC.FieldDefs.Add ('PayName',ftString,20,FALSE);
  ptNOPAYIC.FieldDefs.Add ('BValue0',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('PayVal',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('CrdVal',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('PdfVal',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('DvzVal',ftFloat,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('ExrDate',ftDate,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('VatDate',ftDate,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('PayDate',ftDate,0,FALSE);
  ptNOPAYIC.FieldDefs.Add ('SendDate',ftDate,0,FALSE);

  ptNOPAYIC.IndexDefs.Clear;
  ptNOPAYIC.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptNOPAYIC.CreateTable;
end;

procedure TdmPRN.ptPLSLABBeforeOpen(DataSet: TDataSet);
var I:byte;
begin
  ptPLSLAB.FieldDefs.Clear;
  ptPLSLAB.FieldDefs.Add ('Index',ftInteger,0,FALSE);
  For I:=1 to 21 do begin
    ptPLSLAB.FieldDefs.Add ('GsCode'+StrInt(I,0),ftInteger,0,FALSE);
    ptPLSLAB.FieldDefs.Add ('GsName'+StrInt(I,0),ftString,30,FALSE);
    ptPLSLAB.FieldDefs.Add ('BPrice'+StrInt(I,0),ftString,15,FALSE);
    ptPLSLAB.FieldDefs.Add ('BpcInt'+StrInt(I,0),ftString,6,FALSE);
    ptPLSLAB.FieldDefs.Add ('BpcFrc'+StrInt(I,0),ftString,2,FALSE);
    ptPLSLAB.FieldDefs.Add ('InfVal'+StrInt(I,0),ftString,15,FALSE);
    ptPLSLAB.FieldDefs.Add ('MsuPrice'+StrInt(I,0),ftString,40,FALSE);
    ptPLSLAB.FieldDefs.Add ('InfMsuVal'+StrInt(I,0),ftString,20,FALSE);
    ptPLSLAB.FieldDefs.Add ('BarCode'+StrInt(I,0),ftString,15,FALSE);
//    ptPLSLAB.FieldDefs.Add ('StCode'+StrInt(I,0),ftString,15,FALSE);
    ptPLSLAB.FieldDefs.Add ('Notice1-'+StrInt(I,0),ftString,30,FALSE);
    ptPLSLAB.FieldDefs.Add ('Notice2-'+StrInt(I,0),ftString,30,FALSE);
    ptPLSLAB.FieldDefs.Add ('Notice3-'+StrInt(I,0),ftString,30,FALSE);
//    ptPLSLAB.FieldDefs.Add ('Notice4-'+StrInt(I,0),ftString,30,FALSE);
//    ptPLSLAB.FieldDefs.Add ('Notice5-'+StrInt(I,0),ftString,30,FALSE);
//    ptPLSLAB.FieldDefs.Add ('Notice6-'+StrInt(I,0),ftString,30,FALSE);
  end;

  ptPLSLAB.IndexDefs.Clear;
  ptPLSLAB.IndexDefs.Add ('','Index',[ixPrimary]);
  ptPLSLAB.CreateTable;
end;

procedure TdmPRN.ptICHBeforeOpen(DataSet: TDataSet);
begin
  ptICH.FieldDefs.Clear;
  ptICH.FieldDefs.Add ('SerNum',ftInteger,0,FALSE);
  ptICH.FieldDefs.Add ('DocNum',ftString,12,FALSE);
  ptICH.FieldDefs.Add ('ExtNum',ftString,12,FALSE);
  ptICH.FieldDefs.Add ('PaName',ftString,30,FALSE);
  ptICH.FieldDefs.Add ('PaName_',ftString,30,FALSE);
  ptICH.FieldDefs.Add ('INO',ftString,10,FALSE);
  ptICH.FieldDefs.Add ('TIN',ftString,14,FALSE);
  ptICH.FieldDefs.Add ('KSymbol',ftString,4,FALSE);
  ptICH.FieldDefs.Add ('Transport',ftString,15,FALSE);
  ptICH.FieldDefs.Add ('PayName',ftString,20,FALSE);
  ptICH.FieldDefs.Add ('DvzName',ftString,3,FALSE);
  ptICH.FieldDefs.Add ('FrgVal',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('DifVal',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('PayVal',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('EndVal',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('DscPrc',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('ExpirDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('VATDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('PayDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('RemDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('SendDate',ftDate,0,FALSE);
  ptICH.FieldDefs.Add ('PayDoc',ftString,12,FALSE);
  ptICH.FieldDefs.Add ('CrdVal',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('PAValue0',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('PVatVal0',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('PBValue0',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('PDscVal0',ftFloat,0,FALSE);
  ptICH.FieldDefs.Add ('CnctVal',ftFloat,0,FALSE);

  ptICH.IndexDefs.Clear;
  ptICH.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptICH.IndexDefs.Add ('DocNum','DocNum',[]);
  ptICH.IndexDefs.Add ('PaName_','PaName_',[]);
  ptICH.CreateTable;
end;


procedure TdmPRN.ptACCFNJBeforeOpen(DataSet: TDataSet);
begin
  ptACCFNJ.FieldDefs.Clear;
  ptACCFNJ.FieldDefs.Add ('ConDoc',ftString,12,FALSE);
  ptACCFNJ.FieldDefs.Add ('ItmNum',ftInteger,0,FALSE);
  ptACCFNJ.FieldDefs.Add ('MovCode',ftString,3,FALSE);
  ptACCFNJ.FieldDefs.Add ('MovName',ftString,30,FALSE);
  ptACCFNJ.FieldDefs.Add ('Value',ftFloat,0,FALSE);

  ptACCFNJ.IndexDefs.Clear;
  ptACCFNJ.IndexDefs.Add ('','SerNum',[ixPrimary]);
  ptACCFNJ.CreateTable;
end;

procedure TdmPRN.ptJRNHEADBeforeOpen(DataSet: TDataSet);
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

procedure TdmPRN.ptWRSEVLBeforePost(DataSet: TDataSet);
var I:byte; mActQnt,mSalQnt:double;   mWriNum:Str2;
begin
  mActQnt := 0;  mSalQnt := 0;
  For I:=1 to cStaWrsEvlCnt do begin
    mWriNum := StrIntZero(I,2);
    mActQnt := mActQnt+ptWRSEVL.FieldByName ('ActQnt'+mWriNum).AsFloat;
    mSalQnt := mSalQnt+ptWRSEVL.FieldByName ('SalQnt'+mWriNum).AsFloat;
  end;
  ptWRSEVL.FieldByName ('ActQnt').AsFloat := mActQnt;
  ptWRSEVL.FieldByName ('SalQnt').AsFloat := mSalQnt;
end;

procedure TdmPRN.ptSUVPBeforePost(DataSet: TDataSet);
begin
  ptSUVP.FieldByName ('RowNumS').AsString   :=AlignLeftBy(ptSUVP.FieldByName ('RowNum').AsString,3,' ');
  ptSUVP.FieldByName ('MarkingS').AsString  :=StrToSpaceStr(ptSUVP.FieldByName ('Marking').AsString);
  ptSUVP.FieldByName ('TextS').AsString     :=StrToSpaceStr(ptSUVP.FieldByName ('Text').AsString);
  ptSUVP.FieldByName ('ExNettValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVP.FieldByName('ExNettVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVP.FieldByName ('ExPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVP.FieldByName('ExPrevVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVP.FieldByName ('RdNettValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVP.FieldByName('RdNettVal').AsString),'.',','),17,' ');
  ptSUVP.FieldByName ('RdPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVP.FieldByName('RdPrevVal').AsString),'.',','),17,' ');
end;

procedure TdmPRN.ptSUVABeforePost(DataSet: TDataSet);
begin
  ptSUVA.FieldByName ('RowNumS').AsString   :=AlignLeftBy(ptSUVA.FieldByName ('RowNum').AsString,3,' ');
  ptSUVA.FieldByName ('MarkingS').AsString  :=StrToSpaceStr(ptSUVA.FieldByName ('Marking').AsString);
  ptSUVA.FieldByName ('TextS').AsString     :=StrToSpaceStr(ptSUVA.FieldByName ('Text').AsString);
  ptSUVA.FieldByName ('ExNettValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVA.FieldByName('ExNettVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVA.FieldByName ('ExBrutValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVA.FieldByName('ExBrutVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVA.FieldByName ('ExCorrValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVA.FieldByName('ExCorrVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVA.FieldByName ('ExPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptSUVA.FieldByName('ExPrevVal').AsFloat,0,2)),'.',','),20,' ');
  ptSUVA.FieldByName ('RdNettValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVA.FieldByName('RdNettVal').AsString),'.',','),17,' ');
  ptSUVA.FieldByName ('RdPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVA.FieldByName('RdPrevVal').AsString),'.',','),17,' ');
  ptSUVA.FieldByName ('RdBrutValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVA.FieldByName('RdBrutVal').AsString),'.',','),17,' ');
  ptSUVA.FieldByName ('RdCorrValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptSUVA.FieldByName('RdCorrVal').AsString),'.',','),17,' ');
end;

procedure TdmPRN.ptVYSBeforePost(DataSet: TDataSet);
begin
  ptVYS.FieldByName ('RowNumS').AsString   :=AlignLeftBy(ptVYS.FieldByName('RowNum').AsString,3,' ');
  ptVYS.FieldByName ('MarkingS').AsString  :=StrToSpaceStr(ptVYS.FieldByName('Marking').AsString);
  ptVYS.FieldByName ('TextS').AsString     :=StrToSpaceStr(ptVYS.FieldByName('Text').AsString);
  ptVYS.FieldByName ('ExActValS').AsString :=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptVYS.FieldByName('ExActVal').AsFloat,0,2)), '.',','),20,' ');
  ptVYS.FieldByName ('ExPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(StrDoub(ptVYS.FieldByName('ExPrevVal').AsFloat,0,2)),'.',','),20,' ');
  ptVYS.FieldByName ('RdActValS').AsString :=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptVYS.FieldByName('RdActVal').AsString), '.',','),17,' ');
  ptVYS.FieldByName ('RdPrevValS').AsString:=AlignLeftBy(ReplaceStr(StrToSpaceStr(ptVYS.FieldByName('RdPrevVal').AsString),'.',','),17,' ');
end;

end.
