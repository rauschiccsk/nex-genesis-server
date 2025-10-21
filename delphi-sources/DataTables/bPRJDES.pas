unit bPRJDES;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDnLn = 'DnLn';

type
  TPrjdesBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadDesText:Str250;        procedure WriteDesText (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDnLn (pDocNum:Str12;pLinNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDnLn (pDocNum:Str12;pLinNum:word):boolean;

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
    property LinNum:word read ReadLinNum write WriteLinNum;
    property DesText:Str250 read ReadDesText write WriteDesText;
  end;

implementation

constructor TPrjdesBtr.Create;
begin
  oBtrTable := BtrInit ('PRJDES',gPath.DlsPath,Self);
end;

constructor TPrjdesBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRJDES',pPath,Self);
end;

destructor TPrjdesBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrjdesBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrjdesBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrjdesBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrjdesBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrjdesBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TPrjdesBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TPrjdesBtr.ReadDesText:Str250;
begin
  Result := oBtrTable.FieldByName('DesText').AsString;
end;

procedure TPrjdesBtr.WriteDesText(pValue:Str250);
begin
  oBtrTable.FieldByName('DesText').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrjdesBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjdesBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrjdesBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjdesBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrjdesBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrjdesBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrjdesBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrjdesBtr.LocateDnLn (pDocNum:Str12;pLinNum:word):boolean;
begin
  SetIndex (ixDnLn);
  Result := oBtrTable.FindKey([pDocNum,pLinNum]);
end;

function TPrjdesBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrjdesBtr.NearestDnLn (pDocNum:Str12;pLinNum:word):boolean;
begin
  SetIndex (ixDnLn);
  Result := oBtrTable.FindNearest([pDocNum,pLinNum]);
end;

procedure TPrjdesBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrjdesBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrjdesBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrjdesBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrjdesBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrjdesBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrjdesBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrjdesBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrjdesBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrjdesBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrjdesBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrjdesBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrjdesBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrjdesBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrjdesBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrjdesBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrjdesBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
