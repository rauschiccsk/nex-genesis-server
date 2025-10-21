unit tIMI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkStat = 'StkStat';
  ixPosCode = 'PosCode';
  ixRbaCode = 'RbaCode';

type
  TImiTmp = class (TComponent)
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
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadRndVal:double;         procedure WriteRndVal (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadSrcDoc:Str12;          procedure WriteSrcDoc (pValue:Str12);
    function  ReadSrcItm:word;           procedure WriteSrcItm (pValue:word);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocatePosCode (pPosCode:Str15):boolean;
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
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property ConStk:word read ReadConStk write WriteConStk;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property RndVal:double read ReadRndVal write WriteRndVal;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property ActVal:double read ReadActVal write WriteActVal;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property SrcDoc:Str12 read ReadSrcDoc write WriteSrcDoc;
    property SrcItm:word read ReadSrcItm write WriteSrcItm;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
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

constructor TImiTmp.Create;
begin
  oTmpTable := TmpInit ('IMI',Self);
end;

destructor TImiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TImiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TImiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TImiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TImiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TImiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TImiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TImiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TImiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TImiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TImiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TImiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TImiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TImiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TImiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TImiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TImiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TImiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TImiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TImiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TImiTmp.ReadConStk:word;
begin
  Result := oTmpTable.FieldByName('ConStk').AsInteger;
end;

procedure TImiTmp.WriteConStk(pValue:word);
begin
  oTmpTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TImiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TImiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TImiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TImiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TImiTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TImiTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TImiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TImiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TImiTmp.ReadEPrice:double;
begin
  Result := oTmpTable.FieldByName('EPrice').AsFloat;
end;

procedure TImiTmp.WriteEPrice(pValue:double);
begin
  oTmpTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TImiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TImiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TImiTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TImiTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TImiTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TImiTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TImiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TImiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TImiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TImiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TImiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TImiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TImiTmp.ReadRndVal:double;
begin
  Result := oTmpTable.FieldByName('RndVal').AsFloat;
end;

procedure TImiTmp.WriteRndVal(pValue:double);
begin
  oTmpTable.FieldByName('RndVal').AsFloat := pValue;
end;

function TImiTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TImiTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TImiTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TImiTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TImiTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TImiTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TImiTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TImiTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TImiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TImiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TImiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TImiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TImiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TImiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TImiTmp.ReadSrcDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SrcDoc').AsString;
end;

procedure TImiTmp.WriteSrcDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SrcDoc').AsString := pValue;
end;

function TImiTmp.ReadSrcItm:word;
begin
  Result := oTmpTable.FieldByName('SrcItm').AsInteger;
end;

procedure TImiTmp.WriteSrcItm(pValue:word);
begin
  oTmpTable.FieldByName('SrcItm').AsInteger := pValue;
end;

function TImiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TImiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TImiTmp.ReadPosCode:Str15;
begin
  Result := oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TImiTmp.WritePosCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCode').AsString := pValue;
end;

function TImiTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TImiTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TImiTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TImiTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TImiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TImiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TImiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TImiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TImiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TImiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TImiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TImiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TImiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TImiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TImiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TImiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TImiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TImiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TImiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TImiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TImiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TImiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TImiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TImiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TImiTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TImiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TImiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TImiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TImiTmp.LocatePosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oTmpTable.FindKey([pPosCode]);
end;

function TImiTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TImiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TImiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TImiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TImiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TImiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TImiTmp.First;
begin
  oTmpTable.First;
end;

procedure TImiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TImiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TImiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TImiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TImiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TImiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TImiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TImiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TImiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TImiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TImiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1809010}
