unit bIMI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStDoIt = 'StDoIt';
  ixDoIt = 'DoIt';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixGsName = 'GsName';
  ixCPrice = 'CPrice';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixGsQnt = 'GsQnt';
  ixStkStat = 'StkStat';
  ixConStk = 'ConStk';
  ixDocNum = 'DocNum';
  ixPosCode = 'PosCode';
  ixRbaCode = 'RbaCode';

type
  TImiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  Readx_GsName:Str30;        procedure Writex_GsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  Readx_BStQnt:double;       procedure Writex_BStQnt (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  Readx_AStQnt:double;       procedure Writex_AStQnt (pValue:double);
    function  Readx_BStVal:double;       procedure Writex_BStVal (pValue:double);
    function  Readx_AStVal:double;       procedure Writex_AStVal (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadRndVal:double;         procedure WriteRndVal (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadNotice:Str40;          procedure WriteNotice (pValue:Str40);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  Readx_ImpName:Str8;        procedure Writex_ImpName (pValue:Str8);
    function  Readx_ImpDate:TDatetime;   procedure Writex_ImpDate (pValue:TDatetime);
    function  Readx_ImpTime:TDatetime;   procedure Writex_ImpTime (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadSrcDoc:Str12;          procedure WriteSrcDoc (pValue:Str12);
    function  ReadSrcItm:word;           procedure WriteSrcItm (pValue:word);
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  Readx_FIFOStr:Str220;      procedure Writex_FIFOStr (pValue:Str220);
    function  Readx_Note1:Str60;         procedure Writex_Note1 (pValue:Str60);
    function  Readx_Note2:Str60;         procedure Writex_Note2 (pValue:Str60);
    function  Readx_Note3:Str60;         procedure Writex_Note3 (pValue:Str60);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateStDoIt (pStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:word;pGsCode:longint):boolean;
    function LocateGsName (px_GsName:Str30):boolean;
    function LocateCPrice (pCPrice:double):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateGsQnt (pGsQnt:double):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateConStk (pConStk:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocatePosCode (pPosCode:Str15):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestStDoIt (pStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgGs (pMgCode:word;pGsCode:longint):boolean;
    function NearestGsName (px_GsName:Str30):boolean;
    function NearestCPrice (pCPrice:double):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestGsQnt (pGsQnt:double):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestConStk (pConStk:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestPosCode (pPosCode:Str15):boolean;
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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ConStk:word read ReadConStk write WriteConStk;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property x_GsName:Str30 read Readx_GsName write Writex_GsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property x_BStQnt:double read Readx_BStQnt write Writex_BStQnt;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property x_AStQnt:double read Readx_AStQnt write Writex_AStQnt;
    property x_BStVal:double read Readx_BStVal write Writex_BStVal;
    property x_AStVal:double read Readx_AStVal write Writex_AStVal;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property RndVal:double read ReadRndVal write WriteRndVal;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Notice:Str40 read ReadNotice write WriteNotice;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property x_ImpName:Str8 read Readx_ImpName write Writex_ImpName;
    property x_ImpDate:TDatetime read Readx_ImpDate write Writex_ImpDate;
    property x_ImpTime:TDatetime read Readx_ImpTime write Writex_ImpTime;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ModNum:word read ReadModNum write WriteModNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property SrcDoc:Str12 read ReadSrcDoc write WriteSrcDoc;
    property SrcItm:word read ReadSrcItm write WriteSrcItm;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property x_FIFOStr:Str220 read Readx_FIFOStr write Writex_FIFOStr;
    property x_Note1:Str60 read Readx_Note1 write Writex_Note1;
    property x_Note2:Str60 read Readx_Note2 write Writex_Note2;
    property x_Note3:Str60 read Readx_Note3 write Writex_Note3;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TImiBtr.Create;
begin
  oBtrTable := BtrInit ('IMI',gPath.StkPath,Self);
end;

constructor TImiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IMI',pPath,Self);
end;

destructor TImiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TImiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TImiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TImiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TImiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TImiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TImiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TImiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TImiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TImiBtr.ReadConStk:word;
begin
  Result := oBtrTable.FieldByName('ConStk').AsInteger;
end;

procedure TImiBtr.WriteConStk(pValue:word);
begin
  oBtrTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TImiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TImiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TImiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TImiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TImiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TImiBtr.Readx_GsName:Str30;
begin
  Result := oBtrTable.FieldByName('x_GsName').AsString;
end;

procedure TImiBtr.Writex_GsName(pValue:Str30);
begin
  oBtrTable.FieldByName('x_GsName').AsString := pValue;
end;

function TImiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TImiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TImiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TImiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TImiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TImiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TImiBtr.Readx_BStQnt:double;
begin
  Result := oBtrTable.FieldByName('x_BStQnt').AsFloat;
end;

procedure TImiBtr.Writex_BStQnt(pValue:double);
begin
  oBtrTable.FieldByName('x_BStQnt').AsFloat := pValue;
end;

function TImiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TImiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TImiBtr.Readx_AStQnt:double;
begin
  Result := oBtrTable.FieldByName('x_AStQnt').AsFloat;
end;

procedure TImiBtr.Writex_AStQnt(pValue:double);
begin
  oBtrTable.FieldByName('x_AStQnt').AsFloat := pValue;
end;

function TImiBtr.Readx_BStVal:double;
begin
  Result := oBtrTable.FieldByName('x_BStVal').AsFloat;
end;

procedure TImiBtr.Writex_BStVal(pValue:double);
begin
  oBtrTable.FieldByName('x_BStVal').AsFloat := pValue;
end;

function TImiBtr.Readx_AStVal:double;
begin
  Result := oBtrTable.FieldByName('x_AStVal').AsFloat;
end;

procedure TImiBtr.Writex_AStVal(pValue:double);
begin
  oBtrTable.FieldByName('x_AStVal').AsFloat := pValue;
end;

function TImiBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TImiBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TImiBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TImiBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TImiBtr.ReadEPrice:double;
begin
  Result := oBtrTable.FieldByName('EPrice').AsFloat;
end;

procedure TImiBtr.WriteEPrice(pValue:double);
begin
  oBtrTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TImiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TImiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TImiBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TImiBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TImiBtr.ReadRndVal:double;
begin
  Result := oBtrTable.FieldByName('RndVal').AsFloat;
end;

procedure TImiBtr.WriteRndVal(pValue:double);
begin
  oBtrTable.FieldByName('RndVal').AsFloat := pValue;
end;

function TImiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TImiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TImiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TImiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TImiBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TImiBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TImiBtr.ReadNotice:Str40;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TImiBtr.WriteNotice(pValue:Str40);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TImiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TImiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TImiBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TImiBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TImiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TImiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TImiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TImiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TImiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TImiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TImiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TImiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TImiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TImiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TImiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TImiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TImiBtr.Readx_ImpName:Str8;
begin
  Result := oBtrTable.FieldByName('x_ImpName').AsString;
end;

procedure TImiBtr.Writex_ImpName(pValue:Str8);
begin
  oBtrTable.FieldByName('x_ImpName').AsString := pValue;
end;

function TImiBtr.Readx_ImpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_ImpDate').AsDateTime;
end;

procedure TImiBtr.Writex_ImpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_ImpDate').AsDateTime := pValue;
end;

function TImiBtr.Readx_ImpTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_ImpTime').AsDateTime;
end;

procedure TImiBtr.Writex_ImpTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_ImpTime').AsDateTime := pValue;
end;

function TImiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TImiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TImiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TImiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TImiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TImiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TImiBtr.ReadOcdItm:longint;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TImiBtr.WriteOcdItm(pValue:longint);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TImiBtr.ReadSrcDoc:Str12;
begin
  Result := oBtrTable.FieldByName('SrcDoc').AsString;
end;

procedure TImiBtr.WriteSrcDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('SrcDoc').AsString := pValue;
end;

function TImiBtr.ReadSrcItm:word;
begin
  Result := oBtrTable.FieldByName('SrcItm').AsInteger;
end;

procedure TImiBtr.WriteSrcItm(pValue:word);
begin
  oBtrTable.FieldByName('SrcItm').AsInteger := pValue;
end;

function TImiBtr.ReadPosCode:Str15;
begin
  Result := oBtrTable.FieldByName('PosCode').AsString;
end;

procedure TImiBtr.WritePosCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PosCode').AsString := pValue;
end;

function TImiBtr.Readx_FIFOStr:Str220;
begin
  Result := oBtrTable.FieldByName('x_FIFOStr').AsString;
end;

procedure TImiBtr.Writex_FIFOStr(pValue:Str220);
begin
  oBtrTable.FieldByName('x_FIFOStr').AsString := pValue;
end;

function TImiBtr.Readx_Note1:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note1').AsString;
end;

procedure TImiBtr.Writex_Note1(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note1').AsString := pValue;
end;

function TImiBtr.Readx_Note2:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note2').AsString;
end;

procedure TImiBtr.Writex_Note2(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note2').AsString := pValue;
end;

function TImiBtr.Readx_Note3:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note3').AsString;
end;

procedure TImiBtr.Writex_Note3(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note3').AsString := pValue;
end;

function TImiBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TImiBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TImiBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TImiBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TImiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TImiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TImiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TImiBtr.LocateStDoIt (pStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixStDoIt);
  Result := oBtrTable.FindKey([pStkNum,pDocNum,pItmNum]);
end;

function TImiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TImiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TImiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TImiBtr.LocateMgGs (pMgCode:word;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindKey([pMgCode,pGsCode]);
end;

function TImiBtr.LocateGsName (px_GsName:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([px_GsName]);
end;

function TImiBtr.LocateCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindKey([pCPrice]);
end;

function TImiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TImiBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TImiBtr.LocateGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oBtrTable.FindKey([pGsQnt]);
end;

function TImiBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TImiBtr.LocateConStk (pConStk:word):boolean;
begin
  SetIndex (ixConStk);
  Result := oBtrTable.FindKey([pConStk]);
end;

function TImiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TImiBtr.LocatePosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oBtrTable.FindKey([pPosCode]);
end;

function TImiBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TImiBtr.NearestStDoIt (pStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixStDoIt);
  Result := oBtrTable.FindNearest([pStkNum,pDocNum,pItmNum]);
end;

function TImiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TImiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TImiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TImiBtr.NearestMgGs (pMgCode:word;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindNearest([pMgCode,pGsCode]);
end;

function TImiBtr.NearestGsName (px_GsName:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([px_GsName]);
end;

function TImiBtr.NearestCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindNearest([pCPrice]);
end;

function TImiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TImiBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TImiBtr.NearestGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oBtrTable.FindNearest([pGsQnt]);
end;

function TImiBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TImiBtr.NearestConStk (pConStk:word):boolean;
begin
  SetIndex (ixConStk);
  Result := oBtrTable.FindNearest([pConStk]);
end;

function TImiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TImiBtr.NearestPosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oBtrTable.FindNearest([pPosCode]);
end;

function TImiBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TImiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TImiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TImiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TImiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TImiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TImiBtr.First;
begin
  oBtrTable.First;
end;

procedure TImiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TImiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TImiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TImiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TImiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TImiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TImiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TImiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TImiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TImiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TImiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1809010}
