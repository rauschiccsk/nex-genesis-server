unit pGSCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, DBTables, NexPxbTable;

const
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixFgCode = 'FgCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixSpcCode = 'SpcCode';
  ixOsdCode = 'OsdCode';
  ixGsType = 'GsType';
  ixPackGs = 'PackGs';
  ixDisFlag = 'DisFlag';
  ixSnWc = 'SnWc';
  ixSended = 'Sended';
  ixGaName = 'GaName';
  ixMgSc = 'MgSc';

type
  TGscatPx = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oPxbTable: TNexPxbTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadMsuQnt:double;         procedure WriteMsuQnt (pValue:double);
    function  ReadMsuName:Str5;          procedure WriteMsuName (pValue:Str5);
    function  ReadSbcCnt:word;           procedure WriteSbcCnt (pValue:word);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadLinPrice:double;       procedure WriteLinPrice (pValue:double);
    function  ReadLinDate:TDatetime;     procedure WriteLinDate (pValue:TDatetime);
    function  ReadLinStk:word;           procedure WriteLinStk (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadLinPac:longint;        procedure WriteLinPac (pValue:longint);
    function  ReadSecNum:word;           procedure WriteSecNum (pValue:word);
    function  ReadWgCode:word;           procedure WriteWgCode (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadBasGsc:longint;        procedure WriteBasGsc (pValue:longint);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadGspKfc:word;           procedure WriteGspKfc (pValue:word);
    function  ReadQliKfc:double;         procedure WriteQliKfc (pValue:double);
    function  ReadDrbDay:word;           procedure WriteDrbDay (pValue:word);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadMinOsq:double;         procedure WriteMinOsq (pValue:double);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadPrdPac:longint;        procedure WritePrdPac (pValue:longint);
    function  ReadSupPac:longint;        procedure WriteSupPac (pValue:longint);
    function  ReadSpirGs:byte;           procedure WriteSpirGs (pValue:byte);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadDivSet:byte;           procedure WriteDivSet (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateFgCode (pFgCode:longint):boolean;
    function LocateGsName (pGsName_:Str15):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateSpcCode (pSpcCode:Str30):boolean;
    function LocateOsdCode (pOsdCode:Str15):boolean;
    function LocateGsType (pGsType:Str1):boolean;
    function LocatePackGs (pPackGs:longint):boolean;
    function LocateDisFlag (pDisFlag:byte):boolean;
    function LocateSnWc (pSecNum:word;pWgCode:word):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateGaName (pGaName_:Str60):boolean;
    function LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function NearestFgCode (pFgCode:longint):boolean;
    function NearestGsName (pGsName_:Str15):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestSpcCode (pSpcCode:Str30):boolean;
    function NearestOsdCode (pOsdCode:Str15):boolean;
    function NearestGsType (pGsType:Str1):boolean;
    function NearestPackGs (pPackGs:longint):boolean;
    function NearestDisFlag (pDisFlag:byte):boolean;
    function NearestSnWc (pSecNum:word;pWgCode:word):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestGaName (pGaName_:Str60):boolean;
    function NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property PxbTable:TNexPxbTable read oPxbTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property MsuQnt:double read ReadMsuQnt write WriteMsuQnt;
    property MsuName:Str5 read ReadMsuName write WriteMsuName;
    property SbcCnt:word read ReadSbcCnt write WriteSbcCnt;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property LinPrice:double read ReadLinPrice write WriteLinPrice;
    property LinDate:TDatetime read ReadLinDate write WriteLinDate;
    property LinStk:word read ReadLinStk write WriteLinStk;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property LinPac:longint read ReadLinPac write WriteLinPac;
    property SecNum:word read ReadSecNum write WriteSecNum;
    property WgCode:word read ReadWgCode write WriteWgCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property BasGsc:longint read ReadBasGsc write WriteBasGsc;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property GspKfc:word read ReadGspKfc write WriteGspKfc;
    property QliKfc:double read ReadQliKfc write WriteQliKfc;
    property DrbDay:word read ReadDrbDay write WriteDrbDay;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property MinOsq:double read ReadMinOsq write WriteMinOsq;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property PrdPac:longint read ReadPrdPac write WritePrdPac;
    property SupPac:longint read ReadSupPac write WriteSupPac;
    property SpirGs:byte read ReadSpirGs write WriteSpirGs;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property DivSet:byte read ReadDivSet write WriteDivSet;
  end;

implementation

constructor TGscatPx.Create;
begin
  oPxbTable := PxbInit ('GSCAT',gPath.StkPath,Self);
end;

constructor TGscatPx.Create(pPath:ShortString);
begin
  oPxbTable := PxbInit ('GSCAT',pPath,Self);
end;

destructor TGscatPx.Destroy;
begin
  oPxbTable.Close;  FreeAndNil (oPxbTable);
end;

// *************************************** PRIVATE ********************************************

function TGscatPx.ReadCount:integer;
begin
  Result := oPxbTable.RecordCount;
end;

function TGscatPx.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oPxbTable.FindField(pFieldName)<>nil;
end;

function TGscatPx.ReadGsCode:longint;
begin
  Result := oPxbTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscatPx.WriteGsCode(pValue:longint);
begin
  oPxbTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscatPx.ReadGsName:Str30;
begin
  Result := oPxbTable.FieldByName('GsName').AsString;
end;

procedure TGscatPx.WriteGsName(pValue:Str30);
begin
  oPxbTable.FieldByName('GsName').AsString := pValue;
end;

function TGscatPx.ReadGsName_:Str15;
begin
  Result := oPxbTable.FieldByName('GsName_').AsString;
end;

procedure TGscatPx.WriteGsName_(pValue:Str15);
begin
  oPxbTable.FieldByName('GsName_').AsString := pValue;
end;

function TGscatPx.ReadMgCode:longint;
begin
  Result := oPxbTable.FieldByName('MgCode').AsInteger;
end;

procedure TGscatPx.WriteMgCode(pValue:longint);
begin
  oPxbTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGscatPx.ReadFgCode:longint;
begin
  Result := oPxbTable.FieldByName('FgCode').AsInteger;
end;

procedure TGscatPx.WriteFgCode(pValue:longint);
begin
  oPxbTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TGscatPx.ReadBarCode:Str15;
begin
  Result := oPxbTable.FieldByName('BarCode').AsString;
end;

procedure TGscatPx.WriteBarCode(pValue:Str15);
begin
  oPxbTable.FieldByName('BarCode').AsString := pValue;
end;

function TGscatPx.ReadStkCode:Str15;
begin
  Result := oPxbTable.FieldByName('StkCode').AsString;
end;

procedure TGscatPx.WriteStkCode(pValue:Str15);
begin
  oPxbTable.FieldByName('StkCode').AsString := pValue;
end;

function TGscatPx.ReadMsName:Str10;
begin
  Result := oPxbTable.FieldByName('MsName').AsString;
end;

procedure TGscatPx.WriteMsName(pValue:Str10);
begin
  oPxbTable.FieldByName('MsName').AsString := pValue;
end;

function TGscatPx.ReadPackGs:longint;
begin
  Result := oPxbTable.FieldByName('PackGs').AsInteger;
end;

procedure TGscatPx.WritePackGs(pValue:longint);
begin
  oPxbTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TGscatPx.ReadGsType:Str1;
begin
  Result := oPxbTable.FieldByName('GsType').AsString;
end;

procedure TGscatPx.WriteGsType(pValue:Str1);
begin
  oPxbTable.FieldByName('GsType').AsString := pValue;
end;

function TGscatPx.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oPxbTable.FieldByName('DrbMust').AsInteger);
end;

procedure TGscatPx.WriteDrbMust(pValue:boolean);
begin
  oPxbTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TGscatPx.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oPxbTable.FieldByName('PdnMust').AsInteger);
end;

procedure TGscatPx.WritePdnMust(pValue:boolean);
begin
  oPxbTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TGscatPx.ReadGrcMth:word;
begin
  Result := oPxbTable.FieldByName('GrcMth').AsInteger;
end;

procedure TGscatPx.WriteGrcMth(pValue:word);
begin
  oPxbTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TGscatPx.ReadVatPrc:byte;
begin
  Result := oPxbTable.FieldByName('VatPrc').AsInteger;
end;

procedure TGscatPx.WriteVatPrc(pValue:byte);
begin
  oPxbTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TGscatPx.ReadVolume:double;
begin
  Result := oPxbTable.FieldByName('Volume').AsFloat;
end;

procedure TGscatPx.WriteVolume(pValue:double);
begin
  oPxbTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGscatPx.ReadWeight:double;
begin
  Result := oPxbTable.FieldByName('Weight').AsFloat;
end;

procedure TGscatPx.WriteWeight(pValue:double);
begin
  oPxbTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGscatPx.ReadMsuQnt:double;
begin
  Result := oPxbTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TGscatPx.WriteMsuQnt(pValue:double);
begin
  oPxbTable.FieldByName('MsuQnt').AsFloat := pValue;
end;

function TGscatPx.ReadMsuName:Str5;
begin
  Result := oPxbTable.FieldByName('MsuName').AsString;
end;

procedure TGscatPx.WriteMsuName(pValue:Str5);
begin
  oPxbTable.FieldByName('MsuName').AsString := pValue;
end;

function TGscatPx.ReadSbcCnt:word;
begin
  Result := oPxbTable.FieldByName('SbcCnt').AsInteger;
end;

procedure TGscatPx.WriteSbcCnt(pValue:word);
begin
  oPxbTable.FieldByName('SbcCnt').AsInteger := pValue;
end;

function TGscatPx.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oPxbTable.FieldByName('DisFlag').AsInteger);
end;

