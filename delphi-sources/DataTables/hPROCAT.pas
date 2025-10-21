unit hPROCAT;  // KatalÛg produktov

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';
  ixFgrNum='FgCode';
  ixBarCod='BarCode';
  ixStkCod='StkCode';
  ixShpCod='SpcCode';
  ixOrdCod='OsdCode';
  ixMsuNam='MsName';
  ixProTyp='GsType';
  ixPckPro='PackGs';
  ixDisSta='DisFlag';

type
  TProcatHnd=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str10):boolean;
    function FieldNum(pFieldName:Str10):word;
    // Pristup k databazovym poliam
    function GetProNum:longint;    procedure SetProNum(pValue:longint);
    function GetProNam:Str60;      procedure SetProNam(pValue:Str60);
    function GetEcrNam:Str30;      procedure SetEcrNam(pValue:Str30);
    function GetPgrNum:longint;    procedure SetPgrNum(pValue:longint);
    function GetFgrNum:longint;    procedure SetFgrNum(pValue:longint);
    function GetSgrNum:longint;    procedure SetSgrNum(pValue:longint);
    function GetBarCod:Str15;      procedure SetBarCod(pValue:Str15);
    function GetSubCnt:byte;       procedure SetSubCnt(pValue:byte);
    function GetStkCod:Str15;      procedure SetStkCod(pValue:Str15);
    function GetOrdCod:Str30;      procedure SetOrdCod(pValue:Str30);
    function GetShpCod:Str30;      procedure SetShpCod(pValue:Str30);
    function GetBasPro:longint;    procedure SetBasPro(pValue:longint);
    function GetPckPro:longint;    procedure SetPckPro(pValue:longint);
    function GetMsuNam:Str10;      procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;       procedure SetVatPrc(pValue:byte);
    function GetProTyp:Str1;       procedure SetProTyp(pValue:Str1);
    function GetMsnMus:boolean;    procedure SetMsnMus(pValue:boolean);
    function GetMbaMus:boolean;    procedure SetMbaMus(pValue:boolean);
    function GetGrcMth:byte;       procedure SetGrcMth(pValue:byte);
    function GetMsbNam:Str5;       procedure SetMsbNam(pValue:Str5);
    function GetMsbPrq:double;     procedure SetMsbPrq(pValue:double);
    function GetProVol:double;     procedure SetProVol(pValue:double);
    function GetProWgh:double;     procedure SetProWgh(pValue:double);
    function GetBoxPrq:word;       procedure SetBoxPrq(pValue:word);
    function GetBoxVol:double;     procedure SetBoxVol(pValue:double);
    function GetBoxWgh:double;     procedure SetBoxWgh(pValue:double);
    function GetMosPrq:double;     procedure SetMosPrq(pValue:double);
    function GetPalBoq:word;       procedure SetPalBoq(pValue:word);
    function GetManPac:longint;    procedure SetManPac(pValue:longint);
    function GetManNam:Str10;      procedure SetManNam(pValue:Str10);
    function GetSupPac:longint;    procedure SetSupPac(pValue:longint);
    function GetShpNum:byte;       procedure SetShpNum(pValue:byte);
    function GetDivSta:boolean;    procedure SetDivSta(pValue:boolean);
    function GetDisSta:boolean;    procedure SetDisSta(pValue:boolean);
    function GetMngUsr:word;       procedure SetMngUsr(pValue:word);
    function GetCctCod:Str10;      procedure SetCctCod(pValue:Str10);
    function GetIsiSnt:Str3;       procedure SetIsiSnt(pValue:Str3);
    function GetIsiAnl:Str6;       procedure SetIsiAnl(pValue:Str6);
    function GetIciSnt:Str3;       procedure SetIciSnt(pValue:Str3);
    function GetIciAnl:Str6;       procedure SetIciAnl(pValue:Str6);
    function GetCrtUsr:word;
    function GetCrtDte:TDatetime;
    function GetCrtTim:TDatetime;
  public
    constructor Create(pPath:ShortString); overload;
    // Z·kladnÈ dat·bazovÈ oper·cie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    // Vyhæad·vacie funkcie
    function LocProNum(pValue:longint):boolean;
    function LocFgrNum(pValue:longint):boolean;
    function LocBarCod(pValue:Str15):boolean;
    function LocStkCod(pValue:Str15):boolean;
    function LocShpCod(pValue:Str30):boolean;
    function LocOrdCod(pValue:Str30):boolean;
    function LocProTyp(pValue:Str1):boolean;
    function LocPckPro(pValue:longint):boolean;
    function LocDisSta(pValue:byte):boolean;
    function LocMsuNam(pValue:Str10):boolean;

    function NearProNum(pValue:longint):boolean;
    function NearFgrNum(pValue:longint):boolean;
    function NearBarCod(pValue:Str15):boolean;
    function NearStkCod(pValue:Str15):boolean;
    function NearShpCod(pValue:Str30):boolean;
    function NearOrdCod(pValue:Str30):boolean;
    function NearProTyp(pValue:Str1):boolean;
    function NearPckPro(pValue:longint):boolean;
    function NearDisSta(pValue:byte):boolean;
    function NearMsuNam(pValue:Str10):boolean;

    procedure SetIndex(pIndex:Str20);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;

    procedure FltGsc(pSecPgr:longint);  // Filtrovanie tovarov
    procedure FltSec(pSecPgr:longint);  // Filtrovanie sluûieb
    procedure FltOff;  // Vypn˙ù filtrovanie
  published
    property Table:TNexBtrTable read GetTable;
    property Count:integer read GetCount;
    // Pristup k databazovym poliam
    property ProNum:longint read GetProNum write SetProNum;   // ProduktovÈ ËÌslo
    property ProNam:Str60 read GetProNam write SetProNam;     // N·zov produktu
    property EcrNam:Str30 read GetEcrNam write SetEcrNam;     // N·zov pre ERP
    property PgrNum:longint read GetPgrNum write SetPgrNum;   // Produktov· skupina (samostatne pre tovar a pre sluûby)
    property FgrNum:longint read GetFgrNum write SetFgrNum;   // FinanËnÈ skupny
    property SgrNum:longint read GetSgrNum write SetSgrNum;   // Predajn· skupina
    property BarCod:Str15 read GetBarCod write SetBarCod;     // IdentifikaËn˝ kÛd poloûky
    property SubCnt:byte read GetSubCnt write SetSubCnt;      // PoËet druhotn˝ch kÛdov
    property StkCod:Str15 read GetStkCod write SetStkCod;     // Skladov˝ kÛd tovaru
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;     // Objedn·vacÌ kÛd hlavnÈho dod·vateæa
    property ShpCod:Str30 read GetShpCod write SetShpCod;     // IdentifikaËn˝ kÛd pre Eshop
    property BasPro:longint read GetBasPro write SetBasPro;   // KatalÛgovÈ ËÌslo z·kladnej poloûky
    property PckPro:longint read GetPckPro write SetPckPro;   // KatalÛgovÈ ËÌslo priradenÈho vratnÈho obalu
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;     // Mern· jednotka
    property VatPrc:byte read GetVatPrc write SetVatPrc;      // Percentu·lna sadzba DPH
    property ProTyp:Str1 read GetProTyp write SetProTyp;      // TypovÈ oznaËenie produktu  (T-tovar,W-v·hovy tovar,O-obal,S-sluûba)
    property MsnMus:boolean read GetMsnMus write SetMsnMus;   // Povinn· evidencia v˝robn˝ch ËÌsiel
    property MbaMus:boolean read GetMbaMus write SetMbaMus;   // Povinn· evidencia v˝robnej öarûe
    property GrcMth:byte read GetGrcMth write SetGrcMth;      // Z·ruËn· doba v mesiacoch
    property MsbNam:Str5 read GetMsbNam write SetMsbNam;      // Z·kladn· jednotka
    property MsbPrq:double read GetMsbPrq write SetMsbPrq;    // Mnoûstvo v z·kladnej jednotke
    property MosPrq:double read GetMosPrq write SetMosPrq;    // Minim·lne objedn·vacie mnoûstvo
    property ProVol:double read GetProVol write SetProVol;    // Objem tovaru za mern˙ jednotku
    property ProWgh:double read GetProWgh write SetProWgh;    // V·ha tovaru za mern˙ jednotku
    property BoxPrq:word read GetBoxPrq write SetBoxPrq;      // PoËet kusov tovaru v krabici
    property BoxVol:double read GetBoxVol write SetBoxVol;    // Objem krabicovÈho balenia
    property BoxWgh:double read GetBoxWgh write SetBoxWgh;    // V·ha krabicovÈho balenia
    property PalBoq:word read GetPalBoq write SetPalBoq;      // PoËet kartÛnov na palete
    property ManPac:longint read GetManPac write SetManPac;   // KatalÛgovÈ ËÌslo v˝robcu
    property ManNam:Str10 read GetManNam write SetManNam;     // Skr·tenÈ pomenovanie v˝robcu
    property SupPac:longint read GetSupPac write SetSupPac;   // KatalÛgovÈ ËÌslo hlavnÈho dod·vateæa
    property ShpNum:byte read GetShpNum write SetShpNum;      // »Ìslo elektronickÈho obchodu (Eshop)
    property DivSta:boolean read GetDivSta write SetDivSta;   // Deliteænosù poloûky (1-moûno pred·vaù na desatinnÈ mnoûstv·)
    property DisSta:boolean read GetDisSta write SetDisSta;   // Vyradenie poloûky (1-vyraden·)
    property MngUsr:word read GetMngUsr write SetMngUsr;      // RegistraËnÈ ËÌslo uûÌvateæa, ktor˝ spravuje poloûku
    property CctCod:Str10 read GetCctCod write SetCctCod;     // Tarifn˝ kÛd jednotnÈho colnÈho sadzobnÌka
    property IsiSnt:Str3 read GetIsiSnt write SetIsiSnt;      // Syntetick· Ëasù ˙Ëtu pre roz˙Ëtovanie poloûky DF
    property IsiAnl:Str6 read GetIsiAnl write SetIsiAnl;      // Analytick· Ëasù ˙Ëtu pre roz˙Ëtovanie poloûky DF
    property IciSnt:Str3 read GetIciSnt write SetIciSnt;      // Syntetick· Ëasù ˙Ëtu pre roz˙Ëtovanie poloûky OF
    property IciAnl:Str6 read GetIciAnl write SetIciAnl;      // Analytick· Ëasù ˙Ëtu pre roz˙Ëtovanie poloûky OF
    property CrtUsr:word read GetCrtUsr;                      // RegistraËnÈ ËÌslo uûÌvateæa, ktor˝ vytvoril kartu
    property CrtDte:TDatetime read GetCrtDte;                 // D·tum vytvorenia karty
    property CrtTim:TDatetime read GetCrtTim;                 // »as vytvorenia karty
  end;

