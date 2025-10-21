unit tTOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixDocDate = 'DocDate';
  ixTnTi = 'TnTi';
  ixInIi = 'InIi';
  ixEpdUsrc = 'EpdUsrc';
  ixEpaUsrc = 'EpaUsrc';
  ixEptUsrc = 'EptUsrc';
  ixEpsUsrc = 'EpsUsrc';
  ixDnGc = 'DnGc';

type
  TToiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadHPrice:double;         procedure WriteHPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadCasNum:byte;           procedure WriteCasNum (pValue:byte);
    function  ReadCadNum:Str12;          procedure WriteCadNum (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadPrcDst:Str1;           procedure WritePrcDst (pValue:Str1);
    function  ReadEpdUsrc:Str10;         procedure WriteEpdUsrc (pValue:Str10);
    function  ReadEpaUsrc:Str10;         procedure WriteEpaUsrc (pValue:Str10);
    function  ReadEptUsrc:Str10;         procedure WriteEptUsrc (pValue:Str10);
    function  ReadEpsUsrc:Str10;         procedure WriteEpsUsrc (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function LocateInIi (pIcdNum:Str12;pIcdItm:word):boolean;
    function LocateEpdUsrc (pEpdUsrc:Str10):boolean;
    function LocateEpaUsrc (pEpaUsrc:Str10):boolean;
    function LocateEptUsrc (pEptUsrc:Str10):boolean;
    function LocateEpsUsrc (pEpsUsrc:Str10):boolean;
    function LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property HPrice:double read ReadHPrice write WriteHPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property CasNum:byte read ReadCasNum write WriteCasNum;
    property CadNum:Str12 read ReadCadNum write WriteCadNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property PrcDst:Str1 read ReadPrcDst write WritePrcDst;
    property EpdUsrc:Str10 read ReadEpdUsrc write WriteEpdUsrc;
    property EpaUsrc:Str10 read ReadEpaUsrc write WriteEpaUsrc;
    property EptUsrc:Str10 read ReadEptUsrc write WriteEptUsrc;
    property EpsUsrc:Str10 read ReadEpsUsrc write WriteEpsUsrc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
  end;

implementation

constructor TToiTmp.Create;
begin
  oTmpTable := TmpInit ('TOI',Self);
end;

destructor TToiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TToiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TToiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TToiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TToiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TToiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TToiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TToiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TToiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TToiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TToiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TToiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TToiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TToiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TToiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TToiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TToiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TToiTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TToiTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TToiTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TToiTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TToiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TToiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TToiTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TToiTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TToiTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TToiTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TToiTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TToiTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TToiTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TToiTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TToiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TToiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TToiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TToiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TToiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TToiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TToiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TToiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TToiTmp.ReadHPrice:double;
begin
  Result := oTmpTable.FieldByName('HPrice').AsFloat;
end;

procedure TToiTmp.WriteHPrice(pValue:double);
begin
  oTmpTable.FieldByName('HPrice').AsFloat := pValue;
end;

function TToiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TToiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TToiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TToiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TToiTmp.ReadDValue:double;
begin
  Result := oTmpTable.FieldByName('DValue').AsFloat;
end;

procedure TToiTmp.WriteDValue(pValue:double);
begin
  oTmpTable.FieldByName('DValue').AsFloat := pValue;
end;

function TToiTmp.ReadHValue:double;
begin
  Result := oTmpTable.FieldByName('HValue').AsFloat;
end;

procedure TToiTmp.WriteHValue(pValue:double);
begin
  oTmpTable.FieldByName('HValue').AsFloat := pValue;
end;

function TToiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TToiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TToiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TToiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TToiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TToiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TToiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TToiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TToiTmp.ReadCasNum:byte;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TToiTmp.WriteCasNum(pValue:byte);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TToiTmp.ReadCadNum:Str12;
begin
  Result := oTmpTable.FieldByName('CadNum').AsString;
end;

procedure TToiTmp.WriteCadNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CadNum').AsString := pValue;
end;

function TToiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TToiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TToiTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TToiTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TToiTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TToiTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TToiTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TToiTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TToiTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TToiTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TToiTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TToiTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TToiTmp.ReadPrcDst:Str1;
begin
  Result := oTmpTable.FieldByName('PrcDst').AsString;
end;

procedure TToiTmp.WritePrcDst(pValue:Str1);
begin
  oTmpTable.FieldByName('PrcDst').AsString := pValue;
end;

function TToiTmp.ReadEpdUsrc:Str10;
begin
  Result := oTmpTable.FieldByName('EpdUsrc').AsString;
end;

procedure TToiTmp.WriteEpdUsrc(pValue:Str10);
begin
  oTmpTable.FieldByName('EpdUsrc').AsString := pValue;
end;

function TToiTmp.ReadEpaUsrc:Str10;
begin
  Result := oTmpTable.FieldByName('EpaUsrc').AsString;
end;

procedure TToiTmp.WriteEpaUsrc(pValue:Str10);
begin
  oTmpTable.FieldByName('EpaUsrc').AsString := pValue;
end;

function TToiTmp.ReadEptUsrc:Str10;
begin
  Result := oTmpTable.FieldByName('EptUsrc').AsString;
end;

procedure TToiTmp.WriteEptUsrc(pValue:Str10);
begin
  oTmpTable.FieldByName('EptUsrc').AsString := pValue;
end;

function TToiTmp.ReadEpsUsrc:Str10;
begin
  Result := oTmpTable.FieldByName('EpsUsrc').AsString;
end;

procedure TToiTmp.WriteEpsUsrc(pValue:Str10);
begin
  oTmpTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TToiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TToiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TToiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TToiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TToiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TToiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TToiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TToiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TToiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TToiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TToiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TToiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TToiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TToiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TToiTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TToiTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TToiTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TToiTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TToiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TToiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TToiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TToiTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TToiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TToiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TToiTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TToiTmp.LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oTmpTable.FindKey([pTcdNum,pTcdItm]);
end;

function TToiTmp.LocateInIi (pIcdNum:Str12;pIcdItm:word):boolean;
begin
  SetIndex (ixInIi);
  Result := oTmpTable.FindKey([pIcdNum,pIcdItm]);
end;

function TToiTmp.LocateEpdUsrc (pEpdUsrc:Str10):boolean;
begin
  SetIndex (ixEpdUsrc);
  Result := oTmpTable.FindKey([pEpdUsrc]);
end;

function TToiTmp.LocateEpaUsrc (pEpaUsrc:Str10):boolean;
begin
  SetIndex (ixEpaUsrc);
  Result := oTmpTable.FindKey([pEpaUsrc]);
end;

function TToiTmp.LocateEptUsrc (pEptUsrc:Str10):boolean;
begin
  SetIndex (ixEptUsrc);
  Result := oTmpTable.FindKey([pEptUsrc]);
end;

function TToiTmp.LocateEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oTmpTable.FindKey([pEpsUsrc]);
end;

function TToiTmp.LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oTmpTable.FindKey([pDocNum,pGsCode]);
end;

procedure TToiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TToiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TToiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TToiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TToiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TToiTmp.First;
begin
  oTmpTable.First;
end;

procedure TToiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TToiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TToiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TToiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TToiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TToiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TToiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TToiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TToiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TToiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TToiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
