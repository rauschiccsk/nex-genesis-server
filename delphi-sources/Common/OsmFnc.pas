unit OsmFnc;

interface

uses
  hBCSGSL,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexGlob, StkGlob, Prp, Cnt, Rep, LinLst,
  hSYSTEM, hPARCAT, eOSHLST, eOSILST, eOSNLST, eOSTLST, eOSRHIS, tOSHPRN, tOSILST, tOSIPRN, hSTCLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TOsmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oActBok:Str3;         // Aktu�lna kniha dokladov
    oDocLst:TLinLst;      // Zoznam dokladov, ktor� boli zmenen�
    ohPARCAT:TParcatHnd;  // Evidencia obchodn�ch partnerov
    odOSHLST:TOshlstHne;  // Hlavi�ky dod�vate�sk�ch objedn�vok - v�dy cel� datab�za bez filtrovania
    odOSILST:TOsilstHne;  // Polo�ky dod�vate�sk�ch objedn�vok - v�dy cel� datab�za bez filtrovania
    ohOSHLST:TOshlstHne;  // Hlavi�ky dod�vate�sk�ch objedn�vok
    ohOSILST:TOsilstHne;  // Polo�ky dod�vate�sk�ch objedn�vok
    ohOSNLST:TOsnlstHne;  // Pozn�mky k dod�vate�sk�m objedn�vkam
    ohOSTLST:TOstlstHne;  // Odkazy na vyp�rovan� dod�vate�sk� pr�jemky
    ohOSRHIS:TOsrhisHne;  // Hist�ria zmeny term�nov dod�vok
    ohBCSGSL:TBcsgslHnd;  // N�kupn� podmienky dod�vate�ov nov� s�bory: Spm SpmFnc hSPHLST hSPILST
    ohSTCLST:TStclstHnd;
    otOSILST:TOsilstTmp;
    otOSIPRN:TOsiprnTmp;
    procedure Open;
    procedure OpenOSHLST;
    procedure OpenOSILST;
    procedure OpenOSNLST;
    function NewItmAdr(pDocYer:Str2):longint;
    function NewSerNum(pDocYer:Str2):longint;
    function DecSerNum(pDocYer:Str2;pSerNum:longint):boolean; // TRUE ak zadan� poradov� ��slo bolo posledn� - v tomto pr�pade zn�i poradov� ��slo o 1
    function GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;   // Vygeneruje intern� ��slo dod�vate�skej objedn�vky
    function GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;   // Vygeneruje extern� ��slo dod�vate�skej objedn�vky
    function NewItmNum(pDocNum:Str12):longint;
    function SetDocEdi(pEdiUsr:Str8):boolean; // Nastav� do hlavi�ky dokladu �e je editovan� (TRUE-nastaven�; FALSE-doklad edituje in� u��vate�)
    function GetSupApc(pStkNum:word;pParNum,pProNum:longint;var pOrpSrc:Str3):double;  // N�upn� cena z obchodn�ch podmienok dod�vate�a resp. zo skladovej karty
    function GetRatDay(pParNum,pProNum:longint):word;  // Fixn� term�n dod�vky z obchodn�ch podmienok dod�vate�a
    function SumTsdPrq(pItmAdr:longint):double;  // Dodan� mno�stvo kumulat�vne z OSTLST

    procedure NewDocGen(pParNum,pSpaNum,pWpaNum:longint);  // Vytvor� nov� doklad pre zadan�ho z�kazn�ka
    procedure AddOsiHis(pOciAdr:longint;pModTyp:Str1); // Prid� riadok do hist�rie zmien
    procedure AddOstItm(pOsiAdr:longint;pTsdDoc:Str12;pTsdItm:longint;pTsdDte:TDate;pTsdPrq:double); // Prid� dod�vku do hist�rie

    procedure ClcOsdDoc(pDocNum:Str12);  // Prepo��ta hlavi�kov� �daje dod�vate�skej objedn�vky - pritom overuje hlavi�kov� �daje v polo�k�ch
    procedure ClrDocEdi; // Zru�� priznak, �e doklad je editovan�
    procedure SetDocCls(pDocNum:Str12);  // Uzamkne zadan� doklad
    procedure SetDocOpn(pDocNum:Str12);  // Odomkne zadan� doklad
    procedure ClrDocLst;                 // Vynuluje zoznam dokladov
    procedure AddDocLst(pDocNum:Str12);  // Prid� ��slo odbjedn�vky do zoznamu dokladov, ktor� boli zmenen�
    procedure ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
    procedure DelOsnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky zadanho typu
    procedure AddOsnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok do dokladu
    procedure AddOsnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // Ulo�� pozn�mkov� riadoky do dokladu
    procedure ClcTsdPrq(pOsiAdr:longint);  // Prepo��ta dodan� mno�stvo na polo�ke dod�vate�skej objedn�vky
    // ------------------------------------------------------------------------------------------------------------------
    procedure AddPrnNot(ptOSHPRN:TOshprnTmp;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
    procedure PrnOneDoc(pOsdNum:Str12); overload; // Tla� zadan�ho dokladu cez tla�ov� mana��r
    procedure PrnPdfDoc(pOsdNum:Str12); overload; // Tla� zadan�ho dokladu do PDF s�boru
    procedure PrnBasDoc(pOsdNum:Str12;pMasNam,pPrnNam:Str30;pCopies:byte;pAutPrn:boolean); overload; // Vytla�� zadan� z�kazku
              // pDocNum - ��slo tla�en�ho dokumentu
              // pMasNam - N�zov tla�ovej masky
              // pPrnNam - N�zov tla�iarne
              // pCopies - Po�et vytla�en�ch k�pii
              // pAutPrn - Ak je TRUE potom tla�� bez zobrazenia tla�ov�ho mana��ra
    // ------------------------------------------------------------------------------------------------------------------
    procedure SetOsrSnd; // Nastav� pr�znaky, �e imporotvan� z�znamy boli odolsan� internou spr�vou

  published
    property ActBok:Str3 read oActBok write oActBok;     // Aktu�lna kniha dokladov
    property DocLst:TLinLst read oDocLst;
  end;

implementation

uses dOSHLST, dOSILST;

constructor TOsmFnc.Create;
begin
  oDocLst:=TLinLst.Create;  oDocLst.Clear;
  ohPARCAT:=TParcatHnd.Create;
  odOSHLST:=TOshlstHne.Create;
  odOSILST:=TOsilstHne.Create;
  ohOSHLST:=TOshlstHne.Create;
  ohOSILST:=TOsilstHne.Create;
  ohOSNLST:=TOsnlstHne.Create;
  ohOSTLST:=TOstlstHne.Create;
  ohOSRHIS:=TOsrhisHne.Create;
  ohBCSGSL:=TBcsgslHnd.Create;
  ohSTCLST:=TStclstHnd.Create;
  otOSILST:=TOsilstTmp.Create;
  otOSIPRN:=TOsiprnTmp.Create;
end;

destructor TOsmFnc.Destroy;
begin
  FreeAndNil(otOSIPRN);
  FreeAndNil(otOSILST);
  FreeAndNil(ohPARCAT);
  FreeAndNil(ohOSRHIS);
  FreeAndNil(ohOSTLST);
  FreeAndNil(ohOSNLST);
  FreeAndNil(ohOSILST);
  FreeAndNil(ohOSHLST);
  FreeAndNil(odOSILST);
  FreeAndNil(odOSHLST);
  FreeAndNil(ohBCSGSL);
  FreeAndNil(ohSTCLST);
  FreeAndNil(oDocLst);
end;

// ******************************** PRIVATE ************************************

function TOsmFnc.NewItmAdr(pDocYer:Str2):longint;
begin
  Repeat
    Result:=gCnt.NewItmAdr(pDocYer,'OB');
    Application.ProcessMessages;
  until not odOSILST.LocItmAdr(Result);
end;

function TOsmFnc.NewSerNum(pDocYer:Str2):longint;
var mNewSerNum: longint;
begin
  odOSHLST.SwapIndex;
  odOSHLST.SetIndex('BokNum');
  odOSHLST.Table.ClearFilter;
  odOSHLST.Table.Filter:='['+odOSHLST.FieldNum('BokNum')+']={'+oActBok+'}';
  odOSHLST.Table.Filtered:=TRUE;
  odOSHLST.SetIndex('DocNum');
  odOSHLST.Last;
  if odOSHLST.DocYer < pDocYer
    then mNewSerNum := 1
    else mNewSerNum := odOSHLST.SerNum+1;
  if odOSHLST.LocDyBnSn(pDocYer, oActBok, mNewSerNum) then begin
    Repeat
      mNewSerNum := mNewSerNum + 1;
    until not odOSHLST.LocDyBnSn(pDocYer, oActBok, mNewSerNum);
  end;
  odOSHLST.Table.ClearFilter;
  odOSHLST.Table.Filtered:=FALSE;
  odOSHLST.RestIndex;
  Result := mNewSerNum;
end;

function TOsmFnc.DecSerNum(pDocYer:Str2;pSerNum:longint):boolean;
begin
  Result:=gCnt.DecDocSer(pDocYer,'OB',oActBok,pSernum);
end;

function TOsmFnc.GenDocNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:='OB'+pDocYer+oActBok+StrIntZero(pSerNum,5);
end;

function TOsmFnc.GenExtNum(pDocYer:Str2;pSerNum:longint):Str12;
begin
  Result:=pDocYer+oActBok+StrIntZero(pSerNum,5); // TODO - Prerobi� generovanie po�a pasky - masku premiestni� do PRP
end;

function TOsmFnc.NewItmNum(pDocNum:Str12):longint;
begin
  Result:=0;
  OpenOSILST;
  If ohOSHLST.LocDocNum(pDocNum) then begin
    Repeat
      Application.ProcessMessages;
      Result:=ohOSHLST.ItmNum+1;
    until not ohOSILST.LocDnIn(ohOSHLST.DocNum,Result);
    ohOSHLST.Edit;
    ohOSHLST.ItmNum:=Result;
    ohOSHLST.Post;
  end;
end;

function TOsmFnc.SetDocEdi(pEdiUsr:Str8):boolean;
var mFre:boolean;  mMin:longint;
begin
  Result:=FALSE;
  ohOSHLST.Table.Refresh;
  mFre:=(ohOSHLST.EdiUsr='') or (ohOSHLST.EdiUsr=pEdiUsr);
  If not mFre then begin
    mMin:=MinutesBetween(Time,ohOSHLST.EdiTim); // ohOSHLST.EdiDte+
    mFre:=mMin>10;
  end;
  If mFre then begin
    Result:=TRUE;
    ohOSHLST.Edit;
    ohOSHLST.EdiUsr:=pEdiUsr;
    ohOSHLST.EdiDte:=Date;
    ohOSHLST.EdiTim:=Time;
    ohOSHLST.Post;
  end;
end;

function TOsmFnc.GetSupApc(pStkNum:word;pParNum,pProNum:longint; var pOrpSrc:Str3):double;
begin
  Result:=0;
  pOrpSrc:='OP';
  If not ohBCSGSL.Active then ohBCSGSL.Open;
  If ohBCSGSL.LocatePaGs(pParNum,pProNum) then Result:=ohBCSGSL.FgCprice;
  If IsNul(Result) then begin
    If ohSTCLST.LocSnPn(pStkNum,pProNum) then Result:=ohSTCLST.LasApc;
    If IsNotNul(Result)
      then pOrpSrc:='S'
      else pOrpSrc:='';
  end;
end;

function TOsmFnc.GetRatDay(pParNum,pProNum:longint):word;  // Fixn� term�n dod�vky z obchodn�ch podmienok dod�vate�a
begin
  Result:=0;
  If not ohBCSGSL.Active then ohBCSGSL.Open;
  If (ohBCSGSL.PaCode=pParNum) and (ohBCSGSL.GsCode=pProNum)
    then Result:=ohBCSGSL.RatDay
    else If ohBCSGSL.LocatePaGs(pParNum,pProNum) then Result:=ohBCSGSL.RatDay;
end;

function TOsmFnc.SumTsdPrq(pItmAdr:longint):double;  // Dodan� mno�stvo kumulat�vne z OSTLST
begin
  Result:=0;
  ohOSTLST.SwapStatus;
  If ohOSTLST.LocItmAdr(pItmAdr) then begin
    Repeat
      Result:=Result+ohOSTLST.TsdPrq;
      ohOSTLST.Next;
    until ohOSTLST.Eof or (ohOSTLST.ItmAdr<>pItmAdr);
  end;
  ohOSTLST.RestStatus;
end;

procedure TOsmFnc.NewDocGen(pParNum,pSpaNum,pWpaNum:longint);  // Vytvor� nov� doklad pre zadan�ho z�kazn�ka
var mDocYer:Str2;  mSerNum:longint;  mDocNum:Str12;
begin
  mDocYer:=SysYear;
  mSerNum:=NewSerNum(mDocYer);
  mDocNum:=GenDocNum(mDocYer,mSerNum);
  ohOSHLST.Insert;
  ohOSHLST.BokNum:=oActBok;
  ohOSHLST.DocYer:=mDocYer;
  ohOSHLST.SerNum:=mSerNum;
  ohOSHLST.DocNum:=mDocNum;
  ohOSHLST.DocDte:=Date;
  ohOSHLST.StkNum:=gPrp.Osm.StkNum[oActBok];
  ohOSHLST.ParNum:=pParNum;
  If ohPARCAT.LocParNum(pParNum) then begin
    ohOSHLST.ParNam:=ohPARCAT.ParNam;
    ohOSHLST.RegIno:=ohPARCAT.RegIno;
    ohOSHLST.RegTin:=ohPARCAT.RegTin;
    ohOSHLST.RegVin:=ohPARCAT.RegVin;
    ohOSHLST.RegAdr:=ohPARCAT.RegAdr;
    ohOSHLST.RegSta:=ohPARCAT.RegStc;
    ohOSHLST.RegCty:=ohPARCAT.RegCtc;
    ohOSHLST.RegCtn:=ohPARCAT.RegCtn;
    ohOSHLST.RegZip:=ohPARCAT.RegZip;
//    ohOSHLST.TrsCod:=ohPARCAT.
//    ohOSHLST.TrsNam:=E_TrsName.Text;
  end;
  ohOSHLST.SpaNum:=pSpaNum;
  ohOSHLST.WpaNum:=pWpaNum;
  If ohPARCAT.LocParNum(pSpaNum) and (pWpaNum=0) then begin
    ohOSHLST.WpaNam:=ohPARCAT.ParNam;
    ohOSHLST.WpaAdr:=ohPARCAT.RegAdr;
    ohOSHLST.WpaCty:=ohPARCAT.RegCtn;
    ohOSHLST.WpaCtn:=ohPARCAT.RegCtc;
    ohOSHLST.WpaZip:=ohPARCAT.RegZip;
    ohOSHLST.WpaSta:=ohPARCAT.RegStc;
  end;
//  ohOSHLST.DlvCit:=byte(E_ComDlv.Checked);
//  If E_ComDlv.Checked then ohOSHLST.RcvTyp:='O';
  ohOSHLST.MngUsr:=gvSys.LoginName;
  ohOSHLST.MngUsn:=gvSys.UserName;
  ohOSHLST.CrtUsr:=gvSys.LoginName;
  ohOSHLST.CrtUsn:=gvSys.UserName;
  ohOSHLST.CrtDte:=Date;
  ohOSHLST.CrtTim:=Time;
//  ohOSHLST.DstLck:='R';
  ohOSHLST.Post;
end;

procedure TOsmFnc.AddOsiHis(pOciAdr:longint;pModTyp:Str1); // Prid� riadok do hist�rie zmiie
begin
  // TODO - ulo�i� z�znam do arch�vneho s�boru
end;

procedure TOsmFnc.AddOstItm(pOsiAdr:longint;pTsdDoc:Str12;pTsdItm:longint;pTsdDte:TDate;pTsdPrq:double); // Prid� dod�vku do hist�rie
begin
  If ohOSILST.LocItmAdr(pOsiAdr) then begin
    If not ohOSTLST.LocDoItTdTi(ohOSILST.DocNum,ohOSILST.ItmNum,pTsdDoc,pTsdItm) then begin
      ohOSTLST.Insert;
      ohOSTLST.DocNum:=ohOSILST.DocNum;
      ohOSTLST.ItmNum:=ohOSILST.ItmNum;
      ohOSTLST.ItmAdr:=ohOSILST.ItmAdr;
      ohOSTLST.ProNum:=ohOSILST.ProNum;
      ohOSTLST.TsdNum:=pTsdDoc;
      ohOSTLST.TsdItm:=pTsdItm;
      ohOSTLST.TsdDte:=pTsdDte;
      ohOSTLST.TsdPrq:=pTsdPrq;
      ohOSTLST.Post;
    end else begin
      ohOSTLST.Edit;
      ohOSTLST.ProNum:=ohOSILST.ProNum;
      ohOSTLST.TsdNum:=pTsdDoc;
      ohOSTLST.TsdItm:=pTsdItm;
      ohOSTLST.TsdDte:=pTsdDte;
      ohOSTLST.TsdPrq:=pTsdPrq;
      ohOSTLST.Post;
    end;
    ohOSILST.Edit;
    ohOSILST.TsdNum:=pTsdDoc;
    ohOSILST.TsdItm:=pTsdItm;
    ohOSILST.TsdDte:=pTsdDte;
    ohOSILST.TsdPrq:=SumTsdPrq(ohOSILST.ItmAdr);  // Dodan� mno�stvo kumulat�vne z OSTLST;
    ohOSILST.Post;
  end;
end;

procedure TOsmFnc.ClcOsdDoc(pDocNum:Str12);
var mProAva,mSrvAva,mOrdAva,mOrdBva,mTrsBva,mDvzBva:double;  mItmNum:integer;  mRatDte:TDate;
    mOrdPrq,mRocPrq,mTsdPrq,mUndPrq,mCncPrq,mIsdPrq:double;  mItmQnt:word; mProVol,mProWgh:double;
begin
  If odOSHLST.LocDocNum(pDocNum) then begin
    mItmQnt:=0;  mItmNum:=0;  mProVol:=0;  mProWgh:=0;               mRatDte:=0;
    mOrdPrq:=0;  mRocPrq:=0;  mTsdPrq:=0;  mUndPrq:=0;  mCncPrq:=0;  mIsdPrq:=0;
    mProAva:=0;  mSrvAva:=0;  mOrdAva:=0;  mOrdBva:=0;  mTrsBva:=0;  mDvzBva:=0;
    odOSILST.SwapStatus;  odOSILST.DisabCont;
    If odOSILST.LocDocNum(pDocNum) then begin
      Repeat
        Inc(mItmQnt);
        If mItmNum<odOSILST.ItmNum then mItmNum:=odOSILST.ItmNum;
        mProVol:=mProVol+odOSILST.ProVol*odOSILST.OrdPrq;
        mProWgh:=mProWgh+odOSILST.ProWgh*odOSILST.OrdPrq;
        mOrdPrq:=mOrdPrq+odOSILST.OrdPrq;
        mRocPrq:=mRocPrq+odOSILST.RocPrq;
        mTsdPrq:=mTsdPrq+odOSILST.TsdPrq;
        mCncPrq:=mCncPrq+odOSILST.CncPrq;
        mUndPrq:=mUndPrq+odOSILST.UndPrq;
        mIsdPrq:=mIsdPrq+odOSILST.IsdPrq;
        If odOSILST.ProTyp='S'
          then mSrvAva:=mSrvAva+odOSILST.OrdAva
          else mProAva:=mProAva+odOSILST.OrdAva;
        mOrdAva:=mOrdAva+odOSILST.OrdAva;
        mOrdBva:=mOrdBva+odOSILST.OrdBva;
        mTrsBva:=mTrsBva+odOSILST.TrsBva;
        mDvzBva:=mDvzBva+odOSILST.DvzBva;
        If IsNotNul(odOSILST.UndPrq) then begin
          If ((odOSILST.RatDte<>0) and (odOSILST.RatDte<mRatDte)) or (mRatDte=0) then mRatDte:=odOSILST.RatDte;
        end;
        // Kontrola hlavi�kov�ch �dajov v polo�k�ch
        If (odOSILST.DocNum<>odOSHLST.DocNum) or (odOSILST.ParNum<>odOSHLST.ParNum) or (odOSILST.DocDte<>odOSHLST.DocDte) then begin
          odOSILST.Edit;
          odOSILST.DocNum:=odOSHLST.DocNum;
          odOSILST.ParNum:=odOSHLST.ParNum;
          odOSILST.DocDte:=odOSHLST.DocDte;
          odOSILST.Post;
        end;
        odOSILST.Next;
      until odOSILST.Eof or (odOSILST.DocNum<>pDocNum);
    end;
    odOSILST.RestStatus;  odOSILST.EnabCont;
    odOSHLST.Edit;
    odOSHLST.ItmQnt:=mItmQnt;
    odOSHLST.ItmNum:=mItmNum;
    odOSHLST.ProVol:=mProVol;
    odOSHLST.ProWgh:=mProWgh;
    odOSHLST.ProAva:=mProAva;
    odOSHLST.SrvAva:=mSrvAva;
    odOSHLST.OrdAva:=mOrdAva;
    odOSHLST.VatVal:=mOrdBva-mOrdAva;
    odOSHLST.OrdBva:=mOrdBva;
    odOSHLST.TrsBva:=mTrsBva;
    odOSHLST.EndBva:=mOrdBva+mTrsBva;
    odOSHLST.DvzBva:=mDvzBva;
    odOSHLST.OrdPrq:=mOrdPrq;
    odOSHLST.RocPrq:=mRocPrq;
    odOSHLST.TsdPrq:=mTsdPrq;
    odOSHLST.CncPrq:=mCncPrq;
    odOSHLST.UndPrq:=mUndPrq;
    odOSHLST.IsdPrq:=mIsdPrq;
    odOSHLST.ReqDte:=mRatDte;
    If odOSHLST.DstLck='R' then odOSHLST.DstLck:='';
    If ohOSRHIS.LocDnAs(pDocNum,'')
      then odOSHLST.DstRat:='R'
      else odOSHLST.DstRat:='';
    odOSHLST.Post;
  end;
end;

procedure TOsmFnc.ClrDocEdi;
begin
  ohOSHLST.Table.Refresh;
  ohOSHLST.Edit;
  ohOSHLST.EdiUsr:='';
  ohOSHLST.EdiDte:=0;
  ohOSHLST.EdiTim:=0;
  ohOSHLST.Post;
end;

procedure TOsmFnc.SetDocCls(pDocNum:Str12); // Uzamkne zadan� doklad
begin
  If ohOSHLST.LocDocNum(pDocNum) then begin
    If ohOSHLST.DstLck='' then begin
      ohOSHLST.Edit;
      ohOSHLST.DstLck:='L';
      ohOSHLST.Post;
    end;
  end;
end;

procedure TOsmFnc.SetDocOpn(pDocNum:Str12); // Odomkne zadan� doklad
begin
  If ohOSHLST.LocDocNum(pDocNum) then begin
    If ohOSHLST.DstLck='L' then begin
      ohOSHLST.Edit;
      ohOSHLST.DstLck:='';
      ohOSHLST.Post;
    end;
  end;
end;

procedure TOsmFnc.ClrDocLst;                 // Vynuluje zoznam dokladov
begin
  oDocLst.Clear;
end;

procedure TOsmFnc.AddDocLst(pDocNum:Str12);  // Prid� ��slo odbjedn�vky do zoznamu dokladov, ktor� boli zmenen�
begin
  oDocLst.AddItm(pDocNum);
end;

procedure TOsmFnc.ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    oDocLst.First;
    Repeat
      ClcOsdDoc(oDocLst.Itm);
      Application.ProcessMessages;
      oDocLst.Next;
    until oDocLst.Eof;
    oDocLst.Clear;
  end;
end;


procedure TOsmFnc.DelOsnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1);  // Vyma�e zadan� pozn�mkov� riadky
begin
  While ohOSNLST.LocDnInNt(pDocNum,pItmNum,pNotTyp) do ohOSNLST.Delete;