implementation

constructor TProcatHnd.Create;
begin
  oTable:=BtrInit('GSCAT',gPath.StkPath,Self);
end;

constructor TProcatHnd.Create(pPath:ShortString);
begin
  oTable:=BtrInit('GSCAT',pPath,Self);
end;

destructor TProcatHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TProcatHnd.GetTable:TNexBtrTable;
begin
  Open;
  Result:=oTable;
end;

function TProcatHnd.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TProcatHnd.FieldExist(pFieldName:Str10):boolean;
begin
  Open;
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TProcatHnd.FieldNum(pFieldName:Str10):word;
begin
  Open;
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

// ******************** FIELDS *********************

function TProcatHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TProcatHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TProcatHnd.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('GaName').AsString;
end;

procedure TProcatHnd.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('GaName').AsString:=pValue;
end;

function TProcatHnd.GetEcrNam:Str30;
begin
  Result:=oTable.FieldByName('GsName').AsString;
end;

procedure TProcatHnd.SetEcrNam(pValue:Str30);
begin
  oTable.FieldByName('GsName').AsString:=pValue;
end;

function TProcatHnd.GetPgrNum:longint;
begin
  Result:=oTable.FieldByName('MgCode').AsInteger;
end;

procedure TProcatHnd.SetPgrNum(pValue:longint);
begin
  oTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TProcatHnd.GetFgrNum:longint;
