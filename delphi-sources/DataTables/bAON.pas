unit bAON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TAonBtr = class (TComponent)
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

constructor TAonBtr.Create;
begin
  oBtrTable := BtrInit ('AON',gPath.StkPath,Self);
end;

constructor TAonBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AON',pPath,Self);
end;

destructor TAonBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAonBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAonBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAonBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAonBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAonBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TAonBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TAonBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TAonBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TAonBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAonBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAonBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAonBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAonBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAonBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAonBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAonBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAonBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TAonBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAonBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TAonBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TAonBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAonBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAonBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAonBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAonBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAonBtr.First;
begin
  oBtrTable.First;
end;

procedure TAonBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAonBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAonBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAonBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAonBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAonBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAonBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAonBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAonBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAonBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAonBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
