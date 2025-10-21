unit bTSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixStkStat = 'StkStat';
  ixFinStat = 'FinStat';
  ixPaCode = 'PaCode';
  ixRbaCode = 'RbaCode';

type
  TTsiBtr = class (TComponent)
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
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcSPrice:double;       procedure WriteAcSPrice (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcZValue:double;       procedure WriteAcZValue (pValue:double);
    function  ReadAcTValue:double;       procedure WriteAcTValue (pValue:double);
    function  ReadAcOValue:double;       procedure WriteAcOValue (pValue:double);
    function  ReadAcSValue:double;       procedure WriteAcSValue (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgEPrice:double;       procedure WriteFgEPrice (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadIsdNum:Str12;          procedure WriteIsdNum (pValue:Str12);
    function  ReadIsdItm:word;           procedure WriteIsdItm (pValue:word);
    function  ReadIsdDate:TDatetime;     procedure WriteIsdDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadOmdNum:Str12;          procedure WriteOmdNum (pValue:Str12);
    function  ReadPkdNum:Str12;          procedure WritePkdNum (pValue:Str12);
    function  ReadPkdItm:word;           procedure WritePkdItm (pValue:word);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadCctvat:byte;           procedure WriteCctvat (pValue:byte);
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
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestFinStat (pFinStat:Str1):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestRbaCode (pRbaCode:Str30):boolean;

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
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcSPrice:double read ReadAcSPrice write WriteAcSPrice;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcZValue:double read ReadAcZValue write WriteAcZValue;
    property AcTValue:double read ReadAcTValue write WriteAcTValue;
    property AcOValue:double read ReadAcOValue write WriteAcOValue;
    property AcSValue:double read ReadAcSValue write WriteAcSValue;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgEPrice:double read ReadFgEPrice write WriteFgEPrice;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property IsdNum:Str12 read ReadIsdNum write WriteIsdNum;
    property IsdItm:word read ReadIsdItm write WriteIsdItm;
    property IsdDate:TDatetime read ReadIsdDate write WriteIsdDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property OmdNum:Str12 read ReadOmdNum write WriteOmdNum;
    property PkdNum:Str12 read ReadPkdNum write WritePkdNum;
    property PkdItm:word read ReadPkdItm write WritePkdItm;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property Cctvat:byte read ReadCctvat write WriteCctvat;
  end;

implementation

constructor TTsiBtr.Create;
begin
  oBtrTable := BtrInit ('TSI',gPath.StkPath,Self);
end;

constructor TTsiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TSI',pPath,Self);
end;

destructor TTsiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTsiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTsiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTsiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTsiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTsiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTsiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTsiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTsiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTsiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTsiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTsiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTsiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTsiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTsiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTsiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TTsiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TTsiBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTsiBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TTsiBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TTsiBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TTsiBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TTsiBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TTsiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTsiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTsiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTsiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTsiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTsiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTsiBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TTsiBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TTsiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTsiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTsiBtr.ReadAcSPrice:double;
begin
  Result := oBtrTable.FieldByName('AcSPrice').AsFloat;
end;

procedure TTsiBtr.WriteAcSPrice(pValue:double);
begin
  oBtrTable.FieldByName('AcSPrice').AsFloat := pValue;
end;

function TTsiBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTsiBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTsiBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTsiBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTsiBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TTsiBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcZValue:double;
begin
  Result := oBtrTable.FieldByName('AcZValue').AsFloat;
end;

procedure TTsiBtr.WriteAcZValue(pValue:double);
begin
  oBtrTable.FieldByName('AcZValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcTValue:double;
begin
  Result := oBtrTable.FieldByName('AcTValue').AsFloat;
end;

procedure TTsiBtr.WriteAcTValue(pValue:double);
begin
  oBtrTable.FieldByName('AcTValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcOValue:double;
begin
  Result := oBtrTable.FieldByName('AcOValue').AsFloat;
end;

procedure TTsiBtr.WriteAcOValue(pValue:double);
begin
  oBtrTable.FieldByName('AcOValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcSValue:double;
begin
  Result := oBtrTable.FieldByName('AcSValue').AsFloat;
end;

procedure TTsiBtr.WriteAcSValue(pValue:double);
begin
  oBtrTable.FieldByName('AcSValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTsiBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTsiBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTsiBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTsiBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTsiBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTsiBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TTsiBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TTsiBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTsiBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TTsiBtr.ReadFgEPrice:double;
begin
  Result := oBtrTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TTsiBtr.WriteFgEPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgEPrice').AsFloat := pValue;
end;

function TTsiBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTsiBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTsiBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTsiBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTsiBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTsiBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTsiBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTsiBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTsiBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TTsiBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TTsiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTsiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTsiBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTsiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTsiBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TTsiBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TTsiBtr.ReadOsdItm:word;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TTsiBtr.WriteOsdItm(pValue:word);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TTsiBtr.ReadIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IsdNum').AsString;
end;

procedure TTsiBtr.WriteIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IsdNum').AsString := pValue;
end;

function TTsiBtr.ReadIsdItm:word;
begin
  Result := oBtrTable.FieldByName('IsdItm').AsInteger;
end;

procedure TTsiBtr.WriteIsdItm(pValue:word);
begin
  oBtrTable.FieldByName('IsdItm').AsInteger := pValue;
end;

function TTsiBtr.ReadIsdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IsdDate').AsDateTime;
end;

procedure TTsiBtr.WriteIsdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IsdDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TTsiBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TTsiBtr.ReadFinStat:Str1;
begin
  Result := oBtrTable.FieldByName('FinStat').AsString;
end;

procedure TTsiBtr.WriteFinStat(pValue:Str1);
begin
  oBtrTable.FieldByName('FinStat').AsString := pValue;
end;

function TTsiBtr.ReadAcqStat:Str1;
begin
  Result := oBtrTable.FieldByName('AcqStat').AsString;
end;

procedure TTsiBtr.WriteAcqStat(pValue:Str1);
begin
  oBtrTable.FieldByName('AcqStat').AsString := pValue;
end;

function TTsiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTsiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTsiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTsiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTsiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTsiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTsiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTsiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTsiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTsiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTsiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTsiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTsiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTsiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTsiBtr.ReadOcdItm:longint;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TTsiBtr.WriteOcdItm(pValue:longint);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TTsiBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TTsiBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTsiBtr.ReadOmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OmdNum').AsString;
end;

procedure TTsiBtr.WriteOmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OmdNum').AsString := pValue;
end;

function TTsiBtr.ReadPkdNum:Str12;
begin
  Result := oBtrTable.FieldByName('PkdNum').AsString;
end;

procedure TTsiBtr.WritePkdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('PkdNum').AsString := pValue;
end;

function TTsiBtr.ReadPkdItm:word;
begin
  Result := oBtrTable.FieldByName('PkdItm').AsInteger;
end;

procedure TTsiBtr.WritePkdItm(pValue:word);
begin
  oBtrTable.FieldByName('PkdItm').AsInteger := pValue;
end;

function TTsiBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TTsiBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTsiBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTsiBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTsiBtr.ReadCctvat:byte;
begin
  Result := oBtrTable.FieldByName('Cctvat').AsInteger;
end;

procedure TTsiBtr.WriteCctvat(pValue:byte);
begin
  oBtrTable.FieldByName('Cctvat').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTsiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTsiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTsiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTsiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTsiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTsiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTsiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTsiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTsiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTsiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TTsiBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TTsiBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TTsiBtr.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindKey([pFinStat]);
end;

function TTsiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTsiBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TTsiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTsiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTsiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TTsiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TTsiBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TTsiBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TTsiBtr.NearestFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindNearest([pFinStat]);
end;

function TTsiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTsiBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TTsiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTsiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTsiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTsiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTsiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTsiBtr.First;
begin
  oBtrTable.First;
end;

procedure TTsiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTsiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTsiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTsiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTsiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTsiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTsiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTsiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTsiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTsiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTsiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
