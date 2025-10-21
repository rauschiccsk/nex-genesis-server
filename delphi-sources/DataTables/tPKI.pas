unit tPKI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixTgGsCode = 'TgGsCode';
  ixTgMgGs = 'TgMgGs';
  ixTgGsName = 'TgGsName';
  ixTgBarCode = 'TgBarCode';
  ixTgStkCode = 'TgStkCode';
  ixScGsCode = 'ScGsCode';
  ixScGsName = 'ScGsName';
  ixScBarCode = 'ScBarCode';
  ixScStkCode = 'ScStkCode';
  ixStkStat = 'StkStat';

type
  TPkiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadTgMgCode:word;         procedure WriteTgMgCode (pValue:word);
    function  ReadTgGsCode:longint;      procedure WriteTgGsCode (pValue:longint);
    function  ReadTgGsName:Str30;        procedure WriteTgGsName (pValue:Str30);
    function  ReadTgBarCode:Str15;       procedure WriteTgBarCode (pValue:Str15);
    function  ReadTgStkCode:Str15;       procedure WriteTgStkCode (pValue:Str15);
    function  ReadTgCPrice:double;       procedure WriteTgCPrice (pValue:double);
    function  ReadTgGsQnt:double;        procedure WriteTgGsQnt (pValue:double);
    function  ReadTgCValue:double;       procedure WriteTgCValue (pValue:double);
    function  ReadTgMsName:Str10;        procedure WriteTgMsName (pValue:Str10);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadScMgCode:word;         procedure WriteScMgCode (pValue:word);
    function  ReadScGsCode:longint;      procedure WriteScGsCode (pValue:longint);
    function  ReadScGsName:Str30;        procedure WriteScGsName (pValue:Str30);
    function  ReadScBarCode:Str15;       procedure WriteScBarCode (pValue:Str15);
    function  ReadScStkCode:Str15;       procedure WriteScStkCode (pValue:Str15);
    function  ReadScCPrice:double;       procedure WriteScCPrice (pValue:double);
    function  ReadScGsQnt:double;        procedure WriteScGsQnt (pValue:double);
    function  ReadScCValue:double;       procedure WriteScCValue (pValue:double);
    function  ReadScMsName:Str10;        procedure WriteScMsName (pValue:Str10);
    function  ReadScBPrice:double;       procedure WriteScBPrice (pValue:double);
    function  ReadTgBPrice:double;       procedure WriteTgBPrice (pValue:double);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateTgGsCode (pTgGsCode:longint):boolean;
    function LocateTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
    function LocateTgGsName (pTgGsName:Str30):boolean;
    function LocateTgBarCode (pTgBarCode:Str15):boolean;
    function LocateTgStkCode (pTgStkCode:Str15):boolean;
    function LocateScGsCode (pScGsCode:longint):boolean;
    function LocateScGsName (pScGsName:Str30):boolean;
    function LocateScBarCode (pScBarCode:Str15):boolean;
    function LocateScStkCode (pScStkCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property TgMgCode:word read ReadTgMgCode write WriteTgMgCode;
    property TgGsCode:longint read ReadTgGsCode write WriteTgGsCode;
    property TgGsName:Str30 read ReadTgGsName write WriteTgGsName;
    property TgBarCode:Str15 read ReadTgBarCode write WriteTgBarCode;
    property TgStkCode:Str15 read ReadTgStkCode write WriteTgStkCode;
    property TgCPrice:double read ReadTgCPrice write WriteTgCPrice;
    property TgGsQnt:double read ReadTgGsQnt write WriteTgGsQnt;
    property TgCValue:double read ReadTgCValue write WriteTgCValue;
    property TgMsName:Str10 read ReadTgMsName write WriteTgMsName;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property ScMgCode:word read ReadScMgCode write WriteScMgCode;
    property ScGsCode:longint read ReadScGsCode write WriteScGsCode;
    property ScGsName:Str30 read ReadScGsName write WriteScGsName;
    property ScBarCode:Str15 read ReadScBarCode write WriteScBarCode;
    property ScStkCode:Str15 read ReadScStkCode write WriteScStkCode;
    property ScCPrice:double read ReadScCPrice write WriteScCPrice;
    property ScGsQnt:double read ReadScGsQnt write WriteScGsQnt;
    property ScCValue:double read ReadScCValue write WriteScCValue;
    property ScMsName:Str10 read ReadScMsName write WriteScMsName;
    property ScBPrice:double read ReadScBPrice write WriteScBPrice;
    property TgBPrice:double read ReadTgBPrice write WriteTgBPrice;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPkiTmp.Create;
begin
  oTmpTable := TmpInit ('PKI',Self);
end;

destructor TPkiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPkiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPkiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPkiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPkiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPkiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPkiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPkiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TPkiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPkiTmp.ReadTgSmCode:word;
begin
  Result := oTmpTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TPkiTmp.WriteTgSmCode(pValue:word);
begin
  oTmpTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TPkiTmp.ReadTgMgCode:word;
begin
  Result := oTmpTable.FieldByName('TgMgCode').AsInteger;
end;

procedure TPkiTmp.WriteTgMgCode(pValue:word);
begin
  oTmpTable.FieldByName('TgMgCode').AsInteger := pValue;
end;

function TPkiTmp.ReadTgGsCode:longint;
begin
  Result := oTmpTable.FieldByName('TgGsCode').AsInteger;
end;

procedure TPkiTmp.WriteTgGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('TgGsCode').AsInteger := pValue;
end;

function TPkiTmp.ReadTgGsName:Str30;
begin
  Result := oTmpTable.FieldByName('TgGsName').AsString;
end;

procedure TPkiTmp.WriteTgGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('TgGsName').AsString := pValue;
end;

function TPkiTmp.ReadTgBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('TgBarCode').AsString;
end;

procedure TPkiTmp.WriteTgBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('TgBarCode').AsString := pValue;
end;

function TPkiTmp.ReadTgStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('TgStkCode').AsString;
end;

procedure TPkiTmp.WriteTgStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('TgStkCode').AsString := pValue;
end;

function TPkiTmp.ReadTgCPrice:double;
begin
  Result := oTmpTable.FieldByName('TgCPrice').AsFloat;
end;

procedure TPkiTmp.WriteTgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('TgCPrice').AsFloat := pValue;
end;

function TPkiTmp.ReadTgGsQnt:double;
begin
  Result := oTmpTable.FieldByName('TgGsQnt').AsFloat;
end;

procedure TPkiTmp.WriteTgGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('TgGsQnt').AsFloat := pValue;
end;

function TPkiTmp.ReadTgCValue:double;
begin
  Result := oTmpTable.FieldByName('TgCValue').AsFloat;
end;

procedure TPkiTmp.WriteTgCValue(pValue:double);
begin
  oTmpTable.FieldByName('TgCValue').AsFloat := pValue;
end;

function TPkiTmp.ReadTgMsName:Str10;
begin
  Result := oTmpTable.FieldByName('TgMsName').AsString;
end;

procedure TPkiTmp.WriteTgMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('TgMsName').AsString := pValue;
end;

function TPkiTmp.ReadScSmCode:word;
begin
  Result := oTmpTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TPkiTmp.WriteScSmCode(pValue:word);
begin
  oTmpTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TPkiTmp.ReadScMgCode:word;
begin
  Result := oTmpTable.FieldByName('ScMgCode').AsInteger;
end;

procedure TPkiTmp.WriteScMgCode(pValue:word);
begin
  oTmpTable.FieldByName('ScMgCode').AsInteger := pValue;
end;

function TPkiTmp.ReadScGsCode:longint;
begin
  Result := oTmpTable.FieldByName('ScGsCode').AsInteger;
end;

procedure TPkiTmp.WriteScGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('ScGsCode').AsInteger := pValue;
end;

function TPkiTmp.ReadScGsName:Str30;
begin
  Result := oTmpTable.FieldByName('ScGsName').AsString;
end;

procedure TPkiTmp.WriteScGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('ScGsName').AsString := pValue;
end;

function TPkiTmp.ReadScBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('ScBarCode').AsString;
end;

procedure TPkiTmp.WriteScBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('ScBarCode').AsString := pValue;
end;

function TPkiTmp.ReadScStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('ScStkCode').AsString;
end;

procedure TPkiTmp.WriteScStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('ScStkCode').AsString := pValue;
end;

function TPkiTmp.ReadScCPrice:double;
begin
  Result := oTmpTable.FieldByName('ScCPrice').AsFloat;
end;

procedure TPkiTmp.WriteScCPrice(pValue:double);
begin
  oTmpTable.FieldByName('ScCPrice').AsFloat := pValue;
end;

function TPkiTmp.ReadScGsQnt:double;
begin
  Result := oTmpTable.FieldByName('ScGsQnt').AsFloat;
end;

procedure TPkiTmp.WriteScGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('ScGsQnt').AsFloat := pValue;
end;

function TPkiTmp.ReadScCValue:double;
begin
  Result := oTmpTable.FieldByName('ScCValue').AsFloat;
end;

procedure TPkiTmp.WriteScCValue(pValue:double);
begin
  oTmpTable.FieldByName('ScCValue').AsFloat := pValue;
end;

function TPkiTmp.ReadScMsName:Str10;
begin
  Result := oTmpTable.FieldByName('ScMsName').AsString;
end;

procedure TPkiTmp.WriteScMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('ScMsName').AsString := pValue;
end;

function TPkiTmp.ReadScBPrice:double;
begin
  Result := oTmpTable.FieldByName('ScBPrice').AsFloat;
end;

procedure TPkiTmp.WriteScBPrice(pValue:double);
begin
  oTmpTable.FieldByName('ScBPrice').AsFloat := pValue;
end;

function TPkiTmp.ReadTgBPrice:double;
begin
  Result := oTmpTable.FieldByName('TgBPrice').AsFloat;
end;

procedure TPkiTmp.WriteTgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('TgBPrice').AsFloat := pValue;
end;

function TPkiTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TPkiTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TPkiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPkiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPkiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TPkiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TPkiTmp.ReadScdNum:Str12;
begin
  Result := oTmpTable.FieldByName('ScdNum').AsString;
end;

procedure TPkiTmp.WriteScdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ScdNum').AsString := pValue;
end;

function TPkiTmp.ReadScdItm:word;
begin
  Result := oTmpTable.FieldByName('ScdItm').AsInteger;
end;

procedure TPkiTmp.WriteScdItm(pValue:word);
begin
  oTmpTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TPkiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPkiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPkiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPkiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TPkiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPkiTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TPkiTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TPkiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPkiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPkiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPkiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TPkiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TPkiTmp.LocateTgGsCode (pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgGsCode);
  Result := oTmpTable.FindKey([pTgGsCode]);
end;

function TPkiTmp.LocateTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgMgGs);
  Result := oTmpTable.FindKey([pTgMgCode,pTgGsCode]);
