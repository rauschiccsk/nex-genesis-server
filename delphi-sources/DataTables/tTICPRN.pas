unit tTICPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTicCode = '';

type
  TTicprnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTicCode:Str10;         procedure WriteTicCode (pValue:Str10);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTicCode (pTicCode:Str10):boolean;

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
    property TicCode:Str10 read ReadTicCode write WriteTicCode;
  end;

implementation

constructor TTicprnTmp.Create;
begin
  oTmpTable := TmpInit ('TICPRN',Self);
end;

destructor TTicprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTicprnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTicprnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTicprnTmp.ReadTicCode:Str10;
begin
  Result := oTmpTable.FieldByName('TicCode').AsString;
end;

procedure TTicprnTmp.WriteTicCode(pValue:Str10);
begin
  oTmpTable.FieldByName('TicCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTicprnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTicprnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTicprnTmp.LocateTicCode (pTicCode:Str10):boolean;
begin
  SetIndex (ixTicCode);
  Result := oTmpTable.FindKey([pTicCode]);
end;

procedure TTicprnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTicprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTicprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTicprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTicprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTicprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TTicprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTicprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTicprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTicprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTicprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTicprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTicprnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTicprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTicprnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTicprnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTicprnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1808007}