begin
  Result:=oTable.FieldByName('FgCode').AsInteger;
end;

procedure TProcatHnd.SetFgrNum(pValue:longint);
begin
  oTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TProcatHnd.GetSgrNum:longint;
begin
  Result:=oTable.FieldByName('SgCode').AsInteger;
end;

procedure TProcatHnd.SetSgrNum(pValue:longint);
begin
  oTable.FieldByName('SgCode').AsInteger:=pValue;
end;

function TProcatHnd.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

procedure TProcatHnd.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

function TProcatHnd.GetSubCnt:byte;
begin
  Result:=oTable.FieldByName('SbcCnt').AsInteger;
end;

procedure TProcatHnd.SetSubCnt(pValue:byte);
begin
  oTable.FieldByName('SbcCnt').AsInteger:=pValue;
end;

function TProcatHnd.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCode').AsString;
end;

procedure TProcatHnd.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCode').AsString:=pValue;
end;

function TProcatHnd.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OsdCode').AsString;
end;

procedure TProcatHnd.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OsdCode').AsString:=pValue;
end;

function TProcatHnd.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('SpcCode').AsString;
end;

procedure TProcatHnd.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('SpcCode').AsString:=pValue;
end;

function TProcatHnd.GetBasPro:longint;
begin
  Result:=oTable.FieldByName('BasGsc').AsInteger;
