unit tXRDSIT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='';
  ixProCod='ProCod';
  ixPgrNum='PgrNum';

type
  TXrdsitTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProCod:Str15;            procedure SetProCod (pValue:Str15);
    function GetProNam:Str30;            procedure SetProNam (pValue:Str30);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetStkCva:double;           procedure SetStkCva (pValue:double);
    function GetStkPrq:double;           procedure SetStkPrq (pValue:double);
    function GetOsdCva:double;           procedure SetOsdCva (pValue:double);
    function GetOsdPrq:double;           procedure SetOsdPrq (pValue:double);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProCod (pProCod:Str15):boolean;
    function LocPgrNum (pPgrNum:word):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property ProCod:Str15 read GetProCod write SetProCod;
    property ProNam:Str30 read GetProNam write SetProNam;
    property SalBva:double read GetSalBva write SetSalBva;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property StkCva:double read GetStkCva write SetStkCva;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property OsdCva:double read GetOsdCva write SetOsdCva;
    property OsdPrq:double read GetOsdPrq write SetOsdPrq;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property PgrNum:word read GetPgrNum write SetPgrNum;
  end;

implementation

constructor TXrdsitTmp.Create;
begin
  oTmpTable:=TmpInit ('XRDSIT',Self);
end;

destructor TXrdsitTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TXrdsitTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TXrdsitTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TXrdsitTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TXrdsitTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXrdsitTmp.GetProCod:Str15;
begin
  Result:=oTmpTable.FieldByName('ProCod').AsString;
end;

procedure TXrdsitTmp.SetProCod(pValue:Str15);
begin
  oTmpTable.FieldByName('ProCod').AsString:=pValue;
end;

function TXrdsitTmp.GetProNam:Str30;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TXrdsitTmp.SetProNam(pValue:Str30);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TXrdsitTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TXrdsitTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TXrdsitTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TXrdsitTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TXrdsitTmp.GetStkCva:double;
begin
  Result:=oTmpTable.FieldByName('StkCva').AsFloat;
end;

procedure TXrdsitTmp.SetStkCva(pValue:double);
begin
  oTmpTable.FieldByName('StkCva').AsFloat:=pValue;
end;

function TXrdsitTmp.GetStkPrq:double;
begin
  Result:=oTmpTable.FieldByName('StkPrq').AsFloat;
end;

procedure TXrdsitTmp.SetStkPrq(pValue:double);
begin
  oTmpTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TXrdsitTmp.GetOsdCva:double;
begin
  Result:=oTmpTable.FieldByName('OsdCva').AsFloat;
end;

procedure TXrdsitTmp.SetOsdCva(pValue:double);
begin
  oTmpTable.FieldByName('OsdCva').AsFloat:=pValue;
end;

function TXrdsitTmp.GetOsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OsdPrq').AsFloat;
end;

procedure TXrdsitTmp.SetOsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OsdPrq').AsFloat:=pValue;
end;

function TXrdsitTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TXrdsitTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TXrdsitTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TXrdsitTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrdsitTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TXrdsitTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TXrdsitTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TXrdsitTmp.LocProCod(pProCod:Str15):boolean;
begin
  SetIndex (ixProCod);
  Result:=oTmpTable.FindKey([pProCod]);
end;

function TXrdsitTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

procedure TXrdsitTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TXrdsitTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TXrdsitTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TXrdsitTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TXrdsitTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TXrdsitTmp.First;
begin
  oTmpTable.First;
end;

procedure TXrdsitTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TXrdsitTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TXrdsitTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TXrdsitTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TXrdsitTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TXrdsitTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TXrdsitTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TXrdsitTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TXrdsitTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TXrdsitTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TXrdsitTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2008001}
