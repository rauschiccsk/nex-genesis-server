unit bRMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixScStSn = 'ScStSn';
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixTgStkNum = 'TgStkNum';
  ixEValue = 'EValue';
  ixBValue = 'BValue';
  ixCValue = 'CValue';
  ixAValue = 'AValue';
  ixOcdNum = 'OcdNum';
  ixDescribe = 'Describe';
  ixSended = 'Sended';
  ixRbaCode = 'RbaCode';

type
  TRmhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadScStkNum:word;         procedure WriteScStkNum (pValue:word);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadTgStkNum:word;         procedure WriteTgStkNum (pValue:word);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  Readx_SItemQnt:word;       procedure Writex_SItemQnt (pValue:word);
    function  Readx_NItemQnt:byte;       procedure Writex_NItemQnt (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadVatPrc1:double;        procedure WriteVatPrc1 (pValue:double);
    function  ReadVatPrc2:double;        procedure WriteVatPrc2 (pValue:double);
    function  ReadVatPrc3:double;        procedure WriteVatPrc3 (pValue:double);
    function  ReadCValue1:double;        procedure WriteCValue1 (pValue:double);
    function  ReadCValue2:double;        procedure WriteCValue2 (pValue:double);
    function  ReadCValue3:double;        procedure WriteCValue3 (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadEValue1:double;        procedure WriteEValue1 (pValue:double);
    function  ReadEValue2:double;        procedure WriteEValue2 (pValue:double);
    function  ReadEValue3:double;        procedure WriteEValue3 (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadVatPrc4:double;        procedure WriteVatPrc4 (pValue:double);
    function  ReadVatPrc5:double;        procedure WriteVatPrc5 (pValue:double);
    function  ReadCValue4:double;        procedure WriteCValue4 (pValue:double);
    function  ReadCValue5:double;        procedure WriteCValue5 (pValue:double);
    function  ReadEValue4:double;        procedure WriteEValue4 (pValue:double);
    function  ReadEValue5:double;        procedure WriteEValue5 (pValue:double);
    function  Readx_PBVal1:double;       procedure Writex_PBVal1 (pValue:double);
    function  Readx_PBVal2:double;       procedure Writex_PBVal2 (pValue:double);
    function  Readx_PBVal3:double;       procedure Writex_PBVal3 (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  Readx_PVatVal0:double;     procedure Writex_PVatVal0 (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  Readx_Status1:Str1;        procedure Writex_Status1 (pValue:Str1);
    function  Readx_Status2:Str1;        procedure Writex_Status2 (pValue:Str1);
    function  Readx_Status3:Str1;        procedure Writex_Status3 (pValue:Str1);
    function  Readx_Status4:Str1;        procedure Writex_Status4 (pValue:Str1);
    function  Readx_Status5:Str1;        procedure Writex_Status5 (pValue:Str1);
    function  Readx_Status6:Str1;        procedure Writex_Status6 (pValue:Str1);
    function  Readx_Status7:Str1;        procedure Writex_Status7 (pValue:Str1);
    function  Readx_Status8:Str1;        procedure Writex_Status8 (pValue:Str1);
    function  Readx_Status9:Str1;        procedure Writex_Status9 (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  Readx_LdgName:Str8;        procedure Writex_LdgName (pValue:Str8);
    function  Readx_LdgDate:TDatetime;   procedure Writex_LdgDate (pValue:TDatetime);
    function  Readx_LdgTime:TDatetime;   procedure Writex_LdgTime (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdNum:Str20;          procedure WriteOcdNum (pValue:Str20);
    function  Readx_ActPos:longint;      procedure Writex_ActPos (pValue:longint);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadSrdNum:Str12;          procedure WriteSrdNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
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
    function LocateScStSn (pScStkNum:word;pSerNum:longint):boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateTgStkNum (pTgStkNum:word):boolean;
    function LocateEValue (pEValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateOcdNum (pOcdNum:Str20):boolean;
    function LocateDescribe (pDescribe:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestScStSn (pScStkNum:word;pSerNum:longint):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestTgStkNum (pTgStkNum:word):boolean;
    function NearestEValue (pEValue:double):boolean;
    function NearestBValue (pBValue:double):boolean;
    function NearestCValue (pCValue:double):boolean;
    function NearestAValue (pAValue:double):boolean;
    function NearestOcdNum (pOcdNum:Str20):boolean;
    function NearestDescribe (pDescribe:Str30):boolean;
    function NearestSended (pSended:byte):boolean;
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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property TgStkNum:word read ReadTgStkNum write WriteTgStkNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property x_SItemQnt:word read Readx_SItemQnt write Writex_SItemQnt;
    property x_NItemQnt:byte read Readx_NItemQnt write Writex_NItemQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property VatPrc1:double read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:double read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:double read ReadVatPrc3 write WriteVatPrc3;
    property CValue1:double read ReadCValue1 write WriteCValue1;
    property CValue2:double read ReadCValue2 write WriteCValue2;
    property CValue3:double read ReadCValue3 write WriteCValue3;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property EValue1:double read ReadEValue1 write WriteEValue1;
    property EValue2:double read ReadEValue2 write WriteEValue2;
    property EValue3:double read ReadEValue3 write WriteEValue3;
    property CValue:double read ReadCValue write WriteCValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property EValue:double read ReadEValue write WriteEValue;
    property VatPrc4:double read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:double read ReadVatPrc5 write WriteVatPrc5;
    property CValue4:double read ReadCValue4 write WriteCValue4;
    property CValue5:double read ReadCValue5 write WriteCValue5;
    property EValue4:double read ReadEValue4 write WriteEValue4;
    property EValue5:double read ReadEValue5 write WriteEValue5;
    property x_PBVal1:double read Readx_PBVal1 write Writex_PBVal1;
    property x_PBVal2:double read Readx_PBVal2 write Writex_PBVal2;
    property x_PBVal3:double read Readx_PBVal3 write Writex_PBVal3;
    property AValue:double read ReadAValue write WriteAValue;
    property x_PVatVal0:double read Readx_PVatVal0 write Writex_PVatVal0;
    property BValue:double read ReadBValue write WriteBValue;
    property x_Status1:Str1 read Readx_Status1 write Writex_Status1;
    property x_Status2:Str1 read Readx_Status2 write Writex_Status2;
    property x_Status3:Str1 read Readx_Status3 write Writex_Status3;
    property x_Status4:Str1 read Readx_Status4 write Writex_Status4;
    property x_Status5:Str1 read Readx_Status5 write Writex_Status5;
    property x_Status6:Str1 read Readx_Status6 write Writex_Status6;
    property x_Status7:Str1 read Readx_Status7 write Writex_Status7;
    property x_Status8:Str1 read Readx_Status8 write Writex_Status8;
    property x_Status9:Str1 read Readx_Status9 write Writex_Status9;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property Sended:boolean read ReadSended write WriteSended;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property x_LdgName:Str8 read Readx_LdgName write Writex_LdgName;
    property x_LdgDate:TDatetime read Readx_LdgDate write Writex_LdgDate;
    property x_LdgTime:TDatetime read Readx_LdgTime write Writex_LdgTime;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdNum:Str20 read ReadOcdNum write WriteOcdNum;
    property x_ActPos:longint read Readx_ActPos write Writex_ActPos;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property SrdNum:Str12 read ReadSrdNum write WriteSrdNum;
    property Year:Str2 read ReadYear write WriteYear;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TRmhBtr.Create;
begin
  oBtrTable := BtrInit ('RMH',gPath.StkPath,Self);
end;

constructor TRmhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RMH',pPath,Self);
end;

destructor TRmhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRmhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRmhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRmhBtr.ReadScStkNum:word;
begin
  Result := oBtrTable.FieldByName('ScStkNum').AsInteger;
end;

procedure TRmhBtr.WriteScStkNum(pValue:word);
begin
  oBtrTable.FieldByName('ScStkNum').AsInteger := pValue;
end;

function TRmhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TRmhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TRmhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRmhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRmhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRmhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRmhBtr.ReadTgStkNum:word;
begin
  Result := oBtrTable.FieldByName('TgStkNum').AsInteger;
end;

procedure TRmhBtr.WriteTgStkNum(pValue:word);
begin
  oBtrTable.FieldByName('TgStkNum').AsInteger := pValue;
end;

function TRmhBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TRmhBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TRmhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TRmhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TRmhBtr.Readx_SItemQnt:word;
begin
  Result := oBtrTable.FieldByName('x_SItemQnt').AsInteger;
end;

procedure TRmhBtr.Writex_SItemQnt(pValue:word);
begin
  oBtrTable.FieldByName('x_SItemQnt').AsInteger := pValue;
end;

function TRmhBtr.Readx_NItemQnt:byte;
begin
  Result := oBtrTable.FieldByName('x_NItemQnt').AsInteger;
end;

procedure TRmhBtr.Writex_NItemQnt(pValue:byte);
begin
  oBtrTable.FieldByName('x_NItemQnt').AsInteger := pValue;
end;

function TRmhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TRmhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TRmhBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TRmhBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TRmhBtr.ReadVatPrc1:double;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TRmhBtr.WriteVatPrc1(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TRmhBtr.ReadVatPrc2:double;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TRmhBtr.WriteVatPrc2(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TRmhBtr.ReadVatPrc3:double;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TRmhBtr.WriteVatPrc3(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue1:double;
begin
  Result := oBtrTable.FieldByName('CValue1').AsFloat;
end;

procedure TRmhBtr.WriteCValue1(pValue:double);
begin
  oBtrTable.FieldByName('CValue1').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue2:double;
begin
  Result := oBtrTable.FieldByName('CValue2').AsFloat;
end;

procedure TRmhBtr.WriteCValue2(pValue:double);
begin
  oBtrTable.FieldByName('CValue2').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue3:double;
begin
  Result := oBtrTable.FieldByName('CValue3').AsFloat;
end;

procedure TRmhBtr.WriteCValue3(pValue:double);
begin
  oBtrTable.FieldByName('CValue3').AsFloat := pValue;
end;

function TRmhBtr.ReadVatVal1:double;
begin
  Result := oBtrTable.FieldByName('VatVal1').AsFloat;
end;

procedure TRmhBtr.WriteVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TRmhBtr.ReadVatVal2:double;
begin
  Result := oBtrTable.FieldByName('VatVal2').AsFloat;
end;

procedure TRmhBtr.WriteVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TRmhBtr.ReadVatVal3:double;
begin
  Result := oBtrTable.FieldByName('VatVal3').AsFloat;
end;

procedure TRmhBtr.WriteVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue1:double;
begin
  Result := oBtrTable.FieldByName('EValue1').AsFloat;
end;

procedure TRmhBtr.WriteEValue1(pValue:double);
begin
  oBtrTable.FieldByName('EValue1').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue2:double;
begin
  Result := oBtrTable.FieldByName('EValue2').AsFloat;
end;

procedure TRmhBtr.WriteEValue2(pValue:double);
begin
  oBtrTable.FieldByName('EValue2').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue3:double;
begin
  Result := oBtrTable.FieldByName('EValue3').AsFloat;
end;

procedure TRmhBtr.WriteEValue3(pValue:double);
begin
  oBtrTable.FieldByName('EValue3').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TRmhBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRmhBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TRmhBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TRmhBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TRmhBtr.ReadVatPrc4:double;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TRmhBtr.WriteVatPrc4(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TRmhBtr.ReadVatPrc5:double;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TRmhBtr.WriteVatPrc5(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue4:double;
begin
  Result := oBtrTable.FieldByName('CValue4').AsFloat;
end;

procedure TRmhBtr.WriteCValue4(pValue:double);
begin
  oBtrTable.FieldByName('CValue4').AsFloat := pValue;
end;

function TRmhBtr.ReadCValue5:double;
begin
  Result := oBtrTable.FieldByName('CValue5').AsFloat;
end;

procedure TRmhBtr.WriteCValue5(pValue:double);
begin
  oBtrTable.FieldByName('CValue5').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue4:double;
begin
  Result := oBtrTable.FieldByName('EValue4').AsFloat;
end;

procedure TRmhBtr.WriteEValue4(pValue:double);
begin
  oBtrTable.FieldByName('EValue4').AsFloat := pValue;
end;

function TRmhBtr.ReadEValue5:double;
begin
  Result := oBtrTable.FieldByName('EValue5').AsFloat;
end;

procedure TRmhBtr.WriteEValue5(pValue:double);
begin
  oBtrTable.FieldByName('EValue5').AsFloat := pValue;
end;

function TRmhBtr.Readx_PBVal1:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal1').AsFloat;
end;

procedure TRmhBtr.Writex_PBVal1(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal1').AsFloat := pValue;
end;

function TRmhBtr.Readx_PBVal2:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal2').AsFloat;
end;

procedure TRmhBtr.Writex_PBVal2(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal2').AsFloat := pValue;
end;

function TRmhBtr.Readx_PBVal3:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal3').AsFloat;
end;

procedure TRmhBtr.Writex_PBVal3(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal3').AsFloat := pValue;
end;

function TRmhBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TRmhBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRmhBtr.Readx_PVatVal0:double;
begin
  Result := oBtrTable.FieldByName('x_PVatVal0').AsFloat;
end;

procedure TRmhBtr.Writex_PVatVal0(pValue:double);
begin
  oBtrTable.FieldByName('x_PVatVal0').AsFloat := pValue;
end;

function TRmhBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TRmhBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRmhBtr.Readx_Status1:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status1').AsString;
end;

procedure TRmhBtr.Writex_Status1(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status1').AsString := pValue;
end;

function TRmhBtr.Readx_Status2:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status2').AsString;
end;

procedure TRmhBtr.Writex_Status2(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status2').AsString := pValue;
end;

function TRmhBtr.Readx_Status3:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status3').AsString;
end;

procedure TRmhBtr.Writex_Status3(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status3').AsString := pValue;
end;

function TRmhBtr.Readx_Status4:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status4').AsString;
end;

procedure TRmhBtr.Writex_Status4(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status4').AsString := pValue;
end;

function TRmhBtr.Readx_Status5:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status5').AsString;
end;

procedure TRmhBtr.Writex_Status5(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status5').AsString := pValue;
end;

function TRmhBtr.Readx_Status6:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status6').AsString;
end;

procedure TRmhBtr.Writex_Status6(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status6').AsString := pValue;
end;

function TRmhBtr.Readx_Status7:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status7').AsString;
end;

procedure TRmhBtr.Writex_Status7(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status7').AsString := pValue;
end;

function TRmhBtr.Readx_Status8:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status8').AsString;
end;

procedure TRmhBtr.Writex_Status8(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status8').AsString := pValue;
end;

function TRmhBtr.Readx_Status9:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status9').AsString;
end;

procedure TRmhBtr.Writex_Status9(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status9').AsString := pValue;
end;

function TRmhBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TRmhBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TRmhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TRmhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TRmhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TRmhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TRmhBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TRmhBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TRmhBtr.Readx_LdgName:Str8;
begin
  Result := oBtrTable.FieldByName('x_LdgName').AsString;
end;

procedure TRmhBtr.Writex_LdgName(pValue:Str8);
begin
  oBtrTable.FieldByName('x_LdgName').AsString := pValue;
end;

function TRmhBtr.Readx_LdgDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_LdgDate').AsDateTime;
end;

procedure TRmhBtr.Writex_LdgDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_LdgDate').AsDateTime := pValue;
end;

function TRmhBtr.Readx_LdgTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_LdgTime').AsDateTime;
end;

procedure TRmhBtr.Writex_LdgTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_LdgTime').AsDateTime := pValue;
end;

function TRmhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRmhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRmhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRmhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRmhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRmhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRmhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRmhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRmhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRmhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRmhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRmhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRmhBtr.ReadOcdNum:Str20;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TRmhBtr.WriteOcdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TRmhBtr.Readx_ActPos:longint;
begin
  Result := oBtrTable.FieldByName('x_ActPos').AsInteger;
end;

procedure TRmhBtr.Writex_ActPos(pValue:longint);
begin
  oBtrTable.FieldByName('x_ActPos').AsInteger := pValue;
end;

function TRmhBtr.ReadScSmCode:word;
begin
  Result := oBtrTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TRmhBtr.WriteScSmCode(pValue:word);
begin
  oBtrTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TRmhBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TRmhBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TRmhBtr.ReadTgSmCode:word;
begin
  Result := oBtrTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TRmhBtr.WriteTgSmCode(pValue:word);
begin
  oBtrTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TRmhBtr.ReadSrdNum:Str12;
begin
  Result := oBtrTable.FieldByName('SrdNum').AsString;
end;

procedure TRmhBtr.WriteSrdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('SrdNum').AsString := pValue;
end;

function TRmhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TRmhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TRmhBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TRmhBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TRmhBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TRmhBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRmhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRmhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRmhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRmhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRmhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRmhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRmhBtr.LocateScStSn (pScStkNum:word;pSerNum:longint):boolean;
begin
  SetIndex (ixScStSn);
  Result := oBtrTable.FindKey([pScStkNum,pSerNum]);
end;

function TRmhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TRmhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRmhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TRmhBtr.LocateTgStkNum (pTgStkNum:word):boolean;
begin
  SetIndex (ixTgStkNum);
  Result := oBtrTable.FindKey([pTgStkNum]);
end;

function TRmhBtr.LocateEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oBtrTable.FindKey([pEValue]);
end;

function TRmhBtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TRmhBtr.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindKey([pCValue]);
end;

function TRmhBtr.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindKey([pAValue]);
end;

function TRmhBtr.LocateOcdNum (pOcdNum:Str20):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TRmhBtr.LocateDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([pDescribe]);
end;

function TRmhBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TRmhBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TRmhBtr.NearestScStSn (pScStkNum:word;pSerNum:longint):boolean;
begin
  SetIndex (ixScStSn);
  Result := oBtrTable.FindNearest([pScStkNum,pSerNum]);
end;

function TRmhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TRmhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TRmhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TRmhBtr.NearestTgStkNum (pTgStkNum:word):boolean;
begin
  SetIndex (ixTgStkNum);
  Result := oBtrTable.FindNearest([pTgStkNum]);
end;

function TRmhBtr.NearestEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oBtrTable.FindNearest([pEValue]);
end;

function TRmhBtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TRmhBtr.NearestCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindNearest([pCValue]);
end;

function TRmhBtr.NearestAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindNearest([pAValue]);
end;

function TRmhBtr.NearestOcdNum (pOcdNum:Str20):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TRmhBtr.NearestDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe]);
end;

function TRmhBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TRmhBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TRmhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRmhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TRmhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRmhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRmhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRmhBtr.First;
begin
  oBtrTable.First;
end;

procedure TRmhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRmhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRmhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRmhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRmhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRmhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRmhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRmhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRmhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRmhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRmhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
