unit tOMI;

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
  ixScBc = 'ScBc';
  ixBarCode = 'BarCode';
  ixStkStat = 'StkStat';
  ixPosCode = 'PosCode';
  ixRbaCode = 'RbaCode';

type
  TOmiTmp = class (TComponent)
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
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadEPrice:double;         procedure WriteEPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadSrcDoc:Str12;          procedure WriteSrcDoc (pValue:Str12);
    function  ReadSrcItm:word;           procedure WriteSrcItm (pValue:word);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadPrvVal:double;         procedure WritePrvVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
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
    function LocateScBc (pStkCode:Str15;pBarCode:Str15):boolean;
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
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property EPrice:double read ReadEPrice write WriteEPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property SrcDoc:Str12 read ReadSrcDoc write WriteSrcDoc;
    property SrcItm:word read ReadSrcItm write WriteSrcItm;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property PrvVal:double read ReadPrvVal write WritePrvVal;
    property ActVal:double read ReadActVal write WriteActVal;
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

constructor TOmiTmp.Create;
begin
  oTmpTable := TmpInit ('OMI',Self);
end;

destructor TOmiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOmiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOmiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOmiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOmiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOmiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOmiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOmiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TOmiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOmiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOmiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOmiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOmiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOmiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TOmiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TOmiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TOmiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TOmiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TOmiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TOmiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOmiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOmiTmp.ReadConStk:word;
begin
  Result := oTmpTable.FieldByName('ConStk').AsInteger;
end;

procedure TOmiTmp.WriteConStk(pValue:word);
begin
  oTmpTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TOmiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TOmiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TOmiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TOmiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TOmiTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TOmiTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TOmiTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TOmiTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TOmiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TOmiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TOmiTmp.ReadEPrice:double;
begin
  Result := oTmpTable.FieldByName('EPrice').AsFloat;
end;

procedure TOmiTmp.WriteEPrice(pValue:double);
begin
  oTmpTable.FieldByName('EPrice').AsFloat := pValue;
end;

function TOmiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TOmiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TOmiTmp.ReadEValue:double;
begin
  Result := oTmpTable.FieldByName('EValue').AsFloat;
end;

procedure TOmiTmp.WriteEValue(pValue:double);
begin
  oTmpTable.FieldByName('EValue').AsFloat := pValue;
end;

function TOmiTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TOmiTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TOmiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TOmiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TOmiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TOmiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TOmiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TOmiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TOmiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOmiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOmiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TOmiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TOmiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOmiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TOmiTmp.ReadOcdItm:longint;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOmiTmp.WriteOcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TOmiTmp.ReadSrcDoc:Str12;
begin
  Result := oTmpTable.FieldByName('SrcDoc').AsString;
end;

procedure TOmiTmp.WriteSrcDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('SrcDoc').AsString := pValue;
end;

function TOmiTmp.ReadSrcItm:word;
begin
  Result := oTmpTable.FieldByName('SrcItm').AsInteger;
end;

procedure TOmiTmp.WriteSrcItm(pValue:word);
begin
  oTmpTable.FieldByName('SrcItm').AsInteger := pValue;
end;

function TOmiTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOmiTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TOmiTmp.ReadPrvVal:double;
begin
  Result := oTmpTable.FieldByName('PrvVal').AsFloat;
end;

procedure TOmiTmp.WritePrvVal(pValue:double);
begin
  oTmpTable.FieldByName('PrvVal').AsFloat := pValue;
end;

function TOmiTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TOmiTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TOmiTmp.ReadPosCode:Str15;
begin
  Result := oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TOmiTmp.WritePosCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCode').AsString := pValue;
end;

function TOmiTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TOmiTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TOmiTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TOmiTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TOmiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOmiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOmiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOmiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOmiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOmiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOmiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOmiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOmiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOmiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOmiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOmiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOmiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOmiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOmiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOmiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOmiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOmiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOmiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOmiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TOmiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOmiTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TOmiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TOmiTmp.LocateScBc (pStkCode:Str15;pBarCode:Str15):boolean;
begin
  SetIndex (ixScBc);
  Result := oTmpTable.FindKey([pStkCode,pBarCode]);
end;

function TOmiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TOmiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TOmiTmp.LocatePosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oTmpTable.FindKey([pPosCode]);
end;

function TOmiTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TOmiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOmiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOmiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOmiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOmiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOmiTmp.First;
begin
  oTmpTable.First;
end;

procedure TOmiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOmiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOmiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOmiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOmiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOmiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOmiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOmiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOmiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOmiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOmiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1921001}
