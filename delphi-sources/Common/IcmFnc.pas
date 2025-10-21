unit IcmFnc;

interface

uses
  BasSrv,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexClc, NexGlob, Nexpath, StkGlob, Prp, Rep, Cnt, EmdFnc, ArpFnc,
  hSYSTEM, hPARCAT, hSTCLST, eICHLST, eICNLST, eICILST, tVATSUM, tICILST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TIcdver=record // Kontroln� z�znam na zistenie zmeny v hlavi�ke dokladu
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

  TIcmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oArp:TArpFnc;
    oActBok:Str3;         // Aktu�lna kniha
    oClcDoc:boolean;      // TRUE ak syst�m pr�ve prepo��ta z�kazku
    oDocLst:TStrings;     // Zoznam dokladov, ktor� boli zmenen�
    oIcdVer:TIcdVer;      // Kontroln� z�znam na zistenie zmeny v hlavi�ke dokladu
    oaICHLST:TIchlstHne;  // Hlavi�ky odberate�sk�ch fakt�r - v�dy cel� datab�za bez filtrovania
    oaICILST:TIcilstHne;  // Polo�ky odberate�sk�ch fakt�r - v�dy cel� datab�za bez filtrovania
    ohPARCAT:TParcatHnd;  // Evidencia obchodn�ch partnerov
    ohICHLST:TIchlstHne;  // Hlavi�ky odberate�sk�ch fakt�r
    ohICILST:TIcilstHne;  // Polo�ky odberate�sk�ch fakt�r
    ohICNLST:TIcnlstHne;  // Pozn�mky odberate�sk�ch fakt�r
    otVATSUM:TVatsumTmp;  // Kumulat�vne hodnoty dokladu pod�a sadzieb DPH
    otICILST:TIcilstTmp;
    function GetActBok:Str3;
    function NewItmAdr(pDocYer:Str2):longint;
    function NewSerNum(pDocYer:Str2):longint;
    function DecSerNum(pDocYer:Str2;pSerNum:longint):boolean; // TRUE ak zadan� poradov� ��slo bolo posledn� - v tomto pr�pade zn�i poradov� ��slo o 1
    function GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
    function GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;
    function NewItmNum(pDocNum:Str12):longint;
    function VerIcdChg:boolean; // Porovn� �daje kontroln�ho z�znamu s aktu�lnou hlavi�kou z hOCHLST
    function SetDocEdi(pOcdNum:Str12):boolean; // Nastav� do hlavi�ky dokladu �e je editovan� (TRUE-nastaven�; FALSE-doklad edituje in� u��vate�)
    procedure NewDocGen(pParNum,pSpaNum,pWpaNum:longint;pReqDte:TDate);  // Vytvor� nov� z�kazkov� doklad pre zadan�ho z�kazn�ka
    procedure ClrDocEdi(pOcdNum:Str12); // Zru�� priznak, �e doklad je editovan� na zadanom doklade
    procedure ClrUsrEdi(pUsrLog:Str8);  // Zru�� priznak, �e doklad je editovan� pre v3etky doklady, ktor� edituje zadan� u��vate�
    procedure LodIcdVer; // Na��ta �daje hlavi�ky aktu�lneho dokladu do kontroln�ho z�znamu
    procedure ClcIcdDoc(pDocNum:Str12); // Prepo��ta hlavi�kov� �daje odberate�skej z�kazky - pritom overuje hlavi�kov� �daje v polo�k�ch
    procedure ClcVatSum(pDocNum:Str12); // Vypo��ta kumulat�vne hodnoty zadan�ho dokladu pod�a jednotliv�ch sadzieb DPH
    procedure AddDocLst(pDocNum:Str12);  // Prid� ��slo z�kazky do zoznamu dokladov, ktor� boli zmenen�
    procedure DelIcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky zadanho typu
    procedure AddIcnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok do dokladu
    procedure AddIcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // Ulo�� pozn�mkov� riadoky do dokladu
    procedure ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
    // ------------------------------------------------------------------------------------------------------------------
//    procedure AddPrnNot(ptOCHPRN:TOchprnTmp;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
    procedure PrnOneDoc(pOcdNum:Str12); overload; // Tla� zadan�ho dokladu cez tla�ov� mana��r
    procedure PrnPdfDoc(pOcdNum,pMasNam:Str12;pParNum:longint;pPrnNum:word;pPdfNam:Str30); overload; // Tla� adan�ho dokladu do PDF s�boru
    procedure PrnBasDoc(pOcdNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean); overload; // Vytla�� zadan� z�kazku
              // pDocNum - ��slo tla�en�ho dokumentu
              // pMasNam - N�zov tla�ovej masky
              // pPrnNam - N�zov tla�iarne
              // pCopies - Po�et vytla�en�ch k�pii
              // pAutPrn - Ak je TRUE potom tla�� bez zobrazenia tla�ov�ho mana��ra
    // ------------------------------------------------------------------------------------------------------------------
    procedure EmlIcdSnd(pIcdNum:Str12);  // Odo�le zadan� fakt�ru emailom
    procedure IncEmlCnt(pIcdNum:Str12);  // Zv�ime po��tadlo odoslan�ch emailov

    property ActBok:Str3 read GetActBok write oActBok;     // Aktu�lna kniha dokladov
    property DocLst:TStrings read oDocLst;
  end;

