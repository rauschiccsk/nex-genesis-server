unit tIMH;

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
  ixOmdNum = 'OmdNum';
  ixOcdNum = 'OcdNum';
  ixDescribe = 'Describe';
  ixDstAcc = 'DstAcc';
  ixRbaCode = 'RbaCode';

type
  TImhTmp = class (TComponent)
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
    function  ReadRndVal:double;         procedure WriteRndVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
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
    function  ReadOmdNum:Str20;          procedure WriteOmdNum (pValue:Str20);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadAwdSta:byte;           procedure WriteAwdSta (pValue:byte);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
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
    function LocateOmdNum (pOmdNum:Str20):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function LocateDescribe (pDescribe:Str30):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
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
    property RndVal:double read ReadRndVal write WriteRndVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
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
    property OmdNum:Str20 read ReadOmdNum write WriteOmdNum;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property ActPos:longint read ReadActPos write WriteActPos;
    property AwdSta:byte read ReadAwdSta write WriteAwdSta;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TImhTmp.Create;
begin
  oTmpTable := TmpInit ('IMH',Self);
end;

destructor TImhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TImhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TImhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TImhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TImhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TImhTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TImhTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TImhTmp.ReadConStk:word;
begin
  Result := oTmpTable.FieldByName('ConStk').AsInteger;
end;

procedure TImhTmp.WriteConStk(pValue:word);
begin
  oTmpTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TImhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TImhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TImhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TImhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TImhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TImhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TImhTmp.ReadSmCode:word;
begin
  Result := oTmpTable.FieldByName('SmCode').AsInteger;
end;

