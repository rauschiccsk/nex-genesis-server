unit tSHILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='';
  ixDocTyp='DocTyp';
  ixProNum='ProNum';
  ixDocDte='DocDte';
  ixCrdNum='CrdNum';
  ixPrjNum='PrjNum';

type
  TShilstTmp=class(TComponent)
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
    function GetDocTyp:Str2;             procedure SetDocTyp (pValue:Str2);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetCrdNum:Str20;            procedure SetCrdNum (pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
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
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
    function GetPayCod:Str1;             procedure SetPayCod (pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetDlrNum:longint;          procedure SetDlrNum (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:longint):boolean;
    function LocDocTyp (pDocTyp:Str2):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocCrdNum (pCrdNum:Str20):boolean;
    function LocPrjNum (pPrjNum:Str12):boolean;

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
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property CrdNum:Str20 read GetCrdNum write SetCrdNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNam:Str60 read GetProNam write SetProNam;
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
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property StkAva:double read GetStkAva write SetStkAva;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property PrfAva:double read GetPrfAva write SetPrfAva;
    property SalApc:double read GetSalApc write SetSalApc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
    property PayCod:Str1 read GetPayCod write SetPayCod;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property DlrNum:longint read GetDlrNum write SetDlrNum;
  end;

implementation

constructor TShilstTmp.Create;
begin
  oTmpTable:=TmpInit ('SHILST',Self);
end;

destructor TShilstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShilstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShilstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShilstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TShilstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TShilstTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TShilstTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TShilstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TShilstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TShilstTmp.GetDocTyp:Str2;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TShilstTmp.SetDocTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TShilstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TShilstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TShilstTmp.GetCrdNum:Str20;
begin
  Result:=oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TShilstTmp.SetCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TShilstTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TShilstTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TShilstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TShilstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TShilstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TShilstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TShilstTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TShilstTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TShilstTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TShilstTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TShilstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShilstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShilstTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShilstTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShilstTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShilstTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShilstTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TShilstTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TShilstTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TShilstTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TShilstTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TShilstTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TShilstTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TShilstTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TShilstTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TShilstTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TShilstTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShilstTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShilstTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TShilstTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TShilstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShilstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShilstTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShilstTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShilstTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShilstTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShilstTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TShilstTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TShilstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShilstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShilstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShilstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShilstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShilstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShilstTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShilstTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TShilstTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TShilstTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TShilstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TShilstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TShilstTmp.GetDlrNum:longint;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TShilstTmp.SetDlrNum(pValue:longint);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShilstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShilstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShilstTmp.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TShilstTmp.LocDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex (ixDocTyp);
  Result:=oTmpTable.FindKey([pDocTyp]);
end;

function TShilstTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TShilstTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TShilstTmp.LocCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result:=oTmpTable.FindKey([pCrdNum]);
end;

function TShilstTmp.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex (ixPrjNum);
  Result:=oTmpTable.FindKey([pPrjNum]);
end;

procedure TShilstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShilstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShilstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShilstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShilstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShilstTmp.First;
begin
  oTmpTable.First;
end;

procedure TShilstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShilstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShilstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShilstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShilstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShilstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShilstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShilstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShilstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShilstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShilstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
