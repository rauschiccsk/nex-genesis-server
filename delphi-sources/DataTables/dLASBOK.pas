unit dLASBOK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUlPc='UlPc';

type
  TLasbokDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetUsrLog:Str10;            procedure SetUsrLog(pValue:Str10);
    function GetPmdCod:Str3;             procedure SetPmdCod(pValue:Str3);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
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
    function LocUlPc(pUsrLog:Str10;pPmdCod:Str3):boolean;
    function NearUlPc(pUsrLog:Str10;pPmdCod:Str3):boolean;

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
    property UsrLog:Str10 read GetUsrLog write SetUsrLog;
    property PmdCod:Str3 read GetPmdCod write SetPmdCod;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TLasbokDat.Create;
begin
  oTable:=DatInit('LASBOK',gPath.SysPath,Self);
end;

constructor TLasbokDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('LASBOK',pPath,Self);
end;

destructor TLasbokDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TLasbokDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TLasbokDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TLasbokDat.GetUsrLog:Str10;
begin
  Result:=oTable.FieldByName('UsrLog').AsString;
end;

procedure TLasbokDat.SetUsrLog(pValue:Str10);
begin
  oTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TLasbokDat.GetPmdCod:Str3;
begin
  Result:=oTable.FieldByName('PmdCod').AsString;
end;

procedure TLasbokDat.SetPmdCod(pValue:Str3);
begin
  oTable.FieldByName('PmdCod').AsString:=pValue;
end;

function TLasbokDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TLasbokDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TLasbokDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TLasbokDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TLasbokDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TLasbokDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TLasbokDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TLasbokDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TLasbokDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TLasbokDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TLasbokDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TLasbokDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TLasbokDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TLasbokDat.LocUlPc(pUsrLog:Str10;pPmdCod:Str3):boolean;
begin
  SetIndex(ixUlPc);
  Result:=oTable.FindKey([pUsrLog,pPmdCod]);
end;

function TLasbokDat.NearUlPc(pUsrLog:Str10;pPmdCod:Str3):boolean;
begin
  SetIndex(ixUlPc);
  Result:=oTable.FindNearest([pUsrLog,pPmdCod]);
end;

procedure TLasbokDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TLasbokDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TLasbokDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TLasbokDat.Prior;
begin
  oTable.Prior;
end;

procedure TLasbokDat.Next;
begin
  oTable.Next;
end;

procedure TLasbokDat.First;
begin
  Open;
  oTable.First;
end;

procedure TLasbokDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TLasbokDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TLasbokDat.Edit;
begin
  oTable.Edit;
end;

procedure TLasbokDat.Post;
begin
  oTable.Post;
end;

procedure TLasbokDat.Delete;
begin
  oTable.Delete;
end;

procedure TLasbokDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TLasbokDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TLasbokDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TLasbokDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TLasbokDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TLasbokDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
