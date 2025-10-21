unit dPRPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmdNam='PmdNam';
  ixPnBn='PnBn';
  ixPnBnPnPs='PnBnPnPs';

type
  TPrplstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetPmdNam:Str3;             procedure SetPmdNam(pValue:Str3);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetPrpNam:Str9;             procedure SetPrpNam(pValue:Str9);
    function GetPrpSpc:Str5;             procedure SetPrpSpc(pValue:Str5);
    function GetPrpVal:Str100;           procedure SetPrpVal(pValue:Str100);
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
    function LocPmdNam(pPmdNam:Str3):boolean;
    function LocPnBn(pPmdNam:Str3;pBokNum:Str3):boolean;
    function LocPnBnPnPs(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5):boolean;
    function NearPmdNam(pPmdNam:Str3):boolean;
    function NearPnBn(pPmdNam:Str3;pBokNum:Str3):boolean;
    function NearPnBnPnPs(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5):boolean;

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
    property PmdNam:Str3 read GetPmdNam write SetPmdNam;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property PrpNam:Str9 read GetPrpNam write SetPrpNam;
    property PrpSpc:Str5 read GetPrpSpc write SetPrpSpc;
    property PrpVal:Str100 read GetPrpVal write SetPrpVal;
  end;

implementation

constructor TPrplstDat.Create;
begin
  oTable:=DatInit('PRPLST',gPath.SysPath,Self);
end;

constructor TPrplstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('PRPLST',pPath,Self);
end;

destructor TPrplstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TPrplstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TPrplstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TPrplstDat.GetPmdNam:Str3;
begin
  Result:=oTable.FieldByName('PmdNam').AsString;
end;

procedure TPrplstDat.SetPmdNam(pValue:Str3);
begin
  oTable.FieldByName('PmdNam').AsString:=pValue;
end;

function TPrplstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TPrplstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TPrplstDat.GetPrpNam:Str9;
begin
  Result:=oTable.FieldByName('PrpNam').AsString;
end;

procedure TPrplstDat.SetPrpNam(pValue:Str9);
begin
  oTable.FieldByName('PrpNam').AsString:=pValue;
end;

function TPrplstDat.GetPrpSpc:Str5;
begin
  Result:=oTable.FieldByName('PrpSpc').AsString;
end;

procedure TPrplstDat.SetPrpSpc(pValue:Str5);
begin
  oTable.FieldByName('PrpSpc').AsString:=pValue;
end;

function TPrplstDat.GetPrpVal:Str100;
begin
  Result:=oTable.FieldByName('PrpVal').AsString;
end;

procedure TPrplstDat.SetPrpVal(pValue:Str100);
begin
  oTable.FieldByName('PrpVal').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrplstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TPrplstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TPrplstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TPrplstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TPrplstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TPrplstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TPrplstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TPrplstDat.LocPmdNam(pPmdNam:Str3):boolean;
begin
  SetIndex(ixPmdNam);
  Result:=oTable.FindKey([pPmdNam]);
end;

function TPrplstDat.LocPnBn(pPmdNam:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPnBn);
  Result:=oTable.FindKey([pPmdNam,pBokNum]);
end;

function TPrplstDat.LocPnBnPnPs(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5):boolean;
begin
  SetIndex(ixPnBnPnPs);
  Result:=oTable.FindKey([pPmdNam,pBokNum,pPrpNam,pPrpSpc]);
end;

function TPrplstDat.NearPmdNam(pPmdNam:Str3):boolean;
begin
  SetIndex(ixPmdNam);
  Result:=oTable.FindNearest([pPmdNam]);
end;

function TPrplstDat.NearPnBn(pPmdNam:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPnBn);
  Result:=oTable.FindNearest([pPmdNam,pBokNum]);
end;

function TPrplstDat.NearPnBnPnPs(pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str9;pPrpSpc:Str5):boolean;
begin
  SetIndex(ixPnBnPnPs);
  Result:=oTable.FindNearest([pPmdNam,pBokNum,pPrpNam,pPrpSpc]);
end;

procedure TPrplstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TPrplstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TPrplstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TPrplstDat.Prior;
begin
  oTable.Prior;
end;

procedure TPrplstDat.Next;
begin
  oTable.Next;
end;

procedure TPrplstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TPrplstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TPrplstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TPrplstDat.Edit;
begin
  oTable.Edit;
end;

procedure TPrplstDat.Post;
begin
  oTable.Post;
end;

procedure TPrplstDat.Delete;
begin
  oTable.Delete;
end;

procedure TPrplstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TPrplstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TPrplstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TPrplstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TPrplstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TPrplstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2005001}
