unit tACMSTN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSmoNum='';

type
  TAcmstnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetSmoNum:word;             procedure SetSmoNum (pValue:word);
    function GetSmoNam:Str30;            procedure SetSmoNam (pValue:Str30);
    function GetSmoTyp:Str1;             procedure SetSmoTyp (pValue:Str1);
    function GetBegPrq:double;           procedure SetBegPrq (pValue:double);
    function GetIncPrq:double;           procedure SetIncPrq (pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetEndPrq:double;           procedure SetEndPrq (pValue:double);
    function GetBegAcv:double;           procedure SetBegAcv (pValue:double);
    function GetIncAcv:double;           procedure SetIncAcv (pValue:double);
    function GetOutAcv:double;           procedure SetOutAcv (pValue:double);
    function GetEndAcv:double;           procedure SetEndAcv (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSmoNum (pSmoNum:word):boolean;

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
    property SmoNum:word read GetSmoNum write SetSmoNum;
    property SmoNam:Str30 read GetSmoNam write SetSmoNam;
    property SmoTyp:Str1 read GetSmoTyp write SetSmoTyp;
    property BegPrq:double read GetBegPrq write SetBegPrq;
    property IncPrq:double read GetIncPrq write SetIncPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property EndPrq:double read GetEndPrq write SetEndPrq;
    property BegAcv:double read GetBegAcv write SetBegAcv;
    property IncAcv:double read GetIncAcv write SetIncAcv;
    property OutAcv:double read GetOutAcv write SetOutAcv;
    property EndAcv:double read GetEndAcv write SetEndAcv;
  end;

implementation

constructor TAcmstnTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMSTN',Self);
end;

destructor TAcmstnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcmstnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcmstnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcmstnTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAcmstnTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAcmstnTmp.GetSmoNam:Str30;
begin
  Result:=oTmpTable.FieldByName('SmoNam').AsString;
end;

procedure TAcmstnTmp.SetSmoNam(pValue:Str30);
begin
  oTmpTable.FieldByName('SmoNam').AsString:=pValue;
end;

function TAcmstnTmp.GetSmoTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('SmoTyp').AsString;
end;

procedure TAcmstnTmp.SetSmoTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('SmoTyp').AsString:=pValue;
end;

function TAcmstnTmp.GetBegPrq:double;
begin
  Result:=oTmpTable.FieldByName('BegPrq').AsFloat;
end;

procedure TAcmstnTmp.SetBegPrq(pValue:double);
begin
  oTmpTable.FieldByName('BegPrq').AsFloat:=pValue;
end;

function TAcmstnTmp.GetIncPrq:double;
begin
  Result:=oTmpTable.FieldByName('IncPrq').AsFloat;
end;

procedure TAcmstnTmp.SetIncPrq(pValue:double);
begin
  oTmpTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TAcmstnTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TAcmstnTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TAcmstnTmp.GetEndPrq:double;
begin
  Result:=oTmpTable.FieldByName('EndPrq').AsFloat;
end;

procedure TAcmstnTmp.SetEndPrq(pValue:double);
begin
  oTmpTable.FieldByName('EndPrq').AsFloat:=pValue;
end;

function TAcmstnTmp.GetBegAcv:double;
begin
  Result:=oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TAcmstnTmp.SetBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat:=pValue;
end;

function TAcmstnTmp.GetIncAcv:double;
begin
  Result:=oTmpTable.FieldByName('IncAcv').AsFloat;
end;

procedure TAcmstnTmp.SetIncAcv(pValue:double);
begin
  oTmpTable.FieldByName('IncAcv').AsFloat:=pValue;
end;

function TAcmstnTmp.GetOutAcv:double;
begin
  Result:=oTmpTable.FieldByName('OutAcv').AsFloat;
end;

procedure TAcmstnTmp.SetOutAcv(pValue:double);
begin
  oTmpTable.FieldByName('OutAcv').AsFloat:=pValue;
end;

function TAcmstnTmp.GetEndAcv:double;
begin
  Result:=oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TAcmstnTmp.SetEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcmstnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcmstnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcmstnTmp.LocSmoNum(pSmoNum:word):boolean;
begin
  SetIndex (ixSmoNum);
  Result:=oTmpTable.FindKey([pSmoNum]);
end;

procedure TAcmstnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcmstnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcmstnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcmstnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcmstnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcmstnTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcmstnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcmstnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcmstnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcmstnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcmstnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcmstnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcmstnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcmstnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcmstnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcmstnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcmstnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
