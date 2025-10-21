unit dSTKPOS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixSnPnPc='SnPnPc';
  ixSnPn='SnPn';
  ixSnPc='SnPc';

type
  TStkposDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetPosCod:Str15;            procedure SetPosCod(pValue:Str15);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetCrtUsr:str10;            procedure SetCrtUsr(pValue:str10);
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
    function LocStkNum(pStkNum:word):boolean;
    function LocSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocSnPc(pStkNum:word;pPosCod:Str15):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearSnPc(pStkNum:word;pPosCod:Str15):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property PosCod:Str15 read GetPosCod write SetPosCod;
    property ActPrq:double read GetActPrq write SetActPrq;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TStkposDat.Create;
begin
  oTable:=DatInit('STKPOS',gPath.StkPath,Self);
end;

constructor TStkposDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKPOS',pPath,Self);
end;

destructor TStkposDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkposDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkposDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkposDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkposDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkposDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkposDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkposDat.GetPosCod:Str15;
begin
  Result:=oTable.FieldByName('PosCod').AsString;
end;

procedure TStkposDat.SetPosCod(pValue:Str15);
begin
  oTable.FieldByName('PosCod').AsString:=pValue;
end;

function TStkposDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkposDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkposDat.GetCrtUsr:str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkposDat.SetCrtUsr(pValue:str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkposDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkposDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkposDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkposDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkposDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkposDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkposDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkposDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkposDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkposDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkposDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkposDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkposDat.LocSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPnPc);
  Result:=oTable.FindKey([pStkNum,pProNum,pPosCod]);
end;

function TStkposDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TStkposDat.LocSnPc(pStkNum:word;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPc);
  Result:=oTable.FindKey([pStkNum,pPosCod]);
end;

function TStkposDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkposDat.NearSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPnPc);
  Result:=oTable.FindNearest([pStkNum,pProNum,pPosCod]);
end;

function TStkposDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TStkposDat.NearSnPc(pStkNum:word;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPc);
  Result:=oTable.FindNearest([pStkNum,pPosCod]);
end;

procedure TStkposDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkposDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkposDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkposDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkposDat.Next;
begin
  oTable.Next;
end;

procedure TStkposDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkposDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkposDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkposDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkposDat.Post;
begin
  oTable.Post;
end;

procedure TStkposDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkposDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkposDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkposDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkposDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkposDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkposDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
