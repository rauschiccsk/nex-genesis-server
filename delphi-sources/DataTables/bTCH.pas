unit bTCH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixOcdNum = 'OcdNum';
  ixDocDate = 'DocDate';
  ixStkNum = 'StkNum';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';
  ixDpPc = 'DpPc';
  ixDstCls = 'DstCls';
  ixSended = 'Sended';
  ixDstAcc = 'DstAcc';
  ixSpMark = 'SpMark';
  ixPrjCode = 'PrjCode';
  ixRbaCode = 'RbaCode';

type
  TTchBtr = class (TComponent)
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
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
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
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
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
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadRcvName:Str30;         procedure WriteRcvName (pValue:Str30);
    function  ReadRcvCode:Str10;         procedure WriteRcvCode (pValue:Str10);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCntOut:word;           procedure WriteCntOut (pValue:word);
    function  ReadCntExp:word;           procedure WriteCntExp (pValue:word);
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
    function  ReadFgDBValue:double;      procedure WriteFgDBValue (pValue:double);
    function  ReadFgDscBVal:double;      procedure WriteFgDscBVal (pValue:double);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str8;          procedure WriteCAccAnl (pValue:Str8);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str8;          procedure WriteDAccAnl (pValue:Str8);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadIcdNum:Str14;          procedure WriteIcdNum (pValue:Str14);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
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
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateDpPc (pDstPair:Str1;pPaCode:longint):boolean;
    function LocateDstCls (pDstCls:byte):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSpMark (pSpMark:Str10):boolean;
    function LocatePrjCode (pPrjCode:Str12):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestStkNum (pStkNum:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestAcBValue (pAcBValue:double):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestDpPc (pDstPair:Str1;pPaCode:longint):boolean;
    function NearestDstCls (pDstCls:byte):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;
    function NearestSpMark (pSpMark:Str10):boolean;
    function NearestPrjCode (pPrjCode:Str12):boolean;
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
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
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
    property SmCode:word read ReadSmCode write WriteSmCode;
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
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property RcvName:Str30 read ReadRcvName write WriteRcvName;
    property RcvCode:Str10 read ReadRcvCode write WriteRcvCode;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CntOut:word read ReadCntOut write WriteCntOut;
    property CntExp:word read ReadCntExp write WriteCntExp;
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
    property FgDBValue:double read ReadFgDBValue write WriteFgDBValue;
    property FgDscBVal:double read ReadFgDscBVal write WriteFgDscBVal;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str8 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str8 read ReadDAccAnl write WriteDAccAnl;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property IcdNum:Str14 read ReadIcdNum write WriteIcdNum;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property Year:Str2 read ReadYear write WriteYear;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
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
  end;

implementation

constructor TTchBtr.Create;
begin
  oBtrTable := BtrInit ('TCH',gPath.StkPath,Self);
end;

constructor TTchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TCH',pPath,Self);
end;

destructor TTchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTchBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTchBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTchBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTchBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTchBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTchBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTchBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTchBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTchBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTchBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTchBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTchBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTchBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TTchBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TTchBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TTchBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TTchBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TTchBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TTchBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TTchBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TTchBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TTchBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TTchBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TTchBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TTchBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TTchBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TTchBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TTchBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TTchBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TTchBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TTchBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TTchBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TTchBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TTchBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TTchBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TTchBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TTchBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TTchBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TTchBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TTchBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TTchBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TTchBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TTchBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TTchBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TTchBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TTchBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TTchBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TTchBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TTchBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TTchBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TTchBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TTchBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TTchBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TTchBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TTchBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TTchBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TTchBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TTchBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TTchBtr.ReadRspName:Str20;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TTchBtr.WriteRspName(pValue:Str20);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TTchBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TTchBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TTchBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TTchBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TTchBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTchBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTchBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TTchBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TTchBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTchBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTchBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TTchBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TTchBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TTchBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TTchBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TTchBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TTchBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TTchBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TTchBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTchBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTchBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTchBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTchBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTchBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTchBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTchBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTchBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TTchBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTchBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTchBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TTchBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TTchBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TTchBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TTchBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TTchBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TTchBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TTchBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TTchBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TTchBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TTchBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TTchBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TTchBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TTchBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTchBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTchBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTchBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTchBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTchBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TTchBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TTchBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TTchBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TTchBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue1:double;
begin
  Result := oBtrTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TTchBtr.WriteFgAValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue2:double;
begin
  Result := oBtrTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TTchBtr.WriteFgAValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue3:double;
begin
  Result := oBtrTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TTchBtr.WriteFgAValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TTchBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TTchBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TTchBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TTchBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TTchBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TTchBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TTchBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TTchBtr.ReadRcvName:Str30;
begin
  Result := oBtrTable.FieldByName('RcvName').AsString;
end;

procedure TTchBtr.WriteRcvName(pValue:Str30);
begin
  oBtrTable.FieldByName('RcvName').AsString := pValue;
end;

function TTchBtr.ReadRcvCode:Str10;
begin
  Result := oBtrTable.FieldByName('RcvCode').AsString;
end;

procedure TTchBtr.WriteRcvCode(pValue:Str10);
begin
  oBtrTable.FieldByName('RcvCode').AsString := pValue;
end;

function TTchBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TTchBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TTchBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TTchBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TTchBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TTchBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TTchBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TTchBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TTchBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTchBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTchBtr.ReadCntOut:word;
begin
  Result := oBtrTable.FieldByName('CntOut').AsInteger;
end;

procedure TTchBtr.WriteCntOut(pValue:word);
begin
  oBtrTable.FieldByName('CntOut').AsInteger := pValue;
end;

function TTchBtr.ReadCntExp:word;
begin
  Result := oBtrTable.FieldByName('CntExp').AsInteger;
end;

procedure TTchBtr.WriteCntExp(pValue:word);
begin
  oBtrTable.FieldByName('CntExp').AsInteger := pValue;
end;

function TTchBtr.ReadDstPair:Str1;
begin
  Result := oBtrTable.FieldByName('DstPair').AsString;
end;

procedure TTchBtr.WriteDstPair(pValue:Str1);
begin
  oBtrTable.FieldByName('DstPair').AsString := pValue;
end;

function TTchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TTchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TTchBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TTchBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TTchBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TTchBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TTchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTchBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTchBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTchBtr.ReadFgDBValue:double;
begin
  Result := oBtrTable.FieldByName('FgDBValue').AsFloat;
end;

procedure TTchBtr.WriteFgDBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDBValue').AsFloat := pValue;
end;

function TTchBtr.ReadFgDscBVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TTchBtr.WriteFgDscBVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscBVal').AsFloat := pValue;
end;

function TTchBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TTchBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TTchBtr.ReadCAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TTchBtr.WriteCAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TTchBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TTchBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TTchBtr.ReadDAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TTchBtr.WriteDAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TTchBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TTchBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TTchBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TTchBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TTchBtr.ReadBonNum:byte;
begin
  Result := oBtrTable.FieldByName('BonNum').AsInteger;
end;

procedure TTchBtr.WriteBonNum(pValue:byte);
begin
  oBtrTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TTchBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TTchBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTchBtr.ReadHdsPrc:double;
begin
  Result := oBtrTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TTchBtr.WriteHdsPrc(pValue:double);
begin
  oBtrTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TTchBtr.ReadFgHdsVal:double;
begin
  Result := oBtrTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TTchBtr.WriteFgHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TTchBtr.ReadFgRndVat:double;
begin
  Result := oBtrTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TTchBtr.WriteFgRndVat(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TTchBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTchBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTchBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TTchBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TTchBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TTchBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TTchBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTchBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTchBtr.ReadAcRndVat:double;
begin
  Result := oBtrTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TTchBtr.WriteAcRndVat(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TTchBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTchBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTchBtr.ReadIcdNum:Str14;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTchBtr.WriteIcdNum(pValue:Str14);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTchBtr.ReadPrjCode:Str12;
begin
  Result := oBtrTable.FieldByName('PrjCode').AsString;
end;

procedure TTchBtr.WritePrjCode(pValue:Str12);
begin
  oBtrTable.FieldByName('PrjCode').AsString := pValue;
end;

function TTchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TTchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TTchBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TTchBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTchBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTchBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTchBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TTchBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TTchBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TTchBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TTchBtr.ReadAcAValue4:double;
begin
  Result := oBtrTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TTchBtr.WriteAcAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TTchBtr.ReadAcAValue5:double;
begin
  Result := oBtrTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TTchBtr.WriteAcAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue4:double;
begin
  Result := oBtrTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TTchBtr.WriteAcBValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TTchBtr.ReadAcBValue5:double;
begin
  Result := oBtrTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TTchBtr.WriteAcBValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue4:double;
begin
  Result := oBtrTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TTchBtr.WriteFgAValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TTchBtr.ReadFgAValue5:double;
begin
  Result := oBtrTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TTchBtr.WriteFgAValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue4:double;
begin
  Result := oBtrTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TTchBtr.WriteFgBValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TTchBtr.ReadFgBValue5:double;
begin
  Result := oBtrTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TTchBtr.WriteFgBValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TTchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTchBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TTchBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TTchBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTchBtr.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oBtrTable.FindKey([pStkNum]);
end;

function TTchBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTchBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TTchBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TTchBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TTchBtr.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindKey([pAcBValue]);
end;

function TTchBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TTchBtr.LocateDpPc (pDstPair:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixDpPc);
  Result := oBtrTable.FindKey([pDstPair,pPaCode]);
end;

function TTchBtr.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindKey([pDstCls]);
end;

function TTchBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TTchBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TTchBtr.LocateSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindKey([pSpMark]);
end;

function TTchBtr.LocatePrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindKey([pPrjCode]);
end;

function TTchBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TTchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TTchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTchBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TTchBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TTchBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTchBtr.NearestStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oBtrTable.FindNearest([pStkNum]);
end;

function TTchBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTchBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TTchBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TTchBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TTchBtr.NearestAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindNearest([pAcBValue]);
end;

function TTchBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TTchBtr.NearestDpPc (pDstPair:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixDpPc);
  Result := oBtrTable.FindNearest([pDstPair,pPaCode]);
end;

function TTchBtr.NearestDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindNearest([pDstCls]);
end;

function TTchBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TTchBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

function TTchBtr.NearestSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oBtrTable.FindNearest([pSpMark]);
end;

function TTchBtr.NearestPrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindNearest([pPrjCode]);
end;

function TTchBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TTchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTchBtr.First;
begin
  oBtrTable.First;
end;

procedure TTchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
