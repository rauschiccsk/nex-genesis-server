unit DocHand;

interface

uses
  LangForm, IcTypes, IcVariab, IcConst, IcTools, IcConv, IcDate,IcValue, StkHand, BtrHand, BtrTools,
  NexTypes, NexText, NexPath, NexMsg, NexIni, NexError, NexGlob, StkGlob, Variants, StkCanc, Key, hGSCAT, hPAB, hSPV, hDEBREG,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ProcInd_, Dialogs, ExtCtrls, IcStand, ComCtrls, IcLabels, IcInfoFields,
  StdCtrls, BtrTable, NexBtrTable, NexPxTable, DB;

const cCDMItmAdd=1000000;

type
  TF_DocHand = class(TForm)
    P_Back: TDinamicPanel;
    PB_Indicator: TProgressBar;
    L_InfoLine: TCenterLabel;
    DoubleBevel1: TDoubleBevel;
    DoubleBevel3: TDoubleBevel;
    L_Describe: TCenterLabel;
    PB_Correction: TProgressBar;
    btICH: TNexBtrTable;
    btICI: TNexBtrTable;
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  private
    oStHand: TSubtract;
    oCValue: double;
    oOcdNums: TStrings;
  public
    function GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
    procedure DocStmSum (pDocNum:Str12; pItmNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku

    function InputTsItm: boolean;  // Prijem aktualnej polozky TSI do skladu
    procedure InputTsDoc (pDocNum:Str12);  // Prijem alebo vydaj celeho dokladu DDL
    function OutputTcItm: boolean;  // Prijem aktualnej polozky TCI zo skladu
    function OutputTcDoc (pDocNum:Str12):word;  // Vydaj alebo prijem celeho dokladu ODL - hodnota funkcie je pocet zo skladu nevydanych poloziek
    function InputImItm: boolean;  // Prijem aktualnej polozky IMI do skladu
    procedure InputImDoc (pDocNum:Str12);  // Prijem alebo vydaj celeho dokladu SP
    function OutputOmItm: boolean;  // Vydaj alebo Prijem aktualnej polozky OMI do skladu
    function OutputOmi(pOMH,pOMI:TNexBtrTable): boolean;  // Odpocita aktualnu polozku OMI zo skladu
    procedure OutputOmDoc (pDocNum:Str12);  // Vydaj alebo Prijem celeho dokladu SP

    function OutputRmItm: boolean;  // Vydaj aktualnej polozky RMI do skladu
    function InputRmItm: boolean;  // Prijem aktualnej polozky RMI do skladu

    function OutputPkItm: boolean;  // Vydaj aktualnej polozky PKI do skladu
    function InputPkItm: boolean;  // Prijem aktualnej polozky PKI do skladu

    function OutputCmItm: boolean;  // Vydaj polozky CMI do skladu
    function InputCmPd: boolean;  // prijem kompetizovaneho vyrobku

    function OutputCDM: boolean;  // Vydaj komponentu CDM zo skladu
    function OutputCDM_DI(pRunTrans:boolean;pDocNum:Str12;pItmNum:longint;var pCValue:double): boolean;  // Odpocita komponenty
    function InputCDI: boolean;  // prijem vyrobku na skald

    function InputDmItm: boolean;  // Prijem polozky DMI do skladu
    function OutputDmPd: boolean;  // Vydaj rozobrateho vyrobku

    function OutputSaItm (btSAI:TNexBtrTable): boolean;  // Prijem aktualnej polozky SAI zo skladu
    function OutputSaDoc (btSAH,btSAI:TNexBtrTable;pIndicator:TProgressBar):word;  // Vydaj alebo prijem celeho dokladu MO predaja

    function PackedPkItm (btPKH,btPKI:TNexBtrTable): boolean;  // Prebalenie aktualnej polozky PKI
    function PackedPkDoc (btPKH,btPKI:TNexBtrTable;var pIndicator:TProgressBar):word;  // Prebalenie celeho dokladu
    function ProdCdbDoc  (btCDH,btCDI,btCDM:TNexBtrTable;var pIndicator:TProgressBar):word;  // vyroba celeho dokladu
    function VerifyRba   (pStkNum,pGsCode:longint;pRbaCode:Str30;pQnt:Double;var pRbaQnt,pRbnQnt,pRboQnt:double;var pRbaDate:TDate):boolean;
  published
    property CValue:double read oCValue;
    property OcdNums:TStrings read oOcdNums;
  end;

  TIcdCrdValCalc = class
  private
    oEyCrdVal: double;
  public
    procedure CrdValCalc(pDocNum:Str12;pDocDate:TDateTime);
  published
    property EyCrdVal:double read oEyCrdVal; // Kurzovy rozdiel z prekurzovania faktur
  end;

  TIsdCrdValCalc = class
  private
    oEyCrdVal: double;
  public
    procedure CrdValCalc(pDocNum:Str12;pDocDate:TDateTime);
  published
    property EyCrdVal:double read oEyCrdVal; // Kurzovy rozdiel z prekurzovania faktur
  end;

  // Vseobecne
  function OpenDoc (pDocNum:Str12): boolean;  //Zaregistruje ze doklad je otvoreny, TRUE doklad nie je otvoreny inym uzivatelom
  procedure RefreshDoc (pDocNum:Str12);  //Zaznamena zmenu udajov dokladu
  procedure CloseDoc  (pDocNum:Str12);  //Odstrani registraciu, ze doklad je otvoreny
  function GenExtNum  (pDocDate:TDate;pExtNum,pExnFrm:Str12; pSerNum:longint; pBookNum:Str5; pStkNum:word): Str12; // Hodnota funkcie je externe cislo dokladu generovane podla zadaneho formatu pExnFrm
  function GetDocType (pDocNum:Str12):byte; // Hodnota funkcie je typ zadaneho dokladu
  function GetPmdMark (pDocNum:ShortString):ShortString; // Hodnota funkcie je oznaèenie programového modulu

  function BookNumFromDocNum (pDocNum:Str12):Str5; // Hodnotou funkcie je cislo knihy, ktore obsahuje zadane cislo dokladu
  function YearFromDocNum (pDocNum:Str12):Str2; // Hodnotou funkcie je rok, ktore obsahuje zadane cislo dokladu
  function SerNumFromDocNum (pDocNum:Str12):longint; // Hodnotou funkcie je cislo knihy, ktore obsahuje zadane cislo dokladu

  function GetDstAcc (pDocNum:Str12):Str1; // Funkcia prekontroluje v denniku ci su uctovne zapisy na dany doklad ak ano vrati priznak "A"
  function GetDocTypeName (pDocNum:Str12):Str60; // Hodnota funkcie je nazov typu zadaneho dokladu

  // Generovanie interneho cisla dokladu
  function GenAcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Akciove precenenie tovaru
  function GenAfDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Akciove precenenie tovaru
  function GenAmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Prenajom tovaru
  function GenAoDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; //
  function GenApDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; //
  function GenAlDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; //
  function GenCdDocNum (pYear:Str2;pBookNum:Str5; pSerNum:longint): Str12; // Vyroba vyrobkov
  function GenClDocNum (pBookNum:Str5; pSerNum:longint): Str12; // Zakaznicka reklamacia
  function GenCmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad kompletizacie
  function GenCsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint; pDocType:Str1): Str12; // Hotovostna pokladna
  function GenDmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad rozobratia
  function GenDpDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad pohladavky
  function GenDiDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad pohladavky faktury
  function GenEoDocNum (pYear:Str2; pCntNum,pSerNum:longint): Str12; // Odoslane spravy
  function GenEpDocNum (pYear:Str2; pCntNum,pSerNum:longint): Str12; // Cislo dokladu prijatej spravy
  function GenIcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska faktura
  function GenIdDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Interne uctovne doklady
  function GenIpDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Dosal posta
  function GenIsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska faktura
  function GenImDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Interna skladova prijemka
  function GenKsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
  function GenMcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska zakazka
  function GenOmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Interna skladova vydajka
  function GenOcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska zakazka
  function GenOsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska faktura
  function GenOwDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Interne uctovne doklady
  function GenPcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelska zalohova faktura
  function GenPkDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Prebalovanie tovaru
  function GenPoDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; //
  function GenPqDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Prevodny prikaz
  function GenPsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Plan objednavok
  function GenReDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Precenovaci doklad
  function GenRmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Medziskladovy presun
  function GenSaDocNum (pBookNum:Str5; pDate:TDateTime): Str12; // Skaldove vydajky MO predaja
  function GenScDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Servisna zakazka
  function GenSeDocNum (pBookNum,pSerNum:longint): Str12; // Doklady zalohovych platieb
  function GenSoDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Bankove vypisy
  function GenSvDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo danoveho dokladu zalohovej platby
  function GenTcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Odberatelsky dodaci list
  function GenTsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Dodavatelsky dodaci list
  function GenToDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Terminalovy vydaj
  function GenTiDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Terminalovy prijem
  function GenUdDocNum (pBookNum:Str5; pSerNum:longint): Str12; // Univerzalny odbytovy doklad
  function GenWaDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; //
  function GenPrDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Podnikove projekty
  function GenCrDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Zakaznícke požiadavky
  function GenXrDocNum (pYear:Str2; pSerNum:longint): Str12; // XLS výkazy

  function NextSerNumBtr(pTable:TNexBtrTable): longint; // Funkcia vrati nasledujuce volne poradove cislo cestovneho prikazku

  // Vynechane poradove cislo polozky zadaneho dokladu
  function ImiFreeItmNum (pIMI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function OmiFreeItmNum (pOMI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
//  function OsiFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
//  function OciFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function TciFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function TsiFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function IciFreeItmNum (pICI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function PciFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
  function IsiFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu

  // Nasledujece volne poradove cislo polozky zadaneho dokladu
  function ImiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky SP
  function OmiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky SV
  function PsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky zalohovej faktury
//  function OsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky dodavetelskej objednavky
  function UdiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky UD
//  function OciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ZK
  function TciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
  function TsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
  function SciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky SZ - tovar
  function ScsNextItmNum (pDocNum:Str12;pCsType:Str1): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky SZ - sluzby
  function IciNextItmNum (pICI:TNexBtrTable;pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
  function PciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky zalohovej faktury
  function IsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL

  // Nacita polizky zadaneho dokladu do docasnej databaze
  procedure LoadTsdToTmp (pBtTsi:TNexBtrTable; pPxTsi:TNexPxTable);

  // Prepocet hlavicky dokladu na zaklade jeho poloziek
  procedure ImhRecalc (pIMH,pIMI:TNexBtrTable);  //Prepocita hlavicku zadanej internej skladovej prijemky
  procedure OmhRecalc (pOMH,pOMI:TNexBtrTable);  //Prepocita hlavicku zadanej internej skladovej vydajok
  procedure RmhRecalc (pRMH,pRMI:TNexBtrTable);  //Prepocita hlavicku zadaneho medziskladoveho presunu
  procedure CmhRecalc (pCMH,pCMI:TNexBtrTable);  //Prepocita hlavicku dokladu kompletizacie
  procedure DmhRecalc (pDMH,pDMI:TNexBtrTable);  //Prepocita hlavicku dokladu rozobratia vyrobku
  procedure PkhRecalc (pPKH,pPKI:TNexBtrTable);  //Prepocita hlavicku prebalovacieho dokladu
  procedure RehRecalc (pREH,pREI:TNexBtrTable);  //Prepocita hlavicku precenovacieho dokladu
  procedure AchRecalc (pACH,pACI:TNexBtrTable);  //Prepocita hlavicku dokladu akciovych preceneni
  procedure AfhRecalc (pAfH,pAfI:TNexBtrTable);  //Prepocita hlavicku dokladu akcioveho letaka
  procedure CphRecalc (pCPH,pCPI:TNexBtrTable);  //Prepocita hlavicku kalkulacii vyrobku
  procedure CdhRecalc (pCDH,pCDI,pCDM:TNexBtrTable);  //Prepocita hlavicku vyrobneho dokladu
  procedure CdiRecalc (pCDI,pCDM:TNexBtrTable);  //Prepocita polozku vyrobneho dokladu

  procedure PshRecalc (pPSH,pPSI:TNexBtrTable);  //Prepocita hlavicku zadanej objednavky podla jej poloziek
//  procedure OshRecalc (pOSH,pOSI:TNexBtrTable);  //Prepocita hlavicku zadanej objednavky podla jej poloziek
  procedure TshRecalc (pTSH,pTSI:TNexBtrTable);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
  procedure TihRecalc (pTIH,pTII:TNexBtrTable);  // Prepocita hlavicku zadanej terminalovej vydajky

  procedure SahRecalc (pSAH,pSAI:TNexBtrTable;pInd:TProgressBar);  //Prepocita hlavicku zadaneho dokladu podla jej poloziek
  procedure UdhRecalc (pUDH,pUDI:TNexBtrTable);  //Prepocita hlavicku zadaneho dokladu podla jej poloziek
  procedure TchRecalc (pTCH,pTCI:TNexBtrTable);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
  procedure IchRecalc (pICH,pICI:TNexBtrTable);  //Prepocita hlavicku zadanej faktury podla jej poloziek
  procedure SchRecalc (pSCH,pSCI,pSCS:TNexBtrTable);  //Prepocita hlavicku zadanej zakazky podla jej poloziek
  procedure AlhRecalc (pALH,pALI:TNexBtrTable);  //Prepocita hlavicku zadaneho dokladu podla jej poloziek

  procedure PchRecalc (pDocNum:Str12);  //Prepocita hlavicku zadanej zalohovej faktury podla jej poloziek
  procedure IshRecalc (pISH,pISI:TNexBtrTable);  //Prepocita hlavicku zadanej faktury podla jej poloziek

  procedure CshRecalc (pCSH,pCSI:TNexBtrTable);  // Prepocita hlavicku zadaneho pokladnicneho dokladu podla jeho poloziek
  procedure PqhRecalc (pPQH,pPQI:TNexBtrTable);  // Prepocita hlavicku prevodneho prikazu na ktorom stoji kurzor PQH
  procedure IdhRecalc (pIDH,pIDI:TNexBtrTable);  // Prepocita hlavicku zadaneho uctovneho dokladu podla jeho poloziek
  procedure FxaRecalc (pFXA,pFXT:TNexBtrTable);  // Prepocita inventarnu kartu dlhodobeho majetku
  procedure OwhRecalc (pOWH,pOWI:TNexBtrTable);  // Prepocita hlavicku dokladu vyuctovania sluzobnej cesty

  procedure IvdRecalc (pIndicator:TProgressBar); // Prepocita vydajky MO predaja
  procedure MtcRecalc (pMtCode:longint); // Prepocita udaje skladovej karty MTZ

  procedure RchRecalc (pHEAD,pITEM:TNexBtrTable);  // Prepocita hlavicku dokladu prekurzovania DA

  // Rezervacia hlavicky dookladu pod zadanym poradovycm cislom
  procedure ImhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SP v knihe ktora je otvorena
  procedure OmhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SP v knihe ktora je otvorena
  procedure RmhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku MP v knihe ktora je otvorena
  procedure CmhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku DK v knihe ktora je otvorena
  procedure DmhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku DR v knihe ktora je otvorena
  procedure PkhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku prebalovacieho dokladu v knihe ktora je otvorena
  procedure RehReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku precenovacieho dokladu
  procedure AchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku precenovacieho dokladu
  procedure CdhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku vyrobneho dokladu v knihe ktora je otvorena

  procedure PshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku planu objednavok
  procedure TshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku oDDL v knihe ktora je otvorena

  procedure UdhReserve (pUDH:TNexBtrTable;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku UD v knihe ktora je otvorena
  procedure TchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku odberatelskeho DL v knihe ktora je otvorena
  procedure IchReserve (pICH:TNexBtrTable;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku OF v knihe ktora je otvorena
  procedure SchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SZ v knihe ktora je otvorena

  procedure IdhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku ID v knihe ktora je otvorena
  procedure IshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku DF v knihe ktora je otvorena
  procedure PchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku zalohovej FA v knihe ktora je otvorena
  procedure OwhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SC v knihe ktora je otvorena
  procedure AlhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku ZN v knihe ktora je otvorena

  // Uvolnenie rezervacii
  procedure ImhUnReserve; // Zrusi rezervaciu hlavicky SP
  procedure OmhUnReserve; // Zrusi rezervaciu hlavicky SV
  procedure RmhUnReserve; // Zrusi rezervaciu hlavicky SV
  procedure CmhUnReserve; // Zrusi rezervaciu hlavicky DK
  procedure DmhUnReserve; // Zrusi rezervaciu hlavicky DR
  procedure PkhUnReserve; // Zrusi rezervaciu hlavicky prebalovacieho dokladu
  procedure RehUnReserve; // Zrusi rezervaciu hlavicky precenovacieho odkladu
  procedure AchUnReserve; // Zrusi rezervaciu hlavciky akcioveho precenenia
  procedure CdhUnReserve; // Zrusi rezervaciu hlavicky vyrobneho dokladu

  procedure PshUnReserve; // Zrusi rezervaciu hlavciky planu objednavok
  procedure TshUnReserve; // Zrusi rezervaciu hlavicky DDL

  procedure UdhUnReserve (pUDH:TNexBtrTable); // Zrusi rezervaciu hlavicky UD
  procedure TchUnReserve; // Zrusi rezervaciu hlavicky ODL
  procedure IchUnReserve (pICH:TNexBtrTable); // Zrusi rezervaciu hlavicky OF
  procedure SchUnReserve; // Zrusi rezervaciu hlavicky SZ

  procedure IdhUnReserve; // Zrusi rezervaciu hlavicky ID
  procedure IshUnReserve; // Zrusi rezervaciu hlavicky DF
  procedure PchUnReserve; // Zrusi rezervaciu hlavicky zalohovej faktury
  procedure OwhUnReserve; // Zrusi rezervaciu hlavicky CP
  procedure AlhUnReserve; // Zrusi rezervaciu hlavicky ZN

  // Kontrola rezervacie - TRUE ak je doklad reervovany a zarezervoval prihlaseny uzivatel
  function ImhIsMyReserve: boolean;
  function OmhIsMyReserve: boolean;
  function RmhIsMyReserve: boolean;
  function CmhIsMyReserve: boolean;
  function DmhIsMyReserve: boolean;
  function PkhIsMyReserve: boolean;
  function RehIsMyReserve: boolean;
  function AchIsMyReserve: boolean;
  function CDhIsMyReserve: boolean;

  function PshIsMyReserve: boolean;
  function TshIsMyReserve: boolean;

  function UdhIsMyReserve (pUDH:TNexBtrTable): boolean;
  function TchIsMyReserve: boolean;
  function IchIsMyReserve (pICH:TNexBtrTable): boolean;
  function SchIsMyReserve: boolean;

  function IdhIsMyReserve: boolean;
  function IshIsMyReserve: boolean;
  function PchIsMyReserve: boolean;
  function OwhIsMyReserve: boolean;
  function AlhIsMyReserve: boolean;

  // Kontrola rezervacie - TRUE ak je doklad reervovany
  function ImhIsReserved: boolean;
  function OmhIsReserved: boolean;
  function RmhIsReserved: boolean;
  function CmhIsReserved: boolean;
  function DmhIsReserved: boolean;
  function PkhIsReserved: boolean;
  function RehIsReserved: boolean;
  function AchIsReserved: boolean;
  function CdhIsReserved: boolean;

  function PshIsReserved: boolean;
  function TshIsReserved: boolean;
  function AlhIsReserved: boolean;

  function UdhIsReserved (pUDH:TNexBtrTable): boolean;
  function TchIsReserved: boolean;
  function IchIsReserved (pICH:TNexBtrTable): boolean;
  function IdhIsReserved (pIDH:TNexBtrTable): boolean;
  function SchIsReserved: boolean;

  function OwhIsReserved: boolean;

  // Vymaze poznamky zo zadaneho dokladu
  procedure ImhNoticeDelete (pDocNum:Str12);
  procedure OmhNoticeDelete (pDocNum:Str12);
  procedure RmhNoticeDelete (pDocNum:Str12);
  procedure CmhNoticeDelete (pDocNum:Str12);
  procedure DmhNoticeDelete (pDocNum:Str12);
  procedure TchNoticeDelete (pDocNum:Str12);
  procedure IchNoticeDelete (pDocNum:Str12);
  procedure SchNoticeDelete (pDocNum:Str12);
  procedure TshNoticeDelete (pDocNum:Str12);
  procedure IshNoticeDelete (pDocNum:Str12);
  procedure OchNoticeDelete (pDocNum:Str12);
//  procedure OshNoticeDelete (pDocNum:Str12);
  procedure PshNoticeDelete (pDocNum:Str12);
  procedure OwhNoticeDelete (pDocNum:Str12);

  procedure NoticeDelete (pTable:TNexBtrTable;pDocNum:Str12);
  procedure NoticeSave (pTable:TNexBtrTable;pDocNum:Str12;pNotice:TMemo;pNotType:Str1);
  procedure NoticeLoad (pTable:TNexBtrTable;pDocNum:Str12;pNotice:TMemo;pNotType:Str1);

  // Odparuje zadanu polozku zadaneho dokladu
  procedure TciUnPair (pDocNum:Str12;pItmNum:word);
  procedure TsiUnPair (pDocNum:Str12;pItmNum:word);
  procedure IciUnPair (pDocNum:Str12;pItmNum:word);
  procedure IsiUnPair (pDocNum:Str12;pItmNum:word);

  procedure DeletePdn (pDocNum:Str12;pItmNum,pStkNum:word);

  procedure CMI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);

  // PSB - Planu dodavate;skych objednavok
  procedure PsiClearOsd (pDocNum:Str12;pItmNum:word); // Odstrani odkaz z polozky zakazky na OBJ

  // OCB - Odberatelske zakazky
  procedure TchStatRefresh (pDocNum:Str12);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek

  function NoPayIcdOneBook (pBookNum:Str5; pPaCode:longint):double;  //Hodnota neuhradenych faktur zadanaho partnera zo zadanej knihy
  function NoPayIcdAllBook (pPaCode:longint):double;  //Hodnota neuhradenych faktur zadanaho partnera zo vsetkuch knih

  function IchPayValRecalc (var pIchTable:TNexBtrTable):boolean; // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA - hodnota funkcie je TRUE ak bol zisteny nejaky rozdiel
  function IshPayValRecalc (var pIshTable:TNexBtrTable):boolean; // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA - hodnota funkcie je TRUE ak bol zisteny nejaky rozdiel

  procedure LoadDocFromJrn (pDocNum:Str12); // Nacita uctovne zapisy zadaneho dokladu do databaze ptACC

  procedure DetermineTra (var pItmData:TItmData);overload; // Nastavy ocbodne podmienky a vypocita cenu
  procedure CalcAcValues (var pItmData:TItmData);overload; // Vypocita hodnoty v uctovnej mene
  procedure CalcFromAValue (var pItmData:TItmData);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave
  procedure CalcFromBValue (var pItmData:TItmData);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave

  procedure DetermineTra   (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Nastavy ocbodne podmienky a vypocita cenu
  procedure CalcFromAValue (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave
  procedure CalcFromBValue (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave

  procedure DetermineTra   (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte;pAplItm,pFgPaDsc,pDlrDsc,pDlrLst:TNexBtrTable);overload; // Nastavy ocbodne podmienky a vypocita cenu

  procedure DelNotice (pTable:TNexBtrTable;pDocNum:Str12);
  procedure SaveNotice (pTable:TNexBtrTable;pDocNum:Str12;pNotType:Str1;pNotice:TStrings);
  procedure LoadNotice (pTable:TNexBtrTable;pDocNum:Str12;pNotType:Str1;pNotice:TStrings);

  Function UnlockReasonDocument(pMessage:integer;pParam:Str200; pBtr:TNexBtrTable):boolean;
  // MCB - Odberatelske cenove ponuky

  procedure MchRecalc (pMCH,pMCI:TNexBtrTable);  //Prepocita hlavicku zadanej cenovej ponuky podla jej poloziek
  procedure MchNoticeDelete (pDocNum:Str12);
  procedure MchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku cenovej ponuky
  procedure MchUnReserve; // Zrusi rezervaciu hlavicky CP
  function MchIsMyReserve: boolean;
  function MchIsReserved: boolean;
  function VtrLstYearSerNum:Str5;

var
  F_DocHand: TF_DocHand;

implementation

uses
   PayFnc,
   Sys_UnlEdit_F, SavClc, SPC, pBOKLST, Bok,
   DM_SYSTEM, DM_STKDAT, DM_LDGDAT, DM_DLSDAT, bSPV;

{$R *.DFM}

procedure MchRecalc (pMCH,pMCI:TNexBtrTable);  //Prepocita hlavicku zadanej cenovej ponuky podla jej poloziek
var mItmQnt:longint;   I:byte; mEquVal:double;
    mProVal,mAcCValue,mAcDValue,mAcDscVal,mFgCValue,mFgDValue,mFgDscVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;
begin
  mItmQnt:=0;    mEquVal:=0;    mProVal:=0;
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pMCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcBValue.VatPrc[I]:=pMCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgAValue.VatPrc[I]:=pMCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgBValue.VatPrc[I]:=pMCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  pMCI.SwapIndex;
  pMCI.IndexName:='DocNum';
  If pMCI.FindKey ([pMCH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue:=mAcCValue+pMCI.FieldByName('AcCValue').AsFloat;
      mAcDValue:=mAcDValue+pMCI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pMCI.FieldByName('AcDscVal').AsFloat;
      mFgCValue:=mFgCValue+pMCI.FieldByName('FgCValue').AsFloat;
      mFgDValue:=mFgDValue+pMCI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pMCI.FieldByName('FgDscVal').AsFloat;
      mAcAValue.Add (pMCI.FieldByName('VatPrc').AsInteger,pMCI.FieldByName('AcAValue').AsFloat);
      mAcBValue.Add (pMCI.FieldByName('VatPrc').AsInteger,pMCI.FieldByName('AcBValue').AsFloat);
      mFgAValue.Add (pMCI.FieldByName('VatPrc').AsInteger,pMCI.FieldByName('FgAValue').AsFloat);
      mFgBValue.Add (pMCI.FieldByName('VatPrc').AsInteger,pMCI.FieldByName('FgBValue').AsFloat);
      If (pMCI.FieldByName('OcdNum').AsString<>'') or (pMCI.FieldByName('TcdNum').AsString<>'') or IsNotNul(pMCI.FieldByName('DlvQnt').AsFloat) then begin
        mEquVal:=mEquVal+(pMCI.FieldByName('DlvQnt').AsFloat*pMCI.FieldByName('FgBPrice').AsFloat);
      end;
      pMCI.Next;
    until (pMCI.Eof) or (pMCI.FieldByName('DocNum').AsString<>pMCH.FieldByName('DocNum').AsString);
  end;
  pMCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pMCH.Edit;
  If pMCH.FieldByName('FgCourse').AsFloat=1 then begin
    If IsNotNul (mAcDValue)
      then pMCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mAcDscVal/mAcDValue)*100)
      else pMCH.FieldByName('DscPrc').AsFloat:=0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then pMCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/mFgDValue)*100)
      else pMCH.FieldByName('DscPrc').AsFloat:=0;
  end;
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(pMCH.FieldByName('VatDoc').AsInteger));
  pMCH.FieldByName('ProVal').AsFloat :=mAcAValue.Value[0]-mAcCValue;
  If mAcCValue<>0 then pMCH.FieldByName('ProPrc').AsFloat :=(pMCH.FieldByName('ProVal').AsFloat/mAcCValue*100);
  pMCH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pMCH.FieldByName('AcDValue').AsFloat:=mAcDValue;
  pMCH.FieldByName('AcDscVal').AsFloat:=mAcDscVal;
  pMCH.FieldByName('AcAValue').AsFloat:=mAcAValue.Value[0];
  pMCH.FieldByName('AcVatVal').AsFloat:=mAcBValue.Value[0]-mAcAValue.Value[0];
  pMCH.FieldByName('AcBValue').AsFloat:=mAcBValue.Value[0];
  pMCH.FieldByName('AcAValue1').AsFloat:=mAcAValue.Value[1];
  pMCH.FieldByName('AcAValue2').AsFloat:=mAcAValue.Value[2];
  pMCH.FieldByName('AcAValue3').AsFloat:=mAcAValue.Value[3];
  pMCH.FieldByName('AcAValue4').AsFloat:=mAcAValue.Value[4];
  pMCH.FieldByName('AcAValue5').AsFloat:=mAcAValue.Value[5];

  pMCH.FieldByName('AcBValue1').AsFloat:=mAcBValue.Value[1];
  pMCH.FieldByName('AcBValue2').AsFloat:=mAcBValue.Value[2];
  pMCH.FieldByName('AcBValue3').AsFloat:=mAcBValue.Value[3];
  pMCH.FieldByName('AcBValue4').AsFloat:=mAcBValue.Value[4];
  pMCH.FieldByName('AcBValue5').AsFloat:=mAcBValue.Value[5];

  pMCH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pMCH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pMCH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pMCH.FieldByName('FgAValue').AsFloat:=mFgAValue.Value[0];
  pMCH.FieldByName('FgVatVal').AsFloat:=mFgBValue.Value[0]-mFgAValue.Value[0];
  pMCH.FieldByName('FgBValue').AsFloat:=mFgBValue.Value[0];
  pMCH.FieldByName('FgAValue1').AsFloat:=mFgAValue.Value[1];
  pMCH.FieldByName('FgAValue2').AsFloat:=mFgAValue.Value[2];
  pMCH.FieldByName('FgAValue3').AsFloat:=mFgAValue.Value[3];
  pMCH.FieldByName('FgAValue4').AsFloat:=mFgAValue.Value[4];
  pMCH.FieldByName('FgAValue5').AsFloat:=mFgAValue.Value[5];

  pMCH.FieldByName('FgBValue1').AsFloat:=mFgBValue.Value[1];
  pMCH.FieldByName('FgBValue2').AsFloat:=mFgBValue.Value[2];
  pMCH.FieldByName('FgBValue3').AsFloat:=mFgBValue.Value[3];
  pMCH.FieldByName('FgBValue4').AsFloat:=mFgBValue.Value[4];
  pMCH.FieldByName('FgBValue5').AsFloat:=mFgBValue.Value[5];

  pMCH.FieldByName('FgEndVal').AsFloat:=pMCH.FieldByName('FgBValue').AsFloat-pMCH.FieldByName('FgPayVal').AsFloat;
  pMCH.FieldByName('AcEndVal').AsFloat:=pMCH.FieldByName('AcBValue').AsFloat-pMCH.FieldByName('AcPayVal').AsFloat;
  If IsNotNul(pMCH.FieldByName('FgBValue').AsFloat) then pMCH.FieldByName('PrfPrc').AsFloat:=Rd2 (pMCH.FieldByName('FgPValue').AsFloat/pMCH.FieldByName('FgBValue').AsFloat*100);
  pMCH.FieldByName('EquVal').AsFloat:=mEquVal;
  If IsNotNul(pMCH.FieldByName('FgBValue').AsFloat) then begin
    pMCH.FieldByName('EquPrc').AsInteger:=Round((mEquVal/pMCH.FieldByName('FgBValue').AsFloat)*100);
    If Eq2(mEquVal,pMCH.FieldByName('FgBValue').AsFloat) then pMCH.FieldByName('EquPrc').AsInteger:=100;
    If pMCH.FieldByName('EquPrc').AsInteger=100 then pMCH.FieldByName('DstLck').AsInteger:=1;
  end
  else pMCH.FieldByName('EquPrc').AsInteger:=0;

  pMCH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pMCH.Post;
  FreeAndNil (mAcAValue);   FreeAndNil (mFgAValue);
  FreeAndNil (mAcBValue);   FreeAndNil (mFgBValue);
end;

procedure MchNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej cenovej ponuky
begin
  dmSTK.btMCN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btMCN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btMCN.Delete;
    until (dmSTK.btMCN.Eof) or (dmSTK.btMCN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

Function UnlockReasonDocument (pMessage:integer;pParam:Str200; pBtr:TNexBtrTable):boolean;
begin
  If pBtr.FieldByName('DstLck').AsInteger=1 then begin
    Result:=AskYes(pMessage,pParam);
    If Result and gINI.UnlckRsn then begin
      If F_UnlEdit_F=nil then F_UnlEdit_F:=TF_UnlEdit_F.Create (Application);
      F_UnlEdit_F.Docnum:=pBtr.FieldByName('DocNum').AsString;
      F_UnlEdit_F.ShowModal;
      Result:=F_UnlEdit_F.Accept;
      FreeAndNil (F_UnlEdit_F);
    end;
    If result then begin
      pBTR.Edit;
      pBtr.FieldByName ('DstLck').AsInteger:=0;
      pBtr.Post;
    end;
  end else Result:=FALSE;
end;

function OpenDoc (pDocNum:Str12):boolean;  //Zaregistruje ze doklad je otvoreny
begin
  Result:=dmSYS.btOPENDOC.FindKey ([pDocNum]);
  If not Result then begin //Zaregistrujeme ze doklad je otvoreny
    dmSYS.btOPENDOC.Insert;
    dmSYS.btOPENDOC.FieldByName ('DocNum').AsString:=pDocNum;
    dmSYS.btOPENDOC.FieldByName ('UserName').AsString:=gvSys.UserName;
    dmSYS.btOPENDOC.FieldByName ('OpenUser').AsString:=gvSys.LoginName;
    dmSYS.btOPENDOC.FieldByName ('OpenDate').AsDateTime:=Date;
    dmSYS.btOPENDOC.FieldByName ('OpenTime').AsDateTime:=Time;
    dmSYS.btOPENDOC.Post;
  end
  else begin // Ak doklad je otvoreny
    If dmSYS.btOPENDOC.FieldByName ('OpenUser').AsString=gvSys.LoginName
      then Result:=FALSE //Vstupuje do dokladu ten isty uzivatel, ktory uzatvoril
      else ShowMsg (ecSysDocIsUseAnyUser,dmSYS.btOPENDOC.FieldByName ('UserName').AsString);
  end;
end;

procedure RefreshDoc (pDocNum:Str12);  //Zaznamena zmenu udajov dokladu
begin
  If dmSYS.btOPENDOC.FindKey ([pDocNum]) then begin
    dmSYS.btOPENDOC.Edit;
    dmSYS.btOPENDOC.FieldByName ('LastMod').AsDateTime:=Time;
    dmSYS.btOPENDOC.Post;
  end;
end;

procedure CloseDoc (pDocNum:Str12);  //Odstrani registraciu, ze doklad je otvoreny
begin
  If dmSYS.btOPENDOC.FindKey ([pDocNum]) then dmSYS.btOPENDOC.Delete;
end;

function GenExtNum (pDocDate:TDate;pExtNum,pExnFrm:Str12; pSerNum:longint; pBookNum:Str5; pStkNum:word): Str12; // Hodnota funkcie je externe cislo dokladu generovane podla zadaneho formatu pExnFrm
var mBegPos,mEndPos,mCnt:byte; mPrefix,mSufix:Str10;
begin
  If Copy(pBookNum,1,2)='A-' then pBookNum:=YearS(pDocDate)+Copy(pBookNum,3,3)
  else If Copy(pBookNum,1,2)='P-' then pBookNum:=DecNumStr(YearS(pDocDate))+Copy(pBookNum,3,3);
  Result:=pExtNum;
  If not (pExnFrm='NONE') then begin
    mPrefix:='';  mSufix:='';
    Result:=UpString (pExnFrm);
    If Pos ('D',Result)>1 then Result:=ReplaceStr (Result,'D','N');
    mBegPos:=Pos ('N',Result);
    If mBegPos>0 then begin
      // Poradove cislo dokladu
      If mBegPos>1 then mPrefix:=copy (Result,1,mBegPos-1);
      mEndPos:=mBegPos;  mCnt:=0;
      While (Result[mEndPos]='N') and (mEndPos<=Length(Result)) do begin
        Inc (mEndPos);
        Inc (mCnt);
      end;
      If mEndPos<Length(Result) then mSufix:=copy (Result,mEndPos,Length(Result)-mEndPos+1);
      Result:=mPrefix+StrIntZero(pSerNum,mCnt)+mSufix;
      // Cislo knihy dokladu
      mPrefix:='';  mSufix:='';
      mBegPos:=Pos ('B',Result);
      If mBegPos>0 then begin
        If mBegPos>1 then mPrefix:=copy (Result,1,mBegPos-1);
        mEndPos:=mBegPos;
        While (Result[mEndPos]='B') and (mEndPos<=Length(Result)) do Inc (mEndPos);
        If mEndPos<Length(Result) then mSufix:=copy (Result,mEndPos,Length(Result)-mEndPos+1);
        If mEndPos-mBegPos=5
          then Result:=mPrefix+pBookNum+mSufix
          else Result:=mPrefix+Copy(pBookNum,Length(pBookNum)-(mEndPos-mBegPos)+1,(mEndPos-mBegPos))+mSufix;
      end;
      // Rok
      mPrefix:='';  mSufix:='';
      mBegPos:=Pos ('Y',Result);
      If mBegPos>0 then begin
        If mBegPos>1 then mPrefix:=copy (Result,1,mBegPos-1);
        mEndPos:=mBegPos; mCnt:=0;
        While (Result[mEndPos]='Y') and (mEndPos<=Length(Result)) do begin
          Inc (mEndPos);
          Inc (mCnt);
        end;
        If mEndPos<Length(Result) then mSufix:=copy (Result,mEndPos,Length(Result)-mEndPos+1);
        If mCnt=4
          then Result:=mPrefix+YearL(pDocDate)+mSufix
          else Result:=mPrefix+YearS(pDocDate)+mSufix;
      end;
      // Sklad
      mPrefix:='';  mSufix:='';
      mBegPos:=Pos ('S',Result);
      If mBegPos>0 then begin
        If mBegPos>1 then mPrefix:=copy (Result,1,mBegPos-1);
        mEndPos:=mBegPos; mCnt:=0;
        While (Result[mEndPos]='S') and (mEndPos<=Length(Result)) do begin
          Inc (mEndPos);
          Inc (mCnt);
        end;
        If mEndPos<Length(Result) then mSufix:=copy (Result,mEndPos,Length(Result)-mEndPos+1);
        Result:=mPrefix+StrIntZero(pStkNum,mCnt)+mSufix;
      end;
    end
    else Result:=Result+StrIntZero (pSerNum,5);
  end;
end;

function GetDocType (pDocNum:Str12):byte; // Hodnota funkcie je typ zadaneho dokladu
var mDocType:Str2;
begin
  Result:=0;
  mDocType:=copy(pDocNum,1,2);
  If mDocType='SP' then Result:=dtIM; // Interne skladove prijemky
  If mDocType='SV' then Result:=dtOM; // Interne skladove vydajky
  If mDocType='MP' then Result:=dtRM; // Medziskladove presuny
  If mDocType='MB' then Result:=dtPK; // Manualne prebalenie tovaru
  If mDocType='??' then Result:=dtMS; // Dodavatelske cenove ponuky
  If mDocType='OB' then Result:=dtOS; // Dodavatelske objednavky
  If mDocType='DD' then Result:=dtTS; // Dodavatelske dodacie listy
  If mDocType='DF' then Result:=dtIS; // Dodavatelske faktury
  If mDocType='UD' then Result:=dtUD; // Univerzálne odbytové doklady
  If mDocType='CP' then Result:=dtMC; // Odberatelske cenove ponuky
  If mDocType='ZK' then Result:=dtOC; // Odberatelske objednavky
  If mDocType='OD' then Result:=dtTC; // Odberatelske dodacie listy
  If mDocType='OF' then Result:=dtIC; // Odberatelske faktury
  If mDocType='SZ' then Result:=dtSC; // Servisne zakazky
  If mDocType='BV' then Result:=dtSO; // Bankove vypisy
  If mDocType='PQ' then Result:=dtPQ; // Prevodné príkazy
  If mDocType='DP' then Result:=dtDP; // Postupene pohladavky
  If mDocType='DI' then Result:=dtDI; // Postupene pohladavky FA
  If mDocType='PP' then Result:=dtCS; // Hotovostna pokladna
  If mDocType='PV' then Result:=dtCS; // Hotovostna pokladna
  If mDocType='ID' then Result:=dtID; // Interny uctovny doklad
  If mDocType='DZ' then Result:=dtSV; // Faktura za zalohu
  If mDocType='MI' then Result:=dtMI; // Prijemka MTZ
  If mDocType='MO' then Result:=dtMO; // Vydajka MTZ
  If mDocType='DK' then Result:=dtCM; // Doklad kompletizácii vyrobku
  If mDocType='SA' then Result:=dtSA; // Skladove vydajky MO predaja
  If mDocType='SC' then Result:=dtSA; // Skladove vydajky MO predaja komponenty
  If mDocType='SC' then Result:=dtOW; // Vyuctovanie sluzobnej cesty
  If mDocType='CD' then Result:=dtCD; // Manualna vyroba tovaru
  If mDocType='TO' then Result:=dtTO; // Terminalova skladova vydajka
  If mDocType='TI' then Result:=dtTI; // Terminalova skladova prijemka
  If mDocType='ZP' then Result:=dtAM; // Cenová ponuka prenájmu
  If mDocType='ZO' then Result:=dtAO; // Zákazkový doklad prenájmu
  If mDocType='ZN' then Result:=dtAL; // Zápožièný doklad prenájmu
  If mDocType='PO' then Result:=dtPO; // Pozicna skladova vydajka
  If mDocType='PI' then Result:=dtPI; // Pozicna skladova prijemka
  If mDocType='KD' then Result:=dtKS; // Pozicna skladova prijemka
  If mDocType='DR' then Result:=dtDM; // Doklad rozobratia
  If mDocType='PO' then Result:=dtPS; // Planovanie objednavok
  If mDocType='AC' then Result:=dtAC; // Akciove precenenie
end;

function GetPmdMark (pDocNum:ShortString):ShortString; // Hodnota funkcie je oznaèenie programového modulu
var mDocType:ShortString;
begin
  Result:='';
  mDocType:=copy(pDocNum,1,2);
  If mDocType='SP' then Result:='IMB'; // Interne skladove prijemky
  If mDocType='SV' then Result:='OMB'; // Interne skladove vydajky
  If mDocType='MP' then Result:='RMB'; // Medziskladove presuny
  If mDocType='MB' then Result:='PKB'; // Manualne prebalenie tovaru
  If mDocType='??' then Result:='MSB'; // Dodavatelske cenove ponuky
  If mDocType='OB' then Result:='OSB'; // Dodavatelske objednavky
  If mDocType='DD' then Result:='TSB'; // Dodavatelske dodacie listy
  If mDocType='DF' then Result:='ISB'; // Dodavatelske faktury
  If mDocType='UD' then Result:='UDB'; // Univerzálne odbytové doklady
  If mDocType='CP' then Result:='MCB'; // Odberatelske cenove ponuky
  If mDocType='ZK' then Result:='OCB'; // Odberatelske objednavky
  If mDocType='OD' then Result:='TCB'; // Odberatelske dodacie listy
  If mDocType='OF' then Result:='ICB'; // Odberatelske faktury
  If mDocType='SZ' then Result:='SCB'; // Servisne zakazky
  If mDocType='BV' then Result:='SOB'; // Bankove vypisy
  If mDocType='PQ' then Result:='PQB'; // Prevodné príkazy
  If mDocType='DP' then Result:='DPB'; // Postupene pohladavky
  If mDocType='DI' then Result:='DPB'; // Postupene pohladavky FA
  If mDocType='PP' then Result:='CSB'; // Hotovostna pokladna
  If mDocType='PV' then Result:='CSB'; // Hotovostna pokladna
  If mDocType='ID' then Result:='IDB'; // Interny uctovny doklad
  If mDocType='DZ' then Result:='SVB'; // Faktura za zalohu
  If mDocType='MI' then Result:='MTB'; // Prijemka MTZ
  If mDocType='MO' then Result:='MTB'; // Vydajka MTZ
  If mDocType='DK' then Result:='CMP'; // Doklad kompletizácii vyrobku
  If mDocType='SA' then Result:='SAB'; // Skladove vydajky MO predaja
  If mDocType='SC' then Result:='SAB'; // Skladove vydajky MO predaja komponenty
  If mDocType='SC' then Result:='OWB'; // Vyuctovanie sluzobnej cesty
  If mDocType='CD' then Result:='CDB'; // Manualna vyroba tovaru
  If mDocType='TO' then Result:='TOM'; // Terminalova skladova vydajka
  If mDocType='TI' then Result:='TIM'; // Terminalova skladova prijemka
  If mDocType='ZP' then Result:='ALB'; // Cenová ponuka prenájmu
  If mDocType='ZO' then Result:='ALB'; // Zákazkový doklad prenájmu
  If mDocType='ZN' then Result:='ALB'; // Zápožièný doklad prenájmu
  If mDocType='DR' then Result:='DMB'; // Doklad rozobratia
  If mDocType='PO' then Result:='PSB'; // Planovanie objednavok
  If mDocType='AC' then Result:='ACB'; // Akciove precenenie
end;

function GetDocTypeName (pDocNum:Str12):Str60;
var mDocType:Str2;
begin
  Result:='';
  mDocType:=copy(pDocNum,1,2);
  If mDocType='SP' then Result:='Interne skladove prijemky';
  If mDocType='SV' then Result:='Interne skladove vydajky';
  If mDocType='MP' then Result:='Medziskladove presuny';
  If mDocType='MB' then Result:='Manualne prebalenie tovaru';
  If mDocType='??' then Result:='Dodavatelske cenove ponuky';
  If mDocType='OB' then Result:='Dodavatelske objednavky';
  If mDocType='DD' then Result:='Dodavatelske dodacie listy';
  If mDocType='DF' then Result:='Dodavatelske faktury';
  If mDocType='UD' then Result:='Odberatelske cenove ponuky';
  If mDocType='CP' then Result:='Odberatelske cenove ponuky';
  If mDocType='ZK' then Result:='Odberatelske objednavky';
  If mDocType='OD' then Result:='Odberatelske dodacie listy';
  If mDocType='OF' then Result:='Odberatelske faktury';
  If mDocType='SZ' then Result:='Servisne zakazky';
  If mDocType='BV' then Result:='Bankove vypisy';
  If mDocType='PQ' then Result:='Prevodne prikazy';
  If mDocType='DP' then Result:='Postupene pohladavky';
  If mDocType='DI' then Result:='Postupene pohladavky FA';
  If mDocType='PP' then Result:='Hotovostna pokladna';
  If mDocType='PV' then Result:='Hotovostna pokladna';
  If mDocType='ID' then Result:='Interny uctovny doklad';
  If mDocType='DZ' then Result:='Faktura za zalohu';
  If mDocType='MI' then Result:='Prijemka MTZ';
  If mDocType='MO' then Result:='Vydajka MTZ';
  If mDocType='DK' then Result:='Doklad kompletizácii vyrobku';
  If mDocType='SA' then Result:='Skladove vydajky MO predaja';
  If mDocType='SC' then Result:='Vyuctovanie sluzobnej cesty';
  If mDocType='CD' then Result:='Manualna vyroba tovaru';
  If mDocType='TO' then Result:='Terminalova vydajka';
  If mDocType='TI' then Result:='Terminalova prijemka';
  If mDocType='ZP' then Result:='Cenová ponuka prenájmu';
  If mDocType='ZO' then Result:='Zákazkový doklad prenájmu';
  If mDocType='ZN' then Result:='Zápožièný doklad prenájmu';
  If mDocType='PO' then Result:='Pozicna skladova vydajka';
  If mDocType='PI' then Result:='Pozicna skladova prijemka';
  If mDocType='KD' then Result:='Komisonalne vysporiadanie';
  If mDocType='DR' then Result:='Doklad rozobratia';
  If mDocType='PO' then Result:='Planovanie objednavok';
  If mDocType='AC' then Result:='Akciove precenenie';
end;

function BookNumFromDocNum (pDocNum:Str12):Str5;
var mBokNum:Str3; mDocYer:Str2; //mPmd:Str8; btTable:TNexBtrTable; mIndex:Str20;
begin
  mDocYer:=copy(pDocNum,3,2);
  mBokNum:=copy(pDocNum,5,3);
  If copy(pDocNum,1,2)='ZK' then begin // Zákazky už majú novú štruktúru
    Result:=mBokNum;
  end else begin
    If mDocYer>gKey.Sys.SavYer
      then Result:='A-'+mBokNum
      else Result:='P-'+mBokNum;
  end;
end;

function YearFromDocNum (pDocNum:Str12):Str2; // Hodnotou funkcie je rok, ktore obsahuje zadane cislo dokladu
begin
  If Length(pDocNum)=7
    then Result:=gvSys.ActYear2 else Result:=Copy(pDocNum,3,2);
end;

function SerNumFromDocNum (pDocNum:Str12):longint;
begin
  Result:=ValInt (copy(pDocNum,8,5));
end;

function GetDstAcc (pDocNum:Str12):Str1; // Funkcia prekontroluje v denniku ci su uctovne zapisy na dany doklad ak ano vrati priznak "A"
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmLDG.btJOURNAL.Active;
  If mMyOp then dmLDG.btJOURNAL.Open;
  dmLDG.btJOURNAL.IndexName:='DocNum';
  If dmLDG.btJOURNAL.FindKey ([pDocNum]) then Result:='A';
  If mMyOp then dmLDG.btJOURNAL.Close;
end;

function GenAmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='ZP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenAoDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='ZO'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenAlDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='ZN'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenApDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='AP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

// ************************** INTERNE SKLADOVE PRIJEMKY *****************************

function GenImDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='SP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

procedure ImhRecalc (pIMH,pIMI:TNexBtrTable);  //Prepocita hlavicku zadanej internej skladovej prijemky
var mItmQnt:longint;  mAValue,mBValue:double;  mCValue,mEValue:TValue8; mDstStk:Str1;
begin
  mDstStk:='S';
  mItmQnt:=0;  mAValue:=0;  mBValue:=0;
  mCValue:=TValue8.Create;  mCValue.Clear;
  mCValue.VatPrc[1]:=pIMH.FieldByName('VatPrc1').AsInteger;
  mCValue.VatPrc[2]:=pIMH.FieldByName('VatPrc2').AsInteger;
  mCValue.VatPrc[3]:=pIMH.FieldByName('VatPrc3').AsInteger;
  mCValue.VatPrc[4]:=pIMH.FieldByName('VatPrc4').AsInteger;
  mCValue.VatPrc[5]:=pIMH.FieldByName('VatPrc5').AsInteger;
  mEValue:=TValue8.Create;  mEValue.Clear;
  mEValue.VatPrc[1]:=pIMH.FieldByName('VatPrc1').AsInteger;
  mEValue.VatPrc[2]:=pIMH.FieldByName('VatPrc2').AsInteger;
  mEValue.VatPrc[3]:=pIMH.FieldByName('VatPrc3').AsInteger;
  mEValue.VatPrc[4]:=pIMH.FieldByName('VatPrc4').AsInteger;
  mEValue.VatPrc[5]:=pIMH.FieldByName('VatPrc5').AsInteger;
  pIMI.SwapIndex;
  pIMI.IndexName:='DocNum';
  If pIMI.FindKey ([pIMH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mCValue.Add (pIMI.FieldByName('VatPrc').AsInteger,pIMI.FieldByName('CValue').AsFloat);
      mEValue.Add (pIMI.FieldByName('VatPrc').AsInteger,pIMI.FieldByName('EValue').AsFloat);
      mBValue:=mBValue+pIMI.FieldByName('BValue').AsFloat;
      mAValue:=mAValue+(pIMI.FieldByName('BValue').AsFloat)/(1+pIMI.FieldByName('VatPrc').AsInteger/100);
      If pIMI.FieldByName('StkStat').AsString='N' then mDstStk:='N';
      If pIMI.FieldByName('StkStat').AsString='M' then mDstStk:='N';
      pIMI.Next;
    until (pIMI.Eof) or (pIMI.FieldByName('DocNum').AsString<>pIMH.FieldByName('DocNum').AsString);
  end;
  pIMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pIMH.Edit;
  pIMH.FieldByName ('CValue').AsFloat:=mCValue[0];
  pIMH.FieldByName ('CValue1').AsFloat:=mCValue[1];
  pIMH.FieldByName ('CValue2').AsFloat:=mCValue[2];
  pIMH.FieldByName ('CValue3').AsFloat:=mCValue[3];
  pIMH.FieldByName ('CValue4').AsFloat:=mCValue[4];
  pIMH.FieldByName ('CValue5').AsFloat:=mCValue[5];

  pIMH.FieldByName ('VatVal').AsFloat:=mEValue[0]-mCValue[0];
  //pIMH.FieldByName ('VatVal1').AsFloat:=mEValue[1]-mCValue[1];
  //pIMH.FieldByName ('VatVal2').AsFloat:=mEValue[2]-mCValue[2];
  //pIMH.FieldByName ('VatVal3').AsFloat:=mEValue[3]-mCValue[3];
  //pIMH.FieldByName ('VatVal4').AsFloat:=mEValue[4]-mCValue[4];
  //pIMH.FieldByName ('VatVal5').AsFloat:=mEValue[5]-mCValue[5];

  pIMH.FieldByName ('EValue').AsFloat:=mEValue[0];
  pIMH.FieldByName ('EValue1').AsFloat:=mEValue[1];
  pIMH.FieldByName ('EValue2').AsFloat:=mEValue[2];
  pIMH.FieldByName ('EValue3').AsFloat:=mEValue[3];
  pIMH.FieldByName ('EValue4').AsFloat:=mEValue[4];
  pIMH.FieldByName ('EValue5').AsFloat:=mEValue[5];

  pIMH.FieldByName ('AValue').AsFloat:=Rd2(mAValue);
  pIMH.FieldByName ('BValue').AsFloat:=Rd2(mBValue);
  pIMH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pIMH.FieldByName ('DstStk').AsString:=mDstStk;
  pIMH.FieldByName ('DstAcc').AsString:=GetDstAcc(pIMH.FieldByName('DocNum').AsString);
  pIMH.Post;
  FreeAndNil (mCValue);
  FreeAndNil (mEValue);
end;

procedure ImhNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej skladovej prijemky
begin
  dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btIMN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btIMN.Delete;
    until (dmSTK.btIMN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

// ******************** INTERNE SKLADOVE VYDAJKY ********************

function GenOmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='SV'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenRmDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo MP
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='MP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

procedure OmhRecalc (pOMH,pOMI:TNexBtrTable);  //Prepocita hlavicku zadanej internej skladovej vydajky
var mItmQnt:longint;   mAValue,mBValue:double;   mCValue,mEValue:TValue8;  mDstStk:Str1;
begin
  mItmQnt:=0;  mAValue:=0;  mBValue:=0;
  mCValue:=TValue8.Create;  mCValue.Clear;
  mCValue.VatPrc[1]:=pOMH.FieldByName('VatPrc1').AsInteger;
  mCValue.VatPrc[2]:=pOMH.FieldByName('VatPrc2').AsInteger;
  mCValue.VatPrc[3]:=pOMH.FieldByName('VatPrc3').AsInteger;
  mCValue.VatPrc[4]:=pOMH.FieldByName('VatPrc4').AsInteger;
  mCValue.VatPrc[5]:=pOMH.FieldByName('VatPrc5').AsInteger;
  mEValue:=TValue8.Create;  mEValue.Clear;
  mEValue.VatPrc[1]:=pOMH.FieldByName('VatPrc1').AsInteger;
  mEValue.VatPrc[2]:=pOMH.FieldByName('VatPrc2').AsInteger;
  mEValue.VatPrc[3]:=pOMH.FieldByName('VatPrc3').AsInteger;
  mEValue.VatPrc[4]:=pOMH.FieldByName('VatPrc4').AsInteger;
  mEValue.VatPrc[5]:=pOMH.FieldByName('VatPrc5').AsInteger;
  pOMI.SwapIndex;
  pOMI.IndexName:='DocNum';
  mDstStk:='N';
  If pOMI.FindKey ([pOMH.FieldByName('DocNum').AsString]) then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      mCValue.Add (pOMI.FieldByName('VatPrc').AsInteger,pOMI.FieldByName('CValue').AsFloat);
      mEValue.Add (pOMI.FieldByName('VatPrc').AsInteger,pOMI.FieldByName('EValue').AsFloat);
      mBValue:=mBValue+pOMI.FieldByName('BValue').AsFloat;
      mAValue:=mAValue+(pOMI.FieldByName('BValue').AsFloat)/(1+pOMI.FieldByName('VatPrc').AsInteger/100);
      If (pOMI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      pOMI.Next;
    until (pOMI.Eof) or (pOMI.FieldByName('DocNum').AsString<>pOMH.FieldByName('DocNum').AsString);
  end;
  pOMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pOMH.Edit;
  pOMH.FieldByName ('CValue').AsFloat:=mCValue[0];
  pOMH.FieldByName ('CValue1').AsFloat:=mCValue[1];
  pOMH.FieldByName ('CValue2').AsFloat:=mCValue[2];
  pOMH.FieldByName ('CValue3').AsFloat:=mCValue[3];
  pOMH.FieldByName ('CValue4').AsFloat:=mCValue[4];
  pOMH.FieldByName ('CValue5').AsFloat:=mCValue[5];

  pOMH.FieldByName ('VatVal').AsFloat:=mEValue[0]-mCValue[0];
  //pOMH.FieldByName ('VatVal1').AsFloat:=mEValue[1]-mCValue[1];
  //pOMH.FieldByName ('VatVal2').AsFloat:=mEValue[2]-mCValue[2];
  //pOMH.FieldByName ('VatVal3').AsFloat:=mEValue[3]-mCValue[3];
  //pOMH.FieldByName ('VatVal4').AsFloat:=mEValue[4]-mCValue[4];
  //pOMH.FieldByName ('VatVal5').AsFloat:=mEValue[5]-mCValue[5];

  pOMH.FieldByName ('EValue').AsFloat:=mEValue[0];
  pOMH.FieldByName ('EValue1').AsFloat:=mEValue[1];
  pOMH.FieldByName ('EValue2').AsFloat:=mEValue[2];
  pOMH.FieldByName ('EValue3').AsFloat:=mEValue[3];
  pOMH.FieldByName ('EValue4').AsFloat:=mEValue[4];
  pOMH.FieldByName ('EValue5').AsFloat:=mEValue[5];

  pOMH.FieldByName ('AValue').AsFloat:=Rd2(mAValue);
  pOMH.FieldByName ('BValue').AsFloat:=Rd2(mBValue);
  pOMH.FieldByName ('DstStk').AsString:=mDstStk;
  pOMH.FieldByName ('DstAcc').AsString:=GetDstAcc(pOMH.FieldByName('DocNum').AsString);
  pOMH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pOMH.Post;
  FreeAndNil (mCValue);
  FreeAndNil (mEValue);
end;

procedure RmhRecalc (pRMH,pRMI:TNexBtrTable);  //Prepocita hlavicku zadanej internej skladovej vydajky
var mItmQnt:longint;   mAValue,mBValue:double;
    mCValue,mEValue:TValue8;  mDstStk:Str1;
begin
  mItmQnt:=0;  mAValue:=0;  mBValue:=0;
  mCValue:=TValue8.Create;  mCValue.Clear;
  mCValue.VatPrc[1]:=pRMH.FieldByName('VatPrc1').AsInteger;
  mCValue.VatPrc[2]:=pRMH.FieldByName('VatPrc2').AsInteger;
  mCValue.VatPrc[3]:=pRMH.FieldByName('VatPrc3').AsInteger;
  mCValue.VatPrc[4]:=pRMH.FieldByName('VatPrc4').AsInteger;
  mCValue.VatPrc[5]:=pRMH.FieldByName('VatPrc5').AsInteger;
  mEValue:=TValue8.Create;  mEValue.Clear;
  mEValue.VatPrc[1]:=pRMH.FieldByName('VatPrc1').AsInteger;
  mEValue.VatPrc[2]:=pRMH.FieldByName('VatPrc2').AsInteger;
  mEValue.VatPrc[3]:=pRMH.FieldByName('VatPrc3').AsInteger;
  mEValue.VatPrc[4]:=pRMH.FieldByName('VatPrc4').AsInteger;
  mEValue.VatPrc[5]:=pRMH.FieldByName('VatPrc5').AsInteger;
  pRMI.Refresh;
  pRMI.SwapIndex;
  pRMI.IndexName:='DoIt';
  mDstStk:='N';
  pRMI.FindNearest ([pRMH.FieldByName('DocNum').AsString,0]);
  If pRMI.FieldByName('DocNum').AsString=pRMH.FieldByName('DocNum').AsString then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      mCValue.Add (pRMI.FieldByName('VatPrc').AsInteger,pRMI.FieldByName('CValue').AsFloat);
      mEValue.Add (pRMI.FieldByName('VatPrc').AsInteger,pRMI.FieldByName('EValue').AsFloat);
      mBValue:=mBValue+pRMI.FieldByName('BPrice').AsFloat*pRMI.FieldByName('GsQnt').AsFloat;
      mAValue:=mAValue+(pRMI.FieldByName('BPrice').AsFloat*pRMI.FieldByName('GsQnt').AsFloat)/(1+pRMI.FieldByName('VatPrc').AsInteger/100);
      If (pRMI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      pRMI.Next;
    until (pRMI.Eof) or (pRMI.FieldByName('DocNum').AsString<>pRMH.FieldByName('DocNum').AsString);
  end;
  pRMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pRMH.Edit;
  pRMH.FieldByName ('CValue').AsFloat:=mCValue[0];
  pRMH.FieldByName ('CValue1').AsFloat:=mCValue[1];
  pRMH.FieldByName ('CValue2').AsFloat:=mCValue[2];
  pRMH.FieldByName ('CValue3').AsFloat:=mCValue[3];
  pRMH.FieldByName ('CValue4').AsFloat:=mCValue[4];
  pRMH.FieldByName ('CValue5').AsFloat:=mCValue[5];

  pRMH.FieldByName ('VatVal').AsFloat:=mEValue[0]-mCValue[0];
  //pRMH.FieldByName ('VatVal1').AsFloat:=mEValue[1]-mCValue[1];
  //pRMH.FieldByName ('VatVal2').AsFloat:=mEValue[2]-mCValue[2];
  //pRMH.FieldByName ('VatVal3').AsFloat:=mEValue[3]-mCValue[3];
  //pRMH.FieldByName ('VatVal4').AsFloat:=mEValue[4]-mCValue[4];
  //pRMH.FieldByName ('VatVal5').AsFloat:=mEValue[5]-mCValue[5];

  pRMH.FieldByName ('EValue').AsFloat:=mEValue[0];
  pRMH.FieldByName ('EValue1').AsFloat:=mEValue[1];
  pRMH.FieldByName ('EValue2').AsFloat:=mEValue[2];
  pRMH.FieldByName ('EValue3').AsFloat:=mEValue[3];
  pRMH.FieldByName ('EValue4').AsFloat:=mEValue[4];
  pRMH.FieldByName ('EValue5').AsFloat:=mEValue[5];

  pRMH.FieldByName ('AValue').AsFloat:=Rd2(mAValue);
  pRMH.FieldByName ('BValue').AsFloat:=Rd2(mBValue);
  pRMH.FieldByName ('DstStk').AsString:=mDstStk;
  pRMH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pRMH.Post;
  FreeAndNil (mCValue);
  FreeAndNil (mEValue);
end;

procedure CmhRecalc (pCMH,pCMI:TNexBtrTable);  //Prepocita hlavicku dokladu kompletizacie
var mItmQnt:longint;   mCValue,mBValue:double;
    mDstStk:Str1;
begin
  mItmQnt:=0;  mCValue:=0;   mBValue:=0;
  pCMI.SwapIndex;
  pCMI.IndexName:='DocNum';
  mDstStk:='N';
  If pCMI.FindKey ([pCMH.FieldByName('DocNum').AsString]) then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+pCMI.FieldByName('CValue').AsFloat;
      If (pCMI.FieldByName ('ItmType').AsString<>'W')and(pCMI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      pCMI.Next;
    until (pCMI.Eof) or (pCMI.FieldByName('DocNum').AsString<>pCMH.FieldByName('DocNum').AsString);
  end;
  pCMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pCMH.Edit;
  If IsNotNul (pCMH.FieldByName ('GsQnt').AsFloat) then begin
    pCMH.FieldByName ('CPrice').AsFloat:=RoundCPrice(mCValue/pCMH.FieldByName ('GsQnt').AsFloat);
    pCMH.FieldByName ('BPrice').AsFloat:=Rd2(mBValue/pCMH.FieldByName ('GsQnt').AsFloat);
  end;
  pCMH.FieldByName ('CValue').AsFloat:=mCValue;
  pCMH.FieldByName ('DstStk').AsString:=mDstStk;
  pCMH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pCMH.Post;
end;

procedure DmhRecalc (pDMH,pDMI:TNexBtrTable);  //Prepocita hlavicku dokladu rozobratia vyrobku
var mItmQnt:longint;   mItmVal:double;   mStkStat:Str1;
begin
  mItmQnt:=0;  mItmVal:=0;
  pDMI.SwapIndex;
  pDMI.IndexName:='DocNum';
  mStkStat:='N';
  If pDMI.FindKey ([pDMH.FieldByName('DocNum').AsString]) then begin
    mStkStat:='S';
    Repeat
      Inc (mItmQnt);
      mItmVal:=mItmVal+pDMI.FieldByName('CValue').AsFloat;
      If (pDMI.FieldByName('StkStat').AsString='N') then mStkStat:='N';
      pDMI.Next;
    until (pDMI.Eof) or (pDMI.FieldByName('DocNum').AsString<>pDMH.FieldByName('DocNum').AsString);
  end;
  pDMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pDMH.Edit;
  pDMH.FieldByName ('ItmVal').AsFloat:=mItmVal;
  pDMH.FieldByName ('StkStat').AsString:=mStkStat;
  pDMH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pDMH.Post;
end;

procedure PkhRecalc (pPKH,pPKI:TNexBtrTable);  //Prepocita hlavicku perbalovacieho dokladu
var mItmQnt:longint;  mDstStk:Str1;
begin
  mItmQnt:=0;
  pPKI.SwapIndex;
  pPKI.IndexName:='DoIt';
  mDstStk:='N';
  pPKI.FindNearest ([pPKH.FieldByName('DocNum').AsString,0]);
  If pPKI.FieldByName('DocNum').AsString= pPKH.FieldByName('DocNum').AsString then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      If (pPKI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      pPKI.Next;
    until (pPKI.Eof) or (pPKI.FieldByName('DocNum').AsString<>pPKH.FieldByName('DocNum').AsString);
  end;
  pPKI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pPKH.Edit;
  pPKH.FieldByName ('DstStk').AsString:=mDstStk;
  pPKH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pPKH.Post;
end;

procedure CdhRecalc (pCDH,pCDI,pCDM:TNexBtrTable);  //Prepocita hlavicku vyrobneho dokladu
var mItmQnt:longint;  mDstStk:Str1;  mCValue,mBValue:double;
begin
  mItmQnt:=0; mCValue:=0;mBValue:=0;
  pCDI.SwapIndex;
  pCDI.IndexName:='DoIt';
  mDstStk:='N';
  pCDI.FindNearest ([pCDH.FieldByName('DocNum').AsString,0]);
  If pCDI.FieldByName('DocNum').AsString= pCDH.FieldByName('DocNum').AsString then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+pCDI.FieldByName('CValue').AsFloat;
      mBValue:=mBValue+pCDI.FieldByName('BPrice').AsFloat*pCDI.FieldByName('GsQnt').AsFloat;
      If (pCDI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      pCDI.Next;
    until (pCDI.Eof) or (pCDI.FieldByName('DocNum').AsString<>pCDH.FieldByName('DocNum').AsString);
  end;
  pCDI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pCDH.Edit;
  pCDH.FieldByName ('CValue').AsFloat:=mCValue;
  pCDH.FieldByName ('BValue').AsFloat:=mBValue;
  pCDH.FieldByName ('DstStk').AsString:=mDstStk;
  pCDH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pCDH.Post;
end;

procedure CdIRecalc (pCDI,pCDM:TNexBtrTable);  //Prepocita polozku vyrobneho dokladu
var mItmQnt:longint;  mDstStk:Str1;  mCValue:double;
begin
  mItmQnt:=0; mCValue:=0;
  pCDM.SwapIndex;
  pCDM.IndexName:='DoItGs';
  mDstStk:='N';
  pCDM.FindNearest ([pCDI.FieldByName('DocNum').AsString,pCDI.FieldByName('ItmNum').AsInteger,0]);
  If (pCDM.FieldByName('DocNum').AsString =pCDI.FieldByName('DocNum').AsString)
  and(pCDM.FieldByName('ItmNum').AsInteger=pCDI.FieldByName('ItmNum').AsInteger)then begin
    mDstStk:='S';
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+pCDM.FieldByName('CValue').AsFloat;
      If (pCDM.FieldByName('StkStat').AsString='N')and(pCDM.FieldByName('ItmType').AsString<>'W') then mDstStk:='N';
      pCDM.Next;
    until (pCDM.Eof) or (pCDM.FieldByName('DocNum').AsString<>pCDI.FieldByName('DocNum').AsString)
                     or (pCDM.FieldByName('ItmNum').AsInteger<>pCDI.FieldByName('ItmNum').AsInteger);
  end;
  pCDM.RestoreIndex;
  // Ulozime vypocitane hodnoty do polozky dokladu
  pCDI.Edit;
  pCDI.FieldByName ('CValue').AsFloat:=mCValue;
  If IsNotNul(pCDI.FieldByName ('GsQnt').AsFloat) then pCDI.FieldByName ('CPrice').AsFloat:=mCValue/pCDI.FieldByName ('GsQnt').AsFloat;
  pCDI.FieldByName ('StkStat').AsString:=mDstStk;
  pCDI.Post;
end;

procedure RehRecalc (pREH,pREI:TNexBtrTable);  //Prepocita hlavicku precenovacieho dokladu
var mItmQnt:longint;  mCValue:double;  mOValue,mNValue:TValue8;
    mDstRev:byte;  mRevDate,mRevTime:TDAteTime;
begin
  mItmQnt:=0;  mCValue:=0;
  mOValue:=TValue8.Create;  mOValue.Clear;
  mOValue.VatPrc[1]:=pREH.FieldByName('VatPrc1').AsInteger;
  mOValue.VatPrc[2]:=pREH.FieldByName('VatPrc2').AsInteger;
  mOValue.VatPrc[3]:=pREH.FieldByName('VatPrc3').AsInteger;
  mNValue:=TValue8.Create;  mNValue.Clear;
  mNValue.VatPrc[1]:=pREH.FieldByName('VatPrc1').AsInteger;
  mNValue.VatPrc[2]:=pREH.FieldByName('VatPrc2').AsInteger;
  mNValue.VatPrc[3]:=pREH.FieldByName('VatPrc3').AsInteger;
  pREI.SwapIndex;
  pREI.IndexName:='DocNum';
  mDstRev:=0;
  If pREI.FindKey ([pREH.FieldByName('DocNum').AsString]) then begin
    mDstRev:=1;
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+pREI.FieldByName('CValue').AsFloat;
      mOValue.Add (pREI.FieldByName('VatPrc').AsInteger,pREI.FieldByName('OValue').AsFloat);
      mNValue.Add (pREI.FieldByName('VatPrc').AsInteger,pREI.FieldByName('NValue').AsFloat);
      mRevDate:=pREI.FieldByName('RevDate').AsDateTime;
      mRevTime:=pREI.FieldByName('RevTime').AsDateTime;
      If (pREI.FieldByName('RevStat').AsInteger=0) then mDstRev:=0;
      pREI.Next;
    until (pREI.Eof) or (pREI.FieldByName('DocNum').AsString<>pREH.FieldByName('DocNum').AsString);
  end;
  pREI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pREH.Edit;
  pREH.FieldByName ('CValue').AsFloat:=mCValue;
  pREH.FieldByName ('OValue').AsFloat:=mOValue[0];
  pREH.FieldByName ('NValue').AsFloat:=mNValue[0];
  pREH.FieldByName ('DValue').AsFloat:=mNValue[0]-mOValue[0];
  pREH.FieldByName ('OValue1').AsFloat:=mOValue[1];
  pREH.FieldByName ('OValue2').AsFloat:=mOValue[2];
  pREH.FieldByName ('OValue3').AsFloat:=mOValue[3];

  pREH.FieldByName ('NValue1').AsFloat:=mNValue[1];
  pREH.FieldByName ('NValue2').AsFloat:=mNValue[2];
  pREH.FieldByName ('NValue3').AsFloat:=mNValue[3];
  If mDstRev=1 then begin
    pREH.FieldByName ('RevDate').AsDateTime:=mRevDate;
    pREH.FieldByName ('RevTime').AsDateTime:=mRevTime;
  end;
  pREH.FieldByName ('DstRev').AsInteger:=mDstRev;
  pREH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pREH.Post;
  FreeAndNil (mOValue);
  FreeAndNil (mNValue);
end;

procedure AchRecalc (pACH,pACI:TNexBtrTable);  //Prepocita hlavicku dokladu akciovych preceneni
var mItmQnt:longint;  mStatus:Str1;
begin
  mItmQnt:=0;   mStatus:='E';
  pACI.SwapIndex;
  pACI.IndexName:='DocNum';
  If pACI.FindKey ([pACH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      If (mStatus<>'N') and (pACI.FieldByName('Status').AsString='A') then mStatus:='A';
      If (pACI.FieldByName('Status').AsString='N') then mStatus:='N';
      pACI.Next;
    until (pACI.Eof) or (pACI.FieldByName('DocNum').AsString<>pACH.FieldByName('DocNum').AsString);
    If mItmQnt=0 then mStatus:='N';
  end;
  pACI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pACH.Edit;
  pACH.FieldByName ('Status').AsString:=mStatus;
  pACH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pACH.Post;
end;

procedure AFhRecalc (pAFH,pAFI:TNexBtrTable);  //Prepocita hlavicku dokladu akciovych preceneni
type TAfhCalcRec=record
        CoCValue   : double;       //Obrat v NC bez DPH - kontrolne obdobie
        CoBrfVal   : double;       //Hruby zisk v Sk - kontrolne obdobie
        CoBrfPrc   : double;       //Hruby zisk v  % - kontrolne obdobie
        CoCosVal   : double;       //N klady na pordporu predaja v Sk - kontrolne obdobie
        CoCosPrc   : double;       //N klady na pordporu predaja v %  - kontrolne obdobie
        CoPrfVal   : double;       //Cisty zisk v Sk - kontrolne obdobie
        CoPrfPrc   : double;       //Cisty zisk v  % - kontrolne obdobie
        CoAValue   : double;       //Obrat v PC bez DPH - kontrolne obdobie
        CoSalQnt   : double;       //Kumulativne mnozstvo predaneho tovaru - kontrolne obdobie
        AcCValue   : double;       //Obrat v NC bez DPH - obdobie akcie
        AcBrfVal   : double;       //Hruby zisk v Sk - obdobie akcie
        AcBrfPrc   : double;       //Hruby zisk v  % - obdobie akcie
        AcCosVal   : double;       //N klady na pordporu predaja v Sk
        AcCosPrc   : double;       //N klady na pordporu predaja v %
        AcPrfVal   : double;       //Cisty zisk v Sk - obdobie akcie
        AcPrfPrc   : double;       //Cisty zisk v  % - obdobie akcie
        AcAValue   : double;       //Obrat v PC bez DPH - obdobie akcie
        AcSalQnt   : double;       //Kumulativne mnozstvo predaneho tovaru - obdobie akcie
      end;
var mItmQnt:longint;  mStatus:Str1;
    mCalc:TAfhCalcRec;
begin
  mItmQnt:=0;   mStatus:='N';
  FillChar(mCalc,SizeOf (TAfhCalcRec), 0);
  pAFI.SwapIndex;
  pAFI.IndexName:='DocNum';
  If pAFI.FindKey ([pAFH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      If (pAFI.FieldByName('Status').AsString='X') then mStatus:='X';
      If (pAFI.FieldByName('Status').AsString='A') then mStatus:='A';
      If (pAFI.FieldByName('Status').AsString='N') then mStatus:='N';
      with mCalc do begin
        CoCValue  :=CoCValue   + pAfI.FieldbyName('CoCValue').AsFloat;
        CoBrfVal  :=CoBrfVal   + pAfI.FieldbyName('CoBrfVal').AsFloat;
        CoPrfVal  :=CoPrfVal   + pAfI.FieldbyName('CoPrfVal').AsFloat;
        CoAValue  :=CoAValue   + pAfI.FieldbyName('CoAValue').AsFloat;
        CoSalQnt  :=CoSalQnt   + pAfI.FieldbyName('CoSalQnt').AsFloat;

        AcCValue  :=AcCValue   + pAfI.FieldbyName('AcCValue').AsFloat;
        AcBrfVal  :=AcBrfVal   + pAfI.FieldbyName('AcBrfVal').AsFloat;
        AcPrfVal  :=AcPrfVal   + pAfI.FieldbyName('AcPrfVal').AsFloat;
        AcAValue  :=AcAValue   + pAfI.FieldbyName('AcAValue').AsFloat;
        AcSalQnt  :=AcSalQnt   + pAfI.FieldbyName('AcSalQnt').AsFloat;

      end;
      pAFI.Next;
    until (pAFI.Eof) or (pAFI.FieldByName('DocNum').AsString<>pAFH.FieldByName('DocNum').AsString);
    If mItmQnt=0 then mStatus:='N';
  end;
  pAFI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pAFH.Edit;
  pAFH.FieldByName ('Status').AsString:=mStatus;
  pAFH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pAFH.FieldByName ('CoCValue').AsFloat:=mCalc.CoCValue;
  pAFH.FieldByName ('CoBrfVal').AsFloat:=mCalc.CoBrfVal ;
  pAFH.FieldByName ('CoPrfVal').AsFloat:=mCalc.CoPrfVal ;
  pAFH.FieldByName ('CoAValue').AsFloat:=mCalc.CoAValue ;
  pAFH.FieldByName ('CoSalQnt').AsFloat:=mCalc.CoSalQnt;
  pAFH.FieldByName ('AcCValue').AsFloat:=mCalc.AcCValue;
  pAFH.FieldByName ('AcBrfVal').AsFloat:=mCalc.AcBrfVal ;
  pAFH.FieldByName ('AcPrfVal').AsFloat:=mCalc.AcPrfVal ;
  pAFH.FieldByName ('AcAValue').AsFloat:=mCalc.AcAValue ;
  pAFH.FieldByName ('AcSalQnt').AsFloat:=mCalc.AcSalQnt;
  If pAFH.FieldByName('CoCValue').AsFloat<>0
    then pAFH.FieldByName('ChCValue').AsFloat:=(pAFH.FieldByName('AcCValue').AsFloat/pAFH.FieldByName('CoCValue').AsFloat-1)*100
    else pAFH.FieldByName('ChCValue').AsFloat:=0;
  If pAFH.FieldByName('CoCosVal').AsFloat<>0
    then pAFH.FieldByName('ChCosVal').AsFloat:=(pAFH.FieldByName('AcCosVal').AsFloat/pAFH.FieldByName('CoCosVal').AsFloat-1)*100
    else pAFH.FieldByName('ChCosVal').AsFloat:=0;
  If pAFH.FieldByName('CoBrfVal').AsFloat<>0
    then pAFH.FieldByName('ChBrfVal').AsFloat:=(pAFH.FieldByName('AcBrfVal').AsFloat/pAFH.FieldByName('CoBrfVal').AsFloat-1)*100
    else pAFH.FieldByName('ChBrfVal').AsFloat:=0;
  If pAFH.FieldByName('CoPrfVal').AsFloat<>0
    then pAFH.FieldByName('ChPrfVal').AsFloat:=(pAFH.FieldByName('AcPrfVal').AsFloat/pAFH.FieldByName('CoPrfVal').AsFloat-1)*100
    else pAFH.FieldByName('ChPrfVal').AsFloat:=0;
  If pAFH.FieldByName('CoAValue').AsFloat<>0
    then pAFH.FieldByName('ChTrnVal').AsFloat:=(pAFH.FieldByName('AcAValue').AsFloat/pAFH.FieldByName('CoAValue').AsFloat-1)*100
    else pAFH.FieldByName('ChTrnVal').AsFloat:=0;
  If pAFH.FieldByName('CoSalQnt').AsFloat<>0
    then pAFH.FieldByName('ChSalQnt').AsFloat:=(pAFH.FieldByName('AcSalQnt').AsFloat/pAFH.FieldByName('CoSalQnt').AsFloat-1)*100
    else pAFH.FieldByName('ChSalQnt').AsFloat:=0;

    If pAFH.FieldByName('CoCValue').AsFloat<>0
      then pAFH.FieldByName('CoCosPrc').AsFloat:=pAFH.FieldByName('CoCosVal').AsFloat/pAFH.FieldByName('CoCValue').AsFloat
      else pAFH.FieldByName('CoCosPrc').AsFloat:=0;
    If pAFH.FieldByName('CoCValue').AsFloat<>0
      then pAFH.FieldByName('CoBrfPrc').AsFloat:=(pAFH.FieldByName('CoBrfVal').AsFloat/pAFH.FieldByName('CoCValue').AsFloat-1)*100
      else pAFH.FieldByName('CoBrfPrc').AsFloat:=0;
    pAFH.FieldByName('CoPrfPrc').AsFloat:=pAFH.FieldByName('CoBrfPrc').AsFloat-pAFH.FieldByName('CoCosPrc').AsFloat;

    If pAFH.FieldByName('AcCValue').AsFloat<>0
      then pAFH.FieldByName('AcCosPrc').AsFloat:=pAFH.FieldByName('AcCosVal').AsFloat/pAFH.FieldByName('AcCValue').AsFloat
      else pAFH.FieldByName('AcCosPrc').AsFloat:=0;
    If pAFH.FieldByName('AcCValue').AsFloat<>0
      then pAFH.FieldByName('AcBrfPrc').AsFloat:=(pAFH.FieldByName('AcBrfVal').AsFloat/pAFH.FieldByName('AcCValue').AsFloat-1)*100
      else pAFH.FieldByName('AcBrfPrc').AsFloat:=0;
    pAFH.FieldByName('AcPrfPrc').AsFloat:=pAFH.FieldByName('AcBrfPrc').AsFloat-pAFH.FieldByName('AcCosPrc').AsFloat;

  pAFH.Post;
end;

procedure CphRecalc (pCPH,pCPI:TNexBtrTable);  //Prepocita hlavicku kalkulacii vyrobku
var mItmQnt:longint;  mDValue,mHValue,mAValue,mBValue:double;
begin
  mItmQnt:=0;
  pCPI.SwapIndex;
  pCPI.IndexName:='PdCode';
  If pCPI.FindKey ([pCPH.FieldByName('PdCode').AsInteger]) then begin
    Repeat
      Inc (mItmQnt);
      mDValue:=mDValue+Rd2(pCPI.FieldByName('DPrice').AsFloat*pCPI.FieldByName('CpGsQnt').AsFloat);
      mHValue:=mHValue+Rd2(pCPI.FieldByName('HPrice').AsFloat*pCPI.FieldByName('CpGsQnt').AsFloat);
      mAValue:=mAValue+Rd2(pCPI.FieldByName('APrice').AsFloat*pCPI.FieldByName('CpGsQnt').AsFloat);
      mBValue:=mBValue+Rd2(pCPI.FieldByName('BPrice').AsFloat*pCPI.FieldByName('CpGsQnt').AsFloat);
      pCPI.Next;
    until (pCPI.Eof) or (pCPI.FieldByName('PdCode').AsInteger<>pCPH.FieldByName('PdCode').AsInteger);
  end;
  pCPI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  pCPH.Edit;
  pCPH.FieldByName ('DValue').AsFloat:=mDValue;
  pCPH.FieldByName ('HValue').AsFloat:=mHValue;
  pCPH.FieldByName ('DscAvl').AsFloat:=Rd2(mDValue-mAValue);
  pCPH.FieldByName ('DscBvl').AsFloat:=Rd2(mHValue-mBValue);
  pCPH.FieldByName ('DscPrc').AsFloat:=Rd2((1-(mAValue/mDValue))*100);
  pCPH.FieldByName ('AValue').AsFloat:=mAValue;
  pCPH.FieldByName ('BValue').AsFloat:=mBValue;
  pCPH.FieldByName ('ItmQnt').AsInteger:=mItmQnt;
  pCPH.Post;
end;

procedure OmhNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej skladovej SV
begin
  dmSTK.btOMN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btOMN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btOMN.Delete;
    until (dmSTK.btOMN.Eof) or (dmSTK.btOMN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure RmhNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej skladovej SV
begin
  dmSTK.btRMN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btRMN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btRMN.Delete;
    until (dmSTK.btRMN.Eof) or (dmSTK.btRMN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure CmhNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej skladovej SV
begin
  dmSTK.btCMN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btCMN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btCMN.Delete;
    until (dmSTK.btCMN.Eof) or (dmSTK.btCMN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure DmhNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej skladovej DR
begin
  dmSTK.btDMN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btDMN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btDMN.Delete;
    until (dmSTK.btDMN.Eof) or (dmSTK.btDMN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

// ********************** Doklad kompletizacie *********************
function GenCmDocNum; // Hodnota funkcie je interne cislo dokladu DK
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DK'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenDmDocNum; // Hodnota funkcie je interne cislo dokladu DR
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DR'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenDpDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad pohladavky
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenDiDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Doklad pohladavky
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DI'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

// ********************** ODBERATELSKE ZAKAZKY *********************
procedure OchNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej zakazky
begin
(*
  dmSTK.btOCN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btOCN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btOCN.Delete;
    until (dmSTK.btOCN.Eof) or (dmSTK.btOCN.FieldByName('DocNum').AsString<>pDocNum);
  end;
*)
end;

procedure PsiClearOsd (pDocNum:Str12;pItmNum:word); // Odstrani odkaz z polozky zakazky na OBJ
var mMyOp:boolean;  mBookNum:Str5;
begin
  If pDocNum<>'' then begin
    mBookNum:=BookNumFromDocNum(pDocNum);
    mMyOp:=not dmSTK.btPSI.Active or (dmSTK.btPSH.BookNum<>mBookNum);
    If mMyOp then begin
      dmSTK.OpenBook (dmSTK.btPSH,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
      dmSTK.OpenBook (dmSTK.btPSI,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    end;
    dmSTK.btPSI.IndexName:='OnOi';
    If dmSTK.btPSI.FindKey ([pDocNum,pItmNum]) then begin
      dmSTK.btPSI.Edit;
      dmSTK.btPSI.FieldByName ('OsdNum').AsString:='';
      dmSTK.btPSI.FieldByName ('OsdItm').AsInteger:=0;
      dmSTK.btPSI.FieldByName ('OsdDate').AsDateTime:=0;
      dmSTK.btPSI.FieldByName ('OrdStat').AsString:='';
      dmSTK.btPSI.Post;
      // Oznacime hlavicku ze doklad nie je vyparovany
      PshRecalc (dmSTK.btPSH,dmSTK.btPSI);
    end;
    If mMyOp then begin
      dmSTK.btPSI.Close;
      dmSTK.btPSH.Close;
    end;
  end;
end;


// ********************* DODAVATELSKE OBJEDNAVKY ********************
function ImiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky dodavetelskej SP
begin
  If dmSTK.btIMI.IndexName<>'DoIt' then dmSTK.btIMI.IndexName:='DoIt';
  dmSTK.btIMI.FindNearest([pDocNum,65000]);
  If not dmSTK.btIMI.IsLastRec or (dmSTK.btIMI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btIMI.Prior;
  If dmSTK.btIMI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btIMI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function OmiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky dodavetelskej SV
begin
  If dmSTK.btOMI.IndexName<>'DoIt' then dmSTK.btOMI.IndexName:='DoIt';
  dmSTK.btOMI.FindNearest([pDocNum,65000]);
  If not dmSTK.btOMI.IsLastRec or (dmSTK.btOMI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btOMI.Prior;
  If dmSTK.btOMI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btOMI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function PsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky dodavetelskej objednavky
begin
  If dmSTK.btPSI.IndexName<>'DoIt' then dmSTK.btPSI.IndexName:='DoIt';
  dmSTK.btPSI.FindNearest([pDocNum,65000]);
  If not dmSTK.btPSI.IsLastRec or (dmSTK.btPSI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btPSI.Prior;
  If dmSTK.btPSI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btPSI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

procedure PshNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadaneho dokladu
begin
  dmSTK.btPSN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btPSN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btPSN.Delete;
    until (dmSTK.btPSN.Eof) or (dmSTK.btPSN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure OwhNoticeDelete (pDocNum:Str12); //Vymaze poznamky cestovneho prikazu
begin
  dmLDG.btOWN.FindNearest ([pDocNum,'',0]);
  If dmLDG.btOWN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmLDG.btOWN.Delete;
    until (dmLDG.btOWN.Eof) or (dmLDG.btOWN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure NoticeDelete (pTable:TNexBtrTable;pDocNum:Str12); //Vymaze poznamky cestovneho prikazu
begin
  pTable.FindNearest ([pDocNum]);
  If pTable.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      pTable.Delete;
    until (pTable.Eof) or (pTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure NoticeSave (pTable:TNexBtrTable;pDocNum:Str12;pNotice:TMemo;pNotType:Str1);
var I:word;
begin
  If pNotice.Lines.Count>0 then begin
    For I:=0 to pNotice.Lines.Count-1 do begin
      pTable.Insert;
      pTable.FieldByName ('DocNum').AsString:=pDocNum;
      pTable.FieldByName ('NotType').AsString:=pNotType;
      pTable.FieldByName ('LinNum').AsInteger:=I;
      pTable.FieldByName ('Notice').AsString:=pNotice.Lines.Strings[I];
      pTable.Post;
    end;
  end;
end;

procedure NoticeLoad (pTable:TNexBtrTable;pDocNum:Str12;pNotice:TMemo;pNotType:Str1);
begin
  pNotice.Lines.Clear;
  pTable.FindNearest ([pDocNum,pNotType,0]);
  If (pTable.FieldByName ('DocNum').AsString=pDocNum) and (pTable.FieldByName ('NotType').AsString=pNotType) then begin
    Repeat
      pNotice.Lines.Add(pTable.FieldByName('Notice').AsString);
      pTable.Next;
    until (pTable.Eof) or (pTable.FieldByName('DocNum').AsString<>pDocNum) or (pTable.FieldByName('NotType').AsString<>pNotType);
  end;
end;


procedure DeletePdn (pDocNum:Str12;pItmNum,pStkNum:word);
begin
  dmSTK.OpenList (dmSTK.btSTP,pStkNum);
  dmSTK.btSTP.IndexName:='InDoIt';
  While dmSTK.btSTP.FindKey ([pDocNum,pItmNum]) do begin
    dmSTK.btSTP.Delete;
  end;
  dmSTK.btSTP.Close;
end;

// ************** UKLADANIE ZAZNAMOV DO DOCASNEHO SUBORU ***********
procedure CMI_To_TMP (pBtTable:TNexBtrTable; pPxTable:TNexPxTable);
begin
  pPxTable.FieldByName('DocNum').AsString:=pBtTable.FieldByName('DocNum').AsString;
  pPxTable.FieldByName('ItmNum').AsInteger:=pBtTable.FieldByName('ItmNum').AsInteger;
  pPxTable.FieldByName('StkNum').AsInteger:=pBtTable.FieldByName('StkNum').AsInteger;
  pPxTable.FieldByName('SmCode').AsInteger:=pBtTable.FieldByName('SmCode').AsInteger;
  pPxTable.FieldByName('MgCode').AsInteger:=pBtTable.FieldByName('MgCode').AsInteger;
  pPxTable.FieldByName('GsCode').AsInteger:=pBtTable.FieldByName('GsCode').AsInteger;
  pPxTable.FieldByName('GsName').AsString:=pBtTable.FieldByName('GsName').AsString;
  pPxTable.FieldByName('BarCode').AsString:=pBtTable.FieldByName('BarCode').AsString;
  pPxTable.FieldByName('StkCode').AsString:=pBtTable.FieldByName('StkCode').AsString;
  pPxTable.FieldByName('MsName').AsString:=pBtTable.FieldByName('MsName').AsString;
  pPxTable.FieldByName('Notice').AsString:=pBtTable.FieldByName('Notice').AsString;
  pPxTable.FieldByName('GsQnt').AsFloat:=pBtTable.FieldByName('GsQnt').AsFloat;
  pPxTable.FieldByName('VatPrc').AsInteger:=pBtTable.FieldByName('VatPrc').AsInteger;
  pPxTable.FieldByName('CPrice').AsFloat:=pBtTable.FieldByName('CPrice').AsFloat;
  pPxTable.FieldByName('BPrice').AsFloat:=pBtTable.FieldByName('BPrice').AsFloat;
  pPxTable.FieldByName('CValue').AsFloat:=pBtTable.FieldByName('CValue').AsFloat;
  pPxTable.FieldByName('OcdNum').AsString:=pBtTable.FieldByName('OcdNum').AsString;
  pPxTable.FieldByName('DocDate').AsDateTime:=pBtTable.FieldByName('DocDate').AsDateTime;
  pPxTable.FieldByName('StkStat').AsString:=pBtTable.FieldByName('StkStat').AsString;
  pPxTable.FieldByName('CrtUser').AsString:=pBtTable.FieldByName('CrtUser').AsString;
  pPxTable.FieldByName('CrtDate').AsDateTime:=pBtTable.FieldByName('CrtDate').AsDateTime;
  pPxTable.FieldByName('CrtTime').AsDateTime:=pBtTable.FieldByName('CrtTime').AsDateTime;
  pPxTable.FieldByName('ModNum').AsInteger:=pBtTable.FieldByName('ModNum').AsInteger;
  pPxTable.FieldByName('ModUser').AsString:=pBtTable.FieldByName('ModUser').AsString;
  pPxTable.FieldByName('ModDate').AsDateTime:=pBtTable.FieldByName('ModDate').AsDateTime;
  pPxTable.FieldByName('ModTime').AsDateTime:=pBtTable.FieldByName('ModTime').AsDateTime;
  pPxTable.FieldByName('ItmType').AsString:=pBtTable.FieldByName('ItmType').AsString;
  pPxTable.FieldByName('ActPos').AsInteger:=pBtTable.ActPos;
end;

function PciFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  If dmSTK.btPCI.IndexName<>'DoIt' then dmSTK.btPCI.IndexName:='DoIt';
  If dmSTK.btPCI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<dmSTK.btPCI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>dmSTK.btPCI.FieldByName('ItmNum').AsInteger) then mItmNum:=dmSTK.btPCI.FieldByName('ItmNum').AsInteger;
      dmSTK.btPCI.Next;
    until (dmSTK.btPCI.Eof) or mFind or (dmSTK.btPCI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function IsiFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  If dmLDG.btISI.IndexName<>'DoIt' then dmLDG.btISI.IndexName:='DoIt';
  If dmLDG.btISI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<dmLDG.btISI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>dmLDG.btISI.FieldByName('ItmNum').AsInteger) then mItmNum:=dmLDG.btISI.FieldByName('ItmNum').AsInteger;
      dmLDG.btISI.Next;
    until (dmLDG.btISI.Eof) or mFind or (dmLDG.btISI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function PciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky zalohovej FA
begin
  If dmSTK.btPCI.IndexName<>'DoIt' then dmSTK.btPCI.IndexName:='DoIt';
  dmSTK.btPCI.FindNearest([pDocNum,65000]);
  If not dmSTK.btPCI.IsLastRec or (dmSTK.btPCI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btPCI.Prior;
  If dmSTK.btPCI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btPCI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function IsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky DF
begin
  If dmLDG.btISI.IndexName<>'DoIt' then dmLDG.btISI.IndexName:='DoIt';
  If dmLDG.btISI.FindNearest([pDocNum,65000]) then begin // Nie je to posledny zaznam
    If not dmLDG.btISI.IsLastRec or (dmLDG.btISI.FieldByName('DocNum').AsString<>pDocNum) then dmLDG.btISI.Prior;
  end
  else dmLDG.btISI.Last;
  If dmLDG.btISI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmLDG.btISI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function GenPcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='PF'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

procedure LoadTsdToTmp (pBtTsi:TNexBtrTable; pPxTsi:TNexPxTable);
begin
end;

procedure PchRecalc (pDocNum:Str12);  //Prepocita hlavicku zadanej zalohovej faktury podla jej poloziek
var mItmQnt,mCntNot,mCntOrd,mCntRes,mCntPrp,mCntOut:longint;
    mCValue,mDscVal:double;    mAValue,mVatVal,mBValue:TValue8;
begin
  mItmQnt:=0;  mCntNot:=0;  mCntOrd:=0;  mCntOrd:=0;
  mCntRes:=0;  mCntPrp:=0;  mCntOut:=0;
  mCValue:=0;  mDscVal:=0;
  mAValue:=TValue8.Create;  mAValue.Clear;
  mAValue.VatPrc[1]:=dmSTK.btPCH.FieldByName('VatPrc1').AsInteger;
  mAValue.VatPrc[2]:=dmSTK.btPCH.FieldByName('VatPrc2').AsInteger;
  mAValue.VatPrc[3]:=dmSTK.btPCH.FieldByName('VatPrc3').AsInteger;
  mVatVal:=TValue8.Create;  mVatVal.Clear;
  mVatVal.VatPrc[1]:=dmSTK.btPCH.FieldByName('VatPrc1').AsInteger;
  mVatVal.VatPrc[2]:=dmSTK.btPCH.FieldByName('VatPrc2').AsInteger;
  mVatVal.VatPrc[3]:=dmSTK.btPCH.FieldByName('VatPrc3').AsInteger;
  mBValue:=TValue8.Create;  mBValue.Clear;
  mBValue.VatPrc[1]:=dmSTK.btPCH.FieldByName('VatPrc1').AsInteger;
  mBValue.VatPrc[2]:=dmSTK.btPCH.FieldByName('VatPrc2').AsInteger;
  mBValue.VatPrc[3]:=dmSTK.btPCH.FieldByName('VatPrc3').AsInteger;
  dmSTK.btPCI.SwapIndex;
  dmSTK.btPCI.IndexName:='DocNum';
  If dmSTK.btPCI.FindKey ([pDocNum]) then begin
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+dmSTK.btPCI.FieldByName('CValue').AsFloat;
      mDscVal:=mDscVal+dmSTK.btPCI.FieldByName('DscVal').AsFloat;
      mAValue.Add (dmSTK.btPCI.FieldByName('VatPrc').AsInteger,dmSTK.btPCI.FieldByName('AValue').AsFloat);
      mVatVal.Add (dmSTK.btPCI.FieldByName('VatPrc').AsInteger,dmSTK.btPCI.FieldByName('BValue').AsFloat-dmSTK.btPCI.FieldByName('AValue').AsFloat);
      mBValue.Add (dmSTK.btPCI.FieldByName('VatPrc').AsInteger,dmSTK.btPCI.FieldByName('BValue').AsFloat);
      dmSTK.btPCI.Next;
    until (dmSTK.btPCI.Eof) or (dmSTK.btPCI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  dmSTK.btPCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  dmSTK.btPCH.Edit;
  dmSTK.btPCH.FieldByName('CValue').AsFloat:=mCValue;
  dmSTK.btPCH.FieldByName('DocVal').AsFloat:=mAValue.Value[0]+mDscVal;
  dmSTK.btPCH.FieldByName('DscVal').AsFloat:=mDscVal;
  dmSTK.btPCH.FieldByName('AValue').AsFloat:=mAValue.Value[0];
  dmSTK.btPCH.FieldByName('VatVal').AsFloat:=mVatVal.Value[0];
  dmSTK.btPCH.FieldByName('BValue').AsFloat:=mBValue.Value[0];
  dmSTK.btPCH.FieldByName('AValue1').AsFloat:=mAValue.Value[1];
  dmSTK.btPCH.FieldByName('AValue2').AsFloat:=mAValue.Value[2];
  dmSTK.btPCH.FieldByName('AValue3').AsFloat:=mAValue.Value[3];
  dmSTK.btPCH.FieldByName('VatVal1').AsFloat:=mVatVal.Value[1];
  dmSTK.btPCH.FieldByName('VatVal2').AsFloat:=mVatVal.Value[2];
  dmSTK.btPCH.FieldByName('VatVal3').AsFloat:=mVatVal.Value[3];
  dmSTK.btPCH.FieldByName('BValue1').AsFloat:=mBValue.Value[1];
  dmSTK.btPCH.FieldByName('BValue2').AsFloat:=mBValue.Value[2];
  dmSTK.btPCH.FieldByName('BValue3').AsFloat:=mBValue.Value[3];
  dmSTK.btPCH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  dmSTK.btPCH.Post;
  FreeAndNil (mAValue);
  FreeAndNil (mVatVal);
  FreeAndNil (mBValue);
end;

procedure CshRecalc (pCSH,pCSI:TNexBtrTable);  // Prepocita hlavicku zadaneho pokladnicneho podla jeho poloziek
var mPaCode,mItmQnt,I:longint;  mAcAValue,mAcBValue,mPyAValue,mPyBValue:TValue8; mExcVatVal,mExcCosVal:double;
    mNotice:Str30;  mOcdNum:Str12;  mhPAB:TPabHnd;
begin
  mItmQnt:=0;  mOcdNum:='';  mPaCode:=0;
  If (pCSH.FieldByName('VatPrc1').AsInteger=0) and (pCSH.FieldByName('VatPrc2').AsInteger=0) and (pCSH.FieldByName('VatPrc2').AsInteger=0) then begin
    pCSH.Edit;
    pCSH.FieldByName('VatPrc1').AsInteger:=gIni.GetVatPrc(1);
    pCSH.FieldByName('VatPrc2').AsInteger:=gIni.GetVatPrc(2);
    pCSH.FieldByName('VatPrc3').AsInteger:=gIni.GetVatPrc(3);
    pCSH.FieldByName('VatPrc4').AsInteger:=gIni.GetVatPrc(4);
    pCSH.FieldByName('VatPrc5').AsInteger:=gIni.GetVatPrc(5);
    pCSH.Post;
  end;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mPyAValue:=TValue8.Create;  mPyAValue.Clear;
  mPyBValue:=TValue8.Create;  mPyBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pCSH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
    mAcBValue.VatPrc[I]:=pCSH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
    mPyAValue.VatPrc[I]:=pCSH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
    mPyBValue.VatPrc[I]:=pCSH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
  end;
  mNotice:='';
  mExcVatVal:=0; mExcCosVal:=0;
  pCSI.SwapIndex;
  pCSI.IndexName:='DocNum';
  If pCSI.FindKey ([pCSH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcAValue.Add (pCSI.FieldByName('VatPrc').AsInteger,pCSI.FieldByName('AcAValue').AsFloat);
      mAcBValue.Add (pCSI.FieldByName('VatPrc').AsInteger,pCSI.FieldByName('AcBValue').AsFloat);
      mPyAValue.Add (pCSI.FieldByName('VatPrc').AsInteger,pCSI.FieldByName('PyAValue').AsFloat);
      mPyBValue.Add (pCSI.FieldByName('VatPrc').AsInteger,pCSI.FieldByName('PyBValue').AsFloat);
      mExcVatVal:=mExcVatVal+pCSI.FieldByName('ExcVatVal').AsFloat;
      mExcCosVal:=mExcCosVal+pCSI.FieldByName('ExcCosVal').AsFloat;
      If mNotice='' then mNotice:=pCSI.FieldByName('Describe').AsString;
      If mOcdNum='' then mOcdNum:=pCSI.FieldByName('OcdNum').AsString;
      If (mPaCode=0) and (pCSI.FieldByName('PaCode').AsInteger<>0) then mPaCode:=pCSI.FieldByName('PaCode').AsInteger;
      pCSI.Next;
    until (pCSI.Eof) or (pCSI.FieldByName('DocNum').AsString<>pCSH.FieldByName('DocNum').AsString);
  end;
  pCSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pCSH.Edit;
  If pCSH.FieldByName('Notice').AsString='' then pCSH.FieldByName('Notice').AsString:=mNotice;
  If (pCSH.FieldByName('PaCode').AsInteger=0) and (mPaCode<>0) then begin  // V hlavicke nie je zadana firma preto doplnime z polozky
    mhPAB:=TPabHnd.Create;  mhPAB.Open(0);
    If mhPAB.LocatePaCode(mPaCode) then begin
      pCSH.FieldByName('PaCode').AsInteger:=mhPAB.PaCode;
      pCSH.FieldByName('PaName').AsString:=mhPAB.PaName;
      pCSH.FieldByName('RegName').AsString:=mhPAB.RegName;
      pCSH.FieldByName('RegIno').AsString:=mhPAB.RegIno;
      pCSH.FieldByName('RegTin').AsString:=mhPAB.RegTin;
      pCSH.FieldByName('RegVin').AsString:=mhPAB.RegVin;
      pCSH.FieldByName('RegAddr').AsString:=mhPAB.RegAddr;
      pCSH.FieldByName('RegSta').AsString:=mhPAB.RegSta;
      pCSH.FieldByName('RegCty').AsString:=mhPAB.RegCty;
      pCSH.FieldByName('RegCtn').AsString:=mhPAB.RegCtn;
      pCSH.FieldByName('RegZip').AsString:=mhPAB.RegZip;
    end;
    FreeAndNil(mhPAB);
  end;
  pCSH.FieldByName('OcdNum').AsString:=mOcdNum;
  pCSH.FieldByName('AcAValue').AsFloat:=mAcAValue.Value[0];
  pCSH.FieldByName('AcVatVal').AsFloat:=mAcBValue.Value[0]-mAcAValue.Value[0];
  pCSH.FieldByName('AcBValue').AsFloat:=mAcBValue.Value[0];
  pCSH.FieldByName('AcAValue1').AsFloat:=mAcAValue.Value[1];
  pCSH.FieldByName('AcAValue2').AsFloat:=mAcAValue.Value[2];
  pCSH.FieldByName('AcAValue3').AsFloat:=mAcAValue.Value[3];
  pCSH.FieldByName('AcAValue4').AsFloat:=mAcAValue.Value[4];
  pCSH.FieldByName('AcAValue5').AsFloat:=mAcAValue.Value[5];

  pCSH.FieldByName('AcBValue1').AsFloat:=mAcBValue.Value[1];
  pCSH.FieldByName('AcBValue2').AsFloat:=mAcBValue.Value[2];
  pCSH.FieldByName('AcBValue3').AsFloat:=mAcBValue.Value[3];
  pCSH.FieldByName('AcBValue4').AsFloat:=mAcBValue.Value[4];
  pCSH.FieldByName('AcBValue5').AsFloat:=mAcBValue.Value[5];

  pCSH.FieldByName('PyAValue').AsFloat:=mPyAValue.Value[0];
  pCSH.FieldByName('PyVatVal').AsFloat:=mPyBValue.Value[0]-mPyAValue.Value[0];
  pCSH.FieldByName('PyBValue').AsFloat:=mPyBValue.Value[0];
  pCSH.FieldByName('ExcVatVal').AsFloat:=mExcVatVal;
  pCSH.FieldByName('ExcCosVal').AsFloat:=mExcCosVal;
  If pCSH.FieldByName('DocType').AsString='I'
    then pCSH.FieldByName('PyIncVal').AsFloat:=mPyBValue.Value[0]
    else pCSH.FieldByName('PyExpVal').AsFloat:=mPyBValue.Value[0];
  pCSH.FieldByName('PyEndVal').AsFloat:=pCSH.FieldByName('PyBegVal').AsFloat+pCSH.FieldByName('PyIncVal').AsFloat-pCSH.FieldByName('PyExpVal').AsFloat;
  pCSH.FieldByName('PyAValue1').AsFloat:=mPyAValue.Value[1];
  pCSH.FieldByName('PyAValue2').AsFloat:=mPyAValue.Value[2];
  pCSH.FieldByName('PyAValue3').AsFloat:=mPyAValue.Value[3];
  pCSH.FieldByName('PyAValue4').AsFloat:=mPyAValue.Value[4];
  pCSH.FieldByName('PyAValue5').AsFloat:=mPyAValue.Value[5];

  pCSH.FieldByName('PyBValue1').AsFloat:=mPyBValue.Value[1];
  pCSH.FieldByName('PyBValue2').AsFloat:=mPyBValue.Value[2];
  pCSH.FieldByName('PyBValue3').AsFloat:=mPyBValue.Value[3];
  pCSH.FieldByName('PyBValue4').AsFloat:=mPyBValue.Value[4];
  pCSH.FieldByName('PyBValue5').AsFloat:=mPyBValue.Value[5];

  pCSH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pCSH.FieldByName('DstAcc').AsString:=GetDstAcc(pCSH.FieldByName('DocNum').AsString);
  pCSH.Post;
  FreeAndNil (mAcAValue);   FreeAndNil (mAcBValue);
  FreeAndNil (mPyAValue);   FreeAndNil (mPyBValue);
end;

procedure PqhRecalc (pPQH,pPQI:TNexBtrTable);  // Prepocita hlavicku prevodneho prikazu na ktorom stoji kurzor PQH
var mItmQnt:longint; mDocVal:double;
begin
  mItmQnt:=0;   mDocVal:=0;
  pPQI.SwapIndex;
  pPQI.IndexName:='DocNum';
  If pPQI.FindKey ([pPQH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mDocVal:=mDocVal+pPQI.FieldByName('PayVal').AsFloat;
      pPQI.Next;
    until (pPQI.Eof) or (pPQI.FieldByName('DocNum').AsString<>pPQH.FieldByName('DocNum').AsString);
  end;
  pPQI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pPQH.Edit;
  pPQH.FieldByName('DocVal').AsFloat:=mDocVal;
  pPQH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pPQH.Post;
end;

procedure IdhRecalc (pIDH,pIDI:TNexBtrTable);  // Prepocita hlavicku zadaneho uctovneho dokladu podla jeho poloziek
var mItmQnt:longint;   mCredVal,mDebVal:double;
    mCAccSnt,mDAccSnt:Str3;  mCAccAnl,mDAccAnl:Str6;
    mAcAValue,mAcVatVal:TValue8;    I:byte;
begin
  mCAccSnt:=''; mCAccAnl:='';  mDAccSnt:='';  mDAccAnl:='';
  mItmQnt:=0;  mCredVal:=0;  mDebVal:=0;
  If (pIDH.FieldByName('VatPrc1').AsInteger=0) and (pIDH.FieldByName('VatPrc2').AsInteger=0) and (pIDH.FieldByName('VatPrc3').AsInteger=0) and
     (pIDH.FieldByName('VatPrc4').AsInteger=0) and (pIDH.FieldByName('VatPrc5').AsInteger=0) then begin
    pIDH.Edit;
    pIDH.FieldByName('VatPrc1').AsInteger:=gIni.GetVatPrc(1);
    pIDH.FieldByName('VatPrc2').AsInteger:=gIni.GetVatPrc(2);
    pIDH.FieldByName('VatPrc3').AsInteger:=gIni.GetVatPrc(3);
    pIDH.FieldByName('VatPrc4').AsInteger:=gIni.GetVatPrc(4);
    pIDH.FieldByName('VatPrc5').AsInteger:=gIni.GetVatPrc(5);
    pIDH.Post;
  end;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcVatVal:=TValue8.Create;  mAcVatVal.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pIDH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
    mAcVatVal.VatPrc[I]:=pIDH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
  end;
  pIDI.SwapIndex;
  pIDI.IndexName:='DocNum';
  If pIDI.FindKey ([pIDH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      If pIDH.FieldByName('VtcSpc').AsInteger>0 then begin
        mAcAValue.Add(pIDI.FieldByName('VatPrc').AsInteger,pIDI.FieldByName('AcAValue').AsFloat);
        mAcVatVal.Add(pIDI.FieldByName('VatPrc').AsInteger,pIDI.FieldByName('AcVatVal').AsFloat);
      end;
      mCredVal:=mCredVal+pIDI.FieldByName('CredVal').AsFloat;
      mDebVal:=mDebVal+pIDI.FieldByName('DebVal').AsFloat;
      If IsNotNul (mCredVal) then begin
        mCAccSnt:=pIDI.FieldByName('AccSnt').AsString;
        mCAccAnl:=pIDI.FieldByName('AccAnl').AsString;
      end
      else begin
        mDAccSnt:=pIDI.FieldByName('AccSnt').AsString;
        mDAccAnl:=pIDI.FieldByName('AccAnl').AsString;
      end;
      pIDI.Next;
    until (pIDI.Eof) or (pIDI.FieldByName('DocNum').AsString<>pIDH.FieldByName('DocNum').AsString);
  end;
  pIDI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky
  pIDH.Edit;
  For I:=1 to 5 do begin
    pIDH.FieldByName('AcAValue'+StrInt(I,1)).AsFloat:=mAcAValue.Value[I];
    pIDH.FieldByName('AcVatVal'+StrInt(I,1)).AsFloat:=mAcVatVal.Value[I];
  end;
  pIDH.FieldByName('AcAValue').AsFloat:=mAcAValue.Value[0];
  pIDH.FieldByName('AcVatVal').AsFloat:=mAcVatVal.Value[0];
  pIDH.FieldByName('CredVal').AsFloat:=mCredVal;
  pIDH.FieldByName('DebVal').AsFloat:=mDebVal;
  pIDH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pIDH.FieldByName('CAccSnt').AsString:=mCAccSnt;
  pIDH.FieldByName('CAccAnl').AsString:=mCAccAnl;
  pIDH.FieldByName('DAccSnt').AsString:=mCAccSnt;
  pIDH.FieldByName('DAccAnl').AsString:=mCAccAnl;
  pIDH.FieldByName('DstAcc').AsString:=GetDstAcc(pIDH.FieldByName('DocNum').AsString);
  If not Eq2(mCredVal,mDebVal)
    then pIDH.FieldByName('DstDif').AsString:='!'
    else pIDH.FieldByName('DstDif').AsString:='';
  pIDH.Post;
end;

procedure FxaRecalc (pFXA,pFXT:TNexBtrTable);  // Prepocita inventarnu kartu dlhodobeho majetku
var mTsuVal,mChgVal,mModVal:double;
begin
  mTsuVal:=0;  mChgVal:=0;  mModVal:=0;
  pFXT.SwapIndex;
  pFXT.IndexName:='DocNum';
  If pFXT.FindKey ([pFXA.FieldByName('DocNum').AsString]) then begin
    Repeat
      If pFXT.FieldByName('Year').AsInteger<=ValInt(gvSys.ActYear) then begin
        mTsuVal:=mTsuVal+pFXT.FieldByName('SuVal').AsFloat;
        mChgVal:=mChgVal+pFXT.FieldByName('ChgVal').AsFloat;
        mModVal:=mModVal+pFXT.FieldByName('ModVal').AsFloat;
      end;
      pFXT.Next;
    until (pFXT.Eof) or (pFXT.FieldByName('DocNum').AsString<>pFXA.FieldByName('DocNum').AsString);
  end;
  pFXT.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky
  pFXA.Edit;
  pFXA.FieldByName('SuVal').AsFloat:=mTsuVal;
  pFXA.FieldByName('ChgVal').AsFloat:=mChgVal;
  pFXA.FieldByName('ModVal').AsFloat:=mModVal;
  pFXA.Post;
end;

procedure OwhRecalc (pOWH,pOWI:TNexBtrTable);  // Prepocita hlavicku dokladu vyuctovania sluzobnej cesty
var mItmQnt,I:longint;  mAcBValue,mAcVatVal,mFgBValue:TValue8;
begin
  mItmQnt:=0;
  If (pOWH.FieldByName('VatPrc1').AsInteger=0) and (pOWH.FieldByName('VatPrc2').AsInteger=0) and (pOWH.FieldByName('VatPrc3').AsInteger=0) then begin
    pOWH.Edit;
    pOWH.FieldByName('VatPrc1').AsInteger:=gIni.GetVatPrc(1);
    pOWH.FieldByName('VatPrc2').AsInteger:=gIni.GetVatPrc(2);
    pOWH.FieldByName('VatPrc3').AsInteger:=gIni.GetVatPrc(3);
    pOWH.Post;
  end;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mAcVatVal:=TValue8.Create;  mAcVatVal.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 3 do begin
    mAcBValue.VatPrc[I]:=pOWH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
    mAcVatVal.VatPrc[I]:=pOWH.FieldByName('VatPrc'+StrInt(I,1)).AsInteger;
  end;
  For I:=1 to 5 do
    mFgBValue.VatPrc[I]:=I;
  pOWI.SwapIndex;
  pOWI.IndexName:='DocNum';
  If pOWI.FindKey ([pOWH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcBValue.Add (pOWI.FieldByName('VatPrc').AsInteger,pOWI.FieldByName('AcBValue').AsFloat);
      mAcVatVal.Add (pOWI.FieldByName('VatPrc').AsInteger,pOWI.FieldByName('AcVatVal').AsFloat);
      mFgBValue.Add (pOWI.FieldByName('FgDvzNum').AsInteger,pOWI.FieldByName('FgBValue').AsFloat);
      pOWI.Next;
    until (pOWI.Eof) or (pOWI.FieldByName('DocNum').AsString<>pOWH.FieldByName('DocNum').AsString);
  end;
  pOWI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pOWH.Edit;
  pOWH.FieldByName('AcBValue1').AsFloat:=mAcBValue.Value[1];
  pOWH.FieldByName('AcBValue2').AsFloat:=mAcBValue.Value[2];
  pOWH.FieldByName('AcBValue3').AsFloat:=mAcBValue.Value[3];
  pOWH.FieldByName('AcVatVal1').AsFloat:=mAcVatVal.Value[1];
  pOWH.FieldByName('AcVatVal2').AsFloat:=mAcVatVal.Value[2];
  pOWH.FieldByName('AcVatVal3').AsFloat:=mAcVatVal.Value[3];
  pOWH.FieldByName('AcBValue').AsFloat:=mAcBValue.Value[0];
  pOWH.FieldByName('AcVatVal').AsFloat:=mAcVatVal.Value[0];
  pOWH.FieldByName('FgBValue1').AsFloat:=mFgBValue.Value[1];
  pOWH.FieldByName('FgBValue2').AsFloat:=mFgBValue.Value[2];
  pOWH.FieldByName('FgBValue3').AsFloat:=mFgBValue.Value[3];
  pOWH.FieldByName('FgBValue4').AsFloat:=mFgBValue.Value[4];
  pOWH.FieldByName('FgBValue5').AsFloat:=mFgBValue.Value[5];
  pOWH.FieldByName('AcPValue').AsFloat:=Rd2(pOWH.FieldByName('FgPValue1').AsFloat*pOWH.FieldByName('PfCourse1').AsFloat+
                                              pOWH.FieldByName('FgPValue2').AsFloat*pOWH.FieldByName('PfCourse2').AsFloat+
                                              pOWH.FieldByName('FgPValue3').AsFloat*pOWH.FieldByName('PfCourse3').AsFloat+
                                              pOWH.FieldByName('FgPValue4').AsFloat*pOWH.FieldByName('PfCourse4').AsFloat+
                                              pOWH.FieldByName('FgPValue5').AsFloat*pOWH.FieldByName('PfCourse5').AsFloat+
                                              pOWH.FieldByName('PfCrdVal1').AsFloat+
                                              pOWH.FieldByName('PfCrdVal2').AsFloat+
                                              pOWH.FieldByName('PfCrdVal3').AsFloat+
                                              pOWH.FieldByName('PfCrdVal4').AsFloat+
                                              pOWH.FieldByName('PfCrdVal5').AsFloat);

  pOWH.FieldByName('AcPayVal').AsFloat:=Rd2(pOWH.FieldByName('FgPayVal1').AsFloat*pOWH.FieldByName('PyCourse1').AsFloat+
                                              pOWH.FieldByName('FgPayVal2').AsFloat*pOWH.FieldByName('PyCourse2').AsFloat+
                                              pOWH.FieldByName('FgPayVal3').AsFloat*pOWH.FieldByName('PyCourse3').AsFloat+
                                              pOWH.FieldByName('FgPayVal4').AsFloat*pOWH.FieldByName('PyCourse4').AsFloat+
                                              pOWH.FieldByName('FgPayVal5').AsFloat*pOWH.FieldByName('PyCourse5').AsFloat+
                                              pOWH.FieldByName('PyCrdVal1').AsFloat+
                                              pOWH.FieldByName('PyCrdVal2').AsFloat+
                                              pOWH.FieldByName('PyCrdVal3').AsFloat+
                                              pOWH.FieldByName('PyCrdVal4').AsFloat+
                                              pOWH.FieldByName('PyCrdVal5').AsFloat);

  pOWH.FieldByName('AcEndVal').AsFloat:=pOWH.FieldByName('AcBValue').AsFloat-pOWH.FieldByName('AcPValue').AsFloat-pOWH.FieldByName('AcPayVal').AsFloat;
  pOWH.FieldByName('FgEndVal1').AsFloat:=pOWH.FieldByName('FgBValue1').AsFloat-pOWH.FieldByName('FgPayVal1').AsFloat;
  pOWH.FieldByName('FgEndVal2').AsFloat:=pOWH.FieldByName('FgBValue2').AsFloat-pOWH.FieldByName('FgPayVal2').AsFloat;
  pOWH.FieldByName('FgEndVal3').AsFloat:=pOWH.FieldByName('FgBValue3').AsFloat-pOWH.FieldByName('FgPayVal3').AsFloat;
  pOWH.FieldByName('FgEndVal4').AsFloat:=pOWH.FieldByName('FgBValue4').AsFloat-pOWH.FieldByName('FgPayVal4').AsFloat;
  pOWH.FieldByName('FgEndVal5').AsFloat:=pOWH.FieldByName('FgBValue5').AsFloat-pOWH.FieldByName('FgPayVal5').AsFloat;
  pOWH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pOWH.Post;
  FreeAndNil (mAcBValue);   FreeAndNil (mAcVatVal);   FreeAndNil (mFgBValue);
end;

procedure IvdRecalc (pIndicator:TProgressBar); // Prepocita vydajky MO predaja
var mCIvVal,mCStVal,mCNsVal,mCEvVal,mCPozVal,mCNegVal,mCDifVal:double;
    mPIvVal,mPStVal,mPNsVal,mPEvVal,mPPozVal,mPNegVal,mPDifVal:double;
begin
  dmSTK.OpenIVD (dmSTK.btIVDLST.FieldByName('SerNum').AsInteger);
  dmSTK.btIVD.First;
  pIndicator.Visible:=TRUE;
  pIndicator.Max:=dmSTK.btIVD.RecordCount;
  pIndicator.Position:=0;
  mCIvVal:=0;   mCStVal:=0;  mCNsVal:=0;  mCEvVal:=0;
  mCPozVal:=0;  mCNegVal:=0; mCDifVal:=0;
  mPIvVal:=0;   mPStVal:=0;  mPNsVal:=0;  mPEvVal:=0;
  mPPozVal:=0;  mPNegVal:=0; mPDifVal:=0;
  Repeat
    pIndicator.StepBy (1);
    // Hodnoty v NC bez DPH
    mCIvVal:=mCIvVal+dmSTK.btIVD.FieldByName('IvVal').AsFloat;
    mCStVal:=mCStVal+dmSTK.btIVD.FieldByName('StVal').AsFloat;
    mCNsVal:=mCNsVal+dmSTK.btIVD.FieldByName('CpVal').AsFloat;
    mCEvVal:=mCEvVal+dmSTK.btIVD.FieldByName('EvVal').AsFloat;
    If dmSTK.btIVD.FieldByName('DifQnt').AsFloat>0 then mCPozVal:=mCPozVal+dmSTK.btIVD.FieldByName('DifVal').AsFloat;
    If dmSTK.btIVD.FieldByName('DifQnt').AsFloat<0 then mCNegVal:=mCNegVal+dmSTK.btIVD.FieldByName('DifVal').AsFloat;
    mCDifVal:=mCDifVal+dmSTK.btIVD.FieldByName('DifVal').AsFloat;
    // Hodnoty v PC s DPH
    mPIvVal:=mPIvVal+dmSTK.btIVD.FieldByName('IvQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    mPStVal:=mPStVal+dmSTK.btIVD.FieldByName('StQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    mPNsVal:=mPNsVal+dmSTK.btIVD.FieldByName('CpQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    mPEvVal:=mPEvVal+dmSTK.btIVD.FieldByName('EvQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    If dmSTK.btIVD.FieldByName('DifQnt').AsFloat>0 then mPPozVal:=mPPozVal+dmSTK.btIVD.FieldByName('DifQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    If dmSTK.btIVD.FieldByName('DifQnt').AsFloat<0 then mPNegVal:=mPNegVal+dmSTK.btIVD.FieldByName('DifQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    mPDifVal:=mPDifVal+dmSTK.btIVD.FieldByName('DifQnt').AsFloat*dmSTK.btIVD.FieldByName('BPrice').AsFloat;
    Application.ProcessMessages;
    dmSTK.btIVD.Next;
  until (dmSTK.btIVD.Eof);
  dmSTK.btIVD.Close;

  // Ulozime spocitane hodnoty do hlavicky inventarneho dokladu
  dmSTK.btIVDLST.Edit;
  dmSTK.btIVDLST.FieldByName ('CIvVal').AsFloat:=Rd2(mCIvVal);
  dmSTK.btIVDLST.FieldByName ('CStVal').AsFloat:=Rd2(mCStVal);
  dmSTK.btIVDLST.FieldByName ('CNsVal').AsFloat:=Rd2(mCNsVal*(-1));
  dmSTK.btIVDLST.FieldByName ('CEvVal').AsFloat:=Rd2(mCEvVal);
  dmSTK.btIVDLST.FieldByName ('CPozVal').AsFloat:=Rd2(mCPozVal);
  dmSTK.btIVDLST.FieldByName ('CNegVal').AsFloat:=Rd2(mCNegVal);
  dmSTK.btIVDLST.FieldByName ('CDifVal').AsFloat:=Rd2(mCDifVal);
  dmSTK.btIVDLST.FieldByName ('PIvVal').AsFloat:=Rd2(mPIvVal);
  dmSTK.btIVDLST.FieldByName ('PStVal').AsFloat:=Rd2(mPStVal);
  dmSTK.btIVDLST.FieldByName ('PNsVal').AsFloat:=Rd2(mPNsVal*(-1));
  dmSTK.btIVDLST.FieldByName ('PEvVal').AsFloat:=Rd2(mPEvVal);
  dmSTK.btIVDLST.FieldByName ('PPozVal').AsFloat:=Rd2(mPPozVal);
  dmSTK.btIVDLST.FieldByName ('PNegVal').AsFloat:=Rd2(mPNegVal);
  dmSTK.btIVDLST.FieldByName ('PDifVal').AsFloat:=Rd2(mPDifVal);
  dmSTK.btIVDLST.Post;
end;

procedure MtcRecalc (pMtCode:longint); // Prepocita udaje skladovej karty MTZ
var mInQnt,mOuQnt,mInVal,mOuVal,mLPrice:double;  mDate:TDateTime;
begin
  // Prijem MTZ
  mInQnt:=0;   mInVal:=0;
  try
    dmLDG.btMTBIMD.DisableControls;
    dmLDG.btMTBIMD.SwapStatus;
    dmLDG.btMTBIMD.IndexName:='MtCode';
    If dmLDG.btMTBIMD.FindKey ([pMtCode]) then begin
      mDate:=dmLDG.btMTBIMD.FieldByName('DocDate').AsDateTime;
      mLPrice:=dmLDG.btMTBIMD.FieldByName('CPrice').AsFloat;
      Repeat
        mInQnt:=mInQnt+dmLDG.btMTBIMD.FieldByName('InQnt').AsFloat;
        mInVal:=mInVal+dmLDG.btMTBIMD.FieldByName('CValue').AsFloat;
        If mDate>dmLDG.btMTBIMD.FieldByName('DocDate').AsDateTime then begin
          mDate:=dmLDG.btMTBIMD.FieldByName('DocDate').AsDateTime;
          mLPrice:=dmLDG.btMTBIMD.FieldByName('CPrice').AsFloat;
        end;
        Application.ProcessMessages;
        dmLDG.btMTBIMD.Next;
      until dmLDG.btMTBIMD.Eof or (dmLDG.btMTBIMD.FieldByName('MtCode').AsInteger<>pMtCode);
    end;
    dmLDG.btMTBIMD.RestoreStatus;
  finally
    dmLDG.btMTBIMD.EnableControls;
  end;
  // Vydaj MTZ
  mOuQnt:=0;   mOuVal:=0;
  try
    dmLDG.btMTBOMD.DisableControls;
    dmLDG.btMTBOMD.SwapStatus;
    dmLDG.btMTBOMD.IndexName:='MtCode';
    If dmLDG.btMTBOMD.FindKey ([pMtCode]) then begin
      Repeat
        mOuQnt:=mOuQnt+dmLDG.btMTBOMD.FieldByName('OuQnt').AsFloat;
        mOuVal:=mOuVal+dmLDG.btMTBOMD.FieldByName('CValue').AsFloat;
        Application.ProcessMessages;
        dmLDG.btMTBOMD.Next;
      until dmLDG.btMTBOMD.Eof or (dmLDG.btMTBOMD.FieldByName('MtCode').AsInteger<>pMtCode);
    end;
    dmLDG.btMTBOMD.RestoreStatus;
  finally
    dmLDG.btMTBOMD.EnableControls;
  end;
  // Ulozime udaje na skladovu kartu MTZ
  dmLDG.btMTBSTC.SwapIndex;
  dmLDG.btMTBSTC.IndexName:='MtCode';
  If dmLDG.btMTBSTC.FindKey ([pMtCode]) then begin
    dmLDG.btMTBSTC.Edit;
    dmLDG.btMTBSTC.FieldByName ('InQnt').AsFloat:=mInQnt;
    dmLDG.btMTBSTC.FieldByName ('OuQnt').AsFloat:=mOuQnt;
    dmLDG.btMTBSTC.FieldByName ('InVal').AsFloat:=mInVal;
    dmLDG.btMTBSTC.FieldByName ('OuVal').AsFloat:=mOuVal;
    dmLDG.btMTBSTC.FieldByName ('ActQnt').AsFloat:=mInQnt-mOuQnt;
    dmLDG.btMTBSTC.FieldByName ('ActVal').AsFloat:=mInVal-mOuVal;
    dmLDG.btMTBSTC.FieldByName ('LPrice').AsFloat:=mLPrice;
    If IsNotNul (dmLDG.btMTBSTC.FieldByName ('ActQnt').AsFloat) then begin
      dmLDG.btMTBSTC.FieldByName ('CPrice').AsFloat:=RoundCPrice(dmLDG.btMTBSTC.FieldByName ('ActVal').AsFloat/dmLDG.btMTBSTC.FieldByName ('ActQnt').AsFloat);
    end;
    dmLDG.btMTBSTC.Post;
  end
  else ;
  dmLDG.btMTBSTC.RestoreIndex;
end;

procedure RchRecalc (pHEAD,pITEM:TNexBtrTable);  // Prepocita hlavicku dokladu prekurzovania FA
var mDocQnt:longint;    mFgEndVal,mAcEndVal,mEyEndVal,mEyCrdVal:double;
begin
  If pHEAD.RecordCount>0 then begin
    mDocQnt:=0;
    mFgEndVal:=0;  mAcEndVal:=0;  mEyEndVal:=0;  mEyCrdVal:=0;
    pITEM.SwapIndex;
    pITEM.IndexName:='FgDvzName';
    If pITEM.FindKey([pHEAD.FieldByName('FgDvzName').AsString]) then begin
      Repeat
        Inc (mDocQnt);
        mFgEndVal:=mFgEndVal+pITEM.FieldByName('FgEndVal').AsFloat;
        mAcEndVal:=mAcEndVal+pITEM.FieldByName('AcEndVal').AsFloat;
        mEyEndVal:=mEyEndVal+pITEM.FieldByName('EyEndVal').AsFloat;
        mEyCrdVal:=mEyCrdVal+pITEM.FieldByName('EyCrdVal').AsFloat;
        Application.ProcessMessages;
        pITEM.Next;
      until (pITEM.Eof) or (pITEM.FieldByName('FgDvzName').AsString<>pHEAD.FieldByName('FgDvzName').AsString);
    end;
    pITEM.RestoreIndex;
    // Ulozime vypocitane hodnoty do hlavicky
    pHEAD.Edit;
    pHEAD.FieldByName('FgEndVal').AsFloat:=mFgEndVal;
    pHEAD.FieldByName('AcEndVal').AsFloat:=mAcEndVal;
    pHEAD.FieldByName('EyEndVal').AsFloat:=mEyEndVal;
    pHEAD.FieldByName('EyCrdVal').AsFloat:=mEyCrdVal;
    pHEAD.FieldByName('DocQnt').AsFloat:=mDocQnt;
    pHEAD.Post;
  end;
end;

// ****************** ODBERATELSKE DODACIE LISTY *******************
function ImiFreeItmNum (pIMI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  If pIMI.IndexName<>'DoIt' then pIMI.IndexName:='DoIt';
  If pIMI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<pIMI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>pIMI.FieldByName('ItmNum').AsInteger) then mItmNum:=pIMI.FieldByName('ItmNum').AsInteger;
      pIMI.Next;
    until (pIMI.Eof) or mFind or (pIMI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function OmiFreeItmNum (pOMI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  If pOMI.IndexName<>'DoIt' then pOMI.IndexName:='DoIt';
  If pOMI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<pOMI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>pOMI.FieldByName('ItmNum').AsInteger) then mItmNum:=pOMI.FieldByName('ItmNum').AsInteger;
      pOMI.Next;
    until (pOMI.Eof) or mFind or (pOMI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function TciFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;   mFind:boolean;
begin
  Result:=0;
  If dmSTK.btTCI.IndexName<>'DoIt' then dmSTK.btTCI.IndexName:='DoIt';
  If dmSTK.btTCI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<dmSTK.btTCI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>dmSTK.btTCI.FieldByName('ItmNum').AsInteger) then mItmNum:=dmSTK.btTCI.FieldByName('ItmNum').AsInteger;
      dmSTK.btTCI.Next;
    until (dmSTK.btTCI.Eof) or mFind or (dmSTK.btTCI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function UdiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky UD
begin
  If dmSTK.btUDI.IndexName<>'DoIt' then dmSTK.btUDI.IndexName:='DoIt';
  If not dmSTK.btUDI.FindNearest([pDocNum,65000]) then dmSTK.btUDI.Last;
  If not dmSTK.btUDI.IsLastRec or (dmSTK.btUDI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btUDI.Prior;
  If dmSTK.btUDI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btUDI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function TciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
begin
  If dmSTK.btTCI.IndexName<>'DoIt' then dmSTK.btTCI.IndexName:='DoIt';
  If not dmSTK.btTCI.FindNearest([pDocNum,65000]) then dmSTK.btTCI.Last;
  If not dmSTK.btTCI.IsLastRec or (dmSTK.btTCI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btTCI.Prior;
  If dmSTK.btTCI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btTCI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function GenUdDocNum (pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  Result:='UD'+pBookNum+StrIntZero(pSerNum,5);
end;

function GenMcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='CP'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenOcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='ZK'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenTcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='OD'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenAcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='AC'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenAfDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='AF'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenPsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='PO'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenPkDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='MB'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenCDDocNum (pYear:Str2;pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='CD'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenSaDocNum (pBookNum:Str5; pDate:TDateTime): Str12; // Skaldove vydajky MO predaja
begin
  Result:='SA'+YearS(pDate)+Copy(pBookNum,3,3)+'0'+Mth(pDate)+Day(pDate);
end;

procedure TchRecalc (pTCH,pTCI:TNexBtrTable);  //Prepocita hlavicku zadanho dodacieho listu podla jeho poloziek
var mItmQnt,mCntOut,mCntExp:longint; mDstPair:Str1; mBonNum,mVatQnt,I:byte;
    mAcCValue,mAcDValue,mAcDscVal,mAcRndVal:double; mVolume,mWeight:double;
    mFgCValue,mFgDValue,mFgDBValue,mFgDscVal,mFgDscBVal,mFgHdsVal,mFgRndVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;  mSpMark:Str10;  mIcdNum:Str14;mOcdNum:Str14;
begin
  mVolume:=0;  mWeight:=0;  mSpMark:='';
  mItmQnt:=0;  mCntOut:=0;  mCntExp:=0;
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;  mAcRndVal:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;  mFgRndVal:=0;
  mFgDBValue:=0; mFgDscBVal:=0; mFgHdsVal:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pTCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcBValue.VatPrc[I]:=pTCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgAValue.VatPrc[I]:=pTCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgBValue.VatPrc[I]:=pTCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  pTCI.SwapIndex;
  pTCI.IndexName:='DocNum';
  mDstPair:='N';  mIcdNum:=''; mOcdNum:='';
  If pTCI.FindKey ([pTCH.FieldByName('DocNum').AsString]) then begin
    mDstPair:='Q';
    Repeat
      Inc (mItmQnt);
      If mIcdNum<>'' then begin
        If copy(mIcdNum,1,12)<>pTCI.FieldByName('IcdNum').AsString then mIcdNum:=mIcdNum+'>>';
      end
      else mIcdNum:=pTCI.FieldByName('IcdNum').AsString;
      If mOcdNum<>'' then begin
        If copy(mOcdNum,1,12)<>pTCI.FieldByName('OcdNum').AsString then mOcdNum:=mOcdNum+'>>';
      end
      else mOcdNum:=pTCI.FieldByName('OcdNum').AsString;
      mVolume:=mVolume+pTCI.FieldByName('Volume').AsFloat;
      mWeight:=mWeight+pTCI.FieldByName('Weight').AsFloat;
      // Uctovna mena
      mAcCValue:=mAcCValue+pTCI.FieldByName('AcCValue').AsFloat;
      mAcDValue:=mAcDValue+pTCI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pTCI.FieldByName('AcDscVal').AsFloat;
      mAcRndVal:=mAcRndVal+pTCI.FieldByName('AcRndVal').AsFloat;
      // Vyuctovacia mena
      mFgCValue:=mFgCValue+pTCI.FieldByName('FgCValue').AsFloat;
      mFgDValue:=mFgDValue+pTCI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pTCI.FieldByName('FgDscVal').AsFloat;
      mFgHdsVal:=mFgHdsVal+pTCI.FieldByName('FgHdsVal').AsFloat;
      mFgRndVal:=mFgRndVal+pTCI.FieldByName('FgRndVal').AsFloat;
      mFgDBValue:=mFgDBValue+Rd2(pTCI.FieldByName('FgDValue').AsFloat*(1+pTCI.FieldByName('VatPrc').AsInteger/100));
      mFgDscBVal:=mFgDscBVal+Rd2(pTCI.FieldByName('FgDscVal').AsFloat*(1+pTCI.FieldByName('VatPrc').AsInteger/100));
      If mAcAValue.VatGrp(pTCI.FieldByName('VatPrc').AsInteger)=0 then begin // Neexistujuca sadzba DPH
        mVatQnt:=mAcAValue.VatQnt;
        If mVatQnt<3 then begin
          mAcAValue.VatPrc[mVatQnt+1]:=pTCI.FieldByName('VatPrc').AsInteger;
          mAcBValue.VatPrc[mVatQnt+1]:=pTCI.FieldByName('VatPrc').AsInteger;
          mFgAValue.VatPrc[mVatQnt+1]:=pTCI.FieldByName('VatPrc').AsInteger;
          mFgBValue.VatPrc[mVatQnt+1]:=pTCI.FieldByName('VatPrc').AsInteger;
        end;
      end;
      mFgAValue.Add (pTCI.FieldByName('VatPrc').AsInteger,pTCI.FieldByName('FgAValue').AsFloat+pTCI.FieldByName('FgRndVal').AsFloat-pTCI.FieldByName('FgRndVat').AsFloat);
      mFgBValue.Add (pTCI.FieldByName('VatPrc').AsInteger,pTCI.FieldByName('FgBValue').AsFloat+pTCI.FieldByName('FgRndVal').AsFloat);
      If (pTCI.FieldByName('StkStat').AsString='S') or (pTCI.FieldByName('StkStat').AsString='C') or (pTCI.FieldByName('StkStat').AsString='E') or (pTCI.FieldByName('StkStat').AsString='X') then Inc (mCntOut);
      If (pTCI.FieldByName('StkStat').AsString='E') then Inc (mCntExp);
      If (pTCI.FieldByName('FinStat').AsString='') then mDstPair:='N';
      If (pTCI.FieldByName('SpMark').AsString<>'') then mSpMark:=pTCI.FieldByName('SpMark').AsString;
      If (pTCI.FieldByName('BonNum').AsInteger<>0) then mBonNum:=pTCI.FieldByName('BonNum').AsInteger;
      pTCI.Next;
    until (pTCI.Eof) or (pTCI.FieldByName('DocNum').AsString<>pTCH.FieldByName('DocNum').AsString);
  end;
  pTCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pTCH.Edit;
  pTCH.FieldByName('IcdNum').AsString:=mIcdNum;
  If pTCH.FieldByName('OcdNum').AsString = '' then pTCH.FieldByName('OcdNum').AsString:=mOcdNum;
  pTCH.FieldByName('Volume').AsFloat:=mVolume;
  pTCH.FieldByName('Weight').AsFloat:=mWeight;
  pTCH.FieldByName('VatPrc1').AsInteger:=mAcAValue.VatPrc[1];
  pTCH.FieldByName('VatPrc2').AsInteger:=mAcAValue.VatPrc[2];
  pTCH.FieldByName('VatPrc3').AsInteger:=mAcAValue.VatPrc[3];
  pTCH.FieldByName('VatPrc4').AsInteger:=mAcAValue.VatPrc[4];
  pTCH.FieldByName('VatPrc5').AsInteger:=mAcAValue.VatPrc[5];
  If pTCH.FieldByName('FgCourse').AsFloat=1 then begin
    If IsNotNul (mAcDValue)
      then pTCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mAcDscVal/mAcDValue)*100)
      else pTCH.FieldByName('DscPrc').AsFloat:=0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then pTCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/mFgDValue)*100)
      else pTCH.FieldByName('DscPrc').AsFloat:=0;
  end;
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(pTCH.FieldByName('VatDoc').AsInteger));
  pTCH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pTCH.FieldByName('AcDValue').AsFloat:=ClcAcFromFg2(mFgDValue,pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcDscVal').AsFloat:=ClcAcFromFg2(mFgDscVal,pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue').AsFloat:=ClcAcFromFg2(mFgAValue.Value[0],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcVatVal').AsFloat:=ClcAcFromFg2((mFgBValue.Value[0]-mFgAValue.Value[0]),pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcBValue').AsFloat:=ClcAcFromFg2(mFgBValue.Value[0],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue1').AsFloat:=ClcAcFromFg2(mFgAValue.Value[1],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue2').AsFloat:=ClcAcFromFg2(mFgAValue.Value[2],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue3').AsFloat:=ClcAcFromFg2(mFgAValue.Value[3],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue4').AsFloat:=ClcAcFromFg2(mFgAValue.Value[4],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcAValue5').AsFloat:=ClcAcFromFg2(mFgAValue.Value[5],pTCH.FieldByName('FgCourse').AsFloat);

  pTCH.FieldByName('AcBValue1').AsFloat:=ClcAcFromFg2(mFgBValue.Value[1],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcBValue2').AsFloat:=ClcAcFromFg2(mFgBValue.Value[2],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcBValue3').AsFloat:=ClcAcFromFg2(mFgBValue.Value[3],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcBValue4').AsFloat:=ClcAcFromFg2(mFgBValue.Value[4],pTCH.FieldByName('FgCourse').AsFloat);
  pTCH.FieldByName('AcBValue5').AsFloat:=ClcAcFromFg2(mFgBValue.Value[4],pTCH.FieldByName('FgCourse').AsFloat);

  pTCH.FieldByName('AcRndVal').AsFloat:=mAcRndVal;
  pTCH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pTCH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  If pTCH.FindField('FgDBValue')<>nil then pTCH.FieldByName('FgDBValue').AsFloat:=mFgDBValue;
  If pTCH.FindField('FgDscBVal')<>nil then pTCH.FieldByName('FgDscBVal').AsFloat:=mFgDscBVal;
  pTCH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pTCH.FieldByName('FgHdsVal').AsFloat:=mFgHdsVal;
  pTCH.FieldByName('FgAValue').AsFloat:=mFgAValue.Value[0];
  pTCH.FieldByName('FgVatVal').AsFloat:=mFgBValue.Value[0]-mFgAValue.Value[0];
  pTCH.FieldByName('FgBValue').AsFloat:=mFgBValue.Value[0];
  pTCH.FieldByName('FgAValue1').AsFloat:=mFgAValue.Value[1];
  pTCH.FieldByName('FgAValue2').AsFloat:=mFgAValue.Value[2];
  pTCH.FieldByName('FgAValue3').AsFloat:=mFgAValue.Value[3];
  pTCH.FieldByName('FgAValue4').AsFloat:=mFgAValue.Value[4];
  pTCH.FieldByName('FgAValue5').AsFloat:=mFgAValue.Value[5];

  pTCH.FieldByName('FgBValue1').AsFloat:=mFgBValue.Value[1];
  pTCH.FieldByName('FgBValue2').AsFloat:=mFgBValue.Value[2];
  pTCH.FieldByName('FgBValue3').AsFloat:=mFgBValue.Value[3];
  pTCH.FieldByName('FgBValue4').AsFloat:=mFgBValue.Value[4];
  pTCH.FieldByName('FgBValue5').AsFloat:=mFgBValue.Value[5];

  pTCH.FieldByName('FgRndVal').AsFloat:=mFgRndVal;
  If IsNotNul(mFgAValue.Value[0])
    then pTCH.FieldByName('HdsPrc').AsFloat:=Rd2 ((mFgHdsVal/(mFgHdsVal+mFgAValue.Value[0]))*100)
    else pTCH.FieldByName('HdsPrc').AsFloat:=0;
  pTCH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pTCH.FieldByName('CntOut').AsInteger:=mCntOut;
  pTCH.FieldByName('CntExp').AsInteger:=mCntExp;
  pTCH.FieldByName('DstAcc').AsString:=GetDstAcc(pTCH.FieldByName('DocNum').AsString);
  pTCH.FieldByName('DstPair').AsString:=mDstPair;
  pTCH.FieldByName('SpMark').AsString:=mSpMark;
  pTCH.FieldByName('BonNum').AsInteger:=mBonNum;
  pTCH.Post;
  FreeAndNil (mAcAValue);  FreeAndNil (mFgAValue);
  FreeAndNil (mAcBValue);  FreeAndNil (mFgBValue);
  If not ghDEBREG.Active then ghDEBREG.Open;
  If pTCH.FieldByName('IcdNum').AsString=''
    then ghDEBREG.AddDoc(pTCH.FieldByName('PaCode').AsInteger,pTCH.FieldByName('DocNum').AsString,pTCH.FieldByName('FgBValue').AsFloat,0) // Nevyfakturovaný dodací list - je dlh
    else ghDEBREG.AddDoc(pTCH.FieldByName('PaCode').AsInteger,pTCH.FieldByName('DocNum').AsString,0,0); // Vyfakturovaný dodací list - už nie je dlh
end;

procedure TshRecalc (pTSH,pTSI:TNexBtrTable);  //Prepocita hlavicku zadanho dodacieho listu podla jeho poloziek
var mItmQnt:longint; mDstStk,mDstPair:Str1;  mFind:boolean;  mVatQnt,I:byte;
    mAcZValue,mAcTValue,mAcOValue,mAcSValue,mAcAValue,mAcBValue:double;
    mAcDValue,mAcDscVal,mAcRndVal,mFgDValue,mFgDscVal,mFgRndVal:double;
    mAcCValue,mAcEValue,mFgCValue,mFgEValue:TValue8;  mIsdNum:Str12;
begin
  mItmQnt:=0;
  mAcZValue:=0; mAcTValue:=0; mAcOValue:=0; mAcSValue:=0;
  mAcDValue:=0; mAcDscVal:=0; mAcRndVal:=0; mAcAValue:=0; mAcBValue:=0;
  mFgDValue:=0; mFgDscVal:=0; mFgRndVal:=0;
  mAcCValue:=TValue8.Create;  mAcCValue.Clear;
  mAcEValue:=TValue8.Create;  mAcEValue.Clear;
  mFgCValue:=TValue8.Create;  mFgCValue.Clear;
  mFgEValue:=TValue8.Create;  mFgEValue.Clear;
  For I:=1 to 5 do begin
    mAcCValue.VatPrc[I]:=pTSH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcEValue.VatPrc[I]:=pTSH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgCValue.VatPrc[I]:=pTSH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgEValue.VatPrc[I]:=pTSH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  pTSI.SwapIndex;
  pTSI.IndexName:='DocNum';
  mDstStk:='N';   mDstPair:='N';
  If pTSI.FindKey ([pTSH.FieldByName('DocNum').AsString]) then begin
    mDstStk:='S';  mDstPair:='Q';  mIsdNum:='';
    Repeat
      Inc (mItmQnt);
      mAcZValue:=mAcZValue+pTSI.FieldByName('AcZValue').AsFloat;
      mAcTValue:=mAcTValue+pTSI.FieldByName('AcTValue').AsFloat;
      mAcOValue:=mAcOValue+pTSI.FieldByName('AcOValue').AsFloat;
      mAcSValue:=mAcSValue+pTSI.FieldByName('AcSValue').AsFloat;
      mAcDValue:=mAcDValue+pTSI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pTSI.FieldByName('AcDscVal').AsFloat;
      mAcRndVal:=mAcRndVal+pTSI.FieldByName('AcRndVal').AsFloat;
      mAcAValue:=mAcAValue+pTSI.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pTSI.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pTSI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pTSI.FieldByName('FgDscVal').AsFloat;
      mFgRndVal:=mFgRndVal+pTSI.FieldByName('FgRndVal').AsFloat;
      mAcCValue.Add (pTSI.FieldByName('VatPrc').AsInteger,pTSI.FieldByName('AcCValue').AsFloat);
      mAcEValue.Add (pTSI.FieldByName('VatPrc').AsInteger,pTSI.FieldByName('AcEValue').AsFloat);
      mFgCValue.Add (pTSI.FieldByName('VatPrc').AsInteger,pTSI.FieldByName('FgCValue').AsFloat);
      mFgEValue.Add (pTSI.FieldByName('VatPrc').AsInteger,pTSI.FieldByName('FgEValue').AsFloat);
      If (pTSI.FieldByName('StkStat').AsString='N') then mDstStk:='N';
      If (pTSI.FieldByName('FinStat').AsString='') then mDstPair:='N';
      If mIsdNum='' then mIsdNum:=pTSI.FieldByName('IsdNum').AsString;
      pTSI.Next;
    until (pTSI.Eof) or (pTSI.FieldByName('DocNum').AsString<>pTSH.FieldByName('DocNum').AsString);
  end;
  pTSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  If pTSH.FieldByName ('DocNum').AsString<>pTSH.FieldByName('DocNum').AsString then begin
    If pTSH.IndexName<>'DocNum' then pTSH.IndexName:='DocNum';
    mFind:=pTSH.FindKey ([pTSH.FieldByName('DocNum').AsString]);
  end
  else mFind:=TRUE;
  If mFind then begin // Ak existuje hlavicka dokladu
    DocClcRnd(mAcCValue,mAcEValue,mFgCValue,mFgEValue,IsNotNul(pTSH.FieldByName('VatDoc').AsInteger));
    pTSH.Edit;
    If pTSH.FieldByName('FgCourse').AsFloat=0 then pTSH.FieldByName('FgCourse').AsFloat:=1;
    pTSH.FieldByName('AcZValue').AsFloat:=mAcZValue;
    pTSH.FieldByName('AcTValue').AsFloat:=mAcTValue;
    pTSH.FieldByName('AcOValue').AsFloat:=mAcOValue;
    If IsNotNul (mAcSValue)
      then pTSH.FieldByName('AcSValue').AsFloat:=mAcSValue
      else pTSH.FieldByName('AcSValue').AsFloat:=mAcCValue.Value[0];
    If pTSH.FieldByName('FgCourse').AsFloat=1 then begin
      If IsNotNul (mAcDValue)
        then pTSH.FieldByName('DscPrc').AsFloat:=Rd2 ((mAcDscVal/mAcDValue)*100)
        else pTSH.FieldByName('DscPrc').AsFloat:=0;
    end
    else begin
      If IsNotNul (mFgDValue)
        then pTSH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/mFgDValue)*100)
        else pTSH.FieldByName('DscPrc').AsFloat:=0
    end;
    pTSH.FieldByName('AcDValue').AsFloat:=mAcDValue;
    pTSH.FieldByName('AcDscVal').AsFloat:=mAcDscVal;
    pTSH.FieldByName('AcRndVal').AsFloat:=mAcRndVal;
    pTSH.FieldByName('AcAValue').AsFloat:=mAcAValue;
    pTSH.FieldByName('AcBValue').AsFloat:=mAcBValue;
    pTSH.FieldByName('AcCValue').AsFloat:=mAcCValue.Value[0];
    pTSH.FieldByName('AcVatVal').AsFloat:=mAcEValue.Value[0]-mAcCValue.Value[0];
    pTSH.FieldByName('AcEValue').AsFloat:=mAcEValue.Value[0];
    pTSH.FieldByName('AcCValue1').AsFloat:=mAcCValue.Value[1];
    pTSH.FieldByName('AcCValue2').AsFloat:=mAcCValue.Value[2];
    pTSH.FieldByName('AcCValue3').AsFloat:=mAcCValue.Value[3];
    pTSH.FieldByName('AcCValue4').AsFloat:=mAcCValue.Value[4];
    pTSH.FieldByName('AcCValue5').AsFloat:=mAcCValue.Value[5];

    pTSH.FieldByName('AcEValue1').AsFloat:=mAcEValue.Value[1];
    pTSH.FieldByName('AcEValue2').AsFloat:=mAcEValue.Value[2];
    pTSH.FieldByName('AcEValue3').AsFloat:=mAcEValue.Value[3];
    pTSH.FieldByName('AcEValue4').AsFloat:=mAcEValue.Value[4];
    pTSH.FieldByName('AcEValue5').AsFloat:=mAcEValue.Value[5];

    pTSH.FieldByName('AcPrfVal').AsFloat:=mAcAValue-mAcCValue.Value[0]+mAcRndVal;
    pTSH.FieldByName('PrfPrc').AsFloat:=CalcProfPrc(mAcCValue.Value[0]+mAcRndVal,mAcAValue);
    pTSH.FieldByName('FgDValue').AsFloat:=mFgDValue;
    pTSH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
    pTSH.FieldByName('FgRndVal').AsFloat:=mFgRndVal;
    pTSH.FieldByName('FgCValue').AsFloat:=mFgCValue.Value[0];
    pTSH.FieldByName('FgVatVal').AsFloat:=mFgEValue.Value[0]-mFgCValue.Value[0];
    pTSH.FieldByName('FgEValue').AsFloat:=mFgEValue.Value[0];
    pTSH.FieldByName('FgCValue1').AsFloat:=mFgCValue.Value[1];
    pTSH.FieldByName('FgCValue2').AsFloat:=mFgCValue.Value[2];
    pTSH.FieldByName('FgCValue3').AsFloat:=mFgCValue.Value[3];
    pTSH.FieldByName('FgCValue4').AsFloat:=mFgCValue.Value[4];
    pTSH.FieldByName('FgCValue5').AsFloat:=mFgCValue.Value[5];

    pTSH.FieldByName('FgEValue1').AsFloat:=mFgEValue.Value[1];
    pTSH.FieldByName('FgEValue2').AsFloat:=mFgEValue.Value[2];
    pTSH.FieldByName('FgEValue3').AsFloat:=mFgEValue.Value[3];
    pTSH.FieldByName('FgEValue4').AsFloat:=mFgEValue.Value[4];
    pTSH.FieldByName('FgEValue5').AsFloat:=mFgEValue.Value[5];

    pTSH.FieldByName('IsdNum').AsString:=mIsdNum;
    pTSH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
    pTSH.FieldByName('DstStk').AsString:=mDstStk;
    pTSH.FieldByName('DstAcc').AsString:=GetDstAcc(pTSH.FieldByName('DocNum').AsString);
    If pTSH.FieldByName('DstPair').AsString<>'C' then pTSH.FieldByName('DstPair').AsString:=mDstPair;
    pTSH.Post;
  end;
  FreeAndNil (mAcCValue);    FreeAndNil (mFgCValue);
  FreeAndNil (mAcEValue);    FreeAndNil (mFgEValue);
end;

procedure TihRecalc (pTIH,pTII:TNexBtrTable);  //Prepocita hlavicku zadanho dodacieho listu podla jeho poloziek
var mItmQnt:longint; mCValue,mEValue:double;  mStdNum:Str12;
begin
  mItmQnt:=0;  mCValue:=0; mEValue:=0;  mStdNum:='';
  pTII.SwapIndex;
  pTII.IndexName:='DocNum';
  If pTII.FindKey ([pTIH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mCValue:=mCValue+pTII.FieldByName('CValue').AsFloat;
      mEValue:=mEValue+pTII.FieldByName('EValue').AsFloat;
      If pTII.FieldByName('StdNum').AsString<>'' then mStdNum:=pTII.FieldByName('StdNum').AsString;
      pTII.Next;
    until (pTII.Eof) or (pTII.FieldByName('DocNum').AsString<>pTIH.FieldByName('DocNum').AsString);
  end;
  pTII.RestoreIndex;
  pTIH.Edit;
  pTIH.FieldByName('CValue').AsFloat:=mCValue;
  pTIH.FieldByName('EValue').AsFloat:=mEValue;
  pTIH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pTIH.FieldByName('StdNum').AsString:=mStdNum;
  If mStdNum=''
    then pTIH.FieldByName('Status').AsString:='E'
    else pTIH.FieldByName('Status').AsString:='A';
  pTIH.Post;
end;

procedure SahRecalc;  //Prepocita hlavicku zadaneho dokladu podla jej poloziek
var mAValue,mBValue:TValue8;   mCValue,mDscVal,mSecVal,mSpiBvl,mSpeBvl,mInfVal,mNsiQnt:double; mInd:boolean;
    mItmQnt,mNsiCnt:longint;   I,mVatQnt:byte;  mServiceMg:longint;  mBokNum:Str5;   mhSPV:TSpvHnd;
begin
  mInd:=pInd<>NIL;
  If not mInd then ShowProcInd('Prepocet',pSAH.FieldByName('ItmQnt').AsInteger)
  else begin
    pInd.Max:=pSAH.FieldByName('ItmQnt').AsInteger;
    pInd.Position:=0;
  end;
//  try
    pSAH.DisableControls;
    mServiceMg:=gIni.ServiceMg;
    mBokNum:=BookNumFromDocNum(pSAH.FieldByName('DocNum').AsString);
    mItmQnt:=0;  mNsiCnt:=0;  mInfVal:=0;
    mCValue:=0;  mDscVal:=0;  mSecVal:=0;  mSpiBvl:=0;  mSpeBvl:=0;
    mAValue:=TValue8.Create;  mAValue.Clear;
    mBValue:=TValue8.Create;  mBValue.Clear;
    For I:=1 to 5 do begin
      mAValue.VatPrc[I]:=pSAH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
      mBValue.VatPrc[I]:=pSAH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    end;
    pSAI.SwapIndex;
    pSAI.IndexName:='DocNum';
    If pSAI.FindKey ([pSAH.FieldByName('DocNum').AsString]) then begin
      Repeat
        If not mInd then StepProcInd else pInd.StepBy(1);
        Inc (mItmQnt);
        mCValue:=mCValue+pSAI.FieldByName('CValue').AsFloat;
        If pSAI.FieldByName('StkStat').AsString='C' then begin
          mNsiQnt:=pSAI.FieldByName('CpSeQnt').AsFloat-pSAI.FieldByName('CpSuQnt').AsFloat;
          If IsNotNul(mNsiQnt) then begin
            mInfVal:=mInfVal+pSAI.FieldByName('CPrice').AsFloat*mNsiQnt;
          end;
          mDscVal:=mDscVal+pSAI.FieldByName('DscVal').AsFloat;
        end
        else begin
          mNsiQnt:=pSAI.FieldByName('SeQnt').AsFloat-pSAI.FieldByName('SuQnt').AsFloat;
          If IsNotNul(mNsiQnt) then begin
            mInfVal:=mInfVal+pSAI.FieldByName('CPrice').AsFloat*mNsiQnt;
          end;
          mDscVal:=mDscVal+pSAI.FieldByName('DscVal').AsFloat;
        end;
        If pSAI.FieldByName('MgCode').AsInteger<>gKey.Whs.DpiMgc then begin
          If pSAI.FieldByName('MgCode').AsInteger<>gKey.Whs.DpeMgc then begin
            If pSAI.FieldByName('MgCode').AsInteger<mServiceMg then begin // Tovar
              If IsNotNul(mNsiQnt) then Inc (mNsiCnt); // Pocet nevysporiadanych poloziek
            end else mSecVal:=mSecVal+pSAI.FieldByName('AValue').AsFloat; // Sluzby
          end else mSpeBvl:=mSpeBvl+pSAI.FieldByName('BValue').AsFloat;
        end else mSpiBvl:=mSpiBvl+pSAI.FieldByName('BValue').AsFloat;
        If mAValue.VatGrp(pSAI.FieldByName('VatPrc').AsInteger)=0 then begin // Neexistujuca sadzba DPH
          mVatQnt:=mAValue.VatQnt;
          mAValue.VatPrc[mVatQnt+1]:=pSAI.FieldByName('VatPrc').AsInteger;
          mBValue.VatPrc[mVatQnt+1]:=pSAI.FieldByName('VatPrc').AsInteger;
        end;
        mAValue.Add (pSAI.FieldByName('VatPrc').AsInteger,pSAI.FieldByName('AValue').AsFloat);
        mBValue.Add (pSAI.FieldByName('VatPrc').AsInteger,pSAI.FieldByName('BValue').AsFloat);
        Application.ProcessMessages;
        pSAI.Next;
      until (pSAI.Eof) or (pSAI.FieldByName('DocNum').AsString<>pSAH.FieldByName('DocNum').AsString);
    end;
    pSAI.RestoreIndex;
    // Ulozime vypocitane hodnoty do hlavicky objednavky
    pSAH.Edit;
    pSAH.FieldByName('VatPrc1').AsInteger:=mAValue.VatPrc[1];
    pSAH.FieldByName('VatPrc2').AsInteger:=mAValue.VatPrc[2];
    pSAH.FieldByName('VatPrc3').AsInteger:=mAValue.VatPrc[3];
    pSAH.FieldByName('VatPrc4').AsInteger:=mAValue.VatPrc[4];
    pSAH.FieldByName('VatPrc5').AsInteger:=mAValue.VatPrc[5];
    If gIni.SpecSetting='CKD'
      then pSAH.FieldByName('CValue').AsFloat:=mCValue+mInfVal
      else pSAH.FieldByName('CValue').AsFloat:=mCValue;
    pSAH.FieldByName('DscVal').AsFloat:=mDscVal;
    pSAH.FieldByName('AValue').AsFloat:=Rd2(mAValue.Value[0]);
    pSAH.FieldByName('VatVal').AsFloat:=Rd2(mBValue[0]-mAValue[0]);
    pSAH.FieldByName('BValue').AsFloat:=Rd2(mBValue.Value[0]);
    If pSAH.FindField('SpiVal')<>nil then begin
      pSAH.FieldByName('SpiVat').AsFloat:=Rd2(mSpiBvl-(mSpiBvl/(1+gIni.GetVatPrc(2)/100)));
      pSAH.FieldByName('SpeVat').AsFloat:=Rd2(mSpeBvl-(mSpeBvl/(1+gIni.GetVatPrc(2)/100)));
      pSAH.FieldByName('SpiVal').AsFloat:=Rd2(mSpiBvl-pSAH.FieldByName('SpiVat').AsFloat);
      pSAH.FieldByName('SpeVal').AsFloat:=Rd2(mSpeBvl-pSAH.FieldByName('SpeVat').AsFloat);
      pSAH.FieldByName('SecVal').AsFloat:=Rd2(mSecVal);
      pSAH.FieldByName('GscVal').AsFloat:=pSAH.FieldByName('AValue').AsFloat-pSAH.FieldByName('SecVal').AsFloat-(pSAH.FieldByName('SpeVal').AsFloat)-(pSAH.FieldByName('SpiVal').AsFloat);
    end;
    pSAH.FieldByName('AValue1').AsFloat:=mAValue[1];
    pSAH.FieldByName('AValue2').AsFloat:=mAValue[2];
    pSAH.FieldByName('AValue3').AsFloat:=mAValue[3];
    pSAH.FieldByName('AValue4').AsFloat:=mAValue[4];
    pSAH.FieldByName('AValue5').AsFloat:=mAValue[5];

    pSAH.FieldByName('VatVal1').AsFloat:=mBValue[1]-mAValue[1];
    pSAH.FieldByName('VatVal2').AsFloat:=mBValue[2]-mAValue[2];
    pSAH.FieldByName('VatVal3').AsFloat:=mBValue[3]-mAValue[3];
    pSAH.FieldByName('VatVal4').AsFloat:=mBValue[4]-mAValue[4];
    pSAH.FieldByName('VatVal5').AsFloat:=mBValue[5]-mAValue[5];

    pSAH.FieldByName('BValue1').AsFloat:=mBValue[1];
    pSAH.FieldByName('BValue2').AsFloat:=mBValue[2];
    pSAH.FieldByName('BValue3').AsFloat:=mBValue[3];
    pSAH.FieldByName('BValue4').AsFloat:=mBValue[4];
    pSAH.FieldByName('BValue5').AsFloat:=mBValue[5];

    pSAH.FieldByName('DstAcc').AsString:=GetDstAcc(pSAH.FieldByName('DocNum').AsString);
    pSAH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
    pSAH.FieldByName('NsiCnt').AsInteger:=mNsiCnt;
    pSAH.Post;
//finally
    pSAH.EnableControls;
//end;
  If not mInd then CloseProcInd;
end;

procedure UdhRecalc (pUDH,pUDI:TNexBtrTable);  //Prepocita hlavicku zadaneho dokladu podla jej poloziek
var mAcCValue,mFgDValue,mFgHValue,mFgAValue,mFgBValue:double;
    mSpMark:Str10;   mWsdNum,mTcdNum,mIcdNum,mNudNum:Str12;
    mItmQnt:longint; mBonNum,I:byte;  mType:Str2;
begin
  mItmQnt:=0;    mAcCValue:=0;  mSpMark:='';   mBonNum:=0;
  mFgDValue:=0;  mFgHValue:=0;  mFgAValue:=0;  mFgBValue:=0;
  mWsdNum:='';   mTcdNum:='';   mIcdNum:='';   mNudNum:='';
  pUDI.SwapIndex;
  pUDI.IndexName:='DocNum';
  If pUDI.FindKey ([pUDH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue:=mAcCValue+pUDI.FieldByName('AcCValue').AsFloat;
      mFgDValue:=mFgDValue+pUDI.FieldByName('FgDValue').AsFloat;
      mFgHValue:=mFgHValue+pUDI.FieldByName('FgHValue').AsFloat;
      mFgAValue:=mFgAValue+pUDI.FieldByName('FgAValue').AsFloat;
      mFgBValue:=mFgBValue+pUDI.FieldByName('FgBValue').AsFloat;
      If (pUDI.FieldByName('SpMark').AsString<>'') then mSpMark:=pUDI.FieldByName('SpMark').AsString;
      If (pUDI.FieldByName('BonNum').AsInteger<>0) then mBonNum:=pUDI.FieldByName('BonNum').AsInteger;
      mType:=copy (pUDI.FieldByName('TcdNum').AsString,1,2);
      If (mType='OD') then mTcdNum:=pUDI.FieldByName('TcdNum').AsString;
      If (mType='AV') then mWsdNum:=pUDI.FieldByName('TcdNum').AsString;

      If (pUDI.FieldByName('IcdNum').AsString<>'') then mIcdNum:=pUDI.FieldByName('IcdNum').AsString;
      If (pUDI.FieldByName('NudNum').AsString<>'') then mNudNum:=pUDI.FieldByName('NudNum').AsString;
      pUDI.Next;
    until (pUDI.Eof) or (pUDI.FieldByName('DocNum').AsString<>pUDH.FieldByName('DocNum').AsString);
  end;
  pUDI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pUDH.Edit;
  pUDH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pUDH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pUDH.FieldByName('FgHValue').AsFloat:=mFgHValue;
  pUDH.FieldByName('FgAValue').AsFloat:=mFgAValue;
  pUDH.FieldByName('FgBValue').AsFloat:=mFgBValue;
  If IsNotNul (mFgHValue) then pUDH.FieldByName('DscPrc').AsFloat:=(1-(mFgBValue/mFgHValue))*100;
  pUDH.FieldByName('SpMark').AsString:=mSpMark;
  pUDH.FieldByName('BonNum').AsInteger:=mBonNum;
  pUDH.FieldByName('WsdNum').AsString:=mWsdNum;
  pUDH.FieldByName('TcdNum').AsString:=mTcdNum;
  pUDH.FieldByName('IcdNum').AsString:=mIcdNum;
  pUDH.FieldByName('NudNum').AsString:=mNudNum;
  pUDH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pUDH.Post;
end;

procedure OchRecalc (pOCH,pOCI:TNexBtrTable);  //Prepocita hlavicku zadanej zakazky podla jej poloziek
var mItmQnt,mCntReq,mCntOrd,mCntRes,mCntPrp,mCntRat,mCntTrm,mCntOut,mCntErr:longint;
    mAcCValue,mAcDValue,mAcDscVal,mFgCValue,mFgDValue,mFgDscVal,mTValue:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;    I:byte;
begin
  mItmQnt:=0;  mCntOrd:=0;  mCntReq:=0;  mCntRes:=0;  mTValue:=0;
  mCntPrp:=0;  mCntRat:=0;  mCntTrm:=0;  mCntOut:=0;  mCntErr:=0;
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pOCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcBValue.VatPrc[I]:=pOCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgAValue.VatPrc[I]:=pOCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgBValue.VatPrc[I]:=pOCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  pOCI.SwapIndex;
  pOCI.IndexName:='DocNum';
  If pOCI.FindKey ([pOCH.FieldByname('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue:=mAcCValue+pOCI.FieldByName('AcCValue').AsFloat;
      mAcDValue:=mAcDValue+pOCI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pOCI.FieldByName('AcDscVal').AsFloat;
      mFgCValue:=mFgCValue+pOCI.FieldByName('FgCValue').AsFloat;
      mFgDValue:=mFgDValue+pOCI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pOCI.FieldByName('FgDscVal').AsFloat;
      mTValue:=mTValue+pOCI.FieldByName('TValue').AsFloat;
      mAcAValue.Add(pOCI.FieldByName('VatPrc').AsInteger,pOCI.FieldByName('AcAValue').AsFloat);
      mAcBValue.Add(pOCI.FieldByName('VatPrc').AsInteger,pOCI.FieldByName('AcBValue').AsFloat);
      mFgAValue.Add(pOCI.FieldByName('VatPrc').AsInteger,pOCI.FieldByName('FgAValue').AsFloat);
      mFgBValue.Add(pOCI.FieldByName('VatPrc').AsInteger,pOCI.FieldByName('FgBValue').AsFloat);
      If (pOCI.FieldByName('DlvDate').AsDateTime>0) then Inc (mCntTrm);
      If (pOCI.FieldByName('RatDate').AsDateTime>0) then Inc (mCntRat);
      If pOCI.FieldByName('StkStat').AsString='N' then Inc (mCntReq);
      If pOCI.FieldByName('StkStat').AsString='O' then Inc (mCntOrd);
      If pOCI.FieldByName('StkStat').AsString='R' then Inc (mCntRes);
      If pOCI.FieldByName('StkStat').AsString='P' then Inc (mCntPrp);
      If pOCI.FieldByName('StkStat').AsString='S' then Inc (mCntOut);
      If pOCI.FieldByName('StkStat').AsString='E' then Inc (mCntErr);
      pOCI.Next;
    until (pOCI.Eof) or (pOCI.FieldByName('DocNum').AsString<>pOCH.FieldByName('DocNum').AsString);
  end;
  pOCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pOCH.Edit;
  If pOCH.FieldByName('FgCourse').AsFloat=1 then begin
    If IsNotNul (mAcDValue)
      then pOCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mAcDscVal/mAcDValue)*100)
      else pOCH.FieldByName('DscPrc').AsFloat:=0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then pOCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/mFgDValue)*100)
      else pOCH.FieldByName('DscPrc').AsFloat:=0;
  end;
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(pOCH.FieldByName('VatDoc').AsInteger));
  pOCH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pOCH.FieldByName('AcAValue').AsFloat:=mAcAValue.Value[0];
  pOCH.FieldByName('AcVatVal').AsFloat:=mAcBValue.Value[0]-mAcAValue.Value[0];
  pOCH.FieldByName('AcBValue').AsFloat:=mAcBValue.Value[0];
  pOCH.FieldByName('AcAValue1').AsFloat:=mAcAValue.Value[1];
  pOCH.FieldByName('AcAValue2').AsFloat:=mAcAValue.Value[2];
  pOCH.FieldByName('AcAValue3').AsFloat:=mAcAValue.Value[3];
  pOCH.FieldByName('AcAValue4').AsFloat:=mAcAValue.Value[4];
  pOCH.FieldByName('AcAValue5').AsFloat:=mAcAValue.Value[5];

  pOCH.FieldByName('AcBValue1').AsFloat:=mAcBValue.Value[1];
  pOCH.FieldByName('AcBValue2').AsFloat:=mAcBValue.Value[2];
  pOCH.FieldByName('AcBValue3').AsFloat:=mAcBValue.Value[3];
  pOCH.FieldByName('AcBValue4').AsFloat:=mAcBValue.Value[4];
  pOCH.FieldByName('AcBValue5').AsFloat:=mAcBValue.Value[5];

  pOCH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pOCH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pOCH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pOCH.FieldByName('TValue').AsFloat:=mTValue;
  pOCH.FieldByName('FgAValue').AsFloat:=mFgAValue.Value[0];
  pOCH.FieldByName('FgVatVal').AsFloat:=mFgBValue.Value[0]-mFgAValue.Value[0];
  pOCH.FieldByName('FgBValue').AsFloat:=mFgBValue.Value[0];
  pOCH.FieldByName('FgAValue1').AsFloat:=mFgAValue.Value[1];
  pOCH.FieldByName('FgAValue2').AsFloat:=mFgAValue.Value[2];
  pOCH.FieldByName('FgAValue3').AsFloat:=mFgAValue.Value[3];
  pOCH.FieldByName('FgAValue4').AsFloat:=mFgAValue.Value[4];
  pOCH.FieldByName('FgAValue5').AsFloat:=mFgAValue.Value[5];

  pOCH.FieldByName('FgBValue1').AsFloat:=mFgBValue.Value[1];
  pOCH.FieldByName('FgBValue2').AsFloat:=mFgBValue.Value[2];
  pOCH.FieldByName('FgBValue3').AsFloat:=mFgBValue.Value[3];
  pOCH.FieldByName('FgBValue4').AsFloat:=mFgBValue.Value[4];
  pOCH.FieldByName('FgBValue5').AsFloat:=mFgBValue.Value[5];

  pOCH.FieldByName('AcDValue').AsFloat:=ClcAcFromFg2(mFgDValue,pOCH.FieldByName('FgCourse').AsFloat);
  pOCH.FieldByName('AcDscVal').AsFloat:=ClcAcFromFg2(mFgDscVal,pOCH.FieldByName('FgCourse').AsFloat);

  pOCH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pOCH.FieldByName('CntReq').AsInteger:=mCntReq;
  pOCH.FieldByName('CntOrd').AsInteger:=mCntOrd;
  pOCH.FieldByName('CntRes').AsInteger:=mCntRes;
  pOCH.FieldByName('CntPrp').AsInteger:=mCntPrp;
  pOCH.FieldByName('CntTrm').AsInteger:=mCntTrm;
  pOCH.FieldByName('CntRat').AsInteger:=mCntRat;
  pOCH.FieldByName('CntOut').AsInteger:=mCntOut;
  pOCH.FieldByName('CntErr').AsInteger:=mCntErr;
  pOCH.Post;
  FreeAndNil (mAcAValue);
  FreeAndNil (mAcBValue);
end;

procedure PshRecalc (pPSH,pPSI:TNexBtrTable);  //Prepocita hlavicku zadanej objednavky podla jej poloziek
var mItmQnt:longint;  mDstOrd:Str1;
    mAcDValue,mAcDscVal,mAcCValue,mAcVatVal,mAcEValue,mAcAValue,mAcBValue:double;
    mFgDValue,mFgDscVal,mFgCValue,mFgVatVal,mFgEValue:double;
begin
  mItmQnt:=0; mDstOrd:='O';
  mAcDValue:=0;  mAcDscVal:=0;  mAcCValue:=0; mAcVatVal:=0;
  mAcEValue:=0;  mAcAValue:=0;  mAcBValue:=0;
  mFgDValue:=0;  mFgDscVal:=0;  mFgCValue:=0;
  mFgVatVal:=0;  mFgEValue:=0;
  pPSI.SwapIndex;
  pPSI.IndexName:='DocNum';
  If pPSI.FindKey ([pPSH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcDValue:=mAcDValue+pPSI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pPSI.FieldByName('AcDscVal').AsFloat;
      mAcCValue:=mAcCValue+pPSI.FieldByName('AcCValue').AsFloat;
      mAcEValue:=mAcEValue+pPSI.FieldByName('AcEValue').AsFloat;
      mAcAValue:=mAcAValue+pPSI.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pPSI.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pPSI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pPSI.FieldByName('FgDscVal').AsFloat;
      mFgCValue:=mFgCValue+pPSI.FieldByName('FgCValue').AsFloat;
      mFgEValue:=mFgEValue+pPSI.FieldByName('FgEValue').AsFloat;
      If pPSI.FieldByName('OrdStat').AsString='N' then mDstOrd:='N';
      pPSI.Next;
    until (pPSI.Eof) or (pPSI.FieldByName('DocNum').AsString<>pPSH.FieldByName('DocNum').AsString);
  end;
  pPSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pPSH.Edit;
  pPSH.FieldByName('AcDValue').AsFloat:=mAcDValue;
  pPSH.FieldByName('AcDscVal').AsFloat:=mAcDscVal;
  pPSH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pPSH.FieldByName('AcVatVal').AsFloat:=mAcEValue-mAcCValue;
  pPSH.FieldByName('AcEValue').AsFloat:=mAcEValue;
  pPSH.FieldByName('AcAValue').AsFloat:=mAcAValue;
  pPSH.FieldByName('AcBValue').AsFloat:=mAcBValue;
  pPSH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pPSH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pPSH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pPSH.FieldByName('FgVatVal').AsFloat:=mFgEValue-mFgCValue;
  pPSH.FieldByName('FgEValue').AsFloat:=mFgEValue;
  pPSH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pPSH.FieldByName('DstOrd').AsString:=mDstOrd;
  pPSH.Post;
end;

procedure OshRecalc (pOSH,pOSI:TNexBtrTable);  //Prepocita hlavicku zadanej objednavky podla jej poloziek
var mCQ,mFQ,mSQ,mItmQnt:longint;  mDstStk:Str1;   mVolume,mWeight:double;
    mAcDValue,mAcDscVal,mAcCValue,mAcVatVal,mAcEValue,mAcAValue,mAcBValue:double;
    mFgDValue,mFgDscVal,mFgCValue,mFgVatVal,mFgEValue:double;
begin
  mCQ:=0; mFQ:=0; mSQ:=0; mItmQnt:=0; mDstStk:='S';  mVolume:=0;  mWeight:=0;
  mAcDValue:=0;  mAcDscVal:=0;  mAcCValue:=0;  mAcVatVal:=0;
  mAcEValue:=0;  mAcAValue:=0;  mAcBValue:=0;
  mFgDValue:=0;  mFgDscVal:=0;  mFgCValue:=0;
  mFgVatVal:=0;  mFgEValue:=0;
  pOSI.SwapIndex;
  pOSI.IndexName:='DocNum';
  If pOSI.FindKey ([pOSH.FieldByName('DocNum').AsString]) then begin
    Repeat
      Inc (mItmQnt);
      mAcDValue:=mAcDValue+pOSI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pOSI.FieldByName('AcDscVal').AsFloat;
      mAcCValue:=mAcCValue+pOSI.FieldByName('AcCValue').AsFloat;
      mAcEValue:=mAcEValue+pOSI.FieldByName('AcEValue').AsFloat;
      mAcAValue:=mAcAValue+pOSI.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pOSI.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pOSI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pOSI.FieldByName('FgDscVal').AsFloat;
      mFgCValue:=mFgCValue+pOSI.FieldByName('FgCValue').AsFloat;
      mFgEValue:=mFgEValue+pOSI.FieldByName('FgEValue').AsFloat;
      mVolume:=mVolume+pOSI.FieldByName('Volume').AsFloat;
      mWeight:=mWeight+pOSI.FieldByName('Weight').AsFloat;
      If (pOSI.FieldByName('StkStat').AsString='O') or (pOSI.FieldByName('StkStat').AsString='L') then mDstStk:='O';
      If (pOSI.FieldByName('FixDate').AsDateTime>0) then Inc(mFQ);
      If (pOSI.FieldByName('CnfDate').AsDateTime>0) then Inc(mCQ);
      If (pOSI.FieldByName('SupDate').AsDateTime>0) then Inc(mSQ);
      pOSI.Next;
    until (pOSI.Eof) or (pOSI.FieldByName('DocNum').AsString<>pOSH.FieldByName('DocNum').AsString);
  end;
  pOSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pOSH.Edit;
  pOSH.FieldByName('AcDValue').AsFloat:=mAcDValue;
  pOSH.FieldByName('AcDscVal').AsFloat:=mAcDscVal;
  pOSH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pOSH.FieldByName('AcVatVal').AsFloat:=mAcEValue-mAcCValue;
  pOSH.FieldByName('AcEValue').AsFloat:=mAcEValue;
  pOSH.FieldByName('AcAValue').AsFloat:=mAcAValue;
  pOSH.FieldByName('AcBValue').AsFloat:=mAcBValue;
  pOSH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pOSH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pOSH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pOSH.FieldByName('FgVatVal').AsFloat:=mFgEValue-mFgCValue;
  pOSH.FieldByName('FgEValue').AsFloat:=mFgEValue;
  pOSH.FieldByName('Volume').AsFloat:=mVolume;
  pOSH.FieldByName('Weight').AsFloat:=mWeight;
  pOSH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pOSH.FieldByName('DstStk').AsString:=mDstStk;
  If mSQ=mItmQnt then pOSH.FieldByName('CnfStat').AsString:='P'
  else If mSQ>0  then pOSH.FieldByName('CnfStat').AsString:='N'
  else If mCQ>0  then pOSH.FieldByName('CnfStat').AsString:='C'
  else If mFQ>0  then pOSH.FieldByName('CnfStat').AsString:='F'
                 else pOSH.FieldByName('CnfStat').AsString:='';
  pOSH.Post;
end;

procedure IchRecalc (pICH,pICI:TNexBtrTable);  //Prepocita hlavicku zadanej faktury podla jej poloziek
var mItmQnt:longint;   mDstPair:Str1;   mBonNum, mVatQnt,I:byte; mSpMark:Str10;  mQntSum:double; mTcdNum:Str12;
    mAcCValue,mAcDValue,mAcDscVal,mAcPValue,mEyCrdVal,mAcRndVat,mAcRndVal,mFgRndVat,mFgRndVal:double;
    mFgCourse,mFgCValue,mFgDValue,mFgDBValue,mFgDscVal,mFgDscBVal,mFgPValue,mFgHdsVal,mWeight,mVolume,mCctVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8; mCrdValCalc:TIcdCrdValCalc;
begin
  mItmQnt:=0;    mSpMark:='';   mBonNum:=0;    mQntSum:=0;   mTcdNum:='';
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;  mAcPValue:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;  mFgPValue:=0;
  mEyCrdVal:=0;  mFgHdsVal:=0;  mAcRndVal:=0;  mFgRndVal:=0;
  mFgDBValue:=0; mFgDscBVal:=0; mWeight:=0;    mVolume:=0;   mCctVal:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 5 do begin
    mAcAValue.VatPrc[I]:=pICH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcBValue.VatPrc[I]:=pICH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgAValue.VatPrc[I]:=pICH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgBValue.VatPrc[I]:=pICH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
(*  RZ 31.12.2005 - vypol som pretoze pri aktualizacii prepocet hlaviciek ide velmi pomali
  mCrdValCalc:=TIcdCrdValCalc.Create;
  mCrdValCalc.CrdValCalc(pICH.FieldByName('DocNum').AsString,pICH.FieldByName('DocDate').AsDateTime);
  mEyCrdVal:=mCrdValCalc.CrdVal;
  FreeAndNil (mCrdValCalc);
*)
  pICI.SwapIndex;
  pICI.IndexName:='DocNum';
  mDstPair:='N';
  If pICI.FindKey ([pICH.FieldByName('DocNum').AsString]) then begin
    mDstPair:='Q';
    Repeat
      Inc (mItmQnt);
      If pICI.FieldByName('TcdNum').AsString<>'' then mTcdNum:=pICI.FieldByName('TcdNum').AsString;
      If pICI.FieldByName('GsCode').AsInteger<>gKey.Sys.TrvGsc then begin
        mWeight:=mWeight+pICI.FieldByName('Weight').AsFloat*pICI.FieldByName('GsQnt').AsFloat;
        mVolume:=mVolume+pICI.FieldByName('Volume').AsFloat*pICI.FieldByName('GsQnt').AsFloat;
        mQntSum:=mQntSum+pICI.FieldByName('GsQnt').AsFloat;
      end;
      mAcCValue:=mAcCValue+pICI.FieldByName('AcCValue').AsFloat;
      mAcRndVat:=mAcRndVat+pICI.FieldByName('AcRndVat').AsFloat;
      mAcRndVal:=mAcRndVal+pICI.FieldByName('AcRndVal').AsFloat;
      mFgCValue:=mFgCValue+pICI.FieldByName('FgCValue').AsFloat;
      mFgDValue:=mFgDValue+pICI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pICI.FieldByName('FgDscVal').AsFloat;
      mFgHdsVal:=mFgHdsVal+pICI.FieldByName('FgHdsVal').AsFloat;
      mFgRndVat:=mFgRndVat+pICI.FieldByName('FgRndVat').AsFloat;
      mFgRndVal:=mFgRndVal+pICI.FieldByName('FgRndVal').AsFloat;
      mFgDBValue:=mFgDBValue+Rd2(pICI.FieldByName('FgDValue').AsFloat*(1+pICI.FieldByName('VatPrc').AsInteger/100));
      mFgDscBVal:=mFgDscBVal+Rd2(pICI.FieldByName('FgDscVal').AsFloat*(1+pICI.FieldByName('VatPrc').AsInteger/100));
      If pICI.FieldByName('CctVat').AsInteger=1 then mCctVal:=mCctVal+pICI.FieldByName('AcAValue').AsFloat;
      If pICI.FieldByName('OcdNum').AsString='PROFORMA' then begin
        mAcPValue:=mAcPValue+pICI.FieldByName('AcAValue').AsFloat*(-1);
        mFgPValue:=mFgPValue+pICI.FieldByName('FgAValue').AsFloat*(-1);
      end;
      If mAcAValue.VatGrp(pICI.FieldByName('VatPrc').AsInteger)=0 then begin // Neexistujuca sadzba DPH
        mVatQnt:=mAcAValue.VatQnt;
        If mVatQnt<5 then begin
          mAcAValue.VatPrc[mVatQnt+1]:=pICI.FieldByName('VatPrc').AsInteger;
          mAcBValue.VatPrc[mVatQnt+1]:=pICI.FieldByName('VatPrc').AsInteger;
          mFgAValue.VatPrc[mVatQnt+1]:=pICI.FieldByName('VatPrc').AsInteger;
          mFgBValue.VatPrc[mVatQnt+1]:=pICI.FieldByName('VatPrc').AsInteger;
        end;
      end;
      mAcAValue.Add (pICI.FieldByName('VatPrc').AsInteger,pICI.FieldByName('AcAValue').AsFloat+pICI.FieldByName('AcRndVal').AsFloat-pICI.FieldByName('AcRndVat').AsFloat);
      mAcBValue.Add (pICI.FieldByName('VatPrc').AsInteger,pICI.FieldByName('AcBValue').AsFloat+pICI.FieldByName('AcRndVal').AsFloat);
      mFgAValue.Add (pICI.FieldByName('VatPrc').AsInteger,pICI.FieldByName('FgAValue').AsFloat+pICI.FieldByName('FgRndVal').AsFloat-pICI.FieldByName('FgRndVat').AsFloat);
      mFgBValue.Add (pICI.FieldByName('VatPrc').AsInteger,pICI.FieldByName('FgBValue').AsFloat+pICI.FieldByName('FgRndVal').AsFloat);
      If (pICI.FieldByName('MgCode').AsInteger<gIni.GetServiceMg) and ((pICI.FieldByName('Status').AsString='N') or (pICI.FieldByName('Status').AsString='')) then mDstPair:='N';
      If (pICI.FieldByName('SpMark').AsString<>'') then mSpMark:=pICI.FieldByName('SpMark').AsString;
      If (pICI.FieldByName('BonNum').AsInteger<>0) then mBonNum:=pICI.FieldByName('BonNum').AsInteger;
      pICI.Next;
    until (pICI.Eof) or (pICI.FieldByName('DocNum').AsString<>pICH.FieldByName('DocNum').AsString);
  end;
  pICI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  mFgCourse:=pICH.FieldByName('FgCourse').AsFloat;
  If IsNul (mFgCourse) then mFgCourse:=1;
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(pICH.FieldByName('VatDoc').AsInteger));
  pICH.Edit;
  If IsNotNul (mFgDValue+mFgPValue)
    then pICH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/(mFgDValue+mFgPValue))*100)
    else pICH.FieldByName('DscPrc').AsFloat:=0;
  pICH.FieldByName('VatPrc1').AsInteger:=mAcAValue.VatPrc[1];
  pICH.FieldByName('VatPrc2').AsInteger:=mAcAValue.VatPrc[2];
  pICH.FieldByName('VatPrc3').AsInteger:=mAcAValue.VatPrc[3];
  pICH.FieldByName('VatPrc4').AsInteger:=mAcAValue.VatPrc[4];
  pICH.FieldByName('VatPrc5').AsInteger:=mAcAValue.VatPrc[5];

  pICH.FieldByName('AcCValue').AsFloat:=mAcCValue;
  pICH.FieldByName('FgCValue').AsFloat:=mFgCValue;
  pICH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  If pICH.FindField('FgDBValue')<>nil then pICH.FieldByName('FgDBValue').AsFloat:=Rd2(mFgDBValue);
  If pICH.FindField('FgDscBVal')<>nil then pICH.FieldByName('FgDscBVal').AsFloat:=Rd2(mFgDscBVal);
  pICH.FieldByName('FgDscVal').AsFloat:=Rd2(mFgDscVal);
  pICH.FieldByName('FgHdsVal').AsFloat:=Rd2(mFgHdsVal);
  pICH.FieldByName('FgAValue').AsFloat:=Rd2(mFgAValue.Value[0]);
  pICH.FieldByName('FgBValue').AsFloat:=Rd2(mFgBValue.Value[0]);
  pICH.FieldByName('FgVatVal').AsFloat:=Rd2(pICH.FieldByName('FgBValue').AsFloat-pICH.FieldByName('FgAValue').AsFloat);
  pICH.FieldByName('FgAValue1').AsFloat:=Rd2(mFgAValue.Value[1]);
  pICH.FieldByName('FgAValue2').AsFloat:=Rd2(mFgAValue.Value[2]);
  pICH.FieldByName('FgAValue3').AsFloat:=Rd2(mFgAValue.Value[3]);
  pICH.FieldByName('FgAValue4').AsFloat:=Rd2(mFgAValue.Value[4]);
  pICH.FieldByName('FgAValue5').AsFloat:=Rd2(mFgAValue.Value[5]);

  pICH.FieldByName('FgBValue1').AsFloat:=Rd2(mFgBValue.Value[1]);
  pICH.FieldByName('FgBValue2').AsFloat:=Rd2(mFgBValue.Value[2]);
  pICH.FieldByName('FgBValue3').AsFloat:=Rd2(mFgBValue.Value[3]);
  pICH.FieldByName('FgBValue4').AsFloat:=Rd2(mFgBValue.Value[4]);
  pICH.FieldByName('FgBValue5').AsFloat:=Rd2(mFgBValue.Value[5]);

  pICH.FieldByName('AcDValue').AsFloat:=ClcAcFromFg2(mFgDValue,mFgCourse)+mAcRndVal-mAcRndVat;
  pICH.FieldByName('AcDscVal').AsFloat:=ClcAcFromFg2(mFgDscVal,mFgCourse);
  pICH.FieldByName('AcAValue').AsFloat:=Rd2(mAcAValue.Value[0]);
  pICH.FieldByName('AcBValue').AsFloat:=Rd2(mAcBValue.Value[0]);
  pICH.FieldByName('AcVatVal').AsFloat:=Rd2(pICH.FieldByName('AcBValue').AsFloat-pICH.FieldByName('AcAValue').AsFloat);
  pICH.FieldByName('AcAValue1').AsFloat:=ClcAcFromFg2(mFgAValue.Value[1],mFgCourse);
  pICH.FieldByName('AcAValue2').AsFloat:=ClcAcFromFg2(mFgAValue.Value[2],mFgCourse);
  pICH.FieldByName('AcAValue3').AsFloat:=ClcAcFromFg2(mFgAValue.Value[3],mFgCourse);
  pICH.FieldByName('AcAValue4').AsFloat:=ClcAcFromFg2(mFgAValue.Value[4],mFgCourse);
  pICH.FieldByName('AcAValue5').AsFloat:=ClcAcFromFg2(mFgAValue.Value[5],mFgCourse);

  pICH.FieldByName('AcBValue1').AsFloat:=ClcAcFromFg2(mFgBValue.Value[1],mFgCourse);
  pICH.FieldByName('AcBValue2').AsFloat:=ClcAcFromFg2(mFgBValue.Value[2],mFgCourse);
  pICH.FieldByName('AcBValue3').AsFloat:=ClcAcFromFg2(mFgBValue.Value[3],mFgCourse);
  pICH.FieldByName('AcBValue4').AsFloat:=ClcAcFromFg2(mFgBValue.Value[4],mFgCourse);
  pICH.FieldByName('AcBValue5').AsFloat:=ClcAcFromFg2(mFgBValue.Value[5],mFgCourse);

  pICH.FieldByName('AcPValue').AsFloat:=ClcAcFromFg2(mFgPValue,mFgCourse);
  pICH.FieldByName('FgPValue').AsFloat:=mFgPValue;
  pICH.FieldByName('EyCrdVal').AsFloat:=mEyCrdVal;
  pICH.FieldByName('AcRndVat').AsFloat:=mAcRndVat;
  pICH.FieldByName('AcRndVal').AsFloat:=mAcRndVal;
  pICH.FieldByName('FgRndVat').AsFloat:=mFgRndVat;
  pICH.FieldByName('FgRndVal').AsFloat:=mFgRndVal;
  pICH.FieldByName('CctVal').AsFloat:=Rd2(mCctVal);
  If IsNotNul (mFgAValue.Value[0])
    then pICH.FieldByName('HdsPrc').AsFloat:=Rd2 ((mFgHdsVal/(mFgHdsVal+mFgAValue.Value[0]))*100)
    else pICH.FieldByName('HdsPrc').AsFloat:=0;
  pICH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pICH.FieldByName('DstPair').AsString:=mDstPair;
  pICH.FieldByName('DstAcc').AsString:=GetDstAcc(pICH.FieldByName('DocNum').AsString);
  pICH.FieldByName('AcEndVal').AsFloat:=pICH.FieldByName ('AcBValue').AsFloat-pICH.FieldByName ('AcPayVal').AsFloat-pICH.FieldByName ('EyCrdVal').AsFloat;
  pICH.FieldByName('FgEndVal').AsFloat:=pICH.FieldByName ('FgBValue').AsFloat-pICH.FieldByName ('FgPayVal').AsFloat;
  pICH.FieldByName('Weight').AsFloat:=mWeight;
  pICH.FieldByName('Volume').AsFloat:=mVolume;
  pICH.FieldByName('QntSum').AsFloat:=mQntSum;
  pICH.FieldByName('DstPay').AsInteger:=byte(Eq2(pICH.FieldByName ('AcEndVal').AsFloat,0) and Eq2(pICH.FieldByName ('FgEndVal').AsFloat,0));
  pICH.FieldByName('SpMark').AsString:=mSpMark;
  pICH.FieldByName('BonNum').AsInteger:=mBonNum;
  pICH.FieldByName('TcdNum').AsString:=mTcdNum;
  pICH.Post;
  FreeAndNil (mAcAValue);    FreeAndNil (mFgAValue);
  FreeAndNil (mAcBValue);    FreeAndNil (mFgBValue);
  If not ghDEBREG.Active then ghDEBREG.Open;
  ghDEBREG.AddDoc(pICH.FieldByName('PaCode').AsInteger,pICH.FieldByName('DocNum').AsString,pICH.FieldByName('FgEndVal').AsFloat,pICH.FieldByName('ExpDate').AsDateTime);
end;

procedure SchRecalc (pSCH,pSCI,pSCS:TNexBtrTable);  //PrepSCIta hlavicku zadanej zakazky podla jej poloziek
var mAcCValue,mAcAValue,mAcBValue,mFgDValue,mFgDscVal:double;
    mFgMValue,mFgWValue,mFgGrtVal:double;  mFgAValue,mFgBValue:TValue8;
    mAgiQnt,mGgiQnt,mAgsQnt,mGgsQnt:longint;  I:byte;
begin
  mAgiQnt:=0;    mGgiQnt:=0;    mAgsQnt:=0;    mGgsQnt:=0;
  mAcCValue:=0;  mAcAValue:=0;  mAcBValue:=0;  mFgGrtVal:=0;
  mFgDValue:=0;  mFgDscVal:=0;  mFgMValue:=0;  mFgWValue:=0;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 3 do begin
    mFgAValue.VatPrc[I]:=pSCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgBValue.VatPrc[I]:=pSCH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  // Spocitame pouzity material
  pSCI.SwapIndex;
  pSCI.IndexName:='DocNum';
  If pSCI.FindKey ([pSCH.FieldByname('DocNum').AsString]) then begin
    Repeat
      If pSCI.FieldByName('GrtType').AsString='Z' then begin
        Inc(mGgiQnt);
        mFgGrtVal:=mFgGrtVal+pSCI.FieldByName('FgBValue').AsFloat;
      end
      else Inc(mAgiQnt);
      mAcCValue:=mAcAValue+pSCI.FieldByName('AcCValue').AsFloat;
      mAcAValue:=mAcAValue+pSCI.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pSCI.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pSCI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pSCI.FieldByName('FgDscVal').AsFloat;
      mFgAValue.Add (pSCI.FieldByName('VatPrc').AsInteger,pSCI.FieldByName('FgAValue').AsFloat);
      mFgBValue.Add (pSCI.FieldByName('VatPrc').AsInteger,pSCI.FieldByName('FgBValue').AsFloat);
      mFgMValue:=mFgMValue+pSCI.FieldByName('FgBValue').AsFloat;
      pSCI.Next;
    until (pSCI.Eof) or (pSCI.FieldByName('DocNum').AsString<>pSCH.FieldByName('DocNum').AsString);
  end;
  pSCI.RestoreIndex;
  // Spocitame vykonane servisne prace
  pSCS.SwapIndex;
  pSCS.IndexName:='DocNum';
  If pSCS.FindKey ([pSCH.FieldByname('DocNum').AsString]) then begin
    Repeat
      If pSCS.FieldByName('GrtType').AsString='Z' then begin
        Inc(mGgsQnt);
        mFgGrtVal:=mFgGrtVal+pSCS.FieldByName('FgBValue').AsFloat;
      end
      else Inc(mAgsQnt);
      mAcAValue:=mAcAValue+pSCS.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pSCS.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pSCS.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pSCS.FieldByName('FgDscVal').AsFloat;
      mFgAValue.Add (pSCS.FieldByName('VatPrc').AsInteger,pSCS.FieldByName('FgAValue').AsFloat);
      mFgBValue.Add (pSCS.FieldByName('VatPrc').AsInteger,pSCS.FieldByName('FgBValue').AsFloat);
      mFgWValue:=mFgWValue+pSCS.FieldByName('FgBValue').AsFloat;
      pSCS.Next;
    until (pSCS.Eof) or (pSCS.FieldByName('DocNum').AsString<>pSCH.FieldByName('DocNum').AsString);
  end;
  pSCS.RestoreIndex;
  // Ulozime vypSCItane hodnoty do hlavicky objednavky
  pSCH.Edit;
  If IsNotNul (mFgDValue) then pSCH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/mFgDValue)*100);
  pSCH.FieldByName('AcCValue').AsFloat:=Rd2(mAcCValue);
  pSCH.FieldByName('AcAValue').AsFloat:=Rd2(mAcAValue);
  pSCH.FieldByName('AcVatVal').AsFloat:=Rd2(mAcBValue-mAcAValue);
  pSCH.FieldByName('AcBValue').AsFloat:=Rd2(mAcBValue);
  pSCH.FieldByName('FgDValue').AsFloat:=Rd2(mFgDValue);
  pSCH.FieldByName('FgDscVal').AsFloat:=Rd2(mFgDscVal);
  pSCH.FieldByName('FgAValue').AsFloat:=Rd2(mFgAValue.Value[0]);
  pSCH.FieldByName('FgVatVal').AsFloat:=Rd2(mFgBValue.Value[0]-mFgAValue.Value[0]);
  pSCH.FieldByName('FgBValue').AsFloat:=Rd2(mFgBValue.Value[0]);
  pSCH.FieldByName('FgAValue1').AsFloat:=Rd2(mFgAValue.Value[1]);
  pSCH.FieldByName('FgAValue2').AsFloat:=Rd2(mFgAValue.Value[2]);
  pSCH.FieldByName('FgAValue3').AsFloat:=Rd2(mFgAValue.Value[3]);
  pSCH.FieldByName('FgBValue1').AsFloat:=Rd2(mFgBValue.Value[1]);
  pSCH.FieldByName('FgBValue2').AsFloat:=Rd2(mFgBValue.Value[2]);
  pSCH.FieldByName('FgBValue3').AsFloat:=Rd2(mFgBValue.Value[3]);
  pSCH.FieldByName('FgMValue').AsFloat:=Rd2(mFgMValue);
  pSCH.FieldByName('FgWValue').AsFloat:=Rd2(mFgWValue);
  pSCH.FieldByName('FgGrtVal').AsFloat:=Rd2(mFgGrtVal);
  pSCH.FieldByName('FgAftVal').AsFloat:=Rd2(mFgBValue.Value[0]-mFgGrtVal);
  pSCH.FieldByName('FgEndVal').AsFloat:=Rd2(pSCH.FieldByName('FgAftVal').AsFloat-pSCH.FieldByName('FgPValue').AsFloat);
  pSCH.FieldByName('AgiQnt').AsInteger:=mAgiQnt;
  pSCH.FieldByName('GgiQnt').AsInteger:=mGgiQnt;
  pSCH.FieldByName('AgsQnt').AsInteger:=mAgsQnt;
  pSCH.FieldByName('GgsQnt').AsInteger:=mGgsQnt;
  pSCH.Post;
  FreeAndNil (mFgAValue);
  FreeAndNil (mFgBValue);
end;

procedure AlhRecalc (pALH,pALI:TNexBtrTable);  //PrepSCIta hlavicku zadanej zakazky podla jej poloziek
var mAsAValue,mAsBValue:double;
    mAValue,mBValue:double;
    mItmQnt:longint;
    mDayQnt:longint;
begin
  mItmQnt:=0;
  mAsAValue:=0;  mAsBValue:=0; mAValue:=0;  mBValue:=0;
  // Spocitame pouzity material
  pALI.SwapIndex;
  pALI.IndexName:='DocNum';
  If pALI.FindKey ([pALH.FieldByname('DocNum').AsString]) then begin
    Repeat
      Inc(mItmQnt);
      mAValue  :=mAValue+(pALI.FieldByName('APrice').AsFloat*pALI.FieldByName('GsQnt').AsFloat);
      mBValue  :=mBValue+(pALI.FieldByName('BPrice').AsFloat*pALI.FieldByName('GsQnt').AsFloat);
      mAsAValue:=mAsAValue+pALI.FieldByName('AsAPrice').AsFloat*pALI.FieldByName('GsQnt').AsFloat;
      mAsBValue:=mAsBValue+pALI.FieldByName('AsBPrice').AsFloat*pALI.FieldByName('GsQnt').AsFloat;
      pALI.Next;
    until (pALI.Eof) or (pALI.FieldByName('DocNum').AsString<>pALH.FieldByName('DocNum').AsString);
  end;
  pALI.RestoreIndex;
  // Ulozime vypSCItane hodnoty do hlavicky objednavky
  mDayQnt:= Trunc(dmSTK.btALH.FieldByName ('RetDate').AsDateTime)-Trunc(dmSTK.btALH.FieldByName ('DocDate').AsDateTime)+1;
  pALH.Edit;
  pALH.FieldByName('AsAValue').AsFloat:=Rd2(mAsAValue);
  pALH.FieldByName('AsBValue').AsFloat:=Rd2(mAsBValue);
  pALH.FieldByName('AValue').AsFloat  :=Rd2(mAValue);
  pALH.FieldByName('BValue').AsFloat  :=Rd2(mBValue);
  pALH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pALH.Post;
end;

procedure IshRecalc (pISH,pISI:TNexBtrTable);  //Prepocita hlavicku zadanej faktury podla jej poloziek
var mItmQnt:longint;   mDstPair:Str1;  mTsdNum:Str15;   I:byte;
    mAcDValue,mAcDscVal,mAcAValue,mAcBValue,mEyCrdVal,mCctVal:double;
    mFgDValue,mFgDscVal:double;   mCrdValCalc:TIsdCrdValCalc;
    mAcCValue,mAcEValue,mFgCValue,mFgEValue:TValue8;
    mRAcCValue,mRAcEValue,mRFgCValue,mRFgEValue:TValue8;
begin
  mItmQnt:=0;    mTsdNum:='';   mEyCrdVal:=0;  mCctVal:=0;
  mAcDValue:=0;  mAcDscVal:=0;  mAcAValue:=0;  mAcBValue:=0;
  mFgDValue:=0;  mFgDscVal:=0;
  mAcCValue:=TValue8.Create;  mAcCValue.Clear;
  mAcEValue:=TValue8.Create;  mAcEValue.Clear;
  mFgCValue:=TValue8.Create;  mFgCValue.Clear;
  mFgEValue:=TValue8.Create;  mFgEValue.Clear;
  mRAcCValue:= TValue8.Create;  mRAcCValue.Clear;
  mRAcEValue:= TValue8.Create;  mRAcEValue.Clear;
  mRFgCValue:= TValue8.Create;  mRFgCValue.Clear;
  mRFgEValue:= TValue8.Create;  mRFgEValue.Clear;
  For I:=1 to 5 do begin
    mAcCValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mAcEValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgCValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mFgEValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mRAcCValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mRAcEValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mRFgCValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    mRFgEValue.VatPrc[I]:=pISH.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
  end;
  pISI.SwapIndex;
  pISI.IndexName:='DocNum';
  mDstPair:='N';
  If pISI.FindKey ([pISH.FieldByName('DocNum').AsString]) then begin
    mDstPair:='Q';
    Repeat
      Inc (mItmQnt);
      mAcDValue:=mAcDValue+pISI.FieldByName('AcDValue').AsFloat;
      mAcDscVal:=mAcDscVal+pISI.FieldByName('AcDscVal').AsFloat;
      mAcAValue:=mAcAValue+pISI.FieldByName('AcAValue').AsFloat;
      mAcBValue:=mAcBValue+pISI.FieldByName('AcBValue').AsFloat;
      mFgDValue:=mFgDValue+pISI.FieldByName('FgDValue').AsFloat;
      mFgDscVal:=mFgDscVal+pISI.FieldByName('FgDscVal').AsFloat;
      If pISI.FieldByName('CctVat').AsInteger=1 then mCctVal:=mCctVal+pISI.FieldByName('FgEValue').AsFloat;
      If pISI.FieldByName('GsCode').AsInteger=90100 then begin
        mRAcCValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('AcCValue').AsFloat);
        mRAcEValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('AcEValue').AsFloat);
        mRFgCValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('FgCValue').AsFloat);
        mRFgEValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('FgEValue').AsFloat);
      end else begin
        mAcCValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('AcCValue').AsFloat);
        mAcEValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('AcEValue').AsFloat);
        mFgCValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('FgCValue').AsFloat);
        mFgEValue.Add (pISI.FieldByName('VatPrc').AsInteger,pISI.FieldByName('FgEValue').AsFloat);
      end;
      If (pISI.FieldByName('MgCode').AsInteger<gIni.GetServiceMg) and ((pISI.FieldByName('Status').AsString='N') or (pISI.FieldByName('Status').AsString='')) then mDstPair:='N';
      If mTsdNum='' then mTsdNum:=pISI.FieldByName('TsdNum').AsString;
      pISI.Next;
    until (pISI.Eof) or (pISI.FieldByName('DocNum').AsString<>pISH.FieldByName('DocNum').AsString);
  end;
  pISI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  pISH.Edit;
  If pISH.FieldByName('FgCourse').AsFloat=1 then begin
    If IsNotNul (mAcDValue)
      then pISH.FieldByName('DscPrc').AsFloat:=Rd2 ((mAcDscVal/(mAcDValue))*100)
      else pISH.FieldByName('DscPrc').AsFloat:=0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then pISH.FieldByName('DscPrc').AsFloat:=Rd2 ((mFgDscVal/(mFgDValue))*100)
      else pISH.FieldByName('DscPrc').AsFloat:=0;
  end;
  DocClcRnd(mAcCValue,mAcEValue,mFgCValue,mFgEValue,IsNotNul(pISH.FieldByName('VatDoc').AsInteger));
  pISH.FieldByName('CctVal').AsFloat:=mCctVal;
  pISH.FieldByName('AcDValue').AsFloat:=mAcDValue;
  pISH.FieldByName('AcDscVal').AsFloat:=mAcDscVal;
  pISH.FieldByName('AcAValue').AsFloat:=mAcAValue;
  pISH.FieldByName('AcBValue').AsFloat:=mAcBValue;
  pISH.FieldByName('AcCValue').AsFloat:=mAcCValue.Value[0]+mRAcCValue.Value[0];
  pISH.FieldByName('AcVatVal').AsFloat:=mAcEValue.Value[0]-mAcCValue.Value[0]+mRAcEValue.Value[0]-mRAcCValue.Value[0];
  pISH.FieldByName('AcEValue').AsFloat:=mAcEValue.Value[0]+mRAcEValue.Value[0];
  pISH.FieldByName('AcCValue1').AsFloat:=mAcCValue.Value[1]+mRAcCValue.Value[1];
  pISH.FieldByName('AcCValue2').AsFloat:=mAcCValue.Value[2]+mRAcCValue.Value[2];
  pISH.FieldByName('AcCValue3').AsFloat:=mAcCValue.Value[3]+mRAcCValue.Value[3];
  pISH.FieldByName('AcCValue4').AsFloat:=mAcCValue.Value[4]+mRAcCValue.Value[4];
  pISH.FieldByName('AcCValue5').AsFloat:=mAcCValue.Value[5]+mRAcCValue.Value[5];

  pISH.FieldByName('AcEValue1').AsFloat:=mAcEValue.Value[1]+mRAcEValue.Value[1];
  pISH.FieldByName('AcEValue2').AsFloat:=mAcEValue.Value[2]+mRAcEValue.Value[2];
  pISH.FieldByName('AcEValue3').AsFloat:=mAcEValue.Value[3]+mRAcEValue.Value[3];
  pISH.FieldByName('AcEValue4').AsFloat:=mAcEValue.Value[4]+mRAcEValue.Value[4];
  pISH.FieldByName('AcEValue5').AsFloat:=mAcEValue.Value[5]+mRAcEValue.Value[5];

  pISH.FieldByName('AcEndVal').AsFloat:=pISH.FieldByName('AcEValue').AsFloat-pISH.FieldByName('EyCrdVal').AsFloat-pISH.FieldByName('AcPayVal').AsFloat;
  pISH.FieldByName('FgDValue').AsFloat:=mFgDValue;
  pISH.FieldByName('FgDscVal').AsFloat:=mFgDscVal;
  pISH.FieldByName('FgCValue').AsFloat :=mFgCValue.Value[0]+mRFgCValue.Value[0];
  pISH.FieldByName('FgVatVal').AsFloat :=mFgEValue.Value[0]-mFgCValue.Value[0]+mRFgEValue.Value[0]-mRFgCValue.Value[0];;
  pISH.FieldByName('FgEValue').AsFloat :=mFgEValue.Value[0]+mRFgEValue.Value[0];
  pISH.FieldByName('FgCValue1').AsFloat:=mFgCValue.Value[1]+mRFgCValue.Value[1];
  pISH.FieldByName('FgCValue2').AsFloat:=mFgCValue.Value[2]+mRFgCValue.Value[2];
  pISH.FieldByName('FgCValue3').AsFloat:=mFgCValue.Value[3]+mRFgCValue.Value[3];
  pISH.FieldByName('FgCValue4').AsFloat:=mFgCValue.Value[4]+mRFgCValue.Value[4];
  pISH.FieldByName('FgCValue5').AsFloat:=mFgCValue.Value[5]+mRFgCValue.Value[5];

  pISH.FieldByName('FgEValue1').AsFloat:=mFgEValue.Value[1]+mRFgEValue.Value[1];
  pISH.FieldByName('FgEValue2').AsFloat:=mFgEValue.Value[2]+mRFgEValue.Value[2];
  pISH.FieldByName('FgEValue3').AsFloat:=mFgEValue.Value[3]+mRFgEValue.Value[3];
  pISH.FieldByName('FgEValue4').AsFloat:=mFgEValue.Value[4]+mRFgEValue.Value[4];
  pISH.FieldByName('FgEValue5').AsFloat:=mFgEValue.Value[5]+mRFgEValue.Value[5];

  pISH.FieldByName('FgEndVal').AsFloat:=pISH.FieldByName('FgEValue').AsFloat-pISH.FieldByName('FgPayVal').AsFloat;
  pISH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  pISH.FieldByName('DstAcc').AsString:=GetDstAcc(pISH.FieldByName('DocNum').AsString);
  pISH.FieldByName('DstPair').AsString:=mDstPair;
  pISH.FieldByName('TsdNum').AsString:=mTsdNum;
  pISH.Post;
  FreeAndNil (mAcCValue);    FreeAndNil (mFgCValue);
  FreeAndNil (mAcEValue);    FreeAndNil (mFgEValue);
  FreeAndNil (mRAcCValue);   FreeAndNil (mRFgCValue);
  FreeAndNil (mRAcEValue);   FreeAndNil (mRFgEValue);
end;

procedure TchStatRefresh (pDocNum:Str12);  // Obnovy stav hlavicky ODL podla poloziek
var mItmQnt,mCntOut,mCntExp:longint; mDstPair:Str1;
begin
  mItmQnt:=0;  mCntOut:=0;   mCntExp:=0;
  dmSTK.btTCI.SwapIndex;
  dmSTK.btTCI.IndexName:='DocNum';
  mDstPair:='N';
  If dmSTK.btTCI.FindKey ([pDocNum]) then begin
    mDstPair:='Q';
    Repeat
      Inc (mItmQnt);
      If (dmSTK.btTCI.FieldByName('StkStat').AsString='S') or (dmSTK.btTCI.FieldByName('StkStat').AsString='C') or (dmSTK.btTCI.FieldByName('StkStat').AsString='E') then Inc (mCntOut);
      If (dmSTK.btTCI.FieldByName('StkStat').AsString='E') then Inc (mCntExp);
      If (dmSTK.btTCI.FieldByName('FinStat').AsString='') then mDstPair:='N';
      dmSTK.btTCI.Next;
    until (dmSTK.btTCI.Eof) or (dmSTK.btTCI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  dmSTK.btTCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  dmSTK.btTCH.Edit;
  dmSTK.btTCH.FieldByName('ItmQnt').AsInteger:=mItmQnt;
  dmSTK.btTCH.FieldByName('CntOut').AsInteger:=mCntOut;
  dmSTK.btTCH.FieldByName('CntExp').AsInteger:=mCntExp;
  dmSTK.btTCH.FieldByName('DstPair').AsString:=mDstPair;
  dmSTK.btTCH.Post;
end;

procedure TchNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadaneho dodacieho listu
begin
  dmSTK.btTCN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btTCN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btTCN.Delete;
    until (dmSTK.btTCN.Eof) or (dmSTK.btTCN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure TciUnPair (pDocNum:Str12;pItmNum:word); // Odparuje zadanu polozku dodacieho listy
var mMyOp:boolean;  mBookNum:Str5;
begin
  mBookNum:=BookNumFromDocNum(pDocNum);
  If mBookNum<>'' then begin
    mMyOp:=not dmSTK.btTCI.Active or (dmSTK.btTCH.BookNum<>mBookNum);
    If mMyOp then begin
      dmSTK.OpenBook (dmSTK.btTCH,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
      dmSTK.OpenBook (dmSTK.btTCI,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    end;
    dmSTK.btTCI.IndexName:='DoIt';
    If dmSTK.btTCI.FindKey ([pDocNum,pItmNum]) then begin
      dmSTK.btTCI.Edit;
      dmSTK.btTCI.FieldByName ('IcdNum').AsString:='';
      dmSTK.btTCI.FieldByName ('IcdItm').AsInteger:=0;
      dmSTK.btTCI.FieldByName ('IcdDate').AsDateTime:=0;
      dmSTK.btTCI.FieldByName ('FinStat').AsString:='';
      dmSTK.btTCI.Post;
      // Oznacime hlavicku ze doklad nie je vyparovany
      If dmSTK.btTCH.IndexName<>'DocNum' then dmSTK.btTCH.IndexName:='DocNum';
      If dmSTK.btTCH.FindKey ([pDocNum]) then begin
        dmSTK.btTCH.Edit;
        dmSTK.btTCH.FieldByName ('DstPair').AsString:='N';
        dmSTK.btTCH.Post;
      end;
    end;
    If mMyOp then begin
      dmSTK.btTCI.Close;
      dmSTK.btTCH.Close;
    end;
  end;
end;

//******************** DODAVATELSKE DODACIE LISTY *******************

function GenTsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DD'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenToDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Terminalovy vydaj
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='TO'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenTiDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Terminalovy Prijem
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='TI'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenWaDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='WA'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenReDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Precenovaci doklad
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DC'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenPrDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='PR'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenCrDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12;
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='CR'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenXrDocNum (pYear:Str2; pSerNum:longint): Str12;
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  Result:='XR'+pYear+'000'+StrIntZero(pSerNum,5);
end;

function TsiFreeItmNum (pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  dmSTK.btTSI.SwapStatus;
  If dmSTK.btTSI.IndexName<>'DoIt' then dmSTK.btTSI.IndexName:='DoIt';
  If dmSTK.btTSI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<dmSTK.btTSI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>dmSTK.btTSI.FieldByName('ItmNum').AsInteger) then mItmNum:=dmSTK.btTSI.FieldByName('ItmNum').AsInteger;
      dmSTK.btTSI.Next;
    until (dmSTK.btTSI.Eof) or mFind or (dmSTK.btTSI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind
      then Result:=mItmNum
      else Result:=mItmNum+1;
  end
  else Result:=1;
  dmSTK.btTSI.RestoreStatus;
end;

function TsiNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
begin
  If dmSTK.btTSI.IndexName<>'DoIt' then dmSTK.btTSI.IndexName:='DoIt';
  If not dmSTK.btTSI.FindNearest([pDocNum,65000]) then dmSTK.btTSI.Last;
  If not dmSTK.btTSI.IsLastRec or (dmSTK.btTSI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btTSI.Prior;
  If dmSTK.btTSI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btTSI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function SciNextItmNum (pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
begin
  If dmSTK.btSCI.IndexName<>'DoIt' then dmSTK.btSCI.IndexName:='DoIt';
  If not dmSTK.btSCI.FindNearest([pDocNum,65000]) then dmSTK.btSCI.Last;
  If not dmSTK.btSCI.IsLastRec or (dmSTK.btSCI.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btSCI.Prior;
  If dmSTK.btSCI.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btSCI.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

function ScsNextItmNum (pDocNum:Str12;pCsType:Str1): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
begin
  If dmSTK.btSCS.IndexName<>'DoCsIt' then dmSTK.btSCS.IndexName:='DoCsIt';
  If not dmSTK.btSCS.FindNearest([pDocNum,pCsType,65000]) then dmSTK.btSCS.Last;
  If not dmSTK.btSCS.IsLastRec or (dmSTK.btSCS.FieldByName('DocNum').AsString<>pDocNum) then dmSTK.btSCS.Prior;
  If dmSTK.btSCS.FieldByName('DocNum').AsString=pDocNum
    then Result:=dmSTK.btSCS.FieldByName('ItmNum').AsInteger+1
    else Result:=1;
end;

procedure TsiUnPair (pDocNum:Str12;pItmNum:word); // Odparuje zadanu polozku dodacieho listy
var mMyOp:boolean;  mBookNum:Str5;
begin
  If pDocNum<>'' then begin
    mBookNum:=BookNumFromDocNum(pDocNum);
    mMyOp:=not dmSTK.btTSI.Active or (dmSTK.btTSH.BookNum<>mBookNum);
    If mMyOp then begin
      dmSTK.OpenBook (dmSTK.btTSH,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
      dmSTK.OpenBook (dmSTK.btTSI,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    end;
    dmSTK.btTSI.IndexName:='DoIt';
    If dmSTK.btTSI.FindKey ([pDocNum,pItmNum]) then begin
      dmSTK.btTSI.Edit;
      dmSTK.btTSI.FieldByName ('IsdNum').AsString:='';
      dmSTK.btTSI.FieldByName ('IsdItm').AsInteger:=0;
      dmSTK.btTSI.FieldByName ('IsdDate').AsDateTime:=0;
      dmSTK.btTSI.FieldByName ('FinStat').AsString:='';
      dmSTK.btTSI.Post;
      // Oznacime hlavicku ze doklad nie je vyparovany
      If dmSTK.btTSH.IndexName<>'DocNum' then dmSTK.btTSH.IndexName:='DocNum';
      If dmSTK.btTSH.FindKey ([pDocNum]) then begin
        dmSTK.btTSH.Edit;
        dmSTK.btTSH.FieldByName ('DstPair').AsString:='N';
        dmSTK.btTSH.Post;
      end;
    end;
    If mMyOp then begin
      dmSTK.btTSI.Close;
      dmSTK.btTSH.Close;
    end;
  end;
end;

procedure TshNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadaneho dodacieho listu
begin
  dmSTK.btTSN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btTSN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btTSN.Delete;
    until (dmSTK.btTSN.Eof) or (dmSTK.btTSN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

// ********************* ODBERATELSKE FAKTURY *********************
function NoPayIcdOneBook (pBookNum:Str5; pPaCode:longint):double;  //Hodnota neuhradenych faktur zadanaho partnera zo zadanej knihy
var mtICH: TBtrieveTable;
begin
  Result:=0;
  mtICH:=TBtrieveTable.Create (dmLDG);
  mtICH.DataBaseName:=gPath.LdgPath;
  mtICH.TableName:='ICH'+pBookNum;
  mtICH.DefPath:=gPath.DefPath;
  mtICH.DefName:='ICH.BDF';
  mtICH.AutoCreate:=TRUE;
  mtICH.Open;
  mtICH.IndexName:='PaDp';
  If mtICH.FindKey ([pPaCode,0]) then begin
    Repeat
      Result:=Result+mtICH.FieldByName('AcEndVal').AsFloat;
      mtICH.Next;
    until (mtICH.Eof) or (mtICH.FieldByName('PaCode').AsInteger<>pPaCode) or (mtICH.FieldByName('DstPay').AsInteger<>0);
  end;
  FreeAndNil (mtICH)
end;

function NoPayIcdAllBook (pPaCode:longint):double;  //Hodnota neuhradenych faktur zadanaho partnera zo vsetkuch knih
var otBOKLST:TBoklstTmp;
begin
  Result:=0;
  otBOKLST:=TBoklstTmp.Create; otBOKLST.Open;
  otBOKLST.LoadToTmp('ICB');
  If otBOKLST.Count>0 then begin
    otBOKLST.First;
    Repeat
      Result:=Result+NoPayIcdOneBook (otBOKLST.BokNum,pPaCode); // Hladame len v zadanej knihe
      otBOKLST.Next;
    until (otBOKLST.Eof);
  end;
  otBOKLST.Close;FreeAndNil(otBOKLST);
end;

// ****************** ODBERATELSKE ZALOHOVE FAKTURY ****************
function NextSerNumBtr(pTable:TNexBtrTable): longint; // Funkcia vrati nasledujuce volne poradove cislo cestovneho prikazku
begin
  pTable.Refresh;
  pTable.SwapStatus;
  If pTable.IndexName<>'SerNum' then pTable.IndexName:='SerNum';
  pTable.Last;
  Result:=pTable.FieldByName ('SerNum').AsInteger+1;
  pTable.RestoreStatus;
end;

function IciFreeItmNum (pICI:TNexBtrTable; pDocNum:Str12): longint; // Funkcia vrati vynechane poradove cislo polozky zadaneho dokladu
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  If pICI.IndexName<>'DoIt' then pICI.IndexName:='DoIt';
  If pICI.FindKey([pDocNum,1]) then begin
    mItmNum:=0;
    Repeat
      Inc (mItmNum);
      mFind:=(mItmNum<pICI.FieldByName('ItmNum').AsInteger);
      If (mItmNum>pICI.FieldByName('ItmNum').AsInteger) then mItmNum:=pICI.FieldByName('ItmNum').AsInteger;
      pICI.Next;
    until (pICI.Eof) or mFind or (pICI.FieldByName('DocNum').AsString<>pDocNum);
    If mFind then Result:=mItmNum;
  end;
end;

function IciNextItmNum (pICI:TNexBtrTable;pDocNum:Str12): longint; // Funkcia vrati nasledujuce volne poradove cislo polozky ODL
begin
  If pICI.IndexName<>'DoIt' then pICI.IndexName:='DoIt';
  pICI.Last;
  If pICI.FieldByName('DocNum').AsString<>pDocNum then begin
    pICI.FindNearest([pDocNum,65000]);
    If not pICI.IsLastRec or (pICI.FieldByName('DocNum').AsString<>pDocNum) then pICI.Prior;
    If pICI.FieldByName('DocNum').AsString=pDocNum
      then Result:=pICI.FieldByName('ItmNum').AsInteger+1
      else Result:=1;
   end
   else Result:=pICI.FieldByName('ItmNum').AsInteger+1;
end;

function GenOsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='OB'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenIcDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='OF'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenScDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='SZ'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenClDocNum (pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  Result:='ZR'+pBookNum+StrIntZero(pSerNum,5);
end;

function GenIsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DF'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenIpDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DE'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenKsDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='KD'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenOwDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='SC'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenEoDocNum (pYear:Str2; pCntNum,pSerNum:longint): Str12; // Odoslane spravy
begin
  Result:='EO'+pYear+StrIntZero(pCntNum,3)+StrIntZero(pSerNum,5);
end;

function GenEpDocNum (pYear:Str2; pCntNum,pSerNum:longint): Str12; // Cislo dokladu prijatej spravy
begin
  Result:='EP'+pYear+StrIntZero(pCntNum,3)+StrIntZero(pSerNum,5);
end;

function IchPayValRecalc (var pIchTable:TNexBtrTable):boolean; // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA - hodnota funkcie je TRUE ak bol zisteny nejaky rozdiel
var mPay:TPayFnc;
begin
  mPay:=TPayFnc.Create;
  mPay.ClcInvPay(pIchTable.FieldByName('DocNum').AsString);
  FreeAndNil(mPay);
end;

procedure IchNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej faktury
begin
  dmLDG.btICN.FindNearest ([pDocNum,'',0]);
  If dmLDG.btICN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmLDG.btICN.Delete;
    until (dmLDG.btICN.Eof) or (dmLDG.btICN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure SchNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej faktury
begin
  dmSTK.btSCN.FindNearest ([pDocNum,'',0]);
  If dmSTK.btSCN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btSCN.Delete;
    until (dmSTK.btSCN.Eof) or (dmSTK.btSCN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure IshNoticeDelete (pDocNum:Str12); //Vymaze poznamky zadanej DF
begin
  dmLDG.btISN.FindNearest ([pDocNum,'',0]);
  If dmLDG.btISN.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      dmLDG.btISN.Delete;
    until (dmLDG.btISN.Eof) or (dmLDG.btISN.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure IciUnPair (pDocNum:Str12;pItmNum:word); // Odparuje zadanu polozku OF
var mMyOpIch,mMyOpIci:boolean;  mBookNum:Str5;
begin
  If pDocNum<>'' then begin
    mBookNum:=BookNumFromDocNum(pDocNum);
    mMyOpIch:=not dmLDG.btICH.Active or (dmLDG.btICH.BookNum<>mBookNum);
    mMyOpIci:=not dmLDG.btICI.Active or (dmLDG.btICI.BookNum<>mBookNum);
    If mMyOpIch then dmLDG.OpenBook (dmLDG.btICH,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    If mMyOpIci then dmLDG.OpenBook (dmLDG.btICI,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    dmLDG.btICI.IndexName:='DoIt';
    If dmLDG.btICI.FindKey ([pDocNum,pItmNum]) then begin
      dmLDG.btICI.Edit;
      dmLDG.btICI.FieldByName ('TcdNum').AsString:='';
      dmLDG.btICI.FieldByName ('TcdItm').AsInteger:=0;
      dmLDG.btICI.FieldByName ('TcdDate').AsDateTime:=0;
      dmLDG.btICI.FieldByName ('Status').AsString:='';
      dmLDG.btICI.Post;
      // Oznacime hlavicku ze doklad nie je vyparovany
      If dmLDG.btICH.IndexName<>'DocNum' then dmLDG.btICH.IndexName:='DocNum';
      If dmLDG.btICH.FindKey ([pDocNum]) then begin
        dmLDG.btICH.Edit;
        dmLDG.btICH.FieldByName ('DstPair').AsString:='N';
        dmLDG.btICH.Post;
      end;
    end;
    If mMyOpIci then dmLDG.btICI.Close;
    If mMyOpIch then dmLDG.btICH.Close;
  end;
end;

// ********************* Dodavatelske faktury ********************

function IshPayValRecalc (var pIshTable:TNexBtrTable):boolean; // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA - hodnota funkcie je TRUE ak bol zisteny nejaky rozdiel
var mPay:TPayFnc;
begin
  mPay:=TPayFnc.Create;
  mPay.ClcInvPay(pIshTable.FieldByName('DocNum').AsString);
  FreeAndNil(mPay);
end;

// ****************** Vyuctovanie sluzobnej cesty ******************

procedure LoadDocFromJrn (pDocNum:Str12); // Nacita uctovne zapisy zadaneho dokladu do databaze ptACC
var mMyOp:boolean;
begin
  mMyOp:=not dmLDG.btJOURNAL.Active;
  If mMyOp then dmLDG.btJOURNAL.Open;
  dmLDG.btJOURNAL.SwapIndex;
  dmLDG.btJOURNAL.IndexName:='DocNum';
  If dmLDG.btJOURNAL.FindKey ([pDocNum]) then begin
    Repeat
      dmLDG.ptACC.Insert;
      dmLDG.ptACC.FieldByName ('RowNum').AsInteger:=dmLDG.ptACC.RecordCount+1;
      dmLDG.ptACC.FieldByName ('DocNum').AsString:=dmLDG.btJOURNAL.FieldByName ('DocNum').AsString;
      dmLDG.ptACC.FieldByName ('ItmNum').AsInteger:=dmLDG.btJOURNAL.FieldByName ('ItmNum').AsInteger;
      dmLDG.ptACC.FieldByName ('ExtNum').AsString:=dmLDG.btJOURNAL.FieldByName ('ExtNum').AsString;
      dmLDG.ptACC.FieldByName ('DocDate').AsDateTime:=dmLDG.btJOURNAL.FieldByName ('DocDate').AsDateTime;
      dmLDG.ptACC.FieldByName ('AccSnt').AsString:=dmLDG.btJOURNAL.FieldByName ('AccSnt').AsString;
      dmLDG.ptACC.FieldByName ('AccAnl').AsString:=dmLDG.btJOURNAL.FieldByName ('AccAnl').AsString;
      dmLDG.ptACC.FieldByName ('Describe').AsString:=dmLDG.btJOURNAL.FieldByName ('Describe').AsString;
      dmLDG.ptACC.FieldByName ('CredVal').AsFloat:=dmLDG.btJOURNAL.FieldByName ('CredVal').AsFloat;
      dmLDG.ptACC.FieldByName ('DebVal').AsFloat:=dmLDG.btJOURNAL.FieldByName ('DebVal').AsFloat;
      dmLDG.ptACC.FieldByName ('OcdNum').AsString:=dmLDG.btJOURNAL.FieldByName ('OcdNum').AsString;
      dmLDG.ptACC.FieldByName ('OceNum').AsString:=dmLDG.btJOURNAL.FieldByName ('OceNum').AsString;
      dmLDG.ptACC.FieldByName ('WriNum').AsInteger:=dmLDG.btJOURNAL.FieldByName ('WriNum').AsInteger;
      dmLDG.ptACC.FieldByName ('CentNum').AsInteger:=dmLDG.btJOURNAL.FieldByName ('CentNum').AsInteger;
      dmLDG.ptACC.Post;
      dmLDG.btJOURNAL.Next;
    until (dmLDG.btJOURNAL.Eof) or (dmLDG.btJOURNAL.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure DetermineTra (var pItmData:TItmData); // Nastavy ocbodne podmienky a vypocita cenu
var mDscAPrice:double; // Zlavnena cena globalna alebo sortimentna
    mDlrAPrice:double; // Cena podla obchodnych podmienok obch. zastupcu
    mAplAPrice:double; // Akciova cena
    mAgrAPrice:double; // Zmluvna cena
    mTraAPrice:double; // Najlepsia cena pre odberatela
    mFind:boolean;  mDscPrc:double;
begin
  // ************** Urcenie obchodnych podmienok *****************
  pItmData.DscPrc:=0;
  mAgrAPrice:=pItmData.FgAPrice;
  mTraAPrice:=pItmData.FgAPrice;
  mDlrAPrice:=pItmData.FgAPrice;
//  mOpAgritm:=not dmSTK.btAGRITM.Active;If mOpAgritm then dmSTK.btAGRITM.Open;
//  If dmSTK.btAGRITM.FindKey ([pItmData.PaCode,pItmData.GsCode]) then mAgrAPrice:=dmSTK.btAGRITM.FieldByName ('APrice').AsFloat;
  // Zlava sortimentna alebo globalna
  If dmSTK.btFGPADSC.FindKey ([pItmData.PaCode,pItmData.FgCode])
    then mDscPrc:=dmSTK.btFGPADSC.FieldByName('DscPrc').AsFloat
    else mDscPrc:=pItmData.IcDscPrc;
  mDscAPrice:=Rd2(pItmData.FgDPrice*(1-mDscPrc/100));
  // Akciova cena
  mAplAPrice:=0;
  If pItmData.DlrCode>0 then begin // Ak je zadany ocbh zastupac urcime ceny podla jeho obchodnych podmienok
    If dmDLS.btDLRDSC.IndexName<>'DcItIc' then dmDLS.btDLRDSC.IndexName:='DcItIc';
    mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'G',pItmData.GsCode]); // Najprv skusime podla tovarovych poloziek
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'M',pItmData.MgCode]); // Potom skusime podla tovarovych skupin - pre zadanu skupinu
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'M',0]); // Potom skusime podla tovarovych skupin - pre ostatne skupiny
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'F',pItmData.FgCode]); // A na konci skusime podla financnych skupin - pre zadanu skupinu
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'F',0]); // A na konci skusime podla financnych skupin - pre ostatne skupiny
    If mFind then mDlrAPrice:=Rd2(pItmData.FgDPrice*(1-dmDLS.btDLRDSC.FieldByName('DefDsc').AsFloat/100));
    // Akciovy letak pre ochhodneho zastupcu
    If pItmData.IcAplNum=0 then begin // Ak odberatel nema nasteveny akciovy letak zistime ci ma obchdofny zastupca
      If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName:='DlrCode';
      If dmDLS.btDLRLST.FindKey([pItmData.DlrCode]) then pItmData.IcAplNum:=dmDLS.btDLRLST.FieldByName('AplNum').AsInteger;
    end;
  end;
  // Urcenie akciovej ceny
  If dmSTK.btAPLITM.IndexName<>'AnGs' then dmSTK.btAPLITM.IndexName:='AnGs';
  mFind:=dmSTK.btAPLITM.FindKey ([pItmData.IcAplNum,pItmData.GsCode]); // Najprv skusime cidana firma nema vlastne akcie
//  If not mFind then mFind:=dmSTK.btAPLITM.FindKey ([0,pItmData.GsCode]); // Averime ci ne je nastavena akcia pre vsetky firmy
  If mFind then begin // Pre dany tovar je zadana akcia
    mFind:=FALSE;
    Repeat
      If InDateInterval (dmSTK.btAPLITM.FieldByName('BegDate').AsDateTime,dmSTK.btAPLITM.FieldByName('EndDate').AsDateTime,pItmData.DocDate) then begin
        mFind:=TRUE;
        If IsNul(mAplAPrice) or (dmSTK.btAPLITM.FieldByName('AcAPrice').AsFloat<mAplAPrice)
          then mAplAPrice:=dmSTK.btAPLITM.FieldByName('AcAPrice').AsFloat;
      end;
      Application.ProcessMessages;
      dmSTK.btAPLITM.Next;
    until dmSTK.btAPLITM.Eof or (dmSTK.btAPLITM.FieldByName('AplNum').AsInteger<>pItmData.IcAplNum) or (dmSTK.btAPLITM.FieldByName('GsCode').AsInteger<>pItmData.GsCode);
  end;

  // ***************************************************************
  // Zistime ktora cena je lepsia
  If mDscAPrice<mTraAPrice then mTraAPrice:=mDscAPrice;
  If mDlrAPrice<mTraAPrice then mTraAPrice:=mDlrAPrice;
  If mAgrAPrice<mTraAPrice then mTraAPrice:=mAgrAPrice;
  If IsNotNul(mAplAPrice) and (mAplAPrice<mTraAPrice) then begin
    pItmData.Action:='A';
    pItmData.DscType:='';
    mTraAPrice:=mAplAPrice;
  end;
  If IsNotNul (pItmData.FgDPrice) then mDscPrc:=(1-(mTraAPrice/pItmData.FgDPrice))*100;
  // Ak odberatel ma faktoring - pripocitame faktoringovu prirazku
  If IsNotNul (pItmData.IcFacPrc) then begin
    mDscPrc:=mDscPrc-pItmData.IcFacPrc;
    mTraAPrice:=Rd2(pItmData.FgDPrice*(1-mDscPrc/100));
  end
  else begin
    // Zlava na skorsiu uhradu
    // If IsNotNul (E_DscPrc.Value) then E_DscPrc.Value:=E_DscPrc.Value-gIni.DepDscPrc;
    // pre SOLIDSTAV
  end;
  If not Eq2 (pItmData.FgAPrice,mTraAPrice) then begin // Ak bola najdena obchodna podmienka co ma vplyv na cenu
    pItmData.DscPrc:=mDscPrc;
    pItmData.DscType:='BSDSC';
    pItmData.FgAPrice:=mTraAPrice; // Cena ktora vychadza na zaklade obchodnych podmienok
    pItmData.FgAValue:=mTraAPrice*pItmData.GsQnt;
    CalcFromAValue(pItmData);
  end;
//  If mOpAgritm then dmSTK.btAGRITM.Close;
end;

procedure CalcAcValues (var pItmData:TItmData); // Vypocita hodnoty v uctovnej mene
begin
  pItmData.AcBValue:=ClcAcFromFgC(pItmData.FgBValue,pItmData.FgCourse);
  pItmData.AcAValue:=ClcAcFromFgC(pItmData.FgAValue,pItmData.FgCourse);
end;

procedure CalcFromAValue (var pItmData:TItmData); // Spatny prepocet hodnot podla hodnoty s DPH po zlave
begin
  If IsNul(pItmData.GsQnt) then pItmData.GsQnt:=1;
  If IsNotNul (pItmData.GsQnt) then pItmData.FgAPrice:=Roundx(pItmData.FgAValue/pItmData.GsQnt,pItmData.FgFract);
  pItmData.FgBValue:=Rd2(pItmData.FgAValue*(1+pItmData.VatPrc/100));
  If IsNotNul (pItmData.GsQnt) then pItmData.FgBPrice:=Roundx(pItmData.FgBValue/pItmData.GsQnt,pItmData.FgFract);
  If gvSys.ModToDsc or IsNotNul(pItmData.DscPrc) then begin
    pItmData.FgDValue:=Rd2(pItmData.FgDPrice*pItmData.GsQnt);
    pItmData.FgHValue:=Rd2(pItmData.FgDValue*(1+pItmData.VatPrc/100));
    If IsNotNul (pItmData.FgDValue) then pItmData.DscPrc:=(1-(pItmData.FgAValue/pItmData.FgDValue))*100;
  end
  else begin
    pItmData.FgDValue:=pItmData.FgAValue;
    pItmData.FgHValue:=pItmData.FgBValue;
    pItmData.FgDPrice:=pItmData.FgAPrice;
    pItmData.FgHPrice:=pItmData.FgBPrice;
  end;
  CalcAcValues(pItmData); // Vypocita hodnoty v uctovnej mene
end;

procedure CalcFromBValue (var pItmData:TItmData); // Spatny prepocet hodnot podla hodnoty s DPH po zlave
begin
  If IsNul(pItmData.GsQnt) then pItmData.GsQnt:=1;
  pItmData.FgAValue:=Rd2(pItmData.FgBValue/(1+pItmData.VatPrc/100));
  If IsNotNul (pItmData.GsQnt) then begin
    pItmData.FgBPrice:=Roundx(pItmData.FgBValue/pItmData.GsQnt,pItmData.FgFract);
    pItmData.FgAPrice:=Roundx(pItmData.FgAValue/pItmData.GsQnt,pItmData.FgFract);
  end;
  If gvSys.ModToDsc or IsNotNul(pItmData.DscPrc) then begin
    pItmData.FgDValue:=Rd2(pItmData.FgDPrice*pItmData.GsQnt);
    pItmData.FgHValue:=Rd2(pItmData.FgDValue*(1+pItmData.VatPrc/100));
    If IsNotNul (pItmData.FgDValue) then pItmData.DscPrc:=(1-(pItmData.FgAValue/pItmData.FgDValue))*100;
  end
  else begin
    pItmData.FgDValue:=pItmData.FgAValue;
    pItmData.FgHValue:=pItmData.FgBValue;
    pItmData.FgDPrice:=pItmData.FgAPrice;
    pItmData.FgHPrice:=pItmData.FgBPrice;
  end;
  CalcAcValues(pItmData); // Vypocita hodnoty v uctovnej mene
end;

procedure DetermineTra   (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte;pAplItm,pFgPaDsc,pDlrDsc,pDlrLst:TNexBtrTable);overload; // Nastavy ocbodne podmienky a vypocita cenu
var mDscAPrice:double; // Zlavnena cena globalna alebo sortimentna
    mDlrAPrice:double; // Cena podla obchodnych podmienok obch. zastupcu
    mAplAPrice:double; // Akciova cena
    mAgrAPrice:double; // Zmluvna cena
    mTraAPrice:double; // Najlepsia cena pre odberatela
    mFind:boolean;  mDscPrc:double;
begin
  // ************** Urcenie obchodnych podmienok *****************
  pItmData.DscPrc:=0;
  mAgrAPrice:=pItmData.FgAPrice;
  mTraAPrice:=pItmData.FgAPrice;
  mDlrAPrice:=pItmData.FgAPrice;
//  If pAGRITM.FindKey ([pItmData.PaCode,pItmData.GsCode]) then mAgrAPrice:=pAGRITM.FieldByName ('APrice').AsFloat;
  // Zlava sortimentna alebo globalna
  If pFGPADSC.FindKey ([pItmData.PaCode,pItmData.FgCode])
    then mDscPrc:=pFGPADSC.FieldByName('DscPrc').AsFloat
    else mDscPrc:=pItmData.IcDscPrc;
  mDscAPrice:=Rd(pItmData.FgDPrice*(1-mDscPrc/100),pFgpFrc,cStand);
  // Akciova cena
  mAplAPrice:=0;
  If pItmData.DlrCode>0 then begin // Ak je zadany ocbh zastupac urcime ceny podla jeho obchodnych podmienok
    If pDLRDSC.IndexName<>'DcItIc' then pDLRDSC.IndexName:='DcItIc';
    mFind:=pDLRDSC.FindKey ([pItmData.DlrCode,'G',pItmData.GsCode]); // Najprv skusime podla tovarovych poloziek
    If not mFind then mFind:=pDLRDSC.FindKey ([pItmData.DlrCode,'M',pItmData.MgCode]); // Potom skusime podla tovarovych skupin - pre zadanu skupinu
    If not mFind then mFind:=pDLRDSC.FindKey ([pItmData.DlrCode,'M',0]); // Potom skusime podla tovarovych skupin - pre ostatne skupiny
    If not mFind then mFind:=pDLRDSC.FindKey ([pItmData.DlrCode,'F',pItmData.FgCode]); // A na konci skusime podla financnych skupin - pre zadanu skupinu
    If not mFind then mFind:=pDLRDSC.FindKey ([pItmData.DlrCode,'F',0]); // A na konci skusime podla financnych skupin - pre ostatne skupiny
    If mFind then mDlrAPrice:=Rd(pItmData.FgDPrice*(1-pDLRDSC.FieldByName('DefDsc').AsFloat/100),pFgpFrc,cStand);
    // Akciovy letak pre ochhodneho zastupcu
    If pItmData.IcAplNum=0 then begin // Ak odberatel nema nasteveny akciovy letak zistime ci ma obchdofny zastupca
      If pDLRLST.IndexName<>'DlrCode' then pDLRLST.IndexName:='DlrCode';
      If pDLRLST.FindKey([pItmData.DlrCode]) then pItmData.IcAplNum:=pDLRLST.FieldByName('AplNum').AsInteger;
    end;
  end;
  // Urcenie akciovej ceny
  If pAPLITM.IndexName<>'AnGs' then pAPLITM.IndexName:='AnGs';
  mFind:=pAPLITM.FindKey ([pItmData.IcAplNum,pItmData.GsCode]); // Najprv skusime cidana firma nema vlastne akcie
//  If not mFind then mFind:=pAPLITM.FindKey ([0,pItmData.GsCode]); // Averime ci ne je nastavena akcia pre vsetky firmy
  If mFind then begin // Pre dany tovar je zadana akcia
    mFind:=FALSE;
    Repeat
      If InDateInterval (pAPLITM.FieldByName('BegDate').AsDateTime,pAPLITM.FieldByName('EndDate').AsDateTime,pItmData.DocDate) then begin
        mFind:=TRUE;
        If IsNul(mAplAPrice) or (pAPLITM.FieldByName('AcAPrice').AsFloat<mAplAPrice)
          then mAplAPrice:=pAPLITM.FieldByName('AcAPrice').AsFloat;
      end;
      Application.ProcessMessages;
      pAPLITM.Next;
    until pAPLITM.Eof or (pAPLITM.FieldByName('AplNum').AsInteger<>pItmData.IcAplNum) or (pAPLITM.FieldByName('GsCode').AsInteger<>pItmData.GsCode);
  end;

  // ***************************************************************
  // Zistime ktora cena je lepsia
  If mDscAPrice<mTraAPrice then mTraAPrice:=mDscAPrice;
  If mDlrAPrice<mTraAPrice then mTraAPrice:=mDlrAPrice;
  If mAgrAPrice<mTraAPrice then mTraAPrice:=mAgrAPrice;
  If IsNotNul(mAplAPrice) and (mAplAPrice<mTraAPrice) then begin
    pItmData.Action:='A';
    pItmData.DscType:='';
    mTraAPrice:=mAplAPrice;
  end;
  If IsNotNul (pItmData.FgDPrice) then mDscPrc:=(1-(mTraAPrice/pItmData.FgDPrice))*100;
  // Ak odberatel ma faktoring - pripocitame faktoringovu prirazku
  If IsNotNul (pItmData.IcFacPrc) then begin
    mDscPrc:=mDscPrc-pItmData.IcFacPrc;
    mTraAPrice:=Rd(pItmData.FgDPrice*(1-mDscPrc/100),pFgpFrc,cStand);
  end
  else begin
    // Zlava na skorsiu uhradu
    // If IsNotNul (E_DscPrc.Value) then E_DscPrc.Value:=E_DscPrc.Value-gIni.DepDscPrc;
    // pre SOLIDSTAV
  end;
  If not Eq2 (pItmData.FgAPrice,mTraAPrice) then begin // Ak bola najdena obchodna podmienka co ma vplyv na cenu
    pItmData.DscPrc:=mDscPrc;
    pItmData.DscType:='BSDSC';
    pItmData.FgAPrice:=mTraAPrice; // Cena ktora vychadza na zaklade obchodnych podmienok
    pItmData.FgAValue:=mTraAPrice*pItmData.GsQnt;
    CalcFromAValue(pItmData,pFgpFrc,pFgVFrc);
  end;
end;

procedure DetermineTra (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Nastavy ocbodne podmienky a vypocita cenu
var mDscAPrice:double; // Zlavnena cena globalna alebo sortimentna
    mDlrAPrice:double; // Cena podla obchodnych podmienok obch. zastupcu
    mAplAPrice:double; // Akciova cena
    mAgrAPrice:double; // Zmluvna cena
    mTraAPrice:double; // Najlepsia cena pre odberatela
    mFind:boolean;  mDscPrc:double;
begin
  // ************** Urcenie obchodnych podmienok *****************
  pItmData.DscPrc:=0;
  mAgrAPrice:=pItmData.FgAPrice;
  mTraAPrice:=pItmData.FgAPrice;
  mDlrAPrice:=pItmData.FgAPrice;
//  mOpAgritm:=not dmSTK.btAGRITM.Active;If mOpAgritm then dmSTK.btAGRITM.Open;
//  If dmSTK.btAGRITM.FindKey ([pItmData.PaCode,pItmData.GsCode]) then mAgrAPrice:=dmSTK.btAGRITM.FieldByName ('APrice').AsFloat;
  // Zlava sortimentna alebo globalna
  If dmSTK.btFGPADSC.FindKey ([pItmData.PaCode,pItmData.FgCode])
    then mDscPrc:=dmSTK.btFGPADSC.FieldByName('DscPrc').AsFloat
    else mDscPrc:=pItmData.IcDscPrc;
  mDscAPrice:=Rd(pItmData.FgDPrice*(1-mDscPrc/100),pFgpFrc,cStand);
  // Akciova cena
  mAplAPrice:=0;
  If pItmData.DlrCode>0 then begin // Ak je zadany ocbh zastupac urcime ceny podla jeho obchodnych podmienok
    If dmDLS.btDLRDSC.IndexName<>'DcItIc' then dmDLS.btDLRDSC.IndexName:='DcItIc';
    mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'G',pItmData.GsCode]); // Najprv skusime podla tovarovych poloziek
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'M',pItmData.MgCode]); // Potom skusime podla tovarovych skupin - pre zadanu skupinu
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'M',0]); // Potom skusime podla tovarovych skupin - pre ostatne skupiny
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'F',pItmData.FgCode]); // A na konci skusime podla financnych skupin - pre zadanu skupinu
    If not mFind then mFind:=dmDLS.btDLRDSC.FindKey ([pItmData.DlrCode,'F',0]); // A na konci skusime podla financnych skupin - pre ostatne skupiny
    If mFind then mDlrAPrice:=Rd(pItmData.FgDPrice*(1-dmDLS.btDLRDSC.FieldByName('DefDsc').AsFloat/100),pFgpFrc,cStand);
    // Akciovy letak pre ochhodneho zastupcu
    If pItmData.IcAplNum=0 then begin // Ak odberatel nema nasteveny akciovy letak zistime ci ma obchdofny zastupca
      If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName:='DlrCode';
      If dmDLS.btDLRLST.FindKey([pItmData.DlrCode]) then pItmData.IcAplNum:=dmDLS.btDLRLST.FieldByName('AplNum').AsInteger;
    end;
  end;
  // Urcenie akciovej ceny
  If dmSTK.btAPLITM.IndexName<>'AnGs' then dmSTK.btAPLITM.IndexName:='AnGs';
  mFind:=dmSTK.btAPLITM.FindKey ([pItmData.IcAplNum,pItmData.GsCode]); // Najprv skusime cidana firma nema vlastne akcie
//  If not mFind then mFind:=dmSTK.btAPLITM.FindKey ([0,pItmData.GsCode]); // Averime ci ne je nastavena akcia pre vsetky firmy
  If mFind then begin // Pre dany tovar je zadana akcia
    mFind:=FALSE;
    Repeat
      If InDateInterval (dmSTK.btAPLITM.FieldByName('BegDate').AsDateTime,dmSTK.btAPLITM.FieldByName('EndDate').AsDateTime,pItmData.DocDate) then begin
        mFind:=TRUE;
        If IsNul(mAplAPrice) or (dmSTK.btAPLITM.FieldByName('AcAPrice').AsFloat<mAplAPrice)
          then mAplAPrice:=dmSTK.btAPLITM.FieldByName('AcAPrice').AsFloat;
      end;
      Application.ProcessMessages;
      dmSTK.btAPLITM.Next;
    until dmSTK.btAPLITM.Eof or (dmSTK.btAPLITM.FieldByName('AplNum').AsInteger<>pItmData.IcAplNum) or (dmSTK.btAPLITM.FieldByName('GsCode').AsInteger<>pItmData.GsCode);
  end;

  // ***************************************************************
  // Zistime ktora cena je lepsia
  If mDscAPrice<mTraAPrice then mTraAPrice:=mDscAPrice;
  If mDlrAPrice<mTraAPrice then mTraAPrice:=mDlrAPrice;
  If mAgrAPrice<mTraAPrice then mTraAPrice:=mAgrAPrice;
  If IsNotNul(mAplAPrice) and (mAplAPrice<mTraAPrice) then begin
    pItmData.Action:='A';
    pItmData.DscType:='';
    mTraAPrice:=mAplAPrice;
  end;
  If IsNotNul (pItmData.FgDPrice) then mDscPrc:=(1-(mTraAPrice/pItmData.FgDPrice))*100;
  // Ak odberatel ma faktoring - pripocitame faktoringovu prirazku
  If IsNotNul (pItmData.IcFacPrc) then begin
    mDscPrc:=mDscPrc-pItmData.IcFacPrc;
    mTraAPrice:=Rd(pItmData.FgDPrice*(1-mDscPrc/100),pFgpFrc,cStand);
  end
  else begin
    // Zlava na skorsiu uhradu
    // If IsNotNul (E_DscPrc.Value) then E_DscPrc.Value:=E_DscPrc.Value-gIni.DepDscPrc;
    // pre SOLIDSTAV
  end;
  If not Eq2 (pItmData.FgAPrice,mTraAPrice) then begin // Ak bola najdena obchodna podmienka co ma vplyv na cenu
    pItmData.DscPrc:=mDscPrc;
    pItmData.DscType:='BSDSC';
    pItmData.FgAPrice:=mTraAPrice; // Cena ktora vychadza na zaklade obchodnych podmienok
    pItmData.FgAValue:=mTraAPrice*pItmData.GsQnt;
    CalcFromAValue(pItmData,pFgpFrc,pFgVFrc);
  end;
//  If mOpAgritm then dmSTK.btAGRITM.Close;
end;

procedure CalcFromAValue (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave
begin
  If IsNul(pItmData.GsQnt) then pItmData.GsQnt:=1;
  If IsNotNul (pItmData.GsQnt) then pItmData.FgAPrice:=Roundx(pItmData.FgAValue/pItmData.GsQnt,pFgpFrc);
  pItmData.FgBValue:=Rd(pItmData.FgAValue*(1+pItmData.VatPrc/100),pFgvFrc,cStand);
  If IsNotNul (pItmData.GsQnt) then pItmData.FgBPrice:=Roundx(pItmData.FgBValue/pItmData.GsQnt,pFgpFrc);
  If gvSys.ModToDsc or IsNotNul(pItmData.DscPrc) then begin
    pItmData.FgDValue:=Rd(pItmData.FgDPrice*pItmData.GsQnt,pFgvFrc,cStand);
    pItmData.FgHValue:=Rd(pItmData.FgDValue*(1+pItmData.VatPrc/100),pFgvFrc,cStand);
    If IsNotNul (pItmData.FgDValue) then pItmData.DscPrc:=(1-(pItmData.FgAValue/pItmData.FgDValue))*100;
  end
  else begin
    pItmData.FgDValue:=pItmData.FgAValue;
    pItmData.FgHValue:=pItmData.FgBValue;
    pItmData.FgDPrice:=pItmData.FgAPrice;
    pItmData.FgHPrice:=pItmData.FgBPrice;
  end;
  CalcAcValues(pItmData); // Vypocita hodnoty v uctovnej mene
end;

procedure CalcFromBValue (var pItmData:TItmData;pFgPFrc,pFgvFrc:byte);overload; // Spatny prepocet hodnot podla hodnoty s DPH po zlave
begin
  If IsNul(pItmData.GsQnt) then pItmData.GsQnt:=1;
  pItmData.FgAValue:=Rd(pItmData.FgBValue/(1+pItmData.VatPrc/100),pFgvFrc,cStand);
  If IsNotNul (pItmData.GsQnt) then begin
    pItmData.FgBPrice:=Roundx(pItmData.FgBValue/pItmData.GsQnt,pFgpFrc);
    pItmData.FgAPrice:=Roundx(pItmData.FgAValue/pItmData.GsQnt,pFgpFrc);
  end;
  If gvSys.ModToDsc or IsNotNul(pItmData.DscPrc) then begin
    pItmData.FgDValue:=Rd(pItmData.FgDPrice*pItmData.GsQnt,pFgvFrc,cStand);
    pItmData.FgHValue:=Rd(pItmData.FgDValue*(1+pItmData.VatPrc/100),pFgvFrc,cStand);
    If IsNotNul (pItmData.FgDValue) then pItmData.DscPrc:=(1-(pItmData.FgAValue/pItmData.FgDValue))*100;
  end
  else begin
    pItmData.FgDValue:=pItmData.FgAValue;
    pItmData.FgHValue:=pItmData.FgBValue;
    pItmData.FgDPrice:=pItmData.FgAPrice;
    pItmData.FgHPrice:=pItmData.FgBPrice;
  end;
  CalcAcValues(pItmData); // Vypocita hodnoty v uctovnej mene
end;

procedure IsiUnPair (pDocNum:Str12;pItmNum:word); // Odparuje zadanu polozku DF
var mMyOp:boolean;  mBookNum:Str5;
begin
  If pDocNum<>'' then begin
    mBookNum:=BookNumFromDocNum(pDocNum);
    mMyOp:=not dmLDG.btISI.Active or (dmLDG.btISI.BookNum<>mBookNum);
    If mMyOp then begin
      dmLDG.OpenBook (dmLDG.btISH,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
      dmLDG.OpenBook (dmLDG.btISI,mBookNum); // Ak nie je otvoreny alebo polozka je z inej knihy potom otvorime
    end;
    dmLDG.btISI.IndexName:='DoIt';
    If dmLDG.btISI.FindKey ([pDocNum,pItmNum]) then begin
        dmLDG.btISI.Edit;
        dmLDG.btISI.FieldByName ('TsdNum').AsString:='';
        dmLDG.btISI.FieldByName ('TsdItm').AsInteger:=0;
        dmLDG.btISI.FieldByName ('TsdDate').AsDateTime:=0;
        dmLDG.btISI.FieldByName ('Status').AsString:='N';
        dmLDG.btISI.Post;
        // Oznacime hlavicku ze doklad nie je vyparovany
        If dmLDG.btISH.IndexName<>'DocNum' then dmLDG.btISH.IndexName:='DocNum';
        If dmLDG.btISH.FindKey ([pDocNum]) then begin
          dmLDG.btISH.Edit;
          dmLDG.btISH.FieldByName ('DstPair').AsString:='N';
          dmLDG.btISH.Post;
        end;
    end;
    If mMyOp then begin
      dmLDG.btISI.Close;
      dmLDG.btISH.Close;
    end;
  end;
end;

// ***************** ZALOHOVE UCTY ODBERATELOV ********************

function GenSeDocNum (pBookNum,pSerNum:longint): Str12; // Hodnota funkcie je interne cislo dokladu
begin
  Result:='ZA'+StrIntZero(pBookNum,5)+StrIntZero(pSerNum,5);
end;

function GenSvDocNum (pYear:Str2; pBookNum:Str5;pSerNum:longint): Str12; // Hodnota funkcie je interne cislo danoveho dokladu zalohovej platby
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='DZ'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;


// ***************************** CLASS ****************************
constructor TF_DocHand.Create;
begin
  inherited;
  oStHand:=TSubtract.Create;
  oOcdNums:=TStringList.Create;
end;

destructor TF_DocHand.Destroy;
begin
  inherited;
  FreeAndNil (oStHand);
  FreeAndNil (oOcdNums);
end;

function TF_DocHand.GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
begin
  Result:=oStHand.GetStmSumQnt(pDocNum,pItmNum);
end;

procedure TF_DocHand.DocStmSum (pDocNum:Str12; pItmNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku
begin
  oStHand.DocStmSum(pDocNum,pItmNum,pSumQnt,pSumVal);
end;


function TF_DocHand.InputTsItm:boolean;  // Prijem alebo vydaj aktualnej polozky TSI do skladu
var mStkNum:word;
begin
  mStkNum:=dmSTK.btTSI.FieldByName('StkNum').AsInteger;
  If mStkNum=0 then mStkNum:=dmSTK.btTSH.FieldByName('StkNum').AsInteger;
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  dmSTK.AddSlcToOutFif; // Ak boli vyrane nejake FIFO karty prida do zoznamu ktore budu odpocitane
  oStHand.OpenStkFiles (mStkNum);
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btTSI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(dmSTK.btTSI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btTSH.FieldByName('DocDate').AsDateTime);
  oStHand.PutGsCode(dmSTK.btTSI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btTSI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btTSI.FieldByName('BarCode').AsString);
  oStHand.PutStkCode(dmSTK.btTSI.FieldByName('StkCode').AsString);
  oStHand.PutSmCode(dmSTK.btTSH.FieldByName('SmCode').AsInteger);
  oStHand.PutGsName(dmSTK.btTSI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(dmSTK.btTSI.FieldByName('VatPrc').AsFloat);
  oStHand.PutMsName(dmSTK.btTSI.FieldByName('MsName').AsString);
  oStHand.PutGsQnt(dmSTK.btTSI.FieldByName('GsQnt').AsFloat);
  oStHand.PutCPrice(dmSTK.btTSI.FieldByName('AcSPrice').AsFloat);
  oStHand.PutOcdNum(dmSTK.btTSI.FieldByName('OsdNum').AsString);
  oStHand.PutOcdItm(dmSTK.btTSI.FieldByName('OsdItm').AsInteger);
  oStHand.PutPaCode(dmSTK.btTSH.FieldByName('PaCode').AsInteger);
  oStHand.PutDrbDate(dmSTK.btTSI.FieldByName('DrbDate').AsDateTime);
  oStHand.PutRbaDate(dmSTK.btTSI.FieldByName('RbaDate').AsDateTime);
  oStHand.PutRbaCode(dmSTK.btTSI.FieldByName('RbaCode').AsString);
  oStHand.PutBprice(dmSTK.btTSI.FieldByName('AcBValue').AsFloat/dmSTK.btTSI.FieldByName('GsQnt').AsFloat);
  oStHand.PutAcqStat(dmSTK.btTSI.FieldByName('AcqStat').AsString);
  try BtrBegTrans;
    // zaradit tovar do tlace cenoviek ak datum vydaje je viac ako TicExpDay a stav bol nulovy a je v cenniku
    If (gIni.GetTicExpDay>0) and (gIni.GetTicExpDay<Round(Date-dmSTK.btSTK.FieldByName ('LastODate').AsDateTime))
    and IsNul(dmSTK.btSTK.FieldByName ('ActQnt').AsFloat) and dmStk.btPLS.Active
    and ((dmStk.btPLS.FieldByName ('GsCode').AsInteger=dmSTK.btTSI.FieldByName('GsCode').AsInteger)
       or(dmStk.btPLS.FindKey([dmSTK.btTSI.FieldByName('GsCode').AsInteger]))) then
    begin
      dmStk.btPLS.Edit;
      dmStk.btPLS.FieldByName ('ChgItm').AsString:='';
      dmStk.btPLS.Post;
    end;
    If dmSTK.btTSI.FieldByName('GsQnt').AsFloat>0 then begin // Prijem tovaru
      Result:=TRUE;
      oStHand.PutSmSign ('+');
      oStHand.Input;
      oCValue:=dmSTK.btTSI.FieldByName('AcSPrice').AsFloat;
      dmSTK.btTSI.Edit;
      If dmSTK.btTSI.FieldByName ('StkStat').AsString='N' then dmSTK.btTSI.FieldByName ('StkStat').AsString:='S';
      dmSTK.btTSI.Post;
    end
    else begin // Vydaj tovaru - dobropis
      oStHand.PutSmSign ('-');
      Result:=oStHand.Output(dmSTK.btTSH.FieldByName('DocDate').AsDateTime);
      oCValue:=dmSTK.GetOutFifValue*(-1);
      If Result then begin // Ak je mozne vydat
        dmSTK.btTSI.Edit;
        dmSTK.btTSI.FieldByName('AcCValue').AsFloat:=oCValue;
        dmSTK.btTSI.FieldByName('AcSValue').AsFloat:=oCValue;
        dmSTK.btTSI.FieldByName('AcEValue').AsFloat:=oCValue*(1+dmSTK.btTSI.FieldByName ('VatPrc').AsFloat/100);
        dmSTK.btTSI.FieldByName('AcDValue').AsFloat:=oCValue;
        dmSTK.btTSI.FieldByName('AcSPrice').AsFloat:=RoundCPrice(dmSTK.btTSI.FieldByName ('AcSValue').AsFloat/dmSTK.btTSI.FieldByName ('GsQnt').AsFloat);
        If dmSTK.btTSI.FieldByName('GsQnt').AsFloat<0 then begin
          dmSTK.btTSI.FieldByName('FgDValue').AsFloat:=ClcFgFromAcS(dmSTK.btTSI.FieldByName ('AcDValue').AsFloat,dmSTK.btTSH.FieldByName('FgCourse').AsFloat);
          dmSTK.btTSI.FieldByName('FgCValue').AsFloat:=ClcFgFromAcS(dmSTK.btTSI.FieldByName ('AcCValue').AsFloat,dmSTK.btTSH.FieldByName('FgCourse').AsFloat);
          dmSTK.btTSI.FieldByName('FgEValue').AsFloat:=ClcFgFromAcS(dmSTK.btTSI.FieldByName ('AcEValue').AsFloat,dmSTK.btTSH.FieldByName('FgCourse').AsFloat);
          dmSTK.btTSI.FieldByName('FgDPrice').AsFloat:=RoundCPrice(dmSTK.btTSI.FieldByName ('FgDValue').AsFloat/dmSTK.btTSI.FieldByName ('GsQnt').AsFloat);
          dmSTK.btTSI.FieldByName('FgCPrice').AsFloat:=RoundCPrice(dmSTK.btTSI.FieldByName ('FgCValue').AsFloat/dmSTK.btTSI.FieldByName ('GsQnt').AsFloat);
          dmSTK.btTSI.FieldByName('FgEPrice').AsFloat:=RoundCPrice(dmSTK.btTSI.FieldByName ('FgEValue').AsFloat/dmSTK.btTSI.FieldByName ('GsQnt').AsFloat);
        end;
        If dmSTK.btTSI.FieldByName('StkStat').AsString='N' then dmSTK.btTSI.FieldByName ('StkStat').AsString:='S';
        dmSTK.btTSI.Post;
      end;
    end;
  BtrEndTrans;
  except BtrAbortTrans; end;
  // Zmeni poziadavku objednavky na rezervaciu
  If IsNotNul(dmSTK.btSTK.FieldByName ('NrsQnt').AsFloat) then begin

  end;
end;

procedure TF_DocHand.InputTsDoc (pDocNum:Str12);  //  Realizácia zadaného došlého dodacieho listu
begin
  If dmSTK.btTSI.IndexName<>'DocNum' then dmSTK.btTSI.IndexName:='DocNum';
  If dmSTK.btTSI.FindKey ([pDocNum]) then begin
    Repeat
      If (dmSTK.btTSI.FieldByName('StkStat').AsString='N') then begin
        dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
        InputTsItm;  // Prijem aktualnej polozky TSI do skladu
      end;
      Application.ProcessMessages;
      dmSTK.btTSI.Next;
    until (dmSTK.btTSI.Eof) or (dmSTK.btTSI.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

function TF_DocHand.OutputTcItm: boolean;  // Odpocita aktualnu polozku TCI zo skladu
var mSign:Str1;  mOcBook:Str5;  mCnt:word;  mFind:boolean;
begin
  If (dmSTK.btTCI.FieldByName('StkStat').AsString='N')
  and (dmSTK.btTCI.FieldByName('RbaCode').AsString='') then begin
    If dmSTK.btTCI.FieldByName('GsQnt').AsFloat>0
      then mSign:='-'  // Vydaj tovaru - riadny dodaci list
      else mSign:='+'; // Prijem tovaru - dobropis
    oStHand.OpenStkFiles (dmSTK.btTCI.FieldByName('StkNum').AsInteger);
    dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
    dmSTK.AddSlcToOutFif; // Ak boli vyrane nejake FIFO karty prida do zoznamu ktore budu odpocitane
    oStHand.ClearGsData;
    oStHand.PutDocNum(dmSTK.btTCI.FieldByName('DocNum').AsString);
    oStHand.PutItmNum(dmSTK.btTCI.FieldByName('ItmNum').AsInteger);
    oStHand.PutDocDate(dmSTK.btTCH.FieldByName('DocDate').AsDateTime);
    oStHand.PutSmSign(mSign);
    oStHand.PutGsCode(dmSTK.btTCI.FieldByName('GsCode').AsInteger);
    oStHand.PutMgCode(dmSTK.btTCI.FieldByName('MgCode').AsInteger);
    oStHand.PutBarCode(dmSTK.btTCI.FieldByName('BarCode').AsString);
    oStHand.PutSmCode(dmSTK.btTCH.FieldByName('SmCode').AsInteger);
    oStHand.PutGsName(dmSTK.btTCI.FieldByName('GsName').AsString);
    oStHand.PutVatPrc(dmSTK.btTCI.FieldByName('VatPrc').AsFloat);
    oStHand.PutGsQnt(Abs(dmSTK.btTCI.FieldByName('GsQnt').AsFloat));
    oStHand.PutOcdNum(dmSTK.btTCI.FieldByName('OcdNum').AsString);
    oStHand.PutOcdItm(dmSTK.btTCI.FieldByName('OcdItm').AsInteger);
    oStHand.PutPaCode(dmSTK.btTCH.FieldByName('PaCode').AsInteger);
    If mSign='-' then begin // Vydaj tovaru
      oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btTCI.FieldByName('GsQnt').AsFloat);
      oStHand.PutBprice(dmSTK.btTCI.FieldByName('AcBValue').AsFloat/dmSTK.btTCI.FieldByName('GsQnt').AsFloat);
      Result:=oStHand.Output(dmSTK.btTCH.FieldByName('DocDate').AsDateTime);
      If Result then begin
        oCValue:=dmSTK.GetOutFifValue;
        dmSTK.btTCI.Edit;
        dmSTK.btTCI.FieldByName ('AcCValue').AsFloat:=oCValue;
        dmSTK.btTCI.FieldByName ('FgCValue').AsFloat:=ClcFgFromAcS(dmSTK.btTCI.FieldByName ('AcCValue').AsFloat,dmSTK.btTCH.FieldByName ('FgCourse').AsFloat);
        dmSTK.btTCI.FieldByName ('DrbDate').AsDateTime:=dmSTK.GetOutDrbDate;
        If dmSTK.btTCI.FieldByName ('StkStat').AsString='N' then dmSTK.btTCI.FieldByName ('StkStat').AsString:='S';
        dmSTK.btTCI.Post;
      end
      else begin
        dmSTK.btTCI.Edit;
        dmSTK.btTCI.FieldByName ('AcCValue').AsFloat:=0;
        dmSTK.btTCI.Post;
      end;
    end
    else begin // Prijem na dobropisovaneho tvaru
      oStHand.PutCPrice (dmSTK.btTCI.FieldByName('AcCValue').AsFloat/dmSTK.btTCI.FieldByName('GsQnt').AsFloat);
      oStHand.PutBprice(dmSTK.btTCI.FieldByName('AcBValue').AsFloat/dmSTK.btTCI.FieldByName('GsQnt').AsFloat);
      Result:=TRUE; // Prijem vzdy mozeme urobit
      oStHand.Input;
      dmSTK.btTCI.Edit;
      If dmSTK.btTCI.FieldByName ('StkStat').AsString='N' then dmSTK.btTCI.FieldByName ('StkStat').AsString:='S';
      dmSTK.btTCI.FieldByName ('AcCValue').AsFloat:=oStHand.GetCPrice*dmSTK.btTCI.FieldByName('GsQnt').AsFloat;
      dmSTK.btTCI.Post;
    end;
    If Result then begin // Ak tovar bolo mocne odpocitat zo skladu
      If copy(dmSTK.btTCI.FieldByName ('OcdNum').AsString,1,2)='ZK' then begin // Ak polozka pochadza zo zakzazky oznacime polozku zakazky za vyskladnenu
        mOcBook:=BookNumFromDocNum (dmSTK.btTCI.FieldByName('OcdNum').AsString);
// TODO prepracovat
(*
        If (dmSTK.btOCI.Active=FALSE) or (dmSTK.btOCI.BookNum<>mOcBook) then begin // Musime otvorit knihu zakaziek
          dmSTK.btOCI.Open (mOcBook);
          dmSTK.btOCI.IndexName:='DoIt';
        end;
        If dmSTK.btOCI.FindKey ([dmSTK.btTCI.FieldByName('OcdNum').AsString,dmSTK.btTCI.FieldByName('OcdItm').Asinteger]) then begin
          dmSTK.btOCI.Edit;
          dmSTK.btOCI.FieldByName ('TcdNum').AsString:=dmSTK.btTCI.FieldByName('DocNum').AsString;
          dmSTK.btOCI.FieldByName ('TcdItm').AsInteger:=dmSTK.btTCI.FieldByName('ItmNum').AsInteger;
          dmSTK.btOCI.FieldByName ('DlvQnt').AsFloat  :=dmSTK.btOCI.FieldByName ('DlvQnt').AsFloat+dmSTK.btTCI.FieldByName ('GsQnt').AsFloat;
          dmSTK.btOCI.FieldByName ('StkStat').AsString:='S';
          dmSTK.btOCI.Post;
            dmSTK.btSTO.SwapIndex;
            dmSTK.btSTO.IndexName:='DoIt';
            If dmSTK.btSTO.FindKey ([dmSTK.btOCI.FieldByName ('DocNum').AsString,dmSTK.btOCI.FieldByName ('ItmNum').AsInteger]) then begin
              dmSTK.btSTO.Edit;
              dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat  :=dmSTK.btOCI.FieldByName ('DlvQnt').AsFloat;
              dmSTK.btSTO.FieldByName ('StkStat').AsString:='S';
              dmSTK.btSTO.Post;
            end;
            dmSTK.btSTO.RestoreIndex;
            OcdRecalcFromSto (dmSTK.btOCI.FieldByName ('GsCode').AsInteger); // Vypocita hodnotu pola OcdQnt a NrsQnt z databaze STO a ulozi na skladove karty
          // Ak cislo zakazky este nie je v zozname ulozime
          mFind:=TRUE;
          If oOcdNums.Count>0 then begin
            mCnt:=0;
            Repeat
              mFind:=oOcdNums.Strings[mCnt]=dmLDG.btICI.FieldByName('OcdNum').AsString;
              Inc (mCnt);
            until mFind or (mCnt=oOcdNums.Count);
          end;
          If not mFind then oOcdNums.Add (dmLDG.btICI.FieldByName('OcdNum').AsString);
        end;
*)
      end;
    end;
  end else begin
    Result:=True;
  end;
end;

function TF_DocHand.OutputTcDoc (pDocNum:Str12):word;  //  Realizácia zadaného odoslaného dodacieho listu
begin
  Result:=0;
  oOcdNums.Clear;
  If dmSTK.btTCI.IndexName<>'DocNum' then dmSTK.btTCI.IndexName:='DocNum';
  If dmSTK.btTCI.FindKey ([pDocNum]) then begin
    Repeat
      If (dmSTK.btTCI.FieldByName('StkStat').AsString='N') then begin
        try BtrBegTrans;
          If not OutputTcItm then Inc (Result); // Odpocita aktualnu polozku TCI zo skladu
        BtrEndTrans;
        except BtrAbortTrans; end;
      end;
      Application.ProcessMessages;
      dmSTK.btTCI.Next;
    until (dmSTK.btTCI.Eof) or (dmSTK.btTCI.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

function TF_DocHand.InputImItm: boolean;  // Prijem aktualnej polozky IMI do skladu
var mSPC:TSpc; mMSta,mSpcUse:boolean;
begin
  If ((dmSTK.btIMI.FieldByName ('StkStat').AsString='N')or(dmSTK.btIMI.FieldByName ('StkStat').AsString='M'))
  and (dmSTK.btIMI.FieldByName ('PosCode').AsString<>'')then begin
    mSpcUse:=True;
    mSpc:=TSpc.Create;
    mSpc.StkNum:=dmSTK.btIMI.FieldByName('StkNum').AsInteger;
  end else mSpcUse:=False;
  oStHand.OpenStkFiles (dmSTK.btIMI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btIMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(dmSTK.btIMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btIMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutGsCode(dmSTK.btIMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btIMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btIMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode(dmSTK.btIMH.FieldByName('SmCode').AsInteger);
  oStHand.PutGsName(dmSTK.btIMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(dmSTK.btIMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt(dmSTK.btIMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutCPrice(RoundCPrice(dmSTK.btIMI.FieldByName('CValue').AsFloat/dmSTK.btIMI.FieldByName('GsQnt').AsFloat));
  oStHand.PutBprice(dmSTK.btIMI.FieldByName('BValue').AsFloat/dmSTK.btIMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutPaCode(dmSTK.btIMI.FieldByName('PaCode').AsInteger);
  oStHand.PutConStk(dmSTK.btIMI.FieldByName('ConStk').AsInteger);
  oStHand.PutRbaDate(dmSTK.btIMI.FieldByName('RbaDate').AsDateTime);
  oStHand.PutRbaCode(dmSTK.btIMI.FieldByName('RbaCode').AsString);
  try BtrBegTrans;
    If dmSTK.btIMI.FieldByName('GsQnt').AsFloat>0 then begin // Prijem tovaru
      Result:=TRUE;
      oStHand.PutSmSign ('+');
      oStHand.Input;
      oCValue:=dmSTK.btIMI.FieldByName('CValue').AsFloat;
      dmSTK.btIMI.Edit;
      If mSpcUse then begin
(*
         mSpc.Sub(dmSTK.btIMI.FieldByName('StkNum').AsInteger,dmSTK.btIMI.FieldByName('PosCode').AsString,
                  dmSTK.btIMI.FieldByName('GsCode').AsInteger,
                  dmSTK.btIMI.FieldByName('DocNum').AsString,
                  dmSTK.btIMI.FieldByName('ItmNum').AsInteger,
                  dmSTK.btIMI.FieldByName('DocDate').AsDateTime,
                  0-dmSTK.btIMI.FieldByName('GsQnt').AsFloat,0);
*)
      end;
      If dmSTK.btIMI.FieldByName ('StkStat').AsString='N' then dmSTK.btIMI.FieldByName ('StkStat').AsString:='S';
      If dmSTK.btIMI.FieldByName ('StkStat').AsString='M' then begin
        mMSta:=True;
        dmSTK.btIMI.FieldByName ('StkStat').AsString:='S';
      end else mMSta:=False;
      dmSTK.btIMI.Post;
//      if mMSta then ImiToSto(dmSTK.btIMI);
    end
    else begin // Vydaj tovaru - zaporny prijem
      oStHand.PutSmSign ('-');
      Result:=oStHand.Output(dmSTK.btIMH.FieldByName('DocDate').AsDateTime);
      oCValue:=dmSTK.GetOutFifValue*(-1);
      If Result then begin // Ak je mozne vydat
        dmSTK.btIMI.Edit;
        dmSTK.btIMI.FieldByName('CValue').AsFloat:=oCValue;
        dmSTK.btIMI.FieldByName('CPrice').AsFloat:=RoundCPrice(dmSTK.btIMI.FieldByName ('CValue').AsFloat/dmSTK.btIMI.FieldByName ('GsQnt').AsFloat);
        dmSTK.btIMI.FieldByName('EPrice').AsFloat:=RoundCPrice(dmSTK.btIMI.FieldByName ('CPrice').AsFloat*(1+dmSTK.btIMI.FieldByName ('VatPrc').AsFloat/100));
        dmSTK.btIMI.FieldByName('EValue').AsFloat:=RoundCValue(dmSTK.btIMI.FieldByName ('EPrice').AsFloat*dmSTK.btIMI.FieldByName ('GsQnt').AsFloat);
        If dmSTK.btIMI.FieldByName('StkStat').AsString='N' then dmSTK.btIMI.FieldByName ('StkStat').AsString:='S';
        If dmSTK.btIMI.FieldByName('StkStat').AsString='M' then begin
          mMSta:=True;
          dmSTK.btIMI.FieldByName ('StkStat').AsString:='S';
        end else mMSta:=False;
        dmSTK.btIMI.Post;
//        if mMSta then ImiToSto(dmSTK.btIMI);
      end;
    end;
  BtrEndTrans;
  except BtrAbortTrans; end;
  If mSpcUse then FreeAndNil(mSPC);
end;

procedure TF_DocHand.InputImDoc (pDocNum:Str12);  // Prijem alebo vydaj celeho dokladu SP
begin
  If dmSTK.btIMI.IndexName<>'DocNum' then dmSTK.btIMI.IndexName:='DocNum';
  If dmSTK.btIMI.FindKey ([pDocNum]) then begin
    Repeat
      If (dmSTK.btIMI.FieldByName('StkStat').AsString='N')or(dmSTK.btIMI.FieldByName('StkStat').AsString='M')  then begin
        InputImItm;  // Prijem aktualnej polozky IMI do skladu
      end;
      Application.ProcessMessages;
      dmSTK.btIMI.Next;
    until (dmSTK.btIMI.Eof) or (dmSTK.btIMI.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

function TF_DocHand.OutputOmItm: boolean;  // Odpocita aktualnu polozku OMI zo skladu
var mSign:Str1;  mCPrice:double;
var mSPC:TSpc; mRba,mSpcUse:boolean;
begin
  mRba:=False;
  If (dmSTK.btOMI.FieldByName ('StkStat').AsString='N')and (dmSTK.btOMI.FieldByName ('RbaCode').AsString<>'')then begin
    mRba:=True;
    Result:=True;
    Exit;
  end else If (dmSTK.btOMI.FieldByName ('StkStat').AsString='N')and (dmSTK.btOMI.FieldByName ('PosCode').AsString<>'')then begin
    mSpcUse:=True;
    mSpc:=TSpc.Create;
    mSpc.StkNum:=dmSTK.btOMI.FieldByName('StkNum').AsInteger;
  end else mSpcUse:=False;
  If dmSTK.btOMI.FieldByName('GsQnt').AsFloat>0
    then mSign:='-'  // Vydaj tovaru - riadny dodaci list
    else mSign:='+'; // Prijem tovaru - dobropis
  oStHand.OpenStkFiles (dmSTK.btOMI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  dmSTK.AddSlcToOutFif; // Ak boli vyrane nejake FIFO karty prida do zoznamu ktore budu odpocitane
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btOMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(dmSTK.btOMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btOMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign(mSign);
  oStHand.PutGsCode(dmSTK.btOMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btOMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btOMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode(dmSTK.btOMH.FieldByName('SmCode').AsInteger);
  oStHand.PutGsName(dmSTK.btOMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(dmSTK.btOMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt(Abs(dmSTK.btOMI.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutBprice(dmSTK.btOMI.FieldByName('BValue').AsFloat/dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutConStk(dmSTK.btOMI.FieldByName('ConStk').AsInteger);
  If mSign='-' then begin // Vydaj tovaru
    try BtrBegTrans;
      Result:=oStHand.Output(dmSTK.btOMH.FieldByName('DocDate').AsDateTime);
      If Result then begin
        oCValue:=dmSTK.GetOutFifValue;
        If mSpcUse then begin
(*
           mSpc.Sub(dmSTK.btOMI.FieldByName('StkNum').AsInteger,dmSTK.btOMI.FieldByName('PosCode').AsString,
                    dmSTK.btOMI.FieldByName('GsCode').AsInteger,
                    dmSTK.btOMI.FieldByName('DocNum').AsString,
                    dmSTK.btOMI.FieldByName('ItmNum').AsInteger,
                    dmSTK.btOMI.FieldByName('DocDate').AsDateTime,
                    dmSTK.btOMI.FieldByName('GsQnt').AsFloat,0);
*)
        end;
        dmSTK.btOMI.Edit;
        dmSTK.btOMI.FieldByName('CValue').AsFloat:=oCValue;
        dmSTK.btOMI.FieldByName('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
        dmSTK.btOMI.FieldByName('EValue').AsFloat:=RoundCValue(oCValue*(1+dmSTK.btOMI.FieldByName ('VatPrc').AsFloat/100));
        dmSTK.btOMI.FieldByName('EPrice').AsFloat:=RoundCPrice(dmSTK.btOMI.FieldByName ('EValue').AsFloat/dmSTK.GetOutFifosQnt);
        If dmSTK.btOMI.FieldByName('StkStat').AsString='N' then dmSTK.btOMI.FieldByName ('StkStat').AsString:='S';
        dmSTK.btOMI.Post;
      end;
    BtrEndTrans;
    except BtrAbortTrans; end;
  end
  else begin // Prijem na dobropisovaneho tvaru
    Result:=TRUE; // Prijem vzdy mozeme urobit
    mCPrice:=0;
    If IsNotNul(dmSTK.btOMI.FieldByName('GsQnt').AsFloat) then mCPrice:=RoundCPrice(dmSTK.btOMI.FieldByName ('CValue').AsFloat/dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
    If IsNul (mCPrice) then begin  // Ak cena prijmu je nulova vyhladame cenu zo skladovej karty
      dmSTK.btSTK.SwapStatus;
      If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
      If dmSTK.btSTK.FindKey([dmSTK.btOMI.FieldByName('GsCode').AsInteger]) then begin
        mCPrice:=dmSTK.btSTK.FieldByName('LastPrice').AsFloat;
        // Ak aj posledna nakupna cena je nula potom skusime priemernu nakupnu cenu
        If IsNul (mCPrice) then mCPrice:=dmSTK.btSTK.FieldByName('AvgPrice').AsFloat;
      end;
      dmSTK.btSTK.RestoreStatus;
    end;
    oStHand.PutCPrice (mCPrice);
    oStHand.Input;
    If mSpcUse then begin
(*
       mSpc.Sub(dmSTK.btOMI.FieldByName('StkNum').AsInteger,dmSTK.btOMI.FieldByName('PosCode').AsString,
                dmSTK.btOMI.FieldByName('GsCode').AsInteger,
                dmSTK.btOMI.FieldByName('DocNum').AsString,
                dmSTK.btOMI.FieldByName('ItmNum').AsInteger,
                dmSTK.btOMI.FieldByName('DocDate').AsDateTime,
                dmSTK.btOMI.FieldByName('GsQnt').AsFloat,0);
*)                
    end;
    dmSTK.btOMI.Edit;
    dmSTK.btOMI.FieldByName ('CPrice').AsFloat:=mCPrice;
    dmSTK.btOMI.FieldByName ('CValue').AsFloat:=RoundCValue(mCPrice*dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
    dmSTK.btOMI.FieldByName ('EValue').AsFloat:=RoundCValue(dmSTK.btOMI.FieldByName ('CValue').AsFloat*(1+dmSTK.btOMI.FieldByName ('VatPrc').AsInteger/100));
    If IsNotNul (dmSTK.btOMI.FieldByName('GsQnt').AsFloat) then dmSTK.btOMI.FieldByName ('EPrice').AsFloat:=RoundCPrice(dmSTK.btOMI.FieldByName ('EValue').AsFloat/dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
    If dmSTK.btOMI.FieldByName ('StkStat').AsString='N' then dmSTK.btOMI.FieldByName ('StkStat').AsString:='S';
    dmSTK.btOMI.Post;
  end;
  If mSpcUse then FreeAndNil(mSPC);
end;

function TF_DocHand.OutputOmi(pOMH,pOMI:TNexBtrTable): boolean;  // Odpocita aktualnu polozku OMI zo skladu
var mSign:Str1;  mCPrice:double; mRba:boolean;
begin
  mRba:=False;
  If (pOMI.FieldByName ('StkStat').AsString='N')and (pOMI.FieldByName ('RbaCode').AsString<>'')then begin
    mRba:=True;
    Result:=True;
    Exit;
  end;
  If pOMI.FieldByName('GsQnt').AsFloat>0
    then mSign:='-'  // Vydaj tovaru - riadny dodaci list
    else mSign:='+'; // Prijem tovaru - dobropis
  oStHand.OpenStkFiles(pOMI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum(pOMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(pOMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(pOMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign(mSign);
  oStHand.PutGsCode(pOMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(pOMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode(pOMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode(pOMH.FieldByName('SmCode').AsInteger);
  oStHand.PutGsName(pOMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(pOMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt(Abs(pOMI.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice(dmSTK.GetOutFifValue/pOMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutBprice(pOMI.FieldByName('BValue').AsFloat/pOMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutConStk(pOMI.FieldByName('ConStk').AsInteger);
  If mSign='-' then begin // Vydaj tovaru
    try BtrBegTrans;
      Result:=oStHand.Output(pOMH.FieldByName('DocDate').AsDateTime);
      If Result then begin
        oCValue:=dmSTK.GetOutFifValue;
        pOMI.Edit;
        pOMI.FieldByName ('CValue').AsFloat:=oCValue;
        pOMI.FieldByName ('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
        pOMI.FieldByName ('EValue').AsFloat:=RoundCValue(oCValue*(1+pOMI.FieldByName ('VatPrc').AsFloat/100));
        pOMI.FieldByName ('EPrice').AsFloat:=RoundCPrice(pOMI.FieldByName ('EValue').AsFloat/dmSTK.GetOutFifosQnt);
        If pOMI.FieldByName ('StkStat').AsString='N' then pOMI.FieldByName ('StkStat').AsString:='S';
        pOMI.Post;
      end;
    BtrEndTrans;
    except BtrAbortTrans; end;
  end
  else begin // Prijem na dobropisovaneho tvaru
    Result:=TRUE; // Prijem vzdy mozeme urobit
    mCPrice:=0;
    If IsNotNul(pOMI.FieldByName('GsQnt').AsFloat) then mCPrice:=RoundCPrice(pOMI.FieldByName ('CValue').AsFloat/pOMI.FieldByName('GsQnt').AsFloat);
    If IsNul (mCPrice) then begin  // Ak cena prijmu je nulova vyhladame cenu zo skladovej karty
      dmSTK.btSTK.SwapStatus;
      If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
      If dmSTK.btSTK.FindKey([pOMI.FieldByName('GsCode').AsInteger]) then begin
        mCPrice:=dmSTK.btSTK.FieldByName('LastPrice').AsFloat;
        // Ak aj posledna nakupna cena je nula potom skusime priemernu nakupnu cenu
        If IsNul (mCPrice) then mCPrice:=dmSTK.btSTK.FieldByName('AvgPrice').AsFloat;
      end;
      dmSTK.btSTK.RestoreStatus;
    end;
    oStHand.PutCPrice (mCPrice);
    oStHand.Input;
    pOMI.Edit;
    pOMI.FieldByName ('CPrice').AsFloat:=mCPrice;
    pOMI.FieldByName ('CValue').AsFloat:=RoundCValue(mCPrice*pOMI.FieldByName('GsQnt').AsFloat);
    pOMI.FieldByName ('EValue').AsFloat:=RoundCValue(pOMI.FieldByName ('CValue').AsFloat*(1+pOMI.FieldByName ('VatPrc').AsInteger/100));
    If IsNotNul (pOMI.FieldByName('GsQnt').AsFloat) then pOMI.FieldByName ('EPrice').AsFloat:=RoundCPrice(pOMI.FieldByName ('EValue').AsFloat/pOMI.FieldByName('GsQnt').AsFloat);
    If pOMI.FieldByName ('StkStat').AsString='N' then pOMI.FieldByName ('StkStat').AsString:='S';
    pOMI.Post;
  end;
end;

procedure TF_DocHand.OutputOmDoc (pDocNum:Str12);  //  Odpocet zadanej vydajky
begin
  If dmSTK.btOMI.IndexName<>'DocNum' then dmSTK.btOMI.IndexName:='DocNum';
  If dmSTK.btOMI.FindKey ([pDocNum]) then begin
    Repeat
      If (dmSTK.btOMI.FieldByName('StkStat').AsString='N') then begin
        OutputOmItm  // Odpocita aktualnu polozku IMI zo skladu
      end;
      Application.ProcessMessages;
      dmSTK.btOMI.Next;
    until (dmSTK.btOMI.Eof) or (dmSTK.btOMI.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

function TF_DocHand.OutputRmItm: boolean;  // Odpocita aktualnu polozku RMI zo skladu
var mGsQnt,mCValue,mBValue:double;  mSign:integer;
    mStkNum,mConStk,mSmCode:word;   mRba:boolean;
begin
  mRba:=False;
  If (dmSTK.btRMI.FieldByName ('StkStat').AsString='N')and (dmSTK.btRMI.FieldByName ('RbaCode').AsString<>'')then begin
    mRba:=True;
    Result:=True;
    Exit;
  end;
  If dmSTK.btRMI.FieldByName('GsQnt').AsFloat>0 then begin
    mSign:=1;
    mStkNum:=dmSTK.btRMI.FieldByName('ScStkNum').AsInteger;
    mConStk:=dmSTK.btRMI.FieldByName('TgStkNum').AsInteger;
    mSmCode:=dmSTK.btRMI.FieldByName('ScSmCode').AsInteger;
  end
  else begin
    mSign:=-1;
    mStkNum:=dmSTK.btRMI.FieldByName('TgStkNum').AsInteger;
    mConStk:=dmSTK.btRMI.FieldByName('ScStkNum').AsInteger;
    mSmCode:=dmSTK.btRMI.FieldByName('TgSmCode').AsInteger;
  end;
  mGsQnt:=Abs(dmSTK.btRMI.FieldByName('GsQnt').AsFloat);
  mCValue:=Abs(dmSTK.btRMI.FieldByName('CValue').AsFloat);
  mBValue:=Abs(dmSTK.btRMI.FieldByName('BValue').AsFloat);
  oStHand.OpenStkFiles(mStkNum); // Zdrojovy sklad
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btRMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(dmSTK.btRMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btRMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign('-');  // Vydaj tovaru
  oStHand.PutGsCode(dmSTK.btRMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btRMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btRMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode(mSmCode);  // Zdojovy pohyb
  oStHand.PutConStk(mConStk);  // Protisklad
  oStHand.PutGsName(dmSTK.btRMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(dmSTK.btRMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt(mGsQnt);
  oStHand.PutCPrice(dmSTK.GetOutFifValue/mGsQnt);
  Result:=oStHand.Output(dmSTK.btRMH.FieldByName('DocDate').AsDateTime);
  If Result then begin
    oCValue:=dmSTK.GetOutFifValue;
    dmSTK.btRMI.Edit;
    dmSTK.btRMI.FieldByName('CValue').AsFloat:=oCValue*mSign;
    dmSTK.btRMI.FieldByName('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
    dmSTK.btRMI.FieldByName('EValue').AsFloat:=RoundCValue(dmSTK.btRMI.FieldByName ('CValue').AsFloat*(1+dmSTK.btRMI.FieldByName ('VatPrc').Asinteger/100));
    dmSTK.btRMI.FieldByName('DrbDate').AsDateTime:=dmSTK.GetOutDrbDate;
    If dmSTK.btRMI.FieldByName('StkStat').AsString='N' then dmSTK.btRMI.FieldByName ('StkStat').AsString:='O';
    dmSTK.btRMI.Post;
  end
end;

function TF_DocHand.InputRmItm: boolean;  // Prijme aktualnu polozku RMI zo skladu
var mGsQnt,mCValue,mBValue:double; mSign:integer; mStkNum,mConStk,mSmCode:word;
begin
  If dmSTK.btRMI.FieldByName('GsQnt').AsFloat>0 then begin
    mSign:=1;
    mStkNum:=dmSTK.btRMI.FieldByName('TgStkNum').AsInteger;
    mConStk:=dmSTK.btRMI.FieldByName('ScStkNum').AsInteger;
    mSmCode:=dmSTK.btRMI.FieldByName('TgSmCode').AsInteger;
  end
  else begin
    mSign:=-1;
    mStkNum:=dmSTK.btRMI.FieldByName('ScStkNum').AsInteger;
    mConStk:=dmSTK.btRMI.FieldByName('TgStkNum').AsInteger;
    mSmCode:=dmSTK.btRMI.FieldByName('ScSmCode').AsInteger;
  end;
  mGsQnt:=Abs(dmSTK.btRMI.FieldByName('GsQnt').AsFloat);
  mCValue:=Abs(dmSTK.btRMI.FieldByName('CValue').AsFloat);
  mBValue:=Abs(dmSTK.btRMI.FieldByName('BValue').AsFloat);
  oStHand.OpenStkFiles (mStkNum); // Cielovy sklad
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum (dmSTK.btRMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (dmSTK.btRMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate (dmSTK.btRMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutGsCode (dmSTK.btRMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode (dmSTK.btRMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode (dmSTK.btRMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode (mSmCode); // Cielovy pohyb
  oStHand.PutConStk (mConStk);  // Protisklad
  oStHand.PutGsName (dmSTK.btRMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc (dmSTK.btRMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt (mGsQnt);
  oStHand.PutCPrice (RoundCPrice(mCValue/mGsQnt));
  oStHand.PutBprice (mBValue/mGsQnt);
  oStHand.PutDrbDate (dmSTK.btRMI.FieldByName ('DrbDate').AsDateTime);
  Result:=TRUE;
  oStHand.PutSmSign ('+');  // Prijem tovaru
  oStHand.Input;
  oCValue:=mCValue;
  dmSTK.btRMI.Edit;
  If dmSTK.btRMI.FieldByName ('StkStat').AsString='O' then dmSTK.btRMI.FieldByName ('StkStat').AsString:='S';
  dmSTK.btRMI.Post;
end;

function TF_DocHand.OutputPkItm: boolean;  // Vydaj aktualnej polozky PKI do skladu
begin
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btPKI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(dmSTK.btPKI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btPKH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign('-');  // Vydaj tovaru
  oStHand.PutGsCode(dmSTK.btPKI.FieldByName('ScGsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btPKI.FieldByName('ScMgCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btPKI.FieldByName('ScBarCode').AsString);
  oStHand.PutSmCode(dmSTK.btPKH.FieldByName('ScSmCode').AsInteger);
  oStHand.PutGsName(dmSTK.btPKI.FieldByName('ScGsName').AsString);
  oStHand.PutGsQnt(dmSTK.btPKI.FieldByName('ScGsQnt').AsFloat);
  oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btPKI.FieldByName('ScGsQnt').AsFloat);
  Result:=oStHand.Output(dmSTK.btPKH.FieldByName('DocDate').AsDateTime);
  If Result then begin
    oCValue:=dmSTK.GetOutFifValue;
    dmSTK.btPKI.Edit;
    dmSTK.btPKI.FieldByName('ScCValue').AsFloat:=oCValue;
    dmSTK.btPKI.FieldByName('ScCPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
    dmSTK.btPKI.FieldByName('TgCValue').AsFloat:=oCValue;
    dmSTK.btPKI.FieldByName('TgCPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.btPKI.FieldByName ('TgGsQnt').AsFloat);
    dmSTK.btPKI.FieldByName('DrbDate').AsDateTime:=dmSTK.GetOutDrbDate;
    If dmSTK.btPKI.FieldByName('StkStat').AsString='N' then dmSTK.btPKI.FieldByName ('StkStat').AsString:='O';
    dmSTK.btPKI.Post;
  end
end;

function TF_DocHand.InputPkItm: boolean;  // Prijem aktualnej polozky PKI do skladu
begin
  oStHand.ClearGsData;
  oStHand.PutDocNum (dmSTK.btPKI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (dmSTK.btPKI.FieldByName('ItmNum').AsInteger+10000);
  oStHand.PutDocDate (dmSTK.btPKH.FieldByName('DocDate').AsDateTime);
  oStHand.PutGsCode (dmSTK.btPKI.FieldByName('TgGsCode').AsInteger);
  oStHand.PutMgCode (dmSTK.btPKI.FieldByName('TgMgCode').AsInteger);
  oStHand.PutBarCode (dmSTK.btPKI.FieldByName('TgBarCode').AsString);
  oStHand.PutSmCode (dmSTK.btPKH.FieldByName('TgSmCode').AsInteger);
  oStHand.PutGsName (dmSTK.btPKI.FieldByName('TgGsName').AsString);
  oStHand.PutGsQnt (dmSTK.btPKI.FieldByName('TgGsQnt').AsFloat);
  oStHand.PutCPrice (dmSTK.btPKI.FieldByName('TgCPrice').AsFloat);
  oStHand.PutDrbDate (dmSTK.btPKI.FieldByName('DrbDate').AsDateTime);
  Result:=TRUE;
  oStHand.PutSmSign ('+');  // Prijem tovaru
  oStHand.Input;
  dmSTK.btPKI.Edit;
  If dmSTK.btPKI.FieldByName ('StkStat').AsString='O' then dmSTK.btPKI.FieldByName ('StkStat').AsString:='S';
  dmSTK.btPKI.Post;
end;

function TF_DocHand.OutputCmItm: boolean;  // Odpocita aktualnu polozku CMI zo skladu
var mSign:Str1;
begin
  If(dmSTK.btCMI.FieldByName ('ItmType').AsString<>'W') then begin
    If dmSTK.btCMI.FieldByName('GsQnt').AsFloat>0
      then mSign:='-'  // Vydaj tovaru - riadny dodaci list
      else mSign:='+'; // Prijem tovaru - dobropis
    oStHand.OpenStkFiles (dmSTK.btCMI.FieldByName('StkNum').AsInteger);
    dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
    oStHand.ClearGsData;
    oStHand.PutDocNum(dmSTK.btCMI.FieldByName('DocNum').AsString);
    oStHand.PutItmNum(dmSTK.btCMI.FieldByName('ItmNum').AsInteger);
    oStHand.PutDocDate(dmSTK.btCMH.FieldByName('DocDate').AsDateTime);
    oStHand.PutSmSign(mSign);
    oStHand.PutGsCode(dmSTK.btCMI.FieldByName('GsCode').AsInteger);
    oStHand.PutMgCode(dmSTK.btCMI.FieldByName('MgCode').AsInteger);
    oStHand.PutBarCode(dmSTK.btCMI.FieldByName('BarCode').AsString);
    oStHand.PutSmCode(dmSTK.btCMI.FieldByName('SmCode').AsInteger);
    oStHand.PutGsName(dmSTK.btCMI.FieldByName('GsName').AsString);
    oStHand.PutVatPrc(dmSTK.btCMI.FieldByName('VatPrc').AsFloat);
    oStHand.PutGsQnt(Abs(dmSTK.btCMI.FieldByName('GsQnt').AsFloat));
    oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btCMI.FieldByName('GsQnt').AsFloat);
    If mSign='-' then begin // Vydaj tovaru
      Result:=oStHand.Output(dmSTK.btCMH.FieldByName('DocDate').AsDateTime);
      If Result then begin
        oCValue:=dmSTK.GetOutFifValue;
        dmSTK.btCMI.Edit;
        dmSTK.btCMI.FieldByName('CValue').AsFloat:=oCValue;
        dmSTK.btCMI.FieldByName('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
        If dmSTK.btCMI.FieldByName('StkStat').AsString='N' then dmSTK.btCMI.FieldByName ('StkStat').AsString:='S';
        dmSTK.btCMI.Post;
      end;
    end
    else begin // Prijem na dobropisovaneho tvaru
      Result:=TRUE; // Prijem vzdy mozeme urobit
      oCValue:=dmSTK.btCMI.FieldByName ('CValue').AsFloat;
      oStHand.PutCPrice(RoundCPrice(oCValue/dmSTK.btCMI.FieldByName('GsQnt').AsFloat));
      oStHand.Input;
      dmSTK.btCMI.Edit;
      If dmSTK.btCMI.FieldByName ('StkStat').AsString='N' then dmSTK.btCMI.FieldByName ('StkStat').AsString:='S';
      dmSTK.btCMI.Post;
    end;
  end else begin
    // PRACA
    Result:=True;
  end;
end;

function TF_DocHand.InputCmPd: boolean;  // prijem kompetizovaneho vyrobku
var mSign:Str1;
begin
  mSign:='+'; // Prijem kompletizovaneho vyrobku
  oStHand.OpenStkFiles (dmSTK.btCMH.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum (dmSTK.btCMH.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (0);
  oStHand.PutDocDate (dmSTK.btCMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign (mSign);
  oStHand.PutGsCode (dmSTK.btCMH.FieldByName('GsCode').AsInteger);
  oStHand.PutSmCode (70);
  oStHand.PutBarCode (dmSTK.btCMH.FieldByName('BarCode').AsString);
  oStHand.PutGsName (dmSTK.btCMH.FieldByName('GsName').AsString);
  oStHand.PutVatPrc (dmSTK.btCMH.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt (Abs(dmSTK.btCMH.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice (dmSTK.btCMH.FieldByName('CPrice').AsFloat);
  oStHand.Input;
  dmSTK.btCMH.Edit;
  If dmSTK.btCMH.FieldByName ('StkStat').AsString='N' then dmSTK.btCMH.FieldByName ('StkStat').AsString:='S';
  dmSTK.btCMH.FieldByName('CmdVal').AsFloat:=dmSTK.btCMH.FieldByName('CValue').AsFloat;
  dmSTK.btCMH.Post;
end;

function TF_DocHand.OutputCDM;
var mSign:Str1;
begin
  If dmSTK.btCDM.FieldByName('ItmType').AsString<>'W' then begin
    If dmSTK.btCDM.FieldByName('GsQnt').AsFloat>0
      then mSign:='-'  // Vydaj tovaru - riadny dodaci list
      else mSign:='+'; // Prijem tovaru - dobropis
    oStHand.OpenStkFiles (dmSTK.btCDM.FieldByName('StkNum').AsInteger);
    dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
    oStHand.ClearGsData;
    oStHand.PutDocNum(dmSTK.btCDM.FieldByName('DocNum').AsString);
    oStHand.PutItmNum(dmSTK.btCDM.FieldByName('ItmNum').AsInteger+cCDMItmAdd);
    oStHand.PutDocDate(dmSTK.btCDM.FieldByName('DocDate').AsDateTime);
    oStHand.PutSmSign(mSign);
    oStHand.PutGsCode(dmSTK.btCDM.FieldByName('GsCode').AsInteger);
    oStHand.PutMgCode(dmSTK.btCDM.FieldByName('MgCode').AsInteger);
    oStHand.PutBarCode(dmSTK.btCDM.FieldByName('BarCode').AsString);
    oStHand.PutSmCode(dmSTK.btCDH.FieldByName('CpSmCode').AsInteger);
    oStHand.PutGsName(dmSTK.btCDM.FieldByName('GsName').AsString);
    oStHand.PutVatPrc(dmSTK.btCDM.FieldByName('VatPrc').AsFloat);
    oStHand.PutGsQnt(Abs(dmSTK.btCDM.FieldByName('GsQnt').AsFloat));
    oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btCDM.FieldByName('GsQnt').AsFloat);
    If mSign='-' then begin // Vydaj tovaru
      Result:=oStHand.Output(dmSTK.btCDM.FieldByName('DocDate').AsDateTime);
      If Result then begin
        oCValue:=dmSTK.GetOutFifValue;
        dmSTK.btCDM.Edit;
        dmSTK.btCDM.FieldByName('CValue').AsFloat:=oCValue;
        dmSTK.btCDM.FieldByName('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
        If dmSTK.btCDM.FieldByName('StkStat').AsString='N' then dmSTK.btCDM.FieldByName ('StkStat').AsString:='S';
        dmSTK.btCDM.Post;
      end;
    end
    else begin // Prijem na dobropisovaneho tvaru
      Result:=TRUE; // Prijem vzdy mozeme urobit
      oCValue:=dmSTK.btCDM.FieldByName ('CValue').AsFloat;
      oStHand.PutCPrice(RoundCPrice(oCValue/dmSTK.btCDM.FieldByName('GsQnt').AsFloat));
      oStHand.Input;
      dmSTK.btCDM.Edit;
      If dmSTK.btCDM.FieldByName('StkStat').AsString='N' then dmSTK.btCDM.FieldByName ('StkStat').AsString:='S';
      dmSTK.btCDM.Post;
    end;
  end else begin
    Result:=TRUE;
//    dmSTK.btCDM.Edit;
//    dmSTK.btCDM.FieldByName ('CValue').AsFloat:=0;
//    dmSTK.btCDM.FieldByName ('CPrice').AsFloat:=0;
//    dmSTK.btCDM.Post;
  end;
end;

function TF_DocHand.OutputCDM_DI(pRunTrans:boolean;pDocNum:Str12;pItmNum:longint;var pCValue:double): boolean;  // Odpocita komponenty
var mSign:Str1;
begin
  try
  If pRunTrans then BtrBegTrans;
  Result:=True;
  pCValue:=0;
  dmSTK.btCDM.IndexName:='DoIt';
  dmSTK.btCDM.FindKey([pDocNum,pItmNum]);
  while Result and not dmSTK.btCDM.Eof and(pDocNum=dmSTK.btCDM.FieldByName('DocNum').AsString)and(pItmnum=dmSTK.btCDM.FieldByName('ItmNum').AsInteger) do begin
    Result:=outputCDM;
    If Result then pCValue:=pCValue+dmSTK.btCDM.FieldByName ('CValue').AsFloat else SetAbortTrans;
    dmSTK.btCDM.Next;
  end;
  If pRunTrans then BtrEndTrans;
  except if pRunTrans then BtrAbortTrans; end;
end;

function TF_DocHand.InputCDI: boolean;  // prijem kompetizovaneho vyrobku
var mSign:Str1;
begin
  mSign:='+'; // Prijem kompletizovaneho vyrobku
  oStHand.OpenStkFiles (dmSTK.btCDI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum (dmSTK.btCDI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (dmSTK.btCDI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(dmSTK.btCDI.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign (mSign);
  oStHand.PutGsCode (dmSTK.btCDI.FieldByName('GsCode').AsInteger);
  oStHand.PutSmCode (dmSTK.btCDH.FieldByName('PdSmCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btCDI.FieldByName('BarCode').AsString);
  oStHand.PutGsName (dmSTK.btCDI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc (dmSTK.btCDI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt  (Abs(dmSTK.btCDI.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice (dmSTK.btCDI.FieldByName('CPrice').AsFloat);
  oStHand.Input;
  dmSTK.btCDI.Edit;
  If dmSTK.btCDI.FieldByName ('StkStat').AsString='N' then dmSTK.btCDI.FieldByName ('StkStat').AsString:='S';
  dmSTK.btCDI.FieldByName('CValue').AsFloat:=dmSTK.btCDI.FieldByName('CValue').AsFloat;
  dmSTK.btCDI.Post;
end;

function TF_DocHand.PRodCdbDoc (btCDH,btCDI,btCDM:TNexBtrTable;var pIndicator:TProgressBar):word;  // Vydaj alebo prijem celeho dokladu vyroby
var mCValue:double;
begin
  If btCDI.IndexName<>'DoIt' then btCDI.IndexName:='DoIt';
  btCDI.FindNearest ([btCDH.FieldByName('DocNum').AsString]);
  If btCDI.FieldByName('DocNum').AsString=btCDH.FieldByName('DocNum').AsString then begin
    pIndicator.Max:=btCDH.FieldByName('ItmQnt').AsInteger;
    pIndicator.Position:=0;
    Repeat
      pIndicator.StepBy(1);
      try BtrBegTrans;
      If (btCDI.FieldByName('StkStat').AsString='N') then begin
        If OutputCDM_DI(False,btCDI.FieldByName('DocNum').AsString,btCDI.FieldByName('ItmNum').AsInteger,mCValue) then
        begin
          btCDI.Edit;
          btCDI.FieldByName('CValue').AsFloat:=mCValue;
          If IsNotNul(btCDI.FieldByName ('GsQnt').AsFloat) then btCDI.FieldByName ('CPrice').AsFloat:=mCValue/btCDI.FieldByName ('GsQnt').AsFloat;
          btCDI.Post;
          InputCDI;
        end else SetAbortTrans;
      end;
      BtrEndTrans;
      except BtrAbortTrans; end;
      Application.ProcessMessages;
      btCDI.Next;
    until (btCDI.Eof) or (btCDI.FieldByName('DocNum').AsString<>btCDH.FieldByName('DocNum').AsString);
  end;
  CDHRecalc (btCDH,btCDI,btCDM);
end;

function TF_DocHand.InputDmItm: boolean;  // Odpocita aktualnu polozku DMI zo skladu
var mSign:Str1;
begin
  mSign:='+'; // Prijem tovaru - dobropis
  oStHand.OpenStkFiles (dmSTK.btDMI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum (dmSTK.btDMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (dmSTK.btDMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate (dmSTK.btDMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign (mSign);
  oStHand.PutGsCode (dmSTK.btDMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode (dmSTK.btDMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode (dmSTK.btDMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode (dmSTK.btDMH.FieldByName('InSmCode').AsInteger);
  oStHand.PutGsName (dmSTK.btDMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc (dmSTK.btDMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt (Abs(dmSTK.btDMI.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice (dmSTK.btDMI.FieldByName('CPrice').AsFloat);
  Result:=TRUE; // Prijem vzdy mozeme urobit
  oStHand.Input;
  dmSTK.btDMI.Edit;
  If dmSTK.btDMI.FieldByName ('StkStat').AsString='N' then dmSTK.btDMI.FieldByName ('StkStat').AsString:='S';
  dmSTK.btDMI.Post;
end;

function TF_DocHand.OutputDmPd: boolean;  // prijem kompetizovaneho vyrobku
var mSign:Str1;
begin
  mSign:='-'; // Prijem kompletizovaneho vyrobku
  oStHand.OpenStkFiles(dmSTK.btDMH.FieldByName('OuStkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum(dmSTK.btDMH.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(0);
  oStHand.PutDocDate(dmSTK.btDMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign(mSign);
  oStHand.PutGsCode(dmSTK.btDMH.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode(dmSTK.btDMH.FieldByName('MgCode').AsInteger);
  oStHand.PutSmCode(dmSTK.btDMH.FieldByName('OuSmCode').AsInteger);
  oStHand.PutBarCode(dmSTK.btDMH.FieldByName('BarCode').AsString);
  oStHand.PutGsName(dmSTK.btDMH.FieldByName('GsName').AsString);
  oStHand.PutVatPrc(dmSTK.btDMH.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt(Abs(dmSTK.btDMH.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice(dmSTK.GetOutFifValue/dmSTK.btDMH.FieldByName('GsQnt').AsFloat);
  Result:=oStHand.Output(dmSTK.btDMH.FieldByName('DocDate').AsDateTime);
  If Result then begin
    oCValue:=dmSTK.GetOutFifValue;
    dmSTK.btDMH.Edit;
    dmSTK.btDMH.FieldByName('CValue').AsFloat:=oCValue;
    dmSTK.btDMH.FieldByName('CPrice').AsFloat:=RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
    If dmSTK.btDMH.FieldByName('DstStk').AsString='N' then dmSTK.btDMH.FieldByName ('DstStk').AsString:='S';
    dmSTK.btDMH.Post;
  end;
end;

function TF_DocHand.OutputSaItm(btSAI:TNexBtrTable): boolean;  // Prijem aktualnej polozky TCI zo skladu
var mSign:Str1;  mFifQnt,mGsQnt:double;  mCnt:word;  mFind:boolean;
begin
  If btSAI.FieldByName('MgCode').AsInteger<gIni.ServiceMg then begin
    Result:=FALSE;
    If btSAI.FieldByName('SeQnt').AsFloat>0
      then mSign:='-'  // Vydaj tovaru
      else mSign:='+'; // Prijem tovaru
    mGsQnt:=Abs(btSAI.FieldByName('SeQnt').AsFloat-btSAI.FieldByName('SuQnt').AsFloat);
    If IsNotNul (mGsQnt) then begin
      oStHand.OpenStkFiles(btSAI.FieldByName('StkNum').AsInteger);
      oStHand.SetSalNul;
      dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
      oStHand.ClearGsData;
      oStHand.PutDocNum(btSAI.FieldByName('DocNum').AsString);
      oStHand.PutItmNum(btSAI.FieldByName('GsCode').AsInteger);
      oStHand.PutDocDate(btSAI.FieldByName('DocDate').AsDateTime);
      oStHand.PutSmSign(mSign);
      oStHand.PutGsCode(btSAI.FieldByName('GsCode').AsInteger);
      oStHand.PutMgCode(btSAI.FieldByName('MgCode').AsInteger);
      oStHand.PutBarCode(btSAI.FieldByName('BarCode').AsString);
      oStHand.PutSmCode(59);
      oStHand.PutGsName(btSAI.FieldByName('GsName').AsString);
      oStHand.PutVatPrc(btSAI.FieldByName('VatPrc').AsFloat);
      oStHand.PutBprice(btSAI.FieldByName('BValue').AsFloat/btSAI.FieldByName('SeQnt').AsFloat);
      oStHand.PutGsQnt(mGsQnt);
      If mSign='-' then begin // Vydaj tovaru
        oStHand.AnalyzeFifo(Year(btSAI.FieldByName('DocDate').AsDateTime));
        mFifQnt:=dmSTK.GetOutFifosQnt;
        If Abs(btSAI.FieldByName('SeQnt').AsFloat)>mFifQnt then mGsQnt:=mFifQnt;
        If IsNotNul (mGsQnt) then begin
          oStHand.PutGsQnt(mGsQnt);
          oStHand.PutCPrice(dmSTK.GetOutFifValue/mGsQnt);
          Result:=oStHand.Output(btSAI.FieldByName('DocDate').AsDateTime);
          If Result then begin
            btSAI.Edit;
            btSAI.FieldByName('SuQnt').AsFloat:=btSAI.FieldByName ('SuQnt').AsFloat+mGsQnt;
            btSAI.FieldByName('CValue').AsFloat:=btSAI.FieldByName ('CValue').AsFloat+dmSTK.GetOutFifValue;
            If Eq3(btSAI.FieldByName('SeQnt').AsFloat,btSAI.FieldByName ('SuQnt').AsFloat)
              then btSAI.FieldByName('StkStat').AsString:='S'
              else btSAI.FieldByName('StkStat').AsString:='N';
            btSAI.Post;
            // SAI.BDF
            If mGsQnt>0 then StkGlob.STS_SubQnt(btSAI.FieldByName('GsCode').AsInteger,btSAI.FieldByName('DocDate').AsDateTime,0,mGsQnt)
          end;
        end;
      end
      else begin // Prijem dobropisovaneho tvaru
        dmSTK.btSTK.SwapIndex;
        If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
        If dmSTK.btSTK.FindKey([btSAI.FieldByName('GsCode').AsInteger]) then begin
          Result:=TRUE; // Prijem mozeme urobit
          oStHand.PutCPrice(dmSTK.btSTK.FieldByName ('LastPrice').AsFloat);
          oStHand.Input;
          btSAI.Edit;
          btSAI.FieldByName('SuQnt').AsFloat:=btSAI.FieldByName('SeQnt').AsFloat;
          btSAI.FieldByName('CValue').AsFloat:=dmSTK.btSTK.FieldByName ('LastPrice').AsFloat*btSAI.FieldByName('SeQnt').AsFloat;
          btSAI.FieldByName('StkStat').AsString:='S';
          btSAI.Post;
          // netreba lebo STS sa nuluje uz pri spracovani predaja
//          If mGsQnt>0 then StkGlob.STS_AddQnt(btSAI.FieldByName('GsCode').AsInteger,btSAI.FieldByName('DocDate').AsDateTime,0,mGsQnt)
        end
        else Result:=FALSE; // Prijem nie je mozne urobit
        dmSTK.btSTK.RestoreIndex;
      end;
    end;
  end
  else begin // Sluzny
    Result:=TRUE;
    If btSAI.FieldByName ('StkStat').AsString<>'S' then begin
      btSAI.Edit;
      btSAI.FieldByName ('StkStat').AsString:='S';
      btSAI.Post;
    end;
  end;
end;

function TF_DocHand.OutputSaDoc (btSAH,btSAI:TNexBtrTable;pIndicator:TProgressBar):word;  // Vydaj alebo prijem celeho dokladu MO predaja
var mStkCanc: TStkCanc;  mhGSCAT:TGscatHnd;  mSabGscPce:boolean;
    mgKey_StpRndFrc:byte;
begin
  mgKey_StpRndFrc:=gKey.StpRndFrc;
  If btSAI.IndexName<>'DocNum' then btSAI.IndexName:='DocNum';
  If btSAI.FindKey ([btSAH.FieldByName('DocNum').AsString]) then begin
    mhGSCAT:=TGscatHnd.Create;   mhGSCAT.Open;
    mStkCanc:=TStkCanc.Create;
    pIndicator.Max:=btSAH.FieldByName('ItmQnt').AsInteger;
    pIndicator.Position:=0;
    Repeat
      pIndicator.StepBy(1);
      If (btSAI.FieldByName('StkStat').AsString='N') then begin
        mStkCanc.OpenStkFiles(btSAI.FieldByName('StkNum').AsInteger);
        If mStkCanc.Cancel(btSAI.FieldByName('DocNum').AsString,btSAI.FieldByName('GsCode').AsInteger)=0 then begin
          btSAI.Edit;
          btSAI.FieldByName ('SuQnt').AsFloat:=0;
          btSAI.FieldByName ('CValue').AsFloat:=0;
          btSAI.Post;
        end;
        OutputSaItm (btSAI);  // Odpocita aktualnu polozku IMI zo skladu
        If IsNul(btSAI.FieldByName ('CValue').AsFloat) then begin
          If mhGSCAT.LocateGsCode(btSAI.FieldByName ('GsCode').AsInteger) then begin
            btSAI.Edit;
            btSAI.FieldByName ('CPrice').AsFloat:=mhGSCAT.LinPrice;
            btSAI.Post;
          end;
        end
        else begin
          If IsNotNul(btSAI.FieldByName ('SeQnt').AsFloat) then begin
            btSAI.Edit;
            btSAI.FieldByName ('CPrice').AsFloat:=Rd(btSAI.FieldByName ('CValue').AsFloat/btSAI.FieldByName ('SeQnt').AsFloat,mgKey_StpRndFrc,cStand);
            btSAI.Post;
          end;
        end;
      end;
      Application.ProcessMessages;
      btSAI.Next;
    until (btSAI.Eof) or (btSAI.FieldByName('DocNum').AsString<>btSAH.FieldByName('DocNum').AsString);
    FreeAndNil (mStkCanc);
    FreeAndNil (mhGSCAT);
  end;
end;

function TF_DocHand.PackedPkItm (btPKH,btPKI:TNexBtrTable): boolean;  // Prebalenie aktualnej polozky PKI.BDF
var mSign:Str1;  mFifQnt,mGsQnt:double;  mCnt:word;  mFind:boolean;
    mDrbDate:TDateTime;
begin
  oStHand.OpenStkFiles(gKey.PkbStkNum[btPKH.BookNum]);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum(btPKI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum(btPKI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate(btPKH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmCode(btPKH.FieldByName('ScSmCode').AsInteger);
  oStHand.PutGsCode(btPKI.FieldByName('ScGsCode').AsInteger);
  oStHand.PutMgCode(btPKI.FieldByName('ScMgCode').AsInteger);
  oStHand.PutBarCode(btPKI.FieldByName('ScBarCode').AsString);
  oStHand.PutGsName(btPKI.FieldByName('ScGsName').AsString);
  oStHand.PutGsQnt(btPKI.FieldByName('ScGsQnt').AsFloat);
  oStHand.PutSmSign('-');
  try BtrBegTrans;
    // Vydaj zdrojoveho tovaru
    Result:=oStHand.Output(btPKH.FieldByName('DocDate').AsDateTime);
    If Result then begin
      oCValue:=dmSTK.GetOutFifValue;
      mDrbDate:=dmSTK.GetOutDrbDate;
      // Prijem cieloveho tovaru
      dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
      oStHand.ClearGsData;
      oStHand.PutDocNum(btPKI.FieldByName('DocNum').AsString);
      oStHand.PutItmNum(btPKI.FieldByName('ItmNum').AsInteger+10000);
      oStHand.PutDocDate(btPKH.FieldByName('DocDate').AsDateTime);
      oStHand.PutSmCode(btPKH.FieldByName('TgSmCode').AsInteger);
      oStHand.PutGsCode(btPKI.FieldByName('TgGsCode').AsInteger);
      oStHand.PutMgCode(btPKI.FieldByName('TgMgCode').AsInteger);
      oStHand.PutBarCode(btPKI.FieldByName('TgBarCode').AsString);
      oStHand.PutGsName(btPKI.FieldByName('TgGsName').AsString);
      oStHand.PutVatPrc(gIni.GetVatPrc(2));
      oStHand.PutGsQnt(btPKI.FieldByName('TgGsQnt').AsFloat);
      oStHand.PutCPrice (RoundCPrice(oCValue/btPKI.FieldByName('TgGsQnt').AsFloat));
      oStHand.PutDrbDate (mDrbDate);
      oStHand.PutSmSign ('+');
      oStHand.Input;
      // Ulozime udaje prebaleneho tovaru
      btPKI.Edit;
      btPKI.FieldByName('ScCValue').AsFloat:=oCValue;
      btPKI.FieldByName('TgCValue').AsFloat:=oCValue;
      btPKI.FieldByName('ScCPrice').AsFloat:=RoundCPrice(oCValue/btPKI.FieldByName('ScGsQnt').AsFloat);
      btPKI.FieldByName('TgCPrice').AsFloat:=RoundCPrice(oCValue/btPKI.FieldByName('TgGsQnt').AsFloat);
      btPKI.FieldByName('StkStat').AsString:='S';
      btPKI.Post;
    end;
  BtrEndTrans;
  except BtrAbortTrans; end;
end;

function TF_DocHand.PackedPkDoc (btPKH,btPKI:TNexBtrTable;var pIndicator:TProgressBar):word;  // Vydaj alebo prijem celeho dokladu MO predaja
begin
  If btPKI.IndexName<>'DoIt' then btPKI.IndexName:='DoIt';
  btPKI.FindNearest ([btPKH.FieldByName('DocNum').AsString]);
  If btPKI.FieldByName('DocNum').AsString=btPKH.FieldByName('DocNum').AsString then begin
    pIndicator.Max:=btPKH.FieldByName('ItmQnt').AsInteger;
    pIndicator.Position:=0;
    Repeat
      pIndicator.StepBy(1);
      If (btPKI.FieldByName('StkStat').AsString='N') then PackedPkItm (btPKH,btPKI); // prebali danu polozku
      Application.ProcessMessages;
      btPKI.Next;
    until (btPKI.Eof) or (btPKI.FieldByName('DocNum').AsString<>btPKH.FieldByName('DocNum').AsString);
  end;
  PkhRecalc (btPKH,btPKI);
end;

function TF_DocHand.VerifyRba   (pStkNum,pGsCode:longint;pRbaCode:Str30;pQnt:Double;
         var pRbaQnt,pRbnQnt,pRboQnt:double;var pRbaDate:TDate):boolean;
begin
  pRbaDate:=0;
  oStHand.OpenStkFiles (pStkNum);
  pRbaQnt:=0;pRbnQnt:=0;pRboQnt:=0;
  dmSTK.btFIF.IndexName:='GsCode';
  dmSTK.btFIF.FindKey([pGsCode]);
  while not dmSTK.btFIF.Eof and (dmSTK.btFIF.FieldByName('GsCode').AsInteger=pGsCode) do
  begin
    If dmSTK.btFIF.FieldByName('Status').AsString='A' then begin
      If dmSTK.btFIF.FieldByName('RbaCode').AsString=pRbaCode
        then begin
          pRbaQnt:=pRbaQnt+dmSTK.btFIF.FieldByName('ActQnt').AsFloat;
          pRbaDate:=dmSTK.btFIF.FieldByName('RbaDate').AsDateTime;
        end else If dmSTK.btFIF.FieldByName('RbaCode').AsString=''
          then pRbnQnt:=pRbnQnt+dmSTK.btFIF.FieldByName('ActQnt').AsFloat
          else pRboQnt:=pRboQnt+dmSTK.btFIF.FieldByName('ActQnt').AsFloat;
    end;
    dmSTK.btFIF.Next;
  end;
  Result:=Eq3(pQnt,pRbaQnt) or (pQnt<pRbaQnt);
end;

// **************************** IsdCrdValCalc ***************************

procedure TIsdCrdValCalc.CrdValCalc(pDocNum:Str12;pDocDate:TDateTime);
var mYear:Str4;  mOpen:boolean; mBookNum:Str5;
begin
  oEyCrdVal:=0;
  mYear:=YearL(pDocDate);
  mOpen:=dmLDG.btRCIS.Active;
  mBookNum:=dmLDG.btRCIS.BookNum;
  Repeat
    dmLDG.OpenBook (dmLDG.btRCIS,mYear);
    dmLDG.btRCIS.IndexName:='DocNum';
    If dmLDG.btRCIS.FindKey ([pDocNum]) then oEyCrdVal:=oEyCrdVal+dmLDG.btRCIS.FieldByName('EyCrdVal').AsFloat;
    dmLDG.btRCIS.Close;
    mYear:=StrInt(ValInt(mYear)+1,4);
  until mYear>gvSys.ActYear;
  If mOpen then dmLDG.OpenBook (dmLDG.btRCIS,mBookNum);
end;

// **************************** IcdCrdValCalc ***************************

procedure TIcdCrdValCalc.CrdValCalc(pDocNum:Str12;pDocDate:TDateTime);
var mYear:Str4;  mOpen:boolean; mBookNum:Str5;
begin
  oEyCrdVal:=0;
  mYear:=YearL(pDocDate);
  mOpen:=dmLDG.btRCIC.Active;
  mBookNum:=dmLDG.btRCIC.BookNum;
  Repeat
    dmLDG.OpenBook (dmLDG.btRCIC,mYear);
    dmLDG.btRCIC.IndexName:='DocNum';
    If dmLDG.btRCIC.FindKey ([pDocNum]) then oEyCrdVal:=oEyCrdVal+dmLDG.btRCIC.FieldByName('EyCrdVal').AsFloat;
    dmLDG.btRCIC.Close;
    mYear:=StrInt(ValInt(mYear)+1,4);
  until mYear>gvSys.ActYear;
  If mOpen then dmLDG.OpenBook (dmLDG.btRCIC,mBookNum);
end;

// *******************************************************************

function GenSoDocNum; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='BV'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenPoDocNum; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='PO'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenPqDocNum; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='PQ'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenCsDocNum; // Hodnota funkcie je interne cislo dokladu
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  If pDocType='I'
    then Result:='PP'+pYear+pBookNum+StrIntZero(pSerNum,5)
    else Result:='PV'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

function GenIdDocNum (pYear:Str2; pBookNum:Str5; pSerNum:longint): Str12; // Hodnota funkcie je interne cislo ID
begin
  If pYear = '' then pYear:=gvSys.ActYear2; If Length(pBookNum)=5 then pBookNum:=copy(pBookNum,3,3);
  Result:='ID'+pYear+pBookNum+StrIntZero(pSerNum,5);
end;

procedure DelNotice (pTable:TNexBtrTable;pDocNum:Str12);
begin
  pTable.FindNearest ([pDocNum]);
  If pTable.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      pTable.Delete;
    until (pTable.Eof) or (pTable.RecordCount=0) or (pTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

procedure SaveNotice (pTable:TNexBtrTable;pDocNum:Str12;pNotType:Str1;pNotice:TStrings);
var I:word;
begin
  DelNotice (pTable,pDocNum); // Vymazeme existujuce poznamky
  If pNotice.Count>0 then begin
    For I:=0 to pNotice.Count-1 do begin
      pTable.Insert;
      pTable.FieldByname ('DocNum').AsString:=pDocNum;
      pTable.FieldByname ('NotType').AsString:=pNotType;
      pTable.FieldByname ('LinNum').AsInteger:=I;
      pTable.FieldByname ('Notice').AsString:=pNotice[I];
      pTable.Post;
    end;
  end;
end;

procedure LoadNotice (pTable:TNexBtrTable;pDocNum:Str12;pNotType:Str1;pNotice:TStrings);
begin
  pNotice.Clear;
  pTable.FindNearest ([pDocNum,pNotType]);
  If pTable.FieldByName ('DocNum').AsString=pDocNum then begin
    Repeat
      If pTable.FieldByName ('NotType').AsString=pNotType then pNotice.Add(pTable.FieldByName ('Notice').AsString);
      Application.ProcessMessages;
      pTable.Next;
    until (pTable.Eof) or (pTable.FieldByName('DocNum').AsString<>pDocNum);
  end;
end;

// ********************** ODBERATELSKE CENOVE PONUKY *********************
// ****** RESERVE ******

procedure UdhReserve (pUDH:TNexBtrTable;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  pUDH.Insert;
  pUDH.FieldByName ('SerNum').AsInteger:=pSerNum;
  pUDH.FieldByName ('DocNum').AsString:=pDocNum;
  pUDH.FieldByName ('DocDate').AsDateTime:=Date;
  pUDH.FieldByName ('DstLck').AsInteger:=9;
  pUDH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  pUDH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  pUDH.Post;
end;

procedure TchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  dmSTK.btTCH.Insert;
  dmSTK.btTCH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btTCH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btTCH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btTCH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btTCH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btTCH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btTCH.Post;
end;

procedure SchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  dmSTK.btSCH.Insert;
  dmSTK.btSCH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btSCH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btSCH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btSCH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btSCH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btSCH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btSCH.Post;
end;

procedure MchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky cenovej ponuky
begin
  dmSTK.btMCH.Insert;
  dmSTK.btMCH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btMCH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btMCH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btMCH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btMCH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btMCH.Post;
end;

procedure ImhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SP v knihe ktora je otvorena
begin
  If pYear = '' then begin
    pYear:=gvSys.ActYear2;
  end;
  dmSTK.btIMH.Insert;
  dmSTK.btIMH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btIMH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btIMH.FieldByName ('Year').AsString:=pYear;
  dmSTK.btIMH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btIMH.FieldByName ('Describe').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btIMH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btIMH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btIMH.Post;
end;

procedure OmhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SV v knihe ktora je otvorena
begin
  If pYear = '' then begin
    pYear:=gvSys.ActYear2;
  end;
  dmSTK.btOMH.Insert;
  dmSTK.btOMH.FieldByName ('Year').AsString:=pYear;
  dmSTK.btOMH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btOMH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btOMH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btOMH.FieldByName ('Describe').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btOMH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btOMH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btOMH.Post;
end;

procedure RmhReserve (pYear:Str2;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SV v knihe ktora je otvorena
begin
  If pYear = '' then begin
    pYear:=gvSys.ActYear2;
  end;
  dmSTK.btRMH.Insert;
  dmSTK.btRMH.FieldByName ('Year').AsString:=pYear;
  dmSTK.btRMH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btRMH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btRMH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btRMH.FieldByName ('Describe').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btRMH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btRMH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btRMH.Post;
end;

procedure CmhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku SV v knihe ktora je otvorena
begin
  dmSTK.btCMH.Insert;
  dmSTK.btCMH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btCMH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btCMH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btCMH.FieldByName ('GsName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btCMH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btCMH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btCMH.Post;
end;

procedure DmhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicku DR v knihe ktora je otvorena
begin
  dmSTK.btDMH.Insert;
  dmSTK.btDMH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btDMH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btDMH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btDMH.FieldByName ('GsName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btDMH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btDMH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btDMH.Post;
end;

procedure PchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky zalohovej FA v knihe ktora je otvorena
begin
  dmSTK.btPCH.Insert;
  dmSTK.btPCH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btPCH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btPCH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btPCH.FieldByName ('RspUser').AsString:=gvSys.LoginName;
  dmSTK.btPCH.FieldByName ('RspName').AsString:=gvSys.UserName;
  dmSTK.btPCH.Post;
end;

procedure OwhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  dmLDG.btOWH.Insert;
  dmLDG.btOWH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmLDG.btOWH.FieldByName ('DocNum').AsString:=pDocNum;
  dmLDG.btOWH.FieldByName ('DocDate').AsDateTime:=Date;
  dmLDG.btOWH.FieldByName ('DstLck').AsInteger:=9;
  dmLDG.btOWH.FieldByName ('EpName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmLDG.btOWH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmLDG.btOWH.Post;
end;

procedure AlhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  dmSTK.btALH.Insert;
  dmSTK.btALH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btALH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btALH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btALH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btALH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btALH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btALH.Post;
end;

procedure PkhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky prebalovacieho dokladu v knihe ktora je otvorena
begin
  dmSTK.btPKH.Insert;
  dmSTK.btPKH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btPKH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btPKH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btPKH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btPKH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btPKH.Post;
end;

procedure CDhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky prebalovacieho dokladu v knihe ktora je otvorena
begin
  dmSTK.btCDH.Insert;
  dmSTK.btCDH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btCDH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btCDH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btCDH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btCDH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btCDH.Post;
end;

procedure RehReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky precenovacieho dokladu
begin
  dmSTK.btREH.Insert;
  dmSTK.btREH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btREH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btREH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btREH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btREH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btREH.Post;
end;

procedure AchReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky precenovacieho dokladu
begin
  dmSTK.btACH.Insert;
  dmSTK.btACH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btACH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btACH.FieldByName ('BegDate').AsDateTime:=Date;
  dmSTK.btACH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btACH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btACH.Post;
end;

procedure PshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky planu objednavok
begin
  dmSTK.btPSH.Insert;
  dmSTK.btPSH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btPSH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btPSH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btPSH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btPSH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btPSH.Post;
end;

procedure TshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky DDL v knihe ktora je otvorena
begin
  dmSTK.btTSH.Insert;
  dmSTK.btTSH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmSTK.btTSH.FieldByName ('DocNum').AsString:=pDocNum;
  dmSTK.btTSH.FieldByName ('DocDate').AsDateTime:=Date;
  dmSTK.btTSH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmSTK.btTSH.FieldByName ('DstLck').AsInteger:=9;
  dmSTK.btTSH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmSTK.btTSH.Post;
end;

procedure IchReserve (pICH:TNexBtrTable;pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky odberatelskeho DL v knihe ktora je otvorena
begin
  pICH.Insert;
  pICH.FieldByName ('SerNum').AsInteger:=pSerNum;
  pICH.FieldByName ('DocNum').AsString:=pDocNum;
  pICH.FieldByName ('DocDate').AsDateTime:=Date;
  pICH.FieldByName ('DstLck').AsInteger:=9;
  pICH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  pICH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  pICH.Post;
end;

procedure IdhReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky ID v knihe ktora je otvorena
begin
  dmLDG.btIDH.Insert;
  dmLDG.btIDH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmLDG.btIDH.FieldByName ('DocNum').AsString:=pDocNum;
  dmLDG.btIDH.FieldByName ('DocDate').AsDateTime:=Date;
  dmLDG.btIDH.FieldByName ('DstLck').AsInteger:=9;
  dmLDG.btIDH.FieldByName ('Describe').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmLDG.btIDH.Post;
end;

procedure IshReserve (pSerNum:longint;pDocNum:Str12); // Zarezervuje hlavicky DF v knihe ktora je otvorena
begin
  dmLDG.btISH.Insert;
  dmLDG.btISH.FieldByName ('SerNum').AsInteger:=pSerNum;
  dmLDG.btISH.FieldByName ('DocNum').AsString:=pDocNum;
  dmLDG.btISH.FieldByName ('DocDate').AsDateTime:=Date;
  dmLDG.btISH.FieldByName ('DstLck').AsInteger:=9;
  dmLDG.btISH.FieldByName ('PaName').AsString:=gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  dmLDG.btISH.FieldByName ('CrtUser').AsString:=gvSys.LoginName;
  dmLDG.btISH.Post;
end;

// ****** UNRESERVE ******

procedure MchUnReserve; // Zrusi rezervaciu hlavicky CP
begin
  try
    If MchIsMyReserve then dmSTK.btMCH.Delete;
  finally end;
end;

procedure ImhUnReserve; // Zrusi rezervaciu hlavicky SP
begin
  try
    If ImhIsMyReserve then dmSTK.btIMH.Delete;  // Vymazeme rezervaciu
  finally end;
end;

procedure OmhUnReserve; // Zrusi rezervaciu hlavicky SV
begin
  try
    If OmhIsMyReserve then dmSTK.btOMH.Delete;
  finally end;
end;

procedure RmhUnReserve; // Zrusi rezervaciu hlavicky MP
begin
  try
    If RmhIsMyReserve then dmSTK.btRMH.Delete;
  finally end;
end;

procedure CmhUnReserve; // Zrusi rezervaciu hlavicky DK
begin
  try
    If CmhIsMyReserve then dmSTK.btCMH.Delete;
  finally end;
end;

procedure DmhUnReserve; // Zrusi rezervaciu hlavicky DR
begin
  try
    If DmhIsMyReserve then dmSTK.btDMH.Delete;
  finally end;
end;

procedure PchUnReserve; // Zrusi rezervaciu hlavicky zalohovej FA
begin
  try
    If PchIsMyReserve then dmSTK.btPCH.Delete;
  finally end;
end;

procedure OwhUnReserve; // Zrusi rezervaciu hlavicky SZ
begin
  try
    If OwhIsMyReserve then dmLDG.btOWH.Delete;
  finally end;
end;

procedure PkhUnReserve; // Zrusi rezervaciu hlavicky prebalovacieho dokladu
begin
  try
    If PkhIsMyReserve then dmSTK.btPKH.Delete;
  finally end;
end;

procedure CDhUnReserve; // Zrusi rezervaciu hlavicky prebalovacieho dokladu
begin
  try
    If CDhIsMyReserve then dmSTK.btCDH.Delete;
  finally end;
end;

procedure RehUnReserve; // Zrusi rezervaciu hlavicky pecenovacieho dokladu
begin
  try
    If RehIsMyReserve then dmSTK.btREH.Delete;
  finally end;
end;

procedure AchUnReserve; // Zrusi rezervaciu hlavicky pecenovacieho dokladu
begin
  try
    If AchIsMyReserve then dmSTK.btACH.Delete;
  finally end;
end;

procedure PshUnReserve; // Zrusi rezervaciu hlavicky pecenovacieho dokladu
begin
  try
    If PshIsMyReserve then dmSTK.btPSH.Delete;
  finally end;
end;

procedure AlhUnReserve; // Zrusi rezervaciu hlavicky ZN
begin
  try
    If AlhIsMyReserve then dmSTK.btALH.Delete;
  finally end;
end;

procedure TchUnReserve; // Zrusi rezervaciu hlavicky ODL
begin
  try
    If TchIsMyReserve then dmSTK.btTCH.Delete;
  finally end;
end;

procedure SchUnReserve; // Zrusi rezervaciu hlavicky SZ
begin
  try
    If SchIsMyReserve then dmSTK.btSCH.Delete;
  finally end;
end;

procedure TshUnReserve; // Zrusi rezervaciu hlavicky DDL
begin
  try
    If TshIsMyReserve then dmSTK.btTSH.Delete;
  finally end;
end;

procedure UdhUnReserve (pUDH:TNexBtrTable); // Zrusi rezervaciu hlavicky OF
begin
  try
    If UdhIsMyReserve (pUDH) then pUDH.Delete;
  finally end;
end;

procedure IchUnReserve (pICH:TNexBtrTable); // Zrusi rezervaciu hlavicky OF
begin
  try
    If IchIsMyReserve (pICH) then pICH.Delete;
  finally end;
end;

procedure IdhUnReserve; // Zrusi rezervaciu hlavicky ID
begin
  try
    If IdhIsMyReserve then dmLDG.btIDH.Delete;
  finally end;
end;

procedure IshUnReserve; // Zrusi rezervaciu hlavicky DF
begin
  try
    If IshIsMyReserve then dmLDG.btISH.Delete;
  finally end;
end;

// ****** ISMYRESERVE ******

function ImhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btIMH.Active then Result:=(dmSTK.btIMH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btIMH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function OmhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btOMH.Active then Result:=(dmSTK.btOMH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btOMH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function RmhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btRMH.Active then Result:=(dmSTK.btRMH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btRMH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function CmhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btCMH.Active then Result:=(dmSTK.btCMH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btCMH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function DmhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btDMH.Active then Result:=(dmSTK.btDMH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btDMH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function UdhIsMyReserve (pUDH:TNexBtrTable): boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If pUDH.Active then Result:=(pUDH.FieldByName ('DstLck').AsInteger=9) and (pUDH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function TchIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btTCH.Active then Result:=(dmSTK.btTCH.FieldByName('DstLck').AsInteger=9) and (dmSTK.btTCH.FieldByName ('CrtUser').AsString=gvSys.LoginName) and (dmSTK.btTCH.FieldByName ('DstLck').AsInteger=9);
end;

function SchIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btSCH.Active then Result:=(dmSTK.btSCH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btSCH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function MchIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btMCH.Active then Result:=(dmSTK.btMCH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btMCH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function PchIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btPCH.Active then Result:=(dmSTK.btPCH.FieldByName ('DocNum').AsString='RESERVED') and (dmSTK.btPCH.FieldByName ('RspUser').AsString=gvSys.LoginName);
end;

function OwhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmLDG.btOWH.Active then Result:=(dmLDG.btOWH.FieldByName ('DstLck').AsInteger=9) and (dmLDG.btOWH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function AlhIsMyReserve: boolean; //TRUE ak je doklad reervovany a zerzervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btALH.Active then Result:=(dmSTK.btALH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btALH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function PkhIsMyReserve: boolean; //TRUE ak je dokald reervovany a rezervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btPKH.Active then Result:=(dmSTK.btPKH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btPKH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function CDhIsMyReserve: boolean; //TRUE ak je dokald reervovany a rezervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btCDH.Active then Result:=(dmSTK.btCDH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btCDH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function RehIsMyReserve: boolean; //TRUE ak je dokald reervovany a rezervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btREH.Active then Result:=(dmSTK.btREH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btREH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function AchIsMyReserve: boolean; //TRUE ak je dokald reervovany a rezervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btACH.Active then Result:=(dmSTK.btACH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btACH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function PshIsMyReserve: boolean; //TRUE ak je dokald reervovany a rezervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btPSH.Active then Result:=(dmSTK.btPSH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btPSH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function TshIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmSTK.btTSH.Active then Result:=(dmSTK.btTSH.FieldByName ('DstLck').AsInteger=9) and (dmSTK.btTSH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function IchIsMyReserve (pICH:TNexBtrTable): boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If pICH.Active then Result:=(pICH.FieldByName ('DstLck').AsInteger=9) and (pICH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function IdhIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmLDG.btIDH.Active then Result:=(dmLDG.btIDH.FieldByName ('DstLck').AsInteger=9) and (dmLDG.btIDH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

function IshIsMyReserve: boolean; //TRUE ak je doklad reervovany a eervoval dany uzivatel
begin
  Result:=FALSE;
  If dmLDG.btISH.Active then Result:=(dmLDG.btISH.FieldByName ('DstLck').AsInteger=9) and (dmLDG.btISH.FieldByName ('CrtUser').AsString=gvSys.LoginName);
end;

// ****** ISRESERVED ******

function MchIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btMCH.Active then Result:=(dmSTK.btMCH.FieldByName ('DstLck').AsInteger=9);
end;

function IchIsReserved (pICH:TNexBtrTable): boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If pICH.Active then Result:=(pICH.FieldByName ('DstLck').AsInteger=9);
end;

function IdhIsReserved (pIDH:TNexBtrTable): boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If pIDH.Active then Result:=(pIDH.FieldByName ('DstLck').AsInteger=9);
end;

function TchIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btTCH.Active then Result:=(dmSTK.btTCH.FieldByName ('DstLck').AsInteger=9);
end;

function SchIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btSCH.Active then Result:=(dmSTK.btSCH.FieldByName ('DstLck').AsInteger=9);
end;

function OwhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmLDG.btOWH.Active then Result:=(dmLDG.btOWH.FieldByName ('DstLck').AsInteger=9);
end;

function TshIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btTSH.Active then Result:=(dmSTK.btTSH.FieldByName ('DstLck').AsInteger=9);
end;

function UdhIsReserved (pUDH:TNexBtrTable): boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If pUDH.Active then Result:=(pUDH.FieldByName ('DstLck').AsInteger=9);
end;

function ImhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btIMH.Active then Result:=(dmSTK.btIMH.FieldByName ('DstLck').AsInteger=9);
end;

function OmhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btOMH.Active then Result:=(dmSTK.btOMH.FieldByName ('DstLck').AsInteger=9);
end;

function RmhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btRMH.Active then Result:=(dmSTK.btRMH.FieldByName ('DstLck').AsInteger=9);
end;

function CmhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btCMH.Active then Result:=(dmSTK.btCMH.FieldByName ('DstLck').AsInteger=9);
end;

function DmhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btDMH.Active then Result:=(dmSTK.btDMH.FieldByName ('DstLck').AsInteger=9);
end;

function PkhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btPKH.Active then Result:=(dmSTK.btPKH.FieldByName ('DstLck').AsInteger=9);
end;

function CDhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btCDH.Active then Result:=(dmSTK.btCDH.FieldByName ('DstLck').AsInteger=9);
end;

function RehIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btREH.Active then Result:=(dmSTK.btREH.FieldByName ('DstLck').AsInteger=9);
end;

function AchIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btACH.Active then Result:=(dmSTK.btACH.FieldByName ('DstLck').AsInteger=9);
end;

function PshIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btPSH.Active then Result:=(dmSTK.btPSH.FieldByName ('DstLck').AsInteger=9);
end;

function AlhIsReserved: boolean; //TRUE ak je doklad reervovany
begin
  Result:=FALSE;
  If dmSTK.btALH.Active then Result:=(dmSTK.btALH.FieldByName ('DstLck').AsInteger=9);
end;

function VtrLstYearSerNum:Str5;
begin
  Result:='';
  If not dmLDG.btVTRLST.Active then Exit;
  Result:=dmLDG.btVTRLST.fieldByName('Year').AsString+StrIntZero(dmLDG.btVTRLST.fieldByName('ClsNum').AsInteger,3);
end;

end.

