unit ItmDat;

interface

uses
  Windows, SysUtils, Classes, IcTypes, NexTypes, Forms;

type
  TItmRec=record
    ItmAdr:longint;
    ItmNum:word;
    PgrNum:longint;
    FgrNum:longint;
    SgrNum:longint;
    ProNum:longint;
    ProNam:Str60;
    BarCod:Str15;
    StkCod:Str15;
    ShpCod:Str30;
    OrdCod:Str30;
    ProVol:double;
    ProWgh:double;
    ProTyp:Str1;
    MsuNam:Str10;
    SalPrq:double;
    VatPrc:byte;
    PlsApc:double;
    PlsBpc:double;
    ApsApc:double;
    ApsBpc:double;
    ApsPrq:word;
    PadApc:double;
    PadBpc:double;
    DcpApc:double;
    DcpBpc:double;
    AgrApc:double;
    AgrBpc:double;
    SapApc:double;
    SapBpc:double;
    SapSrc:Str2;
    Notice:Str50;
    StkNum:word;
  end;

  TItmDat=class
    constructor Create;
    destructor Destroy; override;
    private
      oItm:TItmRec;
    public
      procedure Clear;
    published
      property ItmAdr:longint read oItm.ItmAdr write oItm.ItmAdr;     // Fyzická adresa položky
      property ItmNum:word read oItm.ItmNum write oItm.ItmNum;        // Poradove cislo polozky dokldu
      property PgrNum:longint read oItm.PgrNum write oItm.PgrNum;     // Èíslo tovarovej skupiny
      property FgrNum:longint read oItm.FgrNum write oItm.FgrNum;     // Èíslo finanènej skupiny
      property SgrNum:longint read oItm.SgrNum write oItm.SgrNum;     // Èíslo skupiny pre internetový obchod
      property ProNum:longint read oItm.ProNum write oItm.ProNum;     // Tovarove cislo položky
      property ProNam:Str60 read oItm.ProNam write oItm.ProNam;       // Nazov položky
      property BarCod:Str15 read oItm.BarCod write oItm.BarCod;       // Identifikacny kod položky
      property StkCod:Str15 read oItm.StkCod write oItm.StkCod;       // Skladovy kod položky
      property ShpCod:Str30 read oItm.ShpCod write oItm.ShpCod;       // Identifikaèný kód pre Eshop
      property OrdCod:Str30 read oItm.OrdCod write oItm.OrdCod;       // Objednávkový kód položky
      property ProVol:double read oItm.ProVol write oItm.ProVol;      // Objem tovaru (množstvo MJ na 1 m3)
      property ProWgh:double read oItm.ProWgh write oItm.ProWgh;      // Váha tovaru (vaha jednej MJ)
      property ProTyp:Str1 read oItm.ProTyp write oItm.ProTyp;        // Typové oznaèenie produktu  (T-tovar,W-váhovy tovar,O-obal,S-služba)
      property MsuNam:Str10 read oItm.MsuNam write oItm.MsuNam;       // Merná jednotka produktu
      property SalPrq:double read oItm.SalPrq write oItm.SalPrq;      // Predané množstvo
      property VatPrc:byte read oItm.VatPrc write oItm.VatPrc;        // Sadzba DPH v %
      property PlsApc:double read oItm.PlsApc write oItm.PlsApc;      // Jednotková cena bDPH - cenníková cena (PC)
      property PlsBpc:double read oItm.PlsBpc write oItm.PlsBpc;      // Jednotková cena sDPH - cenníková cena (PC)
      property ApsApc:double read oItm.ApsApc write oItm.ApsApc;      // Jednotková cena bDPH - akciová cena (AC)
      property ApsBpc:double read oItm.ApsBpc write oItm.ApsBpc;      // Jednotková cena sDPH - akciová cena (AC)
      property ApsPrq:word read oItm.ApsPrq write oItm.ApsPrq;        // Množstvo pre ktoré platí akciová cena
      property PadApc:double read oItm.PadApc write oItm.PadApc;      // Jednotková cena bDPH - firemná z¾ava (PA)
      property PadBpc:double read oItm.PadBpc write oItm.PadBpc;      // Jednotková cena sDPH - firemná z¾ava (PA)
      property DcpApc:double read oItm.DcpApc write oItm.DcpApc;      // Jednotková cena bDPH - diskontná cena (DC)
      property DcpBpc:double read oItm.DcpBpc write oItm.DcpBpc;      // Jednotková cena sDPH - diskontná cena (DC)
      property AgrApc:double read oItm.AgrApc write oItm.AgrApc;      // Jednotková cena bDPH - zmluvná cena (ZC)
      property AgrBpc:double read oItm.AgrBpc write oItm.AgrBpc;      // Jednotková cena sDPH - zmluvná cena (ZC)
      property SapApc:double read oItm.SapApc write oItm.SapApc;      // Jednotková cena bDPH - cena pre zákazníka
      property SapBpc:double read oItm.SapBpc write oItm.SapBpc;      // Jednotková cena sDPH - cena pre zákazníka
      property SapSrc:Str2 read oItm.SapSrc write oItm.SapSrc;        // Zdroj predajnej ceny (AC-akcia;ZC-zmluva;DC-diskontná;PA-firemná;PC-cenníková)
      property Notice:Str50 read oItm.Notice write oItm.Notice;       // Poznamka k riadku dokladu
      property StkNum:word read oItm.StkNum write oItm.StkNum;        // Cislo skladu, odkial tovar bude vydany
  end;

implementation

constructor TItmDat.Create;
begin
  Clear;
end;

procedure TItmDat.Clear;
begin
  FillChar(oItm,SizeOf(TItmData),#0);
end;

destructor TItmDat.Destroy;
begin
end;


end.
