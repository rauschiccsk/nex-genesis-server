unit bPAB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
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
  ixBonClc = 'BonClc';

type
  TPabBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
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
    function  ReadBonClc:boolean;        procedure WriteBonClc (pValue:boolean);
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
    function  ReadAdvPay:double;         procedure WriteAdvPay (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:longint):boolean;
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
    function LocateBonClc (pBonClc:byte):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
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
    function NearestBonClc (pBonClc:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pLstNum:word);
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
    property PaCode:longint read ReadPaCode write WritePaCode;
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
    property BonClc:boolean read ReadBonClc write WriteBonClc;
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
    property AdvPay:double read ReadAdvPay write WriteAdvPay;
  end;

implementation

constructor TPabBtr.Create;
begin
  oBtrTable := BtrInit ('PAB',gPath.DlsPath,Self);
end;

constructor TPabBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PAB',pPath,Self);
end;

destructor TPabBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPabBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPabBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPabBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPabBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPabBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TPabBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TPabBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TPabBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TPabBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TPabBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TPabBtr.ReadSmlName:Str10;
begin
  Result := oBtrTable.FieldByName('SmlName').AsString;
end;

procedure TPabBtr.WriteSmlName(pValue:Str10);
begin
  oBtrTable.FieldByName('SmlName').AsString := pValue;
end;

function TPabBtr.ReadOldTin:Str15;
begin
  Result := oBtrTable.FieldByName('OldTin').AsString;
end;

procedure TPabBtr.WriteOldTin(pValue:Str15);
begin
  oBtrTable.FieldByName('OldTin').AsString := pValue;
end;

function TPabBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TPabBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TPabBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TPabBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TPabBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TPabBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TPabBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TPabBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TPabBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TPabBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TPabBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TPabBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TPabBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TPabBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TPabBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TPabBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TPabBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TPabBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TPabBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TPabBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TPabBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TPabBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TPabBtr.ReadCrpAddr:Str30;
begin
  Result := oBtrTable.FieldByName('CrpAddr').AsString;
end;

procedure TPabBtr.WriteCrpAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpAddr').AsString := pValue;
end;

function TPabBtr.ReadCrpSta:Str2;
begin
  Result := oBtrTable.FieldByName('CrpSta').AsString;
end;

procedure TPabBtr.WriteCrpSta(pValue:Str2);
begin
  oBtrTable.FieldByName('CrpSta').AsString := pValue;
end;

function TPabBtr.ReadCrpCty:Str3;
begin
  Result := oBtrTable.FieldByName('CrpCty').AsString;
end;

procedure TPabBtr.WriteCrpCty(pValue:Str3);
begin
  oBtrTable.FieldByName('CrpCty').AsString := pValue;
end;

function TPabBtr.ReadCrpCtn:Str30;
begin
  Result := oBtrTable.FieldByName('CrpCtn').AsString;
end;

procedure TPabBtr.WriteCrpCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpCtn').AsString := pValue;
end;

function TPabBtr.ReadCrpZip:Str15;
begin
  Result := oBtrTable.FieldByName('CrpZip').AsString;
end;

procedure TPabBtr.WriteCrpZip(pValue:Str15);
begin
  oBtrTable.FieldByName('CrpZip').AsString := pValue;
end;

function TPabBtr.ReadCrpTel:Str20;
begin
  Result := oBtrTable.FieldByName('CrpTel').AsString;
end;

procedure TPabBtr.WriteCrpTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CrpTel').AsString := pValue;
end;

function TPabBtr.ReadCrpFax:Str20;
begin
  Result := oBtrTable.FieldByName('CrpFax').AsString;
end;

procedure TPabBtr.WriteCrpFax(pValue:Str20);
begin
  oBtrTable.FieldByName('CrpFax').AsString := pValue;
end;

function TPabBtr.ReadCrpEml:Str30;
begin
  Result := oBtrTable.FieldByName('CrpEml').AsString;
end;

procedure TPabBtr.WriteCrpEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpEml').AsString := pValue;
end;

