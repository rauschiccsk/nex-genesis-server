unit tGSCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgGs = 'MgGs';
  ixGsName_ = 'GsName_';
  ixGaName_ = 'GaName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixGsType = 'GsType';
  ixPackGs = 'PackGs';
  ixVatPrc = 'VatPrc';
  ixMsName = 'MsName';

type
  TGscatTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadDrbDay:word;           procedure WriteDrbDay (pValue:word);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadMsuQnt:double;         procedure WriteMsuQnt (pValue:double);
    function  ReadMsuName:Str5;          procedure WriteMsuName (pValue:Str5);
    function  ReadSbcCnt:word;           procedure WriteSbcCnt (pValue:word);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMeType:Str30;          procedure WriteMeType (pValue:Str30);
    function  ReadMePart:Str20;          procedure WriteMePart (pValue:Str20);
    function  ReadMeStat:boolean;        procedure WriteMeStat (pValue:boolean);
    function  ReadMeProc:Str20;          procedure WriteMeProc (pValue:Str20);
    function  ReadWnType:Str30;          procedure WriteWnType (pValue:Str30);
    function  ReadVariety:Str30;         procedure WriteVariety (pValue:Str30);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadState:Str2;            procedure WriteState (pValue:Str2);
    function  ReadLocalit:Str20;         procedure WriteLocalit (pValue:Str20);
    function  ReadRegion:Str20;          procedure WriteRegion (pValue:Str20);
    function  ReadColor:byte;            procedure WriteColor (pValue:byte);
    function  ReadWnYear:Str4;           procedure WriteWnYear (pValue:Str4);
    function  ReadBottle:Str15;          procedure WriteBottle (pValue:Str15);
    function  ReadLinPrice:double;       procedure WriteLinPrice (pValue:double);
    function  ReadLinDate:TDatetime;     procedure WriteLinDate (pValue:TDatetime);
    function  ReadLinStk:word;           procedure WriteLinStk (pValue:word);
    function  ReadLinPac:longint;        procedure WriteLinPac (pValue:longint);
    function  ReadSecNum:word;           procedure WriteSecNum (pValue:word);
    function  ReadWgCode:word;           procedure WriteWgCode (pValue:word);
    function  ReadBasGsc:longint;        procedure WriteBasGsc (pValue:longint);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadGspKfc:word;           procedure WriteGspKfc (pValue:word);
    function  ReadQliKfc:double;         procedure WriteQliKfc (pValue:double);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadMinOsq:double;         procedure WriteMinOsq (pValue:double);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadPrdPac:longint;        procedure WritePrdPac (pValue:longint);
    function  ReadSupPac:longint;        procedure WriteSupPac (pValue:longint);
    function  ReadSpirGs:byte;           procedure WriteSpirGs (pValue:byte);
    function  ReadDivSet:byte;           procedure WriteDivSet (pValue:byte);
    function  ReadSndShp:byte;           procedure WriteSndShp (pValue:byte);
    function  ReadRbaTrc:byte;           procedure WriteRbaTrc (pValue:byte);
    function  ReadNewVatPrc:Str2;        procedure WriteNewVatPrc (pValue:Str2);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateGaName_ (pGaName_:Str60):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateGsType (pGsType:Str1):boolean;
    function LocatePackGs (pPackGs:longint):boolean;
    function LocateVatPrc (pVatPrc:double):boolean;
    function LocateMsName (pMsName:Str10):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property DrbDay:word read ReadDrbDay write WriteDrbDay;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property MsuQnt:double read ReadMsuQnt write WriteMsuQnt;
    property MsuName:Str5 read ReadMsuName write WriteMsuName;
    property SbcCnt:word read ReadSbcCnt write WriteSbcCnt;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MeType:Str30 read ReadMeType write WriteMeType;
    property MePart:Str20 read ReadMePart write WriteMePart;
    property MeStat:boolean read ReadMeStat write WriteMeStat;
    property MeProc:Str20 read ReadMeProc write WriteMeProc;
    property WnType:Str30 read ReadWnType write WriteWnType;
    property Variety:Str30 read ReadVariety write WriteVariety;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property State:Str2 read ReadState write WriteState;
    property Localit:Str20 read ReadLocalit write WriteLocalit;
    property Region:Str20 read ReadRegion write WriteRegion;
    property Color:byte read ReadColor write WriteColor;
    property WnYear:Str4 read ReadWnYear write WriteWnYear;
    property Bottle:Str15 read ReadBottle write WriteBottle;
    property LinPrice:double read ReadLinPrice write WriteLinPrice;
    property LinDate:TDatetime read ReadLinDate write WriteLinDate;
    property LinStk:word read ReadLinStk write WriteLinStk;
    property LinPac:longint read ReadLinPac write WriteLinPac;
    property SecNum:word read ReadSecNum write WriteSecNum;
    property WgCode:word read ReadWgCode write WriteWgCode;
    property BasGsc:longint read ReadBasGsc write WriteBasGsc;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property GspKfc:word read ReadGspKfc write WriteGspKfc;
    property QliKfc:double read ReadQliKfc write WriteQliKfc;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property MinOsq:double read ReadMinOsq write WriteMinOsq;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property PrdPac:longint read ReadPrdPac write WritePrdPac;
    property SupPac:longint read ReadSupPac write WriteSupPac;
    property SpirGs:byte read ReadSpirGs write WriteSpirGs;
    property DivSet:byte read ReadDivSet write WriteDivSet;
    property SndShp:byte read ReadSndShp write WriteSndShp;
    property RbaTrc:byte read ReadRbaTrc write WriteRbaTrc;
    property NewVatPrc:Str2 read ReadNewVatPrc write WriteNewVatPrc;
  end;

