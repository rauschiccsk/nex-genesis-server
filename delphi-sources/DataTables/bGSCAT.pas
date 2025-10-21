unit bGSCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

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
  ixMsName = 'MsName';
  ixCctCod = 'CctCod';
  ixProTyp = 'ProTyp';

type
  TGscatBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
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
    function  ReadSgCode:longint;        procedure WriteSgCode (pValue:longint);
    function  ReadNotice:Str240;         procedure WriteNotice (pValue:Str240);
    function  ReadNewVatPrc:Str2;        procedure WriteNewVatPrc (pValue:Str2);
    function  ReadReserve:Str4;          procedure WriteReserve (pValue:Str4);
    function  ReadShpNum:byte;           procedure WriteShpNum (pValue:byte);
    function  ReadSndShp:byte;           procedure WriteSndShp (pValue:byte);
    function  ReadPlsNum1:word;          procedure WritePlsNum1 (pValue:word);
    function  ReadPlsNum2:word;          procedure WritePlsNum2 (pValue:word);
    function  ReadPlsNum3:word;          procedure WritePlsNum3 (pValue:word);
    function  ReadPlsNum4:word;          procedure WritePlsNum4 (pValue:word);
    function  ReadPlsNum5:word;          procedure WritePlsNum5 (pValue:word);
    function  ReadRbaTrc:byte;           procedure WriteRbaTrc (pValue:byte);
    function  ReadCctCod:Str10;          procedure WriteCctCod (pValue:Str10);
    function  ReadIsiSnt:Str3;           procedure WriteIsiSnt (pValue:Str3);
    function  ReadIsiAnl:Str6;           procedure WriteIsiAnl (pValue:Str6);
    function  ReadIciSnt:Str3;           procedure WriteIciSnt (pValue:Str3);
    function  ReadIciAnl:Str6;           procedure WriteIciAnl (pValue:Str6);
    function  ReadProTyp:Str1;           procedure WriteProTyp (pValue:Str1);
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
    function LocateMsName (pMsName:Str10):boolean;
    function LocateCctCod (pCctCod:Str10):boolean;
    function LocateProTyp (pProTyp:Str1):boolean;
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
    function NearestMsName (pMsName:Str10):boolean;
    function NearestCctCod (pCctCod:Str10):boolean;
    function NearestProTyp (pProTyp:Str1):boolean;

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
    property SgCode:longint read ReadSgCode write WriteSgCode;
    property Notice:Str240 read ReadNotice write WriteNotice;
    property NewVatPrc:Str2 read ReadNewVatPrc write WriteNewVatPrc;
    property Reserve:Str4 read ReadReserve write WriteReserve;
    property ShpNum:byte read ReadShpNum write WriteShpNum;
    property SndShp:byte read ReadSndShp write WriteSndShp;
    property PlsNum1:word read ReadPlsNum1 write WritePlsNum1;
    property PlsNum2:word read ReadPlsNum2 write WritePlsNum2;
    property PlsNum3:word read ReadPlsNum3 write WritePlsNum3;
    property PlsNum4:word read ReadPlsNum4 write WritePlsNum4;
    property PlsNum5:word read ReadPlsNum5 write WritePlsNum5;
    property RbaTrc:byte read ReadRbaTrc write WriteRbaTrc;
    property CctCod:Str10 read ReadCctCod write WriteCctCod;
    property IsiSnt:Str3 read ReadIsiSnt write WriteIsiSnt;
    property IsiAnl:Str6 read ReadIsiAnl write WriteIsiAnl;
    property IciSnt:Str3 read ReadIciSnt write WriteIciSnt;
    property IciAnl:Str6 read ReadIciAnl write WriteIciAnl;
    property ProTyp:Str1 read ReadProTyp write WriteProTyp;
  end;

implementation

constructor TGscatBtr.Create;
begin
  oBtrTable := BtrInit ('GSCAT',gPath.StkPath,Self);
end;

constructor TGscatBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSCAT',pPath,Self);
end;

destructor TGscatBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGscatBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGscatBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGscatBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscatBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscatBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TGscatBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TGscatBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TGscatBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TGscatBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TGscatBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGscatBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TGscatBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TGscatBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TGscatBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TGscatBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TGscatBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TGscatBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TGscatBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TGscatBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TGscatBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TGscatBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TGscatBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TGscatBtr.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DrbMust').AsInteger);
end;

procedure TGscatBtr.WriteDrbMust(pValue:boolean);
begin
  oBtrTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TGscatBtr.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('PdnMust').AsInteger);
end;

procedure TGscatBtr.WritePdnMust(pValue:boolean);
begin
  oBtrTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TGscatBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TGscatBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TGscatBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TGscatBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TGscatBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TGscatBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGscatBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TGscatBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGscatBtr.ReadMsuQnt:double;
