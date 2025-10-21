unit tACMERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TAcmerrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetBegAcv:double;           procedure SetBegAcv (pValue:double);
    function GetCrdAcv:double;           procedure SetCrdAcv (pValue:double);
    function GetDebAcv:double;           procedure SetDebAcv (pValue:double);
    function GetEndAcv:double;           procedure SetEndAcv (pValue:double);
    function GetBegDov:double;           procedure SetBegDov (pValue:double);
    function GetCrdDov:double;           procedure SetCrdDov (pValue:double);
    function GetDebDov:double;           procedure SetDebDov (pValue:double);
    function GetEndDov:double;           procedure SetEndDov (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;

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
    property BegAcv:double read GetBegAcv write SetBegAcv;
    property CrdAcv:double read GetCrdAcv write SetCrdAcv;
    property DebAcv:double read GetDebAcv write SetDebAcv;
    property EndAcv:double read GetEndAcv write SetEndAcv;
    property BegDov:double read GetBegDov write SetBegDov;
    property CrdDov:double read GetCrdDov write SetCrdDov;
    property DebDov:double read GetDebDov write SetDebDov;
    property EndDov:double read GetEndDov write SetEndDov;
    property DifVal:double read GetDifVal write SetDifVal;
  end;

implementation

constructor TAcmerrTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMERR',Self);
end;

destructor TAcmerrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcmerrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcmerrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcmerrTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAcmerrTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TAcmerrTmp.GetBegAcv:double;
begin
  Result:=oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TAcmerrTmp.SetBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat:=pValue;
end;

function TAcmerrTmp.GetCrdAcv:double;
begin
  Result:=oTmpTable.FieldByName('CrdAcv').AsFloat;
end;

procedure TAcmerrTmp.SetCrdAcv(pValue:double);
begin
  oTmpTable.FieldByName('CrdAcv').AsFloat:=pValue;
end;

function TAcmerrTmp.GetDebAcv:double;
begin
  Result:=oTmpTable.FieldByName('DebAcv').AsFloat;
end;

procedure TAcmerrTmp.SetDebAcv(pValue:double);
begin
  oTmpTable.FieldByName('DebAcv').AsFloat:=pValue;
end;

function TAcmerrTmp.GetEndAcv:double;
begin
  Result:=oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TAcmerrTmp.SetEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat:=pValue;
end;

function TAcmerrTmp.GetBegDov:double;
begin
  Result:=oTmpTable.FieldByName('BegDov').AsFloat;
end;

procedure TAcmerrTmp.SetBegDov(pValue:double);
begin
  oTmpTable.FieldByName('BegDov').AsFloat:=pValue;
end;

function TAcmerrTmp.GetCrdDov:double;
begin
  Result:=oTmpTable.FieldByName('CrdDov').AsFloat;
end;

procedure TAcmerrTmp.SetCrdDov(pValue:double);
begin
  oTmpTable.FieldByName('CrdDov').AsFloat:=pValue;
end;

function TAcmerrTmp.GetDebDov:double;
begin
  Result:=oTmpTable.FieldByName('DebDov').AsFloat;
end;

procedure TAcmerrTmp.SetDebDov(pValue:double);
begin
  oTmpTable.FieldByName('DebDov').AsFloat:=pValue;
end;

function TAcmerrTmp.GetEndDov:double;
begin
  Result:=oTmpTable.FieldByName('EndDov').AsFloat;
end;

procedure TAcmerrTmp.SetEndDov(pValue:double);
begin
  oTmpTable.FieldByName('EndDov').AsFloat:=pValue;
end;

function TAcmerrTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TAcmerrTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcmerrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcmerrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcmerrTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TAcmerrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcmerrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcmerrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcmerrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcmerrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcmerrTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcmerrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcmerrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcmerrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcmerrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcmerrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcmerrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcmerrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcmerrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcmerrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcmerrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcmerrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
