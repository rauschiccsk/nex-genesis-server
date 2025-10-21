unit bRMI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStDoIt = 'StDoIt';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixGsName = 'GsName';
  ixCPrice = 'CPrice';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixGsQnt = 'GsQnt';
  ixStkStat = 'StkStat';
  ixSrcPos = 'SrcPos';
  ixTrgPos = 'TrgPos';
  ixRbaCode = 'RbaCode';

type
  TRmiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadScStkNum:word;         procedure WriteScStkNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  Readx_BStQnt:double;       procedure Writex_BStQnt (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  Readx_BStVal:double;       procedure Writex_BStVal (pValue:double);
    function  Readx_AStVal:double;       procedure Writex_AStVal (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadNotice:Str40;          procedure WriteNotice (pValue:Str40);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  Readx_ActPos:longint;      procedure Writex_ActPos (pValue:longint);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadTgStkNum:word;         procedure WriteTgStkNum (pValue:word);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadCndNum:Str12;          procedure WriteCndNum (pValue:Str12);
    function  ReadSrdNum:Str12;          procedure WriteSrdNum (pValue:Str12);
    function  ReadSrdItm:word;           procedure WriteSrdItm (pValue:word);
    function  ReadSrcPos:Str15;          procedure WriteSrcPos (pValue:Str15);
    function  ReadTrgPos:Str15;          procedure WriteTrgPos (pValue:Str15);
    function  Readx_FIFOStr:Str195;      procedure Writex_FIFOStr (pValue:Str195);
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
    function LocateStDoIt (pScStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:word;pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateCPrice (pCPrice:double):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateGsQnt (pGsQnt:double):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateSrcPos (pSrcPos:Str15):boolean;
    function LocateTrgPos (pTrgPos:Str15):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestStDoIt (pScStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgGs (pMgCode:word;pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str30):boolean;
    function NearestCPrice (pCPrice:double):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestGsQnt (pGsQnt:double):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestSrcPos (pSrcPos:Str15):boolean;
    function NearestTrgPos (pTrgPos:Str15):boolean;
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
    property ScStkNum:word read ReadScStkNum write WriteScStkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property x_BStQnt:double read Readx_BStQnt write Writex_BStQnt;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property x_BStVal:double read Readx_BStVal write Writex_BStVal;
    property x_AStVal:double read Readx_AStVal write Writex_AStVal;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Notice:Str40 read ReadNotice write WriteNotice;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property x_ActPos:longint read Readx_ActPos write Writex_ActPos;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ModNum:word read ReadModNum write WriteModNum;
    property TgStkNum:word read ReadTgStkNum write WriteTgStkNum;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property CndNum:Str12 read ReadCndNum write WriteCndNum;
    property SrdNum:Str12 read ReadSrdNum write WriteSrdNum;
    property SrdItm:word read ReadSrdItm write WriteSrdItm;
    property SrcPos:Str15 read ReadSrcPos write WriteSrcPos;
    property TrgPos:Str15 read ReadTrgPos write WriteTrgPos;
    property x_FIFOStr:Str195 read Readx_FIFOStr write Writex_FIFOStr;
    property x_Note1:Str60 read Readx_Note1 write Writex_Note1;
    property x_Note2:Str60 read Readx_Note2 write Writex_Note2;
    property x_Note3:Str60 read Readx_Note3 write Writex_Note3;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TRmiBtr.Create;
begin
  oBtrTable := BtrInit ('RMI',gPath.StkPath,Self);
end;

constructor TRmiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RMI',pPath,Self);
end;

destructor TRmiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRmiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRmiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRmiBtr.ReadScStkNum:word;
begin
  Result := oBtrTable.FieldByName('ScStkNum').AsInteger;
end;

procedure TRmiBtr.WriteScStkNum(pValue:word);
begin
  oBtrTable.FieldByName('ScStkNum').AsInteger := pValue;
end;

function TRmiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRmiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRmiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRmiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRmiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TRmiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TRmiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TRmiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRmiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TRmiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TRmiBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TRmiBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TRmiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TRmiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TRmiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TRmiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TRmiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TRmiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TRmiBtr.Readx_BStQnt:double;
begin
  Result := oBtrTable.FieldByName('x_BStQnt').AsFloat;
end;

procedure TRmiBtr.Writex_BStQnt(pValue:double);
begin
  oBtrTable.FieldByName('x_BStQnt').AsFloat := pValue;
end;

function TRmiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TRmiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TRmiBtr.ReadExpQnt:double;
begin
  Result := oBtrTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TRmiBtr.WriteExpQnt(pValue:double);
begin
  oBtrTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TRmiBtr.Readx_BStVal:double;
begin
  Result := oBtrTable.FieldByName('x_BStVal').AsFloat;
end;

procedure TRmiBtr.Writex_BStVal(pValue:double);
begin
  oBtrTable.FieldByName('x_BStVal').AsFloat := pValue;
end;

function TRmiBtr.Readx_AStVal:double;
begin
  Result := oBtrTable.FieldByName('x_AStVal').AsFloat;
end;

procedure TRmiBtr.Writex_AStVal(pValue:double);
begin
  oBtrTable.FieldByName('x_AStVal').AsFloat := pValue;
end;

function TRmiBtr.ReadVatPrc:double;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsFloat;
end;

procedure TRmiBtr.WriteVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TRmiBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TRmiBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TRmiBtr.ReadEPrice:double;
begin
  Result := oBtrTable.FieldByName('EPrice').AsFloat;
end;

procedure TRmiBtr.WriteEPrice(pValue:double);
begin
  oBtrTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TRmiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TRmiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRmiBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TRmiBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TRmiBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TRmiBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TRmiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TRmiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TRmiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TRmiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRmiBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TRmiBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRmiBtr.ReadNotice:Str40;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TRmiBtr.WriteNotice(pValue:Str40);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TRmiBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TRmiBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TRmiBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TRmiBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TRmiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRmiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRmiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRmiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRmiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRmiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRmiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRmiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRmiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRmiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRmiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRmiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRmiBtr.Readx_ActPos:longint;
begin
  Result := oBtrTable.FieldByName('x_ActPos').AsInteger;
end;

procedure TRmiBtr.Writex_ActPos(pValue:longint);
begin
  oBtrTable.FieldByName('x_ActPos').AsInteger := pValue;
end;

function TRmiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TRmiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TRmiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TRmiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TRmiBtr.ReadTgStkNum:word;
begin
  Result := oBtrTable.FieldByName('TgStkNum').AsInteger;
end;

procedure TRmiBtr.WriteTgStkNum(pValue:word);
begin
  oBtrTable.FieldByName('TgStkNum').AsInteger := pValue;
end;

function TRmiBtr.ReadScSmCode:word;
begin
  Result := oBtrTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TRmiBtr.WriteScSmCode(pValue:word);
begin
  oBtrTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TRmiBtr.ReadTgSmCode:word;
begin
  Result := oBtrTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TRmiBtr.WriteTgSmCode(pValue:word);
begin
  oBtrTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TRmiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRmiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRmiBtr.ReadCndNum:Str12;
begin
  Result := oBtrTable.FieldByName('CndNum').AsString;
end;

procedure TRmiBtr.WriteCndNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CndNum').AsString := pValue;
end;

function TRmiBtr.ReadSrdNum:Str12;
begin
  Result := oBtrTable.FieldByName('SrdNum').AsString;
end;

procedure TRmiBtr.WriteSrdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('SrdNum').AsString := pValue;
end;

function TRmiBtr.ReadSrdItm:word;
begin
  Result := oBtrTable.FieldByName('SrdItm').AsInteger;
end;

procedure TRmiBtr.WriteSrdItm(pValue:word);
begin
  oBtrTable.FieldByName('SrdItm').AsInteger := pValue;
end;

function TRmiBtr.ReadSrcPos:Str15;
begin
  Result := oBtrTable.FieldByName('SrcPos').AsString;
end;

procedure TRmiBtr.WriteSrcPos(pValue:Str15);
begin
  oBtrTable.FieldByName('SrcPos').AsString := pValue;
end;

function TRmiBtr.ReadTrgPos:Str15;
begin
  Result := oBtrTable.FieldByName('TrgPos').AsString;
end;

procedure TRmiBtr.WriteTrgPos(pValue:Str15);
begin
  oBtrTable.FieldByName('TrgPos').AsString := pValue;
end;

function TRmiBtr.Readx_FIFOStr:Str195;
begin
  Result := oBtrTable.FieldByName('x_FIFOStr').AsString;
end;

procedure TRmiBtr.Writex_FIFOStr(pValue:Str195);
begin
  oBtrTable.FieldByName('x_FIFOStr').AsString := pValue;
end;

function TRmiBtr.Readx_Note1:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note1').AsString;
end;

procedure TRmiBtr.Writex_Note1(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note1').AsString := pValue;
end;

function TRmiBtr.Readx_Note2:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note2').AsString;
end;

procedure TRmiBtr.Writex_Note2(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note2').AsString := pValue;
end;

function TRmiBtr.Readx_Note3:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note3').AsString;
end;

procedure TRmiBtr.Writex_Note3(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note3').AsString := pValue;
end;

function TRmiBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TRmiBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TRmiBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TRmiBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRmiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRmiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRmiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRmiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRmiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRmiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRmiBtr.LocateStDoIt (pScStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixStDoIt);
  Result := oBtrTable.FindKey([pScStkNum,pDocNum,pItmNum]);
end;

function TRmiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TRmiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRmiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TRmiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TRmiBtr.LocateMgGs (pMgCode:word;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindKey([pMgCode,pGsCode]);
end;

function TRmiBtr.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TRmiBtr.LocateCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindKey([pCPrice]);
end;

function TRmiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TRmiBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TRmiBtr.LocateGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oBtrTable.FindKey([pGsQnt]);
end;

function TRmiBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TRmiBtr.LocateSrcPos (pSrcPos:Str15):boolean;
begin
  SetIndex (ixSrcPos);
  Result := oBtrTable.FindKey([pSrcPos]);
end;

function TRmiBtr.LocateTrgPos (pTrgPos:Str15):boolean;
begin
  SetIndex (ixTrgPos);
  Result := oBtrTable.FindKey([pTrgPos]);
end;

function TRmiBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TRmiBtr.NearestStDoIt (pScStkNum:word;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixStDoIt);
  Result := oBtrTable.FindNearest([pScStkNum,pDocNum,pItmNum]);
end;

function TRmiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TRmiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TRmiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TRmiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TRmiBtr.NearestMgGs (pMgCode:word;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindNearest([pMgCode,pGsCode]);
end;

function TRmiBtr.NearestGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TRmiBtr.NearestCPrice (pCPrice:double):boolean;
begin
  SetIndex (ixCPrice);
  Result := oBtrTable.FindNearest([pCPrice]);
end;

function TRmiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TRmiBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TRmiBtr.NearestGsQnt (pGsQnt:double):boolean;
begin
  SetIndex (ixGsQnt);
  Result := oBtrTable.FindNearest([pGsQnt]);
end;

function TRmiBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TRmiBtr.NearestSrcPos (pSrcPos:Str15):boolean;
begin
  SetIndex (ixSrcPos);
  Result := oBtrTable.FindNearest([pSrcPos]);
end;

function TRmiBtr.NearestTrgPos (pTrgPos:Str15):boolean;
begin
  SetIndex (ixTrgPos);
  Result := oBtrTable.FindNearest([pTrgPos]);
end;

function TRmiBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TRmiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRmiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TRmiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRmiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRmiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRmiBtr.First;
begin
  oBtrTable.First;
end;

procedure TRmiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRmiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRmiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRmiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRmiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRmiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRmiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRmiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRmiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRmiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRmiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
