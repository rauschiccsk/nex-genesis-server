unit DocFnc;
// *****************************************************************************
//              FUNKCIE, KTOR� PRACUJ� S VIACER�MI DRUHMI DOKLADOV
// *****************************************************************************
//             OPTIMALIZ�CIA REZERVACI� Z DOD�VATE�SK�CH OBJEDN�VOK
// Rezerv�cia z dod�vate�sk�ch objedn�vok sa vykon�va na z�klade term�nu dod�vky
// uveden�ho v dod�vate�skej objedn�vke a na z�klade po�adovan�ho term�nu dod�vky
// zo strany z�kazn�ka. Syst�m sa sna�� vykona� rezerv�ciu tak, aby term�n
// dod�vky dod�vate�a a po�adovan� term�n od z�kazn�ka �asovo boli �o najbli��ie.
// Optimalizova� rezerv�ciu znamen�, �e v pr�pade nejakje zmeny ihne� upravi�
// existuj�cu rezerv�ciu tak, aby medzi d�tumom dod�vky dod�vate�a a po�adovan�m
// term�nom z�kazn�ka nebol �iadny in� objednan� tovar. T�to oper�ciu syst�m
// vykon� nasledovn�m sp�sobom:
// 1. Na zadan� tovarov�ho ��sla (PLU) vyh�ad� v�etky nedodan� polo�ky z dod�va-
//    te�sk�ch objedn�vok.
// 2. Zotriedi tieto z�znamy pod�a d�tumu dod�vky dod�vate�a
// 3. Prekontroluje, �i rezerv�cia konkr�tnej polo�ky z�kazky je optim�lna t.j.
//    zo zadu (z d�tumov�ho h�adiska) n�jde najbli���e mo�n� rezerv�cie - ak
//    dan� z�kazka je rezervovan� tak ponech� ak nie zmen� rezerv�ciu.
//
// MO�N� PR�PADY
// 1. Dod�vate� zmen� sv�j term�n dod�vky
//    1.1. Z�kazky je mo�n� splni� len zo �iasto�ne alebo �plne zo z�soby
//    1.2. Z�kazky nie je mo�n� splni� k po�adovan�mu term�nu
//    1.3. Z�kazky nie je mo�n� �iasto�ne alebo �plne splni�
// 2. Zru�enie pol�ky dod�vate�skej objedn�vky
// 3. Bola spraven� nov� objedn�vka a je mo�n� optimalizova� rezerv�ciu
// 4. Z�kazn�k chce zmeni� sv�j po�adovan� term�n dod�vky
// 5. Zru�enie polo�ky z�kazkov�ho dokladu
//
// OPTIMALIZA�N� PROCES (virtu�lna rezerv�cia):
// 1. Syst�m pozbiera z dod�vate�sk�ch objedn�vok na dan� PLU v�etky nedodan�
//    polo�ky, ktor� maj� term�n dod�vky.
// 2. Zotried�me tento zoznam pod�a d�tumu dod�vky dod�vate�a
// 3. Vytvor�me zoznam nedodan�ch polo�iek z odberate�sk�ch z�kaziek (po�iadavka,
//    rezerv�cia zo z�soby, rezerv�cia z objedn�vky)
// 4. Zotried�me tento zoznam pod�a po�adovan�ho d�tumu dod�vky z�kazn�ka
// 5. Ozna��me skladov� kartu s pr�znakom, �e prebieha optimaliz�cia skladovej
//    rezer�cie
// 6. Zapam�t�me stav skaldovej karty pred virtu�lnou rezerv�ciou (FrePrq)
// 7. Vykon�me virtu�lnu rezerv�ciu t.j. v do�asn�ch s�boroch, kde s� �daje
//    len jednej tovarovej polo�ky
//    - OSITMP.BTR - nedodan� polo�ky dod�vate�sk�ch objedn�vok
//    - OCITMP.BTR - nedodan� polo�ky z odberate�sk�ch z�kaziek
//    - OCRTMP.BTR - detailn� rozpis rezerv�cie
// 8. Po vykonan� virtu�lnej rezerv�cie prekontrolujeme �i sa nezmenil stav
//    skaldovej karty.
// 9. Ak stav sa nezmenil dop�eme do skladovej karty z�kazkov� rezerv�ciu
//    zo z�soby a z objedn�vky
// 10.N�sledne zap�eme �daje z OSIVIR.BTR do OSILST.BTR
// 11.Prepo��tame ka�d� hlavi�ku dod�vate�skej objedn�vky, v ktorej bola roben�
//    nejak� zmena.
// 11.Zap�eme �daje z OCRVIR.BTR do OCRLST.BTR
//
// PO�IADAVKY:
// 1. Optimaliz�cia nem��e pokazi� rezerv�ciu t.j. ak z�kazn�k u� bol informovan�,
//    �e tovar dostane do po�adovan�ho term�nu p�timaliz�cia nem��e zmeni�
//    rezerv�ciu tak, aby nedostal sv�j tovar na po�adovan� term�n.
// -----------------------------------------------------------------------------
//                         POPIS JEDNOTLIV�CH FUNKCII
//
// OptOcdRes - Optimaliz�cia z�kazkov�ch rezerv�cii. T�to funkcia v zadanom
//             sklade pre zadan� PLU sprav� nov� rezerv�ciu pod�a aktu�lneho
//             stavu syst�mu a t�m vlastne optimalizuje rezerv�ciu. Rezerv�cia
//             sa sklad� z dvoch f�z. V prvej f�ze syst�m zarezervuje tie polo�ky,
//             ktor� boli zarezervoovan� aj v perdch�dzaj�com stave a a� n�sledne
//             prist�pi k rezerv�cie po�iadaviek. Je to rie�en� takto z d�vodu,
//             aby nedo�lo k tak�mu pr�padu, �e z�kazn�kovi bol ozn�men�, �e jeho
//             z�kazku bude splnen� do po�adovan�ho term�nu a n�sledne pri nejakej
//             optimaliz�cii syst�m rezervevan� tovar pre tohoto z�kazn�ka by
//             presunul na in� z�kazku.
//               pStkNum - ��slo skladu
//               pProNum - Registra�n� ��slo produktu (PLU)
//
//                      ------------- OSD ---------------
// ClcOsiRes - Prepo��ta z�kazkov� rezerv�cie na polo�ke dod�vate�skej objedn�vky
//             z detailov objedn�vkov�ch rezerv�cii (OCRLST)
//               pOsiAdr - Fyzick� adresa polo�ky dod�vate�skej objedn�vky
//
// ClcOciRes - Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky z detailov
//             objedn�vkov�ch rezerv�cii (OCRLST)
//               pOciAdr - Fyzick� adresa polo�ky odberate�skej z�kazky
//
// AddOciRes - Vykon� rezerv�ciu z zadanej polo�ky z�kazkov�ho dokladu.
//               pOciAdr - Fyzick� adresa polo�ky odberate�skej z�kazky
//               pResTyp - Typ rezerv�cie (S-len zo z�soby;O-len z objedn�vky;
//                         ak je pr�zdne potom naprv z objedn�vky a n�sledne
//                         zo z�soby)
//
// DelOciRst - Zru�� skladov� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
//               pOciAdr - Fyzick� adresa polo�ky odberate�skej z�kazky
//
// DelOciRes - Zru�� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
//               pOciAdr - Fyzick� adresa polo�ky odberate�skej z�kazky
//
//                      ------------- OCD ---------------
// AddNewOci - Zalo�� do zadan�ho z�kazkov�ho dokladu nov� polo�ku
//               pOcdNum - Intern� ��slo z�kazky do ktorej bude polo�ka vytvoren�
//               pProNum - Produktov� ��slo novej polo�ky
//               pSalPqr - Predan� mno�stvo
//               pItmFrm - N�zov formul�ra pomocou ktor�ho polo�ka bola zalo�en�
//
// ClrTcdItm - Zru�� odkaz z�kazkov�ho dokladu na odberate�sk� dodac� list a
//             Prepo��ta hlavi�ku danej z�akzky. T�to funkcia sa pou��va pri
//             zru�en� polo�ky doberate�sk�ho doacieho listu.
//               pOcdNum - Interm� ��slo z�kazkov�ho dokladu
//               pOciNum - ��slo polo�ky z�kazkov�ho dokladu
//               pTcdPrq - Dodan� mno�stvo
//
//                      ------------- OCD ---------------
// EmsTcdPer - Odo�le emailom v�etky odberate�sk� dodacie listy za dan� obdobie
//               pParNum - k�d firmy, komu treba odosla� dodacie listy. Ak je
//                         zadan� 0 potom syst�m pre ka�d� firmu odo�le.
//               pBegDte - za�iatok d�tumov�ho intervalu
//               pEndDte - koniec d�tumov�ho intervalu
//               pDocTyp - typ dokladu, ktor� treba odosla�: ak je pr�zdne potom
//                         v�etky dodacie listy bud� odoslan�, ak je N potom len
//                         nevyfakturovan�.
//
// EmsIcdPer - Odo�le emailom v�etky odberate�sk� fakt�ry za dan� obdobie
//               pParNum - k�d firmy, komu treba odosla� fakt�ry. Ak je zadan� 0
//                         potom syst�m pre ka�d� firmu odo�le.
//               pBegDte - za�iatok d�tumov�ho intervalu
//               pEndDte - koniec d�tumov�ho intervalu
//               pDocTyp - typ dokladu, ktor� treba odosla�: ak je pr�zdne potom
//                         v�etky fakt�ry bud� odoslan�, ak je N potom len neuh-
//                         raden�.
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// OSITMP.BTR - Nedodan� polo�ky dod�vate�sk�ch objedn�vok pre konkr�tne PLU.
// OCITMP.BTR - Nedodan� polo�ky odberate�sk�ch z�kaziek pre konkr�tne PLU.
// OCRTMP.BTR - Detailn� rozpis rezerv�cii odberate�sk�ch z�kaziek z dod�vate�-
//              sk�ch objedn�vok.
//              Hore uveden� datab�zov� s�bory s� pou��van� pri optimaliz�cie
//              z�kazkovej rezerv�cie z dod�vate�sk�ch objedn�vok. S� to do�asn�
//              (pomocn�) s�bory, ktor� sa pou��vaj� len pokia� syst�m nevykon�
//              optimaliz�ciu jedn�ho konkr�tneho tovaru. Pou��vame BTR s�bor
//              preto, aby v pr�pade nedokon�enej oper�cie (v�padku) syst�m mohol
//              dan� oper�ciu dodato�ne dokon�i�.
//
// *****************************************************************************

