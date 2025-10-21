unit tTCH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixStkNum = 'StkNum';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAcBValue = 'AcBValue';
  ixFgBValue = 'FgBValue';
  ixDpPc = 'DpPc';
  ixDstCls = 'DstCls';
  ixDstAcc = 'DstAcc';
  ixSpMark = 'SpMark';
  ixRbaCode = 'RbaCode';

type
  TTchTmp = class (TComponent)
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
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadIcFacDay:word;         procedure WriteIcFacDay (pValue:word);
    function  ReadIcFacPrc:double;       procedure WriteIcFacPrc (pValue:double);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
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
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadImAValue:double;       procedure WriteImAValue (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDBValue:double;      procedure WriteFgDBValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgDscBVal:double;      procedure WriteFgDscBVal (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgAValue4:double;      procedure WriteFgAValue4 (pValue:double);
    function  ReadFgAValue5:double;      procedure WriteFgAValue5 (pValue:double);
    function  ReadFgVatVal1:double;      procedure WriteFgVatVal1 (pValue:double);
    function  ReadFgVatVal2:double;      procedure WriteFgVatVal2 (pValue:double);
    function  ReadFgVatVal3:double;      procedure WriteFgVatVal3 (pValue:double);
    function  ReadFgVatVal4:double;      procedure WriteFgVatVal4 (pValue:double);
    function  ReadFgVatVal5:double;      procedure WriteFgVatVal5 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadFgBValue5:double;      procedure WriteFgBValue5 (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgDuoInf:Str100;       procedure WriteFgDuoInf (pValue:Str100);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadRcvName:Str30;         procedure WriteRcvName (pValue:Str30);
    function  ReadRcvCode:Str10;         procedure WriteRcvCode (pValue:Str10);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCntOut:word;           procedure WriteCntOut (pValue:word);
    function  ReadCntExp:word;           procedure WriteCntExp (pValue:word);
    function  ReadDstPair:Str1;          procedure WriteDstPair (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str8;          procedure WriteCAccAnl (pValue:Str8);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str8;          procedure WriteDAccAnl (pValue:Str8);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadIcdNum:Str14;          procedure WriteIcdNum (pValue:Str14);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadPrjCode:Str12;         procedure WritePrjCode (pValue:Str12);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadNotice1:Str60;         procedure WriteNotice1 (pValue:Str60);
    function  ReadNotice2:Str60;         procedure WriteNotice2 (pValue:Str60);
    function  ReadNotice3:Str60;         procedure WriteNotice3 (pValue:Str60);
    function  ReadNotice4:Str60;         procedure WriteNotice4 (pValue:Str60);
    function  ReadNotice5:Str60;         procedure WriteNotice5 (pValue:Str60);
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
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateDpPc (pDstPair:Str1;pPaCode:longint):boolean;
    function LocateDstCls (pDstCls:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function LocateSpMark (pSpMark:Str10):boolean;
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
    property RspName:Str30 read ReadRspName write WriteRspName;
    property IcFacDay:word read ReadIcFacDay write WriteIcFacDay;
    property IcFacPrc:double read ReadIcFacPrc write WriteIcFacPrc;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
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
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property ImAValue:double read ReadImAValue write WriteImAValue;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDBValue:double read ReadFgDBValue write WriteFgDBValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgDscBVal:double read ReadFgDscBVal write WriteFgDscBVal;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgAValue4:double read ReadFgAValue4 write WriteFgAValue4;
    property FgAValue5:double read ReadFgAValue5 write WriteFgAValue5;
    property FgVatVal1:double read ReadFgVatVal1 write WriteFgVatVal1;
    property FgVatVal2:double read ReadFgVatVal2 write WriteFgVatVal2;
    property FgVatVal3:double read ReadFgVatVal3 write WriteFgVatVal3;
    property FgVatVal4:double read ReadFgVatVal4 write WriteFgVatVal4;
    property FgVatVal5:double read ReadFgVatVal5 write WriteFgVatVal5;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgDuoInf:Str100 read ReadFgDuoInf write WriteFgDuoInf;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property RcvName:Str30 read ReadRcvName write WriteRcvName;
    property RcvCode:Str10 read ReadRcvCode write WriteRcvCode;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CntOut:word read ReadCntOut write WriteCntOut;
    property CntExp:word read ReadCntExp write WriteCntExp;
    property DstPair:Str1 read ReadDstPair write WriteDstPair;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str8 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str8 read ReadDAccAnl write WriteDAccAnl;
    property Sended:boolean read ReadSended write WriteSended;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property IcdNum:Str14 read ReadIcdNum write WriteIcdNum;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property PrjCode:Str12 read ReadPrjCode write WritePrjCode;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property Notice1:Str60 read ReadNotice1 write WriteNotice1;
    property Notice2:Str60 read ReadNotice2 write WriteNotice2;
    property Notice3:Str60 read ReadNotice3 write WriteNotice3;
    property Notice4:Str60 read ReadNotice4 write WriteNotice4;
    property Notice5:Str60 read ReadNotice5 write WriteNotice5;
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

constructor TTchTmp.Create;
begin
  oTmpTable := TmpInit ('TCH',Self);
end;

destructor TTchTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTchTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTchTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTchTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTchTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TTchTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TTchTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TTchTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TTchTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTchTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TTchTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTchTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TTchTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTchTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTchTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTchTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTchTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTchTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTchTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTchTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TTchTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTchTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TTchTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TTchTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TTchTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TTchTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TTchTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TTchTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TTchTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TTchTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TTchTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TTchTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TTchTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TTchTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TTchTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TTchTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TTchTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TTchTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TTchTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TTchTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TTchTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TTchTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TTchTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TTchTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TTchTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TTchTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TTchTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TTchTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TTchTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TTchTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TTchTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TTchTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TTchTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TTchTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TTchTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TTchTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TTchTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TTchTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TTchTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TTchTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TTchTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TTchTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TTchTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TTchTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TTchTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TTchTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TTchTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TTchTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TTchTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TTchTmp.ReadIcFacDay:word;
begin
  Result := oTmpTable.FieldByName('IcFacDay').AsInteger;
end;

procedure TTchTmp.WriteIcFacDay(pValue:word);
begin
  oTmpTable.FieldByName('IcFacDay').AsInteger := pValue;
end;

function TTchTmp.ReadIcFacPrc:double;
begin
  Result := oTmpTable.FieldByName('IcFacPrc').AsFloat;
end;

procedure TTchTmp.WriteIcFacPrc(pValue:double);
begin
  oTmpTable.FieldByName('IcFacPrc').AsFloat := pValue;
end;

function TTchTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTchTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTchTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TTchTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TTchTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTchTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTchTmp.ReadHdsPrc:double;
begin
  Result := oTmpTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TTchTmp.WriteHdsPrc(pValue:double);
begin
  oTmpTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TTchTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TTchTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TTchTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TTchTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TTchTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TTchTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TTchTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TTchTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TTchTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TTchTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TTchTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TTchTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TTchTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTchTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTchTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTchTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTchTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTchTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTchTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTchTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TTchTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTchTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TTchTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TTchTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TTchTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue4:double;
begin
  Result := oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TTchTmp.WriteAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TTchTmp.ReadAcAValue5:double;
begin
  Result := oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TTchTmp.WriteAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue1:double;
begin
  Result := oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TTchTmp.WriteAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue2:double;
begin
  Result := oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TTchTmp.WriteAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue3:double;
begin
  Result := oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TTchTmp.WriteAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue4:double;
begin
  Result := oTmpTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TTchTmp.WriteAcBValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue4').AsFloat := pValue;
end;

function TTchTmp.ReadAcBValue5:double;
begin
  Result := oTmpTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TTchTmp.WriteAcBValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue5').AsFloat := pValue;
end;

function TTchTmp.ReadAcRndVat:double;
begin
  Result := oTmpTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TTchTmp.WriteAcRndVat(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TTchTmp.ReadAcRndVal:double;
begin
  Result := oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTchTmp.WriteAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTchTmp.ReadImAValue:double;
begin
  Result := oTmpTable.FieldByName('ImAValue').AsFloat;
end;

procedure TTchTmp.WriteImAValue(pValue:double);
begin
  oTmpTable.FieldByName('ImAValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TTchTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TTchTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TTchTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TTchTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTchTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTchTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgDBValue:double;
begin
  Result := oTmpTable.FieldByName('FgDBValue').AsFloat;
end;

procedure TTchTmp.WriteFgDBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDBValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTchTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTchTmp.ReadFgDscBVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TTchTmp.WriteFgDscBVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscBVal').AsFloat := pValue;
end;

function TTchTmp.ReadFgHdsVal:double;
begin
  Result := oTmpTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TTchTmp.WriteFgHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TTchTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TTchTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue1:double;
begin
  Result := oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TTchTmp.WriteFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue2:double;
begin
  Result := oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TTchTmp.WriteFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue3:double;
begin
  Result := oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TTchTmp.WriteFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue4:double;
begin
  Result := oTmpTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TTchTmp.WriteFgAValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue4').AsFloat := pValue;
end;

function TTchTmp.ReadFgAValue5:double;
begin
  Result := oTmpTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TTchTmp.WriteFgAValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue5').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal1:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal2:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal3:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal4:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal4').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal4').AsFloat := pValue;
end;

function TTchTmp.ReadFgVatVal5:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal5').AsFloat;
end;

procedure TTchTmp.WriteFgVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal5').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue1:double;
begin
  Result := oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TTchTmp.WriteFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue2:double;
begin
  Result := oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TTchTmp.WriteFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue3:double;
begin
  Result := oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TTchTmp.WriteFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue4:double;
begin
  Result := oTmpTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TTchTmp.WriteFgBValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TTchTmp.ReadFgBValue5:double;
begin
  Result := oTmpTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TTchTmp.WriteFgBValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

function TTchTmp.ReadFgRndVat:double;
begin
  Result := oTmpTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TTchTmp.WriteFgRndVat(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TTchTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTchTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTchTmp.ReadFgDuoInf:Str100;
begin
  Result := oTmpTable.FieldByName('FgDuoInf').AsString;
end;

procedure TTchTmp.WriteFgDuoInf(pValue:Str100);
begin
  oTmpTable.FieldByName('FgDuoInf').AsString := pValue;
end;

function TTchTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TTchTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TTchTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TTchTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TTchTmp.ReadRcvName:Str30;
begin
  Result := oTmpTable.FieldByName('RcvName').AsString;
end;

procedure TTchTmp.WriteRcvName(pValue:Str30);
begin
  oTmpTable.FieldByName('RcvName').AsString := pValue;
end;

function TTchTmp.ReadRcvCode:Str10;
begin
  Result := oTmpTable.FieldByName('RcvCode').AsString;
end;

procedure TTchTmp.WriteRcvCode(pValue:Str10);
begin
  oTmpTable.FieldByName('RcvCode').AsString := pValue;
end;

function TTchTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TTchTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TTchTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TTchTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTchTmp.ReadCusCard:Str20;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TTchTmp.WriteCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TTchTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TTchTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TTchTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TTchTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TTchTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTchTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTchTmp.ReadCntOut:word;
begin
  Result := oTmpTable.FieldByName('CntOut').AsInteger;
end;

procedure TTchTmp.WriteCntOut(pValue:word);
begin
  oTmpTable.FieldByName('CntOut').AsInteger := pValue;
end;

function TTchTmp.ReadCntExp:word;
begin
  Result := oTmpTable.FieldByName('CntExp').AsInteger;
end;

procedure TTchTmp.WriteCntExp(pValue:word);
begin
  oTmpTable.FieldByName('CntExp').AsInteger := pValue;
end;

function TTchTmp.ReadDstPair:Str1;
begin
  Result := oTmpTable.FieldByName('DstPair').AsString;
end;

procedure TTchTmp.WriteDstPair(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPair').AsString := pValue;
end;

function TTchTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TTchTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TTchTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TTchTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TTchTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TTchTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TTchTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TTchTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TTchTmp.ReadCAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TTchTmp.WriteCAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TTchTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TTchTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TTchTmp.ReadDAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TTchTmp.WriteDAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TTchTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TTchTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TTchTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TTchTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TTchTmp.ReadBonNum:byte;
begin
  Result := oTmpTable.FieldByName('BonNum').AsInteger;
end;

procedure TTchTmp.WriteBonNum(pValue:byte);
begin
  oTmpTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TTchTmp.ReadIcdNum:Str14;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TTchTmp.WriteIcdNum(pValue:Str14);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTchTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TTchTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TTchTmp.ReadPrjCode:Str12;
begin
  Result := oTmpTable.FieldByName('PrjCode').AsString;
end;

procedure TTchTmp.WritePrjCode(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjCode').AsString := pValue;
end;

function TTchTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TTchTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTchTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTchTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTchTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TTchTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TTchTmp.ReadNotice1:Str60;
begin
  Result := oTmpTable.FieldByName('Notice1').AsString;
end;

procedure TTchTmp.WriteNotice1(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice1').AsString := pValue;
end;

function TTchTmp.ReadNotice2:Str60;
begin
  Result := oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TTchTmp.WriteNotice2(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice2').AsString := pValue;
end;

function TTchTmp.ReadNotice3:Str60;
begin
  Result := oTmpTable.FieldByName('Notice3').AsString;
end;

procedure TTchTmp.WriteNotice3(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice3').AsString := pValue;
end;

function TTchTmp.ReadNotice4:Str60;
begin
  Result := oTmpTable.FieldByName('Notice4').AsString;
end;

procedure TTchTmp.WriteNotice4(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice4').AsString := pValue;
end;

function TTchTmp.ReadNotice5:Str60;
begin
  Result := oTmpTable.FieldByName('Notice5').AsString;
end;

procedure TTchTmp.WriteNotice5(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice5').AsString := pValue;
end;

function TTchTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTchTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTchTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTchTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTchTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTchTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTchTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TTchTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTchTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTchTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTchTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTchTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTchTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTchTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTchTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTchTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTchTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTchTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTchTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TTchTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TTchTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TTchTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TTchTmp.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oTmpTable.FindKey([pStkNum]);
end;

function TTchTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TTchTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TTchTmp.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oTmpTable.FindKey([pAcBValue]);
end;

function TTchTmp.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oTmpTable.FindKey([pFgBValue]);
end;

function TTchTmp.LocateDpPc (pDstPair:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixDpPc);
  Result := oTmpTable.FindKey([pDstPair,pPaCode]);
end;

function TTchTmp.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oTmpTable.FindKey([pDstCls]);
end;

function TTchTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TTchTmp.LocateSpMark (pSpMark:Str10):boolean;
begin
  SetIndex (ixSpMark);
  Result := oTmpTable.FindKey([pSpMark]);
end;

function TTchTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TTchTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTchTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTchTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTchTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTchTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTchTmp.First;
begin
  oTmpTable.First;
end;

procedure TTchTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTchTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTchTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTchTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTchTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTchTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTchTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTchTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTchTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTchTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTchTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
