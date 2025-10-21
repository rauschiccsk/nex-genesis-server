unit dOCHLST;

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
  ixCusCrd='CusCrd';
  ixParNum='ParNum';
  ixRegIno='RegIno';
  ixSnWn='SnWn';
  ixParNam='ParNam';
  ixEndBva='EndBva';
  ixDepBva='DepBva';
  ixPrjNum='PrjNum';
  ixPrjCod='PrjCod';
  ixEdiUsr='EdiUsr';
  ixDstMod='DstMod';
  ixDocSource='DocSource';
  ixDocStatus='DocStatus';

type
  TOchlstDat=class(TComponent)
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
    function GetCusNum:Str20;            procedure SetCusNum(pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetPrjCod:Str30;            procedure SetPrjCod(pValue:Str30);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
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
    function GetEmlCnt:word;             procedure SetEmlCnt(pValue:word);
    function GetEmlSnd:byte;             procedure SetEmlSnd(pValue:byte);
    function GetSmsSnd:byte;             procedure SetSmsSnd(pValue:byte);
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
    function GetTrsCod:Str1;             procedure SetTrsCod(pValue:Str1);
    function GetTrsNam:Str20;            procedure SetTrsNam(pValue:Str20);
    function GetTrsLin:word;             procedure SetTrsLin(pValue:word);
    function GetDlvCit:byte;             procedure SetDlvCit(pValue:byte);
    function GetDlvCdo:byte;             procedure SetDlvCdo(pValue:byte);
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
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetProAva:double;           procedure SetProAva(pValue:double);
    function GetSrvAva:double;           procedure SetSrvAva(pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetDscAva:double;           procedure SetDscAva(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetVatVal:double;           procedure SetVatVal(pValue:double);
    function GetSalBva:double;           procedure SetSalBva(pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva(pValue:double);
    function GetEndBva:double;           procedure SetEndBva(pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam(pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetDepPrc:double;           procedure SetDepPrc(pValue:double);
    function GetDepBva:double;           procedure SetDepBva(pValue:double);
    function GetDepDte:TDatetime;        procedure SetDepDte(pValue:TDatetime);
    function GetDepPay:Str1;             procedure SetDepPay(pValue:Str1);
    function GetDepCas:byte;             procedure SetDepCas(pValue:byte);
    function GetValClc:Str15;            procedure SetValClc(pValue:Str15);
    function GetResTyp:byte;             procedure SetResTyp(pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq(pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq(pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq(pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq(pValue:double);
    function GetDstMod:Str1;             procedure SetDstMod(pValue:Str1);
    function GetDstExd:Str1;             procedure SetDstExd(pValue:Str1);
    function GetDstLck:Str1;             procedure SetDstLck(pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls(pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq(pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum(pValue:Str13);
    function GetSrdDoq:byte;             procedure SetSrdDoq(pValue:byte);
    function GetMcdNum:Str13;            procedure SetMcdNum(pValue:Str13);
    function GetMcdDoq:byte;             procedure SetMcdDoq(pValue:byte);
    function GetTcdNum:Str13;            procedure SetTcdNum(pValue:Str13);
    function GetTcdDoq:byte;             procedure SetTcdDoq(pValue:byte);
    function GetTcdPrc:byte;             procedure SetTcdPrc(pValue:byte);
    function GetIcdNum:Str13;            procedure SetIcdNum(pValue:Str13);
    function GetIcdDoq:byte;             procedure SetIcdDoq(pValue:byte);
    function GetIcdPrc:byte;             procedure SetIcdPrc(pValue:byte);
    function GetEcdNum:Str13;            procedure SetEcdNum(pValue:Str13);
    function GetEcdDoq:byte;             procedure SetEcdDoq(pValue:byte);
    function GetPrnCnt:byte;             procedure SetPrnCnt(pValue:byte);
    function GetPrnUsr:word;             procedure SetPrnUsr(pValue:word);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes(pValue:Str50);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm(pValue:Str6);
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
    function LocCusCrd(pCusCrd:Str20):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocRegIno(pRegIno:Str15):boolean;
    function LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocEndBva(pEndBva:double):boolean;
    function LocDepBva(pDepBva:double):boolean;
    function LocPrjNum(pPrjNum:Str12):boolean;
    function LocPrjCod(pPrjCod:Str30):boolean;
    function LocEdiUsr(pEdiUsr:Str8):boolean;
    function LocDstMod(pDstMod:Str1):boolean;
    function LocDocSource(pDocSource:Str10):boolean;
    function LocDocStatus(pDocStatus:Str10):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearReqDte(pReqDte:TDatetime):boolean;
    function NearCusCrd(pCusCrd:Str20):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearRegIno(pRegIno:Str15):boolean;
    function NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearEndBva(pEndBva:double):boolean;
    function NearDepBva(pDepBva:double):boolean;
    function NearPrjNum(pPrjNum:Str12):boolean;
    function NearPrjCod(pPrjCod:Str30):boolean;
    function NearEdiUsr(pEdiUsr:Str8):boolean;
    function NearDstMod(pDstMod:Str1):boolean;
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
    property CusNum:Str20 read GetCusNum write SetCusNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property PrjCod:Str30 read GetPrjCod write SetPrjCod;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
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
    property EmlCnt:word read GetEmlCnt write SetEmlCnt;
    property EmlSnd:byte read GetEmlSnd write SetEmlSnd;
    property SmsSnd:byte read GetSmsSnd write SetSmsSnd;
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
    property TrsCod:Str1 read GetTrsCod write SetTrsCod;
    property TrsNam:Str20 read GetTrsNam write SetTrsNam;
    property TrsLin:word read GetTrsLin write SetTrsLin;
    property DlvCit:byte read GetDlvCit write SetDlvCit;
    property DlvCdo:byte read GetDlvCdo write SetDlvCdo;
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
    property StkAva:double read GetStkAva write SetStkAva;
    property ProAva:double read GetProAva write SetProAva;
    property SrvAva:double read GetSrvAva write SetSrvAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
    property SalAva:double read GetSalAva write SetSalAva;
    property VatVal:double read GetVatVal write SetVatVal;
    property SalBva:double read GetSalBva write SetSalBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DvzCrs:double read GetDvzCrs write SetDvzCrs;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property DepPrc:double read GetDepPrc write SetDepPrc;
    property DepBva:double read GetDepBva write SetDepBva;
    property DepDte:TDatetime read GetDepDte write SetDepDte;
    property DepPay:Str1 read GetDepPay write SetDepPay;
    property DepCas:byte read GetDepCas write SetDepCas;
    property ValClc:Str15 read GetValClc write SetValClc;
    property ResTyp:byte read GetResTyp write SetResTyp;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property ReqPrq:double read GetReqPrq write SetReqPrq;
    property RstPrq:double read GetRstPrq write SetRstPrq;
    property RosPrq:double read GetRosPrq write SetRosPrq;
    property ExdPrq:double read GetExdPrq write SetExdPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property DstMod:Str1 read GetDstMod write SetDstMod;
    property DstExd:Str1 read GetDstExd write SetDstExd;
    property DstLck:Str1 read GetDstLck write SetDstLck;
    property DstCls:Str1 read GetDstCls write SetDstCls;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property AtcDoq:byte read GetAtcDoq write SetAtcDoq;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property SrdDoq:byte read GetSrdDoq write SetSrdDoq;
    property McdNum:Str13 read GetMcdNum write SetMcdNum;
    property McdDoq:byte read GetMcdDoq write SetMcdDoq;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property TcdDoq:byte read GetTcdDoq write SetTcdDoq;
    property TcdPrc:byte read GetTcdPrc write SetTcdPrc;
    property IcdNum:Str13 read GetIcdNum write SetIcdNum;
    property IcdDoq:byte read GetIcdDoq write SetIcdDoq;
    property IcdPrc:byte read GetIcdPrc write SetIcdPrc;
    property EcdNum:Str13 read GetEcdNum write SetEcdNum;
    property EcdDoq:byte read GetEcdDoq write SetEcdDoq;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property PrnUsr:word read GetPrnUsr write SetPrnUsr;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property DocDes:Str50 read GetDocDes write SetDocDes;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocFrm:Str6 read GetDocFrm write SetDocFrm;
    property DocSource:Str10 read GetDocSource write SetDocSource;
    property DocStatus:Str10 read GetDocStatus write SetDocStatus;
  end;

implementation

constructor TOchlstDat.Create;
begin
  oTable:=DatInit('OCHLST',gPath.StkPath,Self);
end;

constructor TOchlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCHLST',pPath,Self);
end;

destructor TOchlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOchlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOchlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOchlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TOchlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOchlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TOchlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOchlstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TOchlstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOchlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOchlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOchlstDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TOchlstDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TOchlstDat.GetCusNum:Str20;
begin
  Result:=oTable.FieldByName('CusNum').AsString;
end;

procedure TOchlstDat.SetCusNum(pValue:Str20);
begin
  oTable.FieldByName('CusNum').AsString:=pValue;
end;

function TOchlstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TOchlstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOchlstDat.GetPrjCod:Str30;
begin
  Result:=oTable.FieldByName('PrjCod').AsString;
end;

procedure TOchlstDat.SetPrjCod(pValue:Str30);
begin
  oTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TOchlstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOchlstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOchlstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOchlstDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetReqTyp:Str1;
begin
  Result:=oTable.FieldByName('ReqTyp').AsString;
end;

procedure TOchlstDat.SetReqTyp(pValue:Str1);
begin
  oTable.FieldByName('ReqTyp').AsString:=pValue;
end;

function TOchlstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TOchlstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOchlstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOchlstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOchlstDat.GetVatDoc:byte;
begin
  Result:=oTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOchlstDat.SetVatDoc(pValue:byte);
begin
  oTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TOchlstDat.GetCusCrd:Str20;
begin
  Result:=oTable.FieldByName('CusCrd').AsString;
end;

procedure TOchlstDat.SetCusCrd(pValue:Str20);
begin
  oTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TOchlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOchlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOchlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOchlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOchlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TOchlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOchlstDat.GetRegIno:Str15;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TOchlstDat.SetRegIno(pValue:Str15);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TOchlstDat.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TOchlstDat.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TOchlstDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TOchlstDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TOchlstDat.GetRegAdr:Str30;
begin
  Result:=oTable.FieldByName('RegAdr').AsString;
end;

procedure TOchlstDat.SetRegAdr(pValue:Str30);
begin
  oTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TOchlstDat.GetRegSta:Str2;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TOchlstDat.SetRegSta(pValue:Str2);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TOchlstDat.GetRegCty:Str3;
begin
  Result:=oTable.FieldByName('RegCty').AsString;
end;

procedure TOchlstDat.SetRegCty(pValue:Str3);
begin
  oTable.FieldByName('RegCty').AsString:=pValue;
end;

function TOchlstDat.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TOchlstDat.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TOchlstDat.GetRegZip:Str15;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TOchlstDat.SetRegZip(pValue:Str15);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TOchlstDat.GetCtpNum:longint;
begin
  Result:=oTable.FieldByName('CtpNum').AsInteger;
end;

procedure TOchlstDat.SetCtpNum(pValue:longint);
begin
  oTable.FieldByName('CtpNum').AsInteger:=pValue;
end;

function TOchlstDat.GetCtpNam:Str30;
begin
  Result:=oTable.FieldByName('CtpNam').AsString;
end;

procedure TOchlstDat.SetCtpNam(pValue:Str30);
begin
  oTable.FieldByName('CtpNam').AsString:=pValue;
end;

function TOchlstDat.GetCtpTel:Str20;
begin
  Result:=oTable.FieldByName('CtpTel').AsString;
end;

procedure TOchlstDat.SetCtpTel(pValue:Str20);
begin
  oTable.FieldByName('CtpTel').AsString:=pValue;
end;

function TOchlstDat.GetCtpFax:Str20;
begin
  Result:=oTable.FieldByName('CtpFax').AsString;
end;

procedure TOchlstDat.SetCtpFax(pValue:Str20);
begin
  oTable.FieldByName('CtpFax').AsString:=pValue;
end;

function TOchlstDat.GetCtpEml:Str30;
begin
  Result:=oTable.FieldByName('CtpEml').AsString;
end;

procedure TOchlstDat.SetCtpEml(pValue:Str30);
begin
  oTable.FieldByName('CtpEml').AsString:=pValue;
end;

function TOchlstDat.GetEmlCnt:word;
begin
  Result:=oTable.FieldByName('EmlCnt').AsInteger;
end;

procedure TOchlstDat.SetEmlCnt(pValue:word);
begin
  oTable.FieldByName('EmlCnt').AsInteger:=pValue;
end;

function TOchlstDat.GetEmlSnd:byte;
begin
  Result:=oTable.FieldByName('EmlSnd').AsInteger;
end;

procedure TOchlstDat.SetEmlSnd(pValue:byte);
begin
  oTable.FieldByName('EmlSnd').AsInteger:=pValue;
end;

function TOchlstDat.GetSmsSnd:byte;
begin
  Result:=oTable.FieldByName('SmsSnd').AsInteger;
end;

procedure TOchlstDat.SetSmsSnd(pValue:byte);
begin
  oTable.FieldByName('SmsSnd').AsInteger:=pValue;
end;

function TOchlstDat.GetSpaNum:longint;
begin
  Result:=oTable.FieldByName('SpaNum').AsInteger;
end;

procedure TOchlstDat.SetSpaNum(pValue:longint);
begin
  oTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TOchlstDat.GetWpaNum:word;
begin
  Result:=oTable.FieldByName('WpaNum').AsInteger;
end;

procedure TOchlstDat.SetWpaNum(pValue:word);
begin
  oTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TOchlstDat.GetWpaNam:Str60;
begin
  Result:=oTable.FieldByName('WpaNam').AsString;
end;

procedure TOchlstDat.SetWpaNam(pValue:Str60);
begin
  oTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TOchlstDat.GetWpaAdr:Str30;
begin
  Result:=oTable.FieldByName('WpaAdr').AsString;
end;

procedure TOchlstDat.SetWpaAdr(pValue:Str30);
begin
  oTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TOchlstDat.GetWpaSta:Str2;
begin
  Result:=oTable.FieldByName('WpaSta').AsString;
end;

procedure TOchlstDat.SetWpaSta(pValue:Str2);
begin
  oTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TOchlstDat.GetWpaCty:Str3;
begin
  Result:=oTable.FieldByName('WpaCty').AsString;
end;

procedure TOchlstDat.SetWpaCty(pValue:Str3);
begin
  oTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TOchlstDat.GetWpaCtn:Str30;
begin
  Result:=oTable.FieldByName('WpaCtn').AsString;
end;

procedure TOchlstDat.SetWpaCtn(pValue:Str30);
begin
  oTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TOchlstDat.GetWpaZip:Str15;
begin
  Result:=oTable.FieldByName('WpaZip').AsString;
end;

procedure TOchlstDat.SetWpaZip(pValue:Str15);
begin
  oTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TOchlstDat.GetPayCod:Str1;
begin
  Result:=oTable.FieldByName('PayCod').AsString;
end;

procedure TOchlstDat.SetPayCod(pValue:Str1);
begin
  oTable.FieldByName('PayCod').AsString:=pValue;
end;

function TOchlstDat.GetPayNam:Str20;
begin
  Result:=oTable.FieldByName('PayNam').AsString;
end;

procedure TOchlstDat.SetPayNam(pValue:Str20);
begin
  oTable.FieldByName('PayNam').AsString:=pValue;
end;

function TOchlstDat.GetTrsCod:Str1;
begin
  Result:=oTable.FieldByName('TrsCod').AsString;
end;

procedure TOchlstDat.SetTrsCod(pValue:Str1);
begin
  oTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TOchlstDat.GetTrsNam:Str20;
begin
  Result:=oTable.FieldByName('TrsNam').AsString;
end;

procedure TOchlstDat.SetTrsNam(pValue:Str20);
begin
  oTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TOchlstDat.GetTrsLin:word;
begin
  Result:=oTable.FieldByName('TrsLin').AsInteger;
end;

procedure TOchlstDat.SetTrsLin(pValue:word);
begin
  oTable.FieldByName('TrsLin').AsInteger:=pValue;
end;

function TOchlstDat.GetDlvCit:byte;
begin
  Result:=oTable.FieldByName('DlvCit').AsInteger;
end;

procedure TOchlstDat.SetDlvCit(pValue:byte);
begin
  oTable.FieldByName('DlvCit').AsInteger:=pValue;
end;

function TOchlstDat.GetDlvCdo:byte;
begin
  Result:=oTable.FieldByName('DlvCdo').AsInteger;
end;

procedure TOchlstDat.SetDlvCdo(pValue:byte);
begin
  oTable.FieldByName('DlvCdo').AsInteger:=pValue;
end;

function TOchlstDat.GetRcvTyp:Str1;
begin
  Result:=oTable.FieldByName('RcvTyp').AsString;
end;

procedure TOchlstDat.SetRcvTyp(pValue:Str1);
begin
  oTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TOchlstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOchlstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOchlstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TOchlstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOchlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOchlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOchlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOchlstDat.GetMngUsr:Str8;
begin
  Result:=oTable.FieldByName('MngUsr').AsString;
end;

procedure TOchlstDat.SetMngUsr(pValue:Str8);
begin
  oTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TOchlstDat.GetMngUsn:Str30;
begin
  Result:=oTable.FieldByName('MngUsn').AsString;
end;

procedure TOchlstDat.SetMngUsn(pValue:Str30);
begin
  oTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TOchlstDat.GetMngDte:TDatetime;
begin
  Result:=oTable.FieldByName('MngDte').AsDateTime;
end;

procedure TOchlstDat.SetMngDte(pValue:TDatetime);
begin
  oTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetEdiUsr:Str8;
begin
  Result:=oTable.FieldByName('EdiUsr').AsString;
end;

procedure TOchlstDat.SetEdiUsr(pValue:Str8);
begin
  oTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TOchlstDat.GetEdiDte:TDatetime;
begin
  Result:=oTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TOchlstDat.SetEdiDte(pValue:TDatetime);
begin
  oTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetEdiTim:TDatetime;
begin
  Result:=oTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TOchlstDat.SetEdiTim(pValue:TDatetime);
begin
  oTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TOchlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOchlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TOchlstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TOchlstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOchlstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOchlstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOchlstDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TOchlstDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOchlstDat.GetProAva:double;
begin
  Result:=oTable.FieldByName('ProAva').AsFloat;
end;

procedure TOchlstDat.SetProAva(pValue:double);
begin
  oTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TOchlstDat.GetSrvAva:double;
begin
  Result:=oTable.FieldByName('SrvAva').AsFloat;
end;

procedure TOchlstDat.SetSrvAva(pValue:double);
begin
  oTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TOchlstDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOchlstDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOchlstDat.GetDscAva:double;
begin
  Result:=oTable.FieldByName('DscAva').AsFloat;
end;

procedure TOchlstDat.SetDscAva(pValue:double);
begin
  oTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TOchlstDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TOchlstDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOchlstDat.GetVatVal:double;
begin
  Result:=oTable.FieldByName('VatVal').AsFloat;
end;

procedure TOchlstDat.SetVatVal(pValue:double);
begin
  oTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TOchlstDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TOchlstDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOchlstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOchlstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOchlstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TOchlstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOchlstDat.GetDvzNam:Str3;
begin
  Result:=oTable.FieldByName('DvzNam').AsString;
end;

procedure TOchlstDat.SetDvzNam(pValue:Str3);
begin
  oTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TOchlstDat.GetDvzCrs:double;
begin
  Result:=oTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TOchlstDat.SetDvzCrs(pValue:double);
begin
  oTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TOchlstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOchlstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOchlstDat.GetDepPrc:double;
begin
  Result:=oTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOchlstDat.SetDepPrc(pValue:double);
begin
  oTable.FieldByName('DepPrc').AsFloat:=pValue;
end;

function TOchlstDat.GetDepBva:double;
begin
  Result:=oTable.FieldByName('DepBva').AsFloat;
end;

procedure TOchlstDat.SetDepBva(pValue:double);
begin
  oTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TOchlstDat.GetDepDte:TDatetime;
begin
  Result:=oTable.FieldByName('DepDte').AsDateTime;
end;

procedure TOchlstDat.SetDepDte(pValue:TDatetime);
begin
  oTable.FieldByName('DepDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetDepPay:Str1;
begin
  Result:=oTable.FieldByName('DepPay').AsString;
end;

procedure TOchlstDat.SetDepPay(pValue:Str1);
begin
  oTable.FieldByName('DepPay').AsString:=pValue;
end;

function TOchlstDat.GetDepCas:byte;
begin
  Result:=oTable.FieldByName('DepCas').AsInteger;
end;

procedure TOchlstDat.SetDepCas(pValue:byte);
begin
  oTable.FieldByName('DepCas').AsInteger:=pValue;
end;

function TOchlstDat.GetValClc:Str15;
begin
  Result:=oTable.FieldByName('ValClc').AsString;
end;

procedure TOchlstDat.SetValClc(pValue:Str15);
begin
  oTable.FieldByName('ValClc').AsString:=pValue;
end;

function TOchlstDat.GetResTyp:byte;
begin
  Result:=oTable.FieldByName('ResTyp').AsInteger;
end;

procedure TOchlstDat.SetResTyp(pValue:byte);
begin
  oTable.FieldByName('ResTyp').AsInteger:=pValue;
end;

function TOchlstDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOchlstDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetReqPrq:double;
begin
  Result:=oTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOchlstDat.SetReqPrq(pValue:double);
begin
  oTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetRstPrq:double;
begin
  Result:=oTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOchlstDat.SetRstPrq(pValue:double);
begin
  oTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetRosPrq:double;
begin
  Result:=oTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOchlstDat.SetRosPrq(pValue:double);
begin
  oTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetExdPrq:double;
begin
  Result:=oTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOchlstDat.SetExdPrq(pValue:double);
begin
  oTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOchlstDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetCncPrq:double;
begin
  Result:=oTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOchlstDat.SetCncPrq(pValue:double);
begin
  oTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOchlstDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetIcdPrq:double;
begin
  Result:=oTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOchlstDat.SetIcdPrq(pValue:double);
begin
  oTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOchlstDat.GetDstMod:Str1;
begin
  Result:=oTable.FieldByName('DstMod').AsString;
end;

procedure TOchlstDat.SetDstMod(pValue:Str1);
begin
  oTable.FieldByName('DstMod').AsString:=pValue;
end;

function TOchlstDat.GetDstExd:Str1;
begin
  Result:=oTable.FieldByName('DstExd').AsString;
end;

procedure TOchlstDat.SetDstExd(pValue:Str1);
begin
  oTable.FieldByName('DstExd').AsString:=pValue;
end;

function TOchlstDat.GetDstLck:Str1;
begin
  Result:=oTable.FieldByName('DstLck').AsString;
end;

procedure TOchlstDat.SetDstLck(pValue:Str1);
begin
  oTable.FieldByName('DstLck').AsString:=pValue;
end;

function TOchlstDat.GetDstCls:Str1;
begin
  Result:=oTable.FieldByName('DstCls').AsString;
end;

procedure TOchlstDat.SetDstCls(pValue:Str1);
begin
  oTable.FieldByName('DstCls').AsString:=pValue;
end;

function TOchlstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TOchlstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOchlstDat.GetAtcDoq:byte;
begin
  Result:=oTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TOchlstDat.SetAtcDoq(pValue:byte);
begin
  oTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetSrdNum:Str13;
begin
  Result:=oTable.FieldByName('SrdNum').AsString;
end;

procedure TOchlstDat.SetSrdNum(pValue:Str13);
begin
  oTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOchlstDat.GetSrdDoq:byte;
begin
  Result:=oTable.FieldByName('SrdDoq').AsInteger;
end;

procedure TOchlstDat.SetSrdDoq(pValue:byte);
begin
  oTable.FieldByName('SrdDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetMcdNum:Str13;
begin
  Result:=oTable.FieldByName('McdNum').AsString;
end;

procedure TOchlstDat.SetMcdNum(pValue:Str13);
begin
  oTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOchlstDat.GetMcdDoq:byte;
begin
  Result:=oTable.FieldByName('McdDoq').AsInteger;
end;

procedure TOchlstDat.SetMcdDoq(pValue:byte);
begin
  oTable.FieldByName('McdDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetTcdNum:Str13;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TOchlstDat.SetTcdNum(pValue:Str13);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOchlstDat.GetTcdDoq:byte;
begin
  Result:=oTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOchlstDat.SetTcdDoq(pValue:byte);
begin
  oTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetTcdPrc:byte;
begin
  Result:=oTable.FieldByName('TcdPrc').AsInteger;
end;

procedure TOchlstDat.SetTcdPrc(pValue:byte);
begin
  oTable.FieldByName('TcdPrc').AsInteger:=pValue;
end;

function TOchlstDat.GetIcdNum:Str13;
begin
  Result:=oTable.FieldByName('IcdNum').AsString;
end;

procedure TOchlstDat.SetIcdNum(pValue:Str13);
begin
  oTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOchlstDat.GetIcdDoq:byte;
begin
  Result:=oTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOchlstDat.SetIcdDoq(pValue:byte);
begin
  oTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetIcdPrc:byte;
begin
  Result:=oTable.FieldByName('IcdPrc').AsInteger;
end;

procedure TOchlstDat.SetIcdPrc(pValue:byte);
begin
  oTable.FieldByName('IcdPrc').AsInteger:=pValue;
end;

function TOchlstDat.GetEcdNum:Str13;
begin
  Result:=oTable.FieldByName('EcdNum').AsString;
end;

procedure TOchlstDat.SetEcdNum(pValue:Str13);
begin
  oTable.FieldByName('EcdNum').AsString:=pValue;
end;

function TOchlstDat.GetEcdDoq:byte;
begin
  Result:=oTable.FieldByName('EcdDoq').AsInteger;
end;

procedure TOchlstDat.SetEcdDoq(pValue:byte);
begin
  oTable.FieldByName('EcdDoq').AsInteger:=pValue;
end;

function TOchlstDat.GetPrnCnt:byte;
begin
  Result:=oTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOchlstDat.SetPrnCnt(pValue:byte);
begin
  oTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TOchlstDat.GetPrnUsr:word;
begin
  Result:=oTable.FieldByName('PrnUsr').AsInteger;
end;

procedure TOchlstDat.SetPrnUsr(pValue:word);
begin
  oTable.FieldByName('PrnUsr').AsInteger:=pValue;
end;

function TOchlstDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TOchlstDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TOchlstDat.GetDocDes:Str50;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TOchlstDat.SetDocDes(pValue:Str50);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOchlstDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOchlstDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOchlstDat.GetDocFrm:Str6;
begin
  Result:=oTable.FieldByName('DocFrm').AsString;
end;

procedure TOchlstDat.SetDocFrm(pValue:Str6);
begin
  oTable.FieldByName('DocFrm').AsString:=pValue;
end;

function TOchlstDat.GetDocSource:Str10;
begin
  Result:=oTable.FieldByName('DocSource').AsString;
end;

procedure TOchlstDat.SetDocSource(pValue:Str10);
begin
  oTable.FieldByName('DocSource').AsString:=pValue;
end;

function TOchlstDat.GetDocStatus:Str10;
begin
  Result:=oTable.FieldByName('DocStatus').AsString;
end;

procedure TOchlstDat.SetDocStatus(pValue:Str10);
begin
  oTable.FieldByName('DocStatus').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOchlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOchlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOchlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOchlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOchlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOchlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOchlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOchlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOchlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TOchlstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TOchlstDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TOchlstDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TOchlstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TOchlstDat.LocReqDte(pReqDte:TDatetime):boolean;
begin
  SetIndex(ixReqDte);
  Result:=oTable.FindKey([pReqDte]);
end;

function TOchlstDat.LocCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindKey([pCusCrd]);
end;

function TOchlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOchlstDat.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindKey([pRegIno]);
end;

function TOchlstDat.LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindKey([pSpaNum,pWpaNum]);
end;

function TOchlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TOchlstDat.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindKey([pEndBva]);
end;

function TOchlstDat.LocDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindKey([pDepBva]);
end;

function TOchlstDat.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindKey([pPrjNum]);
end;

function TOchlstDat.LocPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindKey([pPrjCod]);
end;

function TOchlstDat.LocEdiUsr(pEdiUsr:Str8):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindKey([pEdiUsr]);
end;

function TOchlstDat.LocDstMod(pDstMod:Str1):boolean;
begin
  SetIndex(ixDstMod);
  Result:=oTable.FindKey([pDstMod]);
end;

function TOchlstDat.LocDocSource(pDocSource:Str10):boolean;
begin
  SetIndex(ixDocSource);
  Result:=oTable.FindKey([pDocSource]);
end;

function TOchlstDat.LocDocStatus(pDocStatus:Str10):boolean;
begin
  SetIndex(ixDocStatus);
  Result:=oTable.FindKey([pDocStatus]);
end;

function TOchlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOchlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TOchlstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TOchlstDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TOchlstDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TOchlstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TOchlstDat.NearReqDte(pReqDte:TDatetime):boolean;
begin
  SetIndex(ixReqDte);
  Result:=oTable.FindNearest([pReqDte]);
end;

function TOchlstDat.NearCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindNearest([pCusCrd]);
end;

function TOchlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOchlstDat.NearRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindNearest([pRegIno]);
end;

function TOchlstDat.NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindNearest([pSpaNum,pWpaNum]);
end;

function TOchlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TOchlstDat.NearEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindNearest([pEndBva]);
end;

function TOchlstDat.NearDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindNearest([pDepBva]);
end;

function TOchlstDat.NearPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindNearest([pPrjNum]);
end;

function TOchlstDat.NearPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindNearest([pPrjCod]);
end;

function TOchlstDat.NearEdiUsr(pEdiUsr:Str8):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindNearest([pEdiUsr]);
end;

function TOchlstDat.NearDstMod(pDstMod:Str1):boolean;
begin
  SetIndex(ixDstMod);
  Result:=oTable.FindNearest([pDstMod]);
end;

function TOchlstDat.NearDocSource(pDocSource:Str10):boolean;
begin
  SetIndex(ixDocSource);
  Result:=oTable.FindNearest([pDocSource]);
end;

function TOchlstDat.NearDocStatus(pDocStatus:Str10):boolean;
begin
  SetIndex(ixDocStatus);
  Result:=oTable.FindNearest([pDocStatus]);
end;

procedure TOchlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOchlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOchlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOchlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOchlstDat.Next;
begin
  oTable.Next;
end;

procedure TOchlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOchlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOchlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOchlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOchlstDat.Post;
begin
  oTable.Post;
end;

procedure TOchlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOchlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOchlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOchlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOchlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOchlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOchlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
