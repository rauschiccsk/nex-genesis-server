unit tOSHPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TOshprnTmp=class(TComponent)
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
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetVatVal:double;           procedure SetVatVal (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam (pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetValClc:Str15;            procedure SetValClc (pValue:Str15);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
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
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property VatVal:double read GetVatVal write SetVatVal;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DvzCrs:double read GetDvzCrs write SetDvzCrs;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ValClc:Str15 read GetValClc write SetValClc;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
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
    property DocFrm:Str6 read GetDocFrm write SetDocFrm;
    property Notice1:Str250 read GetNotice1 write SetNotice1;
    property Notice2:Str250 read GetNotice2 write SetNotice2;
    property Notice3:Str250 read GetNotice3 write SetNotice3;
    property Notice4:Str250 read GetNotice4 write SetNotice4;
    property Notice5:Str250 read GetNotice5 write SetNotice5;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOshprnTmp.Create;
begin
  oTmpTable:=TmpInit ('OSHPRN',Self);
end;

destructor TOshprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOshprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOshprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOshprnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOshprnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOshprnTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOshprnTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOshprnTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TOshprnTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOshprnTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOshprnTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TOshprnTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TOshprnTmp.GetCusNum:Str20;
begin
  Result:=oTmpTable.FieldByName('CusNum').AsString;
end;

procedure TOshprnTmp.SetCusNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CusNum').AsString:=pValue;
end;

function TOshprnTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TOshprnTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TOshprnTmp.GetPrjCod:Str20;
begin
  Result:=oTmpTable.FieldByName('PrjCod').AsString;
end;

procedure TOshprnTmp.SetPrjCod(pValue:Str20);
begin
  oTmpTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TOshprnTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOshprnTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TOshprnTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOshprnTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetSndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOshprnTmp.SetSndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetReqTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ReqTyp').AsString;
end;

procedure TOshprnTmp.SetReqTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ReqTyp').AsString:=pValue;
end;

function TOshprnTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOshprnTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOshprnTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOshprnTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TOshprnTmp.GetCusCrd:Str20;
begin
  Result:=oTmpTable.FieldByName('CusCrd').AsString;
end;

procedure TOshprnTmp.SetCusCrd(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TOshprnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOshprnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOshprnTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOshprnTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TOshprnTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TOshprnTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TOshprnTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TOshprnTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TOshprnTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TOshprnTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TOshprnTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TOshprnTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TOshprnTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TOshprnTmp.GetRegStn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TOshprnTmp.SetRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString:=pValue;
end;

function TOshprnTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TOshprnTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TOshprnTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TOshprnTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TOshprnTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TOshprnTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TOshprnTmp.GetRegTel:Str20;
begin
  Result:=oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TOshprnTmp.SetRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString:=pValue;
end;

function TOshprnTmp.GetRegFax:Str20;
begin
  Result:=oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TOshprnTmp.SetRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString:=pValue;
end;

function TOshprnTmp.GetRegEml:Str30;
begin
  Result:=oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TOshprnTmp.SetRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString:=pValue;
end;

function TOshprnTmp.GetEmlSnd:byte;
begin
  Result:=oTmpTable.FieldByName('EmlSnd').AsInteger;
end;

procedure TOshprnTmp.SetEmlSnd(pValue:byte);
begin
  oTmpTable.FieldByName('EmlSnd').AsInteger:=pValue;
end;

function TOshprnTmp.GetSmsSnd:byte;
begin
  Result:=oTmpTable.FieldByName('SmsSnd').AsInteger;
end;

procedure TOshprnTmp.SetSmsSnd(pValue:byte);
begin
  oTmpTable.FieldByName('SmsSnd').AsInteger:=pValue;
end;

function TOshprnTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TOshprnTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TOshprnTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TOshprnTmp.GetWpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaNam').AsString;
end;

procedure TOshprnTmp.SetWpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TOshprnTmp.GetWpaAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAdr').AsString;
end;

procedure TOshprnTmp.SetWpaAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TOshprnTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TOshprnTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TOshprnTmp.GetWpaStn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TOshprnTmp.SetWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString:=pValue;
end;

function TOshprnTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TOshprnTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TOshprnTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TOshprnTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TOshprnTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TOshprnTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TOshprnTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TOshprnTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TOshprnTmp.GetPayNam:Str20;
begin
  Result:=oTmpTable.FieldByName('PayNam').AsString;
end;

procedure TOshprnTmp.SetPayNam(pValue:Str20);
begin
  oTmpTable.FieldByName('PayNam').AsString:=pValue;
end;

function TOshprnTmp.GetTrsCod:Str1;
begin
  Result:=oTmpTable.FieldByName('TrsCod').AsString;
end;

procedure TOshprnTmp.SetTrsCod(pValue:Str1);
begin
  oTmpTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TOshprnTmp.GetTrsNam:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsNam').AsString;
end;

procedure TOshprnTmp.SetTrsNam(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TOshprnTmp.GetTrsLin:word;
begin
  Result:=oTmpTable.FieldByName('TrsLin').AsInteger;
end;

procedure TOshprnTmp.SetTrsLin(pValue:word);
begin
  oTmpTable.FieldByName('TrsLin').AsInteger:=pValue;
end;

function TOshprnTmp.GetDlvCit:byte;
begin
  Result:=oTmpTable.FieldByName('DlvCit').AsInteger;
end;

procedure TOshprnTmp.SetDlvCit(pValue:byte);
begin
  oTmpTable.FieldByName('DlvCit').AsInteger:=pValue;
end;

function TOshprnTmp.GetDlvCdo:byte;
begin
  Result:=oTmpTable.FieldByName('DlvCdo').AsInteger;
end;

procedure TOshprnTmp.SetDlvCdo(pValue:byte);
begin
  oTmpTable.FieldByName('DlvCdo').AsInteger:=pValue;
end;

function TOshprnTmp.GetRcvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('RcvTyp').AsString;
end;

procedure TOshprnTmp.SetRcvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('RcvTyp').AsString:=pValue;
end;

function TOshprnTmp.GetCrtUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TOshprnTmp.SetCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOshprnTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TOshprnTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOshprnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOshprnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOshprnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOshprnTmp.GetMngUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('MngUsr').AsString;
end;

procedure TOshprnTmp.SetMngUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TOshprnTmp.GetMngUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('MngUsn').AsString;
end;

procedure TOshprnTmp.SetMngUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TOshprnTmp.GetMngDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('MngDte').AsDateTime;
end;

procedure TOshprnTmp.SetMngDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetEdiUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('EdiUsr').AsString;
end;

procedure TOshprnTmp.SetEdiUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TOshprnTmp.GetEdiDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TOshprnTmp.SetEdiDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetEdiTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TOshprnTmp.SetEdiTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TOshprnTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOshprnTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TOshprnTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOshprnTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOshprnTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOshprnTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOshprnTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TOshprnTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TOshprnTmp.GetProAva:double;
begin
  Result:=oTmpTable.FieldByName('ProAva').AsFloat;
end;

procedure TOshprnTmp.SetProAva(pValue:double);
begin
  oTmpTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TOshprnTmp.GetSrvAva:double;
begin
  Result:=oTmpTable.FieldByName('SrvAva').AsFloat;
end;

procedure TOshprnTmp.SetSrvAva(pValue:double);
begin
  oTmpTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TOshprnTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOshprnTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TOshprnTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TOshprnTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TOshprnTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOshprnTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOshprnTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TOshprnTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TOshprnTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOshprnTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOshprnTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOshprnTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOshprnTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOshprnTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOshprnTmp.GetDvzNam:Str3;
begin
  Result:=oTmpTable.FieldByName('DvzNam').AsString;
end;

procedure TOshprnTmp.SetDvzNam(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TOshprnTmp.GetDvzCrs:double;
begin
  Result:=oTmpTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TOshprnTmp.SetDvzCrs(pValue:double);
begin
  oTmpTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TOshprnTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOshprnTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOshprnTmp.GetValClc:Str15;
begin
  Result:=oTmpTable.FieldByName('ValClc').AsString;
end;

procedure TOshprnTmp.SetValClc(pValue:Str15);
begin
  oTmpTable.FieldByName('ValClc').AsString:=pValue;
end;

function TOshprnTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOshprnTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOshprnTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOshprnTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOshprnTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOshprnTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOshprnTmp.GetDstErr:Str1;
begin
  Result:=oTmpTable.FieldByName('DstErr').AsString;
end;

procedure TOshprnTmp.SetDstErr(pValue:Str1);
begin
  oTmpTable.FieldByName('DstErr').AsString:=pValue;
end;

function TOshprnTmp.GetDstLck:Str1;
begin
  Result:=oTmpTable.FieldByName('DstLck').AsString;
end;

procedure TOshprnTmp.SetDstLck(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLck').AsString:=pValue;
end;

function TOshprnTmp.GetDstCls:Str1;
begin
  Result:=oTmpTable.FieldByName('DstCls').AsString;
end;

procedure TOshprnTmp.SetDstCls(pValue:Str1);
begin
  oTmpTable.FieldByName('DstCls').AsString:=pValue;
end;

function TOshprnTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TOshprnTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TOshprnTmp.GetAtcDoq:byte;
begin
  Result:=oTmpTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TOshprnTmp.SetAtcDoq(pValue:byte);
begin
  oTmpTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TOshprnTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TOshprnTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TOshprnTmp.GetSrdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('SrdDoq').AsInteger;
end;

procedure TOshprnTmp.SetSrdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('SrdDoq').AsInteger:=pValue;
end;

function TOshprnTmp.GetTsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOshprnTmp.SetTsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOshprnTmp.GetTsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('TsdDoq').AsInteger;
end;

procedure TOshprnTmp.SetTsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('TsdDoq').AsInteger:=pValue;
end;

function TOshprnTmp.GetTsdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('TsdPrc').AsInteger;
end;

procedure TOshprnTmp.SetTsdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('TsdPrc').AsInteger:=pValue;
end;

function TOshprnTmp.GetIsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TOshprnTmp.SetIsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('IsdNum').AsString:=pValue;
end;

function TOshprnTmp.GetIsdDoq:byte;
begin
  Result:=oTmpTable.FieldByName('IsdDoq').AsInteger;
end;

procedure TOshprnTmp.SetIsdDoq(pValue:byte);
begin
  oTmpTable.FieldByName('IsdDoq').AsInteger:=pValue;
end;

function TOshprnTmp.GetIsdPrc:byte;
begin
  Result:=oTmpTable.FieldByName('IsdPrc').AsInteger;
end;

procedure TOshprnTmp.SetIsdPrc(pValue:byte);
begin
  oTmpTable.FieldByName('IsdPrc').AsInteger:=pValue;
end;

function TOshprnTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOshprnTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TOshprnTmp.GetPrnUsr:word;
begin
  Result:=oTmpTable.FieldByName('PrnUsr').AsInteger;
end;

procedure TOshprnTmp.SetPrnUsr(pValue:word);
begin
  oTmpTable.FieldByName('PrnUsr').AsInteger:=pValue;
end;

function TOshprnTmp.GetPrnDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TOshprnTmp.SetPrnDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TOshprnTmp.GetDocDes:Str50;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TOshprnTmp.SetDocDes(pValue:Str50);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOshprnTmp.GetDocFrm:Str6;
begin
  Result:=oTmpTable.FieldByName('DocFrm').AsString;
end;

procedure TOshprnTmp.SetDocFrm(pValue:Str6);
begin
  oTmpTable.FieldByName('DocFrm').AsString:=pValue;
end;

function TOshprnTmp.GetNotice1:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TOshprnTmp.SetNotice1(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice1').AsString:=pValue;
end;

function TOshprnTmp.GetNotice2:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TOshprnTmp.SetNotice2(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice2').AsString:=pValue;
end;

function TOshprnTmp.GetNotice3:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TOshprnTmp.SetNotice3(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice3').AsString:=pValue;
end;

function TOshprnTmp.GetNotice4:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TOshprnTmp.SetNotice4(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice4').AsString:=pValue;
end;

function TOshprnTmp.GetNotice5:Str250;
begin
  Result:=oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TOshprnTmp.SetNotice5(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice5').AsString:=pValue;
end;

function TOshprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOshprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOshprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOshprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOshprnTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TOshprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOshprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOshprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOshprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOshprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOshprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TOshprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOshprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOshprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOshprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOshprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOshprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOshprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOshprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOshprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOshprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOshprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
