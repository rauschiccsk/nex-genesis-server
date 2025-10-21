unit dDOCAPP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDtDaPr='DtDaPr';

type
  TDocappDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetProces:Str1;             procedure SetProces(pValue:Str1);
    function GetDapSig:Str100;           procedure SetDapSig(pValue:Str100);
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
    function LocDtDaPr(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean;
    function NearDtDaPr(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean;

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
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property Proces:Str1 read GetProces write SetProces;
    property DapSig:Str100 read GetDapSig write SetDapSig;
  end;

implementation

constructor TDocappDat.Create;
begin
  oTable:=DatInit('DOCAPP',gPath.DlsPath,Self);
end;

constructor TDocappDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('DOCAPP',pPath,Self);
end;

destructor TDocappDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TDocappDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TDocappDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TDocappDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TDocappDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TDocappDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TDocappDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TDocappDat.GetProces:Str1;
begin
  Result:=oTable.FieldByName('Proces').AsString;
end;

procedure TDocappDat.SetProces(pValue:Str1);
begin
  oTable.FieldByName('Proces').AsString:=pValue;
end;

function TDocappDat.GetDapSig:Str100;
begin
  Result:=oTable.FieldByName('DapSig').AsString;
end;

procedure TDocappDat.SetDapSig(pValue:Str100);
begin
  oTable.FieldByName('DapSig').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocappDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TDocappDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TDocappDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TDocappDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TDocappDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TDocappDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TDocappDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TDocappDat.LocDtDaPr(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean;
begin
  SetIndex(ixDtDaPr);
  Result:=oTable.FindKey([pDocTyp,pDocNum,pProces]);
end;

function TDocappDat.NearDtDaPr(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean;
begin
  SetIndex(ixDtDaPr);
  Result:=oTable.FindNearest([pDocTyp,pDocNum,pProces]);
end;

procedure TDocappDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TDocappDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TDocappDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TDocappDat.Prior;
begin
  oTable.Prior;
end;

procedure TDocappDat.Next;
begin
  oTable.Next;
end;

procedure TDocappDat.First;
begin
  Open;
  oTable.First;
end;

procedure TDocappDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TDocappDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TDocappDat.Edit;
begin
  oTable.Edit;
end;

procedure TDocappDat.Post;
begin
  oTable.Post;
end;

procedure TDocappDat.Delete;
begin
  oTable.Delete;
end;

procedure TDocappDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TDocappDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TDocappDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TDocappDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TDocappDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TDocappDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
