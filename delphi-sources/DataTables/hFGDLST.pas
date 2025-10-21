unit hFGDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='PaCode';
  ixPnFn='PaFg';

type
  TFgdlstHnd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function GetTable:TNexBtrTable;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetFgrNum:longint;          procedure SetFgrNum(pValue:longint);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
  public
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocPnFn(pParNum,pFgrNum:longint):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearPnFn(pParNum,pFgrNum:longint):boolean;

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

    property Table:TNexBtrTable read GetTable;
  published
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property ParNum:longint read GetParNum write SetParNum;
    property FgrNum:longint read GetFgrNum write SetFgrNum;
    property DscPrc:double read GetDscPrc write SetDscPrc;
  end;

implementation

constructor TFgdlstHnd.Create;
begin
  oTable:=BtrInit('FGPADSC',gPath.StkPath,Self);
end;

destructor TFgdlstHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TFgdlstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TFgdlstHnd.GetTable:TNexBtrTable;
begin
  Open;
  Result:=oTable;
end;

function TFgdlstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TFgdlstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;
(*
procedure TFgdlstHnd.SetAplNum(pValue:word);
var mFldNum:Str3;
begin
  Open;
  oAplNum:=pValue;
  mFldNum:=StrInt(FieldNum('AplNum'),0);
  oTable.ClearFilter;
  oTable.Filter:='['+mFldNum+']={'+StrInt(oAplNum,0)+'}';
  oTable.Filtered:=TRUE;
end;
*)
// ********************* FIELDS *********************

function TFgdlstHnd.GetParNum:longint;
begin
  Result:=oTable.FieldByName('PaCode').AsInteger;
end;

procedure TFgdlstHnd.SetParNum(pValue:longint);
begin
  oTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TFgdlstHnd.GetFgrNum:longint;
begin
  Result:=oTable.FieldByName('FgCode').AsInteger;
end;

procedure TFgdlstHnd.SetFgrNum(pValue:longint);
begin
  oTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TFgdlstHnd.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TFgdlstHnd.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TFgdlstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TFgdlstHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TFgdlstHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TFgdlstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TFgdlstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TFgdlstHnd.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TFgdlstHnd.LocParNum(pParNum:longint):boolean;
begin
  Open;
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TFgdlstHnd.LocPnFn(pParNum,pFgrNum:longint):boolean;
begin
  Open;
  SetIndex(ixPnFn);
  Result:=oTable.FindKey([pParNum,pFgrNum]);
end;

function TFgdlstHnd.NearParNum(pParNum:longint):boolean;
begin
  Open;
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TFgdlstHnd.NearPnFn(pParNum,pFgrNum:longint):boolean;
begin
  Open;
  SetIndex(ixPnFn);
  Result:=oTable.FindNearest([pParNum,pFgrNum]);
end;

procedure TFgdlstHnd.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TFgdlstHnd.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TFgdlstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TFgdlstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TFgdlstHnd.Next;
begin
  oTable.Next;
end;

procedure TFgdlstHnd.First;
begin
  oTable.First;
end;

procedure TFgdlstHnd.Last;
begin
  oTable.Last;
end;

procedure TFgdlstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TFgdlstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TFgdlstHnd.Post;
begin
  oTable.Post;
end;

procedure TFgdlstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TFgdlstHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TFgdlstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TFgdlstHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TFgdlstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TFgdlstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TFgdlstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001}
