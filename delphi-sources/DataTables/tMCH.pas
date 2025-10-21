unit tMCH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixExpDate = 'ExpDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';

type
  TMchTmp = class (TComponent)
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
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPValue:double;       procedure WriteAcPValue (pValue:double);
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
    function  ReadFgAValue4:double;      procedure WriteFgAValue4 (pValue:double);
    function  ReadFgAValue5:double;      procedure WriteFgAValue5 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadFgBValue5:double;      procedure WriteFgBValue5 (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadAccept:byte;           procedure WriteAccept (pValue:byte);
    function  ReadDcCode:byte;           procedure WriteDcCode (pValue:byte);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadFgVatVal1:double;      procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;      procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;      procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgVatVal4:double;      procedure WriteFgVatVal4 (pValue:double);
    function  ReadFgVatVal5:double;      procedure WriteFgVatVal5 (pValue:double);
    function  ReadRegStn:Str30;          procedure WriteRegStn (pValue:Str30);
    function  ReadWpaStn:Str30;          procedure WriteWpaStn (pValue:Str30);
    function  ReadInfo:Str60;            procedure WriteInfo (pValue:Str60);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadDstSpi:byte;           procedure WriteDstSpi (pValue:byte);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadProPrc:double;         procedure WriteProPrc (pValue:double);
    function  ReadProVal:double;         procedure WriteProVal (pValue:double);
    function  ReadEquVal:double;         procedure WriteEquVal (pValue:double);
    function  ReadEquPrc:byte;           procedure WriteEquPrc (pValue:byte);
    function  ReadNeqNum:word;           procedure WriteNeqNum (pValue:word);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadDocDes:Str50;          procedure WriteDocDes (pValue:Str50);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
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
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPValue:double read ReadAcPValue write WriteAcPValue;
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
    property FgAValue4:double read ReadFgAValue4 write WriteFgAValue4;
    property FgAValue5:double read ReadFgAValue5 write WriteFgAValue5;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Accept:byte read ReadAccept write WriteAccept;
    property DcCode:byte read ReadDcCode write WriteDcCode;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property FgVatVal1:double read ReadFgVatVal1 write WriteFgVatVal1;
    property FgVatVal2:double read ReadFgVatVal2 write WriteFgVatVal2;
    property FgVatVal3:double read ReadFgVatVal3 write WriteFgVatVal3;
    property FgVatVal4:double read ReadFgVatVal4 write WriteFgVatVal4;
    property FgVatVal5:double read ReadFgVatVal5 write WriteFgVatVal5;
    property RegStn:Str30 read ReadRegStn write WriteRegStn;
    property WpaStn:Str30 read ReadWpaStn write WriteWpaStn;
    property Info:Str60 read ReadInfo write WriteInfo;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property DstSpi:byte read ReadDstSpi write WriteDstSpi;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property ProPrc:double read ReadProPrc write WriteProPrc;
    property ProVal:double read ReadProVal write WriteProVal;
    property EquVal:double read ReadEquVal write WriteEquVal;
    property EquPrc:byte read ReadEquPrc write WriteEquPrc;
    property NeqNum:word read ReadNeqNum write WriteNeqNum;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property DocDes:Str50 read ReadDocDes write WriteDocDes;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TMchTmp.Create;
begin
  oTmpTable := TmpInit ('MCH',Self);
end;

destructor TMchTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMchTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMchTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMchTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TMchTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TMchTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TMchTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TMchTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TMchTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TMchTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TMchTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TMchTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TMchTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TMchTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TMchTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TMchTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TMchTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TMchTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TMchTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TMchTmp.ReadMyConto:Str30;
begin
  Result := oTmpTable.FieldByName('MyConto').AsString;
end;

procedure TMchTmp.WriteMyConto(pValue:Str30);
begin
  oTmpTable.FieldByName('MyConto').AsString := pValue;
end;

function TMchTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TMchTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TMchTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TMchTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TMchTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TMchTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TMchTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TMchTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TMchTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TMchTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TMchTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TMchTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TMchTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TMchTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TMchTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TMchTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TMchTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TMchTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TMchTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TMchTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TMchTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TMchTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TMchTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TMchTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TMchTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TMchTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TMchTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TMchTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TMchTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TMchTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TMchTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TMchTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TMchTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TMchTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TMchTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TMchTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TMchTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TMchTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TMchTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TMchTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TMchTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TMchTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TMchTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TMchTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TMchTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TMchTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TMchTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TMchTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TMchTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TMchTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TMchTmp.ReadIcFacDay:word;
begin
  Result := oTmpTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TMchTmp.WriteIcFacDay(pValue:word);
begin
  oTmpTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TMchTmp.ReadIcFacPrc:double;
begin
  Result := oTmpTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TMchTmp.WriteIcFacPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TMchTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TMchTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TMchTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TMchTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TMchTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TMchTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TMchTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TMchTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TMchTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TMchTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TMchTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TMchTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TMchTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TMchTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TMchTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TMchTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TMchTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TMchTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TMchTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TMchTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TMchTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TMchTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TMchTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TMchTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TMchTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TMchTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TMchTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TMchTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TMchTmp.ReadAcPValue:double;
begin
  Result := oTmpTable.FieldByName('AcPValue').AsFloat;
end;

procedure TMchTmp.WriteAcPValue(pValue:double);
begin
  oTmpTable.FieldByName('AcPValue').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TMchTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TMchTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TMchTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue4:double;
begin
  Result := oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TMchTmp.WriteAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TMchTmp.ReadAcAValue5:double;
begin
  Result := oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TMchTmp.WriteAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue1:double;
begin
  Result := oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TMchTmp.WriteAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue2:double;
begin
  Result := oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TMchTmp.WriteAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue3:double;
begin
  Result := oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TMchTmp.WriteAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue4:double;
begin
  Result := oTmpTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TMchTmp.WriteAcBValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TMchTmp.ReadAcBValue5:double;
begin
  Result := oTmpTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TMchTmp.WriteAcBValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TMchTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TMchTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TMchTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TMchTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TMchTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TMchTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TMchTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TMchTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TMchTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TMchTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TMchTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TMchTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TMchTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TMchTmp.ReadFgPValue:double;
begin
  Result := oTmpTable.FieldByName('FgPValue').AsFloat;
end;

procedure TMchTmp.WriteFgPValue(pValue:double);
begin
  oTmpTable.FieldByName('FgPValue').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue1:double;
begin
  Result := oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TMchTmp.WriteFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue2:double;
begin
  Result := oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TMchTmp.WriteFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue3:double;
begin
  Result := oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TMchTmp.WriteFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue4:double;
begin
  Result := oTmpTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TMchTmp.WriteFgAValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TMchTmp.ReadFgAValue5:double;
begin
  Result := oTmpTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TMchTmp.WriteFgAValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue1:double;
begin
  Result := oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TMchTmp.WriteFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue2:double;
begin
  Result := oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TMchTmp.WriteFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue3:double;
begin
  Result := oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TMchTmp.WriteFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue4:double;
begin
  Result := oTmpTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TMchTmp.WriteFgBValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TMchTmp.ReadFgBValue5:double;
begin
  Result := oTmpTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TMchTmp.WriteFgBValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

function TMchTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TMchTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TMchTmp.ReadCusCard:Str20;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TMchTmp.WriteCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TMchTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TMchTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TMchTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TMchTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TMchTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TMchTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TMchTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TMchTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TMchTmp.ReadAccept:byte;
begin
  Result := oTmpTable.FieldByName('Accept').AsInteger;
end;

procedure TMchTmp.WriteAccept(pValue:byte);
begin
  oTmpTable.FieldByName('Accept').AsInteger := pValue;
end;

function TMchTmp.ReadDcCode:byte;
begin
  Result := oTmpTable.FieldByName('DcCode').AsInteger;
end;

procedure TMchTmp.WriteDcCode(pValue:byte);
begin
  oTmpTable.FieldByName('DcCode').AsInteger := pValue;
end;

function TMchTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TMchTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TMchTmp.ReadTrmNum:word;
begin
  Result := oTmpTable.FieldByName('TrmNum').AsInteger;
end;

procedure TMchTmp.WriteTrmNum(pValue:word);
begin
  oTmpTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TMchTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TMchTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMchTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMchTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMchTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMchTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TMchTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TMchTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TMchTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TMchTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TMchTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TMchTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TMchTmp.ReadFgVatVal1:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat := pValue;
end;

function TMchTmp.ReadFgVatVal2:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat := pValue;
end;

function TMchTmp.ReadFgVatVal3:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat := pValue;
end;

function TMchTmp.ReadFgVatVal4:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal4').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal4').AsFloat := pValue;
end;