interface

uses
  BasUtilsTCP,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexClc, LinLst, Bok, Prp, Cnt, ProFnc, ParCat, StkFnc, ArpFnc, DapFnc, TrsFnc, EmdFnc, IstFnc, EdiFnc, AccFnc,
  SrmFnc, OcmFnc, OsmFnc, IvmFnc, BsmFnc, PayFnc, EcmFnc,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, Forms, DateUtils;

type
  TDocFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oArp:TArpFnc;
    oPro:TProFnc;
    oPar:TParCat;
    oStk:TStkFnc;
    oDap:TDapFnc;
    oTrs:TTrsFnc;
    oOcd:TOcmFnc;
    oOsd:TOsmFnc;
    oIvd:TIvmFnc;
    oIst:TIstFnc;
    oEdi:TEdiFnc; // Do�l� elektronick� fakt�ry
    oSrm:TSrmFnc;
    oBsm:TBsmFnc; // Bankov� v�pisy
    oPay:TPayFnc; // Denn�k �hrady fakt�r
    oAcc:TAccFnc; // ��tovn� denn�ky
    // ------------- OSD ---------------
    procedure ClcOsiRes(pOsiAdr:longint);  // Prepo��ta rezerv�cie z polo�ky dod�vate�skej objedn�vky
    procedure DelTsdPrq(pTsdNum:Str12;pTsdItm:word);  // Zru�� dodan� mno�stvo z objedn�vok
    procedure SavOsiDlv(pProNum:longint;pDlvDoc:Str12;pDlvItm:longint;pDlvDte:TDate;pDlvPrq:double);  // Odp�e z nedodan�ch objedn�vok prijat� mno�stvo pod�a poradia FIFO
    // ------------- OCD ---------------
    procedure AddNewOci(pOcdNum:Str12;pProNum:longint;pSalPrq,pPlsBpc,pSalBpc,pTrsBva:double;pItmFrm:Str10); // Zalo�� do zadan�ho z�kazkov�ho dokladu nov� polo�ku
    procedure AddOciRst(pOciAdr:longint);  // Vykon� rezerv�ciu zo skladovej z�soby
    procedure AddOciRos(pOciAdr:longint;pBegTyp:Str1); // Vykon� rezerv�ciu z objedn�vky pod�a zadanej sch�my
    procedure AddOciRes(pOciAdr:longint;pResTyp:Str1); // Vykon� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
    procedure ResOciLst(pStkNum,pProNum:longint);      // Vykon� rezerv�ciu v�etk�ch polo�iek zadan�ho PLU v zadanom sklade
    procedure DelOciRst(pOciAdr:longint);  // Zru�� skladov� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
    procedure DelOciRes(pOciAdr:longint);  // Zru�� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
    procedure ClcOciRes(pOciAdr:longint);  // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
    procedure ClrTcdItm(pOcdNum:Str12;pOciNum:word;pTcdPrq:double); // ZATIAL Zru�� odkaz z�kazkov�ho dokladu na dodac� list pri zru�en� polo�ky dodacieho listu
    // ------------- TCD ---------------
