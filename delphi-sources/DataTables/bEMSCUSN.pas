unit bEMSCUSN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWnSn = 'WnSn';

type
  TEmscusnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWriNum:longint;        procedure WriteWriNum (pValue:longint);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadNotice:Str160;         procedure WriteNotice (pValue:Str160);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateWnSn (pWriNum:longint;pSerNum:longint):boolean;
    function NearestWnSn (pWriNum:longint;pSerNum:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property WriNum:longint read ReadWriNum write WriteWriNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str160 read ReadNotice write WriteNotice;
  end;

implementation

constructor TEmscusnBtr.Create;
begin
  oBtrTable := BtrInit ('EMSCUSN',gPath.SysPath,Self);
end;

constructor TEmscusnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EMSCUSN',pPath,Self);
end;

destructor TEmscusnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEmscusnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEmscusnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEmscusnBtr.ReadWriNum:longint;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TEmscusnBtr.WriteWriNum(pValue:longint);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TEmscusnBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TEmscusnBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TEmscusnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TEmscusnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TEmscusnBtr.ReadNotice:Str160;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TEmscusnBtr.WriteNotice(pValue:Str160);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmscusnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmscusnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEmscusnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmscusnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEmscusnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEmscusnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEmscusnBtr.LocateWnSn (pWriNum:longint;pSerNum:longint):boolean;
begin
  SetIndex (ixWnSn);
  Result := oBtrTable.FindKey([pWriNum,pSerNum]);
end;

function TEmscusnBtr.NearestWnSn (pWriNum:longint;pSerNum:longint):boolean;
begin
  SetIndex (ixWnSn);
  Result := oBtrTable.FindNearest([pWriNum,pSerNum]);
end;

procedure TEmscusnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEmscusnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEmscusnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEmscusnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEmscusnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEmscusnBtr.First;
begin
  oBtrTable.First;
end;

procedure TEmscusnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEmscusnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEmscusnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEmscusnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEmscusnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEmscusnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEmscusnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEmscusnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEmscusnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEmscusnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEmscusnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
