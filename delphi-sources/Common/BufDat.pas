unit BufDat;

interface

uses
  IcTypes, IcTools, IcConv, IcVariab, NexPath,
  StdCtrls, Forms, Classes, SysUtils, Dialogs;

type
  TItmRec = record  // Udaje polozky prvotneho dokladu
    ItmNum: word;         // Poradove cislo polozky dokldu
    MgCode: longint;      // Tovarova skupina
    FgCode: longint;      // Financna skupina
    GsCode: longint;      // Tovarove cislo polozky
    GsName: Str60;        // Nazov tovaru
    BarCode: Str15;       // Identifikacny kod tovaru
    StkCode: Str15;       // Skladovy kod tovaru
    Notice: Str30;        // Poznamka k riadku dokladu
    StkNum: word;         // Cislo skladu, odkial tovar bude vydany
    Volume: double;       // Objem tovaru (mnozstvo MJ na 1 m3)
    Weight: double;       // Vaha tovaru (vaha jednej MJ)
    PackGs: longint;      // Tovarove cislo priradeneho vratneho obalu
    GsType: Str1;         // Typ polo×ky (T-riadny tovar,W-vahovy tovar,O-obal)
    MsName: Str10;        // Merna jednotka tovaru
    GsQnt: double;        // Predane mnozstvo - zakladne
    GscQnt: double;       // Predane mnozstvo - kartony
    GspQnt: double;       // Predane mnozstvo - palety
    GscKfc: word;         // Poèet kusov v kartónovom balení
    GspKfc: word;         // Poèet kartónov v paletovom balení
    FreQnt: double;       // Volne mnozstvo na predaj - zakladne
    EndQnt: double;       // Zostatok na predaj FreQnt-GsQnt
    VatPrc: byte;         // Sadzba DPH v %
    DscPrc: double;       // Percentualna sadzba zlavy
    DscType: Str1;        // Typove oznacenia poskytnutej zlavy
    DrbDate: TDateTime;   // Datum najneskorsej spotreby - expiracie
    DlvDate: TDateTime;   // Datum vyskladnenia tovaru
    DlvUser: Str8;        // Prihlasovacie meno skladnika, ktory vyskladnil tovar
    PdnMust: boolean;     // Povinne sledovanie vyrobnych cisiel
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
  end;

  TItmDat = class
    constructor Create;
    destructor Destroy; override;
  private
    oDat:TItmRec;
  public
    procedure Clear;
  published
    property ItmNum:word read oDat.ItmNum write oDat.ItmNum;
    property MgCode:longint read oDat.MgCode write oDat.MgCode;
    property FgCode:longint read oDat.FgCode write oDat.FgCode;
    property GsCode:longint read oDat.GsCode write oDat.GsCode;
    property GsName:Str60 read oDat.GsName write oDat.GsName;
    property BarCode:Str15 read oDat.BarCode write oDat.BarCode;
    property StkCode:Str15 read oDat.StkCode write oDat.StkCode;
    property Notice:Str30 read oDat.Notice write oDat.Notice;
    property StkNum:word read oDat.StkNum write oDat.StkNum;
    property Volume:double read oDat.Volume write oDat.Volume;
    property Weight:double read oDat.Weight write oDat.Weight;
    property PackGs:longint read oDat.PackGs write oDat.PackGs;
    property GsType:Str1 read oDat.GsType write oDat.GsType;
    property MsName:Str10 read oDat.MsName write oDat.MsName;
    property GsQnt:double read oDat.GsQnt write oDat.GsQnt;
    property GscQnt:double read oDat.GscQnt write oDat.GscQnt;
    property GspQnt:double read oDat.GspQnt write oDat.GspQnt;
    property GscKfc:word read oDat.GscKfc write oDat.GscKfc;
    property GspKfc:word read oDat.GspKfc write oDat.GspKfc;
    property FreQnt:double read oDat.FreQnt write oDat.FreQnt;
    property EndQnt:double read oDat.EndQnt write oDat.EndQnt;
    property VatPrc:byte read oDat.VatPrc write oDat.VatPrc;
    property DscPrc:double read oDat.DscPrc write oDat.DscPrc;
    property DscType:Str1 read oDat.DscType write oDat.DscType;
    property DrbDate:TDateTime read oDat.DrbDate write oDat.DrbDate;
    property DlvDate:TDateTime read oDat.DlvDate write oDat.DlvDate;
    property DlvUser:Str8 read oDat.DlvUser write oDat.DlvUser;
    property PdnMust:boolean read oDat.PdnMust write oDat.PdnMust;
    property McdNum:Str12 read oDat.McdNum write oDat.McdNum;
    property McdItm:word read oDat.McdItm write oDat.McdItm;
    property OcdNum:Str12 read oDat.OcdNum write oDat.OcdNum;
    property OcdItm:word read oDat.OcdItm write oDat.OcdItm;
    property TcdNum:Str12 read oDat.TcdNum write oDat.TcdNum;
    property TcdItm:word read oDat.TcdItm write oDat.TcdItm;
    property TcdDate:TDateTime read oDat.TcdDate write oDat.TcdDate;
    property IcdNum:Str12 read oDat.IcdNum write oDat.IcdNum;
    property IcdItm:word read oDat.IcdItm write oDat.IcdItm;
    property IcdDate:TDateTime read oDat.IcdDate write oDat.IcdDate;
    property StkStat:Str1 read oDat.StkStat write oDat.StkStat;
    property FinStat:Str1 read oDat.FinStat write oDat.FinStat;
    property Action:Str1 read oDat.Action write oDat.Action;
    property SpMark:Str10 read oDat.SpMark write oDat.SpMark;
    property BonNum:byte read oDat.BonNum write oDat.BonNum;
    property AcCPrice:double read oDat.AcCPrice write oDat.AcCPrice;
    property AcAValue:double read oDat.AcAValue write oDat.AcAValue;
    property AcBValue:double read oDat.AcBValue write oDat.AcBValue;
    property FgDPrice:double read oDat.FgDPrice write oDat.FgDPrice;
    property FgHPrice:double read oDat.FgHPrice write oDat.FgHPrice;
    property FgAPrice:double read oDat.FgAPrice write oDat.FgAPrice;
    property FgBPrice:double read oDat.FgBPrice write oDat.FgBPrice;
    property FgDValue:double read oDat.FgDValue write oDat.FgDValue;
    property FgHValue:double read oDat.FgHValue write oDat.FgHValue;
    property FgAValue:double read oDat.FgAValue write oDat.FgAValue;
    property FgBValue:double read oDat.FgBValue write oDat.FgBValue;
    property FgFract:byte read oDat.FgFract write oDat.FgFract;
  end;

  // ***************************************************************************

  TPacRec = record
    IcPlsNum: word;   // Cislo cennika zmluvnych cien
    IcAplNum: word;   // Cislo cennika akciovych cien
    IcDscPrc: double; // Zlava zadanej firmy
  end;

  TPacDat = class
    constructor Create;
    destructor Destroy; override;
  private
  public
    procedure Clear;
  published
  end;

implementation

// ********************************** ItmDat ***********************************

constructor TItmDat.Create;
begin
end;

destructor TItmDat.Destroy;
begin
end;

procedure TItmDat.Clear;
begin
end;

// ********************************** PacDat ***********************************

constructor TPacDat.Create;
begin
end;

destructor TPacDat.Destroy;
begin
end;

procedure TPacDat.Clear;
begin
end;


end.