procedure TImhTmp.WriteSmCode(pValue:word);
begin
  oTmpTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TImhTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TImhTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TImhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TImhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TImhTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TImhTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TImhTmp.ReadVatPrc1:double;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TImhTmp.WriteVatPrc1(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TImhTmp.ReadVatPrc2:double;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TImhTmp.WriteVatPrc2(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TImhTmp.ReadVatPrc3:double;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TImhTmp.WriteVatPrc3(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TImhTmp.ReadVatPrc4:double;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TImhTmp.WriteVatPrc4(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TImhTmp.ReadVatPrc5:double;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TImhTmp.WriteVatPrc5(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TImhTmp.ReadCValue1:double;
begin
  Result := oTmpTable.FieldByName('CValue1').AsFloat;
end;

procedure TImhTmp.WriteCValue1(pValue:double);
begin
  oTmpTable.FieldByName('CValue1').AsFloat := pValue;
end;

function TImhTmp.ReadCValue2:double;
begin
  Result := oTmpTable.FieldByName('CValue2').AsFloat;
end;

procedure TImhTmp.WriteCValue2(pValue:double);
begin
  oTmpTable.FieldByName('CValue2').AsFloat := pValue;
end;

function TImhTmp.ReadCValue3:double;
begin
  Result := oTmpTable.FieldByName('CValue3').AsFloat;
end;

procedure TImhTmp.WriteCValue3(pValue:double);
begin
  oTmpTable.FieldByName('CValue3').AsFloat := pValue;
end;

function TImhTmp.ReadCValue4:double;
begin
  Result := oTmpTable.FieldByName('CValue4').AsFloat;
end;

procedure TImhTmp.WriteCValue4(pValue:double);
begin
  oTmpTable.FieldByName('CValue4').AsFloat := pValue;
end;

function TImhTmp.ReadCValue5:double;
begin
  Result := oTmpTable.FieldByName('CValue5').AsFloat;
end;

procedure TImhTmp.WriteCValue5(pValue:double);
begin
  oTmpTable.FieldByName('CValue5').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TImhTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TImhTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TImhTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TImhTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TImhTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TImhTmp.ReadEValue1:double;
begin
  Result := oTmpTable.FieldByName('EValue1').AsFloat;
end;

procedure TImhTmp.WriteEValue1(pValue:double);
begin
  oTmpTable.FieldByName('EValue1').AsFloat := pValue;
end;

function TImhTmp.ReadEValue2:double;
begin
  Result := oTmpTable.FieldByName('EValue2').AsFloat;
end;

procedure TImhTmp.WriteEValue2(pValue:double);
begin
  oTmpTable.FieldByName('EValue2').AsFloat := pValue;
end;

function TImhTmp.ReadEValue3:double;
begin
  Result := oTmpTable.FieldByName('EValue3').AsFloat;
end;

procedure TImhTmp.WriteEValue3(pValue:double);
begin
  oTmpTable.FieldByName('EValue3').AsFloat := pValue;
end;

function TImhTmp.ReadEValue4:double;
begin
  Result := oTmpTable.FieldByName('EValue4').AsFloat;
end;

procedure TImhTmp.WriteEValue4(pValue:double);
begin
  oTmpTable.FieldByName('EValue4').AsFloat := pValue;
end;

function TImhTmp.ReadEValue5:double;
begin
  Result := oTmpTable.FieldByName('EValue5').AsFloat;
end;

procedure TImhTmp.WriteEValue5(pValue:double);
begin
  oTmpTable.FieldByName('EValue5').AsFloat := pValue;
end;

function TImhTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TImhTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TImhTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TImhTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TImhTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TImhTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TImhTmp.ReadRndVal:double;
begin
  Result := oTmpTable.FieldByName('RndVal').AsFloat;
end;

procedure TImhTmp.WriteRndVal(pValue:double);
begin
  oTmpTable.FieldByName('RndVal').AsFloat := pValue;
end;

function TImhTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TImhTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TImhTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TImhTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TImhTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TImhTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TImhTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TImhTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TImhTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TImhTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TImhTmp.ReadAccUser:Str8;
begin
  Result := oTmpTable.FieldByName('AccUser').AsString;
end;

procedure TImhTmp.WriteAccUser(pValue:Str8);
begin
  oTmpTable.FieldByName('AccUser').AsString := pValue;
end;

function TImhTmp.ReadAccDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AccDate').AsDateTime;
end;

procedure TImhTmp.WriteAccDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TImhTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TImhTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TImhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TImhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TImhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TImhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TImhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TImhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TImhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TImhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TImhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TImhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TImhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TImhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TImhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TImhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TImhTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TImhTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TImhTmp.ReadOmdNum:Str20;
begin
  Result := oTmpTable.FieldByName('OmdNum').AsString;
end;

procedure TImhTmp.WriteOmdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('OmdNum').AsString := pValue;
end;

function TImhTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TImhTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TImhTmp.ReadCAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TImhTmp.WriteCAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TImhTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TImhTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TImhTmp.ReadDAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TImhTmp.WriteDAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TImhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TImhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TImhTmp.ReadAwdSta:byte;
begin
  Result := oTmpTable.FieldByName('AwdSta').AsInteger;
end;

procedure TImhTmp.WriteAwdSta(pValue:byte);
begin
  oTmpTable.FieldByName('AwdSta').AsInteger := pValue;
end;

function TImhTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TImhTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TImhTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TImhTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TImhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TImhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TImhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TImhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TImhTmp.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oTmpTable.FindKey([pSmCode]);
end;

function TImhTmp.LocateEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oTmpTable.FindKey([pEValue]);
end;

function TImhTmp.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oTmpTable.FindKey([pCValue]);
end;

function TImhTmp.LocateOmdNum (pOmdNum:Str20):boolean;
begin
  SetIndex (ixOmdNum);
  Result := oTmpTable.FindKey([pOmdNum]);
end;

function TImhTmp.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TImhTmp.LocateDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oTmpTable.FindKey([pDescribe]);
end;

function TImhTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

function TImhTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TImhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TImhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TImhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TImhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TImhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TImhTmp.First;
begin
  oTmpTable.First;
end;

procedure TImhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TImhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TImhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TImhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TImhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TImhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TImhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TImhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TImhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TImhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TImhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
