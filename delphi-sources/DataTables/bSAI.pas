unit bSAI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixDoGsSt = 'DoGsSt';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';
  ixStkStat = 'StkStat';

type
  TSaiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:Longint;        procedure WriteGsCode (pValue:Longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSeQnt:double;          procedure WriteSeQnt (pValue:double);
    function  ReadSuQnt:double;          procedure WriteSuQnt (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadCpSeQnt:double;        procedure WriteCpSeQnt (pValue:double);
    function  ReadCpSuQnt:double;        procedure WriteCpSuQnt (pValue:double);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:Longint):boolean;
    function LocateDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:Longint):boolean;
    function NearestDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:longint):boolean;
    function NearestMgCode (pMgCode:word):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;

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
    property GsCode:Longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SeQnt:double read ReadSeQnt write WriteSeQnt;
    property SuQnt:double read ReadSuQnt write WriteSuQnt;
    property CValue:double read ReadCValue write WriteCValue;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property CpSeQnt:double read ReadCpSeQnt write WriteCpSeQnt;
    property CpSuQnt:double read ReadCpSuQnt write WriteCpSuQnt;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property CPrice:double read ReadCPrice write WriteCPrice;
  end;

implementation

constructor TSaiBtr.Create;
begin
  oBtrTable := BtrInit ('SAI',gPath.CabPath,Self);
end;

constructor TSaiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SAI',pPath,Self);
end;

destructor TSaiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSaiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSaiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSaiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSaiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSaiBtr.ReadGsCode:Longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSaiBtr.WriteGsCode(pValue:Longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSaiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSaiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSaiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSaiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSaiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSaiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSaiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TSaiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TSaiBtr.ReadSeQnt:double;
begin
  Result := oBtrTable.FieldByName('SeQnt').AsFloat;
end;

procedure TSaiBtr.WriteSeQnt(pValue:double);
begin
  oBtrTable.FieldByName('SeQnt').AsFloat := pValue;
end;

function TSaiBtr.ReadSuQnt:double;
begin
  Result := oBtrTable.FieldByName('SuQnt').AsFloat;
end;

procedure TSaiBtr.WriteSuQnt(pValue:double);
begin
  oBtrTable.FieldByName('SuQnt').AsFloat := pValue;
end;

function TSaiBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TSaiBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSaiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSaiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSaiBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TSaiBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSaiBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TSaiBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSaiBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TSaiBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSaiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSaiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSaiBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TSaiBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TSaiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSaiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSaiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSaiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSaiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSaiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSaiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSaiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSaiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSaiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSaiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSaiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSaiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSaiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSaiBtr.ReadCpSeQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TSaiBtr.WriteCpSeQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TSaiBtr.ReadCpSuQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TSaiBtr.WriteCpSuQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TSaiBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TSaiBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSaiBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TSaiBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSaiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSaiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSaiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSaiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSaiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSaiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSaiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSaiBtr.LocateGsCode (pGsCode:Longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSaiBtr.LocateDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDoGsSt);
  Result := oBtrTable.FindKey([pDocNum,pGsCode,pStkNum]);
end;

function TSaiBtr.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TSaiBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TSaiBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TSaiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSaiBtr.NearestGsCode (pGsCode:Longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSaiBtr.NearestDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDoGsSt);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode,pStkNum]);
end;

function TSaiBtr.NearestMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TSaiBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TSaiBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

procedure TSaiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSaiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSaiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSaiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSaiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSaiBtr.First;
begin
  oBtrTable.First;
end;

procedure TSaiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSaiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSaiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSaiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSaiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSaiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSaiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSaiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSaiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSaiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSaiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
