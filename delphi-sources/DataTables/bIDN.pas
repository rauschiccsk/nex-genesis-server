unit bIDN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoLn = 'DoLn';
  ixDocNum = 'DocNum';

type
  TIdnBtr = class (TComponent)
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
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoLn (pDocNum:Str12;pLinNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDoLn (pDocNum:Str12;pLinNum:word):boolean;
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
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TIdnBtr.Create;
begin
  oBtrTable := BtrInit ('IDN',gPath.LdgPath,Self);
end;

constructor TIdnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IDN',pPath,Self);
end;

destructor TIdnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIdnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIdnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIdnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIdnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIdnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TIdnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TIdnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TIdnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIdnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIdnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIdnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIdnBtr.LocateDoLn (pDocNum:Str12;pLinNum:word):boolean;
begin
  SetIndex (ixDoLn);
  Result := oBtrTable.FindKey([pDocNum,pLinNum]);
end;

function TIdnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIdnBtr.NearestDoLn (pDocNum:Str12;pLinNum:word):boolean;
begin
  SetIndex (ixDoLn);
  Result := oBtrTable.FindNearest([pDocNum,pLinNum]);
end;

function TIdnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TIdnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIdnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIdnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIdnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIdnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIdnBtr.First;
begin
  oBtrTable.First;
end;

procedure TIdnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIdnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIdnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIdnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIdnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIdnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIdnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIdnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIdnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIdnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIdnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
