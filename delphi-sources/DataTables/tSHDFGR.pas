unit tSHDFGR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgrNum='';
  ixFgrNam_='FgrNam_';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TShdfgrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetFgrNam:Str30;            procedure SetFgrNam (pValue:Str30);
    function GetFgrNam_:Str30;           procedure SetFgrNam_ (pValue:Str30);
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
    function LocFgrNum (pFgrNum:word):boolean;
    function LocFgrNam_ (pFgrNam_:Str30):boolean;
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
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property FgrNam:Str30 read GetFgrNam write SetFgrNam;
    property FgrNam_:Str30 read GetFgrNam_ write SetFgrNam_;
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

constructor TShdfgrTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDFGR',Self);
end;

destructor TShdfgrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShdfgrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShdfgrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShdfgrTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShdfgrTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShdfgrTmp.GetFgrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('FgrNam').AsString;
end;

procedure TShdfgrTmp.SetFgrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('FgrNam').AsString:=pValue;
end;

function TShdfgrTmp.GetFgrNam_:Str30;
begin
  Result:=oTmpTable.FieldByName('FgrNam_').AsString;
end;

procedure TShdfgrTmp.SetFgrNam_(pValue:Str30);
begin
  oTmpTable.FieldByName('FgrNam_').AsString:=pValue;
end;

function TShdfgrTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShdfgrTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShdfgrTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShdfgrTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShdfgrTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShdfgrTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShdfgrTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShdfgrTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShdfgrTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShdfgrTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShdfgrTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShdfgrTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShdfgrTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShdfgrTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShdfgrTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShdfgrTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdfgrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShdfgrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShdfgrTmp.LocFgrNum(pFgrNum:word):boolean;
begin
  SetIndex (ixFgrNum);
  Result:=oTmpTable.FindKey([pFgrNum]);
end;

function TShdfgrTmp.LocFgrNam_(pFgrNam_:Str30):boolean;
begin
  SetIndex (ixFgrNam_);
  Result:=oTmpTable.FindKey([pFgrNam_]);
end;

function TShdfgrTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShdfgrTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TShdfgrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShdfgrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShdfgrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShdfgrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShdfgrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShdfgrTmp.First;
begin
  oTmpTable.First;
end;

procedure TShdfgrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShdfgrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShdfgrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShdfgrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShdfgrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShdfgrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShdfgrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShdfgrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShdfgrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShdfgrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShdfgrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