function TMchTmp.ReadFgVatVal5:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal5').AsFloat;
end;

procedure TMchTmp.WriteFgVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal5').AsFloat := pValue;
end;

function TMchTmp.ReadRegStn:Str30;
begin
  Result := oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TMchTmp.WriteRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString := pValue;
end;

function TMchTmp.ReadWpaStn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TMchTmp.WriteWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString := pValue;
end;

function TMchTmp.ReadInfo:Str60;
begin
  Result := oTmpTable.FieldByName('Info').AsString;
end;

procedure TMchTmp.WriteInfo(pValue:Str60);
begin
  oTmpTable.FieldByName('Info').AsString := pValue;
end;

function TMchTmp.ReadPrjCode:Str12;
begin
  Result := oTmpTable.FieldByName('PrjCode').AsString;
end;

procedure TMchTmp.WritePrjCode(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjCode').AsString := pValue;
end;

function TMchTmp.ReadDstSpi:byte;
begin
  Result := oTmpTable.FieldByName('DstSpi').AsInteger;
end;

procedure TMchTmp.WriteDstSpi(pValue:byte);
begin
  oTmpTable.FieldByName('DstSpi').AsInteger := pValue;
end;

function TMchTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TMchTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TMchTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TMchTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TMchTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TMchTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TMchTmp.ReadFgEndVal:double;
begin
  Result := oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TMchTmp.WriteFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TMchTmp.ReadProPrc:double;
begin
  Result := oTmpTable.FieldByName('ProPrc').AsFloat;
end;

procedure TMchTmp.WriteProPrc(pValue:double);
begin
  oTmpTable.FieldByName('ProPrc').AsFloat := pValue;
end;

function TMchTmp.ReadProVal:double;
begin
  Result := oTmpTable.FieldByName('ProVal').AsFloat;
end;

procedure TMchTmp.WriteProVal(pValue:double);
begin
  oTmpTable.FieldByName('ProVal').AsFloat := pValue;
end;

function TMchTmp.ReadEquVal:double;
begin
  Result := oTmpTable.FieldByName('EquVal').AsFloat;
end;

procedure TMchTmp.WriteEquVal(pValue:double);
begin
  oTmpTable.FieldByName('EquVal').AsFloat := pValue;
end;

function TMchTmp.ReadEquPrc:byte;
begin
  Result := oTmpTable.FieldByName('EquPrc').AsInteger;
end;

procedure TMchTmp.WriteEquPrc(pValue:byte);
begin
  oTmpTable.FieldByName('EquPrc').AsInteger := pValue;
end;

function TMchTmp.ReadNeqNum:word;
begin
  Result := oTmpTable.FieldByName('NeqNum').AsInteger;
end;

procedure TMchTmp.WriteNeqNum(pValue:word);
begin
  oTmpTable.FieldByName('NeqNum').AsInteger := pValue;
end;

function TMchTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TMchTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TMchTmp.ReadDocDes:Str50;
begin
  Result := oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TMchTmp.WriteDocDes(pValue:Str50);
begin
  oTmpTable.FieldByName('DocDes').AsString := pValue;
end;

function TMchTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TMchTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMchTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMchTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMchTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TMchTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TMchTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TMchTmp.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oTmpTable.FindKey([pExpDate]);
end;

function TMchTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TMchTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TMchTmp.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oTmpTable.FindKey([pAcBValue]);
end;

function TMchTmp.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oTmpTable.FindKey([pFgBValue]);
end;

procedure TMchTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMchTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMchTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMchTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMchTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMchTmp.First;
begin
  oTmpTable.First;
end;

procedure TMchTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMchTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMchTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMchTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMchTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMchTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMchTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMchTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMchTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMchTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMchTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
