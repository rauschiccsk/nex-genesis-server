unit bGSBRIDGE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCodeO = 'GsCodeO';
  ixGsCodeN = 'GsCodeN';
  ixBarCode = 'BarCode';
  ixMgGso = 'MgGso';
  ixFgCode = 'FgCode';
  ixGsName = 'GsName';
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
  TGsbridgeBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCodeO:longint;       procedure WriteGsCodeO (pValue:longint);
    function  ReadGsCodeN:longint;       procedure WriteGsCodeN (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
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
    function LocateGsCodeO (pGsCodeO:longint):boolean;
    function LocateGsCodeN (pGsCodeN:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateMgGso (pMgCode:longint;pGsCodeO:longint):boolean;
    function LocateFgCode (pFgCode:longint):boolean;
    function LocateGsName (pGsName_:Str15):boolean;
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
    function NearestGsCodeO (pGsCodeO:longint):boolean;
    function NearestGsCodeN (pGsCodeN:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestMgGso (pMgCode:longint;pGsCodeO:longint):boolean;
    function NearestFgCode (pFgCode:longint):boolean;
    function NearestGsName (pGsName_:Str15):boolean;
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
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCodeO:longint read ReadGsCodeO write WriteGsCodeO;
    property GsCodeN:longint read ReadGsCodeN write WriteGsCodeN;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
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

constructor TGsbridgeBtr.Create;
begin
  oBtrTable := BtrInit ('GSBRIDGE',gPath.StkPath,Self);
end;

constructor TGsbridgeBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSBRIDGE',pPath,Self);
end;

destructor TGsbridgeBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGsbridgeBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGsbridgeBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGsbridgeBtr.ReadGsCodeO:longint;
begin
  Result := oBtrTable.FieldByName('GsCodeO').AsInteger;
end;

procedure TGsbridgeBtr.WriteGsCodeO(pValue:longint);
begin
  oBtrTable.FieldByName('GsCodeO').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadGsCodeN:longint;
begin
  Result := oBtrTable.FieldByName('GsCodeN').AsInteger;
end;

procedure TGsbridgeBtr.WriteGsCodeN(pValue:longint);
begin
  oBtrTable.FieldByName('GsCodeN').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TGsbridgeBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TGsbridgeBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TGsbridgeBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TGsbridgeBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TGsbridgeBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TGsbridgeBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TGsbridgeBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TGsbridgeBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TGsbridgeBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TGsbridgeBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TGsbridgeBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TGsbridgeBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TGsbridgeBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TGsbridgeBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TGsbridgeBtr.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DrbMust').AsInteger);
end;

procedure TGsbridgeBtr.WriteDrbMust(pValue:boolean);
begin
  oBtrTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TGsbridgeBtr.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('PdnMust').AsInteger);
end;

procedure TGsbridgeBtr.WritePdnMust(pValue:boolean);
begin
  oBtrTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TGsbridgeBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TGsbridgeBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TGsbridgeBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TGsbridgeBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TGsbridgeBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadMsuQnt:double;
begin
  Result := oBtrTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TGsbridgeBtr.WriteMsuQnt(pValue:double);
begin
  oBtrTable.FieldByName('MsuQnt').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadMsuName:Str5;
begin
  Result := oBtrTable.FieldByName('MsuName').AsString;
end;

procedure TGsbridgeBtr.WriteMsuName(pValue:Str5);
begin
  oBtrTable.FieldByName('MsuName').AsString := pValue;
end;

function TGsbridgeBtr.ReadSbcCnt:word;
begin
  Result := oBtrTable.FieldByName('SbcCnt').AsInteger;
end;

procedure TGsbridgeBtr.WriteSbcCnt(pValue:word);
begin
  oBtrTable.FieldByName('SbcCnt').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TGsbridgeBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TGsbridgeBtr.ReadLinPrice:double;
begin
  Result := oBtrTable.FieldByName('LinPrice').AsFloat;
end;

procedure TGsbridgeBtr.WriteLinPrice(pValue:double);
begin
  oBtrTable.FieldByName('LinPrice').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadLinDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('LinDate').AsDateTime;
end;

procedure TGsbridgeBtr.WriteLinDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LinDate').AsDateTime := pValue;
end;

function TGsbridgeBtr.ReadLinStk:word;
begin
  Result := oBtrTable.FieldByName('LinStk').AsInteger;
end;

procedure TGsbridgeBtr.WriteLinStk(pValue:word);
begin
  oBtrTable.FieldByName('LinStk').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TGsbridgeBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TGsbridgeBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TGsbridgeBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TGsbridgeBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TGsbridgeBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGsbridgeBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGsbridgeBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGsbridgeBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TGsbridgeBtr.ReadLinPac:longint;
begin
  Result := oBtrTable.FieldByName('LinPac').AsInteger;
end;

procedure TGsbridgeBtr.WriteLinPac(pValue:longint);
begin
  oBtrTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadSecNum:word;
begin
  Result := oBtrTable.FieldByName('SecNum').AsInteger;
end;

procedure TGsbridgeBtr.WriteSecNum(pValue:word);
begin
  oBtrTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadWgCode:word;
begin
  Result := oBtrTable.FieldByName('WgCode').AsInteger;
end;

procedure TGsbridgeBtr.WriteWgCode(pValue:word);
begin
  oBtrTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TGsbridgeBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGsbridgeBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGsbridgeBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGsbridgeBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGsbridgeBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGsbridgeBtr.ReadBasGsc:longint;
begin
  Result := oBtrTable.FieldByName('BasGsc').AsInteger;
end;

procedure TGsbridgeBtr.WriteBasGsc(pValue:longint);
begin
  oBtrTable.FieldByName('BasGsc').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadGscKfc:word;
begin
  Result := oBtrTable.FieldByName('GscKfc').AsInteger;
end;

procedure TGsbridgeBtr.WriteGscKfc(pValue:word);
begin
  oBtrTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadGspKfc:word;
begin
  Result := oBtrTable.FieldByName('GspKfc').AsInteger;
end;

procedure TGsbridgeBtr.WriteGspKfc(pValue:word);
begin
  oBtrTable.FieldByName('GspKfc').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadQliKfc:double;
begin
  Result := oBtrTable.FieldByName('QliKfc').AsFloat;
end;

procedure TGsbridgeBtr.WriteQliKfc(pValue:double);
begin
  oBtrTable.FieldByName('QliKfc').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadDrbDay:word;
begin
  Result := oBtrTable.FieldByName('DrbDay').AsInteger;
end;

procedure TGsbridgeBtr.WriteDrbDay(pValue:word);
begin
  oBtrTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadOsdCode:Str15;
begin
  Result := oBtrTable.FieldByName('OsdCode').AsString;
end;

procedure TGsbridgeBtr.WriteOsdCode(pValue:Str15);
begin
  oBtrTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGsbridgeBtr.ReadMinOsq:double;
begin
  Result := oBtrTable.FieldByName('MinOsq').AsFloat;
end;

procedure TGsbridgeBtr.WriteMinOsq(pValue:double);
begin
  oBtrTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TGsbridgeBtr.ReadSpcCode:Str30;
begin
  Result := oBtrTable.FieldByName('SpcCode').AsString;
end;

procedure TGsbridgeBtr.WriteSpcCode(pValue:Str30);
begin
  oBtrTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGsbridgeBtr.ReadPrdPac:longint;
begin
  Result := oBtrTable.FieldByName('PrdPac').AsInteger;
end;

procedure TGsbridgeBtr.WritePrdPac(pValue:longint);
begin
  oBtrTable.FieldByName('PrdPac').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadSupPac:longint;
begin
  Result := oBtrTable.FieldByName('SupPac').AsInteger;
end;

procedure TGsbridgeBtr.WriteSupPac(pValue:longint);
begin
  oBtrTable.FieldByName('SupPac').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadSpirGs:byte;
begin
  Result := oBtrTable.FieldByName('SpirGs').AsInteger;
end;

procedure TGsbridgeBtr.WriteSpirGs(pValue:byte);
begin
  oBtrTable.FieldByName('SpirGs').AsInteger := pValue;
end;

function TGsbridgeBtr.ReadGaName:Str60;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TGsbridgeBtr.WriteGaName(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TGsbridgeBtr.ReadGaName_:Str60;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TGsbridgeBtr.WriteGaName_(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

function TGsbridgeBtr.ReadDivSet:byte;
begin
  Result := oBtrTable.FieldByName('DivSet').AsInteger;
end;

procedure TGsbridgeBtr.WriteDivSet(pValue:byte);
begin
  oBtrTable.FieldByName('DivSet').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsbridgeBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsbridgeBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGsbridgeBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsbridgeBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGsbridgeBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGsbridgeBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGsbridgeBtr.LocateGsCodeO (pGsCodeO:longint):boolean;
begin
  SetIndex (ixGsCodeO);
  Result := oBtrTable.FindKey([pGsCodeO]);
end;

function TGsbridgeBtr.LocateGsCodeN (pGsCodeN:longint):boolean;
begin
  SetIndex (ixGsCodeN);
  Result := oBtrTable.FindKey([pGsCodeN]);
end;

function TGsbridgeBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TGsbridgeBtr.LocateMgGso (pMgCode:longint;pGsCodeO:longint):boolean;
begin
  SetIndex (ixMgGso);
  Result := oBtrTable.FindKey([pMgCode,pGsCodeO]);
end;

function TGsbridgeBtr.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindKey([pFgCode]);
end;

function TGsbridgeBtr.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TGsbridgeBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TGsbridgeBtr.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oBtrTable.FindKey([pSpcCode]);
end;

function TGsbridgeBtr.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindKey([pOsdCode]);
end;

function TGsbridgeBtr.LocateGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindKey([pGsType]);
end;

function TGsbridgeBtr.LocatePackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oBtrTable.FindKey([pPackGs]);
end;

function TGsbridgeBtr.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindKey([pDisFlag]);
end;

function TGsbridgeBtr.LocateSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  Result := oBtrTable.FindKey([pSecNum,pWgCode]);
end;

function TGsbridgeBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TGsbridgeBtr.LocateGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([StrToAlias(pGaName_)]);
end;

function TGsbridgeBtr.LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindKey([pMgCode,pStkCode]);
end;

function TGsbridgeBtr.NearestGsCodeO (pGsCodeO:longint):boolean;
begin
  SetIndex (ixGsCodeO);
  Result := oBtrTable.FindNearest([pGsCodeO]);
end;

function TGsbridgeBtr.NearestGsCodeN (pGsCodeN:longint):boolean;
begin
  SetIndex (ixGsCodeN);
  Result := oBtrTable.FindNearest([pGsCodeN]);
end;

function TGsbridgeBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TGsbridgeBtr.NearestMgGso (pMgCode:longint;pGsCodeO:longint):boolean;
begin
  SetIndex (ixMgGso);
  Result := oBtrTable.FindNearest([pMgCode,pGsCodeO]);
end;

function TGsbridgeBtr.NearestFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindNearest([pFgCode]);
end;

function TGsbridgeBtr.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TGsbridgeBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TGsbridgeBtr.NearestSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oBtrTable.FindNearest([pSpcCode]);
end;

function TGsbridgeBtr.NearestOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindNearest([pOsdCode]);
end;

function TGsbridgeBtr.NearestGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindNearest([pGsType]);
end;

function TGsbridgeBtr.NearestPackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oBtrTable.FindNearest([pPackGs]);
end;

function TGsbridgeBtr.NearestDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindNearest([pDisFlag]);
end;

function TGsbridgeBtr.NearestSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  Result := oBtrTable.FindNearest([pSecNum,pWgCode]);
end;

function TGsbridgeBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TGsbridgeBtr.NearestGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindNearest([pGaName_]);
end;

function TGsbridgeBtr.NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindNearest([pMgCode,pStkCode]);
end;

procedure TGsbridgeBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGsbridgeBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGsbridgeBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGsbridgeBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGsbridgeBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGsbridgeBtr.First;
begin
  oBtrTable.First;
end;

procedure TGsbridgeBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGsbridgeBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGsbridgeBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGsbridgeBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGsbridgeBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGsbridgeBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGsbridgeBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGsbridgeBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGsbridgeBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGsbridgeBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGsbridgeBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
