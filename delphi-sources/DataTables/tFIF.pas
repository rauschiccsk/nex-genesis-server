unit tFIF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum = '';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixGsSt = 'GsSt';
  ixGsStDa = 'GsStDa';
  ixDocDate = 'DocDate';
  ixDrbDate = 'DrbDate';
  ixGcRc = 'GcRc';
  ixRbaCode = 'RbaCode';

type
  TFifTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadStmPrice:double;       procedure WriteStmPrice (pValue:double);
    function  ReadDocPrice:double;       procedure WriteDocPrice (pValue:double);
    function  ReadPriceType:byte;        procedure WritePriceType (pValue:byte);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFifNum (pFifNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function LocateGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDrbDate (pDrbDate:TDatetime):boolean;
    function LocateGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
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
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property ActPos:longint read ReadActPos write WriteActPos;
    property StmPrice:double read ReadStmPrice write WriteStmPrice;
    property DocPrice:double read ReadDocPrice write WriteDocPrice;
    property PriceType:byte read ReadPriceType write WritePriceType;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
  end;

implementation

constructor TFifTmp.Create;
begin
  oTmpTable := TmpInit ('FIF',Self);
end;

destructor TFifTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFifTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFifTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFifTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TFifTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TFifTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFifTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFifTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFifTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFifTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TFifTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TFifTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFifTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFifTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TFifTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TFifTmp.ReadInPrice:double;
begin
  Result := oTmpTable.FieldByName('InPrice').AsFloat;
end;

procedure TFifTmp.WriteInPrice(pValue:double);
begin
  oTmpTable.FieldByName('InPrice').AsFloat := pValue;
end;

function TFifTmp.ReadInQnt:double;
begin
  Result := oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TFifTmp.WriteInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TFifTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TFifTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TFifTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TFifTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TFifTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TFifTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TFifTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TFifTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TFifTmp.ReadAcqStat:Str1;
begin
  Result := oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TFifTmp.WriteAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString := pValue;
end;

function TFifTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TFifTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFifTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TFifTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TFifTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TFifTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TFifTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TFifTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TFifTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TFifTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TFifTmp.ReadStmPrice:double;
begin
  Result := oTmpTable.FieldByName('StmPrice').AsFloat;
end;

procedure TFifTmp.WriteStmPrice(pValue:double);
begin
  oTmpTable.FieldByName('StmPrice').AsFloat := pValue;
end;

function TFifTmp.ReadDocPrice:double;
begin
  Result := oTmpTable.FieldByName('DocPrice').AsFloat;
end;

procedure TFifTmp.WriteDocPrice(pValue:double);
begin
  oTmpTable.FieldByName('DocPrice').AsFloat := pValue;
end;

function TFifTmp.ReadPriceType:byte;
begin
  Result := oTmpTable.FieldByName('PriceType').AsInteger;
end;

procedure TFifTmp.WritePriceType(pValue:byte);
begin
  oTmpTable.FieldByName('PriceType').AsInteger := pValue;
end;

function TFifTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TFifTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TFifTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TFifTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFifTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFifTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFifTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

function TFifTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TFifTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TFifTmp.LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oTmpTable.FindKey([pGsCode,pStatus]);
end;

function TFifTmp.LocateGsStDa (pGsCode:longint;pStatus:Str1;pDocDate:TDatetime):boolean;
begin
  SetIndex (ixGsStDa);
  Result := oTmpTable.FindKey([pGsCode,pStatus,pDocDate]);
end;

function TFifTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TFifTmp.LocateDrbDate (pDrbDate:TDatetime):boolean;
begin
  SetIndex (ixDrbDate);
  Result := oTmpTable.FindKey([pDrbDate]);
end;

function TFifTmp.LocateGcRc (pGsCode:longint;pRbaCode:Str30):boolean;
begin
  SetIndex (ixGcRc);
  Result := oTmpTable.FindKey([pGsCode,pRbaCode]);
end;

function TFifTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

procedure TFifTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFifTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFifTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFifTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFifTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFifTmp.First;
begin
  oTmpTable.First;
end;

procedure TFifTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFifTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFifTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFifTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFifTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFifTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFifTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFifTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFifTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFifTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFifTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1809012}
