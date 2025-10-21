unit tOSDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixItmNum='ItmNum';
  ixProNam_='ProNam_';
  ixBarCod='BarCod';
  ixOrdCod='OrdCod';

type
  TOsditmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
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
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq (pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq (pValue:double);
    function GetConfQnt:double;          procedure SetConfQnt (pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetOrpSrc:Str2;             procedure SetOrpSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetRatDay:word;             procedure SetRatDay (pValue:word);
    function GetRatTyp:Str1;             procedure SetRatTyp (pValue:Str1);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot (pValue:Str50);
    function GetRatPrv:TDatetime;        procedure SetRatPrv (pValue:TDatetime);
    function GetRatChg:byte;             procedure SetRatChg (pValue:byte);
    function GetTsdNum:Str13;            procedure SetTsdNum (pValue:Str13);
    function GetTsdItm:word;             procedure SetTsdItm (pValue:word);
    function GetTsdDte:TDatetime;        procedure SetTsdDte (pValue:TDatetime);
    function GetTsdDoq:byte;             procedure SetTsdDoq (pValue:byte);
    function GetIsdNum:Str13;            procedure SetIsdNum (pValue:Str13);
    function GetIsdItm:word;             procedure SetIsdItm (pValue:word);
    function GetIsdDte:TDatetime;        procedure SetIsdDte (pValue:TDatetime);
    function GetIsdDoq:byte;             procedure SetIsdDoq (pValue:byte);
    function GetFreRes:byte;             procedure SetFreRes (pValue:byte);
    function GetCrtUsr:str8;             procedure SetCrtUsr (pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetItmFrm:Str10;            procedure SetItmFrm (pValue:Str10);
    function GetDocAdr:longint;          procedure SetDocAdr (pValue:longint);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocBarCod (pBarCod:Str15):boolean;
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
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property ConfQnt:double read GetConfQnt write SetConfQnt;
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
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
    property DocAdr:longint read GetDocAdr write SetDocAdr;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOsditmTmp.Create;
begin
  oTmpTable:=TmpInit ('OSDITM',Self);
end;

destructor TOsditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsditmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsditmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsditmTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOsditmTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOsditmTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOsditmTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOsditmTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TOsditmTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOsditmTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOsditmTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsditmTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsditmTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOsditmTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsditmTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsditmTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsditmTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsditmTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOsditmTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsditmTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsditmTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsditmTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOsditmTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsditmTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsditmTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOsditmTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsditmTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOsditmTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOsditmTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOsditmTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsditmTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOsditmTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOsditmTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOsditmTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOsditmTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOsditmTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOsditmTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsditmTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsditmTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsditmTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsditmTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsditmTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsditmTmp.GetRocPrq:double;
begin
  Result:=oTmpTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOsditmTmp.SetRocPrq(pValue:double);
begin
  oTmpTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOsditmTmp.GetTsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOsditmTmp.SetTsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOsditmTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOsditmTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOsditmTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOsditmTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOsditmTmp.GetConfQnt:double;
begin
  Result:=oTmpTable.FieldByName('ConfQnt').AsFloat;
end;

procedure TOsditmTmp.SetConfQnt(pValue:double);
begin
  oTmpTable.FieldByName('ConfQnt').AsFloat:=pValue;
end;

function TOsditmTmp.GetOrdApc:double;
begin
  Result:=oTmpTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsditmTmp.SetOrdApc(pValue:double);
begin
  oTmpTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsditmTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsditmTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsditmTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsditmTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsditmTmp.GetOrpSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('OrpSrc').AsString;
end;

procedure TOsditmTmp.SetOrpSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('OrpSrc').AsString:=pValue;
end;

function TOsditmTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOsditmTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOsditmTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOsditmTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOsditmTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOsditmTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOsditmTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsditmTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsditmTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOsditmTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOsditmTmp.GetRatDay:word;
begin
  Result:=oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsditmTmp.SetRatDay(pValue:word);
begin
  oTmpTable.FieldByName('RatDay').AsInteger:=pValue;
end;

function TOsditmTmp.GetRatTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('RatTyp').AsString;
end;

procedure TOsditmTmp.SetRatTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('RatTyp').AsString:=pValue;
end;

function TOsditmTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsditmTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOsditmTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TOsditmTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOsditmTmp.GetRatPrv:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOsditmTmp.SetRatPrv(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOsditmTmp.GetRatChg:byte;
begin
  Result:=oTmpTable.FieldByName('RatChg').AsInteger;
end;

procedure TOsditmTmp.SetRatChg(pValue:byte);
begin
  oTmpTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOsditmTmp.GetTsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOsditmTmp.SetTsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOsditmTmp.GetTsdItm:word;
begin
  Result:=oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOsditmTmp.SetTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TOsditmTmp.GetTsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TsdDte').AsDateTime;
end;

procedure TOsditmTmp.SetTsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDte').AsDateTime:=pValue;
end;

function TOsditmTmp.GetTsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOsditmTmp.SetTsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOsditmTmp.GetIsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TOsditmTmp.SetIsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOsditmTmp.GetIsdItm:word;
begin
  Result:=oTmpTable.FieldByName('IsdItm').AsInteger;
end;

procedure TOsditmTmp.SetIsdItm(pValue:word);
begin
  oTmpTable.FieldByName('IsdItm').AsInteger:=pValue;
end;

function TOsditmTmp.GetIsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IsdDte').AsDateTime;
end;

procedure TOsditmTmp.SetIsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IsdDte').AsDateTime:=pValue;
end;

function TOsditmTmp.GetIsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOsditmTmp.SetIsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOsditmTmp.GetFreRes:byte;
begin
  Result:=oTmpTable.FieldByName('FreRes').AsInteger;
end;

procedure TOsditmTmp.SetFreRes(pValue:byte);
begin
  oTmpTable.FieldByName('FreRes').AsInteger:=pValue;
end;

function TOsditmTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOsditmTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOsditmTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOsditmTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOsditmTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOsditmTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOsditmTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOsditmTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOsditmTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOsditmTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOsditmTmp.GetItmFrm:Str10;
begin
  Result:=oTmpTable.FieldByName('ItmFrm').AsString;
end;

procedure TOsditmTmp.SetItmFrm(pValue:Str10);
begin
  oTmpTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TOsditmTmp.GetDocAdr:longint;
begin
  Result:=oTmpTable.FieldByName('DocAdr').AsInteger;
end;

procedure TOsditmTmp.SetDocAdr(pValue:longint);
begin
  oTmpTable.FieldByName('DocAdr').AsInteger:=pValue;
end;

function TOsditmTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOsditmTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsditmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsditmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsditmTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOsditmTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TOsditmTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TOsditmTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TOsditmTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TOsditmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsditmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsditmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsditmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsditmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
