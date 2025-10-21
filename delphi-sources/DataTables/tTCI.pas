unit tTCI;

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
  ixScBc='ScBc';
  ixStkStat='StkStat';
  ixFinStat='FinStat';
  ixGsType='GsType';
  ixSnSi='SnSi';
  ixRbaCode='RbaCode';
  ixGcSm='GcSm';

type
  TTciTmp=class(TComponent)
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
    function GetExpQnt:double;           procedure SetExpQnt (pValue:double);
    function GetNoeQnt:double;           procedure SetNoeQnt (pValue:double);
    function GetGscQnt:double;           procedure SetGscQnt (pValue:double);
    function GetGspQnt:double;           procedure SetGspQnt (pValue:double);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetHdsPrc:double;           procedure SetHdsPrc (pValue:double);
    function GetAcCPrice:double;         procedure SetAcCPrice (pValue:double);
    function GetAcAPrice:double;         procedure SetAcAPrice (pValue:double);
    function GetAcBPrice:double;         procedure SetAcBPrice (pValue:double);
    function GetAcCValue:double;         procedure SetAcCValue (pValue:double);
    function GetAcDValue:double;         procedure SetAcDValue (pValue:double);
    function GetAcDscVal:double;         procedure SetAcDscVal (pValue:double);
    function GetAcAValue:double;         procedure SetAcAValue (pValue:double);
    function GetAcBValue:double;         procedure SetAcBValue (pValue:double);
    function GetAcRndVal:double;         procedure SetAcRndVal (pValue:double);
    function GetAcRndVat:double;         procedure SetAcRndVat (pValue:double);
    function GetFgCPrice:double;         procedure SetFgCPrice (pValue:double);
    function GetFgDPrice:double;         procedure SetFgDPrice (pValue:double);
    function GetFgHPrice:double;         procedure SetFgHPrice (pValue:double);
    function GetFgAPrice:double;         procedure SetFgAPrice (pValue:double);
    function GetFgBPrice:double;         procedure SetFgBPrice (pValue:double);
    function GetFgCValue:double;         procedure SetFgCValue (pValue:double);
    function GetFgDValue:double;         procedure SetFgDValue (pValue:double);
    function GetFgHValue:double;         procedure SetFgHValue (pValue:double);
    function GetFgDscVal:double;         procedure SetFgDscVal (pValue:double);
    function GetFgDscAVal:double;        procedure SetFgDscAVal (pValue:double);
    function GetFgDscBVal:double;        procedure SetFgDscBVal (pValue:double);
    function GetFgHdsVal:double;         procedure SetFgHdsVal (pValue:double);
    function GetFgAValue:double;         procedure SetFgAValue (pValue:double);
    function GetFgBValue:double;         procedure SetFgBValue (pValue:double);
    function GetFgRndVal:double;         procedure SetFgRndVal (pValue:double);
    function GetFgRndVat:double;         procedure SetFgRndVat (pValue:double);
    function GetDlrCode:word;            procedure SetDlrCode (pValue:word);
    function GetDltName:Str30;           procedure SetDltName (pValue:Str30);
    function GetSteCode:word;            procedure SetSteCode (pValue:word);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetDrbDate:TDatetime;       procedure SetDrbDate (pValue:TDatetime);
    function GetDlvDate:TDatetime;       procedure SetDlvDate (pValue:TDatetime);
    function GetDlvUser:Str8;            procedure SetDlvUser (pValue:Str8);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetMcdNum:Str12;            procedure SetMcdNum (pValue:Str12);
    function GetMcdItm:word;             procedure SetMcdItm (pValue:word);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm (pValue:word);
    function GetIcdNum:Str12;            procedure SetIcdNum (pValue:Str12);
    function GetIcdItm:word;             procedure SetIcdItm (pValue:word);
    function GetIcdDate:TDatetime;       procedure SetIcdDate (pValue:TDatetime);
    function GetScdNum:Str12;            procedure SetScdNum (pValue:Str12);
    function GetScdItm:word;             procedure SetScdItm (pValue:word);
    function GetStkStat:Str1;            procedure SetStkStat (pValue:Str1);
    function GetFinStat:Str1;            procedure SetFinStat (pValue:Str1);
    function GetAction:Str1;             procedure SetAction (pValue:Str1);
    function GetDscType:Str1;            procedure SetDscType (pValue:Str1);
    function GetSpMark:Str10;            procedure SetSpMark (pValue:Str10);
    function GetBonNum:byte;             procedure SetBonNum (pValue:byte);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetCasNum:word;             procedure SetCasNum (pValue:word);
    function GetPckQnt:byte;             procedure SetPckQnt (pValue:byte);
    function GetCsCode:Str15;            procedure SetCsCode (pValue:Str15);
    function GetRspUser:Str8;            procedure SetRspUser (pValue:Str8);
    function GetRspDate:TDatetime;       procedure SetRspDate (pValue:TDatetime);
    function GetRspTime:TDatetime;       procedure SetRspTime (pValue:TDatetime);
    function GetRbaCode:Str30;           procedure SetRbaCode (pValue:Str30);
    function GetRbaDate:TDatetime;       procedure SetRbaDate (pValue:TDatetime);
    function GetProdNum:Str30;           procedure SetProdNum (pValue:Str30);
    function GetCrtUser:Str8;            procedure SetCrtUser (pValue:Str8);
    function GetCrtDate:TDatetime;       procedure SetCrtDate (pValue:TDatetime);
    function GetCrtTime:TDatetime;       procedure SetCrtTime (pValue:TDatetime);
    function GetModNum:word;             procedure SetModNum (pValue:word);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetNoeRea:Str100;           procedure SetNoeRea (pValue:Str100);
    function GetNoeSol:Str100;           procedure SetNoeSol (pValue:Str100);
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
    function LocScBc (pStkCode:Str15;pBarCode:Str15):boolean;
    function LocStkStat (pStkStat:Str1):boolean;
    function LocFinStat (pFinStat:Str1):boolean;
    function LocGsType (pGsType:Str1):boolean;
    function LocSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocRbaCode (pRbaCode:Str30):boolean;
    function LocGcSm (pGsCode:longint;pSpMark:Str10):boolean;

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
    property ExpQnt:double read GetExpQnt write SetExpQnt;
    property NoeQnt:double read GetNoeQnt write SetNoeQnt;
    property GscQnt:double read GetGscQnt write SetGscQnt;
    property GspQnt:double read GetGspQnt write SetGspQnt;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property HdsPrc:double read GetHdsPrc write SetHdsPrc;
    property AcCPrice:double read GetAcCPrice write SetAcCPrice;
    property AcAPrice:double read GetAcAPrice write SetAcAPrice;
    property AcBPrice:double read GetAcBPrice write SetAcBPrice;
    property AcCValue:double read GetAcCValue write SetAcCValue;
    property AcDValue:double read GetAcDValue write SetAcDValue;
    property AcDscVal:double read GetAcDscVal write SetAcDscVal;
    property AcAValue:double read GetAcAValue write SetAcAValue;
    property AcBValue:double read GetAcBValue write SetAcBValue;
    property AcRndVal:double read GetAcRndVal write SetAcRndVal;
    property AcRndVat:double read GetAcRndVat write SetAcRndVat;
    property FgCPrice:double read GetFgCPrice write SetFgCPrice;
    property FgDPrice:double read GetFgDPrice write SetFgDPrice;
    property FgHPrice:double read GetFgHPrice write SetFgHPrice;
    property FgAPrice:double read GetFgAPrice write SetFgAPrice;
    property FgBPrice:double read GetFgBPrice write SetFgBPrice;
    property FgCValue:double read GetFgCValue write SetFgCValue;
    property FgDValue:double read GetFgDValue write SetFgDValue;
    property FgHValue:double read GetFgHValue write SetFgHValue;
    property FgDscVal:double read GetFgDscVal write SetFgDscVal;
    property FgDscAVal:double read GetFgDscAVal write SetFgDscAVal;
    property FgDscBVal:double read GetFgDscBVal write SetFgDscBVal;
    property FgHdsVal:double read GetFgHdsVal write SetFgHdsVal;
    property FgAValue:double read GetFgAValue write SetFgAValue;
    property FgBValue:double read GetFgBValue write SetFgBValue;
    property FgRndVal:double read GetFgRndVal write SetFgRndVal;
    property FgRndVat:double read GetFgRndVat write SetFgRndVat;
    property DlrCode:word read GetDlrCode write SetDlrCode;
    property DltName:Str30 read GetDltName write SetDltName;
    property SteCode:word read GetSteCode write SetSteCode;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property DrbDate:TDatetime read GetDrbDate write SetDrbDate;
    property DlvDate:TDatetime read GetDlvDate write SetDlvDate;
    property DlvUser:Str8 read GetDlvUser write SetDlvUser;
    property PaCode:longint read GetPaCode write SetPaCode;
    property McdNum:Str12 read GetMcdNum write SetMcdNum;
    property McdItm:word read GetMcdItm write SetMcdItm;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property IcdNum:Str12 read GetIcdNum write SetIcdNum;
    property IcdItm:word read GetIcdItm write SetIcdItm;
    property IcdDate:TDatetime read GetIcdDate write SetIcdDate;
    property ScdNum:Str12 read GetScdNum write SetScdNum;
    property ScdItm:word read GetScdItm write SetScdItm;
    property StkStat:Str1 read GetStkStat write SetStkStat;
    property FinStat:Str1 read GetFinStat write SetFinStat;
    property Action:Str1 read GetAction write SetAction;
    property DscType:Str1 read GetDscType write SetDscType;
    property SpMark:Str10 read GetSpMark write SetSpMark;
    property BonNum:byte read GetBonNum write SetBonNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property CasNum:word read GetCasNum write SetCasNum;
    property PckQnt:byte read GetPckQnt write SetPckQnt;
    property CsCode:Str15 read GetCsCode write SetCsCode;
    property RspUser:Str8 read GetRspUser write SetRspUser;
    property RspDate:TDatetime read GetRspDate write SetRspDate;
    property RspTime:TDatetime read GetRspTime write SetRspTime;
    property RbaCode:Str30 read GetRbaCode write SetRbaCode;
    property RbaDate:TDatetime read GetRbaDate write SetRbaDate;
    property ProdNum:Str30 read GetProdNum write SetProdNum;
    property CrtUser:Str8 read GetCrtUser write SetCrtUser;
    property CrtDate:TDatetime read GetCrtDate write SetCrtDate;
    property CrtTime:TDatetime read GetCrtTime write SetCrtTime;
    property ModNum:word read GetModNum write SetModNum;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
    property Cctvat:byte read GetCctvat write SetCctvat;
    property NoeRea:Str100 read GetNoeRea write SetNoeRea;
    property NoeSol:Str100 read GetNoeSol write SetNoeSol;
    property GSCODE_MsuQnt:double read GetGSCODE_MsuQnt write SetGSCODE_MsuQnt;
    property GSCODE_MsuName:Str5 read GetGSCODE_MsuName write SetGSCODE_MsuName;
  end;

