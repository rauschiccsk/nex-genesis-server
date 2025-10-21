unit tSCH;

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
  ixFgBValue = 'FgBValue';

type
  TSchTmp = class (TComponent)
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
    function  ReadIpaCode:longint;       procedure WriteIpaCode (pValue:longint);
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
    function  ReadFgDgnVal:double;       procedure WriteFgDgnVal (pValue:double);
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
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadGrtProt:Str12;         procedure WriteGrtProt (pValue:Str12);
    function  ReadGrtDate:TDatetime;     procedure WriteGrtDate (pValue:TDatetime);
    function  ReadPayDate:TDatetime;     procedure WritePayDate (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadGrtStat:Str1;          procedure WriteGrtStat (pValue:Str1);
    function  ReadNgrStat:Str1;          procedure WriteNgrStat (pValue:Str1);
    function  ReadClmStat:Str1;          procedure WriteClmStat (pValue:Str1);
    function  ReadRetStat:Str1;          procedure WriteRetStat (pValue:Str1);
    function  ReadSwrTime:TDatetime;     procedure WriteSwrTime (pValue:TDatetime);
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
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMndName:Str30;         procedure WriteMndName (pValue:Str30);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
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
    property IpaCode:longint read ReadIpaCode write WriteIpaCode;
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
    property FgDgnVal:double read ReadFgDgnVal write WriteFgDgnVal;
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
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property GrtProt:Str12 read ReadGrtProt write WriteGrtProt;
    property GrtDate:TDatetime read ReadGrtDate write WriteGrtDate;
    property PayDate:TDatetime read ReadPayDate write WritePayDate;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property GrtStat:Str1 read ReadGrtStat write WriteGrtStat;
    property NgrStat:Str1 read ReadNgrStat write WriteNgrStat;
    property ClmStat:Str1 read ReadClmStat write WriteClmStat;
    property RetStat:Str1 read ReadRetStat write WriteRetStat;
    property SwrTime:TDatetime read ReadSwrTime write WriteSwrTime;
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
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MndName:Str30 read ReadMndName write WriteMndName;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSchTmp.Create;
begin
  oTmpTable := TmpInit ('SCH',Self);
end;

destructor TSchTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSchTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSchTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSchTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSchTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSchTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TSchTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TSchTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TSchTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSchTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TSchTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TSchTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSchTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSchTmp.ReadPlnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PlnDate').AsDateTime;
end;

procedure TSchTmp.WritePlnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PlnDate').AsDateTime := pValue;
end;

function TSchTmp.ReadPlnDay:word;
begin
  Result := oTmpTable.FieldByName('PlnDay').AsInteger;
end;

procedure TSchTmp.WritePlnDay(pValue:word);
begin
  oTmpTable.FieldByName('PlnDay').AsInteger := pValue;
end;

function TSchTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSchTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSchTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSchTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSchTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TSchTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TSchTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TSchTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TSchTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TSchTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TSchTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TSchTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TSchTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TSchTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TSchTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TSchTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TSchTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TSchTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TSchTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TSchTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TSchTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TSchTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TSchTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TSchTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TSchTmp.ReadCrdNum:Str20;
begin
  Result := oTmpTable.FieldByName('CrdNum').AsString;
end;

procedure TSchTmp.WriteCrdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('CrdNum').AsString := pValue;
end;

function TSchTmp.ReadCntName:Str30;
begin
  Result := oTmpTable.FieldByName('CntName').AsString;
end;

procedure TSchTmp.WriteCntName(pValue:Str30);
begin
  oTmpTable.FieldByName('CntName').AsString := pValue;
end;

function TSchTmp.ReadCntTel:Str20;
begin
  Result := oTmpTable.FieldByName('CntTel').AsString;
end;

procedure TSchTmp.WriteCntTel(pValue:Str20);
begin
  oTmpTable.FieldByName('CntTel').AsString := pValue;
end;

function TSchTmp.ReadCntMob:Str20;
begin
  Result := oTmpTable.FieldByName('CntMob').AsString;
end;

procedure TSchTmp.WriteCntMob(pValue:Str20);
begin
  oTmpTable.FieldByName('CntMob').AsString := pValue;
end;

function TSchTmp.ReadCntEml:Str30;
begin
  Result := oTmpTable.FieldByName('CntEml').AsString;
end;

procedure TSchTmp.WriteCntEml(pValue:Str30);
begin
  oTmpTable.FieldByName('CntEml').AsString := pValue;
end;

function TSchTmp.ReadGrtType:Str1;
begin
  Result := oTmpTable.FieldByName('GrtType').AsString;
end;

procedure TSchTmp.WriteGrtType(pValue:Str1);
begin
  oTmpTable.FieldByName('GrtType').AsString := pValue;
end;

function TSchTmp.ReadCusClm:byte;
begin
  Result := oTmpTable.FieldByName('CusClm').AsInteger;
end;

procedure TSchTmp.WriteCusClm(pValue:byte);
begin
  oTmpTable.FieldByName('CusClm').AsInteger := pValue;
end;

function TSchTmp.ReadTkeName:Str30;
begin
  Result := oTmpTable.FieldByName('TkeName').AsString;
end;

procedure TSchTmp.WriteTkeName(pValue:Str30);
begin
  oTmpTable.FieldByName('TkeName').AsString := pValue;
end;

function TSchTmp.ReadTkeDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TkeDate').AsDateTime;
end;

procedure TSchTmp.WriteTkeDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TkeDate').AsDateTime := pValue;
end;

function TSchTmp.ReadJudType:byte;
begin
  Result := oTmpTable.FieldByName('JudType').AsInteger;
end;

procedure TSchTmp.WriteJudType(pValue:byte);
begin
  oTmpTable.FieldByName('JudType').AsInteger := pValue;
end;

function TSchTmp.ReadJudNoti:Str60;
begin
  Result := oTmpTable.FieldByName('JudNoti').AsString;
end;

procedure TSchTmp.WriteJudNoti(pValue:Str60);
begin
  oTmpTable.FieldByName('JudNoti').AsString := pValue;
end;

function TSchTmp.ReadJudName:Str30;
begin
  Result := oTmpTable.FieldByName('JudName').AsString;
end;

procedure TSchTmp.WriteJudName(pValue:Str30);
begin
  oTmpTable.FieldByName('JudName').AsString := pValue;
end;

function TSchTmp.ReadJudDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('JudDate').AsDateTime;
end;

procedure TSchTmp.WriteJudDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('JudDate').AsDateTime := pValue;
end;

function TSchTmp.ReadSolType:byte;
begin
  Result := oTmpTable.FieldByName('SolType').AsInteger;
end;

procedure TSchTmp.WriteSolType(pValue:byte);
begin
  oTmpTable.FieldByName('SolType').AsInteger := pValue;
end;

function TSchTmp.ReadSolNoti:Str60;
begin
  Result := oTmpTable.FieldByName('SolNoti').AsString;
end;

procedure TSchTmp.WriteSolNoti(pValue:Str60);
begin
  oTmpTable.FieldByName('SolNoti').AsString := pValue;
end;

function TSchTmp.ReadSolName:Str30;
begin
  Result := oTmpTable.FieldByName('SolName').AsString;
end;

procedure TSchTmp.WriteSolName(pValue:Str30);
begin
  oTmpTable.FieldByName('SolName').AsString := pValue;
end;

function TSchTmp.ReadSolDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SolDate').AsDateTime;
end;

procedure TSchTmp.WriteSolDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SolDate').AsDateTime := pValue;
end;

function TSchTmp.ReadRepName:Str30;
begin
  Result := oTmpTable.FieldByName('RepName').AsString;
end;

procedure TSchTmp.WriteRepName(pValue:Str30);
begin
  oTmpTable.FieldByName('RepName').AsString := pValue;
end;

function TSchTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TSchTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TSchTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TSchTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TSchTmp.ReadSndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TSchTmp.WriteSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime := pValue;
end;

function TSchTmp.ReadRcvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RcvDate').AsDateTime;
end;

procedure TSchTmp.WriteRcvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RcvDate').AsDateTime := pValue;
end;

function TSchTmp.ReadRpaCode:longint;
begin
  Result := oTmpTable.FieldByName('RpaCode').AsInteger;
end;

procedure TSchTmp.WriteRpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('RpaCode').AsInteger := pValue;
end;

function TSchTmp.ReadIpaCode:longint;
begin
  Result := oTmpTable.FieldByName('IpaCode').AsInteger;
end;

procedure TSchTmp.WriteIpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('IpaCode').AsInteger := pValue;
end;

function TSchTmp.ReadMsgName:Str30;
begin
  Result := oTmpTable.FieldByName('MsgName').AsString;
end;

procedure TSchTmp.WriteMsgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MsgName').AsString := pValue;
end;

function TSchTmp.ReadMsgCode:Str10;
begin
  Result := oTmpTable.FieldByName('MsgCode').AsString;
end;

procedure TSchTmp.WriteMsgCode(pValue:Str10);
begin
  oTmpTable.FieldByName('MsgCode').AsString := pValue;
end;

function TSchTmp.ReadMsgMode:Str20;
begin
  Result := oTmpTable.FieldByName('MsgMode').AsString;
end;

procedure TSchTmp.WriteMsgMode(pValue:Str20);
begin
  oTmpTable.FieldByName('MsgMode').AsString := pValue;
end;

function TSchTmp.ReadMsgDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('MsgDate').AsDateTime;
end;

procedure TSchTmp.WriteMsgDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('MsgDate').AsDateTime := pValue;
end;

function TSchTmp.ReadRetName:Str30;
begin
  Result := oTmpTable.FieldByName('RetName').AsString;
end;

procedure TSchTmp.WriteRetName(pValue:Str30);
begin
  oTmpTable.FieldByName('RetName').AsString := pValue;
end;

function TSchTmp.ReadRetCust:Str30;
begin
  Result := oTmpTable.FieldByName('RetCust').AsString;
end;

procedure TSchTmp.WriteRetCust(pValue:Str30);
begin
  oTmpTable.FieldByName('RetCust').AsString := pValue;
end;

function TSchTmp.ReadRetCnum:Str10;
begin
  Result := oTmpTable.FieldByName('RetCnum').AsString;
end;

procedure TSchTmp.WriteRetCnum(pValue:Str10);
begin
  oTmpTable.FieldByName('RetCnum').AsString := pValue;
end;

function TSchTmp.ReadRetDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RetDate').AsDateTime;
end;

procedure TSchTmp.WriteRetDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RetDate').AsDateTime := pValue;
end;

function TSchTmp.ReadRetPart:byte;
begin
  Result := oTmpTable.FieldByName('RetPart').AsInteger;
end;

procedure TSchTmp.WriteRetPart(pValue:byte);
begin
  oTmpTable.FieldByName('RetPart').AsInteger := pValue;
end;

function TSchTmp.ReadRetType:byte;
begin
  Result := oTmpTable.FieldByName('RetType').AsInteger;
end;

procedure TSchTmp.WriteRetType(pValue:byte);
begin
  oTmpTable.FieldByName('RetType').AsInteger := pValue;
end;

function TSchTmp.ReadClsName:Str30;
begin
  Result := oTmpTable.FieldByName('ClsName').AsString;
end;

procedure TSchTmp.WriteClsName(pValue:Str30);
begin
  oTmpTable.FieldByName('ClsName').AsString := pValue;
end;

function TSchTmp.ReadClsDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ClsDate').AsDateTime;
end;

procedure TSchTmp.WriteClsDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ClsDate').AsDateTime := pValue;
end;

function TSchTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSchTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSchTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSchTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSchTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSchTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSchTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSchTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSchTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSchTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSchTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSchTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSchTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSchTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSchTmp.ReadPdnDevi:Str30;
begin
  Result := oTmpTable.FieldByName('PdnDevi').AsString;
end;

procedure TSchTmp.WritePdnDevi(pValue:Str30);
begin
  oTmpTable.FieldByName('PdnDevi').AsString := pValue;
end;

function TSchTmp.ReadPdnMoto:Str30;
begin
  Result := oTmpTable.FieldByName('PdnMoto').AsString;
end;

procedure TSchTmp.WritePdnMoto(pValue:Str30);
begin
  oTmpTable.FieldByName('PdnMoto').AsString := pValue;
end;

function TSchTmp.ReadWrkHour:word;
begin
  Result := oTmpTable.FieldByName('WrkHour').AsInteger;
end;

procedure TSchTmp.WriteWrkHour(pValue:word);
begin
  oTmpTable.FieldByName('WrkHour').AsInteger := pValue;
end;

function TSchTmp.ReadAcqDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AcqDate').AsDateTime;
end;

procedure TSchTmp.WriteAcqDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AcqDate').AsDateTime := pValue;
end;

function TSchTmp.ReadAcqDoc:Str12;
begin
  Result := oTmpTable.FieldByName('AcqDoc').AsString;
end;

procedure TSchTmp.WriteAcqDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('AcqDoc').AsString := pValue;
end;

function TSchTmp.ReadAcqBpc:double;
begin
  Result := oTmpTable.FieldByName('AcqBpc').AsFloat;
end;

procedure TSchTmp.WriteAcqBpc(pValue:double);
begin
  oTmpTable.FieldByName('AcqBpc').AsFloat := pValue;
end;

function TSchTmp.ReadPdrDevi:Str30;
begin
  Result := oTmpTable.FieldByName('PdrDevi').AsString;
end;

procedure TSchTmp.WritePdrDevi(pValue:Str30);
begin
  oTmpTable.FieldByName('PdrDevi').AsString := pValue;
end;

function TSchTmp.ReadPdrMoto:Str30;
begin
  Result := oTmpTable.FieldByName('PdrMoto').AsString;
end;

procedure TSchTmp.WritePdrMoto(pValue:Str30);
begin
  oTmpTable.FieldByName('PdrMoto').AsString := pValue;
end;

function TSchTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TSchTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TSchTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TSchTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TSchTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TSchTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TSchTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TSchTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TSchTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TSchTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TSchTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TSchTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TSchTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TSchTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TSchTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgHValue:double;
begin
  Result := oTmpTable.FieldByName('FgHValue').AsFloat;
end;

procedure TSchTmp.WriteFgHValue(pValue:double);
begin
  oTmpTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TSchTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgHscVal:double;
begin
  Result := oTmpTable.FieldByName('FgHscVal').AsFloat;
end;

procedure TSchTmp.WriteFgHscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHscVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TSchTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TSchTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TSchTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgEstVal:double;
begin
  Result := oTmpTable.FieldByName('FgEstVal').AsFloat;
end;

procedure TSchTmp.WriteFgEstVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEstVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgMaxVal:double;
begin
  Result := oTmpTable.FieldByName('FgMaxVal').AsFloat;
end;

procedure TSchTmp.WriteFgMaxVal(pValue:double);
begin
  oTmpTable.FieldByName('FgMaxVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgAdvVal:double;
begin
  Result := oTmpTable.FieldByName('FgAdvVal').AsFloat;
end;

procedure TSchTmp.WriteFgAdvVal(pValue:double);
begin
  oTmpTable.FieldByName('FgAdvVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgMValue:double;
begin
  Result := oTmpTable.FieldByName('FgMValue').AsFloat;
end;

procedure TSchTmp.WriteFgMValue(pValue:double);
begin
  oTmpTable.FieldByName('FgMValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgWValue:double;
begin
  Result := oTmpTable.FieldByName('FgWValue').AsFloat;
end;

procedure TSchTmp.WriteFgWValue(pValue:double);
begin
  oTmpTable.FieldByName('FgWValue').AsFloat := pValue;
end;

function TSchTmp.ReadFgGrtVal:double;
begin
  Result := oTmpTable.FieldByName('FgGrtVal').AsFloat;
end;

procedure TSchTmp.WriteFgGrtVal(pValue:double);
begin
  oTmpTable.FieldByName('FgGrtVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgAftVal:double;
begin
  Result := oTmpTable.FieldByName('FgAftVal').AsFloat;
end;

procedure TSchTmp.WriteFgAftVal(pValue:double);
begin
  oTmpTable.FieldByName('FgAftVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgEndVal:double;
begin
  Result := oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TSchTmp.WriteFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgDgnVal:double;
begin
  Result := oTmpTable.FieldByName('FgDgnVal').AsFloat;
end;

procedure TSchTmp.WriteFgDgnVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDgnVal').AsFloat := pValue;
end;

function TSchTmp.ReadFgAValue1:double;
begin
  Result := oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TSchTmp.WriteFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat := pValue;
end;

function TSchTmp.ReadFgAValue2:double;
begin
  Result := oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TSchTmp.WriteFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat := pValue;
end;

function TSchTmp.ReadFgAValue3:double;
begin
  Result := oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TSchTmp.WriteFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat := pValue;
end;

function TSchTmp.ReadFgBValue1:double;
begin
  Result := oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TSchTmp.WriteFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TSchTmp.ReadFgBValue2:double;
begin
  Result := oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TSchTmp.WriteFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TSchTmp.ReadFgBValue3:double;
begin
  Result := oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TSchTmp.WriteFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TSchTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TSchTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TSchTmp.ReadCusCard:Str20;
begin
  Result := oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TSchTmp.WriteCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString := pValue;
end;

function TSchTmp.ReadCsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('CsdNum').AsString;
end;

procedure TSchTmp.WriteCsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CsdNum').AsString := pValue;
end;

function TSchTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TSchTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TSchTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TSchTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TSchTmp.ReadSpvNum:Str12;
begin
  Result := oTmpTable.FieldByName('SpvNum').AsString;
end;

procedure TSchTmp.WriteSpvNum(pValue:Str12);
begin
  oTmpTable.FieldByName('SpvNum').AsString := pValue;
end;

function TSchTmp.ReadCldNum:Str12;
begin
  Result := oTmpTable.FieldByName('CldNum').AsString;
end;

procedure TSchTmp.WriteCldNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CldNum').AsString := pValue;
end;

function TSchTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TSchTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TSchTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSchTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSchTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TSchTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TSchTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TSchTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TSchTmp.ReadGrtProt:Str12;
begin
  Result := oTmpTable.FieldByName('GrtProt').AsString;
end;

procedure TSchTmp.WriteGrtProt(pValue:Str12);
begin
  oTmpTable.FieldByName('GrtProt').AsString := pValue;
end;

function TSchTmp.ReadGrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('GrtDate').AsDateTime;
end;

procedure TSchTmp.WriteGrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('GrtDate').AsDateTime := pValue;
end;

function TSchTmp.ReadPayDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TSchTmp.WritePayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime := pValue;
end;

function TSchTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TSchTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TSchTmp.ReadGrtStat:Str1;
begin
  Result := oTmpTable.FieldByName('GrtStat').AsString;
end;

procedure TSchTmp.WriteGrtStat(pValue:Str1);
begin
  oTmpTable.FieldByName('GrtStat').AsString := pValue;
end;

function TSchTmp.ReadNgrStat:Str1;
begin
  Result := oTmpTable.FieldByName('NgrStat').AsString;
end;

procedure TSchTmp.WriteNgrStat(pValue:Str1);
begin
  oTmpTable.FieldByName('NgrStat').AsString := pValue;
end;

function TSchTmp.ReadClmStat:Str1;
begin
  Result := oTmpTable.FieldByName('ClmStat').AsString;
end;

procedure TSchTmp.WriteClmStat(pValue:Str1);
begin
  oTmpTable.FieldByName('ClmStat').AsString := pValue;
end;

function TSchTmp.ReadRetStat:Str1;
begin
  Result := oTmpTable.FieldByName('RetStat').AsString;
end;

procedure TSchTmp.WriteRetStat(pValue:Str1);
begin
  oTmpTable.FieldByName('RetStat').AsString := pValue;
end;

function TSchTmp.ReadSwrTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('SwrTime').AsDateTime;
end;

procedure TSchTmp.WriteSwrTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SwrTime').AsDateTime := pValue;
end;

function TSchTmp.ReadCarType:Str30;
begin
  Result := oTmpTable.FieldByName('CarType').AsString;
end;

procedure TSchTmp.WriteCarType(pValue:Str30);
begin
  oTmpTable.FieldByName('CarType').AsString := pValue;
end;

function TSchTmp.ReadCarNum:Str30;
begin
  Result := oTmpTable.FieldByName('CarNum').AsString;
end;

procedure TSchTmp.WriteCarNum(pValue:Str30);
begin
  oTmpTable.FieldByName('CarNum').AsString := pValue;
end;

function TSchTmp.ReadCarCht:Str30;
begin
  Result := oTmpTable.FieldByName('CarCht').AsString;
end;

procedure TSchTmp.WriteCarCht(pValue:Str30);
begin
  oTmpTable.FieldByName('CarCht').AsString := pValue;
end;

function TSchTmp.ReadCarChn:Str30;
begin
  Result := oTmpTable.FieldByName('CarChn').AsString;
end;

procedure TSchTmp.WriteCarChn(pValue:Str30);
begin
  oTmpTable.FieldByName('CarChn').AsString := pValue;
end;

function TSchTmp.ReadCarGet:Str30;
begin
  Result := oTmpTable.FieldByName('CarGet').AsString;
end;

procedure TSchTmp.WriteCarGet(pValue:Str30);
begin
  oTmpTable.FieldByName('CarGet').AsString := pValue;
end;

function TSchTmp.ReadCarGen:Str30;
begin
  Result := oTmpTable.FieldByName('CarGen').AsString;
end;

procedure TSchTmp.WriteCarGen(pValue:Str30);
begin
  oTmpTable.FieldByName('CarGen').AsString := pValue;
end;

function TSchTmp.ReadCarClr:Str30;
begin
  Result := oTmpTable.FieldByName('CarClr').AsString;
end;

procedure TSchTmp.WriteCarClr(pValue:Str30);
begin
  oTmpTable.FieldByName('CarClr').AsString := pValue;
end;

function TSchTmp.ReadCarCln:Str30;
begin
  Result := oTmpTable.FieldByName('CarCln').AsString;
end;

procedure TSchTmp.WriteCarCln(pValue:Str30);
begin
  oTmpTable.FieldByName('CarCln').AsString := pValue;
end;

function TSchTmp.ReadCarReg:TDatetime;
begin
  Result := oTmpTable.FieldByName('CarReg').AsDateTime;
end;

procedure TSchTmp.WriteCarReg(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CarReg').AsDateTime := pValue;
end;

function TSchTmp.ReadCarTac:longint;
begin
  Result := oTmpTable.FieldByName('CarTac').AsInteger;
end;

procedure TSchTmp.WriteCarTac(pValue:longint);
begin
  oTmpTable.FieldByName('CarTac').AsInteger := pValue;
end;

function TSchTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TSchTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TSchTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSchTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSchTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSchTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSchTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSchTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSchTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSchTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSchTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSchTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSchTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSchTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSchTmp.ReadMndName:Str30;
begin
  Result := oTmpTable.FieldByName('MndName').AsString;
end;

procedure TSchTmp.WriteMndName(pValue:Str30);
begin
  oTmpTable.FieldByName('MndName').AsString := pValue;
end;

function TSchTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSchTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSchTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSchTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSchTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSchTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TSchTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSchTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TSchTmp.LocateFgBValue (pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result := oTmpTable.FindKey([pFgBValue]);
end;

procedure TSchTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSchTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSchTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSchTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSchTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSchTmp.First;
begin
  oTmpTable.First;
end;

procedure TSchTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSchTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSchTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSchTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSchTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSchTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSchTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSchTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSchTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSchTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSchTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1904012}