//    procedure EmsTcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odo�le emailom v�etky odberate�sk� dodacie listy za zadan� obdobie
//    procedure EmsIcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odo�le emailom v�etky odberate�sk� fakt�ry za zadan� obdobie
  end;

implementation

constructor TDocFnc.Create;
begin
  oPro:=TProFnc.Create;
  oPar:=TParCat.Create;
  oStk:=TStkFnc.Create;
  oArp:=TArpFnc.Create;
  oDap:=TDapFnc.Create;
  oTrs:=TTrsFnc.Create;
  oOcd:=TOcmFnc.Create;
  oOsd:=TOsmFnc.Create;
  oIvd:=TIvmFnc.Create;
  oIst:=TIstFnc.Create;
  oEdi:=TEdiFnc.Create;
  // ------------------
  oSrm:=TSrmFnc.Create;
  oBsm:=TBsmFnc.Create;
  oPay:=TPayFnc.Create;
  oAcc:=TAccFnc.Create;
end;

destructor TDocFnc.Destroy;
begin
  FreeAndNil(oEdi);
  FreeAndNil(oIst);
  FreeAndNil(oIvd);
  FreeAndNil(oOsd);
  FreeAndNil(oOcd);
  FreeAndNil(oTrs);
  FreeAndNil(oDap);
  FreeAndNil(oArp);
  FreeAndNil(oStk);
  FreeAndNil(oPar);
  FreeAndNil(oPro);
  // ------------------
  FreeAndNil(oSrm);
  FreeAndNil(oBsm);
  FreeAndNil(oPay);
  FreeAndNil(oAcc);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

procedure TDocFnc.ClcOsiRes(pOsiAdr:longint); // Prepo��ta rezerv�cie z polo�ky dod�vate�skej objedn�vky
var mRocPrq:double;
begin
  If oOsd.ohOSILST.LocItmAdr(pOsiAdr) then begin
    mRocPrq:=0;
    If oOcd.ohOCRLST.LocOsiAdr(pOsiAdr) then begin
      Repeat
        If oOcd.ohOCRLST.ResTyp='O' then mRocPrq:=mRocPrq+oOcd.ohOCRLST.ResPrq;
        oOcd.ohOCRLST.Next;
      until oOcd.ohOCRLST.Eof or (oOcd.ohOCRLST.OsiAdr<>pOsiAdr);
    end;
    If (oOsd.ohOSILST.RocPrq<>mRocPrq) then begin
      oOsd.ohOSILST.Edit;
      oOsd.ohOSILST.RocPrq:=mRocPrq;
      oOsd.ohOSILST.Post;
    end;
  end;
end;

procedure TDocFnc.ClcOciRes(pOciAdr:longint); // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
var mRosPrq,mRstPrq:double;
begin
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      mRosPrq:=0;  mRstPrq:=0;
      If ohOCRLST.LocOciAdr(pOciAdr) then begin
        Repeat
          If oOcd.ohOCRLST.ResTyp='O'
            then mRosPrq:=mRosPrq+ohOCRLST.ResPrq
            else mRstPrq:=mRstPrq+ohOCRLST.ResPrq;
          ohOCRLST.Next;
        until ohOCRLST.Eof or (ohOCRLST.OciAdr<>pOciAdr);
      end;
      If (ohOCILST.RosPrq<>mRosPrq) or (ohOCILST.RstPrq<>mRstPrq) then begin
        ohOCILST.Edit;
        If (ohOCHLST.LocDocNum(ohOCILST.DocNum)) and (ohOCHLST.EmlCnt>0) and (ohOCILST.RstPrq<>mRstPrq) then ohOCILST.ModSta:='M';
        ohOCILST.RosPrq:=mRosPrq;
        ohOCILST.RstPrq:=mRstPrq;
        If IsNul(mRosPrq+mRstPrq) then ohOCILST.TrsDte:=0;
        ohOCILST.Post;
      end;
      If IsNul(mRosPrq+mRstPrq) and (ohOCILST.TrsDte<>0) then begin // Ak nie je �o doda� zru��me d�tum rozvozu
        ohOCILST.Edit;
        ohOCILST.TrsDte:=0;
        ohOCILST.Post;
      end;
    end;
  end;
end;

procedure TDocFnc.AddOciRst(pOciAdr:longint);  // Vykon� rezerv�ciu zo skladovej z�soby
var mRstPrq:double;
begin
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      If IsNotNul(ohOCILST.UndPrq) then begin  // Zvy�ok rezervujeme zo skladovej z�soby
        If not oPro.ohSTCLST.LocSnPn(ohOCILST.StkNum,ohOCILST.ProNum) then oPro.AddNewStc(ohOCILST.StkNum,ohOCILST.ProNum);
        If oPro.ohSTCLST.FrePrq>=ohOCILST.ReqPrq
          then mRstPrq:=ohOCILST.ReqPrq
          else mRstPrq:=oPro.ohSTCLST.FrePrq;
        AddOcrRst(mRstPrq);
        // Zap�eme d�tum rozvozu
        If ohOCHLST.LocDocNum(ohOCILST.DocNum) and (ohOCHLST.TrsCod='V') and (ohOCHLST.TrsLin>0) then begin
          ohOCILST.Edit;
          If IsNul(ohOCILST.RosPrq) then begin
            ohOCILST.RatDte:=0;
            ohOCILST.RatNot:='';
          end;
          If IsNotNul(mRstPrq) then begin
            If (ohOCHLST.DocDte=ohOCHLST.ReqDte) or (ohOCHLST.ReqDte=0)
              then ohOCILST.TrsDte:=oTrs.GetTrsDte(Date,ohOCHLST.TrsLin,FALSE)
              else ohOCILST.TrsDte:=oTrs.GetTrsDte(ohOCILST.ReqDte,ohOCHLST.TrsLin,TRUE);
          end;
          ohOCILST.Post;
        end;
        ClcOciRes(ohOCILST.ItmAdr);  // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
        oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
      end;
    end;
  end;
end;

