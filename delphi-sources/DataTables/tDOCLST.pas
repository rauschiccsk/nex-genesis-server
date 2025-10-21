unit tDOCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TDoclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
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
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocVal:double read ReadDocVal write WriteDocVal;
  end;

implementation

constructor TDoclstTmp.Create;
begin
  oTmpTable := TmpInit ('DOCLST',Self);
end;

destructor TDoclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDoclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDoclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDoclstTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDoclstTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDoclstTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TDoclstTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TDoclstTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TDoclstTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDoclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDoclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDoclstTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TDoclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDoclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDoclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDoclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDoclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDoclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TDoclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDoclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDoclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDoclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDoclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDoclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDoclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDoclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDoclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDoclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDoclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1921001}
