unit OcmFnc;
// =============================================================================
//                      FUNKCIE PRE ODBERATEºSK… Z¡KAZKY
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************* POUéIT… DATAB¡ZOV… S⁄BORY *************************
// -----------------------------------------------------------------------------
// OCILST.BTR - poloûky odberateæsk˝ch z·kaziek
// OCRLST.DB  - z·kazkovÈ rezerv·cie
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÕ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÕ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// LodOcrLst - pre zadan˝ sklad a produkt naËÌta do doËasnÈho s˙boru z·kazkovÈ
//             rezerv·cie zo skladovej z·soby.
//             õ pStkNum - ËÌslo skladu
//             õ pProNum - PLU produktu
// LodOcqLst - pre zadan˝ sklad a produkt naËÌta do doËasnÈho s˙boru zo z·kaziek
//             poûiadavky na objednanie.
//             õ pStkNum - ËÌslo skladu
//             õ pProNum - PLU produktu
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
// õ
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[02.01.2019] - Nov· funkcia (RZ)
// =============================================================================

interface

uses
  BasSrv,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, NexClc, NexGlob, Nexpath, StkGlob, Prp, Rep, Cnt, EmdFnc, ArpFnc,
  hSYSTEM, hPARCAT, hSTCLST, eOCHLST, eOCNLST, eOCILST, eOCIHIS, eOCRLST, eOCRHIS, tOCIPRN, tOCHPRN, tVATSUM, tOCILST, tOCRLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TOcdver=record // Kontroln˝ z·znam na zistenie zmeny v hlaviËke dokladu
    ExtNum:Str12;     CusNum:Str20;     PrjCod:Str20;     CusCrd:Str20;     ReqTyp:Str1;      VatDoc:byte;
    DocDte:TDateTime; ExpDte:TDateTime; ReqDte:TDateTime;
    ParNum:longint;   ParNam:Str60;     RegIno:Str15;     RegTin:Str15;     RegVin:Str15;     RegAdr:Str30;     RegSta:Str2;    RegCtn:Str30;    RegZip:Str15;
    SpaNum:longint;   WpaNum:word;      WpaNam:Str60;     WpaAdr:Str30;     WpaSta:Str2;      WpaCtn:Str30;     WpaZip:Str15;
    CtpNam:Str30;     CtpTel:Str20;     CtpFax:Str20;     CtpEml:Str30;     EmlSnd:byte;      SmsSnd:byte;
    PayCod:Str1;      TrsCod:Str1;      TrsLin:word;
    DlvCit:byte;      DlvCdo:byte;      RcvTyp:Str1;
    VatVal:double;    SalBva:double;    TrsBva:double;    DvzNam:Str3;      DvzCrs:double;    DvzBva:double;    DepBva:double;    DepDte:TDateTime;
    ProVol:double;    ProWgh:double;    SalPrq:double;    ReqPrq:double;    RstPrq:double;    RosPrq:double;    TcdPrq:double;    IcdPrq:double;
    AtcDoq:byte;      TcdNum:Str13;     TcdPrc:byte;      IcdNum:Str13;     IcdPrc:byte;      EcdNum:Str13;     EcdDoq:byte;
    SpcMrk:Str10;     DocDes:Str50;     ItmQnt:word;
  end;

  TOcmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oArp:TArpFnc;
    oActBok:Str3;         // Aktu·lna kniha
    oClcDoc:boolean;      // TRUE ak systÈm pr·ve prepoùÌta z·kazku
    oDocLst:TStrings;     // Zoznam dokladov, ktorÈ boli zmenenÈ
    oOcdVer:TOcdVer;      // Kontroln˝ z·znam na zistenie zmeny v hlaviËke dokladu
    oaOCHLST:TOchlstHne;  // HlaviËky z·kazkov˝ch dokladov - vûdy cel· datab·za bez filtrovania
    oaOCILST:TOcilstHne;  // Poloûky z·kazkov˝ch dokladov - vûdy cel· datab·za bez filtrovania
    ohPARCAT:TParcatHnd;  // Evidencia obchodn˝ch partnerov
    ohOCHLST:TOchlstHne;  // HlaviËky z·kazkov˝ch dokladov
    ohOCILST:TOcilstHne;  // Poloûky z·kazkov˝ch dokladov
    ohOCNLST:TOcnlstHne;  // Pozn·mky z·kazkov˝ch dokladov
    ohOCIHIS:TOcihisHne;  // HistÛria zmeny poloûky
    ohOCRLST:TOcrlstHne;  // Detailn˝ rozpis rezerv·cie
    ohOCRHIS:TOcrhisHne;  // Stav v momente rezerv·cie
    otVATSUM:TVatsumTmp;  // KumulatÌvne hodnoty dokladu podæa sadzieb DPH
    otOCILST:TOcilstTmp;
    otOCRLST:TOcrlstTmp;
    function GetActBok:Str3;  procedure SetActBok(pBokNum:Str3);
    function NewItmAdr(pDocYer:Str2):longint;
    function NewSerNum(pDocYer:Str2):longint;
    function DecSerNum(pDocYer:Str2;pSerNum:longint):boolean; // TRUE ak zadanÈ poradovÈ ËÌslo bolo poslednÈ - v tomto prÌpade znÌûi poradovÈ ËÌslo o 1
    function GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
    function GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;
    function NewItmNum(pDocNum:Str12):longint;
    function VerOcdChg:boolean; // Porovn· ˙daje kontrolnÈho z·znamu s aktu·lnou hlaviËkou z hOCHLST
    function SetDocEdi(pOcdNum:Str12):boolean; // NastavÌ do hlaviËky dokladu ûe je editovan˝ (TRUE-nastaven˝; FALSE-doklad edituje in˝ uûÌvateæ)
    procedure NewDocGen(pParNum,pSpaNum,pWpaNum:longint;pReqDte:TDate);  // VytvorÌ nov˝ z·kazkov˝ doklad pre zadanÈho z·kaznÌka
    procedure ClrDocEdi(pOcdNum:Str12); // ZruöÌ priznak, ûe doklad je editovan˝ na zadanom doklade
    procedure ClrUsrEdi(pUsrLog:Str8);  // ZruöÌ priznak, ûe doklad je editovan˝ pre vöetky doklady, ktorÈ edituje zadan˝ uûÌvateæ
    procedure LodOcdVer; // NaËÌta ˙daje hlaviËky aktu·lneho dokladu do kontrolnÈho z·znamu
    procedure ClcOcdDoc(pDocNum:Str12); // PrepoËÌta hlaviËkovÈ ˙daje odberateæskej z·kazky - pritom overuje hlaviËkovÈ ˙daje v poloûk·ch
    procedure ClcVatSum(pDocNum:Str12); // VypoËÌta kumulatÌvne hodnoty zadanÈho dokladu podæa jednotliv˝ch sadzieb DPH
    procedure AddOcrRos(pOsiAdr:longint;pOsdNum:Str12;pOsdItm:word;pRatDte:TDateTime;pResPrq:double);
    procedure AddOcrRst(pRstPrq:double);
    procedure AddOciHis(pOciAdr:longint;pModTyp:Str1);
    procedure AddTcdPrq(pOcdNum:Str12;pOcdItm:word;pTcdNum:Str12;pTcdItm:word;pTcdDte:TDateTime;pTcdPrq:double); // Prid· na zadan˙ poloûku z·kazky dodanÈ mnoûstvo
    procedure AddDocLst(pDocNum:Str12);  // Prid· ËÌslo z·kazky do zoznamu dokladov, ktorÈ boli zmenenÈ
    procedure DelOcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vymaûe zadanÈ pozn·mkovÈ riadky zadanho typu
    procedure AddOcnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // UloûÌ pozn·mkov˝ riadok do dokladu
    procedure AddOcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // UloûÌ pozn·mkovÈ riadoky do dokladu
    procedure TmpItmRef;  // ObnovÌ ˙daje aktu·lnej poloûky docasnÈho suboru
    procedure ClcDocLst;  // PrepoËÌta vöetky hlaviËky zoznamu vytvorenÈ pomocou AddDocLst
    // ------------------------------------------------------------------------------------------------------------------
    procedure AddPrnNot(ptOCHPRN:TOchprnTmp;pLinNum:byte;pNotice:Str250); // Prid· poznÈmku do zadanÈho riadku
    procedure PrnUndPrq(pParNum:longint); // TlaË nedodanÈho tovaru zadanÈho z·kaznÌka
    procedure PrnOneDoc(pOcdNum:Str12); overload; // TlaË zadanÈho dokladu cez tlaËov˝ manaûÈr
    procedure PrnPdfDoc(pOcdNum,pMasNam:Str12;pParNum:longint;pPrnNum:word;pPdfNam:Str30); overload; // TlaË adanÈho dokladu do PDF s˙boru
    procedure PrnBasDoc(pOcdNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean); overload; // VytlaËÌ zadan˙ z·kazku
              // pDocNum - »Ìslo tlaËenÈho dokumentu
              // pMasNam - N·zov tlaËovej masky
              // pPrnNam - N·zov tlaËiarne
              // pCopies - PoËet vytlaËen˝ch kÛpii
              // pAutPrn - Ak je TRUE potom tlaËÌ bez zobrazenia tlaËovÈho manaûÈra
    // ------------------------------------------------------------------------------------------------------------------
    procedure EmlOcdSnd(pOcdNum:Str12); // VyvorÌ emailov˙ spr·vu a prijatÌ z·kazky
    procedure IncEmlCnt(pOcdNum:Str12); // ZvÌö·me poËÌtadlo odoslan˝ch emailov
    procedure ClrModSta(pOcdNum:Str12); // ZruöÌme prÌznak, ûe doklad bol modifikovan˝
    procedure LodOcrLst(pStkNum:word;pProNum:longint);
    procedure LodOcqLst(pStkNum:word;pProNum:longint);
  published
    property ActBok:Str3 read GetActBok write SetActBok;     // Aktu·lna kniha dokladov
    property DocLst:TStrings read oDocLst;
  end;

