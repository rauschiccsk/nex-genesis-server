unit tTSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRoIt='';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixGsCode='GsCode';
  ixGsName_='GsName_';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixIsdNum='IsdNum';
  ixStkStat='StkStat';
  ixFinStat='FinStat';
  ixRbaCode='RbaCode';
  ixOdOi='OdOi';

type
  TTsiTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetMgCode:word;             procedure SetMgCode (pValue:word);
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetGsName_:Str30;           procedure SetGsName_ (pValue:Str30);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetNotice:Str30;            procedure SetNotice (pValue:Str30);
    function GetPackGs:longint;          procedure SetPackGs (pValue:longint);
    function GetGsType:Str1;             procedure SetGsType (pValue:Str1);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetMsName:Str10;            procedure SetMsName (pValue:Str10);
    function GetGsQnt:double;            procedure SetGsQnt (pValue:double);
    function GetVatPrc:double;           procedure SetVatPrc (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetAcDPrice:double;         procedure SetAcDPrice (pValue:double);
    function GetAcCPrice:double;         procedure SetAcCPrice (pValue:double);
    function GetAcEPrice:double;         procedure SetAcEPrice (pValue:double);
    function GetAcSPrice:double;         procedure SetAcSPrice (pValue:double);
    function GetAcAPrice:double;         procedure SetAcAPrice (pValue:double);
    function GetAcBPrice:double;         procedure SetAcBPrice (pValue:double);
    function GetAcDValue:double;         procedure SetAcDValue (pValue:double);
    function GetAcDscVal:double;         procedure SetAcDscVal (pValue:double);
    function GetAcCValue:double;         procedure SetAcCValue (pValue:double);
    function GetAcEValue:double;         procedure SetAcEValue (pValue:double);
    function GetAcZValue:double;         procedure SetAcZValue (pValue:double);
    function GetAcTValue:double;         procedure SetAcTValue (pValue:double);
    function GetAcOValue:double;         procedure SetAcOValue (pValue:double);
    function GetAcSValue:double;         procedure SetAcSValue (pValue:double);
    function GetAcRndVal:double;         procedure SetAcRndVal (pValue:double);
    function GetAcAValue:double;         procedure SetAcAValue (pValue:double);
    function GetAcBValue:double;         procedure SetAcBValue (pValue:double);
    function GetFgDPrice:double;         procedure SetFgDPrice (pValue:double);
    function GetFgCPrice:double;         procedure SetFgCPrice (pValue:double);
    function GetFgEPrice:double;         procedure SetFgEPrice (pValue:double);
    function GetFgDValue:double;         procedure SetFgDValue (pValue:double);
    function GetFgDscVal:double;         procedure SetFgDscVal (pValue:double);
    function GetFgRndVal:double;         procedure SetFgRndVal (pValue:double);
    function GetFgCValue:double;         procedure SetFgCValue (pValue:double);
    function GetFgEValue:double;         procedure SetFgEValue (pValue:double);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetDrbDate:TDatetime;       procedure SetDrbDate (pValue:TDatetime);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetOsdNum:Str12;            procedure SetOsdNum (pValue:Str12);
    function GetOsdItm:word;             procedure SetOsdItm (pValue:word);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:longint;          procedure SetOcdItm (pValue:longint);
    function GetIsdNum:Str12;            procedure SetIsdNum (pValue:Str12);
    function GetIsdItm:word;             procedure SetIsdItm (pValue:word);
    function GetIsdDate:TDatetime;       procedure SetIsdDate (pValue:TDatetime);
    function GetStkStat:Str1;            procedure SetStkStat (pValue:Str1);
    function GetFinStat:Str1;            procedure SetFinStat (pValue:Str1);
    function GetAcqStat:Str1;            procedure SetAcqStat (pValue:Str1);
    function GetSteCode:word;            procedure SetSteCode (pValue:word);
    function GetRbaCode:Str30;           procedure SetRbaCode (pValue:Str30);
    function GetRbaDate:TDatetime;       procedure SetRbaDate (pValue:TDatetime);
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetCrtUser:Str8;            procedure SetCrtUser (pValue:Str8);
    function GetCrtDate:TDatetime;       procedure SetCrtDate (pValue:TDatetime);
    function GetCrtTime:TDatetime;       procedure SetCrtTime (pValue:TDatetime);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetModPrc:double;           procedure SetModPrc (pValue:double);
    function GetModCpc:double;           procedure SetModCpc (pValue:double);
    function GetModCva:double;           procedure SetModCva (pValue:double);
    function GetOutDoc:Str12;            procedure SetOutDoc (pValue:Str12);
    function GetOutItm:word;             procedure SetOutItm (pValue:word);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocRoIt (pRowNum:word;pItmNum:word):boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocGsName_ (pGsName_:Str30):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocIsdNum (pIsdNum:Str12):boolean;
    function LocStkStat (pStkStat:Str1):boolean;
    function LocFinStat (pFinStat:Str1):boolean;
    function LocRbaCode (pRbaCode:Str30):boolean;
    function LocOdOi (pOutDoc:Str12;pOutItm:word):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property RowNum:word read GetRowNum write SetRowNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property MgCode:word read GetMgCode write SetMgCode;
    property GsCode:longint read GetGsCode write SetGsCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property GsName_:Str30 read GetGsName_ write SetGsName_;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property Notice:Str30 read GetNotice write SetNotice;
    property PackGs:longint read GetPackGs write SetPackGs;
    property GsType:Str1 read GetGsType write SetGsType;
    property StkNum:word read GetStkNum write SetStkNum;
    property MsName:Str10 read GetMsName write SetMsName;
    property GsQnt:double read GetGsQnt write SetGsQnt;
    property VatPrc:double read GetVatPrc write SetVatPrc;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property AcDPrice:double read GetAcDPrice write SetAcDPrice;
    property AcCPrice:double read GetAcCPrice write SetAcCPrice;
    property AcEPrice:double read GetAcEPrice write SetAcEPrice;
    property AcSPrice:double read GetAcSPrice write SetAcSPrice;
    property AcAPrice:double read GetAcAPrice write SetAcAPrice;
    property AcBPrice:double read GetAcBPrice write SetAcBPrice;
    property AcDValue:double read GetAcDValue write SetAcDValue;
    property AcDscVal:double read GetAcDscVal write SetAcDscVal;
    property AcCValue:double read GetAcCValue write SetAcCValue;
    property AcEValue:double read GetAcEValue write SetAcEValue;
    property AcZValue:double read GetAcZValue write SetAcZValue;
    property AcTValue:double read GetAcTValue write SetAcTValue;
    property AcOValue:double read GetAcOValue write SetAcOValue;
    property AcSValue:double read GetAcSValue write SetAcSValue;
    property AcRndVal:double read GetAcRndVal write SetAcRndVal;
    property AcAValue:double read GetAcAValue write SetAcAValue;
    property AcBValue:double read GetAcBValue write SetAcBValue;
    property FgDPrice:double read GetFgDPrice write SetFgDPrice;
    property FgCPrice:double read GetFgCPrice write SetFgCPrice;
    property FgEPrice:double read GetFgEPrice write SetFgEPrice;
    property FgDValue:double read GetFgDValue write SetFgDValue;
    property FgDscVal:double read GetFgDscVal write SetFgDscVal;
    property FgRndVal:double read GetFgRndVal write SetFgRndVal;
    property FgCValue:double read GetFgCValue write SetFgCValue;
    property FgEValue:double read GetFgEValue write SetFgEValue;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property DrbDate:TDatetime read GetDrbDate write SetDrbDate;
    property PaCode:longint read GetPaCode write SetPaCode;
    property OsdNum:Str12 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:longint read GetOcdItm write SetOcdItm;
    property IsdNum:Str12 read GetIsdNum write SetIsdNum;
    property IsdItm:word read GetIsdItm write SetIsdItm;
    property IsdDate:TDatetime read GetIsdDate write SetIsdDate;
    property StkStat:Str1 read GetStkStat write SetStkStat;
    property FinStat:Str1 read GetFinStat write SetFinStat;
    property AcqStat:Str1 read GetAcqStat write SetAcqStat;
    property SteCode:word read GetSteCode write SetSteCode;
    property RbaCode:Str30 read GetRbaCode write SetRbaCode;
    property RbaDate:TDatetime read GetRbaDate write SetRbaDate;
    property Cctvat:byte read GetCctvat write SetCctvat;
    property CrtUser:Str8 read GetCrtUser write SetCrtUser;
    property CrtDate:TDatetime read GetCrtDate write SetCrtDate;
    property CrtTime:TDatetime read GetCrtTime write SetCrtTime;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ModPrc:double read GetModPrc write SetModPrc;
    property ModCpc:double read GetModCpc write SetModCpc;
    property ModCva:double read GetModCva write SetModCva;
    property OutDoc:Str12 read GetOutDoc write SetOutDoc;
    property OutItm:word read GetOutItm write SetOutItm;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TTsiTmp.Create;
begin
  oTmpTable:=TmpInit ('TSI',Self);
end;

destructor TTsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTsiTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TTsiTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TTsiTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TTsiTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TTsiTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTsiTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TTsiTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTsiTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TTsiTmp.GetMgCode:word;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TTsiTmp.SetMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TTsiTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TTsiTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TTsiTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TTsiTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TTsiTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TTsiTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TTsiTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TTsiTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TTsiTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TTsiTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TTsiTmp.GetNotice:Str30;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TTsiTmp.SetNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TTsiTmp.GetPackGs:longint;
begin
  Result:=oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TTsiTmp.SetPackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger:=pValue;
end;

function TTsiTmp.GetGsType:Str1;
begin
  Result:=oTmpTable.FieldByName('GsType').AsString;
end;

procedure TTsiTmp.SetGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString:=pValue;
end;

function TTsiTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTsiTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TTsiTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TTsiTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TTsiTmp.GetGsQnt:double;
begin
  Result:=oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTsiTmp.SetGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat:=pValue;
end;

function TTsiTmp.GetVatPrc:double;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TTsiTmp.SetVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat:=pValue;
end;

function TTsiTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTsiTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TTsiTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TTsiTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TTsiTmp.GetAcDPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TTsiTmp.SetAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcCPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TTsiTmp.SetAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcEPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcEPrice').AsFloat;
end;

procedure TTsiTmp.SetAcEPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcEPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcSPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcSPrice').AsFloat;
end;

procedure TTsiTmp.SetAcSPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcSPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcAPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TTsiTmp.SetAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcBPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TTsiTmp.SetAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetAcDValue:double;
begin
  Result:=oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTsiTmp.SetAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcDscVal:double;
begin
  Result:=oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTsiTmp.SetAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat:=pValue;
end;

function TTsiTmp.GetAcCValue:double;
begin
  Result:=oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTsiTmp.SetAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcEValue:double;
begin
  Result:=oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TTsiTmp.SetAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcZValue:double;
begin
  Result:=oTmpTable.FieldByName('AcZValue').AsFloat;
end;

procedure TTsiTmp.SetAcZValue(pValue:double);
begin
  oTmpTable.FieldByName('AcZValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcTValue:double;
begin
  Result:=oTmpTable.FieldByName('AcTValue').AsFloat;
end;

procedure TTsiTmp.SetAcTValue(pValue:double);
begin
  oTmpTable.FieldByName('AcTValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcOValue:double;
begin
  Result:=oTmpTable.FieldByName('AcOValue').AsFloat;
end;

procedure TTsiTmp.SetAcOValue(pValue:double);
begin
  oTmpTable.FieldByName('AcOValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcSValue:double;
begin
  Result:=oTmpTable.FieldByName('AcSValue').AsFloat;
end;

procedure TTsiTmp.SetAcSValue(pValue:double);
begin
  oTmpTable.FieldByName('AcSValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcRndVal:double;
begin
  Result:=oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTsiTmp.SetAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat:=pValue;
end;

function TTsiTmp.GetAcAValue:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTsiTmp.SetAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat:=pValue;
end;

function TTsiTmp.GetAcBValue:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTsiTmp.SetAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat:=pValue;
end;

function TTsiTmp.GetFgDPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TTsiTmp.SetFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetFgCPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTsiTmp.SetFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetFgEPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TTsiTmp.SetFgEPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgEPrice').AsFloat:=pValue;
end;

function TTsiTmp.GetFgDValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTsiTmp.SetFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat:=pValue;
end;

function TTsiTmp.GetFgDscVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTsiTmp.SetFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat:=pValue;
end;

function TTsiTmp.GetFgRndVal:double;
begin
  Result:=oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTsiTmp.SetFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat:=pValue;
end;

function TTsiTmp.GetFgCValue:double;
begin
  Result:=oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTsiTmp.SetFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat:=pValue;
end;

function TTsiTmp.GetFgEValue:double;
begin
  Result:=oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TTsiTmp.SetFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat:=pValue;
end;

function TTsiTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTsiTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetDrbDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTsiTmp.SetDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TTsiTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TTsiTmp.GetOsdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TTsiTmp.SetOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TTsiTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TTsiTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TTsiTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TTsiTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TTsiTmp.GetOcdItm:longint;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TTsiTmp.SetOcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TTsiTmp.GetIsdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TTsiTmp.SetIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TTsiTmp.GetIsdItm:word;
begin
  Result:=oTmpTable.FieldByName('IsdItm').AsInteger;
end;

procedure TTsiTmp.SetIsdItm(pValue:word);
begin
  oTmpTable.FieldByName('IsdItm').AsInteger:=pValue;
end;

function TTsiTmp.GetIsdDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IsdDate').AsDateTime;
end;

procedure TTsiTmp.SetIsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IsdDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetStkStat:Str1;
begin
  Result:=oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TTsiTmp.SetStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString:=pValue;
end;

function TTsiTmp.GetFinStat:Str1;
begin
  Result:=oTmpTable.FieldByName('FinStat').AsString;
end;

procedure TTsiTmp.SetFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('FinStat').AsString:=pValue;
end;

function TTsiTmp.GetAcqStat:Str1;
begin
  Result:=oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TTsiTmp.SetAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString:=pValue;
end;

function TTsiTmp.GetSteCode:word;
begin
  Result:=oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TTsiTmp.SetSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger:=pValue;
end;

function TTsiTmp.GetRbaCode:Str30;
begin
  Result:=oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TTsiTmp.SetRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString:=pValue;
end;

function TTsiTmp.GetRbaDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTsiTmp.SetRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TTsiTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TTsiTmp.GetCrtUser:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTsiTmp.SetCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString:=pValue;
end;

function TTsiTmp.GetCrtDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTsiTmp.SetCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetCrtTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTsiTmp.SetCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime:=pValue;
end;

function TTsiTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTsiTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TTsiTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTsiTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TTsiTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTsiTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TTsiTmp.GetModPrc:double;
begin
  Result:=oTmpTable.FieldByName('ModPrc').AsFloat;
end;

procedure TTsiTmp.SetModPrc(pValue:double);
begin
  oTmpTable.FieldByName('ModPrc').AsFloat:=pValue;
end;

function TTsiTmp.GetModCpc:double;
begin
  Result:=oTmpTable.FieldByName('ModCpc').AsFloat;
end;

procedure TTsiTmp.SetModCpc(pValue:double);
begin
  oTmpTable.FieldByName('ModCpc').AsFloat:=pValue;
end;

function TTsiTmp.GetModCva:double;
begin
  Result:=oTmpTable.FieldByName('ModCva').AsFloat;
end;

procedure TTsiTmp.SetModCva(pValue:double);
begin
  oTmpTable.FieldByName('ModCva').AsFloat:=pValue;
end;

function TTsiTmp.GetOutDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TTsiTmp.SetOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString:=pValue;
end;

function TTsiTmp.GetOutItm:word;
begin
  Result:=oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TTsiTmp.SetOutItm(pValue:word);
begin
  oTmpTable.FieldByName('OutItm').AsInteger:=pValue;
end;

function TTsiTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTsiTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TTsiTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TTsiTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TTsiTmp.LocRoIt(pRowNum:word;pItmNum:word):boolean;
begin
  SetIndex (ixRoIt);
  Result:=oTmpTable.FindKey([pRowNum,pItmNum]);
end;

function TTsiTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TTsiTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TTsiTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TTsiTmp.LocGsName_(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TTsiTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TTsiTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TTsiTmp.LocIsdNum(pIsdNum:Str12):boolean;
begin
  SetIndex (ixIsdNum);
  Result:=oTmpTable.FindKey([pIsdNum]);
end;

function TTsiTmp.LocStkStat(pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result:=oTmpTable.FindKey([pStkStat]);
end;

function TTsiTmp.LocFinStat(pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result:=oTmpTable.FindKey([pFinStat]);
end;

function TTsiTmp.LocRbaCode(pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result:=oTmpTable.FindKey([pRbaCode]);
end;

function TTsiTmp.LocOdOi(pOutDoc:Str12;pOutItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result:=oTmpTable.FindKey([pOutDoc,pOutItm]);
end;

procedure TTsiTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TTsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TTsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTsiTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTsiTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTsiTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TTsiTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