function TPabBtr.ReadIvcAddr:Str30;
begin
  Result := oBtrTable.FieldByName('IvcAddr').AsString;
end;

procedure TPabBtr.WriteIvcAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcAddr').AsString := pValue;
end;

function TPabBtr.ReadIvcSta:Str2;
begin
  Result := oBtrTable.FieldByName('IvcSta').AsString;
end;

procedure TPabBtr.WriteIvcSta(pValue:Str2);
begin
  oBtrTable.FieldByName('IvcSta').AsString := pValue;
end;

function TPabBtr.ReadIvcCty:Str3;
begin
  Result := oBtrTable.FieldByName('IvcCty').AsString;
end;

procedure TPabBtr.WriteIvcCty(pValue:Str3);
begin
  oBtrTable.FieldByName('IvcCty').AsString := pValue;
end;

function TPabBtr.ReadIvcCtn:Str30;
begin
  Result := oBtrTable.FieldByName('IvcCtn').AsString;
end;

procedure TPabBtr.WriteIvcCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcCtn').AsString := pValue;
end;

function TPabBtr.ReadIvcZip:Str15;
begin
  Result := oBtrTable.FieldByName('IvcZip').AsString;
end;

procedure TPabBtr.WriteIvcZip(pValue:Str15);
begin
  oBtrTable.FieldByName('IvcZip').AsString := pValue;
end;

function TPabBtr.ReadIvcTel:Str20;
begin
  Result := oBtrTable.FieldByName('IvcTel').AsString;
end;

procedure TPabBtr.WriteIvcTel(pValue:Str20);
begin
  oBtrTable.FieldByName('IvcTel').AsString := pValue;
end;

function TPabBtr.ReadIvcFax:Str20;
begin
  Result := oBtrTable.FieldByName('IvcFax').AsString;
end;

procedure TPabBtr.WriteIvcFax(pValue:Str20);
begin
  oBtrTable.FieldByName('IvcFax').AsString := pValue;
end;

function TPabBtr.ReadIvcEml:Str30;
begin
  Result := oBtrTable.FieldByName('IvcEml').AsString;
end;

procedure TPabBtr.WriteIvcEml(pValue:Str30);
begin
  oBtrTable.FieldByName('IvcEml').AsString := pValue;
end;

function TPabBtr.ReadWebSite:Str30;
begin
  Result := oBtrTable.FieldByName('WebSite').AsString;
end;

procedure TPabBtr.WriteWebSite(pValue:Str30);
begin
  oBtrTable.FieldByName('WebSite').AsString := pValue;
end;

function TPabBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TPabBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPabBtr.ReadBankCode:Str15;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TPabBtr.WriteBankCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TPabBtr.ReadBankSeat:Str30;
begin
  Result := oBtrTable.FieldByName('BankSeat').AsString;
end;

procedure TPabBtr.WriteBankSeat(pValue:Str30);
begin
  oBtrTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPabBtr.ReadIbanCode:Str34;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TPabBtr.WriteIbanCode(pValue:Str34);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPabBtr.ReadSwftCode:Str20;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TPabBtr.WriteSwftCode(pValue:Str20);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

function TPabBtr.ReadContoQnt:byte;
begin
  Result := oBtrTable.FieldByName('ContoQnt').AsInteger;
end;

procedure TPabBtr.WriteContoQnt(pValue:byte);
begin
  oBtrTable.FieldByName('ContoQnt').AsInteger := pValue;
end;

function TPabBtr.ReadIsDscPrc:double;
begin
  Result := oBtrTable.FieldByName('IsDscPrc').AsFloat;
end;

procedure TPabBtr.WriteIsDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('IsDscPrc').AsFloat := pValue;
end;

function TPabBtr.ReadIsExpDay:word;
begin
  Result := oBtrTable.FieldByName('IsExpDay').AsInteger;
end;

procedure TPabBtr.WriteIsExpDay(pValue:word);
begin
  oBtrTable.FieldByName('IsExpDay').AsInteger := pValue;
end;

function TPabBtr.ReadIsPenPrc:double;
begin
  Result := oBtrTable.FieldByName('IsPenPrc').AsFloat;
