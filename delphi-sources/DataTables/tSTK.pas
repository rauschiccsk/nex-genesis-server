unit tSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode='';
  ixMgCode='MgCode';
  ixGsName_='GsName_';
  ixGaName_='GaName_';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixActQnt='ActQnt';
  ixActVal='ActVal';
  ixMinMax='MinMax';
  ixAvgPrice='AvgPrice';
  ixLastPrice='LastPrice';
  ixLastIDate='LastIDate';
  ixLastODate='LastODate';
  ixOsdQnt='OsdQnt';
  ixOsdCode='OsdCode';

type
  TStkTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetMgCode:longint;          procedure SetMgCode (pValue:longint);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetGsName_:Str30;           procedure SetGsName_ (pValue:Str30);
    function GetGaName:Str60;            procedure SetGaName (pValue:Str60);
    function GetGaName_:Str60;           procedure SetGaName_ (pValue:Str60);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetMsName:Str10;            procedure SetMsName (pValue:Str10);
    function GetVatPrc:double;           procedure SetVatPrc (pValue:double);
    function GetGsType:Str1;             procedure SetGsType (pValue:Str1);
    function GetDrbMust:boolean;         procedure SetDrbMust (pValue:boolean);
    function GetDrbDay:word;             procedure SetDrbDay (pValue:word);
    function GetPdnMust:boolean;         procedure SetPdnMust (pValue:boolean);
    function GetGrcMth:word;             procedure SetGrcMth (pValue:word);
    function GetBegQnt:double;           procedure SetBegQnt (pValue:double);
    function GetInQnt:double;            procedure SetInQnt (pValue:double);
    function GetPrvOut:double;           procedure SetPrvOut (pValue:double);
    function GetOutQnt:double;           procedure SetOutQnt (pValue:double);
    function GetActQnt:double;           procedure SetActQnt (pValue:double);
    function GetBegAcq:double;           procedure SetBegAcq (pValue:double);
    function GetInAcq:double;            procedure SetInAcq (pValue:double);
    function GetOutAcq:double;           procedure SetOutAcq (pValue:double);
    function GetActAcq:double;           procedure SetActAcq (pValue:double);
    function GetBegAcv:double;           procedure SetBegAcv (pValue:double);
    function GetInAcv:double;            procedure SetInAcv (pValue:double);
    function GetOutAcv:double;           procedure SetOutAcv (pValue:double);
    function GetActAcv:double;           procedure SetActAcv (pValue:double);
    function GetSalQnt:double;           procedure SetSalQnt (pValue:double);
    function GetNrsQnt:double;           procedure SetNrsQnt (pValue:double);
    function GetOcdQnt:double;           procedure SetOcdQnt (pValue:double);
    function GetFreQnt:double;           procedure SetFreQnt (pValue:double);
    function GetOsdQnt:double;           procedure SetOsdQnt (pValue:double);
    function GetOsrQnt:double;           procedure SetOsrQnt (pValue:double);
    function GetFroQnt:double;           procedure SetFroQnt (pValue:double);
    function GetNsuQnt:double;           procedure SetNsuQnt (pValue:double);
    function GetBegVal:double;           procedure SetBegVal (pValue:double);
    function GetInVal:double;            procedure SetInVal (pValue:double);
    function GetOutVal:double;           procedure SetOutVal (pValue:double);
    function GetActVal:double;           procedure SetActVal (pValue:double);
    function GetAvgPrice:double;         procedure SetAvgPrice (pValue:double);
    function GetLastPrice:double;        procedure SetLastPrice (pValue:double);
    function GetActPrice:double;         procedure SetActPrice (pValue:double);
    function GetMinOsq:double;           procedure SetMinOsq (pValue:double);
    function GetMaxQnt:double;           procedure SetMaxQnt (pValue:double);
    function GetMinQnt:double;           procedure SetMinQnt (pValue:double);
    function GetOptQnt:double;           procedure SetOptQnt (pValue:double);
    function GetDifQnt:double;           procedure SetDifQnt (pValue:double);
    function GetMinMax:Str1;             procedure SetMinMax (pValue:Str1);
    function GetInvDate:TDatetime;       procedure SetInvDate (pValue:TDatetime);
    function GetLastIDate:TDatetime;     procedure SetLastIDate (pValue:TDatetime);
    function GetLastODate:TDatetime;     procedure SetLastODate (pValue:TDatetime);
    function GetLastIQnt:double;         procedure SetLastIQnt (pValue:double);
    function GetLastOQnt:double;         procedure SetLastOQnt (pValue:double);
    function GetActSnQnt:longint;        procedure SetActSnQnt (pValue:longint);
    function GetProfit:double;           procedure SetProfit (pValue:double);
    function GetBPrice:double;           procedure SetBPrice (pValue:double);
    function GetSended:boolean;          procedure SetSended (pValue:boolean);
    function GetAction:Str1;             procedure SetAction (pValue:Str1);
    function GetDisFlag:boolean;         procedure SetDisFlag (pValue:boolean);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
    function GetDifOsd:double;           procedure SetDifOsd (pValue:double);
    function GetDifOcd:double;           procedure SetDifOcd (pValue:double);
    function GetDifNrs:double;           procedure SetDifNrs (pValue:double);
    function GetASaQnt:double;           procedure SetASaQnt (pValue:double);
    function GetAOuQnt:double;           procedure SetAOuQnt (pValue:double);
    function GetPSaQnt:double;           procedure SetPSaQnt (pValue:double);
    function GetPOuQnt:double;           procedure SetPOuQnt (pValue:double);
    function GetSsoQnt:double;           procedure SetSsoQnt (pValue:double);
    function GetImrQnt:double;           procedure SetImrQnt (pValue:double);
    function GetOsdCode:Str15;           procedure SetOsdCode (pValue:Str15);
    function GetOfrQnt:double;           procedure SetOfrQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocMgCode (pMgCode:longint):boolean;
    function LocGsName_ (pGsName_:Str30):boolean;
    function LocGaName_ (pGaName_:Str60):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocActQnt (pActQnt:double):boolean;
    function LocActVal (pActVal:double):boolean;
    function LocMinMax (pMinMax:Str1):boolean;
    function LocAvgPrice (pAvgPrice:double):boolean;
    function LocLastPrice (pLastPrice:double):boolean;
    function LocLastIDate (pLastIDate:TDatetime):boolean;
    function LocLastODate (pLastODate:TDatetime):boolean;
    function LocOsdQnt (pOsdQnt:double):boolean;
    function LocOsdCode (pOsdCode:Str15):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property GsCode:longint read GetGsCode write SetGsCode;
    property MgCode:longint read GetMgCode write SetMgCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property GsName_:Str30 read GetGsName_ write SetGsName_;
    property GaName:Str60 read GetGaName write SetGaName;
    property GaName_:Str60 read GetGaName_ write SetGaName_;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property MsName:Str10 read GetMsName write SetMsName;
    property VatPrc:double read GetVatPrc write SetVatPrc;
    property GsType:Str1 read GetGsType write SetGsType;
    property DrbMust:boolean read GetDrbMust write SetDrbMust;
    property DrbDay:word read GetDrbDay write SetDrbDay;
    property PdnMust:boolean read GetPdnMust write SetPdnMust;
    property GrcMth:word read GetGrcMth write SetGrcMth;
    property BegQnt:double read GetBegQnt write SetBegQnt;
    property InQnt:double read GetInQnt write SetInQnt;
    property PrvOut:double read GetPrvOut write SetPrvOut;
    property OutQnt:double read GetOutQnt write SetOutQnt;
    property ActQnt:double read GetActQnt write SetActQnt;
    property BegAcq:double read GetBegAcq write SetBegAcq;
    property InAcq:double read GetInAcq write SetInAcq;
    property OutAcq:double read GetOutAcq write SetOutAcq;
    property ActAcq:double read GetActAcq write SetActAcq;
    property BegAcv:double read GetBegAcv write SetBegAcv;
    property InAcv:double read GetInAcv write SetInAcv;
    property OutAcv:double read GetOutAcv write SetOutAcv;
    property ActAcv:double read GetActAcv write SetActAcv;
    property SalQnt:double read GetSalQnt write SetSalQnt;
    property NrsQnt:double read GetNrsQnt write SetNrsQnt;
    property OcdQnt:double read GetOcdQnt write SetOcdQnt;
    property FreQnt:double read GetFreQnt write SetFreQnt;
    property OsdQnt:double read GetOsdQnt write SetOsdQnt;
    property OsrQnt:double read GetOsrQnt write SetOsrQnt;
    property FroQnt:double read GetFroQnt write SetFroQnt;
    property NsuQnt:double read GetNsuQnt write SetNsuQnt;
    property BegVal:double read GetBegVal write SetBegVal;
    property InVal:double read GetInVal write SetInVal;
    property OutVal:double read GetOutVal write SetOutVal;
    property ActVal:double read GetActVal write SetActVal;
    property AvgPrice:double read GetAvgPrice write SetAvgPrice;
    property LastPrice:double read GetLastPrice write SetLastPrice;
    property ActPrice:double read GetActPrice write SetActPrice;
    property MinOsq:double read GetMinOsq write SetMinOsq;
    property MaxQnt:double read GetMaxQnt write SetMaxQnt;
    property MinQnt:double read GetMinQnt write SetMinQnt;
    property OptQnt:double read GetOptQnt write SetOptQnt;
    property DifQnt:double read GetDifQnt write SetDifQnt;
    property MinMax:Str1 read GetMinMax write SetMinMax;
    property InvDate:TDatetime read GetInvDate write SetInvDate;
    property LastIDate:TDatetime read GetLastIDate write SetLastIDate;
    property LastODate:TDatetime read GetLastODate write SetLastODate;
    property LastIQnt:double read GetLastIQnt write SetLastIQnt;
    property LastOQnt:double read GetLastOQnt write SetLastOQnt;
    property ActSnQnt:longint read GetActSnQnt write SetActSnQnt;
    property Profit:double read GetProfit write SetProfit;
    property BPrice:double read GetBPrice write SetBPrice;
    property Sended:boolean read GetSended write SetSended;
    property Action:Str1 read GetAction write SetAction;
    property DisFlag:boolean read GetDisFlag write SetDisFlag;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
    property DifOsd:double read GetDifOsd write SetDifOsd;
    property DifOcd:double read GetDifOcd write SetDifOcd;
    property DifNrs:double read GetDifNrs write SetDifNrs;
    property ASaQnt:double read GetASaQnt write SetASaQnt;
    property AOuQnt:double read GetAOuQnt write SetAOuQnt;
    property PSaQnt:double read GetPSaQnt write SetPSaQnt;
    property POuQnt:double read GetPOuQnt write SetPOuQnt;
    property SsoQnt:double read GetSsoQnt write SetSsoQnt;
    property ImrQnt:double read GetImrQnt write SetImrQnt;
    property OsdCode:Str15 read GetOsdCode write SetOsdCode;
    property OfrQnt:double read GetOfrQnt write SetOfrQnt;
  end;

