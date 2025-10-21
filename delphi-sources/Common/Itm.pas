unit Itm;

interface  gsd

uses
  Windows, SysUtils, Classes, IcTypes, NexTypes, Forms;

type
  TGsiRec=record
    ItmAdr     longint      ;Fyzick· adresa poloûky
    ItmNum     word         ;PoradovÈ ËÌslo poloûky fakt˙ry - riadok fakt˙ry
    MgcNum     word         ;»Ìslo tovarova skupina
    FgcNum     word         ;»Ìslo finanËnej skupina
    SgcNum     word         ;»Ìslo skupiny pre internetov˝ obchod
    GsiNum     longint      ;TovarovÈ ËÌslo poloûky fakt˙ry
    GsiNam     Str60        ;N·zov tovaru
    BarCod     Str15        ;Identifikacny kod tovaru
    StkCod     Str15        ;Skladov˝ kÛd tovaru
    OrdCod     Str30        ;Objedn·vkov˝ kÛd tovaru
    Volume     double       ;Objem tovaru (mnoûstvo MJ na 1 m3)
    Weight     double       ;V·ha tovaru (v·ha jednej MJ)
    PckGsc     longint      ;Tovarove cislo priradeneho vratneho obalu
    GsiTyp     Str1         ;Typ poloûky (T-riadny tovar,W-vahovy tovar,O-obal)
    MsuNam     Str10        ;Merna jednotka tovaru
    VatPrc     byte         ;Sadzba DPH v %
    PlsApc     double       ;Jednotkov· cena bDPH - cennÌkov· cena (PC)
    PlsBpc     double       ;Jednotkov· cena sDPH - cennÌkov· cena (PC)
    ApsApc     double       ;Jednotkov· cena bDPH - akciov· cena (AC)
    ApsBpc     double       ;Jednotkov· cena sDPH - akciov· cena (AC)
    ApsGsq     word         ;Mnoûstvo pre ktorÈ platÌ akciov· cena
    PadApc     double       ;Jednotkov· cena bDPH - firemn· zæava (PA)
    PadBpc     double       ;Jednotkov· cena sDPH - firemn· zæava (PA)
    DcpApc     double       ;Jednotkov· cena bDPH - diskontn· cena (DC)
    DcpBpc     double       ;Jednotkov· cena sDPH - diskontn· cena (DC)
    AgrApc     double       ;Jednotkov· cena bDPH - zmluvn· cena (ZC)
    AgrBpc     double       ;Jednotkov· cena sDPH - zmluvn· cena (ZC)
    SapApc     double       ;Jednotkov· cena bDPH - cena pre z·kaznÌka
    SapBpc     double       ;Jednotkov· cena sDPH - cena pre z·kaznÌka
    SapSrc     Str2         ;Zdroj predajnej ceny (AC-akcia;ZC-zmluva;DC-diskontn·;PA-firemn·;PC-cennÌkov·)
  end;

  TItm=class
    constructor Create;
    destructor Destroy; override;
    private
      oItm:TItmRec;
    public
      procedure Clear;
    published
      property ItmNum:word read oItm.ItmNum write oItm.ItmNum;        // Poradove cislo polozky dokldu
      property MgCode:longint read oItm.MgCode write oItm.MgCode;     // Tovarova skupina
      property FgCode:longint read oItm.FgCode write oItm.FgCode;     // Financna skupina
      property GsCode:longint read oItm.GsCode write oItm.GsCode;     // Tovarove cislo polozky
      property GsName:Str30 read oItm.GsName write oItm.GsName;       // Nazov tovaru
      property BarCode:Str15 read oItm.BarCode write oItm.BarCode;    // Identifikacny kod tovaru
      property StkCode:Str15 read oItm.StkCode write oItm.StkCode;    // Skladovy kod tovaru
      property Notice:Str30 read oItm.Notice write oItm.Notice;       // Poznamka k riadku dokladu
      property StkNum:word read oItm.StkNum write oItm.StkNum;        // Cislo skladu, odkial tovar bude vydany
      property Volume:double read oItm.Volume write oItm.Volume;      // Objem tovaru (mnozstvo MJ na 1 m3)
      property Weight:double read oItm.Weight write oItm.Weight;      // Vaha tovaru (vaha jednej MJ)
      property PackGs:longint read oItm.PackGs write oItm.PackGs;     // Tovarove cislo priradeneho vratneho obalu
      property GsType:Str1 read oItm.GsType write oItm.GsType;        // Typ polo◊ky (T-riadny tovar,W-vahovy tovar,O-obal)
      property MsName:Str10 read oItm.MsName write oItm.MsName;       // Merna jednotka tovaru
      property GsQnt:double read oItm.GsQnt write oItm.GsQnt;         // Predane mnozstvo - zakladne
      property GscQnt:double read oItm.GscQnt write oItm.GscQnt;      // Predane mnozstvo - kartony
      property GspQnt:double read oItm.GspQnt write oItm.GspQnt;      // Predane mnozstvo - palety
      property GscKfc:word read oItm.GscKfc write oItm.GscKfc;        // PoËet kusov v kartÛnovom balenÌ
      property GspKfc:word read oItm.GspKfc write oItm.GspKfc;        // PoËet kartÛnov v paletovom balenÌ
      property ActQnt:double read oItm.ActQnt write oItm.ActQnt;      // Aktualna skladova zasoba
      property FreQnt:double read oItm.FreQnt write oItm.FreQnt;      // Volne mnozstvo na predaj - zakladne
      property EndQnt:double read oItm.EndQnt write oItm.EndQnt;      // Zostatok na predaj FreQnt-GsQnt
      property OsdQnt:double read oItm.OsdQnt write oItm.OsdQnt;      // Objednane mnozstvo
      property VatPrc:byte read oItm.VatPrc write oItm.VatPrc;        // Sadzba DPH v %
      property DscPrc:double read oItm.DscPrc write oItm.DscPrc;      // Percentualna sadzba zlavy
      property DscType:Str5 read oItm.DscType write oItm.DscType;     // Typove oznacenia poskytnutej zlavy
      property DrbDate:TDateTime read oItm.DrbDate write oItm.DrbDate;// Datum najneskorsej spotreby - expiracie
      property DlvDate:TDateTime read oItm.DlvDate write oItm.DlvDate;// Datum vyskladnenia tovaru
      property DlvUser:Str8 read oItm.DlvUser write oItm.DlvUser;     // Prihlasovacie meno skladnika, ktory vyskladnil tovar
      property PdnMust:boolean read oItm.PdnMust write oItm.PdnMust;  // Povinne sledovanie vyrobnych cisiel
      property DrbMust:boolean read oItm.DrbMust write oItm.DrbMust;  // Povinne sledovanie trvanlivosti tovaru
      property DrbDay:word read oItm.DrbDay write oItm.DrbDay;        // Pocet dni trvanlivosti tovaru
      property McdNum:Str12 read oItm.McdNum write oItm.McdNum;       // Cislo odberatelskej cenovej ponuky
      property McdItm:word read oItm.McdItm write oItm.McdItm;        // Riadok odberatelskej cenovej ponuky
      property OcdNum:Str12 read oItm.OcdNum write oItm.OcdNum;       // Cislo odberatelskej zakazky
      property OcdItm:word read oItm.OcdItm write oItm.OcdItm;        // Riadok odberatelskej zakazky
      property TcdNum:Str12 read oItm.TcdNum write oItm.TcdNum;       // Cislo odberatelskeho dodacieho listu
      property TcdItm:word read oItm.TcdItm write oItm.TcdItm;        // Riadok odberatelskeho dodacieho listu
      property TcdDate:TDateTime read oItm.TcdDate write oItm.TcdDate;// Datum odberatelskeho dodacieho listu
      property IcdNum:Str12 read oItm.IcdNum write oItm.IcdNum;       // Cislo odberatelskej faktury
      property IcdItm:word read oItm.IcdItm write oItm.IcdItm;        // Riadok odberatelskej faktury
      property IcdDate:TDateTime read oItm.IcdDate write oItm.IcdDate;// Datum vystavenia faktury
      property StkStat:Str1 read oItm.StkStat write oItm.StkStat;     // Stav polozky (N-nerealiz.,O-obj.,R-realiz.,P-pripravena,S-vyskladnena,E-exped.)
      property FinStat:Str1 read oItm.FinStat write oItm.FinStat;     // Stav polozky (F-vyfakturovane,C-vyuctovane cez ERP)
      property Action:Str1 read oItm.Action write oItm.Action;        // Priznak cenovej akcie (A-akciovy tovar)
      property SpMark:Str10 read oItm.SpMark write oItm.SpMark;       // Vseobecne pole na oznacenie faktury
      property BonNum:byte read oItm.BonNum write oItm.BonNum;        // Cislo bonusovej akcie
      property AcCPrice:double read oItm.AcCPrice write oItm.AcCPrice;// NC/MJ bez DPH v uctovnej mene
      property AcAValue:double read oItm.AcCPrice write oItm.AcCPrice;// PC bez DPH po zlave v uctovnej mene
      property AcBValue:double read oItm.AcBValue write oItm.AcBValue;// PC s DPH po zlave v uctovnej mene
      property FgDPrice:double read oItm.FgDPrice write oItm.FgDPrice;// PC/MJ bez DPH pred zlavou vo vyuctovnej mene
      property FgHPrice:double read oItm.FgHPrice write oItm.FgHPrice;// PC/MJ s DPH pred zlavou vo vyuctovnej mene
      property FgAPrice:double read oItm.FgAPrice write oItm.FgAPrice;// PC/MJ bez DPH po zlave vo vyuctovnej mene
      property FgBPrice:double read oItm.FgBPrice write oItm.FgBPrice;// PC/MJ s DPH po zlave vo vyuctovnej mene
      property FgDValue:double read oItm.FgDValue write oItm.FgDValue;// PC bez DPH pred zlavou vo vyuctovnej mene
      property FgHValue:double read oItm.FgHValue write oItm.FgHValue;// PC s DPH pred zlavou vo vyuctovnej mene
      property FgAValue:double read oItm.FgAValue write oItm.FgAValue;// PC bez DPH po zlave vo vyuctovnej mene
      property FgBValue:double read oItm.FgBValue write oItm.FgBValue;// PC s DPH po zlave vo vyuctovnej mene
      property FgFract:byte read oItm.FgFract write oItm.FgFract;     // Pocet desatinnych miest jednotkovej predajnej ceny v UM
      property PrfPrc:double read oItm.PrfPrc write oItm.PrfPrc;      // Obchodna marza
      property OrdPrn:byte read oItm.OrdPrn write oItm.OrdPrn;        // »Ìslo oddelenia kde sa bude tlaËiù reötauraËn· objedn·vka
      property OpenGs:boolean read oItm.OpenGs write oItm.OpenGs;     // OrvorenÈ PLU - moûno meniù predajn˙ cenu na pokladniach
      property DisFlag:boolean read oItm.DisFlag write oItm.DisFlag;  // Vyradenie z evidencie (1-vyraden˝ z evidencie)
      // Hlavickove udaje
      property DocNum:Str12 read oItm.DocNum write oItm.DocNum;       // Cislo dokladu
      property DocDate:TDateTime read oItm.DocDate write oItm.DocDate;// Datum vystavenia dokladu
      property DlrCode:word read oItm.DlrCode write oItm.DlrCode;     // Kod obchodneho zoastupcu
      property PaCode:longint read oItm.PaCode write oItm.PaCode;     // Kod partnera
      property FgCourse:double read oItm.FgCourse write oItm.FgCourse;// Kurz vyuctovacen meny
      property IcPlsNum:word read oItm.IcPlsNum write oItm.IcPlsNum;  // Cennik zmluvnych cien
      property IcAplNum:word read oItm.IcAplNum write oItm.IcAplNum;  // Cennik akciovych cien
      property IcDscPrc:double read oItm.IcDscPrc write oItm.IcDscPrc;// Globalna zlava odberatela
      property IcFacPrc:double read oItm.IcFacPrc write oItm.IcFacPrc;// Faktoringova prirazka
  end;

implementation

constructor TItm.Create;
begin
  Clear;
end;

procedure TItm.Clear;
begin
  FillChar(oItm,SizeOf(TItmData),#0);
end;

destructor TItm.Destroy;
begin
end;


end.
