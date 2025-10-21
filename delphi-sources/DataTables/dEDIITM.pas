unit dEDIITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum='ExtNum';
  ixEnIn='EnIn';
  ixItmNum='ItmNum';
  ixProNam='ProNam';

type
  TEdiitmDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetExtNum:Str12;            procedure SetExtNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetDlvPrq:double;           procedure SetDlvPrq(pValue:double);
    function GetDlvApc:double;           procedure SetDlvApc(pValue:double);
    function GetDlvAva:double;           procedure SetDlvAva(pValue:double);
    function GetDlvBva:double;           procedure SetDlvBva(pValue:double);
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
    function LocExtNum(pExtNum:Str12):boolean;
    function LocEnIn(pExtNum:Str12;pItmNum:word):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearEnIn(pExtNum:Str12;pItmNum:word):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearProNam(pProNam_:Str60):boolean;

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
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property DlvPrq:double read GetDlvPrq write SetDlvPrq;
    property DlvApc:double read GetDlvApc write SetDlvApc;
    property DlvAva:double read GetDlvAva write SetDlvAva;
    property DlvBva:double read GetDlvBva write SetDlvBva;
  end;

implementation

constructor TEdiitmDat.Create;
begin
  oTable:=DatInit('EDIITM',gPath.StkPath,Self);
end;

constructor TEdiitmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EDIITM',pPath,Self);
end;

destructor TEdiitmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEdiitmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEdiitmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEdiitmDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TEdiitmDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TEdiitmDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TEdiitmDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TEdiitmDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TEdiitmDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TEdiitmDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TEdiitmDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TEdiitmDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TEdiitmDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TEdiitmDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TEdiitmDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TEdiitmDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TEdiitmDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TEdiitmDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TEdiitmDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TEdiitmDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TEdiitmDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TEdiitmDat.GetDlvPrq:double;
begin
  Result:=oTable.FieldByName('DlvPrq').AsFloat;
end;

procedure TEdiitmDat.SetDlvPrq(pValue:double);
begin
  oTable.FieldByName('DlvPrq').AsFloat:=pValue;
end;

function TEdiitmDat.GetDlvApc:double;
begin
  Result:=oTable.FieldByName('DlvApc').AsFloat;
end;

procedure TEdiitmDat.SetDlvApc(pValue:double);
begin
  oTable.FieldByName('DlvApc').AsFloat:=pValue;
end;

function TEdiitmDat.GetDlvAva:double;
begin
  Result:=oTable.FieldByName('DlvAva').AsFloat;
end;

procedure TEdiitmDat.SetDlvAva(pValue:double);
begin
  oTable.FieldByName('DlvAva').AsFloat:=pValue;
end;

function TEdiitmDat.GetDlvBva:double;
begin
  Result:=oTable.FieldByName('DlvBva').AsFloat;
end;

procedure TEdiitmDat.SetDlvBva(pValue:double);
begin
  oTable.FieldByName('DlvBva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdiitmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEdiitmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEdiitmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEdiitmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEdiitmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEdiitmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEdiitmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEdiitmDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TEdiitmDat.LocEnIn(pExtNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixEnIn);
  Result:=oTable.FindKey([pExtNum,pItmNum]);
end;

function TEdiitmDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TEdiitmDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TEdiitmDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TEdiitmDat.NearEnIn(pExtNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixEnIn);
  Result:=oTable.FindNearest([pExtNum,pItmNum]);
end;

function TEdiitmDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TEdiitmDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

procedure TEdiitmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEdiitmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEdiitmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEdiitmDat.Prior;
begin
  oTable.Prior;
end;

procedure TEdiitmDat.Next;
begin
  oTable.Next;
end;

procedure TEdiitmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEdiitmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEdiitmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEdiitmDat.Edit;
begin
  oTable.Edit;
end;

procedure TEdiitmDat.Post;
begin
  oTable.Post;
end;

procedure TEdiitmDat.Delete;
begin
  oTable.Delete;
end;

procedure TEdiitmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEdiitmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEdiitmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEdiitmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEdiitmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEdiitmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
