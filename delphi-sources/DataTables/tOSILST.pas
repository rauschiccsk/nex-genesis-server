unit tOSILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixDnIn='DnIn';
  ixPaDnIn='PaDnIn';
  ixItmNum='ItmNum';
  ixSnPn='SnPn';
  ixProNam_='ProNam_';
  ixParNum='ParNum';
  ixDocDte='DocDte';

type
  TOsilstTmp=class(TComponent)
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
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq (pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq (pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq (pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetOrpSrc:Str2;             procedure SetOrpSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
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
    function GetSndDte:TDatetime;        procedure SetSndDte (pValue:TDatetime);
    function GetDlyDay:longint;          procedure SetDlyDay (pValue:longint);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function LocPaDnIn (pParNum:longint;pDocNum:Str12;pItmNum:word):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocSnPn (pStkNum:word;pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;

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
    property Cctvat:byte read GetCctvat write SetCctvat;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property OrdApc:double read GetOrdApc write SetOrdApc;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property OrpSrc:Str2 read GetOrpSrc write SetOrpSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
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
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property DlyDay:longint read GetDlyDay write SetDlyDay;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOsilstTmp.Create;
begin
  oTmpTable:=TmpInit ('OSILST',Self);
end;

destructor TOsilstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsilstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsilstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsilstTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOsilstTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOsilstTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOsilstTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOsilstTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TOsilstTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOsilstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOsilstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsilstTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsilstTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOsilstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsilstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsilstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsilstTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsilstTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOsilstTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsilstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsilstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsilstTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOsilstTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsilstTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsilstTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOsilstTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsilstTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOsilstTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOsilstTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOsilstTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsilstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOsilstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOsilstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOsilstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOsilstTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOsilstTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOsilstTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsilstTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsilstTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TOsilstTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TOsilstTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsilstTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsilstTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsilstTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetRocPrq:double;
begin
  Result:=oTmpTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOsilstTmp.SetRocPrq(pValue:double);
begin
  oTmpTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetTsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOsilstTmp.SetTsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOsilstTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOsilstTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TOsilstTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOsilstTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOsilstTmp.GetOrdApc:double;
begin
  Result:=oTmpTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsilstTmp.SetOrdApc(pValue:double);
begin
  oTmpTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsilstTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsilstTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsilstTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsilstTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsilstTmp.GetOrpSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('OrpSrc').AsString;
end;

procedure TOsilstTmp.SetOrpSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('OrpSrc').AsString:=pValue;
end;

function TOsilstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOsilstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOsilstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOsilstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOsilstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOsilstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOsilstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsilstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsilstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOsilstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsilstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOsilstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetRatDay:word;
begin
  Result:=oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsilstTmp.SetRatDay(pValue:word);
begin
  oTmpTable.FieldByName('RatDay').AsInteger:=pValue;
end;

function TOsilstTmp.GetRatTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('RatTyp').AsString;
end;

procedure TOsilstTmp.SetRatTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('RatTyp').AsString:=pValue;
end;

function TOsilstTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsilstTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetRatNot:Str50;
begin
  Result:=oTmpTable.FieldByName('RatNot').AsString;
end;

procedure TOsilstTmp.SetRatNot(pValue:Str50);
begin
  oTmpTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOsilstTmp.GetRatPrv:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOsilstTmp.SetRatPrv(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOsilstTmp.GetRatChg:byte;
begin
  Result:=oTmpTable.FieldByName('RatChg').AsInteger;
end;

procedure TOsilstTmp.SetRatChg(pValue:byte);
begin
  oTmpTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOsilstTmp.GetTsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOsilstTmp.SetTsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOsilstTmp.GetTsdItm:word;
begin
  Result:=oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOsilstTmp.SetTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TOsilstTmp.GetTsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TsdDte').AsDateTime;
end;

procedure TOsilstTmp.SetTsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetTsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOsilstTmp.SetTsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOsilstTmp.GetIsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TOsilstTmp.SetIsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOsilstTmp.GetIsdItm:word;
begin
  Result:=oTmpTable.FieldByName('IsdItm').AsInteger;
end;

procedure TOsilstTmp.SetIsdItm(pValue:word);
begin
  oTmpTable.FieldByName('IsdItm').AsInteger:=pValue;
end;

function TOsilstTmp.GetIsdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IsdDte').AsDateTime;
end;

procedure TOsilstTmp.SetIsdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IsdDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetIsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOsilstTmp.SetIsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOsilstTmp.GetFreRes:byte;
begin
  Result:=oTmpTable.FieldByName('FreRes').AsInteger;
end;

procedure TOsilstTmp.SetFreRes(pValue:byte);
begin
  oTmpTable.FieldByName('FreRes').AsInteger:=pValue;
end;

function TOsilstTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOsilstTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOsilstTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOsilstTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOsilstTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOsilstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOsilstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOsilstTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOsilstTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOsilstTmp.GetItmFrm:Str10;
begin
  Result:=oTmpTable.FieldByName('ItmFrm').AsString;
end;

procedure TOsilstTmp.SetItmFrm(pValue:Str10);
begin
  oTmpTable.FieldByName('ItmFrm').AsString:=pValue;
end;

function TOsilstTmp.GetSndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOsilstTmp.SetSndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOsilstTmp.GetDlyDay:longint;
begin
  Result:=oTmpTable.FieldByName('DlyDay').AsInteger;
end;

procedure TOsilstTmp.SetDlyDay(pValue:longint);
begin
  oTmpTable.FieldByName('DlyDay').AsInteger:=pValue;
end;

function TOsilstTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOsilstTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsilstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsilstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsilstTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOsilstTmp.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOsilstTmp.LocPaDnIn(pParNum:longint;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixPaDnIn);
  Result:=oTmpTable.FindKey([pParNum,pDocNum,pItmNum]);
end;

function TOsilstTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TOsilstTmp.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex (ixSnPn);
  Result:=oTmpTable.FindKey([pStkNum,pProNum]);
end;

function TOsilstTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TOsilstTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TOsilstTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

procedure TOsilstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsilstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsilstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsilstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsilstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsilstTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsilstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsilstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsilstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsilstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsilstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsilstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsilstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsilstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsilstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsilstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsilstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