implementation

constructor TStkTmp.Create;
begin
  oTmpTable:=TmpInit ('STK',Self);
end;

destructor TStkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TStkTmp.GetMgCode:longint;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TStkTmp.SetMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TStkTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStkTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TStkTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStkTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TStkTmp.GetGaName:Str60;
begin
  Result:=oTmpTable.FieldByName('GaName').AsString;
end;

procedure TStkTmp.SetGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString:=pValue;
end;

function TStkTmp.GetGaName_:Str60;
begin
  Result:=oTmpTable.FieldByName('GaName_').AsString;
end;

procedure TStkTmp.SetGaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName_').AsString:=pValue;
end;

function TStkTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStkTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TStkTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TStkTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TStkTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStkTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TStkTmp.GetVatPrc:double;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TStkTmp.SetVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat:=pValue;
end;

function TStkTmp.GetGsType:Str1;
begin
  Result:=oTmpTable.FieldByName('GsType').AsString;
end;

procedure TStkTmp.SetGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString:=pValue;
end;

function TStkTmp.GetDrbMust:boolean;
begin
  Result:=ByteToBool(oTmpTable.FieldByName('DrbMust').AsInteger);
end;

procedure TStkTmp.SetDrbMust(pValue:boolean);
begin
  oTmpTable.FieldByName('DrbMust').AsInteger:=BoolToByte(pValue);
