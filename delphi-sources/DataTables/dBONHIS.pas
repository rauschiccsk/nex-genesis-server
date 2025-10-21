unit dBONHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixSerNum='SerNum';
  ixOutDte='OutDte';

type
  TBonhisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
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
    function LocParNum(pParNum:longint):boolean;
    function LocSerNum(pSerNum:word):boolean;
    function LocOutDte(pOutDte:TDatetime):boolean;
    function NearParNum(pParNum:longint):boolean;
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
    property ParNum:longint read GetParNum write SetParNum;
    property SerNum:word read GetSerNum write SetSerNum;
    property OutDte:TDatetime read GetOutDte write SetOutDte;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TBonhisDat.Create;
begin
  oTable:=DatInit('BONHIS',gPath.CabPath,Self);
end;

constructor TBonhisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BONHIS',pPath,Self);
end;

destructor TBonhisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBonhisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBonhisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBonhisDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TBonhisDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBonhisDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TBonhisDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TBonhisDat.GetOutDte:TDatetime;
begin
  Result:=oTable.FieldByName('OutDte').AsDateTime;
end;

procedure TBonhisDat.SetOutDte(pValue:TDatetime);
begin
  oTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TBonhisDat.GetOutQnt:word;
begin
  Result:=oTable.FieldByName('OutQnt').AsInteger;
end;

procedure TBonhisDat.SetOutQnt(pValue:word);
begin
  oTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TBonhisDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBonhisDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBonhisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBonhisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBonhisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBonhisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBonhisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBonhisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBonhisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBonhisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBonhisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBonhisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBonhisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBonhisDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TBonhisDat.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TBonhisDat.LocOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindKey([pOutDte]);
end;

function TBonhisDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TBonhisDat.NearSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

function TBonhisDat.NearOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindNearest([pOutDte]);
end;

procedure TBonhisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBonhisDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBonhisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBonhisDat.Prior;
begin
  oTable.Prior;
end;

procedure TBonhisDat.Next;
begin
  oTable.Next;
end;

procedure TBonhisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBonhisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBonhisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBonhisDat.Edit;
begin
  oTable.Edit;
end;

procedure TBonhisDat.Post;
begin
  oTable.Post;
end;

procedure TBonhisDat.Delete;
begin
  oTable.Delete;
end;

procedure TBonhisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBonhisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBonhisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBonhisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBonhisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBonhisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