procedure TDocFnc.AddOciRos(pOciAdr:longint;pBegTyp:Str1);  // Vykon� rezerv�ciu z objedn�vky pod�a zadanej sch�my
var mOsiLst,mOsdLst:TLinLst;  mLine:ShortString;  mFrePrq,mRosPrq:double;  mOsiAdr:longint;
begin
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      mOsdLst:=TLinLst.Create;
      mOsiLst:=TLinLst.Create;
      If oOsd.ohOSILST.LocPnFr(ohOCILST.ProNum,byte(TRUE)) then begin
        Repeat
          If (oOsd.ohOSILST.StkNum=ohOCILST.StkNum) then begin // Ak objedn�vka je odoslan�, m� term�n dodania a je z dan�ho skladu
            If (oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq>0) then begin
              mLine:=StrIntZero(Trunc(oOsd.ohOSILST.RatDte),5)+';'+StrInt(oOsd.ohOSILST.ItmAdr,0)+';'+oOsd.ohOSILST.DocNum+';'+StrInt(oOsd.ohOSILST.ItmNum,0); // Nasp� do d�tumov�ho form�tu: ArraySToFloatRev(DecodeB64(xxxx,65));
              mOsiLst.AddItm(mLine);
            end;
          end;
          Application.ProcessMessages;
          oOsd.ohOSILST.Next;
        until oOsd.ohOSILST.Eof or (oOsd.ohOSILST.ProNum<>oOcd.ohOCILST.ProNum) or (oOsd.ohOSILST.FreRes=0);
      end;
      If mOsiLst.Count>0 then begin
        mOsiLst.Sort;
        If pBegTyp='F' then begin // Rezerv�cia za��naj�c od prv�ch t.j. najstar��ch objedn�vok a� do konca
          mOsiLst.First;
          Repeat
            mOsiAdr:=ValInt(LineElement(mOsiLst.Itm,1,';'));
            If oOsd.ohOSILST.LocItmAdr(mOsiAdr) then begin
                mFrePrq:=oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq;
                If mFrePrq>ohOCILST.ReqPrq
                  then mRosPrq:=ohOCILST.ReqPrq // V�etko �o treba m��eme rezervova� z danej polo�ky
                  else mRosPrq:=mFrePrq; // Vyd�me len voln� mno�stvo
                // Vytvor�me rezerva�n� z�znam
                AddOcrRos(oOsd.ohOSILST.ItmAdr,oOsd.ohOSILST.DocNum,oOsd.ohOSILST.ItmNum,oOsd.ohOSILST.RatDte,mRosPrq);
                If oOsd.ohOSILST.SndDte>0 then begin
                  If oOsd.ohOSILST.RatDte>ohOCILST.ReqDte then begin // Po�adovan� term�n z�kazn�ka nie je mo�n� splni�
                    ohOCILST.Edit;
                    ohOCILST.RatPrv:=ohOCILST.RatDte;
                    ohOCILST.RatDte:=oOsd.ohOSILST.RatDte;
                    If ohOCHLST.LocDocNum(ohOCILST.DocNum) and (ohOCHLST.TrsCod='V') and (ohOCHLST.TrsLin>0) then ohOCILST.TrsDte:=oTrs.GetTrsDte(oOsd.ohOSILST.RatDte+1,ohOCHLST.TrsLin,FALSE);
                    ohOCILST.RatChg:=ohOCILST.RatChg+1;
                    ohOCILST.RatNot:='Zmenen� term�n dod�vky';
                    ohOCILST.Post;
                  end else begin
                    If ohOCILST.RatDte=0 then begin
                      ohOCILST.Edit;
                      If (ohOCHLST.LocDocNum(ohOCILST.DocNum)) and (ohOCHLST.EmlCnt>0) and (ohOCILST.RatDte<>oOsd.ohOSILST.RatDte) then ohOCILST.ModSta:='M';
                      ohOCILST.RatDte:=oOsd.ohOSILST.RatDte;
                      ohOCILST.RatNot:='';
                      If ohOCHLST.LocDocNum(ohOCILST.DocNum) and (ohOCHLST.TrsCod='V') and (ohOCHLST.TrsLin>0) then begin
                        If (ohOCHLST.DocDte=ohOCHLST.ReqDte) or (ohOCHLST.ReqDte=0) or (ohOCILST.RatDte>=ohOCILST.ReqDte)
                          then ohOCILST.TrsDte:=oTrs.GetTrsDte(ohOCILST.RatDte+1,ohOCHLST.TrsLin,FALSE)
                          else ohOCILST.TrsDte:=oTrs.GetTrsDte(ohOCILST.ReqDte,ohOCHLST.TrsLin,TRUE);
                      end;
                      ohOCILST.Post;
                    end;
                  end;
                end else begin
                  ohOCILST.Edit;
                  ohOCILST.RatDte:=0;
                  ohOCILST.TrsDte:=0;
                  ohOCILST.RatNot:='Term�n dod�vky V�m bude upresnen�';
                  ohOCILST.Post;
                end;
                ClcOciRes(ohOCILST.ItmAdr);  // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
                oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
                ClcOsiRes(oOsd.ohOSILST.ItmAdr);  // Prepo��ta rezerv�cie z polo�ky dod�vate�skej objedn�vky
                mOsdLst.AddItm(oOsd.ohOSILST.DocNum);
            end;
            Application.ProcessMessages;
            mOsiLst.Next;
          until mOsiLst.Eof or IsNul(ohOCILST.ReqPrq);
        end;
        If pBegTyp='L' then begin // Rezerv�cia za��naj�c od poslden�ch t.j. najmlad��ch objedn�vok od po�adovan�ho term�nu
          mOsiLst.Last;
          Repeat
            mOsiAdr:=ValInt(LineElement(mOsiLst.Itm,1,';'));
            If oOsd.ohOSILST.LocItmAdr(mOsiAdr) then begin
              If (oOsd.ohOSILST.RatDte<=ohOCILST.ReqDte) and (oOsd.ohOSILST.RatDte<>0) and (oOsd.ohOSILST.RatDte>Date) then begin // or ((oOsd.ohOSILST.RatDte=0) and ())
                mFrePrq:=oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq;
                If mFrePrq>ohOCILST.ReqPrq
                  then mRosPrq:=ohOCILST.ReqPrq // V�etko �o treba m��eme rezervova� z danej polo�ky
                  else mRosPrq:=mFrePrq; // Vyd�me len voln� mno�stvo
                // Vytvor�me rezerva�n� z�znam
                AddOcrRos(oOsd.ohOSILST.ItmAdr,oOsd.ohOSILST.DocNum,oOsd.ohOSILST.ItmNum,oOsd.ohOSILST.RatDte,mRosPrq);
                ohOCILST.Edit;
                If (ohOCHLST.LocDocNum(ohOCILST.DocNum)) and (ohOCHLST.EmlCnt>0) and (ohOCILST.RatDte<>oOsd.ohOSILST.RatDte) then ohOCILST.ModSta:='M';
                ohOCILST.RatDte:=oOsd.ohOSILST.RatDte;
                If ohOCHLST.LocDocNum(ohOCILST.DocNum) and (ohOCHLST.TrsCod='V') and (ohOCHLST.TrsLin>0) then begin
                  If (ohOCHLST.DocDte=ohOCHLST.ReqDte) or (ohOCHLST.ReqDte=0) or (ohOCILST.RatDte>=ohOCILST.ReqDte)
                    then ohOCILST.TrsDte:=oTrs.GetTrsDte(ohOCILST.RatDte+1,ohOCHLST.TrsLin,FALSE)
                    else ohOCILST.TrsDte:=oTrs.GetTrsDte(ohOCILST.ReqDte,ohOCHLST.TrsLin,TRUE);
                end;
                ohOCILST.Post;
                ClcOciRes(ohOCILST.ItmAdr);  // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
                oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
                ClcOsiRes(oOsd.ohOSILST.ItmAdr);  // Prepo��ta rezerv�cie z polo�ky dod�vate�skej objedn�vky
                mOsdLst.AddItm(oOsd.ohOSILST.DocNum);
              end;
            end;
            Application.ProcessMessages;
            mOsiLst.Prior;
          until mOsiLst.Bof or IsNul(ohOCILST.ReqPrq);
        end;
      end;
    end;
    // Prepo��tame hlavi�ky zmenen�ch objedn�vok
    If mOsdLst.Count>0 then begin
      mOsdLst.First;
      Repeat
        oOsd.ClcOsdDoc(mOsdLst.Itm);
        Application.ProcessMessages;
        mOsdLst.Next;
      until mOsdLst.Eof;
    end;
    FreeAndNil(mOsiLst);
    FreeAndNil(mOsdLst);
  end;
