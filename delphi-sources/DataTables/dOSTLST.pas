unit dOSTLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='ItmAdr';
  ixDoItTdTi='DoItTdTi';
  ixTdTi='TdTi';

type
  TOstlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetItmAdr:longint;          procedure SetItmAdr(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetTsdNum:Str12;            procedure SetTsdNum(pValue:Str12);
    function GetTsdItm:word;             procedure SetTsdItm(pValue:word);
    function GetTsdDte:TDatetime;        procedure SetTsdDte(pValue:TDatetime);
    function GetTsdPrq:double;           procedure SetTsdPrq(pValue:double);
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
    function LocItmAdr(pItmAdr:longint):boolean;
    function LocDoItTdTi(pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
    function LocTdTi(pTsdNum:Str12;pTsdItm:word):boolean;
    function NearItmAdr(pItmAdr:longint):boolean;
    function NearDoItTdTi(pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
    function NearTdTi(pTsdNum:Str12;pTsdItm:word):boolean;

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
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property TsdNum:Str12 read GetTsdNum write SetTsdNum;
    property TsdItm:word read GetTsdItm write SetTsdItm;
    property TsdDte:TDatetime read GetTsdDte write SetTsdDte;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOstlstDat.Create;
begin
  oTable:=DatInit('OSTLST',gPath.StkPath,Self);
end;

constructor TOstlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSTLST',pPath,Self);
end;

destructor TOstlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOstlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOstlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOstlstDat.GetItmAdr:longint;
begin
  Result:=oTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOstlstDat.SetItmAdr(pValue:longint);
begin
  oTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOstlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOstlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOstlstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOstlstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOstlstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOstlstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOstlstDat.GetTsdNum:Str12;
begin
  Result:=oTable.FieldByName('TsdNum').AsString;
end;

procedure TOstlstDat.SetTsdNum(pValue:Str12);
begin
  oTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TOstlstDat.GetTsdItm:word;
begin
  Result:=oTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOstlstDat.SetTsdItm(pValue:word);
begin
  oTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TOstlstDat.GetTsdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TsdDte').AsDateTime;
end;

procedure TOstlstDat.SetTsdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TsdDte').AsDateTime:=pValue;
end;

function TOstlstDat.GetTsdPrq:double;
begin
  Result:=oTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOstlstDat.SetTsdPrq(pValue:double);
begin
  oTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOstlstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOstlstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOstlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOstlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOstlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOstlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOstlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOstlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOstlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOstlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOstlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOstlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOstlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOstlstDat.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TOstlstDat.LocDoItTdTi(pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex(ixDoItTdTi);
  Result:=oTable.FindKey([pDocNum,pItmNum,pTsdNum,pTsdItm]);
end;

function TOstlstDat.LocTdTi(pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex(ixTdTi);
  Result:=oTable.FindKey([pTsdNum,pTsdItm]);
end;

function TOstlstDat.NearItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

function TOstlstDat.NearDoItTdTi(pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex(ixDoItTdTi);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pTsdNum,pTsdItm]);
end;

function TOstlstDat.NearTdTi(pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex(ixTdTi);
  Result:=oTable.FindNearest([pTsdNum,pTsdItm]);
end;

procedure TOstlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOstlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOstlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOstlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOstlstDat.Next;
begin
  oTable.Next;
end;

procedure TOstlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOstlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOstlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOstlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOstlstDat.Post;
begin
  oTable.Post;
end;

procedure TOstlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOstlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOstlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOstlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOstlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOstlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOstlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