(*
  If ohOSNLST.LocDocNum(pDocNum) then begin
    Repeat
      Application.ProcessMessages;
      If (ohOSNLST.ItmAdr=pItmAdr) and (ohOSNLST.NotTyp=pNotTyp)
        then ohOSNLST.Delete
        else ohOSNLST.Next;
    until ohOSNLST.Eof or (ohOSNLST.DocNum<>pDocNum);
  end;
*)
end;

procedure TOsmFnc.AddOsnLin(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word;pNotLin:Str250);    // Ulo�� pozn�mkov� riadok do dokladu
begin
  ohOSNLST.Insert;
  ohOSNLST.DocNum:=pDocNum;
  ohOSNLST.ItmNum:=pItmNum;
  ohOSNLST.NotTyp:=pNotTyp;
  ohOSNLST.LinNum:=pLinNum;
  ohOSNLST.Notice:=pNotLin;
  ohOSNLST.Post;
end;

procedure TOsmFnc.AddOsnLst(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pNotice:TStrings);  // Vyma�e zadan� pozn�mkov� riadky
var mLinNum:word;
begin
  If pNotice.Count>0 then begin
    For mLinNum:=0 to pNotice.Count-1 do begin
      AddOsnLin(pDocNum,pItmNum,pNotTyp,mLinNum,pNotice.Strings[mLinNum]);
    end;
  end;
