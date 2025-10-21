unit dCCTDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBasCod='BasCod';

type
  TCctdefDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetBasCod:Str10;            procedure SetBasCod(pValue:Str10);
    function GetBasNam:Str250;           procedure SetBasNam(pValue:Str250);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
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
    function LocBasCod(pBasCod:Str10):boolean;
    function NearBasCod(pBasCod:Str10):boolean;

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
    property BasCod:Str10 read GetBasCod write SetBasCod;
    property BasNam:Str250 read GetBasNam write SetBasNam;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
  end;

implementation

constructor TCctdefDat.Create;
begin
  oTable:=DatInit('CCTDEF',gPath.DlsPath,Self);
end;

constructor TCctdefDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CCTDEF',pPath,Self);
end;

destructor TCctdefDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCctdefDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCctdefDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCctdefDat.GetBasCod:Str10;
begin
  Result:=oTable.FieldByName('BasCod').AsString;
end;

procedure TCctdefDat.SetBasCod(pValue:Str10);
begin
  oTable.FieldByName('BasCod').AsString:=pValue;
end;

function TCctdefDat.GetBasNam:Str250;
begin
  Result:=oTable.FieldByName('BasNam').AsString;
end;

procedure TCctdefDat.SetBasNam(pValue:Str250);
begin
  oTable.FieldByName('BasNam').AsString:=pValue;
end;

function TCctdefDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TCctdefDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TCctdefDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TCctdefDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCctdefDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCctdefDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCctdefDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCctdefDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCctdefDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCctdefDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCctdefDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCctdefDat.LocBasCod(pBasCod:Str10):boolean;
begin
  SetIndex(ixBasCod);
  Result:=oTable.FindKey([pBasCod]);
end;

function TCctdefDat.NearBasCod(pBasCod:Str10):boolean;
begin
  SetIndex(ixBasCod);
  Result:=oTable.FindNearest([pBasCod]);
end;

procedure TCctdefDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCctdefDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCctdefDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCctdefDat.Prior;
begin
  oTable.Prior;
end;

procedure TCctdefDat.Next;
begin
  oTable.Next;
end;

procedure TCctdefDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCctdefDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCctdefDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCctdefDat.Edit;
begin
  oTable.Edit;
end;

procedure TCctdefDat.Post;
begin
  oTable.Post;
end;

procedure TCctdefDat.Delete;
begin
  oTable.Delete;
end;

procedure TCctdefDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCctdefDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCctdefDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCctdefDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCctdefDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCctdefDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2005001}