implementation

constructor TTciTmp.Create;
begin
  oTmpTable:=TmpInit ('TCI',Self);
end;

destructor TTciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTciTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TTciTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TTciTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTciTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TTciTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTciTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TTciTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TTciTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TTciTmp.GetMgCode:longint;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TTciTmp.SetMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TTciTmp.GetMgName:Str30;
begin
  Result:=oTmpTable.FieldByName('MgName').AsString;
end;

procedure TTciTmp.SetMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString:=pValue;
end;

function TTciTmp.GetFgCode:longint;
begin
  Result:=oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TTciTmp.SetFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TTciTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TTciTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TTciTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TTciTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TTciTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TTciTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TTciTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TTciTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TTciTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TTciTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TTciTmp.GetSpcCode:Str30;
begin
  Result:=oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TTciTmp.SetSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString:=pValue;
end;

function TTciTmp.GetNotice:Str30;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TTciTmp.SetNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TTciTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTciTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TTciTmp.GetVolume:double;
begin
  Result:=oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TTciTmp.SetVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat:=pValue;
end;

function TTciTmp.GetWeight:double;
begin
  Result:=oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TTciTmp.SetWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TTciTmp.GetPackGs:longint;
begin
  Result:=oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TTciTmp.SetPackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger:=pValue;
