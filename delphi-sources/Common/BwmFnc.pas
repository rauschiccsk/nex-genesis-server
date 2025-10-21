unit BwmFnc;

interface

uses
  BasFnc,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexClc, NexIni, NexGlob, NexPath, Prp, Rep, Cnt, LinLst,
  hSYSTEM, hPARCAT, hSTCLST, eBWDLST, eBWDITM, eBWDNOT, tBWHPRN, tBWIPRN,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TBwdVer=record // Kontroln� z�znam na zistenie zmeny v hlavi�ke dokladu
    DocDte:TDateTime; BegDte:TDateTime; ExpDte:TDateTime; EndDte:TDateTime;
    ParNum:longint;   ParNam:Str60;
    TcdNum:Str13;     IcdNum:Str13;     EcdNum:Str13;
    DocDes:Str50;     ItmQnt:word;
  end;

  TBwmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oActBok:Str3;         // Aktu�lna kniha
    oDocLst:TStrings;     // Zoznam dokladov, ktor� boli zmenen�
    oBwdVer:TBwdVer;      // Kontroln� z�znam na zistenie zmeny v hlavi�ke dokladu
    oaBWDLST:TBwdlstHne;  // Hlavi�ky z�kazkov�ch dokladov - v�dy cel� datab�za bez filtrovania
    oaBWDITM:TBwditmHne;  // Polo�ky z�kazkov�ch dokladov - v�dy cel� datab�za bez filtrovania
    ohPARCAT:TParcatHnd;  // Evidencia obchodn�ch partnerov
    ohBWDLST:TBwdlstHne;  // Hlavi�ky z�kazkov�ch dokladov
    ohBWDITM:TBwdItmHne;  // Polo�ky z�kazkov�ch dokladov
    ohBWDNOT:TBwdnotHne;  // Pozn�mky z�kazkov�ch dokladov
    function GetActBok:Str3;  procedure SetActBok(pBokNum:Str3);
    function NewItmNum(pDocNum:Str12):longint;
    function SetDocEdi(pDocNum:Str12):boolean; // Nastav� do hlavi�ky dokladu �e je editovan� (TRUE-nastaven�; FALSE-doklad edituje in� u��vate�)
    function VerDocChg:boolean; // Porovn� �daje kontroln�ho z�znamu s aktu�lnou hlavi�kou

    procedure NewDocGen(pParNum:longint;pDocDte:TDate);  // Vytvor� nov� z�kazkov� doklad pre zadan�ho z�kazn�ka
    procedure ClrDocEdi(pDocNum:Str12); // Zru�� priznak, �e doklad je editovan� na zadanom doklade
    procedure ClrUsrEdi(pUsrLog:Str8);  // Zru�� priznak, �e doklad je editovan� pre v�etky doklady, ktor� edituje zadan� u��vate�
    procedure LodDocVer; // Na��ta �daje hlavi�ky aktu�lneho dokladu do kontroln�ho z�znamu
    procedure ClcDocDat(pDocNum:Str12); // Prepo��ta hlavi�kov� �daje
    procedure ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
    // ------------------------------------------------------------------------------------------------------------------
    procedure PrnOneDoc(pDocNum:Str12); overload; // Tla� zadan�ho dokladu cez tla�ov� mana��r
    procedure PrnBasDoc(pDocNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean); overload; // Vytla�� zadan� doklad
    // ------------------------------------------------------------------------------------------------------------------
    property ActBok:Str3 read GetActBok write SetActBok;     // Aktu�lna kniha dokladov
    property DocLst:TStrings read oDocLst;
  end;

implementation

constructor TBwmFnc.Create;
begin
  oDocLst:=TStringList.Create;  oDocLst.Clear;
  oaBWDLST:=TBwdlstHne.Create;
  oaBWDITM:=TBwditmHne.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohBWDLST:=TBwdlstHne.Create;
  ohBWDITM:=TBwditmHne.Create;
  ohBWDNOT:=TBwdnotHne.Create;
end;

destructor TBwmFnc.Destroy;
begin
  FreeAndNil(ohBWDNOT);
  FreeAndNil(ohBWDITM);
  FreeAndNil(ohBWDLST);
  FreeAndNil(ohPARCAT);
  FreeAndNil(oaBWDITM);
  FreeAndNil(oaBWDLST);
  FreeAndNil(oDocLst);
end;

// ******************************** PRIVATE ************************************

function TBwmFnc.GetActBok:Str3;
begin
  Result:=oActBok;
end;

procedure TBwmFnc.SetActBok(pBokNum:Str3);
begin
  oActBok:=pBokNum;
end;

function TBwmFnc.NewItmNum(pDocNum:Str12):longint;
begin
  If not oaBWDITM.Active then oaBWDITM.Open;
  Result:=BasFnc.NewItmNum(oaBWDITM.Table,pDocNum);