end;

procedure TDocFnc.AddOciRes(pOciAdr:longint;pResTyp:Str1);
var mOsiLst:TStringList;  mCnt,mActDly:integer;  mOsiAdr:longint;  mOsdLst:TLinLst;  mSalPrq,mFrePrq,mResPrq:double; mReqDay:integer;
begin
  DelOciRes(pOciAdr);
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      mReqDay:=Trunc(ohOCILST.ReqDte)-Trunc(ohOCILST.DocDte);
      If pResTyp='' then begin
        If mReqDay<=0 then begin  // 1. Rezerv�cia tovar pod�a shc�my: "�O NAJSKOR"
          AddOciRst(pOciAdr);                                       // 1.1. Rezervujeme tovar zo skaldovej z�soby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); // 1.2. Rezervujeme tovar za��naj�c od prv�ch objedn�vok a� do konca
        end else begin            // 2. Rezerv�cia tovaru pod�a sch�my: "K ZADAN�MU TERM�NU"
          AddOciRos(pOciAdr,'L');                                   // 2.1. Rezervujeme tovar za��naj�c od najmlad��ch objedn�vok a� do po�adovan�ho term�nu z�kazn�ka
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRst(pOciAdr);     // 2.2. Rezervujeme tovar zo skaldovej z�soby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); // 2.3. Rezervujeme tovar za��naj�c od prv�ch objedn�vok a� do konca
        end;
        ClcOcdDoc(ohOCILST.DocNum);
      end;
      If pResTyp='O' then begin   // Rezervujeme len z objedn�vok
        If mReqDay<=0 then begin  // 1. Rezerv�cia tovar pod�a shc�my: "�O NAJSKOR"
          AddOciRst(pOciAdr);     //    - Rezervujeme tovar zo skaldovej z�soby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); //    - Rezervujeme tovar za��naj�c od prv�ch objedn�vok a� do konca
        end else begin            // 2. Rezerv�cia tovaru pod�a sch�my: "K ZADAN�MU TERM�NU"
          AddOciRos(pOciAdr,'L'); //    - Rezervujeme tovar za��naj�c od najmlad��ch objedn�vok a� do po�adovan�ho term�nu z�kazn�ka
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); //    2.3. Rezervujeme tovar za��naj�c od prv�ch objedn�vok a� do konca
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRst(pOciAdr);     //    2.4. Rezervujeme tovar zo skaldovej z�soby
        end;
        ClcOcdDoc(ohOCILST.DocNum);
      end;
    end;
  end;
end;

procedure TDocFnc.ResOciLst(pStkNum,pProNum:longint);      // Vykon� rezerv�ciu v�etk�ch polo�iek zadan�ho PLU v zadanom sklade
var mItmLst:TLinLst;
begin
  mItmLst:=TLinLst.Create;
  With oOcd do begin
    If ohOCILST.LocSnPnUs(pStkNum,pProNum,'U') then begin
      Repeat
        mItmLst.AddItm(StrInt(ohOCILST.ItmAdr,0));
        Application.ProcessMessages;
        ohOCILST.Next;
      until ohOCILST.Eof or (ohOCILST.StkNum<>pStkNum) or (ohOCILST.ProNum<>pProNum) or (ohOCILST.UndSta<>'U');
    end;
  end;
  If mItmLst.Count>0 then begin
    mItmLst.First;
    Repeat
      AddOciRes(ValInt(mItmLst.Itm),''); // Vykon� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
      Application.ProcessMessages;
      mItmLst.Next;
    until mItmLst.Eof;
  end;
  FreeAndNil(mItmLst);
end;

procedure TDocFnc.DelOciRst(pOciAdr:longint);  // Zru�� skladov� rezerv�ciu zadanej polo�ky z�kazkov�ho dokladu
var mProNum:longint;  mStkNum:word;
begin
  If oOcd.ohOCRLST.LocIaRt(pOciAdr,'S') then begin
    // TODO historia rezervacie
    mStkNum:=oOcd.ohOCRLST.StkNum;
    mProNum:=oOcd.ohOCRLST.ProNum;
    oOcd.ohOCRLST.Delete;
    ClcOciRes(pOciAdr); // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
    oStk.StcClc(mStkNum,mProNum);
  end;
end;

procedure TDocFnc.DelOciRes(pOciAdr:longint);
var mModify:boolean;  mOsiAdr:longint;  mOsdLst:TLinLst;
begin
  mModify:=FALSE;
  If oOcd.ohOCILST.LocItmAdr(pOciAdr) then begin
    mOsdLst:=TLinLst.Create;
    While oOcd.ohOCRLST.LocOciAdr(pOciAdr) do begin  // Vyma�eme v�etky rezerv�cie zadan�ho dokladu
      mModify:=TRUE;
      mOsiAdr:=oOcd.ohOCRLST.OsiAdr;
      mOsdLst.AddItm(oOcd.ohOCRLST.OsdNum);
      Application.ProcessMessages;
      oOcd.ohOCRLST.Delete;
      ClcOsiRes(mOsiAdr);
    end;
    While oOcd.ohOCRHIS.LocOciAdr(pOciAdr) do begin
      Application.ProcessMessages;
      oOcd.ohOCRHIS.Delete;
    end;
    ClcOciRes(pOciAdr); // Prepo��ta rezerv�cie na polo�ke odberate�skej z�kazky
    oStk.StcClc(oOcd.ohOCILST.StkNum,oOcd.ohOCILST.ProNum);
    If mOsdLst.Count>0 then begin
      mOsdLst.First;
      Repeat
        oOsd.ClcOsdDoc(mOsdLst.Itm);
        Application.ProcessMessages;
        mOsdLst.Next;
      until mOsdLst.Eof;
    end;
    FreeAndNil(mOsdLst);
  end;