end;

function TTciTmp.GetGsType:Str1;
begin
  Result:=oTmpTable.FieldByName('GsType').AsString;
end;

procedure TTciTmp.SetGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString:=pValue;
end;

function TTciTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TTciTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TTciTmp.GetGsQnt:double;
begin
  Result:=oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTciTmp.SetGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat:=pValue;
end;

function TTciTmp.GetExpQnt:double;
begin
  Result:=oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TTciTmp.SetExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat:=pValue;
end;

function TTciTmp.GetNoeQnt:double;
begin
  Result:=oTmpTable.FieldByName('NoeQnt').AsFloat;
end;

procedure TTciTmp.SetNoeQnt(pValue:double);
begin
  oTmpTable.FieldByName('NoeQnt').AsFloat:=pValue;
end;

function TTciTmp.GetGscQnt:double;
begin
  Result:=oTmpTable.FieldByName('GscQnt').AsFloat;
end;

procedure TTciTmp.SetGscQnt(pValue:double);
begin
  oTmpTable.FieldByName('GscQnt').AsFloat:=pValue;
end;

function TTciTmp.GetGspQnt:double;
begin
  Result:=oTmpTable.FieldByName('GspQnt').AsFloat;
end;

procedure TTciTmp.SetGspQnt(pValue:double);
begin
  oTmpTable.FieldByName('GspQnt').AsFloat:=pValue;
