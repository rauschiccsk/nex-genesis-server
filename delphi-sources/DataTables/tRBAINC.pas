unit tRBAINC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnFn = '';
  ixSnGc = 'SnGc';
  ixDoIt = 'DoIt';
  ixGsSt = 'GsSt';
  ixDocDate = 'DocDate';
  ixRbaDate = 'RbaDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixRbaCode = 'RbaCode';
  ixFifNum = 'FifNum';

type
  TRbaincTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadRbaDate:TDatetime;     procedure WriteRbaDate (pValue:TDatetime);
    function  ReadRbaCode:Str30;         procedure WriteRbaCode (pValue:Str30);
    function  ReadInPrice:double;        procedure WriteInPrice (pValue:double);
    function  ReadInQnt:double;          procedure WriteInQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadAcqStat:Str1;          procedure WriteAcqStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSnFn (pStkNum:word;pFifNum:longint):boolean;
    function LocateSnGc (pStkNum:word;pGsCode:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateRbaDate (pRbaDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateRbaCode (pRbaCode:Str30):boolean;
    function LocateFifNum (pFifNum:longint):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property RbaDate:TDatetime read ReadRbaDate write WriteRbaDate;
    property RbaCode:Str30 read ReadRbaCode write WriteRbaCode;
    property InPrice:double read ReadInPrice write WriteInPrice;
    property InQnt:double read ReadInQnt write WriteInQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property AcqStat:Str1 read ReadAcqStat write WriteAcqStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRbaincTmp.Create;
begin
  oTmpTable := TmpInit ('RBAINC',Self);
end;

destructor TRbaincTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRbaincTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRbaincTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRbaincTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TRbaincTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TRbaincTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TRbaincTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TRbaincTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TRbaincTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TRbaincTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRbaincTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRbaincTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TRbaincTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRbaincTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TRbaincTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TRbaincTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TRbaincTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TRbaincTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TRbaincTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TRbaincTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TRbaincTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TRbaincTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TRbaincTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TRbaincTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TRbaincTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TRbaincTmp.ReadRbaDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDate').AsDateTime;
end;

procedure TRbaincTmp.WriteRbaDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDate').AsDateTime := pValue;
end;

function TRbaincTmp.ReadRbaCode:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCode').AsString;
end;

procedure TRbaincTmp.WriteRbaCode(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCode').AsString := pValue;
end;

function TRbaincTmp.ReadInPrice:double;
begin
  Result := oTmpTable.FieldByName('InPrice').AsFloat;
end;

procedure TRbaincTmp.WriteInPrice(pValue:double);
begin
  oTmpTable.FieldByName('InPrice').AsFloat := pValue;
end;

function TRbaincTmp.ReadInQnt:double;
begin
  Result := oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TRbaincTmp.WriteInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat := pValue;
end;

function TRbaincTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TRbaincTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TRbaincTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TRbaincTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TRbaincTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TRbaincTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TRbaincTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TRbaincTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TRbaincTmp.ReadAcqStat:Str1;
begin
  Result := oTmpTable.FieldByName('AcqStat').AsString;
end;

procedure TRbaincTmp.WriteAcqStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqStat').AsString := pValue;
end;

function TRbaincTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TRbaincTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TRbaincTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TRbaincTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TRbaincTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TRbaincTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TRbaincTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRbaincTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRbaincTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRbaincTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRbaincTmp.LocateSnFn (pStkNum:word;pFifNum:longint):boolean;
begin
  SetIndex (ixSnFn);
  Result := oTmpTable.FindKey([pStkNum,pFifNum]);
end;

function TRbaincTmp.LocateSnGc (pStkNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGc);
  Result := oTmpTable.FindKey([pStkNum,pGsCode]);
end;

function TRbaincTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TRbaincTmp.LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oTmpTable.FindKey([pGsCode,pStatus]);
end;

function TRbaincTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TRbaincTmp.LocateRbaDate (pRbaDate:TDatetime):boolean;
begin
  SetIndex (ixRbaDate);
  Result := oTmpTable.FindKey([pRbaDate]);
end;

function TRbaincTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TRbaincTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TRbaincTmp.LocateRbaCode (pRbaCode:Str30):boolean;
begin
  SetIndex (ixRbaCode);
  Result := oTmpTable.FindKey([pRbaCode]);
end;

function TRbaincTmp.LocateFifNum (pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result := oTmpTable.FindKey([pFifNum]);
end;

procedure TRbaincTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRbaincTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRbaincTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRbaincTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRbaincTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRbaincTmp.First;
begin
  oTmpTable.First;
end;

procedure TRbaincTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRbaincTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRbaincTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRbaincTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRbaincTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRbaincTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRbaincTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRbaincTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRbaincTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRbaincTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRbaincTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1901011}