end;

procedure TDocFnc.DelTsdPrq(pTsdNum:Str12;pTsdItm:word);  // Zru�� dodan� mno�stvo z objedn�vok
var mOsdLst:TLinLst; mOsdNum:Str12;  mItmAdr:longint;
begin
  mOsdLst:=TLinLst.Create;
  With oOsd do begin
    While ohOSTLST.LocTdTi(pTsdNum,pTsdItm) do begin
      mItmAdr:=ohOSTLST.ItmAdr;
      mOsdLst.AddItm(ohOSTLST.DocNum);
      ohOSTLST.Delete;
      If ohOSILST.LocItmAdr(mItmAdr) then begin
        ohOSILST.Edit;
        ohOSILST.TsdPrq:=SumTsdPrq(mItmAdr);
        ohOSILST.Post;
        oStk.StcClc(ohOSILST.StkNum,ohOSILST.ProNum);
      end;
      Application.ProcessMessages;
    end;
    If mOsdLst.Count>0 then begin
      mOsdLst.First;
      Repeat
        ClcOsdDoc(mOsdLst.Itm);
        Application.ProcessMessages;
        mOsdLst.Next;
      until mOsdLst.Eof;
    end;
  end;
  FreeAndNil(mOsdLst);
end;

procedure TDocFnc.SavOsiDlv(pProNum:longint;pDlvDoc:Str12;pDlvItm:longint;pDlvDte:TDate;pDlvPrq:double);  // Odp�e z nedodan�ch objedn�vok prijat� mno�stvo pod�a poradia FIFO
var mOsiLst:TLinLst; mOsiAdr:longint; mDlvPrq,mTsdPrq:double;
begin
  mOsiLst:=TLinLst.Create;
  With oOsd do begin
    If ohOSILST.LocPnSt(pProNum,'O')  then begin
      Repeat
        If IsNotNul(ohOSILST.UndPrq) then mOsiLst.AddItm(StrInt(ohOSILST.ItmAdr,0));
        Application.ProcessMessages;
        ohOSILST.Next;
      until ohOSILST.Eof or (ohOSILST.ProNum<>pProNum) or (ohOSILST.ItmSta<>'O');
    end;
    If mOsiLst.Count>0 then begin
      mOsiLst.First;
      mDlvPrq:=pDlvPrq;
      Repeat
        mOsiAdr:=ValInt(mOsiLst.Itm);
        If ohOSILST.LocItmAdr(mOsiAdr) then begin
          If ohOSILST.UndPrq<=pDlvPrq then begin
            mTsdPrq:=ohOSILST.UndPrq;
            mDlvPrq:=mDlvPrq-ohOSILST.UndPrq;
          end else begin
            mTsdPrq:=mDlvPrq;
            mDlvPrq:=0;
          end;
          AddOstItm(ohOSILST.ItmAdr,pDlvDoc,pDlvItm,pDlvDte,mTsdPrq); // Prid� dod�vku do hist�rie
          AddDocLst(ohOSILST.DocNum);  // Prid� ��slo odbjedn�vky do zoznamu dokladov, ktor� boli zmenen�
        end;
        oStk.StcClc(ohOSILST.StkNum,ohOSILST.ProNum);
        Application.ProcessMessages;
        mOsiLst.Next;
      until mOsiLst.Eof or IsNul(mDlvPrq) or (mDlvPrq<0);
      ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
    end;
  end;
  FreeAndNil(mOsiLst);
end;

procedure TDocFnc.AddNewOci(pOcdNum:Str12;pProNum:longint;pSalPrq,pPlsBpc,pSalBpc,pTrsBva:double;pItmFrm:Str10); // Zalo�� do zadan�ho z�kazkov�ho dokladu nov� polo�ku
var mItmAdr,mItmNum:longint;
begin
  With oOcd do begin
    If ohOCHLST.LocDocNum(pOcdNum) then begin
      If oPro.LocProNum(ohOCHLST.ParNum,ohOCHLST.StkNum,pProNum) then begin
        mItmAdr:=NewItmAdr(ohOCHLST.DocYer);
        mItmNum:=NewItmNum(ohOCHLST.DocNum);
        ohOCILST.Insert;
        ohOCILST.ItmAdr:=mItmAdr;
        ohOCILST.DocNum:=ohOCHLST.DocNum;
        ohOCILST.ItmNum:=mItmNum;
        ohOCILST.WriNum:=ohOCHLST.WriNum;
        ohOCILST.StkNum:=ohOCHLST.StkNum;
        ohOCILST.BokNum:=ohOCHLST.BokNum;
        ohOCILST.PrjNum:=ohOCHLST.PrjNum;
        ohOCILST.ParNum:=ohOCHLST.ParNum;
        ohOCILST.DocDte:=ohOCHLST.DocDte;
        ohOCILST.ExpDte:=ohOCHLST.ExpDte;
        ohOCILST.ReqDte:=ohOCHLST.ReqDte;
        ohOCILST.ProNum:=pProNum;
        ohOCILST.ProNam:=oPro.ProNam;
        ohOCILST.PgrNum:=oPro.PgrNum;
        ohOCILST.FgrNum:=oPro.FgrNum;
        ohOCILST.SgrNum:=oPro.SgrNum;
        ohOCILST.BarCod:=oPro.BarCod;
        ohOCILST.StkCod:=oPro.StkCod;
        ohOCILST.ShpCod:=oPro.ShpCod;
        ohOCILST.OrdCod:=oPro.OrdCod;
        ohOCILST.ProVol:=oPro.ProVol;
        ohOCILST.ProWgh:=oPro.ProWgh;
        ohOCILST.ProTyp:=oPro.ProTyp;
        ohOCILST.MsuNam:=oPro.MsuNam;
        ohOCILST.SalPrq:=pSalPrq;
        If ohOCHLST.VatDoc=1
          then ohOCILST.VatPrc:=oPro.VatPrc
          else ohOCILST.VatPrc:=0;
        If oIst.GetCctVat(ohOCHLST.ParNum,pProNum) then begin
          ohOCILST.CctVat:=1;
          ohOCILST.VatPrc:=0;
        end;
        ohOCILST.StkAva:=RndBas(oPro.StkApc*pSalPrq);
        If IsNotNul(pPlsBpc)
          then ohOCILST.PlsAva:=ClcAvaVat(pPlsBpc*pSalPrq,ohOCILST.VatPrc)
          else ohOCILST.PlsAva:=RndBas(oPro.PlsApc*pSalPrq);
        ohOCILST.FgdAva:=RndBas(oPro.FgdApc*pSalPrq);
        If IsNul(pSalBpc) then begin
          ohOCILST.SalAva:=RndBas(oPro.SalApc*pSalPrq);
          ohOCILST.SalBva:=ClcBvaVat(ohOCILST.SalAva,ohOCILST.VatPrc);
          ohOCILST.SapSrc:=oPro.SapSrc;
        end else begin
          ohOCILST.SalBva:=RndBas(pSalBpc*pSalPrq);
          ohOCILST.SalAva:=ClcAvaVat(ohOCILST.SalBva,ohOCILST.VatPrc);
          ohOCILST.SapSrc:='EX';
        end;
        If IsNul(ohOCILST.PlsAva) then ohOCILST.PlsAva:=ohOCILST.SalAva;
        ohOCILST.PrjAva:=ohOCILST.FgdAva;
        ohOCILST.SpcAva:=ohOCILST.FgdAva;
        ohOCILST.DscPrc:=ClcDscPrc(ohOCILST.PlsAva,ohOCILST.SalAva);
        ohOCILST.TrsBva:=pTrsBva;
        ohOCILST.EndBva:=ohOCILST.SalBva+ohOCILST.TrsBva;
        ohOCILST.DvzBva:=ClcDvzVal(ohOCILST.EndBva,ohOCHLST.DvzCrs);
        ohOCILST.CrtUsr:=gvSys.LoginName;
        ohOCILST.CrtDte:=Date;
        ohOCILST.CrtTim:=Time;
        ohOCILST.ItmFrm:=pItmFrm;
        ohOCILST.Post;
      end else ; // TODO - v bazovej evidencii neexituje polo�ka pod zadan�m produktov�m ��slom
    end else ; // TODO - neexistuje hlavi�ka zadan�ho dokladu
  end;
