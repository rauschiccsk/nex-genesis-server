unit DocFnc;
// *****************************************************************************
//              FUNKCIE, KTORÉ PRACUJÚ S VIACERİMI DRUHMI DOKLADOV
// *****************************************************************************
//             OPTIMALIZÁCIA REZERVACIÍ Z DODÁVATE¼SKİCH OBJEDNÁVOK
// Rezervácia z dodávate¾skıch objednávok sa vykonáva na základe termínu dodávky
// uvedeného v dodávate¾skej objednávke a na základe poadovaného termínu dodávky
// zo strany zákazníka. Systém sa snaí vykona rezerváciu tak, aby termín
// dodávky dodávate¾a a poadovanı termín od zákazníka èasovo boli èo najblišie.
// Optimalizova rezerváciu znamená, e v prípade nejakje zmeny ihneï upravi
// existujúcu rezerváciu tak, aby medzi dátumom dodávky dodávate¾a a poadovanım
// termínom zákazníka nebol iadny inı objednanı tovar. Túto operáciu systém
// vykoná nasledovnım spôsobom:
// 1. Na zadané tovarového èísla (PLU) vyh¾adá všetky nedodané poloky z dodáva-
//    te¾skıch objednávok.
// 2. Zotriedi tieto záznamy pod¾a dátumu dodávky dodávate¾a
// 3. Prekontroluje, èi rezervácia konkrétnej poloky zákazky je optimálna t.j.
//    zo zadu (z dátumového h¾adiska) nájde najblišíe moné rezervácie - ak
//    daná zákazka je rezervovaná tak ponechá ak nie zmení rezerváciu.
//
// MONÉ PRÍPADY
// 1. Dodávate¾ zmení svôj termín dodávky
//    1.1. Zákazky je moné splni len zo èiastoène alebo úplne zo zásoby
//    1.2. Zákazky nie je moné splni k poadovanému termínu
//    1.3. Zákazky nie je moné èiastoène alebo úplne splni
// 2. Zrušenie polky dodávate¾skej objednávky
// 3. Bola spravená nová objednávka a je moné optimalizova rezerváciu
// 4. Zákazník chce zmeni svôj poadovanı termín dodávky
// 5. Zrušenie poloky zákazkového dokladu
//
// OPTIMALIZAÈNİ PROCES (virtuálna rezervácia):
// 1. Systém pozbiera z dodávate¾skıch objednávok na dané PLU všetky nedodané
//    poloky, ktoré majú termín dodávky.
// 2. Zotriedíme tento zoznam pod¾a dátumu dodávky dodávate¾a
// 3. Vytvoríme zoznam nedodanıch poloiek z odberate¾skıch zákaziek (poiadavka,
//    rezervácia zo zásoby, rezervácia z objednávky)
// 4. Zotriedíme tento zoznam pod¾a poadovaného dátumu dodávky zákazníka
// 5. Oznaèíme skladovú kartu s príznakom, e prebieha optimalizácia skladovej
//    rezerácie
// 6. Zapamätáme stav skaldovej karty pred virtuálnou rezerváciou (FrePrq)
// 7. Vykonáme virtuálnu rezerváciu t.j. v doèasnıch súboroch, kde sú údaje
//    len jednej tovarovej poloky
//    - OSITMP.BTR - nedodané poloky dodávate¾skıch objednávok
//    - OCITMP.BTR - nedodané poloky z odberate¾skıch zákaziek
//    - OCRTMP.BTR - detailnı rozpis rezervácie
// 8. Po vykonaní virtuálnej rezervácie prekontrolujeme èi sa nezmenil stav
//    skaldovej karty.
// 9. Ak stav sa nezmenil dopíšeme do skladovej karty zákazkovú rezerváciu
//    zo zásoby a z objednávky
// 10.Následne zapíšeme údaje z OSIVIR.BTR do OSILST.BTR
// 11.Prepoèítame kadú hlavièku dodávate¾skej objednávky, v ktorej bola robená
//    nejaká zmena.
// 11.Zapíšeme údaje z OCRVIR.BTR do OCRLST.BTR
//
// POIADAVKY:
// 1. Optimalizácia nemôe pokazi rezerváciu t.j. ak zákazník u bol informovanı,
//    e tovar dostane do poadovaného termínu pútimalizácia nemôe zmeni
//    rezerváciu tak, aby nedostal svôj tovar na poadovanı termín.
// -----------------------------------------------------------------------------
//                         POPIS JEDNOTLIVİCH FUNKCII
//
// OptOcdRes - Optimalizácia zákazkovıch rezervácii. Táto funkcia v zadanom
//             sklade pre zadané PLU spraví novú rezerváciu pod¾a aktuálneho
//             stavu systému a tım vlastne optimalizuje rezerváciu. Rezervácia
//             sa skladá z dvoch fáz. V prvej fáze systém zarezervuje tie poloky,
//             ktoré boli zarezervoované aj v perdchádzajúcom stave a a následne
//             pristúpi k rezervácie poiadaviek. Je to riešené takto z dôvodu,
//             aby nedošlo k takému prípadu, e zákazníkovi bol oznámenı, e jeho
//             zákazku bude splnená do poadovaného termínu a následne pri nejakej
//             optimalizácii systém rezervevanı tovar pre tohoto zákazníka by
//             presunul na inú zákazku.
//               pStkNum - Èíslo skladu
//               pProNum - Registraèné èíslo produktu (PLU)
//
//                      ------------- OSD ---------------
// ClcOsiRes - Prepoèíta zákazkovú rezervácie na poloke dodávate¾skej objednávky
//             z detailov objednávkovıch rezervácii (OCRLST)
//               pOsiAdr - Fyzická adresa poloky dodávate¾skej objednávky
//
// ClcOciRes - Prepoèíta rezervácie na poloke odberate¾skej zákazky z detailov
//             objednávkovıch rezervácii (OCRLST)
//               pOciAdr - Fyzická adresa poloky odberate¾skej zákazky
//
// AddOciRes - Vykoná rezerváciu z zadanej poloky zákazkového dokladu.
//               pOciAdr - Fyzická adresa poloky odberate¾skej zákazky
//               pResTyp - Typ rezervácie (S-len zo zásoby;O-len z objednávky;
//                         ak je prázdne potom naprv z objednávky a následne
//                         zo zásoby)
//
// DelOciRst - Zruší skladovú rezerváciu zadanej poloky zákazkového dokladu
//               pOciAdr - Fyzická adresa poloky odberate¾skej zákazky
//
// DelOciRes - Zruší rezerváciu zadanej poloky zákazkového dokladu
//               pOciAdr - Fyzická adresa poloky odberate¾skej zákazky
//
//                      ------------- OCD ---------------
// AddNewOci - Zaloí do zadaného zákazkového dokladu novú poloku
//               pOcdNum - Interné èíslo zákazky do ktorej bude poloka vytvorená
//               pProNum - Produktové èíslo novej poloky
//               pSalPqr - Predané mnostvo
//               pItmFrm - Názov formulára pomocou ktorého poloka bola zaloená
//
// ClrTcdItm - Zruší odkaz zákazkového dokladu na odberate¾skı dodací list a
//             Prepoèíta hlavièku danej záakzky. Táto funkcia sa pouíva pri
//             zrušení poloky doberate¾ského doacieho listu.
//               pOcdNum - Intermé èíslo zákazkového dokladu
//               pOciNum - Èíslo poloky zákazkového dokladu
//               pTcdPrq - Dodané mnostvo
//
//                      ------------- OCD ---------------
// EmsTcdPer - Odošle emailom všetky odberate¾ské dodacie listy za dané obdobie
//               pParNum - kód firmy, komu treba odosla dodacie listy. Ak je
//                         zadaná 0 potom systém pre kadú firmu odošle.
//               pBegDte - zaèiatok dátumového intervalu
//               pEndDte - koniec dátumového intervalu
//               pDocTyp - typ dokladu, ktoré treba odosla: ak je prázdne potom
//                         všetky dodacie listy budú odoslané, ak je N potom len
//                         nevyfakturované.
//
// EmsIcdPer - Odošle emailom všetky odberate¾ské faktúry za dané obdobie
//               pParNum - kód firmy, komu treba odosla faktúry. Ak je zadaná 0
//                         potom systém pre kadú firmu odošle.
//               pBegDte - zaèiatok dátumového intervalu
//               pEndDte - koniec dátumového intervalu
//               pDocTyp - typ dokladu, ktoré treba odosla: ak je prázdne potom
//                         všetky faktúry budú odoslané, ak je N potom len neuh-
//                         radené.
// -----------------------------------------------------------------------------
// ************************* POUITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// OSITMP.BTR - Nedodané poloky dodávate¾skıch objednávok pre konkrétne PLU.
// OCITMP.BTR - Nedodané poloky odberate¾skıch zákaziek pre konkrétne PLU.
// OCRTMP.BTR - Detailnı rozpis rezervácii odberate¾skıch zákaziek z dodávate¾-
//              skıch objednávok.
//              Hore uvedené databázové súbory sú pouívané pri optimalizácie
//              zákazkovej rezervácie z dodávate¾skıch objednávok. Sú to doèasné
//              (pomocné) súbory, ktoré sa pouívajú len pokia¾ systém nevykoná
//              optimalizáciu jedného konkrétneho tovaru. Pouívame BTR súbor
//              preto, aby v prípade nedokonèenej operácie (vıpadku) systém mohol
//              danú operáciu dodatoène dokonèi.
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
    oEdi:TEdiFnc; // Došlé elektronické faktúry
    oSrm:TSrmFnc;
    oBsm:TBsmFnc; // Bankové vıpisy
    oPay:TPayFnc; // Denník úhrady faktúr
    oAcc:TAccFnc; // Úètovné denníky
    // ------------- OSD ---------------
    procedure ClcOsiRes(pOsiAdr:longint);  // Prepoèíta rezervácie z poloky dodávate¾skej objednávky
    procedure DelTsdPrq(pTsdNum:Str12;pTsdItm:word);  // Zruší dodané mnostvo z objednávok
    procedure SavOsiDlv(pProNum:longint;pDlvDoc:Str12;pDlvItm:longint;pDlvDte:TDate;pDlvPrq:double);  // Odpíše z nedodanıch objednávok prijaté mnostvo pod¾a poradia FIFO
    // ------------- OCD ---------------
    procedure AddNewOci(pOcdNum:Str12;pProNum:longint;pSalPrq,pPlsBpc,pSalBpc,pTrsBva:double;pItmFrm:Str10); // Zaloí do zadaného zákazkového dokladu novú poloku
    procedure AddOciRst(pOciAdr:longint);  // Vykoná rezerváciu zo skladovej zásoby
    procedure AddOciRos(pOciAdr:longint;pBegTyp:Str1); // Vykoná rezerváciu z objednávky pod¾a zadanej schémy
    procedure AddOciRes(pOciAdr:longint;pResTyp:Str1); // Vykoná rezerváciu zadanej poloky zákazkového dokladu
    procedure ResOciLst(pStkNum,pProNum:longint);      // Vykoná rezerváciu všetkıch poloiek zadaného PLU v zadanom sklade
    procedure DelOciRst(pOciAdr:longint);  // Zruší skladovú rezerváciu zadanej poloky zákazkového dokladu
    procedure DelOciRes(pOciAdr:longint);  // Zruší rezerváciu zadanej poloky zákazkového dokladu
    procedure ClcOciRes(pOciAdr:longint);  // Prepoèíta rezervácie na poloke odberate¾skej zákazky
    procedure ClrTcdItm(pOcdNum:Str12;pOciNum:word;pTcdPrq:double); // ZATIAL Zruší odkaz zákazkového dokladu na dodací list pri zrušení poloky dodacieho listu
    // ------------- TCD ---------------