end;

function TTciTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTciTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TTciTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTciTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TTciTmp.GetHdsPrc:double;
begin
  Result:=oTmpTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TTciTmp.SetHdsPrc(pValue:double);
begin
  oTmpTable.FieldByName('HdsPrc').AsFloat:=pValue;
end;

function TTciTmp.GetAcCPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TTciTmp.SetAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat:=pValue;
end;

function TTciTmp.GetAcAPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TTciTmp.SetAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat:=pValue;
end;

function TTciTmp.GetAcBPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TTciTmp.SetAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat:=pValue;
end;

function TTciTmp.GetAcCValue:double;
begin
  Result:=oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTciTmp.SetAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat:=pValue;
end;

function TTciTmp.GetAcDValue:double;
begin
  Result:=oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTciTmp.SetAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat:=pValue;
end;

function TTciTmp.GetAcDscVal:double;
begin
  Result:=oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTciTmp.SetAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat:=pValue;
end;

function TTciTmp.GetAcAValue:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTciTmp.SetAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat:=pValue;
end;

function TTciTmp.GetAcBValue:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTciTmp.SetAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat:=pValue;
end;

function TTciTmp.GetAcRndVal:double;
begin
  Result:=oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTciTmp.SetAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat:=pValue;
end;

function TTciTmp.GetAcRndVat:double;
begin
  Result:=oTmpTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TTciTmp.SetAcRndVat(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVat').AsFloat:=pValue;
end;

function TTciTmp.GetFgCPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTciTmp.SetFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat:=pValue;
end;

function TTciTmp.GetFgDPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TTciTmp.SetFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat:=pValue;
end;

function TTciTmp.GetFgHPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgHPrice').AsFloat;
end;

procedure TTciTmp.SetFgHPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgHPrice').AsFloat:=pValue;
end;

function TTciTmp.GetFgAPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TTciTmp.SetFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat:=pValue;
end;

function TTciTmp.GetFgBPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TTciTmp.SetFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat:=pValue;
end;

function TTciTmp.GetFgCValue:double;
begin
  Result:=oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTciTmp.SetFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat:=pValue;
end;

function TTciTmp.GetFgDValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTciTmp.SetFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat:=pValue;
end;

function TTciTmp.GetFgHValue:double;
begin
  Result:=oTmpTable.FieldByName('FgHValue').AsFloat;
end;

procedure TTciTmp.SetFgHValue(pValue:double);
begin
  oTmpTable.FieldByName('FgHValue').AsFloat:=pValue;
end;

function TTciTmp.GetFgDscVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTciTmp.SetFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat:=pValue;
end;

function TTciTmp.GetFgDscAVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscAVal').AsFloat;
end;

procedure TTciTmp.SetFgDscAVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscAVal').AsFloat:=pValue;
end;

function TTciTmp.GetFgDscBVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TTciTmp.SetFgDscBVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscBVal').AsFloat:=pValue;
end;

function TTciTmp.GetFgHdsVal:double;
begin
  Result:=oTmpTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TTciTmp.SetFgHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHdsVal').AsFloat:=pValue;
end;

function TTciTmp.GetFgAValue:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TTciTmp.SetFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat:=pValue;
end;

function TTciTmp.GetFgBValue:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TTciTmp.SetFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat:=pValue;
end;

function TTciTmp.GetFgRndVal:double;
begin
  Result:=oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTciTmp.SetFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat:=pValue;
end;

function TTciTmp.GetFgRndVat:double;
begin
  Result:=oTmpTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TTciTmp.SetFgRndVat(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVat').AsFloat:=pValue;
end;

function TTciTmp.GetDlrCode:word;
begin
  Result:=oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TTciTmp.SetDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger:=pValue;
end;

function TTciTmp.GetDltName:Str30;
begin
  Result:=oTmpTable.FieldByName('DltName').AsString;
end;

procedure TTciTmp.SetDltName(pValue:Str30);
begin
  oTmpTable.FieldByName('DltName').AsString:=pValue;
end;

function TTciTmp.GetSteCode:word;
begin
  Result:=oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TTciTmp.SetSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger:=pValue;
end;

function TTciTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTciTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TTciTmp.GetDrbDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTciTmp.SetDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime:=pValue;
end;

function TTciTmp.GetDlvDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTciTmp.SetDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime:=pValue;
end;

function TTciTmp.GetDlvUser:Str8;
begin
  Result:=oTmpTable.FieldByName('DlvUser').AsString;
end;

procedure TTciTmp.SetDlvUser(pValue:Str8);
begin
  oTmpTable.FieldByName('DlvUser').AsString:=pValue;
end;

function TTciTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TTciTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TTciTmp.GetMcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TTciTmp.SetMcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TTciTmp.GetMcdItm:word;
begin
  Result:=oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TTciTmp.SetMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TTciTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TTciTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TTciTmp.GetOcdItm:word;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TTciTmp.SetOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TTciTmp.GetIcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TTciTmp.SetIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TTciTmp.GetIcdItm:word;
begin
  Result:=oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TTciTmp.SetIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TTciTmp.GetIcdDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TTciTmp.SetIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDate').AsDateTime:=pValue;
end;

function TTciTmp.GetScdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ScdNum').AsString;
end;

procedure TTciTmp.SetScdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ScdNum').AsString:=pValue;
end;

function TTciTmp.GetScdItm:word;
begin
  Result:=oTmpTable.FieldByName('ScdItm').AsInteger;
end;

procedure TTciTmp.SetScdItm(pValue:word);
begin
  oTmpTable.FieldByName('ScdItm').AsInteger:=pValue;
end;

function TTciTmp.GetStkStat:Str1;
begin
  Result:=oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TTciTmp.SetStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString:=pValue;
end;

function TTciTmp.GetFinStat:Str1;
begin
  Result:=oTmpTable.FieldByName('FinStat').AsString;
end;

procedure TTciTmp.SetFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('FinStat').AsString:=pValue;
end;

function TTciTmp.GetAction:Str1;
begin
  Result:=oTmpTable.FieldByName('Action').AsString;
end;

procedure TTciTmp.SetAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString:=pValue;
end;

function TTciTmp.GetDscType:Str1;
begin
  Result:=oTmpTable.FieldByName('DscType').AsString;
end;

procedure TTciTmp.SetDscType(pValue:Str1);
begin
  oTmpTable.FieldByName('DscType').AsString:=pValue;
end;

function TTciTmp.GetSpMark:Str10;
begin
  Result:=oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TTciTmp.SetSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString:=pValue;
end;

function TTciTmp.GetBonNum:byte;
begin
  Result:=oTmpTable.FieldByName('BonNum').AsInteger;
end;

procedure TTciTmp.SetBonNum(pValue:byte);
begin
  oTmpTable.FieldByName('BonNum').AsInteger:=pValue;
end;

function TTciTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TTciTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TTciTmp.GetCasNum:word;
begin
  Result:=oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TTciTmp.SetCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger:=pValue;
end;

function TTciTmp.GetPckQnt:byte;
begin
  Result:=oTmpTable.FieldByName('PckQnt').AsInteger;
end;

procedure TTciTmp.SetPckQnt(pValue:byte);
begin
  oTmpTable.FieldByName('PckQnt').AsInteger:=pValue;
end;

function TTciTmp.GetCsCode:Str15;
begin
  Result:=oTmpTable.FieldByName('CsCode').AsString;
end;

procedure TTciTmp.SetCsCode(pValue:Str15);
begin
  oTmpTable.FieldByName('CsCode').AsString:=pValue;
end;

function TTciTmp.GetRspUser:Str8;
begin
  Result:=oTmpTable.FieldByName('RspUser').AsString;
end;

procedure TTciTmp.SetRspUser(pValue:Str8);
begin
  oTmpTable.FieldByName('RspUser').AsString:=pValue;
end;

function TTciTmp.GetRspDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RspDate').AsDateTime;
end;

procedure TTciTmp.SetRspDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RspDate').AsDateTime:=pValue;
end;

function TTciTmp.GetRspTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RspTime').AsDateTime;
end;

procedure TTciTmp.SetRspTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RspTime').AsDateTime:=pValue;
end;

function TTciTmp.GetRbaCode:Str30;
begin
  Result:=oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TTciTmp.SetRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString:=pValue;
end;

function TTciTmp.GetRbaDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTciTmp.SetRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime:=pValue;
end;

function TTciTmp.GetProdNum:Str30;
begin
  Result:=oTmpTable.FieldByName('ProdNum').AsString;
end;

procedure TTciTmp.SetProdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ProdNum').AsString:=pValue;
end;

function TTciTmp.GetCrtUser:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTciTmp.SetCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString:=pValue;
end;

function TTciTmp.GetCrtDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTciTmp.SetCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime:=pValue;
end;

function TTciTmp.GetCrtTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTciTmp.SetCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime:=pValue;
end;

function TTciTmp.GetModNum:word;
begin
  Result:=oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TTciTmp.SetModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TTciTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTciTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TTciTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTciTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TTciTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTciTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TTciTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTciTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

function TTciTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TTciTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TTciTmp.GetNoeRea:Str100;
begin
  Result:=oTmpTable.FieldByName('NoeRea').AsString;
end;

procedure TTciTmp.SetNoeRea(pValue:Str100);
begin
  oTmpTable.FieldByName('NoeRea').AsString:=pValue;
end;

function TTciTmp.GetNoeSol:Str100;
begin
  Result:=oTmpTable.FieldByName('NoeSol').AsString;
end;

procedure TTciTmp.SetNoeSol(pValue:Str100);
begin
  oTmpTable.FieldByName('NoeSol').AsString:=pValue;
end;

function TTciTmp.GetGSCODE_MsuQnt:double;
begin
  Result:=oTmpTable.FieldByName('GSCODE_MsuQnt').AsFloat;
end;

procedure TTciTmp.SetGSCODE_MsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('GSCODE_MsuQnt').AsFloat:=pValue;
end;

function TTciTmp.GetGSCODE_MsuName:Str5;
begin
  Result:=oTmpTable.FieldByName('GSCODE_MsuName').AsString;
end;

procedure TTciTmp.SetGSCODE_MsuName(pValue:Str5);
begin
  oTmpTable.FieldByName('GSCODE_MsuName').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TTciTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TTciTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TTciTmp.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TTciTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TTciTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TTciTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

function TTciTmp.LocMgCode(pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result:=oTmpTable.FindKey([pMgCode]);
end;

function TTciTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TTciTmp.LocGsName_(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TTciTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TTciTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TTciTmp.LocScBc(pStkCode:Str15;pBarCode:Str15):boolean;
begin
  SetIndex (ixScBc);
  Result:=oTmpTable.FindKey([pStkCode,pBarCode]);
end;

function TTciTmp.LocStkStat(pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result:=oTmpTable.FindKey([pStkStat]);
end;

function TTciTmp.LocFinStat(pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result:=oTmpTable.FindKey([pFinStat]);
end;

function TTciTmp.LocGsType(pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result:=oTmpTable.FindKey([pGsType]);
end;

function TTciTmp.LocSnSi(pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result:=oTmpTable.FindKey([pScdNum,pScdItm]);
end;

function TTciTmp.LocRbaCode(pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result:=oTmpTable.FindKey([pRbaCode]);
end;

function TTciTmp.LocGcSm(pGsCode:longint;pSpMark:Str10):boolean;
begin
  SetIndex (ixGcSm);
  Result:=oTmpTable.FindKey([pGsCode,pSpMark]);
end;

procedure TTciTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TTciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTciTmp.First;
begin
  oTmpTable.First;
end;

procedure TTciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTciTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTciTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTciTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TTciTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
