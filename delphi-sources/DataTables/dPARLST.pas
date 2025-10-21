unit dPARLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPtPn='PtPn';
  ixParTyp='ParTyp';
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixSapSta='SapSta';
  ixCusSta='CusSta';

type
  TParlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParTyp:Str1;             procedure SetParTyp(pValue:Str1);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetPagNum:longint;          procedure SetPagNum(pValue:longint);
    function GetSchNam:Str10;            procedure SetSchNam(pValue:Str10);
    function GetRegNam:Str100;           procedure SetRegNam(pValue:Str100);
    function GetRegIno:Str10;            procedure SetRegIno(pValue:Str10);
    function GetRegTin:Str15;            procedure SetRegTin(pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin(pValue:Str15);
    function GetRegAdr:Str50;            procedure SetRegAdr(pValue:Str50);
    function GetRegSta:Str2;             procedure SetRegSta(pValue:Str2);
    function GetRegCty:Str3;             procedure SetRegCty(pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn(pValue:Str30);
    function GetRegZip:Str10;            procedure SetRegZip(pValue:Str10);
    function GetRegRec:Str100;           procedure SetRegRec(pValue:Str100);
    function GetCrpAdr:Str50;            procedure SetCrpAdr(pValue:Str50);
    function GetCrpSta:Str2;             procedure SetCrpSta(pValue:Str2);
    function GetCrpCty:Str3;             procedure SetCrpCty(pValue:Str3);
    function GetCrpCtn:Str30;            procedure SetCrpCtn(pValue:Str30);
    function GetCrpZip:Str10;            procedure SetCrpZip(pValue:Str10);
    function GetCrpFax:Str20;            procedure SetCrpFax(pValue:Str20);
    function GetCrpEml:Str30;            procedure SetCrpEml(pValue:Str30);
    function GetComTyp:Str1;             procedure SetComTyp(pValue:Str1);
    function GetIbnNum:Str34;            procedure SetIbnNum(pValue:Str34);
    function GetBicCod:Str8;             procedure SetBicCod(pValue:Str8);
    function GetWpaQnt:word;             procedure SetWpaQnt(pValue:word);
    function GetDlrNum:word;             procedure SetDlrNum(pValue:word);
    function GetWebSit:Str30;            procedure SetWebSit(pValue:Str30);
    function GetSprCer:Str15;            procedure SetSprCer(pValue:Str15);
    function GetPrnLng:Str2;             procedure SetPrnLng(pValue:Str2);
    function GetVatSta:byte;             procedure SetVatSta(pValue:byte);
    function GetShpSta:byte;             procedure SetShpSta(pValue:byte);
    function GetSapSta:byte;             procedure SetSapSta(pValue:byte);
    function GetSapRel:byte;             procedure SetSapRel(pValue:byte);
    function GetCusSta:byte;             procedure SetCusSta(pValue:byte);
    function GetCusRel:byte;             procedure SetCusRel(pValue:byte);
    function GetOsdEml:Str30;            procedure SetOsdEml(pValue:Str30);
    function GetIsdExd:word;             procedure SetIsdExd(pValue:word);
    function GetBuyDvz:Str3;             procedure SetBuyDvz(pValue:Str3);
    function GetBuyRdy:byte;             procedure SetBuyRdy(pValue:byte);
    function GetBuyMva:double;           procedure SetBuyMva(pValue:double);
    function GetBuyPds:double;           procedure SetBuyPds(pValue:double);
    function GetBuyBrm:byte;             procedure SetBuyBrm(pValue:byte);
    function GetBuyLim:double;           procedure SetBuyLim(pValue:double);
    function GetBuyPyc:Str1;             procedure SetBuyPyc(pValue:Str1);
    function GetBuyPyn:Str20;            procedure SetBuyPyn(pValue:Str20);
    function GetBuyTrc:Str1;             procedure SetBuyTrc(pValue:Str1);
    function GetBuyTrn:Str20;            procedure SetBuyTrn(pValue:Str20);
    function GetBuyPen:double;           procedure SetBuyPen(pValue:double);
    function GetBuyDis:byte;             procedure SetBuyDis(pValue:byte);
    function GetPlsNum:word;             procedure SetPlsNum(pValue:word);
    function GetAplNum:word;             procedure SetAplNum(pValue:word);
    function GetSalLev:byte;             procedure SetSalLev(pValue:byte);
    function GetSalBrm:byte;             procedure SetSalBrm(pValue:byte);
    function GetSalLim:double;           procedure SetSalLim(pValue:double);
    function GetSalPyc:Str1;             procedure SetSalPyc(pValue:Str1);
    function GetSalPyn:Str20;            procedure SetSalPyn(pValue:Str20);
    function GetSalTrc:Str1;             procedure SetSalTrc(pValue:Str1);
    function GetSalTrn:Str20;            procedure SetSalTrn(pValue:Str20);
    function GetSalDsc:double;           procedure SetSalDsc(pValue:double);
    function GetSalPen:double;           procedure SetSalPen(pValue:double);
    function GetSalExc:Str15;            procedure SetSalExc(pValue:Str15);
    function GetBonCnv:word;             procedure SetBonCnv(pValue:word);
    function GetPayDly:word;             procedure SetPayDly(pValue:word);
    function GetIcdEml:Str30;            procedure SetIcdEml(pValue:Str30);
    function GetIcdExd:word;             procedure SetIcdExd(pValue:word);
    function GetIcdRmd:byte;             procedure SetIcdRmd(pValue:byte);
    function GetAdvPay:double;           procedure SetAdvPay(pValue:double);
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
    function LocPtPn(pParTyp:Str1;pParNum:longint):boolean;
    function LocParTyp(pParTyp:Str1):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocSapSta(pSapSta:byte):boolean;
    function LocCusSta(pCusSta:byte):boolean;
    function NearPtPn(pParTyp:Str1;pParNum:longint):boolean;
    function NearParTyp(pParTyp:Str1):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearSapSta(pSapSta:byte):boolean;
    function NearCusSta(pCusSta:byte):boolean;

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
    property ParTyp:Str1 read GetParTyp write SetParTyp;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property PagNum:longint read GetPagNum write SetPagNum;
    property SchNam:Str10 read GetSchNam write SetSchNam;
    property RegNam:Str100 read GetRegNam write SetRegNam;
    property RegIno:Str10 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str50 read GetRegAdr write SetRegAdr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str10 read GetRegZip write SetRegZip;
    property RegRec:Str100 read GetRegRec write SetRegRec;
    property CrpAdr:Str50 read GetCrpAdr write SetCrpAdr;
    property CrpSta:Str2 read GetCrpSta write SetCrpSta;
    property CrpCty:Str3 read GetCrpCty write SetCrpCty;
    property CrpCtn:Str30 read GetCrpCtn write SetCrpCtn;
    property CrpZip:Str10 read GetCrpZip write SetCrpZip;
    property CrpFax:Str20 read GetCrpFax write SetCrpFax;
    property CrpEml:Str30 read GetCrpEml write SetCrpEml;
    property ComTyp:Str1 read GetComTyp write SetComTyp;
    property IbnNum:Str34 read GetIbnNum write SetIbnNum;
    property BicCod:Str8 read GetBicCod write SetBicCod;
    property WpaQnt:word read GetWpaQnt write SetWpaQnt;
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property WebSit:Str30 read GetWebSit write SetWebSit;
    property SprCer:Str15 read GetSprCer write SetSprCer;
    property PrnLng:Str2 read GetPrnLng write SetPrnLng;
    property VatSta:byte read GetVatSta write SetVatSta;
    property ShpSta:byte read GetShpSta write SetShpSta;
    property SapSta:byte read GetSapSta write SetSapSta;
    property SapRel:byte read GetSapRel write SetSapRel;
    property CusSta:byte read GetCusSta write SetCusSta;
    property CusRel:byte read GetCusRel write SetCusRel;
    property OsdEml:Str30 read GetOsdEml write SetOsdEml;
    property IsdExd:word read GetIsdExd write SetIsdExd;
    property BuyDvz:Str3 read GetBuyDvz write SetBuyDvz;
    property BuyRdy:byte read GetBuyRdy write SetBuyRdy;
    property BuyMva:double read GetBuyMva write SetBuyMva;
    property BuyPds:double read GetBuyPds write SetBuyPds;
    property BuyBrm:byte read GetBuyBrm write SetBuyBrm;
    property BuyLim:double read GetBuyLim write SetBuyLim;
    property BuyPyc:Str1 read GetBuyPyc write SetBuyPyc;
    property BuyPyn:Str20 read GetBuyPyn write SetBuyPyn;
    property BuyTrc:Str1 read GetBuyTrc write SetBuyTrc;
    property BuyTrn:Str20 read GetBuyTrn write SetBuyTrn;
    property BuyPen:double read GetBuyPen write SetBuyPen;
    property BuyDis:byte read GetBuyDis write SetBuyDis;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property AplNum:word read GetAplNum write SetAplNum;
    property SalLev:byte read GetSalLev write SetSalLev;
    property SalBrm:byte read GetSalBrm write SetSalBrm;
    property SalLim:double read GetSalLim write SetSalLim;
    property SalPyc:Str1 read GetSalPyc write SetSalPyc;
    property SalPyn:Str20 read GetSalPyn write SetSalPyn;
    property SalTrc:Str1 read GetSalTrc write SetSalTrc;
    property SalTrn:Str20 read GetSalTrn write SetSalTrn;
    property SalDsc:double read GetSalDsc write SetSalDsc;
    property SalPen:double read GetSalPen write SetSalPen;
    property SalExc:Str15 read GetSalExc write SetSalExc;
    property BonCnv:word read GetBonCnv write SetBonCnv;
    property PayDly:word read GetPayDly write SetPayDly;
    property IcdEml:Str30 read GetIcdEml write SetIcdEml;
    property IcdExd:word read GetIcdExd write SetIcdExd;
    property IcdRmd:byte read GetIcdRmd write SetIcdRmd;
    property AdvPay:double read GetAdvPay write SetAdvPay;
  end;

implementation

constructor TParlstDat.Create;
begin
  oTable:=DatInit('PARLST',gPath.DlsPath,Self);
end;

constructor TParlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('PARLST',pPath,Self);
end;

destructor TParlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TParlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TParlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TParlstDat.GetParTyp:Str1;
begin
  Result:=oTable.FieldByName('ParTyp').AsString;
end;

procedure TParlstDat.SetParTyp(pValue:Str1);
begin
  oTable.FieldByName('ParTyp').AsString:=pValue;
end;

function TParlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TParlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TParlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TParlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TParlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TParlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TParlstDat.GetPagNum:longint;
begin
  Result:=oTable.FieldByName('PagNum').AsInteger;
end;

procedure TParlstDat.SetPagNum(pValue:longint);
begin
  oTable.FieldByName('PagNum').AsInteger:=pValue;
end;

function TParlstDat.GetSchNam:Str10;
begin
  Result:=oTable.FieldByName('SchNam').AsString;
end;

procedure TParlstDat.SetSchNam(pValue:Str10);
begin
  oTable.FieldByName('SchNam').AsString:=pValue;
end;

function TParlstDat.GetRegNam:Str100;
begin
  Result:=oTable.FieldByName('RegNam').AsString;
end;

procedure TParlstDat.SetRegNam(pValue:Str100);
begin
  oTable.FieldByName('RegNam').AsString:=pValue;
end;

function TParlstDat.GetRegIno:Str10;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TParlstDat.SetRegIno(pValue:Str10);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TParlstDat.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TParlstDat.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TParlstDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TParlstDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TParlstDat.GetRegAdr:Str50;
begin
  Result:=oTable.FieldByName('RegAdr').AsString;
end;

procedure TParlstDat.SetRegAdr(pValue:Str50);
begin
  oTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TParlstDat.GetRegSta:Str2;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TParlstDat.SetRegSta(pValue:Str2);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TParlstDat.GetRegCty:Str3;
begin
  Result:=oTable.FieldByName('RegCty').AsString;
end;

procedure TParlstDat.SetRegCty(pValue:Str3);
begin
  oTable.FieldByName('RegCty').AsString:=pValue;
end;

function TParlstDat.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TParlstDat.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TParlstDat.GetRegZip:Str10;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TParlstDat.SetRegZip(pValue:Str10);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TParlstDat.GetRegRec:Str100;
begin
  Result:=oTable.FieldByName('RegRec').AsString;
end;

procedure TParlstDat.SetRegRec(pValue:Str100);
begin
  oTable.FieldByName('RegRec').AsString:=pValue;
end;

function TParlstDat.GetCrpAdr:Str50;
begin
  Result:=oTable.FieldByName('CrpAdr').AsString;
end;

procedure TParlstDat.SetCrpAdr(pValue:Str50);
begin
  oTable.FieldByName('CrpAdr').AsString:=pValue;
end;

function TParlstDat.GetCrpSta:Str2;
begin
  Result:=oTable.FieldByName('CrpSta').AsString;
end;

procedure TParlstDat.SetCrpSta(pValue:Str2);
begin
  oTable.FieldByName('CrpSta').AsString:=pValue;
end;

function TParlstDat.GetCrpCty:Str3;
begin
  Result:=oTable.FieldByName('CrpCty').AsString;
end;

procedure TParlstDat.SetCrpCty(pValue:Str3);
begin
  oTable.FieldByName('CrpCty').AsString:=pValue;
end;

function TParlstDat.GetCrpCtn:Str30;
begin
  Result:=oTable.FieldByName('CrpCtn').AsString;
end;

procedure TParlstDat.SetCrpCtn(pValue:Str30);
begin
  oTable.FieldByName('CrpCtn').AsString:=pValue;
end;

function TParlstDat.GetCrpZip:Str10;
begin
  Result:=oTable.FieldByName('CrpZip').AsString;
end;

procedure TParlstDat.SetCrpZip(pValue:Str10);
begin
  oTable.FieldByName('CrpZip').AsString:=pValue;
end;

function TParlstDat.GetCrpFax:Str20;
begin
  Result:=oTable.FieldByName('CrpFax').AsString;
end;

procedure TParlstDat.SetCrpFax(pValue:Str20);
begin
  oTable.FieldByName('CrpFax').AsString:=pValue;
end;

function TParlstDat.GetCrpEml:Str30;
begin
  Result:=oTable.FieldByName('CrpEml').AsString;
end;

procedure TParlstDat.SetCrpEml(pValue:Str30);
begin
  oTable.FieldByName('CrpEml').AsString:=pValue;
end;

function TParlstDat.GetComTyp:Str1;
begin
  Result:=oTable.FieldByName('ComTyp').AsString;
end;

procedure TParlstDat.SetComTyp(pValue:Str1);
begin
  oTable.FieldByName('ComTyp').AsString:=pValue;
end;

function TParlstDat.GetIbnNum:Str34;
begin
  Result:=oTable.FieldByName('IbnNum').AsString;
end;

procedure TParlstDat.SetIbnNum(pValue:Str34);
begin
  oTable.FieldByName('IbnNum').AsString:=pValue;
end;

function TParlstDat.GetBicCod:Str8;
begin
  Result:=oTable.FieldByName('BicCod').AsString;
end;

procedure TParlstDat.SetBicCod(pValue:Str8);
begin
  oTable.FieldByName('BicCod').AsString:=pValue;
end;

function TParlstDat.GetWpaQnt:word;
begin
  Result:=oTable.FieldByName('WpaQnt').AsInteger;
end;

procedure TParlstDat.SetWpaQnt(pValue:word);
begin
  oTable.FieldByName('WpaQnt').AsInteger:=pValue;
end;

function TParlstDat.GetDlrNum:word;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TParlstDat.SetDlrNum(pValue:word);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TParlstDat.GetWebSit:Str30;
begin
  Result:=oTable.FieldByName('WebSit').AsString;
end;

procedure TParlstDat.SetWebSit(pValue:Str30);
begin
  oTable.FieldByName('WebSit').AsString:=pValue;
end;

function TParlstDat.GetSprCer:Str15;
begin
  Result:=oTable.FieldByName('SprCer').AsString;
end;

procedure TParlstDat.SetSprCer(pValue:Str15);
begin
  oTable.FieldByName('SprCer').AsString:=pValue;
end;

function TParlstDat.GetPrnLng:Str2;
begin
  Result:=oTable.FieldByName('PrnLng').AsString;
end;

procedure TParlstDat.SetPrnLng(pValue:Str2);
begin
  oTable.FieldByName('PrnLng').AsString:=pValue;
end;

function TParlstDat.GetVatSta:byte;
begin
  Result:=oTable.FieldByName('VatSta').AsInteger;
end;

procedure TParlstDat.SetVatSta(pValue:byte);
begin
  oTable.FieldByName('VatSta').AsInteger:=pValue;
end;

function TParlstDat.GetShpSta:byte;
begin
  Result:=oTable.FieldByName('ShpSta').AsInteger;
end;

procedure TParlstDat.SetShpSta(pValue:byte);
begin
  oTable.FieldByName('ShpSta').AsInteger:=pValue;
end;

function TParlstDat.GetSapSta:byte;
begin
  Result:=oTable.FieldByName('SapSta').AsInteger;
end;

procedure TParlstDat.SetSapSta(pValue:byte);
begin
  oTable.FieldByName('SapSta').AsInteger:=pValue;
end;

function TParlstDat.GetSapRel:byte;
begin
  Result:=oTable.FieldByName('SapRel').AsInteger;
end;

procedure TParlstDat.SetSapRel(pValue:byte);
begin
  oTable.FieldByName('SapRel').AsInteger:=pValue;
end;

function TParlstDat.GetCusSta:byte;
begin
  Result:=oTable.FieldByName('CusSta').AsInteger;
end;

procedure TParlstDat.SetCusSta(pValue:byte);
begin
  oTable.FieldByName('CusSta').AsInteger:=pValue;
end;

function TParlstDat.GetCusRel:byte;
begin
  Result:=oTable.FieldByName('CusRel').AsInteger;
end;

procedure TParlstDat.SetCusRel(pValue:byte);
begin
  oTable.FieldByName('CusRel').AsInteger:=pValue;
end;

function TParlstDat.GetOsdEml:Str30;
begin
  Result:=oTable.FieldByName('OsdEml').AsString;
end;

procedure TParlstDat.SetOsdEml(pValue:Str30);
begin
  oTable.FieldByName('OsdEml').AsString:=pValue;
end;

function TParlstDat.GetIsdExd:word;
begin
  Result:=oTable.FieldByName('IsdExd').AsInteger;
end;

procedure TParlstDat.SetIsdExd(pValue:word);
begin
  oTable.FieldByName('IsdExd').AsInteger:=pValue;
end;

function TParlstDat.GetBuyDvz:Str3;
begin
  Result:=oTable.FieldByName('BuyDvz').AsString;
end;

procedure TParlstDat.SetBuyDvz(pValue:Str3);
begin
  oTable.FieldByName('BuyDvz').AsString:=pValue;
end;

function TParlstDat.GetBuyRdy:byte;
begin
  Result:=oTable.FieldByName('BuyRdy').AsInteger;
end;

procedure TParlstDat.SetBuyRdy(pValue:byte);
begin
  oTable.FieldByName('BuyRdy').AsInteger:=pValue;
end;

function TParlstDat.GetBuyMva:double;
begin
  Result:=oTable.FieldByName('BuyMva').AsFloat;
end;

procedure TParlstDat.SetBuyMva(pValue:double);
begin
  oTable.FieldByName('BuyMva').AsFloat:=pValue;
end;

function TParlstDat.GetBuyPds:double;
begin
  Result:=oTable.FieldByName('BuyPds').AsFloat;
end;

procedure TParlstDat.SetBuyPds(pValue:double);
begin
  oTable.FieldByName('BuyPds').AsFloat:=pValue;
end;

function TParlstDat.GetBuyBrm:byte;
begin
  Result:=oTable.FieldByName('BuyBrm').AsInteger;
end;

procedure TParlstDat.SetBuyBrm(pValue:byte);
begin
  oTable.FieldByName('BuyBrm').AsInteger:=pValue;
end;

function TParlstDat.GetBuyLim:double;
begin
  Result:=oTable.FieldByName('BuyLim').AsFloat;
end;

procedure TParlstDat.SetBuyLim(pValue:double);
begin
  oTable.FieldByName('BuyLim').AsFloat:=pValue;
end;

function TParlstDat.GetBuyPyc:Str1;
begin
  Result:=oTable.FieldByName('BuyPyc').AsString;
end;

procedure TParlstDat.SetBuyPyc(pValue:Str1);
begin
  oTable.FieldByName('BuyPyc').AsString:=pValue;
end;

function TParlstDat.GetBuyPyn:Str20;
begin
  Result:=oTable.FieldByName('BuyPyn').AsString;
end;

procedure TParlstDat.SetBuyPyn(pValue:Str20);
begin
  oTable.FieldByName('BuyPyn').AsString:=pValue;
end;

function TParlstDat.GetBuyTrc:Str1;
begin
  Result:=oTable.FieldByName('BuyTrc').AsString;
end;

procedure TParlstDat.SetBuyTrc(pValue:Str1);
begin
  oTable.FieldByName('BuyTrc').AsString:=pValue;
end;

function TParlstDat.GetBuyTrn:Str20;
begin
  Result:=oTable.FieldByName('BuyTrn').AsString;
end;

procedure TParlstDat.SetBuyTrn(pValue:Str20);
begin
  oTable.FieldByName('BuyTrn').AsString:=pValue;
end;

function TParlstDat.GetBuyPen:double;
begin
  Result:=oTable.FieldByName('BuyPen').AsFloat;
end;

procedure TParlstDat.SetBuyPen(pValue:double);
begin
  oTable.FieldByName('BuyPen').AsFloat:=pValue;
end;

function TParlstDat.GetBuyDis:byte;
begin
  Result:=oTable.FieldByName('BuyDis').AsInteger;
end;

procedure TParlstDat.SetBuyDis(pValue:byte);
begin
  oTable.FieldByName('BuyDis').AsInteger:=pValue;
end;

function TParlstDat.GetPlsNum:word;
begin
  Result:=oTable.FieldByName('PlsNum').AsInteger;
end;

procedure TParlstDat.SetPlsNum(pValue:word);
begin
  oTable.FieldByName('PlsNum').AsInteger:=pValue;
end;

function TParlstDat.GetAplNum:word;
begin
  Result:=oTable.FieldByName('AplNum').AsInteger;
end;

procedure TParlstDat.SetAplNum(pValue:word);
begin
  oTable.FieldByName('AplNum').AsInteger:=pValue;
end;

function TParlstDat.GetSalLev:byte;
begin
  Result:=oTable.FieldByName('SalLev').AsInteger;
end;

procedure TParlstDat.SetSalLev(pValue:byte);
begin
  oTable.FieldByName('SalLev').AsInteger:=pValue;
end;

function TParlstDat.GetSalBrm:byte;
begin
  Result:=oTable.FieldByName('SalBrm').AsInteger;
end;

procedure TParlstDat.SetSalBrm(pValue:byte);
begin
  oTable.FieldByName('SalBrm').AsInteger:=pValue;
end;

function TParlstDat.GetSalLim:double;
begin
  Result:=oTable.FieldByName('SalLim').AsFloat;
end;

procedure TParlstDat.SetSalLim(pValue:double);
begin
  oTable.FieldByName('SalLim').AsFloat:=pValue;
end;

function TParlstDat.GetSalPyc:Str1;
begin
  Result:=oTable.FieldByName('SalPyc').AsString;
end;

procedure TParlstDat.SetSalPyc(pValue:Str1);
begin
  oTable.FieldByName('SalPyc').AsString:=pValue;
end;

function TParlstDat.GetSalPyn:Str20;
begin
  Result:=oTable.FieldByName('SalPyn').AsString;
end;

procedure TParlstDat.SetSalPyn(pValue:Str20);
begin
  oTable.FieldByName('SalPyn').AsString:=pValue;
end;

function TParlstDat.GetSalTrc:Str1;
begin
  Result:=oTable.FieldByName('SalTrc').AsString;
end;

procedure TParlstDat.SetSalTrc(pValue:Str1);
begin
  oTable.FieldByName('SalTrc').AsString:=pValue;
end;

function TParlstDat.GetSalTrn:Str20;
begin
  Result:=oTable.FieldByName('SalTrn').AsString;
end;

procedure TParlstDat.SetSalTrn(pValue:Str20);
begin
  oTable.FieldByName('SalTrn').AsString:=pValue;
end;

function TParlstDat.GetSalDsc:double;
begin
  Result:=oTable.FieldByName('SalDsc').AsFloat;
end;

procedure TParlstDat.SetSalDsc(pValue:double);
begin
  oTable.FieldByName('SalDsc').AsFloat:=pValue;
end;

function TParlstDat.GetSalPen:double;
begin
  Result:=oTable.FieldByName('SalPen').AsFloat;
end;

procedure TParlstDat.SetSalPen(pValue:double);
begin
  oTable.FieldByName('SalPen').AsFloat:=pValue;
end;

function TParlstDat.GetSalExc:Str15;
begin
  Result:=oTable.FieldByName('SalExc').AsString;
end;

procedure TParlstDat.SetSalExc(pValue:Str15);
begin
  oTable.FieldByName('SalExc').AsString:=pValue;
end;

function TParlstDat.GetBonCnv:word;
begin
  Result:=oTable.FieldByName('BonCnv').AsInteger;
end;

procedure TParlstDat.SetBonCnv(pValue:word);
begin
  oTable.FieldByName('BonCnv').AsInteger:=pValue;
end;

function TParlstDat.GetPayDly:word;
begin
  Result:=oTable.FieldByName('PayDly').AsInteger;
end;

procedure TParlstDat.SetPayDly(pValue:word);
begin
  oTable.FieldByName('PayDly').AsInteger:=pValue;
end;

function TParlstDat.GetIcdEml:Str30;
begin
  Result:=oTable.FieldByName('IcdEml').AsString;
end;

procedure TParlstDat.SetIcdEml(pValue:Str30);
begin
  oTable.FieldByName('IcdEml').AsString:=pValue;
end;

function TParlstDat.GetIcdExd:word;
begin
  Result:=oTable.FieldByName('IcdExd').AsInteger;
end;

procedure TParlstDat.SetIcdExd(pValue:word);
begin
  oTable.FieldByName('IcdExd').AsInteger:=pValue;
end;

function TParlstDat.GetIcdRmd:byte;
begin
  Result:=oTable.FieldByName('IcdRmd').AsInteger;
end;

procedure TParlstDat.SetIcdRmd(pValue:byte);
begin
  oTable.FieldByName('IcdRmd').AsInteger:=pValue;
end;

function TParlstDat.GetAdvPay:double;
begin
  Result:=oTable.FieldByName('AdvPay').AsFloat;
end;

procedure TParlstDat.SetAdvPay(pValue:double);
begin
  oTable.FieldByName('AdvPay').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TParlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TParlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TParlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TParlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TParlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TParlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TParlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TParlstDat.LocPtPn(pParTyp:Str1;pParNum:longint):boolean;
begin
  SetIndex(ixPtPn);
  Result:=oTable.FindKey([pParTyp,pParNum]);
end;

function TParlstDat.LocParTyp(pParTyp:Str1):boolean;
begin
  SetIndex(ixParTyp);
  Result:=oTable.FindKey([pParTyp]);
end;

function TParlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TParlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TParlstDat.LocSapSta(pSapSta:byte):boolean;
begin
  SetIndex(ixSapSta);
  Result:=oTable.FindKey([pSapSta]);
end;

function TParlstDat.LocCusSta(pCusSta:byte):boolean;
begin
  SetIndex(ixCusSta);
  Result:=oTable.FindKey([pCusSta]);
end;

function TParlstDat.NearPtPn(pParTyp:Str1;pParNum:longint):boolean;
begin
  SetIndex(ixPtPn);
  Result:=oTable.FindNearest([pParTyp,pParNum]);
end;

function TParlstDat.NearParTyp(pParTyp:Str1):boolean;
begin
  SetIndex(ixParTyp);
  Result:=oTable.FindNearest([pParTyp]);
end;

function TParlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TParlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TParlstDat.NearSapSta(pSapSta:byte):boolean;
begin
  SetIndex(ixSapSta);
  Result:=oTable.FindNearest([pSapSta]);
end;

function TParlstDat.NearCusSta(pCusSta:byte):boolean;
begin
  SetIndex(ixCusSta);
  Result:=oTable.FindNearest([pCusSta]);
end;

procedure TParlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TParlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TParlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TParlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TParlstDat.Next;
begin
  oTable.Next;
end;

procedure TParlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TParlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TParlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TParlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TParlstDat.Post;
begin
  oTable.Post;
end;

procedure TParlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TParlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TParlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TParlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TParlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TParlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TParlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