end;

procedure TOsmFnc.ClcTsdPrq(pOsiAdr:longint);  // Prepo��ta dodan� mno�stvo na polo�ke dod�vate�skej objedn�vky
var mTsdPrq:double;
begin
  If ohOSILST.LocItmAdr(pOsiAdr) then begin
    mTsdPrq:=SumTsdPrq(pOsiAdr);
    If not Eq3(ohOSILST.TsdPrq,mTsdPrq) then begin
      ohOSILST.Edit;
      ohOSILST.TsdPrq:=mTsdPrq;
      ohOSILST.Post;
      ClcOsdDoc(ohOSILST.DocNum);
    end;
  end;
end;


procedure TOsmFnc.AddPrnNot(ptOSHPRN:TOshprnTmp;pLinNum:byte;pNotice:Str250); // Prid� pozn�mku do zadan�ho riadku
begin
  ptOSHPRN.Edit;
  ptOSHPRN.TmpTable.FieldByName('Notice'+StrInt(pLinNum,1)).AsString:=pNotice;
  ptOSHPRN.Post;
end;

procedure TOsmFnc.PrnOneDoc(pOsdNum:Str12);  // Tla� zadan�ho dokladu cez tla�ov� mana��r
begin
  PrnBasDoc(pOsdNum,gPrp.Osm.RepNam[oActBok],'',gPrp.Osm.PrnDoq[oActBok],FALSE);
