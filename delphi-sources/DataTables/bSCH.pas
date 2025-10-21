unit bSCH;

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
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixCrdNum = 'CrdNum';
  ixFgDvzName = 'FgDvzName';
  ixFgBValue = 'FgBValue';
  ixDstCls = 'DstCls';

type
  TSchBtr = class (TComponent)
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
    function  ReadPlnDate:TDatetime;     procedure WritePlnDate (pValue:TDatetime);
    function  ReadPlnDay:word;           procedure WritePlnDay (pValue:word);
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
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCntName:Str30;         procedure WriteCntName (pValue:Str30);
    function  ReadCntTel:Str20;          procedure WriteCntTel (pValue:Str20);
    function  ReadCntMob:Str20;          procedure WriteCntMob (pValue:Str20);
    function  ReadCntEml:Str30;          procedure WriteCntEml (pValue:Str30);
    function  ReadGrtType:Str1;          procedure WriteGrtType (pValue:Str1);
    function  ReadCusClm:byte;           procedure WriteCusClm (pValue:byte);
    function  ReadTkeName:Str30;         procedure WriteTkeName (pValue:Str30);
    function  ReadTkeDate:TDatetime;     procedure WriteTkeDate (pValue:TDatetime);
    function  ReadJudType:byte;          procedure WriteJudType (pValue:byte);
    function  ReadJudNoti:Str60;         procedure WriteJudNoti (pValue:Str60);
    function  ReadJudName:Str30;         procedure WriteJudName (pValue:Str30);
    function  ReadJudDate:TDatetime;     procedure WriteJudDate (pValue:TDatetime);
    function  ReadSolType:byte;          procedure WriteSolType (pValue:byte);
    function  ReadSolNoti:Str60;         procedure WriteSolNoti (pValue:Str60);
    function  ReadSolName:Str30;         procedure WriteSolName (pValue:Str30);
    function  ReadSolDate:TDatetime;     procedure WriteSolDate (pValue:TDatetime);
    function  ReadRepName:Str30;         procedure WriteRepName (pValue:Str30);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadSndDate:TDatetime;     procedure WriteSndDate (pValue:TDatetime);
    function  ReadRcvDate:TDatetime;     procedure WriteRcvDate (pValue:TDatetime);
    function  ReadRpaCode:longint;       procedure WriteRpaCode (pValue:longint);
    function  ReadMsgName:Str30;         procedure WriteMsgName (pValue:Str30);
    function  ReadMsgCode:Str10;         procedure WriteMsgCode (pValue:Str10);
    function  ReadMsgMode:Str20;         procedure WriteMsgMode (pValue:Str20);
    function  ReadMsgDate:TDatetime;     procedure WriteMsgDate (pValue:TDatetime);
    function  ReadRetName:Str30;         procedure WriteRetName (pValue:Str30);
    function  ReadRetCust:Str30;         procedure WriteRetCust (pValue:Str30);
    function  ReadRetCnum:Str10;         procedure WriteRetCnum (pValue:Str10);
    function  ReadRetDate:TDatetime;     procedure WriteRetDate (pValue:TDatetime);
    function  ReadRetPart:byte;          procedure WriteRetPart (pValue:byte);
    function  ReadRetType:byte;          procedure WriteRetType (pValue:byte);
    function  ReadClsName:Str30;         procedure WriteClsName (pValue:Str30);
    function  ReadClsDate:TDatetime;     procedure WriteClsDate (pValue:TDatetime);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadPdnDevi:Str30;         procedure WritePdnDevi (pValue:Str30);
    function  ReadPdnMoto:Str30;         procedure WritePdnMoto (pValue:Str30);
    function  ReadWrkHour:word;          procedure WriteWrkHour (pValue:word);
    function  ReadAcqDate:TDatetime;     procedure WriteAcqDate (pValue:TDatetime);
    function  ReadAcqDoc:Str12;          procedure WriteAcqDoc (pValue:Str12);
    function  ReadAcqBpc:double;         procedure WriteAcqBpc (pValue:double);
    function  ReadPdrDevi:Str30;         procedure WritePdrDevi (pValue:Str30);
    function  ReadPdrMoto:Str30;         procedure WritePdrMoto (pValue:Str30);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgHscVal:double;       procedure WriteFgHscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgEstVal:double;       procedure WriteFgEstVal (pValue:double);
    function  ReadFgMaxVal:double;       procedure WriteFgMaxVal (pValue:double);
    function  ReadFgAdvVal:double;       procedure WriteFgAdvVal (pValue:double);
    function  ReadFgMValue:double;       procedure WriteFgMValue (pValue:double);
    function  ReadFgWValue:double;       procedure WriteFgWValue (pValue:double);
    function  ReadFgGrtVal:double;       procedure WriteFgGrtVal (pValue:double);
    function  ReadFgAftVal:double;       procedure WriteFgAftVal (pValue:double);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgAValue1:double;      procedure WriteFgAValue1 (pValue:double);
    function  ReadFgAValue2:double;      procedure WriteFgAValue2 (pValue:double);
    function  ReadFgAValue3:double;      procedure WriteFgAValue3 (pValue:double);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadSpvNum:Str12;          procedure WriteSpvNum (pValue:Str12);
    function  ReadCldNum:Str12;          procedure WriteCldNum (pValue:Str12);
    function  ReadImdNum:Str12;          procedure WriteImdNum (pValue:Str12);
    function  ReadOmdNum:Str12;          procedure WriteOmdNum (pValue:Str12);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadAgiQnt:word;           procedure WriteAgiQnt (pValue:word);
    function  ReadGgiQnt:word;           procedure WriteGgiQnt (pValue:word);
    function  ReadAgsQnt:word;           procedure WriteAgsQnt (pValue:word);
    function  ReadGgsQnt:word;           procedure WriteGgsQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadGrtProt:Str12;         procedure WriteGrtProt (pValue:Str12);
    function  ReadGrtDate:TDatetime;     procedure WriteGrtDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMndName:Str30;         procedure WriteMndName (pValue:Str30);
    function  ReadIpaCode:longint;       procedure WriteIpaCode (pValue:longint);
    function  ReadSwrTime:TDatetime;     procedure WriteSwrTime (pValue:TDatetime);
    function  ReadFgDgnVal:double;       procedure WriteFgDgnVal (pValue:double);
    function  ReadCarType:Str30;         procedure WriteCarType (pValue:Str30);
    function  ReadCarNum:Str30;          procedure WriteCarNum (pValue:Str30);
    function  ReadCarCht:Str30;          procedure WriteCarCht (pValue:Str30);
    function  ReadCarChn:Str30;          procedure WriteCarChn (pValue:Str30);
    function  ReadCarGet:Str30;          procedure WriteCarGet (pValue:Str30);
    function  ReadCarGen:Str30;          procedure WriteCarGen (pValue:Str30);
    function  ReadCarClr:Str30;          procedure WriteCarClr (pValue:Str30);
    function  ReadCarCln:Str30;          procedure WriteCarCln (pValue:Str30);
    function  ReadCarReg:TDatetime;      procedure WriteCarReg (pValue:TDatetime);
    function  ReadCarTac:longint;        procedure WriteCarTac (pValue:longint);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
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
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateFgBValue (pFgBValue:double):boolean;
    function LocateDstCls (pDstCls:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestCrdNum (pCrdNum:Str20):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestFgBValue (pFgBValue:double):boolean;
    function NearestDstCls (pDstCls:byte):boolean;

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
    property PlnDate:TDatetime read ReadPlnDate write WritePlnDate;
    property PlnDay:word read ReadPlnDay write WritePlnDay;
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
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CntName:Str30 read ReadCntName write WriteCntName;
    property CntTel:Str20 read ReadCntTel write WriteCntTel;
    property CntMob:Str20 read ReadCntMob write WriteCntMob;
    property CntEml:Str30 read ReadCntEml write WriteCntEml;
    property GrtType:Str1 read ReadGrtType write WriteGrtType;
    property CusClm:byte read ReadCusClm write WriteCusClm;
    property TkeName:Str30 read ReadTkeName write WriteTkeName;
    property TkeDate:TDatetime read ReadTkeDate write WriteTkeDate;
    property JudType:byte read ReadJudType write WriteJudType;
    property JudNoti:Str60 read ReadJudNoti write WriteJudNoti;
    property JudName:Str30 read ReadJudName write WriteJudName;
    property JudDate:TDatetime read ReadJudDate write WriteJudDate;
    property SolType:byte read ReadSolType write WriteSolType;
    property SolNoti:Str60 read ReadSolNoti write WriteSolNoti;
    property SolName:Str30 read ReadSolName write WriteSolName;
    property SolDate:TDatetime read ReadSolDate write WriteSolDate;
    property RepName:Str30 read ReadRepName write WriteRepName;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property SndDate:TDatetime read ReadSndDate write WriteSndDate;
    property RcvDate:TDatetime read ReadRcvDate write WriteRcvDate;
    property RpaCode:longint read ReadRpaCode write WriteRpaCode;
    property MsgName:Str30 read ReadMsgName write WriteMsgName;
    property MsgCode:Str10 read ReadMsgCode write WriteMsgCode;
    property MsgMode:Str20 read ReadMsgMode write WriteMsgMode;
    property MsgDate:TDatetime read ReadMsgDate write WriteMsgDate;
    property RetName:Str30 read ReadRetName write WriteRetName;
    property RetCust:Str30 read ReadRetCust write WriteRetCust;
    property RetCnum:Str10 read ReadRetCnum write WriteRetCnum;
    property RetDate:TDatetime read ReadRetDate write WriteRetDate;
    property RetPart:byte read ReadRetPart write WriteRetPart;
    property RetType:byte read ReadRetType write WriteRetType;
    property ClsName:Str30 read ReadClsName write WriteClsName;
    property ClsDate:TDatetime read ReadClsDate write WriteClsDate;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property PdnDevi:Str30 read ReadPdnDevi write WritePdnDevi;
    property PdnMoto:Str30 read ReadPdnMoto write WritePdnMoto;
    property WrkHour:word read ReadWrkHour write WriteWrkHour;
    property AcqDate:TDatetime read ReadAcqDate write WriteAcqDate;
    property AcqDoc:Str12 read ReadAcqDoc write WriteAcqDoc;
    property AcqBpc:double read ReadAcqBpc write WriteAcqBpc;
    property PdrDevi:Str30 read ReadPdrDevi write WritePdrDevi;
    property PdrMoto:Str30 read ReadPdrMoto write WritePdrMoto;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgHscVal:double read ReadFgHscVal write WriteFgHscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgEstVal:double read ReadFgEstVal write WriteFgEstVal;
    property FgMaxVal:double read ReadFgMaxVal write WriteFgMaxVal;
    property FgAdvVal:double read ReadFgAdvVal write WriteFgAdvVal;
    property FgMValue:double read ReadFgMValue write WriteFgMValue;
    property FgWValue:double read ReadFgWValue write WriteFgWValue;
    property FgGrtVal:double read ReadFgGrtVal write WriteFgGrtVal;
    property FgAftVal:double read ReadFgAftVal write WriteFgAftVal;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgAValue1:double read ReadFgAValue1 write WriteFgAValue1;
    property FgAValue2:double read ReadFgAValue2 write WriteFgAValue2;
    property FgAValue3:double read ReadFgAValue3 write WriteFgAValue3;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property SpvNum:Str12 read ReadSpvNum write WriteSpvNum;
    property CldNum:Str12 read ReadCldNum write WriteCldNum;
    property ImdNum:Str12 read ReadImdNum write WriteImdNum;
    property OmdNum:Str12 read ReadOmdNum write WriteOmdNum;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property AgiQnt:word read ReadAgiQnt write WriteAgiQnt;
    property GgiQnt:word read ReadGgiQnt write WriteGgiQnt;
    property AgsQnt:word read ReadAgsQnt write WriteAgsQnt;
    property GgsQnt:word read ReadGgsQnt write WriteGgsQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property GrtProt:Str12 read ReadGrtProt write WriteGrtProt;
    property GrtDate:TDatetime read ReadGrtDate write WriteGrtDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MndName:Str30 read ReadMndName write WriteMndName;
    property IpaCode:longint read ReadIpaCode write WriteIpaCode;
    property SwrTime:TDatetime read ReadSwrTime write WriteSwrTime;
    property FgDgnVal:double read ReadFgDgnVal write WriteFgDgnVal;
    property CarType:Str30 read ReadCarType write WriteCarType;
    property CarNum:Str30 read ReadCarNum write WriteCarNum;
    property CarCht:Str30 read ReadCarCht write WriteCarCht;
    property CarChn:Str30 read ReadCarChn write WriteCarChn;
    property CarGet:Str30 read ReadCarGet write WriteCarGet;
    property CarGen:Str30 read ReadCarGen write WriteCarGen;
    property CarClr:Str30 read ReadCarClr write WriteCarClr;
    property CarCln:Str30 read ReadCarCln write WriteCarCln;
    property CarReg:TDatetime read ReadCarReg write WriteCarReg;
    property CarTac:longint read ReadCarTac write WriteCarTac;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TSchBtr.Create;
begin
  oBtrTable := BtrInit ('SCH',gPath.StkPath,Self);
end;

constructor TSchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCH',pPath,Self);
end;

destructor TSchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSchBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TSchBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TSchBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSchBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSchBtr.ReadPlnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PlnDate').AsDateTime;
end;

procedure TSchBtr.WritePlnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PlnDate').AsDateTime := pValue;
end;

function TSchBtr.ReadPlnDay:word;
begin
  Result := oBtrTable.FieldByName('PlnDay').AsInteger;
end;

procedure TSchBtr.WritePlnDay(pValue:word);
begin
  oBtrTable.FieldByName('PlnDay').AsInteger := pValue;
end;

function TSchBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSchBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSchBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TSchBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TSchBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TSchBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TSchBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TSchBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TSchBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TSchBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TSchBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TSchBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TSchBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TSchBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TSchBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TSchBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TSchBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TSchBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TSchBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TSchBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TSchBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TSchBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TSchBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TSchBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TSchBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TSchBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TSchBtr.ReadCntName:Str30;
begin
  Result := oBtrTable.FieldByName('CntName').AsString;
end;

procedure TSchBtr.WriteCntName(pValue:Str30);
begin
  oBtrTable.FieldByName('CntName').AsString := pValue;
end;

function TSchBtr.ReadCntTel:Str20;
begin
  Result := oBtrTable.FieldByName('CntTel').AsString;
end;

procedure TSchBtr.WriteCntTel(pValue:Str20);
begin
  oBtrTable.FieldByName('CntTel').AsString := pValue;
end;

function TSchBtr.ReadCntMob:Str20;
begin
  Result := oBtrTable.FieldByName('CntMob').AsString;
end;

procedure TSchBtr.WriteCntMob(pValue:Str20);
begin
  oBtrTable.FieldByName('CntMob').AsString := pValue;
end;

function TSchBtr.ReadCntEml:Str30;
begin
  Result := oBtrTable.FieldByName('CntEml').AsString;
end;

procedure TSchBtr.WriteCntEml(pValue:Str30);
begin
  oBtrTable.FieldByName('CntEml').AsString := pValue;
end;

function TSchBtr.ReadGrtType:Str1;
begin
  Result := oBtrTable.FieldByName('GrtType').AsString;
end;

procedure TSchBtr.WriteGrtType(pValue:Str1);
begin
  oBtrTable.FieldByName('GrtType').AsString := pValue;
end;

function TSchBtr.ReadCusClm:byte;
begin
  Result := oBtrTable.FieldByName('CusClm').AsInteger;
end;

procedure TSchBtr.WriteCusClm(pValue:byte);
begin
  oBtrTable.FieldByName('CusClm').AsInteger := pValue;
end;

function TSchBtr.ReadTkeName:Str30;
begin
  Result := oBtrTable.FieldByName('TkeName').AsString;
end;

procedure TSchBtr.WriteTkeName(pValue:Str30);
begin
  oBtrTable.FieldByName('TkeName').AsString := pValue;
end;

function TSchBtr.ReadTkeDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TkeDate').AsDateTime;
end;

procedure TSchBtr.WriteTkeDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TkeDate').AsDateTime := pValue;
end;

function TSchBtr.ReadJudType:byte;
begin
  Result := oBtrTable.FieldByName('JudType').AsInteger;
end;

procedure TSchBtr.WriteJudType(pValue:byte);
begin
  oBtrTable.FieldByName('JudType').AsInteger := pValue;
end;

function TSchBtr.ReadJudNoti:Str60;
begin
  Result := oBtrTable.FieldByName('JudNoti').AsString;
end;

procedure TSchBtr.WriteJudNoti(pValue:Str60);
begin
  oBtrTable.FieldByName('JudNoti').AsString := pValue;
end;

function TSchBtr.ReadJudName:Str30;
begin
  Result := oBtrTable.FieldByName('JudName').AsString;
end;

procedure TSchBtr.WriteJudName(pValue:Str30);
begin
  oBtrTable.FieldByName('JudName').AsString := pValue;
end;

function TSchBtr.ReadJudDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('JudDate').AsDateTime;
end;

procedure TSchBtr.WriteJudDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('JudDate').AsDateTime := pValue;
end;

function TSchBtr.ReadSolType:byte;
begin
  Result := oBtrTable.FieldByName('SolType').AsInteger;
end;

procedure TSchBtr.WriteSolType(pValue:byte);
begin
  oBtrTable.FieldByName('SolType').AsInteger := pValue;
end;

function TSchBtr.ReadSolNoti:Str60;
begin
  Result := oBtrTable.FieldByName('SolNoti').AsString;
end;

procedure TSchBtr.WriteSolNoti(pValue:Str60);
begin
  oBtrTable.FieldByName('SolNoti').AsString := pValue;
end;

function TSchBtr.ReadSolName:Str30;
begin
  Result := oBtrTable.FieldByName('SolName').AsString;
end;

procedure TSchBtr.WriteSolName(pValue:Str30);
begin
  oBtrTable.FieldByName('SolName').AsString := pValue;
end;

function TSchBtr.ReadSolDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SolDate').AsDateTime;
end;

procedure TSchBtr.WriteSolDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SolDate').AsDateTime := pValue;
end;

function TSchBtr.ReadRepName:Str30;
begin
  Result := oBtrTable.FieldByName('RepName').AsString;
end;

procedure TSchBtr.WriteRepName(pValue:Str30);
begin
  oBtrTable.FieldByName('RepName').AsString := pValue;
end;

function TSchBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TSchBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TSchBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TSchBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TSchBtr.ReadSndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SndDate').AsDateTime;
end;

procedure TSchBtr.WriteSndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TSchBtr.ReadRcvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RcvDate').AsDateTime;
end;

procedure TSchBtr.WriteRcvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RcvDate').AsDateTime := pValue;
end;

function TSchBtr.ReadRpaCode:longint;
begin
  Result := oBtrTable.FieldByName('RpaCode').AsInteger;
end;

procedure TSchBtr.WriteRpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('RpaCode').AsInteger := pValue;
end;

function TSchBtr.ReadMsgName:Str30;
begin
  Result := oBtrTable.FieldByName('MsgName').AsString;
end;

procedure TSchBtr.WriteMsgName(pValue:Str30);
begin
  oBtrTable.FieldByName('MsgName').AsString := pValue;
end;

function TSchBtr.ReadMsgCode:Str10;
begin
  Result := oBtrTable.FieldByName('MsgCode').AsString;
end;

procedure TSchBtr.WriteMsgCode(pValue:Str10);
begin
  oBtrTable.FieldByName('MsgCode').AsString := pValue;
end;

function TSchBtr.ReadMsgMode:Str20;
begin
  Result := oBtrTable.FieldByName('MsgMode').AsString;
end;

procedure TSchBtr.WriteMsgMode(pValue:Str20);
begin
  oBtrTable.FieldByName('MsgMode').AsString := pValue;
end;

function TSchBtr.ReadMsgDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('MsgDate').AsDateTime;
end;

procedure TSchBtr.WriteMsgDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MsgDate').AsDateTime := pValue;
end;

function TSchBtr.ReadRetName:Str30;
begin
  Result := oBtrTable.FieldByName('RetName').AsString;
end;

procedure TSchBtr.WriteRetName(pValue:Str30);
begin
  oBtrTable.FieldByName('RetName').AsString := pValue;
end;

function TSchBtr.ReadRetCust:Str30;
begin
  Result := oBtrTable.FieldByName('RetCust').AsString;
end;

procedure TSchBtr.WriteRetCust(pValue:Str30);
begin
  oBtrTable.FieldByName('RetCust').AsString := pValue;
end;

function TSchBtr.ReadRetCnum:Str10;
begin
  Result := oBtrTable.FieldByName('RetCnum').AsString;
end;

procedure TSchBtr.WriteRetCnum(pValue:Str10);
begin
  oBtrTable.FieldByName('RetCnum').AsString := pValue;
end;

function TSchBtr.ReadRetDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RetDate').AsDateTime;
end;

procedure TSchBtr.WriteRetDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RetDate').AsDateTime := pValue;
end;

function TSchBtr.ReadRetPart:byte;
begin
  Result := oBtrTable.FieldByName('RetPart').AsInteger;
end;

procedure TSchBtr.WriteRetPart(pValue:byte);
begin
  oBtrTable.FieldByName('RetPart').AsInteger := pValue;
end;

function TSchBtr.ReadRetType:byte;
begin
  Result := oBtrTable.FieldByName('RetType').AsInteger;
end;

procedure TSchBtr.WriteRetType(pValue:byte);
begin
  oBtrTable.FieldByName('RetType').AsInteger := pValue;
end;

function TSchBtr.ReadClsName:Str30;
begin
  Result := oBtrTable.FieldByName('ClsName').AsString;
end;

procedure TSchBtr.WriteClsName(pValue:Str30);
begin
  oBtrTable.FieldByName('ClsName').AsString := pValue;
end;

function TSchBtr.ReadClsDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ClsDate').AsDateTime;
end;

procedure TSchBtr.WriteClsDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ClsDate').AsDateTime := pValue;
end;

function TSchBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSchBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSchBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSchBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSchBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSchBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSchBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSchBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSchBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSchBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSchBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TSchBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TSchBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSchBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSchBtr.ReadPdnDevi:Str30;
begin
  Result := oBtrTable.FieldByName('PdnDevi').AsString;
end;

procedure TSchBtr.WritePdnDevi(pValue:Str30);
begin
  oBtrTable.FieldByName('PdnDevi').AsString := pValue;
end;

function TSchBtr.ReadPdnMoto:Str30;
begin
  Result := oBtrTable.FieldByName('PdnMoto').AsString;
end;

procedure TSchBtr.WritePdnMoto(pValue:Str30);
begin
  oBtrTable.FieldByName('PdnMoto').AsString := pValue;
end;

function TSchBtr.ReadWrkHour:word;
begin
  Result := oBtrTable.FieldByName('WrkHour').AsInteger;
end;

procedure TSchBtr.WriteWrkHour(pValue:word);
begin
  oBtrTable.FieldByName('WrkHour').AsInteger := pValue;
end;

function TSchBtr.ReadAcqDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AcqDate').AsDateTime;
end;

procedure TSchBtr.WriteAcqDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AcqDate').AsDateTime := pValue;
end;

function TSchBtr.ReadAcqDoc:Str12;
begin
  Result := oBtrTable.FieldByName('AcqDoc').AsString;
end;

procedure TSchBtr.WriteAcqDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('AcqDoc').AsString := pValue;
end;

function TSchBtr.ReadAcqBpc:double;
begin
  Result := oBtrTable.FieldByName('AcqBpc').AsFloat;
end;

procedure TSchBtr.WriteAcqBpc(pValue:double);
begin
  oBtrTable.FieldByName('AcqBpc').AsFloat := pValue;
end;

function TSchBtr.ReadPdrDevi:Str30;
begin
  Result := oBtrTable.FieldByName('PdrDevi').AsString;
end;

procedure TSchBtr.WritePdrDevi(pValue:Str30);
begin
  oBtrTable.FieldByName('PdrDevi').AsString := pValue;
end;

function TSchBtr.ReadPdrMoto:Str30;
begin
  Result := oBtrTable.FieldByName('PdrMoto').AsString;
end;

procedure TSchBtr.WritePdrMoto(pValue:Str30);
begin
  oBtrTable.FieldByName('PdrMoto').AsString := pValue;
end;

function TSchBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TSchBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TSchBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TSchBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TSchBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TSchBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TSchBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TSchBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TSchBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TSchBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TSchBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TSchBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TSchBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TSchBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TSchBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgHValue:double;
begin
  Result := oBtrTable.FieldByName('FgHValue').AsFloat;
end;

procedure TSchBtr.WriteFgHValue(pValue:double);
begin
  oBtrTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TSchBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgHscVal:double;
begin
  Result := oBtrTable.FieldByName('FgHscVal').AsFloat;
end;

procedure TSchBtr.WriteFgHscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHscVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TSchBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TSchBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TSchBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgEstVal:double;
begin
  Result := oBtrTable.FieldByName('FgEstVal').AsFloat;
end;

procedure TSchBtr.WriteFgEstVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEstVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgMaxVal:double;
begin
  Result := oBtrTable.FieldByName('FgMaxVal').AsFloat;
end;

procedure TSchBtr.WriteFgMaxVal(pValue:double);
begin
  oBtrTable.FieldByName('FgMaxVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgAdvVal:double;
begin
  Result := oBtrTable.FieldByName('FgAdvVal').AsFloat;
end;

procedure TSchBtr.WriteFgAdvVal(pValue:double);
begin
  oBtrTable.FieldByName('FgAdvVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgMValue:double;
begin
  Result := oBtrTable.FieldByName('FgMValue').AsFloat;
end;

procedure TSchBtr.WriteFgMValue(pValue:double);
begin
  oBtrTable.FieldByName('FgMValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgWValue:double;
begin
  Result := oBtrTable.FieldByName('FgWValue').AsFloat;
end;

procedure TSchBtr.WriteFgWValue(pValue:double);
begin
  oBtrTable.FieldByName('FgWValue').AsFloat := pValue;
end;

function TSchBtr.ReadFgGrtVal:double;
begin
  Result := oBtrTable.FieldByName('FgGrtVal').AsFloat;
end;

procedure TSchBtr.WriteFgGrtVal(pValue:double);
begin
  oBtrTable.FieldByName('FgGrtVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgAftVal:double;
begin
  Result := oBtrTable.FieldByName('FgAftVal').AsFloat;
end;

procedure TSchBtr.WriteFgAftVal(pValue:double);
begin
  oBtrTable.FieldByName('FgAftVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TSchBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TSchBtr.ReadFgAValue1:double;
begin
  Result := oBtrTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TSchBtr.WriteFgAValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TSchBtr.ReadFgAValue2:double;
begin
  Result := oBtrTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TSchBtr.WriteFgAValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TSchBtr.ReadFgAValue3:double;
begin
  Result := oBtrTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TSchBtr.WriteFgAValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TSchBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TSchBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TSchBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TSchBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TSchBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TSchBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TSchBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TSchBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TSchBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TSchBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TSchBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TSchBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TSchBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TSchBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TSchBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TSchBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TSchBtr.ReadSpvNum:Str12;
begin
  Result := oBtrTable.FieldByName('SpvNum').AsString;
end;

procedure TSchBtr.WriteSpvNum(pValue:Str12);
begin
  oBtrTable.FieldByName('SpvNum').AsString := pValue;
end;

function TSchBtr.ReadCldNum:Str12;
begin
  Result := oBtrTable.FieldByName('CldNum').AsString;
end;

procedure TSchBtr.WriteCldNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CldNum').AsString := pValue;
end;

function TSchBtr.ReadImdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ImdNum').AsString;
end;

procedure TSchBtr.WriteImdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ImdNum').AsString := pValue;
end;

function TSchBtr.ReadOmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OmdNum').AsString;
end;

procedure TSchBtr.WriteOmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OmdNum').AsString := pValue;
end;

function TSchBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TSchBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TSchBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSchBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSchBtr.ReadAgiQnt:word;
begin
  Result := oBtrTable.FieldByName('AgiQnt').AsInteger;
end;

procedure TSchBtr.WriteAgiQnt(pValue:word);
begin
  oBtrTable.FieldByName('AgiQnt').AsInteger := pValue;
end;

function TSchBtr.ReadGgiQnt:word;
begin
  Result := oBtrTable.FieldByName('GgiQnt').AsInteger;
end;

procedure TSchBtr.WriteGgiQnt(pValue:word);
begin
  oBtrTable.FieldByName('GgiQnt').AsInteger := pValue;
end;

function TSchBtr.ReadAgsQnt:word;
begin
  Result := oBtrTable.FieldByName('AgsQnt').AsInteger;
end;

procedure TSchBtr.WriteAgsQnt(pValue:word);
begin
  oBtrTable.FieldByName('AgsQnt').AsInteger := pValue;
end;

function TSchBtr.ReadGgsQnt:word;
begin
  Result := oBtrTable.FieldByName('GgsQnt').AsInteger;
end;

procedure TSchBtr.WriteGgsQnt(pValue:word);
begin
  oBtrTable.FieldByName('GgsQnt').AsInteger := pValue;
end;

function TSchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TSchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TSchBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TSchBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TSchBtr.ReadGrtProt:Str12;
begin
  Result := oBtrTable.FieldByName('GrtProt').AsString;
end;

procedure TSchBtr.WriteGrtProt(pValue:Str12);
begin
  oBtrTable.FieldByName('GrtProt').AsString := pValue;
end;

function TSchBtr.ReadGrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('GrtDate').AsDateTime;
end;

procedure TSchBtr.WriteGrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('GrtDate').AsDateTime := pValue;
end;

function TSchBtr.ReadPayDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PayDate').AsDateTime;
end;

procedure TSchBtr.WritePayDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TSchBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TSchBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TSchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSchBtr.ReadMndName:Str30;
begin
  Result := oBtrTable.FieldByName('MndName').AsString;
end;

procedure TSchBtr.WriteMndName(pValue:Str30);
begin
  oBtrTable.FieldByName('MndName').AsString := pValue;
end;

function TSchBtr.ReadIpaCode:longint;
begin
  Result := oBtrTable.FieldByName('IpaCode').AsInteger;
end;

procedure TSchBtr.WriteIpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('IpaCode').AsInteger := pValue;
end;

function TSchBtr.ReadSwrTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('SwrTime').AsDateTime;
end;

procedure TSchBtr.WriteSwrTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SwrTime').AsDateTime := pValue;
end;

function TSchBtr.ReadFgDgnVal:double;
begin
  Result := oBtrTable.FieldByName('FgDgnVal').AsFloat;
end;

procedure TSchBtr.WriteFgDgnVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDgnVal').AsFloat := pValue;
end;

function TSchBtr.ReadCarType:Str30;
begin
  Result := oBtrTable.FieldByName('CarType').AsString;
end;

procedure TSchBtr.WriteCarType(pValue:Str30);
begin
  oBtrTable.FieldByName('CarType').AsString := pValue;
end;

function TSchBtr.ReadCarNum:Str30;
begin
  Result := oBtrTable.FieldByName('CarNum').AsString;
end;

procedure TSchBtr.WriteCarNum(pValue:Str30);
begin
  oBtrTable.FieldByName('CarNum').AsString := pValue;
end;

function TSchBtr.ReadCarCht:Str30;
begin
  Result := oBtrTable.FieldByName('CarCht').AsString;
end;

procedure TSchBtr.WriteCarCht(pValue:Str30);
begin
  oBtrTable.FieldByName('CarCht').AsString := pValue;
end;

function TSchBtr.ReadCarChn:Str30;
begin
  Result := oBtrTable.FieldByName('CarChn').AsString;
end;

procedure TSchBtr.WriteCarChn(pValue:Str30);
begin
  oBtrTable.FieldByName('CarChn').AsString := pValue;
end;

function TSchBtr.ReadCarGet:Str30;
begin
  Result := oBtrTable.FieldByName('CarGet').AsString;
end;

procedure TSchBtr.WriteCarGet(pValue:Str30);
begin
  oBtrTable.FieldByName('CarGet').AsString := pValue;
end;

function TSchBtr.ReadCarGen:Str30;
begin
  Result := oBtrTable.FieldByName('CarGen').AsString;
end;

procedure TSchBtr.WriteCarGen(pValue:Str30);
begin
  oBtrTable.FieldByName('CarGen').AsString := pValue;
end;

function TSchBtr.ReadCarClr:Str30;
begin
  Result := oBtrTable.FieldByName('CarClr').AsString;
end;

procedure TSchBtr.WriteCarClr(pValue:Str30);
begin
  oBtrTable.FieldByName('CarClr').AsString := pValue;
end;

function TSchBtr.ReadCarCln:Str30;
begin
  Result := oBtrTable.FieldByName('CarCln').AsString;
end;

procedure TSchBtr.WriteCarCln(pValue:Str30);
begin
  oBtrTable.FieldByName('CarCln').AsString := pValue;
end;

function TSchBtr.ReadCarReg:TDatetime;
begin
  Result := oBtrTable.FieldByName('CarReg').AsDateTime;
end;

procedure TSchBtr.WriteCarReg(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CarReg').AsDateTime := pValue;
end;

function TSchBtr.ReadCarTac:longint;
begin
  Result := oBtrTable.FieldByName('CarTac').AsInteger;
end;

procedure TSchBtr.WriteCarTac(pValue:longint);
begin
  oBtrTable.FieldByName('CarTac').AsInteger := pValue;
end;

function TSchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TSchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TSchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSchBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TSchBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSchBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TSchBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TSchBtr.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindKey([pCrdNum]);
end;

function TSchBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TSchBtr.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindKey([pFgBValue]);
end;

function TSchBtr.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindKey([pDstCls]);
end;

function TSchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TSchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSchBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TSchBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSchBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TSchBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TSchBtr.NearestCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindNearest([pCrdNum]);
end;

function TSchBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TSchBtr.NearestFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oBtrTable.FindNearest([pFgBValue]);
end;

function TSchBtr.NearestDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindNearest([pDstCls]);
end;

procedure TSchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSchBtr.First;
begin
  oBtrTable.First;
end;

procedure TSchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