implementation

uses OcmPrp, dOCILST;

constructor TOcmFnc.Create;
begin
  oClcDoc:=FALSE;
  oDocLst:=TStringList.Create;  oDocLst.Clear;
  oaOCHLST:=TOchlstHne.Create;
  oaOCILST:=TOcilstHne.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohOCHLST:=TOchlstHne.Create;
  ohOCILST:=TOcilstHne.Create;
  ohOCIHIS:=TOcihisHne.Create;
  ohOCRLST:=TOcrlstHne.Create;
  ohOCRHIS:=TOcrhisHne.Create;
  ohOCNLST:=TOcnlstHne.Create;
  otVATSUM:=TVatsumTmp.Create;
  otOCILST:=TOcilstTmp.Create;
  otOCRLST:=TOcrlstTmp.Create;
  oArp:=TArpFnc.Create;
end;

destructor TOcmFnc.Destroy;
begin
  FreeAndNil(oArp);
  FreeAndNil(otOCRLST);
  FreeAndNil(otOCILST);
  FreeAndNil(otVATSUM);
  FreeAndNil(ohOCNLST);
  FreeAndNil(ohOCRHIS);
  FreeAndNil(ohOCRLST);
  FreeAndNil(ohOCIHIS);
  FreeAndNil(ohOCILST);
  FreeAndNil(ohOCHLST);
  FreeAndNil(ohPARCAT);
  FreeAndNil(oaOCILST);
  FreeAndNil(oaOCHLST);
  FreeAndNil(oDocLst);
end;

// ******************************** PRIVATE ************************************

function TOcmFnc.GetActBok:Str3;
begin
  Result:=oActBok;
//  If Result='' then Result:=ohOCHLST.BokNum;
end;

procedure TOcmFnc.SetActBok(pBokNum:Str3);
begin
  oActBok:=pBokNum;
end;

function TOcmFnc.NewItmAdr(pDocYer:Str2):longint;
begin
  Repeat
    Result:=gCnt.NewItmAdr(pDocYer,'ZK');
    Application.ProcessMessages;
  until not oaOCILST.LocItmAdr(Result);
end;

function TOcmFnc.NewSerNum(pDocYer:Str2):longint;
begin
  Repeat
    Result:=gCnt.NewDocSer(pDocYer,'ZK',ActBok);
  until not oaOCHLST.LocDyBnSn(pDocYer,ActBok,Result);
end;

function TOcmFnc.DecSerNum(pDocYer:Str2;pSerNum:longint):boolean; // TRUE ak zadanÈ poradovÈ ËÌslo bolo poslednÈ - v tomto prÌpade znÌûi poradovÈ ËÌslo o 1
begin
  Result:=gCnt.DecDocSer(pDocYer,'ZK',ActBok,pSernum);
end;

function TOcmFnc.GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:='ZK'+pDocYer+ActBok+StrIntZero(pSerNum,5);
end;

function TOcmFnc.GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:=pDocYer+ActBok+StrIntZero(pSerNum,5); // TODO - Prerobiù generovanie poæa pasky - masku premiestniù do PRP
end;

function TOcmFnc.NewItmNum(pDocNum:Str12):longint;
begin
  Result:=0;
  If ohOCHLST.LocDocNum(pDocNum) then begin
    Result:=ohOCHLST.ItmNum;
    Repeat
      Application.ProcessMessages;
      Inc(Result);
    until not ohOCILST.LocDnIn(ohOCHLST.DocNum,Result);
    ohOCHLST.Edit;
    ohOCHLST.ItmNum:=Result;
    ohOCHLST.Post;
  end;
end;

