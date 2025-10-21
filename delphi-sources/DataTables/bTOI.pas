unit bTOI;

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
  TToiBtr = class (TComponent)
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
    function  ReadNcdNum:Str12;          procedure WriteNcdNum (pValue:Str12);
    function  ReadNcdItm:word;           procedure WriteNcdItm (pValue:word);
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
    property NcdNum:Str12 read ReadNcdNum write WriteNcdNum;
    property NcdItm:word read ReadNcdItm write WriteNcdItm;
  end;

implementation

constructor TToiBtr.Create;
begin
  oBtrTable := BtrInit ('TOI',gPath.StkPath,Self);
end;

constructor TToiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TOI',pPath,Self);
end;

destructor TToiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TToiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TToiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TToiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TToiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TToiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TToiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TToiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TToiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TToiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TToiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TToiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TToiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TToiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TToiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TToiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TToiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TToiBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TToiBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TToiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TToiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TToiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TToiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TToiBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TToiBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TToiBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TToiBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TToiBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TToiBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TToiBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TToiBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TToiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TToiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TToiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TToiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TToiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TToiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TToiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TToiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TToiBtr.ReadHPrice:double;
begin
  Result := oBtrTable.FieldByName('HPrice').AsFloat;
end;

procedure TToiBtr.WriteHPrice(pValue:double);
begin
  oBtrTable.FieldByName('HPrice').AsFloat := pValue;
end;

function TToiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TToiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TToiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TToiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TToiBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TToiBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TToiBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TToiBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TToiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TToiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TToiBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TToiBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TToiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TToiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TToiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TToiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TToiBtr.ReadCasNum:byte;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TToiBtr.WriteCasNum(pValue:byte);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TToiBtr.ReadCadNum:Str12;
begin
  Result := oBtrTable.FieldByName('CadNum').AsString;
end;

procedure TToiBtr.WriteCadNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CadNum').AsString := pValue;
end;

function TToiBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TToiBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TToiBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TToiBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TToiBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TToiBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TToiBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TToiBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TToiBtr.ReadPrcDst:Str1;
begin
  Result := oBtrTable.FieldByName('PrcDst').AsString;
end;

procedure TToiBtr.WritePrcDst(pValue:Str1);
begin
  oBtrTable.FieldByName('PrcDst').AsString := pValue;
end;

function TToiBtr.ReadEpdUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpdUsrc').AsString;
end;

procedure TToiBtr.WriteEpdUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpdUsrc').AsString := pValue;
end;

function TToiBtr.ReadEpaUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpaUsrc').AsString;
end;

procedure TToiBtr.WriteEpaUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpaUsrc').AsString := pValue;
end;

function TToiBtr.ReadEptUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EptUsrc').AsString;
end;

procedure TToiBtr.WriteEptUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EptUsrc').AsString := pValue;
end;

function TToiBtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TToiBtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TToiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TToiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TToiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TToiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TToiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TToiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TToiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TToiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TToiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TToiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TToiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TToiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TToiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TToiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TToiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TToiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TToiBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TToiBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TToiBtr.ReadOcdQnt:double;
begin
  Result := oBtrTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TToiBtr.WriteOcdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TToiBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TToiBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TToiBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TToiBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TToiBtr.ReadReoNum:byte;
begin
  Result := oBtrTable.FieldByName('ReoNum').AsInteger;
end;

procedure TToiBtr.WriteReoNum(pValue:byte);
begin
  oBtrTable.FieldByName('ReoNum').AsInteger := pValue;
end;

function TToiBtr.ReadRerNum:byte;
begin
  Result := oBtrTable.FieldByName('RerNum').AsInteger;
end;

procedure TToiBtr.WriteRerNum(pValue:byte);
begin
  oBtrTable.FieldByName('RerNum').AsInteger := pValue;
end;

function TToiBtr.ReadNcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('NcdNum').AsString;
end;

procedure TToiBtr.WriteNcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('NcdNum').AsString := pValue;
end;

function TToiBtr.ReadNcdItm:word;
begin
  Result := oBtrTable.FieldByName('NcdItm').AsInteger;
end;

procedure TToiBtr.WriteNcdItm(pValue:word);
begin
  oBtrTable.FieldByName('NcdItm').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TToiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TToiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TToiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TToiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TToiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TToiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TToiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TToiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TToiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TToiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TToiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TToiBtr.LocateOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindKey([pOcdNum,pOcdItm]);
end;

function TToiBtr.LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindKey([pTcdNum,pTcdItm]);
end;

function TToiBtr.LocateInIi (pIcdNum:Str12;pIcdItm:word):boolean;
begin
  SetIndex (ixInIi);
  Result := oBtrTable.FindKey([pIcdNum,pIcdItm]);
end;

function TToiBtr.LocateEpdUsrc (pEpdUsrc:Str10):boolean;
begin
  SetIndex (ixEpdUsrc);
  Result := oBtrTable.FindKey([pEpdUsrc]);
end;

function TToiBtr.LocateEpaUsrc (pEpaUsrc:Str10):boolean;
begin
  SetIndex (ixEpaUsrc);
  Result := oBtrTable.FindKey([pEpaUsrc]);
end;

function TToiBtr.LocateEptUsrc (pEptUsrc:Str10):boolean;
begin
  SetIndex (ixEptUsrc);
  Result := oBtrTable.FindKey([pEptUsrc]);
end;

function TToiBtr.LocateEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindKey([pEpsUsrc]);
end;

function TToiBtr.LocateDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TToiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TToiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TToiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TToiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TToiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TToiBtr.NearestOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindNearest([pOcdNum,pOcdItm]);
end;

function TToiBtr.NearestTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindNearest([pTcdNum,pTcdItm]);
end;

function TToiBtr.NearestInIi (pIcdNum:Str12;pIcdItm:word):boolean;
begin
  SetIndex (ixInIi);
  Result := oBtrTable.FindNearest([pIcdNum,pIcdItm]);
end;

function TToiBtr.NearestEpdUsrc (pEpdUsrc:Str10):boolean;
begin
  SetIndex (ixEpdUsrc);
  Result := oBtrTable.FindNearest([pEpdUsrc]);
end;

function TToiBtr.NearestEpaUsrc (pEpaUsrc:Str10):boolean;
begin
  SetIndex (ixEpaUsrc);
  Result := oBtrTable.FindNearest([pEpaUsrc]);
end;

function TToiBtr.NearestEptUsrc (pEptUsrc:Str10):boolean;
begin
  SetIndex (ixEptUsrc);
  Result := oBtrTable.FindNearest([pEptUsrc]);
end;

function TToiBtr.NearestEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindNearest([pEpsUsrc]);
end;

function TToiBtr.NearestDnGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDnGc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

procedure TToiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TToiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TToiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TToiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TToiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TToiBtr.First;
begin
  oBtrTable.First;
end;

procedure TToiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TToiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TToiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TToiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TToiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TToiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TToiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TToiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TToiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TToiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TToiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
