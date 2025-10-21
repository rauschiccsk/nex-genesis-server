unit dXRIDOS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDySnPn='DySnPn';
  ixDnIn='DnIn';
  ixDocDte='DocDte';

type
  TXridosDat=class(TComponent)
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
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetUndCva:double;           procedure SetUndCva(pValue:double);
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
    function LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property UndCva:double read GetUndCva write SetUndCva;
  end;

implementation

constructor TXridosDat.Create;
begin
  oTable:=DatInit('XRIDOS',gPath.StkPath,Self);
end;

constructor TXridosDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('XRIDOS',pPath,Self);
end;

destructor TXridosDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TXridosDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TXridosDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TXridosDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TXridosDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TXridosDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TXridosDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TXridosDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TXridosDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXridosDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TXridosDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TXridosDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TXridosDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TXridosDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TXridosDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TXridosDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TXridosDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TXridosDat.GetUndCva:double;
begin
  Result:=oTable.FieldByName('UndCva').AsFloat;
end;

procedure TXridosDat.SetUndCva(pValue:double);
begin
  oTable.FieldByName('UndCva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXridosDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TXridosDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TXridosDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TXridosDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TXridosDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TXridosDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TXridosDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TXridosDat.LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindKey([pDocYer,pSerNum,pProNum]);
end;

function TXridosDat.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TXridosDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TXridosDat.NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindNearest([pDocYer,pSerNum,pProNum]);
end;

function TXridosDat.NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TXridosDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

procedure TXridosDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TXridosDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TXridosDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TXridosDat.Prior;
begin
  oTable.Prior;
end;

procedure TXridosDat.Next;
begin
  oTable.Next;
end;

procedure TXridosDat.First;
begin
  Open;
  oTable.First;
end;

procedure TXridosDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TXridosDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TXridosDat.Edit;
begin
  oTable.Edit;
end;

procedure TXridosDat.Post;
begin
  oTable.Post;
end;

procedure TXridosDat.Delete;
begin
  oTable.Delete;
end;

procedure TXridosDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TXridosDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TXridosDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TXridosDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TXridosDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TXridosDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
