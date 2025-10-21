unit tSTSNAPSHOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFifNum='';
  ixDoIt='DoIt';
  ixGsCode='GsCode';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixDocDate='DocDate';

type
  TStsnapshotTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetFifNum:longint;          procedure SetFifNum (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetInvoiceId:Str15;         procedure SetInvoiceId (pValue:Str15);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetInPrice:double;          procedure SetInPrice (pValue:double);
    function GetInQnt:double;            procedure SetInQnt (pValue:double);
    function GetOutQnt:double;           procedure SetOutQnt (pValue:double);
    function GetActQnt:double;           procedure SetActQnt (pValue:double);
    function GetActVal:double;           procedure SetActVal (pValue:double);
    function GetStatus:Str1;             procedure SetStatus (pValue:Str1);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocFifNum (pFifNum:longint):boolean;
    function LocDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocDocDate (pDocDate:TDatetime):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property FifNum:longint read GetFifNum write SetFifNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property InvoiceId:Str15 read GetInvoiceId write SetInvoiceId;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property GsCode:longint read GetGsCode write SetGsCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property InPrice:double read GetInPrice write SetInPrice;
    property InQnt:double read GetInQnt write SetInQnt;
    property OutQnt:double read GetOutQnt write SetOutQnt;
    property ActQnt:double read GetActQnt write SetActQnt;
    property ActVal:double read GetActVal write SetActVal;
    property Status:Str1 read GetStatus write SetStatus;
    property PaCode:longint read GetPaCode write SetPaCode;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStsnapshotTmp.Create;
begin
  oTmpTable:=TmpInit ('STSNAPSHOT',Self);
end;

destructor TStsnapshotTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStsnapshotTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStsnapshotTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStsnapshotTmp.GetFifNum:longint;
begin
  Result:=oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TStsnapshotTmp.SetFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TStsnapshotTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStsnapshotTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStsnapshotTmp.GetInvoiceId:Str15;
begin
  Result:=oTmpTable.FieldByName('InvoiceId').AsString;
end;

procedure TStsnapshotTmp.SetInvoiceId(pValue:Str15);
begin
  oTmpTable.FieldByName('InvoiceId').AsString:=pValue;
end;

function TStsnapshotTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStsnapshotTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStsnapshotTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStsnapshotTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TStsnapshotTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStsnapshotTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TStsnapshotTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStsnapshotTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TStsnapshotTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TStsnapshotTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TStsnapshotTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TStsnapshotTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TStsnapshotTmp.GetInPrice:double;
begin
  Result:=oTmpTable.FieldByName('InPrice').AsFloat;
end;

procedure TStsnapshotTmp.SetInPrice(pValue:double);
begin
  oTmpTable.FieldByName('InPrice').AsFloat:=pValue;
end;

function TStsnapshotTmp.GetInQnt:double;
begin
  Result:=oTmpTable.FieldByName('InQnt').AsFloat;
end;

procedure TStsnapshotTmp.SetInQnt(pValue:double);
begin
  oTmpTable.FieldByName('InQnt').AsFloat:=pValue;
end;

function TStsnapshotTmp.GetOutQnt:double;
begin
  Result:=oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TStsnapshotTmp.SetOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat:=pValue;
end;

function TStsnapshotTmp.GetActQnt:double;
begin
  Result:=oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStsnapshotTmp.SetActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat:=pValue;
end;

function TStsnapshotTmp.GetActVal:double;
begin
  Result:=oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TStsnapshotTmp.SetActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat:=pValue;
end;

function TStsnapshotTmp.GetStatus:Str1;
begin
  Result:=oTmpTable.FieldByName('Status').AsString;
end;

procedure TStsnapshotTmp.SetStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString:=pValue;
end;

function TStsnapshotTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStsnapshotTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TStsnapshotTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStsnapshotTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStsnapshotTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStsnapshotTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStsnapshotTmp.LocFifNum(pFifNum:longint):boolean;
begin
  SetIndex (ixFifNum);
  Result:=oTmpTable.FindKey([pFifNum]);
end;

function TStsnapshotTmp.LocDoIt(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStsnapshotTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TStsnapshotTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TStsnapshotTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TStsnapshotTmp.LocDocDate(pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result:=oTmpTable.FindKey([pDocDate]);
end;

procedure TStsnapshotTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStsnapshotTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStsnapshotTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStsnapshotTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStsnapshotTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStsnapshotTmp.First;
begin
  oTmpTable.First;
end;

procedure TStsnapshotTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStsnapshotTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStsnapshotTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStsnapshotTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStsnapshotTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStsnapshotTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStsnapshotTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStsnapshotTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStsnapshotTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStsnapshotTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStsnapshotTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
