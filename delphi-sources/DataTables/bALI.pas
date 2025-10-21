unit bALI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixStatus = 'Status';

type
  TAliBtr = class (TComponent)
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
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadAgAPrice:double;       procedure WriteAgAPrice (pValue:double);
    function  ReadAgBPrice:double;       procedure WriteAgBPrice (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBValue:double;       procedure WriteAgBValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadRcoQnt:double;         procedure WriteRcoQnt (pValue:double);
    function  ReadRdiQnt:double;         procedure WriteRdiQnt (pValue:double);
    function  ReadRduQnt:double;         procedure WriteRduQnt (pValue:double);
    function  ReadRdnQnt:double;         procedure WriteRdnQnt (pValue:double);
    function  ReadNorQnt:double;         procedure WriteNorQnt (pValue:double);
    function  ReadAsGsCode:longint;      procedure WriteAsGsCode (pValue:longint);
    function  ReadAsGsName:Str30;        procedure WriteAsGsName (pValue:Str30);
    function  ReadAsBarCode:Str15;       procedure WriteAsBarCode (pValue:Str15);
    function  ReadAsAPrice:double;       procedure WriteAsAPrice (pValue:double);
    function  ReadAsBPrice:double;       procedure WriteAsBPrice (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBValue:double;       procedure WriteAsBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadAsDPrice:double;       procedure WriteAsDPrice (pValue:double);
    function  ReadAsHPrice:double;       procedure WriteAsHPrice (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAmdItm:word;           procedure WriteAmdItm (pValue:word);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
    function  ReadAodItm:word;           procedure WriteAodItm (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStatus (pStatus:Str1):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property AgAPrice:double read ReadAgAPrice write WriteAgAPrice;
    property AgBPrice:double read ReadAgBPrice write WriteAgBPrice;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBValue:double read ReadAgBValue write WriteAgBValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property RcoQnt:double read ReadRcoQnt write WriteRcoQnt;
    property RdiQnt:double read ReadRdiQnt write WriteRdiQnt;
    property RduQnt:double read ReadRduQnt write WriteRduQnt;
    property RdnQnt:double read ReadRdnQnt write WriteRdnQnt;
    property NorQnt:double read ReadNorQnt write WriteNorQnt;
    property AsGsCode:longint read ReadAsGsCode write WriteAsGsCode;
    property AsGsName:Str30 read ReadAsGsName write WriteAsGsName;
    property AsBarCode:Str15 read ReadAsBarCode write WriteAsBarCode;
    property AsAPrice:double read ReadAsAPrice write WriteAsAPrice;
    property AsBPrice:double read ReadAsBPrice write WriteAsBPrice;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBValue:double read ReadAsBValue write WriteAsBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property AsDPrice:double read ReadAsDPrice write WriteAsDPrice;
    property AsHPrice:double read ReadAsHPrice write WriteAsHPrice;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AmdItm:word read ReadAmdItm write WriteAmdItm;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
    property AodItm:word read ReadAodItm write WriteAodItm;
    property PaCode:longint read ReadPaCode write WritePaCode;
  end;

implementation

constructor TAliBtr.Create;
begin
  oBtrTable := BtrInit ('ALI',gPath.StkPath,Self);
end;

constructor TAliBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ALI',pPath,Self);
end;

destructor TAliBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAliBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAliBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAliBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAliBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAliBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAliBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAliBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAliBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAliBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAliBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAliBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAliBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAliBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TAliBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TAliBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAliBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAliBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TAliBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TAliBtr.ReadAgAPrice:double;
begin
  Result := oBtrTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAliBtr.WriteAgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAgBPrice:double;
begin
  Result := oBtrTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAliBtr.WriteAgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAgAValue:double;
begin
  Result := oBtrTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAliBtr.WriteAgAValue(pValue:double);
begin
  oBtrTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAliBtr.ReadAgBValue:double;
begin
  Result := oBtrTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAliBtr.WriteAgBValue(pValue:double);
begin
  oBtrTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAliBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAliBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAliBtr.ReadRcoQnt:double;
begin
  Result := oBtrTable.FieldByName('RcoQnt').AsFloat;
end;

procedure TAliBtr.WriteRcoQnt(pValue:double);
begin
  oBtrTable.FieldByName('RcoQnt').AsFloat := pValue;
end;

function TAliBtr.ReadRdiQnt:double;
begin
  Result := oBtrTable.FieldByName('RdiQnt').AsFloat;
end;

procedure TAliBtr.WriteRdiQnt(pValue:double);
begin
  oBtrTable.FieldByName('RdiQnt').AsFloat := pValue;
end;

function TAliBtr.ReadRduQnt:double;
begin
  Result := oBtrTable.FieldByName('RduQnt').AsFloat;
end;

procedure TAliBtr.WriteRduQnt(pValue:double);
begin
  oBtrTable.FieldByName('RduQnt').AsFloat := pValue;
end;

function TAliBtr.ReadRdnQnt:double;
begin
  Result := oBtrTable.FieldByName('RdnQnt').AsFloat;
end;

procedure TAliBtr.WriteRdnQnt(pValue:double);
begin
  oBtrTable.FieldByName('RdnQnt').AsFloat := pValue;
end;

function TAliBtr.ReadNorQnt:double;
begin
  Result := oBtrTable.FieldByName('NorQnt').AsFloat;
end;

procedure TAliBtr.WriteNorQnt(pValue:double);
begin
  oBtrTable.FieldByName('NorQnt').AsFloat := pValue;
end;

function TAliBtr.ReadAsGsCode:longint;
begin
  Result := oBtrTable.FieldByName('AsGsCode').AsInteger;
end;

procedure TAliBtr.WriteAsGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('AsGsCode').AsInteger := pValue;
end;

function TAliBtr.ReadAsGsName:Str30;
begin
  Result := oBtrTable.FieldByName('AsGsName').AsString;
end;

procedure TAliBtr.WriteAsGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('AsGsName').AsString := pValue;
end;

function TAliBtr.ReadAsBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('AsBarCode').AsString;
end;

procedure TAliBtr.WriteAsBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('AsBarCode').AsString := pValue;
end;

function TAliBtr.ReadAsAPrice:double;
begin
  Result := oBtrTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAliBtr.WriteAsAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAsBPrice:double;
begin
  Result := oBtrTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAliBtr.WriteAsBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAsAValue:double;
begin
  Result := oBtrTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAliBtr.WriteAsAValue(pValue:double);
begin
  oBtrTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAliBtr.ReadAsBValue:double;
begin
  Result := oBtrTable.FieldByName('AsBValue').AsFloat;
end;

procedure TAliBtr.WriteAsBValue(pValue:double);
begin
  oBtrTable.FieldByName('AsBValue').AsFloat := pValue;
end;

function TAliBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAliBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAliBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TAliBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TAliBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TAliBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TAliBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TAliBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TAliBtr.ReadDayQnt:word;
begin
  Result := oBtrTable.FieldByName('DayQnt').AsInteger;
end;

procedure TAliBtr.WriteDayQnt(pValue:word);
begin
  oBtrTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TAliBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAliBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TAliBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAliBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAliBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAliBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAliBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAliBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAliBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAliBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAliBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAliBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAliBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAliBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAliBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAliBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAliBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAliBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAliBtr.ReadAsDPrice:double;
begin
  Result := oBtrTable.FieldByName('AsDPrice').AsFloat;
end;

procedure TAliBtr.WriteAsDPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsDPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAsHPrice:double;
begin
  Result := oBtrTable.FieldByName('AsHPrice').AsFloat;
end;

procedure TAliBtr.WriteAsHPrice(pValue:double);
begin
  oBtrTable.FieldByName('AsHPrice').AsFloat := pValue;
end;

function TAliBtr.ReadAsDValue:double;
begin
  Result := oBtrTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAliBtr.WriteAsDValue(pValue:double);
begin
  oBtrTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAliBtr.ReadAsHValue:double;
begin
  Result := oBtrTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAliBtr.WriteAsHValue(pValue:double);
begin
  oBtrTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAliBtr.ReadAmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('AmdNum').AsString;
end;

procedure TAliBtr.WriteAmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAliBtr.ReadAmdItm:word;
begin
  Result := oBtrTable.FieldByName('AmdItm').AsInteger;
end;

procedure TAliBtr.WriteAmdItm(pValue:word);
begin
  oBtrTable.FieldByName('AmdItm').AsInteger := pValue;
end;

function TAliBtr.ReadAodNum:Str12;
begin
  Result := oBtrTable.FieldByName('AodNum').AsString;
end;

procedure TAliBtr.WriteAodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AodNum').AsString := pValue;
end;

function TAliBtr.ReadAodItm:word;
begin
  Result := oBtrTable.FieldByName('AodItm').AsInteger;
end;

procedure TAliBtr.WriteAodItm(pValue:word);
begin
  oBtrTable.FieldByName('AodItm').AsInteger := pValue;
end;

function TAliBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAliBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAliBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAliBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAliBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAliBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAliBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAliBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAliBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAliBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TAliBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAliBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAliBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAliBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAliBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TAliBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAliBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TAliBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAliBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAliBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAliBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAliBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAliBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAliBtr.First;
begin
  oBtrTable.First;
end;

procedure TAliBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAliBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAliBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAliBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAliBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAliBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAliBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAliBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAliBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAliBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAliBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
