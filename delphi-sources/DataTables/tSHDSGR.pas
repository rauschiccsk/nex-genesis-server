unit tSHDSGR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSgrNum='';
  ixSgrNam_='SgrNam_';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TShdsgrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetSgrNam:Str30;            procedure SetSgrNam (pValue:Str30);
    function GetSgrNam_:Str30;           procedure SetSgrNam_ (pValue:Str30);
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
    function LocSgrNum (pSgrNum:word):boolean;
    function LocSgrNam_ (pSgrNam_:Str30):boolean;
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
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property SgrNam:Str30 read GetSgrNam write SetSgrNam;
    property SgrNam_:Str30 read GetSgrNam_ write SetSgrNam_;
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

constructor TShdsgrTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDSGR',Self);
end;

destructor TShdsgrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShdsgrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShdsgrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShdsgrTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShdsgrTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShdsgrTmp.GetSgrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('SgrNam').AsString;
end;

procedure TShdsgrTmp.SetSgrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('SgrNam').AsString:=pValue;
end;

function TShdsgrTmp.GetSgrNam_:Str30;
begin
  Result:=oTmpTable.FieldByName('SgrNam_').AsString;
end;

procedure TShdsgrTmp.SetSgrNam_(pValue:Str30);
begin
  oTmpTable.FieldByName('SgrNam_').AsString:=pValue;
end;

function TShdsgrTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShdsgrTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShdsgrTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShdsgrTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShdsgrTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShdsgrTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShdsgrTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShdsgrTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShdsgrTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShdsgrTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShdsgrTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShdsgrTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShdsgrTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShdsgrTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShdsgrTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShdsgrTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdsgrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShdsgrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShdsgrTmp.LocSgrNum(pSgrNum:word):boolean;
begin
  SetIndex (ixSgrNum);
  Result:=oTmpTable.FindKey([pSgrNum]);
end;

function TShdsgrTmp.LocSgrNam_(pSgrNam_:Str30):boolean;
begin
  SetIndex (ixSgrNam_);
  Result:=oTmpTable.FindKey([pSgrNam_]);
end;

function TShdsgrTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShdsgrTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TShdsgrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShdsgrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShdsgrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShdsgrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShdsgrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShdsgrTmp.First;
begin
  oTmpTable.First;
end;

procedure TShdsgrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShdsgrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShdsgrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShdsgrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShdsgrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShdsgrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShdsgrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShdsgrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShdsgrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShdsgrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShdsgrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
