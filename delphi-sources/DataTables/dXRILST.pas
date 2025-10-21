unit dXRILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDySnPn='DySnPn';
  ixDySn='DySn';
  ixProNum='ProNum';
  ixProCod='ProCod';
  ixProNam='ProNam';
  ixPgrNum='PgrNum';

type
  TXrilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProCod:Str15;            procedure SetProCod(pValue:Str15);
    function GetProNam:Str30;            procedure SetProNam(pValue:Str30);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetSalBva:double;           procedure SetSalBva(pValue:double);
    function GetSalStq:double;           procedure SetSalStq(pValue:double);
    function GetSalCmq:double;           procedure SetSalCmq(pValue:double);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetStkCva:double;           procedure SetStkCva(pValue:double);
    function GetStkStq:double;           procedure SetStkStq(pValue:double);
    function GetStkCmq:double;           procedure SetStkCmq(pValue:double);
    function GetStkPrq:double;           procedure SetStkPrq(pValue:double);
    function GetOsdCva:double;           procedure SetOsdCva(pValue:double);
    function GetOsdPrq:double;           procedure SetOsdPrq(pValue:double);
    function GetItmQnt:longint;          procedure SetItmQnt(pValue:longint);
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
    function LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function LocDySn(pDocYer:Str2;pSerNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProCod(pProCod:Str15):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocPgrNum(pPgrNum:word):boolean;
    function NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:word):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProCod(pProCod:Str15):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearPgrNum(pPgrNum:word):boolean;

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
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:word read GetSerNum write SetSerNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProCod:Str15 read GetProCod write SetProCod;
    property ProNam:Str30 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property SalBva:double read GetSalBva write SetSalBva;
    property SalStq:double read GetSalStq write SetSalStq;
    property SalCmq:double read GetSalCmq write SetSalCmq;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property StkCva:double read GetStkCva write SetStkCva;
    property StkStq:double read GetStkStq write SetStkStq;
    property StkCmq:double read GetStkCmq write SetStkCmq;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property OsdCva:double read GetOsdCva write SetOsdCva;
    property OsdPrq:double read GetOsdPrq write SetOsdPrq;
    property ItmQnt:longint read GetItmQnt write SetItmQnt;
  end;

implementation

constructor TXrilstDat.Create;
begin
  oTable:=DatInit('XRILST',gPath.StkPath,Self);
end;

constructor TXrilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('XRILST',pPath,Self);
end;

destructor TXrilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TXrilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TXrilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TXrilstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TXrilstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TXrilstDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TXrilstDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TXrilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TXrilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXrilstDat.GetProCod:Str15;
begin
  Result:=oTable.FieldByName('ProCod').AsString;
end;

procedure TXrilstDat.SetProCod(pValue:Str15);
begin
  oTable.FieldByName('ProCod').AsString:=pValue;
end;

function TXrilstDat.GetProNam:Str30;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TXrilstDat.SetProNam(pValue:Str30);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TXrilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TXrilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TXrilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TXrilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TXrilstDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TXrilstDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TXrilstDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TXrilstDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TXrilstDat.GetSalStq:double;
begin
  Result:=oTable.FieldByName('SalStq').AsFloat;
end;

procedure TXrilstDat.SetSalStq(pValue:double);
begin
  oTable.FieldByName('SalStq').AsFloat:=pValue;
end;

function TXrilstDat.GetSalCmq:double;
begin
  Result:=oTable.FieldByName('SalCmq').AsFloat;
end;

procedure TXrilstDat.SetSalCmq(pValue:double);
begin
  oTable.FieldByName('SalCmq').AsFloat:=pValue;
end;

function TXrilstDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TXrilstDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TXrilstDat.GetStkCva:double;
begin
  Result:=oTable.FieldByName('StkCva').AsFloat;
end;

procedure TXrilstDat.SetStkCva(pValue:double);
begin
  oTable.FieldByName('StkCva').AsFloat:=pValue;
end;

function TXrilstDat.GetStkStq:double;
begin
  Result:=oTable.FieldByName('StkStq').AsFloat;
end;

procedure TXrilstDat.SetStkStq(pValue:double);
begin
  oTable.FieldByName('StkStq').AsFloat:=pValue;
end;

function TXrilstDat.GetStkCmq:double;
begin
  Result:=oTable.FieldByName('StkCmq').AsFloat;
end;

procedure TXrilstDat.SetStkCmq(pValue:double);
begin
  oTable.FieldByName('StkCmq').AsFloat:=pValue;
end;

function TXrilstDat.GetStkPrq:double;
begin
  Result:=oTable.FieldByName('StkPrq').AsFloat;
end;

procedure TXrilstDat.SetStkPrq(pValue:double);
begin
  oTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TXrilstDat.GetOsdCva:double;
begin
  Result:=oTable.FieldByName('OsdCva').AsFloat;
end;

procedure TXrilstDat.SetOsdCva(pValue:double);
begin
  oTable.FieldByName('OsdCva').AsFloat:=pValue;
end;

function TXrilstDat.GetOsdPrq:double;
begin
  Result:=oTable.FieldByName('OsdPrq').AsFloat;
end;

procedure TXrilstDat.SetOsdPrq(pValue:double);
begin
  oTable.FieldByName('OsdPrq').AsFloat:=pValue;
end;

function TXrilstDat.GetItmQnt:longint;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TXrilstDat.SetItmQnt(pValue:longint);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TXrilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TXrilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TXrilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TXrilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TXrilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TXrilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TXrilstDat.LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindKey([pDocYer,pSerNum,pProNum]);
end;

function TXrilstDat.LocDySn(pDocYer:Str2;pSerNum:word):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TXrilstDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TXrilstDat.LocProCod(pProCod:Str15):boolean;
begin
  SetIndex(ixProCod);
  Result:=oTable.FindKey([pProCod]);
end;

function TXrilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TXrilstDat.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindKey([pPgrNum]);
end;

function TXrilstDat.NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindNearest([pDocYer,pSerNum,pProNum]);
end;

function TXrilstDat.NearDySn(pDocYer:Str2;pSerNum:word):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TXrilstDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TXrilstDat.NearProCod(pProCod:Str15):boolean;
begin
  SetIndex(ixProCod);
  Result:=oTable.FindNearest([pProCod]);
end;

function TXrilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TXrilstDat.NearPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindNearest([pPgrNum]);
end;

procedure TXrilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TXrilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TXrilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TXrilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TXrilstDat.Next;
begin
  oTable.Next;
end;

procedure TXrilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TXrilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TXrilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TXrilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TXrilstDat.Post;
begin
  oTable.Post;
end;

procedure TXrilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TXrilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TXrilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TXrilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TXrilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TXrilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TXrilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
