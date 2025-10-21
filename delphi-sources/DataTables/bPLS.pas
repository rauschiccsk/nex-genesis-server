unit bPLS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixMgGs = 'MgGs';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixProfit = 'Profit';
  ixAPrice = 'APrice';
  ixBPrice = 'BPrice';
  ixChgItm = 'ChgItm';
  ixDisFlag = 'DisFlag';
  ixAction = 'Action';
  ixSended = 'Sended';
  ixGaName = 'GaName';
  ixMgSc = 'MgSc';
  ixOsdCode = 'OsdCode';
  ixOvsUser = 'OvsUser';

type
  TPlsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadUPrice:double;         procedure WriteUPrice (pValue:double);
    function  ReadOrdPrn:byte;           procedure WriteOrdPrn (pValue:byte);
    function  ReadOpenGs:byte;           procedure WriteOpenGs (pValue:byte);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadChgItm:Str1;           procedure WriteChgItm (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDscPrc1:double;        procedure WriteDscPrc1 (pValue:double);
    function  ReadPrfPrc1:double;        procedure WritePrfPrc1 (pValue:double);
    function  ReadAPrice1:double;        procedure WriteAPrice1 (pValue:double);
    function  ReadBPrice1:double;        procedure WriteBPrice1 (pValue:double);
    function  ReadDscPrc2:double;        procedure WriteDscPrc2 (pValue:double);
    function  ReadPrfPrc2:double;        procedure WritePrfPrc2 (pValue:double);
    function  ReadAPrice2:double;        procedure WriteAPrice2 (pValue:double);
    function  ReadBPrice2:double;        procedure WriteBPrice2 (pValue:double);
    function  ReadDscPrc3:double;        procedure WriteDscPrc3 (pValue:double);
    function  ReadPrfPrc3:double;        procedure WritePrfPrc3 (pValue:double);
    function  ReadAPrice3:double;        procedure WriteAPrice3 (pValue:double);
    function  ReadBPrice3:double;        procedure WriteBPrice3 (pValue:double);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadOsdCode:Str30;         procedure WriteOsdCode (pValue:Str30);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadOvsUser:Str8;          procedure WriteOvsUser (pValue:Str8);
    function  ReadOvsDate:TDatetime;     procedure WriteOvsDate (pValue:TDatetime);
    function  ReadCpcSrc:Str1;           procedure WriteCpcSrc (pValue:Str1);
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
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateProfit (pProfit:double):boolean;
    function LocateAPrice (pAPrice:double):boolean;
    function LocateBPrice (pBPrice:double):boolean;
    function LocateChgItm (pChgItm:Str1):boolean;
    function LocateDisFlag (pDisFlag:byte):boolean;
    function LocateAction (pAction:Str1):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateGaName (pGaName_:Str60):boolean;
    function LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
    function LocateOsdCode (pOsdCode:Str30):boolean;
    function LocateOvsUser (pOvsUser:Str8):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestProfit (pProfit:double):boolean;
    function NearestAPrice (pAPrice:double):boolean;
    function NearestBPrice (pBPrice:double):boolean;
    function NearestChgItm (pChgItm:Str1):boolean;
    function NearestDisFlag (pDisFlag:byte):boolean;
    function NearestAction (pAction:Str1):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestGaName (pGaName_:Str60):boolean;
    function NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
    function NearestOsdCode (pOsdCode:Str30):boolean;
    function NearestOvsUser (pOvsUser:Str8):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pPlsNum:word);
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
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property Profit:double read ReadProfit write WriteProfit;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property UPrice:double read ReadUPrice write WriteUPrice;
    property OrdPrn:byte read ReadOrdPrn write WriteOrdPrn;
    property OpenGs:byte read ReadOpenGs write WriteOpenGs;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property ChgItm:Str1 read ReadChgItm write WriteChgItm;
    property Action:Str1 read ReadAction write WriteAction;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DscPrc1:double read ReadDscPrc1 write WriteDscPrc1;
    property PrfPrc1:double read ReadPrfPrc1 write WritePrfPrc1;
    property APrice1:double read ReadAPrice1 write WriteAPrice1;
    property BPrice1:double read ReadBPrice1 write WriteBPrice1;
    property DscPrc2:double read ReadDscPrc2 write WriteDscPrc2;
    property PrfPrc2:double read ReadPrfPrc2 write WritePrfPrc2;
    property APrice2:double read ReadAPrice2 write WriteAPrice2;
    property BPrice2:double read ReadBPrice2 write WriteBPrice2;
    property DscPrc3:double read ReadDscPrc3 write WriteDscPrc3;
    property PrfPrc3:double read ReadPrfPrc3 write WritePrfPrc3;
    property APrice3:double read ReadAPrice3 write WriteAPrice3;
    property BPrice3:double read ReadBPrice3 write WriteBPrice3;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property OsdCode:Str30 read ReadOsdCode write WriteOsdCode;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property OvsUser:Str8 read ReadOvsUser write WriteOvsUser;
    property OvsDate:TDatetime read ReadOvsDate write WriteOvsDate;
    property CpcSrc:Str1 read ReadCpcSrc write WriteCpcSrc;
  end;

