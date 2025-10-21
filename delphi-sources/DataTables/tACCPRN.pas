unit tACCPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixExtNum = 'ExtNum';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';

type
  TAccprnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
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
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPrvPay:double;       procedure WriteAcPrvPay (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcApyVal:double;       procedure WriteAcApyVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadAcAenVal:double;       procedure WriteAcAenVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadExpDay:word;           procedure WriteExpDay (pValue:word);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadTsdNum:Str15;          procedure WriteTsdNum (pValue:Str15);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadIodNum:Str12;          procedure WriteIodNum (pValue:Str12);
    function  ReadIoeNum:Str12;          procedure WriteIoeNum (pValue:Str12);
    function  ReadIncNum:Str20;          procedure WriteIncNum (pValue:Str20);
    function  ReadAccSnt1:Str3;          procedure WriteAccSnt1 (pValue:Str3);
    function  ReadAccAnl1:Str6;          procedure WriteAccAnl1 (pValue:Str6);
    function  ReadAccDes1:Str30;         procedure WriteAccDes1 (pValue:Str30);
    function  ReadCrdVal1:Str14;         procedure WriteCrdVal1 (pValue:Str14);
    function  ReadDebVal1:Str14;         procedure WriteDebVal1 (pValue:Str14);
    function  ReadAccSnt2:Str3;          procedure WriteAccSnt2 (pValue:Str3);
    function  ReadAccAnl2:Str6;          procedure WriteAccAnl2 (pValue:Str6);
    function  ReadAccDes2:Str30;         procedure WriteAccDes2 (pValue:Str30);
    function  ReadCrdVal2:Str14;         procedure WriteCrdVal2 (pValue:Str14);
    function  ReadDebVal2:Str14;         procedure WriteDebVal2 (pValue:Str14);
    function  ReadAccSnt3:Str3;          procedure WriteAccSnt3 (pValue:Str3);
    function  ReadAccAnl3:Str6;          procedure WriteAccAnl3 (pValue:Str6);
    function  ReadAccDes3:Str30;         procedure WriteAccDes3 (pValue:Str30);
    function  ReadCrdVal3:Str14;         procedure WriteCrdVal3 (pValue:Str14);
    function  ReadDebVal3:Str14;         procedure WriteDebVal3 (pValue:Str14);
    function  ReadAccSnt4:Str3;          procedure WriteAccSnt4 (pValue:Str3);
    function  ReadAccAnl4:Str6;          procedure WriteAccAnl4 (pValue:Str6);
    function  ReadAccDes4:Str30;         procedure WriteAccDes4 (pValue:Str30);
    function  ReadCrdVal4:Str14;         procedure WriteCrdVal4 (pValue:Str14);
    function  ReadDebVal4:Str14;         procedure WriteDebVal4 (pValue:Str14);
    function  ReadAccSnt5:Str3;          procedure WriteAccSnt5 (pValue:Str3);
    function  ReadAccAnl5:Str6;          procedure WriteAccAnl5 (pValue:Str6);
    function  ReadAccDes5:Str30;         procedure WriteAccDes5 (pValue:Str30);
    function  ReadCrdVal5:Str14;         procedure WriteCrdVal5 (pValue:Str14);
    function  ReadDebVal5:Str14;         procedure WriteDebVal5 (pValue:Str14);
    function  ReadAccSnt6:Str3;          procedure WriteAccSnt6 (pValue:Str3);
    function  ReadAccAnl6:Str6;          procedure WriteAccAnl6 (pValue:Str6);
    function  ReadAccDes6:Str30;         procedure WriteAccDes6 (pValue:Str30);
    function  ReadCrdVal6:Str14;         procedure WriteCrdVal6 (pValue:Str14);
    function  ReadDebVal6:Str14;         procedure WriteDebVal6 (pValue:Str14);
    function  ReadAccSnt7:Str3;          procedure WriteAccSnt7 (pValue:Str3);
    function  ReadAccAnl7:Str6;          procedure WriteAccAnl7 (pValue:Str6);
    function  ReadAccDes7:Str30;         procedure WriteAccDes7 (pValue:Str30);
    function  ReadCrdVal7:Str14;         procedure WriteCrdVal7 (pValue:Str14);
    function  ReadDebVal7:Str14;         procedure WriteDebVal7 (pValue:Str14);
    function  ReadAccSnt8:Str3;          procedure WriteAccSnt8 (pValue:Str3);
    function  ReadAccAnl8:Str6;          procedure WriteAccAnl8 (pValue:Str6);
    function  ReadAccDes8:Str30;         procedure WriteAccDes8 (pValue:Str30);
    function  ReadCrdVal8:Str14;         procedure WriteCrdVal8 (pValue:Str14);
    function  ReadDebVal8:Str14;         procedure WriteDebVal8 (pValue:Str14);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;

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
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPrvPay:double read ReadAcPrvPay write WriteAcPrvPay;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcApyVal:double read ReadAcApyVal write WriteAcApyVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAenVal:double read ReadAcAenVal write WriteAcAenVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property ExpDay:word read ReadExpDay write WriteExpDay;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property TsdNum:Str15 read ReadTsdNum write WriteTsdNum;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property Sended:boolean read ReadSended write WriteSended;
    property IodNum:Str12 read ReadIodNum write WriteIodNum;
    property IoeNum:Str12 read ReadIoeNum write WriteIoeNum;
    property IncNum:Str20 read ReadIncNum write WriteIncNum;
    property AccSnt1:Str3 read ReadAccSnt1 write WriteAccSnt1;
    property AccAnl1:Str6 read ReadAccAnl1 write WriteAccAnl1;
    property AccDes1:Str30 read ReadAccDes1 write WriteAccDes1;
    property CrdVal1:Str14 read ReadCrdVal1 write WriteCrdVal1;
    property DebVal1:Str14 read ReadDebVal1 write WriteDebVal1;
    property AccSnt2:Str3 read ReadAccSnt2 write WriteAccSnt2;
    property AccAnl2:Str6 read ReadAccAnl2 write WriteAccAnl2;
    property AccDes2:Str30 read ReadAccDes2 write WriteAccDes2;
    property CrdVal2:Str14 read ReadCrdVal2 write WriteCrdVal2;
    property DebVal2:Str14 read ReadDebVal2 write WriteDebVal2;
    property AccSnt3:Str3 read ReadAccSnt3 write WriteAccSnt3;
    property AccAnl3:Str6 read ReadAccAnl3 write WriteAccAnl3;
    property AccDes3:Str30 read ReadAccDes3 write WriteAccDes3;
    property CrdVal3:Str14 read ReadCrdVal3 write WriteCrdVal3;
    property DebVal3:Str14 read ReadDebVal3 write WriteDebVal3;
    property AccSnt4:Str3 read ReadAccSnt4 write WriteAccSnt4;
    property AccAnl4:Str6 read ReadAccAnl4 write WriteAccAnl4;
    property AccDes4:Str30 read ReadAccDes4 write WriteAccDes4;
    property CrdVal4:Str14 read ReadCrdVal4 write WriteCrdVal4;
    property DebVal4:Str14 read ReadDebVal4 write WriteDebVal4;
    property AccSnt5:Str3 read ReadAccSnt5 write WriteAccSnt5;
    property AccAnl5:Str6 read ReadAccAnl5 write WriteAccAnl5;
    property AccDes5:Str30 read ReadAccDes5 write WriteAccDes5;
    property CrdVal5:Str14 read ReadCrdVal5 write WriteCrdVal5;
    property DebVal5:Str14 read ReadDebVal5 write WriteDebVal5;
    property AccSnt6:Str3 read ReadAccSnt6 write WriteAccSnt6;
    property AccAnl6:Str6 read ReadAccAnl6 write WriteAccAnl6;
    property AccDes6:Str30 read ReadAccDes6 write WriteAccDes6;
    property CrdVal6:Str14 read ReadCrdVal6 write WriteCrdVal6;
    property DebVal6:Str14 read ReadDebVal6 write WriteDebVal6;
    property AccSnt7:Str3 read ReadAccSnt7 write WriteAccSnt7;
    property AccAnl7:Str6 read ReadAccAnl7 write WriteAccAnl7;
    property AccDes7:Str30 read ReadAccDes7 write WriteAccDes7;
    property CrdVal7:Str14 read ReadCrdVal7 write WriteCrdVal7;
    property DebVal7:Str14 read ReadDebVal7 write WriteDebVal7;
    property AccSnt8:Str3 read ReadAccSnt8 write WriteAccSnt8;
    property AccAnl8:Str6 read ReadAccAnl8 write WriteAccAnl8;
    property AccDes8:Str30 read ReadAccDes8 write WriteAccDes8;
    property CrdVal8:Str14 read ReadCrdVal8 write WriteCrdVal8;
    property DebVal8:Str14 read ReadDebVal8 write WriteDebVal8;
  end;

implementation

constructor TAccprnTmp.Create;
begin
  oTmpTable := TmpInit ('ACCPRN',Self);
end;

destructor TAccprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAccprnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAccprnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAccprnTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAccprnTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAccprnTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TAccprnTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAccprnTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TAccprnTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAccprnTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAccprnTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadSndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TAccprnTmp.WriteSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAccprnTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadVatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TAccprnTmp.WriteVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TAccprnTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadTaxDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TaxDate').AsDateTime;
end;

procedure TAccprnTmp.WriteTaxDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TaxDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadAccDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AccDate').AsDateTime;
end;

procedure TAccprnTmp.WriteAccDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadPmqDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PmqDate').AsDateTime;
end;

procedure TAccprnTmp.WritePmqDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PmqDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadCsyCode:Str4;
begin
  Result := oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TAccprnTmp.WriteCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString := pValue;
end;

function TAccprnTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TAccprnTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TAccprnTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAccprnTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TAccprnTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAccprnTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAccprnTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAccprnTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAccprnTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAccprnTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAccprnTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TAccprnTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TAccprnTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TAccprnTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TAccprnTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TAccprnTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TAccprnTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TAccprnTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TAccprnTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TAccprnTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAccprnTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TAccprnTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TAccprnTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TAccprnTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TAccprnTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TAccprnTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAccprnTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TAccprnTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TAccprnTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TAccprnTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TAccprnTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TAccprnTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TAccprnTmp.ReadContoNum:Str30;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TAccprnTmp.WriteContoNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TAccprnTmp.ReadBankCode:Str15;
begin
  Result := oTmpTable.FieldByName('BankCode').AsString;
end;

procedure TAccprnTmp.WriteBankCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BankCode').AsString := pValue;
end;

function TAccprnTmp.ReadBankSeat:Str30;
begin
  Result := oTmpTable.FieldByName('BankSeat').AsString;
end;

procedure TAccprnTmp.WriteBankSeat(pValue:Str30);
begin
  oTmpTable.FieldByName('BankSeat').AsString := pValue;
end;

function TAccprnTmp.ReadIbanCode:Str34;
begin
  Result := oTmpTable.FieldByName('IbanCode').AsString;
end;

procedure TAccprnTmp.WriteIbanCode(pValue:Str34);
begin
  oTmpTable.FieldByName('IbanCode').AsString := pValue;
end;

function TAccprnTmp.ReadSwftCode:Str20;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TAccprnTmp.WriteSwftCode(pValue:Str20);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

function TAccprnTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TAccprnTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TAccprnTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TAccprnTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TAccprnTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TAccprnTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TAccprnTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TAccprnTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TAccprnTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TAccprnTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TAccprnTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TAccprnTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TAccprnTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TAccprnTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TAccprnTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TAccprnTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TAccprnTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TAccprnTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TAccprnTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TAccprnTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TAccprnTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TAccprnTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TAccprnTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAccprnTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TAccprnTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TAccprnTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TAccprnTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TAccprnTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TAccprnTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TAccprnTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TAccprnTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcPrvPay:double;
begin
  Result := oTmpTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TAccprnTmp.WriteAcPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('AcPrvPay').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcApyVal:double;
begin
  Result := oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadAcAenVal:double;
begin
  Result := oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TAccprnTmp.WriteAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat := pValue;
end;

function TAccprnTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TAccprnTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TAccprnTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TAccprnTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TAccprnTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TAccprnTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TAccprnTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TAccprnTmp.ReadExpDay:word;
begin
  Result := oTmpTable.FieldByName('ExpDay').AsInteger;
end;

procedure TAccprnTmp.WriteExpDay(pValue:word);
begin
  oTmpTable.FieldByName('ExpDay').AsInteger := pValue;
end;

function TAccprnTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TAccprnTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TAccprnTmp.ReadVatCls:byte;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TAccprnTmp.WriteVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TAccprnTmp.ReadDocSpc:byte;
begin
  Result := oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TAccprnTmp.WriteDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TAccprnTmp.ReadTsdNum:Str15;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TAccprnTmp.WriteTsdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TAccprnTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAccprnTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAccprnTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAccprnTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAccprnTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TAccprnTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TAccprnTmp.ReadDstLiq:Str1;
begin
  Result := oTmpTable.FieldByName('DstLiq').AsString;
end;

procedure TAccprnTmp.WriteDstLiq(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLiq').AsString := pValue;
end;

function TAccprnTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TAccprnTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TAccprnTmp.ReadWrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TAccprnTmp.WriteWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TAccprnTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TAccprnTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TAccprnTmp.ReadIodNum:Str12;
begin
  Result := oTmpTable.FieldByName('IodNum').AsString;
end;

procedure TAccprnTmp.WriteIodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IodNum').AsString := pValue;
end;

function TAccprnTmp.ReadIoeNum:Str12;
begin
  Result := oTmpTable.FieldByName('IoeNum').AsString;
end;

procedure TAccprnTmp.WriteIoeNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IoeNum').AsString := pValue;
end;

function TAccprnTmp.ReadIncNum:Str20;
begin
  Result := oTmpTable.FieldByName('IncNum').AsString;
end;

procedure TAccprnTmp.WriteIncNum(pValue:Str20);
begin
  oTmpTable.FieldByName('IncNum').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt1:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt1').AsString;
end;

procedure TAccprnTmp.WriteAccSnt1(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt1').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl1:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl1').AsString;
end;

procedure TAccprnTmp.WriteAccAnl1(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl1').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes1:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes1').AsString;
end;

procedure TAccprnTmp.WriteAccDes1(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes1').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal1:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal1').AsString;
end;

procedure TAccprnTmp.WriteCrdVal1(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal1').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal1:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal1').AsString;
end;

procedure TAccprnTmp.WriteDebVal1(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal1').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt2:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt2').AsString;
end;

procedure TAccprnTmp.WriteAccSnt2(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt2').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl2:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl2').AsString;
end;

procedure TAccprnTmp.WriteAccAnl2(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl2').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes2:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes2').AsString;
end;

procedure TAccprnTmp.WriteAccDes2(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes2').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal2:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal2').AsString;
end;

procedure TAccprnTmp.WriteCrdVal2(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal2').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal2:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal2').AsString;
end;

procedure TAccprnTmp.WriteDebVal2(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal2').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt3:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt3').AsString;
end;

procedure TAccprnTmp.WriteAccSnt3(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt3').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl3:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl3').AsString;
end;

procedure TAccprnTmp.WriteAccAnl3(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl3').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes3:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes3').AsString;
end;

procedure TAccprnTmp.WriteAccDes3(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes3').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal3:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal3').AsString;
end;

procedure TAccprnTmp.WriteCrdVal3(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal3').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal3:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal3').AsString;
end;

procedure TAccprnTmp.WriteDebVal3(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal3').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt4:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt4').AsString;
end;

procedure TAccprnTmp.WriteAccSnt4(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt4').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl4:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl4').AsString;
end;

procedure TAccprnTmp.WriteAccAnl4(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl4').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes4:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes4').AsString;
end;

procedure TAccprnTmp.WriteAccDes4(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes4').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal4:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal4').AsString;
end;

procedure TAccprnTmp.WriteCrdVal4(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal4').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal4:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal4').AsString;
end;

procedure TAccprnTmp.WriteDebVal4(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal4').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt5:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt5').AsString;
end;

procedure TAccprnTmp.WriteAccSnt5(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt5').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl5:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl5').AsString;
end;

procedure TAccprnTmp.WriteAccAnl5(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl5').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes5:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes5').AsString;
end;

procedure TAccprnTmp.WriteAccDes5(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes5').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal5:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal5').AsString;
end;

procedure TAccprnTmp.WriteCrdVal5(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal5').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal5:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal5').AsString;
end;

procedure TAccprnTmp.WriteDebVal5(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal5').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt6:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt6').AsString;
end;

procedure TAccprnTmp.WriteAccSnt6(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt6').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl6:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl6').AsString;
end;

procedure TAccprnTmp.WriteAccAnl6(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl6').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes6:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes6').AsString;
end;

procedure TAccprnTmp.WriteAccDes6(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes6').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal6:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal6').AsString;
end;

procedure TAccprnTmp.WriteCrdVal6(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal6').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal6:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal6').AsString;
end;

procedure TAccprnTmp.WriteDebVal6(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal6').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt7:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt7').AsString;
end;

procedure TAccprnTmp.WriteAccSnt7(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt7').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl7:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl7').AsString;
end;

procedure TAccprnTmp.WriteAccAnl7(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl7').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes7:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes7').AsString;
end;

procedure TAccprnTmp.WriteAccDes7(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes7').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal7:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal7').AsString;
end;

procedure TAccprnTmp.WriteCrdVal7(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal7').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal7:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal7').AsString;
end;

procedure TAccprnTmp.WriteDebVal7(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal7').AsString := pValue;
end;

function TAccprnTmp.ReadAccSnt8:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt8').AsString;
end;

procedure TAccprnTmp.WriteAccSnt8(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt8').AsString := pValue;
end;

function TAccprnTmp.ReadAccAnl8:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl8').AsString;
end;

procedure TAccprnTmp.WriteAccAnl8(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl8').AsString := pValue;
end;

function TAccprnTmp.ReadAccDes8:Str30;
begin
  Result := oTmpTable.FieldByName('AccDes8').AsString;
end;

procedure TAccprnTmp.WriteAccDes8(pValue:Str30);
begin
  oTmpTable.FieldByName('AccDes8').AsString := pValue;
end;

function TAccprnTmp.ReadCrdVal8:Str14;
begin
  Result := oTmpTable.FieldByName('CrdVal8').AsString;
end;

procedure TAccprnTmp.WriteCrdVal8(pValue:Str14);
begin
  oTmpTable.FieldByName('CrdVal8').AsString := pValue;
end;

function TAccprnTmp.ReadDebVal8:Str14;
begin
  Result := oTmpTable.FieldByName('DebVal8').AsString;
end;

procedure TAccprnTmp.WriteDebVal8(pValue:Str14);
begin
  oTmpTable.FieldByName('DebVal8').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccprnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAccprnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAccprnTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAccprnTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TAccprnTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TAccprnTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TAccprnTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TAccprnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAccprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAccprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAccprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAccprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAccprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TAccprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAccprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAccprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAccprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAccprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAccprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAccprnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAccprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAccprnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAccprnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAccprnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1927001}
