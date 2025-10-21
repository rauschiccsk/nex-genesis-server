unit tPAB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixRegIno = 'RegIno';
  ixRegTin = 'RegTin';
  ixPaName_ = 'PaName_';
  ixSmlName = 'SmlName';
  ixContoNum = 'ContoNum';
  ixPagCode = 'PagCode';
  ixIdCode = 'IdCode';
  ixRegSta = 'RegSta';
  ixRegCty = 'RegCty';
  ixSended = 'Sended';

type
  TPabTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadSmlName:Str10;         procedure WriteSmlName (pValue:Str10);
    function  ReadOldTin:Str15;          procedure WriteOldTin (pValue:Str15);
    function  ReadRegRec:Str60;          procedure WriteRegRec (pValue:Str60);
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
    function  ReadIcExpPrm:word;         procedure WriteIcExpPrm (pValue:word);
    function  ReadIcPenPrc:double;       procedure WriteIcPenPrc (pValue:double);
    function  ReadIcPlsNum:word;         procedure WriteIcPlsNum (pValue:word);
    function  ReadIcAplNum:word;         procedure WriteIcAplNum (pValue:word);
    function  ReadIcPayCode:Str3;        procedure WriteIcPayCode (pValue:Str3);
    function  ReadIcPayName:Str20;       procedure WriteIcPayName (pValue:Str20);
    function  ReadIcTrsCode:Str3;        procedure WriteIcTrsCode (pValue:Str3);
    function  ReadIcTrsName:Str20;       procedure WriteIcTrsName (pValue:Str20);
    function  ReadIcSalLim:double;       procedure WriteIcSalLim (pValue:double);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadBuDisStat:byte;        procedure WriteBuDisStat (pValue:byte);
    function  ReadBuDisDate:TDatetime;   procedure WriteBuDisDate (pValue:TDatetime);
    function  ReadBuDisUser:Str8;        procedure WriteBuDisUser (pValue:Str8);
    function  ReadBuDisDesc:Str30;       procedure WriteBuDisDesc (pValue:Str30);
    function  ReadSaDisStat:byte;        procedure WriteSaDisStat (pValue:byte);
    function  ReadSaDisDate:TDatetime;   procedure WriteSaDisDate (pValue:TDatetime);
    function  ReadSaDisUser:Str8;        procedure WriteSaDisUser (pValue:Str8);
    function  ReadSaDisDesc:Str30;       procedure WriteSaDisDesc (pValue:Str30);
    function  ReadPagCode:word;          procedure WritePagCode (pValue:word);
    function  ReadIdCode:Str20;          procedure WriteIdCode (pValue:Str20);
    function  ReadVatPay:byte;           procedure WriteVatPay (pValue:byte);
    function  ReadSapType:byte;          procedure WriteSapType (pValue:byte);
    function  ReadCusType:byte;          procedure WriteCusType (pValue:byte);
    function  ReadOrgType:byte;          procedure WriteOrgType (pValue:byte);
    function  ReadPasQnt:word;           procedure WritePasQnt (pValue:word);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadHedName:Str30;         procedure WriteHedName (pValue:Str30);
    function  ReadTrdType:byte;          procedure WriteTrdType (pValue:byte);
    function  ReadOwnPac:longint;        procedure WriteOwnPac (pValue:longint);
    function  ReadSpeLev:byte;           procedure WriteSpeLev (pValue:byte);
    function  ReadPrnLng:Str2;           procedure WritePrnLng (pValue:Str2);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadAdvPay:double;         procedure WriteAdvPay (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateRegIno (pRegIno:Str15):boolean;
    function LocateRegTin (pRegTin:Str15):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateSmlName (pSmlName:Str10):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;
    function LocatePagCode (pPagCode:word):boolean;
    function LocateIdCode (pIdCode:Str20):boolean;
    function LocateRegSta (pRegSta:Str2):boolean;
    function LocateRegCty (pRegCty:Str3):boolean;
    function LocateSended (pSended:byte):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property SmlName:Str10 read ReadSmlName write WriteSmlName;
    property OldTin:Str15 read ReadOldTin write WriteOldTin;
    property RegRec:Str60 read ReadRegRec write WriteRegRec;
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
    property IcExpPrm:word read ReadIcExpPrm write WriteIcExpPrm;
    property IcPenPrc:double read ReadIcPenPrc write WriteIcPenPrc;
    property IcPlsNum:word read ReadIcPlsNum write WriteIcPlsNum;
    property IcAplNum:word read ReadIcAplNum write WriteIcAplNum;
    property IcPayCode:Str3 read ReadIcPayCode write WriteIcPayCode;
    property IcPayName:Str20 read ReadIcPayName write WriteIcPayName;
    property IcTrsCode:Str3 read ReadIcTrsCode write WriteIcTrsCode;
    property IcTrsName:Str20 read ReadIcTrsName write WriteIcTrsName;
    property IcSalLim:double read ReadIcSalLim write WriteIcSalLim;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property BuDisStat:byte read ReadBuDisStat write WriteBuDisStat;
    property BuDisDate:TDatetime read ReadBuDisDate write WriteBuDisDate;
    property BuDisUser:Str8 read ReadBuDisUser write WriteBuDisUser;
    property BuDisDesc:Str30 read ReadBuDisDesc write WriteBuDisDesc;
    property SaDisStat:byte read ReadSaDisStat write WriteSaDisStat;
    property SaDisDate:TDatetime read ReadSaDisDate write WriteSaDisDate;
    property SaDisUser:Str8 read ReadSaDisUser write WriteSaDisUser;
    property SaDisDesc:Str30 read ReadSaDisDesc write WriteSaDisDesc;
    property PagCode:word read ReadPagCode write WritePagCode;
    property IdCode:Str20 read ReadIdCode write WriteIdCode;
    property VatPay:byte read ReadVatPay write WriteVatPay;
    property SapType:byte read ReadSapType write WriteSapType;
    property CusType:byte read ReadCusType write WriteCusType;
    property OrgType:byte read ReadOrgType write WriteOrgType;
    property PasQnt:word read ReadPasQnt write WritePasQnt;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property HedName:Str30 read ReadHedName write WriteHedName;
    property TrdType:byte read ReadTrdType write WriteTrdType;
    property OwnPac:longint read ReadOwnPac write WriteOwnPac;
    property SpeLev:byte read ReadSpeLev write WriteSpeLev;
    property PrnLng:Str2 read ReadPrnLng write WritePrnLng;
    property Sended:boolean read ReadSended write WriteSended;
    property AdvPay:double read ReadAdvPay write WriteAdvPay;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPabTmp.Create;
begin
  oTmpTable := TmpInit ('PAB',Self);
end;

destructor TPabTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPabTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPabTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPabTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TPabTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPabTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TPabTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TPabTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TPabTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TPabTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TPabTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TPabTmp.ReadSmlName:Str10;
begin
  Result := oTmpTable.FieldByName('SmlName').AsString;
end;

procedure TPabTmp.WriteSmlName(pValue:Str10);
begin
  oTmpTable.FieldByName('SmlName').AsString := pValue;
end;

function TPabTmp.ReadOldTin:Str15;
begin
  Result := oTmpTable.FieldByName('OldTin').AsString;
end;

procedure TPabTmp.WriteOldTin(pValue:Str15);
begin
  oTmpTable.FieldByName('OldTin').AsString := pValue;
end;

function TPabTmp.ReadRegRec:Str60;
begin
  Result := oTmpTable.FieldByName('RegRec').AsString;
end;

procedure TPabTmp.WriteRegRec(pValue:Str60);
begin
  oTmpTable.FieldByName('RegRec').AsString := pValue;
end;

function TPabTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TPabTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TPabTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TPabTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TPabTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TPabTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TPabTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TPabTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TPabTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TPabTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TPabTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TPabTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TPabTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TPabTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TPabTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TPabTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TPabTmp.ReadRegTel:Str20;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TPabTmp.WriteRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TPabTmp.ReadRegFax:Str20;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TPabTmp.WriteRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TPabTmp.ReadRegEml:Str30;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TPabTmp.WriteRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TPabTmp.ReadCrpAddr:Str30;
begin
  Result := oTmpTable.FieldByName('CrpAddr').AsString;
end;

procedure TPabTmp.WriteCrpAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('CrpAddr').AsString := pValue;
end;

function TPabTmp.ReadCrpSta:Str2;
begin
  Result := oTmpTable.FieldByName('CrpSta').AsString;
end;

procedure TPabTmp.WriteCrpSta(pValue:Str2);
begin
  oTmpTable.FieldByName('CrpSta').AsString := pValue;
end;

function TPabTmp.ReadCrpCty:Str3;
begin
  Result := oTmpTable.FieldByName('CrpCty').AsString;
end;

procedure TPabTmp.WriteCrpCty(pValue:Str3);
begin
  oTmpTable.FieldByName('CrpCty').AsString := pValue;
end;

function TPabTmp.ReadCrpCtn:Str30;
begin
  Result := oTmpTable.FieldByName('CrpCtn').AsString;
end;

procedure TPabTmp.WriteCrpCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrpCtn').AsString := pValue;
end;

function TPabTmp.ReadCrpZip:Str15;
begin
  Result := oTmpTable.FieldByName('CrpZip').AsString;
end;

procedure TPabTmp.WriteCrpZip(pValue:Str15);
begin
  oTmpTable.FieldByName('CrpZip').AsString := pValue;
end;

function TPabTmp.ReadCrpTel:Str20;
begin
  Result := oTmpTable.FieldByName('CrpTel').AsString;
end;

procedure TPabTmp.WriteCrpTel(pValue:Str20);
begin
  oTmpTable.FieldByName('CrpTel').AsString := pValue;
end;

function TPabTmp.ReadCrpFax:Str20;
begin
  Result := oTmpTable.FieldByName('CrpFax').AsString;
end;

procedure TPabTmp.WriteCrpFax(pValue:Str20);
begin
  oTmpTable.FieldByName('CrpFax').AsString := pValue;
end;

function TPabTmp.ReadCrpEml:Str30;
begin
  Result := oTmpTable.FieldByName('CrpEml').AsString;
end;

procedure TPabTmp.WriteCrpEml(pValue:Str30);
begin
  oTmpTable.FieldByName('CrpEml').AsString := pValue;
end;

function TPabTmp.ReadIvcAddr:Str30;
begin
  Result := oTmpTable.FieldByName('IvcAddr').AsString;
end;

procedure TPabTmp.WriteIvcAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('IvcAddr').AsString := pValue;
end;

function TPabTmp.ReadIvcSta:Str2;
begin
  Result := oTmpTable.FieldByName('IvcSta').AsString;
end;

procedure TPabTmp.WriteIvcSta(pValue:Str2);
begin
  oTmpTable.FieldByName('IvcSta').AsString := pValue;
end;

function TPabTmp.ReadIvcCty:Str3;
begin
  Result := oTmpTable.FieldByName('IvcCty').AsString;
end;

procedure TPabTmp.WriteIvcCty(pValue:Str3);
begin
  oTmpTable.FieldByName('IvcCty').AsString := pValue;
end;

function TPabTmp.ReadIvcCtn:Str30;
begin
  Result := oTmpTable.FieldByName('IvcCtn').AsString;
end;

procedure TPabTmp.WriteIvcCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('IvcCtn').AsString := pValue;
end;

function TPabTmp.ReadIvcZip:Str15;
begin
  Result := oTmpTable.FieldByName('IvcZip').AsString;
end;

procedure TPabTmp.WriteIvcZip(pValue:Str15);
begin
  oTmpTable.FieldByName('IvcZip').AsString := pValue;
end;

function TPabTmp.ReadIvcTel:Str20;
begin
  Result := oTmpTable.FieldByName('IvcTel').AsString;
end;

procedure TPabTmp.WriteIvcTel(pValue:Str20);
begin
  oTmpTable.FieldByName('IvcTel').AsString := pValue;
end;

function TPabTmp.ReadIvcFax:Str20;
begin
  Result := oTmpTable.FieldByName('IvcFax').AsString;
end;

procedure TPabTmp.WriteIvcFax(pValue:Str20);
begin
  oTmpTable.FieldByName('IvcFax').AsString := pValue;
end;

function TPabTmp.ReadIvcEml:Str30;
begin
  Result := oTmpTable.FieldByName('IvcEml').AsString;
end;

procedure TPabTmp.WriteIvcEml(pValue:Str30);
begin
  oTmpTable.FieldByName('IvcEml').AsString := pValue;
end;

function TPabTmp.ReadWebSite:Str30;
begin
  Result := oTmpTable.FieldByName('WebSite').AsString;
end;

procedure TPabTmp.WriteWebSite(pValue:Str30);
begin
  oTmpTable.FieldByName('WebSite').AsString := pValue;
end;

function TPabTmp.ReadContoNum:Str30;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TPabTmp.WriteContoNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TPabTmp.ReadBankCode:Str15;
begin
  Result := oTmpTable.FieldByName('BankCode').AsString;
end;

procedure TPabTmp.WriteBankCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BankCode').AsString := pValue;
end;

function TPabTmp.ReadBankSeat:Str30;
begin
  Result := oTmpTable.FieldByName('BankSeat').AsString;
end;

procedure TPabTmp.WriteBankSeat(pValue:Str30);
begin
  oTmpTable.FieldByName('BankSeat').AsString := pValue;
end;

function TPabTmp.ReadIbanCode:Str34;
begin
  Result := oTmpTable.FieldByName('IbanCode').AsString;
end;

procedure TPabTmp.WriteIbanCode(pValue:Str34);
begin
  oTmpTable.FieldByName('IbanCode').AsString := pValue;
end;

function TPabTmp.ReadSwftCode:Str20;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TPabTmp.WriteSwftCode(pValue:Str20);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

function TPabTmp.ReadContoQnt:byte;
begin
  Result := oTmpTable.FieldByName('ContoQnt').AsInteger;
end;

procedure TPabTmp.WriteContoQnt(pValue:byte);
begin
  oTmpTable.FieldByName('ContoQnt').AsInteger := pValue;
end;

function TPabTmp.ReadIsDscPrc:double;
begin
  Result := oTmpTable.FieldByName('IsDscPrc').AsFloat;
end;

procedure TPabTmp.WriteIsDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('IsDscPrc').AsFloat := pValue;
end;

function TPabTmp.ReadIsExpDay:word;
begin
  Result := oTmpTable.FieldByName('IsExpDay').AsInteger;
end;

procedure TPabTmp.WriteIsExpDay(pValue:word);
begin
  oTmpTable.FieldByName('IsExpDay').AsInteger := pValue;
end;

function TPabTmp.ReadIsPenPrc:double;
begin
  Result := oTmpTable.FieldByName('IsPenPrc').AsFloat;
end;

procedure TPabTmp.WriteIsPenPrc(pValue:double);
begin
  oTmpTable.FieldByName('IsPenPrc').AsFloat := pValue;
end;

function TPabTmp.ReadIsPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('IsPayCode').AsString;
end;

procedure TPabTmp.WriteIsPayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('IsPayCode').AsString := pValue;
end;

function TPabTmp.ReadIsPayName:Str20;
begin
  Result := oTmpTable.FieldByName('IsPayName').AsString;
end;

procedure TPabTmp.WriteIsPayName(pValue:Str20);
begin
  oTmpTable.FieldByName('IsPayName').AsString := pValue;
end;

function TPabTmp.ReadIsTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('IsTrsCode').AsString;
end;

procedure TPabTmp.WriteIsTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('IsTrsCode').AsString := pValue;
end;

function TPabTmp.ReadIsTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('IsTrsName').AsString;
end;

procedure TPabTmp.WriteIsTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('IsTrsName').AsString := pValue;
end;

function TPabTmp.ReadIcDscPrc:double;
begin
  Result := oTmpTable.FieldByName('IcDscPrc').AsFloat;
end;

procedure TPabTmp.WriteIcDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcDscPrc').AsFloat := pValue;
end;

function TPabTmp.ReadIcExpDay:word;
begin
  Result := oTmpTable.FieldByName('IcExpDay').AsInteger;
end;

procedure TPabTmp.WriteIcExpDay(pValue:word);
begin
  oTmpTable.FieldByName('IcExpDay').AsInteger := pValue;
end;

function TPabTmp.ReadIcExpPrm:word;
begin
  Result := oTmpTable.FieldByName('IcExpPrm').AsInteger;
end;

procedure TPabTmp.WriteIcExpPrm(pValue:word);
begin
  oTmpTable.FieldByName('IcExpPrm').AsInteger := pValue;
end;

function TPabTmp.ReadIcPenPrc:double;
begin
  Result := oTmpTable.FieldByName('IcPenPrc').AsFloat;
end;

procedure TPabTmp.WriteIcPenPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcPenPrc').AsFloat := pValue;
end;

function TPabTmp.ReadIcPlsNum:word;
begin
  Result := oTmpTable.FieldByName('IcPlsNum').AsInteger;
end;

procedure TPabTmp.WriteIcPlsNum(pValue:word);
begin
  oTmpTable.FieldByName('IcPlsNum').AsInteger := pValue;
end;

function TPabTmp.ReadIcAplNum:word;
begin
  Result := oTmpTable.FieldByName('IcAplNum').AsInteger;
end;

procedure TPabTmp.WriteIcAplNum(pValue:word);
begin
  oTmpTable.FieldByName('IcAplNum').AsInteger := pValue;
end;

function TPabTmp.ReadIcPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('IcPayCode').AsString;
end;

procedure TPabTmp.WriteIcPayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('IcPayCode').AsString := pValue;
end;

function TPabTmp.ReadIcPayName:Str20;
begin
  Result := oTmpTable.FieldByName('IcPayName').AsString;
end;

procedure TPabTmp.WriteIcPayName(pValue:Str20);
begin
  oTmpTable.FieldByName('IcPayName').AsString := pValue;
end;

function TPabTmp.ReadIcTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('IcTrsCode').AsString;
end;

procedure TPabTmp.WriteIcTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('IcTrsCode').AsString := pValue;
end;

function TPabTmp.ReadIcTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('IcTrsName').AsString;
end;

procedure TPabTmp.WriteIcTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('IcTrsName').AsString := pValue;
end;

function TPabTmp.ReadIcSalLim:double;
begin
  Result := oTmpTable.FieldByName('IcSalLim').AsFloat;
end;

procedure TPabTmp.WriteIcSalLim(pValue:double);
begin
  oTmpTable.FieldByName('IcSalLim').AsFloat := pValue;
end;

function TPabTmp.ReadIcFacDay:word;
begin
  Result := oTmpTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TPabTmp.WriteIcFacDay(pValue:word);
begin
  oTmpTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TPabTmp.ReadIcFacPrc:double;
begin
  Result := oTmpTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TPabTmp.WriteIcFacPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TPabTmp.ReadBuDisStat:byte;
begin
  Result := oTmpTable.FieldByName('BuDisStat').AsInteger;
end;

procedure TPabTmp.WriteBuDisStat(pValue:byte);
begin
  oTmpTable.FieldByName('BuDisStat').AsInteger := pValue;
end;

function TPabTmp.ReadBuDisDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BuDisDate').AsDateTime;
end;

procedure TPabTmp.WriteBuDisDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BuDisDate').AsDateTime := pValue;
end;

function TPabTmp.ReadBuDisUser:Str8;
begin
  Result := oTmpTable.FieldByName('BuDisUser').AsString;
end;

procedure TPabTmp.WriteBuDisUser(pValue:Str8);
begin
  oTmpTable.FieldByName('BuDisUser').AsString := pValue;
end;

function TPabTmp.ReadBuDisDesc:Str30;
begin
  Result := oTmpTable.FieldByName('BuDisDesc').AsString;
end;

procedure TPabTmp.WriteBuDisDesc(pValue:Str30);
begin
  oTmpTable.FieldByName('BuDisDesc').AsString := pValue;
end;

function TPabTmp.ReadSaDisStat:byte;
begin
  Result := oTmpTable.FieldByName('SaDisStat').AsInteger;
end;

procedure TPabTmp.WriteSaDisStat(pValue:byte);
begin
  oTmpTable.FieldByName('SaDisStat').AsInteger := pValue;
end;

function TPabTmp.ReadSaDisDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SaDisDate').AsDateTime;
end;

procedure TPabTmp.WriteSaDisDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SaDisDate').AsDateTime := pValue;
end;

function TPabTmp.ReadSaDisUser:Str8;
begin
  Result := oTmpTable.FieldByName('SaDisUser').AsString;
end;

procedure TPabTmp.WriteSaDisUser(pValue:Str8);
begin
  oTmpTable.FieldByName('SaDisUser').AsString := pValue;
end;

function TPabTmp.ReadSaDisDesc:Str30;
begin
  Result := oTmpTable.FieldByName('SaDisDesc').AsString;
end;

procedure TPabTmp.WriteSaDisDesc(pValue:Str30);
begin
  oTmpTable.FieldByName('SaDisDesc').AsString := pValue;
end;

function TPabTmp.ReadPagCode:word;
begin
  Result := oTmpTable.FieldByName('PagCode').AsInteger;
end;

procedure TPabTmp.WritePagCode(pValue:word);
begin
  oTmpTable.FieldByName('PagCode').AsInteger := pValue;
end;

function TPabTmp.ReadIdCode:Str20;
begin
  Result := oTmpTable.FieldByName('IdCode').AsString;
end;

procedure TPabTmp.WriteIdCode(pValue:Str20);
begin
  oTmpTable.FieldByName('IdCode').AsString := pValue;
end;

function TPabTmp.ReadVatPay:byte;
begin
  Result := oTmpTable.FieldByName('VatPay').AsInteger;
end;

procedure TPabTmp.WriteVatPay(pValue:byte);
begin
  oTmpTable.FieldByName('VatPay').AsInteger := pValue;
end;

function TPabTmp.ReadSapType:byte;
begin
  Result := oTmpTable.FieldByName('SapType').AsInteger;
end;

procedure TPabTmp.WriteSapType(pValue:byte);
begin
  oTmpTable.FieldByName('SapType').AsInteger := pValue;
end;

function TPabTmp.ReadCusType:byte;
begin
  Result := oTmpTable.FieldByName('CusType').AsInteger;
end;

procedure TPabTmp.WriteCusType(pValue:byte);
begin
  oTmpTable.FieldByName('CusType').AsInteger := pValue;
end;

function TPabTmp.ReadOrgType:byte;
begin
  Result := oTmpTable.FieldByName('OrgType').AsInteger;
end;

procedure TPabTmp.WriteOrgType(pValue:byte);
begin
  oTmpTable.FieldByName('OrgType').AsInteger := pValue;
end;

function TPabTmp.ReadPasQnt:word;
begin
  Result := oTmpTable.FieldByName('PasQnt').AsInteger;
end;

procedure TPabTmp.WritePasQnt(pValue:word);
begin
  oTmpTable.FieldByName('PasQnt').AsInteger := pValue;
end;

function TPabTmp.ReadSrCode:Str15;
begin
  Result := oTmpTable.FieldByName('SrCode').AsString;
end;

procedure TPabTmp.WriteSrCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SrCode').AsString := pValue;
end;

function TPabTmp.ReadHedName:Str30;
begin
  Result := oTmpTable.FieldByName('HedName').AsString;
end;

procedure TPabTmp.WriteHedName(pValue:Str30);
begin
  oTmpTable.FieldByName('HedName').AsString := pValue;
end;

function TPabTmp.ReadTrdType:byte;
begin
  Result := oTmpTable.FieldByName('TrdType').AsInteger;
end;

procedure TPabTmp.WriteTrdType(pValue:byte);
begin
  oTmpTable.FieldByName('TrdType').AsInteger := pValue;
end;

function TPabTmp.ReadOwnPac:longint;
begin
  Result := oTmpTable.FieldByName('OwnPac').AsInteger;
end;

procedure TPabTmp.WriteOwnPac(pValue:longint);
begin
  oTmpTable.FieldByName('OwnPac').AsInteger := pValue;
end;

function TPabTmp.ReadSpeLev:byte;
begin
  Result := oTmpTable.FieldByName('SpeLev').AsInteger;
end;

procedure TPabTmp.WriteSpeLev(pValue:byte);
begin
  oTmpTable.FieldByName('SpeLev').AsInteger := pValue;
end;

function TPabTmp.ReadPrnLng:Str2;
begin
  Result := oTmpTable.FieldByName('PrnLng').AsString;
end;

procedure TPabTmp.WritePrnLng(pValue:Str2);
begin
  oTmpTable.FieldByName('PrnLng').AsString := pValue;
end;

function TPabTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TPabTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPabTmp.ReadAdvPay:double;
begin
  Result := oTmpTable.FieldByName('AdvPay').AsFloat;
end;

procedure TPabTmp.WriteAdvPay(pValue:double);
begin
  oTmpTable.FieldByName('AdvPay').AsFloat := pValue;
end;

function TPabTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPabTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPabTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPabTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPabTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPabTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPabTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TPabTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPabTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPabTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPabTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPabTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPabTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPabTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPabTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPabTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPabTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPabTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPabTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TPabTmp.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oTmpTable.FindKey([pRegIno]);
end;

function TPabTmp.LocateRegTin (pRegTin:Str15):boolean;
begin
  SetIndex (ixRegTin);
  Result := oTmpTable.FindKey([pRegTin]);
end;

function TPabTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TPabTmp.LocateSmlName (pSmlName:Str10):boolean;
begin
  SetIndex (ixSmlName);
  Result := oTmpTable.FindKey([pSmlName]);
end;

function TPabTmp.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oTmpTable.FindKey([pContoNum]);
end;

function TPabTmp.LocatePagCode (pPagCode:word):boolean;
begin
  SetIndex (ixPagCode);
  Result := oTmpTable.FindKey([pPagCode]);
end;

function TPabTmp.LocateIdCode (pIdCode:Str20):boolean;
begin
  SetIndex (ixIdCode);
  Result := oTmpTable.FindKey([pIdCode]);
end;

function TPabTmp.LocateRegSta (pRegSta:Str2):boolean;
begin
  SetIndex (ixRegSta);
  Result := oTmpTable.FindKey([pRegSta]);
end;

function TPabTmp.LocateRegCty (pRegCty:Str3):boolean;
begin
  SetIndex (ixRegCty);
  Result := oTmpTable.FindKey([pRegCty]);
end;

function TPabTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

procedure TPabTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPabTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPabTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPabTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPabTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPabTmp.First;
begin
  oTmpTable.First;
end;

procedure TPabTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPabTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPabTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPabTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPabTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPabTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPabTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPabTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPabTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPabTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPabTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
