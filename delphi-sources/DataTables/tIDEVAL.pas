unit tIDEVAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEvlCode = '';

type
  TIdevalTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEvlCode:Str15;         procedure WriteEvlCode (pValue:Str15);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateEvlCode (pEvlCode:Str15):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property EvlCode:Str15 read ReadEvlCode write WriteEvlCode;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
  end;

implementation

constructor TIdevalTmp.Create;
begin
  oTmpTable := TmpInit ('IDEVAL',Self);
end;

destructor TIdevalTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIdevalTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIdevalTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIdevalTmp.ReadEvlCode:Str15;
begin
  Result := oTmpTable.FieldByName('EvlCode').AsString;
end;

procedure TIdevalTmp.WriteEvlCode(pValue:Str15);
begin
  oTmpTable.FieldByName('EvlCode').AsString := pValue;
end;

function TIdevalTmp.ReadIncQnt:double;
begin
  Result := oTmpTable.FieldByName('IncQnt').AsFloat;
end;

procedure TIdevalTmp.WriteIncQnt(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TIdevalTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TIdevalTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdevalTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIdevalTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIdevalTmp.LocateEvlCode (pEvlCode:Str15):boolean;
begin
  SetIndex (ixEvlCode);
  Result := oTmpTable.FindKey([pEvlCode]);
end;

procedure TIdevalTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIdevalTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIdevalTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIdevalTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIdevalTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIdevalTmp.First;
begin
  oTmpTable.First;
end;

procedure TIdevalTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIdevalTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIdevalTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIdevalTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIdevalTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIdevalTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIdevalTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIdevalTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIdevalTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIdevalTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIdevalTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
