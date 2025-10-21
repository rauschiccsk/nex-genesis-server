unit tICDLST;

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
  ixCusCrd='CusCrd';
  ixParNum='ParNum';
  ixRegIno='RegIno';
  ixSnWn='SnWn';
  ixParNam_='ParNam_';
  ixEndBva='EndBva';
  ixDepBva='DepBva';
  ixPrjNum='PrjNum';
  ixPrjCod='PrjCod';
  ixDlrNum='DlrNum';
  ixEdiUsr='EdiUsr';
  ixDstAcc='DstAcc';
  ixIccDoc='IccDoc';
  ixDstPay='DstPay';
  ixPaDp='PaDp';
  ixSpcMrk='SpcMrk';

type
  TIcdlstTmp=class(TComponent)
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
    function GetOcdNum:Str13;            procedure SetOcdNum (pValue:Str13);
    function GetOceNum:Str20;            procedure SetOceNum (pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
    function GetPrjCod:Str30;            procedure SetPrjCod (pValue:Str30);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte (pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte (pValue:TDatetime);
    function GetVatDte:TDatetime;        procedure SetVatDte (pValue:TDatetime);
    function GetPayDte:TDatetime;        procedure SetPayDte (pValue:TDatetime);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetConSym:Str4;             procedure SetConSym (pValue:Str4);
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
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum (pValue:word);
    function GetWpaNam:Str60;            procedure SetWpaNam (pValue:Str60);
    function GetWpaAdr:Str30;            procedure SetWpaAdr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
    function GetPayCod:Str1;             procedure SetPayCod (pValue:Str1);
    function GetPayNam:Str20;            procedure SetPayNam (pValue:Str20);
    function GetTrsCod:Str1;             procedure SetTrsCod (pValue:Str1);
    function GetTrsNam:Str20;            procedure SetTrsNam (pValue:Str20);
    function GetVatDoc:byte;             procedure SetVatDoc (pValue:byte);
    function GetVatCls:byte;             procedure SetVatCls (pValue:byte);
    function GetDocSpc:byte;             procedure SetDocSpc (pValue:byte);
    function GetCrtUsr:Str15;            procedure SetCrtUsr (pValue:Str15);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetMngUsr:Str15;            procedure SetMngUsr (pValue:Str15);
    function GetMngUsn:Str30;            procedure SetMngUsn (pValue:Str30);
    function GetMngDte:TDatetime;        procedure SetMngDte (pValue:TDatetime);
    function GetEdiUsr:Str15;            procedure SetEdiUsr (pValue:Str15);
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
    function GetPayVal:double;           procedure SetPayVal (pValue:double);
    function GetEndVal:double;           procedure SetEndVal (pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam (pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetDepBva:double;           procedure SetDepBva (pValue:double);
    function GetValClc:Str15;            procedure SetValClc (pValue:Str15);
    function GetIcdPrq:double;           procedure SetIcdPrq (pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetDstLck:Str1;             procedure SetDstLck (pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls (pValue:Str1);
    function GetDstAcc:Str1;             procedure SetDstAcc (pValue:Str1);
    function GetDstPay:Str1;             procedure SetDstPay (pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq (pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum (pValue:Str13);
    function GetMcdNum:Str13;            procedure SetMcdNum (pValue:Str13);
    function GetTcdNum:Str13;            procedure SetTcdNum (pValue:Str13);
    function GetPrnCnt:byte;             procedure SetPrnCnt (pValue:byte);
    function GetPrnUsr:Str15;            procedure SetPrnUsr (pValue:Str15);
    function GetPrnDte:TDatetime;        procedure SetPrnDte (pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim (pValue:TDatetime);
    function GetEmlCnt:byte;             procedure SetEmlCnt (pValue:byte);
    function GetEmlUsr:Str15;            procedure SetEmlUsr (pValue:Str15);
    function GetEmlDte:TDatetime;        procedure SetEmlDte (pValue:TDatetime);
    function GetEmlTim:TDatetime;        procedure SetEmlTim (pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes (pValue:Str50);
    function GetVatDis:byte;             procedure SetVatDis (pValue:byte);
    function GetDocSnt:Str3;             procedure SetDocSnt (pValue:Str3);
    function GetDocAnl:Str6;             procedure SetDocAnl (pValue:Str6);
    function GetWarNum:byte;             procedure SetWarNum (pValue:byte);
    function GetWarDte:TDatetime;        procedure SetWarDte (pValue:TDatetime);
    function GetIccDoc:Str12;            procedure SetIccDoc (pValue:Str12);
    function GetIccExd:Str12;            procedure SetIccExd (pValue:Str12);
    function GetCsgNum:Str15;            procedure SetCsgNum (pValue:Str15);
    function GetDlrNum:longint;          procedure SetDlrNum (pValue:longint);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm (pValue:Str6);
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
    function LocCusCrd (pCusCrd:Str20):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocRegIno (pRegIno:Str15):boolean;
    function LocSnWn (pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocEndBva (pEndBva:double):boolean;
    function LocDepBva (pDepBva:double):boolean;
    function LocPrjNum (pPrjNum:Str12):boolean;
    function LocPrjCod (pPrjCod:Str30):boolean;
    function LocDlrNum (pDlrNum:longint):boolean;
    function LocEdiUsr (pEdiUsr:Str15):boolean;
    function LocDstAcc (pDstAcc:Str1):boolean;
    function LocIccDoc (pIccDoc:Str12):boolean;
    function LocDstPay (pDstPay:Str1):boolean;
    function LocPaDp (pParNum:longint;pDstPay:Str1):boolean;
    function LocSpcMrk (pSpcMrk:Str10):boolean;

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
    property OcdNum:Str13 read GetOcdNum write SetOcdNum;
    property OceNum:Str20 read GetOceNum write SetOceNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property PrjCod:Str30 read GetPrjCod write SetPrjCod;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property VatDte:TDatetime read GetVatDte write SetVatDte;
    property PayDte:TDatetime read GetPayDte write SetPayDte;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ConSym:Str4 read GetConSym write SetConSym;
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
    property VatDoc:byte read GetVatDoc write SetVatDoc;
    property VatCls:byte read GetVatCls write SetVatCls;
    property DocSpc:byte read GetDocSpc write SetDocSpc;
    property CrtUsr:Str15 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property MngUsr:Str15 read GetMngUsr write SetMngUsr;
    property MngUsn:Str30 read GetMngUsn write SetMngUsn;
    property MngDte:TDatetime read GetMngDte write SetMngDte;
    property EdiUsr:Str15 read GetEdiUsr write SetEdiUsr;
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
    property PayVal:double read GetPayVal write SetPayVal;
    property EndVal:double read GetEndVal write SetEndVal;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DvzCrs:double read GetDvzCrs write SetDvzCrs;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property DepBva:double read GetDepBva write SetDepBva;
    property ValClc:Str15 read GetValClc write SetValClc;
    property IcdPrq:double read GetIcdPrq write SetIcdPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property DstLck:Str1 read GetDstLck write SetDstLck;
    property DstCls:Str1 read GetDstCls write SetDstCls;
    property DstAcc:Str1 read GetDstAcc write SetDstAcc;
    property DstPay:Str1 read GetDstPay write SetDstPay;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property AtcDoq:byte read GetAtcDoq write SetAtcDoq;
    property SrdNum:Str13 read GetSrdNum write SetSrdNum;
    property McdNum:Str13 read GetMcdNum write SetMcdNum;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property PrnUsr:Str15 read GetPrnUsr write SetPrnUsr;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property PrnTim:TDatetime read GetPrnTim write SetPrnTim;
    property EmlCnt:byte read GetEmlCnt write SetEmlCnt;
    property EmlUsr:Str15 read GetEmlUsr write SetEmlUsr;
    property EmlDte:TDatetime read GetEmlDte write SetEmlDte;
    property EmlTim:TDatetime read GetEmlTim write SetEmlTim;
    property DocDes:Str50 read GetDocDes write SetDocDes;
    property VatDis:byte read GetVatDis write SetVatDis;
    property DocSnt:Str3 read GetDocSnt write SetDocSnt;
    property DocAnl:Str6 read GetDocAnl write SetDocAnl;
    property WarNum:byte read GetWarNum write SetWarNum;
    property WarDte:TDatetime read GetWarDte write SetWarDte;
    property IccDoc:Str12 read GetIccDoc write SetIccDoc;
    property IccExd:Str12 read GetIccExd write SetIccExd;
    property CsgNum:Str15 read GetCsgNum write SetCsgNum;
    property DlrNum:longint read GetDlrNum write SetDlrNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocFrm:Str6 read GetDocFrm write SetDocFrm;
  end;

implementation

constructor TIcdlstTmp.Create;
begin
  oTmpTable:=TmpInit ('ICDLST',Self);
end;

destructor TIcdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIcdlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIcdlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIcdlstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIcdlstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIcdlstTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TIcdlstTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIcdlstTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TIcdlstTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TIcdlstTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TIcdlstTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIcdlstTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TIcdlstTmp.GetOcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TIcdlstTmp.SetOcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TIcdlstTmp.GetOceNum:Str20;
begin
  Result:=oTmpTable.FieldByName('OceNum').AsString;
end;

procedure TIcdlstTmp.SetOceNum(pValue:Str20);
begin
  oTmpTable.FieldByName('OceNum').AsString:=pValue;
end;

function TIcdlstTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TIcdlstTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TIcdlstTmp.GetPrjCod:Str30;
begin
  Result:=oTmpTable.FieldByName('PrjCod').AsString;
end;

procedure TIcdlstTmp.SetPrjCod(pValue:Str30);
begin
  oTmpTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TIcdlstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIcdlstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetSndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDte').AsDateTime;
end;

procedure TIcdlstTmp.SetSndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetExpDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TIcdlstTmp.SetExpDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetVatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('VatDte').AsDateTime;
end;

procedure TIcdlstTmp.SetVatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetPayDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDte').AsDateTime;
end;

procedure TIcdlstTmp.SetPayDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIcdlstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIcdlstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetConSym:Str4;
begin
  Result:=oTmpTable.FieldByName('ConSym').AsString;
end;

procedure TIcdlstTmp.SetConSym(pValue:Str4);
begin
  oTmpTable.FieldByName('ConSym').AsString:=pValue;
end;

function TIcdlstTmp.GetCusCrd:Str20;
begin
  Result:=oTmpTable.FieldByName('CusCrd').AsString;
end;

procedure TIcdlstTmp.SetCusCrd(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TIcdlstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TIcdlstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TIcdlstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TIcdlstTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TIcdlstTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TIcdlstTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TIcdlstTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TIcdlstTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TIcdlstTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TIcdlstTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TIcdlstTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TIcdlstTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TIcdlstTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TIcdlstTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TIcdlstTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TIcdlstTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TIcdlstTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TIcdlstTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TIcdlstTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TIcdlstTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TIcdlstTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TIcdlstTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TIcdlstTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TIcdlstTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetWpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaNam').AsString;
end;

procedure TIcdlstTmp.SetWpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TIcdlstTmp.GetWpaAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAdr').AsString;
end;

procedure TIcdlstTmp.SetWpaAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TIcdlstTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TIcdlstTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TIcdlstTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TIcdlstTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TIcdlstTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TIcdlstTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TIcdlstTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TIcdlstTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TIcdlstTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TIcdlstTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TIcdlstTmp.GetPayNam:Str20;
begin
  Result:=oTmpTable.FieldByName('PayNam').AsString;
end;

procedure TIcdlstTmp.SetPayNam(pValue:Str20);
begin
  oTmpTable.FieldByName('PayNam').AsString:=pValue;
end;

function TIcdlstTmp.GetTrsCod:Str1;
begin
  Result:=oTmpTable.FieldByName('TrsCod').AsString;
end;

procedure TIcdlstTmp.SetTrsCod(pValue:Str1);
begin
  oTmpTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TIcdlstTmp.GetTrsNam:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsNam').AsString;
end;

procedure TIcdlstTmp.SetTrsNam(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TIcdlstTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIcdlstTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TIcdlstTmp.GetVatCls:byte;
begin
  Result:=oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TIcdlstTmp.SetVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger:=pValue;
end;

function TIcdlstTmp.GetDocSpc:byte;
begin
  Result:=oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIcdlstTmp.SetDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger:=pValue;
end;

function TIcdlstTmp.GetCrtUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TIcdlstTmp.SetCrtUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIcdlstTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TIcdlstTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIcdlstTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIcdlstTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIcdlstTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetMngUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('MngUsr').AsString;
end;

procedure TIcdlstTmp.SetMngUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TIcdlstTmp.GetMngUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('MngUsn').AsString;
end;

procedure TIcdlstTmp.SetMngUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TIcdlstTmp.GetMngDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('MngDte').AsDateTime;
end;

procedure TIcdlstTmp.SetMngDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetEdiUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('EdiUsr').AsString;
end;

procedure TIcdlstTmp.SetEdiUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TIcdlstTmp.GetEdiDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TIcdlstTmp.SetEdiDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetEdiTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TIcdlstTmp.SetEdiTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIcdlstTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TIcdlstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TIcdlstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TIcdlstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TIcdlstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TIcdlstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TIcdlstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetProAva:double;
begin
  Result:=oTmpTable.FieldByName('ProAva').AsFloat;
end;

procedure TIcdlstTmp.SetProAva(pValue:double);
begin
  oTmpTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetSrvAva:double;
begin
  Result:=oTmpTable.FieldByName('SrvAva').AsFloat;
end;

procedure TIcdlstTmp.SetSrvAva(pValue:double);
begin
  oTmpTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIcdlstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TIcdlstTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TIcdlstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TIcdlstTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TIcdlstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TIcdlstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TIcdlstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TIcdlstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetPayVal:double;
begin
  Result:=oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TIcdlstTmp.SetPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TIcdlstTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TIcdlstTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDvzNam:Str3;
begin
  Result:=oTmpTable.FieldByName('DvzNam').AsString;
end;

procedure TIcdlstTmp.SetDvzNam(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TIcdlstTmp.GetDvzCrs:double;
begin
  Result:=oTmpTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TIcdlstTmp.SetDvzCrs(pValue:double);
begin
  oTmpTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TIcdlstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDepBva:double;
begin
  Result:=oTmpTable.FieldByName('DepBva').AsFloat;
end;

procedure TIcdlstTmp.SetDepBva(pValue:double);
begin
  oTmpTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TIcdlstTmp.GetValClc:Str15;
begin
  Result:=oTmpTable.FieldByName('ValClc').AsString;
end;

procedure TIcdlstTmp.SetValClc(pValue:Str15);
begin
  oTmpTable.FieldByName('ValClc').AsString:=pValue;
end;

function TIcdlstTmp.GetIcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TIcdlstTmp.SetIcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TIcdlstTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TIcdlstTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TIcdlstTmp.GetDstLck:Str1;
begin
  Result:=oTmpTable.FieldByName('DstLck').AsString;
end;

procedure TIcdlstTmp.SetDstLck(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLck').AsString:=pValue;
end;

function TIcdlstTmp.GetDstCls:Str1;
begin
  Result:=oTmpTable.FieldByName('DstCls').AsString;
end;

procedure TIcdlstTmp.SetDstCls(pValue:Str1);
begin
  oTmpTable.FieldByName('DstCls').AsString:=pValue;
end;

function TIcdlstTmp.GetDstAcc:Str1;
begin
  Result:=oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TIcdlstTmp.SetDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString:=pValue;
end;

function TIcdlstTmp.GetDstPay:Str1;
begin
  Result:=oTmpTable.FieldByName('DstPay').AsString;
end;

procedure TIcdlstTmp.SetDstPay(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPay').AsString:=pValue;
end;

function TIcdlstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TIcdlstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TIcdlstTmp.GetAtcDoq:byte;
begin
  Result:=oTmpTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TIcdlstTmp.SetAtcDoq(pValue:byte);
begin
  oTmpTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TIcdlstTmp.GetSrdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TIcdlstTmp.SetSrdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TIcdlstTmp.GetMcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TIcdlstTmp.SetMcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TIcdlstTmp.GetTcdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TIcdlstTmp.SetTcdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TIcdlstTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIcdlstTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TIcdlstTmp.GetPrnUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('PrnUsr').AsString;
end;

procedure TIcdlstTmp.SetPrnUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TIcdlstTmp.GetPrnDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TIcdlstTmp.SetPrnDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetPrnTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TIcdlstTmp.SetPrnTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetEmlCnt:byte;
begin
  Result:=oTmpTable.FieldByName('EmlCnt').AsInteger;
end;

procedure TIcdlstTmp.SetEmlCnt(pValue:byte);
begin
  oTmpTable.FieldByName('EmlCnt').AsInteger:=pValue;
end;

function TIcdlstTmp.GetEmlUsr:Str15;
begin
  Result:=oTmpTable.FieldByName('EmlUsr').AsString;
end;

procedure TIcdlstTmp.SetEmlUsr(pValue:Str15);
begin
  oTmpTable.FieldByName('EmlUsr').AsString:=pValue;
end;

function TIcdlstTmp.GetEmlDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EmlDte').AsDateTime;
end;

procedure TIcdlstTmp.SetEmlDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmlDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetEmlTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EmlTim').AsDateTime;
end;

procedure TIcdlstTmp.SetEmlTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmlTim').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetDocDes:Str50;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TIcdlstTmp.SetDocDes(pValue:Str50);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TIcdlstTmp.GetVatDis:byte;
begin
  Result:=oTmpTable.FieldByName('VatDis').AsInteger;
end;

procedure TIcdlstTmp.SetVatDis(pValue:byte);
begin
  oTmpTable.FieldByName('VatDis').AsInteger:=pValue;
end;

function TIcdlstTmp.GetDocSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TIcdlstTmp.SetDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString:=pValue;
end;

function TIcdlstTmp.GetDocAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TIcdlstTmp.SetDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString:=pValue;
end;

function TIcdlstTmp.GetWarNum:byte;
begin
  Result:=oTmpTable.FieldByName('WarNum').AsInteger;
end;

procedure TIcdlstTmp.SetWarNum(pValue:byte);
begin
  oTmpTable.FieldByName('WarNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetWarDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('WarDte').AsDateTime;
end;

procedure TIcdlstTmp.SetWarDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WarDte').AsDateTime:=pValue;
end;

function TIcdlstTmp.GetIccDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('IccDoc').AsString;
end;

procedure TIcdlstTmp.SetIccDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('IccDoc').AsString:=pValue;
end;

function TIcdlstTmp.GetIccExd:Str12;
begin
  Result:=oTmpTable.FieldByName('IccExd').AsString;
end;

procedure TIcdlstTmp.SetIccExd(pValue:Str12);
begin
  oTmpTable.FieldByName('IccExd').AsString:=pValue;
end;

function TIcdlstTmp.GetCsgNum:Str15;
begin
  Result:=oTmpTable.FieldByName('CsgNum').AsString;
end;

procedure TIcdlstTmp.SetCsgNum(pValue:Str15);
begin
  oTmpTable.FieldByName('CsgNum').AsString:=pValue;
end;

function TIcdlstTmp.GetDlrNum:longint;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TIcdlstTmp.SetDlrNum(pValue:longint);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIcdlstTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIcdlstTmp.GetDocFrm:Str6;
begin
  Result:=oTmpTable.FieldByName('DocFrm').AsString;
end;

procedure TIcdlstTmp.SetDocFrm(pValue:Str6);
begin
  oTmpTable.FieldByName('DocFrm').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcdlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIcdlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIcdlstTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TIcdlstTmp.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex (ixBokNum);
  Result:=oTmpTable.FindKey([pBokNum]);
end;

function TIcdlstTmp.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixDySn);
  Result:=oTmpTable.FindKey([pDocYer,pSerNum]);
end;

function TIcdlstTmp.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex (ixDyBnSn);
  Result:=oTmpTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TIcdlstTmp.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result:=oTmpTable.FindKey([pExtNum]);
end;

function TIcdlstTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TIcdlstTmp.LocCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex (ixCusCrd);
  Result:=oTmpTable.FindKey([pCusCrd]);
end;

function TIcdlstTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TIcdlstTmp.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result:=oTmpTable.FindKey([pRegIno]);
end;

function TIcdlstTmp.LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex (ixSnWn);
  Result:=oTmpTable.FindKey([pSpaNum,pWpaNum]);
end;

function TIcdlstTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TIcdlstTmp.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex (ixEndBva);
  Result:=oTmpTable.FindKey([pEndBva]);
end;

function TIcdlstTmp.LocDepBva(pDepBva:double):boolean;
begin
  SetIndex (ixDepBva);
  Result:=oTmpTable.FindKey([pDepBva]);
end;

function TIcdlstTmp.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex (ixPrjNum);
  Result:=oTmpTable.FindKey([pPrjNum]);
end;

function TIcdlstTmp.LocPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex (ixPrjCod);
  Result:=oTmpTable.FindKey([pPrjCod]);
end;

function TIcdlstTmp.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex (ixDlrNum);
  Result:=oTmpTable.FindKey([pDlrNum]);
end;

function TIcdlstTmp.LocEdiUsr(pEdiUsr:Str15):boolean;
begin
  SetIndex (ixEdiUsr);
  Result:=oTmpTable.FindKey([pEdiUsr]);
end;

function TIcdlstTmp.LocDstAcc(pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result:=oTmpTable.FindKey([pDstAcc]);
end;

function TIcdlstTmp.LocIccDoc(pIccDoc:Str12):boolean;
begin
  SetIndex (ixIccDoc);
  Result:=oTmpTable.FindKey([pIccDoc]);
end;

function TIcdlstTmp.LocDstPay(pDstPay:Str1):boolean;
begin
  SetIndex (ixDstPay);
  Result:=oTmpTable.FindKey([pDstPay]);
end;

function TIcdlstTmp.LocPaDp(pParNum:longint;pDstPay:Str1):boolean;
begin
  SetIndex (ixPaDp);
  Result:=oTmpTable.FindKey([pParNum,pDstPay]);
end;

function TIcdlstTmp.LocSpcMrk(pSpcMrk:Str10):boolean;
begin
  SetIndex (ixSpcMrk);
  Result:=oTmpTable.FindKey([pSpcMrk]);
end;

procedure TIcdlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIcdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIcdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIcdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIcdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIcdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TIcdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIcdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIcdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIcdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIcdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIcdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIcdlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIcdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIcdlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIcdlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIcdlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
