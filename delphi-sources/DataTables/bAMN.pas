unit bAMN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TAmnBtr = class (TComponent)
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

constructor TAmnBtr.Create;
begin
  oBtrTable := BtrInit ('AMN',gPath.StkPath,Self);
end;

constructor TAmnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AMN',pPath,Self);
end;

destructor TAmnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAmnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAmnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAmnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAmnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAmnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TAmnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TAmnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TAmnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TAmnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAmnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAmnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAmnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAmnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAmnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAmnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TAmnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAmnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TAmnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TAmnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAmnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAmnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAmnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAmnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAmnBtr.First;
begin
  oBtrTable.First;
end;

procedure TAmnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAmnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAmnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAmnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAmnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAmnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAmnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAmnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAmnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAmnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAmnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
