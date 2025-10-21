unit tOCH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixPaName_ = 'PaName_';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';

type
  TOchTmp = class (TComponent)
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
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
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
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
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
    function  ReadFgIcdVal:double;       procedure WriteFgIcdVal (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgVatVal1:double;      procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;      procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;      procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCntOrd:word;           procedure WriteCntOrd (pValue:word);
    function  ReadCntRes:word;           procedure WriteCntRes (pValue:word);
    function  ReadCntPrp:word;           procedure WriteCntPrp (pValue:word);
    function  ReadCntOut:word;           procedure WriteCntOut (pValue:word);
    function  ReadCntIcd:word;           procedure WriteCntIcd (pValue:word);
    function  ReadCntRat:word;           procedure WriteCntRat (pValue:word);
    function  ReadCntTrm:word;           procedure WriteCntTrm (pValue:word);
    function  ReadCntErr:word;           procedure WriteCntErr (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadPValPay:Str1;          procedure WritePValPay (pValue:Str1);
    function  ReadSndNum:word;           procedure WriteSndNum (pValue:word);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadTrnCrs:word;           procedure WriteTrnCrs (pValue:word);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadComDlv:byte;           procedure WriteComDlv (pValue:byte);
    function  ReadPerCol:byte;           procedure WritePerCol (pValue:byte);
    function  ReadTvalue:double;         procedure WriteTvalue (pValue:double);
    function  ReadDepPrc:double;         procedure WriteDepPrc (pValue:double);
    function  ReadDepVal:double;         procedure WriteDepVal (pValue:double);
    function  ReadDepDat:TDatetime;      procedure WriteDepDat (pValue:TDatetime);
    function  ReadDepPay:Str1;           procedure WriteDepPay (pValue:Str1);
    function  ReadDepCas:byte;           procedure WriteDepCas (pValue:byte);
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
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;

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
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
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
    property RspName:Str30 read ReadRspName write WriteRspName;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
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
    property FgIcdVal:double read ReadFgIcdVal write WriteFgIcdVal;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgVatVal1:double read ReadFgVatVal1 write WriteFgVatVal1;
    property FgVatVal2:double read ReadFgVatVal2 write WriteFgVatVal2;
    property FgVatVal3:double read ReadFgVatVal3 write WriteFgVatVal3;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CntOrd:word read ReadCntOrd write WriteCntOrd;
    property CntRes:word read ReadCntRes write WriteCntRes;
    property CntPrp:word read ReadCntPrp write WriteCntPrp;
    property CntOut:word read ReadCntOut write WriteCntOut;
    property CntIcd:word read ReadCntIcd write WriteCntIcd;
    property CntRat:word read ReadCntRat write WriteCntRat;
    property CntTrm:word read ReadCntTrm write WriteCntTrm;
    property CntErr:word read ReadCntErr write WriteCntErr;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property Sended:boolean read ReadSended write WriteSended;
    property PValPay:Str1 read ReadPValPay write WritePValPay;
    property SndNum:word read ReadSndNum write WriteSndNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property TrnCrs:word read ReadTrnCrs write WriteTrnCrs;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property ComDlv:byte read ReadComDlv write WriteComDlv;
    property PerCol:byte read ReadPerCol write WritePerCol;
    property Tvalue:double read ReadTvalue write WriteTvalue;
    property DepPrc:double read ReadDepPrc write WriteDepPrc;
    property DepVal:double read ReadDepVal write WriteDepVal;
    property DepDat:TDatetime read ReadDepDat write WriteDepDat;
    property DepPay:Str1 read ReadDepPay write WriteDepPay;
    property DepCas:byte read ReadDepCas write WriteDepCas;
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

constructor TOchTmp.Create;
begin
  oTmpTable := TmpInit ('OCH',Self);
end;

destructor TOchTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOchTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOchTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOchTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOchTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOchTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TOchTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TOchTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOchTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOchTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TOchTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOchTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOchTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOchTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TOchTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TOchTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOchTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOchTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOchTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOchTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOchTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOchTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TOchTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TOchTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TOchTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TOchTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TOchTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TOchTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TOchTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TOchTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TOchTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TOchTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TOchTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TOchTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TOchTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TOchTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TOchTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TOchTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TOchTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TOchTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TOchTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TOchTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TOchTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TOchTmp.ReadRegTel:Str20;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TOchTmp.WriteRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TOchTmp.ReadRegFax:Str20;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TOchTmp.WriteRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TOchTmp.ReadRegEml:Str30;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TOchTmp.WriteRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TOchTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TOchTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TOchTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TOchTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TOchTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TOchTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TOchTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TOchTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TOchTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TOchTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TOchTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TOchTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TOchTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TOchTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TOchTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TOchTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TOchTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TOchTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TOchTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TOchTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TOchTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TOchTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TOchTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TOchTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TOchTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TOchTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TOchTmp.ReadIcFacDay:word;
begin
  Result := oTmpTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TOchTmp.WriteIcFacDay(pValue:word);
begin
  oTmpTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TOchTmp.ReadIcFacPrc:double;
begin
  Result := oTmpTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TOchTmp.WriteIcFacPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TOchTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOchTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOchTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOchTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOchTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TOchTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TOchTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TOchTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TOchTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TOchTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TOchTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TOchTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TOchTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOchTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOchTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOchTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOchTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOchTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TOchTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TOchTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOchTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcMValue:double;
begin
  Result := oTmpTable.FieldByName('AcMValue').AsFloat;
end;

procedure TOchTmp.WriteAcMValue(pValue:double);
begin
  oTmpTable.FieldByName('AcMValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcWValue:double;
begin
  Result := oTmpTable.FieldByName('AcWValue').AsFloat;
end;

procedure TOchTmp.WriteAcWValue(pValue:double);
begin
  oTmpTable.FieldByName('AcWValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcOValue:double;
begin
  Result := oTmpTable.FieldByName('AcOValue').AsFloat;
end;

procedure TOchTmp.WriteAcOValue(pValue:double);
begin
  oTmpTable.FieldByName('AcOValue').AsFloat := pValue;
end;

function TOchTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TOchTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TOchTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TOchTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TOchTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TOchTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TOchTmp.ReadAcBValue1:double;
begin
  Result := oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TOchTmp.WriteAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TOchTmp.ReadAcBValue2:double;
begin
  Result := oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TOchTmp.WriteAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TOchTmp.ReadAcBValue3:double;
begin
  Result := oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TOchTmp.WriteAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TOchTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TOchTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TOchTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TOchTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TOchTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOchTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOchTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOchTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOchTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOchTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOchTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TOchTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TOchTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TOchTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TOchTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TOchTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TOchTmp.ReadFgPValue:double;
begin
  Result := oTmpTable.FieldByName('FgPValue').AsFloat;
end;

procedure TOchTmp.WriteFgPValue(pValue:double);
begin
  oTmpTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TOchTmp.ReadFgIcdVal:double;
begin
  Result := oTmpTable.FieldByName('FgIcdVal').AsFloat;
end;

procedure TOchTmp.WriteFgIcdVal(pValue:double);
begin
  oTmpTable.FieldByName('FgIcdVal').AsFloat := pValue;
end;

function TOchTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TOchTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TOchTmp.ReadFgEndVal:double;
begin
  Result := oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TOchTmp.WriteFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TOchTmp.ReadFgAValue1:double;
begin
  Result := oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TOchTmp.WriteFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TOchTmp.ReadFgAValue2:double;
begin
  Result := oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TOchTmp.WriteFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TOchTmp.ReadFgAValue3:double;
begin
  Result := oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TOchTmp.WriteFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TOchTmp.ReadFgVatVal1:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TOchTmp.WriteFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat := pValue;
end;

function TOchTmp.ReadFgVatVal2:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TOchTmp.WriteFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat := pValue;
end;

function TOchTmp.ReadFgVatVal3:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TOchTmp.WriteFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat := pValue;
end;

function TOchTmp.ReadFgBValue1:double;
begin
  Result := oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TOchTmp.WriteFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TOchTmp.ReadFgBValue2:double;
begin
  Result := oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TOchTmp.WriteFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TOchTmp.ReadFgBValue3:double;
begin
  Result := oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TOchTmp.WriteFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TOchTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TOchTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TOchTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TOchTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TOchTmp.ReadCusCard:Str20;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TOchTmp.WriteCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TOchTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOchTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TOchTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOchTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOchTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOchTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOchTmp.ReadCntOrd:word;
begin
  Result := oTmpTable.FieldByName('CntOrd').AsInteger;
end;

procedure TOchTmp.WriteCntOrd(pValue:word);
begin
  oTmpTable.FieldByName('CntOrd').AsInteger := pValue;
end;

function TOchTmp.ReadCntRes:word;
begin
  Result := oTmpTable.FieldByName('CntRes').AsInteger;
end;

procedure TOchTmp.WriteCntRes(pValue:word);
begin
  oTmpTable.FieldByName('CntRes').AsInteger := pValue;
end;

function TOchTmp.ReadCntPrp:word;
begin
  Result := oTmpTable.FieldByName('CntPrp').AsInteger;
end;

procedure TOchTmp.WriteCntPrp(pValue:word);
begin
  oTmpTable.FieldByName('CntPrp').AsInteger := pValue;
end;

function TOchTmp.ReadCntOut:word;
begin
  Result := oTmpTable.FieldByName('CntOut').AsInteger;
end;

procedure TOchTmp.WriteCntOut(pValue:word);
begin
  oTmpTable.FieldByName('CntOut').AsInteger := pValue;
end;

function TOchTmp.ReadCntIcd:word;
begin
  Result := oTmpTable.FieldByName('CntIcd').AsInteger;
end;

procedure TOchTmp.WriteCntIcd(pValue:word);
begin
  oTmpTable.FieldByName('CntIcd').AsInteger := pValue;
end;

function TOchTmp.ReadCntRat:word;
begin
  Result := oTmpTable.FieldByName('CntRat').AsInteger;
end;

procedure TOchTmp.WriteCntRat(pValue:word);
begin
  oTmpTable.FieldByName('CntRat').AsInteger := pValue;
end;

function TOchTmp.ReadCntTrm:word;
begin
  Result := oTmpTable.FieldByName('CntTrm').AsInteger;
end;

procedure TOchTmp.WriteCntTrm(pValue:word);
begin
  oTmpTable.FieldByName('CntTrm').AsInteger := pValue;
end;

function TOchTmp.ReadCntErr:word;
begin
  Result := oTmpTable.FieldByName('CntErr').AsInteger;
end;

procedure TOchTmp.WriteCntErr(pValue:word);
begin
  oTmpTable.FieldByName('CntErr').AsInteger := pValue;
end;

function TOchTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TOchTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOchTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TOchTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TOchTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TOchTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TOchTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TOchTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOchTmp.ReadPValPay:Str1;
begin
  Result := oTmpTable.FieldByName('PValPay').AsString;
end;

procedure TOchTmp.WritePValPay(pValue:Str1);
begin
  oTmpTable.FieldByName('PValPay').AsString := pValue;
end;

function TOchTmp.ReadSndNum:word;
begin
  Result := oTmpTable.FieldByName('SndNum').AsInteger;
end;

procedure TOchTmp.WriteSndNum(pValue:word);
begin
  oTmpTable.FieldByName('SndNum').AsInteger := pValue;
end;

function TOchTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TOchTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TOchTmp.ReadTrnCrs:word;
begin
  Result := oTmpTable.FieldByName('TrnCrs').AsInteger;
end;

procedure TOchTmp.WriteTrnCrs(pValue:word);
begin
  oTmpTable.FieldByName('TrnCrs').AsInteger := pValue;
end;

function TOchTmp.ReadPrjCode:Str12;
begin
  Result := oTmpTable.FieldByName('PrjCode').AsString;
end;

procedure TOchTmp.WritePrjCode(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjCode').AsString := pValue;
end;

function TOchTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TOchTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TOchTmp.ReadComDlv:byte;
begin
  Result := oTmpTable.FieldByName('ComDlv').AsInteger;
end;

procedure TOchTmp.WriteComDlv(pValue:byte);
begin
  oTmpTable.FieldByName('ComDlv').AsInteger := pValue;
end;

function TOchTmp.ReadPerCol:byte;
begin
  Result := oTmpTable.FieldByName('PerCol').AsInteger;
end;

procedure TOchTmp.WritePerCol(pValue:byte);
begin
  oTmpTable.FieldByName('PerCol').AsInteger := pValue;
end;

function TOchTmp.ReadTvalue:double;
begin
  Result := oTmpTable.FieldByName('Tvalue').AsFloat;
end;

procedure TOchTmp.WriteTvalue(pValue:double);
begin
  oTmpTable.FieldByName('Tvalue').AsFloat := pValue;
end;

function TOchTmp.ReadDepPrc:double;
begin
  Result := oTmpTable.FieldByName('DepPrc').AsFloat;
end;

procedure TOchTmp.WriteDepPrc(pValue:double);
begin
  oTmpTable.FieldByName('DepPrc').AsFloat := pValue;
end;

function TOchTmp.ReadDepVal:double;
begin
  Result := oTmpTable.FieldByName('DepVal').AsFloat;
end;

procedure TOchTmp.WriteDepVal(pValue:double);
begin
  oTmpTable.FieldByName('DepVal').AsFloat := pValue;
end;

function TOchTmp.ReadDepDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('DepDat').AsDateTime;
end;

procedure TOchTmp.WriteDepDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DepDat').AsDateTime := pValue;
end;

function TOchTmp.ReadDepPay:Str1;
begin
  Result := oTmpTable.FieldByName('DepPay').AsString;
end;

procedure TOchTmp.WriteDepPay(pValue:Str1);
begin
  oTmpTable.FieldByName('DepPay').AsString := pValue;
end;

function TOchTmp.ReadDepCas:byte;
begin
  Result := oTmpTable.FieldByName('DepCas').AsInteger;
end;

procedure TOchTmp.WriteDepCas(pValue:byte);
begin
  oTmpTable.FieldByName('DepCas').AsInteger := pValue;
end;

function TOchTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOchTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOchTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOchTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOchTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOchTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOchTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOchTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOchTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOchTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOchTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOchTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOchTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOchTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOchTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOchTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOchTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOchTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOchTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TOchTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TOchTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TOchTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TOchTmp.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oTmpTable.FindKey([pAcBValue]);
end;

function TOchTmp.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oTmpTable.FindKey([pFgBValue]);
end;

procedure TOchTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOchTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOchTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOchTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOchTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOchTmp.First;
begin
  oTmpTable.First;
end;

procedure TOchTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOchTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOchTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOchTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOchTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOchTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOchTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOchTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOchTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOchTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOchTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1928001}