implementation

constructor TGscatTmp.Create;
begin
  oTmpTable := TmpInit ('GSCAT',Self);
end;

destructor TGscatTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGscatTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGscatTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGscatTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscatTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscatTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGscatTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGscatTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TGscatTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TGscatTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TGscatTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TGscatTmp.ReadGaName_:Str60;
begin
  Result := oTmpTable.FieldByName('GaName_').AsString;
end;

procedure TGscatTmp.WriteGaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName_').AsString := pValue;
end;

function TGscatTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TGscatTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGscatTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TGscatTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TGscatTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TGscatTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TGscatTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TGscatTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TGscatTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TGscatTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TGscatTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TGscatTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TGscatTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TGscatTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TGscatTmp.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DrbMust').AsInteger);
end;

procedure TGscatTmp.WriteDrbMust(pValue:boolean);
begin
  oTmpTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TGscatTmp.ReadDrbDay:word;
begin
  Result := oTmpTable.FieldByName('DrbDay').AsInteger;
end;

procedure TGscatTmp.WriteDrbDay(pValue:word);
begin
  oTmpTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TGscatTmp.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('PdnMust').AsInteger);
end;

procedure TGscatTmp.WritePdnMust(pValue:boolean);
begin
  oTmpTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TGscatTmp.ReadGrcMth:word;
begin
  Result := oTmpTable.FieldByName('GrcMth').AsInteger;
end;

procedure TGscatTmp.WriteGrcMth(pValue:word);
begin
  oTmpTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TGscatTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TGscatTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TGscatTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TGscatTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGscatTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TGscatTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGscatTmp.ReadMsuQnt:double;
begin
  Result := oTmpTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TGscatTmp.WriteMsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('MsuQnt').AsFloat := pValue;
end;

function TGscatTmp.ReadMsuName:Str5;
begin
  Result := oTmpTable.FieldByName('MsuName').AsString;
end;

procedure TGscatTmp.WriteMsuName(pValue:Str5);
begin
  oTmpTable.FieldByName('MsuName').AsString := pValue;
end;

function TGscatTmp.ReadSbcCnt:word;
begin
  Result := oTmpTable.FieldByName('SbcCnt').AsInteger;
end;

procedure TGscatTmp.WriteSbcCnt(pValue:word);
begin
  oTmpTable.FieldByName('SbcCnt').AsInteger := pValue;
end;

function TGscatTmp.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DisFlag').AsInteger);
end;

procedure TGscatTmp.WriteDisFlag(pValue:boolean);
begin
  oTmpTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TGscatTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TGscatTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TGscatTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TGscatTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TGscatTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TGscatTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TGscatTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGscatTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGscatTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGscatTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TGscatTmp.ReadMeType:Str30;
begin
  Result := oTmpTable.FieldByName('MeType').AsString;
end;

procedure TGscatTmp.WriteMeType(pValue:Str30);
begin
  oTmpTable.FieldByName('MeType').AsString := pValue;
end;

function TGscatTmp.ReadMePart:Str20;
begin
  Result := oTmpTable.FieldByName('MePart').AsString;
end;

procedure TGscatTmp.WriteMePart(pValue:Str20);
begin
  oTmpTable.FieldByName('MePart').AsString := pValue;
