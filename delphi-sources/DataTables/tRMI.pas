unit tRMI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkStat = 'StkStat';
  ixRbaCode = 'RbaCode';

type
  TRmiTmp = class (TComponent)
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
    function  ReadScStkNum:word;         procedure WriteScStkNum (pValue:word);
    function  ReadTgStkNum:word;         procedure WriteTgStkNum (pValue:word);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadSrcPos:Str15;          procedure WriteSrcPos (pValue:Str15);
    function  ReadTrgPos:Str15;          procedure WriteTrgPos (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadCndNum:Str12;          procedure WriteCndNum (pValue:Str12);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
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
    function LocateGsName (pGsName:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property ScStkNum:word read ReadScStkNum write WriteScStkNum;
    property TgStkNum:word read ReadTgStkNum write WriteTgStkNum;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property SrcPos:Str15 read ReadSrcPos write WriteSrcPos;
    property TrgPos:Str15 read ReadTrgPos write WriteTrgPos;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property CndNum:Str12 read ReadCndNum write WriteCndNum;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRmiTmp.Create;
begin
  oTmpTable := TmpInit ('RMI',Self);
end;

destructor TRmiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRmiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRmiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRmiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TRmiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TRmiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRmiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRmiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TRmiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TRmiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TRmiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRmiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TRmiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TRmiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TRmiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TRmiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TRmiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TRmiTmp.ReadScStkNum:word;
begin
  Result := oTmpTable.FieldByName('ScStkNum').AsInteger;
end;

procedure TRmiTmp.WriteScStkNum(pValue:word);
begin
  oTmpTable.FieldByName('ScStkNum').AsInteger := pValue;
end;

function TRmiTmp.ReadTgStkNum:word;
begin
  Result := oTmpTable.FieldByName('TgStkNum').AsInteger;
end;

procedure TRmiTmp.WriteTgStkNum(pValue:word);
begin
  oTmpTable.FieldByName('TgStkNum').AsInteger := pValue;
end;

function TRmiTmp.ReadScSmCode:word;
begin
  Result := oTmpTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TRmiTmp.WriteScSmCode(pValue:word);
begin
  oTmpTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TRmiTmp.ReadTgSmCode:word;
begin
  Result := oTmpTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TRmiTmp.WriteTgSmCode(pValue:word);
begin
  oTmpTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TRmiTmp.ReadSrcPos:Str15;
begin
  Result := oTmpTable.FieldByName('SrcPos').AsString;
end;

procedure TRmiTmp.WriteSrcPos(pValue:Str15);
begin
  oTmpTable.FieldByName('SrcPos').AsString := pValue;
end;

function TRmiTmp.ReadTrgPos:Str15;
begin
  Result := oTmpTable.FieldByName('TrgPos').AsString;
end;

procedure TRmiTmp.WriteTrgPos(pValue:Str15);
begin
  oTmpTable.FieldByName('TrgPos').AsString := pValue;
end;

function TRmiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TRmiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TRmiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TRmiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TRmiTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TRmiTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TRmiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TRmiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TRmiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TRmiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TRmiTmp.ReadEPrice:double;
begin
  Result := oTmpTable.FieldByName('EPrice').AsFloat;
end;

procedure TRmiTmp.WriteEPrice(pValue:double);
begin
  oTmpTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TRmiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TRmiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRmiTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TRmiTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TRmiTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TRmiTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TRmiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TRmiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TRmiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TRmiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TRmiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TRmiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TRmiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TRmiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TRmiTmp.ReadCndNum:Str12;
begin
  Result := oTmpTable.FieldByName('CndNum').AsString;
end;

procedure TRmiTmp.WriteCndNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CndNum').AsString := pValue;
end;

function TRmiTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TRmiTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TRmiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRmiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRmiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TRmiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TRmiTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TRmiTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TRmiTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TRmiTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TRmiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRmiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRmiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRmiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRmiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRmiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRmiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRmiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRmiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRmiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRmiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRmiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRmiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRmiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRmiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRmiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRmiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TRmiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TRmiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TRmiTmp.LocateGsName (pGsName:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName]);
end;

function TRmiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TRmiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TRmiTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TRmiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRmiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRmiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRmiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRmiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRmiTmp.First;
begin
  oTmpTable.First;
end;

procedure TRmiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRmiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRmiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRmiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRmiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRmiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRmiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRmiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRmiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRmiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRmiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1920001}
