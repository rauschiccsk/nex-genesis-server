unit tOCIPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItIa='';
  ixItIaRd='ItIaRd';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TOciprnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmTyp:byte;             procedure SetItmTyp (pValue:byte);
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetItmDes:Str20;            procedure SetItmDes (pValue:Str20);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetProVol:double;           procedure SetProVol (pValue:double);
    function GetProWgh:double;           procedure SetProWgh (pValue:double);
    function GetProTyp:Str1;             procedure SetProTyp (pValue:Str1);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq (pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq (pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq (pValue:double);
    function GetResPrq:double;           procedure SetResPrq (pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq (pValue:double);
    function GetMinApc:double;           procedure SetMinApc (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva (pValue:double);
    function GetFgdAva:double;           procedure SetFgdAva (pValue:double);
    function GetPrjAva:double;           procedure SetPrjAva (pValue:double);
    function GetSpcAva:double;           procedure SetSpcAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
    function GetSalBpc:double;           procedure SetSalBpc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetReqDte:TDatetime;        procedure SetReqDte (pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
    function GetRatPrv:TDatetime;        procedure SetRatPrv (pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot (pValue:Str50);
    function GetRatChg:byte;             procedure SetRatChg (pValue:byte);
    function GetRatCnt:byte;             procedure SetRatCnt (pValue:byte);
    function GetRatDes:Str50;            procedure SetRatDes (pValue:Str50);
    function GetTrsDte:TDatetime;        procedure SetTrsDte (pValue:TDatetime);
    function GetOsdNum:Str13;            procedure SetOsdNum (pValue:Str13);
    function GetOsdItm:word;             procedure SetOsdItm (pValue:word);
    function GetOsdDte:TDatetime;        procedure SetOsdDte (pValue:TDatetime);
    function GetOsdDoq:byte;             procedure SetOsdDoq (pValue:byte);
    function GetSrdAdr:longint;          procedure SetSrdAdr (pValue:longint);
    function GetSrdNum:Str13;            procedure SetSrdNum (pValue:Str13);
    function GetSrdItm:word;             procedure SetSrdItm (pValue:word);
    function GetSrdQnt:byte;             procedure SetSrdQnt (pValue:byte);
    function GetMcdAdr:longint;          procedure SetMcdAdr (pValue:longint);
    function GetMcdNum:Str13;            procedure SetMcdNum (pValue:Str13);
    function GetMcdItm:word;             procedure SetMcdItm (pValue:word);
    function GetTcdAdr:longint;          procedure SetTcdAdr (pValue:longint);
    function GetTcdNum:Str13;            procedure SetTcdNum (pValue:Str13);
    function GetTcdItm:word;             procedure SetTcdItm (pValue:word);
    function GetTcdDte:TDatetime;        procedure SetTcdDte (pValue:TDatetime);
    function GetTcdDoq:byte;             procedure SetTcdDoq (pValue:byte);
    function GetIcdAdr:longint;          procedure SetIcdAdr (pValue:longint);
    function GetIcdNum:Str13;            procedure SetIcdNum (pValue:Str13);
    function GetIcdItm:word;             procedure SetIcdItm (pValue:word);
    function GetIcdDte:TDatetime;        procedure SetIcdDte (pValue:TDatetime);
    function GetIcdDoq:byte;             procedure SetIcdDoq (pValue:byte);
    function GetCadAdr:longint;          procedure SetCadAdr (pValue:longint);
    function GetCadNum:Str13;            procedure SetCadNum (pValue:Str13);
    function GetCadItm:word;             procedure SetCadItm (pValue:word);
    function GetCadDte:TDatetime;        procedure SetCadDte (pValue:TDatetime);
    function GetCadDoq:byte;             procedure SetCadDoq (pValue:byte);
    function GetRstSta:Str1;             procedure SetRstSta (pValue:Str1);
    function GetRosSta:Str1;             procedure SetRosSta (pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetRemWri:word;             procedure SetRemWri (pValue:word);
    function GetRemStk:word;             procedure SetRemStk (pValue:word);
    function GetComNum:Str14;            procedure SetComNum (pValue:Str14);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItIa (pItmTyp:byte;pItmAdr:longint):boolean;
    function LocItIaRd (pItmTyp:byte;pItmAdr:longint;pRatDte:TDatetime):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam (pProNam:Str60):boolean;
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
    property ItmTyp:byte read GetItmTyp write SetItmTyp;
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property ItmDes:Str20 read GetItmDes write SetItmDes;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
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
    property ResPrq:double read GetResPrq write SetResPrq;
    property ExdPrq:double read GetExdPrq write SetExdPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property MinApc:double read GetMinApc write SetMinApc;
    property StkAva:double read GetStkAva write SetStkAva;
    property PlsAva:double read GetPlsAva write SetPlsAva;
    property FgdAva:double read GetFgdAva write SetFgdAva;
    property PrjAva:double read GetPrjAva write SetPrjAva;
    property SpcAva:double read GetSpcAva write SetSpcAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property SalApc:double read GetSalApc write SetSalApc;
    property SalBpc:double read GetSalBpc write SetSalBpc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property SapSrc:Str2 read GetSapSrc write SetSapSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatPrv:TDatetime read GetRatPrv write SetRatPrv;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property RatChg:byte read GetRatChg write SetRatChg;
    property RatCnt:byte read GetRatCnt write SetRatCnt;
    property RatDes:Str50 read GetRatDes write SetRatDes;
    property TrsDte:TDatetime read GetTrsDte write SetTrsDte;
    property OsdNum:Str13 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OsdDte:TDatetime read GetOsdDte write SetOsdDte;
    property OsdDoq:byte read GetOsdDoq write SetOsdDoq;
    property SrdAdr:longint read GetSrdAdr write SetSrdAdr;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property SrdItm:word read GetSrdItm write SetSrdItm;
    property SrdQnt:byte read GetSrdQnt write SetSrdQnt;
    property McdAdr:longint read GetMcdAdr write SetMcdAdr;
    property McdNum:Str13 read GetMcdNum write SetMcdNum;
    property McdItm:word read GetMcdItm write SetMcdItm;
    property TcdAdr:longint read GetTcdAdr write SetTcdAdr;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property TcdDte:TDatetime read GetTcdDte write SetTcdDte;
    property TcdDoq:byte read GetTcdDoq write SetTcdDoq;
    property IcdAdr:longint read GetIcdAdr write SetIcdAdr;
    property IcdNum:Str13 read GetIcdNum write SetIcdNum;
    property IcdItm:word read GetIcdItm write SetIcdItm;
    property IcdDte:TDatetime read GetIcdDte write SetIcdDte;
    property IcdDoq:byte read GetIcdDoq write SetIcdDoq;
    property CadAdr:longint read GetCadAdr write SetCadAdr;
    property CadNum:Str13 read GetCadNum write SetCadNum;
    property CadItm:word read GetCadItm write SetCadItm;
    property CadDte:TDatetime read GetCadDte write SetCadDte;
    property CadDoq:byte read GetCadDoq write SetCadDoq;
    property RstSta:Str1 read GetRstSta write SetRstSta;
    property RosSta:Str1 read GetRosSta write SetRosSta;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property RemWri:word read GetRemWri write SetRemWri;
    property RemStk:word read GetRemStk write SetRemStk;
    property ComNum:Str14 read GetComNum write SetComNum;
    property Notice:Str50 read GetNotice write SetNotice;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOciprnTmp.Create;
begin
  oTmpTable:=TmpInit ('OCIPRN',Self);
end;

destructor TOciprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOciprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOciprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOciprnTmp.GetItmTyp:byte;
begin
  Result:=oTmpTable.FieldByName('ItmTyp').AsInteger;
end;

procedure TOciprnTmp.SetItmTyp(pValue:byte);
begin
  oTmpTable.FieldByName('ItmTyp').AsInteger:=pValue;
end;

function TOciprnTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOciprnTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetItmDes:Str20;
begin
  Result:=oTmpTable.FieldByName('ItmDes').AsString;
end;

procedure TOciprnTmp.SetItmDes(pValue:Str20);
begin
  oTmpTable.FieldByName('ItmDes').AsString:=pValue;
end;

function TOciprnTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOciprnTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOciprnTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOciprnTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOciprnTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOciprnTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOciprnTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOciprnTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOciprnTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOciprnTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOciprnTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOciprnTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOciprnTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOciprnTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOciprnTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOciprnTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOciprnTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOciprnTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOciprnTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOciprnTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOciprnTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOciprnTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOciprnTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOciprnTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOciprnTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOciprnTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOciprnTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOciprnTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOciprnTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOciprnTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetReqPrq:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOciprnTmp.SetReqPrq(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetRstPrq:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOciprnTmp.SetRstPrq(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetRosPrq:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOciprnTmp.SetRosPrq(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetResPrq:double;
begin
  Result:=oTmpTable.FieldByName('ResPrq').AsFloat;
end;

procedure TOciprnTmp.SetResPrq(pValue:double);
begin
  oTmpTable.FieldByName('ResPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetExdPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOciprnTmp.SetExdPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOciprnTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOciprnTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOciprnTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOciprnTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOciprnTmp.GetMinApc:double;
begin
  Result:=oTmpTable.FieldByName('MinApc').AsFloat;
end;

procedure TOciprnTmp.SetMinApc(pValue:double);
begin
  oTmpTable.FieldByName('MinApc').AsFloat:=pValue;
end;

function TOciprnTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TOciprnTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TOciprnTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetFgdAva:double;
begin
  Result:=oTmpTable.FieldByName('FgdAva').AsFloat;
end;

procedure TOciprnTmp.SetFgdAva(pValue:double);
begin
  oTmpTable.FieldByName('FgdAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetPrjAva:double;
begin
  Result:=oTmpTable.FieldByName('PrjAva').AsFloat;
end;

procedure TOciprnTmp.SetPrjAva(pValue:double);
begin
  oTmpTable.FieldByName('PrjAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetSpcAva:double;
begin
  Result:=oTmpTable.FieldByName('SpcAva').AsFloat;
end;

procedure TOciprnTmp.SetSpcAva(pValue:double);
begin
  oTmpTable.FieldByName('SpcAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOciprnTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOciprnTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TOciprnTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TOciprnTmp.GetSalBpc:double;
begin
  Result:=oTmpTable.FieldByName('SalBpc').AsFloat;
end;

procedure TOciprnTmp.SetSalBpc(pValue:double);
begin
  oTmpTable.FieldByName('SalBpc').AsFloat:=pValue;
end;

function TOciprnTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TOciprnTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOciprnTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TOciprnTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOciprnTmp.GetSapSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('SapSrc').AsString;
end;

procedure TOciprnTmp.SetSapSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TOciprnTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOciprnTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOciprnTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOciprnTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOciprnTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOciprnTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOciprnTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOciprnTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOciprnTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetRatPrv:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOciprnTmp.SetRatPrv(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOciprnTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TOciprnTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOciprnTmp.GetRatChg:byte;
begin
  Result:=oTmpTable.FieldByName('RatChg').AsInteger;
end;

procedure TOciprnTmp.SetRatChg(pValue:byte);
begin
  oTmpTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOciprnTmp.GetRatCnt:byte;
begin
  Result:=oTmpTable.FieldByName('RatCnt').AsInteger;
end;

procedure TOciprnTmp.SetRatCnt(pValue:byte);
begin
  oTmpTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TOciprnTmp.GetRatDes:Str50;
begin
  Result:=oTmpTable.FieldByName('RatDes').AsString;
end;

procedure TOciprnTmp.SetRatDes(pValue:Str50);
begin
  oTmpTable.FieldByName('RatDes').AsString:=pValue;
end;

function TOciprnTmp.GetTrsDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TrsDte').AsDateTime;
end;

procedure TOciprnTmp.SetTrsDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrsDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetOsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TOciprnTmp.SetOsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOciprnTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOciprnTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetOsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OsdDte').AsDateTime;
end;

procedure TOciprnTmp.SetOsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetOsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('OsdDoq').AsInteger;
end;

procedure TOciprnTmp.SetOsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('OsdDoq').AsInteger:=pValue;
end;

function TOciprnTmp.GetSrdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('SrdAdr').AsInteger;
end;

procedure TOciprnTmp.SetSrdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('SrdAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TOciprnTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOciprnTmp.GetSrdItm:word;
begin
  Result:=oTmpTable.FieldByName('SrdItm').AsInteger;
end;

procedure TOciprnTmp.SetSrdItm(pValue:word);
begin
  oTmpTable.FieldByName('SrdItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetSrdQnt:byte;
begin
  Result:=oTmpTable.FieldByName('SrdQnt').AsInteger;
end;

procedure TOciprnTmp.SetSrdQnt(pValue:byte);
begin
  oTmpTable.FieldByName('SrdQnt').AsInteger:=pValue;
end;

function TOciprnTmp.GetMcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('McdAdr').AsInteger;
end;

procedure TOciprnTmp.SetMcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('McdAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetMcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TOciprnTmp.SetMcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOciprnTmp.GetMcdItm:word;
begin
  Result:=oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TOciprnTmp.SetMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetTcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('TcdAdr').AsInteger;
end;

procedure TOciprnTmp.SetTcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('TcdAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOciprnTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOciprnTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOciprnTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetTcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TOciprnTmp.SetTcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetTcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOciprnTmp.SetTcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOciprnTmp.GetIcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('IcdAdr').AsInteger;
end;

procedure TOciprnTmp.SetIcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('IcdAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetIcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TOciprnTmp.SetIcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOciprnTmp.GetIcdItm:word;
begin
  Result:=oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOciprnTmp.SetIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetIcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IcdDte').AsDateTime;
end;

procedure TOciprnTmp.SetIcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetIcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOciprnTmp.SetIcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOciprnTmp.GetCadAdr:longint;
begin
  Result:=oTmpTable.FieldByName('CadAdr').AsInteger;
end;

procedure TOciprnTmp.SetCadAdr(pValue:longint);
begin
  oTmpTable.FieldByName('CadAdr').AsInteger:=pValue;
end;

function TOciprnTmp.GetCadNum:Str13;
begin
  Result:=oTmpTable.FieldByName('CadNum').AsString;
end;

procedure TOciprnTmp.SetCadNum(pValue:Str13);
begin
  oTmpTable.FieldByName('CadNum').AsString:=pValue;
end;

function TOciprnTmp.GetCadItm:word;
begin
  Result:=oTmpTable.FieldByName('CadItm').AsInteger;
end;

procedure TOciprnTmp.SetCadItm(pValue:word);
begin
  oTmpTable.FieldByName('CadItm').AsInteger:=pValue;
end;

function TOciprnTmp.GetCadDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CadDte').AsDateTime;
end;

procedure TOciprnTmp.SetCadDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CadDte').AsDateTime:=pValue;
end;

function TOciprnTmp.GetCadDoq:byte;
begin
  Result:=oTmpTable.FieldByName('CadDoq').AsInteger;
end;

procedure TOciprnTmp.SetCadDoq(pValue:byte);
begin
  oTmpTable.FieldByName('CadDoq').AsInteger:=pValue;
end;

function TOciprnTmp.GetRstSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RstSta').AsString;
end;

procedure TOciprnTmp.SetRstSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RstSta').AsString:=pValue;
end;

function TOciprnTmp.GetRosSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RosSta').AsString;
end;

procedure TOciprnTmp.SetRosSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RosSta').AsString:=pValue;
end;

function TOciprnTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOciprnTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOciprnTmp.GetRemWri:word;
begin
  Result:=oTmpTable.FieldByName('RemWri').AsInteger;
end;

procedure TOciprnTmp.SetRemWri(pValue:word);
begin
  oTmpTable.FieldByName('RemWri').AsInteger:=pValue;
end;

function TOciprnTmp.GetRemStk:word;
begin
  Result:=oTmpTable.FieldByName('RemStk').AsInteger;
end;

procedure TOciprnTmp.SetRemStk(pValue:word);
begin
  oTmpTable.FieldByName('RemStk').AsInteger:=pValue;
end;

function TOciprnTmp.GetComNum:Str14;
begin
  Result:=oTmpTable.FieldByName('ComNum').AsString;
end;

procedure TOciprnTmp.SetComNum(pValue:Str14);
begin
  oTmpTable.FieldByName('ComNum').AsString:=pValue;
end;

function TOciprnTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOciprnTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOciprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOciprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOciprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOciprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOciprnTmp.LocItIa(pItmTyp:byte;pItmAdr:longint):boolean;
begin
  SetIndex (ixItIa);
  Result:=oTmpTable.FindKey([pItmTyp,pItmAdr]);
end;

function TOciprnTmp.LocItIaRd(pItmTyp:byte;pItmAdr:longint;pRatDte:TDatetime):boolean;
begin
  SetIndex (ixItIaRd);
  Result:=oTmpTable.FindKey([pItmTyp,pItmAdr,pRatDte]);
end;

function TOciprnTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOciprnTmp.LocProNam(pProNam:Str60):boolean;
begin
  SetIndex (ixProNam);
  Result:=oTmpTable.FindKey([pProNam]);
end;

function TOciprnTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TOciprnTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TOciprnTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TOciprnTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TOciprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOciprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOciprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOciprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOciprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOciprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TOciprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOciprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOciprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOciprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOciprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOciprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOciprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOciprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOciprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOciprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOciprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
