unit dSTKCRD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnPn='SnPn';
  ixStkNum='StkNum';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixSnOs='SnOs';
  ixOcqSta='OcqSta';
  ixPgrNum='PgrNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TStkcrdDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetMinMax:Str1;             procedure SetMinMax(pValue:Str1);
    function GetMinPrq:double;           procedure SetMinPrq(pValue:double);
    function GetMaxPrq:double;           procedure SetMaxPrq(pValue:double);
    function GetOptPrq:double;           procedure SetOptPrq(pValue:double);
    function GetMcdPrq:double;           procedure SetMcdPrq(pValue:double);
    function GetBegPrq:double;           procedure SetBegPrq(pValue:double);
    function GetBerPrq:double;           procedure SetBerPrq(pValue:double);
    function GetBekPrq:double;           procedure SetBekPrq(pValue:double);
    function GetInpPrq:double;           procedure SetInpPrq(pValue:double);
    function GetIncPrq:double;           procedure SetIncPrq(pValue:double);
    function GetInrPrq:double;           procedure SetInrPrq(pValue:double);
    function GetInkPrq:double;           procedure SetInkPrq(pValue:double);
    function GetOupPrq:double;           procedure SetOupPrq(pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetOurPrq:double;           procedure SetOurPrq(pValue:double);
    function GetOukPrq:double;           procedure SetOukPrq(pValue:double);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetAcrPrq:double;           procedure SetAcrPrq(pValue:double);
    function GetAckPrq:double;           procedure SetAckPrq(pValue:double);
    function GetFrePrq:double;           procedure SetFrePrq(pValue:double);
    function GetNsdPrq:double;           procedure SetNsdPrq(pValue:double);
    function GetNsaPrq:double;           procedure SetNsaPrq(pValue:double);
    function GetNstPrq:double;           procedure SetNstPrq(pValue:double);
    function GetNsoPrq:double;           procedure SetNsoPrq(pValue:double);
    function GetSapPrq:double;           procedure SetSapPrq(pValue:double);
    function GetCapPrq:double;           procedure SetCapPrq(pValue:double);
    function GetTcpPrq:double;           procedure SetTcpPrq(pValue:double);
    function GetIcpPrq:double;           procedure SetIcpPrq(pValue:double);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetCasPrq:double;           procedure SetCasPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq(pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq(pValue:double);
    function GetOsdPrq:double;           procedure SetOsdPrq(pValue:double);
    function GetOsrPrq:double;           procedure SetOsrPrq(pValue:double);
    function GetOsfPrq:double;           procedure SetOsfPrq(pValue:double);
    function GetOscPrq:double;           procedure SetOscPrq(pValue:double);
    function GetOcdPrq:double;           procedure SetOcdPrq(pValue:double);
    function GetOcqPrq:double;           procedure SetOcqPrq(pValue:double);
    function GetOcrPrq:double;           procedure SetOcrPrq(pValue:double);
    function GetOccPrq:double;           procedure SetOccPrq(pValue:double);
    function GetPosPrq:double;           procedure SetPosPrq(pValue:double);
    function GetNpoPrq:double;           procedure SetNpoPrq(pValue:double);
    function GetLinPac:double;           procedure SetLinPac(pValue:double);
    function GetLinDte:double;           procedure SetLinDte(pValue:double);
    function GetLouDte:double;           procedure SetLouDte(pValue:double);
    function GetLasCpc:double;           procedure SetLasCpc(pValue:double);
    function GetAvgCpc:double;           procedure SetAvgCpc(pValue:double);
    function GetActCpc:double;           procedure SetActCpc(pValue:double);
    function GetBegCva:double;           procedure SetBegCva(pValue:double);
    function GetIncCva:double;           procedure SetIncCva(pValue:double);
    function GetOutCva:double;           procedure SetOutCva(pValue:double);
    function GetActCva:double;           procedure SetActCva(pValue:double);
    function GetPlsApc:double;           procedure SetPlsApc(pValue:double);
    function GetPlsBpc:double;           procedure SetPlsBpc(pValue:double);
    function GetSalCva:double;           procedure SetSalCva(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetFifQnt:word;             procedure SetFifQnt(pValue:word);
    function GetStmQnt:word;             procedure SetStmQnt(pValue:word);
    function GetOcqSta:Str1;             procedure SetOcqSta(pValue:Str1);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:str10;            procedure SetModUsr(pValue:str10);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocStkNum(pStkNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocSnOs(pStkNum:word;pOcqSta:Str1):boolean;
    function LocOcqSta(pOcqSta:Str1):boolean;
    function LocPgrNum(pPgrNum:word):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocStkCod(pStkCod:Str15):boolean;
    function LocShpCod(pShpCod:Str30):boolean;
    function LocOrdCod(pOrdCod:Str30):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearSnOs(pStkNum:word;pOcqSta:Str1):boolean;
    function NearOcqSta(pOcqSta:Str1):boolean;
    function NearPgrNum(pPgrNum:word):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearStkCod(pStkCod:Str15):boolean;
    function NearShpCod(pShpCod:Str30):boolean;
    function NearOrdCod(pOrdCod:Str30):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property MinMax:Str1 read GetMinMax write SetMinMax;
    property MinPrq:double read GetMinPrq write SetMinPrq;
    property MaxPrq:double read GetMaxPrq write SetMaxPrq;
    property OptPrq:double read GetOptPrq write SetOptPrq;
    property McdPrq:double read GetMcdPrq write SetMcdPrq;
    property BegPrq:double read GetBegPrq write SetBegPrq;
    property BerPrq:double read GetBerPrq write SetBerPrq;
    property BekPrq:double read GetBekPrq write SetBekPrq;
    property InpPrq:double read GetInpPrq write SetInpPrq;
    property IncPrq:double read GetIncPrq write SetIncPrq;
    property InrPrq:double read GetInrPrq write SetInrPrq;
    property InkPrq:double read GetInkPrq write SetInkPrq;
    property OupPrq:double read GetOupPrq write SetOupPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property OurPrq:double read GetOurPrq write SetOurPrq;
    property OukPrq:double read GetOukPrq write SetOukPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property AcrPrq:double read GetAcrPrq write SetAcrPrq;
    property AckPrq:double read GetAckPrq write SetAckPrq;
    property FrePrq:double read GetFrePrq write SetFrePrq;
    property NsdPrq:double read GetNsdPrq write SetNsdPrq;
    property NsaPrq:double read GetNsaPrq write SetNsaPrq;
    property NstPrq:double read GetNstPrq write SetNstPrq;
    property NsoPrq:double read GetNsoPrq write SetNsoPrq;
    property SapPrq:double read GetSapPrq write SetSapPrq;
    property CapPrq:double read GetCapPrq write SetCapPrq;
    property TcpPrq:double read GetTcpPrq write SetTcpPrq;
    property IcpPrq:double read GetIcpPrq write SetIcpPrq;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property CasPrq:double read GetCasPrq write SetCasPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property ExdPrq:double read GetExdPrq write SetExdPrq;
    property OsdPrq:double read GetOsdPrq write SetOsdPrq;
    property OsrPrq:double read GetOsrPrq write SetOsrPrq;
    property OsfPrq:double read GetOsfPrq write SetOsfPrq;
    property OscPrq:double read GetOscPrq write SetOscPrq;
    property OcdPrq:double read GetOcdPrq write SetOcdPrq;
    property OcqPrq:double read GetOcqPrq write SetOcqPrq;
    property OcrPrq:double read GetOcrPrq write SetOcrPrq;
    property OccPrq:double read GetOccPrq write SetOccPrq;
    property PosPrq:double read GetPosPrq write SetPosPrq;
    property NpoPrq:double read GetNpoPrq write SetNpoPrq;
    property LinPac:double read GetLinPac write SetLinPac;
    property LinDte:double read GetLinDte write SetLinDte;
    property LouDte:double read GetLouDte write SetLouDte;
    property LasCpc:double read GetLasCpc write SetLasCpc;
    property AvgCpc:double read GetAvgCpc write SetAvgCpc;
    property ActCpc:double read GetActCpc write SetActCpc;
    property BegCva:double read GetBegCva write SetBegCva;
    property IncCva:double read GetIncCva write SetIncCva;
    property OutCva:double read GetOutCva write SetOutCva;
    property ActCva:double read GetActCva write SetActCva;
    property PlsApc:double read GetPlsApc write SetPlsApc;
    property PlsBpc:double read GetPlsBpc write SetPlsBpc;
    property SalCva:double read GetSalCva write SetSalCva;
    property SalAva:double read GetSalAva write SetSalAva;
    property FifQnt:word read GetFifQnt write SetFifQnt;
    property StmQnt:word read GetStmQnt write SetStmQnt;
    property OcqSta:Str1 read GetOcqSta write SetOcqSta;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:str10 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TStkcrdDat.Create;
begin
  oTable:=DatInit('STKCRD',gPath.StkPath,Self);
end;

constructor TStkcrdDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKCRD',pPath,Self);
end;

destructor TStkcrdDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkcrdDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkcrdDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkcrdDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkcrdDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkcrdDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkcrdDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkcrdDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TStkcrdDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TStkcrdDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TStkcrdDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TStkcrdDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TStkcrdDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TStkcrdDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TStkcrdDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TStkcrdDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TStkcrdDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TStkcrdDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TStkcrdDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TStkcrdDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TStkcrdDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TStkcrdDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TStkcrdDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TStkcrdDat.GetMinMax:Str1;
begin
  Result:=oTable.FieldByName('MinMax').AsString;
end;

procedure TStkcrdDat.SetMinMax(pValue:Str1);
begin
  oTable.FieldByName('MinMax').AsString:=pValue;
end;

function TStkcrdDat.GetMinPrq:double;
begin
  Result:=oTable.FieldByName('MinPrq').AsFloat;
end;

procedure TStkcrdDat.SetMinPrq(pValue:double);
begin
  oTable.FieldByName('MinPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetMaxPrq:double;
begin
  Result:=oTable.FieldByName('MaxPrq').AsFloat;
end;

procedure TStkcrdDat.SetMaxPrq(pValue:double);
begin
  oTable.FieldByName('MaxPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOptPrq:double;
begin
  Result:=oTable.FieldByName('OptPrq').AsFloat;
end;

procedure TStkcrdDat.SetOptPrq(pValue:double);
begin
  oTable.FieldByName('OptPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetMcdPrq:double;
begin
  Result:=oTable.FieldByName('McdPrq').AsFloat;
end;

procedure TStkcrdDat.SetMcdPrq(pValue:double);
begin
  oTable.FieldByName('McdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetBegPrq:double;
begin
  Result:=oTable.FieldByName('BegPrq').AsFloat;
end;

procedure TStkcrdDat.SetBegPrq(pValue:double);
begin
  oTable.FieldByName('BegPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetBerPrq:double;
begin
  Result:=oTable.FieldByName('BerPrq').AsFloat;
end;

procedure TStkcrdDat.SetBerPrq(pValue:double);
begin
  oTable.FieldByName('BerPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetBekPrq:double;
begin
  Result:=oTable.FieldByName('BekPrq').AsFloat;
end;

procedure TStkcrdDat.SetBekPrq(pValue:double);
begin
  oTable.FieldByName('BekPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetInpPrq:double;
begin
  Result:=oTable.FieldByName('InpPrq').AsFloat;
end;

procedure TStkcrdDat.SetInpPrq(pValue:double);
begin
  oTable.FieldByName('InpPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetIncPrq:double;
begin
  Result:=oTable.FieldByName('IncPrq').AsFloat;
end;

procedure TStkcrdDat.SetIncPrq(pValue:double);
begin
  oTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetInrPrq:double;
begin
  Result:=oTable.FieldByName('InrPrq').AsFloat;
end;

procedure TStkcrdDat.SetInrPrq(pValue:double);
begin
  oTable.FieldByName('InrPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetInkPrq:double;
begin
  Result:=oTable.FieldByName('InkPrq').AsFloat;
end;

procedure TStkcrdDat.SetInkPrq(pValue:double);
begin
  oTable.FieldByName('InkPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOupPrq:double;
begin
  Result:=oTable.FieldByName('OupPrq').AsFloat;
end;

procedure TStkcrdDat.SetOupPrq(pValue:double);
begin
  oTable.FieldByName('OupPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TStkcrdDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOurPrq:double;
begin
  Result:=oTable.FieldByName('OurPrq').AsFloat;
end;

procedure TStkcrdDat.SetOurPrq(pValue:double);
begin
  oTable.FieldByName('OurPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOukPrq:double;
begin
  Result:=oTable.FieldByName('OukPrq').AsFloat;
end;

procedure TStkcrdDat.SetOukPrq(pValue:double);
begin
  oTable.FieldByName('OukPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkcrdDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetAcrPrq:double;
begin
  Result:=oTable.FieldByName('AcrPrq').AsFloat;
end;

procedure TStkcrdDat.SetAcrPrq(pValue:double);
begin
  oTable.FieldByName('AcrPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetAckPrq:double;
begin
  Result:=oTable.FieldByName('AckPrq').AsFloat;
end;

procedure TStkcrdDat.SetAckPrq(pValue:double);
begin
  oTable.FieldByName('AckPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetFrePrq:double;
begin
  Result:=oTable.FieldByName('FrePrq').AsFloat;
end;

procedure TStkcrdDat.SetFrePrq(pValue:double);
begin
  oTable.FieldByName('FrePrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetNsdPrq:double;
begin
  Result:=oTable.FieldByName('NsdPrq').AsFloat;
end;

procedure TStkcrdDat.SetNsdPrq(pValue:double);
begin
  oTable.FieldByName('NsdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetNsaPrq:double;
begin
  Result:=oTable.FieldByName('NsaPrq').AsFloat;
end;

procedure TStkcrdDat.SetNsaPrq(pValue:double);
begin
  oTable.FieldByName('NsaPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetNstPrq:double;
begin
  Result:=oTable.FieldByName('NstPrq').AsFloat;
end;

procedure TStkcrdDat.SetNstPrq(pValue:double);
begin
  oTable.FieldByName('NstPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetNsoPrq:double;
begin
  Result:=oTable.FieldByName('NsoPrq').AsFloat;
end;

procedure TStkcrdDat.SetNsoPrq(pValue:double);
begin
  oTable.FieldByName('NsoPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetSapPrq:double;
begin
  Result:=oTable.FieldByName('SapPrq').AsFloat;
end;

procedure TStkcrdDat.SetSapPrq(pValue:double);
begin
  oTable.FieldByName('SapPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetCapPrq:double;
begin
  Result:=oTable.FieldByName('CapPrq').AsFloat;
end;

procedure TStkcrdDat.SetCapPrq(pValue:double);
begin
  oTable.FieldByName('CapPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetTcpPrq:double;
begin
  Result:=oTable.FieldByName('TcpPrq').AsFloat;
end;

procedure TStkcrdDat.SetTcpPrq(pValue:double);
begin
  oTable.FieldByName('TcpPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetIcpPrq:double;
begin
  Result:=oTable.FieldByName('IcpPrq').AsFloat;
end;

procedure TStkcrdDat.SetIcpPrq(pValue:double);
begin
  oTable.FieldByName('IcpPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TStkcrdDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetCasPrq:double;
begin
  Result:=oTable.FieldByName('CasPrq').AsFloat;
end;

procedure TStkcrdDat.SetCasPrq(pValue:double);
begin
  oTable.FieldByName('CasPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TStkcrdDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetIcdPrq:double;
begin
  Result:=oTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TStkcrdDat.SetIcdPrq(pValue:double);
begin
  oTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetExdPrq:double;
begin
  Result:=oTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TStkcrdDat.SetExdPrq(pValue:double);
begin
  oTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOsdPrq:double;
begin
  Result:=oTable.FieldByName('OsdPrq').AsFloat;
end;

procedure TStkcrdDat.SetOsdPrq(pValue:double);
begin
  oTable.FieldByName('OsdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOsrPrq:double;
begin
  Result:=oTable.FieldByName('OsrPrq').AsFloat;
end;

procedure TStkcrdDat.SetOsrPrq(pValue:double);
begin
  oTable.FieldByName('OsrPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOsfPrq:double;
begin
  Result:=oTable.FieldByName('OsfPrq').AsFloat;
end;

procedure TStkcrdDat.SetOsfPrq(pValue:double);
begin
  oTable.FieldByName('OsfPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOscPrq:double;
begin
  Result:=oTable.FieldByName('OscPrq').AsFloat;
end;

procedure TStkcrdDat.SetOscPrq(pValue:double);
begin
  oTable.FieldByName('OscPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOcdPrq:double;
begin
  Result:=oTable.FieldByName('OcdPrq').AsFloat;
end;

procedure TStkcrdDat.SetOcdPrq(pValue:double);
begin
  oTable.FieldByName('OcdPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOcqPrq:double;
begin
  Result:=oTable.FieldByName('OcqPrq').AsFloat;
end;

procedure TStkcrdDat.SetOcqPrq(pValue:double);
begin
  oTable.FieldByName('OcqPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOcrPrq:double;
begin
  Result:=oTable.FieldByName('OcrPrq').AsFloat;
end;

procedure TStkcrdDat.SetOcrPrq(pValue:double);
begin
  oTable.FieldByName('OcrPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetOccPrq:double;
begin
  Result:=oTable.FieldByName('OccPrq').AsFloat;
end;

procedure TStkcrdDat.SetOccPrq(pValue:double);
begin
  oTable.FieldByName('OccPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetPosPrq:double;
begin
  Result:=oTable.FieldByName('PosPrq').AsFloat;
end;

procedure TStkcrdDat.SetPosPrq(pValue:double);
begin
  oTable.FieldByName('PosPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetNpoPrq:double;
begin
  Result:=oTable.FieldByName('NpoPrq').AsFloat;
end;

procedure TStkcrdDat.SetNpoPrq(pValue:double);
begin
  oTable.FieldByName('NpoPrq').AsFloat:=pValue;
end;

function TStkcrdDat.GetLinPac:double;
begin
  Result:=oTable.FieldByName('LinPac').AsFloat;
end;

procedure TStkcrdDat.SetLinPac(pValue:double);
begin
  oTable.FieldByName('LinPac').AsFloat:=pValue;
end;

function TStkcrdDat.GetLinDte:double;
begin
  Result:=oTable.FieldByName('LinDte').AsFloat;
end;

procedure TStkcrdDat.SetLinDte(pValue:double);
begin
  oTable.FieldByName('LinDte').AsFloat:=pValue;
end;

function TStkcrdDat.GetLouDte:double;
begin
  Result:=oTable.FieldByName('LouDte').AsFloat;
end;

procedure TStkcrdDat.SetLouDte(pValue:double);
begin
  oTable.FieldByName('LouDte').AsFloat:=pValue;
end;

function TStkcrdDat.GetLasCpc:double;
begin
  Result:=oTable.FieldByName('LasCpc').AsFloat;
end;

procedure TStkcrdDat.SetLasCpc(pValue:double);
begin
  oTable.FieldByName('LasCpc').AsFloat:=pValue;
end;

function TStkcrdDat.GetAvgCpc:double;
begin
  Result:=oTable.FieldByName('AvgCpc').AsFloat;
end;

procedure TStkcrdDat.SetAvgCpc(pValue:double);
begin
  oTable.FieldByName('AvgCpc').AsFloat:=pValue;
end;

function TStkcrdDat.GetActCpc:double;
begin
  Result:=oTable.FieldByName('ActCpc').AsFloat;
end;

procedure TStkcrdDat.SetActCpc(pValue:double);
begin
  oTable.FieldByName('ActCpc').AsFloat:=pValue;
end;

function TStkcrdDat.GetBegCva:double;
begin
  Result:=oTable.FieldByName('BegCva').AsFloat;
end;

procedure TStkcrdDat.SetBegCva(pValue:double);
begin
  oTable.FieldByName('BegCva').AsFloat:=pValue;
end;

function TStkcrdDat.GetIncCva:double;
begin
  Result:=oTable.FieldByName('IncCva').AsFloat;
end;

procedure TStkcrdDat.SetIncCva(pValue:double);
begin
  oTable.FieldByName('IncCva').AsFloat:=pValue;
end;

function TStkcrdDat.GetOutCva:double;
begin
  Result:=oTable.FieldByName('OutCva').AsFloat;
end;

procedure TStkcrdDat.SetOutCva(pValue:double);
begin
  oTable.FieldByName('OutCva').AsFloat:=pValue;
end;

function TStkcrdDat.GetActCva:double;
begin
  Result:=oTable.FieldByName('ActCva').AsFloat;
end;

procedure TStkcrdDat.SetActCva(pValue:double);
begin
  oTable.FieldByName('ActCva').AsFloat:=pValue;
end;

function TStkcrdDat.GetPlsApc:double;
begin
  Result:=oTable.FieldByName('PlsApc').AsFloat;
end;

procedure TStkcrdDat.SetPlsApc(pValue:double);
begin
  oTable.FieldByName('PlsApc').AsFloat:=pValue;
end;

function TStkcrdDat.GetPlsBpc:double;
begin
  Result:=oTable.FieldByName('PlsBpc').AsFloat;
end;

procedure TStkcrdDat.SetPlsBpc(pValue:double);
begin
  oTable.FieldByName('PlsBpc').AsFloat:=pValue;
end;

function TStkcrdDat.GetSalCva:double;
begin
  Result:=oTable.FieldByName('SalCva').AsFloat;
end;

procedure TStkcrdDat.SetSalCva(pValue:double);
begin
  oTable.FieldByName('SalCva').AsFloat:=pValue;
end;

function TStkcrdDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TStkcrdDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TStkcrdDat.GetFifQnt:word;
begin
  Result:=oTable.FieldByName('FifQnt').AsInteger;
end;

procedure TStkcrdDat.SetFifQnt(pValue:word);
begin
  oTable.FieldByName('FifQnt').AsInteger:=pValue;
end;

function TStkcrdDat.GetStmQnt:word;
begin
  Result:=oTable.FieldByName('StmQnt').AsInteger;
end;

procedure TStkcrdDat.SetStmQnt(pValue:word);
begin
  oTable.FieldByName('StmQnt').AsInteger:=pValue;
end;

function TStkcrdDat.GetOcqSta:Str1;
begin
  Result:=oTable.FieldByName('OcqSta').AsString;
end;

procedure TStkcrdDat.SetOcqSta(pValue:Str1);
begin
  oTable.FieldByName('OcqSta').AsString:=pValue;
end;

function TStkcrdDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkcrdDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkcrdDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkcrdDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkcrdDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkcrdDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkcrdDat.GetModUsr:str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TStkcrdDat.SetModUsr(pValue:str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TStkcrdDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TStkcrdDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TStkcrdDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TStkcrdDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkcrdDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkcrdDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkcrdDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkcrdDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkcrdDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkcrdDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkcrdDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkcrdDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TStkcrdDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkcrdDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TStkcrdDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TStkcrdDat.LocSnOs(pStkNum:word;pOcqSta:Str1):boolean;
begin
  SetIndex(ixSnOs);
  Result:=oTable.FindKey([pStkNum,pOcqSta]);
end;

function TStkcrdDat.LocOcqSta(pOcqSta:Str1):boolean;
begin
  SetIndex(ixOcqSta);
  Result:=oTable.FindKey([pOcqSta]);
end;

function TStkcrdDat.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindKey([pPgrNum]);
end;

function TStkcrdDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TStkcrdDat.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pStkCod]);
end;

function TStkcrdDat.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindKey([pShpCod]);
end;

function TStkcrdDat.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pOrdCod]);
end;

function TStkcrdDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TStkcrdDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkcrdDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TStkcrdDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TStkcrdDat.NearSnOs(pStkNum:word;pOcqSta:Str1):boolean;
begin
  SetIndex(ixSnOs);
  Result:=oTable.FindNearest([pStkNum,pOcqSta]);
end;

function TStkcrdDat.NearOcqSta(pOcqSta:Str1):boolean;
begin
  SetIndex(ixOcqSta);
  Result:=oTable.FindNearest([pOcqSta]);
end;

function TStkcrdDat.NearPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindNearest([pPgrNum]);
end;

function TStkcrdDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TStkcrdDat.NearStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pStkCod]);
end;

function TStkcrdDat.NearShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindNearest([pShpCod]);
end;

function TStkcrdDat.NearOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pOrdCod]);
end;

procedure TStkcrdDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkcrdDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkcrdDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkcrdDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkcrdDat.Next;
begin
  oTable.Next;
end;

procedure TStkcrdDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkcrdDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkcrdDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkcrdDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkcrdDat.Post;
begin
  oTable.Post;
end;

procedure TStkcrdDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkcrdDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkcrdDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkcrdDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkcrdDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkcrdDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkcrdDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
