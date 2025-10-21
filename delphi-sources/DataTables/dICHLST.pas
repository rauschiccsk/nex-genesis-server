unit dICHLST;

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
  ixCusCrd='CusCrd';
  ixParNum='ParNum';
  ixRegIno='RegIno';
  ixSnWn='SnWn';
  ixParNam='ParNam';
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
  TIchlstDat=class(TComponent)
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
    function GetOcdNum:Str13;            procedure SetOcdNum(pValue:Str13);
    function GetOceNum:Str20;            procedure SetOceNum(pValue:Str20);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetPrjCod:Str30;            procedure SetPrjCod(pValue:Str30);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetVatDte:TDatetime;        procedure SetVatDte(pValue:TDatetime);
    function GetPayDte:TDatetime;        procedure SetPayDte(pValue:TDatetime);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetCsyCde:Str4;             procedure SetCsyCde(pValue:Str4);
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
    function GetVatDoc:byte;             procedure SetVatDoc(pValue:byte);
    function GetVatCls:byte;             procedure SetVatCls(pValue:byte);
    function GetDocSpc:byte;             procedure SetDocSpc(pValue:byte);
    function GetCrtUsr:Str15;            procedure SetCrtUsr(pValue:Str15);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetMngUsr:Str15;            procedure SetMngUsr(pValue:Str15);
    function GetMngUsn:Str30;            procedure SetMngUsn(pValue:Str30);
    function GetMngDte:TDatetime;        procedure SetMngDte(pValue:TDatetime);
    function GetEdiUsr:Str15;            procedure SetEdiUsr(pValue:Str15);
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
    function GetPayVal:double;           procedure SetPayVal(pValue:double);
    function GetEndVal:double;           procedure SetEndVal(pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam(pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetDepBva:double;           procedure SetDepBva(pValue:double);
    function GetValClc:Str15;            procedure SetValClc(pValue:Str15);
    function GetIcdPrq:double;           procedure SetIcdPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetDstLck:Str1;             procedure SetDstLck(pValue:Str1);
    function GetDstCls:Str1;             procedure SetDstCls(pValue:Str1);
    function GetDstAcc:Str1;             procedure SetDstAcc(pValue:Str1);
    function GetDstPay:Str1;             procedure SetDstPay(pValue:Str1);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetAtcDoq:byte;             procedure SetAtcDoq(pValue:byte);
    function GetSrdNum:Str13;            procedure SetSrdNum(pValue:Str13);
    function GetMcdNum:Str13;            procedure SetMcdNum(pValue:Str13);
    function GetTcdNum:Str13;            procedure SetTcdNum(pValue:Str13);
    function GetPrnCnt:byte;             procedure SetPrnCnt(pValue:byte);
    function GetPrnUsr:Str15;            procedure SetPrnUsr(pValue:Str15);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim(pValue:TDatetime);
    function GetEmlCnt:byte;             procedure SetEmlCnt(pValue:byte);
    function GetEmlUsr:Str15;            procedure SetEmlUsr(pValue:Str15);
    function GetEmlDte:TDatetime;        procedure SetEmlDte(pValue:TDatetime);
    function GetEmlTim:TDatetime;        procedure SetEmlTim(pValue:TDatetime);
    function GetDocDes:Str50;            procedure SetDocDes(pValue:Str50);
    function GetVatDis:byte;             procedure SetVatDis(pValue:byte);
    function GetDocSnt:Str3;             procedure SetDocSnt(pValue:Str3);
    function GetDocAnl:Str6;             procedure SetDocAnl(pValue:Str6);
    function GetWarNum:byte;             procedure SetWarNum(pValue:byte);
    function GetWarDte:TDatetime;        procedure SetWarDte(pValue:TDatetime);
    function GetIccDoc:Str12;            procedure SetIccDoc(pValue:Str12);
    function GetIccExd:Str12;            procedure SetIccExd(pValue:Str12);
    function GetCsgNum:Str15;            procedure SetCsgNum(pValue:Str15);
    function GetDlrNum:longint;          procedure SetDlrNum(pValue:longint);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocFrm:Str6;             procedure SetDocFrm(pValue:Str6);
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
    function LocCusCrd(pCusCrd:Str20):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocRegIno(pRegIno:Str15):boolean;
    function LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocEndBva(pEndBva:double):boolean;
    function LocDepBva(pDepBva:double):boolean;
    function LocPrjNum(pPrjNum:Str12):boolean;
    function LocPrjCod(pPrjCod:Str30):boolean;
    function LocDlrNum(pDlrNum:longint):boolean;
    function LocEdiUsr(pEdiUsr:Str15):boolean;
    function LocDstAcc(pDstAcc:Str1):boolean;
    function LocIccDoc(pIccDoc:Str12):boolean;
    function LocDstPay(pDstPay:Str1):boolean;
    function LocPaDp(pParNum:longint;pDstPay:Str1):boolean;
    function LocSpcMrk(pSpcMrk:Str10):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearCusCrd(pCusCrd:Str20):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearRegIno(pRegIno:Str15):boolean;
    function NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearEndBva(pEndBva:double):boolean;
    function NearDepBva(pDepBva:double):boolean;
    function NearPrjNum(pPrjNum:Str12):boolean;
    function NearPrjCod(pPrjCod:Str30):boolean;
    function NearDlrNum(pDlrNum:longint):boolean;
    function NearEdiUsr(pEdiUsr:Str15):boolean;
    function NearDstAcc(pDstAcc:Str1):boolean;
    function NearIccDoc(pIccDoc:Str12):boolean;
    function NearDstPay(pDstPay:Str1):boolean;
    function NearPaDp(pParNum:longint;pDstPay:Str1):boolean;
    function NearSpcMrk(pSpcMrk:Str10):boolean;

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
    property CsyCde:Str4 read GetCsyCde write SetCsyCde;
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

constructor TIchlstDat.Create;
begin
  oTable:=DatInit('ICHLST',gPath.LdgPath,Self);
end;

constructor TIchlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ICHLST',pPath,Self);
end;

destructor TIchlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIchlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIchlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIchlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TIchlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIchlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TIchlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TIchlstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TIchlstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TIchlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIchlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIchlstDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TIchlstDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TIchlstDat.GetOcdNum:Str13;
begin
  Result:=oTable.FieldByName('OcdNum').AsString;
end;

procedure TIchlstDat.SetOcdNum(pValue:Str13);
begin
  oTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TIchlstDat.GetOceNum:Str20;
begin
  Result:=oTable.FieldByName('OceNum').AsString;
end;

procedure TIchlstDat.SetOceNum(pValue:Str20);
begin
  oTable.FieldByName('OceNum').AsString:=pValue;
end;

function TIchlstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TIchlstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TIchlstDat.GetPrjCod:Str30;
begin
  Result:=oTable.FieldByName('PrjCod').AsString;
end;

procedure TIchlstDat.SetPrjCod(pValue:Str30);
begin
  oTable.FieldByName('PrjCod').AsString:=pValue;
end;

function TIchlstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIchlstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetSndDte:TDatetime;
begin
  Result:=oTable.FieldByName('SndDte').AsDateTime;
end;

procedure TIchlstDat.SetSndDte(pValue:TDatetime);
begin
  oTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TIchlstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetVatDte:TDatetime;
begin
  Result:=oTable.FieldByName('VatDte').AsDateTime;
end;

procedure TIchlstDat.SetVatDte(pValue:TDatetime);
begin
  oTable.FieldByName('VatDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetPayDte:TDatetime;
begin
  Result:=oTable.FieldByName('PayDte').AsDateTime;
end;

procedure TIchlstDat.SetPayDte(pValue:TDatetime);
begin
  oTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TIchlstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIchlstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TIchlstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIchlstDat.GetCsyCde:Str4;
begin
  Result:=oTable.FieldByName('CsyCde').AsString;
end;

procedure TIchlstDat.SetCsyCde(pValue:Str4);
begin
  oTable.FieldByName('CsyCde').AsString:=pValue;
end;

function TIchlstDat.GetCusCrd:Str20;
begin
  Result:=oTable.FieldByName('CusCrd').AsString;
end;

procedure TIchlstDat.SetCusCrd(pValue:Str20);
begin
  oTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TIchlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TIchlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIchlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TIchlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TIchlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TIchlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TIchlstDat.GetRegIno:Str15;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TIchlstDat.SetRegIno(pValue:Str15);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TIchlstDat.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TIchlstDat.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TIchlstDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TIchlstDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TIchlstDat.GetRegAdr:Str30;
begin
  Result:=oTable.FieldByName('RegAdr').AsString;
end;

procedure TIchlstDat.SetRegAdr(pValue:Str30);
begin
  oTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TIchlstDat.GetRegSta:Str2;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TIchlstDat.SetRegSta(pValue:Str2);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TIchlstDat.GetRegCty:Str3;
begin
  Result:=oTable.FieldByName('RegCty').AsString;
end;

procedure TIchlstDat.SetRegCty(pValue:Str3);
begin
  oTable.FieldByName('RegCty').AsString:=pValue;
end;

function TIchlstDat.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TIchlstDat.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TIchlstDat.GetRegZip:Str15;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TIchlstDat.SetRegZip(pValue:Str15);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TIchlstDat.GetSpaNum:longint;
begin
  Result:=oTable.FieldByName('SpaNum').AsInteger;
end;

procedure TIchlstDat.SetSpaNum(pValue:longint);
begin
  oTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TIchlstDat.GetWpaNum:word;
begin
  Result:=oTable.FieldByName('WpaNum').AsInteger;
end;

procedure TIchlstDat.SetWpaNum(pValue:word);
begin
  oTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TIchlstDat.GetWpaNam:Str60;
begin
  Result:=oTable.FieldByName('WpaNam').AsString;
end;

procedure TIchlstDat.SetWpaNam(pValue:Str60);
begin
  oTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TIchlstDat.GetWpaAdr:Str30;
begin
  Result:=oTable.FieldByName('WpaAdr').AsString;
end;

procedure TIchlstDat.SetWpaAdr(pValue:Str30);
begin
  oTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TIchlstDat.GetWpaSta:Str2;
begin
  Result:=oTable.FieldByName('WpaSta').AsString;
end;

procedure TIchlstDat.SetWpaSta(pValue:Str2);
begin
  oTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TIchlstDat.GetWpaCty:Str3;
begin
  Result:=oTable.FieldByName('WpaCty').AsString;
end;

procedure TIchlstDat.SetWpaCty(pValue:Str3);
begin
  oTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TIchlstDat.GetWpaCtn:Str30;
begin
  Result:=oTable.FieldByName('WpaCtn').AsString;
end;

procedure TIchlstDat.SetWpaCtn(pValue:Str30);
begin
  oTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TIchlstDat.GetWpaZip:Str15;
begin
  Result:=oTable.FieldByName('WpaZip').AsString;
end;

procedure TIchlstDat.SetWpaZip(pValue:Str15);
begin
  oTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TIchlstDat.GetPayCod:Str1;
begin
  Result:=oTable.FieldByName('PayCod').AsString;
end;

procedure TIchlstDat.SetPayCod(pValue:Str1);
begin
  oTable.FieldByName('PayCod').AsString:=pValue;
end;

function TIchlstDat.GetPayNam:Str20;
begin
  Result:=oTable.FieldByName('PayNam').AsString;
end;

procedure TIchlstDat.SetPayNam(pValue:Str20);
begin
  oTable.FieldByName('PayNam').AsString:=pValue;
end;

function TIchlstDat.GetTrsCod:Str1;
begin
  Result:=oTable.FieldByName('TrsCod').AsString;
end;

procedure TIchlstDat.SetTrsCod(pValue:Str1);
begin
  oTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TIchlstDat.GetTrsNam:Str20;
begin
  Result:=oTable.FieldByName('TrsNam').AsString;
end;

procedure TIchlstDat.SetTrsNam(pValue:Str20);
begin
  oTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TIchlstDat.GetVatDoc:byte;
begin
  Result:=oTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIchlstDat.SetVatDoc(pValue:byte);
begin
  oTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TIchlstDat.GetVatCls:byte;
begin
  Result:=oTable.FieldByName('VatCls').AsInteger;
end;

procedure TIchlstDat.SetVatCls(pValue:byte);
begin
  oTable.FieldByName('VatCls').AsInteger:=pValue;
end;

function TIchlstDat.GetDocSpc:byte;
begin
  Result:=oTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIchlstDat.SetDocSpc(pValue:byte);
begin
  oTable.FieldByName('DocSpc').AsInteger:=pValue;
end;

function TIchlstDat.GetCrtUsr:Str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIchlstDat.SetCrtUsr(pValue:Str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIchlstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TIchlstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIchlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIchlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIchlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIchlstDat.GetMngUsr:Str15;
begin
  Result:=oTable.FieldByName('MngUsr').AsString;
end;

procedure TIchlstDat.SetMngUsr(pValue:Str15);
begin
  oTable.FieldByName('MngUsr').AsString:=pValue;
end;

function TIchlstDat.GetMngUsn:Str30;
begin
  Result:=oTable.FieldByName('MngUsn').AsString;
end;

procedure TIchlstDat.SetMngUsn(pValue:Str30);
begin
  oTable.FieldByName('MngUsn').AsString:=pValue;
end;

function TIchlstDat.GetMngDte:TDatetime;
begin
  Result:=oTable.FieldByName('MngDte').AsDateTime;
end;

procedure TIchlstDat.SetMngDte(pValue:TDatetime);
begin
  oTable.FieldByName('MngDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetEdiUsr:Str15;
begin
  Result:=oTable.FieldByName('EdiUsr').AsString;
end;

procedure TIchlstDat.SetEdiUsr(pValue:Str15);
begin
  oTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TIchlstDat.GetEdiDte:TDatetime;
begin
  Result:=oTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TIchlstDat.SetEdiDte(pValue:TDatetime);
begin
  oTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetEdiTim:TDatetime;
begin
  Result:=oTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TIchlstDat.SetEdiTim(pValue:TDatetime);
begin
  oTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TIchlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIchlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TIchlstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TIchlstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TIchlstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TIchlstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TIchlstDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TIchlstDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TIchlstDat.GetProAva:double;
begin
  Result:=oTable.FieldByName('ProAva').AsFloat;
end;

procedure TIchlstDat.SetProAva(pValue:double);
begin
  oTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TIchlstDat.GetSrvAva:double;
begin
  Result:=oTable.FieldByName('SrvAva').AsFloat;
end;

procedure TIchlstDat.SetSrvAva(pValue:double);
begin
  oTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TIchlstDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIchlstDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIchlstDat.GetDscAva:double;
begin
  Result:=oTable.FieldByName('DscAva').AsFloat;
end;

procedure TIchlstDat.SetDscAva(pValue:double);
begin
  oTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TIchlstDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TIchlstDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TIchlstDat.GetVatVal:double;
begin
  Result:=oTable.FieldByName('VatVal').AsFloat;
end;

procedure TIchlstDat.SetVatVal(pValue:double);
begin
  oTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TIchlstDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TIchlstDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TIchlstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TIchlstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TIchlstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TIchlstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TIchlstDat.GetPayVal:double;
begin
  Result:=oTable.FieldByName('PayVal').AsFloat;
end;

procedure TIchlstDat.SetPayVal(pValue:double);
begin
  oTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TIchlstDat.GetEndVal:double;
begin
  Result:=oTable.FieldByName('EndVal').AsFloat;
end;

procedure TIchlstDat.SetEndVal(pValue:double);
begin
  oTable.FieldByName('EndVal').AsFloat:=pValue;
end;

function TIchlstDat.GetDvzNam:Str3;
begin
  Result:=oTable.FieldByName('DvzNam').AsString;
end;

procedure TIchlstDat.SetDvzNam(pValue:Str3);
begin
  oTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TIchlstDat.GetDvzCrs:double;
begin
  Result:=oTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TIchlstDat.SetDvzCrs(pValue:double);
begin
  oTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TIchlstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TIchlstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TIchlstDat.GetDepBva:double;
begin
  Result:=oTable.FieldByName('DepBva').AsFloat;
end;

procedure TIchlstDat.SetDepBva(pValue:double);
begin
  oTable.FieldByName('DepBva').AsFloat:=pValue;
end;

function TIchlstDat.GetValClc:Str15;
begin
  Result:=oTable.FieldByName('ValClc').AsString;
end;

procedure TIchlstDat.SetValClc(pValue:Str15);
begin
  oTable.FieldByName('ValClc').AsString:=pValue;
end;

function TIchlstDat.GetIcdPrq:double;
begin
  Result:=oTable.FieldByName('IcdPrq').AsFloat;
end;

procedure TIchlstDat.SetIcdPrq(pValue:double);
begin
  oTable.FieldByName('IcdPrq').AsFloat:=pValue;
end;

function TIchlstDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TIchlstDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TIchlstDat.GetDstLck:Str1;
begin
  Result:=oTable.FieldByName('DstLck').AsString;
end;

procedure TIchlstDat.SetDstLck(pValue:Str1);
begin
  oTable.FieldByName('DstLck').AsString:=pValue;
end;

function TIchlstDat.GetDstCls:Str1;
begin
  Result:=oTable.FieldByName('DstCls').AsString;
end;

procedure TIchlstDat.SetDstCls(pValue:Str1);
begin
  oTable.FieldByName('DstCls').AsString:=pValue;
end;

function TIchlstDat.GetDstAcc:Str1;
begin
  Result:=oTable.FieldByName('DstAcc').AsString;
end;

procedure TIchlstDat.SetDstAcc(pValue:Str1);
begin
  oTable.FieldByName('DstAcc').AsString:=pValue;
end;

function TIchlstDat.GetDstPay:Str1;
begin
  Result:=oTable.FieldByName('DstPay').AsString;
end;

procedure TIchlstDat.SetDstPay(pValue:Str1);
begin
  oTable.FieldByName('DstPay').AsString:=pValue;
end;

function TIchlstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TIchlstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TIchlstDat.GetAtcDoq:byte;
begin
  Result:=oTable.FieldByName('AtcDoq').AsInteger;
end;

procedure TIchlstDat.SetAtcDoq(pValue:byte);
begin
  oTable.FieldByName('AtcDoq').AsInteger:=pValue;
end;

function TIchlstDat.GetSrdNum:Str13;
begin
  Result:=oTable.FieldByName('SrdNum').AsString;
end;

procedure TIchlstDat.SetSrdNum(pValue:Str13);
begin
  oTable.FieldByName('SrdNum').AsString:=pValue;
end;

function TIchlstDat.GetMcdNum:Str13;
begin
  Result:=oTable.FieldByName('McdNum').AsString;
end;

procedure TIchlstDat.SetMcdNum(pValue:Str13);
begin
  oTable.FieldByName('McdNum').AsString:=pValue;
end;

function TIchlstDat.GetTcdNum:Str13;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TIchlstDat.SetTcdNum(pValue:Str13);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TIchlstDat.GetPrnCnt:byte;
begin
  Result:=oTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIchlstDat.SetPrnCnt(pValue:byte);
begin
  oTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TIchlstDat.GetPrnUsr:Str15;
begin
  Result:=oTable.FieldByName('PrnUsr').AsString;
end;

procedure TIchlstDat.SetPrnUsr(pValue:Str15);
begin
  oTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TIchlstDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TIchlstDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetPrnTim:TDatetime;
begin
  Result:=oTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TIchlstDat.SetPrnTim(pValue:TDatetime);
begin
  oTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

function TIchlstDat.GetEmlCnt:byte;
begin
  Result:=oTable.FieldByName('EmlCnt').AsInteger;
end;

procedure TIchlstDat.SetEmlCnt(pValue:byte);
begin
  oTable.FieldByName('EmlCnt').AsInteger:=pValue;
end;

function TIchlstDat.GetEmlUsr:Str15;
begin
  Result:=oTable.FieldByName('EmlUsr').AsString;
end;

procedure TIchlstDat.SetEmlUsr(pValue:Str15);
begin
  oTable.FieldByName('EmlUsr').AsString:=pValue;
end;

function TIchlstDat.GetEmlDte:TDatetime;
begin
  Result:=oTable.FieldByName('EmlDte').AsDateTime;
end;

procedure TIchlstDat.SetEmlDte(pValue:TDatetime);
begin
  oTable.FieldByName('EmlDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetEmlTim:TDatetime;
begin
  Result:=oTable.FieldByName('EmlTim').AsDateTime;
end;

procedure TIchlstDat.SetEmlTim(pValue:TDatetime);
begin
  oTable.FieldByName('EmlTim').AsDateTime:=pValue;
end;

function TIchlstDat.GetDocDes:Str50;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TIchlstDat.SetDocDes(pValue:Str50);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TIchlstDat.GetVatDis:byte;
begin
  Result:=oTable.FieldByName('VatDis').AsInteger;
end;

procedure TIchlstDat.SetVatDis(pValue:byte);
begin
  oTable.FieldByName('VatDis').AsInteger:=pValue;
end;

function TIchlstDat.GetDocSnt:Str3;
begin
  Result:=oTable.FieldByName('DocSnt').AsString;
end;

procedure TIchlstDat.SetDocSnt(pValue:Str3);
begin
  oTable.FieldByName('DocSnt').AsString:=pValue;
end;

function TIchlstDat.GetDocAnl:Str6;
begin
  Result:=oTable.FieldByName('DocAnl').AsString;
end;

procedure TIchlstDat.SetDocAnl(pValue:Str6);
begin
  oTable.FieldByName('DocAnl').AsString:=pValue;
end;

function TIchlstDat.GetWarNum:byte;
begin
  Result:=oTable.FieldByName('WarNum').AsInteger;
end;

procedure TIchlstDat.SetWarNum(pValue:byte);
begin
  oTable.FieldByName('WarNum').AsInteger:=pValue;
end;

function TIchlstDat.GetWarDte:TDatetime;
begin
  Result:=oTable.FieldByName('WarDte').AsDateTime;
end;

procedure TIchlstDat.SetWarDte(pValue:TDatetime);
begin
  oTable.FieldByName('WarDte').AsDateTime:=pValue;
end;

function TIchlstDat.GetIccDoc:Str12;
begin
  Result:=oTable.FieldByName('IccDoc').AsString;
end;

procedure TIchlstDat.SetIccDoc(pValue:Str12);
begin
  oTable.FieldByName('IccDoc').AsString:=pValue;
end;

function TIchlstDat.GetIccExd:Str12;
begin
  Result:=oTable.FieldByName('IccExd').AsString;
end;

procedure TIchlstDat.SetIccExd(pValue:Str12);
begin
  oTable.FieldByName('IccExd').AsString:=pValue;
end;

function TIchlstDat.GetCsgNum:Str15;
begin
  Result:=oTable.FieldByName('CsgNum').AsString;
end;

procedure TIchlstDat.SetCsgNum(pValue:Str15);
begin
  oTable.FieldByName('CsgNum').AsString:=pValue;
end;

function TIchlstDat.GetDlrNum:longint;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TIchlstDat.SetDlrNum(pValue:longint);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TIchlstDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIchlstDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIchlstDat.GetDocFrm:Str6;
begin
  Result:=oTable.FieldByName('DocFrm').AsString;
end;

procedure TIchlstDat.SetDocFrm(pValue:Str6);
begin
  oTable.FieldByName('DocFrm').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIchlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIchlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIchlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIchlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIchlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIchlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIchlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIchlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIchlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TIchlstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TIchlstDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TIchlstDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TIchlstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TIchlstDat.LocCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindKey([pCusCrd]);
end;

function TIchlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TIchlstDat.LocRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindKey([pRegIno]);
end;

function TIchlstDat.LocSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindKey([pSpaNum,pWpaNum]);
end;

function TIchlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TIchlstDat.LocEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindKey([pEndBva]);
end;

function TIchlstDat.LocDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindKey([pDepBva]);
end;

function TIchlstDat.LocPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindKey([pPrjNum]);
end;

function TIchlstDat.LocPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindKey([pPrjCod]);
end;

function TIchlstDat.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TIchlstDat.LocEdiUsr(pEdiUsr:Str15):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindKey([pEdiUsr]);
end;

function TIchlstDat.LocDstAcc(pDstAcc:Str1):boolean;
begin
  SetIndex(ixDstAcc);
  Result:=oTable.FindKey([pDstAcc]);
end;

function TIchlstDat.LocIccDoc(pIccDoc:Str12):boolean;
begin
  SetIndex(ixIccDoc);
  Result:=oTable.FindKey([pIccDoc]);
end;

function TIchlstDat.LocDstPay(pDstPay:Str1):boolean;
begin
  SetIndex(ixDstPay);
  Result:=oTable.FindKey([pDstPay]);
end;

function TIchlstDat.LocPaDp(pParNum:longint;pDstPay:Str1):boolean;
begin
  SetIndex(ixPaDp);
  Result:=oTable.FindKey([pParNum,pDstPay]);
end;

function TIchlstDat.LocSpcMrk(pSpcMrk:Str10):boolean;
begin
  SetIndex(ixSpcMrk);
  Result:=oTable.FindKey([pSpcMrk]);
end;

function TIchlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIchlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TIchlstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TIchlstDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TIchlstDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TIchlstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TIchlstDat.NearCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindNearest([pCusCrd]);
end;

function TIchlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TIchlstDat.NearRegIno(pRegIno:Str15):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindNearest([pRegIno]);
end;

function TIchlstDat.NearSnWn(pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex(ixSnWn);
  Result:=oTable.FindNearest([pSpaNum,pWpaNum]);
end;

function TIchlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TIchlstDat.NearEndBva(pEndBva:double):boolean;
begin
  SetIndex(ixEndBva);
  Result:=oTable.FindNearest([pEndBva]);
end;

function TIchlstDat.NearDepBva(pDepBva:double):boolean;
begin
  SetIndex(ixDepBva);
  Result:=oTable.FindNearest([pDepBva]);
end;

function TIchlstDat.NearPrjNum(pPrjNum:Str12):boolean;
begin
  SetIndex(ixPrjNum);
  Result:=oTable.FindNearest([pPrjNum]);
end;

function TIchlstDat.NearPrjCod(pPrjCod:Str30):boolean;
begin
  SetIndex(ixPrjCod);
  Result:=oTable.FindNearest([pPrjCod]);
end;

function TIchlstDat.NearDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

function TIchlstDat.NearEdiUsr(pEdiUsr:Str15):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindNearest([pEdiUsr]);
end;

function TIchlstDat.NearDstAcc(pDstAcc:Str1):boolean;
begin
  SetIndex(ixDstAcc);
  Result:=oTable.FindNearest([pDstAcc]);
end;

function TIchlstDat.NearIccDoc(pIccDoc:Str12):boolean;
begin
  SetIndex(ixIccDoc);
  Result:=oTable.FindNearest([pIccDoc]);
end;

function TIchlstDat.NearDstPay(pDstPay:Str1):boolean;
begin
  SetIndex(ixDstPay);
  Result:=oTable.FindNearest([pDstPay]);
end;

function TIchlstDat.NearPaDp(pParNum:longint;pDstPay:Str1):boolean;
begin
  SetIndex(ixPaDp);
  Result:=oTable.FindNearest([pParNum,pDstPay]);
end;

function TIchlstDat.NearSpcMrk(pSpcMrk:Str10):boolean;
begin
  SetIndex(ixSpcMrk);
  Result:=oTable.FindNearest([pSpcMrk]);
end;

procedure TIchlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIchlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIchlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIchlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TIchlstDat.Next;
begin
  oTable.Next;
end;

procedure TIchlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIchlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIchlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIchlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TIchlstDat.Post;
begin
  oTable.Post;
end;

procedure TIchlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TIchlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIchlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIchlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIchlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIchlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIchlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
