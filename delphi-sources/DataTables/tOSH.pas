unit tOSH;

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
  ixDlvDate = 'DlvDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAcEValue = 'AcEValue';
  ixFgEValue = 'FgEValue';
  ixDstStk = 'DstStk';
  ixDstCls = 'DstCls';

type
  TOshTmp = class (TComponent)
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
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
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
    function  ReadDstOrd:Str1;           procedure WriteDstOrd (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstCls:byte;           procedure WriteDstCls (pValue:byte);
    function  ReadDstSnd:Str1;           procedure WriteDstSnd (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadDlvItm:word;           procedure WriteDlvItm (pValue:word);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadIdlPrc:double;         procedure WriteIdlPrc (pValue:double);
    function  ReadQdlPrc:double;         procedure WriteQdlPrc (pValue:double);
    function  ReadCnfStat:Str1;          procedure WriteCnfStat (pValue:Str1);
    function  ReadIsExpDay:word;         procedure WriteIsExpDay (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDlvDate (pDlvDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAcEValue (pAcEValue:double):boolean;
    function LocateFgEValue (pFgEValue:double):boolean;
    function LocateDstStk (pDstStk:Str1):boolean;
    function LocateDstCls (pDstCls:byte):boolean;

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
    property RspName:Str30 read ReadRspName write WriteRspName;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
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
    property DstOrd:Str1 read ReadDstOrd write WriteDstOrd;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstCls:byte read ReadDstCls write WriteDstCls;
    property DstSnd:Str1 read ReadDstSnd write WriteDstSnd;
    property Sended:boolean read ReadSended write WriteSended;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property DlvItm:word read ReadDlvItm write WriteDlvItm;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property IdlPrc:double read ReadIdlPrc write WriteIdlPrc;
    property QdlPrc:double read ReadQdlPrc write WriteQdlPrc;
    property CnfStat:Str1 read ReadCnfStat write WriteCnfStat;
    property IsExpDay:word read ReadIsExpDay write WriteIsExpDay;
  end;

implementation

constructor TOshTmp.Create;
begin
  oTmpTable := TmpInit ('OSH',Self);
end;

destructor TOshTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOshTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOshTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOshTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOshTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOshTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TOshTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TOshTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOshTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOshTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TOshTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOshTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOshTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOshTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOshTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOshTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOshTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOshTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOshTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOshTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TOshTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TOshTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TOshTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TOshTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TOshTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TOshTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TOshTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TOshTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TOshTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TOshTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TOshTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TOshTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TOshTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TOshTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TOshTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TOshTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TOshTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TOshTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TOshTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TOshTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TOshTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TOshTmp.ReadPayCode:Str3;
begin
  Result := oTmpTable.FieldByName('PayCode').AsString;
end;

procedure TOshTmp.WritePayCode(pValue:Str3);
begin
  oTmpTable.FieldByName('PayCode').AsString := pValue;
end;

function TOshTmp.ReadPayName:Str20;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TOshTmp.WritePayName(pValue:Str20);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TOshTmp.ReadWpaCode:word;
begin
  Result := oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TOshTmp.WriteWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger := pValue;
end;

function TOshTmp.ReadWpaName:Str60;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TOshTmp.WriteWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TOshTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TOshTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TOshTmp.ReadWpaSta:Str2;
begin
  Result := oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TOshTmp.WriteWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString := pValue;
end;

function TOshTmp.ReadWpaCty:Str3;
begin
  Result := oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TOshTmp.WriteWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString := pValue;
end;

function TOshTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TOshTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TOshTmp.ReadWpaZip:Str15;
begin
  Result := oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TOshTmp.WriteWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString := pValue;
end;

function TOshTmp.ReadTrsCode:Str3;
begin
  Result := oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TOshTmp.WriteTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString := pValue;
end;

function TOshTmp.ReadTrsName:Str20;
begin
  Result := oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TOshTmp.WriteTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString := pValue;
end;

function TOshTmp.ReadRspUser:Str8;
begin
  Result := oTmpTable.FieldByName('RspUser').AsString;
end;

procedure TOshTmp.WriteRspUser(pValue:Str8);
begin
  oTmpTable.FieldByName('RspUser').AsString := pValue;
end;

function TOshTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TOshTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TOshTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOshTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOshTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOshTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOshTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TOshTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TOshTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TOshTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TOshTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TOshTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TOshTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TOshTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TOshTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TOshTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TOshTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TOshTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TOshTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOshTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOshTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOshTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOshTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOshTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOshTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TOshTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TOshTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TOshTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TOshTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOshTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOshTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOshTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOshTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TOshTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TOshTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TOshTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TOshTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOshTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOshTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOshTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOshTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOshTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOshTmp.ReadFgVatVal:double;
begin
  Result := oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TOshTmp.WriteFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat := pValue;
end;

function TOshTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TOshTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TOshTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TOshTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TOshTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TOshTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TOshTmp.ReadVatDoc:byte;
begin
  Result := oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOshTmp.WriteVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TOshTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOshTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOshTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOshTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOshTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TOshTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TOshTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TOshTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TOshTmp.ReadDstOrd:Str1;
begin
  Result := oTmpTable.FieldByName('DstOrd').AsString;
end;

procedure TOshTmp.WriteDstOrd(pValue:Str1);
begin
  oTmpTable.FieldByName('DstOrd').AsString := pValue;
end;

function TOshTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TOshTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOshTmp.ReadDstCls:byte;
begin
  Result := oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TOshTmp.WriteDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger := pValue;
end;

function TOshTmp.ReadDstSnd:Str1;
begin
  Result := oTmpTable.FieldByName('DstSnd').AsString;
end;

procedure TOshTmp.WriteDstSnd(pValue:Str1);
begin
  oTmpTable.FieldByName('DstSnd').AsString := pValue;
end;

function TOshTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TOshTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOshTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TOshTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TOshTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOshTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOshTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOshTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOshTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOshTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOshTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOshTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOshTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOshTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOshTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOshTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOshTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOshTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOshTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOshTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TOshTmp.ReadDlvItm:word;
begin
  Result := oTmpTable.FieldByName('DlvItm').AsInteger;
end;

procedure TOshTmp.WriteDlvItm(pValue:word);
begin
  oTmpTable.FieldByName('DlvItm').AsInteger := pValue;
end;

function TOshTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOshTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOshTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOshTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOshTmp.ReadIdlPrc:double;
begin
  Result := oTmpTable.FieldByName('IdlPrc').AsFloat;
end;

procedure TOshTmp.WriteIdlPrc(pValue:double);
begin
  oTmpTable.FieldByName('IdlPrc').AsFloat := pValue;
end;

function TOshTmp.ReadQdlPrc:double;
begin
  Result := oTmpTable.FieldByName('QdlPrc').AsFloat;
end;

procedure TOshTmp.WriteQdlPrc(pValue:double);
begin
  oTmpTable.FieldByName('QdlPrc').AsFloat := pValue;
end;

function TOshTmp.ReadCnfStat:Str1;
begin
  Result := oTmpTable.FieldByName('CnfStat').AsString;
end;

procedure TOshTmp.WriteCnfStat(pValue:Str1);
begin
  oTmpTable.FieldByName('CnfStat').AsString := pValue;
end;

function TOshTmp.ReadIsExpDay:word;
begin
  Result := oTmpTable.FieldByName('IsExpDay').AsInteger;
end;

procedure TOshTmp.WriteIsExpDay(pValue:word);
begin
  oTmpTable.FieldByName('IsExpDay').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOshTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOshTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOshTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TOshTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TOshTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TOshTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TOshTmp.LocateDlvDate (pDlvDate:TDatetime):boolean;
begin
  SetIndex (ixDlvDate);
  Result := oTmpTable.FindKey([pDlvDate]);
end;

function TOshTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TOshTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TOshTmp.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oTmpTable.FindKey([pAcEValue]);
end;

function TOshTmp.LocateFgEValue (pFgEValue:double):boolean;
begin
  SetIndex (ixFgEValue);
  Result := oTmpTable.FindKey([pFgEValue]);
end;

function TOshTmp.LocateDstStk (pDstStk:Str1):boolean;
begin
  SetIndex (ixDstStk);
  Result := oTmpTable.FindKey([pDstStk]);
end;

function TOshTmp.LocateDstCls (pDstCls:byte):boolean;
begin
  SetIndex (ixDstCls);
  Result := oTmpTable.FindKey([pDstCls]);
end;

procedure TOshTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOshTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOshTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOshTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOshTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOshTmp.First;
begin
  oTmpTable.First;
end;

procedure TOshTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOshTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOshTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOshTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOshTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOshTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOshTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOshTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOshTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOshTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOshTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
