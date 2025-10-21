unit dEMDATD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmdNum='EmdNum';
  ixAtdNam='AtdNam';

type
  TEmdatdDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEmdNum:longint;          procedure SetEmdNum(pValue:longint);
    function GetAtdNam:Str100;           procedure SetAtdNam(pValue:Str100);
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
    function LocEmdNum(pEmdNum:longint):boolean;
    function LocAtdNam(pAtdNam:Str100):boolean;
    function NearEmdNum(pEmdNum:longint):boolean;
    function NearAtdNam(pAtdNam:Str100):boolean;

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
    property EmdNum:longint read GetEmdNum write SetEmdNum;
    property AtdNam:Str100 read GetAtdNam write SetAtdNam;
  end;

implementation

constructor TEmdatdDat.Create;
begin
  oTable:=DatInit('EMDATD',gPath.SysPath,Self);
end;

constructor TEmdatdDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EMDATD',pPath,Self);
end;

destructor TEmdatdDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEmdatdDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEmdatdDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEmdatdDat.GetEmdNum:longint;
begin
  Result:=oTable.FieldByName('EmdNum').AsInteger;
end;

procedure TEmdatdDat.SetEmdNum(pValue:longint);
begin
  oTable.FieldByName('EmdNum').AsInteger:=pValue;
end;

function TEmdatdDat.GetAtdNam:Str100;
begin
  Result:=oTable.FieldByName('AtdNam').AsString;
end;

procedure TEmdatdDat.SetAtdNam(pValue:Str100);
begin
  oTable.FieldByName('AtdNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmdatdDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEmdatdDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEmdatdDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEmdatdDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEmdatdDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEmdatdDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEmdatdDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEmdatdDat.LocEmdNum(pEmdNum:longint):boolean;
begin
  SetIndex(ixEmdNum);
  Result:=oTable.FindKey([pEmdNum]);
end;

function TEmdatdDat.LocAtdNam(pAtdNam:Str100):boolean;
begin
  SetIndex(ixAtdNam);
  Result:=oTable.FindKey([pAtdNam]);
end;

function TEmdatdDat.NearEmdNum(pEmdNum:longint):boolean;
begin
  SetIndex(ixEmdNum);
  Result:=oTable.FindNearest([pEmdNum]);
end;

function TEmdatdDat.NearAtdNam(pAtdNam:Str100):boolean;
begin
  SetIndex(ixAtdNam);
  Result:=oTable.FindNearest([pAtdNam]);
end;

procedure TEmdatdDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEmdatdDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEmdatdDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEmdatdDat.Prior;
begin
  oTable.Prior;
end;

procedure TEmdatdDat.Next;
begin
  oTable.Next;
end;

procedure TEmdatdDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEmdatdDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEmdatdDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEmdatdDat.Edit;
begin
  oTable.Edit;
end;

procedure TEmdatdDat.Post;
begin
  oTable.Post;
end;

procedure TEmdatdDat.Delete;
begin
  oTable.Delete;
end;

procedure TEmdatdDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEmdatdDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEmdatdDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEmdatdDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEmdatdDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEmdatdDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
