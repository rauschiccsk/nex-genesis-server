unit bIcn;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TIcnBtr = class (TComponent)
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

constructor TIcnBtr.Create;
begin
  oBtrTable := BtrInit ('ICN',gPath.LdgPath,Self);
end;

constructor TIcnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ICN',pPath,Self);
end;

destructor TIcnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIcnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIcnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIcnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIcnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIcnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TIcnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TIcnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TIcnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TIcnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TIcnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIcnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIcnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIcnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIcnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TIcnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

procedure TIcnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIcnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIcnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIcnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIcnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIcnBtr.First;
begin
  oBtrTable.First;
end;

procedure TIcnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIcnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIcnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIcnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIcnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIcnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIcnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIcnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIcnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIcnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIcnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
