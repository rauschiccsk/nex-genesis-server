unit tSAH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixDocDate = 'DocDate';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixSended = 'Sended';
  ixDstAcc = 'DstAcc';

type
  TSahTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadVatPrc1:double;        procedure WriteVatPrc1 (pValue:double);
    function  ReadVatPrc2:double;        procedure WriteVatPrc2 (pValue:double);
    function  ReadVatPrc3:double;        procedure WriteVatPrc3 (pValue:double);
    function  ReadVatPrc4:double;        procedure WriteVatPrc4 (pValue:double);
    function  ReadVatPrc5:double;        procedure WriteVatPrc5 (pValue:double);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadAValue3:double;        procedure WriteAValue3 (pValue:double);
    function  ReadAValue4:double;        procedure WriteAValue4 (pValue:double);
    function  ReadAValue5:double;        procedure WriteAValue5 (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadVatVal4:double;        procedure WriteVatVal4 (pValue:double);
    function  ReadVatVal5:double;        procedure WriteVatVal5 (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadBValue4:double;        procedure WriteBValue4 (pValue:double);
    function  ReadBValue5:double;        procedure WriteBValue5 (pValue:double);
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
    function  ReadGscVal:double;         procedure WriteGscVal (pValue:double);
    function  ReadGscVat:double;         procedure WriteGscVat (pValue:double);
    function  ReadGscBvl:double;         procedure WriteGscBvl (pValue:double);
    function  ReadSecVal:double;         procedure WriteSecVal (pValue:double);
    function  ReadSecVat:double;         procedure WriteSecVat (pValue:double);
    function  ReadSecBvl:double;         procedure WriteSecBvl (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadTrnVat:double;         procedure WriteTrnVat (pValue:double);
    function  ReadTrnBvl:double;         procedure WriteTrnBvl (pValue:double);
    function  ReadSpiVal:double;         procedure WriteSpiVal (pValue:double);
    function  ReadSpiVat:double;         procedure WriteSpiVat (pValue:double);
    function  ReadSpiBvl:double;         procedure WriteSpiBvl (pValue:double);
    function  ReadSpeVal:double;         procedure WriteSpeVal (pValue:double);
    function  ReadSpeVat:double;         procedure WriteSpeVat (pValue:double);
    function  ReadSpeBvl:double;         procedure WriteSpeBvl (pValue:double);
    function  ReadCseVal:double;         procedure WriteCseVal (pValue:double);
    function  ReadCrcVal:double;         procedure WriteCrcVal (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadSpiDoc:Str12;          procedure WriteSpiDoc (pValue:Str12);
    function  ReadSpeDoc:Str12;          procedure WriteSpeDoc (pValue:Str12);
    function  ReadSpvDoc:Str12;          procedure WriteSpvDoc (pValue:Str12);
    function  ReadCrcDoc:Str12;          procedure WriteCrcDoc (pValue:Str12);
    function  ReadIncCse:Str12;          procedure WriteIncCse (pValue:Str12);
    function  ReadIncCsi:Str12;          procedure WriteIncCsi (pValue:Str12);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;

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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property VatPrc1:double read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:double read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:double read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:double read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:double read ReadVatPrc5 write WriteVatPrc5;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property AValue3:double read ReadAValue3 write WriteAValue3;
    property AValue4:double read ReadAValue4 write WriteAValue4;
    property AValue5:double read ReadAValue5 write WriteAValue5;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property VatVal4:double read ReadVatVal4 write WriteVatVal4;
    property VatVal5:double read ReadVatVal5 write WriteVatVal5;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property BValue4:double read ReadBValue4 write WriteBValue4;
    property BValue5:double read ReadBValue5 write WriteBValue5;
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
    property GscVal:double read ReadGscVal write WriteGscVal;
    property GscVat:double read ReadGscVat write WriteGscVat;
    property GscBvl:double read ReadGscBvl write WriteGscBvl;
    property SecVal:double read ReadSecVal write WriteSecVal;
    property SecVat:double read ReadSecVat write WriteSecVat;
    property SecBvl:double read ReadSecBvl write WriteSecBvl;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property TrnVat:double read ReadTrnVat write WriteTrnVat;
    property TrnBvl:double read ReadTrnBvl write WriteTrnBvl;
    property SpiVal:double read ReadSpiVal write WriteSpiVal;
    property SpiVat:double read ReadSpiVat write WriteSpiVat;
    property SpiBvl:double read ReadSpiBvl write WriteSpiBvl;
    property SpeVal:double read ReadSpeVal write WriteSpeVal;
    property SpeVat:double read ReadSpeVat write WriteSpeVat;
    property SpeBvl:double read ReadSpeBvl write WriteSpeBvl;
    property CseVal:double read ReadCseVal write WriteCseVal;
    property CrcVal:double read ReadCrcVal write WriteCrcVal;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property SpiDoc:Str12 read ReadSpiDoc write WriteSpiDoc;
    property SpeDoc:Str12 read ReadSpeDoc write WriteSpeDoc;
    property SpvDoc:Str12 read ReadSpvDoc write WriteSpvDoc;
    property CrcDoc:Str12 read ReadCrcDoc write WriteCrcDoc;
    property IncCse:Str12 read ReadIncCse write WriteIncCse;
    property IncCsi:Str12 read ReadIncCsi write WriteIncCsi;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSahTmp.Create;
begin
  oTmpTable := TmpInit ('SAH',Self);
end;

destructor TSahTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSahTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSahTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSahTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSahTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSahTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSahTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSahTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSahTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TSahTmp.ReadVatPrc1:double;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TSahTmp.WriteVatPrc1(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TSahTmp.ReadVatPrc2:double;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TSahTmp.WriteVatPrc2(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TSahTmp.ReadVatPrc3:double;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TSahTmp.WriteVatPrc3(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TSahTmp.ReadVatPrc4:double;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TSahTmp.WriteVatPrc4(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TSahTmp.ReadVatPrc5:double;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TSahTmp.WriteVatPrc5(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TSahTmp.ReadAValue1:double;
begin
  Result := oTmpTable.FieldByName('AValue1').AsFloat;
end;

procedure TSahTmp.WriteAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TSahTmp.ReadAValue2:double;
begin
  Result := oTmpTable.FieldByName('AValue2').AsFloat;
end;

procedure TSahTmp.WriteAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TSahTmp.ReadAValue3:double;
begin
  Result := oTmpTable.FieldByName('AValue3').AsFloat;
end;

procedure TSahTmp.WriteAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TSahTmp.ReadAValue4:double;
begin
  Result := oTmpTable.FieldByName('AValue4').AsFloat;
end;

procedure TSahTmp.WriteAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TSahTmp.ReadAValue5:double;
begin
  Result := oTmpTable.FieldByName('AValue5').AsFloat;
end;

procedure TSahTmp.WriteAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TSahTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TSahTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TSahTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TSahTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TSahTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TSahTmp.ReadBValue1:double;
begin
  Result := oTmpTable.FieldByName('BValue1').AsFloat;
end;

procedure TSahTmp.WriteBValue1(pValue:double);
begin
  oTmpTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TSahTmp.ReadBValue2:double;
begin
  Result := oTmpTable.FieldByName('BValue2').AsFloat;
end;

procedure TSahTmp.WriteBValue2(pValue:double);
begin
  oTmpTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TSahTmp.ReadBValue3:double;
begin
  Result := oTmpTable.FieldByName('BValue3').AsFloat;
end;

procedure TSahTmp.WriteBValue3(pValue:double);
begin
  oTmpTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TSahTmp.ReadBValue4:double;
begin
  Result := oTmpTable.FieldByName('BValue4').AsFloat;
end;

procedure TSahTmp.WriteBValue4(pValue:double);
begin
  oTmpTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TSahTmp.ReadBValue5:double;
begin
  Result := oTmpTable.FieldByName('BValue5').AsFloat;
end;

procedure TSahTmp.WriteBValue5(pValue:double);
begin
  oTmpTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TSahTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSahTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSahTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSahTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSahTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TSahTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TSahTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSahTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSahTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TSahTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSahTmp.ReadNsiCnt:word;
begin
  Result := oTmpTable.FieldByName('NsiCnt').AsInteger;
end;

procedure TSahTmp.WriteNsiCnt(pValue:word);
begin
  oTmpTable.FieldByName('NsiCnt').AsInteger := pValue;
end;

function TSahTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSahTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSahTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSahTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSahTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSahTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSahTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSahTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSahTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSahTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSahTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSahTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSahTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSahTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSahTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSahTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSahTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TSahTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSahTmp.ReadBvlDoc:Str12;
begin
  Result := oTmpTable.FieldByName('BvlDoc').AsString;
end;

procedure TSahTmp.WriteBvlDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('BvlDoc').AsString := pValue;
end;

function TSahTmp.ReadCseDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CseDoc').AsString;
end;

procedure TSahTmp.WriteCseDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CseDoc').AsString := pValue;
end;

function TSahTmp.ReadCsiDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CsiDoc').AsString;
end;

procedure TSahTmp.WriteCsiDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CsiDoc').AsString := pValue;
end;

function TSahTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TSahTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TSahTmp.ReadCAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TSahTmp.WriteCAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TSahTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TSahTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TSahTmp.ReadDAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TSahTmp.WriteDAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TSahTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TSahTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TSahTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TSahTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TSahTmp.ReadIValue:double;
begin
  Result := oTmpTable.FieldByName('IValue').AsFloat;
end;

procedure TSahTmp.WriteIValue(pValue:double);
begin
  oTmpTable.FieldByName('IValue').AsFloat := pValue;
end;

function TSahTmp.ReadGscVal:double;
begin
  Result := oTmpTable.FieldByName('GscVal').AsFloat;
end;

procedure TSahTmp.WriteGscVal(pValue:double);
begin
  oTmpTable.FieldByName('GscVal').AsFloat := pValue;
end;

function TSahTmp.ReadGscVat:double;
begin
  Result := oTmpTable.FieldByName('GscVat').AsFloat;
end;

procedure TSahTmp.WriteGscVat(pValue:double);
begin
  oTmpTable.FieldByName('GscVat').AsFloat := pValue;
end;

function TSahTmp.ReadGscBvl:double;
begin
  Result := oTmpTable.FieldByName('GscBvl').AsFloat;
end;

procedure TSahTmp.WriteGscBvl(pValue:double);
begin
  oTmpTable.FieldByName('GscBvl').AsFloat := pValue;
end;

function TSahTmp.ReadSecVal:double;
begin
  Result := oTmpTable.FieldByName('SecVal').AsFloat;
end;

procedure TSahTmp.WriteSecVal(pValue:double);
begin
  oTmpTable.FieldByName('SecVal').AsFloat := pValue;
end;

function TSahTmp.ReadSecVat:double;
begin
  Result := oTmpTable.FieldByName('SecVat').AsFloat;
end;

procedure TSahTmp.WriteSecVat(pValue:double);
begin
  oTmpTable.FieldByName('SecVat').AsFloat := pValue;
end;

function TSahTmp.ReadSecBvl:double;
begin
  Result := oTmpTable.FieldByName('SecBvl').AsFloat;
end;

procedure TSahTmp.WriteSecBvl(pValue:double);
begin
  oTmpTable.FieldByName('SecBvl').AsFloat := pValue;
end;

function TSahTmp.ReadTrnVal:double;
begin
  Result := oTmpTable.FieldByName('TrnVal').AsFloat;
end;

procedure TSahTmp.WriteTrnVal(pValue:double);
begin
  oTmpTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TSahTmp.ReadTrnVat:double;
begin
  Result := oTmpTable.FieldByName('TrnVat').AsFloat;
end;

procedure TSahTmp.WriteTrnVat(pValue:double);
begin
  oTmpTable.FieldByName('TrnVat').AsFloat := pValue;
end;

function TSahTmp.ReadTrnBvl:double;
begin
  Result := oTmpTable.FieldByName('TrnBvl').AsFloat;
end;

procedure TSahTmp.WriteTrnBvl(pValue:double);
begin
  oTmpTable.FieldByName('TrnBvl').AsFloat := pValue;
end;

function TSahTmp.ReadSpiVal:double;
begin
  Result := oTmpTable.FieldByName('SpiVal').AsFloat;
end;

procedure TSahTmp.WriteSpiVal(pValue:double);
begin
  oTmpTable.FieldByName('SpiVal').AsFloat := pValue;
end;

function TSahTmp.ReadSpiVat:double;
begin
  Result := oTmpTable.FieldByName('SpiVat').AsFloat;
end;

procedure TSahTmp.WriteSpiVat(pValue:double);
begin
  oTmpTable.FieldByName('SpiVat').AsFloat := pValue;
end;

function TSahTmp.ReadSpiBvl:double;
begin
  Result := oTmpTable.FieldByName('SpiBvl').AsFloat;
end;

procedure TSahTmp.WriteSpiBvl(pValue:double);
begin
  oTmpTable.FieldByName('SpiBvl').AsFloat := pValue;
end;

function TSahTmp.ReadSpeVal:double;
begin
  Result := oTmpTable.FieldByName('SpeVal').AsFloat;
end;

procedure TSahTmp.WriteSpeVal(pValue:double);
begin
  oTmpTable.FieldByName('SpeVal').AsFloat := pValue;
end;

function TSahTmp.ReadSpeVat:double;
begin
  Result := oTmpTable.FieldByName('SpeVat').AsFloat;
end;

procedure TSahTmp.WriteSpeVat(pValue:double);
begin
  oTmpTable.FieldByName('SpeVat').AsFloat := pValue;
end;

function TSahTmp.ReadSpeBvl:double;
begin
  Result := oTmpTable.FieldByName('SpeBvl').AsFloat;
end;

procedure TSahTmp.WriteSpeBvl(pValue:double);
begin
  oTmpTable.FieldByName('SpeBvl').AsFloat := pValue;
end;

function TSahTmp.ReadCseVal:double;
begin
  Result := oTmpTable.FieldByName('CseVal').AsFloat;
end;

procedure TSahTmp.WriteCseVal(pValue:double);
begin
  oTmpTable.FieldByName('CseVal').AsFloat := pValue;
end;

function TSahTmp.ReadCrcVal:double;
begin
  Result := oTmpTable.FieldByName('CrcVal').AsFloat;
end;

procedure TSahTmp.WriteCrcVal(pValue:double);
begin
  oTmpTable.FieldByName('CrcVal').AsFloat := pValue;
end;

function TSahTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TSahTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSahTmp.ReadSpiDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpiDoc').AsString;
end;

procedure TSahTmp.WriteSpiDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpiDoc').AsString := pValue;
end;

function TSahTmp.ReadSpeDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpeDoc').AsString;
end;

procedure TSahTmp.WriteSpeDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpeDoc').AsString := pValue;
end;

function TSahTmp.ReadSpvDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpvDoc').AsString;
end;

procedure TSahTmp.WriteSpvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpvDoc').AsString := pValue;
end;

function TSahTmp.ReadCrcDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CrcDoc').AsString;
end;

procedure TSahTmp.WriteCrcDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CrcDoc').AsString := pValue;
end;

function TSahTmp.ReadIncCse:Str12;
begin
  Result := oTmpTable.FieldByName('IncCse').AsString;
end;

procedure TSahTmp.WriteIncCse(pValue:Str12);
begin
  oTmpTable.FieldByName('IncCse').AsString := pValue;
end;

function TSahTmp.ReadIncCsi:Str12;
begin
  Result := oTmpTable.FieldByName('IncCsi').AsString;
end;

procedure TSahTmp.WriteIncCsi(pValue:Str12);
begin
  oTmpTable.FieldByName('IncCsi').AsString := pValue;
end;

function TSahTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSahTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSahTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSahTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSahTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSahTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSahTmp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TSahTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TSahTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

function TSahTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

procedure TSahTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSahTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSahTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSahTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSahTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSahTmp.First;
begin
  oTmpTable.First;
end;

procedure TSahTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSahTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSahTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSahTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSahTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSahTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSahTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSahTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSahTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSahTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSahTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
