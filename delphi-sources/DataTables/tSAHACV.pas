unit tSAHACV;

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
  TSahacvTmp = class (TComponent)
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
    function  ReadBvlDoc:Str12;          procedure WriteBvlDoc (pValue:Str12);
    function  ReadSpiDoc:Str12;          procedure WriteSpiDoc (pValue:Str12);
    function  ReadSpeDoc:Str12;          procedure WriteSpeDoc (pValue:Str12);
    function  ReadSpvDoc:Str12;          procedure WriteSpvDoc (pValue:Str12);
    function  ReadCseDoc:Str12;          procedure WriteCseDoc (pValue:Str12);
    function  ReadCsiDoc:Str12;          procedure WriteCsiDoc (pValue:Str12);
    function  ReadIncCse:Str12;          procedure WriteIncCse (pValue:Str12);
    function  ReadIncCsi:Str12;          procedure WriteIncCsi (pValue:Str12);
    function  ReadCrcDoc:Str12;          procedure WriteCrcDoc (pValue:Str12);
    function  ReadxBvlVal:double;        procedure WritexBvlVal (pValue:double);
    function  ReadxSpiVal:double;        procedure WritexSpiVal (pValue:double);
    function  ReadxSpeVal:double;        procedure WritexSpeVal (pValue:double);
    function  ReadxSpvVal:double;        procedure WritexSpvVal (pValue:double);
    function  ReadxCseVal:double;        procedure WritexCseVal (pValue:double);
    function  ReadxCsiVal:double;        procedure WritexCsiVal (pValue:double);
    function  ReadxIneVal:double;        procedure WritexIneVal (pValue:double);
    function  ReadxIniVal:double;        procedure WritexIniVal (pValue:double);
    function  ReaddBvlVal:double;        procedure WritedBvlVal (pValue:double);
    function  ReaddSpiVal:double;        procedure WritedSpiVal (pValue:double);
    function  ReaddSpeVal:double;        procedure WritedSpeVal (pValue:double);
    function  ReaddSpvVal:double;        procedure WritedSpvVal (pValue:double);
    function  ReaddCseVal:double;        procedure WritedCseVal (pValue:double);
    function  ReaddCsiVal:double;        procedure WritedCsiVal (pValue:double);
    function  ReaddIneVal:double;        procedure WritedIneVal (pValue:double);
    function  ReaddIniVal:double;        procedure WritedIniVal (pValue:double);
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
    property BvlDoc:Str12 read ReadBvlDoc write WriteBvlDoc;
    property SpiDoc:Str12 read ReadSpiDoc write WriteSpiDoc;
    property SpeDoc:Str12 read ReadSpeDoc write WriteSpeDoc;
    property SpvDoc:Str12 read ReadSpvDoc write WriteSpvDoc;
    property CseDoc:Str12 read ReadCseDoc write WriteCseDoc;
    property CsiDoc:Str12 read ReadCsiDoc write WriteCsiDoc;
    property IncCse:Str12 read ReadIncCse write WriteIncCse;
    property IncCsi:Str12 read ReadIncCsi write WriteIncCsi;
    property CrcDoc:Str12 read ReadCrcDoc write WriteCrcDoc;
    property xBvlVal:double read ReadxBvlVal write WritexBvlVal;
    property xSpiVal:double read ReadxSpiVal write WritexSpiVal;
    property xSpeVal:double read ReadxSpeVal write WritexSpeVal;
    property xSpvVal:double read ReadxSpvVal write WritexSpvVal;
    property xCseVal:double read ReadxCseVal write WritexCseVal;
    property xCsiVal:double read ReadxCsiVal write WritexCsiVal;
    property xIneVal:double read ReadxIneVal write WritexIneVal;
    property xIniVal:double read ReadxIniVal write WritexIniVal;
    property dBvlVal:double read ReaddBvlVal write WritedBvlVal;
    property dSpiVal:double read ReaddSpiVal write WritedSpiVal;
    property dSpeVal:double read ReaddSpeVal write WritedSpeVal;
    property dSpvVal:double read ReaddSpvVal write WritedSpvVal;
    property dCseVal:double read ReaddCseVal write WritedCseVal;
    property dCsiVal:double read ReaddCsiVal write WritedCsiVal;
    property dIneVal:double read ReaddIneVal write WritedIneVal;
    property dIniVal:double read ReaddIniVal write WritedIniVal;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSahacvTmp.Create;
begin
  oTmpTable := TmpInit ('SAHACV',Self);
end;

destructor TSahacvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSahacvTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSahacvTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSahacvTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSahacvTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSahacvTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSahacvTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSahacvTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSahacvTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TSahacvTmp.ReadVatPrc1:double;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsFloat;
end;

