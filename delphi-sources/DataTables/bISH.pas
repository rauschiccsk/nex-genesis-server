unit bISH;

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
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixDstAcc = 'DstAcc';
  ixPaCode = 'PaCode';
  ixDstLiq = 'DstLiq';
  ixIodNum = 'IodNum';
  ixIncNum = 'IncNum';

type
  TIshBtr = class (TComponent)
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
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadTaxDate:TDatetime;     procedure WriteTaxDate (pValue:TDatetime);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
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
    function  ReadPayCode:Str3;          procedure WritePayCode (pValue:Str3);
    function  ReadPayName:Str20;         procedure WritePayName (pValue:Str20);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankCode:Str15;        procedure WriteBankCode (pValue:Str15);
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadIbanCode:Str34;        procedure WriteIbanCode (pValue:Str34);
    function  ReadSwftCode:Str20;        procedure WriteSwftCode (pValue:Str20);
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
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
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
    function  ReadAcPrvPay:double;       procedure WriteAcPrvPay (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadFgPrvPay:double;       procedure WriteFgPrvPay (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgCValue1:double;      procedure WriteFgCValue1 (pValue:double);
    function  ReadFgCValue2:double;      procedure WriteFgCValue2 (pValue:double);
    function  ReadFgCValue3:double;      procedure WriteFgCValue3 (pValue:double);
    function  ReadFgEValue1:double;      procedure WriteFgEValue1 (pValue:double);
    function  ReadFgEValue2:double;      procedure WriteFgEValue2 (pValue:double);
    function  ReadFgEValue3:double;      procedure WriteFgEValue3 (pValue:double);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadTsdNum:Str15;          procedure WriteTsdNum (pValue:Str15);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
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
    function  ReadDocSnt:Str3;           procedure WriteDocSnt (pValue:Str3);
    function  ReadDocAnl:Str6;           procedure WriteDocAnl (pValue:Str6);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadPmqDate:TDatetime;     procedure WritePmqDate (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcCValue4:double;      procedure WriteAcCValue4 (pValue:double);
    function  ReadAcCValue5:double;      procedure WriteAcCValue5 (pValue:double);
    function  ReadAcEValue4:double;      procedure WriteAcEValue4 (pValue:double);
    function  ReadAcEValue5:double;      procedure WriteAcEValue5 (pValue:double);
    function  ReadFgCValue4:double;      procedure WriteFgCValue4 (pValue:double);
    function  ReadFgCValue5:double;      procedure WriteFgCValue5 (pValue:double);
    function  ReadFgEValue4:double;      procedure WriteFgEValue4 (pValue:double);
    function  ReadFgEValue5:double;      procedure WriteFgEValue5 (pValue:double);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadIodNum:Str12;          procedure WriteIodNum (pValue:Str12);
    function  ReadIoeNum:Str32;          procedure WriteIoeNum (pValue:Str32);
    function  ReadIncNum:Str32;          procedure WriteIncNum (pValue:Str32);
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
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateDstLiq (pDstLiq:Str1):boolean;
    function LocateIodNum (pIodNum:Str12):boolean;
    function LocateIncNum (pIncNum:Str32):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestExpDate (pExpDate:TDatetime):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestAcEValue (pAcEValue:double):boolean;
    function NearestFgEValue (pFgEValue:double):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestDstLiq (pDstLiq:Str1):boolean;
    function NearestIodNum (pIodNum:Str12):boolean;
    function NearestIncNum (pIncNum:Str32):boolean;

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
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property TaxDate:TDatetime read ReadTaxDate write WriteTaxDate;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
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
    property PayCode:Str3 read ReadPayCode write WritePayCode;
    property PayName:Str20 read ReadPayName write WritePayName;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankCode:Str15 read ReadBankCode write WriteBankCode;
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property IbanCode:Str34 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str20 read ReadSwftCode write WriteSwftCode;
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
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
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
    property AcPrvPay:double read ReadAcPrvPay write WriteAcPrvPay;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property FgPrvPay:double read ReadFgPrvPay write WriteFgPrvPay;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgCValue1:double read ReadFgCValue1 write WriteFgCValue1;
    property FgCValue2:double read ReadFgCValue2 write WriteFgCValue2;
    property FgCValue3:double read ReadFgCValue3 write WriteFgCValue3;
    property FgEValue1:double read ReadFgEValue1 write WriteFgEValue1;
    property FgEValue2:double read ReadFgEValue2 write WriteFgEValue2;
    property FgEValue3:double read ReadFgEValue3 write WriteFgEValue3;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property TsdNum:Str15 read ReadTsdNum write WriteTsdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
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
    property DocSnt:Str3 read ReadDocSnt write WriteDocSnt;
    property DocAnl:Str6 read ReadDocAnl write WriteDocAnl;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property PmqDate:TDatetime read ReadPmqDate write WritePmqDate;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcCValue4:double read ReadAcCValue4 write WriteAcCValue4;
    property AcCValue5:double read ReadAcCValue5 write WriteAcCValue5;
    property AcEValue4:double read ReadAcEValue4 write WriteAcEValue4;
    property AcEValue5:double read ReadAcEValue5 write WriteAcEValue5;
    property FgCValue4:double read ReadFgCValue4 write WriteFgCValue4;
    property FgCValue5:double read ReadFgCValue5 write WriteFgCValue5;
    property FgEValue4:double read ReadFgEValue4 write WriteFgEValue4;
    property FgEValue5:double read ReadFgEValue5 write WriteFgEValue5;
    property Year:Str2 read ReadYear write WriteYear;
    property IodNum:Str12 read ReadIodNum write WriteIodNum;
    property IoeNum:Str32 read ReadIoeNum write WriteIoeNum;
    property IncNum:Str32 read ReadIncNum write WriteIncNum;
    property CctVal:double read ReadCctVal write WriteCctVal;
  end;

implementation

constructor TIshBtr.Create;
begin
  oBtrTable := BtrInit ('ISH',gPath.LdgPath,Self);
end;

constructor TIshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ISH',pPath,Self);
end;

destructor TIshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIshBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TIshBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIshBtr.ReadSndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDate').AsDateTime;
end;

procedure TIshBtr.WriteSndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TIshBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TIshBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TIshBtr.ReadVatDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('VatDate').AsDateTime;
end;

procedure TIshBtr.WriteVatDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TIshBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TIshBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TIshBtr.ReadTaxDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TaxDate').AsDateTime;
end;

procedure TIshBtr.WriteTaxDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TaxDate').AsDateTime := pValue;
end;

function TIshBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TIshBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TIshBtr.ReadCsyCode:Str4;
begin
  Result := oBtrTable.FieldByName('CsyCode').AsString;
end;

procedure TIshBtr.WriteCsyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('CsyCode').AsString := pValue;
end;

function TIshBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIshBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIshBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TIshBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TIshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TIshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TIshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TIshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TIshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TIshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TIshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TIshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TIshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TIshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TIshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TIshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TIshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TIshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TIshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TIshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TIshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TIshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TIshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TIshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TIshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TIshBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TIshBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TIshBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TIshBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TIshBtr.ReadContoNum:Str30;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TIshBtr.WriteContoNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TIshBtr.ReadBankCode:Str15;
begin
  Result := oBtrTable.FieldByName('BankCode').AsString;
end;

procedure TIshBtr.WriteBankCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BankCode').AsString := pValue;
end;

function TIshBtr.ReadBankSeat:Str30;
begin
  Result := oBtrTable.FieldByName('BankSeat').AsString;
end;

procedure TIshBtr.WriteBankSeat(pValue:Str30);
begin
  oBtrTable.FieldByName('BankSeat').AsString := pValue;
end;

function TIshBtr.ReadIbanCode:Str34;
begin
  Result := oBtrTable.FieldByName('IbanCode').AsString;
end;

procedure TIshBtr.WriteIbanCode(pValue:Str34);
begin
  oBtrTable.FieldByName('IbanCode').AsString := pValue;
end;

function TIshBtr.ReadSwftCode:Str20;
begin
  Result := oBtrTable.FieldByName('SwftCode').AsString;
end;

procedure TIshBtr.WriteSwftCode(pValue:Str20);
begin
  oBtrTable.FieldByName('SwftCode').AsString := pValue;
end;

function TIshBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TIshBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TIshBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TIshBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TIshBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TIshBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TIshBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TIshBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TIshBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TIshBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TIshBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TIshBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TIshBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TIshBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TIshBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TIshBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TIshBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TIshBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TIshBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TIshBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TIshBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIshBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TIshBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIshBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIshBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIshBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIshBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIshBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIshBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIshBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIshBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TIshBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TIshBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIshBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIshBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIshBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIshBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIshBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIshBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIshBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TIshBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TIshBtr.ReadAcCValue1:double;
begin
  Result := oBtrTable.FieldByName('AcCValue1').AsFloat;
end;

procedure TIshBtr.WriteAcCValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue1').AsFloat := pValue;
end;

function TIshBtr.ReadAcCValue2:double;
begin
  Result := oBtrTable.FieldByName('AcCValue2').AsFloat;
end;

procedure TIshBtr.WriteAcCValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue2').AsFloat := pValue;
end;

function TIshBtr.ReadAcCValue3:double;
begin
  Result := oBtrTable.FieldByName('AcCValue3').AsFloat;
end;

procedure TIshBtr.WriteAcCValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue3').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue1:double;
begin
  Result := oBtrTable.FieldByName('AcEValue1').AsFloat;
end;

procedure TIshBtr.WriteAcEValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue1').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue2:double;
begin
  Result := oBtrTable.FieldByName('AcEValue2').AsFloat;
end;

procedure TIshBtr.WriteAcEValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue2').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue3:double;
begin
  Result := oBtrTable.FieldByName('AcEValue3').AsFloat;
end;

procedure TIshBtr.WriteAcEValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue3').AsFloat := pValue;
end;

function TIshBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIshBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIshBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIshBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIshBtr.ReadAcPrvPay:double;
begin
  Result := oBtrTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TIshBtr.WriteAcPrvPay(pValue:double);
begin
  oBtrTable.FieldByName('AcPrvPay').AsFloat := pValue;
end;

function TIshBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TIshBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TIshBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TIshBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TIshBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TIshBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TIshBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIshBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIshBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIshBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIshBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIshBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIshBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIshBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TIshBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TIshBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TIshBtr.ReadFgPrvPay:double;
begin
  Result := oBtrTable.FieldByName('FgPrvPay').AsFloat;
end;

procedure TIshBtr.WriteFgPrvPay(pValue:double);
begin
  oBtrTable.FieldByName('FgPrvPay').AsFloat := pValue;
end;

function TIshBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIshBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TIshBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TIshBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue1:double;
begin
  Result := oBtrTable.FieldByName('FgCValue1').AsFloat;
end;

procedure TIshBtr.WriteFgCValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue1').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue2:double;
begin
  Result := oBtrTable.FieldByName('FgCValue2').AsFloat;
end;

procedure TIshBtr.WriteFgCValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue2').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue3:double;
begin
  Result := oBtrTable.FieldByName('FgCValue3').AsFloat;
end;

procedure TIshBtr.WriteFgCValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue3').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue1:double;
begin
  Result := oBtrTable.FieldByName('FgEValue1').AsFloat;
end;

procedure TIshBtr.WriteFgEValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue1').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue2:double;
begin
  Result := oBtrTable.FieldByName('FgEValue2').AsFloat;
end;

procedure TIshBtr.WriteFgEValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue2').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue3:double;
begin
  Result := oBtrTable.FieldByName('FgEValue3').AsFloat;
end;

procedure TIshBtr.WriteFgEValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue3').AsFloat := pValue;
end;

function TIshBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TIshBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TIshBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TIshBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TIshBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIshBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TIshBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TIshBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TIshBtr.ReadDocSpc:byte;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIshBtr.WriteDocSpc(pValue:byte);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIshBtr.ReadTsdNum:Str15;
begin
  Result := oBtrTable.FieldByName('TsdNum').AsString;
end;

procedure TIshBtr.WriteTsdNum(pValue:Str15);
begin
  oBtrTable.FieldByName('TsdNum').AsString := pValue;
end;

function TIshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIshBtr.ReadDstPair:Str1;
begin
  Result := oBtrTable.FieldByName('DstPair').AsString;
end;

procedure TIshBtr.WriteDstPair(pValue:Str1);
begin
  oBtrTable.FieldByName('DstPair').AsString := pValue;
end;

function TIshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TIshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIshBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TIshBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TIshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TIshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TIshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIshBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIshBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIshBtr.ReadDocSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DocSnt').AsString;
end;

procedure TIshBtr.WriteDocSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DocSnt').AsString := pValue;
end;

function TIshBtr.ReadDocAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DocAnl').AsString;
end;

procedure TIshBtr.WriteDocAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DocAnl').AsString := pValue;
end;

function TIshBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TIshBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIshBtr.ReadPmqDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PmqDate').AsDateTime;
end;

procedure TIshBtr.WritePmqDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PmqDate').AsDateTime := pValue;
end;

function TIshBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TIshBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TIshBtr.ReadWrnNum:byte;
begin
  Result := oBtrTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIshBtr.WriteWrnNum(pValue:byte);
begin
  oBtrTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIshBtr.ReadWrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIshBtr.WriteWrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIshBtr.ReadDstLiq:Str1;
begin
  Result := oBtrTable.FieldByName('DstLiq').AsString;
end;

procedure TIshBtr.WriteDstLiq(pValue:Str1);
begin
  oBtrTable.FieldByName('DstLiq').AsString := pValue;
end;

function TIshBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIshBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIshBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIshBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIshBtr.ReadAcCValue4:double;
begin
  Result := oBtrTable.FieldByName('AcCValue4').AsFloat;
end;

procedure TIshBtr.WriteAcCValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue4').AsFloat := pValue;
end;

function TIshBtr.ReadAcCValue5:double;
begin
  Result := oBtrTable.FieldByName('AcCValue5').AsFloat;
end;

procedure TIshBtr.WriteAcCValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue5').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue4:double;
begin
  Result := oBtrTable.FieldByName('AcEValue4').AsFloat;
end;

procedure TIshBtr.WriteAcEValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue4').AsFloat := pValue;
end;

function TIshBtr.ReadAcEValue5:double;
begin
  Result := oBtrTable.FieldByName('AcEValue5').AsFloat;
end;

procedure TIshBtr.WriteAcEValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue5').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue4:double;
begin
  Result := oBtrTable.FieldByName('FgCValue4').AsFloat;
end;

procedure TIshBtr.WriteFgCValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue4').AsFloat := pValue;
end;

function TIshBtr.ReadFgCValue5:double;
begin
  Result := oBtrTable.FieldByName('FgCValue5').AsFloat;
end;

procedure TIshBtr.WriteFgCValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue5').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue4:double;
begin
  Result := oBtrTable.FieldByName('FgEValue4').AsFloat;
end;

procedure TIshBtr.WriteFgEValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue4').AsFloat := pValue;
end;

function TIshBtr.ReadFgEValue5:double;
begin
  Result := oBtrTable.FieldByName('FgEValue5').AsFloat;
end;

procedure TIshBtr.WriteFgEValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue5').AsFloat := pValue;
end;

function TIshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TIshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TIshBtr.ReadIodNum:Str12;
begin
  Result := oBtrTable.FieldByName('IodNum').AsString;
end;

procedure TIshBtr.WriteIodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IodNum').AsString := pValue;
end;

function TIshBtr.ReadIoeNum:Str32;
begin
  Result := oBtrTable.FieldByName('IoeNum').AsString;
end;

procedure TIshBtr.WriteIoeNum(pValue:Str32);
begin
  oBtrTable.FieldByName('IoeNum').AsString := pValue;
end;

function TIshBtr.ReadIncNum:Str32;
begin
  Result := oBtrTable.FieldByName('IncNum').AsString;
end;

procedure TIshBtr.WriteIncNum(pValue:Str32);
begin
  oBtrTable.FieldByName('IncNum').AsString := pValue;
end;

function TIshBtr.ReadCctVal:double;
begin
  Result := oBtrTable.FieldByName('CctVal').AsFloat;
end;

procedure TIshBtr.WriteCctVal(pValue:double);
begin
  oBtrTable.FieldByName('CctVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TIshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIshBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TIshBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIshBtr.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindKey([pExpDate]);
end;

function TIshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TIshBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TIshBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TIshBtr.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindKey([pAcEValue]);
end;

function TIshBtr.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindKey([pFgEValue]);
end;

function TIshBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TIshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TIshBtr.LocateDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindKey([pDstLiq]);
end;

function TIshBtr.LocateIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oBtrTable.FindKey([pIodNum]);
end;

function TIshBtr.LocateIncNum (pIncNum:Str32):boolean;
begin
  SetIndex (ixIncNum);
  Result := oBtrTable.FindKey([pIncNum]);
end;

function TIshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TIshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIshBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TIshBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIshBtr.NearestExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindNearest([pExpDate]);
end;

function TIshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TIshBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TIshBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TIshBtr.NearestAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindNearest([pAcEValue]);
end;

function TIshBtr.NearestFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindNearest([pFgEValue]);
end;

function TIshBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

function TIshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TIshBtr.NearestDstLiq (pDstLiq:Str1):boolean;
begin
  SetIndex (ixDstLiq);
  Result := oBtrTable.FindNearest([pDstLiq]);
end;

function TIshBtr.NearestIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oBtrTable.FindNearest([pIodNum]);
end;

function TIshBtr.NearestIncNum (pIncNum:Str32):boolean;
begin
  SetIndex (ixIncNum);
  Result := oBtrTable.FindNearest([pIncNum]);
end;

procedure TIshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIshBtr.First;
begin
  oBtrTable.First;
end;

procedure TIshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
