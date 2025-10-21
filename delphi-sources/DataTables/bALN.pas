unit bALN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TAlnBtr = class (TComponent)
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

constructor TAlnBtr.Create;
begin
  oBtrTable := BtrInit ('ALN',gPath.StkPath,Self);
end;

constructor TAlnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ALN',pPath,Self);
end;

destructor TAlnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAlnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAlnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAlnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAlnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAlnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TAlnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TAlnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TAlnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TAlnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAlnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAlnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAlnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAlnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAlnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TAlnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAlnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TAlnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TAlnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAlnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAlnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAlnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAlnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAlnBtr.First;
begin
  oBtrTable.First;
end;

procedure TAlnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAlnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAlnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAlnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAlnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAlnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAlnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAlnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAlnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAlnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAlnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
