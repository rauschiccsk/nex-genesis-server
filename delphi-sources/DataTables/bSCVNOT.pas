unit bSCVNOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TScvnotBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property NotType:Str1 read ReadNotType write WriteNotType;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TScvnotBtr.Create;
begin
  oBtrTable := BtrInit ('SCVNOT',gPath.StkPath,Self);
end;

constructor TScvnotBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCVNOT',pPath,Self);
end;

destructor TScvnotBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TScvnotBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TScvnotBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TScvnotBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TScvnotBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TScvnotBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TScvnotBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TScvnotBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TScvnotBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TScvnotBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TScvnotBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScvnotBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvnotBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TScvnotBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TScvnotBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TScvnotBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TScvnotBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TScvnotBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TScvnotBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TScvnotBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TScvnotBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TScvnotBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TScvnotBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TScvnotBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TScvnotBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TScvnotBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TScvnotBtr.First;
begin
  oBtrTable.First;
end;

procedure TScvnotBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TScvnotBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TScvnotBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TScvnotBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TScvnotBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TScvnotBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TScvnotBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TScvnotBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TScvnotBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TScvnotBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TScvnotBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1916001}
