unit tOSHLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';
  ixBokNum='BokNum';
  ixDySn='DySn';
  ixDyBnSn='DyBnSn';
  ixExtNum='ExtNum';
  ixDocDte='DocDte';
  ixReqDte='ReqDte';
  ixParNum='ParNum';
  ixRegIno='RegIno';
  ixSnWn='SnWn';
  ixParNam_='ParNam_';
  ixEndBva='EndBva';
  ixDepBva='DepBva';
  ixPrjNum='PrjNum';
  ixPrjCod='PrjCod';

type
  TOshlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum (pValue:longint);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
    function GetPrjCod:Str20;            procedure SetPrjCod (pValue:Str20);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte (pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte (pValue:TDatetime);
    function GetReqTyp:Str1;             procedure SetReqTyp (pValue:Str1);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetVatDoc:byte;             procedure SetVatDoc (pValue:byte);
    function GetCusCrd:Str20;            procedure SetCusCrd (pValue:Str20);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetRegCty:Str3;             procedure SetRegCty (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetCtpNum:longint;          procedure SetCtpNum (pValue:longint);
    function GetCtpNam:Str30;            procedure SetCtpNam (pValue:Str30);
    function GetCtpTel:Str20;            procedure SetCtpTel (pValue:Str20);
    function GetCtpFax:Str20;            procedure SetCtpFax (pValue:Str20);
    function GetCtpEml:Str30;            procedure SetCtpEml (pValue:Str30);
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum (pValue:word);
    function GetWpaNam:Str60;            procedure SetWpaNam (pValue:Str60);
    function GetWpaAdr:Str30;            procedure SetWpaAdr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
    function GetPayNum:byte;             procedure SetPayNum (pValue:byte);
    function GetPayNam:Str20;            procedure SetPayNam (pValue:Str20);
    function GetTrsCod:Str5;             procedure SetTrsCod (pValue:Str5);
    function GetTrsNam:Str20;            procedure SetTrsNam (pValue:Str20);
    function GetComDlv:byte;             procedure SetComDlv (pValue:byte);
    function GetRcvTyp:Str1;             procedure SetRcvTyp (pValue:Str1);
    function GetCrtUsr:Str8;             procedure SetCrtUsr (pValue:Str8);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetMngUsr:Str8;             procedure SetMngUsr (pValue:Str8);
    function GetMngUsn:Str30;            procedure SetMngUsn (pValue:Str30);
    function GetMngDte:TDatetime;        procedure SetMngDte (pValue:TDatetime);
    function GetEdiUsr:Str8;             procedure SetEdiUsr (pValue:Str8);
    function GetEdiDte:TDatetime;        procedure SetEdiDte (pValue:TDatetime);
    function GetEdiTim:TDatetime;        procedure SetEdiTim (pValue:TDatetime);
    function GetItmQnt:word;             procedure SetItmQnt (pValue:word);
    function GetProVol:double;           procedure SetProVol (pValue:double);
    function GetProWgh:double;           procedure SetProWgh (pValue:double);
    function GetProAva:double;           procedure SetProAva (pValue:double);
    function GetSrvAva:double;           procedure SetSrvAva (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetVatVal:double;           procedure SetVatVal (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam (pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetDepPrc:double;           procedure SetDepPrc (pValue:double);
    function GetDepBva:double;           procedure SetDepBva (pValue:double);
    function GetDepDte:TDatetime;        procedure SetDepDte (pValue:TDatetime);
    function GetDepPay:Str1;             procedure SetDepPay (pValue:Str1);
    function GetValClc:Str15;            procedure SetValClc (pValue:Str15);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq (pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq (pValue:double);
    function GetDstErr:Str1;             procedure SetDstErr (pValue:Str1);
    function GetDstLck:Str1;             procedure SetDstLck (pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls (pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq (pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum (pValue:Str13);
    function GetSrdDoq:byte;             procedure SetSrdDoq (pValue:byte);
    function GetTsdNum:Str13;            procedure SetTsdNum (pValue:Str13);
    function GetTsdDoq:byte;             procedure SetTsdDoq (pValue:byte);
    function GetTsdPrc:byte;             procedure SetTsdPrc (pValue:byte);
    function GetIsdNum:Str13;            procedure SetIsdNum (pValue:Str13);
    function GetIsdDoq:byte;             procedure SetIsdDoq (pValue:byte);
    function GetIsdPrc:byte;             procedure SetIsdPrc (pValue:byte);
    function GetPrnCnt:byte;             procedure SetPrnCnt (pValue:byte);
    function GetPrnUsr:word;             procedure SetPrnUsr (pValue:word);
    function GetPrnDte:TDatetime;        procedure SetPrnDte (pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes (pValue:Str50);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm (pValue:Str6);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocBokNum (pBokNum:Str3):boolean;
    function LocDySn (pDocYer:Str2;pSerNum:longint):boolean;
    function LocDyBnSn (pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function LocExtNum (pExtNum:Str12):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocReqDte (pReqDte:TDatetime):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocRegIno (pRegIno:Str15):boolean;
    function LocSnWn (pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocEndBva (pEndBva:double):boolean;
    function LocDepBva (pDepBva:double):boolean;
    function LocPrjNum (pPrjNum:Str12):boolean;
    function LocPrjCod (pPrjCod:Str20):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:longint read GetSerNum write SetSerNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property PrjCod:Str20 read GetPrjCod write SetPrjCod;
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
    property PayNum:byte read GetPayNum write SetPayNum;
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
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property DstErr:Str1 read GetDstErr write SetDstErr;
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
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOshlstTmp.Create;
begin
  oTmpTable:=TmpInit ('OSHLST',Self);
end;

destructor TOshlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOshlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOshlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOshlstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOshlstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOshlstTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOshlstTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOshlstTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TOshlstTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOshlstTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOshlstTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TOshlstTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TOshlstTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TOshlstTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOshlstTmp.GetPrjCod:Str20;
begin
  Result:=oTmpTable.FieldByName('PrjCod').AsString;
end;

procedure TOshlstTmp.SetPrjCod(pValue:Str20);
begin
  oTmpTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TOshlstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOshlstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOshlstTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOshlstTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetSndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOshlstTmp.SetSndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetReqTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ReqTyp').AsString;
end;

procedure TOshlstTmp.SetReqTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ReqTyp').AsString:=pValue;
end;

function TOshlstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOshlstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOshlstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOshlstTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TOshlstTmp.GetCusCrd:Str20;
begin
  Result:=oTmpTable.FieldByName('CusCrd').AsString;
end;

procedure TOshlstTmp.SetCusCrd(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TOshlstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOshlstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOshlstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOshlstTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TOshlstTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOshlstTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TOshlstTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TOshlstTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TOshlstTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TOshlstTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TOshlstTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TOshlstTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TOshlstTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TOshlstTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TOshlstTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TOshlstTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TOshlstTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TOshlstTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TOshlstTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TOshlstTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TOshlstTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TOshlstTmp.GetCtpNum:longint;
begin
  Result:=oTmpTable.FieldByName('CtpNum').AsInteger;
end;

procedure TOshlstTmp.SetCtpNum(pValue:longint);
begin
  oTmpTable.FieldByName('CtpNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetCtpNam:Str30;
begin
  Result:=oTmpTable.FieldByName('CtpNam').AsString;
end;

procedure TOshlstTmp.SetCtpNam(pValue:Str30);
begin
  oTmpTable.FieldByName('CtpNam').AsString:=pValue;
end;

function TOshlstTmp.GetCtpTel:Str20;
begin
  Result:=oTmpTable.FieldByName('CtpTel').AsString;
end;

procedure TOshlstTmp.SetCtpTel(pValue:Str20);
begin
  oTmpTable.FieldByName('CtpTel').AsString:=pValue;
end;

function TOshlstTmp.GetCtpFax:Str20;
begin
  Result:=oTmpTable.FieldByName('CtpFax').AsString;
end;

procedure TOshlstTmp.SetCtpFax(pValue:Str20);
begin
  oTmpTable.FieldByName('CtpFax').AsString:=pValue;
end;

function TOshlstTmp.GetCtpEml:Str30;
begin
  Result:=oTmpTable.FieldByName('CtpEml').AsString;
end;

procedure TOshlstTmp.SetCtpEml(pValue:Str30);
begin
  oTmpTable.FieldByName('CtpEml').AsString:=pValue;
end;

function TOshlstTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TOshlstTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TOshlstTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetWpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaNam').AsString;
end;

procedure TOshlstTmp.SetWpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TOshlstTmp.GetWpaAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAdr').AsString;
end;

procedure TOshlstTmp.SetWpaAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TOshlstTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TOshlstTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TOshlstTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TOshlstTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TOshlstTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TOshlstTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TOshlstTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TOshlstTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TOshlstTmp.GetPayNum:byte;
begin
  Result:=oTmpTable.FieldByName('PayNum').AsInteger;
end;

procedure TOshlstTmp.SetPayNum(pValue:byte);
begin
  oTmpTable.FieldByName('PayNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetPayNam:Str20;
begin
  Result:=oTmpTable.FieldByName('PayNam').AsString;
end;

procedure TOshlstTmp.SetPayNam(pValue:Str20);
begin
  oTmpTable.FieldByName('PayNam').AsString:=pValue;
end;

function TOshlstTmp.GetTrsCod:Str5;
begin
  Result:=oTmpTable.FieldByName('TrsCod').AsString;
end;

procedure TOshlstTmp.SetTrsCod(pValue:Str5);
begin
  oTmpTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TOshlstTmp.GetTrsNam:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsNam').AsString;
end;

procedure TOshlstTmp.SetTrsNam(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TOshlstTmp.GetComDlv:byte;
begin
  Result:=oTmpTable.FieldByName('ComDlv').AsInteger;
end;

procedure TOshlstTmp.SetComDlv(pValue:byte);
begin
  oTmpTable.FieldByName('ComDlv').AsInteger:=pValue;
end;

function TOshlstTmp.GetRcvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('RcvTyp').AsString;
end;

procedure TOshlstTmp.SetRcvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TOshlstTmp.GetCrtUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOshlstTmp.SetCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOshlstTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TOshlstTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOshlstTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOshlstTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOshlstTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOshlstTmp.GetMngUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('MngUsr').AsString;
end;

procedure TOshlstTmp.SetMngUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TOshlstTmp.GetMngUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('MngUsn').AsString;
end;

procedure TOshlstTmp.SetMngUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TOshlstTmp.GetMngDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('MngDte').AsDateTime;
end;

procedure TOshlstTmp.SetMngDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetEdiUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('EdiUsr').AsString;
end;

procedure TOshlstTmp.SetEdiUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TOshlstTmp.GetEdiDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TOshlstTmp.SetEdiDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetEdiTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TOshlstTmp.SetEdiTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TOshlstTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOshlstTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TOshlstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOshlstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOshlstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOshlstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOshlstTmp.GetProAva:double;
begin
  Result:=oTmpTable.FieldByName('ProAva').AsFloat;
end;

procedure TOshlstTmp.SetProAva(pValue:double);
begin
  oTmpTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TOshlstTmp.GetSrvAva:double;
begin
  Result:=oTmpTable.FieldByName('SrvAva').AsFloat;
end;

procedure TOshlstTmp.SetSrvAva(pValue:double);
begin
  oTmpTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TOshlstTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOshlstTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOshlstTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TOshlstTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TOshlstTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOshlstTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOshlstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOshlstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOshlstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOshlstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOshlstTmp.GetDvzNam:Str3;
begin
  Result:=oTmpTable.FieldByName('DvzNam').AsString;
end;

procedure TOshlstTmp.SetDvzNam(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TOshlstTmp.GetDvzCrs:double;
begin
  Result:=oTmpTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TOshlstTmp.SetDvzCrs(pValue:double);
begin
  oTmpTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TOshlstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOshlstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOshlstTmp.GetDepPrc:double;
begin
  Result:=oTmpTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOshlstTmp.SetDepPrc(pValue:double);
begin
  oTmpTable.FieldByName('DepPrc').AsFloat:=pValue;
end;

function TOshlstTmp.GetDepBva:double;
begin
  Result:=oTmpTable.FieldByName('DepBva').AsFloat;
end;

procedure TOshlstTmp.SetDepBva(pValue:double);
begin
  oTmpTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TOshlstTmp.GetDepDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DepDte').AsDateTime;
end;

procedure TOshlstTmp.SetDepDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DepDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetDepPay:Str1;
begin
  Result:=oTmpTable.FieldByName('DepPay').AsString;
end;

procedure TOshlstTmp.SetDepPay(pValue:Str1);
begin
  oTmpTable.FieldByName('DepPay').AsString:=pValue;
end;

function TOshlstTmp.GetValClc:Str15;
begin
  Result:=oTmpTable.FieldByName('ValClc').AsString;
end;

procedure TOshlstTmp.SetValClc(pValue:Str15);
begin
  oTmpTable.FieldByName('ValClc').AsString:=pValue;
end;

function TOshlstTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOshlstTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOshlstTmp.GetRocPrq:double;
begin
  Result:=oTmpTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOshlstTmp.SetRocPrq(pValue:double);
begin
  oTmpTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOshlstTmp.GetTsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOshlstTmp.SetTsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOshlstTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOshlstTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOshlstTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOshlstTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOshlstTmp.GetDstErr:Str1;
begin
  Result:=oTmpTable.FieldByName('DstErr').AsString;
end;

procedure TOshlstTmp.SetDstErr(pValue:Str1);
begin
  oTmpTable.FieldByName('DstErr').AsString:=pValue;
end;

function TOshlstTmp.GetDstLck:Str1;
begin
  Result:=oTmpTable.FieldByName('DstLck').AsString;
end;

procedure TOshlstTmp.SetDstLck(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLck').AsString:=pValue;
end;

function TOshlstTmp.GetDstCls:Str1;
begin
  Result:=oTmpTable.FieldByName('DstCls').AsString;
end;

procedure TOshlstTmp.SetDstCls(pValue:Str1);
begin
  oTmpTable.FieldByName('DstCls').AsString:=pValue;
end;

function TOshlstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOshlstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOshlstTmp.GetAtcDoq:byte;
begin
  Result:=oTmpTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TOshlstTmp.SetAtcDoq(pValue:byte);
begin
  oTmpTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TOshlstTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TOshlstTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOshlstTmp.GetSrdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('SrdDoq').AsInteger;
end;

procedure TOshlstTmp.SetSrdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('SrdDoq').AsInteger:=pValue;
end;

function TOshlstTmp.GetTsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOshlstTmp.SetTsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOshlstTmp.GetTsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOshlstTmp.SetTsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOshlstTmp.GetTsdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('TsdPrc').AsInteger;
end;

procedure TOshlstTmp.SetTsdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('TsdPrc').AsInteger:=pValue;
end;

function TOshlstTmp.GetIsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TOshlstTmp.SetIsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOshlstTmp.GetIsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOshlstTmp.SetIsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOshlstTmp.GetIsdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('IsdPrc').AsInteger;
end;

procedure TOshlstTmp.SetIsdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('IsdPrc').AsInteger:=pValue;
end;

function TOshlstTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOshlstTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TOshlstTmp.GetPrnUsr:word;
begin
  Result:=oTmpTable.FieldByName('PrnUsr').AsInteger;
end;

procedure TOshlstTmp.SetPrnUsr(pValue:word);
begin
  oTmpTable.FieldByName('PrnUsr').AsInteger:=pValue;
end;

function TOshlstTmp.GetPrnDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TOshlstTmp.SetPrnDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TOshlstTmp.GetDocDes:Str50;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TOshlstTmp.SetDocDes(pValue:Str50);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOshlstTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOshlstTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOshlstTmp.GetDocFrm:Str6;
begin
  Result:=oTmpTable.FieldByName('DocFrm').AsString;
end;

procedure TOshlstTmp.SetDocFrm(pValue:Str6);
begin
  oTmpTable.FieldByName('DocFrm').AsString:=pValue;
end;

function TOshlstTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOshlstTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOshlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOshlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOshlstTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TOshlstTmp.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex (ixBokNum);
  Result:=oTmpTable.FindKey([pBokNum]);
end;

function TOshlstTmp.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixDySn);
  Result:=oTmpTable.FindKey([pDocYer,pSerNum]);
end;

function TOshlstTmp.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex (ixDyBnSn);
  Result:=oTmpTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TOshlstTmp.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result:=oTmpTable.FindKey([pExtNum]);
end;

function TOshlstTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TOshlstTmp.LocReqDte(pReqDte:TDatetime):boolean;
begin
  SetIndex (ixReqDte);
  Result:=oTmpTable.FindKey([pReqDte]);
end;

function TOshlstTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TOshlstTmp.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result:=oTmpTable.FindKey([pRegIno]);
end;

function TOshlstTmp.LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex (ixSnWn);
  Result:=oTmpTable.FindKey([pSpaNum,pWpaNum]);
end;

function TOshlstTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TOshlstTmp.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex (ixEndBva);
  Result:=oTmpTable.FindKey([pEndBva]);
end;

function TOshlstTmp.LocDepBva(pDepBva:double):boolean;
begin
  SetIndex (ixDepBva);
  Result:=oTmpTable.FindKey([pDepBva]);
end;

function TOshlstTmp.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex (ixPrjNum);
  Result:=oTmpTable.FindKey([pPrjNum]);
end;

function TOshlstTmp.LocPrjCod(pPrjCod:Str20):boolean;
begin
  SetIndex (ixPrjCod);
  Result:=oTmpTable.FindKey([pPrjCod]);
end;

procedure TOshlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOshlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOshlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOshlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOshlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOshlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TOshlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOshlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOshlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOshlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOshlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOshlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOshlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOshlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOshlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOshlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOshlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
