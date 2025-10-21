unit bOSH;

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
  ixDlvDate = 'DlvDate';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixDstStk = 'DstStk';
  ixDstCls = 'DstCls';
  ixPaDs = 'PaDs';
  ixSended = 'Sended';

type
  TOshBtr = class (TComponent)
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
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgVatVal:double;       procedure WriteFgVatVal (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
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
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadDstSnd:Str1;           procedure WriteDstSnd (pValue:Str1);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadCnfStat:Str1;          procedure WriteCnfStat (pValue:Str1);
    function  ReadIsExpDay:word;         procedure WriteIsExpDay (pValue:word);
    function  ReadRspSig:Str5;           procedure WriteRspSig (pValue:Str5);
    function  ReadVerSig:Str5;           procedure WriteVerSig (pValue:Str5);
    function  ReadAprSig:Str5;           procedure WriteAprSig (pValue:Str5);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
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
    function LocateDlvDate (pDlvDate:TDatetime):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateDstStk (pDstStk:Str1):boolean;
    function LocateDstCls (pDstCls:byte):boolean;
    function LocatePaDs (pPaCode:longint;pDstSnd:Str1):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDlvDate (pDlvDate:TDatetime):boolean;
    function NearestAcEValue (pAcEValue:double):boolean;
    function NearestFgEValue (pFgEValue:double):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestDstStk (pDstStk:Str1):boolean;
    function NearestDstCls (pDstCls:byte):boolean;
    function NearestPaDs (pPaCode:longint;pDstSnd:Str1):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgVatVal:double read ReadFgVatVal write WriteFgVatVal;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
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
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property DstSnd:Str1 read ReadDstSnd write WriteDstSnd;
    property Year:Str2 read ReadYear write WriteYear;
    property CnfStat:Str1 read ReadCnfStat write WriteCnfStat;
    property IsExpDay:word read ReadIsExpDay write WriteIsExpDay;
    property RspSig:Str5 read ReadRspSig write WriteRspSig;
    property VerSig:Str5 read ReadVerSig write WriteVerSig;
    property AprSig:Str5 read ReadAprSig write WriteAprSig;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
  end;

implementation

constructor TOshBtr.Create;
begin
  oBtrTable := BtrInit ('OSH',gPath.StkPath,Self);
end;

constructor TOshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OSH',pPath,Self);
end;

destructor TOshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TOshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOshBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TOshBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOshBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOshBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOshBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOshBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TOshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TOshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TOshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TOshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TOshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TOshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TOshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TOshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TOshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TOshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TOshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TOshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TOshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TOshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TOshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TOshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TOshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TOshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TOshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TOshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TOshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TOshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TOshBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TOshBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TOshBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TOshBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TOshBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TOshBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TOshBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TOshBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TOshBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TOshBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TOshBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TOshBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TOshBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TOshBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TOshBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TOshBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TOshBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TOshBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TOshBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TOshBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TOshBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TOshBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TOshBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TOshBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TOshBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOshBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOshBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOshBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOshBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TOshBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TOshBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TOshBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TOshBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TOshBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TOshBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TOshBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TOshBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOshBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOshBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOshBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOshBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOshBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOshBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TOshBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TOshBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TOshBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TOshBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOshBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOshBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOshBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOshBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TOshBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TOshBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TOshBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TOshBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOshBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOshBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOshBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOshBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOshBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOshBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TOshBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TOshBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TOshBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TOshBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TOshBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TOshBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TOshBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TOshBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOshBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TOshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOshBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TOshBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TOshBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TOshBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TOshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TOshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOshBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TOshBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TOshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TOshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOshBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOshBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOshBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TOshBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TOshBtr.ReadDstSnd:Str1;
begin
  Result := oBtrTable.FieldByName('DstSnd').AsString;
end;

procedure TOshBtr.WriteDstSnd(pValue:Str1);
begin
  oBtrTable.FieldByName('DstSnd').AsString := pValue;
end;

function TOshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TOshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TOshBtr.ReadCnfStat:Str1;
begin
  Result := oBtrTable.FieldByName('CnfStat').AsString;
end;

procedure TOshBtr.WriteCnfStat(pValue:Str1);
begin
  oBtrTable.FieldByName('CnfStat').AsString := pValue;
end;

function TOshBtr.ReadIsExpDay:word;
begin
  Result := oBtrTable.FieldByName('IsExpDay').AsInteger;
end;

procedure TOshBtr.WriteIsExpDay(pValue:word);
begin
  oBtrTable.FieldByName('IsExpDay').AsInteger := pValue;
end;

function TOshBtr.ReadRspSig:Str5;
begin
  Result := oBtrTable.FieldByName('RspSig').AsString;
end;

procedure TOshBtr.WriteRspSig(pValue:Str5);
begin
  oBtrTable.FieldByName('RspSig').AsString := pValue;
end;

function TOshBtr.ReadVerSig:Str5;
begin
  Result := oBtrTable.FieldByName('VerSig').AsString;
end;

procedure TOshBtr.WriteVerSig(pValue:Str5);
begin
  oBtrTable.FieldByName('VerSig').AsString := pValue;
end;

function TOshBtr.ReadAprSig:Str5;
begin
  Result := oBtrTable.FieldByName('AprSig').AsString;
end;

procedure TOshBtr.WriteAprSig(pValue:Str5);
begin
  oBtrTable.FieldByName('AprSig').AsString := pValue;
end;

function TOshBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TOshBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TOshBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TOshBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TOshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOshBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TOshBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TOshBtr.LocateDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindKey([pDlvDate]);
end;

function TOshBtr.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindKey([pAcEValue]);
end;

function TOshBtr.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindKey([pFgEValue]);
end;

function TOshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TOshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TOshBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TOshBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TOshBtr.LocateDstStk (pDstStk:Str1):boolean;
begin
  SetIndex (ixDstStk);
  Result := oBtrTable.FindKey([pDstStk]);
end;

function TOshBtr.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindKey([pDstCls]);
end;

function TOshBtr.LocatePaDs (pPaCode:longint;pDstSnd:Str1):boolean;
begin
  SetIndex (ixPaDs);
  Result := oBtrTable.FindKey([pPaCode,pDstSnd]);
end;

function TOshBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TOshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TOshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOshBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TOshBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TOshBtr.NearestDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindNearest([pDlvDate]);
end;

function TOshBtr.NearestAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oBtrTable.FindNearest([pAcEValue]);
end;

function TOshBtr.NearestFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oBtrTable.FindNearest([pFgEValue]);
end;

function TOshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TOshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TOshBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TOshBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TOshBtr.NearestDstStk (pDstStk:Str1):boolean;
begin
  SetIndex (ixDstStk);
  Result := oBtrTable.FindNearest([pDstStk]);
end;

function TOshBtr.NearestDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oBtrTable.FindNearest([pDstCls]);
end;

function TOshBtr.NearestPaDs (pPaCode:longint;pDstSnd:Str1):boolean;
begin
  SetIndex (ixPaDs);
  Result := oBtrTable.FindNearest([pPaCode,pDstSnd]);
end;

function TOshBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TOshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOshBtr.First;
begin
  oBtrTable.First;
end;

procedure TOshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
