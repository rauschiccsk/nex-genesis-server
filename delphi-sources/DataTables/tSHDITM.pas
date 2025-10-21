unit tSHDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='';
  ixDocYer='DocYer';
  ixYePa='YePa';
  ixYePaPn='YePaPn';
  ixDocTyp='DocTyp';
  ixDocDte='DocDte';
  ixDocNum='DocNum';
  ixCrdNum='CrdNum';
  ixParNum='ParNum';
  ixPrjNum='PrjNum';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TShditmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
    function GetDocTyp:Str2;             procedure SetDocTyp (pValue:Str2);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetCrdNum:Str20;            procedure SetCrdNum (pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
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
    function LocDocYer (pDocYer:Str2):boolean;
    function LocYePa (pDocYer:Str2;pParNum:longint):boolean;
    function LocYePaPn (pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
    function LocDocTyp (pDocTyp:Str2):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocCrdNum (pCrdNum:Str20):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocPrjNum (pPrjNum:Str12):boolean;
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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property ParNum:longint read GetParNum write SetParNum;
    property ProNum:longint read GetProNum write SetProNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property CrdNum:Str20 read GetCrdNum write SetCrdNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
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

constructor TShditmTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDITM',Self);
end;

destructor TShditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShditmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShditmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShditmTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TShditmTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TShditmTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TShditmTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TShditmTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TShditmTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TShditmTmp.GetDocTyp:Str2;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TShditmTmp.SetDocTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TShditmTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TShditmTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TShditmTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TShditmTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TShditmTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TShditmTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TShditmTmp.GetCrdNum:Str20;
begin
  Result:=oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TShditmTmp.SetCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TShditmTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TShditmTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TShditmTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TShditmTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TShditmTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TShditmTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TShditmTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TShditmTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TShditmTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TShditmTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TShditmTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TShditmTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TShditmTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShditmTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShditmTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShditmTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShditmTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShditmTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShditmTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TShditmTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TShditmTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TShditmTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TShditmTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TShditmTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TShditmTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TShditmTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TShditmTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TShditmTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TShditmTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShditmTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShditmTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TShditmTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TShditmTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShditmTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShditmTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShditmTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShditmTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShditmTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShditmTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TShditmTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TShditmTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShditmTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShditmTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShditmTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShditmTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShditmTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShditmTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShditmTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TShditmTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TShditmTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TShditmTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TShditmTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TShditmTmp.GetDlrNum:longint;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TShditmTmp.SetDlrNum(pValue:longint);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShditmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShditmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShditmTmp.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TShditmTmp.LocDocYer(pDocYer:Str2):boolean;
begin
  SetIndex (ixDocYer);
  Result:=oTmpTable.FindKey([pDocYer]);
end;

function TShditmTmp.LocYePa(pDocYer:Str2;pParNum:longint):boolean;
begin
  SetIndex (ixYePa);
  Result:=oTmpTable.FindKey([pDocYer,pParNum]);
end;

function TShditmTmp.LocYePaPn(pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex (ixYePaPn);
  Result:=oTmpTable.FindKey([pDocYer,pParNum,pProNum]);
end;

function TShditmTmp.LocDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex (ixDocTyp);
  Result:=oTmpTable.FindKey([pDocTyp]);
end;

function TShditmTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TShditmTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TShditmTmp.LocCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result:=oTmpTable.FindKey([pCrdNum]);
end;

function TShditmTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TShditmTmp.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex (ixPrjNum);
  Result:=oTmpTable.FindKey([pPrjNum]);
end;

function TShditmTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TShditmTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TShditmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TShditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShditmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShditmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShditmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShditmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
