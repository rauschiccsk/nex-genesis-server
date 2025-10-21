unit tISDICD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';
  ixExtNum='ExtNum';
  ixDocTyp='DocTyp';

type
  TIsdicdTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetDocTyp:Str1;             procedure SetDocTyp (pValue:Str1);
    function GetDocDes:Str20;            procedure SetDocDes (pValue:Str20);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetDocVal:double;           procedure SetDocVal (pValue:double);
    function GetCrdVal:double;           procedure SetCrdVal (pValue:double);
    function GetEndVal:double;           procedure SetEndVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocExtNum (pExtNum:Str12):boolean;
    function LocDocTyp (pDocTyp:Str1):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property DocTyp:Str1 read GetDocTyp write SetDocTyp;
    property DocDes:Str20 read GetDocDes write SetDocDes;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property DocVal:double read GetDocVal write SetDocVal;
    property CrdVal:double read GetCrdVal write SetCrdVal;
    property EndVal:double read GetEndVal write SetEndVal;
  end;

implementation

constructor TIsdicdTmp.Create;
begin
  oTmpTable:=TmpInit ('ISDICD',Self);
end;

destructor TIsdicdTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIsdicdTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIsdicdTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIsdicdTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIsdicdTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIsdicdTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIsdicdTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TIsdicdTmp.GetDocTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TIsdicdTmp.SetDocTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TIsdicdTmp.GetDocDes:Str20;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TIsdicdTmp.SetDocDes(pValue:Str20);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TIsdicdTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIsdicdTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIsdicdTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TIsdicdTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIsdicdTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TIsdicdTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TIsdicdTmp.GetDocVal:double;
begin
  Result:=oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TIsdicdTmp.SetDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat:=pValue;
end;

function TIsdicdTmp.GetCrdVal:double;
begin
  Result:=oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TIsdicdTmp.SetCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat:=pValue;
end;

function TIsdicdTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TIsdicdTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIsdicdTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIsdicdTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIsdicdTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TIsdicdTmp.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result:=oTmpTable.FindKey([pExtNum]);
end;

function TIsdicdTmp.LocDocTyp(pDocTyp:Str1):boolean;
begin
  SetIndex (ixDocTyp);
  Result:=oTmpTable.FindKey([pDocTyp]);
end;

procedure TIsdicdTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIsdicdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIsdicdTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIsdicdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIsdicdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIsdicdTmp.First;
begin
  oTmpTable.First;
end;

procedure TIsdicdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIsdicdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIsdicdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIsdicdTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIsdicdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIsdicdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIsdicdTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIsdicdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIsdicdTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIsdicdTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIsdicdTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
