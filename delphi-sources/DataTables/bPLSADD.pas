unit bPLSADD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPnGc = 'PnGc';
  ixPlsNum = 'PlsNum';
  ixGsCode = 'GsCode';

type
  TPlsaddBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadFixLevel:byte;         procedure WriteFixLevel (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePnGc (pPlsNum:word;pGsCode:longint):boolean;
    function LocatePlsNum (pPlsNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function NearestPnGc (pPlsNum:word;pGsCode:longint):boolean;
    function NearestPlsNum (pPlsNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property FixLevel:byte read ReadFixLevel write WriteFixLevel;
  end;

implementation

constructor TPlsaddBtr.Create;
begin
  oBtrTable := BtrInit ('PLSADD',gPath.StkPath,Self);
end;

constructor TPlsaddBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLSADD',pPath,Self);
end;

destructor TPlsaddBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlsaddBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlsaddBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlsaddBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TPlsaddBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TPlsaddBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlsaddBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPlsaddBtr.ReadFixLevel:byte;
begin
  Result := oBtrTable.FieldByName('FixLevel').AsInteger;
end;

procedure TPlsaddBtr.WriteFixLevel(pValue:byte);
begin
  oBtrTable.FieldByName('FixLevel').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlsaddBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlsaddBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPlsaddBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlsaddBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlsaddBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlsaddBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlsaddBtr.LocatePnGc (pPlsNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixPnGc);
  Result := oBtrTable.FindKey([pPlsNum,pGsCode]);
end;

function TPlsaddBtr.LocatePlsNum (pPlsNum:word):boolean;
begin
  SetIndex (ixPlsNum);
  Result := oBtrTable.FindKey([pPlsNum]);
end;

function TPlsaddBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPlsaddBtr.NearestPnGc (pPlsNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixPnGc);
  Result := oBtrTable.FindNearest([pPlsNum,pGsCode]);
end;

function TPlsaddBtr.NearestPlsNum (pPlsNum:word):boolean;
begin
  SetIndex (ixPlsNum);
  Result := oBtrTable.FindNearest([pPlsNum]);
end;

function TPlsaddBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

procedure TPlsaddBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlsaddBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPlsaddBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlsaddBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlsaddBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlsaddBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlsaddBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlsaddBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlsaddBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlsaddBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlsaddBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlsaddBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlsaddBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlsaddBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlsaddBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlsaddBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlsaddBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
