unit dOSHLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixBokNum='BokNum';
  ixDySn='DySn';
  ixDyBnSn='DyBnSn';
  ixExtNum='ExtNum';
  ixDocDte='DocDte';
  ixReqDte='ReqDte';
  ixParNum='ParNum';
  ixRegIno='RegIno';
  ixSnWn='SnWn';
  ixParNam='ParNam';
  ixEndBva='EndBva';
  ixDepBva='DepBva';
  ixPrjNum='PrjNum';
  ixPrjCod='PrjCod';
  ixDstRat='DstRat';
  ixPyPs='PyPs';
  ixPsdNum='PsdNum';
  ixPseNum='PseNum';
  ixPsvNum='PsvNum';
  ixDsdNum='DsdNum';
  ixDseNum='DseNum';
  ixDsvNum='DsvNum';
  ixDocSource='DocSource';
  ixDocStatus='DocStatus';

type
  TOshlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetExtNum:Str12;            procedure SetExtNum(pValue:Str12);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetPrjCod:Str30;            procedure SetPrjCod(pValue:Str30);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte(pValue:TDatetime);
    function GetReqTyp:Str1;             procedure SetReqTyp(pValue:Str1);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetVatDoc:byte;             procedure SetVatDoc(pValue:byte);
    function GetCusCrd:Str20;            procedure SetCusCrd(pValue:Str20);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno(pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin(pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin(pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr(pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta(pValue:Str2);
    function GetRegCty:Str3;             procedure SetRegCty(pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn(pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip(pValue:Str15);
    function GetCtpNum:longint;          procedure SetCtpNum(pValue:longint);
    function GetCtpNam:Str30;            procedure SetCtpNam(pValue:Str30);
    function GetCtpTel:Str20;            procedure SetCtpTel(pValue:Str20);
    function GetCtpFax:Str20;            procedure SetCtpFax(pValue:Str20);
    function GetCtpEml:Str30;            procedure SetCtpEml(pValue:Str30);
    function GetSpaNum:longint;          procedure SetSpaNum(pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum(pValue:word);
    function GetWpaNam:Str60;            procedure SetWpaNam(pValue:Str60);
    function GetWpaAdr:Str30;            procedure SetWpaAdr(pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta(pValue:Str2);
    function GetWpaCty:Str3;             procedure SetWpaCty(pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn(pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip(pValue:Str15);
    function GetPayCod:Str1;             procedure SetPayCod(pValue:Str1);
    function GetPayNam:Str20;            procedure SetPayNam(pValue:Str20);
    function GetTrsCod:Str5;             procedure SetTrsCod(pValue:Str5);
    function GetTrsNam:Str20;            procedure SetTrsNam(pValue:Str20);
    function GetComDlv:byte;             procedure SetComDlv(pValue:byte);
    function GetRcvTyp:Str1;             procedure SetRcvTyp(pValue:Str1);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetMngUsr:Str8;             procedure SetMngUsr(pValue:Str8);
    function GetMngUsn:Str30;            procedure SetMngUsn(pValue:Str30);
    function GetMngDte:TDatetime;        procedure SetMngDte(pValue:TDatetime);
    function GetEdiUsr:Str8;             procedure SetEdiUsr(pValue:Str8);
    function GetEdiDte:TDatetime;        procedure SetEdiDte(pValue:TDatetime);
    function GetEdiTim:TDatetime;        procedure SetEdiTim(pValue:TDatetime);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetProVol:double;           procedure SetProVol(pValue:double);
    function GetProWgh:double;           procedure SetProWgh(pValue:double);
    function GetProAva:double;           procedure SetProAva(pValue:double);
    function GetSrvAva:double;           procedure SetSrvAva(pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva(pValue:double);
    function GetVatVal:double;           procedure SetVatVal(pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva(pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva(pValue:double);
    function GetEndBva:double;           procedure SetEndBva(pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam(pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetDepPrc:double;           procedure SetDepPrc(pValue:double);
    function GetDepBva:double;           procedure SetDepBva(pValue:double);
    function GetDepDte:TDatetime;        procedure SetDepDte(pValue:TDatetime);
    function GetDepPay:Str1;             procedure SetDepPay(pValue:Str1);
    function GetValClc:Str15;            procedure SetValClc(pValue:Str15);
    function GetOrdPrq:double;           procedure SetOrdPrq(pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq(pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq(pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq(pValue:double);
    function GetDstRat:Str1;             procedure SetDstRat(pValue:Str1);
    function GetDstLck:Str1;             procedure SetDstLck(pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls(pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq(pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum(pValue:Str13);
    function GetSrdDoq:byte;             procedure SetSrdDoq(pValue:byte);
    function GetTsdNum:Str13;            procedure SetTsdNum(pValue:Str13);
    function GetTsdDoq:byte;             procedure SetTsdDoq(pValue:byte);
    function GetTsdPrc:byte;             procedure SetTsdPrc(pValue:byte);
    function GetIsdNum:Str13;            procedure SetIsdNum(pValue:Str13);
    function GetIsdDoq:byte;             procedure SetIsdDoq(pValue:byte);
    function GetIsdPrc:byte;             procedure SetIsdPrc(pValue:byte);
    function GetPrnCnt:byte;             procedure SetPrnCnt(pValue:byte);
    function GetPrnUsr:word;             procedure SetPrnUsr(pValue:word);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes(pValue:Str50);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm(pValue:Str6);
    function GetPsdYer:Str2;             procedure SetPsdYer(pValue:Str2);
    function GetPsdSer:longint;          procedure SetPsdSer(pValue:longint);
    function GetPsdNum:Str12;            procedure SetPsdNum(pValue:Str12);
    function GetPseNum:Str12;            procedure SetPseNum(pValue:Str12);
    function GetPsvNum:Str10;            procedure SetPsvNum(pValue:Str10);
    function GetPsdDte:TDatetime;        procedure SetPsdDte(pValue:TDatetime);
    function GetPseDte:TDatetime;        procedure SetPseDte(pValue:TDatetime);
    function GetPsdVal:double;           procedure SetPsdVal(pValue:double);
    function GetPspVal:double;           procedure SetPspVal(pValue:double);
    function GetPspCur:double;           procedure SetPspCur(pValue:double);
    function GetPsdIba:Str30;            procedure SetPsdIba(pValue:Str30);
    function GetPsdUsr:Str10;            procedure SetPsdUsr(pValue:Str10);
    function GetPsdUsn:Str30;            procedure SetPsdUsn(pValue:Str30);
    function GetDsdNum:Str12;            procedure SetDsdNum(pValue:Str12);
    function GetDseNum:Str12;            procedure SetDseNum(pValue:Str12);
    function GetDsvNum:Str10;            procedure SetDsvNum(pValue:Str10);
    function GetDsdDte:TDatetime;        procedure SetDsdDte(pValue:TDatetime);
    function GetDocSource:Str10;         procedure SetDocSource(pValue:Str10);
    function GetDocStatus:Str10;         procedure SetDocStatus(pValue:Str10);
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
    function LocBokNum(pBokNum:Str3):boolean;
    function LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function LocExtNum(pExtNum:Str12):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocReqDte(pReqDte:TDatetime):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocRegIno(pRegIno:Str15):boolean;
    function LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocEndBva(pEndBva:double):boolean;
    function LocDepBva(pDepBva:double):boolean;
    function LocPrjNum(pPrjNum:Str12):boolean;
    function LocPrjCod(pPrjCod:Str30):boolean;
    function LocDstRat(pDstRat:Str1):boolean;
    function LocPyPs(pPsdYer:Str2;pPsdSer:longint):boolean;
    function LocPsdNum(pPsdNum:Str12):boolean;
    function LocPseNum(pPseNum:Str12):boolean;
    function LocPsvNum(pPsvNum:Str10):boolean;
    function LocDsdNum(pDsdNum:Str12):boolean;
    function LocDseNum(pDseNum:Str12):boolean;
    function LocDsvNum(pDsvNum:Str10):boolean;
    function LocDocSource(pDocSource:Str10):boolean;
    function LocDocStatus(pDocStatus:Str10):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearReqDte(pReqDte:TDatetime):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearRegIno(pRegIno:Str15):boolean;
    function NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearEndBva(pEndBva:double):boolean;
    function NearDepBva(pDepBva:double):boolean;
    function NearPrjNum(pPrjNum:Str12):boolean;
    function NearPrjCod(pPrjCod:Str30):boolean;
    function NearDstRat(pDstRat:Str1):boolean;
    function NearPyPs(pPsdYer:Str2;pPsdSer:longint):boolean;
    function NearPsdNum(pPsdNum:Str12):boolean;
    function NearPseNum(pPseNum:Str12):boolean;
    function NearPsvNum(pPsvNum:Str10):boolean;
    function NearDsdNum(pDsdNum:Str12):boolean;
    function NearDseNum(pDseNum:Str12):boolean;
    function NearDsvNum(pDsvNum:Str10):boolean;
    function NearDocSource(pDocSource:Str10):boolean;
    function NearDocStatus(pDocStatus:Str10):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:longint read GetSerNum write SetSerNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property PrjCod:Str30 read GetPrjCod write SetPrjCod;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property ReqTyp:Str1 read GetReqTyp write SetReqTyp;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property VatDoc:byte read GetVatDoc write SetVatDoc;
    property CusCrd:Str20 read GetCusCrd write SetCusCrd;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property CtpNum:longint read GetCtpNum write SetCtpNum;
    property CtpNam:Str30 read GetCtpNam write SetCtpNam;
    property CtpTel:Str20 read GetCtpTel write SetCtpTel;
    property CtpFax:Str20 read GetCtpFax write SetCtpFax;
    property CtpEml:Str30 read GetCtpEml write SetCtpEml;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property WpaNum:word read GetWpaNum write SetWpaNum;
    property WpaNam:Str60 read GetWpaNam write SetWpaNam;
    property WpaAdr:Str30 read GetWpaAdr write SetWpaAdr;
    property WpaSta:Str2 read GetWpaSta write SetWpaSta;
    property WpaCty:Str3 read GetWpaCty write SetWpaCty;
    property WpaCtn:Str30 read GetWpaCtn write SetWpaCtn;
    property WpaZip:Str15 read GetWpaZip write SetWpaZip;
    property PayCod:Str1 read GetPayCod write SetPayCod;
    property PayNam:Str20 read GetPayNam write SetPayNam;
    property TrsCod:Str5 read GetTrsCod write SetTrsCod;
    property TrsNam:Str20 read GetTrsNam write SetTrsNam;
    property ComDlv:byte read GetComDlv write SetComDlv;
    property RcvTyp:Str1 read GetRcvTyp write SetRcvTyp;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property MngUsr:Str8 read GetMngUsr write SetMngUsr;
    property MngUsn:Str30 read GetMngUsn write SetMngUsn;
    property MngDte:TDatetime read GetMngDte write SetMngDte;
    property EdiUsr:Str8 read GetEdiUsr write SetEdiUsr;
    property EdiDte:TDatetime read GetEdiDte write SetEdiDte;
    property EdiTim:TDatetime read GetEdiTim write SetEdiTim;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property ProAva:double read GetProAva write SetProAva;
    property SrvAva:double read GetSrvAva write SetSrvAva;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property VatVal:double read GetVatVal write SetVatVal;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DvzCrs:double read GetDvzCrs write SetDvzCrs;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property DepPrc:double read GetDepPrc write SetDepPrc;
    property DepBva:double read GetDepBva write SetDepBva;
    property DepDte:TDatetime read GetDepDte write SetDepDte;
    property DepPay:Str1 read GetDepPay write SetDepPay;
    property ValClc:Str15 read GetValClc write SetValClc;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property DstRat:Str1 read GetDstRat write SetDstRat;
    property DstLck:Str1 read GetDstLck write SetDstLck;
    property DstCls:Str1 read GetDstCls write SetDstCls;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property AtcDoq:byte read GetAtcDoq write SetAtcDoq;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property SrdDoq:byte read GetSrdDoq write SetSrdDoq;
    property TsdNum:Str13 read GetTsdNum write SetTsdNum;
    property TsdDoq:byte read GetTsdDoq write SetTsdDoq;
    property TsdPrc:byte read GetTsdPrc write SetTsdPrc;
    property IsdNum:Str13 read GetIsdNum write SetIsdNum;
    property IsdDoq:byte read GetIsdDoq write SetIsdDoq;
    property IsdPrc:byte read GetIsdPrc write SetIsdPrc;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property PrnUsr:word read GetPrnUsr write SetPrnUsr;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property DocDes:Str50 read GetDocDes write SetDocDes;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocFrm:Str6 read GetDocFrm write SetDocFrm;
    property PsdYer:Str2 read GetPsdYer write SetPsdYer;
    property PsdSer:longint read GetPsdSer write SetPsdSer;
    property PsdNum:Str12 read GetPsdNum write SetPsdNum;
    property PseNum:Str12 read GetPseNum write SetPseNum;
    property PsvNum:Str10 read GetPsvNum write SetPsvNum;
    property PsdDte:TDatetime read GetPsdDte write SetPsdDte;
    property PseDte:TDatetime read GetPseDte write SetPseDte;
    property PsdVal:double read GetPsdVal write SetPsdVal;
    property PspVal:double read GetPspVal write SetPspVal;
    property PspCur:double read GetPspCur write SetPspCur;
    property PsdIba:Str30 read GetPsdIba write SetPsdIba;
    property PsdUsr:Str10 read GetPsdUsr write SetPsdUsr;
    property PsdUsn:Str30 read GetPsdUsn write SetPsdUsn;
    property DsdNum:Str12 read GetDsdNum write SetDsdNum;
    property DseNum:Str12 read GetDseNum write SetDseNum;
    property DsvNum:Str10 read GetDsvNum write SetDsvNum;
    property DsdDte:TDatetime read GetDsdDte write SetDsdDte;
    property DocSource:Str10 read GetDocSource write SetDocSource;
    property DocStatus:Str10 read GetDocStatus write SetDocStatus;
  end;

implementation

constructor TOshlstDat.Create;
begin
  oTable:=DatInit('OSHLST',gPath.StkPath,Self);
end;

constructor TOshlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSHLST',pPath,Self);
end;

destructor TOshlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOshlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOshlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOshlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TOshlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOshlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TOshlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOshlstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TOshlstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOshlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOshlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOshlstDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TOshlstDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TOshlstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TOshlstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOshlstDat.GetPrjCod:Str30;
begin
  Result:=oTable.FieldByName('PrjCod').AsString;
end;

procedure TOshlstDat.SetPrjCod(pValue:Str30);
begin
  oTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TOshlstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOshlstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOshlstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOshlstDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetSndDte:TDatetime;
begin
  Result:=oTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOshlstDat.SetSndDte(pValue:TDatetime);
begin
  oTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetReqTyp:Str1;
begin
  Result:=oTable.FieldByName('ReqTyp').AsString;
end;

procedure TOshlstDat.SetReqTyp(pValue:Str1);
begin
  oTable.FieldByName('ReqTyp').AsString:=pValue;
end;

function TOshlstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TOshlstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOshlstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOshlstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOshlstDat.GetVatDoc:byte;
begin
  Result:=oTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOshlstDat.SetVatDoc(pValue:byte);
begin
  oTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TOshlstDat.GetCusCrd:Str20;
begin
  Result:=oTable.FieldByName('CusCrd').AsString;
end;

procedure TOshlstDat.SetCusCrd(pValue:Str20);
begin
  oTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TOshlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOshlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOshlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOshlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOshlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TOshlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOshlstDat.GetRegIno:Str15;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TOshlstDat.SetRegIno(pValue:Str15);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TOshlstDat.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TOshlstDat.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TOshlstDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TOshlstDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TOshlstDat.GetRegAdr:Str30;
begin
  Result:=oTable.FieldByName('RegAdr').AsString;
end;

procedure TOshlstDat.SetRegAdr(pValue:Str30);
begin
  oTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TOshlstDat.GetRegSta:Str2;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TOshlstDat.SetRegSta(pValue:Str2);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TOshlstDat.GetRegCty:Str3;
begin
  Result:=oTable.FieldByName('RegCty').AsString;
end;

procedure TOshlstDat.SetRegCty(pValue:Str3);
begin
  oTable.FieldByName('RegCty').AsString:=pValue;
end;

function TOshlstDat.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TOshlstDat.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TOshlstDat.GetRegZip:Str15;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TOshlstDat.SetRegZip(pValue:Str15);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TOshlstDat.GetCtpNum:longint;
begin
  Result:=oTable.FieldByName('CtpNum').AsInteger;
end;

procedure TOshlstDat.SetCtpNum(pValue:longint);
begin
  oTable.FieldByName('CtpNum').AsInteger:=pValue;
end;

function TOshlstDat.GetCtpNam:Str30;
begin
  Result:=oTable.FieldByName('CtpNam').AsString;
end;

procedure TOshlstDat.SetCtpNam(pValue:Str30);
begin
  oTable.FieldByName('CtpNam').AsString:=pValue;
end;

function TOshlstDat.GetCtpTel:Str20;
begin
  Result:=oTable.FieldByName('CtpTel').AsString;
end;

procedure TOshlstDat.SetCtpTel(pValue:Str20);
begin
  oTable.FieldByName('CtpTel').AsString:=pValue;
end;

function TOshlstDat.GetCtpFax:Str20;
begin
  Result:=oTable.FieldByName('CtpFax').AsString;
end;

procedure TOshlstDat.SetCtpFax(pValue:Str20);
begin
  oTable.FieldByName('CtpFax').AsString:=pValue;
end;

function TOshlstDat.GetCtpEml:Str30;
begin
  Result:=oTable.FieldByName('CtpEml').AsString;
end;

procedure TOshlstDat.SetCtpEml(pValue:Str30);
begin
  oTable.FieldByName('CtpEml').AsString:=pValue;
end;

function TOshlstDat.GetSpaNum:longint;
begin
  Result:=oTable.FieldByName('SpaNum').AsInteger;
end;

procedure TOshlstDat.SetSpaNum(pValue:longint);
begin
  oTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TOshlstDat.GetWpaNum:word;
begin
  Result:=oTable.FieldByName('WpaNum').AsInteger;
end;

procedure TOshlstDat.SetWpaNum(pValue:word);
begin
  oTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TOshlstDat.GetWpaNam:Str60;
begin
  Result:=oTable.FieldByName('WpaNam').AsString;
end;

procedure TOshlstDat.SetWpaNam(pValue:Str60);
begin
  oTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TOshlstDat.GetWpaAdr:Str30;
begin
  Result:=oTable.FieldByName('WpaAdr').AsString;
end;

procedure TOshlstDat.SetWpaAdr(pValue:Str30);
begin
  oTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TOshlstDat.GetWpaSta:Str2;
begin
  Result:=oTable.FieldByName('WpaSta').AsString;
end;

procedure TOshlstDat.SetWpaSta(pValue:Str2);
begin
  oTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TOshlstDat.GetWpaCty:Str3;
begin
  Result:=oTable.FieldByName('WpaCty').AsString;
end;

procedure TOshlstDat.SetWpaCty(pValue:Str3);
begin
  oTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TOshlstDat.GetWpaCtn:Str30;
begin
  Result:=oTable.FieldByName('WpaCtn').AsString;
end;

procedure TOshlstDat.SetWpaCtn(pValue:Str30);
begin
  oTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TOshlstDat.GetWpaZip:Str15;
begin
  Result:=oTable.FieldByName('WpaZip').AsString;
end;

procedure TOshlstDat.SetWpaZip(pValue:Str15);
begin
  oTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TOshlstDat.GetPayCod:Str1;
begin
  Result:=oTable.FieldByName('PayCod').AsString;
end;

procedure TOshlstDat.SetPayCod(pValue:Str1);
begin
  oTable.FieldByName('PayCod').AsString:=pValue;
end;

function TOshlstDat.GetPayNam:Str20;
begin
  Result:=oTable.FieldByName('PayNam').AsString;
end;

procedure TOshlstDat.SetPayNam(pValue:Str20);
begin
  oTable.FieldByName('PayNam').AsString:=pValue;
end;

function TOshlstDat.GetTrsCod:Str5;
begin
  Result:=oTable.FieldByName('TrsCod').AsString;
end;

procedure TOshlstDat.SetTrsCod(pValue:Str5);
begin
  oTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TOshlstDat.GetTrsNam:Str20;
begin
  Result:=oTable.FieldByName('TrsNam').AsString;
end;

procedure TOshlstDat.SetTrsNam(pValue:Str20);
begin
  oTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TOshlstDat.GetComDlv:byte;
begin
  Result:=oTable.FieldByName('ComDlv').AsInteger;
end;

procedure TOshlstDat.SetComDlv(pValue:byte);
begin
  oTable.FieldByName('ComDlv').AsInteger:=pValue;
end;

function TOshlstDat.GetRcvTyp:Str1;
begin
  Result:=oTable.FieldByName('RcvTyp').AsString;
end;

procedure TOshlstDat.SetRcvTyp(pValue:Str1);
begin
  oTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TOshlstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOshlstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOshlstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TOshlstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOshlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOshlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOshlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOshlstDat.GetMngUsr:Str8;
begin
  Result:=oTable.FieldByName('MngUsr').AsString;
end;

procedure TOshlstDat.SetMngUsr(pValue:Str8);
begin
  oTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TOshlstDat.GetMngUsn:Str30;
begin
  Result:=oTable.FieldByName('MngUsn').AsString;
end;

procedure TOshlstDat.SetMngUsn(pValue:Str30);
begin
  oTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TOshlstDat.GetMngDte:TDatetime;
begin
  Result:=oTable.FieldByName('MngDte').AsDateTime;
end;

procedure TOshlstDat.SetMngDte(pValue:TDatetime);
begin
  oTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetEdiUsr:Str8;
begin
  Result:=oTable.FieldByName('EdiUsr').AsString;
end;

procedure TOshlstDat.SetEdiUsr(pValue:Str8);
begin
  oTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TOshlstDat.GetEdiDte:TDatetime;
begin
  Result:=oTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TOshlstDat.SetEdiDte(pValue:TDatetime);
begin
  oTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetEdiTim:TDatetime;
begin
  Result:=oTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TOshlstDat.SetEdiTim(pValue:TDatetime);
begin
  oTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TOshlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOshlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TOshlstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TOshlstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOshlstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOshlstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOshlstDat.GetProAva:double;
begin
  Result:=oTable.FieldByName('ProAva').AsFloat;
end;

procedure TOshlstDat.SetProAva(pValue:double);
begin
  oTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TOshlstDat.GetSrvAva:double;
begin
  Result:=oTable.FieldByName('SrvAva').AsFloat;
end;

procedure TOshlstDat.SetSrvAva(pValue:double);
begin
  oTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TOshlstDat.GetOrdAva:double;
begin
  Result:=oTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOshlstDat.SetOrdAva(pValue:double);
begin
  oTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOshlstDat.GetVatVal:double;
begin
  Result:=oTable.FieldByName('VatVal').AsFloat;
end;

procedure TOshlstDat.SetVatVal(pValue:double);
begin
  oTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TOshlstDat.GetOrdBva:double;
begin
  Result:=oTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOshlstDat.SetOrdBva(pValue:double);
begin
  oTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOshlstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOshlstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOshlstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TOshlstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOshlstDat.GetDvzNam:Str3;
begin
  Result:=oTable.FieldByName('DvzNam').AsString;
end;

procedure TOshlstDat.SetDvzNam(pValue:Str3);
begin
  oTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TOshlstDat.GetDvzCrs:double;
begin
  Result:=oTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TOshlstDat.SetDvzCrs(pValue:double);
begin
  oTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TOshlstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOshlstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOshlstDat.GetDepPrc:double;
begin
  Result:=oTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOshlstDat.SetDepPrc(pValue:double);
begin
  oTable.FieldByName('DepPrc').AsFloat:=pValue;
end;

function TOshlstDat.GetDepBva:double;
begin
  Result:=oTable.FieldByName('DepBva').AsFloat;
end;

procedure TOshlstDat.SetDepBva(pValue:double);
begin
  oTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TOshlstDat.GetDepDte:TDatetime;
begin
  Result:=oTable.FieldByName('DepDte').AsDateTime;
end;

procedure TOshlstDat.SetDepDte(pValue:TDatetime);
begin
  oTable.FieldByName('DepDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetDepPay:Str1;
begin
  Result:=oTable.FieldByName('DepPay').AsString;
end;

procedure TOshlstDat.SetDepPay(pValue:Str1);
begin
  oTable.FieldByName('DepPay').AsString:=pValue;
end;

function TOshlstDat.GetValClc:Str15;
begin
  Result:=oTable.FieldByName('ValClc').AsString;
end;

procedure TOshlstDat.SetValClc(pValue:Str15);
begin
  oTable.FieldByName('ValClc').AsString:=pValue;
end;

function TOshlstDat.GetOrdPrq:double;
begin
  Result:=oTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOshlstDat.SetOrdPrq(pValue:double);
begin
  oTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetRocPrq:double;
begin
  Result:=oTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOshlstDat.SetRocPrq(pValue:double);
begin
  oTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetTsdPrq:double;
begin
  Result:=oTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOshlstDat.SetTsdPrq(pValue:double);
begin
  oTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetCncPrq:double;
begin
  Result:=oTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOshlstDat.SetCncPrq(pValue:double);
begin
  oTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOshlstDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetIsdPrq:double;
begin
  Result:=oTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOshlstDat.SetIsdPrq(pValue:double);
begin
  oTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOshlstDat.GetDstRat:Str1;
begin
  Result:=oTable.FieldByName('DstRat').AsString;
end;

procedure TOshlstDat.SetDstRat(pValue:Str1);
begin
  oTable.FieldByName('DstRat').AsString:=pValue;
end;

function TOshlstDat.GetDstLck:Str1;
begin
  Result:=oTable.FieldByName('DstLck').AsString;
end;

procedure TOshlstDat.SetDstLck(pValue:Str1);
begin
  oTable.FieldByName('DstLck').AsString:=pValue;
end;

function TOshlstDat.GetDstCls:Str1;
begin
  Result:=oTable.FieldByName('DstCls').AsString;
end;

procedure TOshlstDat.SetDstCls(pValue:Str1);
begin
  oTable.FieldByName('DstCls').AsString:=pValue;
end;

function TOshlstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TOshlstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOshlstDat.GetAtcDoq:byte;
begin
  Result:=oTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TOshlstDat.SetAtcDoq(pValue:byte);
begin
  oTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TOshlstDat.GetSrdNum:Str13;
begin
  Result:=oTable.FieldByName('SrdNum').AsString;
end;

procedure TOshlstDat.SetSrdNum(pValue:Str13);
begin
  oTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOshlstDat.GetSrdDoq:byte;
begin
  Result:=oTable.FieldByName('SrdDoq').AsInteger;
end;

procedure TOshlstDat.SetSrdDoq(pValue:byte);
begin
  oTable.FieldByName('SrdDoq').AsInteger:=pValue;
end;

function TOshlstDat.GetTsdNum:Str13;
begin
  Result:=oTable.FieldByName('TsdNum').AsString;
end;

procedure TOshlstDat.SetTsdNum(pValue:Str13);
begin
  oTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOshlstDat.GetTsdDoq:byte;
begin
  Result:=oTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOshlstDat.SetTsdDoq(pValue:byte);
begin
  oTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOshlstDat.GetTsdPrc:byte;
begin
  Result:=oTable.FieldByName('TsdPrc').AsInteger;
end;

procedure TOshlstDat.SetTsdPrc(pValue:byte);
begin
  oTable.FieldByName('TsdPrc').AsInteger:=pValue;
end;

function TOshlstDat.GetIsdNum:Str13;
begin
  Result:=oTable.FieldByName('IsdNum').AsString;
end;

procedure TOshlstDat.SetIsdNum(pValue:Str13);
begin
  oTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOshlstDat.GetIsdDoq:byte;
begin
  Result:=oTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOshlstDat.SetIsdDoq(pValue:byte);
begin
  oTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOshlstDat.GetIsdPrc:byte;
begin
  Result:=oTable.FieldByName('IsdPrc').AsInteger;
end;

procedure TOshlstDat.SetIsdPrc(pValue:byte);
begin
  oTable.FieldByName('IsdPrc').AsInteger:=pValue;
end;

function TOshlstDat.GetPrnCnt:byte;
begin
  Result:=oTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOshlstDat.SetPrnCnt(pValue:byte);
begin
  oTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TOshlstDat.GetPrnUsr:word;
begin
  Result:=oTable.FieldByName('PrnUsr').AsInteger;
end;

procedure TOshlstDat.SetPrnUsr(pValue:word);
begin
  oTable.FieldByName('PrnUsr').AsInteger:=pValue;
end;

function TOshlstDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TOshlstDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetDocDes:Str50;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TOshlstDat.SetDocDes(pValue:Str50);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOshlstDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOshlstDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOshlstDat.GetDocFrm:Str6;
begin
  Result:=oTable.FieldByName('DocFrm').AsString;
end;

procedure TOshlstDat.SetDocFrm(pValue:Str6);
begin
  oTable.FieldByName('DocFrm').AsString:=pValue;
end;

function TOshlstDat.GetPsdYer:Str2;
begin
  Result:=oTable.FieldByName('PsdYer').AsString;
end;

procedure TOshlstDat.SetPsdYer(pValue:Str2);
begin
  oTable.FieldByName('PsdYer').AsString:=pValue;
end;

function TOshlstDat.GetPsdSer:longint;
begin
  Result:=oTable.FieldByName('PsdSer').AsInteger;
end;

procedure TOshlstDat.SetPsdSer(pValue:longint);
begin
  oTable.FieldByName('PsdSer').AsInteger:=pValue;
end;

function TOshlstDat.GetPsdNum:Str12;
begin
  Result:=oTable.FieldByName('PsdNum').AsString;
end;

procedure TOshlstDat.SetPsdNum(pValue:Str12);
begin
  oTable.FieldByName('PsdNum').AsString:=pValue;
end;

function TOshlstDat.GetPseNum:Str12;
begin
  Result:=oTable.FieldByName('PseNum').AsString;
end;

procedure TOshlstDat.SetPseNum(pValue:Str12);
begin
  oTable.FieldByName('PseNum').AsString:=pValue;
end;

function TOshlstDat.GetPsvNum:Str10;
begin
  Result:=oTable.FieldByName('PsvNum').AsString;
end;

procedure TOshlstDat.SetPsvNum(pValue:Str10);
begin
  oTable.FieldByName('PsvNum').AsString:=pValue;
end;

function TOshlstDat.GetPsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('PsdDte').AsDateTime;
end;

procedure TOshlstDat.SetPsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('PsdDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetPseDte:TDatetime;
begin
  Result:=oTable.FieldByName('PseDte').AsDateTime;
end;

procedure TOshlstDat.SetPseDte(pValue:TDatetime);
begin
  oTable.FieldByName('PseDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetPsdVal:double;
begin
  Result:=oTable.FieldByName('PsdVal').AsFloat;
end;

procedure TOshlstDat.SetPsdVal(pValue:double);
begin
  oTable.FieldByName('PsdVal').AsFloat:=pValue;
end;

function TOshlstDat.GetPspVal:double;
begin
  Result:=oTable.FieldByName('PspVal').AsFloat;
end;

procedure TOshlstDat.SetPspVal(pValue:double);
begin
  oTable.FieldByName('PspVal').AsFloat:=pValue;
end;

function TOshlstDat.GetPspCur:double;
begin
  Result:=oTable.FieldByName('PspCur').AsFloat;
end;

procedure TOshlstDat.SetPspCur(pValue:double);
begin
  oTable.FieldByName('PspCur').AsFloat:=pValue;
end;

function TOshlstDat.GetPsdIba:Str30;
begin
  Result:=oTable.FieldByName('PsdIba').AsString;
end;

procedure TOshlstDat.SetPsdIba(pValue:Str30);
begin
  oTable.FieldByName('PsdIba').AsString:=pValue;
end;

function TOshlstDat.GetPsdUsr:Str10;
begin
  Result:=oTable.FieldByName('PsdUsr').AsString;
end;

procedure TOshlstDat.SetPsdUsr(pValue:Str10);
begin
  oTable.FieldByName('PsdUsr').AsString:=pValue;
end;

function TOshlstDat.GetPsdUsn:Str30;
begin
  Result:=oTable.FieldByName('PsdUsn').AsString;
end;

procedure TOshlstDat.SetPsdUsn(pValue:Str30);
begin
  oTable.FieldByName('PsdUsn').AsString:=pValue;
end;

function TOshlstDat.GetDsdNum:Str12;
begin
  Result:=oTable.FieldByName('DsdNum').AsString;
end;

procedure TOshlstDat.SetDsdNum(pValue:Str12);
begin
  oTable.FieldByName('DsdNum').AsString:=pValue;
end;

function TOshlstDat.GetDseNum:Str12;
begin
  Result:=oTable.FieldByName('DseNum').AsString;
end;

procedure TOshlstDat.SetDseNum(pValue:Str12);
begin
  oTable.FieldByName('DseNum').AsString:=pValue;
end;

function TOshlstDat.GetDsvNum:Str10;
begin
  Result:=oTable.FieldByName('DsvNum').AsString;
end;

procedure TOshlstDat.SetDsvNum(pValue:Str10);
begin
  oTable.FieldByName('DsvNum').AsString:=pValue;
end;

function TOshlstDat.GetDsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('DsdDte').AsDateTime;
end;

procedure TOshlstDat.SetDsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('DsdDte').AsDateTime:=pValue;
end;

function TOshlstDat.GetDocSource:Str10;
begin
  Result:=oTable.FieldByName('DocSource').AsString;
end;

procedure TOshlstDat.SetDocSource(pValue:Str10);
begin
  oTable.FieldByName('DocSource').AsString:=pValue;
end;

function TOshlstDat.GetDocStatus:Str10;
begin
  Result:=oTable.FieldByName('DocStatus').AsString;
end;

procedure TOshlstDat.SetDocStatus(pValue:Str10);
begin
  oTable.FieldByName('DocStatus').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOshlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOshlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOshlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOshlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOshlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOshlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOshlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOshlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOshlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TOshlstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TOshlstDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TOshlstDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TOshlstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TOshlstDat.LocReqDte(pReqDte:TDatetime):boolean;
begin
  SetIndex(ixReqDte);
  Result:=oTable.FindKey([pReqDte]);
end;

function TOshlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOshlstDat.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindKey([pRegIno]);
end;

function TOshlstDat.LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindKey([pSpaNum,pWpaNum]);
end;

function TOshlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TOshlstDat.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindKey([pEndBva]);
end;

function TOshlstDat.LocDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindKey([pDepBva]);
end;

function TOshlstDat.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindKey([pPrjNum]);
end;

function TOshlstDat.LocPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindKey([pPrjCod]);
end;

function TOshlstDat.LocDstRat(pDstRat:Str1):boolean;
begin
  SetIndex(ixDstRat);
  Result:=oTable.FindKey([pDstRat]);
end;

function TOshlstDat.LocPyPs(pPsdYer:Str2;pPsdSer:longint):boolean;
begin
  SetIndex(ixPyPs);
  Result:=oTable.FindKey([pPsdYer,pPsdSer]);
end;

function TOshlstDat.LocPsdNum(pPsdNum:Str12):boolean;
begin
  SetIndex(ixPsdNum);
  Result:=oTable.FindKey([pPsdNum]);
end;

function TOshlstDat.LocPseNum(pPseNum:Str12):boolean;
begin
  SetIndex(ixPseNum);
  Result:=oTable.FindKey([pPseNum]);
end;

function TOshlstDat.LocPsvNum(pPsvNum:Str10):boolean;
begin
  SetIndex(ixPsvNum);
  Result:=oTable.FindKey([pPsvNum]);
end;

function TOshlstDat.LocDsdNum(pDsdNum:Str12):boolean;
begin
  SetIndex(ixDsdNum);
  Result:=oTable.FindKey([pDsdNum]);
end;

function TOshlstDat.LocDseNum(pDseNum:Str12):boolean;
begin
  SetIndex(ixDseNum);
  Result:=oTable.FindKey([pDseNum]);
end;

function TOshlstDat.LocDsvNum(pDsvNum:Str10):boolean;
begin
  SetIndex(ixDsvNum);
  Result:=oTable.FindKey([pDsvNum]);
end;

function TOshlstDat.LocDocSource(pDocSource:Str10):boolean;
begin
  SetIndex(ixDocSource);
  Result:=oTable.FindKey([pDocSource]);
end;

function TOshlstDat.LocDocStatus(pDocStatus:Str10):boolean;
begin
  SetIndex(ixDocStatus);
  Result:=oTable.FindKey([pDocStatus]);
end;

function TOshlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOshlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TOshlstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TOshlstDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TOshlstDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TOshlstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TOshlstDat.NearReqDte(pReqDte:TDatetime):boolean;
begin
  SetIndex(ixReqDte);
  Result:=oTable.FindNearest([pReqDte]);
end;

function TOshlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOshlstDat.NearRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindNearest([pRegIno]);
end;

function TOshlstDat.NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindNearest([pSpaNum,pWpaNum]);
end;

function TOshlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TOshlstDat.NearEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindNearest([pEndBva]);
end;

function TOshlstDat.NearDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindNearest([pDepBva]);
end;

function TOshlstDat.NearPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindNearest([pPrjNum]);
end;

function TOshlstDat.NearPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindNearest([pPrjCod]);
end;

function TOshlstDat.NearDstRat(pDstRat:Str1):boolean;
begin
  SetIndex(ixDstRat);
  Result:=oTable.FindNearest([pDstRat]);
end;

function TOshlstDat.NearPyPs(pPsdYer:Str2;pPsdSer:longint):boolean;
begin
  SetIndex(ixPyPs);
  Result:=oTable.FindNearest([pPsdYer,pPsdSer]);
end;

function TOshlstDat.NearPsdNum(pPsdNum:Str12):boolean;
begin
  SetIndex(ixPsdNum);
  Result:=oTable.FindNearest([pPsdNum]);
end;

function TOshlstDat.NearPseNum(pPseNum:Str12):boolean;
begin
  SetIndex(ixPseNum);
  Result:=oTable.FindNearest([pPseNum]);
end;

function TOshlstDat.NearPsvNum(pPsvNum:Str10):boolean;
begin
  SetIndex(ixPsvNum);
  Result:=oTable.FindNearest([pPsvNum]);
end;

function TOshlstDat.NearDsdNum(pDsdNum:Str12):boolean;
begin
  SetIndex(ixDsdNum);
  Result:=oTable.FindNearest([pDsdNum]);
end;

function TOshlstDat.NearDseNum(pDseNum:Str12):boolean;
begin
  SetIndex(ixDseNum);
  Result:=oTable.FindNearest([pDseNum]);
end;

function TOshlstDat.NearDsvNum(pDsvNum:Str10):boolean;
begin
  SetIndex(ixDsvNum);
  Result:=oTable.FindNearest([pDsvNum]);
end;

function TOshlstDat.NearDocSource(pDocSource:Str10):boolean;
begin
  SetIndex(ixDocSource);
  Result:=oTable.FindNearest([pDocSource]);
end;

function TOshlstDat.NearDocStatus(pDocStatus:Str10):boolean;
begin
  SetIndex(ixDocStatus);
  Result:=oTable.FindNearest([pDocStatus]);
end;

procedure TOshlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOshlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOshlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOshlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOshlstDat.Next;
begin
  oTable.Next;
end;

procedure TOshlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOshlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOshlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOshlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOshlstDat.Post;
begin
  oTable.Post;
end;

procedure TOshlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOshlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOshlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOshlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOshlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOshlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOshlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
