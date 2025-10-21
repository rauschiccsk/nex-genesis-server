unit tAMI;

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

type
  TAmiTmp = class (TComponent)
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
    function  ReadAsDdsVal:double;       procedure WriteAsDdsVal (pValue:double);
    function  ReadAsHdsVal:double;       procedure WriteAsHdsVal (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBValue:double;       procedure WriteAsBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
    function  ReadAodItm:word;           procedure WriteAodItm (pValue:word);
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
    property AsDdsVal:double read ReadAsDdsVal write WriteAsDdsVal;
    property AsHdsVal:double read ReadAsHdsVal write WriteAsHdsVal;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBValue:double read ReadAsBValue write WriteAsBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
    property AodItm:word read ReadAodItm write WriteAodItm;
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

constructor TAmiTmp.Create;
begin
  oTmpTable := TmpInit ('AMI',Self);
end;

destructor TAmiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAmiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAmiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAmiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAmiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAmiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAmiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAmiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TAmiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAmiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TAmiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TAmiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TAmiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TAmiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TAmiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TAmiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TAmiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TAmiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAmiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAmiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAmiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAmiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TAmiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TAmiTmp.ReadAgAPrice:double;
begin
  Result := oTmpTable.FieldByName('AgAPrice').AsFloat;
end;

procedure TAmiTmp.WriteAgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgAPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAgBPrice:double;
begin
  Result := oTmpTable.FieldByName('AgBPrice').AsFloat;
end;

procedure TAmiTmp.WriteAgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AgBPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAmiTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAmiTmp.ReadAgBValue:double;
begin
  Result := oTmpTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAmiTmp.WriteAgBValue(pValue:double);
begin
  oTmpTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAmiTmp.ReadAsDPrice:double;
begin
  Result := oTmpTable.FieldByName('AsDPrice').AsFloat;
end;

procedure TAmiTmp.WriteAsDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsDPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAsHPrice:double;
begin
  Result := oTmpTable.FieldByName('AsHPrice').AsFloat;
end;

procedure TAmiTmp.WriteAsHPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsHPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAsAPrice:double;
begin
  Result := oTmpTable.FieldByName('AsAPrice').AsFloat;
end;

procedure TAmiTmp.WriteAsAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsAPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAsBPrice:double;
begin
  Result := oTmpTable.FieldByName('AsBPrice').AsFloat;
end;

procedure TAmiTmp.WriteAsBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AsBPrice').AsFloat := pValue;
end;

function TAmiTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAmiTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAmiTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAmiTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAmiTmp.ReadAsDdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAmiTmp.WriteAsDdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAmiTmp.ReadAsHdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAmiTmp.WriteAsHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAmiTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAmiTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAmiTmp.ReadAsBValue:double;
begin
  Result := oTmpTable.FieldByName('AsBValue').AsFloat;
end;

procedure TAmiTmp.WriteAsBValue(pValue:double);
begin
  oTmpTable.FieldByName('AsBValue').AsFloat := pValue;
end;

function TAmiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAmiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAmiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAmiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAmiTmp.ReadNotice:Str60;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TAmiTmp.WriteNotice(pValue:Str60);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TAmiTmp.ReadAodNum:Str12;
begin
  Result := oTmpTable.FieldByName('AodNum').AsString;
end;

procedure TAmiTmp.WriteAodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AodNum').AsString := pValue;
end;

function TAmiTmp.ReadAodItm:word;
begin
  Result := oTmpTable.FieldByName('AodItm').AsInteger;
end;

procedure TAmiTmp.WriteAodItm(pValue:word);
begin
  oTmpTable.FieldByName('AodItm').AsInteger := pValue;
end;

function TAmiTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAmiTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAmiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAmiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAmiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAmiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAmiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAmiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAmiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAmiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAmiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAmiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAmiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAmiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAmiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAmiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAmiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAmiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAmiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TAmiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TAmiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TAmiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TAmiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TAmiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAmiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAmiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAmiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAmiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAmiTmp.First;
begin
  oTmpTable.First;
end;

procedure TAmiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAmiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAmiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAmiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAmiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAmiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAmiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAmiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAmiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAmiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAmiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
