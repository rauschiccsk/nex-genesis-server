unit dOSILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixItmAdr='ItmAdr';
  ixItmNum='ItmNum';
  ixDnIn='DnIn';
  ixDnPn='DnPn';
  ixSnPn='SnPn';
  ixPnFr='PnFr';
  ixProNam='ProNam';
  ixParNum='ParNum';
  ixItmSta='ItmSta';
  ixPnSt='PnSt';
  ixPaSt='PaSt';
  ixPaPnSt='PaPnSt';
  ixProNum='ProNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixOrdCod='OrdCod';

type
  TOsilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetItmAdr:longint;          procedure SetItmAdr(pValue:longint);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
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
    function GetOrdPrq:double;           procedure SetOrdPrq(pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq(pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq(pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq(pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc(pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva(pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva(pValue:double);
    function GetOrpSrc:Str2;             procedure SetOrpSrc(pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva(pValue:double);
    function GetEndBva:double;           procedure SetEndBva(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetRatDay:word;             procedure SetRatDay(pValue:word);
    function GetRatTyp:Str1;             procedure SetRatTyp(pValue:Str1);
    function GetRatDte:TDatetime;        procedure SetRatDte(pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot(pValue:Str50);
    function GetRatPrv:TDatetime;        procedure SetRatPrv(pValue:TDatetime);
    function GetRatChg:byte;             procedure SetRatChg(pValue:byte);
    function GetTsdNum:Str13;            procedure SetTsdNum(pValue:Str13);
    function GetTsdItm:word;             procedure SetTsdItm(pValue:word);
    function GetTsdDte:TDatetime;        procedure SetTsdDte(pValue:TDatetime);
    function GetTsdDoq:byte;             procedure SetTsdDoq(pValue:byte);
    function GetIsdNum:Str13;            procedure SetIsdNum(pValue:Str13);
    function GetIsdItm:word;             procedure SetIsdItm(pValue:word);
    function GetIsdDte:TDatetime;        procedure SetIsdDte(pValue:TDatetime);
    function GetIsdDoq:byte;             procedure SetIsdDoq(pValue:byte);
    function GetFreRes:byte;             procedure SetFreRes(pValue:byte);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetSndSta:Str1;             procedure SetSndSta(pValue:Str1);
    function GetItmFrm:Str10;            procedure SetItmFrm(pValue:Str10);
    function GetItmSta:Str1;             procedure SetItmSta(pValue:Str1);
    function GetSndDte:TDatetime;        procedure SetSndDte(pValue:TDatetime);
    function GetCctVat:byte;             procedure SetCctVat(pValue:byte);
    function GetIcdNum:Str12;            procedure SetIcdNum(pValue:Str12);
    function GetIcdItm:word;             procedure SetIcdItm(pValue:word);
    function GetNodNum:Str12;            procedure SetNodNum(pValue:Str12);
    function GetNodItm:word;             procedure SetNodItm(pValue:word);
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
    function LocDocNum(pDocNum:Str12):boolean;
    function LocItmAdr(pItmAdr:longint):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocPnFr(pProNum:longint;pFreRes:byte):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocItmSta(pItmSta:Str1):boolean;
    function LocPnSt(pProNum:longint;pItmSta:Str1):boolean;
    function LocPaSt(pParNum:longint;pItmSta:Str1):boolean;
    function LocPaPnSt(pParNum:longint;pProNum:longint;pItmSta:Str1):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocStkCod(pStkCod:Str15):boolean;
    function LocOrdCod(pOrdCod:Str30):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearItmAdr(pItmAdr:longint):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearPnFr(pProNum:longint;pFreRes:byte):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearItmSta(pItmSta:Str1):boolean;
    function NearPnSt(pProNum:longint;pItmSta:Str1):boolean;
    function NearPaSt(pParNum:longint;pItmSta:Str1):boolean;
    function NearPaPnSt(pParNum:longint;pProNum:longint;pItmSta:Str1):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearStkCod(pStkCod:Str15):boolean;
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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
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
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property OrdApc:double read GetOrdApc write SetOrdApc;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property OrpSrc:Str2 read GetOrpSrc write SetOrpSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property RatDay:word read GetRatDay write SetRatDay;
    property RatTyp:Str1 read GetRatTyp write SetRatTyp;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property RatPrv:TDatetime read GetRatPrv write SetRatPrv;
    property RatChg:byte read GetRatChg write SetRatChg;
    property TsdNum:Str13 read GetTsdNum write SetTsdNum;
    property TsdItm:word read GetTsdItm write SetTsdItm;
    property TsdDte:TDatetime read GetTsdDte write SetTsdDte;
    property TsdDoq:byte read GetTsdDoq write SetTsdDoq;
    property IsdNum:Str13 read GetIsdNum write SetIsdNum;
    property IsdItm:word read GetIsdItm write SetIsdItm;
    property IsdDte:TDatetime read GetIsdDte write SetIsdDte;
    property IsdDoq:byte read GetIsdDoq write SetIsdDoq;
    property FreRes:byte read GetFreRes write SetFreRes;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property Notice:Str50 read GetNotice write SetNotice;
    property SndSta:Str1 read GetSndSta write SetSndSta;
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
    property ItmSta:Str1 read GetItmSta write SetItmSta;
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property CctVat:byte read GetCctVat write SetCctVat;
    property IcdNum:Str12 read GetIcdNum write SetIcdNum;
    property IcdItm:word read GetIcdItm write SetIcdItm;
    property NodNum:Str12 read GetNodNum write SetNodNum;
    property NodItm:word read GetNodItm write SetNodItm;
  end;

implementation

constructor TOsilstDat.Create;
begin
  oTable:=DatInit('OSILST',gPath.StkPath,Self);
end;

constructor TOsilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSILST',pPath,Self);
end;

destructor TOsilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsilstDat.GetItmAdr:longint;
begin
  Result:=oTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOsilstDat.SetItmAdr(pValue:longint);
begin
  oTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOsilstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TOsilstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOsilstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TOsilstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOsilstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOsilstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsilstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsilstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsilstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TOsilstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOsilstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsilstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsilstDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOsilstDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOsilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsilstDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsilstDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsilstDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsilstDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsilstDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOsilstDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOsilstDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TOsilstDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsilstDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TOsilstDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsilstDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TOsilstDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOsilstDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TOsilstDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsilstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TOsilstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOsilstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOsilstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOsilstDat.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TOsilstDat.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOsilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TOsilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsilstDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsilstDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsilstDat.GetOrdPrq:double;
begin
  Result:=oTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsilstDat.SetOrdPrq(pValue:double);
begin
  oTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetRocPrq:double;
begin
  Result:=oTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOsilstDat.SetRocPrq(pValue:double);
begin
  oTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetTsdPrq:double;
begin
  Result:=oTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOsilstDat.SetTsdPrq(pValue:double);
begin
  oTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetCncPrq:double;
begin
  Result:=oTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOsilstDat.SetCncPrq(pValue:double);
begin
  oTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOsilstDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetIsdPrq:double;
begin
  Result:=oTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOsilstDat.SetIsdPrq(pValue:double);
begin
  oTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOsilstDat.GetOrdApc:double;
begin
  Result:=oTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsilstDat.SetOrdApc(pValue:double);
begin
  oTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsilstDat.GetOrdAva:double;
begin
  Result:=oTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsilstDat.SetOrdAva(pValue:double);
begin
  oTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsilstDat.GetOrdBva:double;
begin
  Result:=oTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsilstDat.SetOrdBva(pValue:double);
begin
  oTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsilstDat.GetOrpSrc:Str2;
begin
  Result:=oTable.FieldByName('OrpSrc').AsString;
end;

procedure TOsilstDat.SetOrpSrc(pValue:Str2);
begin
  oTable.FieldByName('OrpSrc').AsString:=pValue;
end;

function TOsilstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOsilstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOsilstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TOsilstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOsilstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOsilstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOsilstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsilstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsilstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOsilstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetRatDay:word;
begin
  Result:=oTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsilstDat.SetRatDay(pValue:word);
begin
  oTable.FieldByName('RatDay').AsInteger:=pValue;
end;

function TOsilstDat.GetRatTyp:Str1;
begin
  Result:=oTable.FieldByName('RatTyp').AsString;
end;

procedure TOsilstDat.SetRatTyp(pValue:Str1);
begin
  oTable.FieldByName('RatTyp').AsString:=pValue;
end;

function TOsilstDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsilstDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetRatNot:Str50;
begin
  Result:=oTable.FieldByName('RatNot').AsString;
end;

procedure TOsilstDat.SetRatNot(pValue:Str50);
begin
  oTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOsilstDat.GetRatPrv:TDatetime;
begin
  Result:=oTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOsilstDat.SetRatPrv(pValue:TDatetime);
begin
  oTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOsilstDat.GetRatChg:byte;
begin
  Result:=oTable.FieldByName('RatChg').AsInteger;
end;

procedure TOsilstDat.SetRatChg(pValue:byte);
begin
  oTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOsilstDat.GetTsdNum:Str13;
begin
  Result:=oTable.FieldByName('TsdNum').AsString;
end;

procedure TOsilstDat.SetTsdNum(pValue:Str13);
begin
  oTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOsilstDat.GetTsdItm:word;
begin
  Result:=oTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOsilstDat.SetTsdItm(pValue:word);
begin
  oTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TOsilstDat.GetTsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TsdDte').AsDateTime;
end;

procedure TOsilstDat.SetTsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TsdDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetTsdDoq:byte;
begin
  Result:=oTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOsilstDat.SetTsdDoq(pValue:byte);
begin
  oTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOsilstDat.GetIsdNum:Str13;
begin
  Result:=oTable.FieldByName('IsdNum').AsString;
end;

procedure TOsilstDat.SetIsdNum(pValue:Str13);
begin
  oTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOsilstDat.GetIsdItm:word;
begin
  Result:=oTable.FieldByName('IsdItm').AsInteger;
end;

procedure TOsilstDat.SetIsdItm(pValue:word);
begin
  oTable.FieldByName('IsdItm').AsInteger:=pValue;
end;

function TOsilstDat.GetIsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('IsdDte').AsDateTime;
end;

procedure TOsilstDat.SetIsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('IsdDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetIsdDoq:byte;
begin
  Result:=oTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOsilstDat.SetIsdDoq(pValue:byte);
begin
  oTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOsilstDat.GetFreRes:byte;
begin
  Result:=oTable.FieldByName('FreRes').AsInteger;
end;

procedure TOsilstDat.SetFreRes(pValue:byte);
begin
  oTable.FieldByName('FreRes').AsInteger:=pValue;
end;

function TOsilstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOsilstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOsilstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOsilstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOsilstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOsilstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TOsilstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOsilstDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOsilstDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TOsilstDat.GetSndSta:Str1;
begin
  Result:=oTable.FieldByName('SndSta').AsString;
end;

procedure TOsilstDat.SetSndSta(pValue:Str1);
begin
  oTable.FieldByName('SndSta').AsString:=pValue;
end;

function TOsilstDat.GetItmFrm:Str10;
begin
  Result:=oTable.FieldByName('ItmFrm').AsString;
end;

procedure TOsilstDat.SetItmFrm(pValue:Str10);
begin
  oTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TOsilstDat.GetItmSta:Str1;
begin
  Result:=oTable.FieldByName('ItmSta').AsString;
end;

procedure TOsilstDat.SetItmSta(pValue:Str1);
begin
  oTable.FieldByName('ItmSta').AsString:=pValue;
end;

function TOsilstDat.GetSndDte:TDatetime;
begin
  Result:=oTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOsilstDat.SetSndDte(pValue:TDatetime);
begin
  oTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOsilstDat.GetCctVat:byte;
begin
  Result:=oTable.FieldByName('CctVat').AsInteger;
end;

procedure TOsilstDat.SetCctVat(pValue:byte);
begin
  oTable.FieldByName('CctVat').AsInteger:=pValue;
end;

function TOsilstDat.GetIcdNum:Str12;
begin
  Result:=oTable.FieldByName('IcdNum').AsString;
end;

procedure TOsilstDat.SetIcdNum(pValue:Str12);
begin
  oTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOsilstDat.GetIcdItm:word;
begin
  Result:=oTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOsilstDat.SetIcdItm(pValue:word);
begin
  oTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TOsilstDat.GetNodNum:Str12;
begin
  Result:=oTable.FieldByName('NodNum').AsString;
end;

procedure TOsilstDat.SetNodNum(pValue:Str12);
begin
  oTable.FieldByName('NodNum').AsString:=pValue;
end;

function TOsilstDat.GetNodItm:word;
begin
  Result:=oTable.FieldByName('NodItm').AsInteger;
end;

procedure TOsilstDat.SetNodItm(pValue:word);
begin
  oTable.FieldByName('NodItm').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsilstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOsilstDat.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TOsilstDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TOsilstDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TOsilstDat.LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindKey([pDocNum,pProNum]);
end;

function TOsilstDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TOsilstDat.LocPnFr(pProNum:longint;pFreRes:byte):boolean;
begin
  SetIndex(ixPnFr);
  Result:=oTable.FindKey([pProNum,pFreRes]);
end;

function TOsilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TOsilstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOsilstDat.LocItmSta(pItmSta:Str1):boolean;
begin
  SetIndex(ixItmSta);
  Result:=oTable.FindKey([pItmSta]);
end;

function TOsilstDat.LocPnSt(pProNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPnSt);
  Result:=oTable.FindKey([pProNum,pItmSta]);
end;

function TOsilstDat.LocPaSt(pParNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPaSt);
  Result:=oTable.FindKey([pParNum,pItmSta]);
end;

function TOsilstDat.LocPaPnSt(pParNum:longint;pProNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPaPnSt);
  Result:=oTable.FindKey([pParNum,pProNum,pItmSta]);
end;

function TOsilstDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TOsilstDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TOsilstDat.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pStkCod]);
end;

function TOsilstDat.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pOrdCod]);
end;

function TOsilstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOsilstDat.NearItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

function TOsilstDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TOsilstDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TOsilstDat.NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindNearest([pDocNum,pProNum]);
end;

function TOsilstDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TOsilstDat.NearPnFr(pProNum:longint;pFreRes:byte):boolean;
begin
  SetIndex(ixPnFr);
  Result:=oTable.FindNearest([pProNum,pFreRes]);
end;

function TOsilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TOsilstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOsilstDat.NearItmSta(pItmSta:Str1):boolean;
begin
  SetIndex(ixItmSta);
  Result:=oTable.FindNearest([pItmSta]);
end;

function TOsilstDat.NearPnSt(pProNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPnSt);
  Result:=oTable.FindNearest([pProNum,pItmSta]);
end;

function TOsilstDat.NearPaSt(pParNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPaSt);
  Result:=oTable.FindNearest([pParNum,pItmSta]);
end;

function TOsilstDat.NearPaPnSt(pParNum:longint;pProNum:longint;pItmSta:Str1):boolean;
begin
  SetIndex(ixPaPnSt);
  Result:=oTable.FindNearest([pParNum,pProNum,pItmSta]);
end;

function TOsilstDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TOsilstDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TOsilstDat.NearStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pStkCod]);
end;

function TOsilstDat.NearOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pOrdCod]);
end;

procedure TOsilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOsilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsilstDat.Next;
begin
  oTable.Next;
end;

procedure TOsilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsilstDat.Post;
begin
  oTable.Post;
end;

procedure TOsilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2202001}
