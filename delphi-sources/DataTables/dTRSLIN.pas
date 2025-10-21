unit dTRSLIN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTrsLin='TrsLin';

type
  TTrslinDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetTrsLin:byte;             procedure SetTrsLin(pValue:byte);
    function GetTrsDes:Str250;           procedure SetTrsDes(pValue:Str250);
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
    function LocTrsLin(pTrsLin:byte):boolean;
    function NearTrsLin(pTrsLin:byte):boolean;

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
    property TrsLin:byte read GetTrsLin write SetTrsLin;
    property TrsDes:Str250 read GetTrsDes write SetTrsDes;
  end;

implementation

constructor TTrslinDat.Create;
begin
  oTable:=DatInit('TRSLIN',gPath.DlsPath,Self);
end;

constructor TTrslinDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('TRSLIN',pPath,Self);
end;

destructor TTrslinDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TTrslinDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TTrslinDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TTrslinDat.GetTrsLin:byte;
begin
  Result:=oTable.FieldByName('TrsLin').AsInteger;
end;

procedure TTrslinDat.SetTrsLin(pValue:byte);
begin
  oTable.FieldByName('TrsLin').AsInteger:=pValue;
end;

function TTrslinDat.GetTrsDes:Str250;
begin
  Result:=oTable.FieldByName('TrsDes').AsString;
end;

procedure TTrslinDat.SetTrsDes(pValue:Str250);
begin
  oTable.FieldByName('TrsDes').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrslinDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TTrslinDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TTrslinDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TTrslinDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TTrslinDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TTrslinDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TTrslinDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TTrslinDat.LocTrsLin(pTrsLin:byte):boolean;
begin
  SetIndex(ixTrsLin);
  Result:=oTable.FindKey([pTrsLin]);
end;

function TTrslinDat.NearTrsLin(pTrsLin:byte):boolean;
begin
  SetIndex(ixTrsLin);
  Result:=oTable.FindNearest([pTrsLin]);
end;

procedure TTrslinDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TTrslinDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TTrslinDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TTrslinDat.Prior;
begin
  oTable.Prior;
end;

procedure TTrslinDat.Next;
begin
  oTable.Next;
end;

procedure TTrslinDat.First;
begin
  Open;
  oTable.First;
end;

procedure TTrslinDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TTrslinDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TTrslinDat.Edit;
begin
  oTable.Edit;
end;

procedure TTrslinDat.Post;
begin
  oTable.Post;
end;

procedure TTrslinDat.Delete;
begin
  oTable.Delete;
end;

procedure TTrslinDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TTrslinDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TTrslinDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TTrslinDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TTrslinDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TTrslinDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
