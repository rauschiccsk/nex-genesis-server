unit bTCN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TTcnBtr = class (TComponent)
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

constructor TTcnBtr.Create;
begin
  oBtrTable := BtrInit ('TCN',gPath.StkPath,Self);
end;

constructor TTcnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TCN',pPath,Self);
end;

destructor TTcnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTcnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTcnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTcnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTcnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTcnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TTcnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TTcnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TTcnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TTcnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTcnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTcnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTcnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTcnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTcnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTcnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTcnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTcnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TTcnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTcnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TTcnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TTcnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTcnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTcnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTcnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTcnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTcnBtr.First;
begin
  oBtrTable.First;
end;

procedure TTcnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTcnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTcnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTcnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTcnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTcnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTcnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTcnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTcnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTcnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTcnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
