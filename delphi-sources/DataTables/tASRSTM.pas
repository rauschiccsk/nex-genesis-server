unit tASRSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnDtSo='';

type
  TAsrstmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetDocTyp:Str2;             procedure SetDocTyp (pValue:Str2);
    function GetSmoNum:word;             procedure SetSmoNum (pValue:word);
    function GetStmVal:double;           procedure SetStmVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSnDtSo (pStkNum:word;pDocTyp:Str2;pSmoNum:word):boolean;

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
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property SmoNum:word read GetSmoNum write SetSmoNum;
    property StmVal:double read GetStmVal write SetStmVal;
  end;

implementation

constructor TAsrstmTmp.Create;
begin
  oTmpTable:=TmpInit ('ASRSTM',Self);
end;

destructor TAsrstmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAsrstmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAsrstmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAsrstmTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAsrstmTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAsrstmTmp.GetDocTyp:Str2;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TAsrstmTmp.SetDocTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TAsrstmTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAsrstmTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAsrstmTmp.GetStmVal:double;
begin
  Result:=oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TAsrstmTmp.SetStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAsrstmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAsrstmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAsrstmTmp.LocSnDtSo(pStkNum:word;pDocTyp:Str2;pSmoNum:word):boolean;
begin
  SetIndex (ixSnDtSo);
  Result:=oTmpTable.FindKey([pStkNum,pDocTyp,pSmoNum]);
end;

procedure TAsrstmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAsrstmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAsrstmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAsrstmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAsrstmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAsrstmTmp.First;
begin
  oTmpTable.First;
end;

procedure TAsrstmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAsrstmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAsrstmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAsrstmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAsrstmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAsrstmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAsrstmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAsrstmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAsrstmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAsrstmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAsrstmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
