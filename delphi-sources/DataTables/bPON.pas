unit bPON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TPonBtr = class (TComponent)
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

constructor TPonBtr.Create;
begin
  oBtrTable := BtrInit ('PON',gPath.StkPath,Self);
end;

constructor TPonBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PON',pPath,Self);
end;

destructor TPonBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPonBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPonBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPonBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPonBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPonBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TPonBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TPonBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TPonBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TPonBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TPonBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPonBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPonBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPonBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPonBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPonBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPonBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPonBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TPonBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPonBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TPonBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TPonBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPonBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPonBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPonBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPonBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPonBtr.First;
begin
  oBtrTable.First;
end;

procedure TPonBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPonBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPonBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPonBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPonBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPonBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPonBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPonBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPonBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPonBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPonBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
