unit tDLRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDlrNum='';
  ixDlrNam_='DlrNam_';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TDlrlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDlrNum:word;             procedure SetDlrNum (pValue:word);
    function GetDlrNam:Str30;            procedure SetDlrNam (pValue:Str30);
    function GetDlrNam_:Str30;           procedure SetDlrNam_ (pValue:Str30);
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
    function LocDlrNum (pDlrNum:word):boolean;
    function LocDlrNam_ (pDlrNam_:Str30):boolean;
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
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property DlrNam:Str30 read GetDlrNam write SetDlrNam;
    property DlrNam_:Str30 read GetDlrNam_ write SetDlrNam_;
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

constructor TDlrlstTmp.Create;
begin
  oTmpTable:=TmpInit ('DLRLST',Self);
end;

destructor TDlrlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDlrlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TDlrlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TDlrlstTmp.GetDlrNum:word;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TDlrlstTmp.SetDlrNum(pValue:word);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TDlrlstTmp.GetDlrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('DlrNam').AsString;
end;

procedure TDlrlstTmp.SetDlrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrNam').AsString:=pValue;
end;

function TDlrlstTmp.GetDlrNam_:Str30;
begin
  Result:=oTmpTable.FieldByName('DlrNam_').AsString;
end;

procedure TDlrlstTmp.SetDlrNam_(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrNam_').AsString:=pValue;
end;

function TDlrlstTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TDlrlstTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TDlrlstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TDlrlstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TDlrlstTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TDlrlstTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TDlrlstTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TDlrlstTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TDlrlstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TDlrlstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TDlrlstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TDlrlstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TDlrlstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TDlrlstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TDlrlstTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TDlrlstTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlrlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TDlrlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TDlrlstTmp.LocDlrNum(pDlrNum:word):boolean;
begin
  SetIndex (ixDlrNum);
  Result:=oTmpTable.FindKey([pDlrNum]);
end;

function TDlrlstTmp.LocDlrNam_(pDlrNam_:Str30):boolean;
begin
  SetIndex (ixDlrNam_);
  Result:=oTmpTable.FindKey([pDlrNam_]);
end;

function TDlrlstTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TDlrlstTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TDlrlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TDlrlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDlrlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDlrlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDlrlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDlrlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TDlrlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDlrlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDlrlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDlrlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDlrlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDlrlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDlrlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDlrlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDlrlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDlrlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TDlrlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
