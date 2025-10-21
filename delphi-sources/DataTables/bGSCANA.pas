unit bGscana;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGaName = 'GaName';

type
  TGscanaBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGaName:Str200;         procedure WriteGaName (pValue:Str200);
    function  ReadGaName_:Str200;        procedure WriteGaName_ (pValue:Str200);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGaName (pGaName_:Str200):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GaName:Str200 read ReadGaName write WriteGaName;
    property GaName_:Str200 read ReadGaName_ write WriteGaName_;
  end;

implementation

constructor TGscanaBtr.Create;
begin
  oBtrTable := BtrInit ('Gscana',gPath.StkPath,Self);
end;

destructor  TGscanaBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGscanaBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGscanaBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGscanaBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscanaBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscanaBtr.ReadGaName:Str200;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TGscanaBtr.WriteGaName(pValue:Str200);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TGscanaBtr.ReadGaName_:Str200;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TGscanaBtr.WriteGaName_(pValue:Str200);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscanaBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscanaBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGscanaBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGscanaBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGscanaBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGscanaBtr.LocateGaName (pGaName_:Str200):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([pGaName_]);
end;

procedure TGscanaBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGscanaBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGscanaBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGscanaBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGscanaBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGscanaBtr.First;
begin
  oBtrTable.First;
end;

procedure TGscanaBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGscanaBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGscanaBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGscanaBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGscanaBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGscanaBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGscanaBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGscanaBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGscanaBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGscanaBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGscanaBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
