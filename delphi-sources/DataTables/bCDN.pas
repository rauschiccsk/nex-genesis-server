unit bCDN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = 'DoNtLn';
  ixDocNum = 'DocNum';

type
  TCdnBtr = class (TComponent)
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

constructor TCdnBtr.Create;
begin
  oBtrTable := BtrInit ('CDN',gPath.StkPath,Self);
end;

constructor TCdnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CDN',pPath,Self);
end;

destructor TCdnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCdnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCdnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCdnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCdnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCdnBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TCdnBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TCdnBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TCdnBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TCdnBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TCdnBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCdnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCdnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCdnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCdnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCdnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCdnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCdnBtr.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TCdnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCdnBtr.NearestDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oBtrTable.FindNearest([pDocNum,pNotType,pLinNum]);
end;

function TCdnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TCdnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCdnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCdnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCdnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCdnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCdnBtr.First;
begin
  oBtrTable.First;
end;

procedure TCdnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCdnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCdnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCdnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCdnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCdnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCdnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCdnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCdnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCdnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCdnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