end;

function TPkiTmp.LocateTgGsName (pTgGsName:Str30):boolean;
begin
  SetIndex (ixTgGsName);
  Result := oTmpTable.FindKey([pTgGsName]);
end;

function TPkiTmp.LocateTgBarCode (pTgBarCode:Str15):boolean;
begin
  SetIndex (ixTgBarCode);
  Result := oTmpTable.FindKey([pTgBarCode]);
end;

function TPkiTmp.LocateTgStkCode (pTgStkCode:Str15):boolean;
begin
  SetIndex (ixTgStkCode);
  Result := oTmpTable.FindKey([pTgStkCode]);
end;

function TPkiTmp.LocateScGsCode (pScGsCode:longint):boolean;
begin
  SetIndex (ixScGsCode);
  Result := oTmpTable.FindKey([pScGsCode]);
end;

function TPkiTmp.LocateScGsName (pScGsName:Str30):boolean;
begin
  SetIndex (ixScGsName);
  Result := oTmpTable.FindKey([pScGsName]);
end;

function TPkiTmp.LocateScBarCode (pScBarCode:Str15):boolean;
begin
  SetIndex (ixScBarCode);
  Result := oTmpTable.FindKey([pScBarCode]);
end;

function TPkiTmp.LocateScStkCode (pScStkCode:Str15):boolean;
begin
  SetIndex (ixScStkCode);
  Result := oTmpTable.FindKey([pScStkCode]);
end;

function TPkiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

procedure TPkiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPkiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPkiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPkiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPkiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPkiTmp.First;
begin
  oTmpTable.First;
end;

procedure TPkiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPkiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPkiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPkiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPkiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPkiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPkiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPkiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPkiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPkiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPkiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
