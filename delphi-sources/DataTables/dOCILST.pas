unit dOCILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='ItmAdr';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixDnIn='DnIn';
  ixDnPn='DnPn';
  ixSnPn='SnPn';
  ixProNam='ProNam';
  ixParNum='ParNum';
  ixSnPaPnSt='SnPaPnSt';
  ixSnPnRq='SnPnRq';
  ixSnPnUs='SnPnUs';
  ixRstSta='RstSta';
  ixRosSta='RosSta';
  ixReqSta='ReqSta';
  ixUndSta='UndSta';
  ixModSta='ModSta';
  ixCncSta='CncSta';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TOcilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetItmAdr:longint;          procedure SetItmAdr(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetProVol:double;           procedure SetProVol(pValue:double);
    function GetProWgh:double;           procedure SetProWgh(pValue:double);
    function GetProTyp:Str1;             procedure SetProTyp(pValue:Str1);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq(pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq(pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq(pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq(pValue:double);
    function GetSalApc:double;           procedure SetSalApc(pValue:double);
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva(pValue:double);
    function GetFgdAva:double;           procedure SetFgdAva(pValue:double);
    function GetPrjAva:double;           procedure SetPrjAva(pValue:double);
    function GetSpcAva:double;           procedure SetSpcAva(pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetSalBva:double;           procedure SetSalBva(pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc(pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva(pValue:double);
    function GetEndBva:double;           procedure SetEndBva(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
    function GetRatPrv:TDatetime;        procedure SetRatPrv(pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte(pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot(pValue:Str50);
    function GetRatChg:byte;             procedure SetRatChg(pValue:byte);
    function GetRatCnt:byte;             procedure SetRatCnt(pValue:byte);
    function GetOsdNum:Str13;            procedure SetOsdNum(pValue:Str13);
    function GetOsdItm:word;             procedure SetOsdItm(pValue:word);
    function GetOsdDte:TDatetime;        procedure SetOsdDte(pValue:TDatetime);
    function GetOsdDoq:byte;             procedure SetOsdDoq(pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum(pValue:Str13);
    function GetSrdItm:word;             procedure SetSrdItm(pValue:word);
    function GetSrdQnt:byte;             procedure SetSrdQnt(pValue:byte);
    function GetMcdNum:Str13;            procedure SetMcdNum(pValue:Str13);
    function GetMcdItm:word;             procedure SetMcdItm(pValue:word);
    function GetTcdNum:Str13;            procedure SetTcdNum(pValue:Str13);
    function GetTcdItm:word;             procedure SetTcdItm(pValue:word);
    function GetTcdDte:TDatetime;        procedure SetTcdDte(pValue:TDatetime);
    function GetTcdDoq:byte;             procedure SetTcdDoq(pValue:byte);
    function GetIcdNum:Str13;            procedure SetIcdNum(pValue:Str13);
    function GetIcdItm:word;             procedure SetIcdItm(pValue:word);
    function GetIcdDte:TDatetime;        procedure SetIcdDte(pValue:TDatetime);
    function GetIcdDoq:byte;             procedure SetIcdDoq(pValue:byte);
    function GetCadNum:Str13;            procedure SetCadNum(pValue:Str13);
    function GetCadItm:word;             procedure SetCadItm(pValue:word);
    function GetCadDte:TDatetime;        procedure SetCadDte(pValue:TDatetime);
    function GetCadDoq:byte;             procedure SetCadDoq(pValue:byte);
    function GetResTyp:byte;             procedure SetResTyp(pValue:byte);
    function GetReqSta:Str1;             procedure SetReqSta(pValue:Str1);
    function GetRstSta:Str1;             procedure SetRstSta(pValue:Str1);
    function GetRosSta:Str1;             procedure SetRosSta(pValue:Str1);
    function GetModSta:Str1;             procedure SetModSta(pValue:Str1);
    function GetExdSta:Str1;             procedure SetExdSta(pValue:Str1);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetRemWri:word;             procedure SetRemWri(pValue:word);
    function GetRemStk:word;             procedure SetRemStk(pValue:word);
    function GetComNum:Str14;            procedure SetComNum(pValue:Str14);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetItmFrm:Str10;            procedure SetItmFrm(pValue:Str10);
    function GetTrsDte:TDatetime;        procedure SetTrsDte(pValue:TDatetime);
    function GetUndSta:Str1;             procedure SetUndSta(pValue:Str1);
    function GetCncSta:Str1;             procedure SetCncSta(pValue:Str1);
    function GetCctVat:byte;             procedure SetCctVat(pValue:byte);
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
    function LocItmAdr(pItmAdr:longint):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocSnPaPnSt(pStkNum:word;pParNum:longint;pProNum:longint;pRstSta:Str1):boolean;
    function LocSnPnRq(pStkNum:word;pProNum:longint;pReqSta:Str1):boolean;
    function LocSnPnUs(pStkNum:word;pProNum:longint;pUndSta:Str1):boolean;
    function LocRstSta(pRstSta:Str1):boolean;
    function LocRosSta(pRosSta:Str1):boolean;
    function LocReqSta(pReqSta:Str1):boolean;
    function LocUndSta(pUndSta:Str1):boolean;
    function LocModSta(pModSta:Str1):boolean;
    function LocCncSta(pCncSta:Str1):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocStkCod(pStkCod:Str15):boolean;
    function LocShpCod(pShpCod:Str30):boolean;
    function LocOrdCod(pOrdCod:Str30):boolean;
    function NearItmAdr(pItmAdr:longint):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearSnPaPnSt(pStkNum:word;pParNum:longint;pProNum:longint;pRstSta:Str1):boolean;
    function NearSnPnRq(pStkNum:word;pProNum:longint;pReqSta:Str1):boolean;
    function NearSnPnUs(pStkNum:word;pProNum:longint;pUndSta:Str1):boolean;
    function NearRstSta(pRstSta:Str1):boolean;
    function NearRosSta(pRosSta:Str1):boolean;
    function NearReqSta(pReqSta:Str1):boolean;
    function NearUndSta(pUndSta:Str1):boolean;
    function NearModSta(pModSta:Str1):boolean;
    function NearCncSta(pCncSta:Str1):boolean;
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
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property ProTyp:Str1 read GetProTyp write SetProTyp;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property ReqPrq:double read GetReqPrq write SetReqPrq;
    property RstPrq:double read GetRstPrq write SetRstPrq;
    property RosPrq:double read GetRosPrq write SetRosPrq;
    property ExdPrq:double read GetExdPrq write SetExdPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property SalApc:double read GetSalApc write SetSalApc;
    property StkAva:double read GetStkAva write SetStkAva;
    property PlsAva:double read GetPlsAva write SetPlsAva;
    property FgdAva:double read GetFgdAva write SetFgdAva;
    property PrjAva:double read GetPrjAva write SetPrjAva;
    property SpcAva:double read GetSpcAva write SetSpcAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property SapSrc:Str2 read GetSapSrc write SetSapSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property RatPrv:TDatetime read GetRatPrv write SetRatPrv;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property RatChg:byte read GetRatChg write SetRatChg;
    property RatCnt:byte read GetRatCnt write SetRatCnt;
    property OsdNum:Str13 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OsdDte:TDatetime read GetOsdDte write SetOsdDte;
    property OsdDoq:byte read GetOsdDoq write SetOsdDoq;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property SrdItm:word read GetSrdItm write SetSrdItm;
    property SrdQnt:byte read GetSrdQnt write SetSrdQnt;
    property McdNum:Str13 read GetMcdNum write SetMcdNum;
    property McdItm:word read GetMcdItm write SetMcdItm;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property TcdDte:TDatetime read GetTcdDte write SetTcdDte;
    property TcdDoq:byte read GetTcdDoq write SetTcdDoq;
    property IcdNum:Str13 read GetIcdNum write SetIcdNum;
    property IcdItm:word read GetIcdItm write SetIcdItm;
    property IcdDte:TDatetime read GetIcdDte write SetIcdDte;
    property IcdDoq:byte read GetIcdDoq write SetIcdDoq;
    property CadNum:Str13 read GetCadNum write SetCadNum;
    property CadItm:word read GetCadItm write SetCadItm;
    property CadDte:TDatetime read GetCadDte write SetCadDte;
    property CadDoq:byte read GetCadDoq write SetCadDoq;
    property ResTyp:byte read GetResTyp write SetResTyp;
    property ReqSta:Str1 read GetReqSta write SetReqSta;
    property RstSta:Str1 read GetRstSta write SetRstSta;
    property RosSta:Str1 read GetRosSta write SetRosSta;
    property ModSta:Str1 read GetModSta write SetModSta;
    property ExdSta:Str1 read GetExdSta write SetExdSta;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property RemWri:word read GetRemWri write SetRemWri;
    property RemStk:word read GetRemStk write SetRemStk;
    property ComNum:Str14 read GetComNum write SetComNum;
    property Notice:Str50 read GetNotice write SetNotice;
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
    property TrsDte:TDatetime read GetTrsDte write SetTrsDte;
    property UndSta:Str1 read GetUndSta write SetUndSta;
    property CncSta:Str1 read GetCncSta write SetCncSta;
    property CctVat:byte read GetCctVat write SetCctVat;
  end;

implementation

constructor TOcilstDat.Create;
begin
  oTable:=DatInit('OCILST',gPath.StkPath,Self);
end;

constructor TOcilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCILST',pPath,Self);
end;

destructor TOcilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcilstDat.GetItmAdr:longint;
begin
  Result:=oTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOcilstDat.SetItmAdr(pValue:longint);
begin
  oTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOcilstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOcilstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOcilstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TOcilstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOcilstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TOcilstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOcilstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOcilstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOcilstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TOcilstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOcilstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcilstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcilstDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOcilstDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOcilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcilstDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOcilstDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOcilstDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOcilstDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOcilstDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOcilstDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOcilstDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TOcilstDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOcilstDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TOcilstDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOcilstDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TOcilstDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOcilstDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TOcilstDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOcilstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TOcilstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOcilstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOcilstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOcilstDat.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TOcilstDat.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOcilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TOcilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOcilstDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOcilstDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOcilstDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOcilstDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetReqPrq:double;
begin
  Result:=oTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOcilstDat.SetReqPrq(pValue:double);
begin
  oTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetRstPrq:double;
begin
  Result:=oTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOcilstDat.SetRstPrq(pValue:double);
begin
  oTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetRosPrq:double;
begin
  Result:=oTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOcilstDat.SetRosPrq(pValue:double);
begin
  oTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetExdPrq:double;
begin
  Result:=oTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOcilstDat.SetExdPrq(pValue:double);
begin
  oTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOcilstDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetCncPrq:double;
begin
  Result:=oTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOcilstDat.SetCncPrq(pValue:double);
begin
  oTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOcilstDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetIcdPrq:double;
begin
  Result:=oTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOcilstDat.SetIcdPrq(pValue:double);
begin
  oTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOcilstDat.GetSalApc:double;
begin
  Result:=oTable.FieldByName('SalApc').AsFloat;
end;

procedure TOcilstDat.SetSalApc(pValue:double);
begin
  oTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TOcilstDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TOcilstDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOcilstDat.GetPlsAva:double;
begin
  Result:=oTable.FieldByName('PlsAva').AsFloat;
end;

procedure TOcilstDat.SetPlsAva(pValue:double);
begin
  oTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TOcilstDat.GetFgdAva:double;
begin
  Result:=oTable.FieldByName('FgdAva').AsFloat;
end;

procedure TOcilstDat.SetFgdAva(pValue:double);
begin
  oTable.FieldByName('FgdAva').AsFloat:=pValue;
end;

function TOcilstDat.GetPrjAva:double;
begin
  Result:=oTable.FieldByName('PrjAva').AsFloat;
end;

procedure TOcilstDat.SetPrjAva(pValue:double);
begin
  oTable.FieldByName('PrjAva').AsFloat:=pValue;
end;

function TOcilstDat.GetSpcAva:double;
begin
  Result:=oTable.FieldByName('SpcAva').AsFloat;
end;

procedure TOcilstDat.SetSpcAva(pValue:double);
begin
  oTable.FieldByName('SpcAva').AsFloat:=pValue;
end;

function TOcilstDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOcilstDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOcilstDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TOcilstDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOcilstDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TOcilstDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOcilstDat.GetSapSrc:Str2;
begin
  Result:=oTable.FieldByName('SapSrc').AsString;
end;

procedure TOcilstDat.SetSapSrc(pValue:Str2);
begin
  oTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TOcilstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOcilstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOcilstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TOcilstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOcilstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOcilstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOcilstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOcilstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOcilstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOcilstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOcilstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcilstDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetRatPrv:TDatetime;
begin
  Result:=oTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOcilstDat.SetRatPrv(pValue:TDatetime);
begin
  oTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOcilstDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcilstDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetRatNot:Str50;
begin
  Result:=oTable.FieldByName('RatNot').AsString;
end;

procedure TOcilstDat.SetRatNot(pValue:Str50);
begin
  oTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOcilstDat.GetRatChg:byte;
begin
  Result:=oTable.FieldByName('RatChg').AsInteger;
end;

procedure TOcilstDat.SetRatChg(pValue:byte);
begin
  oTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOcilstDat.GetRatCnt:byte;
begin
  Result:=oTable.FieldByName('RatCnt').AsInteger;
end;

procedure TOcilstDat.SetRatCnt(pValue:byte);
begin
  oTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TOcilstDat.GetOsdNum:Str13;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TOcilstDat.SetOsdNum(pValue:Str13);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcilstDat.GetOsdItm:word;
begin
  Result:=oTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcilstDat.SetOsdItm(pValue:word);
begin
  oTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOcilstDat.GetOsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('OsdDte').AsDateTime;
end;

procedure TOcilstDat.SetOsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('OsdDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetOsdDoq:byte;
begin
  Result:=oTable.FieldByName('OsdDoq').AsInteger;
end;

procedure TOcilstDat.SetOsdDoq(pValue:byte);
begin
  oTable.FieldByName('OsdDoq').AsInteger:=pValue;
end;

function TOcilstDat.GetSrdNum:Str13;
begin
  Result:=oTable.FieldByName('SrdNum').AsString;
end;

procedure TOcilstDat.SetSrdNum(pValue:Str13);
begin
  oTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOcilstDat.GetSrdItm:word;
begin
  Result:=oTable.FieldByName('SrdItm').AsInteger;
end;

procedure TOcilstDat.SetSrdItm(pValue:word);
begin
  oTable.FieldByName('SrdItm').AsInteger:=pValue;
end;

function TOcilstDat.GetSrdQnt:byte;
begin
  Result:=oTable.FieldByName('SrdQnt').AsInteger;
end;

procedure TOcilstDat.SetSrdQnt(pValue:byte);
begin
  oTable.FieldByName('SrdQnt').AsInteger:=pValue;
end;

function TOcilstDat.GetMcdNum:Str13;
begin
  Result:=oTable.FieldByName('McdNum').AsString;
end;

procedure TOcilstDat.SetMcdNum(pValue:Str13);
begin
  oTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOcilstDat.GetMcdItm:word;
begin
  Result:=oTable.FieldByName('McdItm').AsInteger;
end;

procedure TOcilstDat.SetMcdItm(pValue:word);
begin
  oTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TOcilstDat.GetTcdNum:Str13;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TOcilstDat.SetTcdNum(pValue:Str13);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOcilstDat.GetTcdItm:word;
begin
  Result:=oTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOcilstDat.SetTcdItm(pValue:word);
begin
  oTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TOcilstDat.GetTcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TOcilstDat.SetTcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetTcdDoq:byte;
begin
  Result:=oTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOcilstDat.SetTcdDoq(pValue:byte);
begin
  oTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOcilstDat.GetIcdNum:Str13;
begin
  Result:=oTable.FieldByName('IcdNum').AsString;
end;

procedure TOcilstDat.SetIcdNum(pValue:Str13);
begin
  oTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOcilstDat.GetIcdItm:word;
begin
  Result:=oTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOcilstDat.SetIcdItm(pValue:word);
begin
  oTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TOcilstDat.GetIcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('IcdDte').AsDateTime;
end;

procedure TOcilstDat.SetIcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('IcdDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetIcdDoq:byte;
begin
  Result:=oTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOcilstDat.SetIcdDoq(pValue:byte);
begin
  oTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOcilstDat.GetCadNum:Str13;
begin
  Result:=oTable.FieldByName('CadNum').AsString;
end;

procedure TOcilstDat.SetCadNum(pValue:Str13);
begin
  oTable.FieldByName('CadNum').AsString:=pValue;
end;

function TOcilstDat.GetCadItm:word;
begin
  Result:=oTable.FieldByName('CadItm').AsInteger;
end;

procedure TOcilstDat.SetCadItm(pValue:word);
begin
  oTable.FieldByName('CadItm').AsInteger:=pValue;
end;

function TOcilstDat.GetCadDte:TDatetime;
begin
  Result:=oTable.FieldByName('CadDte').AsDateTime;
end;

procedure TOcilstDat.SetCadDte(pValue:TDatetime);
begin
  oTable.FieldByName('CadDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetCadDoq:byte;
begin
  Result:=oTable.FieldByName('CadDoq').AsInteger;
end;

procedure TOcilstDat.SetCadDoq(pValue:byte);
begin
  oTable.FieldByName('CadDoq').AsInteger:=pValue;
end;

function TOcilstDat.GetResTyp:byte;
begin
  Result:=oTable.FieldByName('ResTyp').AsInteger;
end;

procedure TOcilstDat.SetResTyp(pValue:byte);
begin
  oTable.FieldByName('ResTyp').AsInteger:=pValue;
end;

function TOcilstDat.GetReqSta:Str1;
begin
  Result:=oTable.FieldByName('ReqSta').AsString;
end;

procedure TOcilstDat.SetReqSta(pValue:Str1);
begin
  oTable.FieldByName('ReqSta').AsString:=pValue;
end;

function TOcilstDat.GetRstSta:Str1;
begin
  Result:=oTable.FieldByName('RstSta').AsString;
end;

procedure TOcilstDat.SetRstSta(pValue:Str1);
begin
  oTable.FieldByName('RstSta').AsString:=pValue;
end;

function TOcilstDat.GetRosSta:Str1;
begin
  Result:=oTable.FieldByName('RosSta').AsString;
end;

procedure TOcilstDat.SetRosSta(pValue:Str1);
begin
  oTable.FieldByName('RosSta').AsString:=pValue;
end;

function TOcilstDat.GetModSta:Str1;
begin
  Result:=oTable.FieldByName('ModSta').AsString;
end;

procedure TOcilstDat.SetModSta(pValue:Str1);
begin
  oTable.FieldByName('ModSta').AsString:=pValue;
end;

function TOcilstDat.GetExdSta:Str1;
begin
  Result:=oTable.FieldByName('ExdSta').AsString;
end;

procedure TOcilstDat.SetExdSta(pValue:Str1);
begin
  oTable.FieldByName('ExdSta').AsString:=pValue;
end;

function TOcilstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcilstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcilstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcilstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcilstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOcilstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TOcilstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOcilstDat.GetRemWri:word;
begin
  Result:=oTable.FieldByName('RemWri').AsInteger;
end;

procedure TOcilstDat.SetRemWri(pValue:word);
begin
  oTable.FieldByName('RemWri').AsInteger:=pValue;
end;

function TOcilstDat.GetRemStk:word;
begin
  Result:=oTable.FieldByName('RemStk').AsInteger;
end;

procedure TOcilstDat.SetRemStk(pValue:word);
begin
  oTable.FieldByName('RemStk').AsInteger:=pValue;
end;

function TOcilstDat.GetComNum:Str14;
begin
  Result:=oTable.FieldByName('ComNum').AsString;
end;

procedure TOcilstDat.SetComNum(pValue:Str14);
begin
  oTable.FieldByName('ComNum').AsString:=pValue;
end;

function TOcilstDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOcilstDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TOcilstDat.GetItmFrm:Str10;
begin
  Result:=oTable.FieldByName('ItmFrm').AsString;
end;

procedure TOcilstDat.SetItmFrm(pValue:Str10);
begin
  oTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TOcilstDat.GetTrsDte:TDatetime;
begin
  Result:=oTable.FieldByName('TrsDte').AsDateTime;
end;

procedure TOcilstDat.SetTrsDte(pValue:TDatetime);
begin
  oTable.FieldByName('TrsDte').AsDateTime:=pValue;
end;

function TOcilstDat.GetUndSta:Str1;
begin
  Result:=oTable.FieldByName('UndSta').AsString;
end;

procedure TOcilstDat.SetUndSta(pValue:Str1);
begin
  oTable.FieldByName('UndSta').AsString:=pValue;
end;

function TOcilstDat.GetCncSta:Str1;
begin
  Result:=oTable.FieldByName('CncSta').AsString;
end;

procedure TOcilstDat.SetCncSta(pValue:Str1);
begin
  oTable.FieldByName('CncSta').AsString:=pValue;
end;

function TOcilstDat.GetCctVat:byte;
begin
  Result:=oTable.FieldByName('CctVat').AsInteger;
end;

procedure TOcilstDat.SetCctVat(pValue:byte);
begin
  oTable.FieldByName('CctVat').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcilstDat.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TOcilstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOcilstDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TOcilstDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TOcilstDat.LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindKey([pDocNum,pProNum]);
end;

function TOcilstDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TOcilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TOcilstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOcilstDat.LocSnPaPnSt(pStkNum:word;pParNum:longint;pProNum:longint;pRstSta:Str1):boolean;
begin
  SetIndex(ixSnPaPnSt);
  Result:=oTable.FindKey([pStkNum,pParNum,pProNum,pRstSta]);
end;

function TOcilstDat.LocSnPnRq(pStkNum:word;pProNum:longint;pReqSta:Str1):boolean;
begin
  SetIndex(ixSnPnRq);
  Result:=oTable.FindKey([pStkNum,pProNum,pReqSta]);
end;

function TOcilstDat.LocSnPnUs(pStkNum:word;pProNum:longint;pUndSta:Str1):boolean;
begin
  SetIndex(ixSnPnUs);
  Result:=oTable.FindKey([pStkNum,pProNum,pUndSta]);
end;

function TOcilstDat.LocRstSta(pRstSta:Str1):boolean;
begin
  SetIndex(ixRstSta);
  Result:=oTable.FindKey([pRstSta]);
end;

function TOcilstDat.LocRosSta(pRosSta:Str1):boolean;
begin
  SetIndex(ixRosSta);
  Result:=oTable.FindKey([pRosSta]);
end;

function TOcilstDat.LocReqSta(pReqSta:Str1):boolean;
begin
  SetIndex(ixReqSta);
  Result:=oTable.FindKey([pReqSta]);
end;

function TOcilstDat.LocUndSta(pUndSta:Str1):boolean;
begin
  SetIndex(ixUndSta);
  Result:=oTable.FindKey([pUndSta]);
end;

function TOcilstDat.LocModSta(pModSta:Str1):boolean;
begin
  SetIndex(ixModSta);
  Result:=oTable.FindKey([pModSta]);
end;

function TOcilstDat.LocCncSta(pCncSta:Str1):boolean;
begin
  SetIndex(ixCncSta);
  Result:=oTable.FindKey([pCncSta]);
end;

function TOcilstDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TOcilstDat.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pStkCod]);
end;

function TOcilstDat.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindKey([pShpCod]);
end;

function TOcilstDat.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pOrdCod]);
end;

function TOcilstDat.NearItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

function TOcilstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOcilstDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TOcilstDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TOcilstDat.NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindNearest([pDocNum,pProNum]);
end;

function TOcilstDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TOcilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TOcilstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOcilstDat.NearSnPaPnSt(pStkNum:word;pParNum:longint;pProNum:longint;pRstSta:Str1):boolean;
begin
  SetIndex(ixSnPaPnSt);
  Result:=oTable.FindNearest([pStkNum,pParNum,pProNum,pRstSta]);
end;

function TOcilstDat.NearSnPnRq(pStkNum:word;pProNum:longint;pReqSta:Str1):boolean;
begin
  SetIndex(ixSnPnRq);
  Result:=oTable.FindNearest([pStkNum,pProNum,pReqSta]);
end;

function TOcilstDat.NearSnPnUs(pStkNum:word;pProNum:longint;pUndSta:Str1):boolean;
begin
  SetIndex(ixSnPnUs);
  Result:=oTable.FindNearest([pStkNum,pProNum,pUndSta]);
end;

function TOcilstDat.NearRstSta(pRstSta:Str1):boolean;
begin
  SetIndex(ixRstSta);
  Result:=oTable.FindNearest([pRstSta]);
end;

function TOcilstDat.NearRosSta(pRosSta:Str1):boolean;
begin
  SetIndex(ixRosSta);
  Result:=oTable.FindNearest([pRosSta]);
end;

function TOcilstDat.NearReqSta(pReqSta:Str1):boolean;
begin
  SetIndex(ixReqSta);
  Result:=oTable.FindNearest([pReqSta]);
end;

function TOcilstDat.NearUndSta(pUndSta:Str1):boolean;
begin
  SetIndex(ixUndSta);
  Result:=oTable.FindNearest([pUndSta]);
end;

function TOcilstDat.NearModSta(pModSta:Str1):boolean;
begin
  SetIndex(ixModSta);
  Result:=oTable.FindNearest([pModSta]);
end;

function TOcilstDat.NearCncSta(pCncSta:Str1):boolean;
begin
  SetIndex(ixCncSta);
  Result:=oTable.FindNearest([pCncSta]);
end;

function TOcilstDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TOcilstDat.NearStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pStkCod]);
end;

function TOcilstDat.NearShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindNearest([pShpCod]);
end;

function TOcilstDat.NearOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pOrdCod]);
end;

procedure TOcilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOcilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcilstDat.Next;
begin
  oTable.Next;
end;

procedure TOcilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcilstDat.Post;
begin
  oTable.Post;
end;

procedure TOcilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
