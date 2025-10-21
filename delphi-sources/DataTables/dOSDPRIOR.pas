unit dOSDPRIOR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProductId='ProductId';
  ixProductPriority='ProductPriority';
  ixSupplier='Supplier';

type
  TOsdpriorDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetProductId:longint;       procedure SetProductId(pValue:longint);
    function GetPriority:byte;           procedure SetPriority(pValue:byte);
    function GetSupplier:longint;        procedure SetSupplier(pValue:longint);
    function GetQuantity:double;         procedure SetQuantity(pValue:double);
    function GetPrice:double;            procedure SetPrice(pValue:double);
    function GetDate:TDatetime;          procedure SetDate(pValue:TDatetime);
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
    function LocProductId(pProductId:longint):boolean;
    function LocProductPriority(pProductId:longint;pPriority:byte):boolean;
    function LocSupplier(pSupplier:longint):boolean;
    function NearProductId(pProductId:longint):boolean;
    function NearProductPriority(pProductId:longint;pPriority:byte):boolean;
    function NearSupplier(pSupplier:longint):boolean;

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
    property ProductId:longint read GetProductId write SetProductId;
    property Priority:byte read GetPriority write SetPriority;
    property Supplier:longint read GetSupplier write SetSupplier;
    property Quantity:double read GetQuantity write SetQuantity;
    property Price:double read GetPrice write SetPrice;
    property Date:TDatetime read GetDate write SetDate;
  end;

implementation

constructor TOsdpriorDat.Create;
begin
  oTable:=DatInit('OSDPRIOR',gPath.StkPath,Self);
end;

constructor TOsdpriorDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSDPRIOR',pPath,Self);
end;

destructor TOsdpriorDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsdpriorDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsdpriorDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsdpriorDat.GetProductId:longint;
begin
  Result:=oTable.FieldByName('ProductId').AsInteger;
end;

procedure TOsdpriorDat.SetProductId(pValue:longint);
begin
  oTable.FieldByName('ProductId').AsInteger:=pValue;
end;

function TOsdpriorDat.GetPriority:byte;
begin
  Result:=oTable.FieldByName('Priority').AsInteger;
end;

procedure TOsdpriorDat.SetPriority(pValue:byte);
begin
  oTable.FieldByName('Priority').AsInteger:=pValue;
end;

function TOsdpriorDat.GetSupplier:longint;
begin
  Result:=oTable.FieldByName('Supplier').AsInteger;
end;

procedure TOsdpriorDat.SetSupplier(pValue:longint);
begin
  oTable.FieldByName('Supplier').AsInteger:=pValue;
end;

function TOsdpriorDat.GetQuantity:double;
begin
  Result:=oTable.FieldByName('Quantity').AsFloat;
end;

procedure TOsdpriorDat.SetQuantity(pValue:double);
begin
  oTable.FieldByName('Quantity').AsFloat:=pValue;
end;

function TOsdpriorDat.GetPrice:double;
begin
  Result:=oTable.FieldByName('Price').AsFloat;
end;

procedure TOsdpriorDat.SetPrice(pValue:double);
begin
  oTable.FieldByName('Price').AsFloat:=pValue;
end;

function TOsdpriorDat.GetDate:TDatetime;
begin
  Result:=oTable.FieldByName('Date').AsDateTime;
end;

procedure TOsdpriorDat.SetDate(pValue:TDatetime);
begin
  oTable.FieldByName('Date').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsdpriorDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsdpriorDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsdpriorDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsdpriorDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsdpriorDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsdpriorDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsdpriorDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsdpriorDat.LocProductId(pProductId:longint):boolean;
begin
  SetIndex(ixProductId);
  Result:=oTable.FindKey([pProductId]);
end;

function TOsdpriorDat.LocProductPriority(pProductId:longint;pPriority:byte):boolean;
begin
  SetIndex(ixProductPriority);
  Result:=oTable.FindKey([pProductId,pPriority]);
end;

function TOsdpriorDat.LocSupplier(pSupplier:longint):boolean;
begin
  SetIndex(ixSupplier);
  Result:=oTable.FindKey([pSupplier]);
end;

function TOsdpriorDat.NearProductId(pProductId:longint):boolean;
begin
  SetIndex(ixProductId);
  Result:=oTable.FindNearest([pProductId]);
end;

function TOsdpriorDat.NearProductPriority(pProductId:longint;pPriority:byte):boolean;
begin
  SetIndex(ixProductPriority);
  Result:=oTable.FindNearest([pProductId,pPriority]);
end;

function TOsdpriorDat.NearSupplier(pSupplier:longint):boolean;
begin
  SetIndex(ixSupplier);
  Result:=oTable.FindNearest([pSupplier]);
end;

procedure TOsdpriorDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsdpriorDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOsdpriorDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsdpriorDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsdpriorDat.Next;
begin
  oTable.Next;
end;

procedure TOsdpriorDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsdpriorDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsdpriorDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsdpriorDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsdpriorDat.Post;
begin
  oTable.Post;
end;

procedure TOsdpriorDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsdpriorDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsdpriorDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsdpriorDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsdpriorDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsdpriorDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsdpriorDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
