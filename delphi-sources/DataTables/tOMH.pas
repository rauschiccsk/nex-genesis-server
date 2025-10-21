unit tOMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixEValue = 'EValue';
  ixCValue = 'CValue';
  ixDescribe = 'Describe';
  ixOcdNum = 'OcdNum';
  ixRbaCode = 'RbaCode';

type
  TOmhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadSmName:Str17;          procedure WriteSmName (pValue:Str17);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadVatPrc1:double;        procedure WriteVatPrc1 (pValue:double);
    function  ReadVatPrc2:double;        procedure WriteVatPrc2 (pValue:double);
    function  ReadVatPrc3:double;        procedure WriteVatPrc3 (pValue:double);
    function  ReadVatPrc4:double;        procedure WriteVatPrc4 (pValue:double);
    function  ReadVatPrc5:double;        procedure WriteVatPrc5 (pValue:double);
    function  ReadCValue1:double;        procedure WriteCValue1 (pValue:double);
    function  ReadCValue2:double;        procedure WriteCValue2 (pValue:double);
    function  ReadCValue3:double;        procedure WriteCValue3 (pValue:double);
    function  ReadCValue4:double;        procedure WriteCValue4 (pValue:double);
    function  ReadCValue5:double;        procedure WriteCValue5 (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadVatVal4:double;        procedure WriteVatVal4 (pValue:double);
    function  ReadVatVal5:double;        procedure WriteVatVal5 (pValue:double);
    function  ReadEValue1:double;        procedure WriteEValue1 (pValue:double);
    function  ReadEValue2:double;        procedure WriteEValue2 (pValue:double);
    function  ReadEValue3:double;        procedure WriteEValue3 (pValue:double);
    function  ReadEValue4:double;        procedure WriteEValue4 (pValue:double);
    function  ReadEValue5:double;        procedure WriteEValue5 (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadAccUser:Str8;          procedure WriteAccUser (pValue:Str8);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadImdSnd:Str1;           procedure WriteImdSnd (pValue:Str1);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateEValue (pEValue:double):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateDescribe (pDescribe:Str30):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property ConStk:word read ReadConStk write WriteConStk;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property SmName:Str17 read ReadSmName write WriteSmName;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property VatPrc1:double read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:double read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:double read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:double read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:double read ReadVatPrc5 write WriteVatPrc5;
    property CValue1:double read ReadCValue1 write WriteCValue1;
    property CValue2:double read ReadCValue2 write WriteCValue2;
    property CValue3:double read ReadCValue3 write WriteCValue3;
    property CValue4:double read ReadCValue4 write WriteCValue4;
    property CValue5:double read ReadCValue5 write WriteCValue5;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property VatVal4:double read ReadVatVal4 write WriteVatVal4;
    property VatVal5:double read ReadVatVal5 write WriteVatVal5;
    property EValue1:double read ReadEValue1 write WriteEValue1;
    property EValue2:double read ReadEValue2 write WriteEValue2;
    property EValue3:double read ReadEValue3 write WriteEValue3;
    property EValue4:double read ReadEValue4 write WriteEValue4;
    property EValue5:double read ReadEValue5 write WriteEValue5;
    property CValue:double read ReadCValue write WriteCValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property EValue:double read ReadEValue write WriteEValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property AccUser:Str8 read ReadAccUser write WriteAccUser;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Sended:boolean read ReadSended write WriteSended;
    property ImdSnd:Str1 read ReadImdSnd write WriteImdSnd;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TOmhTmp.Create;
begin
  oTmpTable := TmpInit ('OMH',Self);
end;

destructor TOmhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOmhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOmhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOmhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOmhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOmhTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOmhTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOmhTmp.ReadConStk:word;
begin
  Result := oTmpTable.FieldByName('ConStk').AsInteger;
end;

procedure TOmhTmp.WriteConStk(pValue:word);
begin
  oTmpTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TOmhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TOmhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TOmhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TOmhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOmhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOmhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOmhTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TOmhTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TOmhTmp.ReadSmName:Str17;
begin
  Result := oTmpTable.FieldByName('SmName').AsString;
end;

procedure TOmhTmp.WriteSmName(pValue:Str17);
begin
  oTmpTable.FieldByName('SmName').AsString := pValue;
end;

function TOmhTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOmhTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TOmhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOmhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOmhTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TOmhTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TOmhTmp.ReadVatPrc1:double;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TOmhTmp.WriteVatPrc1(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TOmhTmp.ReadVatPrc2:double;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TOmhTmp.WriteVatPrc2(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TOmhTmp.ReadVatPrc3:double;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TOmhTmp.WriteVatPrc3(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TOmhTmp.ReadVatPrc4:double;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TOmhTmp.WriteVatPrc4(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TOmhTmp.ReadVatPrc5:double;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TOmhTmp.WriteVatPrc5(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue1:double;
begin
  Result := oTmpTable.FieldByName('CValue1').AsFloat;
end;

procedure TOmhTmp.WriteCValue1(pValue:double);
begin
  oTmpTable.FieldByName('CValue1').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue2:double;
begin
  Result := oTmpTable.FieldByName('CValue2').AsFloat;
end;

procedure TOmhTmp.WriteCValue2(pValue:double);
begin
  oTmpTable.FieldByName('CValue2').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue3:double;
begin
  Result := oTmpTable.FieldByName('CValue3').AsFloat;
end;

procedure TOmhTmp.WriteCValue3(pValue:double);
begin
  oTmpTable.FieldByName('CValue3').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue4:double;
begin
  Result := oTmpTable.FieldByName('CValue4').AsFloat;
end;

procedure TOmhTmp.WriteCValue4(pValue:double);
begin
  oTmpTable.FieldByName('CValue4').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue5:double;
begin
  Result := oTmpTable.FieldByName('CValue5').AsFloat;
end;

procedure TOmhTmp.WriteCValue5(pValue:double);
begin
  oTmpTable.FieldByName('CValue5').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TOmhTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TOmhTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TOmhTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TOmhTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TOmhTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue1:double;
begin
  Result := oTmpTable.FieldByName('EValue1').AsFloat;
end;

procedure TOmhTmp.WriteEValue1(pValue:double);
begin
  oTmpTable.FieldByName('EValue1').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue2:double;
begin
  Result := oTmpTable.FieldByName('EValue2').AsFloat;
end;

procedure TOmhTmp.WriteEValue2(pValue:double);
begin
  oTmpTable.FieldByName('EValue2').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue3:double;
begin
  Result := oTmpTable.FieldByName('EValue3').AsFloat;
end;

procedure TOmhTmp.WriteEValue3(pValue:double);
begin
  oTmpTable.FieldByName('EValue3').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue4:double;
begin
  Result := oTmpTable.FieldByName('EValue4').AsFloat;
end;

procedure TOmhTmp.WriteEValue4(pValue:double);
begin
  oTmpTable.FieldByName('EValue4').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue5:double;
begin
  Result := oTmpTable.FieldByName('EValue5').AsFloat;
end;

procedure TOmhTmp.WriteEValue5(pValue:double);
begin
  oTmpTable.FieldByName('EValue5').AsFloat := pValue;
end;

function TOmhTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TOmhTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TOmhTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TOmhTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TOmhTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TOmhTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TOmhTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TOmhTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TOmhTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TOmhTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TOmhTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TOmhTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TOmhTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TOmhTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TOmhTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TOmhTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TOmhTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TOmhTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TOmhTmp.ReadCAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TOmhTmp.WriteCAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TOmhTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TOmhTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TOmhTmp.ReadDAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TOmhTmp.WriteDAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TOmhTmp.ReadAccUser:Str8;
begin
  Result := oTmpTable.FieldByName('AccUser').AsString;
end;

procedure TOmhTmp.WriteAccUser(pValue:Str8);
begin
  oTmpTable.FieldByName('AccUser').AsString := pValue;
end;

function TOmhTmp.ReadAccDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AccDate').AsDateTime;
end;

procedure TOmhTmp.WriteAccDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TOmhTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TOmhTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TOmhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOmhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOmhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOmhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOmhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOmhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOmhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOmhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOmhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOmhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOmhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOmhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOmhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TOmhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOmhTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TOmhTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOmhTmp.ReadImdSnd:Str1;
begin
  Result := oTmpTable.FieldByName('ImdSnd').AsString;
end;

procedure TOmhTmp.WriteImdSnd(pValue:Str1);
begin
  oTmpTable.FieldByName('ImdSnd').AsString := pValue;
end;

function TOmhTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TOmhTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TOmhTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TOmhTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TOmhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOmhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOmhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOmhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOmhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TOmhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TOmhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TOmhTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TOmhTmp.LocateEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oTmpTable.FindKey([pEValue]);
end;

function TOmhTmp.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oTmpTable.FindKey([pCValue]);
end;

function TOmhTmp.LocateDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oTmpTable.FindKey([pDescribe]);
end;

function TOmhTmp.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TOmhTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TOmhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOmhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOmhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOmhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOmhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOmhTmp.First;
begin
  oTmpTable.First;
end;

procedure TOmhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOmhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOmhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOmhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOmhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOmhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOmhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOmhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOmhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOmhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOmhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
