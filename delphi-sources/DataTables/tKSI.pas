unit tKSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TKsiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadCctVat:byte;           procedure WriteCctVat (pValue:byte);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadKidNum:Str12;          procedure WriteKidNum (pValue:Str12);
    function  ReadKidItm:word;           procedure WriteKidItm (pValue:word);
    function  ReadKidDate:TDatetime;     procedure WriteKidDate (pValue:TDatetime);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadTsdItm:word;           procedure WriteTsdItm (pValue:word);
    function  ReadTsdDate:TDatetime;     procedure WriteTsdDate (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadGSCODE_OsdCode:Str15;  procedure WriteGSCODE_OsdCode (pValue:Str15);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property CctVat:byte read ReadCctVat write WriteCctVat;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property KidNum:Str12 read ReadKidNum write WriteKidNum;
    property KidItm:word read ReadKidItm write WriteKidItm;
    property KidDate:TDatetime read ReadKidDate write WriteKidDate;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property TsdItm:word read ReadTsdItm write WriteTsdItm;
    property TsdDate:TDatetime read ReadTsdDate write WriteTsdDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property GSCODE_OsdCode:Str15 read ReadGSCODE_OsdCode write WriteGSCODE_OsdCode;
  end;

implementation

constructor TKsiTmp.Create;
begin
  oTmpTable := TmpInit ('KSI',Self);
end;

destructor TKsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TKsiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TKsiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TKsiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TKsiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TKsiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TKsiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TKsiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TKsiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TKsiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TKsiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TKsiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TKsiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TKsiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TKsiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TKsiTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TKsiTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TKsiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TKsiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TKsiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TKsiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TKsiTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TKsiTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TKsiTmp.ReadCctVat:byte;
begin
  Result := oTmpTable.FieldByName('CctVat').AsInteger;
end;

procedure TKsiTmp.WriteCctVat(pValue:byte);
begin
  oTmpTable.FieldByName('CctVat').AsInteger := pValue;
end;

function TKsiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TKsiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TKsiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TKsiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TKsiTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TKsiTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TKsiTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TKsiTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TKsiTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TKsiTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TKsiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TKsiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TKsiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TKsiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TKsiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TKsiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TKsiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TKsiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TKsiTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TKsiTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TKsiTmp.ReadKidNum:Str12;
begin
  Result := oTmpTable.FieldByName('KidNum').AsString;
end;

procedure TKsiTmp.WriteKidNum(pValue:Str12);
begin
  oTmpTable.FieldByName('KidNum').AsString := pValue;
end;

function TKsiTmp.ReadKidItm:word;
begin
  Result := oTmpTable.FieldByName('KidItm').AsInteger;
end;

procedure TKsiTmp.WriteKidItm(pValue:word);
begin
  oTmpTable.FieldByName('KidItm').AsInteger := pValue;
end;

function TKsiTmp.ReadKidDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('KidDate').AsDateTime;
end;

procedure TKsiTmp.WriteKidDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('KidDate').AsDateTime := pValue;
end;

function TKsiTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TKsiTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TKsiTmp.ReadTsdItm:word;
begin
  Result := oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TKsiTmp.WriteTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TKsiTmp.ReadTsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TKsiTmp.WriteTsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDate').AsDateTime := pValue;
end;

function TKsiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TKsiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TKsiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TKsiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TKsiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TKsiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TKsiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TKsiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TKsiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TKsiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TKsiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TKsiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TKsiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TKsiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TKsiTmp.ReadGSCODE_OsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('GSCODE_OsdCode').AsString;
end;

procedure TKsiTmp.WriteGSCODE_OsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('GSCODE_OsdCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKsiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TKsiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TKsiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TKsiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TKsiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TKsiTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

procedure TKsiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TKsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TKsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TKsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TKsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TKsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TKsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TKsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TKsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TKsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TKsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TKsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TKsiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TKsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TKsiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TKsiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TKsiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
