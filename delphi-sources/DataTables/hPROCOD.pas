unit hPROCOD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';
  ixBarCod='BarCode';
  ixPnBc='GsBc';

type
  TProcodHnd=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    // Pristup k databazovym poliam
    function GetProNum:longint;       procedure SetProNum(pValue:longint);
    function GetBarCod:Str15;         procedure SetBarCod(pValue:Str15);
  public
    constructor Create(pPath:ShortString); overload;
    function FieldExist(pFieldName:Str20):boolean;
    // Elementarne databazove operacie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast: boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint): boolean;

    function LocProNum(pProNum:longint):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocPnBc(pProNum:longint;pBarCod:Str15):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearPnBc(pProNum:longint;pBarCod:Str15):boolean;

    procedure SetIndex(pIndexName:STr20);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Pristup k databazovym poliam
    property ProNum:longint read GetProNum write SetProNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
  end;

implementation

constructor TProcodHnd.Create;
begin
  oTable:=BtrInit('BARCODE',gPath.StkPath,Self);
end;

constructor TProcodHnd.Create(pPath:ShortString);
begin
  oTable:=BtrInit('BARCODE',pPath,Self);
end;

destructor TProcodHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TProcodHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TProcodHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TProcodHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TProcodHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TProcodHnd.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

procedure TProcodHnd.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TProcodHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TProcodHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TProcodHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TProcodHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TProcodHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TProcodHnd.GotoPos(pActPos:longint):boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TProcodHnd.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TProcodHnd.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TProcodHnd.LocPnBc(pProNum:longint;pBarCod:Str15):boolean;
begin
  SetIndex(ixPnBc);
  Result:=oTable.FindKey([pProNum,pBarCod]);
end;

function TProcodHnd.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TProcodHnd.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TProcodHnd.NearPnBc(pProNum:longint;pBarCod:Str15):boolean;
begin
  SetIndex(ixPnBc);
  Result:=oTable.FindNearest([pProNum,pBarCod]);
end;

procedure TProcodHnd.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TProcodHnd.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TProcodHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TProcodHnd.Prior;
begin
  oTable.Prior;
end;

procedure TProcodHnd.Next;
begin
  oTable.Next;
end;

procedure TProcodHnd.First;
begin
  oTable.First;
end;

procedure TProcodHnd.Last;
begin
  oTable.Last;
end;

procedure TProcodHnd.Insert;
begin
  oTable.Insert;
end;

procedure TProcodHnd.Edit;
begin
  oTable.Edit;
end;

procedure TProcodHnd.Post;
begin
  oTable.Post;
end;

procedure TProcodHnd.Delete;
begin
  oTable.Delete;
end;

procedure TProcodHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TProcodHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TProcodHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TProcodHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TProcodHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TProcodHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
