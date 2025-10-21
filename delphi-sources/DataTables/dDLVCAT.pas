unit dDLVCAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPcBc='PcBc';
  ixBarCode='BarCode';
  ixOrdCode='OrdCode';

type
  TDlvcatDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetPaCode:longint;          procedure SetPaCode(pValue:longint);
    function GetBarCode:Str15;           procedure SetBarCode(pValue:Str15);
    function GetOrdCode:Str20;           procedure SetOrdCode(pValue:Str20);
    function GetProdName:Str50;          procedure SetProdName(pValue:Str50);
    function GetProdDesc:Str50;          procedure SetProdDesc(pValue:Str50);
    function GetProdInfo:Str50;          procedure SetProdInfo(pValue:Str50);
    function GetBrandText:Str30;         procedure SetBrandText(pValue:Str30);
    function GetWeight:double;           procedure SetWeight(pValue:double);
    function GetDiameter:word;           procedure SetDiameter(pValue:word);
    function GetModUser:Str20;           procedure SetModUser(pValue:Str20);
    function GetModDate:TDatetime;       procedure SetModDate(pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime(pValue:TDatetime);
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
    function LocPcBc(pPaCode:longint;pBarCode:Str15):boolean;
    function LocBarCode(pBarCode:Str15):boolean;
    function LocOrdCode(pOrdCode:Str20):boolean;
    function NearPcBc(pPaCode:longint;pBarCode:Str15):boolean;
    function NearBarCode(pBarCode:Str15):boolean;
    function NearOrdCode(pOrdCode:Str20):boolean;

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
    property PaCode:longint read GetPaCode write SetPaCode;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property OrdCode:Str20 read GetOrdCode write SetOrdCode;
    property ProdName:Str50 read GetProdName write SetProdName;
    property ProdDesc:Str50 read GetProdDesc write SetProdDesc;
    property ProdInfo:Str50 read GetProdInfo write SetProdInfo;
    property BrandText:Str30 read GetBrandText write SetBrandText;
    property Weight:double read GetWeight write SetWeight;
    property Diameter:word read GetDiameter write SetDiameter;
    property ModUser:Str20 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
  end;

implementation

constructor TDlvcatDat.Create;
begin
  oTable:=DatInit('DLVCAT',gPath.StkPath,Self);
end;

constructor TDlvcatDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('DLVCAT',pPath,Self);
end;

destructor TDlvcatDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TDlvcatDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TDlvcatDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TDlvcatDat.GetPaCode:longint;
begin
  Result:=oTable.FieldByName('PaCode').AsInteger;
end;

procedure TDlvcatDat.SetPaCode(pValue:longint);
begin
  oTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TDlvcatDat.GetBarCode:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

procedure TDlvcatDat.SetBarCode(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

function TDlvcatDat.GetOrdCode:Str20;
begin
  Result:=oTable.FieldByName('OrdCode').AsString;
end;

procedure TDlvcatDat.SetOrdCode(pValue:Str20);
begin
  oTable.FieldByName('OrdCode').AsString:=pValue;
end;

function TDlvcatDat.GetProdName:Str50;
begin
  Result:=oTable.FieldByName('ProdName').AsString;
end;

procedure TDlvcatDat.SetProdName(pValue:Str50);
begin
  oTable.FieldByName('ProdName').AsString:=pValue;
end;

function TDlvcatDat.GetProdDesc:Str50;
begin
  Result:=oTable.FieldByName('ProdDesc').AsString;
end;

procedure TDlvcatDat.SetProdDesc(pValue:Str50);
begin
  oTable.FieldByName('ProdDesc').AsString:=pValue;
end;

function TDlvcatDat.GetProdInfo:Str50;
begin
  Result:=oTable.FieldByName('ProdInfo').AsString;
end;

procedure TDlvcatDat.SetProdInfo(pValue:Str50);
begin
  oTable.FieldByName('ProdInfo').AsString:=pValue;
end;

function TDlvcatDat.GetBrandText:Str30;
begin
  Result:=oTable.FieldByName('BrandText').AsString;
end;

procedure TDlvcatDat.SetBrandText(pValue:Str30);
begin
  oTable.FieldByName('BrandText').AsString:=pValue;
end;

function TDlvcatDat.GetWeight:double;
begin
  Result:=oTable.FieldByName('Weight').AsFloat;
end;

procedure TDlvcatDat.SetWeight(pValue:double);
begin
  oTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TDlvcatDat.GetDiameter:word;
begin
  Result:=oTable.FieldByName('Diameter').AsInteger;
end;

procedure TDlvcatDat.SetDiameter(pValue:word);
begin
  oTable.FieldByName('Diameter').AsInteger:=pValue;
end;

function TDlvcatDat.GetModUser:Str20;
begin
  Result:=oTable.FieldByName('ModUser').AsString;
end;

procedure TDlvcatDat.SetModUser(pValue:Str20);
begin
  oTable.FieldByName('ModUser').AsString:=pValue;
end;

function TDlvcatDat.GetModDate:TDatetime;
begin
  Result:=oTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDlvcatDat.SetModDate(pValue:TDatetime);
begin
  oTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TDlvcatDat.GetModTime:TDatetime;
begin
  Result:=oTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDlvcatDat.SetModTime(pValue:TDatetime);
begin
  oTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlvcatDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TDlvcatDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TDlvcatDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TDlvcatDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TDlvcatDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TDlvcatDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TDlvcatDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TDlvcatDat.LocPcBc(pPaCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex(ixPcBc);
  Result:=oTable.FindKey([pPaCode,pBarCode]);
end;

function TDlvcatDat.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex(ixBarCode);
  Result:=oTable.FindKey([pBarCode]);
end;

function TDlvcatDat.LocOrdCode(pOrdCode:Str20):boolean;
begin
  SetIndex(ixOrdCode);
  Result:=oTable.FindKey([pOrdCode]);
end;

function TDlvcatDat.NearPcBc(pPaCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex(ixPcBc);
  Result:=oTable.FindNearest([pPaCode,pBarCode]);
end;

function TDlvcatDat.NearBarCode(pBarCode:Str15):boolean;
begin
  SetIndex(ixBarCode);
  Result:=oTable.FindNearest([pBarCode]);
end;

function TDlvcatDat.NearOrdCode(pOrdCode:Str20):boolean;
begin
  SetIndex(ixOrdCode);
  Result:=oTable.FindNearest([pOrdCode]);
end;

procedure TDlvcatDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TDlvcatDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TDlvcatDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TDlvcatDat.Prior;
begin
  oTable.Prior;
end;

procedure TDlvcatDat.Next;
begin
  oTable.Next;
end;

procedure TDlvcatDat.First;
begin
  Open;
  oTable.First;
end;

procedure TDlvcatDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TDlvcatDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TDlvcatDat.Edit;
begin
  oTable.Edit;
end;

procedure TDlvcatDat.Post;
begin
  oTable.Post;
end;

procedure TDlvcatDat.Delete;
begin
  oTable.Delete;
end;

procedure TDlvcatDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TDlvcatDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TDlvcatDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TDlvcatDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TDlvcatDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TDlvcatDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2202001}
