unit tDIRMOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TDirmoiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadModDes:Str250;         procedure WriteModDes (pValue:Str250);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property ModDes:Str250 read ReadModDes write WriteModDes;
  end;

implementation

constructor TDirmoiTmp.Create;
begin
  oTmpTable := TmpInit ('DIRMOI',Self);
end;

destructor TDirmoiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirmoiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirmoiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirmoiTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TDirmoiTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TDirmoiTmp.ReadModDes:Str250;
begin
  Result := oTmpTable.FieldByName('ModDes').AsString;
end;

procedure TDirmoiTmp.WriteModDes(pValue:Str250);
begin
  oTmpTable.FieldByName('ModDes').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirmoiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirmoiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirmoiTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TDirmoiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirmoiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirmoiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirmoiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirmoiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirmoiTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirmoiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirmoiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirmoiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirmoiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirmoiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirmoiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirmoiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirmoiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirmoiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirmoiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirmoiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