procedure TGscatPx.WriteDisFlag(pValue:boolean);
begin
  oPxbTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TGscatPx.ReadLinPrice:double;
begin
  Result := oPxbTable.FieldByName('LinPrice').AsFloat;
end;

procedure TGscatPx.WriteLinPrice(pValue:double);
begin
  oPxbTable.FieldByName('LinPrice').AsFloat := pValue;
end;

function TGscatPx.ReadLinDate:TDatetime;
begin
  Result := oPxbTable.FieldByName('LinDate').AsDateTime;
end;

procedure TGscatPx.WriteLinDate(pValue:TDatetime);
begin
  oPxbTable.FieldByName('LinDate').AsDateTime := pValue;
end;

function TGscatPx.ReadLinStk:word;
begin
  Result := oPxbTable.FieldByName('LinStk').AsInteger;
end;

procedure TGscatPx.WriteLinStk(pValue:word);
begin
  oPxbTable.FieldByName('LinStk').AsInteger := pValue;
end;

function TGscatPx.ReadSended:boolean;
begin
  Result := ByteToBool(oPxbTable.FieldByName('Sended').AsInteger);
end;

procedure TGscatPx.WriteSended(pValue:boolean);
begin
  oPxbTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TGscatPx.ReadModNum:word;
begin
  Result := oPxbTable.FieldByName('ModNum').AsInteger;