end;

procedure TProcatHnd.SetBasPro(pValue:longint);
begin
  oTable.FieldByName('BasGsc').AsInteger:=pValue;
end;

function TProcatHnd.GetPckPro:longint;
begin
  Result:=oTable.FieldByName('PackGs').AsInteger;
end;

procedure TProcatHnd.SetPckPro(pValue:longint);
begin
  oTable.FieldByName('PackGs').AsInteger:=pValue;
end;

function TProcatHnd.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsName').AsString;
end;

procedure TProcatHnd.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsName').AsString:=pValue;
end;

function TProcatHnd.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TProcatHnd.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TProcatHnd.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TProcatHnd.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TProcatHnd.GetMsnMus:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('PdnMust').AsInteger);
end;

procedure TProcatHnd.SetMsnMus(pValue:boolean);
begin
  oTable.FieldByName('PdnMust').AsInteger:=BoolToByte(pValue);
end;

function TProcatHnd.GetMbaMus:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('RbaTrc').AsInteger);
end;

procedure TProcatHnd.SetMbaMus(pValue:boolean);
begin
  oTable.FieldByName('RbaTrc').AsInteger:=BoolToByte(pValue);
end;

function TProcatHnd.GetGrcMth:byte;
begin
  Result:=oTable.FieldByName('GrcMth').AsInteger;
end;

procedure TProcatHnd.SetGrcMth(pValue:byte);
begin
  oTable.FieldByName('GrcMth').AsInteger:=pValue;
end;

function TProcatHnd.GetMsbNam:Str5;
begin
  Result:=oTable.FieldByName('MsuName').AsString;
end;

procedure TProcatHnd.SetMsbNam(pValue:Str5);
begin
  oTable.FieldByName('MsuName').AsString:=pValue;
end;

function TProcatHnd.GetMsbPrq:double;
begin
  Result:=oTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TProcatHnd.SetMsbPrq(pValue:double);
begin
  oTable.FieldByName('MsuQnt').AsFloat:=pValue;
end;

function TProcatHnd.GetProVol:double;
begin
  Result:=oTable.FieldByName('Volume').AsFloat;
end;

procedure TProcatHnd.SetProVol(pValue:double);
begin
  oTable.FieldByName('Volume').AsFloat:=pValue;
end;

function TProcatHnd.GetProWgh:double;
begin
  Result:=oTable.FieldByName('Weight').AsFloat;
end;

procedure TProcatHnd.SetProWgh(pValue:double);
begin
  oTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TProcatHnd.GetBoxPrq:word;
begin
  Result:=oTable.FieldByName('GscKfc').AsInteger;
end;

procedure TProcatHnd.SetBoxPrq(pValue:word);
begin
  oTable.FieldByName('GscKfc').AsInteger:=pValue;
end;

function TProcatHnd.GetBoxVol:double;
begin
  Result:=oTable.FieldByName('Volume').AsFloat;
end;

