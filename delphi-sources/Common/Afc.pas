unit Afc;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, hAFCDEF,
  AfcAgm, AfcPac,
  AfcGsc, AfcScb, AfcKsb, AfcWab, AfcSab, AfcPsb,
  AfcOsb, AfcTsb, AfcIsb,
  AfcMcb, AfcOcb, AfcTcb, AfcIcb, AfcTob, AfcTib,
  AfcCsb, AfcSob, AfcIdb, AfcSvb,
  AfcImb, AfcOmb, AfcRmb,
  AfcCmb, AfcPkb, AfcDmb, AfcCdb, AfcAcb,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

const
// ******************************************** STK *******************************************
// Upravy -------    Zobrazit ------    Tlac ----------     Nástroje ------     Udrzba --------
   cStkMinMax = 1;   cStkGscInf = 2;    cStkPrnLst = 20;    cStkStcFlt = 22;    cStkStcClc = 38;
                     cStkStcInf = 3;                        cStkBcSrch = 23;    cStkStoClc = 39;
                     cStkActFif = 4;                        cStkNaSrch = 24;    cStkStsClc = 40;
                     cStkAllFif = 5;                        cStkStcStv = 25;    cStkSynDat = 41;
                     cStkStmHis = 6;                        cStkSmdStv = 26;    cStkOcdVer = 42;
                     cStkStcLst = 7;                        cStkSmmStv = 27;    cStkOsdVer = 43;
                     cStkActStp = 8;                        cStkSmgStv = 28;    cStkStcVer = 44;
                     cStkAllStp = 9;                        cStkSmaStv = 29;    cStkFifVer = 45;
                     cStkStpDir = 10;                       cStkDayStm = 30;    cStkDocVer = 46;
                     cStkCpaLst = 11;                       cStkDayStc = 31;    cStkStmDup = 47;
                     cStkSpaLst = 12;                       cStkSapStc = 32;    cStkLosStm = 48;
                     cStkSapLst = 13;                       cStkDrbLst = 33;    cStkLosStc = 49;
                     cStkOcdLst = 14;                       cStkSmcLst = 34;    cStkNusStc = 50;
                     cStkOciDel = 15;                       cStkCnsSal = 35; // Service -------
                     cStkOsdLst = 16;                       cStkInShop = 36;    cStkSerFnc = 51;
                     cStkMinLst = 17;                       cStkRndDif = 37;
                     cStkMaxLst = 18;
                     cStkStsLst = 19;
// ******************************************** AMB ********************************************
// Upravy -------    Zobrazit -------   Tlac ----------     Nástroje ------     Udrzba ---------
   cAmbDocAdd = 1;   cAmbSitLst = 20;   cAmbDocPrn = 40;    cAmbDocFlt = 60;    cAmbDocClc = 90;
   cAmbDocDel = 2;                                          cAmbAmdAog = 61;
   cAmbDocDsc = 3;
   cAmbDocLck = 4;   // Polozky -----
   cAmbDocUnl = 5;   cAmbItmAdd = 150;
   cAmbDocMod = 7;   cAmbItmDel = 151;
   cAmbDatMod = 8;   cAmbItmMod = 152;
   cAmbDocRev = 9;
// -------------------------------------------- AOB --------------------------------------------
// Upravy -------    Zobrazit ------    Tlac ----------     Nástroje ------     Udrzba ---------
   cAobDocAdd = 1;   cAobSitLst = 20;   cAobDocPrn = 40;    cAobDocFlt = 60;    cAobDocClc = 90;
   cAobDocDel = 2;                                          cAobAodAlg = 61;
   cAobDocDsc = 3;
   cAobDocLck = 4;   // Polozky -----
   cAobDocUnl = 5;   cAobItmAdd = 150;
   cAobDocMod = 7;   cAobItmDel = 151;
   cAobDatMod = 8;   cAobItmMod = 152;
   cAobDocRev = 9;
// -------------------------------------------- ALB --------------------------------------------
// Upravy -------    Zobrazit ------    Tlac ----------     Nástroje ------     Udrzba ---------
   cAlbDocAdd = 1;   cAlbSitLst = 20;   cAlbDocPrn = 40;    cAlbDocFlt = 60;    cAlbDocClc = 90;
   cAlbDocDel = 2;   cAlbAliOut = 21;                       cAlbAldIcg = 61;
   cAlbDocDsc = 3;                                          cAlbCsiGen = 62;
   cAlbDocLck = 4;   { Polozky ------}                      cAlbCseGen = 63;
   cAlbDocUnl = 5;   cAlbItmAdd = 150;                      cAlbRetPro = 64;
   cAlbDocMod = 7;   cAlbItmDel = 151;                      cAlbAldFmg = 65;
   cAlbDatMod = 8;   cAlbItmMod = 152;
   cAlbDocRev = 9;
// ******************************************** POB ********************************************
// Upravy -------    Zobrazit -------   Tlac ----------     Nástroje ------     Udrzba ---------
   cPobDocAdd = 1;   cPobSitLst = 20;   cPobExdPrn = 40;    cPobDocFlt = 60;    cPobDocClc = 90;
   cPobDocDel = 2;                                          cPobExdGen = 61;
   cPobDocMod = 3;                                          cPobFmdGen = 62;
   cPobDocDsc = 7;                                          cPobIcdGen = 63;
// Polozky --------
   cPobItmAdd = 150;
   cPobItmDel = 151;
   cPobItmMod = 152;
(*
// ******************************************** MCB ********************************************
// Upravy -------    Zobrazit ------    Tlac ----------     Nástroje ------     Udrzba ---------
   cMcbDocAdd = 1;   cMcbSitLst = 9;    cMcbPrnMcd = 11;    cMcbTcdGen = 13;    cMcbDocClc = 15;
   cMcbDocDel = 2;   cMcbBokPrp = 10;   cMcbPrnMpd = 12;    cMcbOcdGen = 14;
   cMcbDocDsc = 3;
   cMcbDocLck = 4;
   cMcbDocUnl = 5;   // Polozky ----
   cMcbDocRnd = 6;   cMcbItmAdd = 16;
   cMcbDocMod = 7;   cMcbItmDel = 17;
   cMcbVatChg = 8;   cMcbItmMod = 18;
                     cMcbCphEdi = 19;
*)
// ******************************************** RPL *********************************************
// Upravy -------    Nástroje ------
   cRplImpDat = 1;   cRplItmFil = 4;
   cRplImpPls = 2;   cRplDisRpl = 5;
   cRplItmEdi = 3;   cRplStpClc = 6;
   cRplImpNew = 4;   cRplExcClc = 7;

