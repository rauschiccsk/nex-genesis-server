unit tOCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixRowNum = 'RowNum';
  ixMgCode = 'MgCode';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixStkStat = 'StkStat';
  ixFinStat = 'FinStat';
  ixPaCode = 'PaCode';
  ixSnSi = 'SnSi';
  ixFmdNum = 'FmdNum';

type
  TOciTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadItmWgh:double;         procedure WriteItmWgh (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCPrice:double;       procedure WriteAcCPrice (pValue:double);
    function  ReadAcDPrice:double;       procedure WriteAcDPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdDate:TDatetime;     procedure WriteTcdDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadMcdNum:Str12;          procedure WriteMcdNum (pValue:Str12);
    function  ReadMcdItm:word;           procedure WriteMcdItm (pValue:word);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadOsdDate:TDatetime;     procedure WriteOsdDate (pValue:TDatetime);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadTodNum:Str12;          procedure WriteTodNum (pValue:Str12);
    function  ReadTodItm:word;           procedure WriteTodItm (pValue:word);
    function  ReadRatUser:Str8;          procedure WriteRatUser (pValue:Str8);
    function  ReadRatDate:TDatetime;     procedure WriteRatDate (pValue:TDatetime);
    function  ReadRemWri:word;           procedure WriteRemWri (pValue:word);
    function  ReadRemStk:word;           procedure WriteRemStk (pValue:word);
    function  ReadDlvNoti:Str30;         procedure WriteDlvNoti (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDlvNum:byte;           procedure WriteDlvNum (pValue:byte);
    function  ReadRatNum:byte;           procedure WriteRatNum (pValue:byte);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadTrnCrs:word;           procedure WriteTrnCrs (pValue:word);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadComNum:Str14;          procedure WriteComNum (pValue:Str14);
    function  ReadRqdDate:TDatetime;     procedure WriteRqdDate (pValue:TDatetime);
    function  ReadSlcQnt:double;         procedure WriteSlcQnt (pValue:double);
    function  ReadFmdNum:word;           procedure WriteFmdNum (pValue:word);
    function  ReadTvalue:double;         procedure WriteTvalue (pValue:double);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    oTmpTable: TNexPxTable;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocateFmdNum (pFmdNum:word):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property ItmWgh:double read ReadItmWgh write WriteItmWgh;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCPrice:double read ReadAcCPrice write WriteAcCPrice;
    property AcDPrice:double read ReadAcDPrice write WriteAcDPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdDate:TDatetime read ReadTcdDate write WriteTcdDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property McdNum:Str12 read ReadMcdNum write WriteMcdNum;
    property McdItm:word read ReadMcdItm write WriteMcdItm;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property OsdDate:TDatetime read ReadOsdDate write WriteOsdDate;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property TodNum:Str12 read ReadTodNum write WriteTodNum;
    property TodItm:word read ReadTodItm write WriteTodItm;
    property RatUser:Str8 read ReadRatUser write WriteRatUser;
    property RatDate:TDatetime read ReadRatDate write WriteRatDate;
    property RemWri:word read ReadRemWri write WriteRemWri;
    property RemStk:word read ReadRemStk write WriteRemStk;
    property DlvNoti:Str30 read ReadDlvNoti write WriteDlvNoti;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DlvNum:byte read ReadDlvNum write WriteDlvNum;
    property RatNum:byte read ReadRatNum write WriteRatNum;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property TrnCrs:word read ReadTrnCrs write WriteTrnCrs;
    property Action:Str1 read ReadAction write WriteAction;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property ComNum:Str14 read ReadComNum write WriteComNum;
    property RqdDate:TDatetime read ReadRqdDate write WriteRqdDate;
    property SlcQnt:double read ReadSlcQnt write WriteSlcQnt;
    property FmdNum:word read ReadFmdNum write WriteFmdNum;
    property Tvalue:double read ReadTvalue write WriteTvalue;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TOciTmp.Create;
begin
  oTmpTable := TmpInit ('OCI',Self);
end;

destructor TOciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOciTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOciTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOciTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOciTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOciTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOciTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOciTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TOciTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TOciTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TOciTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOciTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TOciTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TOciTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOciTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOciTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOciTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOciTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TOciTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TOciTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TOciTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TOciTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TOciTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TOciTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TOciTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TOciTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOciTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TOciTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOciTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOciTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TOciTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TOciTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TOciTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TOciTmp.ReadItmWgh:double;
begin
  Result := oTmpTable.FieldByName('ItmWgh').AsFloat;
end;

procedure TOciTmp.WriteItmWgh(pValue:double);
begin
  oTmpTable.FieldByName('ItmWgh').AsFloat := pValue;
end;

function TOciTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TOciTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TOciTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TOciTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TOciTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TOciTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TOciTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOciTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOciTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TOciTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TOciTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TOciTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TOciTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TOciTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TOciTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TOciTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TOciTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TOciTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TOciTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOciTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOciTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOciTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TOciTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOciTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOciTmp.ReadAcCPrice:double;
begin
  Result := oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TOciTmp.WriteAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat := pValue;
end;

function TOciTmp.ReadAcDPrice:double;
begin
  Result := oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TOciTmp.WriteAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat := pValue;
end;

function TOciTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TOciTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TOciTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TOciTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TOciTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOciTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOciTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOciTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOciTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOciTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOciTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOciTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOciTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOciTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOciTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TOciTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TOciTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TOciTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TOciTmp.ReadFgDPrice:double;
begin
  Result := oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TOciTmp.WriteFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TOciTmp.ReadFgAPrice:double;
begin
  Result := oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TOciTmp.WriteFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TOciTmp.ReadFgBPrice:double;
begin
  Result := oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TOciTmp.WriteFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TOciTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOciTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOciTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOciTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOciTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOciTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOciTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TOciTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TOciTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TOciTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TOciTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TOciTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TOciTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TOciTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TOciTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOciTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOciTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TOciTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TOciTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOciTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOciTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOciTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOciTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOciTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TOciTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOciTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TOciTmp.ReadTcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TOciTmp.WriteTcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TOciTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TOciTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TOciTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOciTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TOciTmp.ReadIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TOciTmp.WriteIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TOciTmp.ReadMcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TOciTmp.WriteMcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('McdNum').AsString := pValue;
end;

function TOciTmp.ReadMcdItm:word;
begin
  Result := oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TOciTmp.WriteMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TOciTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TOciTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TOciTmp.ReadOsdItm:word;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOciTmp.WriteOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TOciTmp.ReadOsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdDate').AsDateTime;
end;

procedure TOciTmp.WriteOsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDate').AsDateTime := pValue;
end;

function TOciTmp.ReadScdNum:Str12;
begin
  Result := oTmpTable.FieldByName('ScdNum').AsString;
end;

procedure TOciTmp.WriteScdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ScdNum').AsString := pValue;
end;

function TOciTmp.ReadScdItm:word;
begin
  Result := oTmpTable.FieldByName('ScdItm').AsInteger;
end;

procedure TOciTmp.WriteScdItm(pValue:word);
begin
  oTmpTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TOciTmp.ReadTodNum:Str12;
begin
  Result := oTmpTable.FieldByName('TodNum').AsString;
end;

procedure TOciTmp.WriteTodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TodNum').AsString := pValue;
end;

function TOciTmp.ReadTodItm:word;
begin
  Result := oTmpTable.FieldByName('TodItm').AsInteger;
end;

procedure TOciTmp.WriteTodItm(pValue:word);
begin
  oTmpTable.FieldByName('TodItm').AsInteger := pValue;
end;

function TOciTmp.ReadRatUser:Str8;
begin
  Result := oTmpTable.FieldByName('RatUser').AsString;
end;

procedure TOciTmp.WriteRatUser(pValue:Str8);
begin
  oTmpTable.FieldByName('RatUser').AsString := pValue;
end;

function TOciTmp.ReadRatDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RatDate').AsDateTime;
end;

procedure TOciTmp.WriteRatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDate').AsDateTime := pValue;
end;

function TOciTmp.ReadRemWri:word;
begin
  Result := oTmpTable.FieldByName('RemWri').AsInteger;
end;

procedure TOciTmp.WriteRemWri(pValue:word);
begin
  oTmpTable.FieldByName('RemWri').AsInteger := pValue;
end;

function TOciTmp.ReadRemStk:word;
begin
  Result := oTmpTable.FieldByName('RemStk').AsInteger;
end;

procedure TOciTmp.WriteRemStk(pValue:word);
begin
  oTmpTable.FieldByName('RemStk').AsInteger := pValue;
end;

function TOciTmp.ReadDlvNoti:Str30;
begin
  Result := oTmpTable.FieldByName('DlvNoti').AsString;
end;

procedure TOciTmp.WriteDlvNoti(pValue:Str30);
begin
  oTmpTable.FieldByName('DlvNoti').AsString := pValue;
end;

function TOciTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TOciTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TOciTmp.ReadDlvNum:byte;
begin
  Result := oTmpTable.FieldByName('DlvNum').AsInteger;
end;

procedure TOciTmp.WriteDlvNum(pValue:byte);
begin
  oTmpTable.FieldByName('DlvNum').AsInteger := pValue;
end;

function TOciTmp.ReadRatNum:byte;
begin
  Result := oTmpTable.FieldByName('RatNum').AsInteger;
end;

procedure TOciTmp.WriteRatNum(pValue:byte);
begin
  oTmpTable.FieldByName('RatNum').AsInteger := pValue;
end;

function TOciTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TOciTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TOciTmp.ReadFinStat:Str1;
begin
  Result := oTmpTable.FieldByName('FinStat').AsString;
end;

procedure TOciTmp.WriteFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('FinStat').AsString := pValue;
end;

function TOciTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TOciTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TOciTmp.ReadTrnCrs:word;
begin
  Result := oTmpTable.FieldByName('TrnCrs').AsInteger;
end;

procedure TOciTmp.WriteTrnCrs(pValue:word);
begin
  oTmpTable.FieldByName('TrnCrs').AsInteger := pValue;
end;

function TOciTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TOciTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TOciTmp.ReadDayQnt:word;
begin
  Result := oTmpTable.FieldByName('DayQnt').AsInteger;
end;

procedure TOciTmp.WriteDayQnt(pValue:word);
begin
  oTmpTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TOciTmp.ReadComNum:Str14;
begin
  Result := oTmpTable.FieldByName('ComNum').AsString;
end;

procedure TOciTmp.WriteComNum(pValue:Str14);
begin
  oTmpTable.FieldByName('ComNum').AsString := pValue;
end;

function TOciTmp.ReadRqdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RqdDate').AsDateTime;
end;

procedure TOciTmp.WriteRqdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RqdDate').AsDateTime := pValue;
end;

function TOciTmp.ReadSlcQnt:double;
begin
  Result := oTmpTable.FieldByName('SlcQnt').AsFloat;
end;

procedure TOciTmp.WriteSlcQnt(pValue:double);
begin
  oTmpTable.FieldByName('SlcQnt').AsFloat := pValue;
end;

function TOciTmp.ReadFmdNum:word;
begin
  Result := oTmpTable.FieldByName('FmdNum').AsInteger;
end;

procedure TOciTmp.WriteFmdNum(pValue:word);
begin
  oTmpTable.FieldByName('FmdNum').AsInteger := pValue;
end;

function TOciTmp.ReadTvalue:double;
begin
  Result := oTmpTable.FieldByName('Tvalue').AsFloat;
end;

procedure TOciTmp.WriteTvalue(pValue:double);
begin
  oTmpTable.FieldByName('Tvalue').AsFloat := pValue;
end;

function TOciTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOciTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOciTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOciTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOciTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOciTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOciTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOciTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOciTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOciTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOciTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOciTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOciTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOciTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOciTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOciTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOciTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOciTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOciTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOciTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TOciTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TOciTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TOciTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TOciTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOciTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TOciTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TOciTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TOciTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TOciTmp.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oTmpTable.FindKey([pFinStat]);
end;

function TOciTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TOciTmp.LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oTmpTable.FindKey([pScdNum,pScdItm]);
end;

function TOciTmp.LocateFmdNum (pFmdNum:word):boolean;
begin
  SetIndex (ixFmdNum);
  Result := oTmpTable.FindKey([pFmdNum]);
end;

procedure TOciTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOciTmp.First;
begin
  oTmpTable.First;
end;

procedure TOciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOciTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOciTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOciTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOciTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1926001}
