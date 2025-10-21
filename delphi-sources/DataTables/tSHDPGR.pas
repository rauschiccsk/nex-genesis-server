unit tSHDPGR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPgrNum='';
  ixPgrNam_='PgrNam_';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TShdpgrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetPgrNam:Str30;            procedure SetPgrNam (pValue:Str30);
    function GetPgrNam_:Str30;           procedure SetPgrNam_ (pValue:Str30);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocPgrNam_ (pPgrNam_:Str30):boolean;
    function LocPrfPrc (pPrfPrc:double):boolean;
    function LocDscPrc (pDscPrc:double):boolean;

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
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property PgrNam:Str30 read GetPgrNam write SetPgrNam;
    property PgrNam_:Str30 read GetPgrNam_ write SetPgrNam_;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property StkAva:double read GetStkAva write SetStkAva;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property PrfAva:double read GetPrfAva write SetPrfAva;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
  end;

implementation

constructor TShdpgrTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDPGR',Self);
end;

destructor TShdpgrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShdpgrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShdpgrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShdpgrTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShdpgrTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShdpgrTmp.GetPgrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('PgrNam').AsString;
end;

procedure TShdpgrTmp.SetPgrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('PgrNam').AsString:=pValue;
end;

function TShdpgrTmp.GetPgrNam_:Str30;
begin
  Result:=oTmpTable.FieldByName('PgrNam_').AsString;
end;

procedure TShdpgrTmp.SetPgrNam_(pValue:Str30);
begin
  oTmpTable.FieldByName('PgrNam_').AsString:=pValue;
end;

function TShdpgrTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShdpgrTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShdpgrTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShdpgrTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShdpgrTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShdpgrTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShdpgrTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShdpgrTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShdpgrTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShdpgrTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShdpgrTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShdpgrTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShdpgrTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShdpgrTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShdpgrTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShdpgrTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdpgrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShdpgrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShdpgrTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TShdpgrTmp.LocPgrNam_(pPgrNam_:Str30):boolean;
begin
  SetIndex (ixPgrNam_);
  Result:=oTmpTable.FindKey([pPgrNam_]);
end;

function TShdpgrTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShdpgrTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TShdpgrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShdpgrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShdpgrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShdpgrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShdpgrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShdpgrTmp.First;
begin
  oTmpTable.First;
end;

procedure TShdpgrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShdpgrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShdpgrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShdpgrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShdpgrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShdpgrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShdpgrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShdpgrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShdpgrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShdpgrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShdpgrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
