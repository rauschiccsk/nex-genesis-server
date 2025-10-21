unit tDOCSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='';

type
  TDocstkTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetDocVal:double;           procedure SetDocVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocStkNum (pStkNum:word):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property StkNum:word read GetStkNum write SetStkNum;
    property DocVal:double read GetDocVal write SetDocVal;
  end;

implementation

constructor TDocstkTmp.Create;
begin
  oTmpTable:=TmpInit ('DOCSTK',Self);
end;

destructor TDocstkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocstkTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TDocstkTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocstkTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TDocstkTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TDocstkTmp.GetDocVal:double;
begin
  Result:=oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TDocstkTmp.SetDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocstkTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TDocstkTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TDocstkTmp.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result:=oTmpTable.FindKey([pStkNum]);
end;

procedure TDocstkTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TDocstkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocstkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocstkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocstkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocstkTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocstkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocstkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocstkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocstkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocstkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocstkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocstkTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocstkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocstkTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocstkTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TDocstkTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
