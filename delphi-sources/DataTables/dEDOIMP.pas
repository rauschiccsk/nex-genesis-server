unit dEDOIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum='RowNum';
  ixBarCod='BarCod';

type
  TEdoimpDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetRowNum:word;             procedure SetRowNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetBuyPrq:double;           procedure SetBuyPrq(pValue:double);
    function GetBuyApc:double;           procedure SetBuyApc(pValue:double);
    function GetBuyAva:double;           procedure SetBuyAva(pValue:double);
    function GetPlsBpc:double;           procedure SetPlsBpc(pValue:double);
    function GetOsdNum:Str12;            procedure SetOsdNum(pValue:Str12);
    function GetOsdItm:word;             procedure SetOsdItm(pValue:word);
    function GetOsdPrq:double;           procedure SetOsdPrq(pValue:double);
    function GetTsdNum:Str12;            procedure SetTsdNum(pValue:Str12);
    function GetTsdItm:word;             procedure SetTsdItm(pValue:word);
    function GetNotice:Str60;            procedure SetNotice(pValue:Str60);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocRowNum(pRowNum:word):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function NearRowNum(pRowNum:word):boolean;
    function NearBarCod(pBarCod:Str15):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property RowNum:word read GetRowNum write SetRowNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property BuyPrq:double read GetBuyPrq write SetBuyPrq;
    property BuyApc:double read GetBuyApc write SetBuyApc;
    property BuyAva:double read GetBuyAva write SetBuyAva;
    property PlsBpc:double read GetPlsBpc write SetPlsBpc;
    property OsdNum:Str12 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OsdPrq:double read GetOsdPrq write SetOsdPrq;
    property TsdNum:Str12 read GetTsdNum write SetTsdNum;
    property TsdItm:word read GetTsdItm write SetTsdItm;
    property Notice:Str60 read GetNotice write SetNotice;
  end;

implementation

constructor TEdoimpDat.Create;
begin
  oTable:=DatInit('EDOIMP',gPath.StkPath,Self);
end;

constructor TEdoimpDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EDOIMP',pPath,Self);
end;

destructor TEdoimpDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEdoimpDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEdoimpDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEdoimpDat.GetRowNum:word;
begin
  Result:=oTable.FieldByName('RowNum').AsInteger;
end;

procedure TEdoimpDat.SetRowNum(pValue:word);
begin
  oTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TEdoimpDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TEdoimpDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TEdoimpDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TEdoimpDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TEdoimpDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TEdoimpDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TEdoimpDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TEdoimpDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TEdoimpDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TEdoimpDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TEdoimpDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TEdoimpDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TEdoimpDat.GetBuyPrq:double;
begin
  Result:=oTable.FieldByName('BuyPrq').AsFloat;
end;

procedure TEdoimpDat.SetBuyPrq(pValue:double);
begin
  oTable.FieldByName('BuyPrq').AsFloat:=pValue;
end;

function TEdoimpDat.GetBuyApc:double;
begin
  Result:=oTable.FieldByName('BuyApc').AsFloat;
end;

procedure TEdoimpDat.SetBuyApc(pValue:double);
begin
  oTable.FieldByName('BuyApc').AsFloat:=pValue;
end;

function TEdoimpDat.GetBuyAva:double;
begin
  Result:=oTable.FieldByName('BuyAva').AsFloat;
end;

procedure TEdoimpDat.SetBuyAva(pValue:double);
begin
  oTable.FieldByName('BuyAva').AsFloat:=pValue;
end;

function TEdoimpDat.GetPlsBpc:double;
begin
  Result:=oTable.FieldByName('PlsBpc').AsFloat;
end;

procedure TEdoimpDat.SetPlsBpc(pValue:double);
begin
  oTable.FieldByName('PlsBpc').AsFloat:=pValue;
end;

function TEdoimpDat.GetOsdNum:Str12;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TEdoimpDat.SetOsdNum(pValue:Str12);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TEdoimpDat.GetOsdItm:word;
begin
  Result:=oTable.FieldByName('OsdItm').AsInteger;
end;

procedure TEdoimpDat.SetOsdItm(pValue:word);
begin
  oTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TEdoimpDat.GetOsdPrq:double;
begin
  Result:=oTable.FieldByName('OsdPrq').AsFloat;
end;

procedure TEdoimpDat.SetOsdPrq(pValue:double);
begin
  oTable.FieldByName('OsdPrq').AsFloat:=pValue;
end;

function TEdoimpDat.GetTsdNum:Str12;
begin
  Result:=oTable.FieldByName('TsdNum').AsString;
end;

procedure TEdoimpDat.SetTsdNum(pValue:Str12);
begin
  oTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TEdoimpDat.GetTsdItm:word;
begin
  Result:=oTable.FieldByName('TsdItm').AsInteger;
end;

procedure TEdoimpDat.SetTsdItm(pValue:word);
begin
  oTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TEdoimpDat.GetNotice:Str60;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TEdoimpDat.SetNotice(pValue:Str60);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdoimpDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEdoimpDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEdoimpDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEdoimpDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEdoimpDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEdoimpDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEdoimpDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEdoimpDat.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex(ixRowNum);
  Result:=oTable.FindKey([pRowNum]);
end;

function TEdoimpDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TEdoimpDat.NearRowNum(pRowNum:word):boolean;
begin
  SetIndex(ixRowNum);
  Result:=oTable.FindNearest([pRowNum]);
end;

function TEdoimpDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

procedure TEdoimpDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEdoimpDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEdoimpDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEdoimpDat.Prior;
begin
  oTable.Prior;
end;

procedure TEdoimpDat.Next;
begin
  oTable.Next;
end;

procedure TEdoimpDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEdoimpDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEdoimpDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEdoimpDat.Edit;
begin
  oTable.Edit;
end;

procedure TEdoimpDat.Post;
begin
  oTable.Post;
end;

procedure TEdoimpDat.Delete;
begin
  oTable.Delete;
end;

procedure TEdoimpDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEdoimpDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEdoimpDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEdoimpDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEdoimpDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEdoimpDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2005001}
