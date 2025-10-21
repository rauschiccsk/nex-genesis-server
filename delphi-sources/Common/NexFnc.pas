unit NexFnc;
{$F+}

// *****************************************************************************
//                   IZOLOVANE FUNKCIE INFORMACNEHO SYSTEMU NEX
// *****************************************************************************
// Praca s dokladmi:
//   Pri volan� niektorej funkcie ktor� pracuju s dokladmi syst�m otvori objekt
//   pre dan� doklad a drzi uzatvoren� dovtedi pokial tento objekt nie je
//   uzatvoren�.
//
// Programov� funkcia:
// ---------------
// Call - vseobecna metoda na volanie izolovanych funkcii
//        - ALB - Prenajom zariadeni

//        - AMHEDI - Zad�vanie hlavi�ky cenovej ponuky pren�jmu
//        - AMILST - Zoznam pooloziek zapozicnej cenovej ponuky
//        - AMDDSC - Z�ava na vybran� cenov� ponuku pren�jmu
//        - AMDFLT - Filtrovanie cenov�ch pon�k pren�jmu tovaru

//        - AOHEDI - Zad�vanie hlavi�ky z�kazky pren�jmu tovaru
//        - AOILST - Zoznam pooloziek z�kazky pren�jmu tovaru
//        - AODDSC - Z�ava na vybran� z�kazku pren�jmu tovaru
//        - AODFLT - Filtrovanie z�kazky pren�jmu tovaru

//        - ALHEDI - Zad�vanie hlavi�ky z�po�i�n�ho dokladu

//        - FJRBLC - Intern� v�kaz pr�jmov a v�dajov
//        - CSDFLT - Filtrovanie poladni�n�ch dodkladov
//        - ISDFLT - Filtrovanie dod�vate�sk�ch fakt�r
//        - ICDFLT - Filtrovanie odberate�sk�ch fakt�r

//        - DocPrn - tlac zadaneho dokladu (parameter je c�slo dokladu)
//        - DocDel - zrusenie zadaneho dokladu (parameter je c�slo dokladu)
//        - DocAdd - pridavanie noveho dokladu
//        - DocRnd - zaokruhlenie zadaneho dokladu
//        - DocClc - prepo�et hlavi�ky zadaneho dokladu pod�a jeho polo�iek
//        - DocAcc - rozuctovanie zadaneho dokladu
//        - DocSnd - odoslanie zadneho dokladu na inu prevadzku
//        - DocTxt - ulozenie dokladu do textoveho suboru
//        - DocRes - zarezervuje zadan� doklad
//        - DocUnr - zrus� rezerv�ciu zadan�ho dokladu
//        - DocItm - zoznam poloziek zadaneho dokladu
//
//        - ItmAdd -
//        - ItmDel -
//
//        - XXX.NxtSerNum - nasledovne poradov� ��slo dokladu
//        - XXX.FreSerNum - prve volne poradov� ��slo dokladu
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
    dtSC: ; // Servisn� z�kazky
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
