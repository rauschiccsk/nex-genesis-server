unit bICI;

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
  ixDocDate = 'DocDate';
  ixTnTi = 'TnTi';
  ixStatus = 'Status';
  ixDlrCode = 'DlrCode';
  ixSnSi = 'SnSi';
  ixPaCode = 'PaCode';

type
  TIciBtr = class (TComponent)
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
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadMcdNum:Str12;          procedure WriteMcdNum (pValue:Str12);
    function  ReadMcdItm:word;           procedure WriteMcdItm (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdDate:TDatetime;     procedure WriteTcdDate (pValue:TDatetime);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str8;           procedure WriteAccAnl (pValue:Str8);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadGscQnt:double;         procedure WriteGscQnt (pValue:double);
    function  ReadGspQnt:double;         procedure WriteGspQnt (pValue:double);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadDscGrp:byte;           procedure WriteDscGrp (pValue:byte);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspDate:TDatetime;     procedure WriteRspDate (pValue:TDatetime);
    function  ReadRspTime:TDatetime;     procedure WriteRspTime (pValue:TDatetime);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function NearestStatus (pStatus:Str1):boolean;
    function NearestDlrCode (pDlrCode:word):boolean;
    function NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property McdNum:Str12 read ReadMcdNum write WriteMcdNum;
    property McdItm:word read ReadMcdItm write WriteMcdItm;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdDate:TDatetime read ReadTcdDate write WriteTcdDate;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Action:Str1 read ReadAction write WriteAction;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str8 read ReadAccAnl write WriteAccAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property GscQnt:double read ReadGscQnt write WriteGscQnt;
    property GspQnt:double read ReadGspQnt write WriteGspQnt;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property DscGrp:byte read ReadDscGrp write WriteDscGrp;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspDate:TDatetime read ReadRspDate write WriteRspDate;
    property RspTime:TDatetime read ReadRspTime write WriteRspTime;
    property Cctvat:byte read ReadCctvat write WriteCctvat;
  end;

implementation

constructor TIciBtr.Create;
begin
  oBtrTable := BtrInit ('ICI',gPath.LdgPath,Self);
end;

constructor TIciBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ICI',pPath,Self);
end;

destructor TIciBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIciBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIciBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIciBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIciBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIciBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIciBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIciBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TIciBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TIciBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TIciBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIciBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TIciBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TIciBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TIciBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TIciBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TIciBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TIciBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TIciBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TIciBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TIciBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIciBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TIciBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TIciBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TIciBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TIciBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TIciBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TIciBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TIciBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TIciBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TIciBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TIciBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TIciBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TIciBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIciBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TIciBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIciBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIciBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIciBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIciBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIciBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIciBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIciBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIciBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIciBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIciBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIciBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIciBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TIciBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TIciBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TIciBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TIciBtr.ReadFgAPrice:double;
begin
  Result := oBtrTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TIciBtr.WriteFgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TIciBtr.ReadFgBPrice:double;
begin
  Result := oBtrTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TIciBtr.WriteFgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TIciBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIciBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIciBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIciBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIciBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIciBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIciBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TIciBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TIciBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TIciBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TIciBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TIciBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TIciBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIciBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIciBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIciBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIciBtr.ReadMcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('McdNum').AsString;
end;

procedure TIciBtr.WriteMcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('McdNum').AsString := pValue;
end;

function TIciBtr.ReadMcdItm:word;
begin
  Result := oBtrTable.FieldByName('McdItm').AsInteger;
end;

procedure TIciBtr.WriteMcdItm(pValue:word);
begin
  oBtrTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TIciBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TIciBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TIciBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TIciBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TIciBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TIciBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TIciBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TIciBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TIciBtr.ReadTcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TIciBtr.WriteTcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TIciBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TIciBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TIciBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TIciBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TIciBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TIciBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIciBtr.ReadAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TIciBtr.WriteAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIciBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIciBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIciBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIciBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIciBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIciBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIciBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIciBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIciBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIciBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIciBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIciBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIciBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIciBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIciBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TIciBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TIciBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TIciBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TIciBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TIciBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TIciBtr.ReadSpMark:Str10;
begin
  Result := oBtrTable.FieldByName('SpMark').AsString;
end;

procedure TIciBtr.WriteSpMark(pValue:Str10);
begin
  oBtrTable.FieldByName('SpMark').AsString := pValue;
end;

function TIciBtr.ReadBonNum:byte;
begin
  Result := oBtrTable.FieldByName('BonNum').AsInteger;
end;

procedure TIciBtr.WriteBonNum(pValue:byte);
begin
  oBtrTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TIciBtr.ReadGscQnt:double;
begin
  Result := oBtrTable.FieldByName('GscQnt').AsFloat;
end;

procedure TIciBtr.WriteGscQnt(pValue:double);
begin
  oBtrTable.FieldByName('GscQnt').AsFloat := pValue;
end;

function TIciBtr.ReadGspQnt:double;
begin
  Result := oBtrTable.FieldByName('GspQnt').AsFloat;
end;

procedure TIciBtr.WriteGspQnt(pValue:double);
begin
  oBtrTable.FieldByName('GspQnt').AsFloat := pValue;
end;

function TIciBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TIciBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TIciBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIciBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIciBtr.ReadFgHValue:double;
begin
  Result := oBtrTable.FieldByName('FgHValue').AsFloat;
end;

procedure TIciBtr.WriteFgHValue(pValue:double);
begin
  oBtrTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TIciBtr.ReadSteCode:word;
begin
  Result := oBtrTable.FieldByName('SteCode').AsInteger;
end;

procedure TIciBtr.WriteSteCode(pValue:word);
begin
  oBtrTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TIciBtr.ReadDscGrp:byte;
begin
  Result := oBtrTable.FieldByName('DscGrp').AsInteger;
end;

procedure TIciBtr.WriteDscGrp(pValue:byte);
begin
  oBtrTable.FieldByName('DscGrp').AsInteger := pValue;
end;

function TIciBtr.ReadHdsPrc:double;
begin
  Result := oBtrTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TIciBtr.WriteHdsPrc(pValue:double);
begin
  oBtrTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TIciBtr.ReadFgHdsVal:double;
begin
  Result := oBtrTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TIciBtr.WriteFgHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TIciBtr.ReadAcRndVal:double;
begin
  Result := oBtrTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TIciBtr.WriteAcRndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TIciBtr.ReadAcRndVat:double;
begin
  Result := oBtrTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TIciBtr.WriteAcRndVat(pValue:double);
begin
  oBtrTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TIciBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TIciBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TIciBtr.ReadFgRndVat:double;
begin
  Result := oBtrTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TIciBtr.WriteFgRndVat(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TIciBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIciBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIciBtr.ReadScdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScdNum').AsString;
end;

procedure TIciBtr.WriteScdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScdNum').AsString := pValue;
end;

function TIciBtr.ReadScdItm:word;
begin
  Result := oBtrTable.FieldByName('ScdItm').AsInteger;
end;

procedure TIciBtr.WriteScdItm(pValue:word);
begin
  oBtrTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TIciBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TIciBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TIciBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TIciBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TIciBtr.ReadRspDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RspDate').AsDateTime;
end;

procedure TIciBtr.WriteRspDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RspDate').AsDateTime := pValue;
end;

function TIciBtr.ReadRspTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('RspTime').AsDateTime;
end;

procedure TIciBtr.WriteRspTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RspTime').AsDateTime := pValue;
end;

function TIciBtr.ReadCctvat:byte;
begin
  Result := oBtrTable.FieldByName('Cctvat').AsInteger;
end;

procedure TIciBtr.WriteCctvat(pValue:byte);
begin
  oBtrTable.FieldByName('Cctvat').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIciBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIciBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIciBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIciBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIciBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIciBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIciBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TIciBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIciBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TIciBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TIciBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIciBtr.LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindKey([pTcdNum,pTcdItm]);
end;

function TIciBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TIciBtr.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindKey([pDlrCode]);
end;

function TIciBtr.LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindKey([pScdNum,pScdItm]);
end;

function TIciBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TIciBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TIciBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIciBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TIciBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TIciBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIciBtr.NearestTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindNearest([pTcdNum,pTcdItm]);
end;

function TIciBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

function TIciBtr.NearestDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oBtrTable.FindNearest([pDlrCode]);
end;

function TIciBtr.NearestSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oBtrTable.FindNearest([pScdNum,pScdItm]);
end;

function TIciBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TIciBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIciBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIciBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIciBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIciBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIciBtr.First;
begin
  oBtrTable.First;
end;

procedure TIciBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIciBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIciBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIciBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIciBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIciBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIciBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIciBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIciBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIciBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIciBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2005001}
