unit bUDH;

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
  ixFgDvzName = 'FgDvzName';
  ixFgBValue = 'FgBValue';
  ixDlrCode = 'DlrCode';
  ixWsdNum = 'WsdNum';
  ixTcdNum = 'TcdNum';
  ixIcdNum = 'IcdNum';
  ixNudNum = 'NudNum';
  ixSended = 'Sended';
  ixSpMark = 'SpMark';
  ixSndStat = 'SndStat';

type
  TUdhBtr = class (TComponent)
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
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
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
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadWsdNum:Str12;          procedure WriteWsdNum (pValue:Str12);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadNudNum:Str12;          procedure WriteNudNum (pValue:Str12);
    function  ReadNudDate:TDatetime;     procedure WriteNudDate (pValue:TDatetime);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadNotLots:Str1;          procedure WriteNotLots (pValue:Str1);
    function  ReadPayVal0:double;        procedure WritePayVal0 (pValue:double);
    function  ReadPayVal1:double;        procedure WritePayVal1 (pValue:double);
    function  ReadPayVal2:double;        procedure WritePayVal2 (pValue:double);
    function  ReadPayVal3:double;        procedure WritePayVal3 (pValue:double);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
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
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateWsdNum (pWsdNum:Str12):boolean;
    function LocateTcdNum (pTcdNum:Str12):boolean;
    function LocateIcdNum (pIcdNum:Str12):boolean;
    function LocateNudNum (pNudNum:Str12):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateSpMark (pSpMark:Str10):boolean;
    function LocateSndStat (pSndStat:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestDlrCode (pDlrCode:word):boolean;
    function NearestWsdNum (pWsdNum:Str12):boolean;
    function NearestTcdNum (pTcdNum:Str12):boolean;
    function NearestIcdNum (pIcdNum:Str12):boolean;
    function NearestNudNum (pNudNum:Str12):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestSpMark (pSpMark:Str10):boolean;
    function NearestSndStat (pSndStat:Str1):boolean;

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
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
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
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property WsdNum:Str12 read ReadWsdNum write WriteWsdNum;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property NudNum:Str12 read ReadNudNum write WriteNudNum;
    property NudDate:TDatetime read ReadNudDate write WriteNudDate;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property NotLots:Str1 read ReadNotLots write WriteNotLots;
    property PayVal0:double read ReadPayVal0 write WritePayVal0;
    property PayVal1:double read ReadPayVal1 write WritePayVal1;
    property PayVal2:double read ReadPayVal2 write WritePayVal2;
    property PayVal3:double read ReadPayVal3 write WritePayVal3;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TUdhBtr.Create;
begin
  oBtrTable := BtrInit ('UDH',gPath.StkPath,Self);
end;

constructor TUdhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('UDH',pPath,Self);
end;

destructor TUdhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TUdhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TUdhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TUdhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TUdhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TUdhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TUdhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TUdhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TUdhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TUdhBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TUdhBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TUdhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TUdhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TUdhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TUdhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TUdhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TUdhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TUdhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TUdhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TUdhBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TUdhBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TUdhBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TUdhBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TUdhBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TUdhBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TUdhBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TUdhBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TUdhBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TUdhBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TUdhBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TUdhBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TUdhBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TUdhBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TUdhBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TUdhBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TUdhBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TUdhBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TUdhBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TUdhBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TUdhBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TUdhBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TUdhBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TUdhBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TUdhBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TUdhBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TUdhBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TUdhBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TUdhBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TUdhBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TUdhBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TUdhBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TUdhBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TUdhBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TUdhBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TUdhBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TUdhBtr.ReadFgHValue:double;
begin
  Result := oBtrTable.FieldByName('FgHValue').AsFloat;
end;

procedure TUdhBtr.WriteFgHValue(pValue:double);
begin
  oBtrTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TUdhBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TUdhBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TUdhBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TUdhBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TUdhBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TUdhBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TUdhBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TUdhBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TUdhBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TUdhBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TUdhBtr.ReadWsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('WsdNum').AsString;
end;

procedure TUdhBtr.WriteWsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('WsdNum').AsString := pValue;
end;

function TUdhBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TUdhBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TUdhBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TUdhBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TUdhBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TUdhBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TUdhBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TUdhBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TUdhBtr.ReadNudNum:Str12;
begin
  Result := oBtrTable.FieldByName('NudNum').AsString;
end;

procedure TUdhBtr.WriteNudNum(pValue:Str12);
begin
  oBtrTable.FieldByName('NudNum').AsString := pValue;
end;

function TUdhBtr.ReadNudDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('NudDate').AsDateTime;
end;

procedure TUdhBtr.WriteNudDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('NudDate').AsDateTime := pValue;
end;

function TUdhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TUdhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TUdhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TUdhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TUdhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TUdhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TUdhBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TUdhBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TUdhBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TUdhBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TUdhBtr.ReadBonNum:byte;
begin
  Result := oBtrTable.FieldByName('BonNum').AsInteger;
end;

procedure TUdhBtr.WriteBonNum(pValue:byte);
begin
  oBtrTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TUdhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TUdhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TUdhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TUdhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TUdhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TUdhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TUdhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TUdhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TUdhBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TUdhBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TUdhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TUdhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TUdhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TUdhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TUdhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TUdhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TUdhBtr.ReadNotLots:Str1;
begin
  Result := oBtrTable.FieldByName('NotLots').AsString;
end;

procedure TUdhBtr.WriteNotLots(pValue:Str1);
begin
  oBtrTable.FieldByName('NotLots').AsString := pValue;
end;

function TUdhBtr.ReadPayVal0:double;
begin
  Result := oBtrTable.FieldByName('PayVal0').AsFloat;
end;

procedure TUdhBtr.WritePayVal0(pValue:double);
begin
  oBtrTable.FieldByName('PayVal0').AsFloat := pValue;
end;

function TUdhBtr.ReadPayVal1:double;
begin
  Result := oBtrTable.FieldByName('PayVal1').AsFloat;
end;

procedure TUdhBtr.WritePayVal1(pValue:double);
begin
  oBtrTable.FieldByName('PayVal1').AsFloat := pValue;
end;

function TUdhBtr.ReadPayVal2:double;
begin
  Result := oBtrTable.FieldByName('PayVal2').AsFloat;
end;

procedure TUdhBtr.WritePayVal2(pValue:double);
begin
  oBtrTable.FieldByName('PayVal2').AsFloat := pValue;
end;

function TUdhBtr.ReadPayVal3:double;
begin
  Result := oBtrTable.FieldByName('PayVal3').AsFloat;
end;

procedure TUdhBtr.WritePayVal3(pValue:double);
begin
  oBtrTable.FieldByName('PayVal3').AsFloat := pValue;
end;

function TUdhBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TUdhBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TUdhBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TUdhBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TUdhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TUdhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUdhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUdhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TUdhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUdhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TUdhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TUdhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TUdhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TUdhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TUdhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TUdhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TUdhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TUdhBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TUdhBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TUdhBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TUdhBtr.LocateWsdNum (pWsdNum:Str12):boolean;
begin
  SetIndex (ixWsdNum);
  Result := oBtrTable.FindKey([pWsdNum]);
end;

function TUdhBtr.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindKey([pTcdNum]);
end;

function TUdhBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TUdhBtr.LocateNudNum (pNudNum:Str12):boolean;
begin
  SetIndex (ixNudNum);
  Result := oBtrTable.FindKey([pNudNum]);
end;

function TUdhBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TUdhBtr.LocateSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindKey([pSpMark]);
end;

function TUdhBtr.LocateSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindKey([pSndStat]);
end;

function TUdhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TUdhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TUdhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TUdhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TUdhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TUdhBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TUdhBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TUdhBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TUdhBtr.NearestWsdNum (pWsdNum:Str12):boolean;
begin
  SetIndex (ixWsdNum);
  Result := oBtrTable.FindNearest([pWsdNum]);
end;

function TUdhBtr.NearestTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindNearest([pTcdNum]);
end;

function TUdhBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

function TUdhBtr.NearestNudNum (pNudNum:Str12):boolean;
begin
  SetIndex (ixNudNum);
  Result := oBtrTable.FindNearest([pNudNum]);
end;

function TUdhBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TUdhBtr.NearestSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindNearest([pSpMark]);
end;

function TUdhBtr.NearestSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindNearest([pSndStat]);
end;

procedure TUdhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TUdhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TUdhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TUdhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TUdhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TUdhBtr.First;
begin
  oBtrTable.First;
end;

procedure TUdhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TUdhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TUdhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TUdhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TUdhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TUdhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TUdhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TUdhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TUdhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TUdhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TUdhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
