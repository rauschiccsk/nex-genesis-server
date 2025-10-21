unit tDOCSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';

type
  TDocstmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadDocQnt:double;         procedure WriteDocQnt (pValue:double);
    function  ReadStmQnt:double;         procedure WriteStmQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadStmVal:double;         procedure WriteStmVal (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property DocQnt:double read ReadDocQnt write WriteDocQnt;
    property StmQnt:double read ReadStmQnt write WriteStmQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property StmVal:double read ReadStmVal write WriteStmVal;
    property DifVal:double read ReadDifVal write WriteDifVal;
  end;

implementation

constructor TDocstmTmp.Create;
begin
  oTmpTable := TmpInit ('DOCSTM',Self);
end;

destructor TDocstmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocstmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDocstmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocstmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDocstmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDocstmTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDocstmTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDocstmTmp.ReadDocQnt:double;
begin
  Result := oTmpTable.FieldByName('DocQnt').AsFloat;
end;

procedure TDocstmTmp.WriteDocQnt(pValue:double);
begin
  oTmpTable.FieldByName('DocQnt').AsFloat := pValue;
end;

function TDocstmTmp.ReadStmQnt:double;
begin
  Result := oTmpTable.FieldByName('StmQnt').AsFloat;
end;

procedure TDocstmTmp.WriteStmQnt(pValue:double);
begin
  oTmpTable.FieldByName('StmQnt').AsFloat := pValue;
end;

function TDocstmTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TDocstmTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TDocstmTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TDocstmTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TDocstmTmp.ReadStmVal:double;
begin
  Result := oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TDocstmTmp.WriteStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat := pValue;
end;

function TDocstmTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TDocstmTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocstmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDocstmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDocstmTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TDocstmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDocstmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocstmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocstmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocstmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocstmTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocstmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocstmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocstmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocstmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocstmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocstmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocstmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocstmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocstmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocstmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDocstmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
