unit bPOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixDocDate = 'DocDate';
  ixOnOi = 'OnOi';
  ixTnTi = 'TnTi';
  ixInIi = 'InIi';
  ixEpdUsrc = 'EpdUsrc';
  ixEpaUsrc = 'EpaUsrc';
  ixEptUsrc = 'EptUsrc';
  ixEpsUsrc = 'EpsUsrc';
  ixDnGc = 'DnGc';

type
  TPoiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
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
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadReoNum:byte;           procedure WriteReoNum (pValue:byte);
    function  ReadRerNum:byte;           procedure WriteRerNum (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function LocateInIi (pIcdNum:Str12;pIcdItm:word):boolean;
    function LocateEpdUsrc (pEpdUsrc:Str10):boolean;
    function LocateEpaUsrc (pEpaUsrc:Str10):boolean;
    function LocateEptUsrc (pEptUsrc:Str10):boolean;
    function LocateEpsUsrc (pEpsUsrc:Str10):boolean;
    function LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function NearestTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function NearestInIi (pIcdNum:Str12;pIcdItm:word):boolean;
    function NearestEpdUsrc (pEpdUsrc:Str10):boolean;
    function NearestEpaUsrc (pEpaUsrc:Str10):boolean;
    function NearestEptUsrc (pEptUsrc:Str10):boolean;
    function NearestEpsUsrc (pEpsUsrc:Str10):boolean;
    function NearestDnGc (pDocNum:Str12;pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
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
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property ReoNum:byte read ReadReoNum write WriteReoNum;
    property RerNum:byte read ReadRerNum write WriteRerNum;
  end;

implementation

constructor TPoiBtr.Create;
begin
  oBtrTable := BtrInit ('POI',gPath.StkPath,Self);
end;

constructor TPoiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('POI',pPath,Self);
end;

destructor TPoiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPoiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPoiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPoiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPoiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPoiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPoiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPoiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TPoiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPoiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPoiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPoiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TPoiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TPoiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TPoiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TPoiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TPoiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TPoiBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TPoiBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TPoiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TPoiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TPoiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPoiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPoiBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TPoiBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TPoiBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TPoiBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPoiBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TPoiBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TPoiBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TPoiBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TPoiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPoiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPoiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TPoiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TPoiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPoiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPoiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPoiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPoiBtr.ReadHPrice:double;
begin
  Result := oBtrTable.FieldByName('HPrice').AsFloat;
end;

procedure TPoiBtr.WriteHPrice(pValue:double);
begin
  oBtrTable.FieldByName('HPrice').AsFloat := pValue;
end;

function TPoiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TPoiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TPoiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TPoiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TPoiBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TPoiBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TPoiBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TPoiBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TPoiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TPoiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TPoiBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TPoiBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TPoiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPoiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPoiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPoiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPoiBtr.ReadCasNum:byte;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TPoiBtr.WriteCasNum(pValue:byte);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TPoiBtr.ReadCadNum:Str12;
begin
  Result := oBtrTable.FieldByName('CadNum').AsString;
end;

procedure TPoiBtr.WriteCadNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CadNum').AsString := pValue;
end;

function TPoiBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TPoiBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TPoiBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TPoiBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TPoiBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TPoiBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TPoiBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TPoiBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TPoiBtr.ReadPrcDst:Str1;
begin
  Result := oBtrTable.FieldByName('PrcDst').AsString;
end;

procedure TPoiBtr.WritePrcDst(pValue:Str1);
begin
  oBtrTable.FieldByName('PrcDst').AsString := pValue;
end;

function TPoiBtr.ReadEpdUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpdUsrc').AsString;
end;

procedure TPoiBtr.WriteEpdUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpdUsrc').AsString := pValue;
end;

function TPoiBtr.ReadEpaUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpaUsrc').AsString;
end;

procedure TPoiBtr.WriteEpaUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpaUsrc').AsString := pValue;
end;

function TPoiBtr.ReadEptUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EptUsrc').AsString;
end;

procedure TPoiBtr.WriteEptUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EptUsrc').AsString := pValue;
end;

function TPoiBtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TPoiBtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TPoiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPoiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPoiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPoiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPoiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPoiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPoiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPoiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPoiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPoiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPoiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPoiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPoiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPoiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPoiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TPoiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPoiBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TPoiBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TPoiBtr.ReadOcdQnt:double;
begin
  Result := oBtrTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TPoiBtr.WriteOcdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TPoiBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TPoiBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TPoiBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TPoiBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TPoiBtr.ReadReoNum:byte;
begin
  Result := oBtrTable.FieldByName('ReoNum').AsInteger;
end;

procedure TPoiBtr.WriteReoNum(pValue:byte);
begin
  oBtrTable.FieldByName('ReoNum').AsInteger := pValue;
end;

function TPoiBtr.ReadRerNum:byte;
begin
  Result := oBtrTable.FieldByName('RerNum').AsInteger;
end;

procedure TPoiBtr.WriteRerNum(pValue:byte);
begin
  oBtrTable.FieldByName('RerNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPoiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPoiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPoiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPoiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPoiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPoiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPoiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPoiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPoiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPoiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TPoiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPoiBtr.LocateOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindKey([pOcdNum,pOcdItm]);
end;

function TPoiBtr.LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindKey([pTcdNum,pTcdItm]);
end;

function TPoiBtr.LocateInIi (pIcdNum:Str12;pIcdItm:word):boolean;
begin
  SetIndex (ixInIi);
  Result := oBtrTable.FindKey([pIcdNum,pIcdItm]);
end;

function TPoiBtr.LocateEpdUsrc (pEpdUsrc:Str10):boolean;
begin
  SetIndex (ixEpdUsrc);
  Result := oBtrTable.FindKey([pEpdUsrc]);
end;

function TPoiBtr.LocateEpaUsrc (pEpaUsrc:Str10):boolean;
begin
  SetIndex (ixEpaUsrc);
  Result := oBtrTable.FindKey([pEpaUsrc]);
end;

function TPoiBtr.LocateEptUsrc (pEptUsrc:Str10):boolean;
begin
  SetIndex (ixEptUsrc);
  Result := oBtrTable.FindKey([pEptUsrc]);
end;

function TPoiBtr.LocateEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindKey([pEpsUsrc]);
end;

function TPoiBtr.LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TPoiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPoiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPoiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TPoiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TPoiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPoiBtr.NearestOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindNearest([pOcdNum,pOcdItm]);
end;

function TPoiBtr.NearestTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindNearest([pTcdNum,pTcdItm]);
end;

function TPoiBtr.NearestInIi (pIcdNum:Str12;pIcdItm:word):boolean;
begin
  SetIndex (ixInIi);
  Result := oBtrTable.FindNearest([pIcdNum,pIcdItm]);
end;

function TPoiBtr.NearestEpdUsrc (pEpdUsrc:Str10):boolean;
begin
  SetIndex (ixEpdUsrc);
  Result := oBtrTable.FindNearest([pEpdUsrc]);
end;

function TPoiBtr.NearestEpaUsrc (pEpaUsrc:Str10):boolean;
begin
  SetIndex (ixEpaUsrc);
  Result := oBtrTable.FindNearest([pEpaUsrc]);
end;

function TPoiBtr.NearestEptUsrc (pEptUsrc:Str10):boolean;
begin
  SetIndex (ixEptUsrc);
  Result := oBtrTable.FindNearest([pEptUsrc]);
end;

function TPoiBtr.NearestEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindNearest([pEpsUsrc]);
end;

function TPoiBtr.NearestDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

procedure TPoiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPoiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPoiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPoiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPoiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPoiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPoiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPoiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPoiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPoiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPoiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPoiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPoiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPoiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPoiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPoiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPoiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