end;

function TGscatTmp.ReadMeStat:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('MeStat').AsInteger);
end;

procedure TGscatTmp.WriteMeStat(pValue:boolean);
begin
  oTmpTable.FieldByName('MeStat').AsInteger := BoolToByte(pValue);
end;

function TGscatTmp.ReadMeProc:Str20;
begin
  Result := oTmpTable.FieldByName('MeProc').AsString;
end;

procedure TGscatTmp.WriteMeProc(pValue:Str20);
begin
  oTmpTable.FieldByName('MeProc').AsString := pValue;
end;

function TGscatTmp.ReadWnType:Str30;
begin
  Result := oTmpTable.FieldByName('WnType').AsString;
end;

procedure TGscatTmp.WriteWnType(pValue:Str30);
begin
  oTmpTable.FieldByName('WnType').AsString := pValue;
end;

function TGscatTmp.ReadVariety:Str30;
begin
  Result := oTmpTable.FieldByName('Variety').AsString;
end;

procedure TGscatTmp.WriteVariety(pValue:Str30);
begin
  oTmpTable.FieldByName('Variety').AsString := pValue;
end;

function TGscatTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TGscatTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TGscatTmp.ReadState:Str2;
begin
  Result := oTmpTable.FieldByName('State').AsString;
end;

procedure TGscatTmp.WriteState(pValue:Str2);
begin
  oTmpTable.FieldByName('State').AsString := pValue;
end;

function TGscatTmp.ReadLocalit:Str20;
begin
  Result := oTmpTable.FieldByName('Localit').AsString;
end;

procedure TGscatTmp.WriteLocalit(pValue:Str20);
begin
  oTmpTable.FieldByName('Localit').AsString := pValue;
end;

function TGscatTmp.ReadRegion:Str20;
begin
  Result := oTmpTable.FieldByName('Region').AsString;
end;

procedure TGscatTmp.WriteRegion(pValue:Str20);
begin
  oTmpTable.FieldByName('Region').AsString := pValue;
end;

function TGscatTmp.ReadColor:byte;
begin
  Result := oTmpTable.FieldByName('Color').AsInteger;
end;

procedure TGscatTmp.WriteColor(pValue:byte);
begin
  oTmpTable.FieldByName('Color').AsInteger := pValue;
end;

function TGscatTmp.ReadWnYear:Str4;
begin
  Result := oTmpTable.FieldByName('WnYear').AsString;
end;

procedure TGscatTmp.WriteWnYear(pValue:Str4);
begin
  oTmpTable.FieldByName('WnYear').AsString := pValue;
end;

function TGscatTmp.ReadBottle:Str15;
begin
  Result := oTmpTable.FieldByName('Bottle').AsString;
end;

procedure TGscatTmp.WriteBottle(pValue:Str15);
begin
  oTmpTable.FieldByName('Bottle').AsString := pValue;
end;

function TGscatTmp.ReadLinPrice:double;
begin
  Result := oTmpTable.FieldByName('LinPrice').AsFloat;
end;

procedure TGscatTmp.WriteLinPrice(pValue:double);
begin
  oTmpTable.FieldByName('LinPrice').AsFloat := pValue;
end;

function TGscatTmp.ReadLinDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LinDate').AsDateTime;
end;

procedure TGscatTmp.WriteLinDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LinDate').AsDateTime := pValue;
end;

function TGscatTmp.ReadLinStk:word;
begin
  Result := oTmpTable.FieldByName('LinStk').AsInteger;
end;

procedure TGscatTmp.WriteLinStk(pValue:word);
begin
  oTmpTable.FieldByName('LinStk').AsInteger := pValue;
end;

function TGscatTmp.ReadLinPac:longint;
begin
  Result := oTmpTable.FieldByName('LinPac').AsInteger;
end;

procedure TGscatTmp.WriteLinPac(pValue:longint);
begin
  oTmpTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TGscatTmp.ReadSecNum:word;
begin
  Result := oTmpTable.FieldByName('SecNum').AsInteger;
end;

procedure TGscatTmp.WriteSecNum(pValue:word);
begin
  oTmpTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TGscatTmp.ReadWgCode:word;
begin
  Result := oTmpTable.FieldByName('WgCode').AsInteger;
end;

procedure TGscatTmp.WriteWgCode(pValue:word);
begin
  oTmpTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TGscatTmp.ReadBasGsc:longint;
