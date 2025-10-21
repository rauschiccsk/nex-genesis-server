unit dEASDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEcEtEi='EcEtEi';
  ixEasCod='EasCod';

type
  TEasdefDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEasCod:Str9;             procedure SetEasCod(pValue:Str9);
    function GetEasTyp:Str1;             procedure SetEasTyp(pValue:Str1);
    function GetEasIdn:longint;          procedure SetEasIdn(pValue:longint);
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
    function LocEcEtEi(pEasCod:Str9;pEasTyp:Str1;pEasIdn:longint):boolean;
    function LocEasCod(pEasCod:Str9):boolean;
    function NearEcEtEi(pEasCod:Str9;pEasTyp:Str1;pEasIdn:longint):boolean;
    function NearEasCod(pEasCod:Str9):boolean;

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
    property EasCod:Str9 read GetEasCod write SetEasCod;
    property EasTyp:Str1 read GetEasTyp write SetEasTyp;
    property EasIdn:longint read GetEasIdn write SetEasIdn;
  end;

implementation

constructor TEasdefDat.Create;
begin
  oTable:=DatInit('EASDEF',gPath.SysPath,Self);
end;

constructor TEasdefDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EASDEF',pPath,Self);
end;

destructor TEasdefDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEasdefDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEasdefDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEasdefDat.GetEasCod:Str9;
begin
  Result:=oTable.FieldByName('EasCod').AsString;
end;

procedure TEasdefDat.SetEasCod(pValue:Str9);
begin
  oTable.FieldByName('EasCod').AsString:=pValue;
end;

function TEasdefDat.GetEasTyp:Str1;
begin
  Result:=oTable.FieldByName('EasTyp').AsString;
end;

procedure TEasdefDat.SetEasTyp(pValue:Str1);
begin
  oTable.FieldByName('EasTyp').AsString:=pValue;
end;

function TEasdefDat.GetEasIdn:longint;
begin
  Result:=oTable.FieldByName('EasIdn').AsInteger;
end;

procedure TEasdefDat.SetEasIdn(pValue:longint);
begin
  oTable.FieldByName('EasIdn').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEasdefDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEasdefDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEasdefDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEasdefDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEasdefDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEasdefDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEasdefDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEasdefDat.LocEcEtEi(pEasCod:Str9;pEasTyp:Str1;pEasIdn:longint):boolean;
begin
  SetIndex(ixEcEtEi);
  Result:=oTable.FindKey([pEasCod,pEasTyp,pEasIdn]);
end;

function TEasdefDat.LocEasCod(pEasCod:Str9):boolean;
begin
  SetIndex(ixEasCod);
  Result:=oTable.FindKey([pEasCod]);
end;

function TEasdefDat.NearEcEtEi(pEasCod:Str9;pEasTyp:Str1;pEasIdn:longint):boolean;
begin
  SetIndex(ixEcEtEi);
  Result:=oTable.FindNearest([pEasCod,pEasTyp,pEasIdn]);
end;

function TEasdefDat.NearEasCod(pEasCod:Str9):boolean;
begin
  SetIndex(ixEasCod);
  Result:=oTable.FindNearest([pEasCod]);
end;

procedure TEasdefDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEasdefDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEasdefDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEasdefDat.Prior;
begin
  oTable.Prior;
end;

procedure TEasdefDat.Next;
begin
  oTable.Next;
end;

procedure TEasdefDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEasdefDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEasdefDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEasdefDat.Edit;
begin
  oTable.Edit;
end;

procedure TEasdefDat.Post;
begin
  oTable.Post;
end;

procedure TEasdefDat.Delete;
begin
  oTable.Delete;
end;

procedure TEasdefDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEasdefDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEasdefDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEasdefDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEasdefDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEasdefDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
