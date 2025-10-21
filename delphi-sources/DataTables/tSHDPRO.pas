unit tSHDPRO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='';
  ixProNam_='ProNam_';
  ixPgrNum='PgrNum';
  ixFgrNum='FgrNum';
  ixSgrNum='SgrNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TShdproTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocFgrNum (pFgrNum:word):boolean;
    function LocSgrNum (pSgrNum:word):boolean;
    function LocBarCod (pBarCod:Str15):boolean;
    function LocStkCod (pStkCod:Str15):boolean;
    function LocShpCod (pShpCod:Str30):boolean;
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
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property StkAva:double read GetStkAva write SetStkAva;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property PrfAva:double read GetPrfAva write SetPrfAva;
    property SalApc:double read GetSalApc write SetSalApc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
  end;

implementation

constructor TShdproTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDPRO',Self);
end;

destructor TShdproTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShdproTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShdproTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShdproTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TShdproTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TShdproTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TShdproTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TShdproTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TShdproTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TShdproTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShdproTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShdproTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShdproTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShdproTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShdproTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShdproTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TShdproTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TShdproTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TShdproTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TShdproTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TShdproTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TShdproTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TShdproTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TShdproTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShdproTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShdproTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TShdproTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TShdproTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShdproTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShdproTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShdproTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShdproTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShdproTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShdproTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TShdproTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TShdproTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShdproTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShdproTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShdproTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShdproTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShdproTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShdproTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShdproTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdproTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShdproTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShdproTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TShdproTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TShdproTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TShdproTmp.LocFgrNum(pFgrNum:word):boolean;
begin
  SetIndex (ixFgrNum);
  Result:=oTmpTable.FindKey([pFgrNum]);
end;

function TShdproTmp.LocSgrNum(pSgrNum:word):boolean;
begin
  SetIndex (ixSgrNum);
  Result:=oTmpTable.FindKey([pSgrNum]);
end;

function TShdproTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TShdproTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TShdproTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TShdproTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShdproTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TShdproTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShdproTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShdproTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShdproTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShdproTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShdproTmp.First;
begin
  oTmpTable.First;
end;

procedure TShdproTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShdproTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShdproTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShdproTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShdproTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShdproTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShdproTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShdproTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShdproTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShdproTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShdproTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
