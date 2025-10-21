unit bMCN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TMcnBtr = class (TComponent)
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

constructor TMcnBtr.Create;
begin
  oBtrTable := BtrInit ('MCN',gPath.StkPath,Self);
end;

constructor TMcnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MCN',pPath,Self);
end;

destructor TMcnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMcnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMcnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMcnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TMcnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TMcnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TMcnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TMcnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TMcnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TMcnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TMcnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMcnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMcnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMcnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMcnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TMcnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TMcnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TMcnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TMcnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMcnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TMcnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMcnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMcnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMcnBtr.First;
begin
  oBtrTable.First;
end;

procedure TMcnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMcnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMcnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMcnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMcnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMcnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMcnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMcnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMcnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMcnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMcnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
