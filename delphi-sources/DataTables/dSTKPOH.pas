unit dSTKPOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixSnPnPcDnIn='SnPnPcDnIn';
  ixSnPnPc='SnPnPc';
  ixSnPn='SnPn';
  ixSnPc='SnPc';
  ixDnIn='DnIn';

type
  TStkpohDat=class(TComponent)
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
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetMovPrq:double;           procedure SetMovPrq(pValue:double);
    function GetRmiPos:Str15;            procedure SetRmiPos(pValue:Str15);
    function GetRmoPos:Str15;            procedure SetRmoPos(pValue:Str15);
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
    function LocSnPnPcDnIn(pStkNum:word;pProNum:longint;pPosCod:Str15;pDocNum:Str12;pItmNum:longint):boolean;
    function LocSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocSnPc(pStkNum:word;pPosCod:Str15):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearSnPnPcDnIn(pStkNum:word;pProNum:longint;pPosCod:Str15;pDocNum:Str12;pItmNum:longint):boolean;
    function NearSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearSnPc(pStkNum:word;pPosCod:Str15):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property RmiPos:Str15 read GetRmiPos write SetRmiPos;
    property RmoPos:Str15 read GetRmoPos write SetRmoPos;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TStkpohDat.Create;
begin
  oTable:=DatInit('STKPOH',gPath.StkPath,Self);
end;

constructor TStkpohDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKPOH',pPath,Self);
end;

destructor TStkpohDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkpohDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkpohDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkpohDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkpohDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkpohDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkpohDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkpohDat.GetPosCod:Str15;
begin
  Result:=oTable.FieldByName('PosCod').AsString;
end;

procedure TStkpohDat.SetPosCod(pValue:Str15);
begin
  oTable.FieldByName('PosCod').AsString:=pValue;
end;

function TStkpohDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TStkpohDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkpohDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkpohDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkpohDat.GetMovPrq:double;
begin
  Result:=oTable.FieldByName('MovPrq').AsFloat;
end;

procedure TStkpohDat.SetMovPrq(pValue:double);
begin
  oTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TStkpohDat.GetRmiPos:Str15;
begin
  Result:=oTable.FieldByName('RmiPos').AsString;
end;

procedure TStkpohDat.SetRmiPos(pValue:Str15);
begin
  oTable.FieldByName('RmiPos').AsString:=pValue;
end;

function TStkpohDat.GetRmoPos:Str15;
begin
  Result:=oTable.FieldByName('RmoPos').AsString;
end;

procedure TStkpohDat.SetRmoPos(pValue:Str15);
begin
  oTable.FieldByName('RmoPos').AsString:=pValue;
end;

function TStkpohDat.GetCrtUsr:str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkpohDat.SetCrtUsr(pValue:str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkpohDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkpohDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkpohDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkpohDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkpohDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkpohDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkpohDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkpohDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkpohDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkpohDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkpohDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkpohDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkpohDat.LocSnPnPcDnIn(pStkNum:word;pProNum:longint;pPosCod:Str15;pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixSnPnPcDnIn);
  Result:=oTable.FindKey([pStkNum,pProNum,pPosCod,pDocNum,pItmNum]);
end;

function TStkpohDat.LocSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPnPc);
  Result:=oTable.FindKey([pStkNum,pProNum,pPosCod]);
end;

function TStkpohDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TStkpohDat.LocSnPc(pStkNum:word;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPc);
  Result:=oTable.FindKey([pStkNum,pPosCod]);
end;

function TStkpohDat.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TStkpohDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkpohDat.NearSnPnPcDnIn(pStkNum:word;pProNum:longint;pPosCod:Str15;pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixSnPnPcDnIn);
  Result:=oTable.FindNearest([pStkNum,pProNum,pPosCod,pDocNum,pItmNum]);
end;

function TStkpohDat.NearSnPnPc(pStkNum:word;pProNum:longint;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPnPc);
  Result:=oTable.FindNearest([pStkNum,pProNum,pPosCod]);
end;

function TStkpohDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TStkpohDat.NearSnPc(pStkNum:word;pPosCod:Str15):boolean;
begin
  SetIndex(ixSnPc);
  Result:=oTable.FindNearest([pStkNum,pPosCod]);
end;

function TStkpohDat.NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

procedure TStkpohDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkpohDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkpohDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkpohDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkpohDat.Next;
begin
  oTable.Next;
end;

procedure TStkpohDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkpohDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkpohDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkpohDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkpohDat.Post;
begin
  oTable.Post;
end;

procedure TStkpohDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkpohDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkpohDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkpohDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkpohDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkpohDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkpohDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
