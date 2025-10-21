unit dDOCCNT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDyDtBn='DyDtBn';

type
  TDoccntDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetCntNum:longint;          procedure SetCntNum(pValue:longint);
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
    function LocDyDtBn(pDocYer:Str2;pDocTyp:Str2;pBokNum:Str3):boolean;
    function NearDyDtBn(pDocYer:Str2;pDocTyp:Str2;pBokNum:Str3):boolean;

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
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property CntNum:longint read GetCntNum write SetCntNum;
  end;

implementation

constructor TDoccntDat.Create;
begin
  oTable:=DatInit('DOCCNT',gPath.SysPath,Self);
end;

constructor TDoccntDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('DOCCNT',pPath,Self);
end;

destructor TDoccntDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TDoccntDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TDoccntDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TDoccntDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TDoccntDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TDoccntDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TDoccntDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TDoccntDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TDoccntDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TDoccntDat.GetCntNum:longint;
begin
  Result:=oTable.FieldByName('CntNum').AsInteger;
end;

procedure TDoccntDat.SetCntNum(pValue:longint);
begin
  oTable.FieldByName('CntNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDoccntDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TDoccntDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TDoccntDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TDoccntDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TDoccntDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TDoccntDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TDoccntDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TDoccntDat.LocDyDtBn(pDocYer:Str2;pDocTyp:Str2;pBokNum:Str3):boolean;
begin
  SetIndex(ixDyDtBn);
  Result:=oTable.FindKey([pDocYer,pDocTyp,pBokNum]);
end;

function TDoccntDat.NearDyDtBn(pDocYer:Str2;pDocTyp:Str2;pBokNum:Str3):boolean;
begin
  SetIndex(ixDyDtBn);
  Result:=oTable.FindNearest([pDocYer,pDocTyp,pBokNum]);
end;

procedure TDoccntDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TDoccntDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TDoccntDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TDoccntDat.Prior;
begin
  oTable.Prior;
end;

procedure TDoccntDat.Next;
begin
  oTable.Next;
end;

procedure TDoccntDat.First;
begin
  Open;
  oTable.First;
end;

procedure TDoccntDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TDoccntDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TDoccntDat.Edit;
begin
  oTable.Edit;
end;

procedure TDoccntDat.Post;
begin
  oTable.Post;
end;

procedure TDoccntDat.Delete;
begin
  oTable.Delete;
end;

procedure TDoccntDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TDoccntDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TDoccntDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TDoccntDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TDoccntDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TDoccntDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