implementation

constructor TPlsBtr.Create;
begin
  oBtrTable := BtrInit ('PLS',gPath.StkPath,Self);
end;

constructor TPlsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLS',pPath,Self);
end;

destructor TPlsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlsBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlsBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPlsBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TPlsBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TPlsBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TPlsBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TPlsBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TPlsBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPlsBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TPlsBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TPlsBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TPlsBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TPlsBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TPlsBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TPlsBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPlsBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPlsBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TPlsBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TPlsBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPlsBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPlsBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPlsBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPlsBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TPlsBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TPlsBtr.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DrbMust').AsInteger);
end;

procedure TPlsBtr.WriteDrbMust(pValue:boolean);
begin
  oBtrTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TPlsBtr.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('PdnMust').AsInteger);
end;

procedure TPlsBtr.WritePdnMust(pValue:boolean);
begin
  oBtrTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TPlsBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TPlsBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TPlsBtr.ReadProfit:double;
begin
  Result := oBtrTable.FieldByName('Profit').AsFloat;
end;

procedure TPlsBtr.WriteProfit(pValue:double);
begin
  oBtrTable.FieldByName('Profit').AsFloat := pValue;
end;

function TPlsBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TPlsBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TPlsBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TPlsBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TPlsBtr.ReadUPrice:double;
begin
  Result := oBtrTable.FieldByName('UPrice').AsFloat;
end;

procedure TPlsBtr.WriteUPrice(pValue:double);
begin
  oBtrTable.FieldByName('UPrice').AsFloat := pValue;
end;

function TPlsBtr.ReadOrdPrn:byte;
begin
  Result := oBtrTable.FieldByName('OrdPrn').AsInteger;
end;

procedure TPlsBtr.WriteOrdPrn(pValue:byte);
begin
  oBtrTable.FieldByName('OrdPrn').AsInteger := pValue;
end;

function TPlsBtr.ReadOpenGs:byte;
begin
  Result := oBtrTable.FieldByName('OpenGs').AsInteger;
end;

procedure TPlsBtr.WriteOpenGs(pValue:byte);
begin
  oBtrTable.FieldByName('OpenGs').AsInteger := pValue;
end;

function TPlsBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TPlsBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TPlsBtr.ReadChgItm:Str1;
begin
  Result := oBtrTable.FieldByName('ChgItm').AsString;
end;

procedure TPlsBtr.WriteChgItm(pValue:Str1);
begin
  oBtrTable.FieldByName('ChgItm').AsString := pValue;
end;

function TPlsBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TPlsBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TPlsBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TPlsBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPlsBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPlsBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPlsBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPlsBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPlsBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPlsBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPlsBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPlsBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPlsBtr.ReadDscPrc1:double;
begin
  Result := oBtrTable.FieldByName('DscPrc1').AsFloat;
end;