implementation

constructor TIcmFnc.Create;
begin
  oClcDoc:=FALSE;
  oDocLst:=TStringList.Create;  oDocLst.Clear;
  oaICHLST:=TIchlstHne.Create;
  oaICILST:=TIcilstHne.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohICHLST:=TIchlstHne.Create;
  ohICILST:=TIcilstHne.Create;
  ohICNLST:=TIcnlstHne.Create;
  otVATSUM:=TVatsumTmp.Create;
  otICILST:=TIcilstTmp.Create;
  oArp:=TArpFnc.Create;
end;
                
destructor TIcmFnc.Destroy;
begin
  FreeAndNil(oArp);
  FreeAndNil(otICILST);
  FreeAndNil(otVATSUM);
  FreeAndNil(ohICNLST);
  FreeAndNil(ohICILST);
  FreeAndNil(ohICHLST);
  FreeAndNil(ohPARCAT);
  FreeAndNil(oaICILST);
  FreeAndNil(oaICHLST);
  FreeAndNil(oDocLst);
end;

// ******************************** PRIVATE ************************************

function TIcmFnc.GetActBok:Str3;
begin
  Result:=oActBok;
  If Result='' then Result:=ohICHLST.BokNum;
end;

function TIcmFnc.NewItmAdr(pDocYer:Str2):longint;
begin
  Repeat
    Result:=gCnt.NewItmAdr(pDocYer,'ZK');
    Application.ProcessMessages;
  until not oaICILST.LocItmAdr(Result);
end;

function TIcmFnc.NewSerNum(pDocYer:Str2):longint;
begin
  Repeat
    Result:=gCnt.NewDocSer(pDocYer,'ZK',ActBok);
  until not oaICHLST.LocDyBnSn(pDocYer,ActBok,Result);
end;

function TIcmFnc.DecSerNum(pDocYer:Str2;pSerNum:longint):boolean; // TRUE ak zadan� poradov� ��slo bolo posledn� - v tomto pr�pade zn�i poradov� ��slo o 1
begin
  Result:=gCnt.DecDocSer(pDocYer,'ZK',ActBok,pSernum);
end;

function TIcmFnc.GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:='ZK'+pDocYer+ActBok+StrIntZero(pSerNum,5);
end;

function TIcmFnc.GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:=pDocYer+ActBok+StrIntZero(pSerNum,5); // TODO - Prerobi� generovanie po�a pasky - masku premiestni� do PRP
end;

function TIcmFnc.NewItmNum(pDocNum:Str12):longint;
begin
  Result:=0;
  If ohICHLST.LocDocNum(pDocNum) then begin
    Result:=ohICHLST.ItmNum;
    Repeat
      Application.ProcessMessages;
      Inc(Result);
    until not ohICILST.LocDnIn(ohICHLST.DocNum,Result);
    ohICHLST.Edit;
    ohICHLST.ItmNum:=Result;
    ohICHLST.Post;
  end;
end;

