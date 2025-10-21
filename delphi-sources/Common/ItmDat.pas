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
      property ItmAdr:longint read oItm.ItmAdr write oItm.ItmAdr;     // Fyzick� adresa polo�ky
      property ItmNum:word read oItm.ItmNum write oItm.ItmNum;        // Poradove cislo polozky dokldu
      property PgrNum:longint read oItm.PgrNum write oItm.PgrNum;     // ��slo tovarovej skupiny
      property FgrNum:longint read oItm.FgrNum write oItm.FgrNum;     // ��slo finan�nej skupiny
      property SgrNum:longint read oItm.SgrNum write oItm.SgrNum;     // ��slo skupiny pre internetov� obchod
      property ProNum:longint read oItm.ProNum write oItm.ProNum;     // Tovarove cislo polo�ky
      property ProNam:Str60 read oItm.ProNam write oItm.ProNam;       // Nazov polo�ky
      property BarCod:Str15 read oItm.BarCod write oItm.BarCod;       // Identifikacny kod polo�ky
      property StkCod:Str15 read oItm.StkCod write oItm.StkCod;       // Skladovy kod polo�ky
      property ShpCod:Str30 read oItm.ShpCod write oItm.ShpCod;       // Identifika�n� k�d pre Eshop
      property OrdCod:Str30 read oItm.OrdCod write oItm.OrdCod;       // Objedn�vkov� k�d polo�ky
      property ProVol:double read oItm.ProVol write oItm.ProVol;      // Objem tovaru (mno�stvo MJ na 1 m3)
      property ProWgh:double read oItm.ProWgh write oItm.ProWgh;      // V�ha tovaru (vaha jednej MJ)
      property ProTyp:Str1 read oItm.ProTyp write oItm.ProTyp;        // Typov� ozna�enie produktu  (T-tovar,W-v�hovy tovar,O-obal,S-slu�ba)
      property MsuNam:Str10 read oItm.MsuNam write oItm.MsuNam;       // Mern� jednotka produktu
      property SalPrq:double read oItm.SalPrq write oItm.SalPrq;      // Predan� mno�stvo
      property VatPrc:byte read oItm.VatPrc write oItm.VatPrc;        // Sadzba DPH v %
      property PlsApc:double read oItm.PlsApc write oItm.PlsApc;      // Jednotkov� cena bDPH - cenn�kov� cena (PC)
      property PlsBpc:double read oItm.PlsBpc write oItm.PlsBpc;      // Jednotkov� cena sDPH - cenn�kov� cena (PC)
      property ApsApc:double read oItm.ApsApc write oItm.ApsApc;      // Jednotkov� cena bDPH - akciov� cena (AC)
      property ApsBpc:double read oItm.ApsBpc write oItm.ApsBpc;      // Jednotkov� cena sDPH - akciov� cena (AC)
      property ApsPrq:word read oItm.ApsPrq write oItm.ApsPrq;        // Mno�stvo pre ktor� plat� akciov� cena
      property PadApc:double read oItm.PadApc write oItm.PadApc;      // Jednotkov� cena bDPH - firemn� z�ava (PA)
      property PadBpc:double read oItm.PadBpc write oItm.PadBpc;      // Jednotkov� cena sDPH - firemn� z�ava (PA)
      property DcpApc:double read oItm.DcpApc write oItm.DcpApc;      // Jednotkov� cena bDPH - diskontn� cena (DC)
      property DcpBpc:double read oItm.DcpBpc write oItm.DcpBpc;      // Jednotkov� cena sDPH - diskontn� cena (DC)
      property AgrApc:double read oItm.AgrApc write oItm.AgrApc;      // Jednotkov� cena bDPH - zmluvn� cena (ZC)
      property AgrBpc:double read oItm.AgrBpc write oItm.AgrBpc;      // Jednotkov� cena sDPH - zmluvn� cena (ZC)
      property SapApc:double read oItm.SapApc write oItm.SapApc;      // Jednotkov� cena bDPH - cena pre z�kazn�ka
      property SapBpc:double read oItm.SapBpc write oItm.SapBpc;      // Jednotkov� cena sDPH - cena pre z�kazn�ka
      property SapSrc:Str2 read oItm.SapSrc write oItm.SapSrc;        // Zdroj predajnej ceny (AC-akcia;ZC-zmluva;DC-diskontn�;PA-firemn�;PC-cenn�kov�)
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
