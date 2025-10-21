unit tOCRCHG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDaIa='';
  ixItmNum='ItmNum';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TOcrchgTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocAdr:longint;          procedure SetDocAdr (pValue:longint);
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetActRst:double;           procedure SetActRst (pValue:double);
    function GetActRos:double;           procedure SetActRos (pValue:double);
    function GetActRes:double;           procedure SetActRes (pValue:double);
    function GetActDte:TDatetime;        procedure SetActDte (pValue:TDatetime);
    function GetChgRst:double;           procedure SetChgRst (pValue:double);
    function GetChgRos:double;           procedure SetChgRos (pValue:double);
    function GetChgRes:double;           procedure SetChgRes (pValue:double);
    function GetChgDte:TDatetime;        procedure SetChgDte (pValue:TDatetime);
    function GetBetRst:double;           procedure SetBetRst (pValue:double);
    function GetBetRos:double;           procedure SetBetRos (pValue:double);
    function GetBetRes:double;           procedure SetBetRes (pValue:double);
    function GetBetDte:TDatetime;        procedure SetBetDte (pValue:TDatetime);
    function GetNotPrq:double;           procedure SetNotPrq (pValue:double);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDaIa (pDocAdr:longint;pItmAdr:longint):boolean;
    function LocItmNum (pItmNum:word):boolean;
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
    property DocAdr:longint read GetDocAdr write SetDocAdr;
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property ActRst:double read GetActRst write SetActRst;
    property ActRos:double read GetActRos write SetActRos;
    property ActRes:double read GetActRes write SetActRes;
    property ActDte:TDatetime read GetActDte write SetActDte;
    property ChgRst:double read GetChgRst write SetChgRst;
    property ChgRos:double read GetChgRos write SetChgRos;
    property ChgRes:double read GetChgRes write SetChgRes;
    property ChgDte:TDatetime read GetChgDte write SetChgDte;
    property BetRst:double read GetBetRst write SetBetRst;
    property BetRos:double read GetBetRos write SetBetRos;
    property BetRes:double read GetBetRes write SetBetRes;
    property BetDte:TDatetime read GetBetDte write SetBetDte;
    property NotPrq:double read GetNotPrq write SetNotPrq;
    property Notice:Str50 read GetNotice write SetNotice;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOcrchgTmp.Create;
begin
  oTmpTable:=TmpInit ('OCRCHG',Self);
end;

destructor TOcrchgTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcrchgTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcrchgTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcrchgTmp.GetDocAdr:longint;
begin
  Result:=oTmpTable.FieldByName('DocAdr').AsInteger;
end;

procedure TOcrchgTmp.SetDocAdr(pValue:longint);
begin
  oTmpTable.FieldByName('DocAdr').AsInteger:=pValue;
end;

function TOcrchgTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOcrchgTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOcrchgTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOcrchgTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOcrchgTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOcrchgTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOcrchgTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOcrchgTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOcrchgTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOcrchgTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOcrchgTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcrchgTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcrchgTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcrchgTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcrchgTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOcrchgTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcrchgTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOcrchgTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcrchgTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOcrchgTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOcrchgTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOcrchgTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOcrchgTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOcrchgTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOcrchgTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOcrchgTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOcrchgTmp.GetActRst:double;
begin
  Result:=oTmpTable.FieldByName('ActRst').AsFloat;
end;

procedure TOcrchgTmp.SetActRst(pValue:double);
begin
  oTmpTable.FieldByName('ActRst').AsFloat:=pValue;
end;

function TOcrchgTmp.GetActRos:double;
begin
  Result:=oTmpTable.FieldByName('ActRos').AsFloat;
end;

procedure TOcrchgTmp.SetActRos(pValue:double);
begin
  oTmpTable.FieldByName('ActRos').AsFloat:=pValue;
end;

function TOcrchgTmp.GetActRes:double;
begin
  Result:=oTmpTable.FieldByName('ActRes').AsFloat;
end;

procedure TOcrchgTmp.SetActRes(pValue:double);
begin
  oTmpTable.FieldByName('ActRes').AsFloat:=pValue;
end;

function TOcrchgTmp.GetActDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ActDte').AsDateTime;
end;

procedure TOcrchgTmp.SetActDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ActDte').AsDateTime:=pValue;
end;

function TOcrchgTmp.GetChgRst:double;
begin
  Result:=oTmpTable.FieldByName('ChgRst').AsFloat;
end;

procedure TOcrchgTmp.SetChgRst(pValue:double);
begin
  oTmpTable.FieldByName('ChgRst').AsFloat:=pValue;
end;

function TOcrchgTmp.GetChgRos:double;
begin
  Result:=oTmpTable.FieldByName('ChgRos').AsFloat;
end;

procedure TOcrchgTmp.SetChgRos(pValue:double);
begin
  oTmpTable.FieldByName('ChgRos').AsFloat:=pValue;
end;

function TOcrchgTmp.GetChgRes:double;
begin
  Result:=oTmpTable.FieldByName('ChgRes').AsFloat;
end;

procedure TOcrchgTmp.SetChgRes(pValue:double);
begin
  oTmpTable.FieldByName('ChgRes').AsFloat:=pValue;
end;

function TOcrchgTmp.GetChgDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ChgDte').AsDateTime;
end;

procedure TOcrchgTmp.SetChgDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ChgDte').AsDateTime:=pValue;
end;

function TOcrchgTmp.GetBetRst:double;
begin
  Result:=oTmpTable.FieldByName('BetRst').AsFloat;
end;

procedure TOcrchgTmp.SetBetRst(pValue:double);
begin
  oTmpTable.FieldByName('BetRst').AsFloat:=pValue;
end;

function TOcrchgTmp.GetBetRos:double;
begin
  Result:=oTmpTable.FieldByName('BetRos').AsFloat;
end;

procedure TOcrchgTmp.SetBetRos(pValue:double);
begin
  oTmpTable.FieldByName('BetRos').AsFloat:=pValue;
end;

function TOcrchgTmp.GetBetRes:double;
begin
  Result:=oTmpTable.FieldByName('BetRes').AsFloat;
end;

procedure TOcrchgTmp.SetBetRes(pValue:double);
begin
  oTmpTable.FieldByName('BetRes').AsFloat:=pValue;
end;

function TOcrchgTmp.GetBetDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('BetDte').AsDateTime;
end;

procedure TOcrchgTmp.SetBetDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BetDte').AsDateTime:=pValue;
end;

function TOcrchgTmp.GetNotPrq:double;
begin
  Result:=oTmpTable.FieldByName('NotPrq').AsFloat;
end;

procedure TOcrchgTmp.SetNotPrq(pValue:double);
begin
  oTmpTable.FieldByName('NotPrq').AsFloat:=pValue;
end;

function TOcrchgTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOcrchgTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOcrchgTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOcrchgTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcrchgTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcrchgTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcrchgTmp.LocDaIa(pDocAdr:longint;pItmAdr:longint):boolean;
begin
  SetIndex (ixDaIa);
  Result:=oTmpTable.FindKey([pDocAdr,pItmAdr]);
end;

function TOcrchgTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TOcrchgTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOcrchgTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TOcrchgTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcrchgTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcrchgTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcrchgTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcrchgTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcrchgTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcrchgTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcrchgTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcrchgTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcrchgTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcrchgTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcrchgTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcrchgTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcrchgTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcrchgTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcrchgTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcrchgTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
