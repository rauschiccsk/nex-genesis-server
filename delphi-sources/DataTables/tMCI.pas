unit tMCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt='';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixRowNum='RowNum';
  ixMgCode='MgCode';
  ixGsCode='GsCode';
  ixGsName_='GsName_';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixPaCode='PaCode';
  ixStatus='Status';

type
  TMciTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetMgCode:longint;          procedure SetMgCode (pValue:longint);
    function GetMgName:Str30;            procedure SetMgName (pValue:Str30);
    function GetFgCode:longint;          procedure SetFgCode (pValue:longint);
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetGsName_:Str30;           procedure SetGsName_ (pValue:Str30);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetSpcCode:Str30;           procedure SetSpcCode (pValue:Str30);
    function GetNotice:Str30;            procedure SetNotice (pValue:Str30);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetVolume:double;           procedure SetVolume (pValue:double);
    function GetWeight:double;           procedure SetWeight (pValue:double);
    function GetPackGs:longint;          procedure SetPackGs (pValue:longint);
    function GetGsType:Str1;             procedure SetGsType (pValue:Str1);
    function GetMsName:Str10;            procedure SetMsName (pValue:Str10);
    function GetGsQnt:double;            procedure SetGsQnt (pValue:double);
    function GetOfrQnt:Str20;            procedure SetOfrQnt (pValue:Str20);
    function GetDlvQnt:double;           procedure SetDlvQnt (pValue:double);
    function GetGenQnt:double;           procedure SetGenQnt (pValue:double);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetAcCPrice:double;         procedure SetAcCPrice (pValue:double);
    function GetAcDPrice:double;         procedure SetAcDPrice (pValue:double);
    function GetAcAPrice:double;         procedure SetAcAPrice (pValue:double);
    function GetAcBPrice:double;         procedure SetAcBPrice (pValue:double);
    function GetAcCValue:double;         procedure SetAcCValue (pValue:double);
    function GetAcDValue:double;         procedure SetAcDValue (pValue:double);
    function GetAcDscVal:double;         procedure SetAcDscVal (pValue:double);
    function GetAcAValue:double;         procedure SetAcAValue (pValue:double);
    function GetAcBValue:double;         procedure SetAcBValue (pValue:double);
    function GetFgCPrice:double;         procedure SetFgCPrice (pValue:double);
    function GetFgDPrice:double;         procedure SetFgDPrice (pValue:double);
    function GetFgHPrice:double;         procedure SetFgHPrice (pValue:double);
    function GetFgAPrice:double;         procedure SetFgAPrice (pValue:double);
    function GetFgBPrice:double;         procedure SetFgBPrice (pValue:double);
    function GetFgCValue:double;         procedure SetFgCValue (pValue:double);
    function GetFgDValue:double;         procedure SetFgDValue (pValue:double);
    function GetFgHValue:double;         procedure SetFgHValue (pValue:double);
    function GetFgDscAVal:double;        procedure SetFgDscAVal (pValue:double);
    function GetFgDscBVal:double;        procedure SetFgDscBVal (pValue:double);
    function GetFgDscVal:double;         procedure SetFgDscVal (pValue:double);
    function GetFgAValue:double;         procedure SetFgAValue (pValue:double);
    function GetFgBValue:double;         procedure SetFgBValue (pValue:double);
    function GetBciAvalue:double;        procedure SetBciAvalue (pValue:double);
    function GetPrjAvalue:double;        procedure SetPrjAvalue (pValue:double);
    function GetDlrCode:word;            procedure SetDlrCode (pValue:word);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetExpDate:TDatetime;       procedure SetExpDate (pValue:TDatetime);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm (pValue:word);
    function GetOcdDate:TDatetime;       procedure SetOcdDate (pValue:TDatetime);
    function GetTcdNum:Str12;            procedure SetTcdNum (pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm (pValue:word);
    function GetTcdDate:TDatetime;       procedure SetTcdDate (pValue:TDatetime);
    function GetAction:Str1;             procedure SetAction (pValue:Str1);
    function GetStatus:Str1;             procedure SetStatus (pValue:Str1);
    function GetDcCode:byte;             procedure SetDcCode (pValue:byte);
    function GetSpMark:Str10;            procedure SetSpMark (pValue:Str10);
    function GetCrtUser:Str8;            procedure SetCrtUser (pValue:Str8);
    function GetCrtDate:TDatetime;       procedure SetCrtDate (pValue:TDatetime);
    function GetCrtTime:TDatetime;       procedure SetCrtTime (pValue:TDatetime);
    function GetModNum:word;             procedure SetModNum (pValue:word);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
    function GetSrcCPrice:Str1;          procedure SetSrcCPrice (pValue:Str1);
    function GetSupPaCode:longint;       procedure SetSupPaCode (pValue:longint);
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetGSCODE_MsuQnt:double;    procedure SetGSCODE_MsuQnt (pValue:double);
    function GetGSCODE_MsuName:Str5;     procedure SetGSCODE_MsuName (pValue:Str5);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocRowNum (pRowNum:word):boolean;
    function LocMgCode (pMgCode:longint):boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocGsName_ (pGsName_:Str30):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocPaCode (pPaCode:longint):boolean;
    function LocStatus (pStatus:Str1):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property RowNum:word read GetRowNum write SetRowNum;
    property MgCode:longint read GetMgCode write SetMgCode;
    property MgName:Str30 read GetMgName write SetMgName;
    property FgCode:longint read GetFgCode write SetFgCode;
    property GsCode:longint read GetGsCode write SetGsCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property GsName_:Str30 read GetGsName_ write SetGsName_;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property SpcCode:Str30 read GetSpcCode write SetSpcCode;
    property Notice:Str30 read GetNotice write SetNotice;
    property StkNum:word read GetStkNum write SetStkNum;
    property Volume:double read GetVolume write SetVolume;
    property Weight:double read GetWeight write SetWeight;
    property PackGs:longint read GetPackGs write SetPackGs;
    property GsType:Str1 read GetGsType write SetGsType;
    property MsName:Str10 read GetMsName write SetMsName;
    property GsQnt:double read GetGsQnt write SetGsQnt;
    property OfrQnt:Str20 read GetOfrQnt write SetOfrQnt;
    property DlvQnt:double read GetDlvQnt write SetDlvQnt;
    property GenQnt:double read GetGenQnt write SetGenQnt;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property AcCPrice:double read GetAcCPrice write SetAcCPrice;
    property AcDPrice:double read GetAcDPrice write SetAcDPrice;
    property AcAPrice:double read GetAcAPrice write SetAcAPrice;
    property AcBPrice:double read GetAcBPrice write SetAcBPrice;
    property AcCValue:double read GetAcCValue write SetAcCValue;
    property AcDValue:double read GetAcDValue write SetAcDValue;
    property AcDscVal:double read GetAcDscVal write SetAcDscVal;
    property AcAValue:double read GetAcAValue write SetAcAValue;
    property AcBValue:double read GetAcBValue write SetAcBValue;
    property FgCPrice:double read GetFgCPrice write SetFgCPrice;
    property FgDPrice:double read GetFgDPrice write SetFgDPrice;
    property FgHPrice:double read GetFgHPrice write SetFgHPrice;
    property FgAPrice:double read GetFgAPrice write SetFgAPrice;
    property FgBPrice:double read GetFgBPrice write SetFgBPrice;
    property FgCValue:double read GetFgCValue write SetFgCValue;
    property FgDValue:double read GetFgDValue write SetFgDValue;
    property FgHValue:double read GetFgHValue write SetFgHValue;
    property FgDscAVal:double read GetFgDscAVal write SetFgDscAVal;
    property FgDscBVal:double read GetFgDscBVal write SetFgDscBVal;
    property FgDscVal:double read GetFgDscVal write SetFgDscVal;
    property FgAValue:double read GetFgAValue write SetFgAValue;
    property FgBValue:double read GetFgBValue write SetFgBValue;
    property BciAvalue:double read GetBciAvalue write SetBciAvalue;
    property PrjAvalue:double read GetPrjAvalue write SetPrjAvalue;
    property DlrCode:word read GetDlrCode write SetDlrCode;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property ExpDate:TDatetime read GetExpDate write SetExpDate;
    property PaCode:longint read GetPaCode write SetPaCode;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property OcdDate:TDatetime read GetOcdDate write SetOcdDate;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property TcdDate:TDatetime read GetTcdDate write SetTcdDate;
    property Action:Str1 read GetAction write SetAction;
    property Status:Str1 read GetStatus write SetStatus;
    property DcCode:byte read GetDcCode write SetDcCode;
    property SpMark:Str10 read GetSpMark write SetSpMark;
    property CrtUser:Str8 read GetCrtUser write SetCrtUser;
    property CrtDate:TDatetime read GetCrtDate write SetCrtDate;
    property CrtTime:TDatetime read GetCrtTime write SetCrtTime;
    property ModNum:word read GetModNum write SetModNum;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
    property SrcCPrice:Str1 read GetSrcCPrice write SetSrcCPrice;
    property SupPaCode:longint read GetSupPaCode write SetSupPaCode;
    property Cctvat:byte read GetCctvat write SetCctvat;
    property GSCODE_MsuQnt:double read GetGSCODE_MsuQnt write SetGSCODE_MsuQnt;
    property GSCODE_MsuName:Str5 read GetGSCODE_MsuName write SetGSCODE_MsuName;
  end;

implementation

constructor TMciTmp.Create;
begin
  oTmpTable:=TmpInit ('MCI',Self);
end;

destructor TMciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMciTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TMciTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TMciTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TMciTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TMciTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TMciTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TMciTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TMciTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TMciTmp.GetMgCode:longint;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TMciTmp.SetMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TMciTmp.GetMgName:Str30;
begin
  Result:=oTmpTable.FieldByName('MgName').AsString;
end;

procedure TMciTmp.SetMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString:=pValue;
end;

function TMciTmp.GetFgCode:longint;
begin
  Result:=oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TMciTmp.SetFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TMciTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TMciTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TMciTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TMciTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TMciTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TMciTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TMciTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TMciTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TMciTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TMciTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TMciTmp.GetSpcCode:Str30;
begin
  Result:=oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TMciTmp.SetSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString:=pValue;
end;

function TMciTmp.GetNotice:Str30;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TMciTmp.SetNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TMciTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TMciTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TMciTmp.GetVolume:double;
begin
  Result:=oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TMciTmp.SetVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat:=pValue;
end;

function TMciTmp.GetWeight:double;
begin
  Result:=oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TMciTmp.SetWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TMciTmp.GetPackGs:longint;
begin
  Result:=oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TMciTmp.SetPackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger:=pValue;
end;

function TMciTmp.GetGsType:Str1;
begin
  Result:=oTmpTable.FieldByName('GsType').AsString;
end;

procedure TMciTmp.SetGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString:=pValue;
end;

function TMciTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TMciTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TMciTmp.GetGsQnt:double;
begin
  Result:=oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TMciTmp.SetGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat:=pValue;
end;

function TMciTmp.GetOfrQnt:Str20;
begin
  Result:=oTmpTable.FieldByName('OfrQnt').AsString;
end;

procedure TMciTmp.SetOfrQnt(pValue:Str20);
begin
  oTmpTable.FieldByName('OfrQnt').AsString:=pValue;
end;

function TMciTmp.GetDlvQnt:double;
begin
  Result:=oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TMciTmp.SetDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat:=pValue;
end;

function TMciTmp.GetGenQnt:double;
begin
  Result:=oTmpTable.FieldByName('GenQnt').AsFloat;
end;

procedure TMciTmp.SetGenQnt(pValue:double);
begin
  oTmpTable.FieldByName('GenQnt').AsFloat:=pValue;
end;

function TMciTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TMciTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TMciTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TMciTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TMciTmp.GetAcCPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TMciTmp.SetAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat:=pValue;
end;

function TMciTmp.GetAcDPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TMciTmp.SetAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat:=pValue;
end;

function TMciTmp.GetAcAPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TMciTmp.SetAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat:=pValue;
end;

function TMciTmp.GetAcBPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TMciTmp.SetAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat:=pValue;
end;

function TMciTmp.GetAcCValue:double;
begin
  Result:=oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TMciTmp.SetAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat:=pValue;
end;

function TMciTmp.GetAcDValue:double;
begin
  Result:=oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TMciTmp.SetAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat:=pValue;
end;

function TMciTmp.GetAcDscVal:double;
begin
  Result:=oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TMciTmp.SetAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat:=pValue;
end;

function TMciTmp.GetAcAValue:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TMciTmp.SetAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat:=pValue;
end;

function TMciTmp.GetAcBValue:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TMciTmp.SetAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat:=pValue;
end;

function TMciTmp.GetFgCPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TMciTmp.SetFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat:=pValue;
end;

function TMciTmp.GetFgDPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TMciTmp.SetFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat:=pValue;
end;

function TMciTmp.GetFgHPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgHPrice').AsFloat;
end;

procedure TMciTmp.SetFgHPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgHPrice').AsFloat:=pValue;
end;

function TMciTmp.GetFgAPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TMciTmp.SetFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat:=pValue;
end;

function TMciTmp.GetFgBPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TMciTmp.SetFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat:=pValue;
end;

function TMciTmp.GetFgCValue:double;
begin
  Result:=oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TMciTmp.SetFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat:=pValue;
end;

function TMciTmp.GetFgDValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TMciTmp.SetFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat:=pValue;
end;

function TMciTmp.GetFgHValue:double;
begin
  Result:=oTmpTable.FieldByName('FgHValue').AsFloat;
end;

procedure TMciTmp.SetFgHValue(pValue:double);
begin
  oTmpTable.FieldByName('FgHValue').AsFloat:=pValue;
end;

function TMciTmp.GetFgDscAVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscAVal').AsFloat;
end;

procedure TMciTmp.SetFgDscAVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscAVal').AsFloat:=pValue;
end;

function TMciTmp.GetFgDscBVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TMciTmp.SetFgDscBVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscBVal').AsFloat:=pValue;
end;

function TMciTmp.GetFgDscVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TMciTmp.SetFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat:=pValue;
end;

function TMciTmp.GetFgAValue:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TMciTmp.SetFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat:=pValue;
end;

function TMciTmp.GetFgBValue:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TMciTmp.SetFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat:=pValue;
end;

function TMciTmp.GetBciAvalue:double;
begin
  Result:=oTmpTable.FieldByName('BciAvalue').AsFloat;
end;

procedure TMciTmp.SetBciAvalue(pValue:double);
begin
  oTmpTable.FieldByName('BciAvalue').AsFloat:=pValue;
end;

function TMciTmp.GetPrjAvalue:double;
begin
  Result:=oTmpTable.FieldByName('PrjAvalue').AsFloat;
end;

procedure TMciTmp.SetPrjAvalue(pValue:double);
begin
  oTmpTable.FieldByName('PrjAvalue').AsFloat:=pValue;
end;

function TMciTmp.GetDlrCode:word;
begin
  Result:=oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TMciTmp.SetDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger:=pValue;
end;

function TMciTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TMciTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TMciTmp.GetExpDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TMciTmp.SetExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime:=pValue;
end;

function TMciTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TMciTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TMciTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TMciTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TMciTmp.GetOcdItm:word;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TMciTmp.SetOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TMciTmp.GetOcdDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OcdDate').AsDateTime;
end;

procedure TMciTmp.SetOcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdDate').AsDateTime:=pValue;
end;

function TMciTmp.GetTcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TMciTmp.SetTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TMciTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TMciTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TMciTmp.GetTcdDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TMciTmp.SetTcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDate').AsDateTime:=pValue;
end;

function TMciTmp.GetAction:Str1;
begin
  Result:=oTmpTable.FieldByName('Action').AsString;
end;

procedure TMciTmp.SetAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString:=pValue;
end;

function TMciTmp.GetStatus:Str1;
begin
  Result:=oTmpTable.FieldByName('Status').AsString;
end;

procedure TMciTmp.SetStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString:=pValue;
end;

function TMciTmp.GetDcCode:byte;
begin
  Result:=oTmpTable.FieldByName('DcCode').AsInteger;
end;

procedure TMciTmp.SetDcCode(pValue:byte);
begin
  oTmpTable.FieldByName('DcCode').AsInteger:=pValue;
end;

function TMciTmp.GetSpMark:Str10;
begin
  Result:=oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TMciTmp.SetSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString:=pValue;
end;

function TMciTmp.GetCrtUser:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TMciTmp.SetCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString:=pValue;
end;

function TMciTmp.GetCrtDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMciTmp.SetCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime:=pValue;
end;

function TMciTmp.GetCrtTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMciTmp.SetCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime:=pValue;
end;

function TMciTmp.GetModNum:word;
begin
  Result:=oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TMciTmp.SetModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TMciTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TMciTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TMciTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMciTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TMciTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMciTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TMciTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TMciTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

function TMciTmp.GetSrcCPrice:Str1;
begin
  Result:=oTmpTable.FieldByName('SrcCPrice').AsString;
end;

procedure TMciTmp.SetSrcCPrice(pValue:Str1);
begin
  oTmpTable.FieldByName('SrcCPrice').AsString:=pValue;
end;

function TMciTmp.GetSupPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('SupPaCode').AsInteger;
end;

procedure TMciTmp.SetSupPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SupPaCode').AsInteger:=pValue;
end;

function TMciTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TMciTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TMciTmp.GetGSCODE_MsuQnt:double;
begin
  Result:=oTmpTable.FieldByName('GSCODE_MsuQnt').AsFloat;
end;

procedure TMciTmp.SetGSCODE_MsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('GSCODE_MsuQnt').AsFloat:=pValue;
end;

function TMciTmp.GetGSCODE_MsuName:Str5;
begin
  Result:=oTmpTable.FieldByName('GSCODE_MsuName').AsString;
end;

procedure TMciTmp.SetGSCODE_MsuName(pValue:Str5);
begin
  oTmpTable.FieldByName('GSCODE_MsuName').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TMciTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TMciTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TMciTmp.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TMciTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TMciTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TMciTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

function TMciTmp.LocMgCode(pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result:=oTmpTable.FindKey([pMgCode]);
end;

function TMciTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TMciTmp.LocGsName_(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TMciTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TMciTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TMciTmp.LocPaCode(pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result:=oTmpTable.FindKey([pPaCode]);
end;

function TMciTmp.LocStatus(pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result:=oTmpTable.FindKey([pStatus]);
end;

procedure TMciTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TMciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMciTmp.First;
begin
  oTmpTable.First;
end;

procedure TMciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMciTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMciTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMciTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TMciTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
