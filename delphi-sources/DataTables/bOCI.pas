unit bOCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPaCode = 'PaCode';
  ixStkStat = 'StkStat';
  ixFinStat = 'FinStat';
  ixPaGsSt = 'PaGsSt';
  ixSnSi = 'SnSi';
  ixComNum = 'ComNum';
  ixDoSt = 'DoSt';

type
  TOciBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
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
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadOsdDate:TDatetime;     procedure WriteOsdDate (pValue:TDatetime);
    function  ReadRatUser:Str8;          procedure WriteRatUser (pValue:Str8);
    function  ReadRatDate:TDatetime;     procedure WriteRatDate (pValue:TDatetime);
    function  ReadRemWri:word;           procedure WriteRemWri (pValue:word);
    function  ReadRemStk:word;           procedure WriteRemStk (pValue:word);
    function  ReadDlvNoti:Str30;         procedure WriteDlvNoti (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDlvNum:byte;           procedure WriteDlvNum (pValue:byte);
    function  ReadRatNum:byte;           procedure WriteRatNum (pValue:byte);
    function  ReadRmdNum:Str12;          procedure WriteRmdNum (pValue:Str12);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadOsrQnt:double;         procedure WriteOsrQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadTodNum:Str12;          procedure WriteTodNum (pValue:Str12);
    function  ReadTodItm:word;           procedure WriteTodItm (pValue:word);
    function  ReadComNum:Str14;          procedure WriteComNum (pValue:Str14);
    function  ReadRqdDate:TDatetime;     procedure WriteRqdDate (pValue:TDatetime);
    function  ReadTvalue:double;         procedure WriteTvalue (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function LocatePaGsSt (pPaCode:longint;pGsCode:longint;pStkStat:Str1):boolean;
    function LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocateComNum (pComNum:Str14):boolean;
    function LocateDoSt (pDocNum:Str12;pStkStat:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestFinStat (pFinStat:Str1):boolean;
    function NearestPaGsSt (pPaCode:longint;pGsCode:longint;pStkStat:Str1):boolean;
    function NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function NearestComNum (pComNum:Str14):boolean;
    function NearestDoSt (pDocNum:Str12;pStkStat:Str1):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
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
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property Action:Str1 read ReadAction write WriteAction;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property OsdDate:TDatetime read ReadOsdDate write WriteOsdDate;
    property RatUser:Str8 read ReadRatUser write WriteRatUser;
    property RatDate:TDatetime read ReadRatDate write WriteRatDate;
    property RemWri:word read ReadRemWri write WriteRemWri;
    property RemStk:word read ReadRemStk write WriteRemStk;
    property DlvNoti:Str30 read ReadDlvNoti write WriteDlvNoti;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DlvNum:byte read ReadDlvNum write WriteDlvNum;
    property RatNum:byte read ReadRatNum write WriteRatNum;
    property RmdNum:Str12 read ReadRmdNum write WriteRmdNum;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property OsrQnt:double read ReadOsrQnt write WriteOsrQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property TodNum:Str12 read ReadTodNum write WriteTodNum;
    property TodItm:word read ReadTodItm write WriteTodItm;
    property ComNum:Str14 read ReadComNum write WriteComNum;
    property RqdDate:TDatetime read ReadRqdDate write WriteRqdDate;
    property Tvalue:double read ReadTvalue write WriteTvalue;
  end;

implementation

constructor TOciBtr.Create;
begin
  oBtrTable := BtrInit ('OCI',gPath.StkPath,Self);
end;

constructor TOciBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OCI',pPath,Self);
end;

destructor TOciBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOciBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOciBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOciBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOciBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOciBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOciBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOciBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TOciBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOciBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOciBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOciBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TOciBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TOciBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TOciBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TOciBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TOciBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TOciBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TOciBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TOciBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOciBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOciBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TOciBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TOciBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TOciBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TOciBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TOciBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TOciBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TOciBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TOciBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TOciBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TOciBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOciBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOciBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOciBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TOciBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOciBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOciBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOciBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOciBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOciBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOciBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOciBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOciBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOciBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOciBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOciBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOciBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TOciBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TOciBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TOciBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TOciBtr.ReadFgAPrice:double;
begin
  Result := oBtrTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TOciBtr.WriteFgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TOciBtr.ReadFgBPrice:double;
begin
  Result := oBtrTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TOciBtr.WriteFgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TOciBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOciBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOciBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOciBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOciBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOciBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOciBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TOciBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TOciBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TOciBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TOciBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TOciBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TOciBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOciBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOciBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TOciBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TOciBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOciBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOciBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TOciBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOciBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TOciBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TOciBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOciBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TOciBtr.ReadTcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TOciBtr.WriteTcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TOciBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TOciBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TOciBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TOciBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TOciBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TOciBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TOciBtr.ReadMcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('McdNum').AsString;
end;

procedure TOciBtr.WriteMcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('McdNum').AsString := pValue;
end;

function TOciBtr.ReadMcdItm:word;
begin
  Result := oBtrTable.FieldByName('McdItm').AsInteger;
end;

procedure TOciBtr.WriteMcdItm(pValue:word);
begin
  oBtrTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TOciBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TOciBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TOciBtr.ReadFinStat:Str1;
begin
  Result := oBtrTable.FieldByName('FinStat').AsString;
end;

procedure TOciBtr.WriteFinStat(pValue:Str1);
begin
  oBtrTable.FieldByName('FinStat').AsString := pValue;
end;

function TOciBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TOciBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TOciBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOciBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOciBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOciBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOciBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOciBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOciBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOciBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOciBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOciBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOciBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOciBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOciBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOciBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOciBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TOciBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TOciBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TOciBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TOciBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TOciBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TOciBtr.ReadOsdItm:word;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOciBtr.WriteOsdItm(pValue:word);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TOciBtr.ReadOsdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OsdDate').AsDateTime;
end;

procedure TOciBtr.WriteOsdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OsdDate').AsDateTime := pValue;
end;

function TOciBtr.ReadRatUser:Str8;
begin
  Result := oBtrTable.FieldByName('RatUser').AsString;
end;

procedure TOciBtr.WriteRatUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RatUser').AsString := pValue;
end;

function TOciBtr.ReadRatDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RatDate').AsDateTime;
end;

procedure TOciBtr.WriteRatDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RatDate').AsDateTime := pValue;
end;

function TOciBtr.ReadRemWri:word;
begin
  Result := oBtrTable.FieldByName('RemWri').AsInteger;
end;

procedure TOciBtr.WriteRemWri(pValue:word);
begin
  oBtrTable.FieldByName('RemWri').AsInteger := pValue;
end;

function TOciBtr.ReadRemStk:word;
begin
  Result := oBtrTable.FieldByName('RemStk').AsInteger;
end;

procedure TOciBtr.WriteRemStk(pValue:word);
begin
  oBtrTable.FieldByName('RemStk').AsInteger := pValue;
end;

function TOciBtr.ReadDlvNoti:Str30;
begin
  Result := oBtrTable.FieldByName('DlvNoti').AsString;
end;

procedure TOciBtr.WriteDlvNoti(pValue:Str30);
begin
  oBtrTable.FieldByName('DlvNoti').AsString := pValue;
end;

function TOciBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TOciBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TOciBtr.ReadDlvNum:byte;
begin
  Result := oBtrTable.FieldByName('DlvNum').AsInteger;
end;

procedure TOciBtr.WriteDlvNum(pValue:byte);
begin
  oBtrTable.FieldByName('DlvNum').AsInteger := pValue;
end;

function TOciBtr.ReadRatNum:byte;
begin
  Result := oBtrTable.FieldByName('RatNum').AsInteger;
end;

procedure TOciBtr.WriteRatNum(pValue:byte);
begin
  oBtrTable.FieldByName('RatNum').AsInteger := pValue;
end;

function TOciBtr.ReadRmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('RmdNum').AsString;
end;

procedure TOciBtr.WriteRmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RmdNum').AsString := pValue;
end;

function TOciBtr.ReadScdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScdNum').AsString;
end;

procedure TOciBtr.WriteScdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScdNum').AsString := pValue;
end;

function TOciBtr.ReadScdItm:word;
begin
  Result := oBtrTable.FieldByName('ScdItm').AsInteger;
end;

procedure TOciBtr.WriteScdItm(pValue:word);
begin
  oBtrTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TOciBtr.ReadResQnt:double;
begin
  Result := oBtrTable.FieldByName('ResQnt').AsFloat;
end;

procedure TOciBtr.WriteResQnt(pValue:double);
begin
  oBtrTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TOciBtr.ReadOsrQnt:double;
begin
  Result := oBtrTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TOciBtr.WriteOsrQnt(pValue:double);
begin
  oBtrTable.FieldByName('OsrQnt').AsFloat := pValue;
end;

function TOciBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOciBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOciBtr.ReadTodNum:Str12;
begin
  Result := oBtrTable.FieldByName('TodNum').AsString;
end;

procedure TOciBtr.WriteTodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TodNum').AsString := pValue;
end;

function TOciBtr.ReadTodItm:word;
begin
  Result := oBtrTable.FieldByName('TodItm').AsInteger;
end;

procedure TOciBtr.WriteTodItm(pValue:word);
begin
  oBtrTable.FieldByName('TodItm').AsInteger := pValue;
end;

function TOciBtr.ReadComNum:Str14;
begin
  Result := oBtrTable.FieldByName('ComNum').AsString;
end;

procedure TOciBtr.WriteComNum(pValue:Str14);
begin
  oBtrTable.FieldByName('ComNum').AsString := pValue;
end;

function TOciBtr.ReadRqdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RqdDate').AsDateTime;
end;

procedure TOciBtr.WriteRqdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RqdDate').AsDateTime := pValue;
end;

function TOciBtr.ReadTvalue:double;
begin
  Result := oBtrTable.FieldByName('Tvalue').AsFloat;
end;

procedure TOciBtr.WriteTvalue(pValue:double);
begin
  oBtrTable.FieldByName('Tvalue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOciBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOciBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOciBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOciBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOciBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOciBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOciBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TOciBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOciBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TOciBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TOciBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TOciBtr.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindKey([pFinStat]);
end;

function TOciBtr.LocatePaGsSt (pPaCode:longint;pGsCode:longint;pStkStat:Str1):boolean;
begin
  SetIndex (ixPaGsSt);
  Result := oBtrTable.FindKey([pPaCode,pGsCode,pStkStat]);
end;

function TOciBtr.LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindKey([pScdNum,pScdItm]);
end;

function TOciBtr.LocateComNum (pComNum:Str14):boolean;
begin
  SetIndex (ixComNum);
  Result := oBtrTable.FindKey([pComNum]);
end;

function TOciBtr.LocateDoSt (pDocNum:Str12;pStkStat:Str1):boolean;
begin
  SetIndex (ixDoSt);
  Result := oBtrTable.FindKey([pDocNum,pStkStat]);
end;

function TOciBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TOciBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOciBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TOciBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TOciBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TOciBtr.NearestFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindNearest([pFinStat]);
end;

function TOciBtr.NearestPaGsSt (pPaCode:longint;pGsCode:longint;pStkStat:Str1):boolean;
begin
  SetIndex (ixPaGsSt);
  Result := oBtrTable.FindNearest([pPaCode,pGsCode,pStkStat]);
end;

function TOciBtr.NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindNearest([pScdNum,pScdItm]);
end;

function TOciBtr.NearestComNum (pComNum:Str14):boolean;
begin
  SetIndex (ixComNum);
  Result := oBtrTable.FindNearest([pComNum]);
end;

function TOciBtr.NearestDoSt (pDocNum:Str12;pStkStat:Str1):boolean;
begin
  SetIndex (ixDoSt);
  Result := oBtrTable.FindNearest([pDocNum,pStkStat]);
end;

procedure TOciBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOciBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOciBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOciBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOciBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOciBtr.First;
begin
  oBtrTable.First;
end;

procedure TOciBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOciBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOciBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOciBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOciBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOciBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOciBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOciBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOciBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOciBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOciBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1926001}