type
  TAfc = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oGrpNum: word;
    oBookNum: Str5;
    oAgm:TAfcAgm;
    oPac:TAfcPac;
    oGsc:TAfcGsc;
    oScb:TAfcScb;
    oKsb:TAfcKsb;
    oWab:TAfcWab;
    oPsb:TAfcPsb;
    oSab:TAfcSab;
    oCmb:TAfcCmb;
    oDmb:TAfcDmb;
    oPkb:TAfcPkb;
    oCdb:TAfcCdb;
    oAcb:TAfcAcb;
    oMcb:TAfcMcb;
    oIcb:TAfcIcb;
    oTcb:TAfcTcb;
    oTob:TAfcTob;
    oTib:TAfcTib;
    oTsb:TAfcTsb;
    oIsb:TAfcIsb;
    oCsb:TAfcCsb;
    oSob:TAfcSob;
    oIdb:TAfcIdb;
    oSvb:TAfcSvb;
    oImb:TAfcImb;
    oOmb:TAfcOmb;
    oRmb:TAfcRmb;
    oOsb:TAfcOsb;
    oOcb:TAfcOcb;
    function ReadData(pPmdMark:Str6;pFncCode:byte):boolean;
    procedure WriteData(pPmdMark:Str6;pFncCode:byte;pValue:boolean);
    procedure SetGrpNum(pValue:word);
    procedure SetBokNum(pValue:Str5);
    // ---------------------------------- AMB ----------------------------------
    function ReadAmbDocAdd:boolean;    procedure WriteAmbDocAdd(pValue:boolean);
    function ReadAmbDocDel:boolean;    procedure WriteAmbDocDel(pValue:boolean);
    function ReadAmbDocMod:boolean;    procedure WriteAmbDocMod(pValue:boolean);
    function ReadAmbDocDsc:boolean;    procedure WriteAmbDocDsc(pValue:boolean);
    function ReadAmbDocLck:boolean;    procedure WriteAmbDocLck(pValue:boolean);
    function ReadAmbDocUnl:boolean;    procedure WriteAmbDocUnl(pValue:boolean);
    function ReadAmbDatMod:boolean;    procedure WriteAmbDatMod(pValue:boolean);
    function ReadAmbDocRev:boolean;    procedure WriteAmbDocRev(pValue:boolean);
    function ReadAmbSitLst:boolean;    procedure WriteAmbSitLst(pValue:boolean);
    function ReadAmbDocPrn:boolean;    procedure WriteAmbDocPrn(pValue:boolean);
    function ReadAmbDocFlt:boolean;    procedure WriteAmbDocFlt(pValue:boolean);
    function ReadAmbAmdAog:boolean;    procedure WriteAmbAmdAog(pValue:boolean);
    function ReadAmbDocClc:boolean;    procedure WriteAmbDocClc(pValue:boolean);
    function ReadAmbItmAdd:boolean;    procedure WriteAmbItmAdd(pValue:boolean);
    function ReadAmbItmDel:boolean;    procedure WriteAmbItmDel(pValue:boolean);
    function ReadAmbItmMod:boolean;    procedure WriteAmbItmMod(pValue:boolean);
    // ---------------------------------- AOB ----------------------------------
    function ReadAobDocAdd:boolean;    procedure WriteAobDocAdd(pValue:boolean);
    function ReadAobDocDel:boolean;    procedure WriteAobDocDel(pValue:boolean);
    function ReadAobDocMod:boolean;    procedure WriteAobDocMod(pValue:boolean);
    function ReadAobDocDsc:boolean;    procedure WriteAobDocDsc(pValue:boolean);
    function ReadAobDocLck:boolean;    procedure WriteAobDocLck(pValue:boolean);
    function ReadAobDocUnl:boolean;    procedure WriteAobDocUnl(pValue:boolean);
    function ReadAobDatMod:boolean;    procedure WriteAobDatMod(pValue:boolean);
    function ReadAobDocRev:boolean;    procedure WriteAobDocRev(pValue:boolean);
    function ReadAobSitLst:boolean;    procedure WriteAobSitLst(pValue:boolean);
    function ReadAobDocPrn:boolean;    procedure WriteAobDocPrn(pValue:boolean);
    function ReadAobDocFlt:boolean;    procedure WriteAobDocFlt(pValue:boolean);
    function ReadAobAodAlg:boolean;    procedure WriteAobAodAlg(pValue:boolean);
    function ReadAobDocClc:boolean;    procedure WriteAobDocClc(pValue:boolean);
    function ReadAobItmAdd:boolean;    procedure WriteAobItmAdd(pValue:boolean);
    function ReadAobItmDel:boolean;    procedure WriteAobItmDel(pValue:boolean);
    function ReadAobItmMod:boolean;    procedure WriteAobItmMod(pValue:boolean);
    // ---------------------------------- ALB ----------------------------------
    function ReadAlbDocAdd:boolean;    procedure WriteAlbDocAdd(pValue:boolean);
    function ReadAlbDocDel:boolean;    procedure WriteAlbDocDel(pValue:boolean);
    function ReadAlbDocMod:boolean;    procedure WriteAlbDocMod(pValue:boolean);
    function ReadAlbDocDsc:boolean;    procedure WriteAlbDocDsc(pValue:boolean);
    function ReadAlbDocLck:boolean;    procedure WriteAlbDocLck(pValue:boolean);
    function ReadAlbDocUnl:boolean;    procedure WriteAlbDocUnl(pValue:boolean);
    function ReadAlbDatMod:boolean;    procedure WriteAlbDatMod(pValue:boolean);
    function ReadAlbDocRev:boolean;    procedure WriteAlbDocRev(pValue:boolean);
    function ReadAlbSitLst:boolean;    procedure WriteAlbSitLst(pValue:boolean);
    function ReadAlbDocPrn:boolean;    procedure WriteAlbDocPrn(pValue:boolean);
    function ReadAlbDocFlt:boolean;    procedure WriteAlbDocFlt(pValue:boolean);
    function ReadAlbAldIcg:boolean;    procedure WriteAlbAldIcg(pValue:boolean);
    function ReadAlbAldFmg:boolean;    procedure WriteAlbAldFmg(pValue:boolean);
    function ReadAlbDocClc:boolean;    procedure WriteAlbDocClc(pValue:boolean);
    function ReadAlbItmAdd:boolean;    procedure WriteAlbItmAdd(pValue:boolean);
    function ReadAlbItmDel:boolean;    procedure WriteAlbItmDel(pValue:boolean);
    function ReadAlbItmMod:boolean;    procedure WriteAlbItmMod(pValue:boolean);
    function ReadAlbCsiGen:boolean;    procedure WriteAlbCsiGen(pValue:boolean);
    function ReadAlbCseGen:boolean;    procedure WriteAlbCseGen(pValue:boolean);
    function ReadAlbRetPro:boolean;    procedure WriteAlbRetPro(pValue:boolean);
    function ReadAlbAliOut:boolean;    procedure WriteAlbAliOut(pValue:boolean);
    // ---------------------------------- POB ----------------------------------
    function ReadPobDocAdd:boolean;    procedure WritePobDocAdd(pValue:boolean);
    function ReadPobDocDel:boolean;    procedure WritePobDocDel(pValue:boolean);
    function ReadPobDocMod:boolean;    procedure WritePobDocMod(pValue:boolean);
    function ReadPobDocDsc:boolean;    procedure WritePobDocDsc(pValue:boolean);
    function ReadPobSitLst:boolean;    procedure WritePobSitLst(pValue:boolean);
    function ReadPobExdPrn:boolean;    procedure WritePobExdPrn(pValue:boolean);
    function ReadPobDocFlt:boolean;    procedure WritePobDocFlt(pValue:boolean);
    function ReadPobExdGen:boolean;    procedure WritePobExdGen(pValue:boolean);
    function ReadPobFmdGen:boolean;    procedure WritePobFmdGen(pValue:boolean);
    function ReadPobIcdGen:boolean;    procedure WritePobIcdGen(pValue:boolean);
    function ReadPobDocClc:boolean;    procedure WritePobDocClc(pValue:boolean);
    function ReadPobItmAdd:boolean;    procedure WritePobItmAdd(pValue:boolean);
    function ReadPobItmDel:boolean;    procedure WritePobItmDel(pValue:boolean);
    function ReadPobItmMod:boolean;    procedure WritePobItmMod(pValue:boolean);
    // ---------------------------------- RPL ----------------------------------
    function ReadRplImpDat:boolean;    procedure WriteRplImpDat(pValue:boolean);
    function ReadRplImpPls:boolean;    procedure WriteRplImpPls(pValue:boolean);
    function ReadRplImpNew:boolean;    procedure WriteRplImpNew(pValue:boolean);
    function ReadRplItmEdi:boolean;    procedure WriteRplItmEdi(pValue:boolean);
    function ReadRplItmFil:boolean;    procedure WriteRplItmFil(pValue:boolean);
    function ReadRplDisRpl:boolean;    procedure WriteRplDisRpl(pValue:boolean);
    function ReadRplStpClc:boolean;    procedure WriteRplStpClc(pValue:boolean);
    function ReadRplExcClc:boolean;    procedure WriteRplExcClc(pValue:boolean);
  public
    ohAFCDEF:TAfcdefHnd;
    procedure Del (pGrpNum:word); overload;
    procedure Del (pGrpNum:word;pPmdMark:Str6); overload;
    procedure Del (pGrpNum:word;pPmdMark:Str6;pBokNum:Str5); overload;
    procedure DelBok (pPmdMark:Str6;pBokNum:Str5);
    procedure CopyAfc(pGrpNum:word;pPmdMark:Str6;pSrcBok,pTrgBok:Str5);
  published
    property GrpNum:word write SetGrpNum;
    property BookNum:Str5 write SetBokNum;

    property Agm:TAfcAgm read oAgm write oAgm;
    property Pac:TAfcPac read oPac write oPac;

    property Gsc:TAfcGsc read oGsc write oGsc;
    property Scb:TAfcScb read oScb write oScb;
    property Ksb:TAfcKsb read oKsb write oKsb;
    property Wab:TAfcWab read oWab write oWab;
    property Psb:TAfcPsb read oPsb write oPsb;
    property Sab:TAfcSab read oSab write oSab;
    property Cmb:TAfcCmb read oCmb write oCmb;
    property Dmb:TAfcDmb read oDmb write oDmb;
    property Pkb:TAfcPkb read oPkb write oPkb;
    property Cdb:TAfcCdb read oCdb write oCdb;
    property Acb:TAfcAcb read oAcb write oAcb;
    property Mcb:TAfcMcb read oMcb write oMcb;
    property Tcb:TAfcTcb read oTcb write oTcb;
    property Tob:TAfcTob read oTob write oTob;
    property Tib:TAfcTib read oTib write oTib;
    property Icb:TAfcIcb read oIcb write oIcb;
    property Tsb:TAfcTsb read oTsb write oTsb;
    property Isb:TAfcIsb read oIsb write oIsb;
    property Csb:TAfcCsb read oCsb write oCsb;
    property Sob:TAfcSob read oSob write oSob;
    property Idb:TAfcIdb read oIdb write oIdb;
    property Svb:TAfcSvb read oSvb write oSvb;
    property Imb:TAfcImb read oImb write oImb;
    property Omb:TAfcOmb read oOmb write oOmb;
    property Rmb:TAfcRmb read oRmb write oRmb;
    property Osb:TAfcOsb read oOsb write oOsb;
    property Ocb:TAfcOcb read oOcb write oOcb;
    // ---------------------------- STC ------------------------------