function TIcmFnc.VerIcdChg:boolean; // Porovn� �daje kontroln�ho z�znamu s aktu�lnou hlavi�kou z hOCHLST
begin
(*
  Result:=(oIcdVer.ExtNum<>ohICHLST.ExtNum) or (oIcdVer.EmlSnd<>ohICHLST.EmlSnd) or (oIcdVer.DvzNam<>ohICHLST.DvzNam) or
          (oIcdVer.CusNum<>ohICHLST.CusNum) or (oIcdVer.SmsSnd<>ohICHLST.SmsSnd) or (oIcdVer.DvzCrs<>ohICHLST.DvzCrs) or
          (oIcdVer.PrjCod<>ohICHLST.PrjCod) or (oIcdVer.SpaNum<>ohICHLST.SpaNum) or (oIcdVer.DvzBva<>ohICHLST.DvzBva) or
          (oIcdVer.DocDte<>ohICHLST.DocDte) or (oIcdVer.WpaNum<>ohICHLST.WpaNum) or (oIcdVer.DepBva<>ohICHLST.DepBva) or
          (oIcdVer.ExpDte<>ohICHLST.ExpDte) or (oIcdVer.WpaNam<>ohICHLST.WpaNam) or (oIcdVer.DepDte<>ohICHLST.DepDte) or
          (oIcdVer.ReqDte<>ohICHLST.ReqDte) or (oIcdVer.WpaAdr<>ohICHLST.WpaAdr) or (oIcdVer.SalPrq<>ohICHLST.SalPrq) or
          (oIcdVer.ReqTyp<>ohICHLST.ReqTyp) or (oIcdVer.WpaSta<>ohICHLST.WpaSta) or (oIcdVer.ReqPrq<>ohICHLST.ReqPrq) or
          (oIcdVer.VatDoc<>ohICHLST.VatDoc) or (oIcdVer.WpaCtn<>ohICHLST.WpaCtn) or (oIcdVer.RstPrq<>ohICHLST.RstPrq) or
          (oIcdVer.CusCrd<>ohICHLST.CusCrd) or (oIcdVer.WpaZip<>ohICHLST.WpaZip) or (oIcdVer.RosPrq<>ohICHLST.RosPrq) or
          (oIcdVer.ParNum<>ohICHLST.ParNum) or (oIcdVer.PayCod<>ohICHLST.PayCod) or (oIcdVer.TcdPrq<>ohICHLST.TcdPrq) or
          (oIcdVer.ParNam<>ohICHLST.ParNam) or (oIcdVer.TrsCod<>ohICHLST.TrsCod) or (oIcdVer.IcdPrq<>ohICHLST.IcdPrq) or
          (oIcdVer.RegIno<>ohICHLST.RegIno) or (oIcdVer.TrsLin<>ohICHLST.TrsLin) or (oIcdVer.SpcMrk<>ohICHLST.SpcMrk) or
          (oIcdVer.RegTin<>ohICHLST.RegTin) or (oIcdVer.DlvCit<>ohICHLST.DlvCit) or (oIcdVer.AtcDoq<>ohICHLST.AtcDoq) or
          (oIcdVer.RegVin<>ohICHLST.RegVin) or (oIcdVer.DlvCdo<>ohICHLST.DlvCdo) or (oIcdVer.TcdNum<>ohICHLST.TcdNum) or
          (oIcdVer.RegAdr<>ohICHLST.RegAdr) or (oIcdVer.RcvTyp<>ohICHLST.RcvTyp) or (oIcdVer.TcdPrc<>ohICHLST.TcdPrc) or
          (oIcdVer.RegSta<>ohICHLST.RegSta) or (oIcdVer.ItmQnt<>ohICHLST.ItmQnt) or (oIcdVer.IcdNum<>ohICHLST.IcdNum) or
          (oIcdVer.RegCtn<>ohICHLST.RegCtn) or (oIcdVer.ProVol<>ohICHLST.ProVol) or (oIcdVer.IcdPrc<>ohICHLST.IcdPrc) or
          (oIcdVer.RegZip<>ohICHLST.RegZip) or (oIcdVer.ProWgh<>ohICHLST.ProWgh) or (oIcdVer.EcdNum<>ohICHLST.EcdNum) or
          (oIcdVer.CtpNam<>ohICHLST.CtpNam) or (oIcdVer.VatVal<>ohICHLST.VatVal) or (oIcdVer.EcdDoq<>ohICHLST.EcdDoq) or
          (oIcdVer.CtpTel<>ohICHLST.CtpTel) or (oIcdVer.SalBva<>ohICHLST.SalBva) or (oIcdVer.DocDes<>ohICHLST.DocDes) or
          (oIcdVer.CtpFax<>ohICHLST.CtpFax) or (oIcdVer.CtpEml<>ohICHLST.CtpEml) or (oIcdVer.TrsBva<>ohICHLST.TrsBva);
*)
end;

function TIcmFnc.SetDocEdi(pOcdNum:Str12):boolean;
var mFre:boolean;  mMin:longint;
begin
  Result:=FALSE;
  ohICHLST.Table.Refresh;
  If ohICHLST.DocNum<>pOcdNum then ohICHLST.LocDocNum(pOcdNum);
  If ohICHLST.DocNum=pOcdNum then begin
    mFre:=(ohICHLST.EdiUsr='') or (ohICHLST.EdiUsr=gvSys.LoginName);
    If not mFre then mFre:=MinutesBetween(Time,ohICHLST.EdiTim)>60;
    If mFre then begin
      Result:=TRUE;
      ohICHLST.Edit;
      ohICHLST.EdiUsr:=gvSys.LoginName;
      ohICHLST.EdiDte:=Date;
      ohICHLST.EdiTim:=Time;
      ohICHLST.Post;
    end;
  end;
end;

