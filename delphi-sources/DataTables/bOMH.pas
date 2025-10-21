unit bOMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixEValue = 'EValue';
  ixBValue = 'BValue';
  ixCValue = 'CValue';
  ixAValue = 'AValue';
  ixImdNum = 'ImdNum';
  ixDescribe = 'Describe';
  ixOcdNum = 'OcdNum';
  ixSended = 'Sended';
  ixRbaCode = 'RbaCode';

type
  TOmhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadSmName:Str17;          procedure WriteSmName (pValue:Str17);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
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
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadImdSnd:Str1;           procedure WriteImdSnd (pValue:Str1);
    function  Readx_Status2:Str1;        procedure Writex_Status2 (pValue:Str1);
    function  Readx_Status3:Str1;        procedure Writex_Status3 (pValue:Str1);
    function  Readx_Status4:Str1;        procedure Writex_Status4 (pValue:Str1);
    function  Readx_Status5:Str1;        procedure Writex_Status5 (pValue:Str1);
    function  Readx_Status6:Str1;        procedure Writex_Status6 (pValue:Str1);
    function  Readx_Status7:Str1;        procedure Writex_Status7 (pValue:Str1);
    function  Readx_Status8:Str1;        procedure Writex_Status8 (pValue:Str1);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadAccUser:Str8;          procedure WriteAccUser (pValue:Str8);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  Readx_LdgTime:TDatetime;   procedure Writex_LdgTime (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  Readx_ImpName:Str8;        procedure Writex_ImpName (pValue:Str8);
    function  Readx_ImpDate:TDatetime;   procedure Writex_ImpDate (pValue:TDatetime);
    function  Readx_ImpTime:TDatetime;   procedure Writex_ImpTime (pValue:TDatetime);
    function  Readx_SItemQnt:byte;       procedure Writex_SItemQnt (pValue:byte);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadImdNum:Str20;          procedure WriteImdNum (pValue:Str20);
    function  ReadTrgStk:longint;        procedure WriteTrgStk (pValue:longint);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
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
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateEValue (pEValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateImdNum (pImdNum:Str20):boolean;
    function LocateDescribe (pDescribe:Str30):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestSmCode (pSmCode:word):boolean;
    function NearestEValue (pEValue:double):boolean;
    function NearestBValue (pBValue:double):boolean;
    function NearestCValue (pCValue:double):boolean;
    function NearestAValue (pAValue:double):boolean;
    function NearestImdNum (pImdNum:Str20):boolean;
    function NearestDescribe (pDescribe:Str30):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;
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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property SmName:Str17 read ReadSmName write WriteSmName;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
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
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property ImdSnd:Str1 read ReadImdSnd write WriteImdSnd;
    property x_Status2:Str1 read Readx_Status2 write Writex_Status2;
    property x_Status3:Str1 read Readx_Status3 write Writex_Status3;
    property x_Status4:Str1 read Readx_Status4 write Writex_Status4;
    property x_Status5:Str1 read Readx_Status5 write Writex_Status5;
    property x_Status6:Str1 read Readx_Status6 write Writex_Status6;
    property x_Status7:Str1 read Readx_Status7 write Writex_Status7;
    property x_Status8:Str1 read Readx_Status8 write Writex_Status8;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property ConStk:word read ReadConStk write WriteConStk;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property AccUser:Str8 read ReadAccUser write WriteAccUser;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property x_LdgTime:TDatetime read Readx_LdgTime write Writex_LdgTime;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property x_ImpName:Str8 read Readx_ImpName write Writex_ImpName;
    property x_ImpDate:TDatetime read Readx_ImpDate write Writex_ImpDate;
    property x_ImpTime:TDatetime read Readx_ImpTime write Writex_ImpTime;
    property x_SItemQnt:byte read Readx_SItemQnt write Writex_SItemQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Sended:boolean read ReadSended write WriteSended;
    property ImdNum:Str20 read ReadImdNum write WriteImdNum;
    property TrgStk:longint read ReadTrgStk write WriteTrgStk;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property Year:Str2 read ReadYear write WriteYear;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TOmhBtr.Create;
begin
  oBtrTable := BtrInit ('OMH',gPath.StkPath,Self);
end;

constructor TOmhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OMH',pPath,Self);
end;

destructor TOmhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOmhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOmhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOmhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOmhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOmhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TOmhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOmhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOmhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOmhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOmhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOmhBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TOmhBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TOmhBtr.ReadSmName:Str17;
begin
  Result := oBtrTable.FieldByName('SmName').AsString;
end;

procedure TOmhBtr.WriteSmName(pValue:Str17);
begin
  oBtrTable.FieldByName('SmName').AsString := pValue;
end;

function TOmhBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TOmhBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TOmhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOmhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOmhBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOmhBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOmhBtr.ReadVatPrc1:double;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TOmhBtr.WriteVatPrc1(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TOmhBtr.ReadVatPrc2:double;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TOmhBtr.WriteVatPrc2(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TOmhBtr.ReadVatPrc3:double;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TOmhBtr.WriteVatPrc3(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue1:double;
begin
  Result := oBtrTable.FieldByName('CValue1').AsFloat;
end;

procedure TOmhBtr.WriteCValue1(pValue:double);
begin
  oBtrTable.FieldByName('CValue1').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue2:double;
begin
  Result := oBtrTable.FieldByName('CValue2').AsFloat;
end;

procedure TOmhBtr.WriteCValue2(pValue:double);
begin
  oBtrTable.FieldByName('CValue2').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue3:double;
begin
  Result := oBtrTable.FieldByName('CValue3').AsFloat;
end;

procedure TOmhBtr.WriteCValue3(pValue:double);
begin
  oBtrTable.FieldByName('CValue3').AsFloat := pValue;
end;

function TOmhBtr.ReadVatVal1:double;
begin
  Result := oBtrTable.FieldByName('VatVal1').AsFloat;
end;

procedure TOmhBtr.WriteVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TOmhBtr.ReadVatVal2:double;
begin
  Result := oBtrTable.FieldByName('VatVal2').AsFloat;
end;

procedure TOmhBtr.WriteVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TOmhBtr.ReadVatVal3:double;
begin
  Result := oBtrTable.FieldByName('VatVal3').AsFloat;
end;

procedure TOmhBtr.WriteVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue1:double;
begin
  Result := oBtrTable.FieldByName('EValue1').AsFloat;
end;

procedure TOmhBtr.WriteEValue1(pValue:double);
begin
  oBtrTable.FieldByName('EValue1').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue2:double;
begin
  Result := oBtrTable.FieldByName('EValue2').AsFloat;
end;

procedure TOmhBtr.WriteEValue2(pValue:double);
begin
  oBtrTable.FieldByName('EValue2').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue3:double;
begin
  Result := oBtrTable.FieldByName('EValue3').AsFloat;
end;

procedure TOmhBtr.WriteEValue3(pValue:double);
begin
  oBtrTable.FieldByName('EValue3').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TOmhBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TOmhBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TOmhBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TOmhBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TOmhBtr.ReadVatPrc4:double;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TOmhBtr.WriteVatPrc4(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TOmhBtr.ReadVatPrc5:double;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TOmhBtr.WriteVatPrc5(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue4:double;
begin
  Result := oBtrTable.FieldByName('CValue4').AsFloat;
end;

procedure TOmhBtr.WriteCValue4(pValue:double);
begin
  oBtrTable.FieldByName('CValue4').AsFloat := pValue;
end;

function TOmhBtr.ReadCValue5:double;
begin
  Result := oBtrTable.FieldByName('CValue5').AsFloat;
end;

procedure TOmhBtr.WriteCValue5(pValue:double);
begin
  oBtrTable.FieldByName('CValue5').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue4:double;
begin
  Result := oBtrTable.FieldByName('EValue4').AsFloat;
end;

procedure TOmhBtr.WriteEValue4(pValue:double);
begin
  oBtrTable.FieldByName('EValue4').AsFloat := pValue;
end;

function TOmhBtr.ReadEValue5:double;
begin
  Result := oBtrTable.FieldByName('EValue5').AsFloat;
end;

procedure TOmhBtr.WriteEValue5(pValue:double);
begin
  oBtrTable.FieldByName('EValue5').AsFloat := pValue;
end;

function TOmhBtr.Readx_PBVal1:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal1').AsFloat;
end;

procedure TOmhBtr.Writex_PBVal1(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal1').AsFloat := pValue;
end;

function TOmhBtr.Readx_PBVal2:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal2').AsFloat;
end;

procedure TOmhBtr.Writex_PBVal2(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal2').AsFloat := pValue;
end;

function TOmhBtr.Readx_PBVal3:double;
begin
  Result := oBtrTable.FieldByName('x_PBVal3').AsFloat;
end;

procedure TOmhBtr.Writex_PBVal3(pValue:double);
begin
  oBtrTable.FieldByName('x_PBVal3').AsFloat := pValue;
end;

function TOmhBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TOmhBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TOmhBtr.Readx_PVatVal0:double;
begin
  Result := oBtrTable.FieldByName('x_PVatVal0').AsFloat;
end;

procedure TOmhBtr.Writex_PVatVal0(pValue:double);
begin
  oBtrTable.FieldByName('x_PVatVal0').AsFloat := pValue;
end;

function TOmhBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TOmhBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TOmhBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TOmhBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TOmhBtr.ReadImdSnd:Str1;
begin
  Result := oBtrTable.FieldByName('ImdSnd').AsString;
end;

procedure TOmhBtr.WriteImdSnd(pValue:Str1);
begin
  oBtrTable.FieldByName('ImdSnd').AsString := pValue;
end;

function TOmhBtr.Readx_Status2:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status2').AsString;
end;

procedure TOmhBtr.Writex_Status2(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status2').AsString := pValue;
end;

function TOmhBtr.Readx_Status3:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status3').AsString;
end;

procedure TOmhBtr.Writex_Status3(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status3').AsString := pValue;
end;

function TOmhBtr.Readx_Status4:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status4').AsString;
end;

procedure TOmhBtr.Writex_Status4(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status4').AsString := pValue;
end;

function TOmhBtr.Readx_Status5:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status5').AsString;
end;

procedure TOmhBtr.Writex_Status5(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status5').AsString := pValue;
end;

function TOmhBtr.Readx_Status6:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status6').AsString;
end;

procedure TOmhBtr.Writex_Status6(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status6').AsString := pValue;
end;

function TOmhBtr.Readx_Status7:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status7').AsString;
end;

procedure TOmhBtr.Writex_Status7(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status7').AsString := pValue;
end;

function TOmhBtr.Readx_Status8:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status8').AsString;
end;

procedure TOmhBtr.Writex_Status8(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status8').AsString := pValue;
end;

function TOmhBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TOmhBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TOmhBtr.ReadConStk:word;
begin
  Result := oBtrTable.FieldByName('ConStk').AsInteger;
end;

procedure TOmhBtr.WriteConStk(pValue:word);
begin
  oBtrTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TOmhBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TOmhBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TOmhBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TOmhBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TOmhBtr.ReadAccUser:Str8;
begin
  Result := oBtrTable.FieldByName('AccUser').AsString;
end;

procedure TOmhBtr.WriteAccUser(pValue:Str8);
begin
  oBtrTable.FieldByName('AccUser').AsString := pValue;
end;

function TOmhBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TOmhBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TOmhBtr.Readx_LdgTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_LdgTime').AsDateTime;
end;

procedure TOmhBtr.Writex_LdgTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_LdgTime').AsDateTime := pValue;
end;

function TOmhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOmhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOmhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOmhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOmhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOmhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOmhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOmhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOmhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOmhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOmhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOmhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOmhBtr.Readx_ImpName:Str8;
begin
  Result := oBtrTable.FieldByName('x_ImpName').AsString;
end;

procedure TOmhBtr.Writex_ImpName(pValue:Str8);
begin
  oBtrTable.FieldByName('x_ImpName').AsString := pValue;
end;

function TOmhBtr.Readx_ImpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_ImpDate').AsDateTime;
end;

procedure TOmhBtr.Writex_ImpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_ImpDate').AsDateTime := pValue;
end;

function TOmhBtr.Readx_ImpTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('x_ImpTime').AsDateTime;
end;

procedure TOmhBtr.Writex_ImpTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('x_ImpTime').AsDateTime := pValue;
end;

function TOmhBtr.Readx_SItemQnt:byte;
begin
  Result := oBtrTable.FieldByName('x_SItemQnt').AsInteger;
end;

procedure TOmhBtr.Writex_SItemQnt(pValue:byte);
begin
  oBtrTable.FieldByName('x_SItemQnt').AsInteger := pValue;
end;

function TOmhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOmhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOmhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TOmhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOmhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TOmhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOmhBtr.ReadImdNum:Str20;
begin
  Result := oBtrTable.FieldByName('ImdNum').AsString;
end;

procedure TOmhBtr.WriteImdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ImdNum').AsString := pValue;
end;

function TOmhBtr.ReadTrgStk:longint;
begin
  Result := oBtrTable.FieldByName('TrgStk').AsInteger;
end;

procedure TOmhBtr.WriteTrgStk(pValue:longint);
begin
  oBtrTable.FieldByName('TrgStk').AsInteger := pValue;
end;

function TOmhBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TOmhBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TOmhBtr.ReadCAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TOmhBtr.WriteCAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TOmhBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TOmhBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TOmhBtr.ReadDAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TOmhBtr.WriteDAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TOmhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TOmhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TOmhBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TOmhBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TOmhBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TOmhBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOmhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOmhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOmhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOmhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOmhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOmhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOmhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TOmhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOmhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TOmhBtr.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindKey([pSmCode]);
end;

function TOmhBtr.LocateEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oBtrTable.FindKey([pEValue]);
end;

function TOmhBtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TOmhBtr.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindKey([pCValue]);
end;

function TOmhBtr.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindKey([pAValue]);
end;

function TOmhBtr.LocateImdNum (pImdNum:Str20):boolean;
begin
  SetIndex (ixImdNum);
  Result := oBtrTable.FindKey([pImdNum]);
end;

function TOmhBtr.LocateDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([pDescribe]);
end;

function TOmhBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TOmhBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TOmhBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TOmhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TOmhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOmhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TOmhBtr.NearestSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindNearest([pSmCode]);
end;

function TOmhBtr.NearestEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oBtrTable.FindNearest([pEValue]);
end;

function TOmhBtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TOmhBtr.NearestCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindNearest([pCValue]);
end;

function TOmhBtr.NearestAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindNearest([pAValue]);
end;

function TOmhBtr.NearestImdNum (pImdNum:Str20):boolean;
begin
  SetIndex (ixImdNum);
  Result := oBtrTable.FindNearest([pImdNum]);
end;

function TOmhBtr.NearestDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe]);
end;

function TOmhBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

function TOmhBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TOmhBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TOmhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOmhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOmhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOmhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOmhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOmhBtr.First;
begin
  oBtrTable.First;
end;

procedure TOmhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOmhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOmhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOmhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOmhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOmhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOmhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOmhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOmhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOmhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOmhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
