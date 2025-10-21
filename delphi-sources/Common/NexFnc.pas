unit NexFnc;
{$F+}

// *****************************************************************************
//                   IZOLOVANE FUNKCIE INFORMACNEHO SYSTEMU NEX
// *****************************************************************************
// Praca s dokladmi:
//   Pri volaní niektorej funkcie ktoré pracuju s dokladmi systém otvori objekt
//   pre daný doklad a drzi uzatvorení dovtedi pokial tento objekt nie je
//   uzatvorený.
//
// Programové funkcia:
// ---------------
// Call - vseobecna metoda na volanie izolovanych funkcii
//        - ALB - Prenajom zariadeni

//        - AMHEDI - Zadávanie hlavièky cenovej ponuky prenájmu
//        - AMILST - Zoznam pooloziek zapozicnej cenovej ponuky
//        - AMDDSC - Z¾ava na vybranú cenovú ponuku prenájmu
//        - AMDFLT - Filtrovanie cenových ponúk prenájmu tovaru

//        - AOHEDI - Zadávanie hlavièky zákazky prenájmu tovaru
//        - AOILST - Zoznam pooloziek zákazky prenájmu tovaru
//        - AODDSC - Z¾ava na vybranú zákazku prenájmu tovaru
//        - AODFLT - Filtrovanie zákazky prenájmu tovaru

//        - ALHEDI - Zadávanie hlavièky zápožièného dokladu

//        - FJRBLC - Interný výkaz príjmov a výdajov
//        - CSDFLT - Filtrovanie poladnièných dodkladov
//        - ISDFLT - Filtrovanie dodávate¾ských faktúr
//        - ICDFLT - Filtrovanie odberate¾ských faktúr

//        - DocPrn - tlac zadaneho dokladu (parameter je císlo dokladu)
//        - DocDel - zrusenie zadaneho dokladu (parameter je císlo dokladu)
//        - DocAdd - pridavanie noveho dokladu
//        - DocRnd - zaokruhlenie zadaneho dokladu
//        - DocClc - prepoèet hlavièky zadaneho dokladu pod¾a jeho položiek
//        - DocAcc - rozuctovanie zadaneho dokladu
//        - DocSnd - odoslanie zadneho dokladu na inu prevadzku
//        - DocTxt - ulozenie dokladu do textoveho suboru
//        - DocRes - zarezervuje zadaný doklad
//        - DocUnr - zrusí rezerváciu zadaného dokladu
//        - DocItm - zoznam poloziek zadaneho dokladu
//
//        - ItmAdd -
//        - ItmDel -
//
//        - XXX.NxtSerNum - nasledovne poradové èíslo dokladu
//        - XXX.FreSerNum - prve volne poradové èíslo dokladu
//        - XXX.GenDocNum - vygeneruje interne cislo dokladu
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, Key,
  Tcd, Icd, Oac, FjrBlc_F,
  LangForm, SysUtils, Classes, Forms;

type
  TNexFnc = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oTcd:TTcd;
      oIcd:TIcd;
      procedure DocIni (pDocTyp:byte);  // Inicializuje objekt na na zadany typ dokladu
    public
      function Call(pFnc,pPar:ShortString):longint;
      procedure DocPrn(pDocNum:Str12);
      procedure DocClc(pDocNum:Str12);
      procedure DocAcc(pDocNum:Str12);
      procedure FjrBlc;
    published
  end;

function FncCall(pFnc,pPar:ShortString):longint;

implementation


function FncCall(pFnc,pPar:ShortString):longint;
var mFnc:TNexFnc;
begin
  mFnc := TNexFnc.Create;
  Result := mFnc.Call(pFnc,pPar);
  FreeAndNil(mFnc);
end;

// ********************************** OBJEKT ***********************************

constructor TNexFnc.Create;
begin
  oTcd := nil;
  oIcd := nil;
end;

destructor TNexFnc.Destroy;
begin
  If oTcd<>nil then FreeAndNil(oTcd);
  If oIcd<>nil then FreeAndNil(oIcd);
end;

// ********************************** PRIVATE **********************************