//    procedure EmsTcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odošle emailom všetky odberate¾ské dodacie listy za zadané obdobie
//    procedure EmsIcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odošle emailom všetky odberate¾ské faktúry za zadané obdobie
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

procedure TDocFnc.ClcOsiRes(pOsiAdr:longint); // Prepoèíta rezervácie z poloky dodávate¾skej objednávky
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

procedure TDocFnc.ClcOciRes(pOciAdr:longint); // Prepoèíta rezervácie na poloke odberate¾skej zákazky
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
      If IsNul(mRosPrq+mRstPrq) and (ohOCILST.TrsDte<>0) then begin // Ak nie je èo doda zrušíme dátum rozvozu
        ohOCILST.Edit;
        ohOCILST.TrsDte:=0;
        ohOCILST.Post;
      end;
    end;
  end;
end;

procedure TDocFnc.AddOciRst(pOciAdr:longint);  // Vykoná rezerváciu zo skladovej zásoby
var mRstPrq:double;
begin
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      If IsNotNul(ohOCILST.UndPrq) then begin  // Zvyšok rezervujeme zo skladovej zásoby
        If not oPro.ohSTCLST.LocSnPn(ohOCILST.StkNum,ohOCILST.ProNum) then oPro.AddNewStc(ohOCILST.StkNum,ohOCILST.ProNum);
        If oPro.ohSTCLST.FrePrq>=ohOCILST.ReqPrq
          then mRstPrq:=ohOCILST.ReqPrq
          else mRstPrq:=oPro.ohSTCLST.FrePrq;
        AddOcrRst(mRstPrq);
        // Zapíšeme dátum rozvozu
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
        ClcOciRes(ohOCILST.ItmAdr);  // Prepoèíta rezervácie na poloke odberate¾skej zákazky
        oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
      end;
    end;
  end;