procedure TIcmFnc.NewDocGen(pParNum,pSpaNum,pWpaNum:longint;pReqDte:TDate);  // Vytvor� nov� z�kazkov� doklad pre zadan�ho z�kazn�ka
var mDocYer:Str2;  mSerNum:longint;  mDocNum,mExtNum:Str12;
begin
(*
  mDocYer:=SysYear;
  mSerNum:=NewSerNum(mDocYer);
  mDocNum:=GenDocNum(mDocYer,mSerNum);
  mExtNum:=GenExtNum(mDocYer,mSerNum);
  ohICHLST.Insert;
  ohICHLST.BokNum:=ActBok;
  ohICHLST.DocYer:=mDocYer;
  ohICHLST.SerNum:=mSerNum;
  ohICHLST.DocNum:=mDocNum;
  ohICHLST.ExtNum:=mExtNum;
  ohICHLST.DocDte:=Date;
  ohICHLST.StkNum:=gPrp.Ocm.StkNum[ActBok];
  ohICHLST.ParNum:=pParNum;
  If ohPARCAT.LocParNum(pParNum) then begin
    ohICHLST.ParNam:=ohPARCAT.ParNam;
    ohICHLST.RegIno:=ohPARCAT.RegIno;
    ohICHLST.RegTin:=ohPARCAT.RegTin;
    ohICHLST.RegVin:=ohPARCAT.RegVin;
    ohICHLST.RegAdr:=ohPARCAT.RegAdr;
    ohICHLST.RegSta:=ohPARCAT.RegStc;
    ohICHLST.RegCty:=ohPARCAT.RegCtc;
    ohICHLST.RegCtn:=ohPARCAT.RegCtn;
    ohICHLST.RegZip:=ohPARCAT.RegZip;
    ohICHLST.TrsCod:=ohPARCAT.CusTrsCod;
    ohICHLST.TrsNam:=ohPARCAT.CusTrsNam;
    ohICHLST.CtpEml:=ohPARCAT.RegEml;
  end;
  ohICHLST.SpaNum:=pSpaNum;
  ohICHLST.WpaNum:=pWpaNum;
  If ohPARCAT.LocParNum(pSpaNum) and (pWpaNum=0) then begin
    ohICHLST.WpaNam:=ohPARCAT.ParNam;
    ohICHLST.WpaAdr:=ohPARCAT.RegAdr;
    ohICHLST.WpaCty:=ohPARCAT.RegCtn;
    ohICHLST.WpaCtn:=ohPARCAT.RegCtc;
    ohICHLST.WpaZip:=ohPARCAT.RegZip;
    ohICHLST.WpaSta:=ohPARCAT.RegStc;
  end;
//  ohICHLST.DlvCit:=byte(E_ComDlv.Checked);
//  If E_ComDlv.Checked then ohICHLST.RcvTyp:='O';
  ohICHLST.VatDoc:=1;
  ohICHLST.CrtUsr:=gvSys.LoginName;
  ohICHLST.CrtUsn:=gvSys.UserName;
  ohICHLST.CrtDte:=Date;
  ohICHLST.CrtTim:=Time;
  ohICHLST.DstLck:='';
  ohICHLST.Post;
*)
end;

procedure TIcmFnc.ClrDocEdi(pOcdNum:Str12);
begin
(*
  ohICHLST.Table.Refresh;
  If ohICHLST.DocNum<>pOcdNum then ohICHLST.LocDocNum(pOcdNum);
  If ohICHLST.DocNum=pOcdNum then begin
    ohICHLST.Edit;
    ohICHLST.EdiUsr:='';
    ohICHLST.EdiDte:=0;
    ohICHLST.EdiTim:=0;
    ohICHLST.Post;
  end;
*)
end;

procedure TIcmFnc.ClrUsrEdi(pUsrLog:Str8);  // Zru�� priznak, �e doklad je editovan� pre v3etky doklady, ktor� edituje zadan� u��vate�
begin
(*
  If ohICHLST.LocEdiUsr(pUsrLog) then begin
    Repeat
      ohICHLST.Edit;
      ohICHLST.EdiUsr:='';
      ohICHLST.EdiDte:=0;
      ohICHLST.EdiTim:=0;
      ohICHLST.Post;
      Application.ProcessMessages;
      ohICHLST.Next;
    until ohICHLST.Eof or (ohICHLST.EdiUsr<>pUsrLog);
  end;
*)
end;

procedure TIcmFnc.LodIcdVer; // Na��ta �daje hlavi�ky aktu�lneho dokladu do kontroln�ho z�znamu
begin
  ohICHLST.Table.Refresh;
