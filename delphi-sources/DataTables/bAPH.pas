unit bAPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixDstStat = 'DstStat';

type
  TAphBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegRec:Str60;          procedure WriteRegRec (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadCrpAddr:Str30;         procedure WriteCrpAddr (pValue:Str30);
    function  ReadCrpSta:Str2;           procedure WriteCrpSta (pValue:Str2);
    function  ReadCrpCty:Str3;           procedure WriteCrpCty (pValue:Str3);
    function  ReadCrpCtn:Str30;          procedure WriteCrpCtn (pValue:Str30);
    function  ReadCrpZip:Str15;          procedure WriteCrpZip (pValue:Str15);
    function  ReadBaCont:Str30;          procedure WriteBaCont (pValue:Str30);
    function  ReadBaName:Str30;          procedure WriteBaName (pValue:Str30);
    function  ReadVatPay:byte;           procedure WriteVatPay (pValue:byte);
    function  ReadHedName:Str30;         procedure WriteHedName (pValue:Str30);
    function  ReadDebSoi:Str90;          procedure WriteDebSoi (pValue:Str90);
    function  ReadDebHei:Str90;          procedure WriteDebHei (pValue:Str90);
    function  ReadDebTof:Str90;          procedure WriteDebTof (pValue:Str90);
    function  ReadDebOth:Str90;          procedure WriteDebOth (pValue:Str90);
    function  ReadDebSig:Str80;          procedure WriteDebSig (pValue:Str80);
    function  ReadAprSig1:Str80;         procedure WriteAprSig1 (pValue:Str80);
    function  ReadAprSig2:Str80;         procedure WriteAprSig2 (pValue:Str80);
    function  ReadAprSig3:Str80;         procedure WriteAprSig3 (pValue:Str80);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadVerUser:Str8;          procedure WriteVerUser (pValue:Str8);
    function  ReadVerName:Str30;         procedure WriteVerName (pValue:Str30);
    function  ReadVerDate:TDatetime;     procedure WriteVerDate (pValue:TDatetime);
    function  ReadVerTime:TDatetime;     procedure WriteVerTime (pValue:TDatetime);
    function  ReadAprDate:TDatetime;     procedure WriteAprDate (pValue:TDatetime);
    function  ReadAprTime:TDatetime;     procedure WriteAprTime (pValue:TDatetime);
    function  ReadDstStat:Str1;          procedure WriteDstStat (pValue:Str1);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateDstStat (pDstStat:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestDstStat (pDstStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegRec:Str60 read ReadRegRec write WriteRegRec;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property CrpAddr:Str30 read ReadCrpAddr write WriteCrpAddr;
    property CrpSta:Str2 read ReadCrpSta write WriteCrpSta;
    property CrpCty:Str3 read ReadCrpCty write WriteCrpCty;
    property CrpCtn:Str30 read ReadCrpCtn write WriteCrpCtn;
    property CrpZip:Str15 read ReadCrpZip write WriteCrpZip;
    property BaCont:Str30 read ReadBaCont write WriteBaCont;
    property BaName:Str30 read ReadBaName write WriteBaName;
    property VatPay:byte read ReadVatPay write WriteVatPay;
    property HedName:Str30 read ReadHedName write WriteHedName;
    property DebSoi:Str90 read ReadDebSoi write WriteDebSoi;
    property DebHei:Str90 read ReadDebHei write WriteDebHei;
    property DebTof:Str90 read ReadDebTof write WriteDebTof;
    property DebOth:Str90 read ReadDebOth write WriteDebOth;
    property DebSig:Str80 read ReadDebSig write WriteDebSig;
    property AprSig1:Str80 read ReadAprSig1 write WriteAprSig1;
    property AprSig2:Str80 read ReadAprSig2 write WriteAprSig2;
    property AprSig3:Str80 read ReadAprSig3 write WriteAprSig3;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property VerUser:Str8 read ReadVerUser write WriteVerUser;
    property VerName:Str30 read ReadVerName write WriteVerName;
    property VerDate:TDatetime read ReadVerDate write WriteVerDate;
    property VerTime:TDatetime read ReadVerTime write WriteVerTime;
    property AprDate:TDatetime read ReadAprDate write WriteAprDate;
    property AprTime:TDatetime read ReadAprTime write WriteAprTime;
    property DstStat:Str1 read ReadDstStat write WriteDstStat;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TAphBtr.Create;
begin
  oBtrTable := BtrInit ('APH',gPath.DlsPath,Self);
end;

constructor TAphBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APH',pPath,Self);
end;

destructor TAphBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAphBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAphBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAphBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAphBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAphBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAphBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAphBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAphBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAphBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAphBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAphBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAphBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAphBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TAphBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TAphBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TAphBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TAphBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TAphBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAphBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TAphBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TAphBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TAphBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TAphBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TAphBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAphBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TAphBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TAphBtr.ReadRegRec:Str60;
begin
  Result := oBtrTable.FieldByName('RegRec').AsString;
end;

procedure TAphBtr.WriteRegRec(pValue:Str60);
begin
  oBtrTable.FieldByName('RegRec').AsString := pValue;
end;

function TAphBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TAphBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TAphBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TAphBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TAphBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TAphBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TAphBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TAphBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TAphBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TAphBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TAphBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TAphBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TAphBtr.ReadCrpAddr:Str30;
begin
  Result := oBtrTable.FieldByName('CrpAddr').AsString;
end;

procedure TAphBtr.WriteCrpAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpAddr').AsString := pValue;
end;

function TAphBtr.ReadCrpSta:Str2;
begin
  Result := oBtrTable.FieldByName('CrpSta').AsString;
end;

procedure TAphBtr.WriteCrpSta(pValue:Str2);
begin
  oBtrTable.FieldByName('CrpSta').AsString := pValue;
end;

function TAphBtr.ReadCrpCty:Str3;
begin
  Result := oBtrTable.FieldByName('CrpCty').AsString;
end;

procedure TAphBtr.WriteCrpCty(pValue:Str3);
begin
  oBtrTable.FieldByName('CrpCty').AsString := pValue;
end;

function TAphBtr.ReadCrpCtn:Str30;
begin
  Result := oBtrTable.FieldByName('CrpCtn').AsString;
end;

procedure TAphBtr.WriteCrpCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpCtn').AsString := pValue;
end;

function TAphBtr.ReadCrpZip:Str15;
begin
  Result := oBtrTable.FieldByName('CrpZip').AsString;
end;

procedure TAphBtr.WriteCrpZip(pValue:Str15);
begin
  oBtrTable.FieldByName('CrpZip').AsString := pValue;
end;

function TAphBtr.ReadBaCont:Str30;
begin
  Result := oBtrTable.FieldByName('BaCont').AsString;
end;

procedure TAphBtr.WriteBaCont(pValue:Str30);
begin
  oBtrTable.FieldByName('BaCont').AsString := pValue;
end;

function TAphBtr.ReadBaName:Str30;
begin
  Result := oBtrTable.FieldByName('BaName').AsString;
end;

procedure TAphBtr.WriteBaName(pValue:Str30);
begin
  oBtrTable.FieldByName('BaName').AsString := pValue;
end;

function TAphBtr.ReadVatPay:byte;
begin
  Result := oBtrTable.FieldByName('VatPay').AsInteger;
end;

procedure TAphBtr.WriteVatPay(pValue:byte);
begin
  oBtrTable.FieldByName('VatPay').AsInteger := pValue;
end;

function TAphBtr.ReadHedName:Str30;
begin
  Result := oBtrTable.FieldByName('HedName').AsString;
end;

procedure TAphBtr.WriteHedName(pValue:Str30);
begin
  oBtrTable.FieldByName('HedName').AsString := pValue;
end;

function TAphBtr.ReadDebSoi:Str90;
begin
  Result := oBtrTable.FieldByName('DebSoi').AsString;
end;

procedure TAphBtr.WriteDebSoi(pValue:Str90);
begin
  oBtrTable.FieldByName('DebSoi').AsString := pValue;
end;

function TAphBtr.ReadDebHei:Str90;
begin
  Result := oBtrTable.FieldByName('DebHei').AsString;
end;

procedure TAphBtr.WriteDebHei(pValue:Str90);
begin
  oBtrTable.FieldByName('DebHei').AsString := pValue;
end;

function TAphBtr.ReadDebTof:Str90;
begin
  Result := oBtrTable.FieldByName('DebTof').AsString;
end;

procedure TAphBtr.WriteDebTof(pValue:Str90);
begin
  oBtrTable.FieldByName('DebTof').AsString := pValue;
end;

function TAphBtr.ReadDebOth:Str90;
begin
  Result := oBtrTable.FieldByName('DebOth').AsString;
end;

procedure TAphBtr.WriteDebOth(pValue:Str90);
begin
  oBtrTable.FieldByName('DebOth').AsString := pValue;
end;

function TAphBtr.ReadDebSig:Str80;
begin
  Result := oBtrTable.FieldByName('DebSig').AsString;
end;

procedure TAphBtr.WriteDebSig(pValue:Str80);
begin
  oBtrTable.FieldByName('DebSig').AsString := pValue;
end;

function TAphBtr.ReadAprSig1:Str80;
begin
  Result := oBtrTable.FieldByName('AprSig1').AsString;
end;

procedure TAphBtr.WriteAprSig1(pValue:Str80);
begin
  oBtrTable.FieldByName('AprSig1').AsString := pValue;
end;

function TAphBtr.ReadAprSig2:Str80;
begin
  Result := oBtrTable.FieldByName('AprSig2').AsString;
end;

procedure TAphBtr.WriteAprSig2(pValue:Str80);
begin
  oBtrTable.FieldByName('AprSig2').AsString := pValue;
end;

function TAphBtr.ReadAprSig3:Str80;
begin
  Result := oBtrTable.FieldByName('AprSig3').AsString;
end;

procedure TAphBtr.WriteAprSig3(pValue:Str80);
begin
  oBtrTable.FieldByName('AprSig3').AsString := pValue;
end;

function TAphBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAphBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAphBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TAphBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TAphBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAphBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAphBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAphBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAphBtr.ReadVerUser:Str8;
begin
  Result := oBtrTable.FieldByName('VerUser').AsString;
end;

procedure TAphBtr.WriteVerUser(pValue:Str8);
begin
  oBtrTable.FieldByName('VerUser').AsString := pValue;
end;

function TAphBtr.ReadVerName:Str30;
begin
  Result := oBtrTable.FieldByName('VerName').AsString;
end;

procedure TAphBtr.WriteVerName(pValue:Str30);
begin
  oBtrTable.FieldByName('VerName').AsString := pValue;
end;

function TAphBtr.ReadVerDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VerDate').AsDateTime;
end;

procedure TAphBtr.WriteVerDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VerDate').AsDateTime := pValue;
end;

function TAphBtr.ReadVerTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('VerTime').AsDateTime;
end;

procedure TAphBtr.WriteVerTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VerTime').AsDateTime := pValue;
end;

function TAphBtr.ReadAprDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AprDate').AsDateTime;
end;

procedure TAphBtr.WriteAprDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AprDate').AsDateTime := pValue;
end;

function TAphBtr.ReadAprTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('AprTime').AsDateTime;
end;

procedure TAphBtr.WriteAprTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AprTime').AsDateTime := pValue;
end;

function TAphBtr.ReadDstStat:Str1;
begin
  Result := oBtrTable.FieldByName('DstStat').AsString;
end;

procedure TAphBtr.WriteDstStat(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStat').AsString := pValue;
end;

function TAphBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAphBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAphBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAphBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAphBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAphBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAphBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TAphBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAphBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAphBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAphBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAphBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAphBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAphBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAphBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TAphBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAphBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TAphBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAphBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TAphBtr.LocateDstStat (pDstStat:Str1):boolean;
begin
  SetIndex (ixDstStat);
  Result := oBtrTable.FindKey([pDstStat]);
end;

function TAphBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TAphBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAphBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TAphBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAphBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TAphBtr.NearestDstStat (pDstStat:Str1):boolean;
begin
  SetIndex (ixDstStat);
  Result := oBtrTable.FindNearest([pDstStat]);
end;

procedure TAphBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAphBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAphBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAphBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAphBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAphBtr.First;
begin
  oBtrTable.First;
end;

procedure TAphBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAphBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAphBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAphBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAphBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAphBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAphBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAphBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAphBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAphBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAphBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