end;

function TBwmFnc.VerDocChg:boolean; // Porovn� �daje kontroln�ho z�znamu s aktu�lnou hlavi�kou z hOCHLST
begin
(*
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
*)          
end;

function TBwmFnc.SetDocEdi(pDocNum:Str12):boolean;
var mFre:boolean;  mMin:longint;
begin
  Result:=FALSE;
  ohBWDLST.Table.Refresh;
  If ohBWDLST.DocNum<>pDocNum then ohBWDLST.LocDocNum(pDocNum);
  If ohBWDLST.DocNum=pDocNum then begin
    mFre:=(ohBWDLST.EdiUsr='') or (ohBWDLST.EdiUsr=gvSys.LoginName);
    If not mFre then mFre:=MinutesBetween(Time,ohBWDLST.EdiTim)>60;
    If mFre then begin
      Result:=TRUE;
      ohBWDLST.Edit;
      ohBWDLST.EdiUsr:=gvSys.LoginName;
      ohBWDLST.EdiDte:=Date;
      ohBWDLST.EdiTim:=Time;
      ohBWDLST.Post;
    end;
  end;
end;

procedure TBwmFnc.NewDocGen(pParNum:longint;pDocDte:TDate);  // Vytvor� nov� z�kazkov� doklad pre zadan�ho z�kazn�ka
var mDocYer:Str2;  mSerNum:longint;  mDocNum,mExtNum:Str12;
begin
  mDocYer:=SysYear;
  oaBWDLST.Open;
  mSerNum:=NewSerNum(oaBWDLST.Table,ActBok,mDocYer);
  mDocNum:='PN'+mDocYer+ActBok+StrIntZero(mSerNum,5);
  ohBWDLST.Insert;
  ohBWDLST.BokNum:=ActBok;
  ohBWDLST.DocYer:=mDocYer;
  ohBWDLST.SerNum:=mSerNum;
  ohBWDLST.DocNum:=mDocNum;
  ohBWDLST.DocDte:=pDocDte;
  If pDocDte=0 then ohBWDLST.DocDte:=Date;
  ohBWDLST.ParNum:=pParNum;
  If ohPARCAT.LocParNum(pParNum) then begin
    ohBWDLST.ParNam:=ohPARCAT.ParNam;
  end;
  ohBWDLST.CrtUsr:=gvSys.LoginName;
  ohBWDLST.CrtUsn:=gvSys.UserName;
  ohBWDLST.CrtDte:=Date;
  ohBWDLST.CrtTim:=Time;
  ohBWDLST.Post;
end;

procedure TBwmFnc.ClrDocEdi(pDocNum:Str12);
begin
  If pDocNum<>'' then begin
    ohBWDLST.Table.Refresh;
    If ohBWDLST.DocNum<>pDocNum then ohBWDLST.LocDocNum(pDocNum);
    If ohBWDLST.DocNum=pDocNum then begin
      ohBWDLST.Edit;
      ohBWDLST.EdiUsr:='';
      ohBWDLST.EdiDte:=0;
      ohBWDLST.EdiTim:=0;
      ohBWDLST.Post;
    end;
  end;
end;

procedure TBwmFnc.ClrUsrEdi(pUsrLog:Str8);  // Zru�� priznak, �e doklad je editovan� pre v3etky doklady, ktor� edituje zadan� u��vate�
begin
  If ohBWDLST.LocEdiUsr(pUsrLog) then begin
    Repeat
      ohBWDLST.Edit;
      ohBWDLST.EdiUsr:='';
      ohBWDLST.EdiDte:=0;
      ohBWDLST.EdiTim:=0;
      ohBWDLST.Post;
      Application.ProcessMessages;
      ohBWDLST.Next;
    until ohBWDLST.Eof or (ohBWDLST.EdiUsr<>pUsrLog);
  end;
end;

procedure TBwmFnc.LodDocVer; // Na��ta �daje hlavi�ky aktu�lneho dokladu do kontroln�ho z�znamu
begin
(*
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
*)  
end;