end;

function TStkTmp.GetDrbDay:word;
begin
  Result:=oTmpTable.FieldByName('DrbDay').AsInteger;
end;

procedure TStkTmp.SetDrbDay(pValue:word);
begin
  oTmpTable.FieldByName('DrbDay').AsInteger:=pValue;
end;

function TStkTmp.GetPdnMust:boolean;
begin
  Result:=ByteToBool(oTmpTable.FieldByName('PdnMust').AsInteger);
end;

procedure TStkTmp.SetPdnMust(pValue:boolean);
begin
  oTmpTable.FieldByName('PdnMust').AsInteger:=BoolToByte(pValue);
end;

function TStkTmp.GetGrcMth:word;
begin
  Result:=oTmpTable.FieldByName('GrcMth').AsInteger;
end;

procedure TStkTmp.SetGrcMth(pValue:word);
begin
  oTmpTable.FieldByName('GrcMth').AsInteger:=pValue;
end;

function TStkTmp.GetBegQnt:double;
begin
  Result:=oTmpTable.FieldByName('BegQnt').AsFloat;
end;

procedure TStkTmp.SetBegQnt(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt').AsFloat:=pValue;
end;

function TStkTmp.GetInQnt:double;
begin
  Result:=oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TStkTmp.SetInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat:=pValue;
end;

function TStkTmp.GetPrvOut:double;
begin
  Result:=oTmpTable.FieldByName('PrvOut').AsFloat;
end;

procedure TStkTmp.SetPrvOut(pValue:double);
begin
  oTmpTable.FieldByName('PrvOut').AsFloat:=pValue;
end;

function TStkTmp.GetOutQnt:double;
begin
  Result:=oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TStkTmp.SetOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat:=pValue;
end;

function TStkTmp.GetActQnt:double;
begin
  Result:=oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStkTmp.SetActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat:=pValue;
end;

function TStkTmp.GetBegAcq:double;
begin
  Result:=oTmpTable.FieldByName('BegAcq').AsFloat;
end;

procedure TStkTmp.SetBegAcq(pValue:double);
begin
  oTmpTable.FieldByName('BegAcq').AsFloat:=pValue;
end;

function TStkTmp.GetInAcq:double;
begin
  Result:=oTmpTable.FieldByName('InAcq').AsFloat;
end;

procedure TStkTmp.SetInAcq(pValue:double);
begin
  oTmpTable.FieldByName('InAcq').AsFloat:=pValue;
end;

function TStkTmp.GetOutAcq:double;
begin
  Result:=oTmpTable.FieldByName('OutAcq').AsFloat;
end;

procedure TStkTmp.SetOutAcq(pValue:double);
begin
  oTmpTable.FieldByName('OutAcq').AsFloat:=pValue;
end;

function TStkTmp.GetActAcq:double;
begin
  Result:=oTmpTable.FieldByName('ActAcq').AsFloat;
end;

procedure TStkTmp.SetActAcq(pValue:double);
begin
  oTmpTable.FieldByName('ActAcq').AsFloat:=pValue;
end;

function TStkTmp.GetBegAcv:double;
begin
  Result:=oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TStkTmp.SetBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat:=pValue;
end;

function TStkTmp.GetInAcv:double;
begin
  Result:=oTmpTable.FieldByName('InAcv').AsFloat;
end;

procedure TStkTmp.SetInAcv(pValue:double);
begin
  oTmpTable.FieldByName('InAcv').AsFloat:=pValue;
end;

function TStkTmp.GetOutAcv:double;
begin
  Result:=oTmpTable.FieldByName('OutAcv').AsFloat;
end;

procedure TStkTmp.SetOutAcv(pValue:double);
begin
  oTmpTable.FieldByName('OutAcv').AsFloat:=pValue;
end;

function TStkTmp.GetActAcv:double;
begin
  Result:=oTmpTable.FieldByName('ActAcv').AsFloat;
end;

procedure TStkTmp.SetActAcv(pValue:double);
begin
  oTmpTable.FieldByName('ActAcv').AsFloat:=pValue;
end;

function TStkTmp.GetSalQnt:double;
begin
  Result:=oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStkTmp.SetSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat:=pValue;
end;

function TStkTmp.GetNrsQnt:double;
begin
  Result:=oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStkTmp.SetNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat:=pValue;
end;

function TStkTmp.GetOcdQnt:double;
begin
  Result:=oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TStkTmp.SetOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat:=pValue;
end;

function TStkTmp.GetFreQnt:double;
begin
  Result:=oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TStkTmp.SetFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat:=pValue;
end;

function TStkTmp.GetOsdQnt:double;
begin
  Result:=oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TStkTmp.SetOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat:=pValue;
end;

function TStkTmp.GetOsrQnt:double;
begin
  Result:=oTmpTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TStkTmp.SetOsrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsrQnt').AsFloat:=pValue;
end;

function TStkTmp.GetFroQnt:double;
begin
  Result:=oTmpTable.FieldByName('FroQnt').AsFloat;
end;

procedure TStkTmp.SetFroQnt(pValue:double);
begin
  oTmpTable.FieldByName('FroQnt').AsFloat:=pValue;
end;

function TStkTmp.GetNsuQnt:double;
begin
  Result:=oTmpTable.FieldByName('NsuQnt').AsFloat;
end;

procedure TStkTmp.SetNsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsuQnt').AsFloat:=pValue;
end;

function TStkTmp.GetBegVal:double;
begin
  Result:=oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TStkTmp.SetBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat:=pValue;
end;

function TStkTmp.GetInVal:double;
begin
  Result:=oTmpTable.FieldByName('InVal').AsFloat;
end;

procedure TStkTmp.SetInVal(pValue:double);
begin
  oTmpTable.FieldByName('InVal').AsFloat:=pValue;
end;

function TStkTmp.GetOutVal:double;
begin
  Result:=oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TStkTmp.SetOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat:=pValue;
end;

function TStkTmp.GetActVal:double;
begin
  Result:=oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TStkTmp.SetActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat:=pValue;
end;

function TStkTmp.GetAvgPrice:double;
begin
  Result:=oTmpTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TStkTmp.SetAvgPrice(pValue:double);
begin
  oTmpTable.FieldByName('AvgPrice').AsFloat:=pValue;
end;

function TStkTmp.GetLastPrice:double;
begin
  Result:=oTmpTable.FieldByName('LastPrice').AsFloat;
end;

procedure TStkTmp.SetLastPrice(pValue:double);
begin
  oTmpTable.FieldByName('LastPrice').AsFloat:=pValue;
end;

function TStkTmp.GetActPrice:double;
begin
  Result:=oTmpTable.FieldByName('ActPrice').AsFloat;
end;

procedure TStkTmp.SetActPrice(pValue:double);
begin
  oTmpTable.FieldByName('ActPrice').AsFloat:=pValue;
end;

function TStkTmp.GetMinOsq:double;
begin
  Result:=oTmpTable.FieldByName('MinOsq').AsFloat;
end;

procedure TStkTmp.SetMinOsq(pValue:double);
begin
  oTmpTable.FieldByName('MinOsq').AsFloat:=pValue;
end;

function TStkTmp.GetMaxQnt:double;
begin
  Result:=oTmpTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TStkTmp.SetMaxQnt(pValue:double);
begin
  oTmpTable.FieldByName('MaxQnt').AsFloat:=pValue;
end;

function TStkTmp.GetMinQnt:double;
begin
  Result:=oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TStkTmp.SetMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat:=pValue;
end;

function TStkTmp.GetOptQnt:double;
begin
  Result:=oTmpTable.FieldByName('OptQnt').AsFloat;
end;

procedure TStkTmp.SetOptQnt(pValue:double);
begin
  oTmpTable.FieldByName('OptQnt').AsFloat:=pValue;
end;

function TStkTmp.GetDifQnt:double;
begin
  Result:=oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStkTmp.SetDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat:=pValue;
end;

function TStkTmp.GetMinMax:Str1;
begin
  Result:=oTmpTable.FieldByName('MinMax').AsString;
end;

procedure TStkTmp.SetMinMax(pValue:Str1);
begin
  oTmpTable.FieldByName('MinMax').AsString:=pValue;
end;

function TStkTmp.GetInvDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('InvDate').AsDateTime;
end;

procedure TStkTmp.SetInvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InvDate').AsDateTime:=pValue;
end;

function TStkTmp.GetLastIDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('LastIDate').AsDateTime;
end;

procedure TStkTmp.SetLastIDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastIDate').AsDateTime:=pValue;
end;

function TStkTmp.GetLastODate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('LastODate').AsDateTime;
end;

procedure TStkTmp.SetLastODate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastODate').AsDateTime:=pValue;
end;

function TStkTmp.GetLastIQnt:double;
begin
  Result:=oTmpTable.FieldByName('LastIQnt').AsFloat;
end;

procedure TStkTmp.SetLastIQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastIQnt').AsFloat:=pValue;
end;

function TStkTmp.GetLastOQnt:double;
begin
  Result:=oTmpTable.FieldByName('LastOQnt').AsFloat;
end;

procedure TStkTmp.SetLastOQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastOQnt').AsFloat:=pValue;
end;

function TStkTmp.GetActSnQnt:longint;
begin
  Result:=oTmpTable.FieldByName('ActSnQnt').AsInteger;
end;

procedure TStkTmp.SetActSnQnt(pValue:longint);
begin
  oTmpTable.FieldByName('ActSnQnt').AsInteger:=pValue;
end;

function TStkTmp.GetProfit:double;
begin
  Result:=oTmpTable.FieldByName('Profit').AsFloat;
end;

procedure TStkTmp.SetProfit(pValue:double);
begin
  oTmpTable.FieldByName('Profit').AsFloat:=pValue;
end;

function TStkTmp.GetBPrice:double;
begin
  Result:=oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TStkTmp.SetBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat:=pValue;
end;

function TStkTmp.GetSended:boolean;
begin
  Result:=ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TStkTmp.SetSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger:=BoolToByte(pValue);
end;

function TStkTmp.GetAction:Str1;
begin
  Result:=oTmpTable.FieldByName('Action').AsString;
end;

procedure TStkTmp.SetAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString:=pValue;
end;

function TStkTmp.GetDisFlag:boolean;
begin
  Result:=ByteToBool(oTmpTable.FieldByName('DisFlag').AsInteger);
end;

procedure TStkTmp.SetDisFlag(pValue:boolean);
begin
  oTmpTable.FieldByName('DisFlag').AsInteger:=BoolToByte(pValue);
end;

function TStkTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TStkTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TStkTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStkTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TStkTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStkTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TStkTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

function TStkTmp.GetDifOsd:double;
begin
  Result:=oTmpTable.FieldByName('DifOsd').AsFloat;
end;

procedure TStkTmp.SetDifOsd(pValue:double);
begin
  oTmpTable.FieldByName('DifOsd').AsFloat:=pValue;
end;

function TStkTmp.GetDifOcd:double;
begin
  Result:=oTmpTable.FieldByName('DifOcd').AsFloat;
end;

procedure TStkTmp.SetDifOcd(pValue:double);
begin
  oTmpTable.FieldByName('DifOcd').AsFloat:=pValue;
end;

function TStkTmp.GetDifNrs:double;
begin
  Result:=oTmpTable.FieldByName('DifNrs').AsFloat;
end;

procedure TStkTmp.SetDifNrs(pValue:double);
begin
  oTmpTable.FieldByName('DifNrs').AsFloat:=pValue;
end;

function TStkTmp.GetASaQnt:double;
begin
  Result:=oTmpTable.FieldByName('ASaQnt').AsFloat;
end;

procedure TStkTmp.SetASaQnt(pValue:double);
begin
  oTmpTable.FieldByName('ASaQnt').AsFloat:=pValue;
end;

function TStkTmp.GetAOuQnt:double;
begin
  Result:=oTmpTable.FieldByName('AOuQnt').AsFloat;
end;

procedure TStkTmp.SetAOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('AOuQnt').AsFloat:=pValue;
end;

function TStkTmp.GetPSaQnt:double;
begin
  Result:=oTmpTable.FieldByName('PSaQnt').AsFloat;
end;

procedure TStkTmp.SetPSaQnt(pValue:double);
begin
  oTmpTable.FieldByName('PSaQnt').AsFloat:=pValue;
end;

function TStkTmp.GetPOuQnt:double;
begin
  Result:=oTmpTable.FieldByName('POuQnt').AsFloat;
end;

procedure TStkTmp.SetPOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('POuQnt').AsFloat:=pValue;
end;

function TStkTmp.GetSsoQnt:double;
begin
  Result:=oTmpTable.FieldByName('SsoQnt').AsFloat;
end;

procedure TStkTmp.SetSsoQnt(pValue:double);
begin
  oTmpTable.FieldByName('SsoQnt').AsFloat:=pValue;
end;

function TStkTmp.GetImrQnt:double;
begin
  Result:=oTmpTable.FieldByName('ImrQnt').AsFloat;
end;

procedure TStkTmp.SetImrQnt(pValue:double);
begin
  oTmpTable.FieldByName('ImrQnt').AsFloat:=pValue;
end;

function TStkTmp.GetOsdCode:Str15;
begin
  Result:=oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TStkTmp.SetOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString:=pValue;
end;

function TStkTmp.GetOfrQnt:double;
begin
  Result:=oTmpTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TStkTmp.SetOfrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OfrQnt').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TStkTmp.LocMgCode(pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result:=oTmpTable.FindKey([pMgCode]);
end;

function TStkTmp.LocGsName_(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TStkTmp.LocGaName_(pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName_);
  Result:=oTmpTable.FindKey([pGaName_]);
end;

function TStkTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TStkTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TStkTmp.LocActQnt(pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result:=oTmpTable.FindKey([pActQnt]);
end;

function TStkTmp.LocActVal(pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result:=oTmpTable.FindKey([pActVal]);
end;

function TStkTmp.LocMinMax(pMinMax:Str1):boolean;
begin
  SetIndex (ixMinMax);
  Result:=oTmpTable.FindKey([pMinMax]);
end;

function TStkTmp.LocAvgPrice(pAvgPrice:double):boolean;
begin
  SetIndex (ixAvgPrice);
  Result:=oTmpTable.FindKey([pAvgPrice]);
end;

function TStkTmp.LocLastPrice(pLastPrice:double):boolean;
begin
  SetIndex (ixLastPrice);
  Result:=oTmpTable.FindKey([pLastPrice]);
end;

function TStkTmp.LocLastIDate(pLastIDate:TDatetime):boolean;
begin
  SetIndex (ixLastIDate);
  Result:=oTmpTable.FindKey([pLastIDate]);
end;

function TStkTmp.LocLastODate(pLastODate:TDatetime):boolean;
begin
  SetIndex (ixLastODate);
  Result:=oTmpTable.FindKey([pLastODate]);
end;

function TStkTmp.LocOsdQnt(pOsdQnt:double):boolean;
begin
  SetIndex (ixOsdQnt);
  Result:=oTmpTable.FindKey([pOsdQnt]);
end;

function TStkTmp.LocOsdCode(pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result:=oTmpTable.FindKey([pOsdCode]);
end;

procedure TStkTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
