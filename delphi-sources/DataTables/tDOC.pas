unit tDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TDocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
  end;

implementation

constructor TDocTmp.Create;
begin
  oTmpTable := TmpInit ('DOC',Self);
end;

destructor TDocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDocTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDocTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TDocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