end;

procedure TGscatPx.WriteModNum(pValue:word);
begin
  oPxbTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TGscatPx.ReadModUser:Str8;
begin
  Result := oPxbTable.FieldByName('ModUser').AsString;
end;

procedure TGscatPx.WriteModUser(pValue:Str8);
begin
  oPxbTable.FieldByName('ModUser').AsString := pValue;
end;

function TGscatPx.ReadModDate:TDatetime;
begin
  Result := oPxbTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGscatPx.WriteModDate(pValue:TDatetime);
begin
  oPxbTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGscatPx.ReadModTime:TDatetime;
begin
  Result := oPxbTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGscatPx.WriteModTime(pValue:TDatetime);
begin
  oPxbTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TGscatPx.ReadLinPac:longint;
begin
  Result := oPxbTable.FieldByName('LinPac').AsInteger;
end;

procedure TGscatPx.WriteLinPac(pValue:longint);
begin
  oPxbTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TGscatPx.ReadSecNum:word;
begin
  Result := oPxbTable.FieldByName('SecNum').AsInteger;
end;

procedure TGscatPx.WriteSecNum(pValue:word);
begin
  oPxbTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TGscatPx.ReadWgCode:word;
begin
  Result := oPxbTable.FieldByName('WgCode').AsInteger;
end;

procedure TGscatPx.WriteWgCode(pValue:word);
begin
  oPxbTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TGscatPx.ReadCrtUser:Str8;
begin
  Result := oPxbTable.FieldByName('CrtUser').AsString;
end;

procedure TGscatPx.WriteCrtUser(pValue:Str8);
begin
  oPxbTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGscatPx.ReadCrtDate:TDatetime;
begin
  Result := oPxbTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGscatPx.WriteCrtDate(pValue:TDatetime);
