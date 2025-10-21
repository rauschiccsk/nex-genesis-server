unit bPABRIDGE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCodeO = 'PaCodeO';
  ixPaCodeN = 'PaCodeN';
  ixRegIno = 'RegIno';
  ixRegTin = 'RegTin';
  ixPaName = 'PaName';
  ixSmlName = 'SmlName';
  ixContoNum = 'ContoNum';
  ixIdCode = 'IdCode';
  ixRegSta = 'RegSta';
  ixRegCty = 'RegCty';
  ixPagCode = 'PagCode';
  ixPgcCode = 'PgcCode';
  ixDlrCode = 'DlrCode';
  ixOwnPac = 'OwnPac';
  ixSended = 'Sended';

type
  TPabridgeBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCodeO:longint;       procedure WritePaCodeO (pValue:longint);
    function  ReadPaCodeN:longint;       procedure WritePaCodeN (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadSmlName:Str10;         procedure WriteSmlName (pValue:Str10);
    function  ReadOldTin:Str15;          procedure WriteOldTin (pValue:Str15);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadCrpAddr:Str30;         procedure WriteCrpAddr (pValue:Str30);
    function  ReadCrpSta:Str2;           procedure WriteCrpSta (pValue:Str2);
    function  ReadCrpCty:Str3;           procedure WriteCrpCty (pValue:Str3);
    function  ReadCrpCtn:Str30;          procedure WriteCrpCtn (pValue:Str30);
    function  ReadCrpZip:Str15;          procedure WriteCrpZip (pValue:Str15);
    function  ReadCrpTel:Str20;          procedure WriteCrpTel (pValue:Str20);
    function  ReadCrpFax:Str20;          procedure WriteCrpFax (pValue:Str20);
    function  ReadCrpEml:Str30;          procedure WriteCrpEml (pValue:Str30);
    function  ReadIvcAddr:Str30;         procedure WriteIvcAddr (pValue:Str30);
    function  ReadIvcSta:Str2;           procedure WriteIvcSta (pValue:Str2);
    function  ReadIvcCty:Str3;           procedure WriteIvcCty (pValue:Str3);
    function  ReadIvcCtn:Str30;          procedure WriteIvcCtn (pValue:Str30);
    function  ReadIvcZip:Str15;          procedure WriteIvcZip (pValue:Str15);
    function  ReadIvcTel:Str20;          procedure WriteIvcTel (pValue:Str20);
    function  ReadIvcFax:Str20;          procedure WriteIvcFax (pValue:Str20);
    function  ReadIvcEml:Str30;          procedure WriteIvcEml (pValue:Str30);
    function  ReadWebSite:Str30;         procedure WriteWebSite (pValue:Str30);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankCode:Str15;        procedure WriteBankCode (pValue:Str15);
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadIbanCode:Str34;        procedure WriteIbanCode (pValue:Str34);
    function  ReadSwftCode:Str20;        procedure WriteSwftCode (pValue:Str20);
    function  ReadContoQnt:byte;         procedure WriteContoQnt (pValue:byte);
    function  ReadIsDscPrc:double;       procedure WriteIsDscPrc (pValue:double);
    function  ReadIsExpDay:word;         procedure WriteIsExpDay (pValue:word);
    function  ReadIsPenPrc:double;       procedure WriteIsPenPrc (pValue:double);
    function  ReadIsPayCode:Str3;        procedure WriteIsPayCode (pValue:Str3);
    function  ReadIsPayName:Str20;       procedure WriteIsPayName (pValue:Str20);
    function  ReadIsTrsCode:Str3;        procedure WriteIsTrsCode (pValue:Str3);
    function  ReadIsTrsName:Str20;       procedure WriteIsTrsName (pValue:Str20);
    function  ReadIcDscPrc:double;       procedure WriteIcDscPrc (pValue:double);
    function  ReadIcExpDay:word;         procedure WriteIcExpDay (pValue:word);
    function  ReadIcPenPrc:double;       procedure WriteIcPenPrc (pValue:double);
    function  ReadIcPlsNum:word;         procedure WriteIcPlsNum (pValue:word);
    function  ReadIcPayCode:Str3;        procedure WriteIcPayCode (pValue:Str3);
    function  ReadIcPayName:Str18;       procedure WriteIcPayName (pValue:Str18);
    function  ReadIcPayMode:byte;        procedure WriteIcPayMode (pValue:byte);
    function  ReadIcPayBrm:byte;         procedure WriteIcPayBrm (pValue:byte);
    function  ReadIcTrsCode:Str3;        procedure WriteIcTrsCode (pValue:Str3);
    function  ReadIcTrsName:Str20;       procedure WriteIcTrsName (pValue:Str20);
    function  ReadIcSalLim:double;       procedure WriteIcSalLim (pValue:double);
    function  ReadBuDisStat:byte;        procedure WriteBuDisStat (pValue:byte);
    function  ReadBuDisDate:TDatetime;   procedure WriteBuDisDate (pValue:TDatetime);
    function  ReadBuDisUser:Str8;        procedure WriteBuDisUser (pValue:Str8);
    function  ReadBuDisDesc:Str30;       procedure WriteBuDisDesc (pValue:Str30);
    function  ReadSaDisStat:byte;        procedure WriteSaDisStat (pValue:byte);
    function  ReadSaDisDate:TDatetime;   procedure WriteSaDisDate (pValue:TDatetime);
    function  ReadSaDisUser:Str8;        procedure WriteSaDisUser (pValue:Str8);
    function  ReadSaDisDesc:Str20;       procedure WriteSaDisDesc (pValue:Str20);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadPagCode:word;          procedure WritePagCode (pValue:word);
    function  ReadIdCode:Str20;          procedure WriteIdCode (pValue:Str20);
    function  ReadVatPay:byte;           procedure WriteVatPay (pValue:byte);
    function  ReadSapType:byte;          procedure WriteSapType (pValue:byte);
    function  ReadCusType:byte;          procedure WriteCusType (pValue:byte);
    function  ReadOrgType:byte;          procedure WriteOrgType (pValue:byte);
    function  ReadPasQnt:word;           procedure WritePasQnt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadIcAplNum:word;         procedure WriteIcAplNum (pValue:word);
    function  ReadPgcCode:word;          procedure WritePgcCode (pValue:word);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadTrdType:byte;          procedure WriteTrdType (pValue:byte);
    function  ReadPrnLng:Str2;           procedure WritePrnLng (pValue:Str2);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadHedName:Str30;         procedure WriteHedName (pValue:Str30);
    function  ReadRegRec:Str60;          procedure WriteRegRec (pValue:Str60);
    function  ReadIcExpPrm:word;         procedure WriteIcExpPrm (pValue:word);
    function  ReadOwnPac:longint;        procedure WriteOwnPac (pValue:longint);
    function  ReadSpeLev:byte;           procedure WriteSpeLev (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCodeO (pPaCodeO:longint):boolean;
    function LocatePaCodeN (pPaCodeN:longint):boolean;
    function LocateRegIno (pRegIno:Str15):boolean;
    function LocateRegTin (pRegTin:Str15):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateSmlName (pSmlName:Str10):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;
    function LocateIdCode (pIdCode:Str20):boolean;
    function LocateRegSta (pRegSta:Str2):boolean;
    function LocateRegCty (pRegCty:Str3):boolean;
    function LocatePagCode (pPagCode:word):boolean;
    function LocatePgcCode (pPgcCode:word):boolean;
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateOwnPac (pOwnPac:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestPaCodeO (pPaCodeO:longint):boolean;
    function NearestPaCodeN (pPaCodeN:longint):boolean;
    function NearestRegIno (pRegIno:Str15):boolean;
    function NearestRegTin (pRegTin:Str15):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestSmlName (pSmlName:Str10):boolean;
    function NearestContoNum (pContoNum:Str30):boolean;
    function NearestIdCode (pIdCode:Str20):boolean;
    function NearestRegSta (pRegSta:Str2):boolean;
    function NearestRegCty (pRegCty:Str3):boolean;
    function NearestPagCode (pPagCode:word):boolean;
    function NearestPgcCode (pPgcCode:word):boolean;
    function NearestDlrCode (pDlrCode:word):boolean;
    function NearestOwnPac (pOwnPac:longint):boolean;
    function NearestSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property PaCodeO:longint read ReadPaCodeO write WritePaCodeO;
    property PaCodeN:longint read ReadPaCodeN write WritePaCodeN;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property SmlName:Str10 read ReadSmlName write WriteSmlName;
    property OldTin:Str15 read ReadOldTin write WriteOldTin;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property CrpAddr:Str30 read ReadCrpAddr write WriteCrpAddr;
    property CrpSta:Str2 read ReadCrpSta write WriteCrpSta;
    property CrpCty:Str3 read ReadCrpCty write WriteCrpCty;
    property CrpCtn:Str30 read ReadCrpCtn write WriteCrpCtn;
    property CrpZip:Str15 read ReadCrpZip write WriteCrpZip;
    property CrpTel:Str20 read ReadCrpTel write WriteCrpTel;
    property CrpFax:Str20 read ReadCrpFax write WriteCrpFax;
    property CrpEml:Str30 read ReadCrpEml write WriteCrpEml;
    property IvcAddr:Str30 read ReadIvcAddr write WriteIvcAddr;
    property IvcSta:Str2 read ReadIvcSta write WriteIvcSta;
    property IvcCty:Str3 read ReadIvcCty write WriteIvcCty;
    property IvcCtn:Str30 read ReadIvcCtn write WriteIvcCtn;
    property IvcZip:Str15 read ReadIvcZip write WriteIvcZip;
    property IvcTel:Str20 read ReadIvcTel write WriteIvcTel;
    property IvcFax:Str20 read ReadIvcFax write WriteIvcFax;
    property IvcEml:Str30 read ReadIvcEml write WriteIvcEml;
    property WebSite:Str30 read ReadWebSite write WriteWebSite;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankCode:Str15 read ReadBankCode write WriteBankCode;
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property IbanCode:Str34 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str20 read ReadSwftCode write WriteSwftCode;
    property ContoQnt:byte read ReadContoQnt write WriteContoQnt;
    property IsDscPrc:double read ReadIsDscPrc write WriteIsDscPrc;
    property IsExpDay:word read ReadIsExpDay write WriteIsExpDay;
    property IsPenPrc:double read ReadIsPenPrc write WriteIsPenPrc;
    property IsPayCode:Str3 read ReadIsPayCode write WriteIsPayCode;
    property IsPayName:Str20 read ReadIsPayName write WriteIsPayName;
    property IsTrsCode:Str3 read ReadIsTrsCode write WriteIsTrsCode;
    property IsTrsName:Str20 read ReadIsTrsName write WriteIsTrsName;
    property IcDscPrc:double read ReadIcDscPrc write WriteIcDscPrc;
    property IcExpDay:word read ReadIcExpDay write WriteIcExpDay;
    property IcPenPrc:double read ReadIcPenPrc write WriteIcPenPrc;
    property IcPlsNum:word read ReadIcPlsNum write WriteIcPlsNum;
    property IcPayCode:Str3 read ReadIcPayCode write WriteIcPayCode;
    property IcPayName:Str18 read ReadIcPayName write WriteIcPayName;
    property IcPayMode:byte read ReadIcPayMode write WriteIcPayMode;
    property IcPayBrm:byte read ReadIcPayBrm write WriteIcPayBrm;
    property IcTrsCode:Str3 read ReadIcTrsCode write WriteIcTrsCode;
    property IcTrsName:Str20 read ReadIcTrsName write WriteIcTrsName;
    property IcSalLim:double read ReadIcSalLim write WriteIcSalLim;
    property BuDisStat:byte read ReadBuDisStat write WriteBuDisStat;
    property BuDisDate:TDatetime read ReadBuDisDate write WriteBuDisDate;
    property BuDisUser:Str8 read ReadBuDisUser write WriteBuDisUser;
    property BuDisDesc:Str30 read ReadBuDisDesc write WriteBuDisDesc;
    property SaDisStat:byte read ReadSaDisStat write WriteSaDisStat;
    property SaDisDate:TDatetime read ReadSaDisDate write WriteSaDisDate;
    property SaDisUser:Str8 read ReadSaDisUser write WriteSaDisUser;
    property SaDisDesc:Str20 read ReadSaDisDesc write WriteSaDisDesc;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property PagCode:word read ReadPagCode write WritePagCode;
    property IdCode:Str20 read ReadIdCode write WriteIdCode;
    property VatPay:byte read ReadVatPay write WriteVatPay;
    property SapType:byte read ReadSapType write WriteSapType;
    property CusType:byte read ReadCusType write WriteCusType;
    property OrgType:byte read ReadOrgType write WriteOrgType;
    property PasQnt:word read ReadPasQnt write WritePasQnt;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property IcAplNum:word read ReadIcAplNum write WriteIcAplNum;
    property PgcCode:word read ReadPgcCode write WritePgcCode;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property TrdType:byte read ReadTrdType write WriteTrdType;
    property PrnLng:Str2 read ReadPrnLng write WritePrnLng;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property HedName:Str30 read ReadHedName write WriteHedName;
    property RegRec:Str60 read ReadRegRec write WriteRegRec;
    property IcExpPrm:word read ReadIcExpPrm write WriteIcExpPrm;
    property OwnPac:longint read ReadOwnPac write WriteOwnPac;
    property SpeLev:byte read ReadSpeLev write WriteSpeLev;
  end;

implementation

constructor TPabridgeBtr.Create;
begin
  oBtrTable := BtrInit ('PABRIDGE',gPath.DlsPath,Self);
end;

constructor TPabridgeBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PABRIDGE',pPath,Self);
end;

destructor TPabridgeBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPabridgeBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPabridgeBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPabridgeBtr.ReadPaCodeO:longint;
begin
  Result := oBtrTable.FieldByName('PaCodeO').AsInteger;
end;

procedure TPabridgeBtr.WritePaCodeO(pValue:longint);
begin
  oBtrTable.FieldByName('PaCodeO').AsInteger := pValue;
end;

function TPabridgeBtr.ReadPaCodeN:longint;
begin
  Result := oBtrTable.FieldByName('PaCodeN').AsInteger;
end;

procedure TPabridgeBtr.WritePaCodeN(pValue:longint);
begin
  oBtrTable.FieldByName('PaCodeN').AsInteger := pValue;
end;

function TPabridgeBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TPabridgeBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TPabridgeBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TPabridgeBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TPabridgeBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TPabridgeBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TPabridgeBtr.ReadSmlName:Str10;
begin
  Result := oBtrTable.FieldByName('SmlName').AsString;
end;

procedure TPabridgeBtr.WriteSmlName(pValue:Str10);
begin
  oBtrTable.FieldByName('SmlName').AsString := pValue;
end;

function TPabridgeBtr.ReadOldTin:Str15;
begin
  Result := oBtrTable.FieldByName('OldTin').AsString;
end;

procedure TPabridgeBtr.WriteOldTin(pValue:Str15);
begin
  oBtrTable.FieldByName('OldTin').AsString := pValue;
end;

function TPabridgeBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TPabridgeBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TPabridgeBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TPabridgeBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TPabridgeBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TPabridgeBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TPabridgeBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TPabridgeBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TPabridgeBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TPabridgeBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TPabridgeBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TPabridgeBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TPabridgeBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TPabridgeBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TPabridgeBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TPabridgeBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TPabridgeBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TPabridgeBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TPabridgeBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TPabridgeBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TPabridgeBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TPabridgeBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpAddr:Str30;
begin
  Result := oBtrTable.FieldByName('CrpAddr').AsString;
end;

procedure TPabridgeBtr.WriteCrpAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpAddr').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpSta:Str2;
begin
  Result := oBtrTable.FieldByName('CrpSta').AsString;
end;

procedure TPabridgeBtr.WriteCrpSta(pValue:Str2);
begin
  oBtrTable.FieldByName('CrpSta').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpCty:Str3;
begin
  Result := oBtrTable.FieldByName('CrpCty').AsString;
end;

procedure TPabridgeBtr.WriteCrpCty(pValue:Str3);
begin
  oBtrTable.FieldByName('CrpCty').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpCtn:Str30;
begin
  Result := oBtrTable.FieldByName('CrpCtn').AsString;
end;

procedure TPabridgeBtr.WriteCrpCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpCtn').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpZip:Str15;
begin
  Result := oBtrTable.FieldByName('CrpZip').AsString;
end;

procedure TPabridgeBtr.WriteCrpZip(pValue:Str15);
begin
  oBtrTable.FieldByName('CrpZip').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpTel:Str20;
begin
  Result := oBtrTable.FieldByName('CrpTel').AsString;
end;

procedure TPabridgeBtr.WriteCrpTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CrpTel').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpFax:Str20;
begin
  Result := oBtrTable.FieldByName('CrpFax').AsString;
end;

procedure TPabridgeBtr.WriteCrpFax(pValue:Str20);
begin
  oBtrTable.FieldByName('CrpFax').AsString := pValue;
end;

function TPabridgeBtr.ReadCrpEml:Str30;
begin
  Result := oBtrTable.FieldByName('CrpEml').AsString;
end;

procedure TPabridgeBtr.WriteCrpEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpEml').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcAddr:Str30;
begin
  Result := oBtrTable.FieldByName('IvcAddr').AsString;
end;

procedure TPabridgeBtr.WriteIvcAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcAddr').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcSta:Str2;
begin
  Result := oBtrTable.FieldByName('IvcSta').AsString;
end;

procedure TPabridgeBtr.WriteIvcSta(pValue:Str2);
begin
  oBtrTable.FieldByName('IvcSta').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcCty:Str3;
begin
  Result := oBtrTable.FieldByName('IvcCty').AsString;
end;

procedure TPabridgeBtr.WriteIvcCty(pValue:Str3);
begin
  oBtrTable.FieldByName('IvcCty').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcCtn:Str30;
begin
  Result := oBtrTable.FieldByName('IvcCtn').AsString;
end;

procedure TPabridgeBtr.WriteIvcCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcCtn').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcZip:Str15;
begin
  Result := oBtrTable.FieldByName('IvcZip').AsString;
end;

procedure TPabridgeBtr.WriteIvcZip(pValue:Str15);
begin
  oBtrTable.FieldByName('IvcZip').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcTel:Str20;
begin
  Result := oBtrTable.FieldByName('IvcTel').AsString;
end;

procedure TPabridgeBtr.WriteIvcTel(pValue:Str20);
begin
  oBtrTable.FieldByName('IvcTel').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcFax:Str20;
begin
  Result := oBtrTable.FieldByName('IvcFax').AsString;
end;

procedure TPabridgeBtr.WriteIvcFax(pValue:Str20);
begin
  oBtrTable.FieldByName('IvcFax').AsString := pValue;
end;

function TPabridgeBtr.ReadIvcEml:Str30;
begin
  Result := oBtrTable.FieldByName('IvcEml').AsString;
end;

procedure TPabridgeBtr.WriteIvcEml(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcEml').AsString := pValue;
end;

function TPabridgeBtr.ReadWebSite:Str30;
begin
  Result := oBtrTable.FieldByName('WebSite').AsString;
end;

procedure TPabridgeBtr.WriteWebSite(pValue:Str30);
begin
  oBtrTable.FieldByName('WebSite').AsString := pValue;
end;

function TPabridgeBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TPabridgeBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPabridgeBtr.ReadBankCode:Str15;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TPabridgeBtr.WriteBankCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TPabridgeBtr.ReadBankSeat:Str30;
begin
  Result := oBtrTable.FieldByName('BankSeat').AsString;
end;

procedure TPabridgeBtr.WriteBankSeat(pValue:Str30);
begin
  oBtrTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPabridgeBtr.ReadIbanCode:Str34;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TPabridgeBtr.WriteIbanCode(pValue:Str34);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPabridgeBtr.ReadSwftCode:Str20;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TPabridgeBtr.WriteSwftCode(pValue:Str20);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

function TPabridgeBtr.ReadContoQnt:byte;
begin
  Result := oBtrTable.FieldByName('ContoQnt').AsInteger;
end;

procedure TPabridgeBtr.WriteContoQnt(pValue:byte);
begin
  oBtrTable.FieldByName('ContoQnt').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIsDscPrc:double;
begin
  Result := oBtrTable.FieldByName('IsDscPrc').AsFloat;
end;

procedure TPabridgeBtr.WriteIsDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('IsDscPrc').AsFloat := pValue;
end;

function TPabridgeBtr.ReadIsExpDay:word;
begin
  Result := oBtrTable.FieldByName('IsExpDay').AsInteger;
end;

procedure TPabridgeBtr.WriteIsExpDay(pValue:word);
begin
  oBtrTable.FieldByName('IsExpDay').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIsPenPrc:double;
begin
  Result := oBtrTable.FieldByName('IsPenPrc').AsFloat;
end;

procedure TPabridgeBtr.WriteIsPenPrc(pValue:double);
begin
  oBtrTable.FieldByName('IsPenPrc').AsFloat := pValue;
end;

function TPabridgeBtr.ReadIsPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('IsPayCode').AsString;
end;

procedure TPabridgeBtr.WriteIsPayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IsPayCode').AsString := pValue;
end;

function TPabridgeBtr.ReadIsPayName:Str20;
begin
  Result := oBtrTable.FieldByName('IsPayName').AsString;
end;

procedure TPabridgeBtr.WriteIsPayName(pValue:Str20);
begin
  oBtrTable.FieldByName('IsPayName').AsString := pValue;
end;

function TPabridgeBtr.ReadIsTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('IsTrsCode').AsString;
end;

procedure TPabridgeBtr.WriteIsTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IsTrsCode').AsString := pValue;
end;

function TPabridgeBtr.ReadIsTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('IsTrsName').AsString;
end;

procedure TPabridgeBtr.WriteIsTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('IsTrsName').AsString := pValue;
end;

function TPabridgeBtr.ReadIcDscPrc:double;
begin
  Result := oBtrTable.FieldByName('IcDscPrc').AsFloat;
end;

procedure TPabridgeBtr.WriteIcDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcDscPrc').AsFloat := pValue;
end;

function TPabridgeBtr.ReadIcExpDay:word;
begin
  Result := oBtrTable.FieldByName('IcExpDay').AsInteger;
end;

procedure TPabridgeBtr.WriteIcExpDay(pValue:word);
begin
  oBtrTable.FieldByName('IcExpDay').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIcPenPrc:double;
begin
  Result := oBtrTable.FieldByName('IcPenPrc').AsFloat;
end;

procedure TPabridgeBtr.WriteIcPenPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcPenPrc').AsFloat := pValue;
end;

function TPabridgeBtr.ReadIcPlsNum:word;
begin
  Result := oBtrTable.FieldByName('IcPlsNum').AsInteger;
end;

procedure TPabridgeBtr.WriteIcPlsNum(pValue:word);
begin
  oBtrTable.FieldByName('IcPlsNum').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIcPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('IcPayCode').AsString;
end;

procedure TPabridgeBtr.WriteIcPayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IcPayCode').AsString := pValue;
end;

function TPabridgeBtr.ReadIcPayName:Str18;
begin
  Result := oBtrTable.FieldByName('IcPayName').AsString;
end;

procedure TPabridgeBtr.WriteIcPayName(pValue:Str18);
begin
  oBtrTable.FieldByName('IcPayName').AsString := pValue;
end;

function TPabridgeBtr.ReadIcPayMode:byte;
begin
  Result := oBtrTable.FieldByName('IcPayMode').AsInteger;
end;

procedure TPabridgeBtr.WriteIcPayMode(pValue:byte);
begin
  oBtrTable.FieldByName('IcPayMode').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIcPayBrm:byte;
begin
  Result := oBtrTable.FieldByName('IcPayBrm').AsInteger;
end;

procedure TPabridgeBtr.WriteIcPayBrm(pValue:byte);
begin
  oBtrTable.FieldByName('IcPayBrm').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIcTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('IcTrsCode').AsString;
end;

procedure TPabridgeBtr.WriteIcTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IcTrsCode').AsString := pValue;
end;

function TPabridgeBtr.ReadIcTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('IcTrsName').AsString;
end;

procedure TPabridgeBtr.WriteIcTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('IcTrsName').AsString := pValue;
end;

function TPabridgeBtr.ReadIcSalLim:double;
begin
  Result := oBtrTable.FieldByName('IcSalLim').AsFloat;
end;

procedure TPabridgeBtr.WriteIcSalLim(pValue:double);
begin
  oBtrTable.FieldByName('IcSalLim').AsFloat := pValue;
end;

function TPabridgeBtr.ReadBuDisStat:byte;
begin
  Result := oBtrTable.FieldByName('BuDisStat').AsInteger;
end;

procedure TPabridgeBtr.WriteBuDisStat(pValue:byte);
begin
  oBtrTable.FieldByName('BuDisStat').AsInteger := pValue;
end;

function TPabridgeBtr.ReadBuDisDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BuDisDate').AsDateTime;
end;

procedure TPabridgeBtr.WriteBuDisDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BuDisDate').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadBuDisUser:Str8;
begin
  Result := oBtrTable.FieldByName('BuDisUser').AsString;
end;

procedure TPabridgeBtr.WriteBuDisUser(pValue:Str8);
begin
  oBtrTable.FieldByName('BuDisUser').AsString := pValue;
end;

function TPabridgeBtr.ReadBuDisDesc:Str30;
begin
  Result := oBtrTable.FieldByName('BuDisDesc').AsString;
end;

procedure TPabridgeBtr.WriteBuDisDesc(pValue:Str30);
begin
  oBtrTable.FieldByName('BuDisDesc').AsString := pValue;
end;

function TPabridgeBtr.ReadSaDisStat:byte;
begin
  Result := oBtrTable.FieldByName('SaDisStat').AsInteger;
end;

procedure TPabridgeBtr.WriteSaDisStat(pValue:byte);
begin
  oBtrTable.FieldByName('SaDisStat').AsInteger := pValue;
end;

function TPabridgeBtr.ReadSaDisDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SaDisDate').AsDateTime;
end;

procedure TPabridgeBtr.WriteSaDisDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SaDisDate').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadSaDisUser:Str8;
begin
  Result := oBtrTable.FieldByName('SaDisUser').AsString;
end;

procedure TPabridgeBtr.WriteSaDisUser(pValue:Str8);
begin
  oBtrTable.FieldByName('SaDisUser').AsString := pValue;
end;

function TPabridgeBtr.ReadSaDisDesc:Str20;
begin
  Result := oBtrTable.FieldByName('SaDisDesc').AsString;
end;

procedure TPabridgeBtr.WriteSaDisDesc(pValue:Str20);
begin
  oBtrTable.FieldByName('SaDisDesc').AsString := pValue;
end;

function TPabridgeBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TPabridgeBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TPabridgeBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TPabridgeBtr.ReadPagCode:word;
begin
  Result := oBtrTable.FieldByName('PagCode').AsInteger;
end;

procedure TPabridgeBtr.WritePagCode(pValue:word);
begin
  oBtrTable.FieldByName('PagCode').AsInteger := pValue;
end;

function TPabridgeBtr.ReadIdCode:Str20;
begin
  Result := oBtrTable.FieldByName('IdCode').AsString;
end;

procedure TPabridgeBtr.WriteIdCode(pValue:Str20);
begin
  oBtrTable.FieldByName('IdCode').AsString := pValue;
end;

function TPabridgeBtr.ReadVatPay:byte;
begin
  Result := oBtrTable.FieldByName('VatPay').AsInteger;
end;

procedure TPabridgeBtr.WriteVatPay(pValue:byte);
begin
  oBtrTable.FieldByName('VatPay').AsInteger := pValue;
end;

function TPabridgeBtr.ReadSapType:byte;
begin
  Result := oBtrTable.FieldByName('SapType').AsInteger;
end;

procedure TPabridgeBtr.WriteSapType(pValue:byte);
begin
  oBtrTable.FieldByName('SapType').AsInteger := pValue;
end;

function TPabridgeBtr.ReadCusType:byte;
begin
  Result := oBtrTable.FieldByName('CusType').AsInteger;
end;

procedure TPabridgeBtr.WriteCusType(pValue:byte);
begin
  oBtrTable.FieldByName('CusType').AsInteger := pValue;
end;

function TPabridgeBtr.ReadOrgType:byte;
begin
  Result := oBtrTable.FieldByName('OrgType').AsInteger;
end;

procedure TPabridgeBtr.WriteOrgType(pValue:byte);
begin
  oBtrTable.FieldByName('OrgType').AsInteger := pValue;
end;

function TPabridgeBtr.ReadPasQnt:word;
begin
  Result := oBtrTable.FieldByName('PasQnt').AsInteger;
end;

procedure TPabridgeBtr.WritePasQnt(pValue:word);
begin
  oBtrTable.FieldByName('PasQnt').AsInteger := pValue;
end;

function TPabridgeBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPabridgeBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPabridgeBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPabridgeBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPabridgeBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPabridgeBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPabridgeBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPabridgeBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPabridgeBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPabridgeBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPabridgeBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPabridgeBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPabridgeBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPabridgeBtr.ReadIcAplNum:word;
begin
  Result := oBtrTable.FieldByName('IcAplNum').AsInteger;
end;

procedure TPabridgeBtr.WriteIcAplNum(pValue:word);
begin
  oBtrTable.FieldByName('IcAplNum').AsInteger := pValue;
end;

function TPabridgeBtr.ReadPgcCode:word;
begin
  Result := oBtrTable.FieldByName('PgcCode').AsInteger;
end;

procedure TPabridgeBtr.WritePgcCode(pValue:word);
begin
  oBtrTable.FieldByName('PgcCode').AsInteger := pValue;
end;

function TPabridgeBtr.ReadSrCode:Str15;
begin
  Result := oBtrTable.FieldByName('SrCode').AsString;
end;

procedure TPabridgeBtr.WriteSrCode(pValue:Str15);
begin
  oBtrTable.FieldByName('SrCode').AsString := pValue;
end;

function TPabridgeBtr.ReadTrdType:byte;
begin
  Result := oBtrTable.FieldByName('TrdType').AsInteger;
end;

procedure TPabridgeBtr.WriteTrdType(pValue:byte);
begin
  oBtrTable.FieldByName('TrdType').AsInteger := pValue;
end;

function TPabridgeBtr.ReadPrnLng:Str2;
begin
  Result := oBtrTable.FieldByName('PrnLng').AsString;
end;

procedure TPabridgeBtr.WritePrnLng(pValue:Str2);
begin
  oBtrTable.FieldByName('PrnLng').AsString := pValue;
end;

function TPabridgeBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TPabridgeBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TPabridgeBtr.ReadHedName:Str30;
begin
  Result := oBtrTable.FieldByName('HedName').AsString;
end;

procedure TPabridgeBtr.WriteHedName(pValue:Str30);
begin
  oBtrTable.FieldByName('HedName').AsString := pValue;
end;

function TPabridgeBtr.ReadRegRec:Str60;
begin
  Result := oBtrTable.FieldByName('RegRec').AsString;
end;

procedure TPabridgeBtr.WriteRegRec(pValue:Str60);
begin
  oBtrTable.FieldByName('RegRec').AsString := pValue;
end;

function TPabridgeBtr.ReadIcExpPrm:word;
begin
  Result := oBtrTable.FieldByName('IcExpPrm').AsInteger;
end;

procedure TPabridgeBtr.WriteIcExpPrm(pValue:word);
begin
  oBtrTable.FieldByName('IcExpPrm').AsInteger := pValue;
end;

function TPabridgeBtr.ReadOwnPac:longint;
begin
  Result := oBtrTable.FieldByName('OwnPac').AsInteger;
end;

procedure TPabridgeBtr.WriteOwnPac(pValue:longint);
begin
  oBtrTable.FieldByName('OwnPac').AsInteger := pValue;
end;

function TPabridgeBtr.ReadSpeLev:byte;
begin
  Result := oBtrTable.FieldByName('SpeLev').AsInteger;
end;

procedure TPabridgeBtr.WriteSpeLev(pValue:byte);
begin
  oBtrTable.FieldByName('SpeLev').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPabridgeBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPabridgeBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPabridgeBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPabridgeBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPabridgeBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPabridgeBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPabridgeBtr.LocatePaCodeO (pPaCodeO:longint):boolean;
begin
  SetIndex (ixPaCodeO);
  Result := oBtrTable.FindKey([pPaCodeO]);
end;

function TPabridgeBtr.LocatePaCodeN (pPaCodeN:longint):boolean;
begin
  SetIndex (ixPaCodeN);
  Result := oBtrTable.FindKey([pPaCodeN]);
end;

function TPabridgeBtr.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindKey([pRegIno]);
end;

function TPabridgeBtr.LocateRegTin (pRegTin:Str15):boolean;
begin
  SetIndex (ixRegTin);
  Result := oBtrTable.FindKey([pRegTin]);
end;

function TPabridgeBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TPabridgeBtr.LocateSmlName (pSmlName:Str10):boolean;
begin
  SetIndex (ixSmlName);
  Result := oBtrTable.FindKey([pSmlName]);
end;

function TPabridgeBtr.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

function TPabridgeBtr.LocateIdCode (pIdCode:Str20):boolean;
begin
  SetIndex (ixIdCode);
  Result := oBtrTable.FindKey([pIdCode]);
end;

function TPabridgeBtr.LocateRegSta (pRegSta:Str2):boolean;
begin
  SetIndex (ixRegSta);
  Result := oBtrTable.FindKey([pRegSta]);
end;

function TPabridgeBtr.LocateRegCty (pRegCty:Str3):boolean;
begin
  SetIndex (ixRegCty);
  Result := oBtrTable.FindKey([pRegCty]);
end;

function TPabridgeBtr.LocatePagCode (pPagCode:word):boolean;
begin
  SetIndex (ixPagCode);
  Result := oBtrTable.FindKey([pPagCode]);
end;

function TPabridgeBtr.LocatePgcCode (pPgcCode:word):boolean;
begin
  SetIndex (ixPgcCode);
  Result := oBtrTable.FindKey([pPgcCode]);
end;

function TPabridgeBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TPabridgeBtr.LocateOwnPac (pOwnPac:longint):boolean;
begin
  SetIndex (ixOwnPac);
  Result := oBtrTable.FindKey([pOwnPac]);
end;

function TPabridgeBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPabridgeBtr.NearestPaCodeO (pPaCodeO:longint):boolean;
begin
  SetIndex (ixPaCodeO);
  Result := oBtrTable.FindNearest([pPaCodeO]);
end;

function TPabridgeBtr.NearestPaCodeN (pPaCodeN:longint):boolean;
begin
  SetIndex (ixPaCodeN);
  Result := oBtrTable.FindNearest([pPaCodeN]);
end;

function TPabridgeBtr.NearestRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindNearest([pRegIno]);
end;

function TPabridgeBtr.NearestRegTin (pRegTin:Str15):boolean;
begin
  SetIndex (ixRegTin);
  Result := oBtrTable.FindNearest([pRegTin]);
end;

function TPabridgeBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TPabridgeBtr.NearestSmlName (pSmlName:Str10):boolean;
begin
  SetIndex (ixSmlName);
  Result := oBtrTable.FindNearest([pSmlName]);
end;

function TPabridgeBtr.NearestContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindNearest([pContoNum]);
end;

function TPabridgeBtr.NearestIdCode (pIdCode:Str20):boolean;
begin
  SetIndex (ixIdCode);
  Result := oBtrTable.FindNearest([pIdCode]);
end;

function TPabridgeBtr.NearestRegSta (pRegSta:Str2):boolean;
begin
  SetIndex (ixRegSta);
  Result := oBtrTable.FindNearest([pRegSta]);
end;

function TPabridgeBtr.NearestRegCty (pRegCty:Str3):boolean;
begin
  SetIndex (ixRegCty);
  Result := oBtrTable.FindNearest([pRegCty]);
end;

function TPabridgeBtr.NearestPagCode (pPagCode:word):boolean;
begin
  SetIndex (ixPagCode);
  Result := oBtrTable.FindNearest([pPagCode]);
end;

function TPabridgeBtr.NearestPgcCode (pPgcCode:word):boolean;
begin
  SetIndex (ixPgcCode);
  Result := oBtrTable.FindNearest([pPgcCode]);
end;

function TPabridgeBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TPabridgeBtr.NearestOwnPac (pOwnPac:longint):boolean;
begin
  SetIndex (ixOwnPac);
  Result := oBtrTable.FindNearest([pOwnPac]);
end;

function TPabridgeBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TPabridgeBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPabridgeBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPabridgeBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPabridgeBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPabridgeBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPabridgeBtr.First;
begin
  oBtrTable.First;
end;

procedure TPabridgeBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPabridgeBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPabridgeBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPabridgeBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPabridgeBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPabridgeBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPabridgeBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPabridgeBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPabridgeBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPabridgeBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPabridgeBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