end;

procedure TDocFnc.ClrTcdItm(pOcdNum:Str12;pOciNum:word;pTcdPrq:double); // ZATIAL Zru�� odkaz z�kazkov�ho dokladu na dodac� list pri zru�en� polo�ky dodacieho listu
begin
  If oOcd.ohOCILST.LocDnIn(pOcdNum,pOciNum) then begin
    If oOcd.ohOCILST.ExdSta='E' then begin
      oOcd.ohOCILST.Edit;
      oOcd.ohOCILST.ExdPrq:=oOcd.ohOCILST.ExdPrq-pTcdPrq;
      If oOcd.ohOCILST.ExdPrq<0 then oOcd.ohOCILST.ExdPrq:=0;
      oOcd.ohOCILST.TcdNum:='';
      oOcd.ohOCILST.TcdItm:=0;
      oOcd.ohOCILST.Post;
    end else begin
      oOcd.ohOCILST.Edit;
      oOcd.ohOCILST.TcdPrq:=oOcd.ohOCILST.TcdPrq-pTcdPrq;
      If oOcd.ohOCILST.ExdPrq<0 then oOcd.ohOCILST.ExdPrq:=0;
      oOcd.ohOCILST.TcdNum:='';
      oOcd.ohOCILST.TcdItm:=0;
      oOcd.ohOCILST.Post;
      AddOciRes(oOcd.ohOCILST.ItmAdr,'');
    end;
    oOcd.ClcOcdDoc(oOcd.ohOCILST.DocNum);
  end;
end;

(*
procedure TDocFnc.EmsTcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odo�le emailom v�etky odberate�sk� dodacie listy za zadan� obdobie
var mParLst:TLinLst; mTcdLst:TLinLst; mParNum:longint;  mTcd:TTcd; mEmd:TEmdFnc;  mEmdNum:longint;
begin
  mTcd:=TTcd.Create(Application);
  mParLst:=TLinLst.Create;
  mTcdLst:=TLinLst.Create;
  With mTcd do begin
    If pParNum=0 then begin
      gBok.LoadBoks('TCB','');
      If gBok.otBOKLST.Count>0 then begin
        gBok.otBOKLST.First;
        Repeat
          Open(gBok.otBOKLST.BokNum);
          ohTCH.NearestDocDate(pBegDte);
          If InDateinterval(pBegDte,pEndDte,ohTCH.DocDate) and ((ohTCH.IcdNum='') or (pDocTyp='')) then begin
            Repeat
              If not mParLst.LocItm(StrInt(ohTCH.PaCode,0)) then mParLst.AddItm(StrInt(ohTCH.PaCode,0));
              ohTCH.Next;
            until ohTCH.Eof or (ohTCH.DocDate>pEndDte);
          end;
          Application.ProcessMessages;
          gBok.otBOKLST.Next;
        until gBok.otBOKLST.Eof;
      end;
    end else mParLst.AddItm(Strint(pParNum,0));
    If mParLst.Count>0 then begin
      mParLst.First;
      Repeat
        mParNum:=ValInt(mParLst.Itm);
        If (mParNum>0) and oPar.ohPARCAT.LocParNum(mParNum) then begin
          mTcdlst.Clear;
          gBok.LoadBoks('TCB','');
          If gBok.otBOKLST.Count>0 then begin
            gBok.otBOKLST.First;
            Repeat
              Open(gBok.otBOKLST.BokNum);
              If ohTCH.LocatePaCode(mParNum) then begin
                Repeat
                  If InDateinterval(pBegDte,pEndDte,ohTCH.DocDate) and ((ohTCH.IcdNum='') or (pDocTyp='')) then begin
                    PrnPdfDoc(ohTCH.DocNum);  // Tla� adan�ho dokladu do PDF s�boru
                    mTcdLst.AddItm(ohTCH.DocNum);
                  end;
                  ohTCH.Next;
                until ohTCH.Eof or (ohTCH.PaCode>mParNum);
              end;
              Application.ProcessMessages;
              gBok.otBOKLST.Next;
            until gBok.otBOKLST.Eof;
          end;
          If mTcdLst.Count>0 then begin // Priprav�me Email pre dan�ho z�kazn�ka
            mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
            // Vytvor�me z�znam pre emailov� server
            mEmd:=TEmdFnc.Create;
            mEmd.ohEMDLST.Insert;
            mEmd.ohEMDLST.EmdNum:=mEmdNum;
            If gPrp.Ocm.FixSnd['020'] then begin
              mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam['020'];
              mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml['020'];  //    'sulik@solidstav.sk';
            end else begin // �daje u��vate�a, ktor� spravuje doklad

            end;
            mEmd.ohEMDLST.TrgAdr:=oPar.ohPARCAT.RegEml;
            mEmd.ohEMDLST.Subjec:='Zoznam nevyfakturovan�ho odobran�ho tovaru zo d�a '+DateToStr(pBegDte);
            mEmd.ohEMDLST.ParNum:=mParNum;
            mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
            mEmd.ohEMDLST.CrtDte:=Date;
            mEmd.ohEMDLST.CrtTim:=Time;
            mTcdLst.First;
            Repeat
              If mEmd.ohEMDLST.AtdLst=''
                then mEmd.ohEMDLST.AtdLst:=mTcdLst.Itm+'.PDF'
                else mEmd.ohEMDLST.AtdLst:=mEmd.ohEMDLST.AtdLst+';'+mTcdLst.Itm+'.PDF';
              mTcdLst.Next;
            until mTcdLst.Eof;
            mEmd.ohEMDLST.AtdDoq:=mTcdLst.Count; // Po�et pripojen�ch pr�lohov�ch dokumentov
//            mEmd.ohEMDLST.AtdNum:=ohOCHLST.DocNum;
            mEmd.ohEMDLST.AtdTyp:='OD';
            mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
            mEmd.ohEMDLST.EmlMsk:='tcdper.html';
            mEmd.ohEMDLST.SndSta:='P';
            mEmd.ohEMDLST.Post;
            mEmd.AddVar('CurDte',DateToStr(pBegDte));
            mEmd.CrtEmd(mEmdNum);
            If mEmd.ErrCod=0 then begin // Po��tadlo odoslan�ch emailov
//              ohOCHLST.Edit;
//              ohOCHLST.EmlCnt:=ohOCHLST.EmlCnt+1;
//              ohOCHLST.Post;
            end;
            FreeAndNil(mEmd);
          end;
        end;
        Application.ProcessMessages;
        mParLst.Next;
      until mParLst.Eof;
    end;
  end;
  FreeAndNil(mTcdLst);
  FreeAndNil(mParLst);
  FreeAndNil(mTcd);
end;
*)

