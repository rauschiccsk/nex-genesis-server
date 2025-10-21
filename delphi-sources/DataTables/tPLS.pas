unit tPLS;

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
  ixProfit = 'Profit';
  ixAPrice = 'APrice';
  ixBPrice = 'BPrice';
  ixChgItm = 'ChgItm';
  ixDisFlag = 'DisFlag';
  ixAction = 'Action';
  ixStatus = 'Status';
  ixOsdCode = 'OsdCode';

type
  TPlsTmp = class (TComponent)
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
    function  ReadSubCode:Str15;         procedure WriteSubCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadMsuName:Str10;         procedure WriteMsuName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadWPrice:double;         procedure WriteWPrice (pValue:double);
    function  ReadUPrice:double;         procedure WriteUPrice (pValue:double);
    function  ReadMPrice:double;         procedure WriteMPrice (pValue:double);
    function  ReadDPrice:double;         procedure WriteDPrice (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadOrdPrn:byte;           procedure WriteOrdPrn (pValue:byte);
    function  ReadOpenGs:byte;           procedure WriteOpenGs (pValue:byte);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadChgItm:Str1;           procedure WriteChgItm (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgMPrice:double;       procedure WriteFgMPrice (pValue:double);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadNotice2:Str60;         procedure WriteNotice2 (pValue:Str60);
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
    function  ReadOsdCode:Str30;         procedure WriteOsdCode (pValue:Str30);
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
    function LocateProfit (pProfit:double):boolean;
    function LocateAPrice (pAPrice:double):boolean;
    function LocateBPrice (pBPrice:double):boolean;
    function LocateChgItm (pChgItm:Str1):boolean;
    function LocateDisFlag (pDisFlag:byte):boolean;
    function LocateAction (pAction:Str1):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateOsdCode (pOsdCode:Str30):boolean;

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
    property SubCode:Str15 read ReadSubCode write WriteSubCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property MsuName:Str10 read ReadMsuName write WriteMsuName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property Profit:double read ReadProfit write WriteProfit;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property WPrice:double read ReadWPrice write WriteWPrice;
    property UPrice:double read ReadUPrice write WriteUPrice;
    property MPrice:double read ReadMPrice write WriteMPrice;
    property DPrice:double read ReadDPrice write WriteDPrice;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property OrdPrn:byte read ReadOrdPrn write WriteOrdPrn;
    property OpenGs:byte read ReadOpenGs write WriteOpenGs;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property ChgItm:Str1 read ReadChgItm write WriteChgItm;
    property Action:Str1 read ReadAction write WriteAction;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property ModNum:word read ReadModNum write WriteModNum;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgMPrice:double read ReadFgMPrice write WriteFgMPrice;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property Notice2:Str60 read ReadNotice2 write WriteNotice2;
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
    property OsdCode:Str30 read ReadOsdCode write WriteOsdCode;
  end;

implementation

constructor TPlsTmp.Create;
begin
  oTmpTable := TmpInit ('PLS',Self);
end;

destructor TPlsTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPlsTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPlsTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPlsTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlsTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPlsTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TPlsTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TPlsTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TPlsTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TPlsTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TPlsTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TPlsTmp.ReadGaName_:Str60;
begin
  Result := oTmpTable.FieldByName('GaName_').AsString;
end;

procedure TPlsTmp.WriteGaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName_').AsString := pValue;
end;

function TPlsTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TPlsTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPlsTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TPlsTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TPlsTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TPlsTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TPlsTmp.ReadSubCode:Str15;
begin
  Result := oTmpTable.FieldByName('SubCode').AsString;
end;

procedure TPlsTmp.WriteSubCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SubCode').AsString := pValue;
end;

function TPlsTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TPlsTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TPlsTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TPlsTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TPlsTmp.ReadMsuName:Str10;
begin
  Result := oTmpTable.FieldByName('MsuName').AsString;
end;

procedure TPlsTmp.WriteMsuName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuName').AsString := pValue;
end;

function TPlsTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TPlsTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TPlsTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TPlsTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPlsTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPlsTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPlsTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TPlsTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TPlsTmp.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DrbMust').AsInteger);
end;

procedure TPlsTmp.WriteDrbMust(pValue:boolean);
begin
  oTmpTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TPlsTmp.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('PdnMust').AsInteger);
end;

procedure TPlsTmp.WritePdnMust(pValue:boolean);
begin
  oTmpTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TPlsTmp.ReadGrcMth:word;
begin
  Result := oTmpTable.FieldByName('GrcMth').AsInteger;
end;

procedure TPlsTmp.WriteGrcMth(pValue:word);
begin
  oTmpTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TPlsTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TPlsTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TPlsTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TPlsTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadProfit:double;
begin
  Result := oTmpTable.FieldByName('Profit').AsFloat;
end;

procedure TPlsTmp.WriteProfit(pValue:double);
begin
  oTmpTable.FieldByName('Profit').AsFloat := pValue;
end;

function TPlsTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TPlsTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TPlsTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TPlsTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadWPrice:double;
begin
  Result := oTmpTable.FieldByName('WPrice').AsFloat;
end;

procedure TPlsTmp.WriteWPrice(pValue:double);
begin
  oTmpTable.FieldByName('WPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadUPrice:double;
begin
  Result := oTmpTable.FieldByName('UPrice').AsFloat;
end;

procedure TPlsTmp.WriteUPrice(pValue:double);
begin
  oTmpTable.FieldByName('UPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadMPrice:double;
begin
  Result := oTmpTable.FieldByName('MPrice').AsFloat;
end;

procedure TPlsTmp.WriteMPrice(pValue:double);
begin
  oTmpTable.FieldByName('MPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadDPrice:double;
begin
  Result := oTmpTable.FieldByName('DPrice').AsFloat;
end;

procedure TPlsTmp.WriteDPrice(pValue:double);
begin
  oTmpTable.FieldByName('DPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPlsTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPlsTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TPlsTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TPlsTmp.ReadOrdPrn:byte;
begin
  Result := oTmpTable.FieldByName('OrdPrn').AsInteger;
end;

procedure TPlsTmp.WriteOrdPrn(pValue:byte);
begin
  oTmpTable.FieldByName('OrdPrn').AsInteger := pValue;
end;

function TPlsTmp.ReadOpenGs:byte;
begin
  Result := oTmpTable.FieldByName('OpenGs').AsInteger;
end;

procedure TPlsTmp.WriteOpenGs(pValue:byte);
begin
  oTmpTable.FieldByName('OpenGs').AsInteger := pValue;
end;

function TPlsTmp.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DisFlag').AsInteger);
end;

procedure TPlsTmp.WriteDisFlag(pValue:boolean);
begin
  oTmpTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TPlsTmp.ReadChgItm:Str1;
begin
  Result := oTmpTable.FieldByName('ChgItm').AsString;
end;

procedure TPlsTmp.WriteChgItm(pValue:Str1);
begin
  oTmpTable.FieldByName('ChgItm').AsString := pValue;
end;

function TPlsTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TPlsTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TPlsTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TPlsTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TPlsTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TPlsTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPlsTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TPlsTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TPlsTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TPlsTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPlsTmp.ReadFgAPrice:double;
begin
  Result := oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TPlsTmp.WriteFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadFgBPrice:double;
begin
  Result := oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TPlsTmp.WriteFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadFgMPrice:double;
begin
  Result := oTmpTable.FieldByName('FgMPrice').AsFloat;
end;

procedure TPlsTmp.WriteFgMPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgMPrice').AsFloat := pValue;
end;

function TPlsTmp.ReadNotice:Str60;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TPlsTmp.WriteNotice(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TPlsTmp.ReadNotice2:Str60;
begin
  Result := oTmpTable.FieldByName('Notice2').AsString;
end;

procedure TPlsTmp.WriteNotice2(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice2').AsString := pValue;
end;

function TPlsTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPlsTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPlsTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPlsTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPlsTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPlsTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPlsTmp.ReadDscPrc1:double;
begin
  Result := oTmpTable.FieldByName('DscPrc1').AsFloat;
end;

procedure TPlsTmp.WriteDscPrc1(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc1').AsFloat := pValue;
end;

function TPlsTmp.ReadPrfPrc1:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc1').AsFloat;
end;

procedure TPlsTmp.WritePrfPrc1(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc1').AsFloat := pValue;
end;

function TPlsTmp.ReadAPrice1:double;
begin
  Result := oTmpTable.FieldByName('APrice1').AsFloat;
end;

procedure TPlsTmp.WriteAPrice1(pValue:double);
begin
  oTmpTable.FieldByName('APrice1').AsFloat := pValue;
end;

function TPlsTmp.ReadBPrice1:double;
begin
  Result := oTmpTable.FieldByName('BPrice1').AsFloat;
end;

procedure TPlsTmp.WriteBPrice1(pValue:double);
begin
  oTmpTable.FieldByName('BPrice1').AsFloat := pValue;
end;

function TPlsTmp.ReadDscPrc2:double;
begin
  Result := oTmpTable.FieldByName('DscPrc2').AsFloat;
end;

procedure TPlsTmp.WriteDscPrc2(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc2').AsFloat := pValue;
end;

function TPlsTmp.ReadPrfPrc2:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc2').AsFloat;
end;

procedure TPlsTmp.WritePrfPrc2(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc2').AsFloat := pValue;
end;

function TPlsTmp.ReadAPrice2:double;
begin
  Result := oTmpTable.FieldByName('APrice2').AsFloat;
end;

procedure TPlsTmp.WriteAPrice2(pValue:double);
begin
  oTmpTable.FieldByName('APrice2').AsFloat := pValue;
end;

function TPlsTmp.ReadBPrice2:double;
begin
  Result := oTmpTable.FieldByName('BPrice2').AsFloat;
end;

procedure TPlsTmp.WriteBPrice2(pValue:double);
begin
  oTmpTable.FieldByName('BPrice2').AsFloat := pValue;
end;

function TPlsTmp.ReadDscPrc3:double;
begin
  Result := oTmpTable.FieldByName('DscPrc3').AsFloat;
end;

procedure TPlsTmp.WriteDscPrc3(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc3').AsFloat := pValue;
end;

function TPlsTmp.ReadPrfPrc3:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc3').AsFloat;
end;

procedure TPlsTmp.WritePrfPrc3(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc3').AsFloat := pValue;
end;

function TPlsTmp.ReadAPrice3:double;
begin
  Result := oTmpTable.FieldByName('APrice3').AsFloat;
end;

procedure TPlsTmp.WriteAPrice3(pValue:double);
begin
  oTmpTable.FieldByName('APrice3').AsFloat := pValue;
end;

function TPlsTmp.ReadBPrice3:double;
begin
  Result := oTmpTable.FieldByName('BPrice3').AsFloat;
end;

procedure TPlsTmp.WriteBPrice3(pValue:double);
begin
  oTmpTable.FieldByName('BPrice3').AsFloat := pValue;
end;

function TPlsTmp.ReadOsdCode:Str30;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TPlsTmp.WriteOsdCode(pValue:Str30);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlsTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPlsTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPlsTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TPlsTmp.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oTmpTable.FindKey([pMgCode,pGsCode]);
end;

function TPlsTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TPlsTmp.LocateGaName_ (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName_);
  Result := oTmpTable.FindKey([pGaName_]);
end;

function TPlsTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TPlsTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TPlsTmp.LocateProfit (pProfit:double):boolean;
begin
  SetIndex (ixProfit);
  Result := oTmpTable.FindKey([pProfit]);
end;

function TPlsTmp.LocateAPrice (pAPrice:double):boolean;
begin
  SetIndex (ixAPrice);
  Result := oTmpTable.FindKey([pAPrice]);
end;

function TPlsTmp.LocateBPrice (pBPrice:double):boolean;
begin
  SetIndex (ixBPrice);
  Result := oTmpTable.FindKey([pBPrice]);
end;

function TPlsTmp.LocateChgItm (pChgItm:Str1):boolean;
begin
  SetIndex (ixChgItm);
  Result := oTmpTable.FindKey([pChgItm]);
end;

function TPlsTmp.LocateDisFlag (pDisFlag:byte):boolean;
begin
  SetIndex (ixDisFlag);
  Result := oTmpTable.FindKey([pDisFlag]);
end;

function TPlsTmp.LocateAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oTmpTable.FindKey([pAction]);
end;

function TPlsTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

function TPlsTmp.LocateOsdCode (pOsdCode:Str30):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oTmpTable.FindKey([pOsdCode]);
end;

procedure TPlsTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPlsTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPlsTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPlsTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPlsTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPlsTmp.First;
begin
  oTmpTable.First;
end;

procedure TPlsTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPlsTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPlsTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPlsTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPlsTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPlsTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPlsTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPlsTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPlsTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPlsTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPlsTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1807036}
