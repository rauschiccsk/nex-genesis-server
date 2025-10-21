unit dCRDBON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrdNum='CrdNum';
  ixSerNum='SerNum';
  ixOutDte='OutDte';

type
  TCrdbonDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetCrdNum:Str20;            procedure SetCrdNum(pValue:Str20);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetOutDte:TDatetime;        procedure SetOutDte(pValue:TDatetime);
    function GetOutQnt:word;             procedure SetOutQnt(pValue:word);
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
    function LocCrdNum(pCrdNum:Str20):boolean;
    function LocSerNum(pSerNum:word):boolean;
    function LocOutDte(pOutDte:TDatetime):boolean;
    function NearCrdNum(pCrdNum:Str20):boolean;
    function NearSerNum(pSerNum:word):boolean;
    function NearOutDte(pOutDte:TDatetime):boolean;

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
    property CrdNum:Str20 read GetCrdNum write SetCrdNum;
    property SerNum:word read GetSerNum write SetSerNum;
    property OutDte:TDatetime read GetOutDte write SetOutDte;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TCrdbonDat.Create;
begin
  oTable:=DatInit('CRDBON',gPath.DlsPath,Self);
end;

constructor TCrdbonDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CRDBON',pPath,Self);
end;

destructor TCrdbonDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdbonDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCrdbonDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCrdbonDat.GetCrdNum:Str20;
begin
  Result:=oTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdbonDat.SetCrdNum(pValue:Str20);
begin
  oTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TCrdbonDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TCrdbonDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TCrdbonDat.GetOutDte:TDatetime;
begin
  Result:=oTable.FieldByName('OutDte').AsDateTime;
end;

procedure TCrdbonDat.SetOutDte(pValue:TDatetime);
begin
  oTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TCrdbonDat.GetOutQnt:word;
begin
  Result:=oTable.FieldByName('OutQnt').AsInteger;
end;

procedure TCrdbonDat.SetOutQnt(pValue:word);
begin
  oTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TCrdbonDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCrdbonDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCrdbonDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCrdbonDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCrdbonDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCrdbonDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdbonDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCrdbonDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCrdbonDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCrdbonDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCrdbonDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCrdbonDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCrdbonDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCrdbonDat.LocCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindKey([pCrdNum]);
end;

function TCrdbonDat.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TCrdbonDat.LocOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindKey([pOutDte]);
end;

function TCrdbonDat.NearCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindNearest([pCrdNum]);
end;

function TCrdbonDat.NearSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

function TCrdbonDat.NearOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindNearest([pOutDte]);
end;

procedure TCrdbonDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCrdbonDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCrdbonDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCrdbonDat.Prior;
begin
  oTable.Prior;
end;

procedure TCrdbonDat.Next;
begin
  oTable.Next;
end;

procedure TCrdbonDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCrdbonDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCrdbonDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCrdbonDat.Edit;
begin
  oTable.Edit;
end;

procedure TCrdbonDat.Post;
begin
  oTable.Post;
end;

procedure TCrdbonDat.Delete;
begin
  oTable.Delete;
end;

procedure TCrdbonDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCrdbonDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCrdbonDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCrdbonDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCrdbonDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCrdbonDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
