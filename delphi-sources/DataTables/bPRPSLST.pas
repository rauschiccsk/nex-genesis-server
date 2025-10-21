unit bPrpslst;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrpsCode = 'PrpsCode';
  ixPrpsName = 'PrpsName';

type
  TPrpslstBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPrpsCode:longint;      procedure WritePrpsCode (pValue:longint);
    function  ReadPrpsName:Str50;        procedure WritePrpsName (pValue:Str50);
    function  ReadPrpsName_:Str50;       procedure WritePrpsName_ (pValue:Str50);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePrpsCode (pPrpsCode:longint):boolean;
    function LocatePrpsName (pPrpsName_:Str50):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open; virtual;
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
    property PrpsCode:longint read ReadPrpsCode write WritePrpsCode;
    property PrpsName:Str50 read ReadPrpsName write WritePrpsName;
    property PrpsName_:Str50 read ReadPrpsName_ write WritePrpsName_;
  end;

implementation

constructor TPrpslstBtr.Create;
begin
  oBtrTable := BtrInit ('Prpslst',gPath.StkPath,Self);
end;

destructor  TPrpslstBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrpslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrpslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrpslstBtr.ReadPrpsCode:longint;
begin
  Result := oBtrTable.FieldByName('PrpsCode').AsInteger;
end;

procedure TPrpslstBtr.WritePrpsCode(pValue:longint);
begin
  oBtrTable.FieldByName('PrpsCode').AsInteger := pValue;
end;

function TPrpslstBtr.ReadPrpsName:Str50;
begin
  Result := oBtrTable.FieldByName('PrpsName').AsString;
end;

procedure TPrpslstBtr.WritePrpsName(pValue:Str50);
begin
  oBtrTable.FieldByName('PrpsName').AsString := pValue;
end;

function TPrpslstBtr.ReadPrpsName_:Str50;
begin
  Result := oBtrTable.FieldByName('PrpsName_').AsString;
end;

procedure TPrpslstBtr.WritePrpsName_(pValue:Str50);
begin
  oBtrTable.FieldByName('PrpsName_').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrpslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrpslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrpslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrpslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrpslstBtr.LocatePrpsCode (pPrpsCode:longint):boolean;
begin
  SetIndex (ixPrpsCode);
  Result := oBtrTable.FindKey([pPrpsCode]);
end;

function TPrpslstBtr.LocatePrpsName (pPrpsName_:Str50):boolean;
begin
  SetIndex (ixPrpsName);
  Result := oBtrTable.FindKey([pPrpsName_]);
end;

procedure TPrpslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrpslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrpslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrpslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrpslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrpslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrpslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrpslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrpslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrpslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrpslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrpslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrpslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrpslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrpslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrpslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrpslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