(*
    property StcMinMax:boolean read ReadStcMinMax write WriteStcMinMax;  // Zadavanie skladovych normatívov
    property StcGscInf:boolean read ReadStcGscInf write WriteStcGscInf;  // Podrobné informácie o tovare
    property StcStkInf:boolean read ReadStcStkInf write WriteStcStkInf;  // Skladová karta zásob
    property StcActFif:boolean read ReadStcActFif write WriteStcActFif;  // Nevydané FIFO karty položky
    property StcAllFif:boolean read ReadStcAllFif write WriteStcAllFif;  // Všetky FIFO karty položky
    property StcStmHis:boolean read ReadStcStmHis write WriteStcStmHis;  // História skladových pohybov
*)
    // ---------------------------- AMB ------------------------------
    property AmbDocAdd:boolean read ReadAmbDocAdd write WriteAmbDocAdd;
    property AmbDocDel:boolean read ReadAmbDocDel write WriteAmbDocDel;
    property AmbDocMod:boolean read ReadAmbDocMod write WriteAmbDocMod;
    property AmbDocDsc:boolean read ReadAmbDocDsc write WriteAmbDocDsc;
    property AmbDocLck:boolean read ReadAmbDocLck write WriteAmbDocLck;
    property AmbDocUnl:boolean read ReadAmbDocUnl write WriteAmbDocUnl;
    property AmbDatMod:boolean read ReadAmbDatMod write WriteAmbDatMod;
    property AmbDocRev:boolean read ReadAmbDocRev write WriteAmbDocRev;
    property AmbSitLst:boolean read ReadAmbSitLst write WriteAmbSitLst;
    property AmbDocPrn:boolean read ReadAmbDocPrn write WriteAmbDocPrn;
    property AmbDocFlt:boolean read ReadAmbDocFlt write WriteAmbDocFlt;
    property AmbAmdAog:boolean read ReadAmbAmdAog write WriteAmbAmdAog;
    property AmbDocClc:boolean read ReadAmbDocClc write WriteAmbDocClc;
    property AmbItmAdd:boolean read ReadAmbItmAdd write WriteAmbItmAdd;
    property AmbItmDel:boolean read ReadAmbItmDel write WriteAmbItmDel;
    property AmbItmMod:boolean read ReadAmbItmMod write WriteAmbItmMod;
    // ---------------------------- AOB ------------------------------
    property AobDocAdd:boolean read ReadAobDocAdd write WriteAobDocAdd;
    property AobDocDel:boolean read ReadAobDocDel write WriteAobDocDel;
    property AobDocMod:boolean read ReadAobDocMod write WriteAobDocMod;
    property AobDocDsc:boolean read ReadAobDocDsc write WriteAobDocDsc;
    property AobDocLck:boolean read ReadAobDocLck write WriteAobDocLck;
    property AobDocUnl:boolean read ReadAobDocUnl write WriteAobDocUnl;
    property AobDatMod:boolean read ReadAobDatMod write WriteAobDatMod;
    property AobDocRev:boolean read ReadAobDocRev write WriteAobDocRev;
    property AobSitLst:boolean read ReadAobSitLst write WriteAobSitLst;
    property AobDocPrn:boolean read ReadAobDocPrn write WriteAobDocPrn;
    property AobDocFlt:boolean read ReadAobDocFlt write WriteAobDocFlt;
    property AobAodAlg:boolean read ReadAobAodAlg write WriteAobAodAlg;
    property AobDocClc:boolean read ReadAobDocClc write WriteAobDocClc;
    property AobItmAdd:boolean read ReadAobItmAdd write WriteAobItmAdd;
    property AobItmDel:boolean read ReadAobItmDel write WriteAobItmDel;
    property AobItmMod:boolean read ReadAobItmMod write WriteAobItmMod;
    // ---------------------------- ALB ------------------------------
    property AlbDocAdd:boolean read ReadAlbDocAdd write WriteAlbDocAdd;
    property AlbDocDel:boolean read ReadAlbDocDel write WriteAlbDocDel;
    property AlbDocMod:boolean read ReadAlbDocMod write WriteAlbDocMod;
    property AlbDocDsc:boolean read ReadAlbDocDsc write WriteAlbDocDsc;
    property AlbDocLck:boolean read ReadAlbDocLck write WriteAlbDocLck;
    property AlbDocUnl:boolean read ReadAlbDocUnl write WriteAlbDocUnl;
    property AlbDatMod:boolean read ReadAlbDatMod write WriteAlbDatMod;
    property AlbDocRev:boolean read ReadAlbDocRev write WriteAlbDocRev;
    property AlbSitLst:boolean read ReadAlbSitLst write WriteAlbSitLst;
    property AlbDocPrn:boolean read ReadAlbDocPrn write WriteAlbDocPrn;
    property AlbDocFlt:boolean read ReadAlbDocFlt write WriteAlbDocFlt;
    property AlbAldIcg:boolean read ReadAlbAldIcg write WriteAlbAldIcg;
    property AlbAldFmg:boolean read ReadAlbAldFmg write WriteAlbAldFmg;
    property AlbDocClc:boolean read ReadAlbDocClc write WriteAlbDocClc;
    property AlbItmAdd:boolean read ReadAlbItmAdd write WriteAlbItmAdd;
    property AlbItmDel:boolean read ReadAlbItmDel write WriteAlbItmDel;
    property AlbItmMod:boolean read ReadAlbItmMod write WriteAlbItmMod;
    property AlbCsiGen:boolean read ReadAlbCsiGen write WriteAlbCsiGen;
    property AlbCseGen:boolean read ReadAlbCseGen write WriteAlbCseGen;
    property AlbRetPro:boolean read ReadAlbRetPro write WriteAlbRetPro;
    property AlbAliOut:boolean read ReadAlbAliOut write WriteAlbAliOut;
    // ---------------------------- POB ------------------------------
    property PobDocAdd:boolean read ReadPobDocAdd write WritePobDocAdd;
    property PobDocDel:boolean read ReadPobDocDel write WritePobDocDel;
    property PobDocMod:boolean read ReadPobDocMod write WritePobDocMod;
    property PobDocDsc:boolean read ReadPobDocDsc write WritePobDocDsc;
    property PobSitLst:boolean read ReadPobSitLst write WritePobSitLst;
    property PobExdPrn:boolean read ReadPobExdPrn write WritePobExdPrn;
    property PobDocFlt:boolean read ReadPobDocFlt write WritePobDocFlt;
    property PobExdGen:boolean read ReadPobExdGen write WritePobExdGen;
    property PobFmdGen:boolean read ReadPobFmdGen write WritePobFmdGen;
    property PobIcdGen:boolean read ReadPobIcdGen write WritePobIcdGen;
    property PobDocClc:boolean read ReadPobDocClc write WritePobDocClc;
    property PobItmAdd:boolean read ReadPobItmAdd write WritePobItmAdd;
    property PobItmDel:boolean read ReadPobItmDel write WritePobItmDel;
    property PobItmMod:boolean read ReadPobItmMod write WritePobItmMod;
    // ---------------------------- RPL ------------------------------
    property RplImpDat:boolean read ReadRplImpDat write WriteRplImpDat;
    property RplImpPls:boolean read ReadRplImpPls write WriteRplImpPls;
    property RplImpNew:boolean read ReadRplImpNew write WriteRplImpNew;
    property RplItmEdi:boolean read ReadRplItmEdi write WriteRplItmEdi;
    property RplItmFil:boolean read ReadRplItmFil write WriteRplItmFil;
    property RplDisRpl:boolean read ReadRplDisRpl write WriteRplDisRpl;
    property RplStpClc:boolean read ReadRplStpClc write WriteRplStpClc;
    property RplExcClc:boolean read ReadRplExcClc write WriteRplExcClc;
  end;

