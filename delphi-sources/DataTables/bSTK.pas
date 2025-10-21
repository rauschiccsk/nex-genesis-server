unit bSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixActQnt = 'ActQnt';
  ixActVal = 'ActVal';
  ixMinMax = 'MinMax';
  ixAvgPrice = 'AvgPrice';
  ixLastPrice = 'LastPrice';
  ixLastIDate = 'LastIDate';
  ixLastODate = 'LastODate';
  ixSended = 'Sended';
  ixAction = 'Action';
  ixLinPac = 'LinPac';
  ixGaName = 'GaName';
  ixMgSc = 'MgSc';
  ixOsdCode = 'OsdCode';

type
  TStkBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str15;         procedure WriteGsName_ (pValue:Str15);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadInVal:double;          procedure WriteInVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadAvgPrice:double;       procedure WriteAvgPrice (pValue:double);
    function  ReadLastPrice:double;      procedure WriteLastPrice (pValue:double);
    function  ReadActPrice:double;       procedure WriteActPrice (pValue:double);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadOptQnt:double;         procedure WriteOptQnt (pValue:double);
    function  ReadMinMax:Str1;           procedure WriteMinMax (pValue:Str1);
    function  ReadInvDate:TDatetime;     procedure WriteInvDate (pValue:TDatetime);
    function  ReadLastIDate:TDatetime;   procedure WriteLastIDate (pValue:TDatetime);
    function  ReadLastODate:TDatetime;   procedure WriteLastODate (pValue:TDatetime);
    function  ReadLastIQnt:double;       procedure WriteLastIQnt (pValue:double);
    function  ReadLastOQnt:double;       procedure WriteLastOQnt (pValue:double);
    function  ReadActSnQnt:longint;      procedure WriteActSnQnt (pValue:longint);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadLinPac:longint;        procedure WriteLinPac (pValue:longint);
    function  ReadDefPos:Str15;          procedure WriteDefPos (pValue:Str15);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadNsuQnt:double;         procedure WriteNsuQnt (pValue:double);
    function  ReadOsrQnt:double;         procedure WriteOsrQnt (pValue:double);
    function  ReadFroQnt:double;         procedure WriteFroQnt (pValue:double);
    function  ReadASaQnt:double;         procedure WriteASaQnt (pValue:double);
    function  ReadAOuQnt:double;         procedure WriteAOuQnt (pValue:double);
    function  ReadPSaQnt:double;         procedure WritePSaQnt (pValue:double);
    function  ReadPOuQnt:double;         procedure WritePOuQnt (pValue:double);
    function  ReadImrQnt:double;         procedure WriteImrQnt (pValue:double);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadPosQnt:double;         procedure WritePosQnt (pValue:double);
    function  ReadOfrQnt:double;         procedure WriteOfrQnt (pValue:double);
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
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsName (pGsName_:Str15):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateActQnt (pActQnt:double):boolean;
    function LocateActVal (pActVal:double):boolean;
    function LocateMinMax (pMinMax:Str1):boolean;
    function LocateAvgPrice (pAvgPrice:double):boolean;
    function LocateLastPrice (pLastPrice:double):boolean;
    function LocateLastIDate (pLastIDate:TDatetime):boolean;
    function LocateLastODate (pLastODate:TDatetime):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateAction (pAction:Str1):boolean;
    function LocateLinPac (pLinPac:longint):boolean;
    function LocateGaName (pGaName_:Str60):boolean;
    function LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
    function LocateOsdCode (pOsdCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestMgCode (pMgCode:longint):boolean;
    function NearestGsName (pGsName_:Str15):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestActQnt (pActQnt:double):boolean;
    function NearestActVal (pActVal:double):boolean;
    function NearestMinMax (pMinMax:Str1):boolean;
    function NearestAvgPrice (pAvgPrice:double):boolean;
    function NearestLastPrice (pLastPrice:double):boolean;
    function NearestLastIDate (pLastIDate:TDatetime):boolean;
    function NearestLastODate (pLastODate:TDatetime):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestAction (pAction:Str1):boolean;
    function NearestLinPac (pLinPac:longint):boolean;
    function NearestGaName (pGaName_:Str60):boolean;
    function NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
    function NearestOsdCode (pOsdCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:longint);
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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str15 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property InVal:double read ReadInVal write WriteInVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property ActVal:double read ReadActVal write WriteActVal;
    property AvgPrice:double read ReadAvgPrice write WriteAvgPrice;
    property LastPrice:double read ReadLastPrice write WriteLastPrice;
    property ActPrice:double read ReadActPrice write WriteActPrice;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property OptQnt:double read ReadOptQnt write WriteOptQnt;
    property MinMax:Str1 read ReadMinMax write WriteMinMax;
    property InvDate:TDatetime read ReadInvDate write WriteInvDate;
    property LastIDate:TDatetime read ReadLastIDate write WriteLastIDate;
    property LastODate:TDatetime read ReadLastODate write WriteLastODate;
    property LastIQnt:double read ReadLastIQnt write WriteLastIQnt;
    property LastOQnt:double read ReadLastOQnt write WriteLastOQnt;
    property ActSnQnt:longint read ReadActSnQnt write WriteActSnQnt;
    property Profit:double read ReadProfit write WriteProfit;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property Sended:boolean read ReadSended write WriteSended;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Action:Str1 read ReadAction write WriteAction;
    property LinPac:longint read ReadLinPac write WriteLinPac;
    property DefPos:Str15 read ReadDefPos write WriteDefPos;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property NsuQnt:double read ReadNsuQnt write WriteNsuQnt;
    property OsrQnt:double read ReadOsrQnt write WriteOsrQnt;
    property FroQnt:double read ReadFroQnt write WriteFroQnt;
    property ASaQnt:double read ReadASaQnt write WriteASaQnt;
    property AOuQnt:double read ReadAOuQnt write WriteAOuQnt;
    property PSaQnt:double read ReadPSaQnt write WritePSaQnt;
    property POuQnt:double read ReadPOuQnt write WritePOuQnt;
    property ImrQnt:double read ReadImrQnt write WriteImrQnt;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property PosQnt:double read ReadPosQnt write WritePosQnt;
    property OfrQnt:double read ReadOfrQnt write WriteOfrQnt;
  end;

implementation

constructor TStkBtr.Create;
begin
  oBtrTable := BtrInit ('STK',gPath.StkPath,Self);
end;

constructor TStkBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STK',pPath,Self);
end;

destructor TStkBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStkBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStkBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStkBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStkBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStkBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TStkBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TStkBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TStkBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TStkBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TStkBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TStkBtr.ReadGsName_:Str15;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TStkBtr.WriteGsName_(pValue:Str15);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TStkBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TStkBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TStkBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TStkBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TStkBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TStkBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TStkBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TStkBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TStkBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TStkBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TStkBtr.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DrbMust').AsInteger);
end;

procedure TStkBtr.WriteDrbMust(pValue:boolean);
begin
  oBtrTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TStkBtr.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('PdnMust').AsInteger);
