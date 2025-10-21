unit tIMPPDN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TImppdnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadPrdNum:Str30;          procedure WritePrdNum (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadBaCode:Str15;          procedure WriteBaCode (pValue:Str15);
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
    property PrdNum:Str30 read ReadPrdNum write WritePrdNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BaCode:Str15 read ReadBaCode write WriteBaCode;
  end;

implementation

constructor TImppdnTmp.Create;
begin
  oTmpTable := TmpInit ('IMPPDN',Self);
end;

destructor TImppdnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TImppdnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TImppdnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TImppdnTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TImppdnTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TImppdnTmp.ReadPrdNum:Str30;
begin
  Result := oTmpTable.FieldByName('PrdNum').AsString;
end;

procedure TImppdnTmp.WritePrdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('PrdNum').AsString := pValue;
end;

function TImppdnTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TImppdnTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImppdnTmp.ReadBaCode:Str15;
begin
  Result := oTmpTable.FieldByName('BaCode').AsString;
end;

procedure TImppdnTmp.WriteBaCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BaCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImppdnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TImppdnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TImppdnTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TImppdnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TImppdnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TImppdnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TImppdnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TImppdnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TImppdnTmp.First;
begin
  oTmpTable.First;
end;

procedure TImppdnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TImppdnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TImppdnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TImppdnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TImppdnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TImppdnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TImppdnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TImppdnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TImppdnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TImppdnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TImppdnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1920001}