(*
  oIcdVer.ExtNum:=ohICHLST.ExtNum;       oIcdVer.EmlSnd:=ohICHLST.EmlSnd;       oIcdVer.DvzNam:=ohICHLST.DvzNam;
  oIcdVer.CusNum:=ohICHLST.CusNum;       oIcdVer.SmsSnd:=ohICHLST.SmsSnd;       oIcdVer.DvzCrs:=ohICHLST.DvzCrs;
  oIcdVer.PrjCod:=ohICHLST.PrjCod;       oIcdVer.SpaNum:=ohICHLST.SpaNum;       oIcdVer.DvzBva:=ohICHLST.DvzBva;
  oIcdVer.DocDte:=ohICHLST.DocDte;       oIcdVer.WpaNum:=ohICHLST.WpaNum;       oIcdVer.DepBva:=ohICHLST.DepBva;
  oIcdVer.ExpDte:=ohICHLST.ExpDte;       oIcdVer.WpaNam:=ohICHLST.WpaNam;       oIcdVer.DepDte:=ohICHLST.DepDte;
  oIcdVer.ReqDte:=ohICHLST.ReqDte;       oIcdVer.WpaAdr:=ohICHLST.WpaAdr;       oIcdVer.SalPrq:=ohICHLST.SalPrq;
  oIcdVer.ReqTyp:=ohICHLST.ReqTyp;       oIcdVer.WpaSta:=ohICHLST.WpaSta;       oIcdVer.ReqPrq:=ohICHLST.ReqPrq;
  oIcdVer.VatDoc:=ohICHLST.VatDoc;       oIcdVer.WpaCtn:=ohICHLST.WpaCtn;       oIcdVer.RstPrq:=ohICHLST.RstPrq;
  oIcdVer.CusCrd:=ohICHLST.CusCrd;       oIcdVer.WpaZip:=ohICHLST.WpaZip;       oIcdVer.RosPrq:=ohICHLST.RosPrq;
  oIcdVer.ParNum:=ohICHLST.ParNum;       oIcdVer.PayCod:=ohICHLST.PayCod;       oIcdVer.TcdPrq:=ohICHLST.TcdPrq;
  oIcdVer.ParNam:=ohICHLST.ParNam;       oIcdVer.TrsCod:=ohICHLST.TrsCod;       oIcdVer.IcdPrq:=ohICHLST.IcdPrq;
  oIcdVer.RegIno:=ohICHLST.RegIno;       oIcdVer.TrsLin:=ohICHLST.TrsLin;       oIcdVer.SpcMrk:=ohICHLST.SpcMrk;
  oIcdVer.RegTin:=ohICHLST.RegTin;       oIcdVer.DlvCit:=ohICHLST.DlvCit;       oIcdVer.AtcDoq:=ohICHLST.AtcDoq;
  oIcdVer.RegVin:=ohICHLST.RegVin;       oIcdVer.DlvCdo:=ohICHLST.DlvCdo;       oIcdVer.TcdNum:=ohICHLST.TcdNum;
  oIcdVer.RegAdr:=ohICHLST.RegAdr;       oIcdVer.RcvTyp:=ohICHLST.RcvTyp;       oIcdVer.TcdPrc:=ohICHLST.TcdPrc;
  oIcdVer.RegSta:=ohICHLST.RegSta;       oIcdVer.ItmQnt:=ohICHLST.ItmQnt;       oIcdVer.IcdNum:=ohICHLST.IcdNum;
  oIcdVer.RegCtn:=ohICHLST.RegCtn;       oIcdVer.ProVol:=ohICHLST.ProVol;       oIcdVer.IcdPrc:=ohICHLST.IcdPrc;
  oIcdVer.RegZip:=ohICHLST.RegZip;       oIcdVer.ProWgh:=ohICHLST.ProWgh;       oIcdVer.EcdNum:=ohICHLST.EcdNum;
  oIcdVer.CtpNam:=ohICHLST.CtpNam;       oIcdVer.VatVal:=ohICHLST.VatVal;       oIcdVer.EcdDoq:=ohICHLST.EcdDoq;
  oIcdVer.CtpTel:=ohICHLST.CtpTel;       oIcdVer.SalBva:=ohICHLST.SalBva;       oIcdVer.DocDes:=ohICHLST.DocDes;
  oIcdVer.CtpFax:=ohICHLST.CtpFax;       oIcdVer.TrsBva:=ohICHLST.TrsBva;
  oIcdVer.CtpEml:=ohICHLST.CtpEml;
*)
end;

procedure TIcmFnc.ClcIcdDoc(pDocNum:Str12); // Prepo��ta hlavi�kov� �daje odberate�skej z�kazky - pritom overuje hlavi�kov� �daje v polo�k�ch
var mStkAva,mProAva,mSrvAva,mSalAva,mSalBva,mTrsBva,mDvzBva:double;  mSalPrq,mReqPrq,mRstPrq,mRosPrq,mExdPrq,mTcdPrq,mUndPrq,mCncPrq,mIcdPrq:double;
    mItmQnt,mItmNum:word; mProVol,mProWgh:double;  mDstMod:Str1;