function TOcmFnc.VerOcdChg:boolean; // Porovn· ˙daje kontrolnÈho z·znamu s aktu·lnou hlaviËkou z hOCHLST
begin
  Result:=(oOcdVer.ExtNum<>ohOCHLST.ExtNum) or (oOcdVer.EmlSnd<>ohOCHLST.EmlSnd) or (oOcdVer.DvzNam<>ohOCHLST.DvzNam) or
          (oOcdVer.CusNum<>ohOCHLST.CusNum) or (oOcdVer.SmsSnd<>ohOCHLST.SmsSnd) or (oOcdVer.DvzCrs<>ohOCHLST.DvzCrs) or
          (oOcdVer.PrjCod<>ohOCHLST.PrjCod) or (oOcdVer.SpaNum<>ohOCHLST.SpaNum) or (oOcdVer.DvzBva<>ohOCHLST.DvzBva) or
          (oOcdVer.DocDte<>ohOCHLST.DocDte) or (oOcdVer.WpaNum<>ohOCHLST.WpaNum) or (oOcdVer.DepBva<>ohOCHLST.DepBva) or
          (oOcdVer.ExpDte<>ohOCHLST.ExpDte) or (oOcdVer.WpaNam<>ohOCHLST.WpaNam) or (oOcdVer.DepDte<>ohOCHLST.DepDte) or
          (oOcdVer.ReqDte<>ohOCHLST.ReqDte) or (oOcdVer.WpaAdr<>ohOCHLST.WpaAdr) or (oOcdVer.SalPrq<>ohOCHLST.SalPrq) or
          (oOcdVer.ReqTyp<>ohOCHLST.ReqTyp) or (oOcdVer.WpaSta<>ohOCHLST.WpaSta) or (oOcdVer.ReqPrq<>ohOCHLST.ReqPrq) or
          (oOcdVer.VatDoc<>ohOCHLST.VatDoc) or (oOcdVer.WpaCtn<>ohOCHLST.WpaCtn) or (oOcdVer.RstPrq<>ohOCHLST.RstPrq) or
          (oOcdVer.CusCrd<>ohOCHLST.CusCrd) or (oOcdVer.WpaZip<>ohOCHLST.WpaZip) or (oOcdVer.RosPrq<>ohOCHLST.RosPrq) or
          (oOcdVer.ParNum<>ohOCHLST.ParNum) or (oOcdVer.PayCod<>ohOCHLST.PayCod) or (oOcdVer.TcdPrq<>ohOCHLST.TcdPrq) or
          (oOcdVer.ParNam<>ohOCHLST.ParNam) or (oOcdVer.TrsCod<>ohOCHLST.TrsCod) or (oOcdVer.IcdPrq<>ohOCHLST.IcdPrq) or
          (oOcdVer.RegIno<>ohOCHLST.RegIno) or (oOcdVer.TrsLin<>ohOCHLST.TrsLin) or (oOcdVer.SpcMrk<>ohOCHLST.SpcMrk) or
          (oOcdVer.RegTin<>ohOCHLST.RegTin) or (oOcdVer.DlvCit<>ohOCHLST.DlvCit) or (oOcdVer.AtcDoq<>ohOCHLST.AtcDoq) or
          (oOcdVer.RegVin<>ohOCHLST.RegVin) or (oOcdVer.DlvCdo<>ohOCHLST.DlvCdo) or (oOcdVer.TcdNum<>ohOCHLST.TcdNum) or
          (oOcdVer.RegAdr<>ohOCHLST.RegAdr) or (oOcdVer.RcvTyp<>ohOCHLST.RcvTyp) or (oOcdVer.TcdPrc<>ohOCHLST.TcdPrc) or
          (oOcdVer.RegSta<>ohOCHLST.RegSta) or (oOcdVer.ItmQnt<>ohOCHLST.ItmQnt) or (oOcdVer.IcdNum<>ohOCHLST.IcdNum) or
          (oOcdVer.RegCtn<>ohOCHLST.RegCtn) or (oOcdVer.ProVol<>ohOCHLST.ProVol) or (oOcdVer.IcdPrc<>ohOCHLST.IcdPrc) or
          (oOcdVer.RegZip<>ohOCHLST.RegZip) or (oOcdVer.ProWgh<>ohOCHLST.ProWgh) or (oOcdVer.EcdNum<>ohOCHLST.EcdNum) or
          (oOcdVer.CtpNam<>ohOCHLST.CtpNam) or (oOcdVer.VatVal<>ohOCHLST.VatVal) or (oOcdVer.EcdDoq<>ohOCHLST.EcdDoq) or
          (oOcdVer.CtpTel<>ohOCHLST.CtpTel) or (oOcdVer.SalBva<>ohOCHLST.SalBva) or (oOcdVer.DocDes<>ohOCHLST.DocDes) or
          (oOcdVer.CtpFax<>ohOCHLST.CtpFax) or (oOcdVer.CtpEml<>ohOCHLST.CtpEml) or (oOcdVer.TrsBva<>ohOCHLST.TrsBva);
end;

function TOcmFnc.SetDocEdi(pOcdNum:Str12):boolean;
var mFre:boolean;  mMin:longint;
begin
  Result:=FALSE;
  ohOCHLST.Table.Refresh;
  If ohOCHLST.DocNum<>pOcdNum then ohOCHLST.LocDocNum(pOcdNum);
  If ohOCHLST.DocNum=pOcdNum then begin
    mFre:=(ohOCHLST.EdiUsr='') or (ohOCHLST.EdiUsr=gvSys.LoginName);
    If not mFre then mFre:=MinutesBetween(Time,ohOCHLST.EdiTim)>60;
    If mFre then begin
      Result:=TRUE;
      ohOCHLST.Edit;
      ohOCHLST.EdiUsr:=gvSys.LoginName;
      ohOCHLST.EdiDte:=Date;
      ohOCHLST.EdiTim:=Time;
      ohOCHLST.Post;
    end;
  end;
end;

procedure TOcmFnc.NewDocGen(pParNum,pSpaNum,pWpaNum:longint;pReqDte:TDate);  // VytvorÌ nov˝ z·kazkov˝ doklad pre zadanÈho z·kaznÌka
var mDocYer:Str2;  mSerNum:longint;  mDocNum,mExtNum:Str12;
begin
  mDocYer:=SysYear;
  mSerNum:=NewSerNum(mDocYer);
  mDocNum:=GenDocNum(mDocYer,mSerNum);
  mExtNum:=GenExtNum(mDocYer,mSerNum);
  ohOCHLST.Insert;
  ohOCHLST.BokNum:=ActBok;
  ohOCHLST.DocYer:=mDocYer;
  ohOCHLST.SerNum:=mSerNum;
  ohOCHLST.DocNum:=mDocNum;
  ohOCHLST.ExtNum:=mExtNum;
  ohOCHLST.DocDte:=Date;
  ohOCHLST.ReqDte:=pReqDte;
  ohOCHLST.StkNum:=gPrp.Ocm.StkNum[ActBok];
  ohOCHLST.ParNum:=pParNum;
  If ohPARCAT.LocParNum(pParNum) then begin
    ohOCHLST.ParNam:=ohPARCAT.ParNam;
    ohOCHLST.RegIno:=ohPARCAT.RegIno;
    ohOCHLST.RegTin:=ohPARCAT.RegTin;
    ohOCHLST.RegVin:=ohPARCAT.RegVin;
    ohOCHLST.RegAdr:=ohPARCAT.RegAdr;
    ohOCHLST.RegSta:=ohPARCAT.RegStc;
    ohOCHLST.RegCty:=ohPARCAT.RegCtc;
    ohOCHLST.RegCtn:=ohPARCAT.RegCtn;
    ohOCHLST.RegZip:=ohPARCAT.RegZip;
    ohOCHLST.TrsCod:=ohPARCAT.CusTrsCod;
    ohOCHLST.TrsNam:=ohPARCAT.CusTrsNam;
    ohOCHLST.CtpEml:=ohPARCAT.RegEml;
  end;
  ohOCHLST.SpaNum:=pSpaNum;
  ohOCHLST.WpaNum:=pWpaNum;
  If ohPARCAT.LocParNum(pSpaNum) and (pWpaNum=0) then begin
    ohOCHLST.WpaNam:=ohPARCAT.ParNam;
    ohOCHLST.WpaAdr:=ohPARCAT.RegAdr;
    ohOCHLST.WpaCty:=ohPARCAT.RegCtn;
    ohOCHLST.WpaCtn:=ohPARCAT.RegCtc;
    ohOCHLST.WpaZip:=ohPARCAT.RegZip;
    ohOCHLST.WpaSta:=ohPARCAT.RegStc;
  end;
