unit dOCTHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocAdr='DocAdr';
  ixItmAdr='ItmAdr';
  ixTcdAdr='TcdAdr';

type
  TOcthisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocAdr:longint;          procedure SetDocAdr(pValue:longint);
    function GetItmAdr:longitn;          procedure SetItmAdr(pValue:longitn);
    function GetTcdAdr:longint;          procedure SetTcdAdr(pValue:longint);
    function GetTciAdr:longint;          procedure SetTciAdr(pValue:longint);
    function GetTcdNum:Str12;            procedure SetTcdNum(pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm(pValue:word);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetTcdDte:TDatetime;        procedure SetTcdDte(pValue:TDatetime);
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
    function LocDocAdr(pDocAdr:longint):boolean;
    function LocItmAdr(pItmAdr:longitn):boolean;
    function LocTcdAdr(pTcdAdr:longint):boolean;
    function NearDocAdr(pDocAdr:longint):boolean;
    function NearItmAdr(pItmAdr:longitn):boolean;
    function NearTcdAdr(pTcdAdr:longint):boolean;

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
    property DocAdr:longint read GetDocAdr write SetDocAdr;
    property ItmAdr:longitn read GetItmAdr write SetItmAdr;
    property TcdAdr:longint read GetTcdAdr write SetTcdAdr;
    property TciAdr:longint read GetTciAdr write SetTciAdr;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property TcdDte:TDatetime read GetTcdDte write SetTcdDte;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOcthisDat.Create;
begin
  oTable:=BtrInit('OCTHIS',gPath.StkPath,Self);
end;

constructor TOcthisDat.Create(pPath:ShortString);
begin
  oTable:=BtrInit('OCTHIS',pPath,Self);
end;

destructor TOcthisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcthisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcthisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcthisDat.GetDocAdr:longint;
begin
  Result:=oTable.FieldByName('DocAdr').AsInteger;
end;

procedure TOcthisDat.SetDocAdr(pValue:longint);
begin
  oTable.FieldByName('DocAdr').AsInteger:=pValue;
end;

function TOcthisDat.GetItmAdr:longitn;
begin
  Result:=oTable.FieldByName('ItmAdr').AsVariant;
end;

procedure TOcthisDat.SetItmAdr(pValue:longitn);
begin
  oTable.FieldByName('ItmAdr').AsVariant:=pValue;
end;

function TOcthisDat.GetTcdAdr:longint;
begin
  Result:=oTable.FieldByName('TcdAdr').AsInteger;
end;

procedure TOcthisDat.SetTcdAdr(pValue:longint);
begin
  oTable.FieldByName('TcdAdr').AsInteger:=pValue;
end;

function TOcthisDat.GetTciAdr:longint;
begin
  Result:=oTable.FieldByName('TciAdr').AsInteger;
end;

procedure TOcthisDat.SetTciAdr(pValue:longint);
begin
  oTable.FieldByName('TciAdr').AsInteger:=pValue;
end;

function TOcthisDat.GetTcdNum:Str12;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TOcthisDat.SetTcdNum(pValue:Str12);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOcthisDat.GetTcdItm:word;
begin
  Result:=oTable.FieldByName('TcdItm').AsInteger;
end;

procedure TOcthisDat.SetTcdItm(pValue:word);
begin
  oTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TOcthisDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOcthisDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOcthisDat.GetTcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TOcthisDat.SetTcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TOcthisDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcthisDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcthisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcthisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcthisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcthisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcthisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcthisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcthisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcthisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcthisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcthisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcthisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcthisDat.LocDocAdr(pDocAdr:longint):boolean;
begin
  SetIndex(ixDocAdr);
  Result:=oTable.FindKey([pDocAdr]);
end;

function TOcthisDat.LocItmAdr(pItmAdr:longitn):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TOcthisDat.LocTcdAdr(pTcdAdr:longint):boolean;
begin
  SetIndex(ixTcdAdr);
  Result:=oTable.FindKey([pTcdAdr]);
end;

function TOcthisDat.NearDocAdr(pDocAdr:longint):boolean;
begin
  SetIndex(ixDocAdr);
  Result:=oTable.FindNearest([pDocAdr]);
end;

function TOcthisDat.NearItmAdr(pItmAdr:longitn):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

function TOcthisDat.NearTcdAdr(pTcdAdr:longint):boolean;
begin
  SetIndex(ixTcdAdr);
  Result:=oTable.FindNearest([pTcdAdr]);
end;

procedure TOcthisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcthisDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOcthisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcthisDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcthisDat.Next;
begin
  oTable.Next;
end;

procedure TOcthisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcthisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcthisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcthisDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcthisDat.Post;
begin
  oTable.Post;
end;

procedure TOcthisDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcthisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcthisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcthisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcthisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcthisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcthisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
