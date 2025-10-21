unit dOSGDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixParNam='ParNam';

type
  TOsgdocDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetOrdPrq:double;           procedure SetOrdPrq(pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva(pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva(pValue:double);
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
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
  end;

implementation

constructor TOsgdocDat.Create;
begin
  oTable:=DatInit('OSGDOC',gPath.StkPath,Self);
end;

constructor TOsgdocDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSGDOC',pPath,Self);
end;

destructor TOsgdocDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsgdocDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsgdocDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsgdocDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsgdocDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsgdocDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOsgdocDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsgdocDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TOsgdocDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOsgdocDat.GetOrdPrq:double;
begin
  Result:=oTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsgdocDat.SetOrdPrq(pValue:double);
begin
  oTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsgdocDat.GetOrdAva:double;
begin
  Result:=oTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsgdocDat.SetOrdAva(pValue:double);
begin
  oTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsgdocDat.GetOrdBva:double;
begin
  Result:=oTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsgdocDat.SetOrdBva(pValue:double);
begin
  oTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsgdocDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsgdocDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsgdocDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsgdocDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsgdocDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsgdocDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsgdocDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsgdocDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOsgdocDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TOsgdocDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOsgdocDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TOsgdocDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsgdocDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOsgdocDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsgdocDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsgdocDat.Next;
begin
  oTable.Next;
end;

procedure TOsgdocDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsgdocDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsgdocDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsgdocDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsgdocDat.Post;
begin
  oTable.Post;
end;

procedure TOsgdocDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsgdocDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsgdocDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsgdocDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsgdocDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsgdocDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsgdocDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
