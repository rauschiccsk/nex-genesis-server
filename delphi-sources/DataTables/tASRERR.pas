unit tASRERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnSn='';
  ixDifVal='DifVal';

type
  TAsrerrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetStmSmo:word;             procedure SetStmSmo (pValue:word);
    function GetStmSnt:Str3;             procedure SetStmSnt (pValue:Str3);
    function GetStmAnl:Str6;             procedure SetStmAnl (pValue:Str6);
    function GetStmVal:double;           procedure SetStmVal (pValue:double);
    function GetJrnSmo:word;             procedure SetJrnSmo (pValue:word);
    function GetJrnSnt:Str3;             procedure SetJrnSnt (pValue:Str3);
    function GetJrnAnl:Str6;             procedure SetJrnAnl (pValue:Str6);
    function GetJrnVal:double;           procedure SetJrnVal (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
    function GetCrdVal:double;           procedure SetCrdVal (pValue:double);
    function GetDebVal:double;           procedure SetDebVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDnSn (pDocNum:Str12;pStkNum:word):boolean;
    function LocDifVal (pDifVal:double):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property StmSmo:word read GetStmSmo write SetStmSmo;
    property StmSnt:Str3 read GetStmSnt write SetStmSnt;
    property StmAnl:Str6 read GetStmAnl write SetStmAnl;
    property StmVal:double read GetStmVal write SetStmVal;
    property JrnSmo:word read GetJrnSmo write SetJrnSmo;
    property JrnSnt:Str3 read GetJrnSnt write SetJrnSnt;
    property JrnAnl:Str6 read GetJrnAnl write SetJrnAnl;
    property JrnVal:double read GetJrnVal write SetJrnVal;
    property DifVal:double read GetDifVal write SetDifVal;
    property CrdVal:double read GetCrdVal write SetCrdVal;
    property DebVal:double read GetDebVal write SetDebVal;
  end;

implementation

constructor TAsrerrTmp.Create;
begin
  oTmpTable:=TmpInit ('ASRERR',Self);
end;

destructor TAsrerrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAsrerrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAsrerrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAsrerrTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAsrerrTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TAsrerrTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAsrerrTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAsrerrTmp.GetStmSmo:word;
begin
  Result:=oTmpTable.FieldByName('StmSmo').AsInteger;
end;

procedure TAsrerrTmp.SetStmSmo(pValue:word);
begin
  oTmpTable.FieldByName('StmSmo').AsInteger:=pValue;
end;

function TAsrerrTmp.GetStmSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('StmSnt').AsString;
end;

procedure TAsrerrTmp.SetStmSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('StmSnt').AsString:=pValue;
end;

function TAsrerrTmp.GetStmAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('StmAnl').AsString;
end;

procedure TAsrerrTmp.SetStmAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('StmAnl').AsString:=pValue;
end;

function TAsrerrTmp.GetStmVal:double;
begin
  Result:=oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TAsrerrTmp.SetStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat:=pValue;
end;

function TAsrerrTmp.GetJrnSmo:word;
begin
  Result:=oTmpTable.FieldByName('JrnSmo').AsInteger;
end;

procedure TAsrerrTmp.SetJrnSmo(pValue:word);
begin
  oTmpTable.FieldByName('JrnSmo').AsInteger:=pValue;
end;

function TAsrerrTmp.GetJrnSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('JrnSnt').AsString;
end;

procedure TAsrerrTmp.SetJrnSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('JrnSnt').AsString:=pValue;
end;

function TAsrerrTmp.GetJrnAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('JrnAnl').AsString;
end;

procedure TAsrerrTmp.SetJrnAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('JrnAnl').AsString:=pValue;
end;

function TAsrerrTmp.GetJrnVal:double;
begin
  Result:=oTmpTable.FieldByName('JrnVal').AsFloat;
end;

procedure TAsrerrTmp.SetJrnVal(pValue:double);
begin
  oTmpTable.FieldByName('JrnVal').AsFloat:=pValue;
end;

function TAsrerrTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TAsrerrTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

function TAsrerrTmp.GetCrdVal:double;
begin
  Result:=oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TAsrerrTmp.SetCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat:=pValue;
end;

function TAsrerrTmp.GetDebVal:double;
begin
  Result:=oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TAsrerrTmp.SetDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAsrerrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAsrerrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAsrerrTmp.LocDnSn(pDocNum:Str12;pStkNum:word):boolean;
begin
  SetIndex (ixDnSn);
  Result:=oTmpTable.FindKey([pDocNum,pStkNum]);
end;

function TAsrerrTmp.LocDifVal(pDifVal:double):boolean;
begin
  SetIndex (ixDifVal);
  Result:=oTmpTable.FindKey([pDifVal]);
end;

procedure TAsrerrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAsrerrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAsrerrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAsrerrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAsrerrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAsrerrTmp.First;
begin
  oTmpTable.First;
end;

procedure TAsrerrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAsrerrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAsrerrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAsrerrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAsrerrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAsrerrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAsrerrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAsrerrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAsrerrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAsrerrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAsrerrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