end;

procedure TPabBtr.WriteIsPenPrc(pValue:double);
begin
  oBtrTable.FieldByName('IsPenPrc').AsFloat := pValue;
end;

function TPabBtr.ReadIsPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('IsPayCode').AsString;
end;

procedure TPabBtr.WriteIsPayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IsPayCode').AsString := pValue;
end;

function TPabBtr.ReadIsPayName:Str20;
begin
  Result := oBtrTable.FieldByName('IsPayName').AsString;
end;

procedure TPabBtr.WriteIsPayName(pValue:Str20);
begin
  oBtrTable.FieldByName('IsPayName').AsString := pValue;
end;

function TPabBtr.ReadIsTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('IsTrsCode').AsString;
end;

procedure TPabBtr.WriteIsTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IsTrsCode').AsString := pValue;
end;

function TPabBtr.ReadIsTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('IsTrsName').AsString;
end;

procedure TPabBtr.WriteIsTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('IsTrsName').AsString := pValue;
end;

function TPabBtr.ReadIcDscPrc:double;
begin
  Result := oBtrTable.FieldByName('IcDscPrc').AsFloat;
end;

procedure TPabBtr.WriteIcDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcDscPrc').AsFloat := pValue;
end;

function TPabBtr.ReadIcExpDay:word;
begin
  Result := oBtrTable.FieldByName('IcExpDay').AsInteger;
end;

procedure TPabBtr.WriteIcExpDay(pValue:word);
begin
  oBtrTable.FieldByName('IcExpDay').AsInteger := pValue;
end;

function TPabBtr.ReadIcPenPrc:double;
begin
  Result := oBtrTable.FieldByName('IcPenPrc').AsFloat;
end;

procedure TPabBtr.WriteIcPenPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcPenPrc').AsFloat := pValue;
end;

function TPabBtr.ReadIcPlsNum:word;
begin
  Result := oBtrTable.FieldByName('IcPlsNum').AsInteger;
end;

procedure TPabBtr.WriteIcPlsNum(pValue:word);
begin
  oBtrTable.FieldByName('IcPlsNum').AsInteger := pValue;
end;

function TPabBtr.ReadIcPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('IcPayCode').AsString;
end;

procedure TPabBtr.WriteIcPayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IcPayCode').AsString := pValue;
end;

function TPabBtr.ReadIcPayName:Str18;
begin
  Result := oBtrTable.FieldByName('IcPayName').AsString;
end;

procedure TPabBtr.WriteIcPayName(pValue:Str18);
begin
  oBtrTable.FieldByName('IcPayName').AsString := pValue;
end;

function TPabBtr.ReadIcPayMode:byte;
begin
  Result := oBtrTable.FieldByName('IcPayMode').AsInteger;
end;

procedure TPabBtr.WriteIcPayMode(pValue:byte);
begin
  oBtrTable.FieldByName('IcPayMode').AsInteger := pValue;
end;

function TPabBtr.ReadIcPayBrm:byte;
begin
  Result := oBtrTable.FieldByName('IcPayBrm').AsInteger;
end;

procedure TPabBtr.WriteIcPayBrm(pValue:byte);
begin
  oBtrTable.FieldByName('IcPayBrm').AsInteger := pValue;
end;

function TPabBtr.ReadIcTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('IcTrsCode').AsString;
end;

procedure TPabBtr.WriteIcTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('IcTrsCode').AsString := pValue;
end;

function TPabBtr.ReadIcTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('IcTrsName').AsString;
end;

procedure TPabBtr.WriteIcTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('IcTrsName').AsString := pValue;
end;

function TPabBtr.ReadIcSalLim:double;
begin
  Result := oBtrTable.FieldByName('IcSalLim').AsFloat;
end;

procedure TPabBtr.WriteIcSalLim(pValue:double);
begin
  oBtrTable.FieldByName('IcSalLim').AsFloat := pValue;
end;

function TPabBtr.ReadBuDisStat:byte;
begin
  Result := oBtrTable.FieldByName('BuDisStat').AsInteger;
