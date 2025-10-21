unit hPLCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';
type
  PDat=^TDat;
  TDat=record
    rTable:TNexBtrTable;
    rPlsNum:word;
  end;
  TPlclstHnd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oPlsNum:word;
    oTable:TNexBtrTable;
    oLst:TList;
    function GetCount:integer;
    function GetTable(pPlsNum:word):TNexBtrTable;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    // Prístup k databázovým poliam
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetPlsApc:double;           procedure SetPlsApc(pValue:double);
    function GetPlsBpc:double;           procedure SetPlsBpc(pValue:double);
  public
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pPlsNum:word;pActPos:longint):boolean;
    function LocProNum(pPlsNum:word;pProNum:longint):boolean;
    function NearProNum(pPlsNum:word;pProNum:longint):boolean;

    procedure SetIndex(pIndexName:Str20);
    procedure Activate(pIndex:word);
    procedure Open(pPlsNum:word);
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

    property Table[pPlsNum:word]:TNexBtrTable read GetTable;
  published
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property PlsApc:double read GetPlsApc write SetPlsApc;
    property PlsBpc:double read GetPlsBpc write SetPlsBpc;
  end;

implementation

constructor TPlclstHnd.Create;
begin
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TPlclstHnd.Destroy;
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

function TPlclstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TPlclstHnd.GetTable(pPlsNum:word):TNexBtrTable;
begin
  Open(pPlsNum);
  Result:=oTable;
end;

function TPlclstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TPlclstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

// ********************* FIELDS *********************

function TPlclstHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlclstHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TPlclstHnd.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('GsName').AsString;
end;

procedure TPlclstHnd.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('GsName').AsString:=pValue;
end;

function TPlclstHnd.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

procedure TPlclstHnd.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

function TPlclstHnd.GetPlsApc:double;
begin
  Result:=oTable.FieldByName('APrice').AsFloat;
end;

procedure TPlclstHnd.SetPlsApc(pValue:double);
begin
  oTable.FieldByName('APrice').AsFloat:=pValue;
end;

function TPlclstHnd.GetPlsBpc:double;
begin
  Result:=oTable.FieldByName('BPrice').AsFloat;
end;

procedure TPlclstHnd.SetPlsBpc(pValue:double);
begin
  oTable.FieldByName('BPrice').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlclstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TPlclstHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TPlclstHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TPlclstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TPlclstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TPlclstHnd.GotoPos(pPlsNum:word;pActPos:longint): boolean;
begin
  Open(pPlsNum);
  Result:=oTable.GotoPos(pActPos);
end;

function TPlclstHnd.LocProNum(pPlsNum:word;pProNum:longint):boolean;
begin
  Open(pPlsNum);
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TPlclstHnd.NearProNum(pPlsNum:word;pProNum:longint):boolean;
begin
  Open(pPlsNum);
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

procedure TPlclstHnd.SetIndex(pIndexName:Str20);
begin
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TPlclstHnd.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  oTable:=mDat.rTable;
  oPlsNum:=mDat.rPlsNum;
end;

procedure TPlclstHnd.Open(pPlsNum:word);
var mDat:PDat;  mCnt:byte;  mFind:boolean;
begin
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=oTable.BookNum=StrInt(pPlsNum,0);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak daný cenník este nie je otvorený potom otvoríme
    oTable:=BtrInit('PLS',gPath.StkPath,Self);
    oTable.Open(pPlsNum);
    // Uložíme objekt do zoznamu
    GetMem(mDat,SizeOf(TDat));
    mDat^.rTable:=oTable;
    mDat^.rPlsNum:=pPlsNum;
    oLst.Add(mDat);
  end;
end;

procedure TPlclstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TPlclstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TPlclstHnd.Next;
begin
  oTable.Next;
end;

procedure TPlclstHnd.First;
begin
  oTable.First;
end;

procedure TPlclstHnd.Last;
begin
  oTable.Last;
end;

procedure TPlclstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TPlclstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TPlclstHnd.Post;
begin
  oTable.Post;
end;

procedure TPlclstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TPlclstHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TPlclstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TPlclstHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TPlclstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TPlclstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TPlclstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001}