end;

procedure TDocFnc.AddOciRos(pOciAdr:longint;pBegTyp:Str1);  // Vykoná rezerváciu z objednávky pod¾a zadanej schémy
var mOsiLst,mOsdLst:TLinLst;  mLine:ShortString;  mFrePrq,mRosPrq:double;  mOsiAdr:longint;
begin
  With oOcd do begin
    If ohOCILST.LocItmAdr(pOciAdr) then begin
      mOsdLst:=TLinLst.Create;
      mOsiLst:=TLinLst.Create;
      If oOsd.ohOSILST.LocPnFr(ohOCILST.ProNum,byte(TRUE)) then begin
        Repeat
          If (oOsd.ohOSILST.StkNum=ohOCILST.StkNum) then begin // Ak objednávka je odoslaná, má termín dodania a je z daného skladu
            If (oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq>0) then begin
              mLine:=StrIntZero(Trunc(oOsd.ohOSILST.RatDte),5)+';'+StrInt(oOsd.ohOSILST.ItmAdr,0)+';'+oOsd.ohOSILST.DocNum+';'+StrInt(oOsd.ohOSILST.ItmNum,0); // Naspä do dátumového formátu: ArraySToFloatRev(DecodeB64(xxxx,65));
              mOsiLst.AddItm(mLine);
            end;
          end;
          Application.ProcessMessages;
          oOsd.ohOSILST.Next;
        until oOsd.ohOSILST.Eof or (oOsd.ohOSILST.ProNum<>oOcd.ohOCILST.ProNum) or (oOsd.ohOSILST.FreRes=0);
      end;
      If mOsiLst.Count>0 then begin
        mOsiLst.Sort;
        If pBegTyp='F' then begin // Rezervácia zaèínajúc od prvıch t.j. najstarších objednávok a do konca
          mOsiLst.First;
          Repeat
            mOsiAdr:=ValInt(LineElement(mOsiLst.Itm,1,';'));
            If oOsd.ohOSILST.LocItmAdr(mOsiAdr) then begin
                mFrePrq:=oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq;
                If mFrePrq>ohOCILST.ReqPrq
                  then mRosPrq:=ohOCILST.ReqPrq // Všetko èo treba môeme rezervova z danej poloky
                  else mRosPrq:=mFrePrq; // Vydáme len volné mnostvo
                // Vytvoríme rezervaènı záznam
                AddOcrRos(oOsd.ohOSILST.ItmAdr,oOsd.ohOSILST.DocNum,oOsd.ohOSILST.ItmNum,oOsd.ohOSILST.RatDte,mRosPrq);
                If oOsd.ohOSILST.SndDte>0 then begin
                  If oOsd.ohOSILST.RatDte>ohOCILST.ReqDte then begin // Poadovanı termín zákazníka nie je moné splni
                    ohOCILST.Edit;
                    ohOCILST.RatPrv:=ohOCILST.RatDte;
                    ohOCILST.RatDte:=oOsd.ohOSILST.RatDte;
                    If ohOCHLST.LocDocNum(ohOCILST.DocNum) and (ohOCHLST.TrsCod='V') and (ohOCHLST.TrsLin>0) then ohOCILST.TrsDte:=oTrs.GetTrsDte(oOsd.ohOSILST.RatDte+1,ohOCHLST.TrsLin,FALSE);
                    ohOCILST.RatChg:=ohOCILST.RatChg+1;
                    ohOCILST.RatNot:='Zmenenı termín dodávky';
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
                  ohOCILST.RatNot:='Termín dodávky Vám bude upresnenı';
                  ohOCILST.Post;
                end;
                ClcOciRes(ohOCILST.ItmAdr);  // Prepoèíta rezervácie na poloke odberate¾skej zákazky
                oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
                ClcOsiRes(oOsd.ohOSILST.ItmAdr);  // Prepoèíta rezervácie z poloky dodávate¾skej objednávky
                mOsdLst.AddItm(oOsd.ohOSILST.DocNum);
            end;
            Application.ProcessMessages;
            mOsiLst.Next;
          until mOsiLst.Eof or IsNul(ohOCILST.ReqPrq);
        end;
        If pBegTyp='L' then begin // Rezervácia zaèínajúc od posldenıch t.j. najmladších objednávok od poadovaného termínu
          mOsiLst.Last;
          Repeat
            mOsiAdr:=ValInt(LineElement(mOsiLst.Itm,1,';'));
            If oOsd.ohOSILST.LocItmAdr(mOsiAdr) then begin
              If (oOsd.ohOSILST.RatDte<=ohOCILST.ReqDte) and (oOsd.ohOSILST.RatDte<>0) and (oOsd.ohOSILST.RatDte>Date) then begin // or ((oOsd.ohOSILST.RatDte=0) and ())
                mFrePrq:=oOsd.ohOSILST.UndPrq-oOsd.ohOSILST.RocPrq;
                If mFrePrq>ohOCILST.ReqPrq
                  then mRosPrq:=ohOCILST.ReqPrq // Všetko èo treba môeme rezervova z danej poloky
                  else mRosPrq:=mFrePrq; // Vydáme len volné mnostvo
                // Vytvoríme rezervaènı záznam
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
                ClcOciRes(ohOCILST.ItmAdr);  // Prepoèíta rezervácie na poloke odberate¾skej zákazky
                oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
                ClcOsiRes(oOsd.ohOSILST.ItmAdr);  // Prepoèíta rezervácie z poloky dodávate¾skej objednávky
                mOsdLst.AddItm(oOsd.ohOSILST.DocNum);
              end;
            end;
            Application.ProcessMessages;
            mOsiLst.Prior;
          until mOsiLst.Bof or IsNul(ohOCILST.ReqPrq);
        end;
      end;
    end;
    // Prepoèítame hlavièky zmenenıch objednávok
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
        If mReqDay<=0 then begin  // 1. Rezervácia tovar pod¾a shcémy: "ÈO NAJSKOR"
          AddOciRst(pOciAdr);                                       // 1.1. Rezervujeme tovar zo skaldovej zásoby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); // 1.2. Rezervujeme tovar zaèínajúc od prvıch objednávok a do konca
        end else begin            // 2. Rezervácia tovaru pod¾a schémy: "K ZADANÉMU TERMÍNU"
          AddOciRos(pOciAdr,'L');                                   // 2.1. Rezervujeme tovar zaèínajúc od najmladších objednávok a do poadovaného termínu zákazníka
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRst(pOciAdr);     // 2.2. Rezervujeme tovar zo skaldovej zásoby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); // 2.3. Rezervujeme tovar zaèínajúc od prvıch objednávok a do konca
        end;
        ClcOcdDoc(ohOCILST.DocNum);
      end;
      If pResTyp='O' then begin   // Rezervujeme len z objednávok
        If mReqDay<=0 then begin  // 1. Rezervácia tovar pod¾a shcémy: "ÈO NAJSKOR"
          AddOciRst(pOciAdr);     //    - Rezervujeme tovar zo skaldovej zásoby
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); //    - Rezervujeme tovar zaèínajúc od prvıch objednávok a do konca
        end else begin            // 2. Rezervácia tovaru pod¾a schémy: "K ZADANÉMU TERMÍNU"
          AddOciRos(pOciAdr,'L'); //    - Rezervujeme tovar zaèínajúc od najmladších objednávok a do poadovaného termínu zákazníka
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRos(pOciAdr,'F'); //    2.3. Rezervujeme tovar zaèínajúc od prvıch objednávok a do konca
          If IsNotNul(ohOCILST.ReqPrq) then AddOciRst(pOciAdr);     //    2.4. Rezervujeme tovar zo skaldovej zásoby
        end;
        ClcOcdDoc(ohOCILST.DocNum);
      end;
    end;
  end;