begin
  oPxbTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGscatPx.ReadCrtTime:TDatetime;
begin
  Result := oPxbTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGscatPx.WriteCrtTime(pValue:TDatetime);
begin
  oPxbTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGscatPx.ReadBasGsc:longint;
begin
  Result := oPxbTable.FieldByName('BasGsc').AsInteger;
end;

procedure TGscatPx.WriteBasGsc(pValue:longint);
begin
  oPxbTable.FieldByName('BasGsc').AsInteger := pValue;
end;

function TGscatPx.ReadGscKfc:word;
begin
  Result := oPxbTable.FieldByName('GscKfc').AsInteger;
end;

procedure TGscatPx.WriteGscKfc(pValue:word);
begin
  oPxbTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TGscatPx.ReadGspKfc:word;
begin
  Result := oPxbTable.FieldByName('GspKfc').AsInteger;
end;

procedure TGscatPx.WriteGspKfc(pValue:word);
begin
  oPxbTable.FieldByName('GspKfc').AsInteger := pValue;
end;

function TGscatPx.ReadQliKfc:double;
begin
  Result := oPxbTable.FieldByName('QliKfc').AsFloat;
end;

procedure TGscatPx.WriteQliKfc(pValue:double);
begin
  oPxbTable.FieldByName('QliKfc').AsFloat := pValue;
end;

function TGscatPx.ReadDrbDay:word;
begin
  Result := oPxbTable.FieldByName('DrbDay').AsInteger;
end;

procedure TGscatPx.WriteDrbDay(pValue:word);
begin
  oPxbTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TGscatPx.ReadOsdCode:Str15;
begin
  Result := oPxbTable.FieldByName('OsdCode').AsString;
end;

procedure TGscatPx.WriteOsdCode(pValue:Str15);
begin
  oPxbTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGscatPx.ReadMinOsq:double;
begin
  Result := oPxbTable.FieldByName('MinOsq').AsFloat;
end;

procedure TGscatPx.WriteMinOsq(pValue:double);
begin
  oPxbTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TGscatPx.ReadSpcCode:Str30;
begin
  Result := oPxbTable.FieldByName('SpcCode').AsString;
end;

procedure TGscatPx.WriteSpcCode(pValue:Str30);
begin
  oPxbTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGscatPx.ReadPrdPac:longint;
begin
  Result := oPxbTable.FieldByName('PrdPac').AsInteger;
end;

procedure TGscatPx.WritePrdPac(pValue:longint);
begin
  oPxbTable.FieldByName('PrdPac').AsInteger := pValue;
end;

function TGscatPx.ReadSupPac:longint;
begin
  Result := oPxbTable.FieldByName('SupPac').AsInteger;
end;

procedure TGscatPx.WriteSupPac(pValue:longint);
begin
  oPxbTable.FieldByName('SupPac').AsInteger := pValue;
end;

function TGscatPx.ReadSpirGs:byte;
begin
  Result := oPxbTable.FieldByName('SpirGs').AsInteger;
end;

procedure TGscatPx.WriteSpirGs(pValue:byte);
begin
  oPxbTable.FieldByName('SpirGs').AsInteger := pValue;
end;

function TGscatPx.ReadGaName:Str60;
begin
  Result := oPxbTable.FieldByName('GaName').AsString;
end;

procedure TGscatPx.WriteGaName(pValue:Str60);
begin
  oPxbTable.FieldByName('GaName').AsString := pValue;
end;

function TGscatPx.ReadGaName_:Str60;
begin
  Result := oPxbTable.FieldByName('GaName_').AsString;
end;

procedure TGscatPx.WriteGaName_(pValue:Str60);
begin
  oPxbTable.FieldByName('GaName_').AsString := pValue;
end;

function TGscatPx.ReadDivSet:byte;
begin
  Result := oPxbTable.FieldByName('DivSet').AsInteger;
end;

procedure TGscatPx.WriteDivSet(pValue:byte);
begin
  oPxbTable.FieldByName('DivSet').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscatPx.Eof: boolean;
begin
  Result := oPxbTable.Eof;
end;

function TGscatPx.IsFirstRec: boolean;
begin
  Result := oPxbTable.Bof;
end;

function TGscatPx.IsLastRec: boolean;
begin
  Result := oPxbTable.Eof;
end;