var gAfc:TAfc;

implementation

uses AfcBas, bAFCDEF;

constructor TAfc.Create;
begin
  ohAFCDEF:=TAfcdefHnd.Create;  ohAFCDEF.Open;
  oAgm:=TAfcAgm.Create(ohAFCDEF);
  oPac:=TAfcPac.Create(ohAFCDEF);

  oGsc:=TAfcGsc.Create(ohAFCDEF);
  oScb:=TAfcScb.Create(ohAFCDEF);
  oKsb:=TAfcKsb.Create(ohAFCDEF);
  oWab:=TAfcWab.Create(ohAFCDEF);
  oPsb:=TAfcPsb.Create(ohAFCDEF);
  oSab:=TAfcSab.Create(ohAFCDEF);
  oCmb:=TAfcCmb.Create(ohAFCDEF);
  oDmb:=TAfcDmb.Create(ohAFCDEF);
  oPkb:=TAfcPkb.Create(ohAFCDEF);
  oCdb:=TAfcCdb.Create(ohAFCDEF);
  oAcb:=TAfcAcb.Create(ohAFCDEF);
  oMcb:=TAfcMcb.Create(ohAFCDEF);
  oTcb:=TAfcTcb.Create(ohAFCDEF);
  oTob:=TAfcTob.Create(ohAFCDEF);
  oTib:=TAfcTib.Create(ohAFCDEF);
  oIcb:=TAfcIcb.Create(ohAFCDEF);
  oTsb:=TAfcTsb.Create(ohAFCDEF);
  oIsb:=TAfcIsb.Create(ohAFCDEF);
  oCsb:=TAfcCsb.Create(ohAFCDEF);
  oSob:=TAfcSob.Create(ohAFCDEF);
  oIdb:=TAfcIdb.Create(ohAFCDEF);
  oSvb:=TAfcSvb.Create(ohAFCDEF);
  oImb:=TAfcImb.Create(ohAFCDEF);
  oOmb:=TAfcOmb.Create(ohAFCDEF);
  oRmb:=TAfcRmb.Create(ohAFCDEF);
  oOsb:=TAfcOsb.Create(ohAFCDEF);
  oOcb:=TAfcOcb.Create(ohAFCDEF);
end;