begin
  Result := oBtrTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TGscatBtr.WriteMsuQnt(pValue:double);
begin
  oBtrTable.FieldByName('MsuQnt').AsFloat := pValue;
end;

function TGscatBtr.ReadMsuName:Str5;
begin
  Result := oBtrTable.FieldByName('MsuName').AsString;
end;

procedure TGscatBtr.WriteMsuName(pValue:Str5);
begin
  oBtrTable.FieldByName('MsuName').AsString := pValue;
end;

function TGscatBtr.ReadSbcCnt:word;
begin
  Result := oBtrTable.FieldByName('SbcCnt').AsInteger;
end;

procedure TGscatBtr.WriteSbcCnt(pValue:word);
begin
  oBtrTable.FieldByName('SbcCnt').AsInteger := pValue;
end;

function TGscatBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TGscatBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TGscatBtr.ReadLinPrice:double;
begin
  Result := oBtrTable.FieldByName('LinPrice').AsFloat;
end;

procedure TGscatBtr.WriteLinPrice(pValue:double);
begin
  oBtrTable.FieldByName('LinPrice').AsFloat := pValue;
end;

function TGscatBtr.ReadLinDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('LinDate').AsDateTime;
end;

procedure TGscatBtr.WriteLinDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LinDate').AsDateTime := pValue;
end;

function TGscatBtr.ReadLinStk:word;
begin
  Result := oBtrTable.FieldByName('LinStk').AsInteger;
end;

procedure TGscatBtr.WriteLinStk(pValue:word);
begin
  oBtrTable.FieldByName('LinStk').AsInteger := pValue;
end;

function TGscatBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TGscatBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TGscatBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TGscatBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TGscatBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TGscatBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TGscatBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGscatBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGscatBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGscatBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TGscatBtr.ReadLinPac:longint;
begin
  Result := oBtrTable.FieldByName('LinPac').AsInteger;
end;

procedure TGscatBtr.WriteLinPac(pValue:longint);
begin
  oBtrTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TGscatBtr.ReadSecNum:word;
begin
  Result := oBtrTable.FieldByName('SecNum').AsInteger;
end;

procedure TGscatBtr.WriteSecNum(pValue:word);
begin
  oBtrTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TGscatBtr.ReadWgCode:word;
begin
  Result := oBtrTable.FieldByName('WgCode').AsInteger;
end;

procedure TGscatBtr.WriteWgCode(pValue:word);
begin
  oBtrTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TGscatBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TGscatBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGscatBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGscatBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGscatBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGscatBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGscatBtr.ReadBasGsc:longint;
begin
  Result := oBtrTable.FieldByName('BasGsc').AsInteger;
end;

procedure TGscatBtr.WriteBasGsc(pValue:longint);
begin
  oBtrTable.FieldByName('BasGsc').AsInteger := pValue;
end;

function TGscatBtr.ReadGscKfc:word;
begin
  Result := oBtrTable.FieldByName('GscKfc').AsInteger;
end;

procedure TGscatBtr.WriteGscKfc(pValue:word);
begin
  oBtrTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TGscatBtr.ReadGspKfc:word;
begin
  Result := oBtrTable.FieldByName('GspKfc').AsInteger;
end;

procedure TGscatBtr.WriteGspKfc(pValue:word);
begin
  oBtrTable.FieldByName('GspKfc').AsInteger := pValue;
end;

function TGscatBtr.ReadQliKfc:double;
begin
  Result := oBtrTable.FieldByName('QliKfc').AsFloat;
end;

procedure TGscatBtr.WriteQliKfc(pValue:double);
begin
  oBtrTable.FieldByName('QliKfc').AsFloat := pValue;
end;

function TGscatBtr.ReadDrbDay:word;
begin
  Result := oBtrTable.FieldByName('DrbDay').AsInteger;
end;

procedure TGscatBtr.WriteDrbDay(pValue:word);
begin
  oBtrTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TGscatBtr.ReadOsdCode:Str15;
begin
  Result := oBtrTable.FieldByName('OsdCode').AsString;
end;

procedure TGscatBtr.WriteOsdCode(pValue:Str15);
begin
  oBtrTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGscatBtr.ReadMinOsq:double;
begin
  Result := oBtrTable.FieldByName('MinOsq').AsFloat;
end;

procedure TGscatBtr.WriteMinOsq(pValue:double);
begin
  oBtrTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TGscatBtr.ReadSpcCode:Str30;
begin
  Result := oBtrTable.FieldByName('SpcCode').AsString;
end;

procedure TGscatBtr.WriteSpcCode(pValue:Str30);
begin
  oBtrTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGscatBtr.ReadPrdPac:longint;
begin
  Result := oBtrTable.FieldByName('PrdPac').AsInteger;
end;

