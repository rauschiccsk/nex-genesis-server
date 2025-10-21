unit tSHPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='';
  ixProNam='ProNam';
  ixPrfPrc='PrfPrc';
  ixPrfAva='PrfAva';
  ixSalBva='SalBva';
  ixDscAva='DscAva';
  ixSalDte='SalDte';

type
  TShplstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetYerNum:Str2;             procedure SetYerNum (pValue:Str2);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetProTyp:Str1;             procedure SetProTyp (pValue:Str1);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetRetPrq:double;           procedure SetRetPrq (pValue:double);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetRetAva:double;           procedure SetRetAva (pValue:double);
    function GetRetBva:double;           procedure SetRetBva (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
    function GetDscBva:double;           procedure SetDscBva (pValue:double);
    function GetSalDte:TDatetime;        procedure SetSalDte (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam (pProNam_:Str60):boolean;
    function LocPrfPrc (pPrfPrc:double):boolean;
    function LocPrfAva (pPrfAva:double):boolean;
    function LocSalBva (pSalBva:double):boolean;
    function LocDscAva (pDscAva:double):boolean;
    function LocSalDte (pSalDte:TDatetime):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property YerNum:Str2 read GetYerNum write SetYerNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property ProTyp:Str1 read GetProTyp write SetProTyp;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property RetPrq:double read GetRetPrq write SetRetPrq;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property StkAva:double read GetStkAva write SetStkAva;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property PrfAva:double read GetPrfAva write SetPrfAva;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property RetAva:double read GetRetAva write SetRetAva;
    property RetBva:double read GetRetBva write SetRetBva;
    property DscAva:double read GetDscAva write SetDscAva;
    property DscBva:double read GetDscBva write SetDscBva;
    property SalDte:TDatetime read GetSalDte write SetSalDte;
  end;

implementation

constructor TShplstTmp.Create;
begin
  oTmpTable:=TmpInit ('SHPLST',Self);
end;

destructor TShplstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShplstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShplstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShplstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TShplstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TShplstTmp.GetYerNum:Str2;
begin
  Result:=oTmpTable.FieldByName('YerNum').AsString;
end;

procedure TShplstTmp.SetYerNum(pValue:Str2);
begin
  oTmpTable.FieldByName('YerNum').AsString:=pValue;
end;

function TShplstTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TShplstTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TShplstTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TShplstTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TShplstTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TShplstTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TShplstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShplstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShplstTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShplstTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShplstTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShplstTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShplstTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TShplstTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TShplstTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TShplstTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TShplstTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TShplstTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TShplstTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TShplstTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TShplstTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TShplstTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TShplstTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShplstTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShplstTmp.GetRetPrq:double;
begin
  Result:=oTmpTable.FieldByName('RetPrq').AsFloat;
end;

procedure TShplstTmp.SetRetPrq(pValue:double);
begin
  oTmpTable.FieldByName('RetPrq').AsFloat:=pValue;
end;

function TShplstTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TShplstTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TShplstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShplstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShplstTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShplstTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShplstTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShplstTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShplstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShplstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShplstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShplstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShplstTmp.GetRetAva:double;
begin
  Result:=oTmpTable.FieldByName('RetAva').AsFloat;
end;

procedure TShplstTmp.SetRetAva(pValue:double);
begin
  oTmpTable.FieldByName('RetAva').AsFloat:=pValue;
end;

function TShplstTmp.GetRetBva:double;
begin
  Result:=oTmpTable.FieldByName('RetBva').AsFloat;
end;

procedure TShplstTmp.SetRetBva(pValue:double);
begin
  oTmpTable.FieldByName('RetBva').AsFloat:=pValue;
end;

function TShplstTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShplstTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TShplstTmp.GetDscBva:double;
begin
  Result:=oTmpTable.FieldByName('DscBva').AsFloat;
end;

procedure TShplstTmp.SetDscBva(pValue:double);
begin
  oTmpTable.FieldByName('DscBva').AsFloat:=pValue;
end;

function TShplstTmp.GetSalDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SalDte').AsDateTime;
end;

procedure TShplstTmp.SetSalDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDte').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShplstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShplstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShplstTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TShplstTmp.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TShplstTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShplstTmp.LocPrfAva(pPrfAva:double):boolean;
begin
  SetIndex (ixPrfAva);
  Result:=oTmpTable.FindKey([pPrfAva]);
end;

function TShplstTmp.LocSalBva(pSalBva:double):boolean;
begin
  SetIndex (ixSalBva);
  Result:=oTmpTable.FindKey([pSalBva]);
end;

function TShplstTmp.LocDscAva(pDscAva:double):boolean;
begin
  SetIndex (ixDscAva);
  Result:=oTmpTable.FindKey([pDscAva]);
end;

function TShplstTmp.LocSalDte(pSalDte:TDatetime):boolean;
begin
  SetIndex (ixSalDte);
  Result:=oTmpTable.FindKey([pSalDte]);
end;

procedure TShplstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShplstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShplstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShplstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShplstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShplstTmp.First;
begin
  oTmpTable.First;
end;

procedure TShplstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShplstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShplstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShplstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShplstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShplstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShplstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShplstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShplstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShplstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShplstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