begin
  Result := oTmpTable.FieldByName('BasGsc').AsInteger;
end;

procedure TGscatTmp.WriteBasGsc(pValue:longint);
begin
  oTmpTable.FieldByName('BasGsc').AsInteger := pValue;
end;

function TGscatTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TGscatTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TGscatTmp.ReadGspKfc:word;
begin
  Result := oTmpTable.FieldByName('GspKfc').AsInteger;
end;

procedure TGscatTmp.WriteGspKfc(pValue:word);
begin
  oTmpTable.FieldByName('GspKfc').AsInteger := pValue;
end;

function TGscatTmp.ReadQliKfc:double;
begin
  Result := oTmpTable.FieldByName('QliKfc').AsFloat;
end;

procedure TGscatTmp.WriteQliKfc(pValue:double);
begin
  oTmpTable.FieldByName('QliKfc').AsFloat := pValue;
end;

function TGscatTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TGscatTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGscatTmp.ReadMinOsq:double;
begin
  Result := oTmpTable.FieldByName('MinOsq').AsFloat;
end;

procedure TGscatTmp.WriteMinOsq(pValue:double);
begin
  oTmpTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TGscatTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TGscatTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGscatTmp.ReadPrdPac:longint;
begin
  Result := oTmpTable.FieldByName('PrdPac').AsInteger;
end;

procedure TGscatTmp.WritePrdPac(pValue:longint);
begin
  oTmpTable.FieldByName('PrdPac').AsInteger := pValue;
end;

function TGscatTmp.ReadSupPac:longint;
begin
  Result := oTmpTable.FieldByName('SupPac').AsInteger;
end;

procedure TGscatTmp.WriteSupPac(pValue:longint);
begin
  oTmpTable.FieldByName('SupPac').AsInteger := pValue;
end;

function TGscatTmp.ReadSpirGs:byte;
begin
  Result := oTmpTable.FieldByName('SpirGs').AsInteger;
end;

procedure TGscatTmp.WriteSpirGs(pValue:byte);
begin
  oTmpTable.FieldByName('SpirGs').AsInteger := pValue;
end;

function TGscatTmp.ReadDivSet:byte;
begin
  Result := oTmpTable.FieldByName('DivSet').AsInteger;
end;

procedure TGscatTmp.WriteDivSet(pValue:byte);
begin
  oTmpTable.FieldByName('DivSet').AsInteger := pValue;
end;

function TGscatTmp.ReadSndShp:byte;
begin
  Result := oTmpTable.FieldByName('SndShp').AsInteger;
end;

procedure TGscatTmp.WriteSndShp(pValue:byte);
begin
  oTmpTable.FieldByName('SndShp').AsInteger := pValue;
end;

function TGscatTmp.ReadRbaTrc:byte;
begin
  Result := oTmpTable.FieldByName('RbaTrc').AsInteger;
end;

procedure TGscatTmp.WriteRbaTrc(pValue:byte);
begin
  oTmpTable.FieldByName('RbaTrc').AsInteger := pValue;
end;

function TGscatTmp.ReadNewVatPrc:Str2;
begin
  Result := oTmpTable.FieldByName('NewVatPrc').AsString;
end;

procedure TGscatTmp.WriteNewVatPrc(pValue:Str2);
begin
  oTmpTable.FieldByName('NewVatPrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscatTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGscatTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGscatTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TGscatTmp.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oTmpTable.FindKey([pMgCode,pGsCode]);
end;

function TGscatTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TGscatTmp.LocateGaName_ (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName_);
  Result := oTmpTable.FindKey([pGaName_]);
end;

function TGscatTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TGscatTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TGscatTmp.LocateGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oTmpTable.FindKey([pGsType]);
end;

function TGscatTmp.LocatePackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oTmpTable.FindKey([pPackGs]);
end;

function TGscatTmp.LocateVatPrc (pVatPrc:double):boolean;
begin
  SetIndex (ixVatPrc);
  Result := oTmpTable.FindKey([pVatPrc]);
end;

function TGscatTmp.LocateMsName (pMsName:Str10):boolean;
begin
  SetIndex (ixMsName);
  Result := oTmpTable.FindKey([pMsName]);
end;

procedure TGscatTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGscatTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGscatTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGscatTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGscatTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGscatTmp.First;
begin
  oTmpTable.First;
end;

procedure TGscatTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGscatTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGscatTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGscatTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGscatTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGscatTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGscatTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGscatTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGscatTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGscatTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGscatTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
