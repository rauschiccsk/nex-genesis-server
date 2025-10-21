unit bIsn;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoLn = 'DoLn';
  ixDocNum = 'DocNum';

type
  TIsnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadNotice:Str250;         procedure WriteNotice (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoLn (pDocNum:Str12;pLinNum:word):boolean;
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
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TIsnBtr.Create;
begin
  oBtrTable := BtrInit ('ISN',gPath.LdgPath,Self);
end;

constructor TIsnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ISN',pPath,Self);
end;

destructor TIsnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIsnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIsnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIsnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIsnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIsnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TIsnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TIsnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TIsnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIsnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIsnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIsnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIsnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIsnBtr.LocateDoLn (pDocNum:Str12;pLinNum:word):boolean;
begin
  SetIndex (ixDoLn);
  Result := oBtrTable.FindKey([pDocNum,pLinNum]);
end;

function TIsnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

procedure TIsnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIsnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIsnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIsnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIsnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIsnBtr.First;
begin
  oBtrTable.First;
end;

procedure TIsnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIsnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIsnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIsnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIsnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIsnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIsnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIsnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIsnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIsnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIsnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
