unit dOCRHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOciAdr='OciAdr';

type
  TOcrhisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetOciAdr:longint;          procedure SetOciAdr(pValue:longint);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
    function GetOsiAdr:longint;          procedure SetOsiAdr(pValue:longint);
    function GetOsdNum:Str13;            procedure SetOsdNum(pValue:Str13);
    function GetOsdItm:word;             procedure SetOsdItm(pValue:word);
    function GetOrdPrq:double;           procedure SetOrdPrq(pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq(pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq(pValue:double);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetFrePrq:double;           procedure SetFrePrq(pValue:double);
    function GetRatDte:TDatetime;        procedure SetRatDte(pValue:TDatetime);
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
    function LocOciAdr(pOciAdr:longint):boolean;
    function NearOciAdr(pOciAdr:longint):boolean;

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
    property OciAdr:longint read GetOciAdr write SetOciAdr;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property OsiAdr:longint read GetOsiAdr write SetOsiAdr;
    property OsdNum:Str13 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property FrePrq:double read GetFrePrq write SetFrePrq;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOcrhisDat.Create;
begin
  oTable:=DatInit('OCRHIS',gPath.StkPath,Self);
end;

constructor TOcrhisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCRHIS',pPath,Self);
end;

destructor TOcrhisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcrhisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcrhisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcrhisDat.GetOciAdr:longint;
begin
  Result:=oTable.FieldByName('OciAdr').AsInteger;
end;

procedure TOcrhisDat.SetOciAdr(pValue:longint);
begin
  oTable.FieldByName('OciAdr').AsInteger:=pValue;
end;

function TOcrhisDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcrhisDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcrhisDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcrhisDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcrhisDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcrhisDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcrhisDat.GetOsiAdr:longint;
begin
  Result:=oTable.FieldByName('OsiAdr').AsInteger;
end;

procedure TOcrhisDat.SetOsiAdr(pValue:longint);
begin
  oTable.FieldByName('OsiAdr').AsInteger:=pValue;
end;

function TOcrhisDat.GetOsdNum:Str13;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TOcrhisDat.SetOsdNum(pValue:Str13);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcrhisDat.GetOsdItm:word;
begin
  Result:=oTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcrhisDat.SetOsdItm(pValue:word);
begin
  oTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOcrhisDat.GetOrdPrq:double;
begin
  Result:=oTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOcrhisDat.SetOrdPrq(pValue:double);
begin
  oTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOcrhisDat.GetRocPrq:double;
begin
  Result:=oTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOcrhisDat.SetRocPrq(pValue:double);
begin
  oTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOcrhisDat.GetTsdPrq:double;
begin
  Result:=oTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOcrhisDat.SetTsdPrq(pValue:double);
begin
  oTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOcrhisDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TOcrhisDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TOcrhisDat.GetFrePrq:double;
begin
  Result:=oTable.FieldByName('FrePrq').AsFloat;
end;

procedure TOcrhisDat.SetFrePrq(pValue:double);
begin
  oTable.FieldByName('FrePrq').AsFloat:=pValue;
end;

function TOcrhisDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcrhisDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcrhisDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcrhisDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcrhisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcrhisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcrhisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcrhisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcrhisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcrhisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcrhisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcrhisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcrhisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcrhisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcrhisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcrhisDat.LocOciAdr(pOciAdr:longint):boolean;
begin
  SetIndex(ixOciAdr);
  Result:=oTable.FindKey([pOciAdr]);
end;

function TOcrhisDat.NearOciAdr(pOciAdr:longint):boolean;
begin
  SetIndex(ixOciAdr);
  Result:=oTable.FindNearest([pOciAdr]);
end;

procedure TOcrhisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcrhisDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOcrhisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcrhisDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcrhisDat.Next;
begin
  oTable.Next;
end;

procedure TOcrhisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcrhisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcrhisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcrhisDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcrhisDat.Post;
begin
  oTable.Post;
end;

procedure TOcrhisDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcrhisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcrhisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcrhisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcrhisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcrhisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcrhisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
