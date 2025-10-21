unit bTSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixStkNum = 'StkNum';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixOcdNum = 'OcdNum';
  ixCsdNum = 'CsdNum';
  ixSended = 'Sended';
  ixDstAcc = 'DstAcc';
  ixSndStat = 'SndStat';
  ixDstCor = 'DstCor';
  ixPcDp = 'PcDp';
  ixDstLiq = 'DstLiq';
  ixRbaCode = 'RbaCode';

type
  TTshBtr = class (TComponent)
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
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
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
    function  ReadPayCode:Str3;          procedure WritePayCode (pValue:Str3);
    function  ReadPayName:Str20;         procedure WritePayName (pValue:Str20);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str20;         procedure WriteTrsName (pValue:Str20);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcZValue:double;       procedure WriteAcZValue (pValue:double);
    function  ReadAcTValue:double;       procedure WriteAcTValue (pValue:double);
    function  ReadAcOValue:double;       procedure WriteAcOValue (pValue:double);
    function  ReadAcSValue:double;       procedure WriteAcSValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcCValue1:double;      procedure WriteAcCValue1 (pValue:double);
    function  ReadAcCValue2:double;      procedure WriteAcCValue2 (pValue:double);
    function  ReadAcCValue3:double;      procedure WriteAcCValue3 (pValue:double);
    function  ReadAcEValue1:double;      procedure WriteAcEValue1 (pValue:double);
    function  ReadAcEValue2:double;      procedure WriteAcEValue2 (pValue:double);
    function  ReadAcEValue3:double;      procedure WriteAcEValue3 (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadFgCValue1:double;      procedure WriteFgCValue1 (pValue:double);
    function  ReadFgCValue2:double;      procedure WriteFgCValue2 (pValue:double);
    function  ReadFgCValue3:double;      procedure WriteFgCValue3 (pValue:double);
    function  ReadFgEValue1:double;      procedure WriteFgEValue1 (pValue:double);
    function  ReadFgEValue2:double;      procedure WriteFgEValue2 (pValue:double);
    function  ReadFgEValue3:double;      procedure WriteFgEValue3 (pValue:double);
    function  ReadFgCsdVal1:double;      procedure WriteFgCsdVal1 (pValue:double);
    function  ReadFgCsdVal2:double;      procedure WriteFgCsdVal2 (pValue:double);
    function  ReadFgCsdVal3:double;      procedure WriteFgCsdVal3 (pValue:double);
    function  ReadZIseNum:Str12;         procedure WriteZIseNum (pValue:Str12);
    function  ReadTIseNum:Str12;         procedure WriteTIseNum (pValue:Str12);
    function  ReadOIseNum:Str12;         procedure WriteOIseNum (pValue:Str12);
    function  ReadGIseNum:Str12;         procedure WriteGIseNum (pValue:Str12);
    function  ReadZIsdNum:Str12;         procedure WriteZIsdNum (pValue:Str12);
    function  ReadTIsdNum:Str12;         procedure WriteTIsdNum (pValue:Str12);
    function  ReadOIsdNum:Str12;         procedure WriteOIsdNum (pValue:Str12);
    function  ReadGIsdNum:Str12;         procedure WriteGIsdNum (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadIsdNum:Str15;          procedure WriteIsdNum (pValue:Str15);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str8;          procedure WriteCAccAnl (pValue:Str8);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str8;          procedure WriteDAccAnl (pValue:Str8);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadAcPrfVal:double;       procedure WriteAcPrfVal (pValue:double);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadDstCor:Str1;           procedure WriteDstCor (pValue:Str1);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadPkdNum:Str12;          procedure WritePkdNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadAcCValue4:double;      procedure WriteAcCValue4 (pValue:double);
    function  ReadAcEValue4:double;      procedure WriteAcEValue4 (pValue:double);
    function  ReadFgCValue4:double;      procedure WriteFgCValue4 (pValue:double);
    function  ReadFgEValue4:double;      procedure WriteFgEValue4 (pValue:double);
    function  ReadFgCsdVal4:double;      procedure WriteFgCsdVal4 (pValue:double);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcCValue5:double;      procedure WriteAcCValue5 (pValue:double);
    function  ReadAcEValue5:double;      procedure WriteAcEValue5 (pValue:double);
    function  ReadFgCValue5:double;      procedure WriteFgCValue5 (pValue:double);
    function  ReadFgEValue5:double;      procedure WriteFgEValue5 (pValue:double);
    function  ReadFgCsdVal5:double;      procedure WriteFgCsdVal5 (pValue:double);
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
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateCsdNum (pCsdNum:Str12):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSndStat (pSndStat:Str1):boolean;
    function LocateDstCor (pDstCor:Str1):boolean;
    function LocatePcDp (pPaCode:longint;pDstPair:Str1):boolean;
    function LocateDstLiq (pDstLiq:Str1):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestStkNum (pStkNum:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestAcEValue (pAcEValue:double):boolean;
    function NearestFgEValue (pFgEValue:double):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;
    function NearestCsdNum (pCsdNum:Str12):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;
    function NearestSndStat (pSndStat:Str1):boolean;
    function NearestDstCor (pDstCor:Str1):boolean;
    function NearestPcDp (pPaCode:longint;pDstPair:Str1):boolean;
    function NearestDstLiq (pDstLiq:Str1):boolean;
    function NearestRbaCode (pRbaCode:Str30):boolean;

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
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
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
    property PayCode:Str3 read ReadPayCode write WritePayCode;
    property PayName:Str20 read ReadPayName write WritePayName;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str20 read ReadTrsName write WriteTrsName;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcZValue:double read ReadAcZValue write WriteAcZValue;
    property AcTValue:double read ReadAcTValue write WriteAcTValue;
    property AcOValue:double read ReadAcOValue write WriteAcOValue;
    property AcSValue:double read ReadAcSValue write WriteAcSValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcCValue1:double read ReadAcCValue1 write WriteAcCValue1;
    property AcCValue2:double read ReadAcCValue2 write WriteAcCValue2;
    property AcCValue3:double read ReadAcCValue3 write WriteAcCValue3;
    property AcEValue1:double read ReadAcEValue1 write WriteAcEValue1;
    property AcEValue2:double read ReadAcEValue2 write WriteAcEValue2;
    property AcEValue3:double read ReadAcEValue3 write WriteAcEValue3;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property FgCValue1:double read ReadFgCValue1 write WriteFgCValue1;
    property FgCValue2:double read ReadFgCValue2 write WriteFgCValue2;
    property FgCValue3:double read ReadFgCValue3 write WriteFgCValue3;
    property FgEValue1:double read ReadFgEValue1 write WriteFgEValue1;
    property FgEValue2:double read ReadFgEValue2 write WriteFgEValue2;
    property FgEValue3:double read ReadFgEValue3 write WriteFgEValue3;
    property FgCsdVal1:double read ReadFgCsdVal1 write WriteFgCsdVal1;
    property FgCsdVal2:double read ReadFgCsdVal2 write WriteFgCsdVal2;
    property FgCsdVal3:double read ReadFgCsdVal3 write WriteFgCsdVal3;
    property ZIseNum:Str12 read ReadZIseNum write WriteZIseNum;
    property TIseNum:Str12 read ReadTIseNum write WriteTIseNum;
    property OIseNum:Str12 read ReadOIseNum write WriteOIseNum;
    property GIseNum:Str12 read ReadGIseNum write WriteGIseNum;
    property ZIsdNum:Str12 read ReadZIsdNum write WriteZIsdNum;
    property TIsdNum:Str12 read ReadTIsdNum write WriteTIsdNum;
    property OIsdNum:Str12 read ReadOIsdNum write WriteOIsdNum;
    property GIsdNum:Str12 read ReadGIsdNum write WriteGIsdNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property IsdNum:Str15 read ReadIsdNum write WriteIsdNum;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str8 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str8 read ReadDAccAnl write WriteDAccAnl;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property AcPrfVal:double read ReadAcPrfVal write WriteAcPrfVal;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property DstCor:Str1 read ReadDstCor write WriteDstCor;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property PkdNum:Str12 read ReadPkdNum write WritePkdNum;
    property Year:Str2 read ReadYear write WriteYear;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property AcCValue4:double read ReadAcCValue4 write WriteAcCValue4;
    property AcEValue4:double read ReadAcEValue4 write WriteAcEValue4;
    property FgCValue4:double read ReadFgCValue4 write WriteFgCValue4;
    property FgEValue4:double read ReadFgEValue4 write WriteFgEValue4;
    property FgCsdVal4:double read ReadFgCsdVal4 write WriteFgCsdVal4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcCValue5:double read ReadAcCValue5 write WriteAcCValue5;
    property AcEValue5:double read ReadAcEValue5 write WriteAcEValue5;
    property FgCValue5:double read ReadFgCValue5 write WriteFgCValue5;
    property FgEValue5:double read ReadFgEValue5 write WriteFgEValue5;
    property FgCsdVal5:double read ReadFgCsdVal5 write WriteFgCsdVal5;
  end;

implementation

constructor TTshBtr.Create;
begin
  oBtrTable := BtrInit ('TSH',gPath.StkPath,Self);
end;

constructor TTshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TSH',pPath,Self);
end;

destructor TTshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTshBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTshBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTshBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTshBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TTshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TTshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TTshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TTshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TTshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TTshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TTshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TTshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TTshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TTshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TTshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TTshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TTshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TTshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TTshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TTshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TTshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TTshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TTshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TTshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TTshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TTshBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TTshBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TTshBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TTshBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TTshBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TTshBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TTshBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TTshBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TTshBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TTshBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TTshBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TTshBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TTshBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TTshBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TTshBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TTshBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TTshBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TTshBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TTshBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TTshBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TTshBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TTshBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TTshBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTshBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTshBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTshBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTshBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TTshBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TTshBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TTshBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TTshBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TTshBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TTshBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TTshBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TTshBtr.ReadAcZValue:double;
begin
  Result := oBtrTable.FieldByName('AcZValue').AsFloat;
end;

procedure TTshBtr.WriteAcZValue(pValue:double);
begin
  oBtrTable.FieldByName('AcZValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcTValue:double;
begin
  Result := oBtrTable.FieldByName('AcTValue').AsFloat;
end;

procedure TTshBtr.WriteAcTValue(pValue:double);
begin
  oBtrTable.FieldByName('AcTValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcOValue:double;
begin
  Result := oBtrTable.FieldByName('AcOValue').AsFloat;
end;

procedure TTshBtr.WriteAcOValue(pValue:double);
begin
  oBtrTable.FieldByName('AcOValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcSValue:double;
begin
  Result := oBtrTable.FieldByName('AcSValue').AsFloat;
end;

procedure TTshBtr.WriteAcSValue(pValue:double);
begin
  oBtrTable.FieldByName('AcSValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTshBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTshBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTshBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTshBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTshBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTshBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TTshBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TTshBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcCValue1:double;
begin
  Result := oBtrTable.FieldByName('AcCValue1').AsFloat;
end;

procedure TTshBtr.WriteAcCValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue1').AsFloat := pValue;
end;

function TTshBtr.ReadAcCValue2:double;
begin
  Result := oBtrTable.FieldByName('AcCValue2').AsFloat;
end;

procedure TTshBtr.WriteAcCValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue2').AsFloat := pValue;
end;

function TTshBtr.ReadAcCValue3:double;
begin
  Result := oBtrTable.FieldByName('AcCValue3').AsFloat;
end;

procedure TTshBtr.WriteAcCValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue3').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue1:double;
begin
  Result := oBtrTable.FieldByName('AcEValue1').AsFloat;
end;

procedure TTshBtr.WriteAcEValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue1').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue2:double;
begin
  Result := oBtrTable.FieldByName('AcEValue2').AsFloat;
end;

procedure TTshBtr.WriteAcEValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue2').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue3:double;
begin
  Result := oBtrTable.FieldByName('AcEValue3').AsFloat;
end;

procedure TTshBtr.WriteAcEValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue3').AsFloat := pValue;
end;

function TTshBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTshBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTshBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTshBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTshBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TTshBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TTshBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TTshBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TTshBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTshBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTshBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTshBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTshBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTshBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTshBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTshBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TTshBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TTshBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue1:double;
begin
  Result := oBtrTable.FieldByName('FgCValue1').AsFloat;
end;

procedure TTshBtr.WriteFgCValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue1').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue2:double;
begin
  Result := oBtrTable.FieldByName('FgCValue2').AsFloat;
end;

procedure TTshBtr.WriteFgCValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue2').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue3:double;
begin
  Result := oBtrTable.FieldByName('FgCValue3').AsFloat;
end;

procedure TTshBtr.WriteFgCValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue3').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue1:double;
begin
  Result := oBtrTable.FieldByName('FgEValue1').AsFloat;
end;

procedure TTshBtr.WriteFgEValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue1').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue2:double;
begin
  Result := oBtrTable.FieldByName('FgEValue2').AsFloat;
end;

procedure TTshBtr.WriteFgEValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue2').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue3:double;
begin
  Result := oBtrTable.FieldByName('FgEValue3').AsFloat;
end;

procedure TTshBtr.WriteFgEValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue3').AsFloat := pValue;
end;

function TTshBtr.ReadFgCsdVal1:double;
begin
  Result := oBtrTable.FieldByName('FgCsdVal1').AsFloat;
end;

procedure TTshBtr.WriteFgCsdVal1(pValue:double);
begin
  oBtrTable.FieldByName('FgCsdVal1').AsFloat := pValue;
end;

function TTshBtr.ReadFgCsdVal2:double;
begin
  Result := oBtrTable.FieldByName('FgCsdVal2').AsFloat;
end;

procedure TTshBtr.WriteFgCsdVal2(pValue:double);
begin
  oBtrTable.FieldByName('FgCsdVal2').AsFloat := pValue;
end;

function TTshBtr.ReadFgCsdVal3:double;
begin
  Result := oBtrTable.FieldByName('FgCsdVal3').AsFloat;
end;

procedure TTshBtr.WriteFgCsdVal3(pValue:double);
begin
  oBtrTable.FieldByName('FgCsdVal3').AsFloat := pValue;
end;

function TTshBtr.ReadZIseNum:Str12;
begin
  Result := oBtrTable.FieldByName('ZIseNum').AsString;
end;

procedure TTshBtr.WriteZIseNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ZIseNum').AsString := pValue;
end;

function TTshBtr.ReadTIseNum:Str12;
begin
  Result := oBtrTable.FieldByName('TIseNum').AsString;
end;

procedure TTshBtr.WriteTIseNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TIseNum').AsString := pValue;
end;

function TTshBtr.ReadOIseNum:Str12;
begin
  Result := oBtrTable.FieldByName('OIseNum').AsString;
end;

procedure TTshBtr.WriteOIseNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OIseNum').AsString := pValue;
end;

function TTshBtr.ReadGIseNum:Str12;
begin
  Result := oBtrTable.FieldByName('GIseNum').AsString;
end;

procedure TTshBtr.WriteGIseNum(pValue:Str12);
begin
  oBtrTable.FieldByName('GIseNum').AsString := pValue;
end;

function TTshBtr.ReadZIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ZIsdNum').AsString;
end;

procedure TTshBtr.WriteZIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ZIsdNum').AsString := pValue;
end;

function TTshBtr.ReadTIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TIsdNum').AsString;
end;

procedure TTshBtr.WriteTIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TIsdNum').AsString := pValue;
end;

function TTshBtr.ReadOIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OIsdNum').AsString;
end;

procedure TTshBtr.WriteOIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OIsdNum').AsString := pValue;
end;

function TTshBtr.ReadGIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('GIsdNum').AsString;
end;

procedure TTshBtr.WriteGIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('GIsdNum').AsString := pValue;
end;

function TTshBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTshBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTshBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TTshBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TTshBtr.ReadIsdNum:Str15;
begin
  Result := oBtrTable.FieldByName('IsdNum').AsString;
end;

procedure TTshBtr.WriteIsdNum(pValue:Str15);
begin
  oBtrTable.FieldByName('IsdNum').AsString := pValue;
end;

function TTshBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TTshBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TTshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TTshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TTshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTshBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TTshBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TTshBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TTshBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TTshBtr.ReadDstPair:Str1;
begin
  Result := oBtrTable.FieldByName('DstPair').AsString;
end;

procedure TTshBtr.WriteDstPair(pValue:Str1);
begin
  oBtrTable.FieldByName('DstPair').AsString := pValue;
end;

function TTshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TTshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TTshBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TTshBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TTshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TTshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TTshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTshBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTshBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTshBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TTshBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TTshBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TTshBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TTshBtr.ReadCAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TTshBtr.WriteCAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TTshBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TTshBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TTshBtr.ReadDAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TTshBtr.WriteDAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TTshBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TTshBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTshBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TTshBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TTshBtr.ReadAcPrfVal:double;
begin
  Result := oBtrTable.FieldByName('AcPrfVal').AsFloat;
end;

procedure TTshBtr.WriteAcPrfVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPrfVal').AsFloat := pValue;
end;

function TTshBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TTshBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TTshBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TTshBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TTshBtr.ReadDstCor:Str1;
begin
  Result := oBtrTable.FieldByName('DstCor').AsString;
end;

procedure TTshBtr.WriteDstCor(pValue:Str1);
begin
  oBtrTable.FieldByName('DstCor').AsString := pValue;
end;

function TTshBtr.ReadDstLiq:Str1;
begin
  Result := oBtrTable.FieldByName('DstLiq').AsString;
end;

procedure TTshBtr.WriteDstLiq(pValue:Str1);
begin
  oBtrTable.FieldByName('DstLiq').AsString := pValue;
end;

function TTshBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTshBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTshBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTshBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTshBtr.ReadPkdNum:Str12;
begin
  Result := oBtrTable.FieldByName('PkdNum').AsString;
end;

procedure TTshBtr.WritePkdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('PkdNum').AsString := pValue;
end;

function TTshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TTshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TTshBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TTshBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTshBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTshBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTshBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TTshBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TTshBtr.ReadAcCValue4:double;
begin
  Result := oBtrTable.FieldByName('AcCValue4').AsFloat;
end;

procedure TTshBtr.WriteAcCValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue4').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue4:double;
begin
  Result := oBtrTable.FieldByName('AcEValue4').AsFloat;
end;

procedure TTshBtr.WriteAcEValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue4').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue4:double;
begin
  Result := oBtrTable.FieldByName('FgCValue4').AsFloat;
end;

procedure TTshBtr.WriteFgCValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue4').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue4:double;
begin
  Result := oBtrTable.FieldByName('FgEValue4').AsFloat;
end;

procedure TTshBtr.WriteFgEValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue4').AsFloat := pValue;
end;

function TTshBtr.ReadFgCsdVal4:double;
begin
  Result := oBtrTable.FieldByName('FgCsdVal4').AsFloat;
end;

procedure TTshBtr.WriteFgCsdVal4(pValue:double);
begin
  oBtrTable.FieldByName('FgCsdVal4').AsFloat := pValue;
end;

function TTshBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TTshBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TTshBtr.ReadAcCValue5:double;
begin
  Result := oBtrTable.FieldByName('AcCValue5').AsFloat;
end;

procedure TTshBtr.WriteAcCValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue5').AsFloat := pValue;
end;

function TTshBtr.ReadAcEValue5:double;
begin
  Result := oBtrTable.FieldByName('AcEValue5').AsFloat;
end;

procedure TTshBtr.WriteAcEValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue5').AsFloat := pValue;
end;

function TTshBtr.ReadFgCValue5:double;
begin
  Result := oBtrTable.FieldByName('FgCValue5').AsFloat;
end;

procedure TTshBtr.WriteFgCValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue5').AsFloat := pValue;
end;

function TTshBtr.ReadFgEValue5:double;
begin
  Result := oBtrTable.FieldByName('FgEValue5').AsFloat;
end;

procedure TTshBtr.WriteFgEValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue5').AsFloat := pValue;
end;

function TTshBtr.ReadFgCsdVal5:double;
begin
  Result := oBtrTable.FieldByName('FgCsdVal5').AsFloat;
end;

procedure TTshBtr.WriteFgCsdVal5(pValue:double);
begin
  oBtrTable.FieldByName('FgCsdVal5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TTshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTshBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TTshBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTshBtr.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oBtrTable.FindKey([pStkNum]);
end;

function TTshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TTshBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TTshBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TTshBtr.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindKey([pAcEValue]);
end;

function TTshBtr.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindKey([pFgEValue]);
end;

function TTshBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TTshBtr.LocateCsdNum (pCsdNum:Str12):boolean;
begin
  SetIndex (ixCsdNum);
  Result := oBtrTable.FindKey([pCsdNum]);
end;

function TTshBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TTshBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TTshBtr.LocateSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindKey([pSndStat]);
end;

function TTshBtr.LocateDstCor (pDstCor:Str1):boolean;
begin
  SetIndex (ixDstCor);
  Result := oBtrTable.FindKey([pDstCor]);
end;

function TTshBtr.LocatePcDp (pPaCode:longint;pDstPair:Str1):boolean;
begin
  SetIndex (ixPcDp);
  Result := oBtrTable.FindKey([pPaCode,pDstPair]);
end;

function TTshBtr.LocateDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindKey([pDstLiq]);
end;

function TTshBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TTshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TTshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTshBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TTshBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTshBtr.NearestStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oBtrTable.FindNearest([pStkNum]);
end;

function TTshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TTshBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TTshBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TTshBtr.NearestAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindNearest([pAcEValue]);
end;

function TTshBtr.NearestFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindNearest([pFgEValue]);
end;

function TTshBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TTshBtr.NearestCsdNum (pCsdNum:Str12):boolean;
begin
  SetIndex (ixCsdNum);
  Result := oBtrTable.FindNearest([pCsdNum]);
end;

function TTshBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TTshBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

function TTshBtr.NearestSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindNearest([pSndStat]);
end;

function TTshBtr.NearestDstCor (pDstCor:Str1):boolean;
begin
  SetIndex (ixDstCor);
  Result := oBtrTable.FindNearest([pDstCor]);
end;

function TTshBtr.NearestPcDp (pPaCode:longint;pDstPair:Str1):boolean;
begin
  SetIndex (ixPcDp);
  Result := oBtrTable.FindNearest([pPaCode,pDstPair]);
end;

function TTshBtr.NearestDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindNearest([pDstLiq]);
end;

function TTshBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TTshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTshBtr.First;
begin
  oBtrTable.First;
end;

procedure TTshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
