unit dOCRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOciAdr='OciAdr';
  ixIaRt='IaRt';
  ixIaFn='IaFn';
  ixSnPn='SnPn';
  ixOsiAdr='OsiAdr';

type
  TOcrlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetOciAdr:longint;          procedure SetOciAdr(pValue:longint);
    function GetResTyp:Str1;             procedure SetResTyp(pValue:Str1);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetFifNum:longint;          procedure SetFifNum(pValue:longint);
    function GetOsiAdr:longint;          procedure SetOsiAdr(pValue:longint);
    function GetResPrq:double;           procedure SetResPrq(pValue:double);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
    function GetRatPrv:TDatetime;        procedure SetRatPrv(pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte(pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot(pValue:Str50);
    function GetRatChg:byte;             procedure SetRatChg(pValue:byte);
    function GetRatCnt:byte;             procedure SetRatCnt(pValue:byte);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetOsdNum:Str13;            procedure SetOsdNum(pValue:Str13);
    function GetOsdItm:word;             procedure SetOsdItm(pValue:word);
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
    function LocIaRt(pOciAdr:longint;pResTyp:Str1):boolean;
    function LocIaFn(pOciAdr:longint;pFifNum:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocOsiAdr(pOsiAdr:longint):boolean;
    function NearOciAdr(pOciAdr:longint):boolean;
    function NearIaRt(pOciAdr:longint;pResTyp:Str1):boolean;
    function NearIaFn(pOciAdr:longint;pFifNum:longint):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearOsiAdr(pOsiAdr:longint):boolean;

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
    property ResTyp:Str1 read GetResTyp write SetResTyp;
    property ProNum:longint read GetProNum write SetProNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property FifNum:longint read GetFifNum write SetFifNum;
    property OsiAdr:longint read GetOsiAdr write SetOsiAdr;
    property ResPrq:double read GetResPrq write SetResPrq;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property RatPrv:TDatetime read GetRatPrv write SetRatPrv;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property RatChg:byte read GetRatChg write SetRatChg;
    property RatCnt:byte read GetRatCnt write SetRatCnt;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property OsdNum:Str13 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
  end;

implementation

constructor TOcrlstDat.Create;
begin
  oTable:=DatInit('OCRLST',gPath.StkPath,Self);
end;

constructor TOcrlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCRLST',pPath,Self);
end;

destructor TOcrlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcrlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcrlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcrlstDat.GetOciAdr:longint;
begin
  Result:=oTable.FieldByName('OciAdr').AsInteger;
end;

procedure TOcrlstDat.SetOciAdr(pValue:longint);
begin
  oTable.FieldByName('OciAdr').AsInteger:=pValue;
end;

function TOcrlstDat.GetResTyp:Str1;
begin
  Result:=oTable.FieldByName('ResTyp').AsString;
end;

procedure TOcrlstDat.SetResTyp(pValue:Str1);
begin
  oTable.FieldByName('ResTyp').AsString:=pValue;
end;

function TOcrlstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcrlstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcrlstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcrlstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcrlstDat.GetFifNum:longint;
begin
  Result:=oTable.FieldByName('FifNum').AsInteger;
end;

procedure TOcrlstDat.SetFifNum(pValue:longint);
begin
  oTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TOcrlstDat.GetOsiAdr:longint;
begin
  Result:=oTable.FieldByName('OsiAdr').AsInteger;
end;

procedure TOcrlstDat.SetOsiAdr(pValue:longint);
begin
  oTable.FieldByName('OsiAdr').AsInteger:=pValue;
end;

function TOcrlstDat.GetResPrq:double;
begin
  Result:=oTable.FieldByName('ResPrq').AsFloat;
end;

procedure TOcrlstDat.SetResPrq(pValue:double);
begin
  oTable.FieldByName('ResPrq').AsFloat:=pValue;
end;

function TOcrlstDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcrlstDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcrlstDat.GetRatPrv:TDatetime;
begin
  Result:=oTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOcrlstDat.SetRatPrv(pValue:TDatetime);
begin
  oTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOcrlstDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcrlstDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcrlstDat.GetRatNot:Str50;
begin
  Result:=oTable.FieldByName('RatNot').AsString;
end;

procedure TOcrlstDat.SetRatNot(pValue:Str50);
begin
  oTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOcrlstDat.GetRatChg:byte;
begin
  Result:=oTable.FieldByName('RatChg').AsInteger;
end;

procedure TOcrlstDat.SetRatChg(pValue:byte);
begin
  oTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOcrlstDat.GetRatCnt:byte;
begin
  Result:=oTable.FieldByName('RatCnt').AsInteger;
end;

procedure TOcrlstDat.SetRatCnt(pValue:byte);
begin
  oTable.FieldByName('RatCnt').AsInteger:=pValue;
end;

function TOcrlstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOcrlstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOcrlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOcrlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOcrlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOcrlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOcrlstDat.GetOsdNum:Str13;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TOcrlstDat.SetOsdNum(pValue:Str13);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcrlstDat.GetOsdItm:word;
begin
  Result:=oTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcrlstDat.SetOsdItm(pValue:word);
begin
  oTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcrlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcrlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcrlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcrlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcrlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcrlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcrlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcrlstDat.LocOciAdr(pOciAdr:longint):boolean;
begin
  SetIndex(ixOciAdr);
  Result:=oTable.FindKey([pOciAdr]);
end;

function TOcrlstDat.LocIaRt(pOciAdr:longint;pResTyp:Str1):boolean;
begin
  SetIndex(ixIaRt);
  Result:=oTable.FindKey([pOciAdr,pResTyp]);
end;

function TOcrlstDat.LocIaFn(pOciAdr:longint;pFifNum:longint):boolean;
begin
  SetIndex(ixIaFn);
  Result:=oTable.FindKey([pOciAdr,pFifNum]);
end;

function TOcrlstDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TOcrlstDat.LocOsiAdr(pOsiAdr:longint):boolean;
begin
  SetIndex(ixOsiAdr);
  Result:=oTable.FindKey([pOsiAdr]);
end;

function TOcrlstDat.NearOciAdr(pOciAdr:longint):boolean;
begin
  SetIndex(ixOciAdr);
  Result:=oTable.FindNearest([pOciAdr]);
end;

function TOcrlstDat.NearIaRt(pOciAdr:longint;pResTyp:Str1):boolean;
begin
  SetIndex(ixIaRt);
  Result:=oTable.FindNearest([pOciAdr,pResTyp]);
end;

function TOcrlstDat.NearIaFn(pOciAdr:longint;pFifNum:longint):boolean;
begin
  SetIndex(ixIaFn);
  Result:=oTable.FindNearest([pOciAdr,pFifNum]);
end;

function TOcrlstDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TOcrlstDat.NearOsiAdr(pOsiAdr:longint):boolean;
begin
  SetIndex(ixOsiAdr);
  Result:=oTable.FindNearest([pOsiAdr]);
end;

procedure TOcrlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcrlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOcrlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcrlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcrlstDat.Next;
begin
  oTable.Next;
end;

procedure TOcrlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcrlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcrlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcrlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcrlstDat.Post;
begin
  oTable.Post;
end;

procedure TOcrlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcrlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcrlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcrlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcrlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcrlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcrlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