end;

procedure TStkBtr.WritePdnMust(pValue:boolean);
begin
  oBtrTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TStkBtr.ReadGrcMth:word;
begin
  Result := oBtrTable.FieldByName('GrcMth').AsInteger;
end;

procedure TStkBtr.WriteGrcMth(pValue:word);
begin
  oBtrTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TStkBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TStkBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TStkBtr.ReadInQnt:double;
begin
  Result := oBtrTable.FieldByName('InQnt').AsFloat;
end;

procedure TStkBtr.WriteInQnt(pValue:double);
begin
  oBtrTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TStkBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TStkBtr.ReadActQnt:double;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStkBtr.WriteActQnt(pValue:double);
begin
  oBtrTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TStkBtr.ReadSalQnt:double;
begin
  Result := oBtrTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStkBtr.WriteSalQnt(pValue:double);
begin
  oBtrTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStkBtr.ReadNrsQnt:double;
begin
  Result := oBtrTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStkBtr.WriteNrsQnt(pValue:double);
begin
  oBtrTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOcdQnt:double;
begin
  Result := oBtrTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TStkBtr.WriteOcdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TStkBtr.ReadFreQnt:double;
begin
  Result := oBtrTable.FieldByName('FreQnt').AsFloat;
end;

procedure TStkBtr.WriteFreQnt(pValue:double);
begin
  oBtrTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOsdQnt:double;
begin
  Result := oBtrTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TStkBtr.WriteOsdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TStkBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TStkBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TStkBtr.ReadInVal:double;
