unit tISH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnAsAa = '';
  ixDocNum = 'DocNum';
  ixSerNum = 'SerNum';
  ixAsDn = 'AsDn';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixExpDate = 'ExpDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixDstAcc = 'DstAcc';
  ixExpDay = 'ExpDay';
  ixIodNum = 'IodNum';
  ixIncNum = 'IncNum';

type
  TIshTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadVatDate:TDatetime;     procedure WriteVatDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadTaxDate:TDatetime;     procedure WriteTaxDate (pValue:TDatetime);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadPmqDate:TDatetime;     procedure WritePmqDate (pValue:TDatetime);
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
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcCValue1:double;      procedure WriteAcCValue1 (pValue:double);
    function  ReadAcCValue2:double;      procedure WriteAcCValue2 (pValue:double);
    function  ReadAcCValue3:double;      procedure WriteAcCValue3 (pValue:double);
    function  ReadAcCValue4:double;      procedure WriteAcCValue4 (pValue:double);
    function  ReadAcCValue5:double;      procedure WriteAcCValue5 (pValue:double);
    function  ReadAcEValue1:double;      procedure WriteAcEValue1 (pValue:double);
    function  ReadAcEValue2:double;      procedure WriteAcEValue2 (pValue:double);
    function  ReadAcEValue3:double;      procedure WriteAcEValue3 (pValue:double);
    function  ReadAcEValue4:double;      procedure WriteAcEValue4 (pValue:double);
    function  ReadAcEValue5:double;      procedure WriteAcEValue5 (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPrvPay:double;       procedure WriteAcPrvPay (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcApyVal:double;       procedure WriteAcApyVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadAcAenVal:double;       procedure WriteAcAenVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadFgPrvPay:double;       procedure WriteFgPrvPay (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgApyVal:double;       procedure WriteFgApyVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgAenVal:double;       procedure WriteFgAenVal (pValue:double);
    function  ReadFgCValue1:double;      procedure WriteFgCValue1 (pValue:double);
    function  ReadFgCValue2:double;      procedure WriteFgCValue2 (pValue:double);
    function  ReadFgCValue3:double;      procedure WriteFgCValue3 (pValue:double);
    function  ReadFgCValue4:double;      procedure WriteFgCValue4 (pValue:double);
    function  ReadFgCValue5:double;      procedure WriteFgCValue5 (pValue:double);
    function  ReadFgEValue1:double;      procedure WriteFgEValue1 (pValue:double);
    function  ReadFgEValue2:double;      procedure WriteFgEValue2 (pValue:double);
    function  ReadFgEValue3:double;      procedure WriteFgEValue3 (pValue:double);
    function  ReadFgEValue4:double;      procedure WriteFgEValue4 (pValue:double);
    function  ReadFgEValue5:double;      procedure WriteFgEValue5 (pValue:double);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadExpDay:word;           procedure WriteExpDay (pValue:word);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadTsdNum:Str15;          procedure WriteTsdNum (pValue:Str15);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadDocSnt:Str3;           procedure WriteDocSnt (pValue:Str3);
    function  ReadDocAnl:Str6;           procedure WriteDocAnl (pValue:Str6);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadIodNum:Str12;          procedure WriteIodNum (pValue:Str12);
    function  ReadIoeNum:Str12;          procedure WriteIoeNum (pValue:Str12);
    function  ReadIncNum:Str20;          procedure WriteIncNum (pValue:Str20);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDnAsAa (pDocNum:Str12;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateAsDn (pAccSnt:Str3;pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateExpDay (pExpDay:word):boolean;
    function LocateIodNum (pIodNum:Str12):boolean;
    function LocateIncNum (pIncNum:Str20):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property VatDate:TDatetime read ReadVatDate write WriteVatDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property TaxDate:TDatetime read ReadTaxDate write WriteTaxDate;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property PmqDate:TDatetime read ReadPmqDate write WritePmqDate;
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
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcCValue1:double read ReadAcCValue1 write WriteAcCValue1;
    property AcCValue2:double read ReadAcCValue2 write WriteAcCValue2;
    property AcCValue3:double read ReadAcCValue3 write WriteAcCValue3;
    property AcCValue4:double read ReadAcCValue4 write WriteAcCValue4;
    property AcCValue5:double read ReadAcCValue5 write WriteAcCValue5;
    property AcEValue1:double read ReadAcEValue1 write WriteAcEValue1;
    property AcEValue2:double read ReadAcEValue2 write WriteAcEValue2;
    property AcEValue3:double read ReadAcEValue3 write WriteAcEValue3;
    property AcEValue4:double read ReadAcEValue4 write WriteAcEValue4;
    property AcEValue5:double read ReadAcEValue5 write WriteAcEValue5;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPrvPay:double read ReadAcPrvPay write WriteAcPrvPay;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcApyVal:double read ReadAcApyVal write WriteAcApyVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAenVal:double read ReadAcAenVal write WriteAcAenVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property FgPrvPay:double read ReadFgPrvPay write WriteFgPrvPay;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgApyVal:double read ReadFgApyVal write WriteFgApyVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgAenVal:double read ReadFgAenVal write WriteFgAenVal;
    property FgCValue1:double read ReadFgCValue1 write WriteFgCValue1;
    property FgCValue2:double read ReadFgCValue2 write WriteFgCValue2;
    property FgCValue3:double read ReadFgCValue3 write WriteFgCValue3;
    property FgCValue4:double read ReadFgCValue4 write WriteFgCValue4;
    property FgCValue5:double read ReadFgCValue5 write WriteFgCValue5;
    property FgEValue1:double read ReadFgEValue1 write WriteFgEValue1;
    property FgEValue2:double read ReadFgEValue2 write WriteFgEValue2;
    property FgEValue3:double read ReadFgEValue3 write WriteFgEValue3;
    property FgEValue4:double read ReadFgEValue4 write WriteFgEValue4;
    property FgEValue5:double read ReadFgEValue5 write WriteFgEValue5;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property ExpDay:word read ReadExpDay write WriteExpDay;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property TsdNum:Str15 read ReadTsdNum write WriteTsdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property DocSnt:Str3 read ReadDocSnt write WriteDocSnt;
    property DocAnl:Str6 read ReadDocAnl write WriteDocAnl;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property Sended:boolean read ReadSended write WriteSended;
    property IodNum:Str12 read ReadIodNum write WriteIodNum;
    property IoeNum:Str12 read ReadIoeNum write WriteIoeNum;
    property IncNum:Str20 read ReadIncNum write WriteIncNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIshTmp.Create;
begin
  oTmpTable := TmpInit ('ISH',Self);
end;

destructor TIshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIshTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIshTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIshTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIshTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIshTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIshTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIshTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TIshTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TIshTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TIshTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIshTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIshTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIshTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIshTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIshTmp.ReadSndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TIshTmp.WriteSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TIshTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TIshTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TIshTmp.ReadVatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TIshTmp.WriteVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TIshTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TIshTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TIshTmp.ReadTaxDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TaxDate').AsDateTime;
end;

procedure TIshTmp.WriteTaxDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TaxDate').AsDateTime := pValue;
end;

function TIshTmp.ReadAccDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AccDate').AsDateTime;
end;

procedure TIshTmp.WriteAccDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TIshTmp.ReadPmqDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PmqDate').AsDateTime;
end;

procedure TIshTmp.WritePmqDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PmqDate').AsDateTime := pValue;
end;

function TIshTmp.ReadCsyCode:Str4;
begin
  Result := oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TIshTmp.WriteCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString := pValue;
end;

function TIshTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIshTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIshTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIshTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIshTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIshTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIshTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TIshTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TIshTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TIshTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TIshTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TIshTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TIshTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TIshTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TIshTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TIshTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TIshTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TIshTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TIshTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TIshTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TIshTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TIshTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TIshTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TIshTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TIshTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TIshTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TIshTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TIshTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TIshTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TIshTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TIshTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TIshTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TIshTmp.ReadContoNum:Str30;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TIshTmp.WriteContoNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TIshTmp.ReadBankCode:Str15;
begin
  Result := oTmpTable.FieldByName('BankCode').AsString;
end;

procedure TIshTmp.WriteBankCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BankCode').AsString := pValue;
end;

function TIshTmp.ReadBankSeat:Str30;
begin
  Result := oTmpTable.FieldByName('BankSeat').AsString;
end;

procedure TIshTmp.WriteBankSeat(pValue:Str30);
begin
  oTmpTable.FieldByName('BankSeat').AsString := pValue;
end;

function TIshTmp.ReadIbanCode:Str34;
begin
  Result := oTmpTable.FieldByName('IbanCode').AsString;
end;

procedure TIshTmp.WriteIbanCode(pValue:Str34);
begin
  oTmpTable.FieldByName('IbanCode').AsString := pValue;
end;

function TIshTmp.ReadSwftCode:Str20;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TIshTmp.WriteSwftCode(pValue:Str20);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

function TIshTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TIshTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TIshTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TIshTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TIshTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TIshTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TIshTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TIshTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TIshTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TIshTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TIshTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TIshTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TIshTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TIshTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TIshTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TIshTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TIshTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TIshTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TIshTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TIshTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TIshTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIshTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TIshTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIshTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIshTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIshTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIshTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIshTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIshTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIshTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIshTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIshTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIshTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIshTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIshTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TIshTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TIshTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIshTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIshTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIshTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIshTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIshTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIshTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TIshTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue1:double;
begin
  Result := oTmpTable.FieldByName('AcCValue1').AsFloat;
end;

procedure TIshTmp.WriteAcCValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue1').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue2:double;
begin
  Result := oTmpTable.FieldByName('AcCValue2').AsFloat;
end;

procedure TIshTmp.WriteAcCValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue2').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue3:double;
begin
  Result := oTmpTable.FieldByName('AcCValue3').AsFloat;
end;

procedure TIshTmp.WriteAcCValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue3').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue4:double;
begin
  Result := oTmpTable.FieldByName('AcCValue4').AsFloat;
end;

procedure TIshTmp.WriteAcCValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue4').AsFloat := pValue;
end;

function TIshTmp.ReadAcCValue5:double;
begin
  Result := oTmpTable.FieldByName('AcCValue5').AsFloat;
end;

procedure TIshTmp.WriteAcCValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue5').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue1:double;
begin
  Result := oTmpTable.FieldByName('AcEValue1').AsFloat;
end;

procedure TIshTmp.WriteAcEValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue1').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue2:double;
begin
  Result := oTmpTable.FieldByName('AcEValue2').AsFloat;
end;

procedure TIshTmp.WriteAcEValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue2').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue3:double;
begin
  Result := oTmpTable.FieldByName('AcEValue3').AsFloat;
end;

procedure TIshTmp.WriteAcEValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue3').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue4:double;
begin
  Result := oTmpTable.FieldByName('AcEValue4').AsFloat;
end;

procedure TIshTmp.WriteAcEValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue4').AsFloat := pValue;
end;

function TIshTmp.ReadAcEValue5:double;
begin
  Result := oTmpTable.FieldByName('AcEValue5').AsFloat;
end;

procedure TIshTmp.WriteAcEValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue5').AsFloat := pValue;
end;

function TIshTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIshTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIshTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIshTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIshTmp.ReadAcPrvPay:double;
begin
  Result := oTmpTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TIshTmp.WriteAcPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('AcPrvPay').AsFloat := pValue;
end;

function TIshTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TIshTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TIshTmp.ReadAcApyVal:double;
begin
  Result := oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TIshTmp.WriteAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat := pValue;
end;

function TIshTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TIshTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TIshTmp.ReadAcAenVal:double;
begin
  Result := oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TIshTmp.WriteAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TIshTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TIshTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIshTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIshTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIshTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIshTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIshTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIshTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIshTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TIshTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TIshTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TIshTmp.ReadFgPrvPay:double;
begin
  Result := oTmpTable.FieldByName('FgPrvPay').AsFloat;
end;

procedure TIshTmp.WriteFgPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('FgPrvPay').AsFloat := pValue;
end;

function TIshTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIshTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgApyVal:double;
begin
  Result := oTmpTable.FieldByName('FgApyVal').AsFloat;
end;

procedure TIshTmp.WriteFgApyVal(pValue:double);
begin
  oTmpTable.FieldByName('FgApyVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgEndVal:double;
begin
  Result := oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TIshTmp.WriteFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgAenVal:double;
begin
  Result := oTmpTable.FieldByName('FgAenVal').AsFloat;
end;

procedure TIshTmp.WriteFgAenVal(pValue:double);
begin
  oTmpTable.FieldByName('FgAenVal').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue1:double;
begin
  Result := oTmpTable.FieldByName('FgCValue1').AsFloat;
end;

procedure TIshTmp.WriteFgCValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue1').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue2:double;
begin
  Result := oTmpTable.FieldByName('FgCValue2').AsFloat;
end;

procedure TIshTmp.WriteFgCValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue2').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue3:double;
begin
  Result := oTmpTable.FieldByName('FgCValue3').AsFloat;
end;

procedure TIshTmp.WriteFgCValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue3').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue4:double;
begin
  Result := oTmpTable.FieldByName('FgCValue4').AsFloat;
end;

procedure TIshTmp.WriteFgCValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue4').AsFloat := pValue;
end;

function TIshTmp.ReadFgCValue5:double;
begin
  Result := oTmpTable.FieldByName('FgCValue5').AsFloat;
end;

procedure TIshTmp.WriteFgCValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue5').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue1:double;
begin
  Result := oTmpTable.FieldByName('FgEValue1').AsFloat;
end;

procedure TIshTmp.WriteFgEValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue1').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue2:double;
begin
  Result := oTmpTable.FieldByName('FgEValue2').AsFloat;
end;

procedure TIshTmp.WriteFgEValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue2').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue3:double;
begin
  Result := oTmpTable.FieldByName('FgEValue3').AsFloat;
end;

procedure TIshTmp.WriteFgEValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue3').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue4:double;
begin
  Result := oTmpTable.FieldByName('FgEValue4').AsFloat;
end;

procedure TIshTmp.WriteFgEValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue4').AsFloat := pValue;
end;

function TIshTmp.ReadFgEValue5:double;
begin
  Result := oTmpTable.FieldByName('FgEValue5').AsFloat;
end;

procedure TIshTmp.WriteFgEValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue5').AsFloat := pValue;
end;

function TIshTmp.ReadEyCourse:double;
begin
  Result := oTmpTable.FieldByName('EyCourse').AsFloat;
end;

procedure TIshTmp.WriteEyCourse(pValue:double);
begin
  oTmpTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TIshTmp.ReadEyCrdVal:double;
begin
  Result := oTmpTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TIshTmp.WriteEyCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TIshTmp.ReadExpDay:word;
begin
  Result := oTmpTable.FieldByName('ExpDay').AsInteger;
end;

procedure TIshTmp.WriteExpDay(pValue:word);
begin
  oTmpTable.FieldByName('ExpDay').AsInteger := pValue;
end;

function TIshTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIshTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TIshTmp.ReadVatCls:byte;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TIshTmp.WriteVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TIshTmp.ReadDocSpc:byte;
begin
  Result := oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIshTmp.WriteDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIshTmp.ReadTsdNum:Str15;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TIshTmp.WriteTsdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TIshTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIshTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIshTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIshTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIshTmp.ReadDstPair:Str1;
begin
  Result := oTmpTable.FieldByName('DstPair').AsString;
end;

procedure TIshTmp.WriteDstPair(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPair').AsString := pValue;
end;

function TIshTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TIshTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIshTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TIshTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TIshTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TIshTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIshTmp.ReadDstLiq:Str1;
begin
  Result := oTmpTable.FieldByName('DstLiq').AsString;
end;

procedure TIshTmp.WriteDstLiq(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLiq').AsString := pValue;
end;

function TIshTmp.ReadDocSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TIshTmp.WriteDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString := pValue;
end;

function TIshTmp.ReadDocAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TIshTmp.WriteDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString := pValue;
end;

function TIshTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIshTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIshTmp.ReadWrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIshTmp.WriteWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIshTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TIshTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TIshTmp.ReadIodNum:Str12;
begin
  Result := oTmpTable.FieldByName('IodNum').AsString;
end;

procedure TIshTmp.WriteIodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IodNum').AsString := pValue;
end;

function TIshTmp.ReadIoeNum:Str12;
begin
  Result := oTmpTable.FieldByName('IoeNum').AsString;
end;

procedure TIshTmp.WriteIoeNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IoeNum').AsString := pValue;
end;

function TIshTmp.ReadIncNum:Str20;
begin
  Result := oTmpTable.FieldByName('IncNum').AsString;
end;

procedure TIshTmp.WriteIncNum(pValue:Str20);
begin
  oTmpTable.FieldByName('IncNum').AsString := pValue;
end;

function TIshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIshTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIshTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIshTmp.LocateDnAsAa (pDocNum:Str12;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixDnAsAa);
  Result := oTmpTable.FindKey([pDocNum,pAccSnt,pAccAnl]);
end;

function TIshTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TIshTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TIshTmp.LocateAsDn (pAccSnt:Str3;pDocNum:Str12):boolean;
begin
  SetIndex (ixAsDn);
  Result := oTmpTable.FindKey([pAccSnt,pDocNum]);
end;

function TIshTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TIshTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TIshTmp.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oTmpTable.FindKey([pExpDate]);
end;

function TIshTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TIshTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TIshTmp.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oTmpTable.FindKey([pAcEValue]);
end;

function TIshTmp.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oTmpTable.FindKey([pFgEValue]);
end;

function TIshTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TIshTmp.LocateExpDay (pExpDay:word):boolean;
begin
  SetIndex (ixExpDay);
  Result := oTmpTable.FindKey([pExpDay]);
end;

function TIshTmp.LocateIodNum (pIodNum:Str12):boolean;
begin
  SetIndex (ixIodNum);
  Result := oTmpTable.FindKey([pIodNum]);
end;

function TIshTmp.LocateIncNum (pIncNum:Str20):boolean;
begin
  SetIndex (ixIncNum);
  Result := oTmpTable.FindKey([pIncNum]);
end;

procedure TIshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIshTmp.First;
begin
  oTmpTable.First;
end;

procedure TIshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1806003}
