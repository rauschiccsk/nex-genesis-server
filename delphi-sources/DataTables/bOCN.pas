unit bOcn;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TOcnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadNotType:Str1;          procedure WriteNotType (pValue:Str1);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadNotice:Str250;         procedure WriteNotice (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property NotType:Str1 read ReadNotType write WriteNotType;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TOcnBtr.Create;
begin
  oBtrTable := BtrInit ('OCN',gPath.StkPath,Self);
end;

constructor TOcnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OCN',pPath,Self);
end;

destructor TOcnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOcnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOcnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOcnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOcnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOcnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TOcnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TOcnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TOcnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TOcnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TOcnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOcnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOcnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOcnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOcnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TOcnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

procedure TOcnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOcnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOcnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOcnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOcnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOcnBtr.First;
begin
  oBtrTable.First;
end;

procedure TOcnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOcnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOcnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOcnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOcnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOcnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOcnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOcnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOcnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOcnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOcnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
