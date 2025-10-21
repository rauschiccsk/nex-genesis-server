unit bSAH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixSended = 'Sended';
  ixDstAcc = 'DstAcc';

type
  TSahBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadVatPrc1:double;        procedure WriteVatPrc1 (pValue:double);
    function  ReadVatPrc2:double;        procedure WriteVatPrc2 (pValue:double);
    function  ReadVatPrc3:double;        procedure WriteVatPrc3 (pValue:double);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadAValue3:double;        procedure WriteAValue3 (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadNsiCnt:word;           procedure WriteNsiCnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadGscVal:double;         procedure WriteGscVal (pValue:double);
    function  ReadSecVal:double;         procedure WriteSecVal (pValue:double);
    function  ReadCrcVal:double;         procedure WriteCrcVal (pValue:double);
    function  ReadBvlDoc:Str12;          procedure WriteBvlDoc (pValue:Str12);
    function  ReadCseDoc:Str12;          procedure WriteCseDoc (pValue:Str12);
    function  ReadCsiDoc:Str12;          procedure WriteCsiDoc (pValue:Str12);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str8;          procedure WriteCAccAnl (pValue:Str8);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str8;          procedure WriteDAccAnl (pValue:Str8);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadIValue:double;         procedure WriteIValue (pValue:double);
    function  ReadSpiVal:double;         procedure WriteSpiVal (pValue:double);
    function  ReadSpeVal:double;         procedure WriteSpeVal (pValue:double);
    function  ReadSpiVat:double;         procedure WriteSpiVat (pValue:double);
    function  ReadSpeVat:double;         procedure WriteSpeVat (pValue:double);
    function  ReadCseVal:double;         procedure WriteCseVal (pValue:double);
    function  ReadSpiDoc:Str12;          procedure WriteSpiDoc (pValue:Str12);
    function  ReadSpeDoc:Str12;          procedure WriteSpeDoc (pValue:Str12);
    function  ReadSpvDoc:Str12;          procedure WriteSpvDoc (pValue:Str12);
    function  ReadCrcDoc:Str12;          procedure WriteCrcDoc (pValue:Str12);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadIncCse:Str12;          procedure WriteIncCse (pValue:Str12);
    function  ReadIncCsi:Str12;          procedure WriteIncCsi (pValue:Str12);
    function  ReadVatPrc4:double;        procedure WriteVatPrc4 (pValue:double);
    function  ReadAValue4:double;        procedure WriteAValue4 (pValue:double);
    function  ReadVatVal4:double;        procedure WriteVatVal4 (pValue:double);
    function  ReadBValue4:double;        procedure WriteBValue4 (pValue:double);
    function  ReadVatPrc5:double;        procedure WriteVatPrc5 (pValue:double);
    function  ReadAValue5:double;        procedure WriteAValue5 (pValue:double);
    function  ReadVatVal5:double;        procedure WriteVatVal5 (pValue:double);
    function  ReadBValue5:double;        procedure WriteBValue5 (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestAValue (pAValue:double):boolean;
    function NearestBValue (pBValue:double):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property VatPrc1:double read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:double read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:double read ReadVatPrc3 write WriteVatPrc3;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property AValue3:double read ReadAValue3 write WriteAValue3;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property CValue:double read ReadCValue write WriteCValue;
    property AValue:double read ReadAValue write WriteAValue;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property BValue:double read ReadBValue write WriteBValue;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property NsiCnt:word read ReadNsiCnt write WriteNsiCnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Sended:boolean read ReadSended write WriteSended;
    property GscVal:double read ReadGscVal write WriteGscVal;
    property SecVal:double read ReadSecVal write WriteSecVal;
    property CrcVal:double read ReadCrcVal write WriteCrcVal;
    property BvlDoc:Str12 read ReadBvlDoc write WriteBvlDoc;
    property CseDoc:Str12 read ReadCseDoc write WriteCseDoc;
    property CsiDoc:Str12 read ReadCsiDoc write WriteCsiDoc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str8 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str8 read ReadDAccAnl write WriteDAccAnl;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property IValue:double read ReadIValue write WriteIValue;
    property SpiVal:double read ReadSpiVal write WriteSpiVal;
    property SpeVal:double read ReadSpeVal write WriteSpeVal;
    property SpiVat:double read ReadSpiVat write WriteSpiVat;
    property SpeVat:double read ReadSpeVat write WriteSpeVat;
    property CseVal:double read ReadCseVal write WriteCseVal;
    property SpiDoc:Str12 read ReadSpiDoc write WriteSpiDoc;
    property SpeDoc:Str12 read ReadSpeDoc write WriteSpeDoc;
    property SpvDoc:Str12 read ReadSpvDoc write WriteSpvDoc;
    property CrcDoc:Str12 read ReadCrcDoc write WriteCrcDoc;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property IncCse:Str12 read ReadIncCse write WriteIncCse;
    property IncCsi:Str12 read ReadIncCsi write WriteIncCsi;
    property VatPrc4:double read ReadVatPrc4 write WriteVatPrc4;
    property AValue4:double read ReadAValue4 write WriteAValue4;
    property VatVal4:double read ReadVatVal4 write WriteVatVal4;
    property BValue4:double read ReadBValue4 write WriteBValue4;
    property VatPrc5:double read ReadVatPrc5 write WriteVatPrc5;
    property AValue5:double read ReadAValue5 write WriteAValue5;
    property VatVal5:double read ReadVatVal5 write WriteVatVal5;
    property BValue5:double read ReadBValue5 write WriteBValue5;
  end;

implementation

constructor TSahBtr.Create;
begin
  oBtrTable := BtrInit ('SAH',gPath.CabPath,Self);
end;

constructor TSahBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SAH',pPath,Self);
end;

destructor TSahBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSahBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSahBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSahBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSahBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSahBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSahBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSahBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSahBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TSahBtr.ReadVatPrc1:double;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TSahBtr.WriteVatPrc1(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TSahBtr.ReadVatPrc2:double;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TSahBtr.WriteVatPrc2(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TSahBtr.ReadVatPrc3:double;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TSahBtr.WriteVatPrc3(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TSahBtr.ReadAValue1:double;
begin
  Result := oBtrTable.FieldByName('AValue1').AsFloat;
end;

procedure TSahBtr.WriteAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TSahBtr.ReadAValue2:double;
begin
  Result := oBtrTable.FieldByName('AValue2').AsFloat;
end;

procedure TSahBtr.WriteAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TSahBtr.ReadAValue3:double;
begin
  Result := oBtrTable.FieldByName('AValue3').AsFloat;
end;

procedure TSahBtr.WriteAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal1:double;
begin
  Result := oBtrTable.FieldByName('VatVal1').AsFloat;
end;

procedure TSahBtr.WriteVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal2:double;
begin
  Result := oBtrTable.FieldByName('VatVal2').AsFloat;
end;

procedure TSahBtr.WriteVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal3:double;
begin
  Result := oBtrTable.FieldByName('VatVal3').AsFloat;
end;

procedure TSahBtr.WriteVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TSahBtr.ReadBValue1:double;
begin
  Result := oBtrTable.FieldByName('BValue1').AsFloat;
end;

procedure TSahBtr.WriteBValue1(pValue:double);
begin
  oBtrTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TSahBtr.ReadBValue2:double;
begin
  Result := oBtrTable.FieldByName('BValue2').AsFloat;
end;

procedure TSahBtr.WriteBValue2(pValue:double);
begin
  oBtrTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TSahBtr.ReadBValue3:double;
begin
  Result := oBtrTable.FieldByName('BValue3').AsFloat;
end;

procedure TSahBtr.WriteBValue3(pValue:double);
begin
  oBtrTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TSahBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TSahBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSahBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TSahBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TSahBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TSahBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TSahBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSahBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TSahBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSahBtr.ReadNsiCnt:word;
begin
  Result := oBtrTable.FieldByName('NsiCnt').AsInteger;
end;

procedure TSahBtr.WriteNsiCnt(pValue:word);
begin
  oBtrTable.FieldByName('NsiCnt').AsInteger := pValue;
end;

function TSahBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSahBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSahBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSahBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSahBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSahBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSahBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSahBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSahBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSahBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSahBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSahBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSahBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSahBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSahBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSahBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSahBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TSahBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSahBtr.ReadGscVal:double;
begin
  Result := oBtrTable.FieldByName('GscVal').AsFloat;
end;

procedure TSahBtr.WriteGscVal(pValue:double);
begin
  oBtrTable.FieldByName('GscVal').AsFloat := pValue;
end;

function TSahBtr.ReadSecVal:double;
begin
  Result := oBtrTable.FieldByName('SecVal').AsFloat;
end;

procedure TSahBtr.WriteSecVal(pValue:double);
begin
  oBtrTable.FieldByName('SecVal').AsFloat := pValue;
end;

function TSahBtr.ReadCrcVal:double;
begin
  Result := oBtrTable.FieldByName('CrcVal').AsFloat;
end;

procedure TSahBtr.WriteCrcVal(pValue:double);
begin
  oBtrTable.FieldByName('CrcVal').AsFloat := pValue;
end;

function TSahBtr.ReadBvlDoc:Str12;
begin
  Result := oBtrTable.FieldByName('BvlDoc').AsString;
end;

procedure TSahBtr.WriteBvlDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('BvlDoc').AsString := pValue;
end;

function TSahBtr.ReadCseDoc:Str12;
begin
  Result := oBtrTable.FieldByName('CseDoc').AsString;
end;

procedure TSahBtr.WriteCseDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('CseDoc').AsString := pValue;
end;

function TSahBtr.ReadCsiDoc:Str12;
begin
  Result := oBtrTable.FieldByName('CsiDoc').AsString;
end;

procedure TSahBtr.WriteCsiDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('CsiDoc').AsString := pValue;
end;

function TSahBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TSahBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TSahBtr.ReadCAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TSahBtr.WriteCAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TSahBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TSahBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TSahBtr.ReadDAccAnl:Str8;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TSahBtr.WriteDAccAnl(pValue:Str8);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TSahBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TSahBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TSahBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TSahBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TSahBtr.ReadIValue:double;
begin
  Result := oBtrTable.FieldByName('IValue').AsFloat;
end;

procedure TSahBtr.WriteIValue(pValue:double);
begin
  oBtrTable.FieldByName('IValue').AsFloat := pValue;
end;

function TSahBtr.ReadSpiVal:double;
begin
  Result := oBtrTable.FieldByName('SpiVal').AsFloat;
end;

procedure TSahBtr.WriteSpiVal(pValue:double);
begin
  oBtrTable.FieldByName('SpiVal').AsFloat := pValue;
end;

function TSahBtr.ReadSpeVal:double;
begin
  Result := oBtrTable.FieldByName('SpeVal').AsFloat;
end;

procedure TSahBtr.WriteSpeVal(pValue:double);
begin
  oBtrTable.FieldByName('SpeVal').AsFloat := pValue;
end;

function TSahBtr.ReadSpiVat:double;
begin
  Result := oBtrTable.FieldByName('SpiVat').AsFloat;
end;

procedure TSahBtr.WriteSpiVat(pValue:double);
begin
  oBtrTable.FieldByName('SpiVat').AsFloat := pValue;
end;

function TSahBtr.ReadSpeVat:double;
begin
  Result := oBtrTable.FieldByName('SpeVat').AsFloat;
end;

procedure TSahBtr.WriteSpeVat(pValue:double);
begin
  oBtrTable.FieldByName('SpeVat').AsFloat := pValue;
end;

function TSahBtr.ReadCseVal:double;
begin
  Result := oBtrTable.FieldByName('CseVal').AsFloat;
end;

procedure TSahBtr.WriteCseVal(pValue:double);
begin
  oBtrTable.FieldByName('CseVal').AsFloat := pValue;
end;

function TSahBtr.ReadSpiDoc:Str12;
begin
  Result := oBtrTable.FieldByName('SpiDoc').AsString;
end;

procedure TSahBtr.WriteSpiDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('SpiDoc').AsString := pValue;
end;

function TSahBtr.ReadSpeDoc:Str12;
begin
  Result := oBtrTable.FieldByName('SpeDoc').AsString;
end;

procedure TSahBtr.WriteSpeDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('SpeDoc').AsString := pValue;
end;

function TSahBtr.ReadSpvDoc:Str12;
begin
  Result := oBtrTable.FieldByName('SpvDoc').AsString;
end;

procedure TSahBtr.WriteSpvDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('SpvDoc').AsString := pValue;
end;

function TSahBtr.ReadCrcDoc:Str12;
begin
  Result := oBtrTable.FieldByName('CrcDoc').AsString;
end;

procedure TSahBtr.WriteCrcDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('CrcDoc').AsString := pValue;
end;

function TSahBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TSahBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSahBtr.ReadIncCse:Str12;
begin
  Result := oBtrTable.FieldByName('IncCse').AsString;
end;

procedure TSahBtr.WriteIncCse(pValue:Str12);
begin
  oBtrTable.FieldByName('IncCse').AsString := pValue;
end;

function TSahBtr.ReadIncCsi:Str12;
begin
  Result := oBtrTable.FieldByName('IncCsi').AsString;
end;

procedure TSahBtr.WriteIncCsi(pValue:Str12);
begin
  oBtrTable.FieldByName('IncCsi').AsString := pValue;
end;

function TSahBtr.ReadVatPrc4:double;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TSahBtr.WriteVatPrc4(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TSahBtr.ReadAValue4:double;
begin
  Result := oBtrTable.FieldByName('AValue4').AsFloat;
end;

procedure TSahBtr.WriteAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal4:double;
begin
  Result := oBtrTable.FieldByName('VatVal4').AsFloat;
end;

procedure TSahBtr.WriteVatVal4(pValue:double);
begin
  oBtrTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TSahBtr.ReadBValue4:double;
begin
  Result := oBtrTable.FieldByName('BValue4').AsFloat;
end;

procedure TSahBtr.WriteBValue4(pValue:double);
begin
  oBtrTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TSahBtr.ReadVatPrc5:double;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TSahBtr.WriteVatPrc5(pValue:double);
begin
  oBtrTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TSahBtr.ReadAValue5:double;
begin
  Result := oBtrTable.FieldByName('AValue5').AsFloat;
end;

procedure TSahBtr.WriteAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TSahBtr.ReadVatVal5:double;
begin
  Result := oBtrTable.FieldByName('VatVal5').AsFloat;
end;

procedure TSahBtr.WriteVatVal5(pValue:double);
begin
  oBtrTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TSahBtr.ReadBValue5:double;
begin
  Result := oBtrTable.FieldByName('BValue5').AsFloat;
end;

procedure TSahBtr.WriteBValue5(pValue:double);
begin
  oBtrTable.FieldByName('BValue5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSahBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSahBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSahBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSahBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSahBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSahBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSahBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSahBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSahBtr.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindKey([pAValue]);
end;

function TSahBtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TSahBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TSahBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TSahBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSahBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSahBtr.NearestAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oBtrTable.FindNearest([pAValue]);
end;

function TSahBtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TSahBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TSahBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

procedure TSahBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSahBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSahBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSahBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSahBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSahBtr.First;
begin
  oBtrTable.First;
end;

procedure TSahBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSahBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSahBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSahBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSahBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSahBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSahBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSahBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSahBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSahBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSahBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