//  ohOCHLST.DlvCit:=byte(E_ComDlv.Checked);
//  If E_ComDlv.Checked then ohOCHLST.RcvTyp:='O';
  ohOCHLST.VatDoc:=1;
  ohOCHLST.CrtUsr:=gvSys.LoginName;
  ohOCHLST.CrtUsn:=gvSys.UserName;
  ohOCHLST.CrtDte:=Date;
  ohOCHLST.CrtTim:=Time;     
  ohOCHLST.DstLck:='';
  ohOCHLST.Post;
end;

procedure TOcmFnc.ClrDocEdi(pOcdNum:Str12);
begin
  If pOcdNum<>'' then begin
    ohOCHLST.Table.Refresh;
    If ohOCHLST.DocNum<>pOcdNum then ohOCHLST.LocDocNum(pOcdNum);
    If ohOCHLST.DocNum=pOcdNum then begin
      ohOCHLST.Edit;
      ohOCHLST.EdiUsr:='';
      ohOCHLST.EdiDte:=0;
      ohOCHLST.EdiTim:=0;
      ohOCHLST.Post;
    end;
  end;
end;

procedure TOcmFnc.ClrUsrEdi(pUsrLog:Str8);  // ZruöÌ priznak, ûe doklad je editovan˝ pre v3etky doklady, ktorÈ edituje zadan˝ uûÌvateæ
begin
  If ohOCHLST.LocEdiUsr(pUsrLog) then begin
    Repeat
      ohOCHLST.Edit;
      ohOCHLST.EdiUsr:='';
      ohOCHLST.EdiDte:=0;
      ohOCHLST.EdiTim:=0;
      ohOCHLST.Post;
      Application.ProcessMessages;
      ohOCHLST.Next;
    until ohOCHLST.Eof or (ohOCHLST.EdiUsr<>pUsrLog);
  end;
end;

procedure TOcmFnc.LodOcdVer; // NaËÌta ˙daje hlaviËky aktu·lneho dokladu do kontrolnÈho z·znamu
begin
  ohOCHLST.Table.Refresh;
  oOcdVer.ExtNum:=ohOCHLST.ExtNum;       oOcdVer.EmlSnd:=ohOCHLST.EmlSnd;       oOcdVer.DvzNam:=ohOCHLST.DvzNam;
  oOcdVer.CusNum:=ohOCHLST.CusNum;       oOcdVer.SmsSnd:=ohOCHLST.SmsSnd;       oOcdVer.DvzCrs:=ohOCHLST.DvzCrs;
  oOcdVer.PrjCod:=ohOCHLST.PrjCod;       oOcdVer.SpaNum:=ohOCHLST.SpaNum;       oOcdVer.DvzBva:=ohOCHLST.DvzBva;
  oOcdVer.DocDte:=ohOCHLST.DocDte;       oOcdVer.WpaNum:=ohOCHLST.WpaNum;       oOcdVer.DepBva:=ohOCHLST.DepBva;
  oOcdVer.ExpDte:=ohOCHLST.ExpDte;       oOcdVer.WpaNam:=ohOCHLST.WpaNam;       oOcdVer.DepDte:=ohOCHLST.DepDte;
  oOcdVer.ReqDte:=ohOCHLST.ReqDte;       oOcdVer.WpaAdr:=ohOCHLST.WpaAdr;       oOcdVer.SalPrq:=ohOCHLST.SalPrq;
  oOcdVer.ReqTyp:=ohOCHLST.ReqTyp;       oOcdVer.WpaSta:=ohOCHLST.WpaSta;       oOcdVer.ReqPrq:=ohOCHLST.ReqPrq;
  oOcdVer.VatDoc:=ohOCHLST.VatDoc;       oOcdVer.WpaCtn:=ohOCHLST.WpaCtn;       oOcdVer.RstPrq:=ohOCHLST.RstPrq;
  oOcdVer.CusCrd:=ohOCHLST.CusCrd;       oOcdVer.WpaZip:=ohOCHLST.WpaZip;       oOcdVer.RosPrq:=ohOCHLST.RosPrq;
  oOcdVer.ParNum:=ohOCHLST.ParNum;       oOcdVer.PayCod:=ohOCHLST.PayCod;       oOcdVer.TcdPrq:=ohOCHLST.TcdPrq;
  oOcdVer.ParNam:=ohOCHLST.ParNam;       oOcdVer.TrsCod:=ohOCHLST.TrsCod;       oOcdVer.IcdPrq:=ohOCHLST.IcdPrq;
  oOcdVer.RegIno:=ohOCHLST.RegIno;       oOcdVer.TrsLin:=ohOCHLST.TrsLin;       oOcdVer.SpcMrk:=ohOCHLST.SpcMrk;
  oOcdVer.RegTin:=ohOCHLST.RegTin;       oOcdVer.DlvCit:=ohOCHLST.DlvCit;       oOcdVer.AtcDoq:=ohOCHLST.AtcDoq;
  oOcdVer.RegVin:=ohOCHLST.RegVin;       oOcdVer.DlvCdo:=ohOCHLST.DlvCdo;       oOcdVer.TcdNum:=ohOCHLST.TcdNum;
  oOcdVer.RegAdr:=ohOCHLST.RegAdr;       oOcdVer.RcvTyp:=ohOCHLST.RcvTyp;       oOcdVer.TcdPrc:=ohOCHLST.TcdPrc;
  oOcdVer.RegSta:=ohOCHLST.RegSta;       oOcdVer.ItmQnt:=ohOCHLST.ItmQnt;       oOcdVer.IcdNum:=ohOCHLST.IcdNum;
  oOcdVer.RegCtn:=ohOCHLST.RegCtn;       oOcdVer.ProVol:=ohOCHLST.ProVol;       oOcdVer.IcdPrc:=ohOCHLST.IcdPrc;
  oOcdVer.RegZip:=ohOCHLST.RegZip;       oOcdVer.ProWgh:=ohOCHLST.ProWgh;       oOcdVer.EcdNum:=ohOCHLST.EcdNum;
  oOcdVer.CtpNam:=ohOCHLST.CtpNam;       oOcdVer.VatVal:=ohOCHLST.VatVal;       oOcdVer.EcdDoq:=ohOCHLST.EcdDoq;
  oOcdVer.CtpTel:=ohOCHLST.CtpTel;       oOcdVer.SalBva:=ohOCHLST.SalBva;       oOcdVer.DocDes:=ohOCHLST.DocDes;
  oOcdVer.CtpFax:=ohOCHLST.CtpFax;       oOcdVer.TrsBva:=ohOCHLST.TrsBva;
  oOcdVer.CtpEml:=ohOCHLST.CtpEml;
end;

