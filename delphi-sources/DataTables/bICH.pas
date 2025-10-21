unit bICH;

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
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixOcdNum = 'OcdNum';
  ixSndDate = 'SndDate';
  ixExpDate = 'ExpDate';
  ixDstPair = 'DstPair';
  ixPaDp = 'PaDp';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';
  ixFgEndVal = 'FgEndVal';
  ixDlrCode = 'DlrCode';
  ixSended = 'Sended';
  ixCrCard = 'CrCard';
  ixDstAcc = 'DstAcc';
  ixSpMark = 'SpMark';
  ixPrjCode = 'PrjCode';
  ixIodNum = 'IodNum';

type
  TIchBtr = class (TComponent)
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
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMyConto:Str30;         procedure WriteMyConto (pValue:Str30);
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
    function  ReadPayName:Str19;         procedure WritePayName (pValue:Str19);
    function  ReadPayMode:byte;          procedure WritePayMode (pValue:byte);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadWpaCode:word;          procedure WriteWpaCode (pValue:word);
    function  ReadWpaName:Str60;         procedure WriteWpaName (pValue:Str60);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaSta:Str2;           procedure WriteWpaSta (pValue:Str2);
    function  ReadWpaCty:Str3;           procedure WriteWpaCty (pValue:Str3);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadWpaZip:Str15;          procedure WriteWpaZip (pValue:Str15);
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str20;         procedure WriteTrsName (pValue:Str20);
    function  ReadRspName:Str20;         procedure WriteRspName (pValue:Str20);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPValue:double;       procedure WriteAcPValue (pValue:double);
    function  ReadAcPrvPay:double;       procedure WriteAcPrvPay (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcBValue1:double;      procedure WriteAcBValue1 (pValue:double);
    function  ReadAcBValue2:double;      procedure WriteAcBValue2 (pValue:double);
    function  ReadAcBValue3:double;      procedure WriteAcBValue3 (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgPValue:double;       procedure WriteFgPValue (pValue:double);
    function  ReadFgPrvPay:double;       procedure WriteFgPrvPay (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadRcvName:Str30;         procedure WriteRcvName (pValue:Str30);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadTcdNum:Str15;          procedure WriteTcdNum (pValue:Str15);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstPay:byte;           procedure WriteDstPay (pValue:byte);
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
    function  ReadDocSnt:Str3;           procedure WriteDocSnt (pValue:Str3);
    function  ReadDocAnl:Str6;           procedure WriteDocAnl (pValue:Str6);
    function  ReadCrcVal:double;         procedure WriteCrcVal (pValue:double);
    function  ReadCrCard:Str20;          procedure WriteCrCard (pValue:Str20);
    function  ReadFgDBValue:double;      procedure WriteFgDBValue (pValue:double);
    function  ReadFgDscBVal:double;      procedure WriteFgDscBVal (pValue:double);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadVatDis:byte;           procedure WriteVatDis (pValue:byte);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadCsgNum:Str15;          procedure WriteCsgNum (pValue:Str15);
    function  ReadEmlDate:TDatetime;     procedure WriteEmlDate (pValue:TDatetime);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcBValue4:double;      procedure WriteAcBValue4 (pValue:double);
    function  ReadAcBValue5:double;      procedure WriteAcBValue5 (pValue:double);
    function  ReadFgAValue4:double;      procedure WriteFgAValue4 (pValue:double);
    function  ReadFgAValue5:double;      procedure WriteFgAValue5 (pValue:double);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadFgBValue5:double;      procedure WriteFgBValue5 (pValue:double);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadIodNum:Str12;          procedure WriteIodNum (pValue:Str12);
    function  ReadIoeNum:Str12;          procedure WriteIoeNum (pValue:Str12);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadQntSum:double;         procedure WriteQntSum (pValue:double);
    function  ReadCctVal:double;         procedure WriteCctVal (pValue:double);
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
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateSndDate (pSndDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocateDstPair (pDstPair:Str1):boolean;
    function LocatePaDp (pPaCode:longint;pDstPay:byte):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateFgEndVal (pFgEndVal:double):boolean;
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateCrCard (pCrCard:Str20):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSpMark (pSpMark:Str10):boolean;
    function LocatePrjCode (pPrjCode:Str12):boolean;
    function LocateIodNum (pIodNum:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;
    function NearestSndDate (pSndDate:TDatetime):boolean;
    function NearestExpDate (pExpDate:TDatetime):boolean;
    function NearestDstPair (pDstPair:Str1):boolean;
    function NearestPaDp (pPaCode:longint;pDstPay:byte):boolean;
    function NearestAcBValue (pAcBValue:double):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestFgEndVal (pFgEndVal:double):boolean;
    function NearestDlrCode (pDlrCode:word):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestCrCard (pCrCard:Str20):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;
    function NearestSpMark (pSpMark:Str10):boolean;
    function NearestPrjCode (pPrjCode:Str12):boolean;
    function NearestIodNum (pIodNum:Str12):boolean;

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
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MyConto:Str30 read ReadMyConto write WriteMyConto;
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
    property PayName:Str19 read ReadPayName write WritePayName;
    property PayMode:byte read ReadPayMode write WritePayMode;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property WpaCode:word read ReadWpaCode write WriteWpaCode;
    property WpaName:Str60 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaSta:Str2 read ReadWpaSta write WriteWpaSta;
    property WpaCty:Str3 read ReadWpaCty write WriteWpaCty;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property WpaZip:Str15 read ReadWpaZip write WriteWpaZip;
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str20 read ReadTrsName write WriteTrsName;
    property RspName:Str20 read ReadRspName write WriteRspName;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPValue:double read ReadAcPValue write WriteAcPValue;
    property AcPrvPay:double read ReadAcPrvPay write WriteAcPrvPay;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcBValue1:double read ReadAcBValue1 write WriteAcBValue1;
    property AcBValue2:double read ReadAcBValue2 write WriteAcBValue2;
    property AcBValue3:double read ReadAcBValue3 write WriteAcBValue3;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgPValue:double read ReadFgPValue write WriteFgPValue;
    property FgPrvPay:double read ReadFgPrvPay write WriteFgPrvPay;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property RcvName:Str30 read ReadRcvName write WriteRcvName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property TcdNum:Str15 read ReadTcdNum write WriteTcdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstPay:byte read ReadDstPay write WriteDstPay;
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
    property DocSnt:Str3 read ReadDocSnt write WriteDocSnt;
    property DocAnl:Str6 read ReadDocAnl write WriteDocAnl;
    property CrcVal:double read ReadCrcVal write WriteCrcVal;
    property CrCard:Str20 read ReadCrCard write WriteCrCard;
    property FgDBValue:double read ReadFgDBValue write WriteFgDBValue;
    property FgDscBVal:double read ReadFgDscBVal write WriteFgDscBVal;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property VatDis:byte read ReadVatDis write WriteVatDis;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property CsgNum:Str15 read ReadCsgNum write WriteCsgNum;
    property EmlDate:TDatetime read ReadEmlDate write WriteEmlDate;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcBValue4:double read ReadAcBValue4 write WriteAcBValue4;
    property AcBValue5:double read ReadAcBValue5 write WriteAcBValue5;
    property FgAValue4:double read ReadFgAValue4 write WriteFgAValue4;
    property FgAValue5:double read ReadFgAValue5 write WriteFgAValue5;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
    property Year:Str2 read ReadYear write WriteYear;
    property IodNum:Str12 read ReadIodNum write WriteIodNum;
    property IoeNum:Str12 read ReadIoeNum write WriteIoeNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property QntSum:double read ReadQntSum write WriteQntSum;
    property CctVal:double read ReadCctVal write WriteCctVal;
  end;

implementation

constructor TIchBtr.Create;
begin
  oBtrTable := BtrInit ('ICH',gPath.LdgPath,Self);
end;

constructor TIchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ICH',pPath,Self);
end;

destructor TIchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIchBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TIchBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIchBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TIchBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TIchBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIchBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIchBtr.ReadSndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDate').AsDateTime;
end;

procedure TIchBtr.WriteSndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TIchBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TIchBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TIchBtr.ReadVatDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VatDate').AsDateTime;
end;

procedure TIchBtr.WriteVatDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TIchBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TIchBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TIchBtr.ReadCsyCode:Str4;
begin
  Result := oBtrTable.FieldByName('CsyCode').AsString;
end;

procedure TIchBtr.WriteCsyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('CsyCode').AsString := pValue;
end;

function TIchBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIchBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIchBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TIchBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIchBtr.ReadMyConto:Str30;
begin
  Result := oBtrTable.FieldByName('MyConto').AsString;
end;

procedure TIchBtr.WriteMyConto(pValue:Str30);
begin
  oBtrTable.FieldByName('MyConto').AsString := pValue;
end;

function TIchBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIchBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIchBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TIchBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TIchBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TIchBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TIchBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TIchBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TIchBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TIchBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TIchBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TIchBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TIchBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TIchBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TIchBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TIchBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TIchBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TIchBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TIchBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TIchBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TIchBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TIchBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TIchBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TIchBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TIchBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TIchBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TIchBtr.ReadPayName:Str19;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TIchBtr.WritePayName(pValue:Str19);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TIchBtr.ReadPayMode:byte;
begin
  Result := oBtrTable.FieldByName('PayMode').AsInteger;
end;

procedure TIchBtr.WritePayMode(pValue:byte);
begin
  oBtrTable.FieldByName('PayMode').AsInteger := pValue;
end;

function TIchBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TIchBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TIchBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TIchBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TIchBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TIchBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TIchBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TIchBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TIchBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TIchBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TIchBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TIchBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TIchBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TIchBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TIchBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TIchBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TIchBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TIchBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TIchBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TIchBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TIchBtr.ReadRspName:Str20;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TIchBtr.WriteRspName(pValue:Str20);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TIchBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TIchBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TIchBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TIchBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TIchBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIchBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TIchBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TIchBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TIchBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIchBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIchBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIchBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIchBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIchBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIchBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIchBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIchBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TIchBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TIchBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIchBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIchBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIchBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIchBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIchBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIchBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIchBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIchBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIchBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIchBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIchBtr.ReadAcPValue:double;
begin
  Result := oBtrTable.FieldByName('AcPValue').AsFloat;
end;

procedure TIchBtr.WriteAcPValue(pValue:double);
begin
  oBtrTable.FieldByName('AcPValue').AsFloat := pValue;
end;

function TIchBtr.ReadAcPrvPay:double;
begin
  Result := oBtrTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TIchBtr.WriteAcPrvPay(pValue:double);
begin
  oBtrTable.FieldByName('AcPrvPay').AsFloat := pValue;
end;

function TIchBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TIchBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TIchBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TIchBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TIchBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TIchBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TIchBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TIchBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TIchBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TIchBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TIchBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TIchBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TIchBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TIchBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TIchBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TIchBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIchBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIchBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIchBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIchBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIchBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TIchBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TIchBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TIchBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TIchBtr.ReadFgPValue:double;
begin
  Result := oBtrTable.FieldByName('FgPValue').AsFloat;
end;

procedure TIchBtr.WriteFgPValue(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgPrvPay:double;
begin
  Result := oBtrTable.FieldByName('FgPrvPay').AsFloat;
end;

procedure TIchBtr.WriteFgPrvPay(pValue:double);
begin
  oBtrTable.FieldByName('FgPrvPay').AsFloat := pValue;
end;

function TIchBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIchBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TIchBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TIchBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue1:double;
begin
  Result := oBtrTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TIchBtr.WriteFgAValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue2:double;
begin
  Result := oBtrTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TIchBtr.WriteFgAValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue3:double;
begin
  Result := oBtrTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TIchBtr.WriteFgAValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TIchBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TIchBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TIchBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TIchBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TIchBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TIchBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TIchBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TIchBtr.ReadRcvName:Str30;
begin
  Result := oBtrTable.FieldByName('RcvName').AsString;
end;

procedure TIchBtr.WriteRcvName(pValue:Str30);
begin
  oBtrTable.FieldByName('RcvName').AsString := pValue;
end;

function TIchBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TIchBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TIchBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TIchBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TIchBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIchBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TIchBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TIchBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TIchBtr.ReadDocSpc:byte;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIchBtr.WriteDocSpc(pValue:byte);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIchBtr.ReadTcdNum:Str15;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TIchBtr.WriteTcdNum(pValue:Str15);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TIchBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIchBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIchBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIchBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIchBtr.ReadDstPair:Str1;
begin
  Result := oBtrTable.FieldByName('DstPair').AsString;
end;

procedure TIchBtr.WriteDstPair(pValue:Str1);
begin
  oBtrTable.FieldByName('DstPair').AsString := pValue;
end;

function TIchBtr.ReadDstPay:byte;
begin
  Result := oBtrTable.FieldByName('DstPay').AsInteger;
end;

procedure TIchBtr.WriteDstPay(pValue:byte);
begin
  oBtrTable.FieldByName('DstPay').AsInteger := pValue;
end;

function TIchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TIchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIchBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TIchBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TIchBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TIchBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TIchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIchBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIchBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIchBtr.ReadDocSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DocSnt').AsString;
end;

procedure TIchBtr.WriteDocSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DocSnt').AsString := pValue;
end;

function TIchBtr.ReadDocAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DocAnl').AsString;
end;

procedure TIchBtr.WriteDocAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DocAnl').AsString := pValue;
end;

function TIchBtr.ReadCrcVal:double;
begin
  Result := oBtrTable.FieldByName('CrcVal').AsFloat;
end;

procedure TIchBtr.WriteCrcVal(pValue:double);
begin
  oBtrTable.FieldByName('CrcVal').AsFloat := pValue;
end;

function TIchBtr.ReadCrCard:Str20;
begin
  Result := oBtrTable.FieldByName('CrCard').AsString;
end;

procedure TIchBtr.WriteCrCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CrCard').AsString := pValue;
end;

function TIchBtr.ReadFgDBValue:double;
begin
  Result := oBtrTable.FieldByName('FgDBValue').AsFloat;
end;

procedure TIchBtr.WriteFgDBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDBValue').AsFloat := pValue;
end;

function TIchBtr.ReadFgDscBVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TIchBtr.WriteFgDscBVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscBVal').AsFloat := pValue;
end;

function TIchBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TIchBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIchBtr.ReadVatDis:byte;
begin
  Result := oBtrTable.FieldByName('VatDis').AsInteger;
end;

procedure TIchBtr.WriteVatDis(pValue:byte);
begin
  oBtrTable.FieldByName('VatDis').AsInteger := pValue;
end;

function TIchBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TIchBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TIchBtr.ReadBonNum:byte;
begin
  Result := oBtrTable.FieldByName('BonNum').AsInteger;
end;

procedure TIchBtr.WriteBonNum(pValue:byte);
begin
  oBtrTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TIchBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TIchBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TIchBtr.ReadFgHValue:double;
begin
  Result := oBtrTable.FieldByName('FgHValue').AsFloat;
end;

procedure TIchBtr.WriteFgHValue(pValue:double);
begin
  oBtrTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TIchBtr.ReadHdsPrc:double;
begin
  Result := oBtrTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TIchBtr.WriteHdsPrc(pValue:double);
begin
  oBtrTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TIchBtr.ReadFgHdsVal:double;
begin
  Result := oBtrTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TIchBtr.WriteFgHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TIchBtr.ReadFgRndVat:double;
begin
  Result := oBtrTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TIchBtr.WriteFgRndVat(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TIchBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TIchBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TIchBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TIchBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TIchBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TIchBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TIchBtr.ReadAcRndVat:double;
begin
  Result := oBtrTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TIchBtr.WriteAcRndVat(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TIchBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TIchBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TIchBtr.ReadWrnNum:byte;
begin
  Result := oBtrTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIchBtr.WriteWrnNum(pValue:byte);
begin
  oBtrTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIchBtr.ReadWrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIchBtr.WriteWrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIchBtr.ReadCsgNum:Str15;
begin
  Result := oBtrTable.FieldByName('CsgNum').AsString;
end;

procedure TIchBtr.WriteCsgNum(pValue:Str15);
begin
  oBtrTable.FieldByName('CsgNum').AsString := pValue;
end;

function TIchBtr.ReadEmlDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmlDate').AsDateTime;
end;

procedure TIchBtr.WriteEmlDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmlDate').AsDateTime := pValue;
end;

function TIchBtr.ReadPrjCode:Str12;
begin
  Result := oBtrTable.FieldByName('PrjCode').AsString;
end;

procedure TIchBtr.WritePrjCode(pValue:Str12);
begin
  oBtrTable.FieldByName('PrjCode').AsString := pValue;
end;

function TIchBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIchBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIchBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIchBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIchBtr.ReadAcAValue4:double;
begin
  Result := oBtrTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TIchBtr.WriteAcAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TIchBtr.ReadAcAValue5:double;
begin
  Result := oBtrTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TIchBtr.WriteAcAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue4:double;
begin
  Result := oBtrTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TIchBtr.WriteAcBValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TIchBtr.ReadAcBValue5:double;
begin
  Result := oBtrTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TIchBtr.WriteAcBValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue4:double;
begin
  Result := oBtrTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TIchBtr.WriteFgAValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TIchBtr.ReadFgAValue5:double;
begin
  Result := oBtrTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TIchBtr.WriteFgAValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue4:double;
begin
  Result := oBtrTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TIchBtr.WriteFgBValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TIchBtr.ReadFgBValue5:double;
begin
  Result := oBtrTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TIchBtr.WriteFgBValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

function TIchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TIchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TIchBtr.ReadIodNum:Str12;
begin
  Result := oBtrTable.FieldByName('IodNum').AsString;
end;

procedure TIchBtr.WriteIodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IodNum').AsString := pValue;
end;

function TIchBtr.ReadIoeNum:Str12;
begin
  Result := oBtrTable.FieldByName('IoeNum').AsString;
end;

procedure TIchBtr.WriteIoeNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IoeNum').AsString := pValue;
end;

function TIchBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TIchBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TIchBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TIchBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TIchBtr.ReadQntSum:double;
begin
  Result := oBtrTable.FieldByName('QntSum').AsFloat;
end;

procedure TIchBtr.WriteQntSum(pValue:double);
begin
  oBtrTable.FieldByName('QntSum').AsFloat := pValue;
end;

function TIchBtr.ReadCctVal:double;
begin
  Result := oBtrTable.FieldByName('CctVal').AsFloat;
end;

procedure TIchBtr.WriteCctVal(pValue:double);
begin
  oBtrTable.FieldByName('CctVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TIchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIchBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TIchBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIchBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TIchBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TIchBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TIchBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TIchBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TIchBtr.LocateSndDate (pSndDate:TDatetime):boolean;
begin
  SetIndex (ixSndDate);
  Result := oBtrTable.FindKey([pSndDate]);
end;

function TIchBtr.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindKey([pExpDate]);
end;

function TIchBtr.LocateDstPair (pDstPair:Str1):boolean;
begin
  SetIndex (ixDstPair);
  Result := oBtrTable.FindKey([pDstPair]);
end;

function TIchBtr.LocatePaDp (pPaCode:longint;pDstPay:byte):boolean;
begin
  SetIndex (ixPaDp);
  Result := oBtrTable.FindKey([pPaCode,pDstPay]);
end;

function TIchBtr.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindKey([pAcBValue]);
end;

function TIchBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TIchBtr.LocateFgEndVal (pFgEndVal:double):boolean;
begin
  SetIndex (ixFgEndVal);
  Result := oBtrTable.FindKey([pFgEndVal]);
end;

function TIchBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TIchBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TIchBtr.LocateCrCard (pCrCard:Str20):boolean;
begin
  SetIndex (ixCrCard);
  Result := oBtrTable.FindKey([pCrCard]);
end;

function TIchBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TIchBtr.LocateSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindKey([pSpMark]);
end;

function TIchBtr.LocatePrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindKey([pPrjCode]);
end;

function TIchBtr.LocateIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oBtrTable.FindKey([pIodNum]);
end;

function TIchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TIchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIchBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TIchBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIchBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TIchBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TIchBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TIchBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TIchBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TIchBtr.NearestSndDate (pSndDate:TDatetime):boolean;
begin
  SetIndex (ixSndDate);
  Result := oBtrTable.FindNearest([pSndDate]);
end;

function TIchBtr.NearestExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindNearest([pExpDate]);
end;

function TIchBtr.NearestDstPair (pDstPair:Str1):boolean;
begin
  SetIndex (ixDstPair);
  Result := oBtrTable.FindNearest([pDstPair]);
end;

function TIchBtr.NearestPaDp (pPaCode:longint;pDstPay:byte):boolean;
begin
  SetIndex (ixPaDp);
  Result := oBtrTable.FindNearest([pPaCode,pDstPay]);
end;

function TIchBtr.NearestAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindNearest([pAcBValue]);
end;

function TIchBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TIchBtr.NearestFgEndVal (pFgEndVal:double):boolean;
begin
  SetIndex (ixFgEndVal);
  Result := oBtrTable.FindNearest([pFgEndVal]);
end;

function TIchBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TIchBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TIchBtr.NearestCrCard (pCrCard:Str20):boolean;
begin
  SetIndex (ixCrCard);
  Result := oBtrTable.FindNearest([pCrCard]);
end;

function TIchBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

function TIchBtr.NearestSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindNearest([pSpMark]);
end;

function TIchBtr.NearestPrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindNearest([pPrjCode]);
end;

function TIchBtr.NearestIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oBtrTable.FindNearest([pIodNum]);
end;

procedure TIchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIchBtr.First;
begin
  oBtrTable.First;
end;

procedure TIchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
