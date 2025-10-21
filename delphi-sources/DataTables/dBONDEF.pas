unit dBONDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEndDte='EndDte';

type
  TBondefDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetBonVal:double;           procedure SetBonVal(pValue:double);
    function GetDesTxt:Str100;           procedure SetDesTxt(pValue:Str100);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
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
    function LocEndDte(pEndDte:TDatetime):boolean;
    function NearEndDte(pEndDte:TDatetime):boolean;

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
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property BonVal:double read GetBonVal write SetBonVal;
    property DesTxt:Str100 read GetDesTxt write SetDesTxt;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TBondefDat.Create;
begin
  oTable:=DatInit('BONDEF',gPath.CabPath,Self);
end;

constructor TBondefDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BONDEF',pPath,Self);
end;

destructor TBondefDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBondefDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBondefDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBondefDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TBondefDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TBondefDat.GetBonVal:double;
begin
  Result:=oTable.FieldByName('BonVal').AsFloat;
end;

procedure TBondefDat.SetBonVal(pValue:double);
begin
  oTable.FieldByName('BonVal').AsFloat:=pValue;
end;

function TBondefDat.GetDesTxt:Str100;
begin
  Result:=oTable.FieldByName('DesTxt').AsString;
end;

procedure TBondefDat.SetDesTxt(pValue:Str100);
begin
  oTable.FieldByName('DesTxt').AsString:=pValue;
end;

function TBondefDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBondefDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBondefDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBondefDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBondefDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBondefDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBondefDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBondefDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBondefDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBondefDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBondefDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBondefDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBondefDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBondefDat.LocEndDte(pEndDte:TDatetime):boolean;
begin
  SetIndex(ixEndDte);
  Result:=oTable.FindKey([pEndDte]);
end;

function TBondefDat.NearEndDte(pEndDte:TDatetime):boolean;
begin
  SetIndex(ixEndDte);
  Result:=oTable.FindNearest([pEndDte]);
end;

procedure TBondefDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBondefDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBondefDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBondefDat.Prior;
begin
  oTable.Prior;
end;

procedure TBondefDat.Next;
begin
  oTable.Next;
end;

procedure TBondefDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBondefDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBondefDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBondefDat.Edit;
begin
  oTable.Edit;
end;

procedure TBondefDat.Post;
begin
  oTable.Post;
end;

procedure TBondefDat.Delete;
begin
  oTable.Delete;
end;

procedure TBondefDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBondefDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBondefDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBondefDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBondefDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBondefDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
