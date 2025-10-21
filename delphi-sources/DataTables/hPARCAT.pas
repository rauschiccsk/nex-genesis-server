unit hPARCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, hSTALST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='PaCode';
  ixParIdn='IdCode';
  ixRegIno='RegIno';
  ixRegTin='RegTin';

type
  TParcatHnd=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    ohSTALST:TStalstHnd;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParIdn:Str10;            procedure SetParIdn(pValue:Str10);
    function GetParGrp:word;             procedure SetParGrp(pValue:word);
    function GetParTel:Str20;            procedure SetParTel(pValue:Str20);
    function GetParEml:Str30;            procedure SetParEml(pValue:Str30);
    function GetParWeb:Str30;            procedure SetParWeb(pValue:Str30);
    function GetRegNam:Str60;            procedure SetRegNam(pValue:Str60);
    function GetRegIno:Str10;            procedure SetRegIno(pValue:Str10);
    function GetRegTin:Str15;            procedure SetRegTin(pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin(pValue:Str15);
    function GetRegAdr:Str60;            procedure SetRegAdr(pValue:Str60);
    function GetRegStc:Str2;             procedure SetRegStc(pValue:Str2);
    function GetRegStn:Str30;            
    function GetRegCtc:Str3;             procedure SetRegCtc(pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn(pValue:Str30);
    function GetRegZip:Str10;            procedure SetRegZip(pValue:Str10);
    function GetRegRec:Str60;            procedure SetRegRec(pValue:Str60);
    function GetRegTel:Str20;            procedure SetRegTel(pValue:Str20);
    function GetRegEml:Str30;            procedure SetRegEml(pValue:Str30);

    function GetEmgNam:Str30;            procedure SetEmgNam(pValue:Str30);
    function GetCrpAdr:Str30;            procedure SetCrpAdr(pValue:Str30);
    function GetCrpStc:Str2;             procedure SetCrpStc(pValue:Str2);
    function GetCrpStn:Str30;            procedure SetCrpStn(pValue:Str2);
    function GetCrpCtc:Str3;             procedure SetCrpCtc(pValue:Str3);
    function GetCrpCtn:Str30;            procedure SetCrpCtn(pValue:Str30);
    function GetCrpZip:Str10;            procedure SetCrpZip(pValue:Str10);
    function GetSpiPer:Str15;            procedure SetSpiPer(pValue:Str15);
    function GetPrnLng:Str2;             procedure SetPrnLng(pValue:Str2);
    function GetBanNam:Str30;            procedure SetBanNam(pValue:Str30);
    function GetIbaCod:Str34;            procedure SetIbaCod(pValue:Str34);
    function GetSwfCod:Str20;            procedure SetSwfCod(pValue:Str20);
    function GetBacQnt:byte;             procedure SetBacQnt(pValue:byte);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetExpDay:word;             procedure SetExpDay(pValue:word);
    function GetPenPrc:double;           procedure SetPenPrc(pValue:double);
    function GetPlsNum:word;             procedure SetPlsNum(pValue:word);
    function GetAplNum:word;             procedure SetAplNum(pValue:word);
    function GetSalLim:double;           procedure SetSalLim(pValue:double);
    function GetVatPay:byte;             procedure SetVatPay(pValue:byte);
    function GetOrgTyp:byte;             procedure SetOrgTyp(pValue:byte);
    function GetWpaQnt:word;             procedure SetWpaQnt(pValue:word);
    function GetBonCnv:word;             procedure SetBonCnv(pValue:word);
    function GetBonClc:byte;             procedure SetBonClc(pValue:byte);
    function GetCusPayCod:Str3;          procedure SetCusPayCod(pValue:Str3);
    function GetCusPayNam:Str20;         procedure SetCusPayNam(pValue:Str20);
    function GetCusPayBrm:Str1;          procedure SetCusPayBrm(pValue:Str1);
    function GetCusTrsCod:Str3;          procedure SetCusTrsCod(pValue:Str3);
    function GetCusTrsNam:Str20;         procedure SetCusTrsNam(pValue:Str20);
    function GetHedNam:Str30;            procedure SetHedNam(pValue:Str30);
    function GetDlrNum:word;             procedure SetDlrNum(pValue:word);
    function GetCrtUsr:word;             procedure SetCrtUsr(pValue:word);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParIdn(pParIdn:Str10):boolean;
    function LocRegIno(pRegIno:Str10):boolean;
    function LocRegTin(pRegTin:Str15):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParIdn(pParIdn:Str10):boolean;
    function NearRegIno(pRegIno:Str10):boolean;
    function NearRegTin(pRegTin:Str15):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParIdn:Str10 read GetParIdn write SetParIdn;
    property ParGrp:word read GetParGrp write SetParGrp;
    property ParTel:Str20 read GetParTel write SetParTel;
    property ParEml:Str30 read GetParEml write SetParEml;
    property ParWeb:Str30 read GetParWeb write SetParWeb;
    property RegNam:Str60 read GetRegNam write SetRegNam;
    property RegIno:Str10 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str60 read GetRegAdr write SetRegAdr;
    property RegStc:Str2 read GetRegStc write SetRegStc;
    property RegStn:Str30 read GetRegStn;
    property RegCtc:Str3 read GetRegCtc write SetRegCtc;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str10 read GetRegZip write SetRegZip;
    property RegRec:Str60 read GetRegRec write SetRegRec;
    property RegTel:Str20 read GetRegTel write SetRegTel;
    property RegEml:Str30 read GetRegEml write SetRegEml;
    property EmgNam:Str30 read GetEmgNam write SetEmgNam;
    property CrpAdr:Str30 read GetCrpAdr write SetCrpAdr;
    property CrpStc:Str2 read GetCrpStc write SetCrpStc;
    property CrpStn:Str30 read GetCrpStn;
    property CrpCtc:Str3 read GetCrpCtc write SetCrpCtc;
    property CrpCtn:Str30 read GetCrpCtn write SetCrpCtn;
    property CrpZip:Str10 read GetCrpZip write SetCrpZip;
    property SpiPer:Str15 read GetSpiPer write SetSpiPer;
    property PrnLng:Str2 read GetPrnLng write SetPrnLng;
    property BanNam:Str30 read GetBanNam write SetBanNam;
    property IbaCod:Str34 read GetIbaCod write SetIbaCod;
    property SwfCod:Str20 read GetSwfCod write SetSwfCod;
    property BacQnt:byte read GetBacQnt write SetBacQnt;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property ExpDay:word read GetExpDay write SetExpDay;
    property PenPrc:double read GetPenPrc write SetPenPrc;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property AplNum:word read GetAplNum write SetAplNum;
    property SalLim:double read GetSalLim write SetSalLim;
    property VatPay:byte read GetVatPay write SetVatPay;
    property OrgTyp:byte read GetOrgTyp write SetOrgTyp;
    property WpaQnt:word read GetWpaQnt write SetWpaQnt;
    property BonCnv:word read GetBonCnv write SetBonCnv;
    property BonClc:byte read GetBonClc write SetBonClc;
    property CusPayCod:Str3 read GetCusPayCod write SetCusPayCod;
    property CusPayNam:Str20 read GetCusPayNam write SetCusPayNam;
    property CusPayBrm:Str1 read GetCusPayBrm write SetCusPayBrm;
    property CusTrsCod:Str3 read GetCusTrsCod write SetCusTrsCod;
    property CusTrsNam:Str20 read GetCusTrsNam write SetCusTrsNam;
    property HedNam:Str30 read GetHedNam write SetHedNam;
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property CrtUsr:word read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

uses bStalst;

constructor TParcatHnd.Create;
begin
  oTable:=BtrInit('PAB',gPath.DlsPath,Self);
  ohSTALST:=TStalstHnd.Create;
end;

constructor TParcatHnd.Create(pPath:ShortString);
begin
  FreeAndNil(ohSTALST);
  oTable:=BtrInit('PAB',pPath,Self);
end;

destructor TParcatHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TParcatHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TParcatHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TParcatHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

// ********************* FIELDS *********************

function TParcatHnd.GetParNum:longint;
begin
  Result:=oTable.FieldByName('PaCode').AsInteger;
end;

procedure TParcatHnd.SetParNum(pValue:longint);
begin
  oTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TParcatHnd.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('PaName').AsString;
end;

procedure TParcatHnd.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('PaName').AsString:=pValue;
end;

function TParcatHnd.GetParIdn:Str10;
begin
  Result:=oTable.FieldByName('SmlName').AsString;
end;

procedure TParcatHnd.SetParIdn(pValue:Str10);
begin
  oTable.FieldByName('SmlName').AsString:=pValue;
end;

function TParcatHnd.GetParGrp:word;
begin
  Result:=oTable.FieldByName('PagCode').AsInteger;
end;

procedure TParcatHnd.SetParGrp(pValue:word);
begin
  oTable.FieldByName('PagCode').AsInteger:=pValue;
end;

function TParcatHnd.GetParTel:Str20;
begin
  Result:=oTable.FieldByName('RegTel').AsString;
end;

procedure TParcatHnd.SetParTel(pValue:Str20);
begin
  oTable.FieldByName('RegTel').AsString:=pValue;
end;

function TParcatHnd.GetParEml:Str30;
begin
  Result:=oTable.FieldByName('RegEml').AsString;
end;

procedure TParcatHnd.SetParEml(pValue:Str30);
begin
  oTable.FieldByName('RegEml').AsString:=pValue;
end;

function TParcatHnd.GetParWeb:Str30;
begin
  Result:=oTable.FieldByName('WebSite').AsString;
end;

procedure TParcatHnd.SetParWeb(pValue:Str30);
begin
  oTable.FieldByName('WebSite').AsString:=pValue;
end;

function TParcatHnd.GetRegNam:Str60;
begin
  Result:=oTable.FieldByName('RegName').AsString;
end;

procedure TParcatHnd.SetRegNam(pValue:Str60);
begin
  oTable.FieldByName('RegName').AsString:=pValue;
end;

function TParcatHnd.GetRegIno:Str10;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TParcatHnd.SetRegIno(pValue:Str10);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TParcatHnd.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TParcatHnd.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TParcatHnd.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TParcatHnd.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TParcatHnd.GetRegAdr:Str60;
begin
  Result:=oTable.FieldByName('RegAddr').AsString;
end;

procedure TParcatHnd.SetRegAdr(pValue:Str60);
begin
  oTable.FieldByName('RegAddr').AsString:=pValue;
end;

function TParcatHnd.GetRegStc:Str2;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TParcatHnd.SetRegStc(pValue:Str2);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TParcatHnd.GetRegStn:Str30;
begin
  Result:='';
  If not ohSTALST.Active then ohSTALST.Open;
  If ohSTALST.LocateStaCode(RegStc) then Result:=ohSTALST.StaName;
end;

function TParcatHnd.GetRegCtc:Str3;
begin
  Result:=oTable.FieldByName('RegCty').AsString;
end;

procedure TParcatHnd.SetRegCtc(pValue:Str3);
begin
  oTable.FieldByName('RegCty').AsString:=pValue;
end;

function TParcatHnd.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TParcatHnd.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TParcatHnd.GetRegZip:Str10;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TParcatHnd.SetRegZip(pValue:Str10);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TParcatHnd.GetRegRec:Str60;
begin
  Result:=oTable.FieldByName('RegRec').AsString;
end;

procedure TParcatHnd.SetRegRec(pValue:Str60);
begin
  oTable.FieldByName('RegRec').AsString:=pValue;
end;

function TParcatHnd.GetRegTel:Str20;
begin
  Result:=oTable.FieldByName('RegTel').AsString;
end;

procedure TParcatHnd.SetRegTel(pValue:Str20);
begin
  oTable.FieldByName('RegTel').AsString:=pValue;
end;

function TParcatHnd.GetRegEml:Str30;
begin
  Result:=oTable.FieldByName('RegEml').AsString;
end;

procedure TParcatHnd.SetRegEml(pValue:Str30);
begin
  oTable.FieldByName('RegEml').AsString:=pValue;
end;

function TParcatHnd.GetEmgNam:Str30;
begin
  Result:=oTable.FieldByName('HedName').AsString;
end;

procedure TParcatHnd.SetEmgNam(pValue:Str30);
begin
  oTable.FieldByName('HedName').AsString:=pValue;
end;

function TParcatHnd.GetCrpAdr:Str30;
begin
  Result:=oTable.FieldByName('CrpAddr').AsString;
end;

procedure TParcatHnd.SetCrpAdr(pValue:Str30);
begin
  oTable.FieldByName('CrpAddr').AsString:=pValue;
end;

function TParcatHnd.GetCrpStc:Str2;
begin
  Result:=oTable.FieldByName('CrpSta').AsString;
end;

procedure TParcatHnd.SetCrpStc(pValue:Str2);
begin
  oTable.FieldByName('CrpSta').AsString:=pValue;
end;

function TParcatHnd.GetCrpStn:Str30;
begin
  Result:='';
  If not ohSTALST.Active then ohSTALST.Open;
  If ohSTALST.LocateStaCode(CrpStc) then Result:=ohSTALST.StaName;
end;

procedure TParcatHnd.SetCrpStn(pValue:Str2);
begin
  oTable.FieldByName('CrpStn').AsString:=pValue;
end;

function TParcatHnd.GetCrpCtc:Str3;
begin
  Result:=oTable.FieldByName('CrpCty').AsString;
end;

procedure TParcatHnd.SetCrpCtc(pValue:Str3);
begin
  oTable.FieldByName('CrpCty').AsString:=pValue;
end;

function TParcatHnd.GetCrpCtn:Str30;
begin
  Result:=oTable.FieldByName('CrpCtn').AsString;
end;

procedure TParcatHnd.SetCrpCtn(pValue:Str30);
begin
  oTable.FieldByName('CrpCtn').AsString:=pValue;
end;

function TParcatHnd.GetCrpZip:Str10;
begin
  Result:=oTable.FieldByName('CrpZip').AsString;
end;

procedure TParcatHnd.SetCrpZip(pValue:Str10);
begin
  oTable.FieldByName('CrpZip').AsString:=pValue;
end;

function TParcatHnd.GetSpiPer:Str15;
begin
  Result:=oTable.FieldByName('SrCode').AsString;
end;

procedure TParcatHnd.SetSpiPer(pValue:Str15);
begin
  oTable.FieldByName('SrCode').AsString:=pValue;
end;

function TParcatHnd.GetPrnLng:Str2;
begin
  Result:=oTable.FieldByName('PrnLng').AsString;
end;

procedure TParcatHnd.SetPrnLng(pValue:Str2);
begin
  oTable.FieldByName('PrnLng').AsString:=pValue;
end;

function TParcatHnd.GetBanNam:Str30;
begin
  Result:=oTable.FieldByName('ContoNum').AsString;
end;

procedure TParcatHnd.SetBanNam(pValue:Str30);
begin
  oTable.FieldByName('ContoNum').AsString:=pValue;
end;

function TParcatHnd.GetIbaCod:Str34;
begin
  Result:=oTable.FieldByName('IbanCode').AsString;
end;

procedure TParcatHnd.SetIbaCod(pValue:Str34);
begin
  oTable.FieldByName('IbanCode').AsString:=pValue;
end;

function TParcatHnd.GetSwfCod:Str20;
begin
  Result:=oTable.FieldByName('SwftCode').AsString;
end;

procedure TParcatHnd.SetSwfCod(pValue:Str20);
begin
  oTable.FieldByName('SwftCode').AsString:=pValue;
end;

function TParcatHnd.GetBacQnt:byte;
begin
  Result:=oTable.FieldByName('ContoQnt').AsInteger;
end;

procedure TParcatHnd.SetBacQnt(pValue:byte);
begin
  oTable.FieldByName('ContoQnt').AsInteger:=pValue;
end;

function TParcatHnd.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('IcDscPrc').AsFloat;
end;

procedure TParcatHnd.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('IcDscPrc').AsFloat:=pValue;
end;

function TParcatHnd.GetExpDay:word;
begin
  Result:=oTable.FieldByName('IcExpDay').AsInteger;
end;

procedure TParcatHnd.SetExpDay(pValue:word);
begin
  oTable.FieldByName('IcExpDay').AsInteger:=pValue;
end;

function TParcatHnd.GetPenPrc:double;
begin
  Result:=oTable.FieldByName('IcPenPrc').AsFloat;
end;

procedure TParcatHnd.SetPenPrc(pValue:double);
begin
  oTable.FieldByName('IcPenPrc').AsFloat:=pValue;
end;

function TParcatHnd.GetPlsNum:word;
begin
  Result:=oTable.FieldByName('IcPlsNum').AsInteger;
end;

procedure TParcatHnd.SetPlsNum(pValue:word);
begin
  oTable.FieldByName('IcPlsNum').AsInteger:=pValue;
end;

function TParcatHnd.GetAplNum:word;
begin
  Result:=oTable.FieldByName('IcAplNum').AsInteger;
end;

procedure TParcatHnd.SetAplNum(pValue:word);
begin
  oTable.FieldByName('IcAplNum').AsInteger:=pValue;
end;

function TParcatHnd.GetSalLim:double;
begin
  Result:=oTable.FieldByName('IcSalLim').AsFloat;
end;

procedure TParcatHnd.SetSalLim(pValue:double);
begin
  oTable.FieldByName('IcSalLim').AsFloat:=pValue;
end;

function TParcatHnd.GetVatPay:byte;
begin
  Result:=oTable.FieldByName('VatPay').AsInteger;
end;

procedure TParcatHnd.SetVatPay(pValue:byte);
begin
  oTable.FieldByName('VatPay').AsInteger:=pValue;
end;

function TParcatHnd.GetOrgTyp:byte;
begin
  Result:=oTable.FieldByName('OrgType').AsInteger;
end;

procedure TParcatHnd.SetOrgTyp(pValue:byte);
begin
  oTable.FieldByName('OrgType').AsInteger:=pValue;
end;

function TParcatHnd.GetWpaQnt:word;
begin
  Result:=oTable.FieldByName('PasQnt').AsInteger;
end;

procedure TParcatHnd.SetWpaQnt(pValue:word);
begin
  oTable.FieldByName('PasQnt').AsInteger:=pValue;
end;

function TParcatHnd.GetBonCnv:word;
begin
  Result:=oTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TParcatHnd.SetBonCnv(pValue:word);
begin
  oTable.FieldByName('IcFacDay').AsInteger:=pValue;
end;

function TParcatHnd.GetBonClc:byte;
begin
  Result:=oTable.FieldByName('BonClc').AsInteger;
end;

procedure TParcatHnd.SetBonClc(pValue:byte);
begin
  oTable.FieldByName('BonClc').AsInteger:=pValue;
end;

function TParcatHnd.GetCusPayCod:Str3;
begin
  Result:=oTable.FieldByName('IcPayCode').AsString;
end;

procedure TParcatHnd.SetCusPayCod(pValue:Str3);
begin
  oTable.FieldByName('IcPayCode').AsString:=pValue;
end;

function TParcatHnd.GetCusPayNam:Str20;
begin
  Result:=oTable.FieldByName('IcPayName').AsString;
end;

procedure TParcatHnd.SetCusPayNam(pValue:Str20);
begin
  oTable.FieldByName('IcPayName').AsString:=pValue;
end;

function TParcatHnd.GetCusPayBrm:Str1;
begin
  If oTable.FieldByName('IcPayBrm').AsInteger=1
    then Result:='B'
    else Result:='H';
end;

procedure TParcatHnd.SetCusPayBrm(pValue:Str1);
begin
  If pValue='B'
    then oTable.FieldByName('IcPayBrm').AsInteger:=1
    else oTable.FieldByName('IcPayBrm').AsInteger:=0;
end;

function TParcatHnd.GetCusTrsCod:Str3;
begin
  Result:=oTable.FieldByName('IcTrsCode').AsString;
end;

procedure TParcatHnd.SetCusTrsCod(pValue:Str3);
begin
  oTable.FieldByName('IcTrsCode').AsString:=pValue;
end;

function TParcatHnd.GetCusTrsNam:Str20;
begin
  Result:=oTable.FieldByName('IcTrsName').AsString;
end;

procedure TParcatHnd.SetCusTrsNam(pValue:Str20);
begin
  oTable.FieldByName('IcTrsName').AsString:=pValue;
end;

function TParcatHnd.GetHedNam:Str30;
begin
  Result:=oTable.FieldByName('HedName').AsString;
end;

procedure TParcatHnd.SetHedNam(pValue:Str30);
begin
  oTable.FieldByName('HedName').AsString:=pValue;
end;

function TParcatHnd.GetDlrNum:word;
begin
  Result:=oTable.FieldByName('DlrCode').AsInteger;
end;

procedure TParcatHnd.SetDlrNum(pValue:word);
begin
  oTable.FieldByName('DlrCode').AsInteger:=pValue;
end;

function TParcatHnd.GetCrtUsr:word;
begin
//  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TParcatHnd.SetCrtUsr(pValue:word);
begin
//  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TParcatHnd.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TParcatHnd.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDate').AsDateTime:=pValue;
end;

function TParcatHnd.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TParcatHnd.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTime').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TParcatHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TParcatHnd.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TParcatHnd.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TParcatHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TParcatHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TParcatHnd.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TParcatHnd.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TParcatHnd.LocParIdn(pParIdn:Str10):boolean;
begin
  SetIndex(ixParIdn);
  Result:=oTable.FindKey([pParIdn]);
end;

function TParcatHnd.LocRegIno(pRegIno:Str10):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindKey([pRegIno]);
end;

function TParcatHnd.LocRegTin(pRegTin:Str15):boolean;
begin
  SetIndex(ixRegTin);
  Result:=oTable.FindKey([pRegTin]);
end;

function TParcatHnd.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TParcatHnd.NearParIdn(pParIdn:Str10):boolean;
begin
  SetIndex(ixParIdn);
  Result:=oTable.FindNearest([pParIdn]);
end;

function TParcatHnd.NearRegIno(pRegIno:Str10):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindNearest([pRegIno]);
end;

function TParcatHnd.NearRegTin(pRegTin:Str15):boolean;
begin
  SetIndex(ixRegTin);
  Result:=oTable.FindNearest([pRegTin]);
end;

procedure TParcatHnd.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TParcatHnd.Open;
begin
  If not oTable.Active then oTable.Open(0);
end;

procedure TParcatHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TParcatHnd.Prior;
begin
  oTable.Prior;
end;

procedure TParcatHnd.Next;
begin
  oTable.Next;
end;

procedure TParcatHnd.First;
begin
  oTable.First;
end;

procedure TParcatHnd.Last;
begin
  oTable.Last;
end;

procedure TParcatHnd.Insert;
begin
  oTable.Insert;
end;

procedure TParcatHnd.Edit;
begin
  oTable.Edit;
end;

procedure TParcatHnd.Post;
begin
  oTable.Post;
end;

procedure TParcatHnd.Delete;
begin
  oTable.Delete;
end;

procedure TParcatHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TParcatHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TParcatHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TParcatHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TParcatHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TParcatHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
