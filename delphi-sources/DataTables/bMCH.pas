unit bMCH;

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
  ixExpDate = 'ExpDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';
  ixAccept = 'Accept';
  ixPrjCode = 'PrjCode';
  ixDocDes = 'DocDes';

type
  TMchBtr = class (TComponent)
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
    function  ReadMyConto:Str30;         procedure WriteMyConto (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str20;         procedure WritePaName_ (pValue:Str20);
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
    function  ReadReserve:Str20;         procedure WriteReserve (pValue:Str20);
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
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcPValue:double;       procedure WriteAcPValue (pValue:double);
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
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadAccept:byte;           procedure WriteAccept (pValue:byte);
    function  ReadDcCode:byte;           procedure WriteDcCode (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadDstSpi:byte;           procedure WriteDstSpi (pValue:byte);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadDstPay:byte;           procedure WriteDstPay (pValue:byte);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadProPrc:double;         procedure WriteProPrc (pValue:double);
    function  ReadProVal:double;         procedure WriteProVal (pValue:double);
    function  ReadEquVal:double;         procedure WriteEquVal (pValue:double);
    function  ReadEquPrc:byte;           procedure WriteEquPrc (pValue:byte);
    function  ReadNeqNum:word;           procedure WriteNeqNum (pValue:word);
    function  ReadDocDes:Str50;          procedure WriteDocDes (pValue:Str50);
    function  ReadDocDes_:Str50;         procedure WriteDocDes_ (pValue:Str50);
    function  ReadRspNum:word;           procedure WriteRspNum (pValue:word);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadCusReq:Str20;          procedure WriteCusReq (pValue:Str20);
    function  ReadCusTel:Str20;          procedure WriteCusTel (pValue:Str20);
    function  ReadCumEml:Str30;          procedure WriteCumEml (pValue:Str30);
    function  ReadIddQnt:word;           procedure WriteIddQnt (pValue:word);
    function  ReadDlvDay:word;           procedure WriteDlvDay (pValue:word);
    function  ReadAplNum:word;           procedure WriteAplNum (pValue:word);
    function  ReadPrjSub:word;           procedure WritePrjSub (pValue:word);
    function  ReadSigUid1:Str3;          procedure WriteSigUid1 (pValue:Str3);
    function  ReadSigUid2:Str3;          procedure WriteSigUid2 (pValue:Str3);
    function  ReadSigUid3:Str3;          procedure WriteSigUid3 (pValue:Str3);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcBValue4:double;      procedure WriteAcBValue4 (pValue:double);
    function  ReadFgAValue4:double;      procedure WriteFgAValue4 (pValue:double);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcBValue5:double;      procedure WriteAcBValue5 (pValue:double);
    function  ReadFgAValue5:double;      procedure WriteFgAValue5 (pValue:double);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str20):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateAccept (pAccept:byte):boolean;
    function LocatePrjCode (pPrjCode:Str12):boolean;
    function LocateDocDes (pDocDes_:Str50):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestExpDate (pExpDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str20):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestAcBValue (pAcBValue:double):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestAccept (pAccept:byte):boolean;
    function NearestPrjCode (pPrjCode:Str12):boolean;
    function NearestDocDes (pDocDes_:Str50):boolean;

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
    property MyConto:Str30 read ReadMyConto write WriteMyConto;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str20 read ReadPaName_ write WritePaName_;
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
    property Reserve:Str20 read ReadReserve write WriteReserve;
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
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcPValue:double read ReadAcPValue write WriteAcPValue;
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
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Accept:byte read ReadAccept write WriteAccept;
    property DcCode:byte read ReadDcCode write WriteDcCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property DstSpi:byte read ReadDstSpi write WriteDstSpi;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property DstPay:byte read ReadDstPay write WriteDstPay;
    property Year:Str2 read ReadYear write WriteYear;
    property ProPrc:double read ReadProPrc write WriteProPrc;
    property ProVal:double read ReadProVal write WriteProVal;
    property EquVal:double read ReadEquVal write WriteEquVal;
    property EquPrc:byte read ReadEquPrc write WriteEquPrc;
    property NeqNum:word read ReadNeqNum write WriteNeqNum;
    property DocDes:Str50 read ReadDocDes write WriteDocDes;
    property DocDes_:Str50 read ReadDocDes_ write WriteDocDes_;
    property RspNum:word read ReadRspNum write WriteRspNum;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property CusReq:Str20 read ReadCusReq write WriteCusReq;
    property CusTel:Str20 read ReadCusTel write WriteCusTel;
    property CumEml:Str30 read ReadCumEml write WriteCumEml;
    property IddQnt:word read ReadIddQnt write WriteIddQnt;
    property DlvDay:word read ReadDlvDay write WriteDlvDay;
    property AplNum:word read ReadAplNum write WriteAplNum;
    property PrjSub:word read ReadPrjSub write WritePrjSub;
    property SigUid1:Str3 read ReadSigUid1 write WriteSigUid1;
    property SigUid2:Str3 read ReadSigUid2 write WriteSigUid2;
    property SigUid3:Str3 read ReadSigUid3 write WriteSigUid3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcBValue4:double read ReadAcBValue4 write WriteAcBValue4;
    property FgAValue4:double read ReadFgAValue4 write WriteFgAValue4;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcBValue5:double read ReadAcBValue5 write WriteAcBValue5;
    property FgAValue5:double read ReadFgAValue5 write WriteFgAValue5;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
  end;

implementation

constructor TMchBtr.Create;
begin
  oBtrTable := BtrInit ('MCH',gPath.StkPath,Self);
end;

constructor TMchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MCH',pPath,Self);
end;

destructor TMchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TMchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TMchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TMchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TMchBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TMchBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TMchBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TMchBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TMchBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TMchBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TMchBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TMchBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TMchBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TMchBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TMchBtr.ReadMyConto:Str30;
begin
  Result := oBtrTable.FieldByName('MyConto').AsString;
end;

procedure TMchBtr.WriteMyConto(pValue:Str30);
begin
  oBtrTable.FieldByName('MyConto').AsString := pValue;
end;

function TMchBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TMchBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TMchBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TMchBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TMchBtr.ReadPaName_:Str20;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TMchBtr.WritePaName_(pValue:Str20);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TMchBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TMchBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TMchBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TMchBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TMchBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TMchBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TMchBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TMchBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TMchBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TMchBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TMchBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TMchBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TMchBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TMchBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TMchBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TMchBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TMchBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TMchBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TMchBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TMchBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TMchBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TMchBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TMchBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TMchBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TMchBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TMchBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TMchBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TMchBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TMchBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TMchBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TMchBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TMchBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TMchBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TMchBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TMchBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TMchBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TMchBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TMchBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TMchBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TMchBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TMchBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TMchBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TMchBtr.ReadReserve:Str20;
begin
  Result := oBtrTable.FieldByName('Reserve').AsString;
end;

procedure TMchBtr.WriteReserve(pValue:Str20);
begin
  oBtrTable.FieldByName('Reserve').AsString := pValue;
end;

function TMchBtr.ReadIcFacDay:word;
begin
  Result := oBtrTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TMchBtr.WriteIcFacDay(pValue:word);
begin
  oBtrTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TMchBtr.ReadIcFacPrc:double;
begin
  Result := oBtrTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TMchBtr.WriteIcFacPrc(pValue:double);
begin
  oBtrTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TMchBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TMchBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TMchBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TMchBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TMchBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TMchBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TMchBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TMchBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TMchBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TMchBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TMchBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TMchBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TMchBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TMchBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TMchBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TMchBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TMchBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TMchBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TMchBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TMchBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TMchBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TMchBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TMchBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TMchBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TMchBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TMchBtr.ReadAcPValue:double;
begin
  Result := oBtrTable.FieldByName('AcPValue').AsFloat;
end;

procedure TMchBtr.WriteAcPValue(pValue:double);
begin
  oBtrTable.FieldByName('AcPValue').AsFloat := pValue;
end;

function TMchBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TMchBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TMchBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TMchBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TMchBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TMchBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TMchBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TMchBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TMchBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TMchBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TMchBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TMchBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TMchBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TMchBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TMchBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TMchBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TMchBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TMchBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TMchBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TMchBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TMchBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TMchBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TMchBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TMchBtr.ReadFgPValue:double;
begin
  Result := oBtrTable.FieldByName('FgPValue').AsFloat;
end;

procedure TMchBtr.WriteFgPValue(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue1:double;
begin
  Result := oBtrTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TMchBtr.WriteFgAValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue2:double;
begin
  Result := oBtrTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TMchBtr.WriteFgAValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue3:double;
begin
  Result := oBtrTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TMchBtr.WriteFgAValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TMchBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TMchBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TMchBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TMchBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TMchBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TMchBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TMchBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TMchBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TMchBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TMchBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TMchBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TMchBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TMchBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TMchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TMchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TMchBtr.ReadAccept:byte;
begin
  Result := oBtrTable.FieldByName('Accept').AsInteger;
end;

procedure TMchBtr.WriteAccept(pValue:byte);
begin
  oBtrTable.FieldByName('Accept').AsInteger := pValue;
end;

function TMchBtr.ReadDcCode:byte;
begin
  Result := oBtrTable.FieldByName('DcCode').AsInteger;
end;

procedure TMchBtr.WriteDcCode(pValue:byte);
begin
  oBtrTable.FieldByName('DcCode').AsInteger := pValue;
end;

function TMchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMchBtr.ReadTrmNum:word;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TMchBtr.WriteTrmNum(pValue:word);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TMchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TMchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TMchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMchBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TMchBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TMchBtr.ReadPrjCode:Str12;
begin
  Result := oBtrTable.FieldByName('PrjCode').AsString;
end;

procedure TMchBtr.WritePrjCode(pValue:Str12);
begin
  oBtrTable.FieldByName('PrjCode').AsString := pValue;
end;

function TMchBtr.ReadDstSpi:byte;
begin
  Result := oBtrTable.FieldByName('DstSpi').AsInteger;
end;

procedure TMchBtr.WriteDstSpi(pValue:byte);
begin
  oBtrTable.FieldByName('DstSpi').AsInteger := pValue;
end;

function TMchBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TMchBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TMchBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TMchBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TMchBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TMchBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TMchBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TMchBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TMchBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TMchBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TMchBtr.ReadDstPay:byte;
begin
  Result := oBtrTable.FieldByName('DstPay').AsInteger;
end;

procedure TMchBtr.WriteDstPay(pValue:byte);
begin
  oBtrTable.FieldByName('DstPay').AsInteger := pValue;
end;

function TMchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TMchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TMchBtr.ReadProPrc:double;
begin
  Result := oBtrTable.FieldByName('ProPrc').AsFloat;
end;

procedure TMchBtr.WriteProPrc(pValue:double);
begin
  oBtrTable.FieldByName('ProPrc').AsFloat := pValue;
end;

function TMchBtr.ReadProVal:double;
begin
  Result := oBtrTable.FieldByName('ProVal').AsFloat;
end;

procedure TMchBtr.WriteProVal(pValue:double);
begin
  oBtrTable.FieldByName('ProVal').AsFloat := pValue;
end;

function TMchBtr.ReadEquVal:double;
begin
  Result := oBtrTable.FieldByName('EquVal').AsFloat;
end;

procedure TMchBtr.WriteEquVal(pValue:double);
begin
  oBtrTable.FieldByName('EquVal').AsFloat := pValue;
end;

function TMchBtr.ReadEquPrc:byte;
begin
  Result := oBtrTable.FieldByName('EquPrc').AsInteger;
end;

procedure TMchBtr.WriteEquPrc(pValue:byte);
begin
  oBtrTable.FieldByName('EquPrc').AsInteger := pValue;
end;

function TMchBtr.ReadNeqNum:word;
begin
  Result := oBtrTable.FieldByName('NeqNum').AsInteger;
end;

procedure TMchBtr.WriteNeqNum(pValue:word);
begin
  oBtrTable.FieldByName('NeqNum').AsInteger := pValue;
end;

function TMchBtr.ReadDocDes:Str50;
begin
  Result := oBtrTable.FieldByName('DocDes').AsString;
end;

procedure TMchBtr.WriteDocDes(pValue:Str50);
begin
  oBtrTable.FieldByName('DocDes').AsString := pValue;
end;

function TMchBtr.ReadDocDes_:Str50;
begin
  Result := oBtrTable.FieldByName('DocDes_').AsString;
end;

procedure TMchBtr.WriteDocDes_(pValue:Str50);
begin
  oBtrTable.FieldByName('DocDes_').AsString := pValue;
end;

function TMchBtr.ReadRspNum:word;
begin
  Result := oBtrTable.FieldByName('RspNum').AsInteger;
end;

procedure TMchBtr.WriteRspNum(pValue:word);
begin
  oBtrTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TMchBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TMchBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TMchBtr.ReadCusReq:Str20;
begin
  Result := oBtrTable.FieldByName('CusReq').AsString;
end;

procedure TMchBtr.WriteCusReq(pValue:Str20);
begin
  oBtrTable.FieldByName('CusReq').AsString := pValue;
end;

function TMchBtr.ReadCusTel:Str20;
begin
  Result := oBtrTable.FieldByName('CusTel').AsString;
end;

procedure TMchBtr.WriteCusTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CusTel').AsString := pValue;
end;

function TMchBtr.ReadCumEml:Str30;
begin
  Result := oBtrTable.FieldByName('CumEml').AsString;
end;

procedure TMchBtr.WriteCumEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CumEml').AsString := pValue;
end;

function TMchBtr.ReadIddQnt:word;
begin
  Result := oBtrTable.FieldByName('IddQnt').AsInteger;
end;

procedure TMchBtr.WriteIddQnt(pValue:word);
begin
  oBtrTable.FieldByName('IddQnt').AsInteger := pValue;
end;

function TMchBtr.ReadDlvDay:word;
begin
  Result := oBtrTable.FieldByName('DlvDay').AsInteger;
end;

procedure TMchBtr.WriteDlvDay(pValue:word);
begin
  oBtrTable.FieldByName('DlvDay').AsInteger := pValue;
end;

function TMchBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TMchBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TMchBtr.ReadPrjSub:word;
begin
  Result := oBtrTable.FieldByName('PrjSub').AsInteger;
end;

procedure TMchBtr.WritePrjSub(pValue:word);
begin
  oBtrTable.FieldByName('PrjSub').AsInteger := pValue;
end;

function TMchBtr.ReadSigUid1:Str3;
begin
  Result := oBtrTable.FieldByName('SigUid1').AsString;
end;

procedure TMchBtr.WriteSigUid1(pValue:Str3);
begin
  oBtrTable.FieldByName('SigUid1').AsString := pValue;
end;

function TMchBtr.ReadSigUid2:Str3;
begin
  Result := oBtrTable.FieldByName('SigUid2').AsString;
end;

procedure TMchBtr.WriteSigUid2(pValue:Str3);
begin
  oBtrTable.FieldByName('SigUid2').AsString := pValue;
end;

function TMchBtr.ReadSigUid3:Str3;
begin
  Result := oBtrTable.FieldByName('SigUid3').AsString;
end;

procedure TMchBtr.WriteSigUid3(pValue:Str3);
begin
  oBtrTable.FieldByName('SigUid3').AsString := pValue;
end;

function TMchBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TMchBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TMchBtr.ReadAcAValue4:double;
begin
  Result := oBtrTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TMchBtr.WriteAcAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue4:double;
begin
  Result := oBtrTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TMchBtr.WriteAcBValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue4:double;
begin
  Result := oBtrTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TMchBtr.WriteFgAValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue4:double;
begin
  Result := oBtrTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TMchBtr.WriteFgBValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TMchBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TMchBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TMchBtr.ReadAcAValue5:double;
begin
  Result := oBtrTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TMchBtr.WriteAcAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TMchBtr.ReadAcBValue5:double;
begin
  Result := oBtrTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TMchBtr.WriteAcBValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TMchBtr.ReadFgAValue5:double;
begin
  Result := oBtrTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TMchBtr.WriteFgAValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TMchBtr.ReadFgBValue5:double;
begin
  Result := oBtrTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TMchBtr.WriteFgBValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TMchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TMchBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TMchBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TMchBtr.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindKey([pExpDate]);
end;

function TMchBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TMchBtr.LocatePaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TMchBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TMchBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TMchBtr.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindKey([pAcBValue]);
end;

function TMchBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TMchBtr.LocateAccept (pAccept:byte):boolean;
begin
  SetIndex (ixAccept);
  Result := oBtrTable.FindKey([pAccept]);
end;

function TMchBtr.LocatePrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindKey([pPrjCode]);
end;

function TMchBtr.LocateDocDes (pDocDes_:Str50):boolean;
begin
  SetIndex (ixDocDes);
  Result := oBtrTable.FindKey([StrToAlias(pDocDes_)]);
end;

function TMchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TMchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TMchBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TMchBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TMchBtr.NearestExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindNearest([pExpDate]);
end;

function TMchBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TMchBtr.NearestPaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TMchBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TMchBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TMchBtr.NearestAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindNearest([pAcBValue]);
end;

function TMchBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TMchBtr.NearestAccept (pAccept:byte):boolean;
begin
  SetIndex (ixAccept);
  Result := oBtrTable.FindNearest([pAccept]);
end;

function TMchBtr.NearestPrjCode (pPrjCode:Str12):boolean;
begin
  SetIndex (ixPrjCode);
  Result := oBtrTable.FindNearest([pPrjCode]);
end;

function TMchBtr.NearestDocDes (pDocDes_:Str50):boolean;
begin
  SetIndex (ixDocDes);
  Result := oBtrTable.FindNearest([pDocDes_]);
end;

procedure TMchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TMchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMchBtr.First;
begin
  oBtrTable.First;
end;

procedure TMchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
