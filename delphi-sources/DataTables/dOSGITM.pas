unit dOSGITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixProNum='ProNum';
  ixProNam='ProNam';

type
  TOsgitmDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetMinPrq:double;           procedure SetMinPrq(pValue:double);
    function GetPckPrq:double;           procedure SetPckPrq(pValue:double);
    function GetOptPrq:double;           procedure SetOptPrq(pValue:double);
    function GetStkPrq:double;           procedure SetStkPrq(pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq(pValue:double);
    function GetSysPrq:double;           procedure SetSysPrq(pValue:double);
    function GetMinOsq:double;           procedure SetMinOsq(pValue:double);
    function GetOrdPrq:double;           procedure SetOrdPrq(pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc(pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva(pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva(pValue:double);
    function GetRatDay:word;             procedure SetRatDay(pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocParNum(pParNum:longint):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property StkNum:word read GetStkNum write SetStkNum;
    property ActPrq:double read GetActPrq write SetActPrq;
    property MinPrq:double read GetMinPrq write SetMinPrq;
    property PckPrq:double read GetPckPrq write SetPckPrq;
    property OptPrq:double read GetOptPrq write SetOptPrq;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property ReqPrq:double read GetReqPrq write SetReqPrq;
    property SysPrq:double read GetSysPrq write SetSysPrq;
    property MinOsq:double read GetMinOsq write SetMinOsq;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property OrdApc:double read GetOrdApc write SetOrdApc;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property RatDay:word read GetRatDay write SetRatDay;
  end;

implementation

constructor TOsgitmDat.Create;
begin
  oTable:=DatInit('OSGITM',gPath.StkPath,Self);
end;

constructor TOsgitmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSGITM',pPath,Self);
end;

destructor TOsgitmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsgitmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsgitmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsgitmDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsgitmDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsgitmDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOsgitmDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsgitmDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsgitmDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsgitmDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOsgitmDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsgitmDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOsgitmDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsgitmDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsgitmDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsgitmDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsgitmDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsgitmDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TOsgitmDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsgitmDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TOsgitmDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsgitmDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TOsgitmDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsgitmDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TOsgitmDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsgitmDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsgitmDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsgitmDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TOsgitmDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetMinPrq:double;
begin
  Result:=oTable.FieldByName('MinPrq').AsFloat;
end;

procedure TOsgitmDat.SetMinPrq(pValue:double);
begin
  oTable.FieldByName('MinPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetPckPrq:double;
begin
  Result:=oTable.FieldByName('PckPrq').AsFloat;
end;

procedure TOsgitmDat.SetPckPrq(pValue:double);
begin
  oTable.FieldByName('PckPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetOptPrq:double;
begin
  Result:=oTable.FieldByName('OptPrq').AsFloat;
end;

procedure TOsgitmDat.SetOptPrq(pValue:double);
begin
  oTable.FieldByName('OptPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetStkPrq:double;
begin
  Result:=oTable.FieldByName('StkPrq').AsFloat;
end;

procedure TOsgitmDat.SetStkPrq(pValue:double);
begin
  oTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetReqPrq:double;
begin
  Result:=oTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOsgitmDat.SetReqPrq(pValue:double);
begin
  oTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetSysPrq:double;
begin
  Result:=oTable.FieldByName('SysPrq').AsFloat;
end;

procedure TOsgitmDat.SetSysPrq(pValue:double);
begin
  oTable.FieldByName('SysPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetMinOsq:double;
begin
  Result:=oTable.FieldByName('MinOsq').AsFloat;
end;

procedure TOsgitmDat.SetMinOsq(pValue:double);
begin
  oTable.FieldByName('MinOsq').AsFloat:=pValue;
end;

function TOsgitmDat.GetOrdPrq:double;
begin
  Result:=oTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsgitmDat.SetOrdPrq(pValue:double);
begin
  oTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsgitmDat.GetOrdApc:double;
begin
  Result:=oTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsgitmDat.SetOrdApc(pValue:double);
begin
  oTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsgitmDat.GetOrdAva:double;
begin
  Result:=oTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsgitmDat.SetOrdAva(pValue:double);
begin
  oTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsgitmDat.GetOrdBva:double;
begin
  Result:=oTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsgitmDat.SetOrdBva(pValue:double);
begin
  oTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsgitmDat.GetRatDay:word;
begin
  Result:=oTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsgitmDat.SetRatDay(pValue:word);
begin
  oTable.FieldByName('RatDay').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsgitmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsgitmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsgitmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsgitmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsgitmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsgitmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsgitmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsgitmDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOsgitmDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TOsgitmDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TOsgitmDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOsgitmDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TOsgitmDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

procedure TOsgitmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsgitmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOsgitmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsgitmDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsgitmDat.Next;
begin
  oTable.Next;
end;

procedure TOsgitmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsgitmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsgitmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsgitmDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsgitmDat.Post;
begin
  oTable.Post;
end;

procedure TOsgitmDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsgitmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsgitmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsgitmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsgitmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsgitmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsgitmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
