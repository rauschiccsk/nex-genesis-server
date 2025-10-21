unit bCSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDtDc = 'DtDc';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixPyIncVal = 'PyIncVal';
  ixPyExpVal = 'PyExpVal';
  ixDocDate = 'DocDate';
  ixDrvCode = 'DrvCode';
  ixCarMark = 'CarMark';
  ixSended = 'Sended';
  ixDstAcc = 'DstAcc';
  ixDstLiq = 'DstLiq';

type
  TCshBtr = class (TComponent)
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
    function  ReadDocCnt:word;           procedure WriteDocCnt (pValue:word);
    function  ReadDocType:Str1;          procedure WriteDocType (pValue:Str1);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
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
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcBValue1:double;      procedure WriteAcBValue1 (pValue:double);
    function  ReadAcBValue2:double;      procedure WriteAcBValue2 (pValue:double);
    function  ReadAcBValue3:double;      procedure WriteAcBValue3 (pValue:double);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyAValue:double;       procedure WritePyAValue (pValue:double);
    function  ReadPyVatVal:double;       procedure WritePyVatVal (pValue:double);
    function  ReadPyBValue:double;       procedure WritePyBValue (pValue:double);
    function  ReadPyBegVal:double;       procedure WritePyBegVal (pValue:double);
    function  ReadPyIncVal:double;       procedure WritePyIncVal (pValue:double);
    function  ReadPyExpVal:double;       procedure WritePyExpVal (pValue:double);
    function  ReadPyEndVal:double;       procedure WritePyEndVal (pValue:double);
    function  ReadPyAValue1:double;      procedure WritePyAValue1 (pValue:double);
    function  ReadPyAValue2:double;      procedure WritePyAValue2 (pValue:double);
    function  ReadPyAValue3:double;      procedure WritePyAValue3 (pValue:double);
    function  ReadPyBValue1:double;      procedure WritePyBValue1 (pValue:double);
    function  ReadPyBValue2:double;      procedure WritePyBValue2 (pValue:double);
    function  ReadPyBValue3:double;      procedure WritePyBValue3 (pValue:double);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDrvCode:word;          procedure WriteDrvCode (pValue:word);
    function  ReadDrvName:Str30;         procedure WriteDrvName (pValue:Str30);
    function  ReadCarMark:Str10;         procedure WriteCarMark (pValue:Str10);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadExcCosVal:double;      procedure WriteExcCosVal (pValue:double);
    function  ReadExcVatVal:double;      procedure WriteExcVatVal (pValue:double);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcBValue4:double;      procedure WriteAcBValue4 (pValue:double);
    function  ReadPyAValue4:double;      procedure WritePyAValue4 (pValue:double);
    function  ReadPyBValue4:double;      procedure WritePyBValue4 (pValue:double);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcBValue5:double;      procedure WriteAcBValue5 (pValue:double);
    function  ReadPyAValue5:double;      procedure WritePyAValue5 (pValue:double);
    function  ReadPyBValue5:double;      procedure WritePyBValue5 (pValue:double);
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
    function LocateDtDc (pDocType:Str1;pDocCnt:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocatePyIncVal (pPyIncVal:double):boolean;
    function LocatePyExpVal (pPyExpVal:double):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDrvCode (pDrvCode:word):boolean;
    function LocateCarMark (pCarMark:Str10):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateDstLiq (pDstLiq:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDtDc (pDocType:Str1;pDocCnt:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestPyIncVal (pPyIncVal:double):boolean;
    function NearestPyExpVal (pPyExpVal:double):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDrvCode (pDrvCode:word):boolean;
    function NearestCarMark (pCarMark:Str10):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;
    function NearestDstLiq (pDstLiq:Str1):boolean;

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
    property DocCnt:word read ReadDocCnt write WriteDocCnt;
    property DocType:Str1 read ReadDocType write WriteDocType;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property WriNum:word read ReadWriNum write WriteWriNum;
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
    property Notice:Str30 read ReadNotice write WriteNotice;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcBValue1:double read ReadAcBValue1 write WriteAcBValue1;
    property AcBValue2:double read ReadAcBValue2 write WriteAcBValue2;
    property AcBValue3:double read ReadAcBValue3 write WriteAcBValue3;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyAValue:double read ReadPyAValue write WritePyAValue;
    property PyVatVal:double read ReadPyVatVal write WritePyVatVal;
    property PyBValue:double read ReadPyBValue write WritePyBValue;
    property PyBegVal:double read ReadPyBegVal write WritePyBegVal;
    property PyIncVal:double read ReadPyIncVal write WritePyIncVal;
    property PyExpVal:double read ReadPyExpVal write WritePyExpVal;
    property PyEndVal:double read ReadPyEndVal write WritePyEndVal;
    property PyAValue1:double read ReadPyAValue1 write WritePyAValue1;
    property PyAValue2:double read ReadPyAValue2 write WritePyAValue2;
    property PyAValue3:double read ReadPyAValue3 write WritePyAValue3;
    property PyBValue1:double read ReadPyBValue1 write WritePyBValue1;
    property PyBValue2:double read ReadPyBValue2 write WritePyBValue2;
    property PyBValue3:double read ReadPyBValue3 write WritePyBValue3;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DrvCode:word read ReadDrvCode write WriteDrvCode;
    property DrvName:Str30 read ReadDrvName write WriteDrvName;
    property CarMark:Str10 read ReadCarMark write WriteCarMark;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property Year:Str2 read ReadYear write WriteYear;
    property ExcCosVal:double read ReadExcCosVal write WriteExcCosVal;
    property ExcVatVal:double read ReadExcVatVal write WriteExcVatVal;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcBValue4:double read ReadAcBValue4 write WriteAcBValue4;
    property PyAValue4:double read ReadPyAValue4 write WritePyAValue4;
    property PyBValue4:double read ReadPyBValue4 write WritePyBValue4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcBValue5:double read ReadAcBValue5 write WriteAcBValue5;
    property PyAValue5:double read ReadPyAValue5 write WritePyAValue5;
    property PyBValue5:double read ReadPyBValue5 write WritePyBValue5;
  end;

implementation

constructor TCshBtr.Create;
begin
  oBtrTable := BtrInit ('CSH',gPath.LdgPath,Self);
end;

constructor TCshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CSH',pPath,Self);
end;

destructor TCshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TCshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCshBtr.ReadDocCnt:word;
begin
  Result := oBtrTable.FieldByName('DocCnt').AsInteger;
end;

procedure TCshBtr.WriteDocCnt(pValue:word);
begin
  oBtrTable.FieldByName('DocCnt').AsInteger := pValue;
end;

function TCshBtr.ReadDocType:Str1;
begin
  Result := oBtrTable.FieldByName('DocType').AsString;
end;

procedure TCshBtr.WriteDocType(pValue:Str1);
begin
  oBtrTable.FieldByName('DocType').AsString := pValue;
end;

function TCshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCshBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TCshBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TCshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TCshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TCshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TCshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TCshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TCshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TCshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TCshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TCshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TCshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TCshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TCshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TCshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TCshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TCshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TCshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TCshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TCshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TCshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TCshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TCshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TCshBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TCshBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TCshBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TCshBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TCshBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TCshBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TCshBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TCshBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TCshBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TCshBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TCshBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TCshBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TCshBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TCshBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TCshBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TCshBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TCshBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TCshBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TCshBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TCshBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TCshBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TCshBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TCshBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TCshBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TCshBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TCshBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TCshBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TCshBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue:double;
begin
  Result := oBtrTable.FieldByName('PyAValue').AsFloat;
end;

procedure TCshBtr.WritePyAValue(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue').AsFloat := pValue;
end;

function TCshBtr.ReadPyVatVal:double;
begin
  Result := oBtrTable.FieldByName('PyVatVal').AsFloat;
end;

procedure TCshBtr.WritePyVatVal(pValue:double);
begin
  oBtrTable.FieldByName('PyVatVal').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue:double;
begin
  Result := oBtrTable.FieldByName('PyBValue').AsFloat;
end;

procedure TCshBtr.WritePyBValue(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue').AsFloat := pValue;
end;

function TCshBtr.ReadPyBegVal:double;
begin
  Result := oBtrTable.FieldByName('PyBegVal').AsFloat;
end;

procedure TCshBtr.WritePyBegVal(pValue:double);
begin
  oBtrTable.FieldByName('PyBegVal').AsFloat := pValue;
end;

function TCshBtr.ReadPyIncVal:double;
begin
  Result := oBtrTable.FieldByName('PyIncVal').AsFloat;
end;

procedure TCshBtr.WritePyIncVal(pValue:double);
begin
  oBtrTable.FieldByName('PyIncVal').AsFloat := pValue;
end;

function TCshBtr.ReadPyExpVal:double;
begin
  Result := oBtrTable.FieldByName('PyExpVal').AsFloat;
end;

procedure TCshBtr.WritePyExpVal(pValue:double);
begin
  oBtrTable.FieldByName('PyExpVal').AsFloat := pValue;
end;

function TCshBtr.ReadPyEndVal:double;
begin
  Result := oBtrTable.FieldByName('PyEndVal').AsFloat;
end;

procedure TCshBtr.WritePyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('PyEndVal').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue1:double;
begin
  Result := oBtrTable.FieldByName('PyAValue1').AsFloat;
end;

procedure TCshBtr.WritePyAValue1(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue1').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue2:double;
begin
  Result := oBtrTable.FieldByName('PyAValue2').AsFloat;
end;

procedure TCshBtr.WritePyAValue2(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue2').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue3:double;
begin
  Result := oBtrTable.FieldByName('PyAValue3').AsFloat;
end;

procedure TCshBtr.WritePyAValue3(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue3').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue1:double;
begin
  Result := oBtrTable.FieldByName('PyBValue1').AsFloat;
end;

procedure TCshBtr.WritePyBValue1(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue1').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue2:double;
begin
  Result := oBtrTable.FieldByName('PyBValue2').AsFloat;
end;

procedure TCshBtr.WritePyBValue2(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue2').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue3:double;
begin
  Result := oBtrTable.FieldByName('PyBValue3').AsFloat;
end;

procedure TCshBtr.WritePyBValue3(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue3').AsFloat := pValue;
end;

function TCshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TCshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TCshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCshBtr.ReadDocSpc:byte;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TCshBtr.WriteDocSpc(pValue:byte);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TCshBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TCshBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TCshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCshBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCshBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCshBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TCshBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TCshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TCshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TCshBtr.ReadDrvCode:word;
begin
  Result := oBtrTable.FieldByName('DrvCode').AsInteger;
end;

procedure TCshBtr.WriteDrvCode(pValue:word);
begin
  oBtrTable.FieldByName('DrvCode').AsInteger := pValue;
end;

function TCshBtr.ReadDrvName:Str30;
begin
  Result := oBtrTable.FieldByName('DrvName').AsString;
end;

procedure TCshBtr.WriteDrvName(pValue:Str30);
begin
  oBtrTable.FieldByName('DrvName').AsString := pValue;
end;

function TCshBtr.ReadCarMark:Str10;
begin
  Result := oBtrTable.FieldByName('CarMark').AsString;
end;

procedure TCshBtr.WriteCarMark(pValue:Str10);
begin
  oBtrTable.FieldByName('CarMark').AsString := pValue;
end;

function TCshBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TCshBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCshBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TCshBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TCshBtr.ReadDstLiq:Str1;
begin
  Result := oBtrTable.FieldByName('DstLiq').AsString;
end;

procedure TCshBtr.WriteDstLiq(pValue:Str1);
begin
  oBtrTable.FieldByName('DstLiq').AsString := pValue;
end;

function TCshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TCshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TCshBtr.ReadExcCosVal:double;
begin
  Result := oBtrTable.FieldByName('ExcCosVal').AsFloat;
end;

procedure TCshBtr.WriteExcCosVal(pValue:double);
begin
  oBtrTable.FieldByName('ExcCosVal').AsFloat := pValue;
end;

function TCshBtr.ReadExcVatVal:double;
begin
  Result := oBtrTable.FieldByName('ExcVatVal').AsFloat;
end;

procedure TCshBtr.WriteExcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('ExcVatVal').AsFloat := pValue;
end;

function TCshBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TCshBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TCshBtr.ReadAcAValue4:double;
begin
  Result := oBtrTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TCshBtr.WriteAcAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue4:double;
begin
  Result := oBtrTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TCshBtr.WriteAcBValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue4:double;
begin
  Result := oBtrTable.FieldByName('PyAValue4').AsFloat;
end;

procedure TCshBtr.WritePyAValue4(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue4').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue4:double;
begin
  Result := oBtrTable.FieldByName('PyBValue4').AsFloat;
end;

procedure TCshBtr.WritePyBValue4(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue4').AsFloat := pValue;
end;

function TCshBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TCshBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TCshBtr.ReadAcAValue5:double;
begin
  Result := oBtrTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TCshBtr.WriteAcAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TCshBtr.ReadAcBValue5:double;
begin
  Result := oBtrTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TCshBtr.WriteAcBValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TCshBtr.ReadPyAValue5:double;
begin
  Result := oBtrTable.FieldByName('PyAValue5').AsFloat;
end;

procedure TCshBtr.WritePyAValue5(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue5').AsFloat := pValue;
end;

function TCshBtr.ReadPyBValue5:double;
begin
  Result := oBtrTable.FieldByName('PyBValue5').AsFloat;
end;

procedure TCshBtr.WritePyBValue5(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TCshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCshBtr.LocateDtDc (pDocType:Str1;pDocCnt:word):boolean;
begin
  SetIndex (ixDtDc);
  Result := oBtrTable.FindKey([pDocType,pDocCnt]);
end;

function TCshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TCshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TCshBtr.LocatePyIncVal (pPyIncVal:double):boolean;
begin
  SetIndex (ixPyIncVal);
  Result := oBtrTable.FindKey([pPyIncVal]);
end;

function TCshBtr.LocatePyExpVal (pPyExpVal:double):boolean;
begin
  SetIndex (ixPyExpVal);
  Result := oBtrTable.FindKey([pPyExpVal]);
end;

function TCshBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TCshBtr.LocateDrvCode (pDrvCode:word):boolean;
begin
  SetIndex (ixDrvCode);
  Result := oBtrTable.FindKey([pDrvCode]);
end;

function TCshBtr.LocateCarMark (pCarMark:Str10):boolean;
begin
  SetIndex (ixCarMark);
  Result := oBtrTable.FindKey([pCarMark]);
end;

function TCshBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TCshBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TCshBtr.LocateDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindKey([pDstLiq]);
end;

function TCshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TCshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCshBtr.NearestDtDc (pDocType:Str1;pDocCnt:word):boolean;
begin
  SetIndex (ixDtDc);
  Result := oBtrTable.FindNearest([pDocType,pDocCnt]);
end;

function TCshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TCshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TCshBtr.NearestPyIncVal (pPyIncVal:double):boolean;
begin
  SetIndex (ixPyIncVal);
  Result := oBtrTable.FindNearest([pPyIncVal]);
end;

function TCshBtr.NearestPyExpVal (pPyExpVal:double):boolean;
begin
  SetIndex (ixPyExpVal);
  Result := oBtrTable.FindNearest([pPyExpVal]);
end;

function TCshBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TCshBtr.NearestDrvCode (pDrvCode:word):boolean;
begin
  SetIndex (ixDrvCode);
  Result := oBtrTable.FindNearest([pDrvCode]);
end;

function TCshBtr.NearestCarMark (pCarMark:Str10):boolean;
begin
  SetIndex (ixCarMark);
  Result := oBtrTable.FindNearest([pCarMark]);
end;

function TCshBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TCshBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

function TCshBtr.NearestDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindNearest([pDstLiq]);
end;

procedure TCshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCshBtr.First;
begin
  oBtrTable.First;
end;

procedure TCshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