destructor TAfc.Destroy;
begin
  FreeAndNil(oOcb);
  FreeAndNil(oOsb);
  FreeAndNil(oRmb);
  FreeAndNil(oOmb);
  FreeAndNil(oImb);
  FreeAndNil(oTsb);
  FreeAndNil(oIcb);
  FreeAndNil(oTcb);
  FreeAndNil(oTob);
  FreeAndNil(oTib);
  FreeAndNil(oOcb);
  FreeAndNil(oMcb);
  FreeAndNil(oScb);
  FreeAndNil(oKsb);
  FreeAndNil(oWab);
  FreeAndNil(oPsb);
  FreeAndNil(oSab);
  FreeAndNil(oCmb);
  FreeAndNil(oDmb);
  FreeAndNil(oPkb);
  FreeAndNil(oCdb);
  FreeAndNil(oAcb);
  FreeAndNil(oGsc);

  FreeAndNil(oPac);
  FreeAndNil(oAgm);

  FreeAndNil(ohAFCDEF);
end;

// *************************************** PRIVATE ********************************************

function TAfc.ReadData(pPmdMark:Str6;pFncCode:byte):boolean;
var mAcsCtrl:Str250;
begin
//  If oGrpNum='ADMIN'
  If oGrpNum=0
    then Result:=TRUE
    else begin
      Result:=FALSE;
      If ohAFCDEF.LocateGrPmBn(oGrpNum,pPmdMark,oBookNum) then begin
        mAcsCtrl:=ohAFCDEF.AcsCtrl;
        If Length(mAcsCtrl)>=pFncCode then Result:=mAcsCtrl[pFncCode]='X';
      end;
    end;
end;

procedure TAfc.WriteData(pPmdMark:Str6;pFncCode:byte;pValue:boolean);
var mAcsCtrl:Str250;
begin
  If ohAFCDEF.LocateGrPmBn(oGrpNum,pPmdMark,oBookNum) then begin
    mAcsCtrl:=ohAFCDEF.AcsCtrl;
    If pValue
      then mAcsCtrl[pFncCode]:='X'
      else mAcsCtrl[pFncCode]:='.';
    ohAFCDEF.Edit;
    ohAFCDEF.AcsCtrl:=mAcsCtrl;
    ohAFCDEF.Post;
  end
  else begin
    mAcsCtrl:=FillStr ('',250,'.');
    If pValue
      then mAcsCtrl[pFncCode]:='X'
      else mAcsCtrl[pFncCode]:='.';
    ohAFCDEF.Insert;
    ohAFCDEF.GrpNum:=oGrpNum;
    ohAFCDEF.PmdMark:=pPmdMark;
    ohAFCDEF.BookNum:=oBookNum;
    ohAFCDEF.AcsCtrl:=mAcsCtrl;
    ohAFCDEF.Post;
  end;
end;

procedure TAfc.SetGrpNum(pValue:word);
begin
  oGrpNum:=pValue;
  oAgm.GrpNum:=pValue;
  oPac.GrpNum:=pValue;

  oGsc.GrpNum:=pValue;
  oScb.GrpNum:=pValue;
  oKsb.GrpNum:=pValue;
  oWab.GrpNum:=pValue;
  oPsb.GrpNum:=pValue;
  oSab.GrpNum:=pValue;
  oCmb.GrpNum:=pValue;
  oDmb.GrpNum:=pValue;
  oPkb.GrpNum:=pValue;
  oCdb.GrpNum:=pValue;
  oAcb.GrpNum:=pValue;
  oMcb.GrpNum:=pValue;
  oIcb.GrpNum:=pValue;
  oIsb.GrpNum:=pValue;
  oCsb.GrpNum:=pValue;
  oSob.GrpNum:=pValue;
  oIdb.GrpNum:=pValue;
  oSvb.GrpNum:=pValue;
  oTcb.GrpNum:=pValue;
  oTob.GrpNum:=pValue;
  oTib.GrpNum:=pValue;
  oTsb.GrpNum:=pValue;
  oImb.GrpNum:=pValue;
  oOmb.GrpNum:=pValue;
  oRmb.GrpNum:=pValue;
  oOsb.GrpNum:=pValue;
  oOcb.GrpNum:=pValue;
end;

procedure TAfc.SetBokNum(pValue:Str5);
begin
  oBookNum:=pValue;
  oScb.BokNum:=pValue;
  oKsb.BokNum:=pValue;
  oWab.BokNum:=pValue;
  oPsb.BokNum:=pValue;
  oSab.BokNum:=pValue;
  oCmb.BokNum:=pValue;
  oDmb.BokNum:=pValue;
  oPkb.BokNum:=pValue;
  oCdb.BokNum:=pValue;
  oAcb.BokNum:=pValue;
  oMcb.BokNum:=pValue;
  oIsb.BokNum:=pValue;
  oCsb.BokNum:=pValue;
  oSob.BokNum:=pValue;
  oIdb.BokNum:=pValue;
  oSvb.BokNum:=pValue;
  oIcb.BokNum:=pValue;
  oTcb.BokNum:=pValue;
  oTob.BokNum:=pValue;
  oTib.BokNum:=pValue;
  oTsb.BokNum:=pValue;
  oImb.BokNum:=pValue;
  oOmb.BokNum:=pValue;
  oRmb.BokNum:=pValue;
  oOsb.BokNum:=pValue;
  oOcb.BokNum:=pValue;
end;

procedure TAfc.Del (pGrpNum:word);
begin
  If ohAFCDEF.Count>0 then begin
    ohAFCDEF.First;
    Repeat
      Application.ProcessMessages;
      If ohAFCDEF.GrpNum=pGrpNum
        then ohAFCDEF.Delete
        else ohAFCDEF.Next;
    until ohAFCDEF.Eof;
  end;
end;

procedure TAfc.Del (pGrpNum:word;pPmdMark:Str6);
begin
  ohAFCDEF.SwapIndex;
  If ohAFCDEF.LocateGrPm(pGrpNum,pPmdMark) then begin
    Repeat
      Application.ProcessMessages;
      ohAFCDEF.Delete;
    until ohAFCDEF.Eof or (ohAFCDEF.GrpNum<>pGrpNum) or (ohAFCDEF.PmdMark<>pPmdMark);
  end;
  ohAFCDEF.RestoreIndex;
end;

procedure TAfc.Del(pGrpNum:word;pPmdMark:Str6;pBokNum:Str5);
begin
  ohAFCDEF.SwapIndex;
  If ohAFCDEF.LocateGrPmBn(pGrpNum,pPmdMark,pBokNum) then begin
    Repeat
      Application.ProcessMessages;
      ohAFCDEF.Delete;
    until ohAFCDEF.Eof or (ohAFCDEF.GrpNum<>pGrpNum) or (ohAFCDEF.PmdMark<>pPmdMark) or (ohAFCDEF.BookNum<>pBokNum);
  end;
  ohAFCDEF.RestoreIndex;
end;

procedure TAfc.DelBok(pPmdMark:Str6;pBokNum: Str5);
begin
  ohAFCDEF.First;
  while not ohAFCDEF.Eof do begin
    Application.ProcessMessages;
    If (ohAFCDEF.BookNum=pBokNum) and (ohAFCDEF.PmdMark=pPmdMark) 
      then ohAFCDEF.Delete
      else ohAFCDEF.Next;
  end;
end;

