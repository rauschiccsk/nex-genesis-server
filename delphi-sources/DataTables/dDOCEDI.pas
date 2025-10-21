unit dDOCEDI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';

type
  TDocediDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetUsrLog:Str8;             procedure SetUsrLog(pValue:Str8);
    function GetUsrNam:Str30;            procedure SetUsrNam(pValue:Str30);
    function GetEdiDte:TDatetime;        procedure SetEdiDte(pValue:TDatetime);
    function GetEdiTim:TDatetime;        procedure SetEdiTim(pValue:TDatetime);
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
    function LocDocNum(pDocNum:Str12):boolean;
    function NearDocNum(pDocNum:Str12):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property UsrLog:Str8 read GetUsrLog write SetUsrLog;
    property UsrNam:Str30 read GetUsrNam write SetUsrNam;
    property EdiDte:TDatetime read GetEdiDte write SetEdiDte;
    property EdiTim:TDatetime read GetEdiTim write SetEdiTim;
  end;

implementation

constructor TDocediDat.Create;
begin
  oTable:=DatInit('DOCEDI',gPath.SysPath,Self);
end;

constructor TDocediDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('DOCEDI',pPath,Self);
end;

destructor TDocediDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TDocediDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TDocediDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TDocediDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TDocediDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TDocediDat.GetUsrLog:Str8;
begin
  Result:=oTable.FieldByName('UsrLog').AsString;
end;

procedure TDocediDat.SetUsrLog(pValue:Str8);
begin
  oTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TDocediDat.GetUsrNam:Str30;
begin
  Result:=oTable.FieldByName('UsrNam').AsString;
end;

procedure TDocediDat.SetUsrNam(pValue:Str30);
begin
  oTable.FieldByName('UsrNam').AsString:=pValue;
end;

function TDocediDat.GetEdiDte:TDatetime;
begin
  Result:=oTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TDocediDat.SetEdiDte(pValue:TDatetime);
begin
  oTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TDocediDat.GetEdiTim:TDatetime;
begin
  Result:=oTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TDocediDat.SetEdiTim(pValue:TDatetime);
begin
  oTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocediDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TDocediDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TDocediDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TDocediDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TDocediDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TDocediDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TDocediDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TDocediDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TDocediDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

procedure TDocediDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TDocediDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TDocediDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TDocediDat.Prior;
begin
  oTable.Prior;
end;

procedure TDocediDat.Next;
begin
  oTable.Next;
end;

procedure TDocediDat.First;
begin
  Open;
  oTable.First;
end;

procedure TDocediDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TDocediDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TDocediDat.Edit;
begin
  oTable.Edit;
end;

procedure TDocediDat.Post;
begin
  oTable.Post;
end;

procedure TDocediDat.Delete;
begin
  oTable.Delete;
end;

procedure TDocediDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TDocediDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TDocediDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TDocediDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TDocediDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TDocediDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
