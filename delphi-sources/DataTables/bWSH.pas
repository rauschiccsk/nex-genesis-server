unit bWSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDoDate = 'DoDate';
  ixSmCode = 'SmCode';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixIcdNum = 'IcdNum';
  ixSended = 'Sended';
  ixSndDoc = 'SndDoc';

type
  TWshBtr = class (TComponent)
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
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadInpQnt:word;           procedure WriteInpQnt (pValue:word);
    function  ReadOutQnt:word;           procedure WriteOutQnt (pValue:word);
    function  ReadActQnt:word;           procedure WriteActQnt (pValue:word);
    function  ReadPcoQnt:word;           procedure WritePcoQnt (pValue:word);
    function  ReadPciQnt:word;           procedure WritePciQnt (pValue:word);
    function  ReadOutDate1:TDatetime;    procedure WriteOutDate1 (pValue:TDatetime);
    function  ReadOutDate2:TDatetime;    procedure WriteOutDate2 (pValue:TDatetime);
    function  ReadOutDate3:TDatetime;    procedure WriteOutDate3 (pValue:TDatetime);
    function  ReadOutDate4:TDatetime;    procedure WriteOutDate4 (pValue:TDatetime);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadLouDate:TDatetime;     procedure WriteLouDate (pValue:TDatetime);
    function  ReadTelWork:Str20;         procedure WriteTelWork (pValue:Str20);
    function  ReadTelMob:Str15;          procedure WriteTelMob (pValue:Str15);
    function  ReadPlnDate1:TDatetime;    procedure WritePlnDate1 (pValue:TDatetime);
    function  ReadPlnDate2:TDatetime;    procedure WritePlnDate2 (pValue:TDatetime);
    function  ReadPlnDate3:TDatetime;    procedure WritePlnDate3 (pValue:TDatetime);
    function  ReadPlnDate4:TDatetime;    procedure WritePlnDate4 (pValue:TDatetime);
    function  ReadSanType1:byte;         procedure WriteSanType1 (pValue:byte);
    function  ReadSanType2:byte;         procedure WriteSanType2 (pValue:byte);
    function  ReadSanType3:byte;         procedure WriteSanType3 (pValue:byte);
    function  ReadSanType4:byte;         procedure WriteSanType4 (pValue:byte);
    function  ReadDstEnd:byte;           procedure WriteDstEnd (pValue:byte);
    function  ReadCorQnt:word;           procedure WriteCorQnt (pValue:word);
    function  ReadSndWri:word;           procedure WriteSndWri (pValue:word);
    function  ReadSndDoc:Str12;          procedure WriteSndDoc (pValue:Str12);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadSndTime:TDatetime;     procedure WriteSndTime (pValue:TDatetime);
    function  ReadRcvWri:word;           procedure WriteRcvWri (pValue:word);
    function  ReadRcvDoc:Str12;          procedure WriteRcvDoc (pValue:Str12);
    function  ReadRcvDate:TDatetime;     procedure WriteRcvDate (pValue:TDatetime);
    function  ReadRcvTime:TDatetime;     procedure WriteRcvTime (pValue:TDatetime);
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
    function LocateDoDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateIcdNum (pIcdNum:Str12):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateSndDoc (pSndDoc:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoDate (pDocDate:TDatetime):boolean;
    function NearestSmCode (pSmCode:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestIcdNum (pIcdNum:Str12):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestSndDoc (pSndDoc:Str12):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property CValue:double read ReadCValue write WriteCValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property InpQnt:word read ReadInpQnt write WriteInpQnt;
    property OutQnt:word read ReadOutQnt write WriteOutQnt;
    property ActQnt:word read ReadActQnt write WriteActQnt;
    property PcoQnt:word read ReadPcoQnt write WritePcoQnt;
    property PciQnt:word read ReadPciQnt write WritePciQnt;
    property OutDate1:TDatetime read ReadOutDate1 write WriteOutDate1;
    property OutDate2:TDatetime read ReadOutDate2 write WriteOutDate2;
    property OutDate3:TDatetime read ReadOutDate3 write WriteOutDate3;
    property OutDate4:TDatetime read ReadOutDate4 write WriteOutDate4;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property LouDate:TDatetime read ReadLouDate write WriteLouDate;
    property TelWork:Str20 read ReadTelWork write WriteTelWork;
    property TelMob:Str15 read ReadTelMob write WriteTelMob;
    property PlnDate1:TDatetime read ReadPlnDate1 write WritePlnDate1;
    property PlnDate2:TDatetime read ReadPlnDate2 write WritePlnDate2;
    property PlnDate3:TDatetime read ReadPlnDate3 write WritePlnDate3;
    property PlnDate4:TDatetime read ReadPlnDate4 write WritePlnDate4;
    property SanType1:byte read ReadSanType1 write WriteSanType1;
    property SanType2:byte read ReadSanType2 write WriteSanType2;
    property SanType3:byte read ReadSanType3 write WriteSanType3;
    property SanType4:byte read ReadSanType4 write WriteSanType4;
    property DstEnd:byte read ReadDstEnd write WriteDstEnd;
    property CorQnt:word read ReadCorQnt write WriteCorQnt;
    property SndWri:word read ReadSndWri write WriteSndWri;
    property SndDoc:Str12 read ReadSndDoc write WriteSndDoc;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property SndTime:TDatetime read ReadSndTime write WriteSndTime;
    property RcvWri:word read ReadRcvWri write WriteRcvWri;
    property RcvDoc:Str12 read ReadRcvDoc write WriteRcvDoc;
    property RcvDate:TDatetime read ReadRcvDate write WriteRcvDate;
    property RcvTime:TDatetime read ReadRcvTime write WriteRcvTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TWshBtr.Create;
begin
  oBtrTable := BtrInit ('WSH',gPath.StkPath,Self);
end;

constructor TWshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WSH',pPath,Self);
end;

destructor TWshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TWshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TWshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TWshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TWshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TWshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TWshBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TWshBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TWshBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TWshBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TWshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TWshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TWshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TWshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TWshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TWshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TWshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TWshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TWshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TWshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TWshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TWshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TWshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TWshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TWshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TWshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TWshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TWshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TWshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TWshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TWshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TWshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TWshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TWshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TWshBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TWshBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TWshBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TWshBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TWshBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TWshBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TWshBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TWshBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TWshBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TWshBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TWshBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TWshBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TWshBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TWshBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TWshBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TWshBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TWshBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TWshBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TWshBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TWshBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TWshBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TWshBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TWshBtr.ReadInpQnt:word;
begin
  Result := oBtrTable.FieldByName('InpQnt').AsInteger;
end;

procedure TWshBtr.WriteInpQnt(pValue:word);
begin
  oBtrTable.FieldByName('InpQnt').AsInteger := pValue;
end;

function TWshBtr.ReadOutQnt:word;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsInteger;
end;

procedure TWshBtr.WriteOutQnt(pValue:word);
begin
  oBtrTable.FieldByName('OutQnt').AsInteger := pValue;
end;

function TWshBtr.ReadActQnt:word;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TWshBtr.WriteActQnt(pValue:word);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TWshBtr.ReadPcoQnt:word;
begin
  Result := oBtrTable.FieldByName('PcoQnt').AsInteger;
end;

procedure TWshBtr.WritePcoQnt(pValue:word);
begin
  oBtrTable.FieldByName('PcoQnt').AsInteger := pValue;
end;

function TWshBtr.ReadPciQnt:word;
begin
  Result := oBtrTable.FieldByName('PciQnt').AsInteger;
end;

procedure TWshBtr.WritePciQnt(pValue:word);
begin
  oBtrTable.FieldByName('PciQnt').AsInteger := pValue;
end;

function TWshBtr.ReadOutDate1:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDate1').AsDateTime;
end;

procedure TWshBtr.WriteOutDate1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDate1').AsDateTime := pValue;
end;

function TWshBtr.ReadOutDate2:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDate2').AsDateTime;
end;

procedure TWshBtr.WriteOutDate2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDate2').AsDateTime := pValue;
end;

function TWshBtr.ReadOutDate3:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDate3').AsDateTime;
end;

procedure TWshBtr.WriteOutDate3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDate3').AsDateTime := pValue;
end;

function TWshBtr.ReadOutDate4:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDate4').AsDateTime;
end;

procedure TWshBtr.WriteOutDate4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDate4').AsDateTime := pValue;
end;

function TWshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TWshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TWshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TWshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TWshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TWshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TWshBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TWshBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TWshBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TWshBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TWshBtr.ReadCAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TWshBtr.WriteCAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TWshBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TWshBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TWshBtr.ReadDAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TWshBtr.WriteDAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TWshBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TWshBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TWshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TWshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TWshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWshBtr.ReadLouDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('LouDate').AsDateTime;
end;

procedure TWshBtr.WriteLouDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LouDate').AsDateTime := pValue;
end;

function TWshBtr.ReadTelWork:Str20;
begin
  Result := oBtrTable.FieldByName('TelWork').AsString;
end;

procedure TWshBtr.WriteTelWork(pValue:Str20);
begin
  oBtrTable.FieldByName('TelWork').AsString := pValue;
end;

function TWshBtr.ReadTelMob:Str15;
begin
  Result := oBtrTable.FieldByName('TelMob').AsString;
end;

procedure TWshBtr.WriteTelMob(pValue:Str15);
begin
  oBtrTable.FieldByName('TelMob').AsString := pValue;
end;

function TWshBtr.ReadPlnDate1:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate1').AsDateTime;
end;

procedure TWshBtr.WritePlnDate1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate1').AsDateTime := pValue;
end;

function TWshBtr.ReadPlnDate2:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate2').AsDateTime;
end;

procedure TWshBtr.WritePlnDate2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate2').AsDateTime := pValue;
end;

function TWshBtr.ReadPlnDate3:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate3').AsDateTime;
end;

procedure TWshBtr.WritePlnDate3(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate3').AsDateTime := pValue;
end;

function TWshBtr.ReadPlnDate4:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate4').AsDateTime;
end;

procedure TWshBtr.WritePlnDate4(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate4').AsDateTime := pValue;
end;

function TWshBtr.ReadSanType1:byte;
begin
  Result := oBtrTable.FieldByName('SanType1').AsInteger;
end;

procedure TWshBtr.WriteSanType1(pValue:byte);
begin
  oBtrTable.FieldByName('SanType1').AsInteger := pValue;
end;

function TWshBtr.ReadSanType2:byte;
begin
  Result := oBtrTable.FieldByName('SanType2').AsInteger;
end;

procedure TWshBtr.WriteSanType2(pValue:byte);
begin
  oBtrTable.FieldByName('SanType2').AsInteger := pValue;
end;

function TWshBtr.ReadSanType3:byte;
begin
  Result := oBtrTable.FieldByName('SanType3').AsInteger;
end;

procedure TWshBtr.WriteSanType3(pValue:byte);
begin
  oBtrTable.FieldByName('SanType3').AsInteger := pValue;
end;

function TWshBtr.ReadSanType4:byte;
begin
  Result := oBtrTable.FieldByName('SanType4').AsInteger;
end;

procedure TWshBtr.WriteSanType4(pValue:byte);
begin
  oBtrTable.FieldByName('SanType4').AsInteger := pValue;
end;

function TWshBtr.ReadDstEnd:byte;
begin
  Result := oBtrTable.FieldByName('DstEnd').AsInteger;
end;

procedure TWshBtr.WriteDstEnd(pValue:byte);
begin
  oBtrTable.FieldByName('DstEnd').AsInteger := pValue;
end;

function TWshBtr.ReadCorQnt:word;
begin
  Result := oBtrTable.FieldByName('CorQnt').AsInteger;
end;

procedure TWshBtr.WriteCorQnt(pValue:word);
begin
  oBtrTable.FieldByName('CorQnt').AsInteger := pValue;
end;

function TWshBtr.ReadSndWri:word;
begin
  Result := oBtrTable.FieldByName('SndWri').AsInteger;
end;

procedure TWshBtr.WriteSndWri(pValue:word);
begin
  oBtrTable.FieldByName('SndWri').AsInteger := pValue;
end;

function TWshBtr.ReadSndDoc:Str12;
begin
  Result := oBtrTable.FieldByName('SndDoc').AsString;
end;

procedure TWshBtr.WriteSndDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('SndDoc').AsString := pValue;
end;

function TWshBtr.ReadSndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDate').AsDateTime;
end;

procedure TWshBtr.WriteSndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TWshBtr.ReadSndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndTime').AsDateTime;
end;

procedure TWshBtr.WriteSndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndTime').AsDateTime := pValue;
end;

function TWshBtr.ReadRcvWri:word;
begin
  Result := oBtrTable.FieldByName('RcvWri').AsInteger;
end;

procedure TWshBtr.WriteRcvWri(pValue:word);
begin
  oBtrTable.FieldByName('RcvWri').AsInteger := pValue;
end;

function TWshBtr.ReadRcvDoc:Str12;
begin
  Result := oBtrTable.FieldByName('RcvDoc').AsString;
end;

procedure TWshBtr.WriteRcvDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('RcvDoc').AsString := pValue;
end;

function TWshBtr.ReadRcvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RcvDate').AsDateTime;
end;

procedure TWshBtr.WriteRcvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RcvDate').AsDateTime := pValue;
end;

function TWshBtr.ReadRcvTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RcvTime').AsDateTime;
end;

procedure TWshBtr.WriteRcvTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RcvTime').AsDateTime := pValue;
end;

function TWshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TWshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TWshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TWshBtr.LocateDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TWshBtr.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindKey([pSmCode]);
end;

function TWshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TWshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TWshBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TWshBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TWshBtr.LocateSndDoc (pSndDoc:Str12):boolean;
begin
  SetIndex (ixSndDoc);
  Result := oBtrTable.FindKey([pSndDoc]);
end;

function TWshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TWshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TWshBtr.NearestDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TWshBtr.NearestSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindNearest([pSmCode]);
end;

function TWshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TWshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TWshBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

function TWshBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TWshBtr.NearestSndDoc (pSndDoc:Str12):boolean;
begin
  SetIndex (ixSndDoc);
  Result := oBtrTable.FindNearest([pSndDoc]);
end;

procedure TWshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TWshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWshBtr.First;
begin
  oBtrTable.First;
end;

procedure TWshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
