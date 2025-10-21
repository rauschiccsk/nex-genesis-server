unit dOWCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum='SerNum';

type
  TOwclstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetOwcNam:Str10;            procedure SetOwcNam(pValue:Str10);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetNexDir:Str50;            procedure SetNexDir(pValue:Str50);
    function GetDcpEna:Str1;             procedure SetDcpEna(pValue:Str1);
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
    function LocSerNum(pSerNum:word):boolean;
    function NearSerNum(pSerNum:word):boolean;

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
    property SerNum:word read GetSerNum write SetSerNum;
    property OwcNam:Str10 read GetOwcNam write SetOwcNam;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property NexDir:Str50 read GetNexDir write SetNexDir;
    property DcpEna:Str1 read GetDcpEna write SetDcpEna;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOwclstDat.Create;
begin
  oTable:=DatInit('OWCLST',gPath.DlsPath,Self);
end;

constructor TOwclstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OWCLST',pPath,Self);
end;

destructor TOwclstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOwclstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOwclstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOwclstDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TOwclstDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOwclstDat.GetOwcNam:Str10;
begin
  Result:=oTable.FieldByName('OwcNam').AsString;
end;

procedure TOwclstDat.SetOwcNam(pValue:Str10);
begin
  oTable.FieldByName('OwcNam').AsString:=pValue;
end;

function TOwclstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOwclstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOwclstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOwclstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOwclstDat.GetNexDir:Str50;
begin
  Result:=oTable.FieldByName('NexDir').AsString;
end;

procedure TOwclstDat.SetNexDir(pValue:Str50);
begin
  oTable.FieldByName('NexDir').AsString:=pValue;
end;

function TOwclstDat.GetDcpEna:Str1;
begin
  Result:=oTable.FieldByName('DcpEna').AsString;
end;

procedure TOwclstDat.SetDcpEna(pValue:Str1);
begin
  oTable.FieldByName('DcpEna').AsString:=pValue;
end;

function TOwclstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOwclstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOwclstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOwclstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOwclstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOwclstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOwclstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOwclstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOwclstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOwclstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOwclstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOwclstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOwclstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOwclstDat.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindKey([pSerNum]);
end;

function TOwclstDat.NearSerNum(pSerNum:word):boolean;
begin
  SetIndex(ixSerNum);
  Result:=oTable.FindNearest([pSerNum]);
end;

procedure TOwclstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOwclstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOwclstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOwclstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOwclstDat.Next;
begin
  oTable.Next;
end;

procedure TOwclstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOwclstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOwclstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOwclstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOwclstDat.Post;
begin
  oTable.Post;
end;

procedure TOwclstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOwclstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOwclstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOwclstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOwclstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOwclstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOwclstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
