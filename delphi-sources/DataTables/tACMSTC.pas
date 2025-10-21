unit tACMSTC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStPn='';
  ixProNam_='ProNam_';

type
  TAcmstcTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetBegPrq:double;           procedure SetBegPrq (pValue:double);
    function GetIncPrq:double;           procedure SetIncPrq (pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetEndPrq:double;           procedure SetEndPrq (pValue:double);
    function GetBegVal:double;           procedure SetBegVal (pValue:double);
    function GetIncVal:double;           procedure SetIncVal (pValue:double);
    function GetOutVal:double;           procedure SetOutVal (pValue:double);
    function GetEndVal:double;           procedure SetEndVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocStPn (pStkNum:word;pProNum:longint):boolean;
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
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BegPrq:double read GetBegPrq write SetBegPrq;
    property IncPrq:double read GetIncPrq write SetIncPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property EndPrq:double read GetEndPrq write SetEndPrq;
    property BegVal:double read GetBegVal write SetBegVal;
    property IncVal:double read GetIncVal write SetIncVal;
    property OutVal:double read GetOutVal write SetOutVal;
    property EndVal:double read GetEndVal write SetEndVal;
  end;

implementation

constructor TAcmstcTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMSTC',Self);
end;

destructor TAcmstcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcmstcTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcmstcTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcmstcTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAcmstcTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAcmstcTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TAcmstcTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TAcmstcTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TAcmstcTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TAcmstcTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TAcmstcTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TAcmstcTmp.GetBegPrq:double;
begin
  Result:=oTmpTable.FieldByName('BegPrq').AsFloat;
end;

procedure TAcmstcTmp.SetBegPrq(pValue:double);
begin
  oTmpTable.FieldByName('BegPrq').AsFloat:=pValue;
end;

function TAcmstcTmp.GetIncPrq:double;
begin
  Result:=oTmpTable.FieldByName('IncPrq').AsFloat;
end;

procedure TAcmstcTmp.SetIncPrq(pValue:double);
begin
  oTmpTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TAcmstcTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TAcmstcTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TAcmstcTmp.GetEndPrq:double;
begin
  Result:=oTmpTable.FieldByName('EndPrq').AsFloat;
end;

procedure TAcmstcTmp.SetEndPrq(pValue:double);
begin
  oTmpTable.FieldByName('EndPrq').AsFloat:=pValue;
end;

function TAcmstcTmp.GetBegVal:double;
begin
  Result:=oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TAcmstcTmp.SetBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat:=pValue;
end;

function TAcmstcTmp.GetIncVal:double;
begin
  Result:=oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TAcmstcTmp.SetIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat:=pValue;
end;

function TAcmstcTmp.GetOutVal:double;
begin
  Result:=oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TAcmstcTmp.SetOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat:=pValue;
end;

function TAcmstcTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TAcmstcTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcmstcTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcmstcTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcmstcTmp.LocStPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex (ixStPn);
  Result:=oTmpTable.FindKey([pStkNum,pProNum]);
end;

function TAcmstcTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TAcmstcTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcmstcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcmstcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcmstcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcmstcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcmstcTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcmstcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcmstcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcmstcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcmstcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcmstcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcmstcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcmstcTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcmstcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcmstcTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcmstcTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcmstcTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
