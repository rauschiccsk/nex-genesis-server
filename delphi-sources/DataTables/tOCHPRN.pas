unit tOCHPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TOchprnTmp=class(TComponent)
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
    function GetCusNum:Str20;            procedure SetCusNum (pValue:Str20);
    function GetPrjAdr:longint;          procedure SetPrjAdr (pValue:longint);
    function GetPrjCod:Str20;            procedure SetPrjCod (pValue:Str20);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetReqDte:TDatetime;        procedure SetReqDte (pValue:TDatetime);
    function GetReqTyp:Str1;             procedure SetReqTyp (pValue:Str1);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetVatDoc:byte;             procedure SetVatDoc (pValue:byte);
    function GetCusCrd:Str20;            procedure SetCusCrd (pValue:Str20);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetRegStn:Str30;            procedure SetRegStn (pValue:Str30);
    function GetRegCty:Str3;             procedure SetRegCty (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetRegTel:Str20;            procedure SetRegTel (pValue:Str20);
    function GetRegFax:Str20;            procedure SetRegFax (pValue:Str20);
    function GetRegEml:Str30;            procedure SetRegEml (pValue:Str30);
    function GetEmlSnd:byte;             procedure SetEmlSnd (pValue:byte);
    function GetSmsSnd:byte;             procedure SetSmsSnd (pValue:byte);
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum (pValue:word);
    function GetWpaNam:Str60;            procedure SetWpaNam (pValue:Str60);
    function GetWpaAdr:Str30;            procedure SetWpaAdr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaStn:Str30;            procedure SetWpaStn (pValue:Str30);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
    function GetPayCod:Str1;             procedure SetPayCod (pValue:Str1);
    function GetPayNam:Str20;            procedure SetPayNam (pValue:Str20);
    function GetTrsCod:Str1;             procedure SetTrsCod (pValue:Str1);
    function GetTrsNam:Str20;            procedure SetTrsNam (pValue:Str20);
    function GetTrsLin:word;             procedure SetTrsLin (pValue:word);
    function GetDlvCit:byte;             procedure SetDlvCit (pValue:byte);
    function GetDlvCdo:byte;             procedure SetDlvCdo (pValue:byte);
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
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetProAva:double;           procedure SetProAva (pValue:double);
    function GetSrvAva:double;           procedure SetSrvAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetVatVal:double;           procedure SetVatVal (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam (pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetDepPrc:double;           procedure SetDepPrc (pValue:double);
    function GetDepBva:double;           procedure SetDepBva (pValue:double);
    function GetDepDte:TDatetime;        procedure SetDepDte (pValue:TDatetime);
    function GetDepPay:Str1;             procedure SetDepPay (pValue:Str1);
    function GetDepCas:byte;             procedure SetDepCas (pValue:byte);
    function GetValClc:Str15;            procedure SetValClc (pValue:Str15);
    function GetResTyp:byte;             procedure SetResTyp (pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetReqPrq:double;           procedure SetReqPrq (pValue:double);
    function GetRstPrq:double;           procedure SetRstPrq (pValue:double);
    function GetRosPrq:double;           procedure SetRosPrq (pValue:double);
    function GetExdPrq:double;           procedure SetExdPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIcdPrq:double;           procedure SetIcdPrq (pValue:double);
    function GetDstErr:Str1;             procedure SetDstErr (pValue:Str1);
    function GetDstExd:Str1;             procedure SetDstExd (pValue:Str1);
    function GetDstLck:Str1;             procedure SetDstLck (pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls (pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq (pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum (pValue:Str13);
    function GetSrdDoq:byte;             procedure SetSrdDoq (pValue:byte);
    function GetMcdNum:Str13;            procedure SetMcdNum (pValue:Str13);
    function GetMcdDoq:byte;             procedure SetMcdDoq (pValue:byte);
    function GetTcdNum:Str13;            procedure SetTcdNum (pValue:Str13);
    function GetTcdDoq:byte;             procedure SetTcdDoq (pValue:byte);
    function GetTcdPrc:byte;             procedure SetTcdPrc (pValue:byte);
    function GetIcdNum:Str13;            procedure SetIcdNum (pValue:Str13);
    function GetIcdDoq:byte;             procedure SetIcdDoq (pValue:byte);
    function GetIcdPrc:byte;             procedure SetIcdPrc (pValue:byte);
    function GetEcdNum:Str13;            procedure SetEcdNum (pValue:Str13);
    function GetEcdDoq:byte;             procedure SetEcdDoq (pValue:byte);
    function GetPrnCnt:byte;             procedure SetPrnCnt (pValue:byte);
    function GetPrnUsr:word;             procedure SetPrnUsr (pValue:word);
    function GetPrnDte:TDatetime;        procedure SetPrnDte (pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes (pValue:Str50);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm (pValue:Str6);
    function GetNotice1:Str250;          procedure SetNotice1 (pValue:Str250);
    function GetNotice2:Str250;          procedure SetNotice2 (pValue:Str250);
    function GetNotice3:Str250;          procedure SetNotice3 (pValue:Str250);
    function GetNotice4:Str250;          procedure SetNotice4 (pValue:Str250);
    function GetNotice5:Str250;          procedure SetNotice5 (pValue:Str250);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;

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
    property CusNum:Str20 read GetCusNum write SetCusNum;
    property PrjAdr:longint read GetPrjAdr write SetPrjAdr;
    property PrjCod:Str20 read GetPrjCod write SetPrjCod;
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
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegStn:Str30 read GetRegStn write SetRegStn;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property RegTel:Str20 read GetRegTel write SetRegTel;
    property RegFax:Str20 read GetRegFax write SetRegFax;
    property RegEml:Str30 read GetRegEml write SetRegEml;
    property EmlSnd:byte read GetEmlSnd write SetEmlSnd;
    property SmsSnd:byte read GetSmsSnd write SetSmsSnd;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property WpaNum:word read GetWpaNum write SetWpaNum;
    property WpaNam:Str60 read GetWpaNam write SetWpaNam;
    property WpaAdr:Str30 read GetWpaAdr write SetWpaAdr;
    property WpaSta:Str2 read GetWpaSta write SetWpaSta;
    property WpaStn:Str30 read GetWpaStn write SetWpaStn;
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
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property DstErr:Str1 read GetDstErr write SetDstErr;
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
    property Notice1:Str250 read GetNotice1 write SetNotice1;
    property Notice2:Str250 read GetNotice2 write SetNotice2;
    property Notice3:Str250 read GetNotice3 write SetNotice3;
    property Notice4:Str250 read GetNotice4 write SetNotice4;
    property Notice5:Str250 read GetNotice5 write SetNotice5;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOchprnTmp.Create;
begin
  oTmpTable:=TmpInit ('OCHPRN',Self);
end;

destructor TOchprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOchprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOchprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOchprnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOchprnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOchprnTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOchprnTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOchprnTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TOchprnTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOchprnTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOchprnTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TOchprnTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TOchprnTmp.GetCusNum:Str20;
begin
  Result:=oTmpTable.FieldByName('CusNum').AsString;
end;

procedure TOchprnTmp.SetCusNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CusNum').AsString:=pValue;
end;

function TOchprnTmp.GetPrjAdr:longint;
begin
  Result:=oTmpTable.FieldByName('PrjAdr').AsInteger;
end;

procedure TOchprnTmp.SetPrjAdr(pValue:longint);
begin
  oTmpTable.FieldByName('PrjAdr').AsInteger:=pValue;
end;

function TOchprnTmp.GetPrjCod:Str20;
begin
  Result:=oTmpTable.FieldByName('PrjCod').AsString;
end;

procedure TOchprnTmp.SetPrjCod(pValue:Str20);
begin
  oTmpTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TOchprnTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOchprnTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOchprnTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOchprnTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetReqTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ReqTyp').AsString;
end;

procedure TOchprnTmp.SetReqTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ReqTyp').AsString:=pValue;
end;

function TOchprnTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOchprnTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOchprnTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOchprnTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TOchprnTmp.GetCusCrd:Str20;
begin
  Result:=oTmpTable.FieldByName('CusCrd').AsString;
end;

procedure TOchprnTmp.SetCusCrd(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TOchprnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOchprnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOchprnTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOchprnTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TOchprnTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TOchprnTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TOchprnTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TOchprnTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TOchprnTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TOchprnTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TOchprnTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TOchprnTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TOchprnTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TOchprnTmp.GetRegStn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TOchprnTmp.SetRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString:=pValue;
end;

function TOchprnTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TOchprnTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TOchprnTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TOchprnTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TOchprnTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TOchprnTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TOchprnTmp.GetRegTel:Str20;
begin
  Result:=oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TOchprnTmp.SetRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString:=pValue;
end;

function TOchprnTmp.GetRegFax:Str20;
begin
  Result:=oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TOchprnTmp.SetRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString:=pValue;
end;

function TOchprnTmp.GetRegEml:Str30;
begin
  Result:=oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TOchprnTmp.SetRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString:=pValue;
end;

function TOchprnTmp.GetEmlSnd:byte;
begin
  Result:=oTmpTable.FieldByName('EmlSnd').AsInteger;
end;

procedure TOchprnTmp.SetEmlSnd(pValue:byte);
begin
  oTmpTable.FieldByName('EmlSnd').AsInteger:=pValue;
end;

function TOchprnTmp.GetSmsSnd:byte;
begin
  Result:=oTmpTable.FieldByName('SmsSnd').AsInteger;
end;

procedure TOchprnTmp.SetSmsSnd(pValue:byte);
begin
  oTmpTable.FieldByName('SmsSnd').AsInteger:=pValue;
end;

function TOchprnTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TOchprnTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TOchprnTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetWpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaNam').AsString;
end;

procedure TOchprnTmp.SetWpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TOchprnTmp.GetWpaAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAdr').AsString;
end;

procedure TOchprnTmp.SetWpaAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TOchprnTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TOchprnTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TOchprnTmp.GetWpaStn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TOchprnTmp.SetWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString:=pValue;
end;

function TOchprnTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TOchprnTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TOchprnTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TOchprnTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TOchprnTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TOchprnTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TOchprnTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TOchprnTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TOchprnTmp.GetPayNam:Str20;
begin
  Result:=oTmpTable.FieldByName('PayNam').AsString;
end;

procedure TOchprnTmp.SetPayNam(pValue:Str20);
begin
  oTmpTable.FieldByName('PayNam').AsString:=pValue;
end;

function TOchprnTmp.GetTrsCod:Str1;
begin
  Result:=oTmpTable.FieldByName('TrsCod').AsString;
end;

procedure TOchprnTmp.SetTrsCod(pValue:Str1);
begin
  oTmpTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TOchprnTmp.GetTrsNam:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsNam').AsString;
end;

procedure TOchprnTmp.SetTrsNam(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TOchprnTmp.GetTrsLin:word;
begin
  Result:=oTmpTable.FieldByName('TrsLin').AsInteger;
end;

procedure TOchprnTmp.SetTrsLin(pValue:word);
begin
  oTmpTable.FieldByName('TrsLin').AsInteger:=pValue;
end;

function TOchprnTmp.GetDlvCit:byte;
begin
  Result:=oTmpTable.FieldByName('DlvCit').AsInteger;
end;

procedure TOchprnTmp.SetDlvCit(pValue:byte);
begin
  oTmpTable.FieldByName('DlvCit').AsInteger:=pValue;
end;

function TOchprnTmp.GetDlvCdo:byte;
begin
  Result:=oTmpTable.FieldByName('DlvCdo').AsInteger;
end;

procedure TOchprnTmp.SetDlvCdo(pValue:byte);
begin
  oTmpTable.FieldByName('DlvCdo').AsInteger:=pValue;
end;

function TOchprnTmp.GetRcvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('RcvTyp').AsString;
end;

procedure TOchprnTmp.SetRcvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TOchprnTmp.GetCrtUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOchprnTmp.SetCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOchprnTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TOchprnTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOchprnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOchprnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOchprnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOchprnTmp.GetMngUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('MngUsr').AsString;
end;

procedure TOchprnTmp.SetMngUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TOchprnTmp.GetMngUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('MngUsn').AsString;
end;

procedure TOchprnTmp.SetMngUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TOchprnTmp.GetMngDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('MngDte').AsDateTime;
end;

procedure TOchprnTmp.SetMngDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetEdiUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('EdiUsr').AsString;
end;

procedure TOchprnTmp.SetEdiUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TOchprnTmp.GetEdiDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TOchprnTmp.SetEdiDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetEdiTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TOchprnTmp.SetEdiTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TOchprnTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOchprnTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TOchprnTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOchprnTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOchprnTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOchprnTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOchprnTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TOchprnTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOchprnTmp.GetProAva:double;
begin
  Result:=oTmpTable.FieldByName('ProAva').AsFloat;
end;

procedure TOchprnTmp.SetProAva(pValue:double);
begin
  oTmpTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TOchprnTmp.GetSrvAva:double;
begin
  Result:=oTmpTable.FieldByName('SrvAva').AsFloat;
end;

procedure TOchprnTmp.SetSrvAva(pValue:double);
begin
  oTmpTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TOchprnTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOchprnTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOchprnTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TOchprnTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TOchprnTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TOchprnTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TOchprnTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TOchprnTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TOchprnTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TOchprnTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TOchprnTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOchprnTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOchprnTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOchprnTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOchprnTmp.GetDvzNam:Str3;
begin
  Result:=oTmpTable.FieldByName('DvzNam').AsString;
end;

procedure TOchprnTmp.SetDvzNam(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TOchprnTmp.GetDvzCrs:double;
begin
  Result:=oTmpTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TOchprnTmp.SetDvzCrs(pValue:double);
begin
  oTmpTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TOchprnTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOchprnTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOchprnTmp.GetDepPrc:double;
begin
  Result:=oTmpTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOchprnTmp.SetDepPrc(pValue:double);
begin
  oTmpTable.FieldByName('DepPrc').AsFloat:=pValue;
end;

function TOchprnTmp.GetDepBva:double;
begin
  Result:=oTmpTable.FieldByName('DepBva').AsFloat;
end;

procedure TOchprnTmp.SetDepBva(pValue:double);
begin
  oTmpTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TOchprnTmp.GetDepDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DepDte').AsDateTime;
end;

procedure TOchprnTmp.SetDepDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DepDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetDepPay:Str1;
begin
  Result:=oTmpTable.FieldByName('DepPay').AsString;
end;

procedure TOchprnTmp.SetDepPay(pValue:Str1);
begin
  oTmpTable.FieldByName('DepPay').AsString:=pValue;
end;

function TOchprnTmp.GetDepCas:byte;
begin
  Result:=oTmpTable.FieldByName('DepCas').AsInteger;
end;

procedure TOchprnTmp.SetDepCas(pValue:byte);
begin
  oTmpTable.FieldByName('DepCas').AsInteger:=pValue;
end;

function TOchprnTmp.GetValClc:Str15;
begin
  Result:=oTmpTable.FieldByName('ValClc').AsString;
end;

procedure TOchprnTmp.SetValClc(pValue:Str15);
begin
  oTmpTable.FieldByName('ValClc').AsString:=pValue;
end;

function TOchprnTmp.GetResTyp:byte;
begin
  Result:=oTmpTable.FieldByName('ResTyp').AsInteger;
end;

procedure TOchprnTmp.SetResTyp(pValue:byte);
begin
  oTmpTable.FieldByName('ResTyp').AsInteger:=pValue;
end;

function TOchprnTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOchprnTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetReqPrq:double;
begin
  Result:=oTmpTable.FieldByName('ReqPrq').AsFloat;
end;

procedure TOchprnTmp.SetReqPrq(pValue:double);
begin
  oTmpTable.FieldByName('ReqPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetRstPrq:double;
begin
  Result:=oTmpTable.FieldByName('RstPrq').AsFloat;
end;

procedure TOchprnTmp.SetRstPrq(pValue:double);
begin
  oTmpTable.FieldByName('RstPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetRosPrq:double;
begin
  Result:=oTmpTable.FieldByName('RosPrq').AsFloat;
end;

procedure TOchprnTmp.SetRosPrq(pValue:double);
begin
  oTmpTable.FieldByName('RosPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetExdPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExdPrq').AsFloat;
end;

procedure TOchprnTmp.SetExdPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExdPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOchprnTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOchprnTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TOchprnTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TOchprnTmp.GetDstErr:Str1;
begin
  Result:=oTmpTable.FieldByName('DstErr').AsString;
end;

procedure TOchprnTmp.SetDstErr(pValue:Str1);
begin
  oTmpTable.FieldByName('DstErr').AsString:=pValue;
end;

function TOchprnTmp.GetDstExd:Str1;
begin
  Result:=oTmpTable.FieldByName('DstExd').AsString;
end;

procedure TOchprnTmp.SetDstExd(pValue:Str1);
begin
  oTmpTable.FieldByName('DstExd').AsString:=pValue;
end;

function TOchprnTmp.GetDstLck:Str1;
begin
  Result:=oTmpTable.FieldByName('DstLck').AsString;
end;

procedure TOchprnTmp.SetDstLck(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLck').AsString:=pValue;
end;

function TOchprnTmp.GetDstCls:Str1;
begin
  Result:=oTmpTable.FieldByName('DstCls').AsString;
end;

procedure TOchprnTmp.SetDstCls(pValue:Str1);
begin
  oTmpTable.FieldByName('DstCls').AsString:=pValue;
end;

function TOchprnTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOchprnTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOchprnTmp.GetAtcDoq:byte;
begin
  Result:=oTmpTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TOchprnTmp.SetAtcDoq(pValue:byte);
begin
  oTmpTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TOchprnTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOchprnTmp.GetSrdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('SrdDoq').AsInteger;
end;

procedure TOchprnTmp.SetSrdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('SrdDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetMcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TOchprnTmp.SetMcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TOchprnTmp.GetMcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('McdDoq').AsInteger;
end;

procedure TOchprnTmp.SetMcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('McdDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOchprnTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOchprnTmp.GetTcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TcdDoq').AsInteger;
end;

procedure TOchprnTmp.SetTcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TcdDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetTcdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('TcdPrc').AsInteger;
end;

procedure TOchprnTmp.SetTcdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('TcdPrc').AsInteger:=pValue;
end;

function TOchprnTmp.GetIcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TOchprnTmp.SetIcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IcdNum').AsString:=pValue;
end;

function TOchprnTmp.GetIcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IcdDoq').AsInteger;
end;

procedure TOchprnTmp.SetIcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IcdDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetIcdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('IcdPrc').AsInteger;
end;

procedure TOchprnTmp.SetIcdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('IcdPrc').AsInteger:=pValue;
end;

function TOchprnTmp.GetEcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('EcdNum').AsString;
end;

procedure TOchprnTmp.SetEcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('EcdNum').AsString:=pValue;
end;

function TOchprnTmp.GetEcdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('EcdDoq').AsInteger;
end;

procedure TOchprnTmp.SetEcdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('EcdDoq').AsInteger:=pValue;
end;

function TOchprnTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOchprnTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TOchprnTmp.GetPrnUsr:word;
begin
  Result:=oTmpTable.FieldByName('PrnUsr').AsInteger;
end;

procedure TOchprnTmp.SetPrnUsr(pValue:word);
begin
  oTmpTable.FieldByName('PrnUsr').AsInteger:=pValue;
end;

function TOchprnTmp.GetPrnDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TOchprnTmp.SetPrnDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TOchprnTmp.GetDocDes:Str50;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TOchprnTmp.SetDocDes(pValue:Str50);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOchprnTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOchprnTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOchprnTmp.GetDocFrm:Str6;
begin
  Result:=oTmpTable.FieldByName('DocFrm').AsString;
end;

procedure TOchprnTmp.SetDocFrm(pValue:Str6);
begin
  oTmpTable.FieldByName('DocFrm').AsString:=pValue;
end;

function TOchprnTmp.GetNotice1:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TOchprnTmp.SetNotice1(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice1').AsString:=pValue;
end;

function TOchprnTmp.GetNotice2:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TOchprnTmp.SetNotice2(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice2').AsString:=pValue;
end;

function TOchprnTmp.GetNotice3:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TOchprnTmp.SetNotice3(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice3').AsString:=pValue;
end;

function TOchprnTmp.GetNotice4:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TOchprnTmp.SetNotice4(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice4').AsString:=pValue;
end;

function TOchprnTmp.GetNotice5:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TOchprnTmp.SetNotice5(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice5').AsString:=pValue;
end;

function TOchprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOchprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOchprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOchprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOchprnTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TOchprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOchprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOchprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOchprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOchprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOchprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TOchprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOchprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOchprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOchprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOchprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOchprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOchprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOchprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOchprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOchprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOchprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
