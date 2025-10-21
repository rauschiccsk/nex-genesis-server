unit tGSC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';

type
  TGscTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property GsCode:longint read ReadGsCode write WriteGsCode;
  end;

implementation

constructor TGscTmp.Create;
begin
  oTmpTable := TmpInit ('GSC',Self);
end;

destructor TGscTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGscTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGscTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGscTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGscTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGscTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TGscTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGscTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGscTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGscTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGscTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGscTmp.First;
begin
  oTmpTable.First;
end;

procedure TGscTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGscTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGscTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGscTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGscTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGscTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGscTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGscTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGscTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGscTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGscTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
