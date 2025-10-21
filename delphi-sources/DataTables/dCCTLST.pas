unit dCCTLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCctCod='CctCod';
  ix_CctNam='_CctNam';

type
  TCctlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetCctCod:Str10;            procedure SetCctCod(pValue:Str10);
    function GetCctNam:Str250;           procedure SetCctNam(pValue:Str250);
    function GetCctNam_:Str250;          procedure SetCctNam_(pValue:Str250);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
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
    function LocCctCod(pCctCod:Str10):boolean;
    function Loc_CctNam(pCctNam_:Str250):boolean;
    function NearCctCod(pCctCod:Str10):boolean;
    function Near_CctNam(pCctNam_:Str250):boolean;

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
    property CctCod:Str10 read GetCctCod write SetCctCod;
    property CctNam:Str250 read GetCctNam write SetCctNam;
    property CctNam_:Str250 read GetCctNam_ write SetCctNam_;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TCctlstDat.Create;
begin
  oTable:=DatInit('CCTLST',gPath.DlsPath,Self);
end;

constructor TCctlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CCTLST',pPath,Self);
end;

destructor TCctlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCctlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCctlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCctlstDat.GetCctCod:Str10;
begin
  Result:=oTable.FieldByName('CctCod').AsString;
end;

procedure TCctlstDat.SetCctCod(pValue:Str10);
begin
  oTable.FieldByName('CctCod').AsString:=pValue;
end;

function TCctlstDat.GetCctNam:Str250;
begin
  Result:=oTable.FieldByName('CctNam').AsString;
end;

procedure TCctlstDat.SetCctNam(pValue:Str250);
begin
  oTable.FieldByName('CctNam').AsString:=pValue;
end;

function TCctlstDat.GetCctNam_:Str250;
begin
  Result:=oTable.FieldByName('CctNam_').AsString;
end;

procedure TCctlstDat.SetCctNam_(pValue:Str250);
begin
  oTable.FieldByName('CctNam_').AsString:=pValue;
end;

function TCctlstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCctlstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCctlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCctlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCctlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCctlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCctlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCctlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCctlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCctlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCctlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCctlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCctlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCctlstDat.LocCctCod(pCctCod:Str10):boolean;
begin
  SetIndex(ixCctCod);
  Result:=oTable.FindKey([pCctCod]);
end;

function TCctlstDat.Loc_CctNam(pCctNam_:Str250):boolean;
begin
  SetIndex(ix_CctNam);
  Result:=oTable.FindKey([StrToAlias(pCctNam_)]);
end;

function TCctlstDat.NearCctCod(pCctCod:Str10):boolean;
begin
  SetIndex(ixCctCod);
  Result:=oTable.FindNearest([pCctCod]);
end;

function TCctlstDat.Near_CctNam(pCctNam_:Str250):boolean;
begin
  SetIndex(ix_CctNam);
  Result:=oTable.FindNearest([pCctNam_]);
end;

procedure TCctlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCctlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCctlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCctlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TCctlstDat.Next;
begin
  oTable.Next;
end;

procedure TCctlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCctlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCctlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCctlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TCctlstDat.Post;
begin
  oTable.Post;
end;

procedure TCctlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TCctlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCctlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCctlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCctlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCctlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCctlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2008001}
