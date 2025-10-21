unit bTCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixDnGc = 'DnGc';
  ixPaCode = 'PaCode';
  ixStkStat = 'StkStat';
  ixFinStat = 'FinStat';
  ixGsType = 'GsType';
  ixSnSi = 'SnSi';
  ixRbaCode = 'RbaCode';

type
  TTciBtr = class (TComponent)
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
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
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
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadDlvUser:Str8;          procedure WriteDlvUser (pValue:Str8);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadMcdNum:Str12;          procedure WriteMcdNum (pValue:Str12);
    function  ReadMcdItm:word;           procedure WriteMcdItm (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
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
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadGscQnt:double;         procedure WriteGscQnt (pValue:double);
    function  ReadGspQnt:double;         procedure WriteGspQnt (pValue:double);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspDate:TDatetime;     procedure WriteRspDate (pValue:TDatetime);
    function  ReadRspTime:TDatetime;     procedure WriteRspTime (pValue:TDatetime);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
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
    function LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function LocateGsType (pGsType:Str1):boolean;
    function LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestDnGc (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestFinStat (pFinStat:Str1):boolean;
    function NearestGsType (pGsType:Str1):boolean;
    function NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
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
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property DlvUser:Str8 read ReadDlvUser write WriteDlvUser;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property McdNum:Str12 read ReadMcdNum write WriteMcdNum;
    property McdItm:word read ReadMcdItm write WriteMcdItm;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
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
    property DscType:Str1 read ReadDscType write WriteDscType;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property GscQnt:double read ReadGscQnt write WriteGscQnt;
    property GspQnt:double read ReadGspQnt write WriteGspQnt;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspDate:TDatetime read ReadRspDate write WriteRspDate;
    property RspTime:TDatetime read ReadRspTime write WriteRspTime;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property Cctvat:byte read ReadCctvat write WriteCctvat;
  end;

implementation

constructor TTciBtr.Create;
begin
  oBtrTable := BtrInit ('TCI',gPath.StkPath,Self);
end;

constructor TTciBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TCI',pPath,Self);
end;

destructor TTciBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTciBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTciBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTciBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTciBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTciBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTciBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTciBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTciBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTciBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTciBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTciBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTciBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTciBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTciBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTciBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TTciBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TTciBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTciBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TTciBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTciBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTciBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TTciBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TTciBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TTciBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TTciBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TTciBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TTciBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TTciBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TTciBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTciBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTciBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTciBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTciBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTciBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTciBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TTciBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TTciBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTciBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTciBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TTciBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TTciBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TTciBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TTciBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TTciBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TTciBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TTciBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TTciBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTciBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TTciBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TTciBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TTciBtr.ReadFgAPrice:double;
begin
  Result := oBtrTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TTciBtr.WriteFgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TTciBtr.ReadFgBPrice:double;
begin
  Result := oBtrTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TTciBtr.WriteFgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TTciBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTciBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTciBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TTciBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TTciBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TTciBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TTciBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TTciBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TTciBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TTciBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TTciBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TTciBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TTciBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTciBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTciBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTciBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTciBtr.ReadDlvUser:Str8;
begin
  Result := oBtrTable.FieldByName('DlvUser').AsString;
end;

procedure TTciBtr.WriteDlvUser(pValue:Str8);
begin
  oBtrTable.FieldByName('DlvUser').AsString := pValue;
end;

function TTciBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTciBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTciBtr.ReadMcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('McdNum').AsString;
end;

procedure TTciBtr.WriteMcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('McdNum').AsString := pValue;
end;

function TTciBtr.ReadMcdItm:word;
begin
  Result := oBtrTable.FieldByName('McdItm').AsInteger;
end;

procedure TTciBtr.WriteMcdItm(pValue:word);
begin
  oBtrTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TTciBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTciBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTciBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TTciBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TTciBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTciBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTciBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TTciBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TTciBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TTciBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TTciBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TTciBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TTciBtr.ReadFinStat:Str1;
begin
  Result := oBtrTable.FieldByName('FinStat').AsString;
end;

procedure TTciBtr.WriteFinStat(pValue:Str1);
begin
  oBtrTable.FieldByName('FinStat').AsString := pValue;
end;

function TTciBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TTciBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TTciBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTciBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTciBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTciBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTciBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTciBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTciBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTciBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTciBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTciBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTciBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTciBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTciBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTciBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTciBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TTciBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TTciBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TTciBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TTciBtr.ReadBonNum:byte;
begin
  Result := oBtrTable.FieldByName('BonNum').AsInteger;
end;

procedure TTciBtr.WriteBonNum(pValue:byte);
begin
  oBtrTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TTciBtr.ReadGscQnt:double;
begin
  Result := oBtrTable.FieldByName('GscQnt').AsFloat;
end;

procedure TTciBtr.WriteGscQnt(pValue:double);
begin
  oBtrTable.FieldByName('GscQnt').AsFloat := pValue;
end;

function TTciBtr.ReadGspQnt:double;
begin
  Result := oBtrTable.FieldByName('GspQnt').AsFloat;
end;

procedure TTciBtr.WriteGspQnt(pValue:double);
begin
  oBtrTable.FieldByName('GspQnt').AsFloat := pValue;
end;

function TTciBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTciBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TTciBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TTciBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TTciBtr.ReadHdsPrc:double;
begin
  Result := oBtrTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TTciBtr.WriteHdsPrc(pValue:double);
begin
  oBtrTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TTciBtr.ReadFgHdsVal:double;
begin
  Result := oBtrTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TTciBtr.WriteFgHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TTciBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TTciBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TTciBtr.ReadAcRndVat:double;
begin
  Result := oBtrTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TTciBtr.WriteAcRndVat(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TTciBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TTciBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TTciBtr.ReadFgRndVat:double;
begin
  Result := oBtrTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TTciBtr.WriteFgRndVat(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TTciBtr.ReadScdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScdNum').AsString;
end;

procedure TTciBtr.WriteScdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScdNum').AsString := pValue;
end;

function TTciBtr.ReadScdItm:word;
begin
  Result := oBtrTable.FieldByName('ScdItm').AsInteger;
end;

procedure TTciBtr.WriteScdItm(pValue:word);
begin
  oBtrTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TTciBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTciBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTciBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TTciBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TTciBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TTciBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TTciBtr.ReadRspDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RspDate').AsDateTime;
end;

procedure TTciBtr.WriteRspDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RspDate').AsDateTime := pValue;
end;

function TTciBtr.ReadRspTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RspTime').AsDateTime;
end;

procedure TTciBtr.WriteRspTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RspTime').AsDateTime := pValue;
end;

function TTciBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TTciBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TTciBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TTciBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TTciBtr.ReadExpQnt:double;
begin
  Result := oBtrTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TTciBtr.WriteExpQnt(pValue:double);
begin
  oBtrTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TTciBtr.ReadCctvat:byte;
begin
  Result := oBtrTable.FieldByName('Cctvat').AsInteger;
end;

procedure TTciBtr.WriteCctvat(pValue:byte);
begin
  oBtrTable.FieldByName('Cctvat').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTciBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTciBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTciBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTciBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTciBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTciBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTciBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTciBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTciBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTciBtr.LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TTciBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTciBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TTciBtr.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindKey([pFinStat]);
end;

function TTciBtr.LocateGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindKey([pGsType]);
end;

function TTciBtr.LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindKey([pScdNum,pScdItm]);
end;

function TTciBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TTciBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTciBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTciBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TTciBtr.NearestDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

function TTciBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTciBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TTciBtr.NearestFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindNearest([pFinStat]);
end;

function TTciBtr.NearestGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindNearest([pGsType]);
end;

function TTciBtr.NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindNearest([pScdNum,pScdItm]);
end;

function TTciBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TTciBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTciBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTciBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTciBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTciBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTciBtr.First;
begin
  oBtrTable.First;
end;

procedure TTciBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTciBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTciBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTciBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTciBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTciBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTciBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTciBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTciBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTciBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTciBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
