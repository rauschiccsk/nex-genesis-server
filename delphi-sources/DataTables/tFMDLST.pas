unit tFMDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFmdNum = '';

type
  TFmdlstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFmdNum:word;           procedure WriteFmdNum (pValue:word);
    function  ReadBvalue:double;         procedure WriteBvalue (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFmdNum (pFmdNum:word):boolean;

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
    property FmdNum:word read ReadFmdNum write WriteFmdNum;
    property Bvalue:double read ReadBvalue write WriteBvalue;
    property Weight:double read ReadWeight write WriteWeight;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
  end;

implementation

constructor TFmdlstTmp.Create;
begin
  oTmpTable := TmpInit ('FMDLST',Self);
end;

destructor TFmdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFmdlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFmdlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFmdlstTmp.ReadFmdNum:word;
begin
  Result := oTmpTable.FieldByName('FmdNum').AsInteger;
end;

procedure TFmdlstTmp.WriteFmdNum(pValue:word);
begin
  oTmpTable.FieldByName('FmdNum').AsInteger := pValue;
end;

function TFmdlstTmp.ReadBvalue:double;
begin
  Result := oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TFmdlstTmp.WriteBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat := pValue;
end;

function TFmdlstTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TFmdlstTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TFmdlstTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TFmdlstTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFmdlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFmdlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFmdlstTmp.LocateFmdNum (pFmdNum:word):boolean;
begin
  SetIndex (ixFmdNum);
  Result := oTmpTable.FindKey([pFmdNum]);
end;

procedure TFmdlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFmdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFmdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFmdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFmdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFmdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TFmdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFmdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFmdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFmdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFmdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFmdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFmdlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFmdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFmdlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFmdlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFmdlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