end;

procedure TDocFnc.ResOciLst(pStkNum,pProNum:longint);      // Vykoná rezerváciu všetkıch poloiek zadaného PLU v zadanom sklade
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
      AddOciRes(ValInt(mItmLst.Itm),''); // Vykoná rezerváciu zadanej poloky zákazkového dokladu
      Application.ProcessMessages;
      mItmLst.Next;
    until mItmLst.Eof;
  end;
  FreeAndNil(mItmLst);
end;

procedure TDocFnc.DelOciRst(pOciAdr:longint);  // Zruší skladovú rezerváciu zadanej poloky zákazkového dokladu
var mProNum:longint;  mStkNum:word;
begin
  If oOcd.ohOCRLST.LocIaRt(pOciAdr,'S') then begin
    // TODO historia rezervacie
    mStkNum:=oOcd.ohOCRLST.StkNum;
    mProNum:=oOcd.ohOCRLST.ProNum;
    oOcd.ohOCRLST.Delete;
    ClcOciRes(pOciAdr); // Prepoèíta rezervácie na poloke odberate¾skej zákazky
    oStk.StcClc(mStkNum,mProNum);
  end;
end;

procedure TDocFnc.DelOciRes(pOciAdr:longint);
var mModify:boolean;  mOsiAdr:longint;  mOsdLst:TLinLst;
begin
  mModify:=FALSE;
  If oOcd.ohOCILST.LocItmAdr(pOciAdr) then begin
    mOsdLst:=TLinLst.Create;
    While oOcd.ohOCRLST.LocOciAdr(pOciAdr) do begin  // Vymaeme všetky rezervácie zadaného dokladu
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
    ClcOciRes(pOciAdr); // Prepoèíta rezervácie na poloke odberate¾skej zákazky
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