begin
(*
  oaICHLST.SwapIndex;
  If oaICHLST.DocNum<>pDocNum then oaICHLST.LocDocNum(pDocNum);
  oaICHLST.RestIndex;
  If oaICHLST.DocNum=pDocNum then begin
    mItmQnt:=0;  mItmNum:=0;  mProVol:=0;  mProWgh:=0;
    mSalPrq:=0;  mReqPrq:=0;  mRstPrq:=0;  mRosPrq:=0;  mExdPrq:=0;  mTcdPrq:=0;  mCncPrq:=0;  mUndPrq:=0;  mIcdPrq:=0;
    mStkAva:=0;  mProAva:=0;  mSrvAva:=0;  mSalAva:=0;  mSalBva:=0;  mTrsBva:=0;  mDvzBva:=0;  mDstMod:='';
    If ohICILST.LocDocNum(pDocNum) then begin
      Repeat
        Inc(mItmQnt);
        mProVol:=mProVol+ohICILST.ProVol*ohICILST.SalPrq;
        mProWgh:=mProWgh+ohICILST.ProWgh*ohICILST.SalPrq;
        mSalPrq:=mSalPrq+ohICILST.SalPrq;
        mReqPrq:=mReqPrq+ohICILST.ReqPrq;
        mRstPrq:=mRstPrq+ohICILST.RstPrq;
        mRosPrq:=mRosPrq+ohICILST.RosPrq;
        mExdPrq:=mExdPrq+ohICILST.ExdPrq;
        mTcdPrq:=mTcdPrq+ohICILST.TcdPrq;
        mCncPrq:=mCncPrq+ohICILST.CncPrq;
        mUndPrq:=mUndPrq+ohICILST.UndPrq;
        mIcdPrq:=mIcdPrq+ohICILST.IcdPrq;
        mStkAva:=mStkAva+ohICILST.StkAva;
        If ohICILST.ProTyp='S'
          then mSrvAva:=mSrvAva+ohICILST.PlsAva
          else mProAva:=mProAva+ohICILST.PlsAva;
        mSalAva:=mSalAva+ohICILST.SalAva;
        mSalBva:=mSalBva+ohICILST.SalBva;
        mTrsBva:=mTrsBva+ohICILST.TrsBva;
        mDvzBva:=mDvzBva+ohICILST.DvzBva;
        If ohICILST.ItmNum>mItmNum then mItmNum:=ohICILST.ItmNum;
        If ohICILST.ModSta='M' then mDstMod:='M';
        // Kontrola hlavi�kov�ch �dajov v polo�k�ch
        If (ohICILST.DocNum<>oaICHLST.DocNum) or (ohICILST.ParNum<>oaICHLST.ParNum) or (ohICILST.DocDte<>oaICHLST.DocDte) or (ohICILST.ExpDte<>oaICHLST.ExpDte) then begin
          ohICILST.Edit;
          ohICILST.DocNum:=oaICHLST.DocNum;
          ohICILST.ParNum:=oaICHLST.ParNum;
          ohICILST.DocDte:=oaICHLST.DocDte;
          ohICILST.ExpDte:=oaICHLST.ExpDte;
          ohICILST.Post;
        end;
        ohICILST.Next;
      until ohICILST.Eof or (ohICILST.DocNum<>pDocNum);
    end;
    oaICHLST.Edit;
    oaICHLST.ItmQnt:=mItmQnt;
    oaICHLST.ItmNum:=mItmNum;
    oaICHLST.ProVol:=mProVol;
    oaICHLST.ProWgh:=mProWgh;
    oaICHLST.StkAva:=mStkAva;
    oaICHLST.ProAva:=mProAva;
    oaICHLST.SrvAva:=mSrvAva;
    oaICHLST.DscAva:=mProAva+mSrvAva-mSalAva;
    oaICHLST.DscPrc:=ClcDscPrc(mProAva+mSrvAva,mSalAva);
    oaICHLST.SalAva:=mSalAva;
    oaICHLST.VatVal:=mSalBva-mSalAva;
    oaICHLST.SalBva:=mSalBva;
    oaICHLST.TrsBva:=mTrsBva;
    oaICHLST.EndBva:=RndBas(mSalBva+mTrsBva-oaICHLST.DepBva);
    oaICHLST.DvzBva:=mDvzBva;
    oaICHLST.SalPrq:=mSalPrq;
    oaICHLST.ReqPrq:=mReqPrq;
    oaICHLST.RstPrq:=mRstPrq;
    oaICHLST.RosPrq:=mRosPrq;
    oaICHLST.ExdPrq:=mExdPrq;
    oaICHLST.TcdPrq:=mTcdPrq;
    oaICHLST.CncPrq:=mCncPrq;
    oaICHLST.UndPrq:=mUndPrq;
    oaICHLST.IcdPrq:=mIcdPrq;
    oaICHLST.DstMod:=mDstMod;
    If oaICHLST.DstLck='R' then oaICHLST.DstLck:='';
    oaICHLST.Post;
  end;
*)
end;

procedure TIcmFnc.ClcVatSum(pDocNum:Str12); // Vypo��ta kumulat�vne hodnoty zadan�ho dokladu pod�a jednotliv�ch sadzieb DPH
begin
  otVATSUM.Open;
  If ohICILST.LocDocNum(pDocNum) then begin
    Repeat
      If otVATSUM.LocVatPrc(ohICILST.VatPrc)
        then otVATSUM.Edit
        else begin
          otVATSUM.Insert;
          otVATSUM.VatPrc:=ohICILST.VatPrc;
        end;
      otVATSUM.Avalue:=otVATSUM.Avalue+ohICILST.SalAva;
      otVATSUM.VatVal:=otVATSUM.VatVal+ohICILST.SalBva-ohICILST.SalAva;
      otVATSUM.Bvalue:=otVATSUM.Bvalue+ohICILST.SalBva;
      otVATSUM.Post;
      Application.ProcessMessages;
      ohICILST.Next;
    until ohICILST.Eof or (ohICILST.DocNum<>pDocNum);
  end;
end;

// ********************************* PUBLIC ************************************

procedure TIcmFnc.AddDocLst(pDocNum:Str12);  // Prid� adresu hlavi�ky do zoznamu z�kaziek, ktor� boli zmenen�
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    For I:=0 to oDocLst.Count-1 do begin
      If oDocLst.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then oDocLst.Add(pDocNum);
end;

procedure TIcmFnc.DelIcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky
begin
  While ohICNLST.LocDnInNt(pDocNum,pItmNum,pNotTyp) do ohICNLST.Delete;
(*
  If ohICNLST.LocDocNum(pDocNum) then begin
    Repeat
      Application.ProcessMessages;
      If (ohICNLST.ItmAdr=pItmAdr) and (ohICNLST.NotTyp=pNotTyp)
        then ohICNLST.Delete
        else ohICNLST.Next;
    until ohICNLST.Eof or (ohICNLST.DocNum<>pDocNum);
  end;
*)
end;