procedure TOcmFnc.ClcOcdDoc(pDocNum:Str12); // PrepoËÌta hlaviËkovÈ ˙daje odberateöskej z·kazky - pritom overuje hlaviËkovÈ ˙daje v poloûk·ch
var mStkAva,mProAva,mSrvAva,mSalAva,mSalBva,mTrsBva,mDvzBva:double;  mSalPrq,mReqPrq,mRstPrq,mRosPrq,mExdPrq,mTcdPrq,mUndPrq,mCncPrq,mIcdPrq:double;
    mItmQnt,mItmNum:word; mProVol,mProWgh:double;  mDstMod:Str1;     mIcdNum,mTcdNum,mEcdNum:Str13;
begin
  oaOCHLST.SwapIndex;
  If oaOCHLST.DocNum<>pDocNum then oaOCHLST.LocDocNum(pDocNum);
  oaOCHLST.RestIndex;
  If oaOCHLST.DocNum=pDocNum then begin
    mIcdNum:=''; mTcdNum:=''; mEcdNum:='';
    mItmQnt:=0;  mItmNum:=0;  mProVol:=0;  mProWgh:=0;
    mSalPrq:=0;  mReqPrq:=0;  mRstPrq:=0;  mRosPrq:=0;  mExdPrq:=0;  mTcdPrq:=0;  mCncPrq:=0;  mUndPrq:=0;  mIcdPrq:=0;
    mStkAva:=0;  mProAva:=0;  mSrvAva:=0;  mSalAva:=0;  mSalBva:=0;  mTrsBva:=0;  mDvzBva:=0;  mDstMod:='';
    ohOCILST.SwapStatus;
    If ohOCILST.LocDocNum(pDocNum) then begin
      Repeat
        Inc(mItmQnt);
        mProVol:=mProVol+ohOCILST.ProVol*ohOCILST.SalPrq;
        mProWgh:=mProWgh+ohOCILST.ProWgh*ohOCILST.SalPrq;
        mSalPrq:=mSalPrq+ohOCILST.SalPrq;
        mReqPrq:=mReqPrq+ohOCILST.ReqPrq;
        mRstPrq:=mRstPrq+ohOCILST.RstPrq;
        mRosPrq:=mRosPrq+ohOCILST.RosPrq;
        mExdPrq:=mExdPrq+ohOCILST.ExdPrq;
        mTcdPrq:=mTcdPrq+ohOCILST.TcdPrq;
        mCncPrq:=mCncPrq+ohOCILST.CncPrq;
        mUndPrq:=mUndPrq+ohOCILST.UndPrq;
        mIcdPrq:=mIcdPrq+ohOCILST.IcdPrq;
        mStkAva:=mStkAva+ohOCILST.StkAva;
        If ohOCILST.ProTyp='S'
          then mSrvAva:=mSrvAva+ohOCILST.PlsAva
          else mProAva:=mProAva+ohOCILST.PlsAva;
        mSalAva:=mSalAva+ohOCILST.SalAva;
        mSalBva:=mSalBva+ohOCILST.SalBva;
        mTrsBva:=mTrsBva+ohOCILST.TrsBva;
        mDvzBva:=mDvzBva+ohOCILST.DvzBva;
        If ohOCILST.ItmNum>mItmNum then mItmNum:=ohOCILST.ItmNum;
        If ohOCILST.ModSta='M' then mDstMod:='M';
        // Kontrola hlaviËkov˝ch ˙dajov v poloûk·ch
        If (ohOCILST.DocNum<>oaOCHLST.DocNum) or (ohOCILST.ParNum<>oaOCHLST.ParNum) or (ohOCILST.DocDte<>oaOCHLST.DocDte) or (ohOCILST.ExpDte<>oaOCHLST.ExpDte) then begin
          ohOCILST.Edit;
          ohOCILST.DocNum:=oaOCHLST.DocNum;
          ohOCILST.ParNum:=oaOCHLST.ParNum;
          ohOCILST.DocDte:=oaOCHLST.DocDte;
          ohOCILST.ExpDte:=oaOCHLST.ExpDte;
          ohOCILST.Post;
        end;
        If ohOCILST.IcdNum<>'' then mIcdNum:=ohOCILST.IcdNum;
        If ohOCILST.TcdNum<>'' then mTcdNum:=ohOCILST.TcdNum;
        If ohOCILST.CadNum<>'' then mEcdNum:=ohOCILST.CadNum;
        ohOCILST.Next;
      until ohOCILST.Eof or (ohOCILST.DocNum<>pDocNum);
    end;
    ohOCILST.RestStatus;
    oaOCHLST.Edit;
    oaOCHLST.ItmQnt:=mItmQnt;
    oaOCHLST.ItmNum:=mItmNum;
    oaOCHLST.ProVol:=mProVol;
    oaOCHLST.ProWgh:=mProWgh;
    oaOCHLST.StkAva:=mStkAva;
    oaOCHLST.ProAva:=mProAva;
    oaOCHLST.SrvAva:=mSrvAva;
    oaOCHLST.DscAva:=mProAva+mSrvAva-mSalAva;
    oaOCHLST.DscPrc:=ClcDscPrc(mProAva+mSrvAva,mSalAva);
    oaOCHLST.SalAva:=mSalAva;
    oaOCHLST.VatVal:=mSalBva-mSalAva;
    oaOCHLST.SalBva:=mSalBva;
    oaOCHLST.TrsBva:=mTrsBva;
    oaOCHLST.EndBva:=RndBas(mSalBva+mTrsBva-oaOCHLST.DepBva);
    oaOCHLST.DvzBva:=RndBas(mDvzBva);
    oaOCHLST.SalPrq:=RndBas(mSalPrq);
    oaOCHLST.ReqPrq:=RndBas(mReqPrq);
    oaOCHLST.RstPrq:=RndBas(mRstPrq);
    oaOCHLST.RosPrq:=RndBas(mRosPrq);
    oaOCHLST.ExdPrq:=RndBas(mExdPrq);
    oaOCHLST.TcdPrq:=RndBas(mTcdPrq);
    oaOCHLST.CncPrq:=RndBas(mCncPrq);
    oaOCHLST.UndPrq:=RndBas(mUndPrq);
    oaOCHLST.IcdPrq:=RndBas(mIcdPrq);
    oaOCHLST.IcdNum:=mIcdNum;
    oaOCHLST.TcdNum:=mTcdNum;
    oaOCHLST.EcdNum:=mEcdNum;
    oaOCHLST.DstMod:=mDstMod;
    If oaOCHLST.DstLck='R' then oaOCHLST.DstLck:='';
    oaOCHLST.Post;
  end;
end;

procedure TOcmFnc.ClcVatSum(pDocNum:Str12); // VypoËÌta kumulatÌvne hodnoty zadanÈho dokladu podæa jednotliv˝ch sadzieb DPH
begin
  otVATSUM.Open;
  If ohOCILST.LocDocNum(pDocNum) then begin
    Repeat
      If otVATSUM.LocVatPrc(ohOCILST.VatPrc)
        then otVATSUM.Edit
        else begin
          otVATSUM.Insert;
          otVATSUM.VatPrc:=ohOCILST.VatPrc;
        end;
      otVATSUM.Avalue:=otVATSUM.Avalue+ohOCILST.SalAva;
      otVATSUM.VatVal:=otVATSUM.VatVal+ohOCILST.SalBva-ohOCILST.SalAva;
      otVATSUM.Bvalue:=otVATSUM.Bvalue+ohOCILST.SalBva;
      otVATSUM.Post;
      Application.ProcessMessages;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.DocNum<>pDocNum);
  end;