procedure TSahacvTmp.WriteVatPrc1(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc1').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatPrc2:double;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsFloat;
end;

procedure TSahacvTmp.WriteVatPrc2(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc2').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatPrc3:double;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsFloat;
end;

procedure TSahacvTmp.WriteVatPrc3(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc3').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatPrc4:double;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsFloat;
end;

procedure TSahacvTmp.WriteVatPrc4(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc4').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatPrc5:double;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsFloat;
end;

procedure TSahacvTmp.WriteVatPrc5(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc5').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue1:double;
begin
  Result := oTmpTable.FieldByName('AValue1').AsFloat;
end;

procedure TSahacvTmp.WriteAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue2:double;
begin
  Result := oTmpTable.FieldByName('AValue2').AsFloat;
end;

procedure TSahacvTmp.WriteAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue3:double;
begin
  Result := oTmpTable.FieldByName('AValue3').AsFloat;
end;

procedure TSahacvTmp.WriteAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue4:double;
begin
  Result := oTmpTable.FieldByName('AValue4').AsFloat;
end;

procedure TSahacvTmp.WriteAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue5:double;
begin
  Result := oTmpTable.FieldByName('AValue5').AsFloat;
end;

procedure TSahacvTmp.WriteAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue1:double;
begin
  Result := oTmpTable.FieldByName('BValue1').AsFloat;
end;

procedure TSahacvTmp.WriteBValue1(pValue:double);
begin
  oTmpTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue2:double;
begin
  Result := oTmpTable.FieldByName('BValue2').AsFloat;
end;

procedure TSahacvTmp.WriteBValue2(pValue:double);
begin
  oTmpTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue3:double;
begin
  Result := oTmpTable.FieldByName('BValue3').AsFloat;
end;

procedure TSahacvTmp.WriteBValue3(pValue:double);
begin
  oTmpTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue4:double;
begin
  Result := oTmpTable.FieldByName('BValue4').AsFloat;
end;

procedure TSahacvTmp.WriteBValue4(pValue:double);
begin
  oTmpTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue5:double;
begin
  Result := oTmpTable.FieldByName('BValue5').AsFloat;
end;

procedure TSahacvTmp.WriteBValue5(pValue:double);
begin
  oTmpTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TSahacvTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSahacvTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSahacvTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSahacvTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSahacvTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TSahacvTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSahacvTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSahacvTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TSahacvTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadNsiCnt:word;
begin
  Result := oTmpTable.FieldByName('NsiCnt').AsInteger;
end;

procedure TSahacvTmp.WriteNsiCnt(pValue:word);
begin
  oTmpTable.FieldByName('NsiCnt').AsInteger := pValue;
end;

function TSahacvTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSahacvTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSahacvTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSahacvTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSahacvTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSahacvTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSahacvTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSahacvTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSahacvTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSahacvTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSahacvTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSahacvTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSahacvTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSahacvTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSahacvTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSahacvTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSahacvTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TSahacvTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSahacvTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TSahacvTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TSahacvTmp.ReadCAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TSahacvTmp.WriteCAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TSahacvTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TSahacvTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TSahacvTmp.ReadDAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TSahacvTmp.WriteDAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TSahacvTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TSahacvTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TSahacvTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TSahacvTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TSahacvTmp.ReadIValue:double;
begin
  Result := oTmpTable.FieldByName('IValue').AsFloat;
end;

procedure TSahacvTmp.WriteIValue(pValue:double);
begin
  oTmpTable.FieldByName('IValue').AsFloat := pValue;
end;

function TSahacvTmp.ReadGscVal:double;
begin
  Result := oTmpTable.FieldByName('GscVal').AsFloat;
end;

procedure TSahacvTmp.WriteGscVal(pValue:double);
begin
  oTmpTable.FieldByName('GscVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadGscVat:double;
begin
  Result := oTmpTable.FieldByName('GscVat').AsFloat;
end;

procedure TSahacvTmp.WriteGscVat(pValue:double);
begin
  oTmpTable.FieldByName('GscVat').AsFloat := pValue;
end;

function TSahacvTmp.ReadGscBvl:double;
begin
  Result := oTmpTable.FieldByName('GscBvl').AsFloat;
end;

procedure TSahacvTmp.WriteGscBvl(pValue:double);
begin
  oTmpTable.FieldByName('GscBvl').AsFloat := pValue;
end;

function TSahacvTmp.ReadSecVal:double;
begin
  Result := oTmpTable.FieldByName('SecVal').AsFloat;
end;

procedure TSahacvTmp.WriteSecVal(pValue:double);
begin
  oTmpTable.FieldByName('SecVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadSecVat:double;
begin
  Result := oTmpTable.FieldByName('SecVat').AsFloat;
end;

procedure TSahacvTmp.WriteSecVat(pValue:double);
begin
  oTmpTable.FieldByName('SecVat').AsFloat := pValue;
end;

function TSahacvTmp.ReadSecBvl:double;
begin
  Result := oTmpTable.FieldByName('SecBvl').AsFloat;
end;

procedure TSahacvTmp.WriteSecBvl(pValue:double);
begin
  oTmpTable.FieldByName('SecBvl').AsFloat := pValue;
end;

function TSahacvTmp.ReadTrnVal:double;
begin
  Result := oTmpTable.FieldByName('TrnVal').AsFloat;
end;

procedure TSahacvTmp.WriteTrnVal(pValue:double);
begin
  oTmpTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadTrnVat:double;
begin
  Result := oTmpTable.FieldByName('TrnVat').AsFloat;
end;

procedure TSahacvTmp.WriteTrnVat(pValue:double);
begin
  oTmpTable.FieldByName('TrnVat').AsFloat := pValue;
end;

function TSahacvTmp.ReadTrnBvl:double;
begin
  Result := oTmpTable.FieldByName('TrnBvl').AsFloat;
end;

procedure TSahacvTmp.WriteTrnBvl(pValue:double);
begin
  oTmpTable.FieldByName('TrnBvl').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpiVal:double;
begin
  Result := oTmpTable.FieldByName('SpiVal').AsFloat;
end;

procedure TSahacvTmp.WriteSpiVal(pValue:double);
begin
  oTmpTable.FieldByName('SpiVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpiVat:double;
begin
  Result := oTmpTable.FieldByName('SpiVat').AsFloat;
end;

procedure TSahacvTmp.WriteSpiVat(pValue:double);
begin
  oTmpTable.FieldByName('SpiVat').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpiBvl:double;
begin
  Result := oTmpTable.FieldByName('SpiBvl').AsFloat;
end;

procedure TSahacvTmp.WriteSpiBvl(pValue:double);
begin
  oTmpTable.FieldByName('SpiBvl').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpeVal:double;
begin
  Result := oTmpTable.FieldByName('SpeVal').AsFloat;
end;

procedure TSahacvTmp.WriteSpeVal(pValue:double);
begin
  oTmpTable.FieldByName('SpeVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpeVat:double;
begin
  Result := oTmpTable.FieldByName('SpeVat').AsFloat;
end;

procedure TSahacvTmp.WriteSpeVat(pValue:double);
begin
  oTmpTable.FieldByName('SpeVat').AsFloat := pValue;
end;

function TSahacvTmp.ReadSpeBvl:double;
begin
  Result := oTmpTable.FieldByName('SpeBvl').AsFloat;
end;

procedure TSahacvTmp.WriteSpeBvl(pValue:double);
begin
  oTmpTable.FieldByName('SpeBvl').AsFloat := pValue;
end;

function TSahacvTmp.ReadCseVal:double;
begin
  Result := oTmpTable.FieldByName('CseVal').AsFloat;
end;

procedure TSahacvTmp.WriteCseVal(pValue:double);
begin
  oTmpTable.FieldByName('CseVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadCrcVal:double;
begin
  Result := oTmpTable.FieldByName('CrcVal').AsFloat;
end;

procedure TSahacvTmp.WriteCrcVal(pValue:double);
begin
  oTmpTable.FieldByName('CrcVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TSahacvTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadBvlDoc:Str12;
begin
  Result := oTmpTable.FieldByName('BvlDoc').AsString;
end;

procedure TSahacvTmp.WriteBvlDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('BvlDoc').AsString := pValue;
end;

function TSahacvTmp.ReadSpiDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpiDoc').AsString;
end;

procedure TSahacvTmp.WriteSpiDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpiDoc').AsString := pValue;
end;

function TSahacvTmp.ReadSpeDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpeDoc').AsString;
end;

procedure TSahacvTmp.WriteSpeDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpeDoc').AsString := pValue;
end;

function TSahacvTmp.ReadSpvDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SpvDoc').AsString;
end;

procedure TSahacvTmp.WriteSpvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SpvDoc').AsString := pValue;
end;

function TSahacvTmp.ReadCseDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CseDoc').AsString;
end;

procedure TSahacvTmp.WriteCseDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CseDoc').AsString := pValue;
end;

function TSahacvTmp.ReadCsiDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CsiDoc').AsString;
end;

procedure TSahacvTmp.WriteCsiDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CsiDoc').AsString := pValue;
end;

function TSahacvTmp.ReadIncCse:Str12;
begin
  Result := oTmpTable.FieldByName('IncCse').AsString;
end;

procedure TSahacvTmp.WriteIncCse(pValue:Str12);
begin
  oTmpTable.FieldByName('IncCse').AsString := pValue;
end;

function TSahacvTmp.ReadIncCsi:Str12;
begin
  Result := oTmpTable.FieldByName('IncCsi').AsString;
end;

procedure TSahacvTmp.WriteIncCsi(pValue:Str12);
begin
  oTmpTable.FieldByName('IncCsi').AsString := pValue;
end;

function TSahacvTmp.ReadCrcDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CrcDoc').AsString;
end;

procedure TSahacvTmp.WriteCrcDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CrcDoc').AsString := pValue;
end;

function TSahacvTmp.ReadxBvlVal:double;
begin
  Result := oTmpTable.FieldByName('xBvlVal').AsFloat;
end;

procedure TSahacvTmp.WritexBvlVal(pValue:double);
begin
  oTmpTable.FieldByName('xBvlVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxSpiVal:double;
begin
  Result := oTmpTable.FieldByName('xSpiVal').AsFloat;
end;

procedure TSahacvTmp.WritexSpiVal(pValue:double);
begin
  oTmpTable.FieldByName('xSpiVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxSpeVal:double;
begin
  Result := oTmpTable.FieldByName('xSpeVal').AsFloat;
end;

procedure TSahacvTmp.WritexSpeVal(pValue:double);
begin
  oTmpTable.FieldByName('xSpeVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxSpvVal:double;
begin
  Result := oTmpTable.FieldByName('xSpvVal').AsFloat;
end;

procedure TSahacvTmp.WritexSpvVal(pValue:double);
begin
  oTmpTable.FieldByName('xSpvVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxCseVal:double;
begin
  Result := oTmpTable.FieldByName('xCseVal').AsFloat;
end;

procedure TSahacvTmp.WritexCseVal(pValue:double);
begin
  oTmpTable.FieldByName('xCseVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxCsiVal:double;
begin
  Result := oTmpTable.FieldByName('xCsiVal').AsFloat;
end;

procedure TSahacvTmp.WritexCsiVal(pValue:double);
begin
  oTmpTable.FieldByName('xCsiVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxIneVal:double;
begin
  Result := oTmpTable.FieldByName('xIneVal').AsFloat;
end;

procedure TSahacvTmp.WritexIneVal(pValue:double);
begin
  oTmpTable.FieldByName('xIneVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadxIniVal:double;
begin
  Result := oTmpTable.FieldByName('xIniVal').AsFloat;
end;

procedure TSahacvTmp.WritexIniVal(pValue:double);
begin
  oTmpTable.FieldByName('xIniVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddBvlVal:double;
begin
  Result := oTmpTable.FieldByName('dBvlVal').AsFloat;
end;

procedure TSahacvTmp.WritedBvlVal(pValue:double);
begin
  oTmpTable.FieldByName('dBvlVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddSpiVal:double;
begin
  Result := oTmpTable.FieldByName('dSpiVal').AsFloat;
end;

procedure TSahacvTmp.WritedSpiVal(pValue:double);
begin
  oTmpTable.FieldByName('dSpiVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddSpeVal:double;
begin
  Result := oTmpTable.FieldByName('dSpeVal').AsFloat;
end;

procedure TSahacvTmp.WritedSpeVal(pValue:double);
begin
  oTmpTable.FieldByName('dSpeVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddSpvVal:double;
begin
  Result := oTmpTable.FieldByName('dSpvVal').AsFloat;
end;

procedure TSahacvTmp.WritedSpvVal(pValue:double);
begin
  oTmpTable.FieldByName('dSpvVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddCseVal:double;
begin
  Result := oTmpTable.FieldByName('dCseVal').AsFloat;
end;

procedure TSahacvTmp.WritedCseVal(pValue:double);
begin
  oTmpTable.FieldByName('dCseVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddCsiVal:double;
begin
  Result := oTmpTable.FieldByName('dCsiVal').AsFloat;
end;

procedure TSahacvTmp.WritedCsiVal(pValue:double);
begin
  oTmpTable.FieldByName('dCsiVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddIneVal:double;
begin
  Result := oTmpTable.FieldByName('dIneVal').AsFloat;
end;

procedure TSahacvTmp.WritedIneVal(pValue:double);
begin
  oTmpTable.FieldByName('dIneVal').AsFloat := pValue;
end;

function TSahacvTmp.ReaddIniVal:double;
begin
  Result := oTmpTable.FieldByName('dIniVal').AsFloat;
end;

procedure TSahacvTmp.WritedIniVal(pValue:double);
begin
  oTmpTable.FieldByName('dIniVal').AsFloat := pValue;
end;

function TSahacvTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSahacvTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSahacvTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSahacvTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSahacvTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSahacvTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSahacvTmp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TSahacvTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TSahacvTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

function TSahacvTmp.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oTmpTable.FindKey([pDstAcc]);
end;

procedure TSahacvTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSahacvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSahacvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSahacvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSahacvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSahacvTmp.First;
begin
  oTmpTable.First;
end;

procedure TSahacvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSahacvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSahacvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSahacvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSahacvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSahacvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSahacvTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSahacvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSahacvTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSahacvTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSahacvTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
