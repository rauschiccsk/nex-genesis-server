unit hFGRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgrNum='FgrNum';

type
  TFgrlstHnd=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetFgrNum:longint;          procedure SetFgrNum(pValue:longint);
    function GetFgrNam:Str30;            procedure SetFgrNam(pValue:Str30);
    function GetFgrDes:Str150;           procedure SetFgrDes(pValue:Str150);
    function GetMaxDsc:double;           procedure SetMaxDsc(pValue:double);
    function GetMinPrf:double;           procedure SetMinPrf(pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):byte;
    function LocFgrNum(pFgrNum:longint):boolean;
    function NearFgrNum(pFgrNum:longint):boolean;

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
    property FgrNum:longint read GetFgrNum write SetFgrNum;
    property FgrNam:Str30 read GetFgrNam write SetFgrNam;
    property FgrDes:Str150 read GetFgrDes write SetFgrDes;
    property MaxDsc:double read GetMaxDsc write SetMaxDsc;
    property MinPrf:double read GetMinPrf write SetMinPrf;
  end;

implementation

constructor TFgrlstHnd.Create;
begin
  oTable:=BtrInit('FGLST',gPath.StkPath,Self);
end;

constructor TFgrlstHnd.Create(pPath:ShortString);
begin
  oTable:=BtrInit('FGLST',pPath,Self);
end;

destructor TFgrlstHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TFgrlstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TFgrlstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TFgrlstHnd.GetFgrNum:longint;
begin
  Result:=oTable.FieldByName('FgCode').AsInteger;
end;

procedure TFgrlstHnd.SetFgrNum(pValue:longint);
begin
  oTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TFgrlstHnd.GetFgrNam:Str30;
begin
  Result:=oTable.FieldByName('FgName').AsString;
end;

procedure TFgrlstHnd.SetFgrNam(pValue:Str30);
begin
  oTable.FieldByName('FgName').AsString:=pValue;
end;

function TFgrlstHnd.GetFgrDes:Str150;
begin
  Result:=oTable.FieldByName('Describe').AsString;
end;

procedure TFgrlstHnd.SetFgrDes(pValue:Str150);
begin
  oTable.FieldByName('Describe').AsString:=pValue;
end;

function TFgrlstHnd.GetMaxDsc:double;
begin
  Result:=oTable.FieldByName('MaxDsc').AsFloat;
end;

procedure TFgrlstHnd.SetMaxDsc(pValue:double);
begin
  oTable.FieldByName('MaxDsc').AsFloat:=pValue;
end;

function TFgrlstHnd.GetMinPrf:double;
begin
  Result:=oTable.FieldByName('MinPrf').AsFloat;
end;

procedure TFgrlstHnd.SetMinPrf(pValue:double);
begin
  oTable.FieldByName('MinPrf').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TFgrlstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TFgrlstHnd.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TFgrlstHnd.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TFgrlstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TFgrlstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TFgrlstHnd.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TFgrlstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

function TFgrlstHnd.LocFgrNum(pFgrNum:longint):boolean;
begin
  SetIndex(ixFgrNum);
  Result:=oTable.FindKey([pFgrNum]);
end;

function TFgrlstHnd.NearFgrNum(pFgrNum:longint):boolean;
begin
  SetIndex(ixFgrNum);
  Result:=oTable.FindNearest([pFgrNum]);
end;

procedure TFgrlstHnd.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TFgrlstHnd.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TFgrlstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TFgrlstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TFgrlstHnd.Next;
begin
  oTable.Next;
end;

procedure TFgrlstHnd.First;
begin
  oTable.First;
end;

procedure TFgrlstHnd.Last;
begin
  oTable.Last;
end;

procedure TFgrlstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TFgrlstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TFgrlstHnd.Post;
begin
  oTable.Post;
end;

procedure TFgrlstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TFgrlstHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TFgrlstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TFgrlstHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TFgrlstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TFgrlstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TFgrlstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