end;

// ********************************* PUBLIC ************************************

procedure TOcmFnc.AddOcrRos(pOsiAdr:longint;pOsdNum:Str12;pOsdItm:word;pRatDte:TDateTime;pResPrq:double);
begin
  If IsNotNul(pResPrq) then begin
    ohOCILST.Table.Refresh;
    ohOCRLST.Insert;
    ohOCRLST.OciAdr:=ohOCILST.ItmAdr;
    ohOCRLST.ResTyp:='O';
    ohOCRLST.ProNum:=ohOCILST.ProNum;
    ohOCRLST.StkNum:=ohOCILST.StkNum;
    ohOCRLST.OsiAdr:=pOsiAdr;
    ohOCRLST.OsdNum:=pOsdNum;
    ohOCRLST.OsdItm:=pOsdItm;
    ohOCRLST.ReqDte:=ohOCILST.ReqDte;
    ohOCRLST.RatDte:=pRatDte;
    ohOCRLST.ResPrq:=pResPrq;
    ohOCRLST.CrtUsr:=gvSys.LoginName;
    ohOCRLST.CrtDte:=Date;
    ohOCRLST.CrtTim:=Time;
    ohOCRLST.Post;
  end;
end;

procedure TOcmFnc.AddOcrRst(pRstPrq:double);
begin
  If IsNotNul(pRstPrq) then begin
    ohOCILST.Table.Refresh;
    ohOCRLST.Insert;
    ohOCRLST.OciAdr:=ohOCILST.ItmAdr;
    ohOCRLST.ResTyp:='S';
    ohOCRLST.ProNum:=ohOCILST.ProNum;
    ohOCRLST.StkNum:=ohOCILST.StkNum;
    ohOCRLST.FifNum:=0;
    ohOCRLST.ResPrq:=pRstPrq;
    ohOCRLST.CrtUsr:=gvSys.LoginName;
    ohOCRLST.CrtDte:=Date;
    ohOCRLST.CrtTim:=Time;
    ohOCRLST.Post;
  end;
end;

procedure TOcmFnc.AddOciHis(pOciAdr:longint;pModTyp:Str1);
var mModNum:longint;
begin
  If ohOCILST.LocItmAdr(pOciAdr) then begin
    ohOCIHIS.SetIndex('ModNum');
    ohOCIHIS.Last;
    mModNum:=ohOCIHIS.ModNum+1;
    ohOCIHIS.Insert;
    BTR_To_BTR(ohOCILST.Table,ohOCIHIS.Table);
    ohOCIHIS.ModNum:=mModNum;
    ohOCIHIS.ModTyp:=pModTyp;
    ohOCIHIS.ModUsr:=gvSys.LoginName;
    ohOCIHIS.ModUsn:=gvSys.UserName;
    ohOCIHIS.ModDte:=Date;
    ohOCIHIS.ModTim:=Time;
    ohOCIHIS.Post;
  end;
end;

procedure TOcmFnc.AddTcdPrq(pOcdNum:Str12;pOcdItm:word;pTcdNum:Str12;pTcdItm:word;pTcdDte:TDateTime;pTcdPrq:double); // Prid· na zadan˙ poloûku z·kazky dodanÈ mnoûstvo
begin
//  If ohOCILST.LocItmAdr(pOciAdr) then begin TODO prerobit ked uz OciAdr bude v TCILST
  If ohOCILST.LocDnIn(pOcdNum,pOcdItm) then begin
    ohOCILST.Edit;
    ohOCILST.TcdNum:=pTcdNum;
    ohOCILST.TcdItm:=pTcdItm;
    ohOCILST.TcdDte:=pTcdDte;
    ohOCILST.TcdPrq:=ohOCILST.TcdPrq+pTcdPrq;  // TODO treba potom prerobiù na kalkul·ciu podæa TCILST
    ohOCILST.RstPrq:=ohOCILST.RstPrq-pTcdPrq;
    ohOCILST.ExdPrq:=0;
    ohOCILST.Post;
    If ohOCRLST.LocOciAdr(ohOCILST.ItmAdr) then begin // ZnÌûime mnoûstvo rezerv·cie
      ohOCRLST.Edit;
      ohOCRLST.ResPrq:=ohOCRLST.ResPrq-pTcdPrq;
      ohOCRLST.Post;
    end;
    AddDocLst(ohOCILST.DocNum);
    // TODO - Po prechodu na TCILST je potrebnÈ doplniù
  end;;
end;

procedure TOcmFnc.AddDocLst(pDocNum:Str12);  // Prid· adresu hlaviËky do zoznamu z·kaziek, ktorÈ boli zmenenÈ
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If oDocLst.Count>0 then begin  // Zoznam nie je pr·zdny
    For I:=0 to oDocLst.Count-1 do begin
      If oDocLst.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then oDocLst.Add(pDocNum);
end;

procedure TOcmFnc.DelOcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vymaûe zadanÈ pozn·mkovÈ riadky
begin
  While ohOCNLST.LocDnInNt(pDocNum,pItmNum,pNotTyp) do ohOCNLST.Delete;
(*
  If ohOCNLST.LocDocNum(pDocNum) then begin
    Repeat
      Application.ProcessMessages;
      If (ohOCNLST.ItmAdr=pItmAdr) and (ohOCNLST.NotTyp=pNotTyp)
        then ohOCNLST.Delete
        else ohOCNLST.Next;
    until ohOCNLST.Eof or (ohOCNLST.DocNum<>pDocNum);
  end;
*)  
end;

procedure TOcmFnc.AddOcnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // UloûÌ pozn·mkov˝ riadok do dokladu
begin
  ohOCNLST.Insert;
  ohOCNLST.DocNum:=pDocNum;
  ohOCNLST.ItmNum:=pItmNum;
  ohOCNLST.NotTyp:=pNotTyp;
  ohOCNLST.LinNum:=pLinNum;
  ohOCNLST.Notice:=pNotLin;
  ohOCNLST.Post;
end;

procedure TOcmFnc.AddOcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // Vymaûe zadanÈ pozn·mkovÈ riadky
var mLinNum:word;
begin
  If pNotice.Count>0 then begin
    For mLinNum:=0 to pNotice.Count-1 do begin
      AddOcnLin(pDocNum,pItmNum,pNotTyp,mLinNum,pNotice.Strings[mLinNum]);
    end;
  end;
end;

procedure TOcmFnc.TmpItmRef;  // ObnovÌ ˙daje aktu·lnej poloûky docasnÈho suboru
begin
  If ohOCILST.GotoPos(otOCILST.ActPos) then begin
    otOCILST.Edit;
    BTR_To_PX(ohOCILST.Table,otOCILST.TmpTable);
    otOCILST.Post;
  end;
end;

procedure TOcmFnc.ClcDocLst;  // PrepoËÌta vöetky hlaviËky zoznamu vytvoreÈn pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je pr·zdny
    For I:=0 to oDocLst.Count-1 do begin
      Application.ProcessMessages;
      ClcOcdDoc(oDocLst.Strings[I]);
    end;
    oDocLst.Clear;
  end;
