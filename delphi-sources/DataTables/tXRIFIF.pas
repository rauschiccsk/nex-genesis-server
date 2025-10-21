unit tXRIFIF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum='';

type
  TXrififTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetFifNum:longint;          procedure SetFifNum (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetActCva:double;           procedure SetActCva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocFifNum (pFifNum:longint):boolean;

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
    property FifNum:longint read GetFifNum write SetFifNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property ActPrq:double read GetActPrq write SetActPrq;
    property ActCva:double read GetActCva write SetActCva;
  end;

implementation

constructor TXrififTmp.Create;
begin
  oTmpTable:=TmpInit ('XRIFIF',Self);
end;

destructor TXrififTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TXrififTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TXrififTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TXrififTmp.GetFifNum:longint;
begin
  Result:=oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TXrififTmp.SetFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TXrififTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TXrififTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TXrififTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TXrififTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TXrififTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TXrififTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TXrififTmp.GetActCva:double;
begin
  Result:=oTmpTable.FieldByName('ActCva').AsFloat;
end;

procedure TXrififTmp.SetActCva(pValue:double);
begin
  oTmpTable.FieldByName('ActCva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrififTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TXrififTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TXrififTmp.LocFifNum(pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result:=oTmpTable.FindKey([pFifNum]);
end;

procedure TXrififTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TXrififTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TXrififTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TXrififTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TXrififTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TXrififTmp.First;
begin
  oTmpTable.First;
end;

procedure TXrififTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TXrififTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TXrififTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TXrififTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TXrififTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TXrififTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TXrififTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TXrififTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TXrififTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TXrififTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TXrififTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
