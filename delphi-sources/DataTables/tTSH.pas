unit tTSH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixStkNum = 'StkNum';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixDstAcc = 'DstAcc';
  ixSndStat = 'SndStat';
  ixDstCor = 'DstCor';
  ixOcdNum = 'OcdNum';
  ixRbaCode = 'RbaCode';

type
  TTshTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
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
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
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
    function  ReadAcCValue4:double;      procedure WriteAcCValue4 (pValue:double);
    function  ReadAcCValue5:double;      procedure WriteAcCValue5 (pValue:double);
    function  ReadAcEValue1:double;      procedure WriteAcEValue1 (pValue:double);
    function  ReadAcEValue2:double;      procedure WriteAcEValue2 (pValue:double);
    function  ReadAcEValue3:double;      procedure WriteAcEValue3 (pValue:double);
    function  ReadAcEValue4:double;      procedure WriteAcEValue4 (pValue:double);
    function  ReadAcEValue5:double;      procedure WriteAcEValue5 (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadImCValue:double;       procedure WriteImCValue (pValue:double);
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
    function  ReadFgCValue4:double;      procedure WriteFgCValue4 (pValue:double);
    function  ReadFgCValue5:double;      procedure WriteFgCValue5 (pValue:double);
    function  ReadFgEValue1:double;      procedure WriteFgEValue1 (pValue:double);
    function  ReadFgEValue2:double;      procedure WriteFgEValue2 (pValue:double);
    function  ReadFgEValue3:double;      procedure WriteFgEValue3 (pValue:double);
    function  ReadFgEValue4:double;      procedure WriteFgEValue4 (pValue:double);
    function  ReadFgEValue5:double;      procedure WriteFgEValue5 (pValue:double);
    function  ReadFgCsdVal1:double;      procedure WriteFgCsdVal1 (pValue:double);
    function  ReadFgCsdVal2:double;      procedure WriteFgCsdVal2 (pValue:double);
    function  ReadFgCsdVal3:double;      procedure WriteFgCsdVal3 (pValue:double);
    function  ReadFgCsdVal4:double;      procedure WriteFgCsdVal4 (pValue:double);
    function  ReadFgCsdVal5:double;      procedure WriteFgCsdVal5 (pValue:double);
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
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadPkdNum:Str12;          procedure WritePkdNum (pValue:Str12);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadDstCor:Str1;           procedure WriteDstCor (pValue:Str1);
    function  ReadDstLiq:Str1;           procedure WriteDstLiq (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str8;          procedure WriteCAccAnl (pValue:Str8);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str8;          procedure WriteDAccAnl (pValue:Str8);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSndStat (pSndStat:Str1):boolean;
    function LocateDstCor (pDstCor:Str1):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
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
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
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
    property AcCValue4:double read ReadAcCValue4 write WriteAcCValue4;
    property AcCValue5:double read ReadAcCValue5 write WriteAcCValue5;
    property AcEValue1:double read ReadAcEValue1 write WriteAcEValue1;
    property AcEValue2:double read ReadAcEValue2 write WriteAcEValue2;
    property AcEValue3:double read ReadAcEValue3 write WriteAcEValue3;
    property AcEValue4:double read ReadAcEValue4 write WriteAcEValue4;
    property AcEValue5:double read ReadAcEValue5 write WriteAcEValue5;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property ImCValue:double read ReadImCValue write WriteImCValue;
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
    property FgCValue4:double read ReadFgCValue4 write WriteFgCValue4;
    property FgCValue5:double read ReadFgCValue5 write WriteFgCValue5;
    property FgEValue1:double read ReadFgEValue1 write WriteFgEValue1;
    property FgEValue2:double read ReadFgEValue2 write WriteFgEValue2;
    property FgEValue3:double read ReadFgEValue3 write WriteFgEValue3;
    property FgEValue4:double read ReadFgEValue4 write WriteFgEValue4;
    property FgEValue5:double read ReadFgEValue5 write WriteFgEValue5;
    property FgCsdVal1:double read ReadFgCsdVal1 write WriteFgCsdVal1;
    property FgCsdVal2:double read ReadFgCsdVal2 write WriteFgCsdVal2;
    property FgCsdVal3:double read ReadFgCsdVal3 write WriteFgCsdVal3;
    property FgCsdVal4:double read ReadFgCsdVal4 write WriteFgCsdVal4;
    property FgCsdVal5:double read ReadFgCsdVal5 write WriteFgCsdVal5;
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
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property PkdNum:Str12 read ReadPkdNum write WritePkdNum;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property DstCor:Str1 read ReadDstCor write WriteDstCor;
    property DstLiq:Str1 read ReadDstLiq write WriteDstLiq;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str8 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str8 read ReadDAccAnl write WriteDAccAnl;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property Sended:boolean read ReadSended write WriteSended;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
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

constructor TTshTmp.Create;
begin
  oTmpTable := TmpInit ('TSH',Self);
end;

destructor TTshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTshTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTshTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TTshTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TTshTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TTshTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TTshTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTshTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TTshTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTshTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTshTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTshTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTshTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTshTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TTshTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTshTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TTshTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TTshTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TTshTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TTshTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TTshTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TTshTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TTshTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TTshTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TTshTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TTshTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TTshTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TTshTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TTshTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TTshTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TTshTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TTshTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TTshTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TTshTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TTshTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TTshTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TTshTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TTshTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TTshTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TTshTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TTshTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TTshTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TTshTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TTshTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TTshTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TTshTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TTshTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TTshTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TTshTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TTshTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TTshTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TTshTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TTshTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TTshTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TTshTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TTshTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TTshTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TTshTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TTshTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TTshTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTshTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTshTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTshTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTshTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TTshTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TTshTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TTshTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TTshTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TTshTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TTshTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TTshTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TTshTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TTshTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TTshTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TTshTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TTshTmp.ReadAcZValue:double;
begin
  Result := oTmpTable.FieldByName('AcZValue').AsFloat;
end;

procedure TTshTmp.WriteAcZValue(pValue:double);
begin
  oTmpTable.FieldByName('AcZValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcTValue:double;
begin
  Result := oTmpTable.FieldByName('AcTValue').AsFloat;
end;

procedure TTshTmp.WriteAcTValue(pValue:double);
begin
  oTmpTable.FieldByName('AcTValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcOValue:double;
begin
  Result := oTmpTable.FieldByName('AcOValue').AsFloat;
end;

procedure TTshTmp.WriteAcOValue(pValue:double);
begin
  oTmpTable.FieldByName('AcOValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcSValue:double;
begin
  Result := oTmpTable.FieldByName('AcSValue').AsFloat;
end;

procedure TTshTmp.WriteAcSValue(pValue:double);
begin
  oTmpTable.FieldByName('AcSValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTshTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTshTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTshTmp.ReadAcRndVal:double;
begin
  Result := oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTshTmp.WriteAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTshTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TTshTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TTshTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue1:double;
begin
  Result := oTmpTable.FieldByName('AcCValue1').AsFloat;
end;

procedure TTshTmp.WriteAcCValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue1').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue2:double;
begin
  Result := oTmpTable.FieldByName('AcCValue2').AsFloat;
end;

procedure TTshTmp.WriteAcCValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue2').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue3:double;
begin
  Result := oTmpTable.FieldByName('AcCValue3').AsFloat;
end;

procedure TTshTmp.WriteAcCValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue3').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue4:double;
begin
  Result := oTmpTable.FieldByName('AcCValue4').AsFloat;
end;

procedure TTshTmp.WriteAcCValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue4').AsFloat := pValue;
end;

function TTshTmp.ReadAcCValue5:double;
begin
  Result := oTmpTable.FieldByName('AcCValue5').AsFloat;
end;

procedure TTshTmp.WriteAcCValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue5').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue1:double;
begin
  Result := oTmpTable.FieldByName('AcEValue1').AsFloat;
end;

procedure TTshTmp.WriteAcEValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue1').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue2:double;
begin
  Result := oTmpTable.FieldByName('AcEValue2').AsFloat;
end;

procedure TTshTmp.WriteAcEValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue2').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue3:double;
begin
  Result := oTmpTable.FieldByName('AcEValue3').AsFloat;
end;

procedure TTshTmp.WriteAcEValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue3').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue4:double;
begin
  Result := oTmpTable.FieldByName('AcEValue4').AsFloat;
end;

procedure TTshTmp.WriteAcEValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue4').AsFloat := pValue;
end;

function TTshTmp.ReadAcEValue5:double;
begin
  Result := oTmpTable.FieldByName('AcEValue5').AsFloat;
end;

procedure TTshTmp.WriteAcEValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue5').AsFloat := pValue;
end;

function TTshTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTshTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTshTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTshTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTshTmp.ReadImCValue:double;
begin
  Result := oTmpTable.FieldByName('ImCValue').AsFloat;
end;

procedure TTshTmp.WriteImCValue(pValue:double);
begin
  oTmpTable.FieldByName('ImCValue').AsFloat := pValue;
end;

function TTshTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TTshTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TTshTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TTshTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TTshTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTshTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTshTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTshTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTshTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTshTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTshTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTshTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TTshTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TTshTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue1:double;
begin
  Result := oTmpTable.FieldByName('FgCValue1').AsFloat;
end;

procedure TTshTmp.WriteFgCValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue1').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue2:double;
begin
  Result := oTmpTable.FieldByName('FgCValue2').AsFloat;
end;

procedure TTshTmp.WriteFgCValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue2').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue3:double;
begin
  Result := oTmpTable.FieldByName('FgCValue3').AsFloat;
end;

procedure TTshTmp.WriteFgCValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue3').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue4:double;
begin
  Result := oTmpTable.FieldByName('FgCValue4').AsFloat;
end;

procedure TTshTmp.WriteFgCValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue4').AsFloat := pValue;
end;

function TTshTmp.ReadFgCValue5:double;
begin
  Result := oTmpTable.FieldByName('FgCValue5').AsFloat;
end;

procedure TTshTmp.WriteFgCValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue5').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue1:double;
begin
  Result := oTmpTable.FieldByName('FgEValue1').AsFloat;
end;

procedure TTshTmp.WriteFgEValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue1').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue2:double;
begin
  Result := oTmpTable.FieldByName('FgEValue2').AsFloat;
end;

procedure TTshTmp.WriteFgEValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue2').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue3:double;
begin
  Result := oTmpTable.FieldByName('FgEValue3').AsFloat;
end;

procedure TTshTmp.WriteFgEValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue3').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue4:double;
begin
  Result := oTmpTable.FieldByName('FgEValue4').AsFloat;
end;

procedure TTshTmp.WriteFgEValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue4').AsFloat := pValue;
end;

function TTshTmp.ReadFgEValue5:double;
begin
  Result := oTmpTable.FieldByName('FgEValue5').AsFloat;
end;

procedure TTshTmp.WriteFgEValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue5').AsFloat := pValue;
end;

function TTshTmp.ReadFgCsdVal1:double;
begin
  Result := oTmpTable.FieldByName('FgCsdVal1').AsFloat;
end;

procedure TTshTmp.WriteFgCsdVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgCsdVal1').AsFloat := pValue;
end;

function TTshTmp.ReadFgCsdVal2:double;
begin
  Result := oTmpTable.FieldByName('FgCsdVal2').AsFloat;
end;

procedure TTshTmp.WriteFgCsdVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgCsdVal2').AsFloat := pValue;
end;

function TTshTmp.ReadFgCsdVal3:double;
begin
  Result := oTmpTable.FieldByName('FgCsdVal3').AsFloat;
end;

procedure TTshTmp.WriteFgCsdVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgCsdVal3').AsFloat := pValue;
end;

function TTshTmp.ReadFgCsdVal4:double;
begin
  Result := oTmpTable.FieldByName('FgCsdVal4').AsFloat;
end;

procedure TTshTmp.WriteFgCsdVal4(pValue:double);
begin
  oTmpTable.FieldByName('FgCsdVal4').AsFloat := pValue;
end;

function TTshTmp.ReadFgCsdVal5:double;
begin
  Result := oTmpTable.FieldByName('FgCsdVal5').AsFloat;
end;

procedure TTshTmp.WriteFgCsdVal5(pValue:double);
begin
  oTmpTable.FieldByName('FgCsdVal5').AsFloat := pValue;
end;

function TTshTmp.ReadZIseNum:Str12;
begin
  Result := oTmpTable.FieldByName('ZIseNum').AsString;
end;

procedure TTshTmp.WriteZIseNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ZIseNum').AsString := pValue;
end;

function TTshTmp.ReadTIseNum:Str12;
begin
  Result := oTmpTable.FieldByName('TIseNum').AsString;
end;

procedure TTshTmp.WriteTIseNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TIseNum').AsString := pValue;
end;

function TTshTmp.ReadOIseNum:Str12;
begin
  Result := oTmpTable.FieldByName('OIseNum').AsString;
end;

procedure TTshTmp.WriteOIseNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OIseNum').AsString := pValue;
end;

function TTshTmp.ReadGIseNum:Str12;
begin
  Result := oTmpTable.FieldByName('GIseNum').AsString;
end;

procedure TTshTmp.WriteGIseNum(pValue:Str12);
begin
  oTmpTable.FieldByName('GIseNum').AsString := pValue;
end;

function TTshTmp.ReadZIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('ZIsdNum').AsString;
end;

procedure TTshTmp.WriteZIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ZIsdNum').AsString := pValue;
end;

function TTshTmp.ReadTIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TIsdNum').AsString;
end;

procedure TTshTmp.WriteTIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TIsdNum').AsString := pValue;
end;

function TTshTmp.ReadOIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OIsdNum').AsString;
end;

procedure TTshTmp.WriteOIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OIsdNum').AsString := pValue;
end;

function TTshTmp.ReadGIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('GIsdNum').AsString;
end;

procedure TTshTmp.WriteGIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('GIsdNum').AsString := pValue;
end;

function TTshTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TTshTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTshTmp.ReadCsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('CsdNum').AsString;
end;

procedure TTshTmp.WriteCsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CsdNum').AsString := pValue;
end;

function TTshTmp.ReadIsdNum:Str15;
begin
  Result := oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TTshTmp.WriteIsdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('IsdNum').AsString := pValue;
end;

function TTshTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TTshTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTshTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TTshTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTshTmp.ReadPkdNum:Str12;
begin
  Result := oTmpTable.FieldByName('PkdNum').AsString;
end;

procedure TTshTmp.WritePkdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PkdNum').AsString := pValue;
end;

function TTshTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TTshTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TTshTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TTshTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TTshTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTshTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTshTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TTshTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TTshTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TTshTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TTshTmp.ReadDstPair:Str1;
begin
  Result := oTmpTable.FieldByName('DstPair').AsString;
end;

procedure TTshTmp.WriteDstPair(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPair').AsString := pValue;
end;

function TTshTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TTshTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TTshTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TTshTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TTshTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TTshTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TTshTmp.ReadDstCor:Str1;
begin
  Result := oTmpTable.FieldByName('DstCor').AsString;
end;

procedure TTshTmp.WriteDstCor(pValue:Str1);
begin
  oTmpTable.FieldByName('DstCor').AsString := pValue;
end;

function TTshTmp.ReadDstLiq:Str1;
begin
  Result := oTmpTable.FieldByName('DstLiq').AsString;
end;

procedure TTshTmp.WriteDstLiq(pValue:Str1);
begin
  oTmpTable.FieldByName('DstLiq').AsString := pValue;
end;

function TTshTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TTshTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TTshTmp.ReadCAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TTshTmp.WriteCAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TTshTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TTshTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TTshTmp.ReadDAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TTshTmp.WriteDAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TTshTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TTshTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTshTmp.ReadSndNum:word;
begin
  Result := oTmpTable.FieldByName('SndNum').AsInteger;
end;

procedure TTshTmp.WriteSndNum(pValue:word);
begin
  oTmpTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TTshTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TTshTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TTshTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TTshTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TTshTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TTshTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTshTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTshTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTshTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TTshTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTshTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TTshTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TTshTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TTshTmp.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oTmpTable.FindKey([pStkNum]);
end;

function TTshTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TTshTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TTshTmp.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oTmpTable.FindKey([pAcEValue]);
end;

function TTshTmp.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oTmpTable.FindKey([pFgEValue]);
end;

function TTshTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TTshTmp.LocateSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oTmpTable.FindKey([pSndStat]);
end;

function TTshTmp.LocateDstCor (pDstCor:Str1):boolean;
begin
  SetIndex (ixDstCor);
  Result := oTmpTable.FindKey([pDstCor]);
end;

function TTshTmp.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TTshTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TTshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTshTmp.First;
begin
  oTmpTable.First;
end;

procedure TTshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
