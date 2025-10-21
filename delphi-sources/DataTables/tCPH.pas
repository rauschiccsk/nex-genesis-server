unit tCPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPdCode = '';
  ixPdName = 'PdName';
  ixSended = 'Sended';

type
  TCphTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadPdName:Str30;          procedure WritePdName (pValue:Str30);
    function  ReadPdName_:Str30;         procedure WritePdName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscAvl:double;         procedure WriteDscAvl (pValue:double);
    function  ReadDscBvl:double;         procedure WriteDscBvl (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadCpiVal:double;         procedure WriteCpiVal (pValue:double);
    function  ReadCpsVal:double;         procedure WriteCpsVal (pValue:double);
    function  ReadIRcGsQnt:double;       procedure WriteIRcGsQnt (pValue:double);
    function  ReadILosPrc:double;        procedure WriteILosPrc (pValue:double);
    function  ReadICpGsQnt:double;       procedure WriteICpGsQnt (pValue:double);
    function  ReadICPrice:double;        procedure WriteICPrice (pValue:double);
    function  ReadIDPrice:double;        procedure WriteIDPrice (pValue:double);
    function  ReadIHPrice:double;        procedure WriteIHPrice (pValue:double);
    function  ReadIDscPrc:double;        procedure WriteIDscPrc (pValue:double);
    function  ReadIDscType:Str1;         procedure WriteIDscType (pValue:Str1);
    function  ReadIAPrice:double;        procedure WriteIAPrice (pValue:double);
    function  ReadIBPrice:double;        procedure WriteIBPrice (pValue:double);
    function  ReadICValue:double;        procedure WriteICValue (pValue:double);
    function  ReadIAValue:double;        procedure WriteIAValue (pValue:double);
    function  ReadIBValue:double;        procedure WriteIBValue (pValue:double);
    function  ReadINotice:Str80;         procedure WriteINotice (pValue:Str80);
    function  ReadIItmType:Str1;         procedure WriteIItmType (pValue:Str1);
    function  ReadIPdGsQntu:double;      procedure WriteIPdGsQntu (pValue:double);
    function  ReadIRcGsQntu:double;      procedure WriteIRcGsQntu (pValue:double);
    function  ReadICpGsQntu:double;      procedure WriteICpGsQntu (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePdCode (pPdCode:longint):boolean;
    function LocatePdName (pPdName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;

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
    property PdCode:longint read ReadPdCode write WritePdCode;
    property PdName:Str30 read ReadPdName write WritePdName;
    property PdName_:Str30 read ReadPdName_ write WritePdName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CValue:double read ReadCValue write WriteCValue;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscAvl:double read ReadDscAvl write WriteDscAvl;
    property DscBvl:double read ReadDscBvl write WriteDscBvl;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property CpiVal:double read ReadCpiVal write WriteCpiVal;
    property CpsVal:double read ReadCpsVal write WriteCpsVal;
    property IRcGsQnt:double read ReadIRcGsQnt write WriteIRcGsQnt;
    property ILosPrc:double read ReadILosPrc write WriteILosPrc;
    property ICpGsQnt:double read ReadICpGsQnt write WriteICpGsQnt;
    property ICPrice:double read ReadICPrice write WriteICPrice;
    property IDPrice:double read ReadIDPrice write WriteIDPrice;
    property IHPrice:double read ReadIHPrice write WriteIHPrice;
    property IDscPrc:double read ReadIDscPrc write WriteIDscPrc;
    property IDscType:Str1 read ReadIDscType write WriteIDscType;
    property IAPrice:double read ReadIAPrice write WriteIAPrice;
    property IBPrice:double read ReadIBPrice write WriteIBPrice;
    property ICValue:double read ReadICValue write WriteICValue;
    property IAValue:double read ReadIAValue write WriteIAValue;
    property IBValue:double read ReadIBValue write WriteIBValue;
    property INotice:Str80 read ReadINotice write WriteINotice;
    property IItmType:Str1 read ReadIItmType write WriteIItmType;
    property IPdGsQntu:double read ReadIPdGsQntu write WriteIPdGsQntu;
    property IRcGsQntu:double read ReadIRcGsQntu write WriteIRcGsQntu;
    property ICpGsQntu:double read ReadICpGsQntu write WriteICpGsQntu;
  end;

implementation

constructor TCphTmp.Create;
begin
  oTmpTable := TmpInit ('CPH',Self);
end;

destructor TCphTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCphTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCphTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCphTmp.ReadPdCode:longint;
begin
  Result := oTmpTable.FieldByName('PdCode').AsInteger;
end;

procedure TCphTmp.WritePdCode(pValue:longint);
begin
  oTmpTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TCphTmp.ReadPdName:Str30;
begin
  Result := oTmpTable.FieldByName('PdName').AsString;
end;

procedure TCphTmp.WritePdName(pValue:Str30);
begin
  oTmpTable.FieldByName('PdName').AsString := pValue;
end;

function TCphTmp.ReadPdName_:Str30;
begin
  Result := oTmpTable.FieldByName('PdName_').AsString;
end;

procedure TCphTmp.WritePdName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PdName_').AsString := pValue;
end;

function TCphTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCphTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCphTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCphTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCphTmp.ReadPdGsQnt:double;
begin
  Result := oTmpTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TCphTmp.WritePdGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TCphTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TCphTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TCphTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TCphTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCphTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TCphTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TCphTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TCphTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TCphTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TCphTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TCphTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCphTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCphTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCphTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCphTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TCphTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCphTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCphTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCphTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCphTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCphTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCphTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCphTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TCphTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCphTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TCphTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TCphTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCphTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCphTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCphTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCphTmp.ReadDValue:double;
begin
  Result := oTmpTable.FieldByName('DValue').AsFloat;
end;

procedure TCphTmp.WriteDValue(pValue:double);
begin
  oTmpTable.FieldByName('DValue').AsFloat := pValue;
end;

function TCphTmp.ReadHValue:double;
begin
  Result := oTmpTable.FieldByName('HValue').AsFloat;
end;

procedure TCphTmp.WriteHValue(pValue:double);
begin
  oTmpTable.FieldByName('HValue').AsFloat := pValue;
end;

function TCphTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCphTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCphTmp.ReadDscAvl:double;
begin
  Result := oTmpTable.FieldByName('DscAvl').AsFloat;
end;

procedure TCphTmp.WriteDscAvl(pValue:double);
begin
  oTmpTable.FieldByName('DscAvl').AsFloat := pValue;
end;

function TCphTmp.ReadDscBvl:double;
begin
  Result := oTmpTable.FieldByName('DscBvl').AsFloat;
end;

procedure TCphTmp.WriteDscBvl(pValue:double);
begin
  oTmpTable.FieldByName('DscBvl').AsFloat := pValue;
end;

function TCphTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TCphTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCphTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCphTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCphTmp.ReadCpiVal:double;
begin
  Result := oTmpTable.FieldByName('CpiVal').AsFloat;
end;

procedure TCphTmp.WriteCpiVal(pValue:double);
begin
  oTmpTable.FieldByName('CpiVal').AsFloat := pValue;
end;

function TCphTmp.ReadCpsVal:double;
begin
  Result := oTmpTable.FieldByName('CpsVal').AsFloat;
end;

procedure TCphTmp.WriteCpsVal(pValue:double);
begin
  oTmpTable.FieldByName('CpsVal').AsFloat := pValue;
end;

function TCphTmp.ReadIRcGsQnt:double;
begin
  Result := oTmpTable.FieldByName('IRcGsQnt').AsFloat;
end;

procedure TCphTmp.WriteIRcGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('IRcGsQnt').AsFloat := pValue;
end;

function TCphTmp.ReadILosPrc:double;
begin
  Result := oTmpTable.FieldByName('ILosPrc').AsFloat;
end;

procedure TCphTmp.WriteILosPrc(pValue:double);
begin
  oTmpTable.FieldByName('ILosPrc').AsFloat := pValue;
end;

function TCphTmp.ReadICpGsQnt:double;
begin
  Result := oTmpTable.FieldByName('ICpGsQnt').AsFloat;
end;

procedure TCphTmp.WriteICpGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('ICpGsQnt').AsFloat := pValue;
end;

function TCphTmp.ReadICPrice:double;
begin
  Result := oTmpTable.FieldByName('ICPrice').AsFloat;
end;

procedure TCphTmp.WriteICPrice(pValue:double);
begin
  oTmpTable.FieldByName('ICPrice').AsFloat := pValue;
end;

function TCphTmp.ReadIDPrice:double;
begin
  Result := oTmpTable.FieldByName('IDPrice').AsFloat;
end;

procedure TCphTmp.WriteIDPrice(pValue:double);
begin
  oTmpTable.FieldByName('IDPrice').AsFloat := pValue;
end;

function TCphTmp.ReadIHPrice:double;
begin
  Result := oTmpTable.FieldByName('IHPrice').AsFloat;
end;

procedure TCphTmp.WriteIHPrice(pValue:double);
begin
  oTmpTable.FieldByName('IHPrice').AsFloat := pValue;
end;

function TCphTmp.ReadIDscPrc:double;
begin
  Result := oTmpTable.FieldByName('IDscPrc').AsFloat;
end;

procedure TCphTmp.WriteIDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('IDscPrc').AsFloat := pValue;
end;

function TCphTmp.ReadIDscType:Str1;
begin
  Result := oTmpTable.FieldByName('IDscType').AsString;
end;

procedure TCphTmp.WriteIDscType(pValue:Str1);
begin
  oTmpTable.FieldByName('IDscType').AsString := pValue;
end;

function TCphTmp.ReadIAPrice:double;
begin
  Result := oTmpTable.FieldByName('IAPrice').AsFloat;
end;

procedure TCphTmp.WriteIAPrice(pValue:double);
begin
  oTmpTable.FieldByName('IAPrice').AsFloat := pValue;
end;

function TCphTmp.ReadIBPrice:double;
begin
  Result := oTmpTable.FieldByName('IBPrice').AsFloat;
end;

procedure TCphTmp.WriteIBPrice(pValue:double);
begin
  oTmpTable.FieldByName('IBPrice').AsFloat := pValue;
end;

function TCphTmp.ReadICValue:double;
begin
  Result := oTmpTable.FieldByName('ICValue').AsFloat;
end;

procedure TCphTmp.WriteICValue(pValue:double);
begin
  oTmpTable.FieldByName('ICValue').AsFloat := pValue;
end;

function TCphTmp.ReadIAValue:double;
begin
  Result := oTmpTable.FieldByName('IAValue').AsFloat;
end;

procedure TCphTmp.WriteIAValue(pValue:double);
begin
  oTmpTable.FieldByName('IAValue').AsFloat := pValue;
end;

function TCphTmp.ReadIBValue:double;
begin
  Result := oTmpTable.FieldByName('IBValue').AsFloat;
end;

procedure TCphTmp.WriteIBValue(pValue:double);
begin
  oTmpTable.FieldByName('IBValue').AsFloat := pValue;
end;

function TCphTmp.ReadINotice:Str80;
begin
  Result := oTmpTable.FieldByName('INotice').AsString;
end;

procedure TCphTmp.WriteINotice(pValue:Str80);
begin
  oTmpTable.FieldByName('INotice').AsString := pValue;
end;

function TCphTmp.ReadIItmType:Str1;
begin
  Result := oTmpTable.FieldByName('IItmType').AsString;
end;

procedure TCphTmp.WriteIItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('IItmType').AsString := pValue;
end;

function TCphTmp.ReadIPdGsQntu:double;
begin
  Result := oTmpTable.FieldByName('IPdGsQntu').AsFloat;
end;

procedure TCphTmp.WriteIPdGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('IPdGsQntu').AsFloat := pValue;
end;

function TCphTmp.ReadIRcGsQntu:double;
begin
  Result := oTmpTable.FieldByName('IRcGsQntu').AsFloat;
end;

procedure TCphTmp.WriteIRcGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('IRcGsQntu').AsFloat := pValue;
end;

function TCphTmp.ReadICpGsQntu:double;
begin
  Result := oTmpTable.FieldByName('ICpGsQntu').AsFloat;
end;

procedure TCphTmp.WriteICpGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('ICpGsQntu').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCphTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCphTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCphTmp.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oTmpTable.FindKey([pPdCode]);
end;

function TCphTmp.LocatePdName (pPdName_:Str30):boolean;
begin
  SetIndex (ixPdName);
  Result := oTmpTable.FindKey([pPdName_]);
end;

function TCphTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

procedure TCphTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCphTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCphTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCphTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCphTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCphTmp.First;
begin
  oTmpTable.First;
end;

procedure TCphTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCphTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCphTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCphTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCphTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCphTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCphTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCphTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCphTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCphTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCphTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1905010}
