unit bGSNAME;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';

type
  TGsnameBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str20;          procedure WriteGsName (pValue:Str20);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName:Str20):boolean;
    function NearestGsName (pGsName:Str20):boolean;

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
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str20 read ReadGsName write WriteGsName;
  end;

implementation

constructor TGsnameBtr.Create;
begin
  oBtrTable := BtrInit ('GSNAME',gPath.StkPath,Self);
end;

destructor  TGsnameBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGsnameBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGsnameBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsnameBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsnameBtr.ReadGsName:Str20;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TGsnameBtr.WriteGsName(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsnameBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsnameBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGsnameBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGsnameBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGsnameBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGsnameBtr.LocateGsName (pGsName:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([pGsName]);
end;

function TGsnameBtr.NearestGsName (pGsName:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName]);
end;

procedure TGsnameBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGsnameBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGsnameBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGsnameBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGsnameBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGsnameBtr.First;
begin
  oBtrTable.First;
end;

procedure TGsnameBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGsnameBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGsnameBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGsnameBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGsnameBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGsnameBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGsnameBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

end.
