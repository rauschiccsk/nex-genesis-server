unit bPSH;

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
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixAcDvzName = 'AcDvzName';
  ixFgDvzName = 'FgDvzName';
  ixDstOrd = 'DstOrd';
  ixSended = 'Sended';

type
  TPshBtr = class (TComponent)
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
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
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
    function  ReadDstOrd:Str1;           procedure WriteDstOrd (pValue:Str1);
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
    function LocateDlvDate (pDlvDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAcDvzName (pAcDvzName:Str3):boolean;
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function LocateDstOrd (pDstOrd:Str1):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDlvDate (pDlvDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAcDvzName (pAcDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestDstOrd (pDstOrd:Str1):boolean;
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
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
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
    property DstOrd:Str1 read ReadDstOrd write WriteDstOrd;
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
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TPshBtr.Create;
begin
  oBtrTable := BtrInit ('PSH',gPath.StkPath,Self);
end;

constructor TPshBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PSH',pPath,Self);
end;

destructor TPshBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPshBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPshBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPshBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPshBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPshBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPshBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPshBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TPshBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TPshBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPshBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPshBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TPshBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TPshBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPshBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPshBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPshBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPshBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TPshBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TPshBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TPshBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TPshBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TPshBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TPshBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TPshBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TPshBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TPshBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TPshBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TPshBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TPshBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TPshBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TPshBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TPshBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TPshBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TPshBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TPshBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TPshBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TPshBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TPshBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TPshBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TPshBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TPshBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TPshBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TPshBtr.ReadWpaCode:word;
begin
  Result := oBtrTable.FieldByName('WpaCode').AsInteger;
end;

procedure TPshBtr.WriteWpaCode(pValue:word);
begin
  oBtrTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TPshBtr.ReadWpaName:Str60;
begin
  Result := oBtrTable.FieldByName('WpaName').AsString;
end;

procedure TPshBtr.WriteWpaName(pValue:Str60);
begin
  oBtrTable.FieldByName('WpaName').AsString := pValue;
end;

function TPshBtr.ReadWpaAddr:Str30;
begin
  Result := oBtrTable.FieldByName('WpaAddr').AsString;
end;

procedure TPshBtr.WriteWpaAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TPshBtr.ReadWpaSta:Str2;
begin
  Result := oBtrTable.FieldByName('WpaSta').AsString;
end;

procedure TPshBtr.WriteWpaSta(pValue:Str2);
begin
  oBtrTable.FieldByName('WpaSta').AsString := pValue;
end;

function TPshBtr.ReadWpaCty:Str3;
begin
  Result := oBtrTable.FieldByName('WpaCty').AsString;
end;

procedure TPshBtr.WriteWpaCty(pValue:Str3);
begin
  oBtrTable.FieldByName('WpaCty').AsString := pValue;
end;

function TPshBtr.ReadWpaCtn:Str30;
begin
  Result := oBtrTable.FieldByName('WpaCtn').AsString;
end;

procedure TPshBtr.WriteWpaCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TPshBtr.ReadWpaZip:Str15;
begin
  Result := oBtrTable.FieldByName('WpaZip').AsString;
end;

procedure TPshBtr.WriteWpaZip(pValue:Str15);
begin
  oBtrTable.FieldByName('WpaZip').AsString := pValue;
end;

function TPshBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TPshBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TPshBtr.ReadTrsName:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TPshBtr.WriteTrsName(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TPshBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TPshBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TPshBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TPshBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TPshBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPshBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPshBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TPshBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TPshBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TPshBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TPshBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TPshBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TPshBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TPshBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TPshBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TPshBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TPshBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TPshBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TPshBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TPshBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TPshBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TPshBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TPshBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TPshBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TPshBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TPshBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TPshBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TPshBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TPshBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TPshBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TPshBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TPshBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TPshBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TPshBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TPshBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TPshBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TPshBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TPshBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TPshBtr.ReadFgVatVal:double;
begin
  Result := oBtrTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TPshBtr.WriteFgVatVal(pValue:double);
begin
  oBtrTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TPshBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TPshBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TPshBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TPshBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TPshBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TPshBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPshBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TPshBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TPshBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TPshBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TPshBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPshBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPshBtr.ReadDstOrd:Str1;
begin
  Result := oBtrTable.FieldByName('DstOrd').AsString;
end;

procedure TPshBtr.WriteDstOrd(pValue:Str1);
begin
  oBtrTable.FieldByName('DstOrd').AsString := pValue;
end;

function TPshBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TPshBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TPshBtr.ReadDstCls:byte;
begin
  Result := oBtrTable.FieldByName('DstCls').AsInteger;
end;

procedure TPshBtr.WriteDstCls(pValue:byte);
begin
  oBtrTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TPshBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPshBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPshBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPshBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPshBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPshBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPshBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPshBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPshBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPshBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPshBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPshBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPshBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPshBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPshBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPshBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPshBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TPshBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPshBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPshBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPshBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPshBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPshBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPshBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPshBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TPshBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPshBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TPshBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPshBtr.LocateDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindKey([pDlvDate]);
end;

function TPshBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPshBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TPshBtr.LocateAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindKey([pAcDvzName]);
end;

function TPshBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TPshBtr.LocateDstOrd (pDstOrd:Str1):boolean;
begin
  SetIndex (ixDstOrd);
  Result := oBtrTable.FindKey([pDstOrd]);
end;

function TPshBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPshBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TPshBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPshBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TPshBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPshBtr.NearestDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oBtrTable.FindNearest([pDlvDate]);
end;

function TPshBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TPshBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TPshBtr.NearestAcDvzName (pAcDvzName:Str3):boolean;
begin
  SetIndex (ixAcDvzName);
  Result := oBtrTable.FindNearest([pAcDvzName]);
end;

function TPshBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TPshBtr.NearestDstOrd (pDstOrd:Str1):boolean;
begin
  SetIndex (ixDstOrd);
  Result := oBtrTable.FindNearest([pDstOrd]);
end;

function TPshBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TPshBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPshBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPshBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPshBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPshBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPshBtr.First;
begin
  oBtrTable.First;
end;

procedure TPshBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPshBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPshBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPshBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPshBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPshBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPshBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPshBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPshBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPshBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPshBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
