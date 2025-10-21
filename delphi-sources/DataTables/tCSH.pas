unit tCSH;

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
  ixDtDc = 'DtDc';
  ixPaName_ = 'PaName_';
  ixPyBValue = 'PyBValue';
  ixPyIncVal = 'PyIncVal';
  ixPyExpVal = 'PyExpVal';
  ixDocDate = 'DocDate';
  ixDstAcc = 'DstAcc';
  ixYearSerNum = 'YearSerNum';

type
  TCshTmp = class (TComponent)
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
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcBValue1:double;      procedure WriteAcBValue1 (pValue:double);
    function  ReadAcBValue2:double;      procedure WriteAcBValue2 (pValue:double);
    function  ReadAcBValue3:double;      procedure WriteAcBValue3 (pValue:double);
    function  ReadAcBValue4:double;      procedure WriteAcBValue4 (pValue:double);
    function  ReadAcBValue5:double;      procedure WriteAcBValue5 (pValue:double);
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
    function  ReadPyVatVal1:double;      procedure WritePyVatVal1 (pValue:double);
    function  ReadPyVatVal2:double;      procedure WritePyVatVal2 (pValue:double);
    function  ReadPyVatVal3:double;      procedure WritePyVatVal3 (pValue:double);
    function  ReadPyBValue1:double;      procedure WritePyBValue1 (pValue:double);
    function  ReadPyBValue2:double;      procedure WritePyBValue2 (pValue:double);
    function  ReadPyBValue3:double;      procedure WritePyBValue3 (pValue:double);
    function  ReadPyDuoInf:Str100;       procedure WritePyDuoInf (pValue:Str100);
    function  ReadTxtVal:Str80;          procedure WriteTxtVal (pValue:Str80);
    function  ReadDrvCode:word;          procedure WriteDrvCode (pValue:word);
    function  ReadDrvName:Str30;         procedure WriteDrvName (pValue:Str30);
    function  ReadCarMark:Str10;         procedure WriteCarMark (pValue:Str10);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDocSpc:byte;           procedure WriteDocSpc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadExcCosVal:double;      procedure WriteExcCosVal (pValue:double);
    function  ReadExcVatVal:double;      procedure WriteExcVatVal (pValue:double);
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
    function LocateDtDc (pDocType:Str1;pDocCnt:word):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocatePyBValue (pPyBValue:double):boolean;
    function LocatePyIncVal (pPyIncVal:double):boolean;
    function LocatePyExpVal (pPyExpVal:double):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;

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
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcBValue1:double read ReadAcBValue1 write WriteAcBValue1;
    property AcBValue2:double read ReadAcBValue2 write WriteAcBValue2;
    property AcBValue3:double read ReadAcBValue3 write WriteAcBValue3;
    property AcBValue4:double read ReadAcBValue4 write WriteAcBValue4;
    property AcBValue5:double read ReadAcBValue5 write WriteAcBValue5;
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
    property PyVatVal1:double read ReadPyVatVal1 write WritePyVatVal1;
    property PyVatVal2:double read ReadPyVatVal2 write WritePyVatVal2;
    property PyVatVal3:double read ReadPyVatVal3 write WritePyVatVal3;
    property PyBValue1:double read ReadPyBValue1 write WritePyBValue1;
    property PyBValue2:double read ReadPyBValue2 write WritePyBValue2;
    property PyBValue3:double read ReadPyBValue3 write WritePyBValue3;
    property PyDuoInf:Str100 read ReadPyDuoInf write WritePyDuoInf;
    property TxtVal:Str80 read ReadTxtVal write WriteTxtVal;
    property DrvCode:word read ReadDrvCode write WriteDrvCode;
    property DrvName:Str30 read ReadDrvName write WriteDrvName;
    property CarMark:Str10 read ReadCarMark write WriteCarMark;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DocSpc:byte read ReadDocSpc write WriteDocSpc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property Sended:boolean read ReadSended write WriteSended;
    property ExcCosVal:double read ReadExcCosVal write WriteExcCosVal;
    property ExcVatVal:double read ReadExcVatVal write WriteExcVatVal;
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

constructor TCshTmp.Create;
begin
  oTmpTable := TmpInit ('CSH',Self);
end;

destructor TCshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCshTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCshTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCshTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TCshTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TCshTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TCshTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TCshTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TCshTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TCshTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TCshTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCshTmp.ReadDocCnt:word;
begin
  Result := oTmpTable.FieldByName('DocCnt').AsInteger;
end;

procedure TCshTmp.WriteDocCnt(pValue:word);
begin
  oTmpTable.FieldByName('DocCnt').AsInteger := pValue;
end;

function TCshTmp.ReadDocType:Str1;
begin
  Result := oTmpTable.FieldByName('DocType').AsString;
end;

procedure TCshTmp.WriteDocType(pValue:Str1);
begin
  oTmpTable.FieldByName('DocType').AsString := pValue;
end;

function TCshTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCshTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCshTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TCshTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCshTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCshTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCshTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCshTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TCshTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TCshTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TCshTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TCshTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TCshTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TCshTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TCshTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TCshTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TCshTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TCshTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TCshTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TCshTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TCshTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TCshTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TCshTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TCshTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TCshTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TCshTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TCshTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TCshTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TCshTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TCshTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TCshTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TCshTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TCshTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TCshTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TCshTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TCshTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TCshTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TCshTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TCshTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TCshTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TCshTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TCshTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TCshTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TCshTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TCshTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TCshTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TCshTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TCshTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TCshTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TCshTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TCshTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TCshTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TCshTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TCshTmp.ReadAcAValue4:double;
begin
  Result := oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TCshTmp.WriteAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TCshTmp.ReadAcAValue5:double;
begin
  Result := oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TCshTmp.WriteAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue1:double;
begin
  Result := oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TCshTmp.WriteAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue2:double;
begin
  Result := oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TCshTmp.WriteAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue3:double;
begin
  Result := oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TCshTmp.WriteAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue4:double;
begin
  Result := oTmpTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TCshTmp.WriteAcBValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TCshTmp.ReadAcBValue5:double;
begin
  Result := oTmpTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TCshTmp.WriteAcBValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TCshTmp.ReadPyDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('PyDvzName').AsString;
end;

procedure TCshTmp.WritePyDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TCshTmp.ReadPyCourse:double;
begin
  Result := oTmpTable.FieldByName('PyCourse').AsFloat;
end;

procedure TCshTmp.WritePyCourse(pValue:double);
begin
  oTmpTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TCshTmp.ReadPyAValue:double;
begin
  Result := oTmpTable.FieldByName('PyAValue').AsFloat;
end;

procedure TCshTmp.WritePyAValue(pValue:double);
begin
  oTmpTable.FieldByName('PyAValue').AsFloat := pValue;
end;

function TCshTmp.ReadPyVatVal:double;
begin
  Result := oTmpTable.FieldByName('PyVatVal').AsFloat;
end;

procedure TCshTmp.WritePyVatVal(pValue:double);
begin
  oTmpTable.FieldByName('PyVatVal').AsFloat := pValue;
end;

function TCshTmp.ReadPyBValue:double;
begin
  Result := oTmpTable.FieldByName('PyBValue').AsFloat;
end;

procedure TCshTmp.WritePyBValue(pValue:double);
begin
  oTmpTable.FieldByName('PyBValue').AsFloat := pValue;
end;

function TCshTmp.ReadPyBegVal:double;
begin
  Result := oTmpTable.FieldByName('PyBegVal').AsFloat;
end;

procedure TCshTmp.WritePyBegVal(pValue:double);
begin
  oTmpTable.FieldByName('PyBegVal').AsFloat := pValue;
end;

function TCshTmp.ReadPyIncVal:double;
begin
  Result := oTmpTable.FieldByName('PyIncVal').AsFloat;
end;

procedure TCshTmp.WritePyIncVal(pValue:double);
begin
  oTmpTable.FieldByName('PyIncVal').AsFloat := pValue;
end;

function TCshTmp.ReadPyExpVal:double;
begin
  Result := oTmpTable.FieldByName('PyExpVal').AsFloat;
end;

procedure TCshTmp.WritePyExpVal(pValue:double);
begin
  oTmpTable.FieldByName('PyExpVal').AsFloat := pValue;
end;

function TCshTmp.ReadPyEndVal:double;
begin
  Result := oTmpTable.FieldByName('PyEndVal').AsFloat;
end;

procedure TCshTmp.WritePyEndVal(pValue:double);
begin
  oTmpTable.FieldByName('PyEndVal').AsFloat := pValue;
end;

function TCshTmp.ReadPyAValue1:double;
begin
  Result := oTmpTable.FieldByName('PyAValue1').AsFloat;
end;

procedure TCshTmp.WritePyAValue1(pValue:double);
begin
  oTmpTable.FieldByName('PyAValue1').AsFloat := pValue;
end;

function TCshTmp.ReadPyAValue2:double;
begin
  Result := oTmpTable.FieldByName('PyAValue2').AsFloat;
end;

procedure TCshTmp.WritePyAValue2(pValue:double);
begin
  oTmpTable.FieldByName('PyAValue2').AsFloat := pValue;
end;

function TCshTmp.ReadPyAValue3:double;
begin
  Result := oTmpTable.FieldByName('PyAValue3').AsFloat;
end;

procedure TCshTmp.WritePyAValue3(pValue:double);
begin
  oTmpTable.FieldByName('PyAValue3').AsFloat := pValue;
end;

function TCshTmp.ReadPyVatVal1:double;
begin
  Result := oTmpTable.FieldByName('PyVatVal1').AsFloat;
end;

procedure TCshTmp.WritePyVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('PyVatVal1').AsFloat := pValue;
end;

function TCshTmp.ReadPyVatVal2:double;
begin
  Result := oTmpTable.FieldByName('PyVatVal2').AsFloat;
end;

procedure TCshTmp.WritePyVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('PyVatVal2').AsFloat := pValue;
end;

