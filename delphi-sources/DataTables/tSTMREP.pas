unit tSTMREP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';

type
  TStmrepTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadBvalue:double;         procedure WriteBvalue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property Bvalue:double read ReadBvalue write WriteBvalue;
  end;

implementation

constructor TStmrepTmp.Create;
begin
  oTmpTable := TmpInit ('STMREP',Self);
end;

destructor TStmrepTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStmrepTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStmrepTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStmrepTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStmrepTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TStmrepTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStmrepTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStmrepTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStmrepTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStmrepTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStmrepTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStmrepTmp.ReadBvalue:double;
begin
  Result := oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TStmrepTmp.WriteBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStmrepTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStmrepTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStmrepTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TStmrepTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStmrepTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStmrepTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStmrepTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStmrepTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStmrepTmp.First;
begin
  oTmpTable.First;
end;

procedure TStmrepTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStmrepTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStmrepTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStmrepTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStmrepTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStmrepTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStmrepTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStmrepTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStmrepTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStmrepTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStmrepTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
