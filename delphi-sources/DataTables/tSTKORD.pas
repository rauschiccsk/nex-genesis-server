unit tSTKORD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgCode = 'MgCode';
  ixGsName_ = 'GsName_';
  ixGaName_ = 'GaName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixActQnt = 'ActQnt';
  ixActVal = 'ActVal';
  ixMinMax = 'MinMax';
  ixAvgPrice = 'AvgPrice';
  ixLastPrice = 'LastPrice';
  ixLastIDate = 'LastIDate';
  ixLastODate = 'LastODate';
  ixOsdQnt = 'OsdQnt';

type
  TStkordTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadDrbDay:word;           procedure WriteDrbDay (pValue:word);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadPrvOut:double;         procedure WritePrvOut (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadOsrQnt:double;         procedure WriteOsrQnt (pValue:double);
    function  ReadFroQnt:double;         procedure WriteFroQnt (pValue:double);
    function  ReadNsuQnt:double;         procedure WriteNsuQnt (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadInVal:double;          procedure WriteInVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadAvgPrice:double;       procedure WriteAvgPrice (pValue:double);
    function  ReadLastPrice:double;      procedure WriteLastPrice (pValue:double);
    function  ReadActPrice:double;       procedure WriteActPrice (pValue:double);
    function  ReadMinOsq:double;         procedure WriteMinOsq (pValue:double);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadOptQnt:double;         procedure WriteOptQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadPckQnt:double;         procedure WritePckQnt (pValue:double);
    function  ReadMinMax:Str1;           procedure WriteMinMax (pValue:Str1);
    function  ReadInvDate:TDatetime;     procedure WriteInvDate (pValue:TDatetime);
    function  ReadLastIDate:TDatetime;   procedure WriteLastIDate (pValue:TDatetime);
    function  ReadLastODate:TDatetime;   procedure WriteLastODate (pValue:TDatetime);
    function  ReadLastIQnt:double;       procedure WriteLastIQnt (pValue:double);
    function  ReadLastOQnt:double;       procedure WriteLastOQnt (pValue:double);
    function  ReadActSnQnt:longint;      procedure WriteActSnQnt (pValue:longint);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadMxwQnt:double;         procedure WriteMxwQnt (pValue:double);
    function  ReadMxwNum:longint;        procedure WriteMxwNum (pValue:longint);
    function  ReadSumQnt:double;         procedure WriteSumQnt (pValue:double);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadCnoQnt:double;         procedure WriteCnoQnt (pValue:double);
    function  ReadCnmQnt:double;         procedure WriteCnmQnt (pValue:double);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadImiQnt:double;         procedure WriteImiQnt (pValue:double);
    function  ReadASaQnt:double;         procedure WriteASaQnt (pValue:double);
    function  ReadAOuQnt:double;         procedure WriteAOuQnt (pValue:double);
    function  ReadPSaQnt:double;         procedure WritePSaQnt (pValue:double);
    function  ReadPOuQnt:double;         procedure WritePOuQnt (pValue:double);
    function  ReadSsoQnt:double;         procedure WriteSsoQnt (pValue:double);
    function  ReadImrQnt:double;         procedure WriteImrQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateGaName_ (pGaName_:Str60):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateActQnt (pActQnt:double):boolean;
    function LocateActVal (pActVal:double):boolean;
    function LocateMinMax (pMinMax:Str1):boolean;
    function LocateAvgPrice (pAvgPrice:double):boolean;
    function LocateLastPrice (pLastPrice:double):boolean;
    function LocateLastIDate (pLastIDate:TDatetime):boolean;
    function LocateLastODate (pLastODate:TDatetime):boolean;
    function LocateOsdQnt (pOsdQnt:double):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property DrbDay:word read ReadDrbDay write WriteDrbDay;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property PrvOut:double read ReadPrvOut write WritePrvOut;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property OsrQnt:double read ReadOsrQnt write WriteOsrQnt;
    property FroQnt:double read ReadFroQnt write WriteFroQnt;
    property NsuQnt:double read ReadNsuQnt write WriteNsuQnt;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property InVal:double read ReadInVal write WriteInVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property ActVal:double read ReadActVal write WriteActVal;
    property AvgPrice:double read ReadAvgPrice write WriteAvgPrice;
    property LastPrice:double read ReadLastPrice write WriteLastPrice;
    property ActPrice:double read ReadActPrice write WriteActPrice;
    property MinOsq:double read ReadMinOsq write WriteMinOsq;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property OptQnt:double read ReadOptQnt write WriteOptQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property PckQnt:double read ReadPckQnt write WritePckQnt;
    property MinMax:Str1 read ReadMinMax write WriteMinMax;
    property InvDate:TDatetime read ReadInvDate write WriteInvDate;
    property LastIDate:TDatetime read ReadLastIDate write WriteLastIDate;
    property LastODate:TDatetime read ReadLastODate write WriteLastODate;
    property LastIQnt:double read ReadLastIQnt write WriteLastIQnt;
    property LastOQnt:double read ReadLastOQnt write WriteLastOQnt;
    property ActSnQnt:longint read ReadActSnQnt write WriteActSnQnt;
    property Profit:double read ReadProfit write WriteProfit;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Sended:boolean read ReadSended write WriteSended;
    property Action:Str1 read ReadAction write WriteAction;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property MxwQnt:double read ReadMxwQnt write WriteMxwQnt;
    property MxwNum:longint read ReadMxwNum write WriteMxwNum;
    property SumQnt:double read ReadSumQnt write WriteSumQnt;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property CnoQnt:double read ReadCnoQnt write WriteCnoQnt;
    property CnmQnt:double read ReadCnmQnt write WriteCnmQnt;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property ImiQnt:double read ReadImiQnt write WriteImiQnt;
    property ASaQnt:double read ReadASaQnt write WriteASaQnt;
    property AOuQnt:double read ReadAOuQnt write WriteAOuQnt;
    property PSaQnt:double read ReadPSaQnt write WritePSaQnt;
    property POuQnt:double read ReadPOuQnt write WritePOuQnt;
    property SsoQnt:double read ReadSsoQnt write WriteSsoQnt;
    property ImrQnt:double read ReadImrQnt write WriteImrQnt;
  end;

implementation

constructor TStkordTmp.Create;
begin
  oTmpTable := TmpInit ('STKORD',Self);
end;

destructor TStkordTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkordTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStkordTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkordTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkordTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStkordTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TStkordTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TStkordTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStkordTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStkordTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStkordTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStkordTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TStkordTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TStkordTmp.ReadGaName_:Str60;
begin
  Result := oTmpTable.FieldByName('GaName_').AsString;
end;

procedure TStkordTmp.WriteGaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName_').AsString := pValue;
end;

function TStkordTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStkordTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TStkordTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TStkordTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TStkordTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStkordTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TStkordTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TStkordTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TStkordTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TStkordTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TStkordTmp.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DrbMust').AsInteger);
end;

procedure TStkordTmp.WriteDrbMust(pValue:boolean);
begin
  oTmpTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TStkordTmp.ReadDrbDay:word;
begin
  Result := oTmpTable.FieldByName('DrbDay').AsInteger;
end;

procedure TStkordTmp.WriteDrbDay(pValue:word);
begin
  oTmpTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TStkordTmp.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('PdnMust').AsInteger);
end;

procedure TStkordTmp.WritePdnMust(pValue:boolean);
begin
  oTmpTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TStkordTmp.ReadGrcMth:word;
begin
  Result := oTmpTable.FieldByName('GrcMth').AsInteger;
end;

procedure TStkordTmp.WriteGrcMth(pValue:word);
begin
  oTmpTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TStkordTmp.ReadBegQnt:double;
begin
  Result := oTmpTable.FieldByName('BegQnt').AsFloat;
end;

procedure TStkordTmp.WriteBegQnt(pValue:double);
begin
  oTmpTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadInQnt:double;
begin
  Result := oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TStkordTmp.WriteInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadPrvOut:double;
begin
  Result := oTmpTable.FieldByName('PrvOut').AsFloat;
end;

procedure TStkordTmp.WritePrvOut(pValue:double);
begin
  oTmpTable.FieldByName('PrvOut').AsFloat := pValue;
end;

function TStkordTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TStkordTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStkordTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStkordTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStkordTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadOcdQnt:double;
begin
  Result := oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TStkordTmp.WriteOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TStkordTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadOsdQnt:double;
begin
  Result := oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TStkordTmp.WriteOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadOsrQnt:double;
begin
  Result := oTmpTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TStkordTmp.WriteOsrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsrQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadFroQnt:double;
begin
  Result := oTmpTable.FieldByName('FroQnt').AsFloat;
end;

procedure TStkordTmp.WriteFroQnt(pValue:double);
begin
  oTmpTable.FieldByName('FroQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadNsuQnt:double;
begin
  Result := oTmpTable.FieldByName('NsuQnt').AsFloat;
end;

procedure TStkordTmp.WriteNsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsuQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadBegVal:double;
begin
  Result := oTmpTable.FieldByName('BegVal').AsFloat;
end;

procedure TStkordTmp.WriteBegVal(pValue:double);
begin
  oTmpTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TStkordTmp.ReadInVal:double;
begin
  Result := oTmpTable.FieldByName('InVal').AsFloat;
end;

procedure TStkordTmp.WriteInVal(pValue:double);
begin
  oTmpTable.FieldByName('InVal').AsFloat := pValue;
end;

function TStkordTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TStkordTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TStkordTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TStkordTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TStkordTmp.ReadAvgPrice:double;
begin
  Result := oTmpTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TStkordTmp.WriteAvgPrice(pValue:double);
begin
  oTmpTable.FieldByName('AvgPrice').AsFloat := pValue;
end;

function TStkordTmp.ReadLastPrice:double;
begin
  Result := oTmpTable.FieldByName('LastPrice').AsFloat;
end;

procedure TStkordTmp.WriteLastPrice(pValue:double);
begin
  oTmpTable.FieldByName('LastPrice').AsFloat := pValue;
end;

function TStkordTmp.ReadActPrice:double;
begin
  Result := oTmpTable.FieldByName('ActPrice').AsFloat;
end;

procedure TStkordTmp.WriteActPrice(pValue:double);
begin
  oTmpTable.FieldByName('ActPrice').AsFloat := pValue;
end;

function TStkordTmp.ReadMinOsq:double;
begin
  Result := oTmpTable.FieldByName('MinOsq').AsFloat;
end;

procedure TStkordTmp.WriteMinOsq(pValue:double);
begin
  oTmpTable.FieldByName('MinOsq').AsFloat := pValue;
end;

function TStkordTmp.ReadMaxQnt:double;
begin
  Result := oTmpTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TStkordTmp.WriteMaxQnt(pValue:double);
begin
  oTmpTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadMinQnt:double;
begin
  Result := oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TStkordTmp.WriteMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadOptQnt:double;
begin
  Result := oTmpTable.FieldByName('OptQnt').AsFloat;
end;

procedure TStkordTmp.WriteOptQnt(pValue:double);
begin
  oTmpTable.FieldByName('OptQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStkordTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadPckQnt:double;
begin
  Result := oTmpTable.FieldByName('PckQnt').AsFloat;
end;

procedure TStkordTmp.WritePckQnt(pValue:double);
begin
  oTmpTable.FieldByName('PckQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadMinMax:Str1;
begin
  Result := oTmpTable.FieldByName('MinMax').AsString;
end;

procedure TStkordTmp.WriteMinMax(pValue:Str1);
begin
  oTmpTable.FieldByName('MinMax').AsString := pValue;
end;

function TStkordTmp.ReadInvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('InvDate').AsDateTime;
end;

procedure TStkordTmp.WriteInvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InvDate').AsDateTime := pValue;
end;

function TStkordTmp.ReadLastIDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LastIDate').AsDateTime;
end;

procedure TStkordTmp.WriteLastIDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastIDate').AsDateTime := pValue;
end;

function TStkordTmp.ReadLastODate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LastODate').AsDateTime;
end;

procedure TStkordTmp.WriteLastODate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LastODate').AsDateTime := pValue;
end;

function TStkordTmp.ReadLastIQnt:double;
begin
  Result := oTmpTable.FieldByName('LastIQnt').AsFloat;
end;

procedure TStkordTmp.WriteLastIQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastIQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadLastOQnt:double;
begin
  Result := oTmpTable.FieldByName('LastOQnt').AsFloat;
end;

procedure TStkordTmp.WriteLastOQnt(pValue:double);
begin
  oTmpTable.FieldByName('LastOQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadActSnQnt:longint;
begin
  Result := oTmpTable.FieldByName('ActSnQnt').AsInteger;
end;

procedure TStkordTmp.WriteActSnQnt(pValue:longint);
begin
  oTmpTable.FieldByName('ActSnQnt').AsInteger := pValue;
end;

function TStkordTmp.ReadProfit:double;
begin
  Result := oTmpTable.FieldByName('Profit').AsFloat;
end;

procedure TStkordTmp.WriteProfit(pValue:double);
begin
  oTmpTable.FieldByName('Profit').AsFloat := pValue;
end;

function TStkordTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TStkordTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TStkordTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TStkordTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStkordTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TStkordTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TStkordTmp.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DisFlag').AsInteger);
end;

procedure TStkordTmp.WriteDisFlag(pValue:boolean);
begin
  oTmpTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TStkordTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TStkordTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TStkordTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStkordTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStkordTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStkordTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStkordTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkordTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TStkordTmp.ReadMxwQnt:double;
begin
  Result := oTmpTable.FieldByName('MxwQnt').AsFloat;
end;

procedure TStkordTmp.WriteMxwQnt(pValue:double);
begin
  oTmpTable.FieldByName('MxwQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadMxwNum:longint;
begin
  Result := oTmpTable.FieldByName('MxwNum').AsInteger;
end;

procedure TStkordTmp.WriteMxwNum(pValue:longint);
begin
  oTmpTable.FieldByName('MxwNum').AsInteger := pValue;
end;

function TStkordTmp.ReadSumQnt:double;
begin
  Result := oTmpTable.FieldByName('SumQnt').AsFloat;
end;

procedure TStkordTmp.WriteSumQnt(pValue:double);
begin
  oTmpTable.FieldByName('SumQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStkordTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadCnoQnt:double;
begin
  Result := oTmpTable.FieldByName('CnoQnt').AsFloat;
end;

procedure TStkordTmp.WriteCnoQnt(pValue:double);
begin
  oTmpTable.FieldByName('CnoQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadCnmQnt:double;
begin
  Result := oTmpTable.FieldByName('CnmQnt').AsFloat;
end;

procedure TStkordTmp.WriteCnmQnt(pValue:double);
begin
  oTmpTable.FieldByName('CnmQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TStkordTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TStkordTmp.ReadImiQnt:double;
begin
  Result := oTmpTable.FieldByName('ImiQnt').AsFloat;
end;

procedure TStkordTmp.WriteImiQnt(pValue:double);
begin
  oTmpTable.FieldByName('ImiQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadASaQnt:double;
begin
  Result := oTmpTable.FieldByName('ASaQnt').AsFloat;
end;

procedure TStkordTmp.WriteASaQnt(pValue:double);
begin
  oTmpTable.FieldByName('ASaQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadAOuQnt:double;
begin
  Result := oTmpTable.FieldByName('AOuQnt').AsFloat;
end;

procedure TStkordTmp.WriteAOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('AOuQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadPSaQnt:double;
begin
  Result := oTmpTable.FieldByName('PSaQnt').AsFloat;
end;

procedure TStkordTmp.WritePSaQnt(pValue:double);
begin
  oTmpTable.FieldByName('PSaQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadPOuQnt:double;
begin
  Result := oTmpTable.FieldByName('POuQnt').AsFloat;
end;

procedure TStkordTmp.WritePOuQnt(pValue:double);
begin
  oTmpTable.FieldByName('POuQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadSsoQnt:double;
begin
  Result := oTmpTable.FieldByName('SsoQnt').AsFloat;
end;

procedure TStkordTmp.WriteSsoQnt(pValue:double);
begin
  oTmpTable.FieldByName('SsoQnt').AsFloat := pValue;
end;

function TStkordTmp.ReadImrQnt:double;
begin
  Result := oTmpTable.FieldByName('ImrQnt').AsFloat;
end;

procedure TStkordTmp.WriteImrQnt(pValue:double);
begin
  oTmpTable.FieldByName('ImrQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkordTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStkordTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStkordTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStkordTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TStkordTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TStkordTmp.LocateGaName_ (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName_);
  Result := oTmpTable.FindKey([pGaName_]);
end;

function TStkordTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TStkordTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TStkordTmp.LocateActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oTmpTable.FindKey([pActQnt]);
end;

function TStkordTmp.LocateActVal (pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result := oTmpTable.FindKey([pActVal]);
end;

function TStkordTmp.LocateMinMax (pMinMax:Str1):boolean;
begin
  SetIndex (ixMinMax);
  Result := oTmpTable.FindKey([pMinMax]);
end;

function TStkordTmp.LocateAvgPrice (pAvgPrice:double):boolean;
begin
  SetIndex (ixAvgPrice);
  Result := oTmpTable.FindKey([pAvgPrice]);
end;

function TStkordTmp.LocateLastPrice (pLastPrice:double):boolean;
begin
  SetIndex (ixLastPrice);
  Result := oTmpTable.FindKey([pLastPrice]);
end;

function TStkordTmp.LocateLastIDate (pLastIDate:TDatetime):boolean;
begin
  SetIndex (ixLastIDate);
  Result := oTmpTable.FindKey([pLastIDate]);
end;

function TStkordTmp.LocateLastODate (pLastODate:TDatetime):boolean;
begin
  SetIndex (ixLastODate);
  Result := oTmpTable.FindKey([pLastODate]);
end;

function TStkordTmp.LocateOsdQnt (pOsdQnt:double):boolean;
begin
  SetIndex (ixOsdQnt);
  Result := oTmpTable.FindKey([pOsdQnt]);
end;

procedure TStkordTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStkordTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkordTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkordTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkordTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkordTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkordTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkordTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkordTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkordTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkordTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkordTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkordTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkordTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkordTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkordTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStkordTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
