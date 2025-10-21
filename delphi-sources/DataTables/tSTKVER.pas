unit tSTKVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt='';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TStkverTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetDocPrq:double;           procedure SetDocPrq (pValue:double);
    function GetDocVal:double;           procedure SetDocVal (pValue:double);
    function GetStmPro:longint;          procedure SetStmPro (pValue:longint);
    function GetStmStn:word;             procedure SetStmStn (pValue:word);
    function GetStmPrq:double;           procedure SetStmPrq (pValue:double);
    function GetStmVal:double;           procedure SetStmVal (pValue:double);
    function GetFifPro:longint;          procedure SetFifPro (pValue:longint);
    function GetFifStn:word;             procedure SetFifStn (pValue:word);
    function GetFifPrq:double;           procedure SetFifPrq (pValue:double);
    function GetFifVal:double;           procedure SetFifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;

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
    property ItmNum:longint read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property StkNum:word read GetStkNum write SetStkNum;
    property DocPrq:double read GetDocPrq write SetDocPrq;
    property DocVal:double read GetDocVal write SetDocVal;
    property StmPro:longint read GetStmPro write SetStmPro;
    property StmStn:word read GetStmStn write SetStmStn;
    property StmPrq:double read GetStmPrq write SetStmPrq;
    property StmVal:double read GetStmVal write SetStmVal;
    property FifPro:longint read GetFifPro write SetFifPro;
    property FifStn:word read GetFifStn write SetFifStn;
    property FifPrq:double read GetFifPrq write SetFifPrq;
    property FifVal:double read GetFifVal write SetFifVal;
  end;

implementation

constructor TStkverTmp.Create;
begin
  oTmpTable:=TmpInit ('STKVER',Self);
end;

destructor TStkverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkverTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkverTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkverTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStkverTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkverTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkverTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkverTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkverTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkverTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TStkverTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TStkverTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TStkverTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TStkverTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkverTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkverTmp.GetDocPrq:double;
begin
  Result:=oTmpTable.FieldByName('DocPrq').AsFloat;
end;

procedure TStkverTmp.SetDocPrq(pValue:double);
begin
  oTmpTable.FieldByName('DocPrq').AsFloat:=pValue;
end;

function TStkverTmp.GetDocVal:double;
begin
  Result:=oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TStkverTmp.SetDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat:=pValue;
end;

function TStkverTmp.GetStmPro:longint;
begin
  Result:=oTmpTable.FieldByName('StmPro').AsInteger;
end;

procedure TStkverTmp.SetStmPro(pValue:longint);
begin
  oTmpTable.FieldByName('StmPro').AsInteger:=pValue;
end;

function TStkverTmp.GetStmStn:word;
begin
  Result:=oTmpTable.FieldByName('StmStn').AsInteger;
end;

procedure TStkverTmp.SetStmStn(pValue:word);
begin
  oTmpTable.FieldByName('StmStn').AsInteger:=pValue;
end;

function TStkverTmp.GetStmPrq:double;
begin
  Result:=oTmpTable.FieldByName('StmPrq').AsFloat;
end;

procedure TStkverTmp.SetStmPrq(pValue:double);
begin
  oTmpTable.FieldByName('StmPrq').AsFloat:=pValue;
end;

function TStkverTmp.GetStmVal:double;
begin
  Result:=oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TStkverTmp.SetStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat:=pValue;
end;

function TStkverTmp.GetFifPro:longint;
begin
  Result:=oTmpTable.FieldByName('FifPro').AsInteger;
end;

procedure TStkverTmp.SetFifPro(pValue:longint);
begin
  oTmpTable.FieldByName('FifPro').AsInteger:=pValue;
end;

function TStkverTmp.GetFifStn:word;
begin
  Result:=oTmpTable.FieldByName('FifStn').AsInteger;
end;

procedure TStkverTmp.SetFifStn(pValue:word);
begin
  oTmpTable.FieldByName('FifStn').AsInteger:=pValue;
end;

function TStkverTmp.GetFifPrq:double;
begin
  Result:=oTmpTable.FieldByName('FifPrq').AsFloat;
end;

procedure TStkverTmp.SetFifPrq(pValue:double);
begin
  oTmpTable.FieldByName('FifPrq').AsFloat:=pValue;
end;

function TStkverTmp.GetFifVal:double;
begin
  Result:=oTmpTable.FieldByName('FifVal').AsFloat;
end;

procedure TStkverTmp.SetFifVal(pValue:double);
begin
  oTmpTable.FieldByName('FifVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkverTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkverTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkverTmp.LocDoIt(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStkverTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TStkverTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TStkverTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkverTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkverTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkverTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkverTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkverTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