procedure TPlsBtr.WriteDscPrc1(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc1').AsFloat := pValue;
end;

function TPlsBtr.ReadPrfPrc1:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc1').AsFloat;
end;

procedure TPlsBtr.WritePrfPrc1(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc1').AsFloat := pValue;
end;

function TPlsBtr.ReadAPrice1:double;
begin
  Result := oBtrTable.FieldByName('APrice1').AsFloat;
end;

procedure TPlsBtr.WriteAPrice1(pValue:double);
begin
  oBtrTable.FieldByName('APrice1').AsFloat := pValue;
end;

function TPlsBtr.ReadBPrice1:double;
begin
  Result := oBtrTable.FieldByName('BPrice1').AsFloat;
end;

procedure TPlsBtr.WriteBPrice1(pValue:double);
begin
  oBtrTable.FieldByName('BPrice1').AsFloat := pValue;
end;

function TPlsBtr.ReadDscPrc2:double;
begin
  Result := oBtrTable.FieldByName('DscPrc2').AsFloat;
end;

procedure TPlsBtr.WriteDscPrc2(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc2').AsFloat := pValue;
end;

function TPlsBtr.ReadPrfPrc2:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc2').AsFloat;
end;

procedure TPlsBtr.WritePrfPrc2(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc2').AsFloat := pValue;
end;

function TPlsBtr.ReadAPrice2:double;
begin
  Result := oBtrTable.FieldByName('APrice2').AsFloat;
end;

procedure TPlsBtr.WriteAPrice2(pValue:double);
begin
  oBtrTable.FieldByName('APrice2').AsFloat := pValue;
end;

function TPlsBtr.ReadBPrice2:double;
begin
  Result := oBtrTable.FieldByName('BPrice2').AsFloat;
end;

procedure TPlsBtr.WriteBPrice2(pValue:double);
begin
  oBtrTable.FieldByName('BPrice2').AsFloat := pValue;
end;

function TPlsBtr.ReadDscPrc3:double;
begin
  Result := oBtrTable.FieldByName('DscPrc3').AsFloat;
end;

procedure TPlsBtr.WriteDscPrc3(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc3').AsFloat := pValue;
end;

function TPlsBtr.ReadPrfPrc3:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc3').AsFloat;
end;

procedure TPlsBtr.WritePrfPrc3(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc3').AsFloat := pValue;
end;

function TPlsBtr.ReadAPrice3:double;
begin
  Result := oBtrTable.FieldByName('APrice3').AsFloat;
end;

procedure TPlsBtr.WriteAPrice3(pValue:double);
begin
  oBtrTable.FieldByName('APrice3').AsFloat := pValue;
end;

function TPlsBtr.ReadBPrice3:double;
begin
  Result := oBtrTable.FieldByName('BPrice3').AsFloat;
end;

procedure TPlsBtr.WriteBPrice3(pValue:double);
begin
  oBtrTable.FieldByName('BPrice3').AsFloat := pValue;
end;

function TPlsBtr.ReadGaName:Str60;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TPlsBtr.WriteGaName(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TPlsBtr.ReadGaName_:Str60;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TPlsBtr.WriteGaName_(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

function TPlsBtr.ReadOsdCode:Str30;
begin
  Result := oBtrTable.FieldByName('OsdCode').AsString;
end;

procedure TPlsBtr.WriteOsdCode(pValue:Str30);
begin
  oBtrTable.FieldByName('OsdCode').AsString := pValue;
end;

function TPlsBtr.ReadMinQnt:double;
begin
  Result := oBtrTable.FieldByName('MinQnt').AsFloat;
end;

procedure TPlsBtr.WriteMinQnt(pValue:double);
begin
  oBtrTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TPlsBtr.ReadOvsUser:Str8;
begin
  Result := oBtrTable.FieldByName('OvsUser').AsString;
end;

procedure TPlsBtr.WriteOvsUser(pValue:Str8);
begin
  oBtrTable.FieldByName('OvsUser').AsString := pValue;
end;

function TPlsBtr.ReadOvsDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OvsDate').AsDateTime;
end;

procedure TPlsBtr.WriteOvsDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OvsDate').AsDateTime := pValue;
end;

function TPlsBtr.ReadCpcSrc:Str1;
begin
  Result := oBtrTable.FieldByName('CpcSrc').AsString;
end;

procedure TPlsBtr.WriteCpcSrc(pValue:Str1);
begin
  oBtrTable.FieldByName('CpcSrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPlsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlsBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPlsBtr.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindKey([pMgCode,pGsCode]);
end;

function TPlsBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TPlsBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TPlsBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TPlsBtr.LocateProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindKey([pProfit]);
end;

function TPlsBtr.LocateAPrice (pAPrice:double):boolean;
begin
  SetIndex (ixAPrice);
  Result := oBtrTable.FindKey([pAPrice]);
end;

function TPlsBtr.LocateBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oBtrTable.FindKey([pBPrice]);
end;

function TPlsBtr.LocateChgItm (pChgItm:Str1):boolean;
begin
  SetIndex (ixChgItm);
  Result := oBtrTable.FindKey([pChgItm]);
end;

function TPlsBtr.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindKey([pDisFlag]);
end;

function TPlsBtr.LocateAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindKey([pAction]);
end;

function TPlsBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TPlsBtr.LocateGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([StrToAlias(pGaName_)]);
end;

function TPlsBtr.LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindKey([pMgCode,pStkCode]);
end;

function TPlsBtr.LocateOsdCode (pOsdCode:Str30):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindKey([pOsdCode]);
end;

function TPlsBtr.LocateOvsUser (pOvsUser:Str8):boolean;
begin
  SetIndex (ixOvsUser);
  Result := oBtrTable.FindKey([pOvsUser]);
end;

function TPlsBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TPlsBtr.NearestMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oBtrTable.FindNearest([pMgCode,pGsCode]);
end;

function TPlsBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TPlsBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TPlsBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TPlsBtr.NearestProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oBtrTable.FindNearest([pProfit]);
end;

function TPlsBtr.NearestAPrice (pAPrice:double):boolean;
begin
  SetIndex (ixAPrice);
  Result := oBtrTable.FindNearest([pAPrice]);
end;

function TPlsBtr.NearestBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oBtrTable.FindNearest([pBPrice]);
end;

function TPlsBtr.NearestChgItm (pChgItm:Str1):boolean;
begin
  SetIndex (ixChgItm);
  Result := oBtrTable.FindNearest([pChgItm]);
end;

function TPlsBtr.NearestDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oBtrTable.FindNearest([pDisFlag]);
end;

function TPlsBtr.NearestAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindNearest([pAction]);
end;

function TPlsBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TPlsBtr.NearestGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindNearest([pGaName_]);
end;

function TPlsBtr.NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindNearest([pMgCode,pStkCode]);
end;

function TPlsBtr.NearestOsdCode (pOsdCode:Str30):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindNearest([pOsdCode]);
end;

function TPlsBtr.NearestOvsUser (pOvsUser:Str8):boolean;
begin
  SetIndex (ixOvsUser);
  Result := oBtrTable.FindNearest([pOvsUser]);
end;

procedure TPlsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlsBtr.Open(pPlsNum:word);
begin
  oBtrTable.Open(pPlsNum);
end;

procedure TPlsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlsBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1925001}
