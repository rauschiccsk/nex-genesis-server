unit tOCILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixItmNum='ItmNum';
  ixPaDnIn='PaDnIn';
  ixProNum='ProNum';
  ixProNam_='ProNam_';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TOcilstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
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
    function GetCctVat:byte;             procedure SetCctVat (pValue:byte);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq (pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq (pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq (pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva (pValue:double);
    function GetFgdAva:double;           procedure SetFgdAva (pValue:double);
    function GetPrjAva:double;           procedure SetPrjAva (pValue:double);
    function GetSpcAva:double;           procedure SetSpcAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetExdBva:double;           procedure SetExdBva (pValue:double);
    function GetUndAva:double;           procedure SetUndAva (pValue:double);
    function GetUndBva:double;           procedure SetUndBva (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte (pValue:TDatetime);
    function GetRatPrv:TDatetime;        procedure SetRatPrv (pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot (pValue:Str50);
    function GetRatChg:byte;             procedure SetRatChg (pValue:byte);
    function GetRatCnt:byte;             procedure SetRatCnt (pValue:byte);
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
    function GetTciAdr:longint;          procedure SetTciAdr (pValue:longint);
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
    function GetCncSta:Str1;             procedure SetCncSta (pValue:Str1);
    function GetUndSta:Str1;             procedure SetUndSta (pValue:Str1);
    function GetSndSta:Str1;             procedure SetSndSta (pValue:Str1);
    function GetModSta:Str1;             procedure SetModSta (pValue:Str1);
    function GetExdSta:Str1;             procedure SetExdSta (pValue:Str1);
    function GetCrtUsr:str8;             procedure SetCrtUsr (pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetRemWri:word;             procedure SetRemWri (pValue:word);
    function GetRemStk:word;             procedure SetRemStk (pValue:word);
    function GetComNum:Str14;            procedure SetComNum (pValue:Str14);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetItmFrm:Str10;            procedure SetItmFrm (pValue:Str10);
    function GetTrsDte:TDatetime;        procedure SetTrsDte (pValue:TDatetime);
    function GetDlyDay:longint;          procedure SetDlyDay (pValue:longint);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocPaDnIn (pParNum:longint;pDocNum:Str12;pItmNum:word):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
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
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property BokNum:Str3 read GetBokNum write SetBokNum;
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
    property CctVat:byte read GetCctVat write SetCctVat;
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
    property ExdBva:double read GetExdBva write SetExdBva;
    property UndAva:double read GetUndAva write SetUndAva;
    property UndBva:double read GetUndBva write SetUndBva;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
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
    property SrdAdr:longint read GetSrdAdr write SetSrdAdr;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property SrdItm:word read GetSrdItm write SetSrdItm;
    property SrdQnt:byte read GetSrdQnt write SetSrdQnt;
    property McdAdr:longint read GetMcdAdr write SetMcdAdr;
    property McdNum:Str13 read GetMcdNum write SetMcdNum;
    property McdItm:word read GetMcdItm write SetMcdItm;
    property TciAdr:longint read GetTciAdr write SetTciAdr;
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
    property CncSta:Str1 read GetCncSta write SetCncSta;
    property UndSta:Str1 read GetUndSta write SetUndSta;
    property SndSta:Str1 read GetSndSta write SetSndSta;
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
    property DlyDay:longint read GetDlyDay write SetDlyDay;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOcilstTmp.Create;
begin
  oTmpTable:=TmpInit ('OCILST',Self);
end;

destructor TOcilstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcilstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcilstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcilstTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOcilstTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOcilstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOcilstTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOcilstTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOcilstTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOcilstTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOcilstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcilstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcilstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOcilstTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcilstTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOcilstTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcilstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOcilstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOcilstTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOcilstTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOcilstTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOcilstTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOcilstTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOcilstTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOcilstTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOcilstTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOcilstTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOcilstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOcilstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOcilstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOcilstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOcilstTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOcilstTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOcilstTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOcilstTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOcilstTmp.GetCctVat:byte;
begin
  Result:=oTmpTable.FieldByName('CctVat').AsInteger;
end;

procedure TOcilstTmp.SetCctVat(pValue:byte);
begin
  oTmpTable.FieldByName('CctVat').AsInteger:=pValue;
end;

function TOcilstTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOcilstTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOcilstTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOcilstTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetReqPrq:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOcilstTmp.SetReqPrq(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetRstPrq:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOcilstTmp.SetRstPrq(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetRosPrq:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOcilstTmp.SetRosPrq(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetExdPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOcilstTmp.SetExdPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOcilstTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOcilstTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOcilstTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOcilstTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOcilstTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TOcilstTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TOcilstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TOcilstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TOcilstTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetFgdAva:double;
begin
  Result:=oTmpTable.FieldByName('FgdAva').AsFloat;
end;

procedure TOcilstTmp.SetFgdAva(pValue:double);
begin
  oTmpTable.FieldByName('FgdAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetPrjAva:double;
begin
  Result:=oTmpTable.FieldByName('PrjAva').AsFloat;
end;

procedure TOcilstTmp.SetPrjAva(pValue:double);
begin
  oTmpTable.FieldByName('PrjAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetSpcAva:double;
begin
  Result:=oTmpTable.FieldByName('SpcAva').AsFloat;
end;

procedure TOcilstTmp.SetSpcAva(pValue:double);
begin
  oTmpTable.FieldByName('SpcAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOcilstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOcilstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TOcilstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TOcilstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetSapSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('SapSrc').AsString;
end;

procedure TOcilstTmp.SetSapSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TOcilstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOcilstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOcilstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOcilstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetExdBva:double;
begin
  Result:=oTmpTable.FieldByName('ExdBva').AsFloat;
end;

procedure TOcilstTmp.SetExdBva(pValue:double);
begin
  oTmpTable.FieldByName('ExdBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetUndAva:double;
begin
  Result:=oTmpTable.FieldByName('UndAva').AsFloat;
end;

procedure TOcilstTmp.SetUndAva(pValue:double);
begin
  oTmpTable.FieldByName('UndAva').AsFloat:=pValue;
end;

function TOcilstTmp.GetUndBva:double;
begin
  Result:=oTmpTable.FieldByName('UndBva').AsFloat;
end;

procedure TOcilstTmp.SetUndBva(pValue:double);
begin
  oTmpTable.FieldByName('UndBva').AsFloat:=pValue;
end;

function TOcilstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOcilstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOcilstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOcilstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOcilstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOcilstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOcilstTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcilstTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetRatPrv:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOcilstTmp.SetRatPrv(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOcilstTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcilstTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TOcilstTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOcilstTmp.GetRatChg:byte;
begin
  Result:=oTmpTable.FieldByName('RatChg').AsInteger;
end;

procedure TOcilstTmp.SetRatChg(pValue:byte);
begin
  oTmpTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOcilstTmp.GetRatCnt:byte;
begin
  Result:=oTmpTable.FieldByName('RatCnt').AsInteger;
end;

procedure TOcilstTmp.SetRatCnt(pValue:byte);
begin
  oTmpTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TOcilstTmp.GetOsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TOcilstTmp.SetOsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcilstTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcilstTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetOsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OsdDte').AsDateTime;
end;

procedure TOcilstTmp.SetOsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetOsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('OsdDoq').AsInteger;
end;

procedure TOcilstTmp.SetOsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('OsdDoq').AsInteger:=pValue;
end;

function TOcilstTmp.GetSrdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('SrdAdr').AsInteger;
end;

procedure TOcilstTmp.SetSrdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('SrdAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TOcilstTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOcilstTmp.GetSrdItm:word;
begin
  Result:=oTmpTable.FieldByName('SrdItm').AsInteger;
end;

procedure TOcilstTmp.SetSrdItm(pValue:word);
begin
  oTmpTable.FieldByName('SrdItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetSrdQnt:byte;
begin
  Result:=oTmpTable.FieldByName('SrdQnt').AsInteger;
end;

procedure TOcilstTmp.SetSrdQnt(pValue:byte);
begin
  oTmpTable.FieldByName('SrdQnt').AsInteger:=pValue;
end;

function TOcilstTmp.GetMcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('McdAdr').AsInteger;
end;

procedure TOcilstTmp.SetMcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('McdAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetMcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TOcilstTmp.SetMcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOcilstTmp.GetMcdItm:word;
begin
  Result:=oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TOcilstTmp.SetMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetTciAdr:longint;
begin
  Result:=oTmpTable.FieldByName('TciAdr').AsInteger;
end;

procedure TOcilstTmp.SetTciAdr(pValue:longint);
begin
  oTmpTable.FieldByName('TciAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOcilstTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOcilstTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOcilstTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetTcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TOcilstTmp.SetTcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetTcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOcilstTmp.SetTcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOcilstTmp.GetIcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('IcdAdr').AsInteger;
end;

procedure TOcilstTmp.SetIcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('IcdAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetIcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TOcilstTmp.SetIcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOcilstTmp.GetIcdItm:word;
begin
  Result:=oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOcilstTmp.SetIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetIcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IcdDte').AsDateTime;
end;

procedure TOcilstTmp.SetIcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetIcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOcilstTmp.SetIcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOcilstTmp.GetCadAdr:longint;
begin
  Result:=oTmpTable.FieldByName('CadAdr').AsInteger;
end;

procedure TOcilstTmp.SetCadAdr(pValue:longint);
begin
  oTmpTable.FieldByName('CadAdr').AsInteger:=pValue;
end;

function TOcilstTmp.GetCadNum:Str13;
begin
  Result:=oTmpTable.FieldByName('CadNum').AsString;
end;

procedure TOcilstTmp.SetCadNum(pValue:Str13);
begin
  oTmpTable.FieldByName('CadNum').AsString:=pValue;
end;

function TOcilstTmp.GetCadItm:word;
begin
  Result:=oTmpTable.FieldByName('CadItm').AsInteger;
end;

procedure TOcilstTmp.SetCadItm(pValue:word);
begin
  oTmpTable.FieldByName('CadItm').AsInteger:=pValue;
end;

function TOcilstTmp.GetCadDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CadDte').AsDateTime;
end;

procedure TOcilstTmp.SetCadDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CadDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetCadDoq:byte;
begin
  Result:=oTmpTable.FieldByName('CadDoq').AsInteger;
end;

procedure TOcilstTmp.SetCadDoq(pValue:byte);
begin
  oTmpTable.FieldByName('CadDoq').AsInteger:=pValue;
end;

function TOcilstTmp.GetRstSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RstSta').AsString;
end;

procedure TOcilstTmp.SetRstSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RstSta').AsString:=pValue;
end;

function TOcilstTmp.GetRosSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RosSta').AsString;
end;

procedure TOcilstTmp.SetRosSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RosSta').AsString:=pValue;
end;

function TOcilstTmp.GetCncSta:Str1;
begin
  Result:=oTmpTable.FieldByName('CncSta').AsString;
end;

procedure TOcilstTmp.SetCncSta(pValue:Str1);
begin
  oTmpTable.FieldByName('CncSta').AsString:=pValue;
end;

function TOcilstTmp.GetUndSta:Str1;
begin
  Result:=oTmpTable.FieldByName('UndSta').AsString;
end;

procedure TOcilstTmp.SetUndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('UndSta').AsString:=pValue;
end;

function TOcilstTmp.GetSndSta:Str1;
begin
  Result:=oTmpTable.FieldByName('SndSta').AsString;
end;

procedure TOcilstTmp.SetSndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('SndSta').AsString:=pValue;
end;

function TOcilstTmp.GetModSta:Str1;
begin
  Result:=oTmpTable.FieldByName('ModSta').AsString;
end;

procedure TOcilstTmp.SetModSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ModSta').AsString:=pValue;
end;

function TOcilstTmp.GetExdSta:Str1;
begin
  Result:=oTmpTable.FieldByName('ExdSta').AsString;
end;

procedure TOcilstTmp.SetExdSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ExdSta').AsString:=pValue;
end;

function TOcilstTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcilstTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcilstTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcilstTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcilstTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOcilstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOcilstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOcilstTmp.GetRemWri:word;
begin
  Result:=oTmpTable.FieldByName('RemWri').AsInteger;
end;

procedure TOcilstTmp.SetRemWri(pValue:word);
begin
  oTmpTable.FieldByName('RemWri').AsInteger:=pValue;
end;

function TOcilstTmp.GetRemStk:word;
begin
  Result:=oTmpTable.FieldByName('RemStk').AsInteger;
end;

procedure TOcilstTmp.SetRemStk(pValue:word);
begin
  oTmpTable.FieldByName('RemStk').AsInteger:=pValue;
end;

function TOcilstTmp.GetComNum:Str14;
begin
  Result:=oTmpTable.FieldByName('ComNum').AsString;
end;

procedure TOcilstTmp.SetComNum(pValue:Str14);
begin
  oTmpTable.FieldByName('ComNum').AsString:=pValue;
end;

function TOcilstTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOcilstTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOcilstTmp.GetItmFrm:Str10;
begin
  Result:=oTmpTable.FieldByName('ItmFrm').AsString;
end;

procedure TOcilstTmp.SetItmFrm(pValue:Str10);
begin
  oTmpTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TOcilstTmp.GetTrsDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TrsDte').AsDateTime;
end;

procedure TOcilstTmp.SetTrsDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrsDte').AsDateTime:=pValue;
end;

function TOcilstTmp.GetDlyDay:longint;
begin
  Result:=oTmpTable.FieldByName('DlyDay').AsInteger;
end;

procedure TOcilstTmp.SetDlyDay(pValue:longint);
begin
  oTmpTable.FieldByName('DlyDay').AsInteger:=pValue;
end;

function TOcilstTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOcilstTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcilstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcilstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcilstTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOcilstTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TOcilstTmp.LocPaDnIn(pParNum:longint;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixPaDnIn);
  Result:=oTmpTable.FindKey([pParNum,pDocNum,pItmNum]);
end;

function TOcilstTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOcilstTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TOcilstTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TOcilstTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TOcilstTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TOcilstTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TOcilstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcilstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcilstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcilstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcilstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcilstTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcilstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcilstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcilstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcilstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcilstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcilstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcilstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcilstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcilstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcilstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcilstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