procedure TProcatHnd.SetBoxVol(pValue:double);
begin
  oTable.FieldByName('Volume').AsFloat:=pValue;
end;

function TProcatHnd.GetBoxWgh:double;
begin
  Result:=oTable.FieldByName('QliKfc').AsFloat;
end;

procedure TProcatHnd.SetBoxWgh(pValue:double);
begin
  oTable.FieldByName('QliKfc').AsFloat:=pValue;
end;

function TProcatHnd.GetMosPrq:double;
begin
  Result:=oTable.FieldByName('MinOsq').AsFloat;
end;

procedure TProcatHnd.SetMosPrq(pValue:double);
begin
  oTable.FieldByName('MinOsq').AsFloat:=pValue;
end;

function TProcatHnd.GetPalBoq:word;
begin
  Result:=oTable.FieldByName('GspKfc').AsInteger;
end;

procedure TProcatHnd.SetPalBoq(pValue:word);
begin
  oTable.FieldByName('GspKfc').AsInteger:=pValue;
end;

function TProcatHnd.GetManPac:longint;
begin
  Result:=oTable.FieldByName('PrdPac').AsInteger;
end;

procedure TProcatHnd.SetManPac(pValue:longint);
begin
  oTable.FieldByName('PrdPac').AsInteger:=pValue;
end;

function TProcatHnd.GetManNam:Str10;
begin
  Result:='';
//  Result:=oTable.FieldByName('ManNam').AsString;
end;

procedure TProcatHnd.SetManNam(pValue:Str10);
begin
//  oTable.FieldByName('ManNam').AsString:=pValue;
end;

function TProcatHnd.GetSupPac:longint;
begin
  Result:=oTable.FieldByName('SupPac').AsInteger;
end;

procedure TProcatHnd.SetSupPac(pValue:longint);
begin
  oTable.FieldByName('SupPac').AsInteger:=pValue;
end;

function TProcatHnd.GetShpNum:byte;
begin
  Result:=oTable.FieldByName('ShpNum').AsInteger;
end;

procedure TProcatHnd.SetShpNum(pValue:byte);
begin
  oTable.FieldByName('ShpNum').AsInteger:=pValue;
end;

function TProcatHnd.GetDivSta:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('DivSet').AsInteger);
end;

procedure TProcatHnd.SetDivSta(pValue:boolean);
begin
  oTable.FieldByName('DivSet').AsInteger:=BoolToByte(pValue);
end;

function TProcatHnd.GetDisSta:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('DisFlag').AsInteger);
end;

procedure TProcatHnd.SetDisSta(pValue:boolean);
begin
  oTable.FieldByName('DisFlag').AsInteger:=BoolToByte(pValue);
end;

function TProcatHnd.GetMngUsr:word;
begin
  Result:=0;
//  Result:=oTable.FieldByName('CrtUsr').AsInteger;
end;

procedure TProcatHnd.SetMngUsr(pValue:word);
begin
//  oTable.FieldByName('MngUsr').AsInteger:=pValue;
end;

function TProcatHnd.GetCctCod:Str10;
begin
  Result:=oTable.FieldByName('CctCod').AsString;
end;

procedure TProcatHnd.SetCctCod(pValue:Str10);
begin
  oTable.FieldByName('CctCod').AsString:=pValue;
end;

function TProcatHnd.GetIsiSnt:Str3;
begin
  Result:=oTable.FieldByName('IsiSnt').AsString;
end;

procedure TProcatHnd.SetIsiSnt(pValue:Str3);
begin
  oTable.FieldByName('IsiSnt').AsString:=pValue;
end;

function TProcatHnd.GetIsiAnl:Str6;
begin
  Result:=oTable.FieldByName('IsiSnt').AsString;
end;

procedure TProcatHnd.SetIsiAnl(pValue:Str6);
begin
  oTable.FieldByName('IsiAnl').AsString:=pValue;
end;

function TProcatHnd.GetIciSnt:Str3;
begin
  Result:=oTable.FieldByName('IciSnt').AsString;
end;

procedure TProcatHnd.SetIciSnt(pValue:Str3);
begin
  oTable.FieldByName('IciSnt').AsString:=pValue;
end;

