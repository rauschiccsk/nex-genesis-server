unit bOCH;

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
  ixDlvDate = 'DlvDate';
  ixPaCode = 'PaCode';
  ixSpaWpa = 'SpaWpa';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';
  ixCntOrd = 'CntOrd';
  ixCntRes = 'CntRes';
  ixCntPrp = 'CntPrp';
  ixCntOut = 'CntOut';
  ixDstCls = 'DstCls';
  ixSended = 'Sended';
  ixPrjCode = 'PrjCode';
  ixRegIno = 'RegIno';

type
  TOchBtr = class (TComponent)
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
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
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
    function  ReadDepPrc:double;         procedure WriteDepPrc (pValue:double);
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
    function  ReadDepVal:double;         procedure WriteDepVal (pValue:double);
    function  ReadAcMValue:double;       procedure WriteAcMValue (pValue:double);
    function  ReadAcWValue:double;       procedure WriteAcWValue (pValue:double);
    function  ReadAcOValue:double;       procedure WriteAcOValue (pValue:double);
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
    function  ReadFgPValue:double;       procedure WriteFgPValue (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCntOrd:word;           procedure WriteCntOrd (pValue:word);
    function  ReadCntRes:word;           procedure WriteCntRes (pValue:word);
    function  ReadCntPrp:word;           procedure WriteCntPrp (pValue:word);
    function  ReadCntOut:word;           procedure WriteCntOut (pValue:word);
    function  ReadCntReq:word;           procedure WriteCntReq (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadSended:byte;           procedure WriteSended (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPValPay:Str1;          procedure WritePValPay (pValue:Str1);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadCntRat:word;           procedure WriteCntRat (pValue:word);
    function  ReadCntTrm:word;           procedure WriteCntTrm (pValue:word);
    function  ReadCntErr:word;           procedure WriteCntErr (pValue:word);
    function  ReadTrnCrs:word;           procedure WriteTrnCrs (pValue:word);
    function  ReadCntTre:word;           procedure WriteCntTre (pValue:word);
    function  ReadRmdNum:Str12;          procedure WriteRmdNum (pValue:Str12);
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadComDlv:byte;           procedure WriteComDlv (pValue:byte);
    function  ReadPerCol:byte;           procedure WritePerCol (pValue:byte);
    function  ReadTvalue:double;         procedure WriteTvalue (pValue:double);
    function  ReadDepDat:TDatetime;      procedure WriteDepDat (pValue:TDatetime);
    function  ReadDepPay:Str1;           procedure WriteDepPay (pValue:Str1);
    function  ReadDepCas:byte;           procedure WriteDepCas (pValue:byte);
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
    function LocateDlvDate (pDlvDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSpaWpa (pSpaCode:longint;pWpaCode:word):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateCntOrd (pCntOrd:word):boolean;
    function LocateCntRes (pCntRes:word):boolean;
    function LocateCntPrp (pCntPrp:word):boolean;
    function LocateCntOut (pCntOut:word):boolean;
    function LocateDstCls (pDstCls:byte):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocatePrjCode (pPrjCode:Str12):boolean;
    function LocateRegIno (pRegIno:Str15):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDlvDate (pDlvDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestSpaWpa (pSpaCode:longint;pWpaCode:word):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestAcBValue (pAcBValue:double):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestCntOrd (pCntOrd:word):boolean;
    function NearestCntRes (pCntRes:word):boolean;
    function NearestCntPrp (pCntPrp:word):boolean;
    function NearestCntOut (pCntOut:word):boolean;
    function NearestDstCls (pDstCls:byte):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestPrjCode (pPrjCode:Str12):boolean;
    function NearestRegIno (pRegIno:Str15):boolean;

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
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
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
    property DepPrc:double read ReadDepPrc write WriteDepPrc;
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
    property DepVal:double read ReadDepVal write WriteDepVal;
    property AcMValue:double read ReadAcMValue write WriteAcMValue;
    property AcWValue:double read ReadAcWValue write WriteAcWValue;
    property AcOValue:double read ReadAcOValue write WriteAcOValue;
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
    property FgPValue:double read ReadFgPValue write WriteFgPValue;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CntOrd:word read ReadCntOrd write WriteCntOrd;
    property CntRes:word read ReadCntRes write WriteCntRes;
    property CntPrp:word read ReadCntPrp write WriteCntPrp;
    property CntOut:word read ReadCntOut write WriteCntOut;
    property CntReq:word read ReadCntReq write WriteCntReq;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property Sended:byte read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PValPay:Str1 read ReadPValPay write WritePValPay;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property CntRat:word read ReadCntRat write WriteCntRat;
    property CntTrm:word read ReadCntTrm write WriteCntTrm;
    property CntErr:word read ReadCntErr write WriteCntErr;
    property TrnCrs:word read ReadTrnCrs write WriteTrnCrs;
    property CntTre:word read ReadCntTre write WriteCntTre;
    property RmdNum:Str12 read ReadRmdNum write WriteRmdNum;
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property Year:Str2 read ReadYear write WriteYear;
    property ComDlv:byte read ReadComDlv write WriteComDlv;
    property PerCol:byte read ReadPerCol write WritePerCol;
    property Tvalue:double read ReadTvalue write WriteTvalue;
    property DepDat:TDatetime read ReadDepDat write WriteDepDat;
    property DepPay:Str1 read ReadDepPay write WriteDepPay;
    property DepCas:byte read ReadDepCas write WriteDepCas;
  end;

implementation

constructor TOchBtr.Create;
begin
  oBtrTable := BtrInit ('OCH',gPath.StkPath,Self);
end;

constructor TOchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OCH',pPath,Self);
end;

destructor TOchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TOchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOchBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TOchBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOchBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOchBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOchBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TOchBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TOchBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOchBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOchBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOchBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOchBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TOchBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOchBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TOchBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TOchBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TOchBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TOchBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TOchBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TOchBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TOchBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TOchBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TOchBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TOchBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TOchBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TOchBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TOchBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TOchBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TOchBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TOchBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TOchBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TOchBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TOchBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TOchBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TOchBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TOchBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TOchBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TOchBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TOchBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TOchBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TOchBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TOchBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TOchBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TOchBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TOchBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TOchBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TOchBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TOchBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TOchBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TOchBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TOchBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TOchBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TOchBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TOchBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TOchBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TOchBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TOchBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TOchBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TOchBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TOchBtr.ReadRspName:Str20;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TOchBtr.WriteRspName(pValue:Str20);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TOchBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TOchBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TOchBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TOchBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TOchBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOchBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOchBtr.ReadDepPrc:double;
begin
  Result := oBtrTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOchBtr.WriteDepPrc(pValue:double);
begin
  oBtrTable.FieldByName('DepPrc').AsFloat := pValue;
end;

function TOchBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOchBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOchBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TOchBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TOchBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TOchBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TOchBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TOchBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TOchBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TOchBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TOchBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOchBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOchBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOchBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOchBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOchBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TOchBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TOchBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOchBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOchBtr.ReadDepVal:double;
begin
  Result := oBtrTable.FieldByName('DepVal').AsFloat;
end;

procedure TOchBtr.WriteDepVal(pValue:double);
begin
  oBtrTable.FieldByName('DepVal').AsFloat := pValue;
end;

function TOchBtr.ReadAcMValue:double;
begin
  Result := oBtrTable.FieldByName('AcMValue').AsFloat;
end;

procedure TOchBtr.WriteAcMValue(pValue:double);
begin
  oBtrTable.FieldByName('AcMValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcWValue:double;
begin
  Result := oBtrTable.FieldByName('AcWValue').AsFloat;
end;

procedure TOchBtr.WriteAcWValue(pValue:double);
begin
  oBtrTable.FieldByName('AcWValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcOValue:double;
begin
  Result := oBtrTable.FieldByName('AcOValue').AsFloat;
end;

procedure TOchBtr.WriteAcOValue(pValue:double);
begin
  oBtrTable.FieldByName('AcOValue').AsFloat := pValue;
end;

function TOchBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TOchBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TOchBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TOchBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TOchBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TOchBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TOchBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TOchBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TOchBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TOchBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TOchBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TOchBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TOchBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TOchBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TOchBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TOchBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TOchBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOchBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOchBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOchBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOchBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOchBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOchBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TOchBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TOchBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TOchBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TOchBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TOchBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TOchBtr.ReadFgPValue:double;
begin
  Result := oBtrTable.FieldByName('FgPValue').AsFloat;
end;

procedure TOchBtr.WriteFgPValue(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TOchBtr.ReadFgAValue1:double;
begin
  Result := oBtrTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TOchBtr.WriteFgAValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TOchBtr.ReadFgAValue2:double;
begin
  Result := oBtrTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TOchBtr.WriteFgAValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TOchBtr.ReadFgAValue3:double;
begin
  Result := oBtrTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TOchBtr.WriteFgAValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TOchBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TOchBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TOchBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TOchBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TOchBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TOchBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TOchBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TOchBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TOchBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TOchBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TOchBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOchBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TOchBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOchBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOchBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOchBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOchBtr.ReadCntOrd:word;
begin
  Result := oBtrTable.FieldByName('CntOrd').AsInteger;
end;

procedure TOchBtr.WriteCntOrd(pValue:word);
begin
  oBtrTable.FieldByName('CntOrd').AsInteger := pValue;
end;

function TOchBtr.ReadCntRes:word;
begin
  Result := oBtrTable.FieldByName('CntRes').AsInteger;
end;

procedure TOchBtr.WriteCntRes(pValue:word);
begin
  oBtrTable.FieldByName('CntRes').AsInteger := pValue;
end;

function TOchBtr.ReadCntPrp:word;
begin
  Result := oBtrTable.FieldByName('CntPrp').AsInteger;
end;

procedure TOchBtr.WriteCntPrp(pValue:word);
begin
  oBtrTable.FieldByName('CntPrp').AsInteger := pValue;
end;

function TOchBtr.ReadCntOut:word;
begin
  Result := oBtrTable.FieldByName('CntOut').AsInteger;
end;

procedure TOchBtr.WriteCntOut(pValue:word);
begin
  oBtrTable.FieldByName('CntOut').AsInteger := pValue;
end;

function TOchBtr.ReadCntReq:word;
begin
  Result := oBtrTable.FieldByName('CntReq').AsInteger;
end;

procedure TOchBtr.WriteCntReq(pValue:word);
begin
  oBtrTable.FieldByName('CntReq').AsInteger := pValue;
end;

function TOchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TOchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOchBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TOchBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TOchBtr.ReadSended:byte;
begin
  Result:=oBtrTable.FieldByName('Sended').AsInteger;
end;

procedure TOchBtr.WriteSended(pValue:byte);
begin
  oBtrTable.FieldByName('Sended').AsInteger:=pValue;
end;

function TOchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOchBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOchBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOchBtr.ReadPValPay:Str1;
begin
  Result := oBtrTable.FieldByName('PValPay').AsString;
end;

procedure TOchBtr.WritePValPay(pValue:Str1);
begin
  oBtrTable.FieldByName('PValPay').AsString := pValue;
end;

function TOchBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TOchBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TOchBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TOchBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TOchBtr.ReadSndNum:word;
begin
  Result := oBtrTable.FieldByName('SndNum').AsInteger;
end;

procedure TOchBtr.WriteSndNum(pValue:word);
begin
  oBtrTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TOchBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TOchBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TOchBtr.ReadCntRat:word;
begin
  Result := oBtrTable.FieldByName('CntRat').AsInteger;
end;

procedure TOchBtr.WriteCntRat(pValue:word);
begin
  oBtrTable.FieldByName('CntRat').AsInteger := pValue;
end;

function TOchBtr.ReadCntTrm:word;
begin
  Result := oBtrTable.FieldByName('CntTrm').AsInteger;
end;

procedure TOchBtr.WriteCntTrm(pValue:word);
begin
  oBtrTable.FieldByName('CntTrm').AsInteger := pValue;
end;

function TOchBtr.ReadCntErr:word;
begin
  Result := oBtrTable.FieldByName('CntErr').AsInteger;
end;

procedure TOchBtr.WriteCntErr(pValue:word);
begin
  oBtrTable.FieldByName('CntErr').AsInteger := pValue;
end;

function TOchBtr.ReadTrnCrs:word;
begin
  Result := oBtrTable.FieldByName('TrnCrs').AsInteger;
end;

procedure TOchBtr.WriteTrnCrs(pValue:word);
begin
  oBtrTable.FieldByName('TrnCrs').AsInteger := pValue;
end;

function TOchBtr.ReadCntTre:word;
begin
  Result := oBtrTable.FieldByName('CntTre').AsInteger;
end;

procedure TOchBtr.WriteCntTre(pValue:word);
begin
  oBtrTable.FieldByName('CntTre').AsInteger := pValue;
end;

function TOchBtr.ReadRmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('RmdNum').AsString;
end;

procedure TOchBtr.WriteRmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RmdNum').AsString := pValue;
end;

function TOchBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TOchBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TOchBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TOchBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TOchBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TOchBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TOchBtr.ReadPrjCode:Str12;
begin
  Result := oBtrTable.FieldByName('PrjCode').AsString;
end;

procedure TOchBtr.WritePrjCode(pValue:Str12);
begin
  oBtrTable.FieldByName('PrjCode').AsString := pValue;
end;

function TOchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TOchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TOchBtr.ReadComDlv:byte;
begin
  Result := oBtrTable.FieldByName('ComDlv').AsInteger;
end;

procedure TOchBtr.WriteComDlv(pValue:byte);
begin
  oBtrTable.FieldByName('ComDlv').AsInteger := pValue;
end;

function TOchBtr.ReadPerCol:byte;
begin
  Result := oBtrTable.FieldByName('PerCol').AsInteger;
end;

procedure TOchBtr.WritePerCol(pValue:byte);
begin
  oBtrTable.FieldByName('PerCol').AsInteger := pValue;
end;

function TOchBtr.ReadTvalue:double;
begin
  Result := oBtrTable.FieldByName('Tvalue').AsFloat;
end;

procedure TOchBtr.WriteTvalue(pValue:double);
begin
  oBtrTable.FieldByName('Tvalue').AsFloat := pValue;
end;

function TOchBtr.ReadDepDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('DepDat').AsDateTime;
end;

procedure TOchBtr.WriteDepDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DepDat').AsDateTime := pValue;
end;

function TOchBtr.ReadDepPay:Str1;
begin
  Result := oBtrTable.FieldByName('DepPay').AsString;
end;

procedure TOchBtr.WriteDepPay(pValue:Str1);
begin
  oBtrTable.FieldByName('DepPay').AsString := pValue;
end;

function TOchBtr.ReadDepCas:byte;
begin
  Result := oBtrTable.FieldByName('DepCas').AsInteger;
end;

procedure TOchBtr.WriteDepCas(pValue:byte);
begin
  oBtrTable.FieldByName('DepCas').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TOchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOchBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TOchBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TOchBtr.LocateDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindKey([pDlvDate]);
end;

function TOchBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TOchBtr.LocateSpaWpa (pSpaCode:longint;pWpaCode:word):boolean;
begin
  SetIndex (ixSpaWpa);
  Result := oBtrTable.FindKey([pSpaCode,pWpaCode]);
end;

function TOchBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TOchBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TOchBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TOchBtr.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindKey([pAcBValue]);
end;

function TOchBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TOchBtr.LocateCntOrd (pCntOrd:word):boolean;
begin
  SetIndex (ixCntOrd);
  Result := oBtrTable.FindKey([pCntOrd]);
end;

function TOchBtr.LocateCntRes (pCntRes:word):boolean;
begin
  SetIndex (ixCntRes);
  Result := oBtrTable.FindKey([pCntRes]);
end;

function TOchBtr.LocateCntPrp (pCntPrp:word):boolean;
begin
  SetIndex (ixCntPrp);
  Result := oBtrTable.FindKey([pCntPrp]);
end;

function TOchBtr.LocateCntOut (pCntOut:word):boolean;
begin
  SetIndex (ixCntOut);
  Result := oBtrTable.FindKey([pCntOut]);
end;

function TOchBtr.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindKey([pDstCls]);
end;

function TOchBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TOchBtr.LocatePrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindKey([pPrjCode]);
end;

function TOchBtr.LocateRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindKey([pRegIno]);
end;

function TOchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TOchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOchBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TOchBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TOchBtr.NearestDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindNearest([pDlvDate]);
end;

function TOchBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TOchBtr.NearestSpaWpa (pSpaCode:longint;pWpaCode:word):boolean;
begin
  SetIndex (ixSpaWpa);
  Result := oBtrTable.FindNearest([pSpaCode,pWpaCode]);
end;

function TOchBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TOchBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TOchBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TOchBtr.NearestAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindNearest([pAcBValue]);
end;

function TOchBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TOchBtr.NearestCntOrd (pCntOrd:word):boolean;
begin
  SetIndex (ixCntOrd);
  Result := oBtrTable.FindNearest([pCntOrd]);
end;

function TOchBtr.NearestCntRes (pCntRes:word):boolean;
begin
  SetIndex (ixCntRes);
  Result := oBtrTable.FindNearest([pCntRes]);
end;

function TOchBtr.NearestCntPrp (pCntPrp:word):boolean;
begin
  SetIndex (ixCntPrp);
  Result := oBtrTable.FindNearest([pCntPrp]);
end;

function TOchBtr.NearestCntOut (pCntOut:word):boolean;
begin
  SetIndex (ixCntOut);
  Result := oBtrTable.FindNearest([pCntOut]);
end;

function TOchBtr.NearestDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindNearest([pDstCls]);
end;

function TOchBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TOchBtr.NearestPrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindNearest([pPrjCode]);
end;

function TOchBtr.NearestRegIno (pRegIno:Str15):boolean;
begin
  SetIndex (ixRegIno);
  Result := oBtrTable.FindNearest([pRegIno]);
end;

procedure TOchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOchBtr.First;
begin
  oBtrTable.First;
end;

procedure TOchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
