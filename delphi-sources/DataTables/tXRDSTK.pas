unit tXRDSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='';

type
  TXrdstkTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetActCva:double;           procedure SetActCva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocProNum (pProNum:longint):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property ActPrq:double read GetActPrq write SetActPrq;
    property ActCva:double read GetActCva write SetActCva;
  end;

implementation

constructor TXrdstkTmp.Create;
begin
  oTmpTable:=TmpInit ('XRDSTK',Self);
end;

destructor TXrdstkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TXrdstkTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TXrdstkTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TXrdstkTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TXrdstkTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXrdstkTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TXrdstkTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TXrdstkTmp.GetActCva:double;
begin
  Result:=oTmpTable.FieldByName('ActCva').AsFloat;
end;

procedure TXrdstkTmp.SetActCva(pValue:double);
begin
  oTmpTable.FieldByName('ActCva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrdstkTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TXrdstkTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TXrdstkTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

procedure TXrdstkTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TXrdstkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TXrdstkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TXrdstkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TXrdstkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TXrdstkTmp.First;
begin
  oTmpTable.First;
end;

procedure TXrdstkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TXrdstkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TXrdstkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TXrdstkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TXrdstkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TXrdstkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TXrdstkTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TXrdstkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TXrdstkTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TXrdstkTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TXrdstkTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
