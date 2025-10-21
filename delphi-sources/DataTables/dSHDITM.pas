unit dSHDITM;

// 8.3.2019 TIBI - Vypol som zápis vymazaných rekordov do DEL súboru pri inicializácii oTable

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='DnIn';
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
  ixDlrNum='DlrNum';

type
  TShditmDat=class(TComponent)
    oTable:TNexBtrTable;
    constructor Create; overload;
    destructor Destroy; override;
  private
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetCrdNum:Str20;            procedure SetCrdNum(pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProTyp:Str1;             procedure SetProTyp(pValue:Str1);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc(pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva(pValue:double);
    function GetSalApc:double;           procedure SetSalApc(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetSalBva:double;           procedure SetSalBva(pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetDscAva:double;           procedure SetDscAva(pValue:double);
    function GetPayCod:Str1;             procedure SetPayCod(pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetDlrNum:longint;          procedure SetDlrNum(pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function LocDocYer(pDocYer:Str2):boolean;
    function LocYePa(pDocYer:Str2;pParNum:longint):boolean;
    function LocYePaPn(pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
    function LocDocTyp(pDocTyp:Str2):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocCrdNum(pCrdNum:Str20):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocPrjNum(pPrjNum:Str12):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocDlrNum(pDlrNum:longint):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function NearDocYer(pDocYer:Str2):boolean;
    function NearYePa(pDocYer:Str2;pParNum:longint):boolean;
    function NearYePaPn(pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
    function NearDocTyp(pDocTyp:Str2):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearCrdNum(pCrdNum:Str20):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearPrjNum(pPrjNum:Str12):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearDlrNum(pDlrNum:longint):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
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

constructor TShditmDat.Create;
begin
  oTable:=DatInit('SHDITM',gPath.CabPath,Self);
  oTable.DelToTxt:=FALSE;  // 8.3.2019 TIBI - vypne zápis vymazaných rekordov do DEL súboru
end;

constructor TShditmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SHDITM',pPath,Self);
end;

destructor TShditmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TShditmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TShditmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TShditmDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TShditmDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TShditmDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TShditmDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TShditmDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TShditmDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TShditmDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TShditmDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TShditmDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TShditmDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TShditmDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TShditmDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TShditmDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TShditmDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TShditmDat.GetCrdNum:Str20;
begin
  Result:=oTable.FieldByName('CrdNum').AsString;
end;

procedure TShditmDat.SetCrdNum(pValue:Str20);
begin
  oTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TShditmDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TShditmDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TShditmDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TShditmDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TShditmDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TShditmDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TShditmDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TShditmDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TShditmDat.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TShditmDat.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TShditmDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TShditmDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TShditmDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TShditmDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TShditmDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TShditmDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TShditmDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TShditmDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TShditmDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TShditmDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TShditmDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TShditmDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TShditmDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TShditmDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TShditmDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TShditmDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TShditmDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TShditmDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TShditmDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TShditmDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TShditmDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TShditmDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShditmDat.GetPrfPrc:double;
begin
  Result:=oTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShditmDat.SetPrfPrc(pValue:double);
begin
  oTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShditmDat.GetPrfAva:double;
begin
  Result:=oTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShditmDat.SetPrfAva(pValue:double);
begin
  oTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShditmDat.GetSalApc:double;
begin
  Result:=oTable.FieldByName('SalApc').AsFloat;
end;

procedure TShditmDat.SetSalApc(pValue:double);
begin
  oTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TShditmDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TShditmDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShditmDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TShditmDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShditmDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShditmDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShditmDat.GetDscAva:double;
begin
  Result:=oTable.FieldByName('DscAva').AsFloat;
end;

procedure TShditmDat.SetDscAva(pValue:double);
begin
  oTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TShditmDat.GetPayCod:Str1;
begin
  Result:=oTable.FieldByName('PayCod').AsString;
end;

procedure TShditmDat.SetPayCod(pValue:Str1);
begin
  oTable.FieldByName('PayCod').AsString:=pValue;
end;

function TShditmDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TShditmDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TShditmDat.GetDlrNum:longint;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TShditmDat.SetDlrNum(pValue:longint);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShditmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TShditmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TShditmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TShditmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TShditmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TShditmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TShditmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TShditmDat.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TShditmDat.LocDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindKey([pDocYer]);
end;

function TShditmDat.LocYePa(pDocYer:Str2;pParNum:longint):boolean;
begin
  SetIndex(ixYePa);
  Result:=oTable.FindKey([pDocYer,pParNum]);
end;

function TShditmDat.LocYePaPn(pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex(ixYePaPn);
  Result:=oTable.FindKey([pDocYer,pParNum,pProNum]);
end;

function TShditmDat.LocDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindKey([pDocTyp]);
end;

function TShditmDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TShditmDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TShditmDat.LocCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindKey([pCrdNum]);
end;

function TShditmDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TShditmDat.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindKey([pPrjNum]);
end;

function TShditmDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TShditmDat.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TShditmDat.NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TShditmDat.NearDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindNearest([pDocYer]);
end;

function TShditmDat.NearYePa(pDocYer:Str2;pParNum:longint):boolean;
begin
  SetIndex(ixYePa);
  Result:=oTable.FindNearest([pDocYer,pParNum]);
end;

function TShditmDat.NearYePaPn(pDocYer:Str2;pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex(ixYePaPn);
  Result:=oTable.FindNearest([pDocYer,pParNum,pProNum]);
end;

function TShditmDat.NearDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindNearest([pDocTyp]);
end;

function TShditmDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TShditmDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TShditmDat.NearCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindNearest([pCrdNum]);
end;

function TShditmDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TShditmDat.NearPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindNearest([pPrjNum]);
end;

function TShditmDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TShditmDat.NearDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

procedure TShditmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TShditmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TShditmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TShditmDat.Prior;
begin
  oTable.Prior;
end;

procedure TShditmDat.Next;
begin
  oTable.Next;
end;

procedure TShditmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TShditmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TShditmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TShditmDat.Edit;
begin
  oTable.Edit;
end;

procedure TShditmDat.Post;
begin
  oTable.Post;
end;

procedure TShditmDat.Delete;
begin
  oTable.Delete;
end;

procedure TShditmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TShditmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TShditmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TShditmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TShditmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TShditmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