begin
  Result := oBtrTable.FieldByName('InVal').AsFloat;
end;

procedure TStkBtr.WriteInVal(pValue:double);
begin
  oBtrTable.FieldByName('InVal').AsFloat := pValue;
end;

function TStkBtr.ReadOutVal:double;
begin
  Result := oBtrTable.FieldByName('OutVal').AsFloat;
end;

procedure TStkBtr.WriteOutVal(pValue:double);
begin
  oBtrTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TStkBtr.ReadActVal:double;
begin
  Result := oBtrTable.FieldByName('ActVal').AsFloat;
end;

procedure TStkBtr.WriteActVal(pValue:double);
begin
  oBtrTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TStkBtr.ReadAvgPrice:double;
begin
  Result := oBtrTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TStkBtr.WriteAvgPrice(pValue:double);
begin
  oBtrTable.FieldByName('AvgPrice').AsFloat := pValue;
end;

function TStkBtr.ReadLastPrice:double;
begin
  Result := oBtrTable.FieldByName('LastPrice').AsFloat;
end;

procedure TStkBtr.WriteLastPrice(pValue:double);
begin
  oBtrTable.FieldByName('LastPrice').AsFloat := pValue;
end;

function TStkBtr.ReadActPrice:double;
begin
  Result := oBtrTable.FieldByName('ActPrice').AsFloat;
end;

procedure TStkBtr.WriteActPrice(pValue:double);
begin
  oBtrTable.FieldByName('ActPrice').AsFloat := pValue;
end;

function TStkBtr.ReadMaxQnt:double;
begin
  Result := oBtrTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TStkBtr.WriteMaxQnt(pValue:double);
begin
  oBtrTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TStkBtr.ReadMinQnt:double;
begin
  Result := oBtrTable.FieldByName('MinQnt').AsFloat;
end;

procedure TStkBtr.WriteMinQnt(pValue:double);
begin
  oBtrTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOptQnt:double;
begin
  Result := oBtrTable.FieldByName('OptQnt').AsFloat;
end;

procedure TStkBtr.WriteOptQnt(pValue:double);
begin
  oBtrTable.FieldByName('OptQnt').AsFloat := pValue;
end;

function TStkBtr.ReadMinMax:Str1;
begin
  Result := oBtrTable.FieldByName('MinMax').AsString;
end;

procedure TStkBtr.WriteMinMax(pValue:Str1);
begin
  oBtrTable.FieldByName('MinMax').AsString := pValue;
end;

function TStkBtr.ReadInvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('InvDate').AsDateTime;
end;

procedure TStkBtr.WriteInvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('InvDate').AsDateTime := pValue;
end;

function TStkBtr.ReadLastIDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('LastIDate').AsDateTime;
end;

procedure TStkBtr.WriteLastIDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LastIDate').AsDateTime := pValue;
end;

function TStkBtr.ReadLastODate:TDatetime;
begin
  Result := oBtrTable.FieldByName('LastODate').AsDateTime;
end;

procedure TStkBtr.WriteLastODate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LastODate').AsDateTime := pValue;
end;

function TStkBtr.ReadLastIQnt:double;
begin
  Result := oBtrTable.FieldByName('LastIQnt').AsFloat;
end;

procedure TStkBtr.WriteLastIQnt(pValue:double);
begin
  oBtrTable.FieldByName('LastIQnt').AsFloat := pValue;
end;

function TStkBtr.ReadLastOQnt:double;
begin
  Result := oBtrTable.FieldByName('LastOQnt').AsFloat;
end;

procedure TStkBtr.WriteLastOQnt(pValue:double);
begin
  oBtrTable.FieldByName('LastOQnt').AsFloat := pValue;
end;

function TStkBtr.ReadActSnQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActSnQnt').AsInteger;
end;

procedure TStkBtr.WriteActSnQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActSnQnt').AsInteger := pValue;
end;

function TStkBtr.ReadProfit:double;
begin
  Result := oBtrTable.FieldByName('Profit').AsFloat;
end;

procedure TStkBtr.WriteProfit(pValue:double);
begin
  oBtrTable.FieldByName('Profit').AsFloat := pValue;
end;

function TStkBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TStkBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TStkBtr.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DisFlag').AsInteger);
end;