procedure TAfc.CopyAfc(pGrpNum:word;pPmdMark:Str6;pSrcBok,pTrgBok:Str5);
var mAcsCtrl:Str250;
begin
  If ohAFCDEF.LocateGrPmBn(pGrpNum,pPmdMark,pSrcBok) then begin
    mAcsCtrl:=ohAFCDEF.AcsCtrl;
    ohAFCDEF.Insert;
    ohAFCDEF.GrpNum:=pGrpNum;
    ohAFCDEF.PmdMark:=pPmdMark;
    ohAFCDEF.BookNum:=pTrgBok;
    ohAFCDEF.AcsCtrl:=mAcsCtrl;
    ohAFCDEF.Post;
  end;
end;

// ------------------------------- PRIVATE -------------------------------------

// --------------------------------- AMB ---------------------------------------
function TAfc.ReadAmbDocAdd:boolean;
begin
  Result:=ReadData('AMB',cAmbDocAdd);
end;

procedure TAfc.WriteAmbDocAdd(pValue:boolean);
begin
  WriteData('AMB',cAmbDocAdd,pValue);
end;

function TAfc.ReadAmbDocDel:boolean;
begin
  Result:=ReadData('AMB',cAmbDocDel);
end;

procedure TAfc.WriteAmbDocDel(pValue:boolean);
begin
  WriteData('AMB',cAmbDocDel,pValue);
end;

function TAfc.ReadAmbDocDsc:boolean;
begin
  Result:=ReadData('AMB',cAmbDocDsc);
end;

procedure TAfc.WriteAmbDocDsc(pValue:boolean);
begin
  WriteData('AMB',cAmbDocDsc,pValue);
end;

function TAfc.ReadAmbDocLck:boolean;
begin
  Result:=ReadData('AMB',cAmbDocLck);
end;

procedure TAfc.WriteAmbDocLck(pValue:boolean);
begin
  WriteData('AMB',cAmbDocLck,pValue);
end;

function TAfc.ReadAmbDocUnl:boolean;
begin
  Result:=ReadData('AMB',cAmbDocUnl);
end;

procedure TAfc.WriteAmbDocUnl(pValue:boolean);
begin
  WriteData('AMB',cAmbDocUnl,pValue);
end;

function TAfc.ReadAmbDocMod:boolean;
begin
  Result:=ReadData('AMB',cAmbDocMod);
end;

procedure TAfc.WriteAmbDocMod(pValue:boolean);
begin
  WriteData('AMB',cAmbDocMod,pValue);
end;

function TAfc.ReadAmbDatMod:boolean;
begin
  Result:=ReadData('AMB',cAmbDatMod);
end;

procedure TAfc.WriteAmbDatMod(pValue:boolean);
begin
  WriteData('AMB',cAmbDatMod,pValue);
end;

function TAfc.ReadAmbDocRev:boolean;
begin
  Result:=ReadData('AMB',cAmbDocRev);
end;

procedure TAfc.WriteAmbDocRev(pValue:boolean);
begin
  WriteData('AMB',cAmbDocRev,pValue);
end;

function TAfc.ReadAmbSitLst:boolean;
begin
  Result:=ReadData('AMB',cAmbSitLst);
end;

procedure TAfc.WriteAmbSitLst(pValue:boolean);
begin
  WriteData('AMB',cAmbSitLst,pValue);
end;

function TAfc.ReadAmbDocPrn:boolean;
begin
  Result:=ReadData('AMB',cAmbDocPrn);
end;

procedure TAfc.WriteAmbDocPrn(pValue:boolean);
begin
  WriteData('AMB',cAmbDocPrn,pValue);
end;

function TAfc.ReadAmbDocFlt:boolean;
begin
  Result:=ReadData('AMB',cAmbDocFlt);
end;

procedure TAfc.WriteAmbDocFlt(pValue:boolean);
begin
  WriteData('AMB',cAmbDocFlt,pValue);
end;

function TAfc.ReadAmbAmdAog:boolean;
begin
  Result:=ReadData('AMB',cAmbAmdAog);
end;

procedure TAfc.WriteAmbAmdAog(pValue:boolean);
begin
  WriteData('AMB',cAmbAmdAog,pValue);
end;

function TAfc.ReadAmbDocClc:boolean;
begin
  Result:=ReadData('AMB',cAmbDocClc);
end;

procedure TAfc.WriteAmbDocClc(pValue:boolean);
begin
  WriteData('AMB',cAmbDocClc,pValue);
end;

function TAfc.ReadAmbItmAdd:boolean;
begin
  Result:=ReadData('AMB',cAmbItmAdd);
end;

procedure TAfc.WriteAmbItmAdd(pValue:boolean);
begin
  WriteData('AMB',cAmbItmAdd,pValue);
end;

function TAfc.ReadAmbItmDel:boolean;
begin
  Result:=ReadData('AMB',cAmbItmDel);
end;

procedure TAfc.WriteAmbItmDel(pValue:boolean);
begin
  WriteData('AMB',cAmbItmDel,pValue);
end;

function TAfc.ReadAmbItmMod:boolean;
begin
  Result:=ReadData('AMB',cAmbItmMod);
end;

procedure TAfc.WriteAmbItmMod(pValue:boolean);
begin
  WriteData('AMB',cAmbItmMod,pValue);
end;

// --------------------------------- AOB ---------------------------------------
function TAfc.ReadAobDocAdd:boolean;
begin
  Result:=ReadData('AOB',cAobDocAdd);
end;

procedure TAfc.WriteAobDocAdd(pValue:boolean);
begin
  WriteData('AOB',cAobDocAdd,pValue);
end;

function TAfc.ReadAobDocDel:boolean;
begin
  Result:=ReadData('AOB',cAobDocDel);
end;

procedure TAfc.WriteAobDocDel(pValue:boolean);
begin
  WriteData('AOB',cAobDocDel,pValue);
end;

function TAfc.ReadAobDocDsc:boolean;
begin
  Result:=ReadData('AOB',cAobDocDsc);
end;

procedure TAfc.WriteAobDocDsc(pValue:boolean);
begin
  WriteData('AOB',cAobDocDsc,pValue);
end;

function TAfc.ReadAobDocLck:boolean;
begin
  Result:=ReadData('AOB',cAobDocLck);
end;

procedure TAfc.WriteAobDocLck(pValue:boolean);
begin
  WriteData('AOB',cAobDocLck,pValue);
end;

function TAfc.ReadAobDocUnl:boolean;
begin
  Result:=ReadData('AOB',cAobDocUnl);
end;

procedure TAfc.WriteAobDocUnl(pValue:boolean);
begin
  WriteData('AOB',cAobDocUnl,pValue);
end;

function TAfc.ReadAobDocMod:boolean;
begin
  Result:=ReadData('AOB',cAobDocMod);
end;

procedure TAfc.WriteAobDocMod(pValue:boolean);
begin
  WriteData('AOB',cAobDocMod,pValue);
end;

function TAfc.ReadAobDatMod:boolean;
begin
  Result:=ReadData('AOB',cAobDatMod);
end;

procedure TAfc.WriteAobDatMod(pValue:boolean);
begin
  WriteData('AOB',cAobDatMod,pValue);
end;

