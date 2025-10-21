unit hSPCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, NexClc,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';

type
  PDat=^TDat;
  TDat=record
    rTable:TNexBtrTable;
    rStkNum:word;
  end;
  TSpclstHnd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oStkNum:word;
    oTable:TNexBtrTable;
    oLst:TList;
    function GetCount:integer;
    function GetTable(pStkNum:word):TNexBtrTable;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    // Prístup k databázovým poliam
    function GetStkNum:word;       procedure SetStkNum(pValue:word);
    function GetPosCod:Str15;      procedure SetPosCod(pValue:Str15);
    function GetProNum:longint;    procedure SetProNum(pValue:longint);
    function GetActPrq:double;     procedure SetActPrq(pValue:double);
  public
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pStkNum:word;pActPos:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;

    procedure SetIndex(pIndexName:Str20);
    procedure Activate(pIndex:word);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;

    property Table[pStkNum:word]:TNexBtrTable read GetTable;
  published
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property StkNum:word read GetStkNum write SetStkNum;      // Èíslo skladu
    property PosCod:Str15 read GetPosCod write SetPosCod;     // Skladové pozièné miesto
    property ProNum:longint read GetProNum write SetProNum;   // Produktové èíslo
    property ActPrq:double read GetActPrq write SetActPrq;    // Aktuálne množstvo tovaru na danej pozícii
  end;

implementation

constructor TSpclstHnd.Create;
begin
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TSpclstHnd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      oTable.Close;
      FreeAndNil(oTable);
    end;
  end;
  FreeAndNil(oLst);
end;

// *************************************** PRIVATE ********************************************

function TSpclstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TSpclstHnd.GetTable(pStkNum:word):TNexBtrTable;
begin
  Open(pStkNum);
  Result:=oTable;
end;

function TSpclstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TSpclstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

// ********************* FIELDS *********************

function TSpclstHnd.GetStkNum:word;
begin
  Result:=oStkNum;
end;

procedure TSpclstHnd.SetStkNum(pValue:word);
begin
  //
end;

function TSpclstHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TSpclstHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GoCode').AsInteger:=pValue;
end;

function TSpclstHnd.GetPosCod:Str15;
begin
  Result:=oTable.FieldByName('PoCode').AsString;
end;

procedure TSpclstHnd.SetPosCod(pValue:Str15);
begin
  oTable.FieldByName('PoCode').AsString:=pValue;
end;

function TSpclstHnd.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActQnt').AsFloat;
end;

procedure TSpclstHnd.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActQnt').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpclstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TSpclstHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TSpclstHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TSpclstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TSpclstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TSpclstHnd.GotoPos(pStkNum:word;pActPos:longint): boolean;
begin
  Open(pStkNum);
  Result:=oTable.GotoPos(pActPos);
end;

function TSpclstHnd.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  Open(pStkNum);
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TSpclstHnd.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  Open(pStkNum);
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

procedure TSpclstHnd.SetIndex(pIndexName:Str20);
begin
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TSpclstHnd.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  oTable:=mDat.rTable;
  oStkNum:=mDat.rStkNum;
end;

procedure TSpclstHnd.Open(pStkNum:word);
var mDat:PDat;  mCnt:byte;  mFind:boolean;
begin
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=oTable.BookNum=StrInt(pStkNum,0);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak daný cenník este nie je otvorený potom otvoríme
    oTable:=BtrInit('SPC',gPath.StkPath,Self);
    oTable.Open(pStkNum);
    // Uložíme objekt do zoznamu
    GetMem(mDat,SizeOf(TDat));
    mDat^.rTable:=oTable;
    mDat^.rStkNum:=pStkNum;
    oLst.Add(mDat);
  end;
end;

procedure TSpclstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TSpclstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TSpclstHnd.Next;
begin
  oTable.Next;
end;

procedure TSpclstHnd.First;
begin
  oTable.First;
end;

procedure TSpclstHnd.Last;
begin
  oTable.Last;
end;

procedure TSpclstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TSpclstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TSpclstHnd.Post;
begin
  oTable.Post;
end;

procedure TSpclstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TSpclstHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TSpclstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TSpclstHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TSpclstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TSpclstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TSpclstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001}
