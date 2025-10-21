unit bEMF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmfNum = 'EmfNum';

type
  TEmfBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEmfNum:word;           procedure WriteEmfNum (pValue:word);
    function  ReadEmfName:Str30;         procedure WriteEmfName (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEmfNum (pEmfNum:word):boolean;
    function NearestEmfNum (pEmfNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pCntNum:word);virtual;
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
    property EmfNum:word read ReadEmfNum write WriteEmfNum;
    property EmfName:Str30 read ReadEmfName write WriteEmfName;
  end;

implementation

constructor TEmfBtr.Create;
begin
  oBtrTable := BtrInit ('EMF',gPath.DlsPath,Self);
end;

constructor TEmfBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EMF',pPath,Self);
end;

destructor TEmfBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEmfBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEmfBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEmfBtr.ReadEmfNum:word;
begin
  Result := oBtrTable.FieldByName('EmfNum').AsInteger;
end;

procedure TEmfBtr.WriteEmfNum(pValue:word);
begin
  oBtrTable.FieldByName('EmfNum').AsInteger := pValue;
end;

function TEmfBtr.ReadEmfName:Str30;
begin
  Result := oBtrTable.FieldByName('EmfName').AsString;
end;

procedure TEmfBtr.WriteEmfName(pValue:Str30);
begin
  oBtrTable.FieldByName('EmfName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmfBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmfBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEmfBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEmfBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEmfBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEmfBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEmfBtr.LocateEmfNum (pEmfNum:word):boolean;
begin
  SetIndex (ixEmfNum);
  Result := oBtrTable.FindKey([pEmfNum]);
end;

function TEmfBtr.NearestEmfNum (pEmfNum:word):boolean;
begin
  SetIndex (ixEmfNum);
  Result := oBtrTable.FindNearest([pEmfNum]);
end;

procedure TEmfBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEmfBtr.Open;
begin
  oBtrTable.Open(pCntNum);
end;

procedure TEmfBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEmfBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEmfBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEmfBtr.First;
begin
  oBtrTable.First;
end;

procedure TEmfBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEmfBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEmfBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEmfBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEmfBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEmfBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEmfBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEmfBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEmfBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEmfBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEmfBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