function TGscatPx.Active: boolean;
begin
  Result := oPxbTable.Active;
end;

function TGscatPx.ActPos: longint;
begin
  Result := oPxbTable.RecNo;
end;

function TGscatPx.GotoPos (pActPos:longint): boolean;
begin
  oPxbTable.First;
  Result := oPxbTable.MoveBy(pActPos)=pActPos;
end;

function TGscatPx.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oPxbTable.FindKey([pGsCode]);
end;

function TGscatPx.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oPxbTable.FindKey([pMgCode,pGsCode]);
end;

function TGscatPx.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oPxbTable.FindKey([pFgCode]);
end;

function TGscatPx.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oPxbTable.FindKey([StrToAlias(pGsName_)]);
end;

function TGscatPx.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oPxbTable.FindKey([pBarCode]);
end;

function TGscatPx.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oPxbTable.FindKey([pStkCode]);
end;

function TGscatPx.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oPxbTable.FindKey([pSpcCode]);
end;

function TGscatPx.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oPxbTable.FindKey([pOsdCode]);
end;

function TGscatPx.LocateGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oPxbTable.FindKey([pGsType]);
end;

function TGscatPx.LocatePackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oPxbTable.FindKey([pPackGs]);
end;

function TGscatPx.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oPxbTable.FindKey([pDisFlag]);
end;

function TGscatPx.LocateSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  Result := oPxbTable.FindKey([pSecNum,pWgCode]);
end;

function TGscatPx.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oPxbTable.FindKey([pSended]);
end;

function TGscatPx.LocateGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oPxbTable.FindKey([StrToAlias(pGaName_)]);
end;

function TGscatPx.LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oPxbTable.FindKey([pMgCode,pStkCode]);
end;

function TGscatPx.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  oPxbTable.FindNearest([pGsCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  oPxbTable.FindNearest([pMgCode,pGsCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  oPxbTable.FindNearest([pFgCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  oPxbTable.FindNearest([pGsName_]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  oPxbTable.FindNearest([pBarCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  oPxbTable.FindNearest([pStkCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  oPxbTable.FindNearest([pSpcCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  oPxbTable.FindNearest([pOsdCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  oPxbTable.FindNearest([pGsType]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestPackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  oPxbTable.FindNearest([pPackGs]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  oPxbTable.FindNearest([pDisFlag]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  oPxbTable.FindNearest([pSecNum,pWgCode]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  oPxbTable.FindNearest([pSended]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  oPxbTable.FindNearest([pGaName_]);
  Result := not oPxbTable.Eof;
end;

function TGscatPx.NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  oPxbTable.FindNearest([pMgCode,pStkCode]);
  Result := not oPxbTable.Eof;
end;

procedure TGscatPx.SetIndex (pIndexName:ShortString);
begin
  If oPxbTable.IndexName<>pIndexName then oPxbTable.IndexName := pIndexName;
end;

procedure TGscatPx.Open;
begin
  oPxbTable.Open;
end;

procedure TGscatPx.Close;
begin
  If oPxbTable.Active then oPxbTable.Close;
end;

procedure TGscatPx.Prior;
begin
  oPxbTable.Prior;
end;

procedure TGscatPx.Next;
begin
  oPxbTable.Next;
end;

procedure TGscatPx.First;
begin
  oPxbTable.First;
end;

procedure TGscatPx.Last;
begin
  oPxbTable.Last;
end;

procedure TGscatPx.Insert;
begin
  oPxbTable.Insert;
end;

procedure TGscatPx.Edit;
begin
  oPxbTable.Edit;
end;

procedure TGscatPx.Post;
begin
  oPxbTable.Post;
end;

procedure TGscatPx.Delete;
begin
  oPxbTable.Delete;
end;

procedure TGscatPx.SwapIndex;
begin
  oPxbTable.SwapIndex;
end;

procedure TGscatPx.RestoreIndex;
begin
  oPxbTable.RestoreIndex;
end;

procedure TGscatPx.SwapStatus;
begin
  oPxbTable.SwapStatus;
end;

procedure TGscatPx.RestoreStatus;
begin
  oPxbTable.RestoreStatus;
end;

procedure TGscatPx.EnableControls;
begin
  oPxbTable.EnableControls;
end;

procedure TGscatPx.DisableControls;
begin
  oPxbTable.DisableControls;
end;

end.
