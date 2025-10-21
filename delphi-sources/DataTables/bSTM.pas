unit bSTM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStmNum = 'StmNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixFifNum = 'FifNum';
  ixOdOi = 'OdOi';
  ixPaCode = 'PaCode';
  ixSpaCode = 'SpaCode';
  ixSended = 'Sended';

type
  TStmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStmNum:longint;        procedure WriteStmNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:longint;        procedure WriteOcdItm (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadConStk:word;           procedure WriteConStk (pValue:word);
    function  ReadBegStat:Str1;          procedure WriteBegStat (pValue:Str1);
    function  ReadBprice:double;         procedure WriteBprice (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateStmNum (pStmNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSpaCode (pSpaCode:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestStmNum (pStmNum:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestSmCode (pSmCode:word):boolean;
    function NearestFifNum (pFifNum:longint):boolean;
    function NearestOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestSpaCode (pSpaCode:longint):boolean;
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
    property StmNum:longint read ReadStmNum write WriteStmNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CValue:double read ReadCValue write WriteCValue;
    property BValue:double read ReadBValue write WriteBValue;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:longint read ReadOcdItm write WriteOcdItm;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property Sended:boolean read ReadSended write WriteSended;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property ConStk:word read ReadConStk write WriteConStk;
    property BegStat:Str1 read ReadBegStat write WriteBegStat;
    property Bprice:double read ReadBprice write WriteBprice;
  end;

implementation

constructor TStmBtr.Create;
begin
  oBtrTable := BtrInit ('STM',gPath.StkPath,Self);
end;

constructor TStmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STM',pPath,Self);
end;

destructor TStmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStmBtr.ReadStmNum:longint;
begin
  Result := oBtrTable.FieldByName('StmNum').AsInteger;
end;

procedure TStmBtr.WriteStmNum(pValue:longint);
begin
  oBtrTable.FieldByName('StmNum').AsInteger := pValue;
end;

function TStmBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TStmBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TStmBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStmBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStmBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TStmBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TStmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStmBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TStmBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TStmBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TStmBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TStmBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TStmBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TStmBtr.ReadFifNum:longint;
begin
  Result := oBtrTable.FieldByName('FifNum').AsInteger;
end;

procedure TStmBtr.WriteFifNum(pValue:longint);
begin
  oBtrTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TStmBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TStmBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TStmBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TStmBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStmBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TStmBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStmBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TStmBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TStmBtr.ReadOcdItm:longint;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TStmBtr.WriteOcdItm(pValue:longint);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TStmBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TStmBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStmBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TStmBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TStmBtr.ReadAcqStat:Str1;
begin
  Result := oBtrTable.FieldByName('AcqStat').AsString;
end;

procedure TStmBtr.WriteAcqStat(pValue:Str1);
begin
  oBtrTable.FieldByName('AcqStat').AsString := pValue;
end;

function TStmBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TStmBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TStmBtr.ReadConStk:word;
begin
  Result := oBtrTable.FieldByName('ConStk').AsInteger;
end;

procedure TStmBtr.WriteConStk(pValue:word);
begin
  oBtrTable.FieldByName('ConStk').AsInteger := pValue;
end;

function TStmBtr.ReadBegStat:Str1;
begin
  Result := oBtrTable.FieldByName('BegStat').AsString;
end;

procedure TStmBtr.WriteBegStat(pValue:Str1);
begin
  oBtrTable.FieldByName('BegStat').AsString := pValue;
end;

function TStmBtr.ReadBprice:double;
begin
  Result := oBtrTable.FieldByName('Bprice').AsFloat;
end;

procedure TStmBtr.WriteBprice(pValue:double);
begin
  oBtrTable.FieldByName('Bprice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStmBtr.LocateStmNum (pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result := oBtrTable.FindKey([pStmNum]);
end;

function TStmBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TStmBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStmBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TStmBtr.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindKey([pSmCode]);
end;

function TStmBtr.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oBtrTable.FindKey([pFifNum]);
end;

function TStmBtr.LocateOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindKey([pOcdNum,pOcdItm]);
end;

function TStmBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TStmBtr.LocateSpaCode (pSpaCode:longint):boolean;
begin
  SetIndex (ixSpaCode);
  Result := oBtrTable.FindKey([pSpaCode]);
end;

function TStmBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TStmBtr.NearestStmNum (pStmNum:longint):boolean;
begin
  SetIndex (ixStmNum);
  Result := oBtrTable.FindNearest([pStmNum]);
end;

function TStmBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TStmBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStmBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TStmBtr.NearestSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindNearest([pSmCode]);
end;

function TStmBtr.NearestFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oBtrTable.FindNearest([pFifNum]);
end;

function TStmBtr.NearestOdOi (pOcdNum:Str12;pOcdItm:longint):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindNearest([pOcdNum,pOcdItm]);
end;

function TStmBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TStmBtr.NearestSpaCode (pSpaCode:longint):boolean;
begin
  SetIndex (ixSpaCode);
  Result := oBtrTable.FindNearest([pSpaCode]);
end;

function TStmBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TStmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStmBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TStmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStmBtr.First;
begin
  oBtrTable.First;
end;

procedure TStmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1922001}
