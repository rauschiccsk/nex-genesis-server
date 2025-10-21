unit bTSN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TTsnBtr = class (TComponent)
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
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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

constructor TTsnBtr.Create;
begin
  oBtrTable := BtrInit ('TSN',gPath.StkPath,Self);
end;

constructor TTsnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TSN',pPath,Self);
end;

destructor TTsnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTsnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTsnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTsnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTsnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTsnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TTsnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TTsnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TTsnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TTsnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTsnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTsnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTsnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTsnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTsnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTsnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTsnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTsnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TTsnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTsnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TTsnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TTsnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTsnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTsnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTsnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTsnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTsnBtr.First;
begin
  oBtrTable.First;
end;

procedure TTsnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTsnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTsnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTsnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTsnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTsnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTsnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTsnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTsnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTsnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTsnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
