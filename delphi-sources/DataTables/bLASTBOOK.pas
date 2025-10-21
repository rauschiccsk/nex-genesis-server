unit bLASTBOOK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLnBt = 'LnBt';

type
  TLastbookBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLoginName:Str8;        procedure WriteLoginName (pValue:Str8);
    function  ReadBookType:Str3;         procedure WriteBookType (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateLnBt (pLoginName:Str8;pBookType:Str3):boolean;
    function NearestLnBt (pLoginName:Str8;pBookType:Str3):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property LoginName:Str8 read ReadLoginName write WriteLoginName;
    property BookType:Str3 read ReadBookType write WriteBookType;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
  end;

implementation

constructor TLastbookBtr.Create;
begin
  oBtrTable := BtrInit ('LASTBOOK',gPath.SysPath,Self);
end;

constructor TLastbookBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('LASTBOOK',pPath,Self);
end;

destructor TLastbookBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TLastbookBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TLastbookBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TLastbookBtr.ReadLoginName:Str8;
begin
  Result := oBtrTable.FieldByName('LoginName').AsString;
end;

procedure TLastbookBtr.WriteLoginName(pValue:Str8);
begin
  oBtrTable.FieldByName('LoginName').AsString := pValue;
end;

function TLastbookBtr.ReadBookType:Str3;
begin
  Result := oBtrTable.FieldByName('BookType').AsString;
end;

procedure TLastbookBtr.WriteBookType(pValue:Str3);
begin
  oBtrTable.FieldByName('BookType').AsString := pValue;
end;

function TLastbookBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TLastbookBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLastbookBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLastbookBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TLastbookBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLastbookBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TLastbookBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TLastbookBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TLastbookBtr.LocateLnBt (pLoginName:Str8;pBookType:Str3):boolean;
begin
  SetIndex (ixLnBt);
  Result := oBtrTable.FindKey([pLoginName,pBookType]);
end;

function TLastbookBtr.NearestLnBt (pLoginName:Str8;pBookType:Str3):boolean;
begin
  SetIndex (ixLnBt);
  Result := oBtrTable.FindNearest([pLoginName,pBookType]);
end;

procedure TLastbookBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TLastbookBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TLastbookBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TLastbookBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TLastbookBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TLastbookBtr.First;
begin
  oBtrTable.First;
end;

procedure TLastbookBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TLastbookBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TLastbookBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TLastbookBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TLastbookBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TLastbookBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TLastbookBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TLastbookBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TLastbookBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TLastbookBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TLastbookBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