procedure TBwmFnc.ClcDocDat(pDocNum:Str12); // Prepo��ta hlavi�kov� �daje odberate�skej z�kazky - pritom overuje hlavi�kov� �daje v polo�k�ch
var mProBva,mBwrBva,mCauVal:double;  mItmQnt,mOutQnt:longint;
begin
  oaBWDLST.SwapIndex;
  If oaBWDLST.DocNum<>pDocNum then oaBWDLST.LocDocNum(pDocNum);
  oaBWDLST.RestIndex;
  If oaBWDLST.DocNum=pDocNum then begin
    mProBva:=0;  mBwrBva:=0;  mCauVal:=0;  mItmQnt:=0;  mOutQnt:=0;
    oaBWDITM.SwapStatus;
    If oaBWDITM.LocDocNum(pDocNum) then begin
      Repeat
        Inc(mItmQnt);
        mProBva:=mProBva+oaBWDITM.ProBva;
        mBwrBva:=mBwrBva+oaBWDITM.BrwBva;
        mCauVal:=mCauVal+oaBWDITM.CauVal;
        If oaBWDITM.RetDte=0 then Inc(mOutQnt);
        Application.ProcessMessages;
        oaBWDITM.Next;
      until oaBWDITM.Eof or (oaBWDITM.DocNum<>pDocNum);
    end;
    oaBWDITM.RestStatus;
    // Ulo��me �daje do hlavi�ky doklad
    oaBWDLST.Edit;
    oaBWDLST.ProBva:=RndBas(mProBva);
    oaBWDLST.BwrBva:=RndBas(mBwrBva);
    oaBWDLST.BwrAva:=ClcAvaVat(mBwrBva,gIni.GetVatPrc(gIni.GetDefVatGrp));
    oaBWDLST.CauVal:=RndBas(mCauVal);
    oaBWDLST.ItmQnt:=mItmQnt;
    oaBWDLST.OutQnt:=mOutQnt;
    oaBWDLST.Post;
  end;
end;

// ********************************* PUBLIC ************************************

procedure TBwmFnc.ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvore�n pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    For I:=0 to oDocLst.Count-1 do begin
      Application.ProcessMessages;
      ClcDocDat(oDocLst.Strings[I]);
    end;
    oDocLst.Clear;
  end;
end;

procedure TBwmFnc.PrnOneDoc(pDocNum:Str12);  // Tla� zadan0ho dokladu cez tla�ov� mana��r
begin
  PrnBasDoc(pDocNum,'BWMDOC','','',1,FALSE);
end;

procedure TBwmFnc.PrnBasDoc(pDocNum:Str12;pMasNam,pPrnNam,pPdfNam:Str30;pCopies:byte;pAutPrn:boolean);  // Vytla�� zadan� z�kazku
var mRep:TRep; mhSYSTEM:TSystemHnd; mtBWIPRN:TBwiprnTmp; mtBWHPRN:TBwhprnTmp; I:byte;
begin
  If ohBWDLST.LocDocNum(pDocNum) then begin
    mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
    mtBWHPRN:=TBwhprnTmp.Create;  mtBWHPRN.Open;
    mtBWIPRN:=TBwiprnTmp.Create;  mtBWIPRN.Open;
    // --- Pr�prava hlavi�kov�ch �dajov na tla� ----
    mtBWHPRN.Insert;
    BTR_To_PX(ohBWDLST.Table,mtBWHPRN.TmpTable);
    If ohPARCAT.LocParNum(ohBWDLST.ParNum) then begin
      BTR_To_PX(ohPARCAT.Table,mtBWHPRN.TmpTable);
      mtBWHPRN.RegAdr:=ohPARCAT.RegAdr;
    end;
    mtBWHPRN.Post;
    // Zru�en� polo�ky
    If ohBWDITM.LocDocNum(pDocNum) then begin
      Repeat
        mtBWIPRN.Insert;
        BTR_To_PX(ohBWDITM.Table,mtBWIPRN.TmpTable);
        mtBWIPRN.Post;
        Application.ProcessMessages;
        ohBWDITM.Next;
      until ohBWDITM.Eof or (ohBWDITM.DocNum<>pDocNum);
    end;
    // ---------------------- Zber pozn�mok dokladu --------------------------
    For I:=1 to 5 do
      If ohBWDNOT.LocDnInNtLn(pDocNum,0,'',I-1) then AddPrnNot(mtBWHPRN.TmpTable,I,ohBWDNOT.Notice); // Prid� pozn�mku do zadan�ho riadku
    // ----------------------- Tla� dokladu (OCDBAS) -------------------------
    mRep:=TRep.Create(Application);
    mRep.SysBtr:=mhSYSTEM.BtrTable;
    mRep.HedTmp:=mtBWHPRN.TmpTable;
    mRep.ItmTmp:=mtBWIPRN.TmpTable;
    If pAutPrn
      then mRep.ExecuteQuick(pMasNam,pPrnNam,pPdfNam,pCopies)
      else mRep.Execute(pMasNam,pDocNum);
    FreeAndNil(mRep);
    // -----------------------------------------------------------------------
    FreeAndNil(mtBWIPRN);
    FreeAndNil(mtBWHPRN);
    FreeAndNil(mhSYSTEM);
  end else; // TODO Neexistuj�ca hlavi�ka dokladu
end;

end.


