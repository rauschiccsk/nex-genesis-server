unit tOSGITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaPn='';
  ixProNum='ProNum';
  ixParNum='ParNum';
  ixPgrNum='PgrNum';
  ixProNam_='ProNam_';
  ixOrdCod='OrdCod';
  ixBarCod='BarCod';

type
  TOsgitmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetCctVat:byte;             procedure SetCctVat (pValue:byte);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetFrePrq:double;           procedure SetFrePrq (pValue:double);
    function GetMinPrq:double;           procedure SetMinPrq (pValue:double);
    function GetOptPrq:double;           procedure SetOptPrq (pValue:double);
    function GetStkPrq:double;           procedure SetStkPrq (pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq (pValue:double);
    function GetMosPrq:double;           procedure SetMosPrq (pValue:double);
    function GetPckPrq:double;           procedure SetPckPrq (pValue:double);
    function GetRcmPrq:double;           procedure SetRcmPrq (pValue:double);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetOrdPck:Str1;             procedure SetOrdPck (pValue:Str1);
    function GetRatDay:word;             procedure SetRatDay (pValue:word);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot (pValue:Str50);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPaPn (pParNum:longint;pProNum:longint):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocOrdCod (pOrdCod:Str30):boolean;
    function LocBarCod (pBarCod:Str15):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property StkNum:word read GetStkNum write SetStkNum;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property CctVat:byte read GetCctVat write SetCctVat;
    property ActPrq:double read GetActPrq write SetActPrq;
    property FrePrq:double read GetFrePrq write SetFrePrq;
    property MinPrq:double read GetMinPrq write SetMinPrq;
    property OptPrq:double read GetOptPrq write SetOptPrq;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property ReqPrq:double read GetReqPrq write SetReqPrq;
    property MosPrq:double read GetMosPrq write SetMosPrq;
    property PckPrq:double read GetPckPrq write SetPckPrq;
    property RcmPrq:double read GetRcmPrq write SetRcmPrq;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property OrdApc:double read GetOrdApc write SetOrdApc;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property OrdPck:Str1 read GetOrdPck write SetOrdPck;
    property RatDay:word read GetRatDay write SetRatDay;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property SalApc:double read GetSalApc write SetSalApc;
  end;

implementation

constructor TOsgitmTmp.Create;
begin
  oTmpTable:=TmpInit ('OSGITM',Self);
end;

destructor TOsgitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsgitmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsgitmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsgitmTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsgitmTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsgitmTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsgitmTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsgitmTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOsgitmTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsgitmTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsgitmTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsgitmTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOsgitmTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsgitmTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsgitmTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsgitmTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsgitmTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsgitmTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsgitmTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsgitmTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOsgitmTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsgitmTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOsgitmTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsgitmTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsgitmTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsgitmTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsgitmTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsgitmTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsgitmTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsgitmTmp.GetCctVat:byte;
begin
  Result:=oTmpTable.FieldByName('CctVat').AsInteger;
end;

procedure TOsgitmTmp.SetCctVat(pValue:byte);
begin
  oTmpTable.FieldByName('CctVat').AsInteger:=pValue;
end;

function TOsgitmTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TOsgitmTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetFrePrq:double;
begin
  Result:=oTmpTable.FieldByName('FrePrq').AsFloat;
end;

procedure TOsgitmTmp.SetFrePrq(pValue:double);
begin
  oTmpTable.FieldByName('FrePrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetMinPrq:double;
begin
  Result:=oTmpTable.FieldByName('MinPrq').AsFloat;
end;

procedure TOsgitmTmp.SetMinPrq(pValue:double);
begin
  oTmpTable.FieldByName('MinPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOptPrq:double;
begin
  Result:=oTmpTable.FieldByName('OptPrq').AsFloat;
end;

procedure TOsgitmTmp.SetOptPrq(pValue:double);
begin
  oTmpTable.FieldByName('OptPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetStkPrq:double;
begin
  Result:=oTmpTable.FieldByName('StkPrq').AsFloat;
end;

procedure TOsgitmTmp.SetStkPrq(pValue:double);
begin
  oTmpTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetReqPrq:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOsgitmTmp.SetReqPrq(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetMosPrq:double;
begin
  Result:=oTmpTable.FieldByName('MosPrq').AsFloat;
end;

procedure TOsgitmTmp.SetMosPrq(pValue:double);
begin
  oTmpTable.FieldByName('MosPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetPckPrq:double;
begin
  Result:=oTmpTable.FieldByName('PckPrq').AsFloat;
end;

procedure TOsgitmTmp.SetPckPrq(pValue:double);
begin
  oTmpTable.FieldByName('PckPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetRcmPrq:double;
begin
  Result:=oTmpTable.FieldByName('RcmPrq').AsFloat;
end;

procedure TOsgitmTmp.SetRcmPrq(pValue:double);
begin
  oTmpTable.FieldByName('RcmPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsgitmTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOrdApc:double;
begin
  Result:=oTmpTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsgitmTmp.SetOrdApc(pValue:double);
begin
  oTmpTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsgitmTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsgitmTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsgitmTmp.GetOrdPck:Str1;
begin
  Result:=oTmpTable.FieldByName('OrdPck').AsString;
end;

procedure TOsgitmTmp.SetOrdPck(pValue:Str1);
begin
  oTmpTable.FieldByName('OrdPck').AsString:=pValue;
end;

function TOsgitmTmp.GetRatDay:word;
begin
  Result:=oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsgitmTmp.SetRatDay(pValue:word);
begin
  oTmpTable.FieldByName('RatDay').AsInteger:=pValue;
end;

function TOsgitmTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsgitmTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOsgitmTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TOsgitmTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOsgitmTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TOsgitmTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsgitmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsgitmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsgitmTmp.LocPaPn(pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex (ixPaPn);
  Result:=oTmpTable.FindKey([pParNum,pProNum]);
end;

function TOsgitmTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOsgitmTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TOsgitmTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TOsgitmTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TOsgitmTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

function TOsgitmTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

procedure TOsgitmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsgitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsgitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsgitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsgitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsgitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsgitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsgitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsgitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsgitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsgitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsgitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsgitmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsgitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsgitmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsgitmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsgitmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
