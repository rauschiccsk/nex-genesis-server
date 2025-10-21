unit dXRIDST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDySnPn='DySnPn';
  ixCmpNum='CmpNum';
  ixCmpCod='CmpCod';

type
  TXridstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetActCva:double;           procedure SetActCva(pValue:double);
    function GetCmpNum:longint;          procedure SetCmpNum(pValue:longint);
    function GetCmpNam:Str60;            procedure SetCmpNam(pValue:Str60);
    function GetCmpCod:Str15;            procedure SetCmpCod(pValue:Str15);
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
    function LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function LocCmpNum(pCmpNum:longint):boolean;
    function LocCmpCod(pCmpCod:Str15):boolean;
    function NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function NearCmpNum(pCmpNum:longint):boolean;
    function NearCmpCod(pCmpCod:Str15):boolean;

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
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:word read GetSerNum write SetSerNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ActPrq:double read GetActPrq write SetActPrq;
    property ActCva:double read GetActCva write SetActCva;
    property CmpNum:longint read GetCmpNum write SetCmpNum;
    property CmpNam:Str60 read GetCmpNam write SetCmpNam;
    property CmpCod:Str15 read GetCmpCod write SetCmpCod;
  end;

implementation

constructor TXridstDat.Create;
begin
  oTable:=DatInit('XRIDST',gPath.StkPath,Self);
end;

constructor TXridstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('XRIDST',pPath,Self);
end;

destructor TXridstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TXridstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TXridstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TXridstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TXridstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TXridstDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TXridstDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TXridstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TXridstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXridstDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TXridstDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TXridstDat.GetActCva:double;
begin
  Result:=oTable.FieldByName('ActCva').AsFloat;
end;

procedure TXridstDat.SetActCva(pValue:double);
begin
  oTable.FieldByName('ActCva').AsFloat:=pValue;
end;

function TXridstDat.GetCmpNum:longint;
begin
  Result:=oTable.FieldByName('CmpNum').AsInteger;
end;

procedure TXridstDat.SetCmpNum(pValue:longint);
begin
  oTable.FieldByName('CmpNum').AsInteger:=pValue;
end;

function TXridstDat.GetCmpNam:Str60;
begin
  Result:=oTable.FieldByName('CmpNam').AsString;
end;

procedure TXridstDat.SetCmpNam(pValue:Str60);
begin
  oTable.FieldByName('CmpNam').AsString:=pValue;
end;

function TXridstDat.GetCmpCod:Str15;
begin
  Result:=oTable.FieldByName('CmpCod').AsString;
end;

procedure TXridstDat.SetCmpCod(pValue:Str15);
begin
  oTable.FieldByName('CmpCod').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXridstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TXridstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TXridstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TXridstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TXridstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TXridstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TXridstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TXridstDat.LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindKey([pDocYer,pSerNum,pProNum]);
end;

function TXridstDat.LocCmpNum(pCmpNum:longint):boolean;
begin
  SetIndex(ixCmpNum);
  Result:=oTable.FindKey([pCmpNum]);
end;

function TXridstDat.LocCmpCod(pCmpCod:Str15):boolean;
begin
  SetIndex(ixCmpCod);
  Result:=oTable.FindKey([pCmpCod]);
end;

function TXridstDat.NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindNearest([pDocYer,pSerNum,pProNum]);
end;

function TXridstDat.NearCmpNum(pCmpNum:longint):boolean;
begin
  SetIndex(ixCmpNum);
  Result:=oTable.FindNearest([pCmpNum]);
end;

function TXridstDat.NearCmpCod(pCmpCod:Str15):boolean;
begin
  SetIndex(ixCmpCod);
  Result:=oTable.FindNearest([pCmpCod]);
end;

procedure TXridstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TXridstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TXridstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TXridstDat.Prior;
begin
  oTable.Prior;
end;

procedure TXridstDat.Next;
begin
  oTable.Next;
end;

procedure TXridstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TXridstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TXridstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TXridstDat.Edit;
begin
  oTable.Edit;
end;

procedure TXridstDat.Post;
begin
  oTable.Post;
end;

procedure TXridstDat.Delete;
begin
  oTable.Delete;
end;

procedure TXridstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TXridstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TXridstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TXridstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TXridstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TXridstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