end;

procedure TOcmFnc.AddPrnNot(ptOCHPRN:TOchprnTmp;pLinNum:byte;pNotice:Str250); // Prid· poznÈmku do zadanÈho riadku
begin
  ptOCHPRN.Edit;
  ptOCHPRN.TmpTable.FieldByName('Notice'+StrInt(pLinNum,1)).AsString:=pNotice;
  ptOCHPRN.Post;
end;

procedure TOcmFnc.PrnUndPrq(pParNum:longint);  // TlaË nedodanÈho tovaru zadanÈho z·kaznÌka
var mRep:TRep; mtOCILST:TOcilstTmp;
begin
  If ohOCILST.LocParNum(pParNum) then begin
    mtOCILST:=TOcilstTmp.Create;  mtOCILST.Open;
    Repeat
      If IsNotNul(ohOCILST.UndPrq) then begin
        mtOCILST.Insert;
        BTR_To_PX(ohOCILST.Table,mtOCILST.TmpTable);
        mtOCILST.DlyDay:=Trunc(Date)-Trunc(mtOCILST.DocDte);
        mtOCILST.Post;
      end;
      Application.ProcessMessages;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.ParNum<>pParNum);
    If mtOCILST.Count>0 then begin
      If ohPARCAT.LocParNum(pParNum) then begin
        mRep:=TRep.Create(Application);
        mRep.HedBtr:=ohPARCAT.Table;
        mRep.ItmTmp:=mtOCILST.TmpTable;
        mRep.Execute('EXDOCD');
        FreeAndNil(mRep);
      end;
    end;
    FreeAndNil(mtOCILST);
  end;
end;

procedure TOcmFnc.PrnOneDoc(pOcdNum:Str12);  // TlaË zadan0ho dokladu cez tlaËov˝ manaûÈr
begin
  PrnBasDoc(pOcdNum,gPrp.Ocm.RepNam[ActBok],'','',gPrp.Ocm.PrnDoq[ActBok],FALSE);
end;

procedure TOcmFnc.PrnPdfDoc(pOcdNum,pMasNam:Str12;pParNum:longint;pPrnNum:word;pPdfNam:Str30);  // TlaË zadanÈho dokladu do PDF s˙boru
begin
  SetLastProc(pOcdNum);
  PrnBasDoc(pOcdNum,pMasNam,'PDFCreator',pPdfNam,1,TRUE);
end;

procedure TOcmFnc.PrnBasDoc(pOcdNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean);  // VytlaËÌ zadan˙ z·kazku
var mRep:TRep; mhSYSTEM:TSystemHnd; mtOCIPRN:TOciprnTmp; mtOCHPRN:TOchprnTmp; mItmTyp,I:byte;  mRatDes:ShortString;
begin
  If ohOCHLST.LocDocNum(pOcdNum) then begin
    If ohOCILST.LocDocNum(pOcdNum) or ohOCIHIS.LocDocNum(pOcdNum) then begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      mtOCHPRN:=TOchprnTmp.Create;  mtOCHPRN.Open;
      mtOCIPRN:=TOciprnTmp.Create;  mtOCIPRN.Open;
      // ---- PrÌprav hlaviËkov˝ch ˙dajov na tlaË -----
      mtOCHPRN.Insert;
      BTR_To_PX(ohOCHLST.Table,mtOCHPRN.TmpTable);
      mtOCHPRN.RegStn:=GetStaName(mtOCHPRN.RegSta);
      mtOCHPRN.WpaStn:=GetStaName(mtOCHPRN.WpaSta);
      mtOCHPRN.Post;
      If ohOCILST.LocDocNum(pOcdNum) then begin
        // ----------- Zber poloûiek dokladu ------------
        Repeat
          // Pozbierame vöetky rezerv·cie z doöl˝ch objedn·vok danej poloûky
          mRatDes:='';
          If ohOCRLST.LocOciAdr(ohOCILST.ItmAdr) then begin
            Repeat
              If ohOCRLST.ResTyp='O' then begin
                If mRatDes<>'' then mRatDes:=mRatDes+';';
                If ohOCRLST.RatDte>0
                  then mRatDes:=mRatDes+DateToStr(ohOCRLST.RatDte)+' ('+StrDoub(ohOCRLST.ResPrq,0,1)+ohOCILST.MsuNam+')'
                  else mRatDes:='TermÌn dod·vky V·m bude upresnen˝';
              end;
              ohOCRLST.Next;
            until ohOCRLST.Eof or (ohOCRLST.OciAdr<>ohOCILST.ItmAdr);
          end;
          // -----------------------------------------------------------------------------------------------------------------
          mItmTyp:=0;
          If ohOCILST.ModSta='M' then mItmTyp:=1; // Zmenen· poloûka
          If IsNul(ohOCILST.UndPrq) and (ohOCILST.TcdPrq>0) then mItmTyp:=3; // Dodan· poloûka
          If IsNul(ohOCILST.UndPrq) and IsNul(ohOCILST.TcdPrq) and (ohOCILST.CncPrq>0) then mItmTyp:=4; // Stornovan· poloûka
          If mItmTyp=0 then mItmTyp:=2; // Poloûky v rieöenÌ
          // -----------------------------------------------------------------------------------------------------------------
          mtOCIPRN.Insert;
          BTR_To_PX(ohOCILST.Table,mtOCIPRN.TmpTable);
          mtOCIPRN.ItmTyp:=mItmTyp;
          case mItmTyp of
            1:mtOCIPRN.ItmDes:='ZMENEN… POLOéKY';
            2:mtOCIPRN.ItmDes:='POLOéKY V RIEäENÕ';
            3:mtOCIPRN.ItmDes:='DODAN… POLOéKY';
            4:mtOCIPRN.ItmDes:='ZRUäEN… POLOéKY';
          end;
          mtOCIPRN.RatDes:=mRatDes;
          If IsNotNul(mtOCIPRN.SalPrq) then mtOCIPRN.SalBpc:=RndBas(mtOCIPRN.SalBva/mtOCIPRN.SalPrq);
          mtOCIPRN.Post;
          Application.ProcessMessages;
          ohOCILST.Next;
        until ohOCILST.Eof or (ohOCILST.DocNum<>pOcdNum);
      end;
      // ZruöenÈ poloûky
      If ohOCIHIS.LocDocNum(pOcdNum) then begin
        mItmTyp:=4; // ZruöenÈ poloûka
        Repeat
          If ohOCIHIS.ModTyp='D' then begin
            If mtOCIPRN.LocItIa(mItmTyp,ohOCIHIS.ItmAdr)
              then mtOCIPRN.Edit
              else mtOCIPRN.Insert;
            BTR_To_PX(ohOCIHIS.Table,mtOCIPRN.TmpTable);
            mtOCIPRN.ItmTyp:=mItmTyp;
            mtOCIPRN.ItmDes:='ZruöenÈ poloûky';
            mtOCIPRN.UndPrq:=0;
            If IsNotNul(mtOCIPRN.SalPrq) then mtOCIPRN.SalBpc:=RndBas(mtOCIPRN.SalBva/mtOCIPRN.SalPrq);
            mtOCIPRN.Post;
          end;
          Application.ProcessMessages;
          ohOCIHIS.Next;
        until ohOCIHIS.Eof or (ohOCIHIS.DocNum<>pOcdNum);
      end;
      // ---------------------- Zber pozn·mok dokladu --------------------------
      For I:=1 to 5 do
        If ohOCNLST.LocDnInNtLn(pOcdNum,0,'',I-1) then AddPrnNot(mtOCHPRN,I,ohOCNLST.Notice); // Prid· poznÈmku do zadanÈho riadku
      // ----------------------- TlaË dokladu (OCDBAS) -------------------------
      mRep:=TRep.Create(Application);
      mRep.SysBtr:=mhSYSTEM.BtrTable;
      mRep.HedTmp:=mtOCHPRN.TmpTable;
      mRep.ItmTmp:=mtOCIPRN.TmpTable;
      If pAutPrn
        then mRep.ExecuteQuick(pMasNam,pPrnNam,pPdfNam,pCopies)
        else mRep.Execute(pMasNam,mtOCHPRN.DocNum);
      FreeAndNil(mRep);
      // -----------------------------------------------------------------------
      FreeAndNil(mtOCIPRN);
      FreeAndNil(mtOCHPRN);
      FreeAndNil(mhSYSTEM);
    end else; // TODO Pr·zdny doklad
  end else; // TODO Neexistuj˙ca hlaviËka dokladu