procedure TNexFnc.DocIni (pDocTyp:byte);  // Inicializuje objekt na na zadany doklad
begin
  case pDocTyp of
    dtIM: ; // Interne skladove prijemky
    dtOM: ; // Interne skladove vydajky
    dtRM: ; // Medziskladove presuny
    dtPK: ; // Manualne prebalenie tovaru
    dtMS: ; // Dodavatelske cenove ponuky
    dtOS: ; // Dodavatelske objednavky
    dtTS: ; // Dodavatelske dodacie listy
    dtIS: ; // Dodavatelske faktury
    dtMC: ; // Odberatelske cenove ponuky
    dtOC: ; // Odberatelske objednavky
    dtTC: oTcd := TTcd.Create(Self); // Odberatelske dodacie listy
    dtIC: oIcd := TIcd.Create(Self);   // Odberatelske faktury
    dtCS: ; // Hotovostne pokladnicne doklady
    dtSO: ; // Bankove vypisy
    dtID: ; // Interne uctovne doklady
    dtSV: ; // Faktura za zalohu
    dtMI: ; // Prijemka MTZ
    dtMO: ; // Vydajka MTZ
    dtCM: ; // Kompletizacia vyrobkov
    dtSA: ; // Skladove vydajky MO perdaja
    dtSC: ; // Servisné zákazky
    dtOW: ; // Doklad vyuctovania sluzobnej cesty
    dtUD: ; // Univerzalny odbytovy doklad
    dtCD: ; // Vyrobny doklad
    dtTO: ; // Terminalova skladova vydajka
    dtTI: ; // Terminalova skladova prijemka
    dtPI: ; // Pozicna skladova prijemka
  end;
end;

// ********************************** PUBLIC ***********************************

function TNexFnc.Call(pFnc,pPar:ShortString):longint;
begin
  Result := 0;
  pFnc := UpString(pFnc);
  If pFnc='DOCPRN' then DocPrn(pPar);
  If pFnc='DOCCLC' then DocClc(pPar);
  If pFnc='DOCACC' then DocAcc(pPar);
  If pFnc='FJRBLC' then FjrBlc;
end;

procedure TNexFnc.DocPrn (pDocNum:Str12);
var mDocTyp:byte;
begin
  mDocTyp := GetDocType (pDocNum);
  DocIni (mDocTyp);
  case mDocTyp of
    dtIM: ;
    dtOM: ;
    dtRM: ;
    dtPK: ;
    dtMS: ;
    dtOS: ;
    dtTS: ;
    dtIS: ;
    dtMC: ;
    dtOC: ;
    dtTC: oTcd.PrnDoc(pDocNum,'',FALSE,'','',0);
    dtIC: oIcd.PrnDoc(pDocNum,FALSE,'','',0);
    dtCS: ;
    dtSO: ;
    dtID: ;
    dtSV: ;
    dtMI: ;
    dtMO: ;
    dtCM: ;
    dtSA: ;
    dtSC: ;
    dtOW: ;
    dtUD: ;
    dtCD: ;
    dtTO: ;
    dtTI: ;
  end;
end;

procedure TNexFnc.DocClc (pDocNum:Str12);
var mDocTyp:byte;
begin
  mDocTyp := GetDocType (pDocNum);
  DocIni (mDocTyp);
  case mDocTyp of
    dtIM: ;
    dtOM: ;
    dtRM: ;
    dtPK: ;
    dtMS: ;
    dtOS: ;
    dtTS: ;
    dtIS: ;
    dtMC: ;
    dtOC: ;
    dtTC: oTcd.ClcDoc(pDocNum);
    dtIC: ;
    dtCS: ;
    dtSO: ;
    dtID: ;
    dtSV: ;
    dtMI: ;
    dtMO: ;
    dtCM: ;
    dtSA: ;
    dtSC: ;
    dtOW: ;
    dtUD: ;
    dtCD: ;
    dtTO: ;
    dtTI: ;
    dtPI: ;
  end;
end;

procedure TNexFnc.DocAcc(pDocNum:Str12);
var mOac:TOac;
begin
  mOac := TOac.Create(Self);
  mOac.Acc(pDocNum);
  FreeAndNil(mOac);
end;

procedure TNexFnc.FjrBlc;
var mFjrBlc:TFjrBlcF;
begin
  mFjrBlc := TFjrBlcF.Create(Self);
  mFjrBlc.Execute;
  FreeAndNil(mFjrBlc);
end;

end.