function TCshTmp.ReadPyVatVal3:double;
begin
  Result := oTmpTable.FieldByName('PyVatVal3').AsFloat;
end;

procedure TCshTmp.WritePyVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('PyVatVal3').AsFloat := pValue;
end;

function TCshTmp.ReadPyBValue1:double;
begin
  Result := oTmpTable.FieldByName('PyBValue1').AsFloat;
end;

procedure TCshTmp.WritePyBValue1(pValue:double);
begin
  oTmpTable.FieldByName('PyBValue1').AsFloat := pValue;
end;

function TCshTmp.ReadPyBValue2:double;
begin
  Result := oTmpTable.FieldByName('PyBValue2').AsFloat;
end;

procedure TCshTmp.WritePyBValue2(pValue:double);
begin
  oTmpTable.FieldByName('PyBValue2').AsFloat := pValue;
end;

function TCshTmp.ReadPyBValue3:double;
begin
  Result := oTmpTable.FieldByName('PyBValue3').AsFloat;
end;

procedure TCshTmp.WritePyBValue3(pValue:double);
begin
  oTmpTable.FieldByName('PyBValue3').AsFloat := pValue;
end;

function TCshTmp.ReadPyDuoInf:Str100;
begin
  Result := oTmpTable.FieldByName('PyDuoInf').AsString;
end;

procedure TCshTmp.WritePyDuoInf(pValue:Str100);
begin
  oTmpTable.FieldByName('PyDuoInf').AsString := pValue;
end;

function TCshTmp.ReadTxtVal:Str80;
begin
  Result := oTmpTable.FieldByName('TxtVal').AsString;
end;

procedure TCshTmp.WriteTxtVal(pValue:Str80);
begin
  oTmpTable.FieldByName('TxtVal').AsString := pValue;
end;

function TCshTmp.ReadDrvCode:word;
begin
  Result := oTmpTable.FieldByName('DrvCode').AsInteger;
end;

procedure TCshTmp.WriteDrvCode(pValue:word);
begin
  oTmpTable.FieldByName('DrvCode').AsInteger := pValue;
end;

function TCshTmp.ReadDrvName:Str30;
begin
  Result := oTmpTable.FieldByName('DrvName').AsString;
end;

procedure TCshTmp.WriteDrvName(pValue:Str30);
begin
  oTmpTable.FieldByName('DrvName').AsString := pValue;
end;

function TCshTmp.ReadCarMark:Str10;
begin
  Result := oTmpTable.FieldByName('CarMark').AsString;
end;

procedure TCshTmp.WriteCarMark(pValue:Str10);
begin
  oTmpTable.FieldByName('CarMark').AsString := pValue;
end;

function TCshTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TCshTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TCshTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCshTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCshTmp.ReadDocSpc:byte;
begin
  Result := oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TCshTmp.WriteDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TCshTmp.ReadVatCls:byte;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TCshTmp.WriteVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TCshTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TCshTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TCshTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TCshTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TCshTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TCshTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCshTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TCshTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCshTmp.ReadExcCosVal:double;
begin
  Result := oTmpTable.FieldByName('ExcCosVal').AsFloat;
end;

procedure TCshTmp.WriteExcCosVal(pValue:double);
begin
  oTmpTable.FieldByName('ExcCosVal').AsFloat := pValue;
end;

function TCshTmp.ReadExcVatVal:double;
begin
  Result := oTmpTable.FieldByName('ExcVatVal').AsFloat;
end;

procedure TCshTmp.WriteExcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('ExcVatVal').AsFloat := pValue;
end;

function TCshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCshTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TCshTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TCshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TCshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TCshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCshTmp.LocateDnAsAa (pDocNum:Str12;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixDnAsAa);
  Result := oTmpTable.FindKey([pDocNum,pAccSnt,pAccAnl]);
end;

function TCshTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TCshTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TCshTmp.LocateAsDn (pAccSnt:Str3;pDocNum:Str12):boolean;
begin
  SetIndex (ixAsDn);
  Result := oTmpTable.FindKey([pAccSnt,pDocNum]);
end;

function TCshTmp.LocateDtDc (pDocType:Str1;pDocCnt:word):boolean;
begin
  SetIndex (ixDtDc);
  Result := oTmpTable.FindKey([pDocType,pDocCnt]);
end;

function TCshTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TCshTmp.LocatePyBValue (pPyBValue:double):boolean;
begin
  SetIndex (ixPyBValue);
  Result := oTmpTable.FindKey([pPyBValue]);
end;

function TCshTmp.LocatePyIncVal (pPyIncVal:double):boolean;
begin
  SetIndex (ixPyIncVal);
  Result := oTmpTable.FindKey([pPyIncVal]);
end;

function TCshTmp.LocatePyExpVal (pPyExpVal:double):boolean;
begin
  SetIndex (ixPyExpVal);
  Result := oTmpTable.FindKey([pPyExpVal]);
end;

function TCshTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TCshTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TCshTmp.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oTmpTable.FindKey([pYear,pSerNum]);
end;

procedure TCshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCshTmp.First;
begin
  oTmpTable.First;
end;

procedure TCshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
