unit bKSN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TKsnBtr = class (TComponent)
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

constructor TKsnBtr.Create;
begin
  oBtrTable := BtrInit ('KSN',gPath.StkPath,Self);
end;

constructor TKsnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('KSN',pPath,Self);
end;

destructor TKsnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TKsnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TKsnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TKsnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TKsnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TKsnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TKsnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TKsnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TKsnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TKsnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TKsnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKsnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKsnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TKsnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKsnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TKsnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TKsnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TKsnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TKsnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TKsnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TKsnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TKsnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TKsnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TKsnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TKsnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TKsnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TKsnBtr.First;
begin
  oBtrTable.First;
end;

procedure TKsnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TKsnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TKsnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TKsnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TKsnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TKsnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TKsnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TKsnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TKsnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TKsnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TKsnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
