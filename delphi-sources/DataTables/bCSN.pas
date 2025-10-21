unit bCSN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TCsnBtr = class (TComponent)
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

constructor TCsnBtr.Create;
begin
  oBtrTable := BtrInit ('CSN',gPath.LdgPath,Self);
end;

constructor TCsnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CSN',pPath,Self);
end;

destructor TCsnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCsnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCsnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCsnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCsnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCsnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TCsnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TCsnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TCsnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TCsnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TCsnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCsnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCsnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCsnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCsnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TCsnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCsnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TCsnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TCsnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCsnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCsnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCsnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCsnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCsnBtr.First;
begin
  oBtrTable.First;
end;

procedure TCsnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCsnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCsnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCsnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCsnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCsnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCsnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCsnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCsnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCsnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCsnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
