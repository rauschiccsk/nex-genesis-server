unit dEDINOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocSer='DocSer';

type
  TEdinotDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocSer:word;             procedure SetDocSer(pValue:word);
    function GetNotice:Str250;           procedure SetNotice(pValue:Str250);
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
    function LocDocSer(pDocSer:word):boolean;
    function NearDocSer(pDocSer:word):boolean;

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
    property DocSer:word read GetDocSer write SetDocSer;
    property Notice:Str250 read GetNotice write SetNotice;
  end;

implementation

constructor TEdinotDat.Create;
begin
  oTable:=DatInit('EDINOT',gPath.StkPath,Self);
end;

constructor TEdinotDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EDINOT',pPath,Self);
end;

destructor TEdinotDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEdinotDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEdinotDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEdinotDat.GetDocSer:word;
begin
  Result:=oTable.FieldByName('DocSer').AsInteger;
end;

procedure TEdinotDat.SetDocSer(pValue:word);
begin
  oTable.FieldByName('DocSer').AsInteger:=pValue;
end;

function TEdinotDat.GetNotice:Str250;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TEdinotDat.SetNotice(pValue:Str250);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdinotDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEdinotDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEdinotDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEdinotDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEdinotDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEdinotDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEdinotDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEdinotDat.LocDocSer(pDocSer:word):boolean;
begin
  SetIndex(ixDocSer);
  Result:=oTable.FindKey([pDocSer]);
end;

function TEdinotDat.NearDocSer(pDocSer:word):boolean;
begin
  SetIndex(ixDocSer);
  Result:=oTable.FindNearest([pDocSer]);
end;

procedure TEdinotDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEdinotDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEdinotDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEdinotDat.Prior;
begin
  oTable.Prior;
end;

procedure TEdinotDat.Next;
begin
  oTable.Next;
end;

procedure TEdinotDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEdinotDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEdinotDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEdinotDat.Edit;
begin
  oTable.Edit;
end;

procedure TEdinotDat.Post;
begin
  oTable.Post;
end;

procedure TEdinotDat.Delete;
begin
  oTable.Delete;
end;

procedure TEdinotDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEdinotDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEdinotDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEdinotDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEdinotDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEdinotDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
