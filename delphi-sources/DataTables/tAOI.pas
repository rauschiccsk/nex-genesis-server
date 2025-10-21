unit tAOI;

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
  TAoiTmp = class (TComponent)
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
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadAgAPrice:double;       procedure WriteAgAPrice (pValue:double);
    function  ReadAgBPrice:double;       procedure WriteAgBPrice (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBValue:double;       procedure WriteAgBValue (pValue:double);
    function  ReadAsDPrice:double;       procedure WriteAsDPrice (pValue:double);
    function  ReadAsHPrice:double;       procedure WriteAsHPrice (pValue:double);
    function  ReadAsAPrice:double;       procedure WriteAsAPrice (pValue:double);
    function  ReadAsBPrice:double;       procedure WriteAsBPrice (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBValue:double;       procedure WriteAsBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAmdItm:word;           procedure WriteAmdItm (pValue:word);
    function  ReadAldNum:Str12;          procedure WriteAldNum (pValue:Str12);
    function  ReadAldItm:word;           procedure WriteAldItm (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
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
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property AgAPrice:double read ReadAgAPrice write WriteAgAPrice;
    property AgBPrice:double read ReadAgBPrice write WriteAgBPrice;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBValue:double read ReadAgBValue write WriteAgBValue;
    property AsDPrice:double read ReadAsDPrice write WriteAsDPrice;
    property AsHPrice:double read ReadAsHPrice write WriteAsHPrice;
    property AsAPrice:double read ReadAsAPrice write WriteAsAPrice;
    property AsBPrice:double read ReadAsBPrice write WriteAsBPrice;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBValue:double read ReadAsBValue write WriteAsBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AmdItm:word read ReadAmdItm write WriteAmdItm;
    property AldNum:Str12 read ReadAldNum write WriteAldNum;
    property AldItm:word read ReadAldItm write WriteAldItm;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAoiTmp.Create;
begin
  oTmpTable := TmpInit ('AOI',Self);
end;

destructor TAoiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAoiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAoiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAoiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAoiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAoiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAoiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAoiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TAoiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAoiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TAoiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TAoiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TAoiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TAoiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TAoiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TAoiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TAoiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TAoiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAoiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAoiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAoiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAoiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TAoiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TAoiTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TAoiTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TAoiTmp.ReadAgAPrice:double;
begin
  Result := oTmpTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAoiTmp.WriteAgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAgBPrice:double;
begin
  Result := oTmpTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAoiTmp.WriteAgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAoiTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAoiTmp.ReadAgBValue:double;
begin
  Result := oTmpTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAoiTmp.WriteAgBValue(pValue:double);
begin
  oTmpTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAoiTmp.ReadAsDPrice:double;
begin
  Result := oTmpTable.FieldByName('AsDPrice').AsFloat;
end;

procedure TAoiTmp.WriteAsDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsDPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAsHPrice:double;
begin
  Result := oTmpTable.FieldByName('AsHPrice').AsFloat;
end;

procedure TAoiTmp.WriteAsHPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsHPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAsAPrice:double;
begin
  Result := oTmpTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAoiTmp.WriteAsAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAsBPrice:double;
begin
  Result := oTmpTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAoiTmp.WriteAsBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAoiTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAoiTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAoiTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAoiTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAoiTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAoiTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAoiTmp.ReadAsBValue:double;
begin
  Result := oTmpTable.FieldByName('AsBValue').AsFloat;
end;

procedure TAoiTmp.WriteAsBValue(pValue:double);
begin
  oTmpTable.FieldByName('AsBValue').AsFloat := pValue;
end;

function TAoiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAoiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAoiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAoiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAoiTmp.ReadNotice:Str60;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TAoiTmp.WriteNotice(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TAoiTmp.ReadAmdNum:Str12;
begin
  Result := oTmpTable.FieldByName('AmdNum').AsString;
end;

procedure TAoiTmp.WriteAmdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAoiTmp.ReadAmdItm:word;
begin
  Result := oTmpTable.FieldByName('AmdItm').AsInteger;
end;

procedure TAoiTmp.WriteAmdItm(pValue:word);
begin
  oTmpTable.FieldByName('AmdItm').AsInteger := pValue;
end;

function TAoiTmp.ReadAldNum:Str12;
begin
  Result := oTmpTable.FieldByName('AldNum').AsString;
end;

procedure TAoiTmp.WriteAldNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AldNum').AsString := pValue;
end;

function TAoiTmp.ReadAldItm:word;
begin
  Result := oTmpTable.FieldByName('AldItm').AsInteger;
end;

procedure TAoiTmp.WriteAldItm(pValue:word);
begin
  oTmpTable.FieldByName('AldItm').AsInteger := pValue;
end;

function TAoiTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAoiTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAoiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAoiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAoiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAoiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAoiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAoiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAoiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAoiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAoiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAoiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAoiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAoiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAoiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAoiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAoiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAoiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAoiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TAoiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TAoiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TAoiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TAoiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TAoiTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TAoiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAoiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAoiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAoiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAoiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAoiTmp.First;
begin
  oTmpTable.First;
end;

procedure TAoiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAoiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAoiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAoiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAoiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAoiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAoiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAoiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAoiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAoiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAoiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