procedure TDocFnc.DelTsdPrq(pTsdNum:Str12;pTsdItm:word);  // Zruší dodané mnostvo z objednávok
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

procedure TDocFnc.SavOsiDlv(pProNum:longint;pDlvDoc:Str12;pDlvItm:longint;pDlvDte:TDate;pDlvPrq:double);  // Odpíše z nedodanıch objednávok prijaté mnostvo pod¾a poradia FIFO
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
          AddOstItm(ohOSILST.ItmAdr,pDlvDoc,pDlvItm,pDlvDte,mTsdPrq); // Pridá dodávku do histórie
          AddDocLst(ohOSILST.DocNum);  // Pridá èíslo odbjednávky do zoznamu dokladov, ktoré boli zmenené
        end;
        oStk.StcClc(ohOSILST.StkNum,ohOSILST.ProNum);
        Application.ProcessMessages;
        mOsiLst.Next;
      until mOsiLst.Eof or IsNul(mDlvPrq) or (mDlvPrq<0);
      ClcDocLst;  // Prepoèíta všetky hlavièky zoznamu vytvorené pomocou AddDocLst
    end;
  end;
  FreeAndNil(mOsiLst);
end;

procedure TDocFnc.AddNewOci(pOcdNum:Str12;pProNum:longint;pSalPrq,pPlsBpc,pSalBpc,pTrsBva:double;pItmFrm:Str10); // Zaloí do zadaného zákazkového dokladu novú poloku
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
      end else ; // TODO - v bazovej evidencii neexituje poloka pod zadanım produktovım èíslom
    end else ; // TODO - neexistuje hlavièka zadaného dokladu
  end;