end;

procedure TOsmFnc.PrnPdfDoc(pOsdNum:Str12);  // Tla� adan�ho dokladu do PDF s�boru
begin
  PrnBasDoc(pOsdNum,gPrp.Osm.RepNam[oActBok],'PDFCreator',1,TRUE);
end;

procedure TOsmFnc.PrnBasDoc(pOsdNum:Str12;pMasNam,pPrnNam:Str30;pCopies:byte;pAutPrn:boolean);  // Vytla�� zadan� z�kazku
var mRep:TRep; mhSYSTEM:TSystemHnd; mtOSIPRN:TOsiprnTmp; mtOSHPRN:TOshprnTmp;   I:byte;
begin
  If ohOSHLST.LocDocNum(pOsdNum) then begin
    If ohOSILST.LocDocNum(pOsdNum) then begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      mtOSHPRN:=TOshprnTmp.Create;  mtOSHPRN.Open;
      mtOSIPRN:=TOsiprnTmp.Create;  mtOSIPRN.Open;
      // ---- Pr�prav hlavi�kov�ch �dajov na tla� -----
      mtOSHPRN.Insert;
      BTR_To_PX(ohOSHLST.Table,mtOSHPRN.TmpTable);
      mtOSHPRN.RegStn:=GetStaName(mtOSHPRN.RegSta);
      mtOSHPRN.WpaStn:=GetStaName(mtOSHPRN.WpaSta);
      mtOSHPRN.Post;
      // ----------- Zber polo�iek dokladu ------------
      Repeat
        mtOSIPRN.Insert;
        BTR_To_PX(ohOSILST.Table,mtOSIPRN.TmpTable);
        mtOSIPRN.Post;
        ohOSILST.Next;
      until ohOSILST.Eof or (ohOSILST.DocNum<>pOsdNum);
      // ---------------------- Zber pozn�mok dokladu --------------------------
      For I:=1 to 5 do
        If ohOSNLST.LocDnInNtLn(pOsdNum,0,'',I-1) then AddPrnNot(mtOSHPRN,I,ohOSNLST.Notice); // Prid� pozn�mku do zadan�ho riadku
      // ----------------------- Tla� dokladu (OSDBAS) -------------------------
      mRep:=TRep.Create(Application);
      mRep.SysBtr:=mhSYSTEM.BtrTable;
      mRep.HedTmp:=mtOSHPRN.TmpTable;
      mRep.ItmTmp:=mtOSIPRN.TmpTable;
      If pAutPrn
        then mRep.ExecuteQuick(pMasNam,pPrnNam,mtOSHPRN.DocNum,pCopies)
        else mRep.Execute(pMasNam,mtOSHPRN.DocNum);
      FreeAndNil (mRep);
      // -----------------------------------------------------------------------
      FreeAndNil(mtOSIPRN);
      FreeAndNil(mtOSHPRN);
      FreeAndNil(mhSYSTEM);
    end else; // TODO Pr�zdny doklad
  end else; // TODO Neexistuj�ca hlavi�ka dokladu
end;

// ********************************* PUBLIC ************************************

procedure TOsmFnc.SetOsrSnd; // Nastav� pr�znaky, �e imporotvan� z�znamy boli odolsan� internou spr�vou
begin
  ohOSRHIS.SwapIndex;
  While ohOSRHIS.LocSndSta('W') do begin
    ohOSRHIS.Edit;
    ohOSRHIS.SndSta:='S';
    ohOSRHIS.Post;
    Application.ProcessMessages;
  end;
  ohOSRHIS.RestIndex;
end;


procedure TOsmFnc.Open;
begin
  OpenOSHLST;
  OpenOSILST;
  OpenOSNLST;
end;

procedure TOsmFnc.OpenOSHLST;
begin
  If not ohOSHLST.Active then ohOSHLST.Open;;
end;

procedure TOsmFnc.OpenOSILST;
begin
  If not ohOSILST.Active then ohOSILST.Open;;
end;

procedure TOsmFnc.OpenOSNLST;
begin
  If not ohOSNLST.Active then ohOSNLST.Open;;
end;

end.


