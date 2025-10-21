unit bSTB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGcFn = 'GcFn';
  ixPaCode = 'PaCode';
  ixSended = 'Sended';

type
  TStbBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadStmNum:longint;        procedure WriteStmNum (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadDocQnt:double;         procedure WriteDocQnt (pValue:double);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadBegStat:Str1;          procedure WriteBegStat (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGcFn (pGsCode:longint;pFifNum:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestGcFn (pGsCode:longint;pFifNum:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:word);
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property StmNum:longint read ReadStmNum write WriteStmNum;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property DocQnt:double read ReadDocQnt write WriteDocQnt;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property Sended:boolean read ReadSended write WriteSended;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property ConStk:word read ReadConStk write WriteConStk;
    property BegStat:Str1 read ReadBegStat write WriteBegStat;
  end;

implementation

constructor TStbBtr.Create;
begin
  oBtrTable := BtrInit ('STB',gPath.StkPath,Self);
end;

constructor TStbBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STB',pPath,Self);
end;

destructor TStbBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStbBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStbBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStbBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStbBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStbBtr.ReadFifNum:longint;
begin
  Result := oBtrTable.FieldByName('FifNum').AsInteger;
end;

procedure TStbBtr.WriteFifNum(pValue:longint);
begin
  oBtrTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TStbBtr.ReadStmNum:longint;
begin
  Result := oBtrTable.FieldByName('StmNum').AsInteger;
end;

procedure TStbBtr.WriteStmNum(pValue:longint);
begin
  oBtrTable.FieldByName('StmNum').AsInteger := pValue;
end;

function TStbBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TStbBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TStbBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TStbBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TStbBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStbBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStbBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStbBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStbBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TStbBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStbBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TStbBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TStbBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TStbBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TStbBtr.ReadDocQnt:double;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsFloat;
end;

procedure TStbBtr.WriteDocQnt(pValue:double);
begin
  oBtrTable.FieldByName('DocQnt').AsFloat := pValue;
end;

function TStbBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TStbBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TStbBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TStbBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TStbBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TStbBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStbBtr.ReadAcqStat:Str1;
begin
  Result := oBtrTable.FieldByName('AcqStat').AsString;
end;

procedure TStbBtr.WriteAcqStat(pValue:Str1);
begin
  oBtrTable.FieldByName('AcqStat').AsString := pValue;
end;

function TStbBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TStbBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStbBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStbBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStbBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStbBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStbBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStbBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStbBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TStbBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TStbBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TStbBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TStbBtr.ReadOcdItm:longint;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TStbBtr.WriteOcdItm(pValue:longint);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TStbBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TStbBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TStbBtr.ReadConStk:word;
begin
  Result := oBtrTable.FieldByName('ConStk').AsInteger;
end;

procedure TStbBtr.WriteConStk(pValue:word);
begin
  oBtrTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TStbBtr.ReadBegStat:Str1;
begin
  Result := oBtrTable.FieldByName('BegStat').AsString;
end;

procedure TStbBtr.WriteBegStat(pValue:Str1);
begin
  oBtrTable.FieldByName('BegStat').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStbBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStbBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStbBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStbBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStbBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStbBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStbBtr.LocateGcFn (pGsCode:longint;pFifNum:longint):boolean;
begin
  SetIndex (ixGcFn);
  Result := oBtrTable.FindKey([pGsCode,pFifNum]);
end;

function TStbBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TStbBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TStbBtr.NearestGcFn (pGsCode:longint;pFifNum:longint):boolean;
begin
  SetIndex (ixGcFn);
  Result := oBtrTable.FindNearest([pGsCode,pFifNum]);
end;

function TStbBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TStbBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TStbBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStbBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStbBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStbBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStbBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStbBtr.First;
begin
  oBtrTable.First;
end;

procedure TStbBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStbBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStbBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStbBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStbBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStbBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStbBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStbBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStbBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStbBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStbBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1808012}
