unit bPKI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixTgGsCode = 'TgGsCode';
  ixTgMgGs = 'TgMgGs';
  ixx_TGSName = 'x_TGSName';
  ixTgBarCode = 'TgBarCode';
  ixTgStkCode = 'TgStkCode';
  ixSnSg = 'SnSg';
  ixScGsCode = 'ScGsCode';
  ixScMgGs = 'ScMgGs';
  ixx_SGSName = 'x_SGSName';
  ixScBarCode = 'ScBarCode';
  ixScStkCode = 'ScStkCode';
  ixStkStat = 'StkStat';

type
  TPkiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadTgMgCode:word;         procedure WriteTgMgCode (pValue:word);
    function  ReadTgGsCode:longint;      procedure WriteTgGsCode (pValue:longint);
    function  ReadTgGsName:Str30;        procedure WriteTgGsName (pValue:Str30);
    function  Readx_TGsName:Str30;       procedure Writex_TGsName (pValue:Str30);
    function  ReadTgBarCode:Str15;       procedure WriteTgBarCode (pValue:Str15);
    function  ReadTgStkCode:Str15;       procedure WriteTgStkCode (pValue:Str15);
    function  ReadTgCPrice:double;       procedure WriteTgCPrice (pValue:double);
    function  ReadTgGsQnt:double;        procedure WriteTgGsQnt (pValue:double);
    function  ReadTgCValue:double;       procedure WriteTgCValue (pValue:double);
    function  ReadTgMsName:Str10;        procedure WriteTgMsName (pValue:Str10);
    function  ReadScMgCode:word;         procedure WriteScMgCode (pValue:word);
    function  ReadScGsCode:longint;      procedure WriteScGsCode (pValue:longint);
    function  ReadScGsName:Str30;        procedure WriteScGsName (pValue:Str30);
    function  Readx_SGSName:Str30;       procedure Writex_SGSName (pValue:Str30);
    function  ReadScBarCode:Str15;       procedure WriteScBarCode (pValue:Str15);
    function  ReadScStkCode:Str15;       procedure WriteScStkCode (pValue:Str15);
    function  ReadScCPrice:double;       procedure WriteScCPrice (pValue:double);
    function  ReadScGsQnt:double;        procedure WriteScGsQnt (pValue:double);
    function  ReadScCValue:double;       procedure WriteScCValue (pValue:double);
    function  ReadScMsName:Str10;        procedure WriteScMsName (pValue:Str10);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  Readx_Flag:byte;           procedure Writex_Flag (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadScBPrice:double;       procedure WriteScBPrice (pValue:double);
    function  ReadTgBPrice:double;       procedure WriteTgBPrice (pValue:double);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  Readx_FIFOStr:Str220;      procedure Writex_FIFOStr (pValue:Str220);
    function  Readx_Note1:Str60;         procedure Writex_Note1 (pValue:Str60);
    function  Readx_Note2:Str60;         procedure Writex_Note2 (pValue:Str60);
    function  Readx_Note3:Str60;         procedure Writex_Note3 (pValue:Str60);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateTgGsCode (pTgGsCode:longint):boolean;
    function LocateTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
    function Locatex_TGSName (px_TGSName:Str30):boolean;
    function LocateTgBarCode (pTgBarCode:Str15):boolean;
    function LocateTgStkCode (pTgStkCode:Str15):boolean;
    function LocateSnSg (pStkNum:word;pScGsCode:longint):boolean;
    function LocateScGsCode (pScGsCode:longint):boolean;
    function LocateScMgGs (pScMgCode:word;pScGsCode:longint):boolean;
    function Locatex_SGSName (px_SGSName:Str30):boolean;
    function LocateScBarCode (pScBarCode:Str15):boolean;
    function LocateScStkCode (pScStkCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestTgGsCode (pTgGsCode:longint):boolean;
    function NearestTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
    function Nearestx_TGSName (px_TGSName:Str30):boolean;
    function NearestTgBarCode (pTgBarCode:Str15):boolean;
    function NearestTgStkCode (pTgStkCode:Str15):boolean;
    function NearestSnSg (pStkNum:word;pScGsCode:longint):boolean;
    function NearestScGsCode (pScGsCode:longint):boolean;
    function NearestScMgGs (pScMgCode:word;pScGsCode:longint):boolean;
    function Nearestx_SGSName (px_SGSName:Str30):boolean;
    function NearestScBarCode (pScBarCode:Str15):boolean;
    function NearestScStkCode (pScStkCode:Str15):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property StkNum:word read ReadStkNum write WriteStkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TgMgCode:word read ReadTgMgCode write WriteTgMgCode;
    property TgGsCode:longint read ReadTgGsCode write WriteTgGsCode;
    property TgGsName:Str30 read ReadTgGsName write WriteTgGsName;
    property x_TGsName:Str30 read Readx_TGsName write Writex_TGsName;
    property TgBarCode:Str15 read ReadTgBarCode write WriteTgBarCode;
    property TgStkCode:Str15 read ReadTgStkCode write WriteTgStkCode;
    property TgCPrice:double read ReadTgCPrice write WriteTgCPrice;
    property TgGsQnt:double read ReadTgGsQnt write WriteTgGsQnt;
    property TgCValue:double read ReadTgCValue write WriteTgCValue;
    property TgMsName:Str10 read ReadTgMsName write WriteTgMsName;
    property ScMgCode:word read ReadScMgCode write WriteScMgCode;
    property ScGsCode:longint read ReadScGsCode write WriteScGsCode;
    property ScGsName:Str30 read ReadScGsName write WriteScGsName;
    property x_SGSName:Str30 read Readx_SGSName write Writex_SGSName;
    property ScBarCode:Str15 read ReadScBarCode write WriteScBarCode;
    property ScStkCode:Str15 read ReadScStkCode write WriteScStkCode;
    property ScCPrice:double read ReadScCPrice write WriteScCPrice;
    property ScGsQnt:double read ReadScGsQnt write WriteScGsQnt;
    property ScCValue:double read ReadScCValue write WriteScCValue;
    property ScMsName:Str10 read ReadScMsName write WriteScMsName;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property x_Flag:byte read Readx_Flag write Writex_Flag;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property ScBPrice:double read ReadScBPrice write WriteScBPrice;
    property TgBPrice:double read ReadTgBPrice write WriteTgBPrice;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property x_FIFOStr:Str220 read Readx_FIFOStr write Writex_FIFOStr;
    property x_Note1:Str60 read Readx_Note1 write Writex_Note1;
    property x_Note2:Str60 read Readx_Note2 write Writex_Note2;
    property x_Note3:Str60 read Readx_Note3 write Writex_Note3;
  end;

implementation

constructor TPkiBtr.Create;
begin
  oBtrTable := BtrInit ('PKI',gPath.StkPath,Self);
end;

constructor TPkiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PKI',pPath,Self);
end;

destructor TPkiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPkiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPkiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPkiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPkiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPkiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPkiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPkiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPkiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPkiBtr.ReadTgMgCode:word;
begin
  Result := oBtrTable.FieldByName('TgMgCode').AsInteger;
end;

procedure TPkiBtr.WriteTgMgCode(pValue:word);
begin
  oBtrTable.FieldByName('TgMgCode').AsInteger := pValue;
end;

function TPkiBtr.ReadTgGsCode:longint;
begin
  Result := oBtrTable.FieldByName('TgGsCode').AsInteger;
end;

procedure TPkiBtr.WriteTgGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('TgGsCode').AsInteger := pValue;
end;

function TPkiBtr.ReadTgGsName:Str30;
begin
  Result := oBtrTable.FieldByName('TgGsName').AsString;
end;

procedure TPkiBtr.WriteTgGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('TgGsName').AsString := pValue;
end;

function TPkiBtr.Readx_TGsName:Str30;
begin
  Result := oBtrTable.FieldByName('x_TGsName').AsString;
end;

procedure TPkiBtr.Writex_TGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('x_TGsName').AsString := pValue;
end;

function TPkiBtr.ReadTgBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('TgBarCode').AsString;
end;

procedure TPkiBtr.WriteTgBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('TgBarCode').AsString := pValue;
end;

function TPkiBtr.ReadTgStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('TgStkCode').AsString;
end;

procedure TPkiBtr.WriteTgStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('TgStkCode').AsString := pValue;
end;

function TPkiBtr.ReadTgCPrice:double;
begin
  Result := oBtrTable.FieldByName('TgCPrice').AsFloat;
end;

procedure TPkiBtr.WriteTgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('TgCPrice').AsFloat := pValue;
end;

function TPkiBtr.ReadTgGsQnt:double;
begin
  Result := oBtrTable.FieldByName('TgGsQnt').AsFloat;
end;

procedure TPkiBtr.WriteTgGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('TgGsQnt').AsFloat := pValue;
end;

function TPkiBtr.ReadTgCValue:double;
begin
  Result := oBtrTable.FieldByName('TgCValue').AsFloat;
end;

procedure TPkiBtr.WriteTgCValue(pValue:double);
begin
  oBtrTable.FieldByName('TgCValue').AsFloat := pValue;
end;

function TPkiBtr.ReadTgMsName:Str10;
begin
  Result := oBtrTable.FieldByName('TgMsName').AsString;
end;

procedure TPkiBtr.WriteTgMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('TgMsName').AsString := pValue;
end;

function TPkiBtr.ReadScMgCode:word;
begin
  Result := oBtrTable.FieldByName('ScMgCode').AsInteger;
end;

procedure TPkiBtr.WriteScMgCode(pValue:word);
begin
  oBtrTable.FieldByName('ScMgCode').AsInteger := pValue;
end;

function TPkiBtr.ReadScGsCode:longint;
begin
  Result := oBtrTable.FieldByName('ScGsCode').AsInteger;
end;

procedure TPkiBtr.WriteScGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('ScGsCode').AsInteger := pValue;
end;

function TPkiBtr.ReadScGsName:Str30;
begin
  Result := oBtrTable.FieldByName('ScGsName').AsString;
end;

procedure TPkiBtr.WriteScGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('ScGsName').AsString := pValue;
end;

function TPkiBtr.Readx_SGSName:Str30;
begin
  Result := oBtrTable.FieldByName('x_SGSName').AsString;
end;

procedure TPkiBtr.Writex_SGSName(pValue:Str30);
begin
  oBtrTable.FieldByName('x_SGSName').AsString := pValue;
end;

function TPkiBtr.ReadScBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('ScBarCode').AsString;
end;

procedure TPkiBtr.WriteScBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ScBarCode').AsString := pValue;
end;

function TPkiBtr.ReadScStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('ScStkCode').AsString;
end;

procedure TPkiBtr.WriteScStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ScStkCode').AsString := pValue;
end;

function TPkiBtr.ReadScCPrice:double;
begin
  Result := oBtrTable.FieldByName('ScCPrice').AsFloat;
end;

procedure TPkiBtr.WriteScCPrice(pValue:double);
begin
  oBtrTable.FieldByName('ScCPrice').AsFloat := pValue;
end;

function TPkiBtr.ReadScGsQnt:double;
begin
  Result := oBtrTable.FieldByName('ScGsQnt').AsFloat;
end;

procedure TPkiBtr.WriteScGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('ScGsQnt').AsFloat := pValue;
end;

function TPkiBtr.ReadScCValue:double;
begin
  Result := oBtrTable.FieldByName('ScCValue').AsFloat;
end;

procedure TPkiBtr.WriteScCValue(pValue:double);
begin
  oBtrTable.FieldByName('ScCValue').AsFloat := pValue;
end;

function TPkiBtr.ReadScMsName:Str10;
begin
  Result := oBtrTable.FieldByName('ScMsName').AsString;
end;

procedure TPkiBtr.WriteScMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('ScMsName').AsString := pValue;
end;

function TPkiBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TPkiBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TPkiBtr.Readx_Flag:byte;
begin
  Result := oBtrTable.FieldByName('x_Flag').AsInteger;
end;

procedure TPkiBtr.Writex_Flag(pValue:byte);
begin
  oBtrTable.FieldByName('x_Flag').AsInteger := pValue;
end;

function TPkiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPkiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPkiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPkiBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TPkiBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TPkiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPkiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPkiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TPkiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPkiBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TPkiBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TPkiBtr.ReadScBPrice:double;
begin
  Result := oBtrTable.FieldByName('ScBPrice').AsFloat;
end;

procedure TPkiBtr.WriteScBPrice(pValue:double);
begin
  oBtrTable.FieldByName('ScBPrice').AsFloat := pValue;
end;

function TPkiBtr.ReadTgBPrice:double;
begin
  Result := oBtrTable.FieldByName('TgBPrice').AsFloat;
end;

procedure TPkiBtr.WriteTgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('TgBPrice').AsFloat := pValue;
end;

function TPkiBtr.ReadScSmCode:word;
begin
  Result := oBtrTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TPkiBtr.WriteScSmCode(pValue:word);
begin
  oBtrTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TPkiBtr.ReadTgSmCode:word;
begin
  Result := oBtrTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TPkiBtr.WriteTgSmCode(pValue:word);
begin
  oBtrTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TPkiBtr.ReadScdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScdNum').AsString;
end;

procedure TPkiBtr.WriteScdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScdNum').AsString := pValue;
end;

function TPkiBtr.ReadScdItm:word;
begin
  Result := oBtrTable.FieldByName('ScdItm').AsInteger;
end;

procedure TPkiBtr.WriteScdItm(pValue:word);
begin
  oBtrTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TPkiBtr.Readx_FIFOStr:Str220;
begin
  Result := oBtrTable.FieldByName('x_FIFOStr').AsString;
end;

procedure TPkiBtr.Writex_FIFOStr(pValue:Str220);
begin
  oBtrTable.FieldByName('x_FIFOStr').AsString := pValue;
end;

function TPkiBtr.Readx_Note1:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note1').AsString;
end;

procedure TPkiBtr.Writex_Note1(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note1').AsString := pValue;
end;

function TPkiBtr.Readx_Note2:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note2').AsString;
end;

procedure TPkiBtr.Writex_Note2(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note2').AsString := pValue;
end;

function TPkiBtr.Readx_Note3:Str60;
begin
  Result := oBtrTable.FieldByName('x_Note3').AsString;
end;

procedure TPkiBtr.Writex_Note3(pValue:Str60);
begin
  oBtrTable.FieldByName('x_Note3').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPkiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPkiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPkiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPkiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPkiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPkiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TPkiBtr.LocateTgGsCode (pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgGsCode);
  Result := oBtrTable.FindKey([pTgGsCode]);
end;

function TPkiBtr.LocateTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgMgGs);
  Result := oBtrTable.FindKey([pTgMgCode,pTgGsCode]);
end;

function TPkiBtr.Locatex_TGSName (px_TGSName:Str30):boolean;
begin
  SetIndex (ixx_TGSName);
  Result := oBtrTable.FindKey([px_TGSName]);
end;

function TPkiBtr.LocateTgBarCode (pTgBarCode:Str15):boolean;
begin
  SetIndex (ixTgBarCode);
  Result := oBtrTable.FindKey([pTgBarCode]);
end;

function TPkiBtr.LocateTgStkCode (pTgStkCode:Str15):boolean;
begin
  SetIndex (ixTgStkCode);
  Result := oBtrTable.FindKey([pTgStkCode]);
end;

function TPkiBtr.LocateSnSg (pStkNum:word;pScGsCode:longint):boolean;
begin
  SetIndex (ixSnSg);
  Result := oBtrTable.FindKey([pStkNum,pScGsCode]);
end;

function TPkiBtr.LocateScGsCode (pScGsCode:longint):boolean;
begin
  SetIndex (ixScGsCode);
  Result := oBtrTable.FindKey([pScGsCode]);
end;

function TPkiBtr.LocateScMgGs (pScMgCode:word;pScGsCode:longint):boolean;
begin
  SetIndex (ixScMgGs);
  Result := oBtrTable.FindKey([pScMgCode,pScGsCode]);
end;

function TPkiBtr.Locatex_SGSName (px_SGSName:Str30):boolean;
begin
  SetIndex (ixx_SGSName);
  Result := oBtrTable.FindKey([px_SGSName]);
end;

function TPkiBtr.LocateScBarCode (pScBarCode:Str15):boolean;
begin
  SetIndex (ixScBarCode);
  Result := oBtrTable.FindKey([pScBarCode]);
end;

function TPkiBtr.LocateScStkCode (pScStkCode:Str15):boolean;
begin
  SetIndex (ixScStkCode);
  Result := oBtrTable.FindKey([pScStkCode]);
end;

function TPkiBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TPkiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPkiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPkiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TPkiBtr.NearestTgGsCode (pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgGsCode);
  Result := oBtrTable.FindNearest([pTgGsCode]);
end;

function TPkiBtr.NearestTgMgGs (pTgMgCode:word;pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgMgGs);
  Result := oBtrTable.FindNearest([pTgMgCode,pTgGsCode]);
end;

function TPkiBtr.Nearestx_TGSName (px_TGSName:Str30):boolean;
begin
  SetIndex (ixx_TGSName);
  Result := oBtrTable.FindNearest([px_TGSName]);
end;

function TPkiBtr.NearestTgBarCode (pTgBarCode:Str15):boolean;
begin
  SetIndex (ixTgBarCode);
  Result := oBtrTable.FindNearest([pTgBarCode]);
end;

function TPkiBtr.NearestTgStkCode (pTgStkCode:Str15):boolean;
begin
  SetIndex (ixTgStkCode);
  Result := oBtrTable.FindNearest([pTgStkCode]);
end;

function TPkiBtr.NearestSnSg (pStkNum:word;pScGsCode:longint):boolean;
begin
  SetIndex (ixSnSg);
  Result := oBtrTable.FindNearest([pStkNum,pScGsCode]);
end;

function TPkiBtr.NearestScGsCode (pScGsCode:longint):boolean;
begin
  SetIndex (ixScGsCode);
  Result := oBtrTable.FindNearest([pScGsCode]);
end;

function TPkiBtr.NearestScMgGs (pScMgCode:word;pScGsCode:longint):boolean;
begin
  SetIndex (ixScMgGs);
  Result := oBtrTable.FindNearest([pScMgCode,pScGsCode]);
end;

function TPkiBtr.Nearestx_SGSName (px_SGSName:Str30):boolean;
begin
  SetIndex (ixx_SGSName);
  Result := oBtrTable.FindNearest([px_SGSName]);
end;

function TPkiBtr.NearestScBarCode (pScBarCode:Str15):boolean;
begin
  SetIndex (ixScBarCode);
  Result := oBtrTable.FindNearest([pScBarCode]);
end;

function TPkiBtr.NearestScStkCode (pScStkCode:Str15):boolean;
begin
  SetIndex (ixScStkCode);
  Result := oBtrTable.FindNearest([pScStkCode]);
end;

function TPkiBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

procedure TPkiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPkiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPkiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPkiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPkiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPkiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPkiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPkiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPkiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPkiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPkiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPkiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPkiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPkiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPkiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPkiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPkiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
