unit dEXPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExpNum='ExpNum';
  ixGrpCod='GrpCod';
  ixShwSta='ShwSta';

type
  TExplstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetExpNum:word;             procedure SetExpNum(pValue:word);
    function GetExpNam:Str200;           procedure SetExpNam(pValue:Str200);
    function GetGrpCod:Str10;            procedure SetGrpCod(pValue:Str10);
    function GetButNam:Str10;            procedure SetButNam(pValue:Str10);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetRecQnt:longint;          procedure SetRecQnt(pValue:longint);
    function GetExpDir:Str100;           procedure SetExpDir(pValue:Str100);
    function GetShwSta:Str1;             procedure SetShwSta(pValue:Str1);
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
    function LocExpNum(pExpNum:word):boolean;
    function LocGrpCod(pGrpCod:Str10):boolean;
    function LocShwSta(pShwSta:Str1):boolean;
    function NearExpNum(pExpNum:word):boolean;
    function NearGrpCod(pGrpCod:Str10):boolean;
    function NearShwSta(pShwSta:Str1):boolean;

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
    property ExpNum:word read GetExpNum write SetExpNum;
    property ExpNam:Str200 read GetExpNam write SetExpNam;
    property GrpCod:Str10 read GetGrpCod write SetGrpCod;
    property ButNam:Str10 read GetButNam write SetButNam;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property RecQnt:longint read GetRecQnt write SetRecQnt;
    property ExpDir:Str100 read GetExpDir write SetExpDir;
    property ShwSta:Str1 read GetShwSta write SetShwSta;
  end;

implementation

constructor TExplstDat.Create;
begin
  oTable:=DatInit('EXPLST',gPath.SysPath,Self);
end;

constructor TExplstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EXPLST',pPath,Self);
end;

destructor TExplstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TExplstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TExplstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TExplstDat.GetExpNum:word;
begin
  Result:=oTable.FieldByName('ExpNum').AsInteger;
end;

procedure TExplstDat.SetExpNum(pValue:word);
begin
  oTable.FieldByName('ExpNum').AsInteger:=pValue;
end;

function TExplstDat.GetExpNam:Str200;
begin
  Result:=oTable.FieldByName('ExpNam').AsString;
end;

procedure TExplstDat.SetExpNam(pValue:Str200);
begin
  oTable.FieldByName('ExpNam').AsString:=pValue;
end;

function TExplstDat.GetGrpCod:Str10;
begin
  Result:=oTable.FieldByName('GrpCod').AsString;
end;

procedure TExplstDat.SetGrpCod(pValue:Str10);
begin
  oTable.FieldByName('GrpCod').AsString:=pValue;
end;

function TExplstDat.GetButNam:Str10;
begin
  Result:=oTable.FieldByName('ButNam').AsString;
end;

procedure TExplstDat.SetButNam(pValue:Str10);
begin
  oTable.FieldByName('ButNam').AsString:=pValue;
end;

function TExplstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TExplstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TExplstDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TExplstDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TExplstDat.GetRecQnt:longint;
begin
  Result:=oTable.FieldByName('RecQnt').AsInteger;
end;

procedure TExplstDat.SetRecQnt(pValue:longint);
begin
  oTable.FieldByName('RecQnt').AsInteger:=pValue;
end;

function TExplstDat.GetExpDir:Str100;
begin
  Result:=oTable.FieldByName('ExpDir').AsString;
end;

procedure TExplstDat.SetExpDir(pValue:Str100);
begin
  oTable.FieldByName('ExpDir').AsString:=pValue;
end;

function TExplstDat.GetShwSta:Str1;
begin
  Result:=oTable.FieldByName('ShwSta').AsString;
end;

procedure TExplstDat.SetShwSta(pValue:Str1);
begin
  oTable.FieldByName('ShwSta').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TExplstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TExplstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TExplstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TExplstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TExplstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TExplstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TExplstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TExplstDat.LocExpNum(pExpNum:word):boolean;
begin
  SetIndex(ixExpNum);
  Result:=oTable.FindKey([pExpNum]);
end;

function TExplstDat.LocGrpCod(pGrpCod:Str10):boolean;
begin
  SetIndex(ixGrpCod);
  Result:=oTable.FindKey([pGrpCod]);
end;

function TExplstDat.LocShwSta(pShwSta:Str1):boolean;
begin
  SetIndex(ixShwSta);
  Result:=oTable.FindKey([pShwSta]);
end;

function TExplstDat.NearExpNum(pExpNum:word):boolean;
begin
  SetIndex(ixExpNum);
  Result:=oTable.FindNearest([pExpNum]);
end;

function TExplstDat.NearGrpCod(pGrpCod:Str10):boolean;
begin
  SetIndex(ixGrpCod);
  Result:=oTable.FindNearest([pGrpCod]);
end;

function TExplstDat.NearShwSta(pShwSta:Str1):boolean;
begin
  SetIndex(ixShwSta);
  Result:=oTable.FindNearest([pShwSta]);
end;

procedure TExplstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TExplstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TExplstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TExplstDat.Prior;
begin
  oTable.Prior;
end;

procedure TExplstDat.Next;
begin
  oTable.Next;
end;

procedure TExplstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TExplstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TExplstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TExplstDat.Edit;
begin
  oTable.Edit;
end;

procedure TExplstDat.Post;
begin
  oTable.Post;
end;

procedure TExplstDat.Delete;
begin
  oTable.Delete;
end;

procedure TExplstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TExplstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TExplstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TExplstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TExplstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TExplstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
