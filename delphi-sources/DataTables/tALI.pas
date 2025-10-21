unit tALI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStatus = 'Status';

type
  TAliTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStatus (pStatus:Str1):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAliTmp.Create;
begin
  oTmpTable := TmpInit ('ALI',Self);
end;

destructor TAliTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAliTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAliTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAliTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAliTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAliTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAliTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAliTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TAliTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAliTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TAliTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TAliTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TAliTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TAliTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TAliTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TAliTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TAliTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TAliTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAliTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAliTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TAliTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TAliTmp.ReadAgAPrice:double;
begin
  Result := oTmpTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAliTmp.WriteAgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAgBPrice:double;
begin
  Result := oTmpTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAliTmp.WriteAgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAliTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAliTmp.ReadAgBValue:double;
begin
  Result := oTmpTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAliTmp.WriteAgBValue(pValue:double);
begin
  oTmpTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAliTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAliTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAliTmp.ReadRcoQnt:double;
begin
  Result := oTmpTable.FieldByName('RcoQnt').AsFloat;
end;

procedure TAliTmp.WriteRcoQnt(pValue:double);
begin
  oTmpTable.FieldByName('RcoQnt').AsFloat := pValue;
end;

function TAliTmp.ReadRdiQnt:double;
begin
  Result := oTmpTable.FieldByName('RdiQnt').AsFloat;
end;

procedure TAliTmp.WriteRdiQnt(pValue:double);
begin
  oTmpTable.FieldByName('RdiQnt').AsFloat := pValue;
end;

function TAliTmp.ReadRduQnt:double;
begin
  Result := oTmpTable.FieldByName('RduQnt').AsFloat;
end;

procedure TAliTmp.WriteRduQnt(pValue:double);
begin
  oTmpTable.FieldByName('RduQnt').AsFloat := pValue;
end;

function TAliTmp.ReadRdnQnt:double;
begin
  Result := oTmpTable.FieldByName('RdnQnt').AsFloat;
end;

procedure TAliTmp.WriteRdnQnt(pValue:double);
begin
  oTmpTable.FieldByName('RdnQnt').AsFloat := pValue;
end;

function TAliTmp.ReadNorQnt:double;
begin
  Result := oTmpTable.FieldByName('NorQnt').AsFloat;
end;

procedure TAliTmp.WriteNorQnt(pValue:double);
begin
  oTmpTable.FieldByName('NorQnt').AsFloat := pValue;
end;

function TAliTmp.ReadAsGsCode:longint;
begin
  Result := oTmpTable.FieldByName('AsGsCode').AsInteger;
end;

procedure TAliTmp.WriteAsGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('AsGsCode').AsInteger := pValue;
end;

function TAliTmp.ReadAsGsName:Str30;
begin
  Result := oTmpTable.FieldByName('AsGsName').AsString;
end;

procedure TAliTmp.WriteAsGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('AsGsName').AsString := pValue;
end;

function TAliTmp.ReadAsBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('AsBarCode').AsString;
end;

procedure TAliTmp.WriteAsBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('AsBarCode').AsString := pValue;
end;

function TAliTmp.ReadAsAPrice:double;
begin
  Result := oTmpTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAliTmp.WriteAsAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAsBPrice:double;
begin
  Result := oTmpTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAliTmp.WriteAsBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAliTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAliTmp.ReadAsBValue:double;
begin
  Result := oTmpTable.FieldByName('AsBValue').AsFloat;
end;

procedure TAliTmp.WriteAsBValue(pValue:double);
begin
  oTmpTable.FieldByName('AsBValue').AsFloat := pValue;
end;

function TAliTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAliTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAliTmp.ReadIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TAliTmp.WriteIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TAliTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TAliTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TAliTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TAliTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TAliTmp.ReadDayQnt:word;
begin
  Result := oTmpTable.FieldByName('DayQnt').AsInteger;
end;

procedure TAliTmp.WriteDayQnt(pValue:word);
begin
  oTmpTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TAliTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TAliTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TAliTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAliTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAliTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAliTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAliTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAliTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAliTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAliTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAliTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TAliTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAliTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAliTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAliTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAliTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAliTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAliTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAliTmp.ReadAsDPrice:double;
begin
  Result := oTmpTable.FieldByName('AsDPrice').AsFloat;
end;

procedure TAliTmp.WriteAsDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsDPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAsHPrice:double;
begin
  Result := oTmpTable.FieldByName('AsHPrice').AsFloat;
end;

procedure TAliTmp.WriteAsHPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsHPrice').AsFloat := pValue;
end;

function TAliTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAliTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAliTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAliTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAliTmp.ReadAmdNum:Str12;
begin
  Result := oTmpTable.FieldByName('AmdNum').AsString;
end;

procedure TAliTmp.WriteAmdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAliTmp.ReadAmdItm:word;
begin
  Result := oTmpTable.FieldByName('AmdItm').AsInteger;
end;

procedure TAliTmp.WriteAmdItm(pValue:word);
begin
  oTmpTable.FieldByName('AmdItm').AsInteger := pValue;
end;

function TAliTmp.ReadAodNum:Str12;
begin
  Result := oTmpTable.FieldByName('AodNum').AsString;
end;

procedure TAliTmp.WriteAodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AodNum').AsString := pValue;
end;

function TAliTmp.ReadAodItm:word;
begin
  Result := oTmpTable.FieldByName('AodItm').AsInteger;
end;

procedure TAliTmp.WriteAodItm(pValue:word);
begin
  oTmpTable.FieldByName('AodItm').AsInteger := pValue;
end;

function TAliTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAliTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAliTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAliTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAliTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAliTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAliTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TAliTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TAliTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TAliTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TAliTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TAliTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TAliTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAliTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAliTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAliTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAliTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAliTmp.First;
begin
  oTmpTable.First;
end;

procedure TAliTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAliTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAliTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAliTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAliTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAliTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAliTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAliTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAliTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAliTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAliTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
