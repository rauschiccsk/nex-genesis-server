unit bCAPDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPayNum = 'PayNum';

type
  TCapdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPayNum:byte;           procedure WritePayNum (pValue:byte);
    function  ReadPayName:Str30;         procedure WritePayName (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePayNum (pPayNum:byte):boolean;
    function NearestPayNum (pPayNum:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open; virtual;
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
    property PayNum:byte read ReadPayNum write WritePayNum;
    property PayName:Str30 read ReadPayName write WritePayName;
  end;

implementation

constructor TCapdefBtr.Create;
begin
  oBtrTable := BtrInit ('CAPDEF',gPath.CabPath,Self);
end;

constructor TCapdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CAPDEF',pPath,Self);
end;

destructor TCapdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCapdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCapdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCapdefBtr.ReadPayNum:byte;
begin
  Result := oBtrTable.FieldByName('PayNum').AsInteger;
end;

procedure TCapdefBtr.WritePayNum(pValue:byte);
begin
  oBtrTable.FieldByName('PayNum').AsInteger := pValue;
end;

function TCapdefBtr.ReadPayName:Str30;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TCapdefBtr.WritePayName(pValue:Str30);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCapdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCapdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCapdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCapdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCapdefBtr.LocatePayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindKey([pPayNum]);
end;

function TCapdefBtr.NearestPayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindNearest([pPayNum]);
end;

procedure TCapdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCapdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCapdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCapdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCapdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCapdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TCapdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCapdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCapdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCapdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCapdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCapdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCapdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCapdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCapdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCapdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCapdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
