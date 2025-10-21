unit bDEBREG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixDocNum = 'DocNum';

type
  TDebregBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadExpDat:TDatetime;      procedure WriteExpDat (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property ExpDat:TDatetime read ReadExpDat write WriteExpDat;
  end;

implementation

constructor TDebregBtr.Create;
begin
  oBtrTable := BtrInit ('DEBREG',gPath.LdgPath,Self);
end;

constructor TDebregBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DEBREG',pPath,Self);
end;

destructor TDebregBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDebregBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDebregBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDebregBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TDebregBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TDebregBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TDebregBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TDebregBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TDebregBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TDebregBtr.ReadExpDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDat').AsDateTime;
end;

procedure TDebregBtr.WriteExpDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDebregBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDebregBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDebregBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDebregBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDebregBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDebregBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDebregBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TDebregBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TDebregBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TDebregBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TDebregBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDebregBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDebregBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDebregBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDebregBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDebregBtr.First;
begin
  oBtrTable.First;
end;

procedure TDebregBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDebregBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDebregBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDebregBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDebregBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDebregBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDebregBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDebregBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDebregBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDebregBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDebregBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