end;

procedure TPabBtr.WriteBuDisStat(pValue:byte);
begin
  oBtrTable.FieldByName('BuDisStat').AsInteger := pValue;
end;

function TPabBtr.ReadBuDisDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BuDisDate').AsDateTime;
end;

procedure TPabBtr.WriteBuDisDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BuDisDate').AsDateTime := pValue;
end;

function TPabBtr.ReadBuDisUser:Str8;
begin
  Result := oBtrTable.FieldByName('BuDisUser').AsString;
end;

procedure TPabBtr.WriteBuDisUser(pValue:Str8);
begin
  oBtrTable.FieldByName('BuDisUser').AsString := pValue;
end;

function TPabBtr.ReadBuDisDesc:Str30;
begin
  Result := oBtrTable.FieldByName('BuDisDesc').AsString;
end;

procedure TPabBtr.WriteBuDisDesc(pValue:Str30);
begin
  oBtrTable.FieldByName('BuDisDesc').AsString := pValue;
end;

function TPabBtr.ReadSaDisStat:byte;
begin
  Result := oBtrTable.FieldByName('SaDisStat').AsInteger;
end;

procedure TPabBtr.WriteSaDisStat(pValue:byte);
begin
  oBtrTable.FieldByName('SaDisStat').AsInteger := pValue;
end;

function TPabBtr.ReadSaDisDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SaDisDate').AsDateTime;
end;

procedure TPabBtr.WriteSaDisDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SaDisDate').AsDateTime := pValue;
end;

function TPabBtr.ReadSaDisUser:Str8;
begin
  Result := oBtrTable.FieldByName('SaDisUser').AsString;
end;

procedure TPabBtr.WriteSaDisUser(pValue:Str8);
begin
  oBtrTable.FieldByName('SaDisUser').AsString := pValue;
end;

function TPabBtr.ReadSaDisDesc:Str20;
begin
  Result := oBtrTable.FieldByName('SaDisDesc').AsString;
end;

procedure TPabBtr.WriteSaDisDesc(pValue:Str20);
begin
  oBtrTable.FieldByName('SaDisDesc').AsString := pValue;
end;

function TPabBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TPabBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TPabBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TPabBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TPabBtr.ReadPagCode:word;
begin
  Result := oBtrTable.FieldByName('PagCode').AsInteger;
end;

procedure TPabBtr.WritePagCode(pValue:word);
begin
  oBtrTable.FieldByName('PagCode').AsInteger := pValue;
end;

function TPabBtr.ReadIdCode:Str20;
begin
  Result := oBtrTable.FieldByName('IdCode').AsString;
end;

procedure TPabBtr.WriteIdCode(pValue:Str20);
begin
  oBtrTable.FieldByName('IdCode').AsString := pValue;
end;

function TPabBtr.ReadVatPay:byte;
begin
  Result := oBtrTable.FieldByName('VatPay').AsInteger;
end;

procedure TPabBtr.WriteVatPay(pValue:byte);
begin
  oBtrTable.FieldByName('VatPay').AsInteger := pValue;
end;

function TPabBtr.ReadSapType:byte;
begin
  Result := oBtrTable.FieldByName('SapType').AsInteger;
end;

procedure TPabBtr.WriteSapType(pValue:byte);
begin
  oBtrTable.FieldByName('SapType').AsInteger := pValue;
end;

function TPabBtr.ReadCusType:byte;
begin
  Result := oBtrTable.FieldByName('CusType').AsInteger;
end;

procedure TPabBtr.WriteCusType(pValue:byte);
begin
  oBtrTable.FieldByName('CusType').AsInteger := pValue;
end;

function TPabBtr.ReadOrgType:byte;
begin
  Result := oBtrTable.FieldByName('OrgType').AsInteger;
end;

procedure TPabBtr.WriteOrgType(pValue:byte);
begin
  oBtrTable.FieldByName('OrgType').AsInteger := pValue;
end;

function TPabBtr.ReadPasQnt:word;
begin
  Result := oBtrTable.FieldByName('PasQnt').AsInteger;
