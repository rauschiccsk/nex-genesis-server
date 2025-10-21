unit tSTKCRD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnPn='';
  ixStkNum='StkNum';
  ixProNum='ProNum';
  ixProNam_='ProNam_';
  ixSnOs='SnOs';
  ixOcqSta='OcqSta';
  ixPgrNum='PgrNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TStkcrdTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetStkNam:Str30;            procedure SetStkNam (pValue:Str30);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetMinMax:Str1;             procedure SetMinMax (pValue:Str1);
    function GetMinPrq:double;           procedure SetMinPrq (pValue:double);
    function GetMaxPrq:double;           procedure SetMaxPrq (pValue:double);
    function GetOptPrq:double;           procedure SetOptPrq (pValue:double);
    function GetMcdPrq:double;           procedure SetMcdPrq (pValue:double);
    function GetBegPrq:double;           procedure SetBegPrq (pValue:double);
    function GetBerPrq:double;           procedure SetBerPrq (pValue:double);
    function GetBekPrq:double;           procedure SetBekPrq (pValue:double);
    function GetInpPrq:double;           procedure SetInpPrq (pValue:double);
    function GetIncPrq:double;           procedure SetIncPrq (pValue:double);
    function GetInrPrq:double;           procedure SetInrPrq (pValue:double);
    function GetInkPrq:double;           procedure SetInkPrq (pValue:double);
    function GetOupPrq:double;           procedure SetOupPrq (pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetOurPrq:double;           procedure SetOurPrq (pValue:double);
    function GetOukPrq:double;           procedure SetOukPrq (pValue:double);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetAcrPrq:double;           procedure SetAcrPrq (pValue:double);
    function GetAckPrq:double;           procedure SetAckPrq (pValue:double);
    function GetFrePrq:double;           procedure SetFrePrq (pValue:double);
    function GetNsdPrq:double;           procedure SetNsdPrq (pValue:double);
    function GetNsaPrq:double;           procedure SetNsaPrq (pValue:double);
    function GetNstPrq:double;           procedure SetNstPrq (pValue:double);
    function GetNsoPrq:double;           procedure SetNsoPrq (pValue:double);
    function GetSapPrq:double;           procedure SetSapPrq (pValue:double);
    function GetCapPrq:double;           procedure SetCapPrq (pValue:double);
    function GetTcpPrq:double;           procedure SetTcpPrq (pValue:double);
    function GetIcpPrq:double;           procedure SetIcpPrq (pValue:double);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetCasPrq:double;           procedure SetCasPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq (pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq (pValue:double);
    function GetOsdPrq:double;           procedure SetOsdPrq (pValue:double);
    function GetOsrPrq:double;           procedure SetOsrPrq (pValue:double);
    function GetOsfPrq:double;           procedure SetOsfPrq (pValue:double);
    function GetOscPrq:double;           procedure SetOscPrq (pValue:double);
    function GetOcdPrq:double;           procedure SetOcdPrq (pValue:double);
    function GetOcqPrq:double;           procedure SetOcqPrq (pValue:double);
    function GetOcrPrq:double;           procedure SetOcrPrq (pValue:double);
    function GetOccPrq:double;           procedure SetOccPrq (pValue:double);
    function GetPosPrq:double;           procedure SetPosPrq (pValue:double);
    function GetNpoPrq:double;           procedure SetNpoPrq (pValue:double);
    function GetLinPac:double;           procedure SetLinPac (pValue:double);
    function GetLinDte:double;           procedure SetLinDte (pValue:double);
    function GetLouDte:double;           procedure SetLouDte (pValue:double);
    function GetLasCpc:double;           procedure SetLasCpc (pValue:double);
    function GetAvgCpc:double;           procedure SetAvgCpc (pValue:double);
    function GetActCpc:double;           procedure SetActCpc (pValue:double);
    function GetBegCva:double;           procedure SetBegCva (pValue:double);
    function GetIncCva:double;           procedure SetIncCva (pValue:double);
    function GetOutCva:double;           procedure SetOutCva (pValue:double);
    function GetActCva:double;           procedure SetActCva (pValue:double);
    function GetPlsApc:double;           procedure SetPlsApc (pValue:double);
    function GetPlsBpc:double;           procedure SetPlsBpc (pValue:double);
    function GetSalCva:double;           procedure SetSalCva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetFifQnt:word;             procedure SetFifQnt (pValue:word);
    function GetStmQnt:word;             procedure SetStmQnt (pValue:word);
    function GetOcqSta:Str1;             procedure SetOcqSta (pValue:Str1);
    function GetCrtUsr:str8;             procedure SetCrtUsr (pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetModUsr:str10;            procedure SetModUsr (pValue:str10);
    function GetModDte:TDatetime;        procedure SetModDte (pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSnPn (pStkNum:word;pProNum:longint):boolean;
    function LocStkNum (pStkNum:word):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocSnOs (pStkNum:word;pOcqSta:Str1):boolean;
    function LocOcqSta (pOcqSta:Str1):boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocBarCod (pBarCod:Str15):boolean;
    function LocStkCod (pStkCod:Str15):boolean;
    function LocShpCod (pShpCod:Str30):boolean;
    function LocOrdCod (pOrdCod:Str30):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property StkNam:Str30 read GetStkNam write SetStkNam;
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

constructor TStkcrdTmp.Create;
begin
  oTmpTable:=TmpInit ('STKCRD',Self);
end;

destructor TStkcrdTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkcrdTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkcrdTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkcrdTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkcrdTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkcrdTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkcrdTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkcrdTmp.GetStkNam:Str30;
begin
  Result:=oTmpTable.FieldByName('StkNam').AsString;
end;

procedure TStkcrdTmp.SetStkNam(pValue:Str30);
begin
  oTmpTable.FieldByName('StkNam').AsString:=pValue;
end;

function TStkcrdTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TStkcrdTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TStkcrdTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TStkcrdTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TStkcrdTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TStkcrdTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TStkcrdTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TStkcrdTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TStkcrdTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TStkcrdTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TStkcrdTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TStkcrdTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TStkcrdTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TStkcrdTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TStkcrdTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TStkcrdTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TStkcrdTmp.GetMinMax:Str1;
begin
  Result:=oTmpTable.FieldByName('MinMax').AsString;
end;

procedure TStkcrdTmp.SetMinMax(pValue:Str1);
begin
  oTmpTable.FieldByName('MinMax').AsString:=pValue;
end;

function TStkcrdTmp.GetMinPrq:double;
begin
  Result:=oTmpTable.FieldByName('MinPrq').AsFloat;
end;

procedure TStkcrdTmp.SetMinPrq(pValue:double);
begin
  oTmpTable.FieldByName('MinPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetMaxPrq:double;
begin
  Result:=oTmpTable.FieldByName('MaxPrq').AsFloat;
end;

procedure TStkcrdTmp.SetMaxPrq(pValue:double);
begin
  oTmpTable.FieldByName('MaxPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOptPrq:double;
begin
  Result:=oTmpTable.FieldByName('OptPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOptPrq(pValue:double);
begin
  oTmpTable.FieldByName('OptPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetMcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('McdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetMcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('McdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetBegPrq:double;
begin
  Result:=oTmpTable.FieldByName('BegPrq').AsFloat;
end;

procedure TStkcrdTmp.SetBegPrq(pValue:double);
begin
  oTmpTable.FieldByName('BegPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetBerPrq:double;
begin
  Result:=oTmpTable.FieldByName('BerPrq').AsFloat;
end;

procedure TStkcrdTmp.SetBerPrq(pValue:double);
begin
  oTmpTable.FieldByName('BerPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetBekPrq:double;
begin
  Result:=oTmpTable.FieldByName('BekPrq').AsFloat;
end;

procedure TStkcrdTmp.SetBekPrq(pValue:double);
begin
  oTmpTable.FieldByName('BekPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetInpPrq:double;
begin
  Result:=oTmpTable.FieldByName('InpPrq').AsFloat;
end;

procedure TStkcrdTmp.SetInpPrq(pValue:double);
begin
  oTmpTable.FieldByName('InpPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetIncPrq:double;
begin
  Result:=oTmpTable.FieldByName('IncPrq').AsFloat;
end;

procedure TStkcrdTmp.SetIncPrq(pValue:double);
begin
  oTmpTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetInrPrq:double;
begin
  Result:=oTmpTable.FieldByName('InrPrq').AsFloat;
end;

procedure TStkcrdTmp.SetInrPrq(pValue:double);
begin
  oTmpTable.FieldByName('InrPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetInkPrq:double;
begin
  Result:=oTmpTable.FieldByName('InkPrq').AsFloat;
end;

procedure TStkcrdTmp.SetInkPrq(pValue:double);
begin
  oTmpTable.FieldByName('InkPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOupPrq:double;
begin
  Result:=oTmpTable.FieldByName('OupPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOupPrq(pValue:double);
begin
  oTmpTable.FieldByName('OupPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOurPrq:double;
begin
  Result:=oTmpTable.FieldByName('OurPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOurPrq(pValue:double);
begin
  oTmpTable.FieldByName('OurPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOukPrq:double;
begin
  Result:=oTmpTable.FieldByName('OukPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOukPrq(pValue:double);
begin
  oTmpTable.FieldByName('OukPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkcrdTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetAcrPrq:double;
begin
  Result:=oTmpTable.FieldByName('AcrPrq').AsFloat;
end;

procedure TStkcrdTmp.SetAcrPrq(pValue:double);
begin
  oTmpTable.FieldByName('AcrPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetAckPrq:double;
begin
  Result:=oTmpTable.FieldByName('AckPrq').AsFloat;
end;

procedure TStkcrdTmp.SetAckPrq(pValue:double);
begin
  oTmpTable.FieldByName('AckPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetFrePrq:double;
begin
  Result:=oTmpTable.FieldByName('FrePrq').AsFloat;
end;

procedure TStkcrdTmp.SetFrePrq(pValue:double);
begin
  oTmpTable.FieldByName('FrePrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetNsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('NsdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetNsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('NsdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetNsaPrq:double;
begin
  Result:=oTmpTable.FieldByName('NsaPrq').AsFloat;
end;

procedure TStkcrdTmp.SetNsaPrq(pValue:double);
begin
  oTmpTable.FieldByName('NsaPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetNstPrq:double;
begin
  Result:=oTmpTable.FieldByName('NstPrq').AsFloat;
end;

procedure TStkcrdTmp.SetNstPrq(pValue:double);
begin
  oTmpTable.FieldByName('NstPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetNsoPrq:double;
begin
  Result:=oTmpTable.FieldByName('NsoPrq').AsFloat;
end;

procedure TStkcrdTmp.SetNsoPrq(pValue:double);
begin
  oTmpTable.FieldByName('NsoPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetSapPrq:double;
begin
  Result:=oTmpTable.FieldByName('SapPrq').AsFloat;
end;

procedure TStkcrdTmp.SetSapPrq(pValue:double);
begin
  oTmpTable.FieldByName('SapPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetCapPrq:double;
begin
  Result:=oTmpTable.FieldByName('CapPrq').AsFloat;
end;

procedure TStkcrdTmp.SetCapPrq(pValue:double);
begin
  oTmpTable.FieldByName('CapPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetTcpPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcpPrq').AsFloat;
end;

procedure TStkcrdTmp.SetTcpPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcpPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetIcpPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcpPrq').AsFloat;
end;

procedure TStkcrdTmp.SetIcpPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcpPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TStkcrdTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetCasPrq:double;
begin
  Result:=oTmpTable.FieldByName('CasPrq').AsFloat;
end;

procedure TStkcrdTmp.SetCasPrq(pValue:double);
begin
  oTmpTable.FieldByName('CasPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetExdPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetExdPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OsdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OsdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOsrPrq:double;
begin
  Result:=oTmpTable.FieldByName('OsrPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOsrPrq(pValue:double);
begin
  oTmpTable.FieldByName('OsrPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOsfPrq:double;
begin
  Result:=oTmpTable.FieldByName('OsfPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOsfPrq(pValue:double);
begin
  oTmpTable.FieldByName('OsfPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOscPrq:double;
begin
  Result:=oTmpTable.FieldByName('OscPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOscPrq(pValue:double);
begin
  oTmpTable.FieldByName('OscPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OcdPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OcdPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOcqPrq:double;
begin
  Result:=oTmpTable.FieldByName('OcqPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOcqPrq(pValue:double);
begin
  oTmpTable.FieldByName('OcqPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOcrPrq:double;
begin
  Result:=oTmpTable.FieldByName('OcrPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOcrPrq(pValue:double);
begin
  oTmpTable.FieldByName('OcrPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOccPrq:double;
begin
  Result:=oTmpTable.FieldByName('OccPrq').AsFloat;
end;

procedure TStkcrdTmp.SetOccPrq(pValue:double);
begin
  oTmpTable.FieldByName('OccPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetPosPrq:double;
begin
  Result:=oTmpTable.FieldByName('PosPrq').AsFloat;
end;

procedure TStkcrdTmp.SetPosPrq(pValue:double);
begin
  oTmpTable.FieldByName('PosPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetNpoPrq:double;
begin
  Result:=oTmpTable.FieldByName('NpoPrq').AsFloat;
end;

procedure TStkcrdTmp.SetNpoPrq(pValue:double);
begin
  oTmpTable.FieldByName('NpoPrq').AsFloat:=pValue;
end;

function TStkcrdTmp.GetLinPac:double;
begin
  Result:=oTmpTable.FieldByName('LinPac').AsFloat;
end;

procedure TStkcrdTmp.SetLinPac(pValue:double);
begin
  oTmpTable.FieldByName('LinPac').AsFloat:=pValue;
end;

function TStkcrdTmp.GetLinDte:double;
begin
  Result:=oTmpTable.FieldByName('LinDte').AsFloat;
end;

procedure TStkcrdTmp.SetLinDte(pValue:double);
begin
  oTmpTable.FieldByName('LinDte').AsFloat:=pValue;
end;

function TStkcrdTmp.GetLouDte:double;
begin
  Result:=oTmpTable.FieldByName('LouDte').AsFloat;
end;

procedure TStkcrdTmp.SetLouDte(pValue:double);
begin
  oTmpTable.FieldByName('LouDte').AsFloat:=pValue;
end;

function TStkcrdTmp.GetLasCpc:double;
begin
  Result:=oTmpTable.FieldByName('LasCpc').AsFloat;
end;

procedure TStkcrdTmp.SetLasCpc(pValue:double);
begin
  oTmpTable.FieldByName('LasCpc').AsFloat:=pValue;
end;

function TStkcrdTmp.GetAvgCpc:double;
begin
  Result:=oTmpTable.FieldByName('AvgCpc').AsFloat;
end;

procedure TStkcrdTmp.SetAvgCpc(pValue:double);
begin
  oTmpTable.FieldByName('AvgCpc').AsFloat:=pValue;
end;

function TStkcrdTmp.GetActCpc:double;
begin
  Result:=oTmpTable.FieldByName('ActCpc').AsFloat;
end;

procedure TStkcrdTmp.SetActCpc(pValue:double);
begin
  oTmpTable.FieldByName('ActCpc').AsFloat:=pValue;
end;

function TStkcrdTmp.GetBegCva:double;
begin
  Result:=oTmpTable.FieldByName('BegCva').AsFloat;
end;

procedure TStkcrdTmp.SetBegCva(pValue:double);
begin
  oTmpTable.FieldByName('BegCva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetIncCva:double;
begin
  Result:=oTmpTable.FieldByName('IncCva').AsFloat;
end;

procedure TStkcrdTmp.SetIncCva(pValue:double);
begin
  oTmpTable.FieldByName('IncCva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetOutCva:double;
begin
  Result:=oTmpTable.FieldByName('OutCva').AsFloat;
end;

procedure TStkcrdTmp.SetOutCva(pValue:double);
begin
  oTmpTable.FieldByName('OutCva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetActCva:double;
begin
  Result:=oTmpTable.FieldByName('ActCva').AsFloat;
end;

procedure TStkcrdTmp.SetActCva(pValue:double);
begin
  oTmpTable.FieldByName('ActCva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetPlsApc:double;
begin
  Result:=oTmpTable.FieldByName('PlsApc').AsFloat;
end;

procedure TStkcrdTmp.SetPlsApc(pValue:double);
begin
  oTmpTable.FieldByName('PlsApc').AsFloat:=pValue;
end;

function TStkcrdTmp.GetPlsBpc:double;
begin
  Result:=oTmpTable.FieldByName('PlsBpc').AsFloat;
end;

procedure TStkcrdTmp.SetPlsBpc(pValue:double);
begin
  oTmpTable.FieldByName('PlsBpc').AsFloat:=pValue;
end;

function TStkcrdTmp.GetSalCva:double;
begin
  Result:=oTmpTable.FieldByName('SalCva').AsFloat;
end;

procedure TStkcrdTmp.SetSalCva(pValue:double);
begin
  oTmpTable.FieldByName('SalCva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TStkcrdTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TStkcrdTmp.GetFifQnt:word;
begin
  Result:=oTmpTable.FieldByName('FifQnt').AsInteger;
end;

procedure TStkcrdTmp.SetFifQnt(pValue:word);
begin
  oTmpTable.FieldByName('FifQnt').AsInteger:=pValue;
end;

function TStkcrdTmp.GetStmQnt:word;
begin
  Result:=oTmpTable.FieldByName('StmQnt').AsInteger;
end;

procedure TStkcrdTmp.SetStmQnt(pValue:word);
begin
  oTmpTable.FieldByName('StmQnt').AsInteger:=pValue;
end;

function TStkcrdTmp.GetOcqSta:Str1;
begin
  Result:=oTmpTable.FieldByName('OcqSta').AsString;
end;

procedure TStkcrdTmp.SetOcqSta(pValue:Str1);
begin
  oTmpTable.FieldByName('OcqSta').AsString:=pValue;
end;

function TStkcrdTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkcrdTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkcrdTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkcrdTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkcrdTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkcrdTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkcrdTmp.GetModUsr:str10;
begin
  Result:=oTmpTable.FieldByName('ModUsr').AsString;
end;

procedure TStkcrdTmp.SetModUsr(pValue:str10);
begin
  oTmpTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TStkcrdTmp.GetModDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDte').AsDateTime;
end;

procedure TStkcrdTmp.SetModDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TStkcrdTmp.GetModTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTim').AsDateTime;
end;

procedure TStkcrdTmp.SetModTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkcrdTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkcrdTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkcrdTmp.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex (ixSnPn);
  Result:=oTmpTable.FindKey([pStkNum,pProNum]);
end;

function TStkcrdTmp.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result:=oTmpTable.FindKey([pStkNum]);
end;

function TStkcrdTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TStkcrdTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TStkcrdTmp.LocSnOs(pStkNum:word;pOcqSta:Str1):boolean;
begin
  SetIndex (ixSnOs);
  Result:=oTmpTable.FindKey([pStkNum,pOcqSta]);
end;

function TStkcrdTmp.LocOcqSta(pOcqSta:Str1):boolean;
begin
  SetIndex (ixOcqSta);
  Result:=oTmpTable.FindKey([pOcqSta]);
end;

function TStkcrdTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TStkcrdTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TStkcrdTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TStkcrdTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TStkcrdTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TStkcrdTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkcrdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkcrdTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkcrdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkcrdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkcrdTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkcrdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkcrdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkcrdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkcrdTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkcrdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkcrdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkcrdTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkcrdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkcrdTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkcrdTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkcrdTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