function TAfc.ReadAobDocRev:boolean;
begin
  Result:=ReadData('AOB',cAobDocRev);
end;

procedure TAfc.WriteAobDocRev(pValue:boolean);
begin
  WriteData('AOB',cAobDocRev,pValue);
end;

function TAfc.ReadAobSitLst:boolean;
begin
  Result:=ReadData('AOB',cAobSitLst);
end;

procedure TAfc.WriteAobSitLst(pValue:boolean);
begin
  WriteData('AOB',cAobSitLst,pValue);
end;

function TAfc.ReadAobDocPrn:boolean;
begin
  Result:=ReadData('AOB',cAobDocPrn);
end;

procedure TAfc.WriteAobDocPrn(pValue:boolean);
begin
  WriteData('AOB',cAobDocPrn,pValue);
end;

function TAfc.ReadAobDocFlt:boolean;
begin
  Result:=ReadData('AOB',cAobDocFlt);
end;

procedure TAfc.WriteAobDocFlt(pValue:boolean);
begin
  WriteData('AOB',cAobDocFlt,pValue);
end;

function TAfc.ReadAobAodAlg:boolean;
begin
  Result:=ReadData('AOB',cAobAodAlg);
end;

procedure TAfc.WriteAobAodAlg(pValue:boolean);
begin
  WriteData('AOB',cAobAodAlg,pValue);
end;

function TAfc.ReadAobDocClc:boolean;
begin
  Result:=ReadData('AOB',cAobDocClc);
end;

procedure TAfc.WriteAobDocClc(pValue:boolean);
begin
  WriteData('AOB',cAobDocClc,pValue);
end;

function TAfc.ReadAobItmAdd:boolean;
begin
  Result:=ReadData('AOB',cAobItmAdd);
end;

procedure TAfc.WriteAobItmAdd(pValue:boolean);
begin
  WriteData('AOB',cAobItmAdd,pValue);
end;

function TAfc.ReadAobItmDel:boolean;
begin
  Result:=ReadData('AOB',cAobItmDel);
end;

procedure TAfc.WriteAobItmDel(pValue:boolean);
begin
  WriteData('AOB',cAobItmDel,pValue);
end;

function TAfc.ReadAobItmMod:boolean;
begin
  Result:=ReadData('AOB',cAobItmMod);
end;

procedure TAfc.WriteAobItmMod(pValue:boolean);
begin
  WriteData('AOB',cAobItmMod,pValue);
end;

// --------------------------------- AOB ---------------------------------------
function TAfc.ReadAlbDocAdd:boolean;
begin
  Result:=ReadData('ALB',cAlbDocAdd);
end;

procedure TAfc.WriteAlbDocAdd(pValue:boolean);
begin
  WriteData('ALB',cAlbDocAdd,pValue);
end;

function TAfc.ReadAlbDocDel:boolean;
begin
  Result:=ReadData('ALB',cAlbDocDel);
end;

procedure TAfc.WriteAlbDocDel(pValue:boolean);
begin
  WriteData('ALB',cAlbDocDel,pValue);
end;

function TAfc.ReadAlbDocDsc:boolean;
begin
  Result:=ReadData('ALB',cAlbDocDsc);
end;

procedure TAfc.WriteAlbDocDsc(pValue:boolean);
begin
  WriteData('ALB',cAlbDocDsc,pValue);
end;

function TAfc.ReadAlbDocLck:boolean;
begin
  Result:=ReadData('ALB',cAlbDocLck);
end;

procedure TAfc.WriteAlbDocLck(pValue:boolean);
begin
  WriteData('ALB',cAlbDocLck,pValue);
end;

function TAfc.ReadAlbDocUnl:boolean;
begin
  Result:=ReadData('ALB',cAlbDocUnl);
end;

procedure TAfc.WriteAlbDocUnl(pValue:boolean);
begin
  WriteData('ALB',cAlbDocUnl,pValue);
end;

function TAfc.ReadAlbDocMod:boolean;
begin
  Result:=ReadData('ALB',cAlbDocMod);
end;

procedure TAfc.WriteAlbDocMod(pValue:boolean);
begin
  WriteData('ALB',cAlbDocMod,pValue);
end;

function TAfc.ReadAlbDatMod:boolean;
begin
  Result:=ReadData('ALB',cAlbDatMod);
end;

procedure TAfc.WriteAlbDatMod(pValue:boolean);
begin
  WriteData('ALB',cAlbDatMod,pValue);
end;

function TAfc.ReadAlbDocRev:boolean;
begin
  Result:=ReadData('ALB',cAlbDocRev);
end;

procedure TAfc.WriteAlbDocRev(pValue:boolean);
begin
  WriteData('ALB',cAlbDocRev,pValue);
end;

function TAfc.ReadAlbSitLst:boolean;
begin
  Result:=ReadData('ALB',cAlbSitLst);
end;

procedure TAfc.WriteAlbSitLst(pValue:boolean);
begin
  WriteData('ALB',cAlbSitLst,pValue);
end;

function TAfc.ReadAlbDocPrn:boolean;
begin
  Result:=ReadData('ALB',cAlbDocPrn);
end;

procedure TAfc.WriteAlbDocPrn(pValue:boolean);
begin
  WriteData('ALB',cAlbDocPrn,pValue);
end;

function TAfc.ReadAlbDocFlt:boolean;
begin
  Result:=ReadData('ALB',cAlbDocFlt);
end;

procedure TAfc.WriteAlbDocFlt(pValue:boolean);
begin
  WriteData('ALB',cAlbDocFlt,pValue);
end;

function TAfc.ReadAlbAldIcg:boolean;
begin
  Result:=ReadData('ALB',cAlbAldIcg);
end;

procedure TAfc.WriteAlbAldIcg(pValue:boolean);
begin
  WriteData('ALB',cAlbAldIcg,pValue);
end;

function TAfc.ReadAlbAldFmg:boolean;
begin
  Result:=ReadData('ALB',cAlbAldFmg);
end;

procedure TAfc.WriteAlbAldFmg(pValue:boolean);
begin
  WriteData('ALB',cAlbAldFmg,pValue);
end;

function TAfc.ReadAlbDocClc:boolean;
begin
  Result:=ReadData('ALB',cAlbDocClc);
end;

procedure TAfc.WriteAlbDocClc(pValue:boolean);
begin
  WriteData('ALB',cAlbDocClc,pValue);
end;

function TAfc.ReadAlbItmAdd:boolean;
begin
  Result:=ReadData('ALB',cAlbItmAdd);
end;

procedure TAfc.WriteAlbItmAdd(pValue:boolean);
begin
  WriteData('ALB',cAlbItmAdd,pValue);
end;

function TAfc.ReadAlbItmDel:boolean;
begin
  Result:=ReadData('ALB',cAlbItmDel);
end;

procedure TAfc.WriteAlbItmDel(pValue:boolean);
begin
  WriteData('ALB',cAlbItmDel,pValue);
end;

function TAfc.ReadAlbItmMod:boolean;
begin
  Result:=ReadData('ALB',cAlbItmMod);
end;

procedure TAfc.WriteAlbItmMod(pValue:boolean);
begin
  WriteData('ALB',cAlbItmMod,pValue);
