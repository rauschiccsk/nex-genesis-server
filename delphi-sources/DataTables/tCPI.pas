unit tCPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCpCode = '';
  ixCpName_ = 'CpName_';
  ixBarCode = 'BarCode';
  ixItmType = 'ItmType';

type
  TCpiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadCpName_:Str30;         procedure WriteCpName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadRcGsQnt:double;        procedure WriteRcGsQnt (pValue:double);
    function  ReadLosPrc:double;         procedure WriteLosPrc (pValue:double);
    function  ReadCpGsQnt:double;        procedure WriteCpGsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadDPrice:double;         procedure WriteDPrice (pValue:double);
    function  ReadHPrice:double;         procedure WriteHPrice (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadNotice:Str80;          procedure WriteNotice (pValue:Str80);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadPdGsQntu:double;       procedure WritePdGsQntu (pValue:double);
    function  ReadRcGsQntu:double;       procedure WriteRcGsQntu (pValue:double);
    function  ReadCpGsQntu:double;       procedure WriteCpGsQntu (pValue:double);
    function  ReadMsuName:Str10;         procedure WriteMsuName (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCpCode (pCpCode:longint):boolean;
    function LocateCpName_ (pCpName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateItmType (pItmType:Str1):boolean;

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
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property CpName_:Str30 read ReadCpName_ write WriteCpName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property RcGsQnt:double read ReadRcGsQnt write WriteRcGsQnt;
    property LosPrc:double read ReadLosPrc write WriteLosPrc;
    property CpGsQnt:double read ReadCpGsQnt write WriteCpGsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property DPrice:double read ReadDPrice write WriteDPrice;
    property HPrice:double read ReadHPrice write WriteHPrice;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property Notice:Str80 read ReadNotice write WriteNotice;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property PdGsQntu:double read ReadPdGsQntu write WritePdGsQntu;
    property RcGsQntu:double read ReadRcGsQntu write WriteRcGsQntu;
    property CpGsQntu:double read ReadCpGsQntu write WriteCpGsQntu;
    property MsuName:Str10 read ReadMsuName write WriteMsuName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TCpiTmp.Create;
begin
  oTmpTable := TmpInit ('CPI',Self);
end;

destructor TCpiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCpiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCpiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCpiTmp.ReadCpCode:longint;
begin
  Result := oTmpTable.FieldByName('CpCode').AsInteger;
end;

procedure TCpiTmp.WriteCpCode(pValue:longint);
begin
  oTmpTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TCpiTmp.ReadCpName:Str30;
begin
  Result := oTmpTable.FieldByName('CpName').AsString;
end;

procedure TCpiTmp.WriteCpName(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName').AsString := pValue;
end;

function TCpiTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TCpiTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TCpiTmp.ReadCpName_:Str30;
begin
  Result := oTmpTable.FieldByName('CpName_').AsString;
end;

procedure TCpiTmp.WriteCpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName_').AsString := pValue;
end;

function TCpiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCpiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCpiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCpiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCpiTmp.ReadPdGsQnt:double;
begin
  Result := oTmpTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TCpiTmp.WritePdGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TCpiTmp.ReadRcGsQnt:double;
begin
  Result := oTmpTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TCpiTmp.WriteRcGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TCpiTmp.ReadLosPrc:double;
begin
  Result := oTmpTable.FieldByName('LosPrc').AsFloat;
end;

procedure TCpiTmp.WriteLosPrc(pValue:double);
begin
  oTmpTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TCpiTmp.ReadCpGsQnt:double;
begin
  Result := oTmpTable.FieldByName('CpGsQnt').AsFloat;
end;

procedure TCpiTmp.WriteCpGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpGsQnt').AsFloat := pValue;
end;

function TCpiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TCpiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TCpiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TCpiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TCpiTmp.ReadDPrice:double;
begin
  Result := oTmpTable.FieldByName('DPrice').AsFloat;
end;

procedure TCpiTmp.WriteDPrice(pValue:double);
begin
  oTmpTable.FieldByName('DPrice').AsFloat := pValue;
end;

function TCpiTmp.ReadHPrice:double;
begin
  Result := oTmpTable.FieldByName('HPrice').AsFloat;
end;

procedure TCpiTmp.WriteHPrice(pValue:double);
begin
  oTmpTable.FieldByName('HPrice').AsFloat := pValue;
end;

function TCpiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCpiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCpiTmp.ReadDscType:Str1;
begin
  Result := oTmpTable.FieldByName('DscType').AsString;
end;

procedure TCpiTmp.WriteDscType(pValue:Str1);
begin
  oTmpTable.FieldByName('DscType').AsString := pValue;
end;

function TCpiTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TCpiTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TCpiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCpiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCpiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TCpiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCpiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TCpiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCpiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCpiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCpiTmp.ReadNotice:Str80;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TCpiTmp.WriteNotice(pValue:Str80);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TCpiTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TCpiTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TCpiTmp.ReadPdGsQntu:double;
begin
  Result := oTmpTable.FieldByName('PdGsQntu').AsFloat;
end;

procedure TCpiTmp.WritePdGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('PdGsQntu').AsFloat := pValue;
end;

function TCpiTmp.ReadRcGsQntu:double;
begin
  Result := oTmpTable.FieldByName('RcGsQntu').AsFloat;
end;

procedure TCpiTmp.WriteRcGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('RcGsQntu').AsFloat := pValue;
end;

function TCpiTmp.ReadCpGsQntu:double;
begin
  Result := oTmpTable.FieldByName('CpGsQntu').AsFloat;
end;

procedure TCpiTmp.WriteCpGsQntu(pValue:double);
begin
  oTmpTable.FieldByName('CpGsQntu').AsFloat := pValue;
end;

function TCpiTmp.ReadMsuName:Str10;
begin
  Result := oTmpTable.FieldByName('MsuName').AsString;
end;

procedure TCpiTmp.WriteMsuName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuName').AsString := pValue;
end;

function TCpiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCpiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCpiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCpiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCpiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCpiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCpiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TCpiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCpiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TCpiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TCpiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCpiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCpiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCpiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCpiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TCpiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCpiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCpiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCpiTmp.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oTmpTable.FindKey([pCpCode]);
end;

function TCpiTmp.LocateCpName_ (pCpName_:Str30):boolean;
begin
  SetIndex (ixCpName_);
  Result := oTmpTable.FindKey([pCpName_]);
end;

function TCpiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TCpiTmp.LocateItmType (pItmType:Str1):boolean;
begin
  SetIndex (ixItmType);
  Result := oTmpTable.FindKey([pItmType]);
end;

procedure TCpiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCpiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCpiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCpiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCpiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCpiTmp.First;
begin
  oTmpTable.First;
end;

procedure TCpiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCpiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCpiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCpiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCpiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCpiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCpiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCpiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCpiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCpiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCpiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