procedure TIcmFnc.AddIcnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok do dokladu
begin
  ohICNLST.Insert;
  ohICNLST.DocNum:=pDocNum;
  ohICNLST.ItmNum:=pItmNum;
  ohICNLST.NotTyp:=pNotTyp;
  ohICNLST.LinNum:=pLinNum;
  ohICNLST.Notice:=pNotLin;
  ohICNLST.Post;
end;

procedure TIcmFnc.AddIcnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // Vyma�e zadan� pozn�mkov� riadky
var mLinNum:word;
begin
  If pNotice.Count>0 then begin
    For mLinNum:=0 to pNotice.Count-1 do begin
      AddIcnLin(pDocNum,pItmNum,pNotTyp,mLinNum,pNotice.Strings[mLinNum]);
    end;
  end;
end;

procedure TIcmFnc.ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvore�n pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    For I:=0 to oDocLst.Count-1 do begin
      Application.ProcessMessages;
      ClcIcdDoc(oDocLst.Strings[I]);
    end;
    oDocLst.Clear;
  end;
end;
(*
procedure TIcmFnc.AddPrnNot(ptOCHPRN:TOchprnTmp;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
begin
  ptOCHPRN.Edit;
  ptOCHPRN.TmpTable.FieldByName('Notice'+StrInt(pLinNum,1)).AsString:=pNotice;
  ptOCHPRN.Post;
end;
*)
procedure TIcmFnc.PrnOneDoc(pOcdNum:Str12);  // Tla� zadan0ho dokladu cez tla�ov� mana��r
begin
  PrnBasDoc(pOcdNum,gPrp.Ocm.RepNam[ActBok],'','',gPrp.Ocm.PrnDoq[ActBok],FALSE);
end;

procedure TIcmFnc.PrnPdfDoc(pOcdNum,pMasNam:Str12;pParNum:longint;pPrnNum:word;pPdfNam:Str30);  // Tla� zadan�ho dokladu do PDF s�boru
begin
  SetLastProc(pOcdNum);
  PrnBasDoc(pOcdNum,pMasNam,'PDFCreator',pPdfNam,1,TRUE);
end;

procedure TIcmFnc.PrnBasDoc(pOcdNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean);  // Vytla�� zadan� z�kazku
//var mRep:TRep; mhSYSTEM:TSystemHnd; mtOCIPRN:TOciprnTmp; mtOCHPRN:TOchprnTmp; mItmTyp,I:byte;  mRatDes:ShortString;
begin
(*
  If ohICHLST.LocDocNum(pOcdNum) then begin
    If ohICILST.LocDocNum(pOcdNum) or ohOCIHIS.LocDocNum(pOcdNum) then begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      mtOCHPRN:=TOchprnTmp.Create;  mtOCHPRN.Open;
      mtOCIPRN:=TOciprnTmp.Create;  mtOCIPRN.Open;
      // ---- Pr�prav hlavi�kov�ch �dajov na tla� -----
      mtOCHPRN.Insert;
      BTR_To_PX(ohICHLST.Table,mtOCHPRN.TmpTable);
      mtOCHPRN.RegStn:=GetStaName(mtOCHPRN.RegSta);
      mtOCHPRN.WpaStn:=GetStaName(mtOCHPRN.WpaSta);
      mtOCHPRN.Post;
      If ohICILST.LocDocNum(pOcdNum) then begin
        // ----------- Zber polo�iek dokladu ------------
        Repeat
          // Pozbierame v�etky rezerv�cie z do�l�ch objedn�vok danej polo�ky
          mRatDes:='';
          If ohOCRLST.LocOciAdr(ohICILST.ItmAdr) then begin
            Repeat
              If ohOCRLST.ResTyp='O' then begin
                If mRatDes<>'' then mRatDes:=mRatDes+';';
                If ohOCRLST.RatDte>0
                  then mRatDes:=mRatDes+DateToStr(ohOCRLST.RatDte)+' ('+StrDoub(ohOCRLST.ResPrq,0,1)+ohICILST.MsuNam+')'
                  else mRatDes:='Term�n dod�vky V�m bude upresnen�';
              end;
              ohOCRLST.Next;
            until ohOCRLST.Eof or (ohOCRLST.OciAdr<>ohICILST.ItmAdr);
          end;
          // -----------------------------------------------------------------------------------------------------------------
          mItmTyp:=0;
          If ohICILST.ModSta='M' then mItmTyp:=1; // Zmenen� polo�ka
          If IsNul(ohICILST.UndPrq) and (ohICILST.TcdPrq>0) then mItmTyp:=3; // Dodan� polo�ka
          If IsNul(ohICILST.UndPrq) and IsNul(ohICILST.TcdPrq) and (ohICILST.CncPrq>0) then mItmTyp:=4; // Stornovan� polo�ka
          If mItmTyp=0 then mItmTyp:=2; // Polo�ky v rie�en�
          // -----------------------------------------------------------------------------------------------------------------
          mtOCIPRN.Insert;
          BTR_To_PX(ohICILST.Table,mtOCIPRN.TmpTable);
          mtOCIPRN.ItmTyp:=mItmTyp;
          case mItmTyp of
            1:mtOCIPRN.ItmDes:='ZMENEN� POLO�KY';
            2:mtOCIPRN.ItmDes:='POLO�KY V RIE�EN�';
            3:mtOCIPRN.ItmDes:='DODAN� POLO�KY';
            4:mtOCIPRN.ItmDes:='ZRU�EN� POLO�KY';
          end;
          mtOCIPRN.RatDes:=mRatDes;
          mtOCIPRN.Post;
          Application.ProcessMessages;
          ohICILST.Next;
        until ohICILST.Eof or (ohICILST.DocNum<>pOcdNum);
      end;
      // Zru�en� polo�ky
      If ohOCIHIS.LocDocNum(pOcdNum) then begin
        mItmTyp:=4; // Zru�en� polo�ka
        Repeat
          If ohOCIHIS.ModTyp='D' then begin
            If mtOCIPRN.LocItIa(mItmTyp,ohOCIHIS.ItmAdr)
              then mtOCIPRN.Edit
              else mtOCIPRN.Insert;
            BTR_To_PX(ohOCIHIS.Table,mtOCIPRN.TmpTable);
            mtOCIPRN.ItmTyp:=mItmTyp;
            mtOCIPRN.ItmDes:='Zru�en� polo�ky';
            mtOCIPRN.UndPrq:=0;
            mtOCIPRN.Post;
          end;
          Application.ProcessMessages;
          ohOCIHIS.Next;
        until ohOCIHIS.Eof or (ohOCIHIS.DocNum<>pOcdNum);
      end;
      // ---------------------- Zber pozn�mok dokladu --------------------------
      For I:=1 to 5 do
        If ohICNLST.LocDnInNtLn(pOcdNum,0,'',I-1) then AddPrnNot(mtOCHPRN,I,ohICNLST.Notice); // Prid� pozn�mku do zadan�ho riadku
      // ----------------------- Tla� dokladu (OCDBAS) -------------------------
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
    end else; // TODO Pr�zdny doklad
  end else; // TODO Neexistuj�ca hlavi�ka dokladu
*)
end;

procedure TIcmFnc.EmlIcdSnd(pIcdNum:Str12);  // Odo�le zadan� fakt�ru emailom
var mEmd:TEmdFnc;  mEmdNum:longint;
begin
(*
  If ohICHLST.LocDocNum(pOcdNum) then begin
    If (ohICHLST.CtpEml<>'') then begin
      oArp.AddArpHis('ZK',ohICHLST.DocNum,ohICHLST.ParNum,ohICHLST.ParNam,gvSys.LoginName,'OCDBAS','Q10','Potvrdenie prijatia z�kazky');
      // Po��tadlo fyzickej adresy emailov
      mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
      // Vytvor�me z�znam pre emailov� server
      mEmd:=TEmdFnc.Create;
      mEmd.ohEMDLST.Insert;
      mEmd.ohEMDLST.EmdNum:=mEmdNum;
      If gPrp.Ocm.FixSnd[ohICHLST.BokNum] then begin
        mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam[ohICHLST.BokNum];
        mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml[ohICHLST.BokNum];  //    'sulik@solidstav.sk';
      end else begin // �daje u��vate�a, ktor� spravuje doklad
      end;
      mEmd.ohEMDLST.TrgAdr:=ohICHLST.CtpEml;
      mEmd.ohEMDLST.Subjec:='Potvrdenie prijatia objedn�vky: '+ohICHLST.DocNum;
      mEmd.ohEMDLST.ParNum:=ohICHLST.ParNum;
      mEmd.ohEMDLST.ParNam:=ohICHLST.ParNam;
      mEmd.ohEMDLST.CrtDte:=Date;
      mEmd.ohEMDLST.CrtTim:=Time;
      mEmd.ohEMDLST.AtdNum:=ohICHLST.DocNum;
      mEmd.ohEMDLST.AtdTyp:=copy(ohICHLST.DocNum,1,2);
      mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
      mEmd.ohEMDLST.EmlMsk:='ocdeml.html';
      mEmd.ohEMDLST.SndSta:='P';
      mEmd.ohEMDLST.Post;
      mEmd.AddVar('IntNum',ohICHLST.DocNum);
      mEmd.AddVar('ExtNum',ohICHLST.ExtNum);
      mEmd.SavAtd(mEmdNum,oArp.ohARPHIS.PdfNam+'.PDF');
      mEmd.CrtEmd(mEmdNum);
      If mEmd.ErrCod=0 then begin
        // Po��tadlo odoslan�ch emailov
        ohICHLST.Edit;
        ohICHLST.EmlCnt:=ohICHLST.EmlCnt+1;
        ohICHLST.Post;
      end;
      FreeAndNil(mEmd);
    end;
  end else ; // TODO - hl�si� �e emailov� adresa nie je zadan�
*)
end;

procedure TIcmFnc.IncEmlCnt(pIcdNum:Str12); // Zv��me po��tadlo odoslan�ch emailov
begin
(*
  If ohICHLST.LocDocNum(pOcdNum) then begin
    ohICHLST.Edit;
    ohICHLST.EmlCnt:=ohICHLST.EmlCnt+1;
    ohICHLST.DstMod:='';
    ohICHLST.Post;
  end;
*)
end;

end.