end;

function TAfc.ReadAlbCsiGen:boolean;
begin
  Result:=ReadData('ALB',cAlbCsiGen);
end;

procedure TAfc.WriteAlbCsiGen(pValue:boolean);
begin
  WriteData('ALB',cAlbCsiGen,pValue);
end;

function TAfc.ReadAlbCseGen:boolean;
begin
  Result:=ReadData('ALB',cAlbCseGen);
end;

procedure TAfc.WriteAlbCseGen(pValue:boolean);
begin
  WriteData('ALB',cAlbCseGen,pValue);
end;

function TAfc.ReadAlbRetPro:boolean;
begin
  Result:=ReadData('ALB',cAlbRetPro);
end;

procedure TAfc.WriteAlbRetPro(pValue:boolean);
begin
  WriteData('ALB',cAlbRetPro,pValue);
end;

function TAfc.ReadAlbAliOut:boolean;
begin
  Result:=ReadData('ALB',cAlbAliOut);
end;

procedure TAfc.WriteAlbAliOut(pValue:boolean);
begin
  WriteData('ALB',cAlbAliOut,pValue);
end;

// ---------------------------------- POB --------------------------------------

function TAfc.ReadPobDocAdd:boolean;
begin
  Result:=ReadData('POB',cPobDocAdd);
end;

procedure TAfc.WritePobDocAdd(pValue:boolean);
begin
  WriteData('POB',cPobDocAdd,pValue);
end;

function TAfc.ReadPobDocDel:boolean;
begin
  Result:=ReadData('POB',cPobDocDel);
end;

procedure TAfc.WritePobDocDel(pValue:boolean);
begin
  WriteData('POB',cPobDocDel,pValue);
end;

function TAfc.ReadPobDocMod:boolean;
begin
  Result:=ReadData('POB',cPobDocMod);
end;

procedure TAfc.WritePobDocMod(pValue:boolean);
begin
  WriteData('POB',cPobDocMod,pValue);
end;

function TAfc.ReadPobDocDsc:boolean;
begin
  Result:=ReadData('POB',cPobDocDsc);
end;

procedure TAfc.WritePobDocDsc(pValue:boolean);
begin
  WriteData('POB',cPobDocDsc,pValue);
end;

function TAfc.ReadPobSitLst:boolean;
begin
  Result:=ReadData('POB',cPobSitLst);
end;

procedure TAfc.WritePobSitLst(pValue:boolean);
begin
  WriteData('POB',cPobSitLst,pValue);
end;

function TAfc.ReadPobExdPrn:boolean;
begin
  Result:=ReadData('POB',cPobExdPrn);
end;

procedure TAfc.WritePobExdPrn(pValue:boolean);
begin
  WriteData('POB',cPobExdPrn,pValue);
end;

function TAfc.ReadPobDocFlt:boolean;
begin
  Result:=ReadData('POB',cPobDocFlt);
end;

procedure TAfc.WritePobDocFlt(pValue:boolean);
begin
  WriteData('POB',cPobDocFlt,pValue);
end;

function TAfc.ReadPobExdGen:boolean;
begin
  Result:=ReadData('POB',cPobExdGen);
end;

procedure TAfc.WritePobExdGen(pValue:boolean);
begin
  WriteData('POB',cPobExdGen,pValue);
end;

function TAfc.ReadPobFmdGen:boolean;
begin
  Result:=ReadData('POB',cPobFmdGen);
end;

procedure TAfc.WritePobFmdGen(pValue:boolean);
begin
  WriteData('POB',cPobFmdGen,pValue);
end;

function TAfc.ReadPobIcdGen:boolean;
begin
  Result:=ReadData('POB',cPobIcdGen);
end;

procedure TAfc.WritePobIcdGen(pValue:boolean);
begin
  WriteData('POB',cPobIcdGen,pValue);
end;

function TAfc.ReadPobDocClc:boolean;
begin
  Result:=ReadData('POB',cPobDocClc);
end;

procedure TAfc.WritePobDocClc(pValue:boolean);
begin
  WriteData('POB',cPobDocClc,pValue);
end;

function TAfc.ReadPobItmAdd:boolean;
begin
  Result:=ReadData('POB',cPobItmAdd);
end;

procedure TAfc.WritePobItmAdd(pValue:boolean);
begin
  WriteData('POB',cPobItmAdd,pValue);
end;

function TAfc.ReadPobItmDel:boolean;
begin
  Result:=ReadData('POB',cPobItmDel);
end;

procedure TAfc.WritePobItmDel(pValue:boolean);
begin
  WriteData('POB',cPobItmDel,pValue);
end;

function TAfc.ReadPobItmMod:boolean;
begin
  Result:=ReadData('POB',cPobItmMod);
end;

procedure TAfc.WritePobItmMod(pValue:boolean);
begin
  WriteData('POB',cPobItmMod,pValue);
end;

// ********************************** RPL **************************************

function TAfc.ReadRplImpDat:boolean;
begin
  Result:=ReadData('RPL',cRplImpDat);
end;

procedure TAfc.WriteRplImpDat(pValue:boolean);
begin
  WriteData('RPL',cRplImpDat,pValue);
end;

function TAfc.ReadRplImpPls:boolean;
begin
  Result:=ReadData('RPL',cRplImpPls);
end;

procedure TAfc.WriteRplImpPls(pValue:boolean);
begin
  WriteData('RPL',cRplImpPls,pValue);
end;

function TAfc.ReadRplImpNew:boolean;
begin
  Result:=ReadData('RPL',cRplImpNew);
end;

procedure TAfc.WriteRplImpNew(pValue:boolean);
begin
  WriteData('RPL',cRplImpNew,pValue);
end;

function TAfc.ReadRplItmEdi:boolean;
begin
  Result:=ReadData('RPL',cRplItmEdi);
end;

procedure TAfc.WriteRplItmEdi(pValue:boolean);
begin
  WriteData('RPL',cRplItmEdi,pValue);
end;

function TAfc.ReadRplItmFil:boolean;
begin
  Result:=ReadData('RPL',cRplItmFil);
end;

procedure TAfc.WriteRplItmFil(pValue:boolean);
begin
  WriteData('RPL',cRplItmFil,pValue);
end;

function TAfc.ReadRplDisRpl:boolean;
begin
  Result:=ReadData('RPL',cRplDisRpl);
end;

procedure TAfc.WriteRplDisRpl(pValue:boolean);
begin
  WriteData('RPL',cRplDisRpl,pValue);
end;

function TAfc.ReadRplStpClc:boolean;
begin
  Result:=ReadData('RPL',cRplStpClc);
end;

procedure TAfc.WriteRplStpClc(pValue:boolean);
begin
  WriteData('RPL',cRplStpClc,pValue);
end;

function TAfc.ReadRplExcClc:boolean;
begin
  Result:=ReadData('RPL',cRplExcClc);
end;

procedure TAfc.WriteRplExcClc(pValue:boolean);
begin
  WriteData('RPL',cRplExcClc,pValue);
end;

end.

{MOD 1915001 - Nový prepracovaný modul - Zmluvné podmienky odberate¾ov }
