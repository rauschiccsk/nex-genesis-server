unit dSHDBON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaYe='PaYe';
  ixDocYer='DocYer';
  ixParNum='ParNum';
  ixSerNum='SerNum';
  ixOutDte='OutDte';

type
  TShdbonDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetOutDte:TDatetime;        procedure SetOutDte(pValue:TDatetime);
    function GetOutQnt:word;             procedure SetOutQnt(pValue:word);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
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
    function LocPaYe(pParNum:longint;pDocYer:Str2):boolean;
    function LocDocYer(pDocYer:Str2):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocSerNum(pSerNum:word):boolean;
    function LocOutDte(pOutDte:TDatetime):boolean;
    function NearPaYe(pParNum:longint;pDocYer:Str2):boolean;
    function NearDocYer(pDocYer:Str2):boolean;
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
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:word read GetSerNum write SetSerNum;
    property OutDte:TDatetime read GetOutDte write SetOutDte;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TShdbonDat.Create;
begin
  oTable:=DatInit('SHDBON',gPath.CabPath,Self);
end;

constructor TShdbonDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SHDBON',pPath,Self);
end;

destructor TShdbonDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TShdbonDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TShdbonDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TShdbonDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TShdbonDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TShdbonDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TShdbonDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TShdbonDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TShdbonDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TShdbonDat.GetOutDte:TDatetime;
begin
  Result:=oTable.FieldByName('OutDte').AsDateTime;
end;

procedure TShdbonDat.SetOutDte(pValue:TDatetime);
begin
  oTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TShdbonDat.GetOutQnt:word;
begin
  Result:=oTable.FieldByName('OutQnt').AsInteger;
end;

procedure TShdbonDat.SetOutQnt(pValue:word);
begin
  oTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TShdbonDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TShdbonDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TShdbonDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TShdbonDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TShdbonDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TShdbonDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TShdbonDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TShdbonDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdbonDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TShdbonDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TShdbonDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TShdbonDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TShdbonDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TShdbonDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TShdbonDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TShdbonDat.LocPaYe(pParNum:longint;pDocYer:Str2):boolean;
begin
  SetIndex(ixPaYe);
  Result:=oTable.FindKey([pParNum,pDocYer]);
end;

function TShdbonDat.LocDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindKey([pDocYer]);
end;

function TShdbonDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TShdbonDat.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TShdbonDat.LocOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindKey([pOutDte]);
end;

function TShdbonDat.NearPaYe(pParNum:longint;pDocYer:Str2):boolean;
begin
  SetIndex(ixPaYe);
  Result:=oTable.FindNearest([pParNum,pDocYer]);
end;

function TShdbonDat.NearDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindNearest([pDocYer]);
end;

function TShdbonDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TShdbonDat.NearSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

function TShdbonDat.NearOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindNearest([pOutDte]);
end;

procedure TShdbonDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TShdbonDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TShdbonDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TShdbonDat.Prior;
begin
  oTable.Prior;
end;

procedure TShdbonDat.Next;
begin
  oTable.Next;
end;

procedure TShdbonDat.First;
begin
  Open;
  oTable.First;
end;

procedure TShdbonDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TShdbonDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TShdbonDat.Edit;
begin
  oTable.Edit;
end;

procedure TShdbonDat.Post;
begin
  oTable.Post;
end;

procedure TShdbonDat.Delete;
begin
  oTable.Delete;
end;

procedure TShdbonDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TShdbonDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TShdbonDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TShdbonDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TShdbonDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TShdbonDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
