unit tDOCITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';

type
  TDocitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadIsdNum:Str12;          procedure WriteIsdNum (pValue:Str12);
    function  ReadIsdItm:word;           procedure WriteIsdItm (pValue:word);
    function  ReadIsdDate:TDatetime;     procedure WriteIsdDate (pValue:TDatetime);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadOmdNum:Str12;          procedure WriteOmdNum (pValue:Str12);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadTgdNum:Str12;          procedure WriteTgdNum (pValue:Str12);
    function  ReadTgdItm:word;           procedure WriteTgdItm (pValue:word);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property EValue:double read ReadEValue write WriteEValue;
    property APrice:double read ReadAPrice write WriteAPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property IsdNum:Str12 read ReadIsdNum write WriteIsdNum;
    property IsdItm:word read ReadIsdItm write WriteIsdItm;
    property IsdDate:TDatetime read ReadIsdDate write WriteIsdDate;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property OmdNum:Str12 read ReadOmdNum write WriteOmdNum;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property TgdNum:Str12 read ReadTgdNum write WriteTgdNum;
    property TgdItm:word read ReadTgdItm write WriteTgdItm;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property ActPos:longint read ReadActPos write WriteActPos;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDocitmTmp.Create;
begin
  oTmpTable := TmpInit ('DOCITM',Self);
end;

destructor TDocitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDocitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocitmTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDocitmTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDocitmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDocitmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDocitmTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TDocitmTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TDocitmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TDocitmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TDocitmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TDocitmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TDocitmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TDocitmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TDocitmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TDocitmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TDocitmTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TDocitmTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TDocitmTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TDocitmTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TDocitmTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TDocitmTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TDocitmTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TDocitmTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TDocitmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TDocitmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TDocitmTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TDocitmTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TDocitmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TDocitmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TDocitmTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TDocitmTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TDocitmTmp.ReadIncQnt:double;
begin
  Result := oTmpTable.FieldByName('IncQnt').AsFloat;
end;

procedure TDocitmTmp.WriteIncQnt(pValue:double);
begin
  oTmpTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TDocitmTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TDocitmTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TDocitmTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TDocitmTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TDocitmTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TDocitmTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TDocitmTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TDocitmTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TDocitmTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TDocitmTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TDocitmTmp.ReadEPrice:double;
begin
  Result := oTmpTable.FieldByName('EPrice').AsFloat;
end;

procedure TDocitmTmp.WriteEPrice(pValue:double);
begin
  oTmpTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TDocitmTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TDocitmTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TDocitmTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TDocitmTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TDocitmTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TDocitmTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TDocitmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TDocitmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TDocitmTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TDocitmTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TDocitmTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TDocitmTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TDocitmTmp.ReadOsdItm:word;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TDocitmTmp.WriteOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TDocitmTmp.ReadIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TDocitmTmp.WriteIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsdNum').AsString := pValue;
end;

function TDocitmTmp.ReadIsdItm:word;
begin
  Result := oTmpTable.FieldByName('IsdItm').AsInteger;
end;

procedure TDocitmTmp.WriteIsdItm(pValue:word);
begin
  oTmpTable.FieldByName('IsdItm').AsInteger := pValue;
end;

function TDocitmTmp.ReadIsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IsdDate').AsDateTime;
end;

procedure TDocitmTmp.WriteIsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IsdDate').AsDateTime := pValue;
end;

function TDocitmTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TDocitmTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TDocitmTmp.ReadOcdItm:longint;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TDocitmTmp.WriteOcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TDocitmTmp.ReadOmdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OmdNum').AsString;
end;

procedure TDocitmTmp.WriteOmdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OmdNum').AsString := pValue;
end;

function TDocitmTmp.ReadScdNum:Str12;
begin
  Result := oTmpTable.FieldByName('ScdNum').AsString;
end;

procedure TDocitmTmp.WriteScdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ScdNum').AsString := pValue;
end;

function TDocitmTmp.ReadScdItm:word;
begin
  Result := oTmpTable.FieldByName('ScdItm').AsInteger;
end;

procedure TDocitmTmp.WriteScdItm(pValue:word);
begin
  oTmpTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TDocitmTmp.ReadTgdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TgdNum').AsString;
end;

procedure TDocitmTmp.WriteTgdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TgdNum').AsString := pValue;
end;

function TDocitmTmp.ReadTgdItm:word;
begin
  Result := oTmpTable.FieldByName('TgdItm').AsInteger;
end;

procedure TDocitmTmp.WriteTgdItm(pValue:word);
begin
  oTmpTable.FieldByName('TgdItm').AsInteger := pValue;
end;

function TDocitmTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TDocitmTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TDocitmTmp.ReadFinStat:Str1;
begin
  Result := oTmpTable.FieldByName('FinStat').AsString;
end;

procedure TDocitmTmp.WriteFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('FinStat').AsString := pValue;
end;

function TDocitmTmp.ReadAcqStat:Str1;
begin
  Result := oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TDocitmTmp.WriteAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString := pValue;
end;

function TDocitmTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDocitmTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TDocitmTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDocitmTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDocitmTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDocitmTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDocitmTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDocitmTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDocitmTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDocitmTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDocitmTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDocitmTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDocitmTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDocitmTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDocitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDocitmTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TDocitmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TDocitmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TDocitmTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TDocitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDocitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDocitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