end;

procedure TOcmFnc.EmlOcdSnd(pOcdNum:Str12);  // VyvorÌ emailov˙ spr·vu a prijatÌ z·kazky
var mEmd:TEmdFnc;  mEmdNum:longint;
begin
  If ohOCHLST.LocDocNum(pOcdNum) then begin
    If (ohOCHLST.CtpEml<>'') then begin
      oArp.AddArpHis('ZK',ohOCHLST.DocNum,ohOCHLST.ParNum,ohOCHLST.ParNam,gvSys.LoginName,'OCDBAS','Q10','Potvrdenie prijatia z·kazky');
      // PoËÌtadlo fyzickej adresy emailov
      mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
      // VytvorÌme z·znam pre emailov˝ server
      mEmd:=TEmdFnc.Create;
      mEmd.ohEMDLST.Insert;
      mEmd.ohEMDLST.EmdNum:=mEmdNum;
      If gPrp.Ocm.FixSnd[ohOCHLST.BokNum] then begin
        mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam[ohOCHLST.BokNum];
        mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml[ohOCHLST.BokNum];  //    'sulik@solidstav.sk';
      end else begin // ⁄daje uûÌvateæa, ktor˝ spravuje doklad
      end;
      mEmd.ohEMDLST.TrgAdr:=ohOCHLST.CtpEml;
      mEmd.ohEMDLST.Subjec:='Potvrdenie prijatia objedn·vky: '+ohOCHLST.DocNum;
      mEmd.ohEMDLST.ParNum:=ohOCHLST.ParNum;
      mEmd.ohEMDLST.ParNam:=ohOCHLST.ParNam;
      mEmd.ohEMDLST.CrtDte:=Date;
      mEmd.ohEMDLST.CrtTim:=Time;
      mEmd.ohEMDLST.AtdNum:=ohOCHLST.DocNum;
      mEmd.ohEMDLST.AtdTyp:=copy(ohOCHLST.DocNum,1,2);
      mEmd.ohEMDLST.ErrSta:='P';  // PrÌznak, ûe treba pripojiù prilohu
      mEmd.ohEMDLST.EmlMsk:='ocdeml.html';
      mEmd.ohEMDLST.SndSta:='P';
      mEmd.ohEMDLST.Post;
      mEmd.AddVar('IntNum',ohOCHLST.DocNum);
      mEmd.AddVar('ExtNum',ohOCHLST.ExtNum);
      mEmd.SavAtd(mEmdNum,oArp.ohARPHIS.PdfNam+'.PDF');
      mEmd.CrtEmd(mEmdNum);
      If mEmd.ErrCod=0 then begin
        // PoËÌtadlo odoslan˝ch emailov
        ohOCHLST.Edit;
        ohOCHLST.EmlCnt:=ohOCHLST.EmlCnt+1;
        ohOCHLST.Post;
      end;
      FreeAndNil(mEmd);
    end;
  end else ; // TODO - hl·siù ûe emailov· adresa nie je zadan·
end;

procedure TOcmFnc.IncEmlCnt(pOcdNum:Str12); // ZvÌö·me poËÌtadlo odoslan˝ch emailov
begin
  If ohOCHLST.LocDocNum(pOcdNum) then begin
    ohOCHLST.Edit;
    ohOCHLST.EmlCnt:=ohOCHLST.EmlCnt+1;
    ohOCHLST.DstMod:='';
    ohOCHLST.Post;
  end;
end;

procedure TOcmFnc.ClrModSta(pOcdNum:Str12); // ZruöÌme prÌznak, ûe doklad bol modifikovan˝
begin
  ohOCILST.SwapIndex;
  If ohOCILST.LocDocNum(pOcdNum) then begin
    Repeat
      If ohOCILST.ModSta='M' then begin
        ohOCILST.Edit;
        ohOCILST.ModSta:='';
        ohOCILST.Post;
      end;
      Application.ProcessMessages;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.DocNum<>pOcdNum);
  end;
  ohOCILST.RestIndex;
  ClcOcdDoc(pOcdNum); // PrepoËÌta hlaviËkovÈ ˙daje odberateæskej z·kazky - pritom overuje hlaviËkovÈ ˙daje v poloûk·ch
end;

procedure TOcmFnc.LodOcrLst(pStkNum:word;pProNum:longint);
begin
  If otOCRLST.Active then ClrTmpTab(otOCRLST.TmpTable) else otOCRLST.Open;
  If ohOCILST.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      If IsNotNul(ohOCILST.RstPrq) then begin
        otOCRLST.Insert;
        otOCRLST.OciAdr:=ohOCILST.ItmAdr;
        otOCRLST.OcdNum:=ohOCILST.DocNum;
        otOCRLST.OcdItm:=ohOCILST.ItmNum;
        otOCRLST.OcdPar:=ohOCILST.ParNum;
        If ohPARCAT.LocParNum(ohOCILST.ParNum) then otOCRLST.OcdPan:=ohPARCAT.ParNam;
        otOCRLST.OcdDte:=ohOCILST.DocDte;
        otOCRLST.ResPrq:=ohOCILST.RstPrq;
        otOCRLST.ReqDte:=ohOCILST.ReqDte;
        otOCRLST.RatDte:=ohOCILST.RatDte;
        otOCRLST.Post;
      end;
      Application.ProcessMessages;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.StkNum<>pStkNum) or (ohOCILST.ProNum<>pProNum);
  end;
end;

procedure TOcmFnc.LodOcqLst(pStkNum:word;pProNum:longint);
begin
  If otOCILST.Active then ClrTmpTab(otOCILST.TmpTable) else otOCILST.Open;
  If ohOCILST.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      If IsNotNul(ohOCILST.ReqPrq) then begin
        otOCILST.Insert;
        BtrCpyTmp(ohOCILST.Table,otOCILST.TmpTable);
        otOCILST.Post;
      end;
      Application.ProcessMessages;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.StkNum<>pStkNum) or (ohOCILST.ProNum<>pProNum);
  end;
end;

end.


