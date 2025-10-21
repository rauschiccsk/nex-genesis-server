unit dOCIHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixModNum='ModNum';
  ixDocNum='DocNum';
  ixItmAdr='ItmAdr';

type
  TOcihisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetModNum:longint;          procedure SetModNum(pValue:longint);
    function GetModTyp:Str1;             procedure SetModTyp(pValue:Str1);
    function GetModUsr:str8;             procedure SetModUsr(pValue:str8);
    function GetModUsn:Str30;            procedure SetModUsn(pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq(pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq(pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq(pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq(pValue:double);
    function GetMinApc:double;           procedure SetMinApc(pValue:double);
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
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetRemWri:word;             procedure SetRemWri(pValue:word);
    function GetRemStk:word;             procedure SetRemStk(pValue:word);
    function GetComNum:Str14;            procedure SetComNum(pValue:Str14);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetItmFrm:Str10;            procedure SetItmFrm(pValue:Str10);
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
    function LocModNum(pModNum:longint):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocItmAdr(pItmAdr:longint):boolean;
    function NearModNum(pModNum:longint):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearItmAdr(pItmAdr:longint):boolean;

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
    property ModNum:longint read GetModNum write SetModNum;
    property ModTyp:Str1 read GetModTyp write SetModTyp;
    property ModUsr:str8 read GetModUsr write SetModUsr;
    property ModUsn:Str30 read GetModUsn write SetModUsn;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
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
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property ReqPrq:double read GetReqPrq write SetReqPrq;
    property RstPrq:double read GetRstPrq write SetRstPrq;
    property RosPrq:double read GetRosPrq write SetRosPrq;
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
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property RemWri:word read GetRemWri write SetRemWri;
    property RemStk:word read GetRemStk write SetRemStk;
    property ComNum:Str14 read GetComNum write SetComNum;
    property Notice:Str50 read GetNotice write SetNotice;
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
  end;

implementation

constructor TOcihisDat.Create;
begin
  oTable:=DatInit('OCIHIS',gPath.StkPath,Self);
end;

constructor TOcihisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCIHIS',pPath,Self);
end;

destructor TOcihisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcihisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcihisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcihisDat.GetModNum:longint;
begin
  Result:=oTable.FieldByName('ModNum').AsInteger;
end;

procedure TOcihisDat.SetModNum(pValue:longint);
begin
  oTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TOcihisDat.GetModTyp:Str1;
begin
  Result:=oTable.FieldByName('ModTyp').AsString;
end;

procedure TOcihisDat.SetModTyp(pValue:Str1);
begin
  oTable.FieldByName('ModTyp').AsString:=pValue;
end;

function TOcihisDat.GetModUsr:str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TOcihisDat.SetModUsr(pValue:str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TOcihisDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TOcihisDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TOcihisDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TOcihisDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TOcihisDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TOcihisDat.GetItmAdr:longint;
begin
  Result:=oTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOcihisDat.SetItmAdr(pValue:longint);
begin
  oTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOcihisDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TOcihisDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOcihisDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TOcihisDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOcihisDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOcihisDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOcihisDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOcihisDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOcihisDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TOcihisDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOcihisDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcihisDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcihisDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcihisDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcihisDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOcihisDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcihisDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOcihisDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcihisDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOcihisDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOcihisDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOcihisDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOcihisDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOcihisDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOcihisDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TOcihisDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOcihisDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TOcihisDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOcihisDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TOcihisDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOcihisDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TOcihisDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOcihisDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TOcihisDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOcihisDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOcihisDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOcihisDat.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TOcihisDat.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOcihisDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TOcihisDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOcihisDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOcihisDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOcihisDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOcihisDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetReqPrq:double;
begin
  Result:=oTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOcihisDat.SetReqPrq(pValue:double);
begin
  oTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetRstPrq:double;
begin
  Result:=oTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOcihisDat.SetRstPrq(pValue:double);
begin
  oTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetRosPrq:double;
begin
  Result:=oTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOcihisDat.SetRosPrq(pValue:double);
begin
  oTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetExdPrq:double;
begin
  Result:=oTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOcihisDat.SetExdPrq(pValue:double);
begin
  oTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOcihisDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetCncPrq:double;
begin
  Result:=oTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOcihisDat.SetCncPrq(pValue:double);
begin
  oTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOcihisDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetIcdPrq:double;
begin
  Result:=oTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOcihisDat.SetIcdPrq(pValue:double);
begin
  oTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOcihisDat.GetMinApc:double;
begin
  Result:=oTable.FieldByName('MinApc').AsFloat;
end;

procedure TOcihisDat.SetMinApc(pValue:double);
begin
  oTable.FieldByName('MinApc').AsFloat:=pValue;
end;

function TOcihisDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TOcihisDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOcihisDat.GetPlsAva:double;
begin
  Result:=oTable.FieldByName('PlsAva').AsFloat;
end;

procedure TOcihisDat.SetPlsAva(pValue:double);
begin
  oTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TOcihisDat.GetFgdAva:double;
begin
  Result:=oTable.FieldByName('FgdAva').AsFloat;
end;

procedure TOcihisDat.SetFgdAva(pValue:double);
begin
  oTable.FieldByName('FgdAva').AsFloat:=pValue;
end;

function TOcihisDat.GetPrjAva:double;
begin
  Result:=oTable.FieldByName('PrjAva').AsFloat;
end;

procedure TOcihisDat.SetPrjAva(pValue:double);
begin
  oTable.FieldByName('PrjAva').AsFloat:=pValue;
end;

function TOcihisDat.GetSpcAva:double;
begin
  Result:=oTable.FieldByName('SpcAva').AsFloat;
end;

procedure TOcihisDat.SetSpcAva(pValue:double);
begin
  oTable.FieldByName('SpcAva').AsFloat:=pValue;
end;

function TOcihisDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOcihisDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOcihisDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TOcihisDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOcihisDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TOcihisDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOcihisDat.GetSapSrc:Str2;
begin
  Result:=oTable.FieldByName('SapSrc').AsString;
end;

procedure TOcihisDat.SetSapSrc(pValue:Str2);
begin
  oTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TOcihisDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOcihisDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOcihisDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TOcihisDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOcihisDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOcihisDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOcihisDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOcihisDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOcihisDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOcihisDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOcihisDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcihisDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetRatPrv:TDatetime;
begin
  Result:=oTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOcihisDat.SetRatPrv(pValue:TDatetime);
begin
  oTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOcihisDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcihisDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetRatNot:Str50;
begin
  Result:=oTable.FieldByName('RatNot').AsString;
end;

procedure TOcihisDat.SetRatNot(pValue:Str50);
begin
  oTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOcihisDat.GetRatChg:byte;
begin
  Result:=oTable.FieldByName('RatChg').AsInteger;
end;

procedure TOcihisDat.SetRatChg(pValue:byte);
begin
  oTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOcihisDat.GetRatCnt:byte;
begin
  Result:=oTable.FieldByName('RatCnt').AsInteger;
end;

procedure TOcihisDat.SetRatCnt(pValue:byte);
begin
  oTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TOcihisDat.GetOsdNum:Str13;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TOcihisDat.SetOsdNum(pValue:Str13);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcihisDat.GetOsdItm:word;
begin
  Result:=oTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcihisDat.SetOsdItm(pValue:word);
begin
  oTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOcihisDat.GetOsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('OsdDte').AsDateTime;
end;

procedure TOcihisDat.SetOsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('OsdDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetOsdDoq:byte;
begin
  Result:=oTable.FieldByName('OsdDoq').AsInteger;
end;

procedure TOcihisDat.SetOsdDoq(pValue:byte);
begin
  oTable.FieldByName('OsdDoq').AsInteger:=pValue;
end;

function TOcihisDat.GetSrdNum:Str13;
begin
  Result:=oTable.FieldByName('SrdNum').AsString;
end;

procedure TOcihisDat.SetSrdNum(pValue:Str13);
begin
  oTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOcihisDat.GetSrdItm:word;
begin
  Result:=oTable.FieldByName('SrdItm').AsInteger;
end;

procedure TOcihisDat.SetSrdItm(pValue:word);
begin
  oTable.FieldByName('SrdItm').AsInteger:=pValue;
end;

function TOcihisDat.GetSrdQnt:byte;
begin
  Result:=oTable.FieldByName('SrdQnt').AsInteger;
end;

procedure TOcihisDat.SetSrdQnt(pValue:byte);
begin
  oTable.FieldByName('SrdQnt').AsInteger:=pValue;
end;

function TOcihisDat.GetMcdNum:Str13;
begin
  Result:=oTable.FieldByName('McdNum').AsString;
end;

procedure TOcihisDat.SetMcdNum(pValue:Str13);
begin
  oTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOcihisDat.GetMcdItm:word;
begin
  Result:=oTable.FieldByName('McdItm').AsInteger;
end;

procedure TOcihisDat.SetMcdItm(pValue:word);
begin
  oTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TOcihisDat.GetTcdNum:Str13;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TOcihisDat.SetTcdNum(pValue:Str13);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOcihisDat.GetTcdItm:word;
begin
  Result:=oTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOcihisDat.SetTcdItm(pValue:word);
begin
  oTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TOcihisDat.GetTcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TOcihisDat.SetTcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetTcdDoq:byte;
begin
  Result:=oTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOcihisDat.SetTcdDoq(pValue:byte);
begin
  oTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOcihisDat.GetIcdNum:Str13;
begin
  Result:=oTable.FieldByName('IcdNum').AsString;
end;

procedure TOcihisDat.SetIcdNum(pValue:Str13);
begin
  oTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOcihisDat.GetIcdItm:word;
begin
  Result:=oTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOcihisDat.SetIcdItm(pValue:word);
begin
  oTable.FieldByName('IcdItm').AsInteger:=pValue;
end;

function TOcihisDat.GetIcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('IcdDte').AsDateTime;
end;

procedure TOcihisDat.SetIcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('IcdDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetIcdDoq:byte;
begin
  Result:=oTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOcihisDat.SetIcdDoq(pValue:byte);
begin
  oTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOcihisDat.GetCadNum:Str13;
begin
  Result:=oTable.FieldByName('CadNum').AsString;
end;

procedure TOcihisDat.SetCadNum(pValue:Str13);
begin
  oTable.FieldByName('CadNum').AsString:=pValue;
end;

function TOcihisDat.GetCadItm:word;
begin
  Result:=oTable.FieldByName('CadItm').AsInteger;
end;

procedure TOcihisDat.SetCadItm(pValue:word);
begin
  oTable.FieldByName('CadItm').AsInteger:=pValue;
end;

function TOcihisDat.GetCadDte:TDatetime;
begin
  Result:=oTable.FieldByName('CadDte').AsDateTime;
end;

procedure TOcihisDat.SetCadDte(pValue:TDatetime);
begin
  oTable.FieldByName('CadDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetCadDoq:byte;
begin
  Result:=oTable.FieldByName('CadDoq').AsInteger;
end;

procedure TOcihisDat.SetCadDoq(pValue:byte);
begin
  oTable.FieldByName('CadDoq').AsInteger:=pValue;
end;

function TOcihisDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcihisDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcihisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcihisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcihisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcihisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOcihisDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TOcihisDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOcihisDat.GetRemWri:word;
begin
  Result:=oTable.FieldByName('RemWri').AsInteger;
end;

procedure TOcihisDat.SetRemWri(pValue:word);
begin
  oTable.FieldByName('RemWri').AsInteger:=pValue;
end;

function TOcihisDat.GetRemStk:word;
begin
  Result:=oTable.FieldByName('RemStk').AsInteger;
end;

procedure TOcihisDat.SetRemStk(pValue:word);
begin
  oTable.FieldByName('RemStk').AsInteger:=pValue;
end;

function TOcihisDat.GetComNum:Str14;
begin
  Result:=oTable.FieldByName('ComNum').AsString;
end;

procedure TOcihisDat.SetComNum(pValue:Str14);
begin
  oTable.FieldByName('ComNum').AsString:=pValue;
end;

function TOcihisDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOcihisDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TOcihisDat.GetItmFrm:Str10;
begin
  Result:=oTable.FieldByName('ItmFrm').AsString;
end;

procedure TOcihisDat.SetItmFrm(pValue:Str10);
begin
  oTable.FieldByName('ItmFrm').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcihisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcihisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcihisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcihisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcihisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcihisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcihisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcihisDat.LocModNum(pModNum:longint):boolean;
begin
  SetIndex(ixModNum);
  Result:=oTable.FindKey([pModNum]);
end;

function TOcihisDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOcihisDat.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TOcihisDat.NearModNum(pModNum:longint):boolean;
begin
  SetIndex(ixModNum);
  Result:=oTable.FindNearest([pModNum]);
end;

function TOcihisDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOcihisDat.NearItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

procedure TOcihisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcihisDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOcihisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcihisDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcihisDat.Next;
begin
  oTable.Next;
end;

procedure TOcihisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcihisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcihisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcihisDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcihisDat.Post;
begin
  oTable.Post;
end;

procedure TOcihisDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcihisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcihisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcihisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcihisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcihisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcihisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