end;

procedure TDocFnc.ClrTcdItm(pOcdNum:Str12;pOciNum:word;pTcdPrq:double); // ZATIAL Zruší odkaz zákazkového dokladu na dodací list pri zrušení poloky dodacieho listu
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
procedure TDocFnc.EmsTcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odošle emailom všetky odberate¾ské dodacie listy za zadané obdobie
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
                    PrnPdfDoc(ohTCH.DocNum);  // Tlaè adaného dokladu do PDF súboru
                    mTcdLst.AddItm(ohTCH.DocNum);
                  end;
                  ohTCH.Next;
                until ohTCH.Eof or (ohTCH.PaCode>mParNum);
              end;
              Application.ProcessMessages;
              gBok.otBOKLST.Next;
            until gBok.otBOKLST.Eof;
          end;
          If mTcdLst.Count>0 then begin // Pripravíme Email pre daného zákazníka
            mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
            // Vytvoríme záznam pre emailovı server
            mEmd:=TEmdFnc.Create;
            mEmd.ohEMDLST.Insert;
            mEmd.ohEMDLST.EmdNum:=mEmdNum;
            If gPrp.Ocm.FixSnd['020'] then begin
              mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam['020'];
              mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml['020'];  //    'sulik@solidstav.sk';
            end else begin // Údaje uívate¾a, ktorı spravuje doklad

            end;
            mEmd.ohEMDLST.TrgAdr:=oPar.ohPARCAT.RegEml;
            mEmd.ohEMDLST.Subjec:='Zoznam nevyfakturovaného odobraného tovaru zo dòa '+DateToStr(pBegDte);
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
            mEmd.ohEMDLST.AtdDoq:=mTcdLst.Count; // Poèet pripojenıch prílohovıch dokumentov