procedure TGscatBtr.WritePrdPac(pValue:longint);
begin
  oBtrTable.FieldByName('PrdPac').AsInteger := pValue;
end;

function TGscatBtr.ReadSupPac:longint;
begin
  Result := oBtrTable.FieldByName('SupPac').AsInteger;
end;

procedure TGscatBtr.WriteSupPac(pValue:longint);
begin
  oBtrTable.FieldByName('SupPac').AsInteger := pValue;
end;

function TGscatBtr.ReadSpirGs:byte;
begin
  Result := oBtrTable.FieldByName('SpirGs').AsInteger;
end;

procedure TGscatBtr.WriteSpirGs(pValue:byte);
begin
  oBtrTable.FieldByName('SpirGs').AsInteger := pValue;
end;

function TGscatBtr.ReadGaName:Str60;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TGscatBtr.WriteGaName(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TGscatBtr.ReadGaName_:Str60;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TGscatBtr.WriteGaName_(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

function TGscatBtr.ReadDivSet:byte;
begin
  Result := oBtrTable.FieldByName('DivSet').AsInteger;
end;

procedure TGscatBtr.WriteDivSet(pValue:byte);
begin
  oBtrTable.FieldByName('DivSet').AsInteger := pValue;
end;

function TGscatBtr.ReadSgCode:longint;
begin
  Result := oBtrTable.FieldByName('SgCode').AsInteger;
end;

procedure TGscatBtr.WriteSgCode(pValue:longint);
begin
  oBtrTable.FieldByName('SgCode').AsInteger := pValue;
end;

function TGscatBtr.ReadNotice:Str240;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TGscatBtr.WriteNotice(pValue:Str240);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TGscatBtr.ReadNewVatPrc:Str2;
begin
  Result := oBtrTable.FieldByName('NewVatPrc').AsString;
end;

procedure TGscatBtr.WriteNewVatPrc(pValue:Str2);
begin
  oBtrTable.FieldByName('NewVatPrc').AsString := pValue;
end;

function TGscatBtr.ReadReserve:Str4;
begin
  Result := oBtrTable.FieldByName('Reserve').AsString;
end;

procedure TGscatBtr.WriteReserve(pValue:Str4);
begin
  oBtrTable.FieldByName('Reserve').AsString := pValue;
end;

function TGscatBtr.ReadShpNum:byte;
begin
  Result := oBtrTable.FieldByName('ShpNum').AsInteger;
end;

procedure TGscatBtr.WriteShpNum(pValue:byte);
begin
  oBtrTable.FieldByName('ShpNum').AsInteger := pValue;
end;

function TGscatBtr.ReadSndShp:byte;
begin
  Result := oBtrTable.FieldByName('SndShp').AsInteger;
end;

procedure TGscatBtr.WriteSndShp(pValue:byte);
begin
  oBtrTable.FieldByName('SndShp').AsInteger := pValue;
end;

function TGscatBtr.ReadPlsNum1:word;
begin
  Result := oBtrTable.FieldByName('PlsNum1').AsInteger;
end;

procedure TGscatBtr.WritePlsNum1(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum1').AsInteger := pValue;
end;

function TGscatBtr.ReadPlsNum2:word;
begin
  Result := oBtrTable.FieldByName('PlsNum2').AsInteger;
end;

procedure TGscatBtr.WritePlsNum2(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum2').AsInteger := pValue;
end;

function TGscatBtr.ReadPlsNum3:word;
begin
  Result := oBtrTable.FieldByName('PlsNum3').AsInteger;
end;

procedure TGscatBtr.WritePlsNum3(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum3').AsInteger := pValue;
end;

function TGscatBtr.ReadPlsNum4:word;
begin
  Result := oBtrTable.FieldByName('PlsNum4').AsInteger;
end;

procedure TGscatBtr.WritePlsNum4(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum4').AsInteger := pValue;
end;

function TGscatBtr.ReadPlsNum5:word;
begin
  Result := oBtrTable.FieldByName('PlsNum5').AsInteger;
end;

procedure TGscatBtr.WritePlsNum5(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum5').AsInteger := pValue;
end;

function TGscatBtr.ReadRbaTrc:byte;
begin
  Result := oBtrTable.FieldByName('RbaTrc').AsInteger;
end;

procedure TGscatBtr.WriteRbaTrc(pValue:byte);
begin
  oBtrTable.FieldByName('RbaTrc').AsInteger := pValue;
end;

function TGscatBtr.ReadCctCod:Str10;
begin
  Result := oBtrTable.FieldByName('CctCod').AsString;
end;

procedure TGscatBtr.WriteCctCod(pValue:Str10);
begin
  oBtrTable.FieldByName('CctCod').AsString := pValue;
end;

function TGscatBtr.ReadIsiSnt:Str3;
begin
  Result := oBtrTable.FieldByName('IsiSnt').AsString;
end;

procedure TGscatBtr.WriteIsiSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('IsiSnt').AsString := pValue;
end;

function TGscatBtr.ReadIsiAnl:Str6;
begin
  Result := oBtrTable.FieldByName('IsiAnl').AsString;
end;

procedure TGscatBtr.WriteIsiAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('IsiAnl').AsString := pValue;
end;

function TGscatBtr.ReadIciSnt:Str3;
begin
  Result := oBtrTable.FieldByName('IciSnt').AsString;
end;

procedure TGscatBtr.WriteIciSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('IciSnt').AsString := pValue;
end;

function TGscatBtr.ReadIciAnl:Str6;
begin
  Result := oBtrTable.FieldByName('IciAnl').AsString;
end;

procedure TGscatBtr.WriteIciAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('IciAnl').AsString := pValue;
end;

function TGscatBtr.ReadProTyp:Str1;
begin
  Result := oBtrTable.FieldByName('ProTyp').AsString;
end;

procedure TGscatBtr.WriteProTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('ProTyp').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscatBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscatBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGscatBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscatBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGscatBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGscatBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGscatBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGscatBtr.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindKey([pMgCode,pGsCode]);
end;

function TGscatBtr.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindKey([pFgCode]);
end;

function TGscatBtr.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TGscatBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TGscatBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TGscatBtr.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oBtrTable.FindKey([pSpcCode]);
end;

function TGscatBtr.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindKey([pOsdCode]);
end;

function TGscatBtr.LocateGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindKey([pGsType]);
end;

function TGscatBtr.LocatePackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oBtrTable.FindKey([pPackGs]);
end;

function TGscatBtr.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindKey([pDisFlag]);
end;

function TGscatBtr.LocateSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  Result := oBtrTable.FindKey([pSecNum,pWgCode]);
end;

function TGscatBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TGscatBtr.LocateGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([StrToAlias(pGaName_)]);
end;

function TGscatBtr.LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindKey([pMgCode,pStkCode]);
end;

function TGscatBtr.LocateMsName (pMsName:Str10):boolean;
begin
  SetIndex (ixMsName);
  Result := oBtrTable.FindKey([pMsName]);
end;

function TGscatBtr.LocateCctCod (pCctCod:Str10):boolean;
begin
  SetIndex (ixCctCod);
  Result := oBtrTable.FindKey([pCctCod]);
end;

function TGscatBtr.LocateProTyp (pProTyp:Str1):boolean;
begin
  SetIndex (ixProTyp);
  Result := oBtrTable.FindKey([pProTyp]);
end;

function TGscatBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TGscatBtr.NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindNearest([pMgCode,pGsCode]);
end;

function TGscatBtr.NearestFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindNearest([pFgCode]);
end;

function TGscatBtr.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TGscatBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TGscatBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TGscatBtr.NearestSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oBtrTable.FindNearest([pSpcCode]);
end;

function TGscatBtr.NearestOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindNearest([pOsdCode]);
end;

function TGscatBtr.NearestGsType (pGsType:Str1):boolean;
begin
  SetIndex (ixGsType);
  Result := oBtrTable.FindNearest([pGsType]);
end;

function TGscatBtr.NearestPackGs (pPackGs:longint):boolean;
begin
  SetIndex (ixPackGs);
  Result := oBtrTable.FindNearest([pPackGs]);
end;

function TGscatBtr.NearestDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindNearest([pDisFlag]);
end;

function TGscatBtr.NearestSnWc (pSecNum:word;pWgCode:word):boolean;
begin
  SetIndex (ixSnWc);
  Result := oBtrTable.FindNearest([pSecNum,pWgCode]);
end;

function TGscatBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TGscatBtr.NearestGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindNearest([pGaName_]);
end;

function TGscatBtr.NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindNearest([pMgCode,pStkCode]);
end;

function TGscatBtr.NearestMsName (pMsName:Str10):boolean;
begin
  SetIndex (ixMsName);
  Result := oBtrTable.FindNearest([pMsName]);
end;

function TGscatBtr.NearestCctCod (pCctCod:Str10):boolean;
begin
  SetIndex (ixCctCod);
  Result := oBtrTable.FindNearest([pCctCod]);
end;

function TGscatBtr.NearestProTyp (pProTyp:Str1):boolean;
begin
  SetIndex (ixProTyp);
  Result := oBtrTable.FindNearest([pProTyp]);
end;

procedure TGscatBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGscatBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGscatBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGscatBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGscatBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGscatBtr.First;
begin
  oBtrTable.First;
end;

procedure TGscatBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGscatBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGscatBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGscatBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGscatBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGscatBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGscatBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGscatBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGscatBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGscatBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGscatBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
