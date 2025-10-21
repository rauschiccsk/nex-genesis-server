unit bTII;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDoGs = 'DoGs';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixDocDate = 'DocDate';
  ixTnTi = 'TnTi';
  ixEpsUsrc = 'EpsUsrc';

type
  TTiiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
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
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadStdNum:Str12;          procedure WriteStdNum (pValue:Str12);
    function  ReadStdItm:word;           procedure WriteStdItm (pValue:word);
    function  ReadPrcDst:Str1;           procedure WritePrcDst (pValue:Str1);
    function  ReadEpsUsrc:Str10;         procedure WriteEpsUsrc (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateTnTi (pStdNum:Str12;pStdItm:word):boolean;
    function LocateEpsUsrc (pEpsUsrc:Str10):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestTnTi (pStdNum:Str12;pStdItm:word):boolean;
    function NearestEpsUsrc (pEpsUsrc:Str10):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property StdNum:Str12 read ReadStdNum write WriteStdNum;
    property StdItm:word read ReadStdItm write WriteStdItm;
    property PrcDst:Str1 read ReadPrcDst write WritePrcDst;
    property EpsUsrc:Str10 read ReadEpsUsrc write WriteEpsUsrc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
  end;

implementation

constructor TTiiBtr.Create;
begin
  oBtrTable := BtrInit ('TII',gPath.StkPath,Self);
end;

constructor TTiiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TII',pPath,Self);
end;

destructor TTiiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTiiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTiiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTiiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTiiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTiiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTiiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTiiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTiiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTiiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTiiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTiiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTiiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTiiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTiiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTiiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TTiiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TTiiBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTiiBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TTiiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTiiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTiiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTiiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTiiBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TTiiBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TTiiBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TTiiBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TTiiBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TTiiBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TTiiBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TTiiBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TTiiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTiiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTiiBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTiiBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTiiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTiiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTiiBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TTiiBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TTiiBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TTiiBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TTiiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTiiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTiiBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TTiiBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TTiiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTiiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTiiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTiiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTiiBtr.ReadStdNum:Str12;
begin
  Result := oBtrTable.FieldByName('StdNum').AsString;
end;

procedure TTiiBtr.WriteStdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('StdNum').AsString := pValue;
end;

function TTiiBtr.ReadStdItm:word;
begin
  Result := oBtrTable.FieldByName('StdItm').AsInteger;
end;

procedure TTiiBtr.WriteStdItm(pValue:word);
begin
  oBtrTable.FieldByName('StdItm').AsInteger := pValue;
end;

function TTiiBtr.ReadPrcDst:Str1;
begin
  Result := oBtrTable.FieldByName('PrcDst').AsString;
end;

procedure TTiiBtr.WritePrcDst(pValue:Str1);
begin
  oBtrTable.FieldByName('PrcDst').AsString := pValue;
end;

function TTiiBtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TTiiBtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TTiiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTiiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTiiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTiiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTiiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTiiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTiiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTiiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTiiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTiiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTiiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTiiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTiiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTiiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTiiBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TTiiBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTiiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTiiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTiiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTiiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTiiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTiiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTiiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTiiBtr.LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TTiiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTiiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTiiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TTiiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTiiBtr.LocateTnTi (pStdNum:Str12;pStdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindKey([pStdNum,pStdItm]);
end;

function TTiiBtr.LocateEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindKey([pEpsUsrc]);
end;

function TTiiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTiiBtr.NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

function TTiiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTiiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TTiiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TTiiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTiiBtr.NearestTnTi (pStdNum:Str12;pStdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oBtrTable.FindNearest([pStdNum,pStdItm]);
end;

function TTiiBtr.NearestEpsUsrc (pEpsUsrc:Str10):boolean;
begin
  SetIndex (ixEpsUsrc);
  Result := oBtrTable.FindNearest([pEpsUsrc]);
end;

procedure TTiiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTiiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTiiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTiiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTiiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTiiBtr.First;
begin
  oBtrTable.First;
end;

procedure TTiiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTiiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTiiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTiiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTiiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTiiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTiiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTiiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTiiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTiiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTiiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