function TProcatHnd.GetIciAnl:Str6;
begin
  Result:=oTable.FieldByName('IciAnl').AsString;
end;

procedure TProcatHnd.SetIciAnl(pValue:Str6);
begin
  oTable.FieldByName('IciAnl').AsString:=pValue;
end;

function TProcatHnd.GetCrtUsr:word;
begin
  Result:=0;
//  Result:=oTable.FieldByName('CrtUsr').AsInteger;
end;

function TProcatHnd.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDate').AsDateTime;
end;

function TProcatHnd.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTime').AsDateTime;
end;

// **************************************** PUBLIC ********************************************

function TProcatHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TProcatHnd.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TProcatHnd.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TProcatHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TProcatHnd.ActPos:longint;
begin
  Open;
  Result:=oTable.ActPos;
end;

function TProcatHnd.GotoPos(pActPos:longint):boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TProcatHnd.LocProNum(pValue:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocFgrNum(pValue:longint):boolean;
begin
  SetIndex(ixFgrNum);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocBarCod(pvalue:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocStkCod(pValue:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocShpCod(pValue:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocOrdCod(pValue:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocProTyp(pValue:Str1):boolean;
begin
  SetIndex (ixProTyp);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocPckPro(pValue:longint):boolean;
begin
  SetIndex(ixPckPro);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocDisSta(pValue:byte):boolean;
begin
  SetIndex (ixDisSta);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.LocMsuNam(pValue:Str10):boolean;
begin
  SetIndex (ixMsuNam);
  Result:=oTable.FindKey([pValue]);
end;

function TProcatHnd.NearProNum(pValue:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearFgrNum(pvalue:longint):boolean;
begin
  SetIndex(ixFgrNum);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearBarCod(pValue:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearStkCod(pValue:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearShpCod(pValue:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearOrdCod(pValue:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearProTyp(pValue:Str1):boolean;
begin
  SetIndex(ixProTyp);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearPckPro(pValue:longint):boolean;
begin
  SetIndex(ixPckPro);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearDisSta(pValue:byte):boolean;
begin
  SetIndex(ixDisSta);
  Result:=oTable.FindNearest([pValue]);
end;

function TProcatHnd.NearMsuNam(pValue:Str10):boolean;
begin
  SetIndex(ixMsuNam);
  Result:=oTable.FindNearest([pValue]);
end;

procedure TProcatHnd.SetIndex(pIndex:Str20);
begin
  Open;
  If oTable.IndexName<>pIndex then oTable.IndexName:=pIndex;
end;

procedure TProcatHnd.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TProcatHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TProcatHnd.Prior;
begin
  Open;
  oTable.Prior;
end;

procedure TProcatHnd.Next;
begin
  oTable.Next;
end;

procedure TProcatHnd.First;
begin
  Open;
  oTable.First;
end;

procedure TProcatHnd.Last;
begin
  Open;
  oTable.Last;
end;

procedure TProcatHnd.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TProcatHnd.Edit;
begin
  Open;
  oTable.Edit;
end;

procedure TProcatHnd.Post;
begin
  oTable.Post;
end;

procedure TProcatHnd.Delete;
begin
  Open;
  oTable.Delete;
end;

procedure TProcatHnd.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TProcatHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TProcatHnd.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TProcatHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TProcatHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TProcatHnd.DisabCont;
begin
  Open;
  oTable.DisableControls;
end;

procedure TProcatHnd.FltGsc(pSecPgr:longint);
begin
  Open;
  oTable.ClearFilter;
  oTable.Filter:='['+StrInt(FieldNum('MgCode'),0)+']<{'+StrInt(pSecPgr,0)+'}';
  oTable.Filtered:=TRUE;
end;

procedure TProcatHnd.FltSec(pSecPgr:longint);
begin
  Open;
  oTable.ClearFilter;
  oTable.Filter:='['+StrInt(FieldNum('MgCode'),0)+']>={'+StrInt(pSecPgr,0)+'}';
  oTable.Filtered:=TRUE;
end;

procedure TProcatHnd.FltOff;
begin
  oTable.ClearFilter;
  oTable.Filtered:=FALSE;
end;

end.
{MOD 2001}