//            mEmd.ohEMDLST.AtdNum:=ohOCHLST.DocNum;
            mEmd.ohEMDLST.AtdTyp:='OD';
            mEmd.ohEMDLST.ErrSta:='P';  // Príznak, e treba pripoji prilohu
            mEmd.ohEMDLST.EmlMsk:='tcdper.html';
            mEmd.ohEMDLST.SndSta:='P';
            mEmd.ohEMDLST.Post;
            mEmd.AddVar('CurDte',DateToStr(pBegDte));
            mEmd.CrtEmd(mEmdNum);
            If mEmd.ErrCod=0 then begin // Poèítadlo odoslanıch emailov
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
procedure TDocFnc.EmsIcdPer(pParNum:longint;pBegDte,pEndDte:TDateTime;pDocTyp:Str1); // Odošle emailom všetky odberate¾ské dodacie listy za zadané obdobie
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
                    PrnDoc(ohICH.DocNum,TRUE,'',1,TRUE); // Tlaè adaného dokladu do PDF súboru
                    mIcdLst.AddItm(ohICH.DocNum);
                  end;
                  ohICH.Next;
                until ohICH.Eof or (ohICH.PaCode>mParNum);
              end;
              Application.ProcessMessages;
              gBok.otBOKLST.Next;
            until gBok.otBOKLST.Eof;
          end;
          If mIcdLst.Count>0 then begin // Pripravíme Email pre daného zákazníka
            mEmdNum:=gCnt.NewItmAdr(SysYear,'EM');
            // Vytvoríme záznam pre emailovı server
            mEmd:=TEmdFnc.Create;
            mEmd.ohEMDLST.Insert;
            mEmd.ohEMDLST.EmdNum:=mEmdNum;
            If gPrp.Ocm.FixSnd['020'] then begin
              mEmd.ohEMDLST.SndNam:=gPrp.Ocm.SndNam['020'];
              mEmd.ohEMDLST.SndAdr:=gPrp.Ocm.SndEml['020'];  //    'sulik@solidstav.sk';
            end else begin // Údaje uívate¾a, ktorı spravuje doklad

            end;
            mEmd.ohEMDLST.TrgAdr:=oPar.ohPARCAT.RegEml;
            mEmd.ohEMDLST.Subjec:='Vaše vystavené faktúry za dnešnı deò '+DateToStr(pBegDte);
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
            mEmd.ohEMDLST.AtdDoq:=mIcdLst.Count; // Poèet pripojenıch prílohovıch dokumentov
//            mEmd.ohEMDLST.AtdNum:=ohOCHLST.DocNum;
            mEmd.ohEMDLST.AtdTyp:='OD';
            mEmd.ohEMDLST.ErrSta:='P';  // Príznak, e treba pripoji prilohu
            mEmd.ohEMDLST.EmlMsk:='icdper.html';
            mEmd.ohEMDLST.SndSta:='P';
            mEmd.ohEMDLST.Post;
            mEmd.AddVar('CurDte',DateToStr(pBegDte));
            mEmd.CrtEmd(mEmdNum);
            If mEmd.ErrCod=0 then begin // Poèítadlo odoslanıch emailov
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


