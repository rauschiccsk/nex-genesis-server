unit tROCREF;

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
  TRocrefTmp=class(TComponent)
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
    function GetReqMpq:double;           procedure SetReqMpq (pValue:double);
    function GetRstMpq:double;           procedure SetRstMpq (pValue:double);
    function GetRosMpq:double;           procedure SetRosMpq (pValue:double);
    function GetUndMpq:double;           procedure SetUndMpq (pValue:double);
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
    property ReqMpq:double read GetReqMpq write SetReqMpq;
    property RstMpq:double read GetRstMpq write SetRstMpq;
    property RosMpq:double read GetRosMpq write SetRosMpq;
    property UndMpq:double read GetUndMpq write SetUndMpq;
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

constructor TRocrefTmp.Create;
begin
  oTmpTable:=TmpInit ('ROCREF',Self);
end;

destructor TRocrefTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRocrefTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TRocrefTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TRocrefTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TRocrefTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TRocrefTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TRocrefTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TRocrefTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TRocrefTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRocrefTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TRocrefTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TRocrefTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TRocrefTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TRocrefTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TRocrefTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TRocrefTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TRocrefTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TRocrefTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TRocrefTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TRocrefTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TRocrefTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TRocrefTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TRocrefTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TRocrefTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TRocrefTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TRocrefTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TRocrefTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TRocrefTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TRocrefTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TRocrefTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TRocrefTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TRocrefTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TRocrefTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TRocrefTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TRocrefTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TRocrefTmp.GetCctVat:byte;
begin
  Result:=oTmpTable.FieldByName('CctVat').AsInteger;
end;

procedure TRocrefTmp.SetCctVat(pValue:byte);
begin
  oTmpTable.FieldByName('CctVat').AsInteger:=pValue;
end;

function TRocrefTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TRocrefTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TRocrefTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TRocrefTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetReqPrq:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TRocrefTmp.SetReqPrq(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetRstPrq:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq').AsFloat;
end;

procedure TRocrefTmp.SetRstPrq(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetRosPrq:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq').AsFloat;
end;

procedure TRocrefTmp.SetRosPrq(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetExdPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TRocrefTmp.SetExdPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TRocrefTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TRocrefTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TRocrefTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TRocrefTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TRocrefTmp.GetReqMpq:double;
begin
  Result:=oTmpTable.FieldByName('ReqMpq').AsFloat;
end;

procedure TRocrefTmp.SetReqMpq(pValue:double);
begin
  oTmpTable.FieldByName('ReqMpq').AsFloat:=pValue;
end;

function TRocrefTmp.GetRstMpq:double;
begin
  Result:=oTmpTable.FieldByName('RstMpq').AsFloat;
end;

procedure TRocrefTmp.SetRstMpq(pValue:double);
begin
  oTmpTable.FieldByName('RstMpq').AsFloat:=pValue;
end;

function TRocrefTmp.GetRosMpq:double;
begin
  Result:=oTmpTable.FieldByName('RosMpq').AsFloat;
end;

procedure TRocrefTmp.SetRosMpq(pValue:double);
begin
  oTmpTable.FieldByName('RosMpq').AsFloat:=pValue;
end;

function TRocrefTmp.GetUndMpq:double;
begin
  Result:=oTmpTable.FieldByName('UndMpq').AsFloat;
end;

procedure TRocrefTmp.SetUndMpq(pValue:double);
begin
  oTmpTable.FieldByName('UndMpq').AsFloat:=pValue;
end;

function TRocrefTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TRocrefTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TRocrefTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TRocrefTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TRocrefTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetFgdAva:double;
begin
  Result:=oTmpTable.FieldByName('FgdAva').AsFloat;
end;

procedure TRocrefTmp.SetFgdAva(pValue:double);
begin
  oTmpTable.FieldByName('FgdAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetPrjAva:double;
begin
  Result:=oTmpTable.FieldByName('PrjAva').AsFloat;
end;

procedure TRocrefTmp.SetPrjAva(pValue:double);
begin
  oTmpTable.FieldByName('PrjAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetSpcAva:double;
begin
  Result:=oTmpTable.FieldByName('SpcAva').AsFloat;
end;

procedure TRocrefTmp.SetSpcAva(pValue:double);
begin
  oTmpTable.FieldByName('SpcAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TRocrefTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TRocrefTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TRocrefTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TRocrefTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TRocrefTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TRocrefTmp.GetSapSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('SapSrc').AsString;
end;

procedure TRocrefTmp.SetSapSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TRocrefTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TRocrefTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TRocrefTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TRocrefTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TRocrefTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TRocrefTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TRocrefTmp.GetExdBva:double;
begin
  Result:=oTmpTable.FieldByName('ExdBva').AsFloat;
end;

procedure TRocrefTmp.SetExdBva(pValue:double);
begin
  oTmpTable.FieldByName('ExdBva').AsFloat:=pValue;
end;

function TRocrefTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TRocrefTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TRocrefTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TRocrefTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TRocrefTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TRocrefTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TRocrefTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TRocrefTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetRatPrv:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TRocrefTmp.SetRatPrv(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TRocrefTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TRocrefTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TRocrefTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TRocrefTmp.GetRatChg:byte;
begin
  Result:=oTmpTable.FieldByName('RatChg').AsInteger;
end;

procedure TRocrefTmp.SetRatChg(pValue:byte);
begin
  oTmpTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TRocrefTmp.GetRatCnt:byte;
begin
  Result:=oTmpTable.FieldByName('RatCnt').AsInteger;
end;

procedure TRocrefTmp.SetRatCnt(pValue:byte);
begin
  oTmpTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TRocrefTmp.GetOsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TRocrefTmp.SetOsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TRocrefTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TRocrefTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetOsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OsdDte').AsDateTime;
end;

procedure TRocrefTmp.SetOsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetOsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('OsdDoq').AsInteger;
end;

procedure TRocrefTmp.SetOsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('OsdDoq').AsInteger:=pValue;
end;

function TRocrefTmp.GetSrdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('SrdAdr').AsInteger;
end;

procedure TRocrefTmp.SetSrdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('SrdAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TRocrefTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TRocrefTmp.GetSrdItm:word;
begin
  Result:=oTmpTable.FieldByName('SrdItm').AsInteger;
end;

procedure TRocrefTmp.SetSrdItm(pValue:word);
begin
  oTmpTable.FieldByName('SrdItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetSrdQnt:byte;
begin
  Result:=oTmpTable.FieldByName('SrdQnt').AsInteger;
end;

procedure TRocrefTmp.SetSrdQnt(pValue:byte);
begin
  oTmpTable.FieldByName('SrdQnt').AsInteger:=pValue;
end;

function TRocrefTmp.GetMcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('McdAdr').AsInteger;
end;

procedure TRocrefTmp.SetMcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('McdAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetMcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TRocrefTmp.SetMcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TRocrefTmp.GetMcdItm:word;
begin
  Result:=oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TRocrefTmp.SetMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetTciAdr:longint;
begin
  Result:=oTmpTable.FieldByName('TciAdr').AsInteger;
end;

procedure TRocrefTmp.SetTciAdr(pValue:longint);
begin
  oTmpTable.FieldByName('TciAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TRocrefTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TRocrefTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TRocrefTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetTcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TRocrefTmp.SetTcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetTcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TRocrefTmp.SetTcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TRocrefTmp.GetIcdAdr:longint;
begin
  Result:=oTmpTable.FieldByName('IcdAdr').AsInteger;
end;

procedure TRocrefTmp.SetIcdAdr(pValue:longint);
begin
  oTmpTable.FieldByName('IcdAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetIcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TRocrefTmp.SetIcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TRocrefTmp.GetIcdItm:word;
begin
  Result:=oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TRocrefTmp.SetIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetIcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IcdDte').AsDateTime;
end;

procedure TRocrefTmp.SetIcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetIcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TRocrefTmp.SetIcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TRocrefTmp.GetCadAdr:longint;
begin
  Result:=oTmpTable.FieldByName('CadAdr').AsInteger;
end;

procedure TRocrefTmp.SetCadAdr(pValue:longint);
begin
  oTmpTable.FieldByName('CadAdr').AsInteger:=pValue;
end;

function TRocrefTmp.GetCadNum:Str13;
begin
  Result:=oTmpTable.FieldByName('CadNum').AsString;
end;

procedure TRocrefTmp.SetCadNum(pValue:Str13);
begin
  oTmpTable.FieldByName('CadNum').AsString:=pValue;
end;

function TRocrefTmp.GetCadItm:word;
begin
  Result:=oTmpTable.FieldByName('CadItm').AsInteger;
end;

procedure TRocrefTmp.SetCadItm(pValue:word);
begin
  oTmpTable.FieldByName('CadItm').AsInteger:=pValue;
end;

function TRocrefTmp.GetCadDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CadDte').AsDateTime;
end;

procedure TRocrefTmp.SetCadDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CadDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetCadDoq:byte;
begin
  Result:=oTmpTable.FieldByName('CadDoq').AsInteger;
end;

procedure TRocrefTmp.SetCadDoq(pValue:byte);
begin
  oTmpTable.FieldByName('CadDoq').AsInteger:=pValue;
end;

function TRocrefTmp.GetRstSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RstSta').AsString;
end;

procedure TRocrefTmp.SetRstSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RstSta').AsString:=pValue;
end;

function TRocrefTmp.GetRosSta:Str1;
begin
  Result:=oTmpTable.FieldByName('RosSta').AsString;
end;

procedure TRocrefTmp.SetRosSta(pValue:Str1);
begin
  oTmpTable.FieldByName('RosSta').AsString:=pValue;
end;

function TRocrefTmp.GetCncSta:Str1;
begin
  Result:=oTmpTable.FieldByName('CncSta').AsString;
end;

procedure TRocrefTmp.SetCncSta(pValue:Str1);
begin
  oTmpTable.FieldByName('CncSta').AsString:=pValue;
end;

function TRocrefTmp.GetUndSta:Str1;
begin
  Result:=oTmpTable.FieldByName('UndSta').AsString;
end;

procedure TRocrefTmp.SetUndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('UndSta').AsString:=pValue;
end;

function TRocrefTmp.GetSndSta:Str1;
begin
  Result:=oTmpTable.FieldByName('SndSta').AsString;
end;

procedure TRocrefTmp.SetSndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('SndSta').AsString:=pValue;
end;

function TRocrefTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TRocrefTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TRocrefTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TRocrefTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TRocrefTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TRocrefTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TRocrefTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TRocrefTmp.GetRemWri:word;
begin
  Result:=oTmpTable.FieldByName('RemWri').AsInteger;
end;

procedure TRocrefTmp.SetRemWri(pValue:word);
begin
  oTmpTable.FieldByName('RemWri').AsInteger:=pValue;
end;

function TRocrefTmp.GetRemStk:word;
begin
  Result:=oTmpTable.FieldByName('RemStk').AsInteger;
end;

procedure TRocrefTmp.SetRemStk(pValue:word);
begin
  oTmpTable.FieldByName('RemStk').AsInteger:=pValue;
end;

function TRocrefTmp.GetComNum:Str14;
begin
  Result:=oTmpTable.FieldByName('ComNum').AsString;
end;

procedure TRocrefTmp.SetComNum(pValue:Str14);
begin
  oTmpTable.FieldByName('ComNum').AsString:=pValue;
end;

function TRocrefTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TRocrefTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TRocrefTmp.GetItmFrm:Str10;
begin
  Result:=oTmpTable.FieldByName('ItmFrm').AsString;
end;

procedure TRocrefTmp.SetItmFrm(pValue:Str10);
begin
  oTmpTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TRocrefTmp.GetTrsDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TrsDte').AsDateTime;
end;

procedure TRocrefTmp.SetTrsDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TrsDte').AsDateTime:=pValue;
end;

function TRocrefTmp.GetDlyDay:longint;
begin
  Result:=oTmpTable.FieldByName('DlyDay').AsInteger;
end;

procedure TRocrefTmp.SetDlyDay(pValue:longint);
begin
  oTmpTable.FieldByName('DlyDay').AsInteger:=pValue;
end;

function TRocrefTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRocrefTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TRocrefTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TRocrefTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TRocrefTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TRocrefTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TRocrefTmp.LocPaDnIn(pParNum:longint;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixPaDnIn);
  Result:=oTmpTable.FindKey([pParNum,pDocNum,pItmNum]);
end;

function TRocrefTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TRocrefTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TRocrefTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TRocrefTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TRocrefTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TRocrefTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TRocrefTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TRocrefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRocrefTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRocrefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRocrefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRocrefTmp.First;
begin
  oTmpTable.First;
end;

procedure TRocrefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRocrefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRocrefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRocrefTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRocrefTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRocrefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRocrefTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRocrefTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRocrefTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRocrefTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TRocrefTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2008001}