end;

procedure TPabBtr.WritePasQnt(pValue:word);
begin
  oBtrTable.FieldByName('PasQnt').AsInteger := pValue;
end;

function TPabBtr.ReadBonClc:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('BonClc').AsInteger);
end;

procedure TPabBtr.WriteBonClc(pValue:boolean);
begin
  oBtrTable.FieldByName('BonClc').AsInteger := BoolToByte(pValue);
end;

function TPabBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPabBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPabBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPabBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPabBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPabBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPabBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPabBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPabBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPabBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPabBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPabBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPabBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPabBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPabBtr.ReadIcAplNum:word;
begin
  Result := oBtrTable.FieldByName('IcAplNum').AsInteger;
end;

procedure TPabBtr.WriteIcAplNum(pValue:word);
begin
  oBtrTable.FieldByName('IcAplNum').AsInteger := pValue;
end;

function TPabBtr.ReadPgcCode:word;
begin
  Result := oBtrTable.FieldByName('PgcCode').AsInteger;
end;

procedure TPabBtr.WritePgcCode(pValue:word);
begin
  oBtrTable.FieldByName('PgcCode').AsInteger := pValue;
end;

function TPabBtr.ReadSrCode:Str15;
begin
  Result := oBtrTable.FieldByName('SrCode').AsString;
end;

procedure TPabBtr.WriteSrCode(pValue:Str15);
begin
  oBtrTable.FieldByName('SrCode').AsString := pValue;
end;

function TPabBtr.ReadTrdType:byte;
begin
  Result := oBtrTable.FieldByName('TrdType').AsInteger;
end;

procedure TPabBtr.WriteTrdType(pValue:byte);
begin
  oBtrTable.FieldByName('TrdType').AsInteger := pValue;
end;

function TPabBtr.ReadPrnLng:Str2;
begin
  Result := oBtrTable.FieldByName('PrnLng').AsString;
end;

procedure TPabBtr.WritePrnLng(pValue:Str2);
begin
  oBtrTable.FieldByName('PrnLng').AsString := pValue;
end;

function TPabBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TPabBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TPabBtr.ReadHedName:Str30;
begin
  Result := oBtrTable.FieldByName('HedName').AsString;
end;

procedure TPabBtr.WriteHedName(pValue:Str30);
begin
  oBtrTable.FieldByName('HedName').AsString := pValue;
end;

function TPabBtr.ReadRegRec:Str60;
begin
  Result := oBtrTable.FieldByName('RegRec').AsString;
end;

procedure TPabBtr.WriteRegRec(pValue:Str60);
begin
  oBtrTable.FieldByName('RegRec').AsString := pValue;
end;

function TPabBtr.ReadIcExpPrm:word;
begin
  Result := oBtrTable.FieldByName('IcExpPrm').AsInteger;
end;

procedure TPabBtr.WriteIcExpPrm(pValue:word);
begin
  oBtrTable.FieldByName('IcExpPrm').AsInteger := pValue;
end;

function TPabBtr.ReadOwnPac:longint;
begin
  Result := oBtrTable.FieldByName('OwnPac').AsInteger;
end;

procedure TPabBtr.WriteOwnPac(pValue:longint);
begin
  oBtrTable.FieldByName('OwnPac').AsInteger := pValue;
end;

function TPabBtr.ReadSpeLev:byte;
begin
  Result := oBtrTable.FieldByName('SpeLev').AsInteger;
end;

procedure TPabBtr.WriteSpeLev(pValue:byte);
begin
  oBtrTable.FieldByName('SpeLev').AsInteger := pValue;
end;

function TPabBtr.ReadAdvPay:double;
begin
  Result := oBtrTable.FieldByName('AdvPay').AsFloat;
end;

procedure TPabBtr.WriteAdvPay(pValue:double);
begin
  oBtrTable.FieldByName('AdvPay').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPabBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPabBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPabBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPabBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPabBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPabBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPabBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPabBtr.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindKey([pRegIno]);
end;

