unit bFIF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum = 'FifNum';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixGsSt = 'GsSt';
  ixGsStDa = 'GsStDa';
  ixGsStDr = 'GsStDr';
  ixDocDate = 'DocDate';
  ixDrbDate = 'DrbDate';
  ixSended = 'Sended';
  ixGcRc = 'GcRc';
  ixRbaCode = 'RbaCode';

type
  TFifBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadInPrice:double;        procedure WriteInPrice (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadPdnQnt:double;         procedure WritePdnQnt (pValue:double);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadBegStat:Str1;          procedure WriteBegStat (pValue:Str1);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function LocateGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
    function LocateGsStDr (pGsCode:longint;pStatus:Str1;pDrbDate:TDatetime):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDrbDate (pDrbDate:TDatetime):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function NearestFifNum (pFifNum:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function NearestGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
    function NearestGsStDr (pGsCode:longint;pStatus:Str1;pDrbDate:TDatetime):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDrbDate (pDrbDate:TDatetime):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
    function NearestRbaCode (pRbaCode:Str30):boolean;

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
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property InPrice:double read ReadInPrice write WriteInPrice;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property PdnQnt:double read ReadPdnQnt write WritePdnQnt;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property BegStat:Str1 read ReadBegStat write WriteBegStat;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TFifBtr.Create;
begin
  oBtrTable := BtrInit ('FIF',gPath.StkPath,Self);
end;

constructor TFifBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FIF',pPath,Self);
end;

destructor TFifBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFifBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFifBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFifBtr.ReadFifNum:longint;
begin
  Result := oBtrTable.FieldByName('FifNum').AsInteger;
end;

procedure TFifBtr.WriteFifNum(pValue:longint);
begin
  oBtrTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TFifBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFifBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFifBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFifBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFifBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TFifBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TFifBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFifBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFifBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TFifBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TFifBtr.ReadInPrice:double;
begin
  Result := oBtrTable.FieldByName('InPrice').AsFloat;
end;

procedure TFifBtr.WriteInPrice(pValue:double);
begin
  oBtrTable.FieldByName('InPrice').AsFloat := pValue;
end;

function TFifBtr.ReadInQnt:double;
begin
  Result := oBtrTable.FieldByName('InQnt').AsFloat;
end;

procedure TFifBtr.WriteInQnt(pValue:double);
begin
  oBtrTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TFifBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TFifBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TFifBtr.ReadActQnt:double;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsFloat;
end;

procedure TFifBtr.WriteActQnt(pValue:double);
begin
  oBtrTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TFifBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TFifBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TFifBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TFifBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TFifBtr.ReadPdnQnt:double;
begin
  Result := oBtrTable.FieldByName('PdnQnt').AsFloat;
end;

procedure TFifBtr.WritePdnQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdnQnt').AsFloat := pValue;
end;

function TFifBtr.ReadAcqStat:Str1;
begin
  Result := oBtrTable.FieldByName('AcqStat').AsString;
end;

procedure TFifBtr.WriteAcqStat(pValue:Str1);
begin
  oBtrTable.FieldByName('AcqStat').AsString := pValue;
end;

function TFifBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TFifBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFifBtr.ReadBegStat:Str1;
begin
  Result := oBtrTable.FieldByName('BegStat').AsString;
end;

procedure TFifBtr.WriteBegStat(pValue:Str1);
begin
  oBtrTable.FieldByName('BegStat').AsString := pValue;
end;

function TFifBtr.ReadRbaCode:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCode').AsString;
end;

procedure TFifBtr.WriteRbaCode(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCode').AsString := pValue;
end;

function TFifBtr.ReadRbaDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TFifBtr.WriteRbaDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFifBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFifBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFifBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFifBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFifBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFifBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFifBtr.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oBtrTable.FindKey([pFifNum]);
end;

function TFifBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TFifBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TFifBtr.LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oBtrTable.FindKey([pGsCode,pStatus]);
end;

function TFifBtr.LocateGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
begin
  SetIndex (ixGsStDa);
  Result := oBtrTable.FindKey([pGsCode,pStatus,pDocDate]);
end;

function TFifBtr.LocateGsStDr (pGsCode:longint;pStatus:Str1;pDrbDate:TDatetime):boolean;
begin
  SetIndex (ixGsStDr);
  Result := oBtrTable.FindKey([pGsCode,pStatus,pDrbDate]);
end;

function TFifBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TFifBtr.LocateDrbDate (pDrbDate:TDatetime):boolean;
begin
  SetIndex (ixDrbDate);
  Result := oBtrTable.FindKey([pDrbDate]);
end;

function TFifBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TFifBtr.LocateGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
begin
  SetIndex (ixGcRc);
  Result := oBtrTable.FindKey([pGsCode,pRbaCode]);
end;

function TFifBtr.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindKey([pRbaCode]);
end;

function TFifBtr.NearestFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oBtrTable.FindNearest([pFifNum]);
end;

function TFifBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TFifBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TFifBtr.NearestGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oBtrTable.FindNearest([pGsCode,pStatus]);
end;

function TFifBtr.NearestGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
begin
  SetIndex (ixGsStDa);
  Result := oBtrTable.FindNearest([pGsCode,pStatus,pDocDate]);
end;

function TFifBtr.NearestGsStDr (pGsCode:longint;pStatus:Str1;pDrbDate:TDatetime):boolean;
begin
  SetIndex (ixGsStDr);
  Result := oBtrTable.FindNearest([pGsCode,pStatus,pDrbDate]);
end;

function TFifBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TFifBtr.NearestDrbDate (pDrbDate:TDatetime):boolean;
begin
  SetIndex (ixDrbDate);
  Result := oBtrTable.FindNearest([pDrbDate]);
end;

function TFifBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TFifBtr.NearestGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
begin
  SetIndex (ixGcRc);
  Result := oBtrTable.FindNearest([pGsCode,pRbaCode]);
end;

function TFifBtr.NearestRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oBtrTable.FindNearest([pRbaCode]);
end;

procedure TFifBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFifBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TFifBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFifBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFifBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFifBtr.First;
begin
  oBtrTable.First;
end;

procedure TFifBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFifBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFifBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFifBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFifBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFifBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFifBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFifBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFifBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFifBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFifBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