(*
procedure TDocFnc.EmsIcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odo�le emailom v�etky odberate�sk� dodacie listy za zadan� obdobie
var mParLst:TLinLst; mIcdLst:TLinLst; mParNum:longint;  mIcd:TIcd; mEmd:TEmdFnc;  mEmdNum:longint;
begin
  mIcd:=TIcd.Create(Application);
  mParLst:=TLinLst.Create;
  mIcdLst:=TLinLst.Create;
  With mIcd do begin
    If pParNum=0 then begin
      gBok.LoadBoks('ICB','');
      If gBok.otBOKLST.Count>0 then begin
        gBok.otBOKLST.First;
        Repeat
          Open(gBok.otBOKLST.BokNum);
          ohICH.NearestDocDate(pBegDte);
          If InDateinterval(pBegDte,pEndDte,ohICH.DocDate) and (IsNotNul(ohICH.FgEndVal) or (pDocTyp='')) then begin
            Repeat
              If not mParLst.LocItm(StrInt(ohICH.PaCode,0)) then mParLst.AddItm(StrInt(ohICH.PaCode,0));
              ohICH.Next;
            until ohICH.Eof or (ohICH.DocDate>pEndDte);
          end;
          Application.ProcessMessages;
          gBok.otBOKLST.Next;
        until gBok.otBOKLST.Eof;
      end;
    end else mParLst.AddItm(Strint(pParNum,0));
    If mParLst.Count>0 then begin
      mParLst.First;
      Repeat
        mParNum:=ValInt(mParLst.Itm);
        If (mParNum>0) and oPar.ohPARCAT.LocParNum(mParNum) then begin
          mIcdlst.Clear;
          gBok.LoadBoks('ICB','');
          If gBok.otBOKLST.Count>0 then begin
            gBok.otBOKLST.First;
            Repeat
              Open(gBok.otBOKLST.BokNum);
              If ohICH.LocatePaCode(mParNum) then begin
                Repeat
                  If InDateinterval(pBegDte,pEndDte,ohICH.DocDate) and (IsNotNul(ohICH.FgEndVal) or (pDocTyp='')) then begin
                    PrnDoc(ohICH.DocNum,TRUE,'',1,TRUE); // Tla� adan�ho dokladu do PDF s�boru
                    mIcdLst.AddItm(ohICH.DocNum);
                  end;
                  ohICH.Next;
                until ohICH.Eof or (ohICH.PaCode>mParNum);
              end;
              Application.ProcessMessages;
              gBok.otBOKLST.Next;
            until gBok.otBOKLST.Eof;
          end;
          If mIcdLst.Count>0 then begin // Priprav�me Email pre dan�ho z�kazn�ka
            mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
            // Vytvor�me z�znam pre emailov� server
            mEmd:=TEmdFnc.Create;
            mEmd.ohEMDLST.Insert;
            mEmd.ohEMDLST.EmdNum:=mEmdNum;
            If gPrp.Ocm.FixSnd['020'] then begin
              mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam['020'];
              mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml['020'];  //    'sulik@solidstav.sk';
            end else begin // �daje u��vate�a, ktor� spravuje doklad

            end;
            mEmd.ohEMDLST.TrgAdr:=oPar.ohPARCAT.RegEml;
            mEmd.ohEMDLST.Subjec:='Va�e vystaven� fakt�ry za dne�n� de� '+DateToStr(pBegDte);
            mEmd.ohEMDLST.ParNum:=mParNum;
            mEmd.ohEMDLST.ParNam:=oPar.ohPARCAT.ParNam;
            mEmd.ohEMDLST.CrtDte:=Date;
            mEmd.ohEMDLST.CrtTim:=Time;
            mIcdLst.First;
            Repeat
              If mEmd.ohEMDLST.AtdLst=''
                then mEmd.ohEMDLST.AtdLst:=mIcdLst.Itm+'.PDF'
                else mEmd.ohEMDLST.AtdLst:=mEmd.ohEMDLST.AtdLst+';'+mIcdLst.Itm+'.PDF';
              mIcdLst.Next;
            until mIcdLst.Eof;
            mEmd.ohEMDLST.AtdDoq:=mIcdLst.Count; // Po�et pripojen�ch pr�lohov�ch dokumentov
//            mEmd.ohEMDLST.AtdNum:=ohOCHLST.DocNum;
            mEmd.ohEMDLST.AtdTyp:='OD';
            mEmd.ohEMDLST.ErrSta:='P';  // Pr�znak, �e treba pripoji� prilohu
            mEmd.ohEMDLST.EmlMsk:='icdper.html';
            mEmd.ohEMDLST.SndSta:='P';
            mEmd.ohEMDLST.Post;
            mEmd.AddVar('CurDte',DateToStr(pBegDte));
            mEmd.CrtEmd(mEmdNum);
            If mEmd.ErrCod=0 then begin // Po��tadlo odoslan�ch emailov
//              ohOCHLST.Edit;
//              ohOCHLST.EmlCnt:=ohOCHLST.EmlCnt+1;
//              ohOCHLST.Post;
            end;
            FreeAndNil(mEmd);
          end;
        end;
        Application.ProcessMessages;
        mParLst.Next;
      until mParLst.Eof;
    end;
  end;
  FreeAndNil(mIcdLst);
  FreeAndNil(mParLst);
  FreeAndNil(mIcd);
end;
*)

end.