function TPabBtr.LocateRegTin (pRegTin:Str15):boolean;
begin
  SetIndex (ixRegTin);
  Result := oBtrTable.FindKey([pRegTin]);
end;

function TPabBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TPabBtr.LocateSmlName (pSmlName:Str10):boolean;
begin
  SetIndex (ixSmlName);
  Result := oBtrTable.FindKey([pSmlName]);
end;

function TPabBtr.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

function TPabBtr.LocateIdCode (pIdCode:Str20):boolean;
begin
  SetIndex (ixIdCode);
  Result := oBtrTable.FindKey([pIdCode]);
end;

function TPabBtr.LocateRegSta (pRegSta:Str2):boolean;
begin
  SetIndex (ixRegSta);
  Result := oBtrTable.FindKey([pRegSta]);
end;

function TPabBtr.LocateRegCty (pRegCty:Str3):boolean;
begin
  SetIndex (ixRegCty);
  Result := oBtrTable.FindKey([pRegCty]);
end;

function TPabBtr.LocatePagCode (pPagCode:word):boolean;
begin
  SetIndex (ixPagCode);
  Result := oBtrTable.FindKey([pPagCode]);
end;

function TPabBtr.LocatePgcCode (pPgcCode:word):boolean;
begin
  SetIndex (ixPgcCode);
  Result := oBtrTable.FindKey([pPgcCode]);
end;

function TPabBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TPabBtr.LocateOwnPac (pOwnPac:longint):boolean;
begin
  SetIndex (ixOwnPac);
  Result := oBtrTable.FindKey([pOwnPac]);
end;

function TPabBtr.LocateBonClc (pBonClc:byte):boolean;
begin
  SetIndex (ixBonClc);
  Result := oBtrTable.FindKey([pBonClc]);
end;

function TPabBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TPabBtr.NearestRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindNearest([pRegIno]);
end;

function TPabBtr.NearestRegTin (pRegTin:Str15):boolean;
begin
  SetIndex (ixRegTin);
  Result := oBtrTable.FindNearest([pRegTin]);
end;

function TPabBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TPabBtr.NearestSmlName (pSmlName:Str10):boolean;
begin
  SetIndex (ixSmlName);
  Result := oBtrTable.FindNearest([pSmlName]);
end;

function TPabBtr.NearestContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindNearest([pContoNum]);
end;

function TPabBtr.NearestIdCode (pIdCode:Str20):boolean;
begin
  SetIndex (ixIdCode);
  Result := oBtrTable.FindNearest([pIdCode]);
end;

function TPabBtr.NearestRegSta (pRegSta:Str2):boolean;
begin
  SetIndex (ixRegSta);
  Result := oBtrTable.FindNearest([pRegSta]);
end;

function TPabBtr.NearestRegCty (pRegCty:Str3):boolean;
begin
  SetIndex (ixRegCty);
  Result := oBtrTable.FindNearest([pRegCty]);
end;

function TPabBtr.NearestPagCode (pPagCode:word):boolean;
begin
  SetIndex (ixPagCode);
  Result := oBtrTable.FindNearest([pPagCode]);
end;

function TPabBtr.NearestPgcCode (pPgcCode:word):boolean;
begin
  SetIndex (ixPgcCode);
  Result := oBtrTable.FindNearest([pPgcCode]);
end;

function TPabBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TPabBtr.NearestOwnPac (pOwnPac:longint):boolean;
begin
  SetIndex (ixOwnPac);
  Result := oBtrTable.FindNearest([pOwnPac]);
end;

function TPabBtr.NearestBonClc (pBonClc:byte):boolean;
begin
  SetIndex (ixBonClc);
  Result := oBtrTable.FindNearest([pBonClc]);
end;

procedure TPabBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPabBtr.Open(pLstNum:word);
begin
  oBtrTable.Open(pLstNum);
end;

procedure TPabBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPabBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPabBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPabBtr.First;
begin
  oBtrTable.First;
end;

procedure TPabBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPabBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPabBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPabBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPabBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPabBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPabBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPabBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPabBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPabBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPabBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
