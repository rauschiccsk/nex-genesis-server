unit tRMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixDescribe = 'Describe';
  ixCValue = 'CValue';
  ixEValue = 'EValue';
  ixOcdNum = 'OcdNum';
  ixRbaCode = 'RbaCode';

type
  TRmhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadScStkNum:word;         procedure WriteScStkNum (pValue:word);
    function  ReadTgStkNum:word;         procedure WriteTgStkNum (pValue:word);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
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
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSrdNum:Str12;          procedure WriteSrdNum (pValue:Str12);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe (pDescribe:Str30):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateEValue (pEValue:double):boolean;
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
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ScStkNum:word read ReadScStkNum write WriteScStkNum;
    property TgStkNum:word read ReadTgStkNum write WriteTgStkNum;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
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
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property SrdNum:Str12 read ReadSrdNum write WriteSrdNum;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRmhTmp.Create;
begin
  oTmpTable := TmpInit ('RMH',Self);
end;

destructor TRmhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRmhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRmhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRmhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TRmhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TRmhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TRmhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TRmhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TRmhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TRmhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRmhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRmhTmp.ReadScStkNum:word;
begin
  Result := oTmpTable.FieldByName('ScStkNum').AsInteger;
end;

procedure TRmhTmp.WriteScStkNum(pValue:word);
begin
  oTmpTable.FieldByName('ScStkNum').AsInteger := pValue;
end;

function TRmhTmp.ReadTgStkNum:word;
begin
  Result := oTmpTable.FieldByName('TgStkNum').AsInteger;
end;

procedure TRmhTmp.WriteTgStkNum(pValue:word);
begin
  oTmpTable.FieldByName('TgStkNum').AsInteger := pValue;
end;

function TRmhTmp.ReadScSmCode:word;
begin
  Result := oTmpTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TRmhTmp.WriteScSmCode(pValue:word);
begin
  oTmpTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TRmhTmp.ReadTgSmCode:word;
begin
  Result := oTmpTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TRmhTmp.WriteTgSmCode(pValue:word);
begin
  oTmpTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TRmhTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TRmhTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TRmhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TRmhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TRmhTmp.ReadPlsNum:word;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TRmhTmp.WritePlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TRmhTmp.ReadVatPrc1:double;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TRmhTmp.WriteVatPrc1(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TRmhTmp.ReadVatPrc2:double;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TRmhTmp.WriteVatPrc2(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TRmhTmp.ReadVatPrc3:double;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TRmhTmp.WriteVatPrc3(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TRmhTmp.ReadVatPrc4:double;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TRmhTmp.WriteVatPrc4(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TRmhTmp.ReadVatPrc5:double;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TRmhTmp.WriteVatPrc5(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue1:double;
begin
  Result := oTmpTable.FieldByName('CValue1').AsFloat;
end;

procedure TRmhTmp.WriteCValue1(pValue:double);
begin
  oTmpTable.FieldByName('CValue1').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue2:double;
begin
  Result := oTmpTable.FieldByName('CValue2').AsFloat;
end;

procedure TRmhTmp.WriteCValue2(pValue:double);
begin
  oTmpTable.FieldByName('CValue2').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue3:double;
begin
  Result := oTmpTable.FieldByName('CValue3').AsFloat;
end;

procedure TRmhTmp.WriteCValue3(pValue:double);
begin
  oTmpTable.FieldByName('CValue3').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue4:double;
begin
  Result := oTmpTable.FieldByName('CValue4').AsFloat;
end;

procedure TRmhTmp.WriteCValue4(pValue:double);
begin
  oTmpTable.FieldByName('CValue4').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue5:double;
begin
  Result := oTmpTable.FieldByName('CValue5').AsFloat;
end;

procedure TRmhTmp.WriteCValue5(pValue:double);
begin
  oTmpTable.FieldByName('CValue5').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TRmhTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TRmhTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TRmhTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TRmhTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TRmhTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue1:double;
begin
  Result := oTmpTable.FieldByName('EValue1').AsFloat;
end;

procedure TRmhTmp.WriteEValue1(pValue:double);
begin
  oTmpTable.FieldByName('EValue1').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue2:double;
begin
  Result := oTmpTable.FieldByName('EValue2').AsFloat;
end;

procedure TRmhTmp.WriteEValue2(pValue:double);
begin
  oTmpTable.FieldByName('EValue2').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue3:double;
begin
  Result := oTmpTable.FieldByName('EValue3').AsFloat;
end;

procedure TRmhTmp.WriteEValue3(pValue:double);
begin
  oTmpTable.FieldByName('EValue3').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue4:double;
begin
  Result := oTmpTable.FieldByName('EValue4').AsFloat;
end;

procedure TRmhTmp.WriteEValue4(pValue:double);
begin
  oTmpTable.FieldByName('EValue4').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue5:double;
begin
  Result := oTmpTable.FieldByName('EValue5').AsFloat;
end;

procedure TRmhTmp.WriteEValue5(pValue:double);
begin
  oTmpTable.FieldByName('EValue5').AsFloat := pValue;
end;

function TRmhTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TRmhTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRmhTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TRmhTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TRmhTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TRmhTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TRmhTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TRmhTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRmhTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TRmhTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRmhTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TRmhTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TRmhTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TRmhTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TRmhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TRmhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TRmhTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TRmhTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TRmhTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TRmhTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TRmhTmp.ReadSrdNum:Str12;
begin
  Result := oTmpTable.FieldByName('SrdNum').AsString;
end;

procedure TRmhTmp.WriteSrdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('SrdNum').AsString := pValue;
end;

function TRmhTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TRmhTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TRmhTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TRmhTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TRmhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRmhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRmhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRmhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRmhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRmhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRmhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRmhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRmhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRmhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRmhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRmhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRmhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRmhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRmhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRmhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRmhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TRmhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TRmhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TRmhTmp.LocateDescribe (pDescribe:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oTmpTable.FindKey([pDescribe]);
end;

function TRmhTmp.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oTmpTable.FindKey([pCValue]);
end;

function TRmhTmp.LocateEValue (pEValue:double):boolean;
begin
  SetIndex (ixEValue);
  Result := oTmpTable.FindKey([pEValue]);
end;

function TRmhTmp.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TRmhTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TRmhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRmhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRmhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRmhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRmhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRmhTmp.First;
begin
  oTmpTable.First;
end;

procedure TRmhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRmhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRmhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRmhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRmhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRmhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRmhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRmhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRmhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRmhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRmhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
