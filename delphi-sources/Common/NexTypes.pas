unit NexTypes;

interface

uses
  Windows, SysUtils, Classes, IcTypes;

type
  TItmData=record // Udaje polozky prvotneho dokladu
    ItmNum: word;         // Poradove cislo polozky dokldu
    MgCode: longint;      // Tovarova skupina
    FgCode: longint;      // Financna skupina
    GsCode: longint;      // Tovarove cislo polozky
    GsName: Str30;        // Nazov tovaru
    BarCode: Str15;       // Identifikacny kod tovaru
    StkCode: Str15;       // Skladovy kod tovaru
    Notice: Str30;        // Poznamka k riadku dokladu
    StkNum: word;         // Cislo skladu, odkial tovar bude vydany
    Volume: double;       // Objem tovaru (mnozstvo MJ na 1 m3)
    Weight: double;       // Vaha tovaru (vaha jednej MJ)
    PackGs: longint;      // Tovarove cislo priradeneho vratneho obalu
    GsType: Str1;         // Typ polo◊ky (T-riadny tovar,W-vahovy tovar,O-obal)
    MsName: Str10;        // Merna jednotka tovaru
    GsQnt: double;        // Predane mnozstvo - zakladne
    GscQnt: double;       // Predane mnozstvo - kartony
    GspQnt: double;       // Predane mnozstvo - palety
    GscKfc: word;         // PoËet kusov v kartÛnovom balenÌ
    GspKfc: word;         // PoËet kartÛnov v paletovom balenÌ
    ActQnt: double;       // Aktualna skaldova zasoba
    FreQnt: double;       // Volne mnozstvo na predaj - zakladne
    EndQnt: double;       // Zostatok na predaj FreQnt-GsQnt
    OsdQnt: double;       // Objednane mnozstvo
    VatPrc: byte;         // Sadzba DPH v %
    DscPrc: double;       // Percentualna sadzba zlavy
    DscType: Str5;        // Typove oznacenia poskytnutej zlavy
    DrbDate: TDateTime;   // Datum najneskorsej spotreby - expiracie 
    DlvDate: TDateTime;   // Datum vyskladnenia tovaru
    DlvUser: Str8;        // Prihlasovacie meno skladnika, ktory vyskladnil tovar
    PdnMust: boolean;     // Povinne sledovanie vyrobnych cisiel
    RbaTrc: boolean;      // Povinne sledovanie vyrobnych sarzi
    DrbMust:boolean;      // Povinne sledovanie trvanlivosti tovaru
    DrbDay: word;         // pocet dni trvanlivosti tovaru
    McdNum: Str12;        // Cislo odberatelskej cenovej ponuky
    McdItm: word;         // Riadok odberatelskej cenovej ponuky
    OcdNum: Str12;        // Cislo odberatelskej zakazky
    OcdItm: word;         // Riadok odberatelskej zakazky
    TcdNum: Str12;        // Cislo odberatelskeho dodacieho listu
    TcdItm: word;         // Riadok odberatelskeho dodacieho listu
    TcdDate: TDateTime;   // Datum odberatelskeho dodacieho listu
    IcdNum: Str12;        // Cislo odberatelskej faktury
    IcdItm: word;         // Riadok odberatelskej faktury
    IcdDate: TDateTime;   // Datum vystavenia faktury
    StkStat: Str1;        // Stav polozky (N-nerealiz.,O-obj.,R-realiz.,P-pripravena,S-vyskladnena,E-exped.)
    FinStat: Str1;        // Stav polozky (F-vyfakturovane,C-vyuctovane cez ERP)
    Action: Str1;         // Priznak cenovej akcie (A-akciovy tovar)
    SpMark: Str10;        // Vseobecne pole na oznacenie faktury
    BonNum: byte;         // Cislo bonusovej akcie
    AcCPrice: double;     // NC/MJ bez DPH v uctovnej mene
    AcCValue: double;     // NC bez DPH v uctovnej mene
    AcEValue: double;     // NC s DPH v uctovnej mene
    AcAValue: double;     // PC bez DPH po zlave v uctovnej mene
    AcBValue: double;     // PC s DPH po zlave v uctovnej mene
    FgDPrice: double;     // PC/MJ bez DPH pred zlavou vo vyuctovnej mene
    FgHPrice: double;     // PC/MJ s DPH pred zlavou vo vyuctovnej mene
    FgAPrice: double;     // PC/MJ bez DPH po zlave vo vyuctovnej mene
    FgBPrice: double;     // PC/MJ s DPH po zlave vo vyuctovnej mene
    FgDValue: double;     // PC bez DPH pred zlavou vo vyuctovnej mene
    FgHValue: double;     // PC s DPH pred zlavou vo vyuctovnej mene
    FgAValue: double;     // PC bez DPH po zlave vo vyuctovnej mene
    FgBValue: double;     // PC s DPH po zlave vo vyuctovnej mene
    FgFract: byte;        // Pocet desatinnych miest jednotkovej predajnej ceny v UM
    PrfPrc: double;       // Obchodna marza
    OrdPrn: byte;         // »Ìslo oddelenia kde sa bude tlaËiù reötauraËn· objedn·vka
    DivSet: byte;         // Priznak delitelnosti tovaru
    OpenGs: boolean;      // OrvorenÈ PLU - moûno meniù predajn˙ cenu na pokladniach
    DisFlag: boolean;     // Vyradenie z evidencie (1-vyraden˝ z evidencie)
    // Hlavickove udaje
    DocNum:Str12;       // Cislo dokladu
    DocDate:TDateTime;  // Datum vystavenia dokladu
    DlrCode:word;       // Kod obchodneho zoastupcu
    PaCode:longint;     // Kod partnera
    FgCourse:double;    // Kurz vyuctovacen meny
    IcPlsNum:word;      // Cennik zmluvnych cien
    IcAplNum:word;      // Cennik akciovych cien
    IcDscPrc:double;    // Globalna zlava odberatela
    IcFacPrc:double;    // Faktoringova prirazka
    CctVat:byte;        // Prenesenie daj povinnosti DPH
  end;

  TPaData = record    // Skryte udaje vybranej firmy
    IcPlsNum: word;   // Cislo cennika zmluvnych cien
    IcAplNum: word;   // Cislo cennika akciovych cien
    IcDscPrc: double; // Zlava zadanej firmy
    IcFacDay: word;   // Fatctoringova splatnost - pocet dn°
    IcFacPrc: double; // Percentualne zvysenie cien v pripade Factoringu
  end;

  TSaveData=procedure (pItmData:TItmData) of object;
  TNewItem=function:word of object;
  TAddNewGs=function (pGsCode:longint):boolean of object;

implementation

end.
{MOD 1809009}