procedure TStkBtr.WriteDisFlag(pValue:boolean);
begin
  oBtrTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TStkBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TStkBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStkBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStkBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStkBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStkBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStkBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStkBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStkBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TStkBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TStkBtr.ReadLinPac:longint;
begin
  Result := oBtrTable.FieldByName('LinPac').AsInteger;
end;

procedure TStkBtr.WriteLinPac(pValue:longint);
begin
  oBtrTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TStkBtr.ReadDefPos:Str15;
begin
  Result := oBtrTable.FieldByName('DefPos').AsString;
end;

procedure TStkBtr.WriteDefPos(pValue:Str15);
begin
  oBtrTable.FieldByName('DefPos').AsString := pValue;
end;

function TStkBtr.ReadGaName:Str60;
begin
  Result := oBtrTable.FieldByName('GaName').AsString;
end;

procedure TStkBtr.WriteGaName(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName').AsString := pValue;
end;

function TStkBtr.ReadGaName_:Str60;
begin
  Result := oBtrTable.FieldByName('GaName_').AsString;
end;

procedure TStkBtr.WriteGaName_(pValue:Str60);
begin
  oBtrTable.FieldByName('GaName_').AsString := pValue;
end;

function TStkBtr.ReadNsuQnt:double;
begin
  Result := oBtrTable.FieldByName('NsuQnt').AsFloat;
end;

procedure TStkBtr.WriteNsuQnt(pValue:double);
begin
  oBtrTable.FieldByName('NsuQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOsrQnt:double;
begin
  Result := oBtrTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TStkBtr.WriteOsrQnt(pValue:double);
begin
  oBtrTable.FieldByName('OsrQnt').AsFloat := pValue;
end;

function TStkBtr.ReadFroQnt:double;
begin
  Result := oBtrTable.FieldByName('FroQnt').AsFloat;
end;

procedure TStkBtr.WriteFroQnt(pValue:double);
begin
  oBtrTable.FieldByName('FroQnt').AsFloat := pValue;
end;

function TStkBtr.ReadASaQnt:double;
begin
  Result := oBtrTable.FieldByName('ASaQnt').AsFloat;
end;

procedure TStkBtr.WriteASaQnt(pValue:double);
begin
  oBtrTable.FieldByName('ASaQnt').AsFloat := pValue;
end;

function TStkBtr.ReadAOuQnt:double;
begin
  Result := oBtrTable.FieldByName('AOuQnt').AsFloat;
end;

procedure TStkBtr.WriteAOuQnt(pValue:double);
begin
  oBtrTable.FieldByName('AOuQnt').AsFloat := pValue;
end;

function TStkBtr.ReadPSaQnt:double;
begin
  Result := oBtrTable.FieldByName('PSaQnt').AsFloat;
end;

procedure TStkBtr.WritePSaQnt(pValue:double);
begin
  oBtrTable.FieldByName('PSaQnt').AsFloat := pValue;
end;

function TStkBtr.ReadPOuQnt:double;
begin
  Result := oBtrTable.FieldByName('POuQnt').AsFloat;
end;

procedure TStkBtr.WritePOuQnt(pValue:double);
begin
  oBtrTable.FieldByName('POuQnt').AsFloat := pValue;
end;

function TStkBtr.ReadImrQnt:double;
begin
  Result := oBtrTable.FieldByName('ImrQnt').AsFloat;
end;

procedure TStkBtr.WriteImrQnt(pValue:double);
begin
  oBtrTable.FieldByName('ImrQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOsdCode:Str15;
begin
  Result := oBtrTable.FieldByName('OsdCode').AsString;
end;

procedure TStkBtr.WriteOsdCode(pValue:Str15);
begin
  oBtrTable.FieldByName('OsdCode').AsString := pValue;
end;

function TStkBtr.ReadPosQnt:double;
begin
  Result := oBtrTable.FieldByName('PosQnt').AsFloat;
end;

procedure TStkBtr.WritePosQnt(pValue:double);
begin
  oBtrTable.FieldByName('PosQnt').AsFloat := pValue;
end;

function TStkBtr.ReadOfrQnt:double;
begin
  Result := oBtrTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TStkBtr.WriteOfrQnt(pValue:double);
begin
  oBtrTable.FieldByName('OfrQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStkBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStkBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStkBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStkBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStkBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStkBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStkBtr.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TStkBtr.LocateGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TStkBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TStkBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TStkBtr.LocateActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindKey([pActQnt]);
end;

function TStkBtr.LocateActVal (pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result := oBtrTable.FindKey([pActVal]);
end;

function TStkBtr.LocateMinMax (pMinMax:Str1):boolean;
begin
  SetIndex (ixMinMax);
  Result := oBtrTable.FindKey([pMinMax]);
end;

function TStkBtr.LocateAvgPrice (pAvgPrice:double):boolean;
begin
  SetIndex (ixAvgPrice);
  Result := oBtrTable.FindKey([pAvgPrice]);
end;

function TStkBtr.LocateLastPrice (pLastPrice:double):boolean;
begin
  SetIndex (ixLastPrice);
  Result := oBtrTable.FindKey([pLastPrice]);
end;

function TStkBtr.LocateLastIDate (pLastIDate:TDatetime):boolean;
begin
  SetIndex (ixLastIDate);
  Result := oBtrTable.FindKey([pLastIDate]);
end;

function TStkBtr.LocateLastODate (pLastODate:TDatetime):boolean;
begin
  SetIndex (ixLastODate);
  Result := oBtrTable.FindKey([pLastODate]);
end;

function TStkBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TStkBtr.LocateAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindKey([pAction]);
end;

function TStkBtr.LocateLinPac (pLinPac:longint):boolean;
begin
  SetIndex (ixLinPac);
  Result := oBtrTable.FindKey([pLinPac]);
end;

function TStkBtr.LocateGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindKey([StrToAlias(pGaName_)]);
end;

function TStkBtr.LocateMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindKey([pMgCode,pStkCode]);
end;

function TStkBtr.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindKey([pOsdCode]);
end;

function TStkBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStkBtr.NearestMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TStkBtr.NearestGsName (pGsName_:Str15):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TStkBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TStkBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TStkBtr.NearestActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindNearest([pActQnt]);
end;

function TStkBtr.NearestActVal (pActVal:double):boolean;
begin
  SetIndex (ixActVal);
  Result := oBtrTable.FindNearest([pActVal]);
end;

function TStkBtr.NearestMinMax (pMinMax:Str1):boolean;
begin
  SetIndex (ixMinMax);
  Result := oBtrTable.FindNearest([pMinMax]);
end;

function TStkBtr.NearestAvgPrice (pAvgPrice:double):boolean;
begin
  SetIndex (ixAvgPrice);
  Result := oBtrTable.FindNearest([pAvgPrice]);
end;

function TStkBtr.NearestLastPrice (pLastPrice:double):boolean;
begin
  SetIndex (ixLastPrice);
  Result := oBtrTable.FindNearest([pLastPrice]);
end;

function TStkBtr.NearestLastIDate (pLastIDate:TDatetime):boolean;
begin
  SetIndex (ixLastIDate);
  Result := oBtrTable.FindNearest([pLastIDate]);
end;

function TStkBtr.NearestLastODate (pLastODate:TDatetime):boolean;
begin
  SetIndex (ixLastODate);
  Result := oBtrTable.FindNearest([pLastODate]);
end;

function TStkBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TStkBtr.NearestAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oBtrTable.FindNearest([pAction]);
end;

function TStkBtr.NearestLinPac (pLinPac:longint):boolean;
begin
  SetIndex (ixLinPac);
  Result := oBtrTable.FindNearest([pLinPac]);
end;

function TStkBtr.NearestGaName (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName);
  Result := oBtrTable.FindNearest([pGaName_]);
end;

function TStkBtr.NearestMgSc (pMgCode:longint;pStkCode:Str15):boolean;
begin
  SetIndex (ixMgSc);
  Result := oBtrTable.FindNearest([pMgCode,pStkCode]);
end;

function TStkBtr.NearestOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oBtrTable.FindNearest([pOsdCode]);
end;

procedure TStkBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStkBtr.Open(pStkNum:longint);
begin
  oBtrTable.Open(pStkNum);
  oBtrTable.Open;
end;

procedure TStkBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStkBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStkBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStkBtr.First;
begin
  oBtrTable.First;
end;

procedure TStkBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStkBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStkBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStkBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStkBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStkBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStkBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStkBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStkBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStkBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStkBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
