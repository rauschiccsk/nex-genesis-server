unit dSTKFIF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixSnFn='SnFn';
  ixSnPn='SnPn';
  ixDnIn='DnIn';
  ixProNum='ProNum';

type
  TStkfifDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetFifNum:longint;          procedure SetFifNum(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetIncPrq:double;           procedure SetIncPrq(pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetActPrq:double;           procedure SetActPrq(pValue:double);
    function GetActSta:Str1;             procedure SetActSta(pValue:Str1);
    function GetIncCpc:double;           procedure SetIncCpc(pValue:double);
    function GetIncCva:double;           procedure SetIncCva(pValue:double);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetIncTyp:Str1;             procedure SetIncTyp(pValue:Str1);
    function GetBegSta:Str1;             procedure SetBegSta(pValue:Str1);
    function GetRbaCod:Str30;            procedure SetRbaCod(pValue:Str30);
    function GetRbaDte:TDatetime;        procedure SetRbaDte(pValue:TDatetime);
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
    function LocSnFn(pStkNum:word;pFifNum:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function LocProNum(pProNum:longint):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearSnFn(pStkNum:word;pFifNum:longint):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function NearProNum(pProNum:longint):boolean;

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
    property FifNum:longint read GetFifNum write SetFifNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property IncPrq:double read GetIncPrq write SetIncPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property ActPrq:double read GetActPrq write SetActPrq;
    property ActSta:Str1 read GetActSta write SetActSta;
    property IncCpc:double read GetIncCpc write SetIncCpc;
    property IncCva:double read GetIncCva write SetIncCva;
    property ParNum:longint read GetParNum write SetParNum;
    property IncTyp:Str1 read GetIncTyp write SetIncTyp;
    property BegSta:Str1 read GetBegSta write SetBegSta;
    property RbaCod:Str30 read GetRbaCod write SetRbaCod;
    property RbaDte:TDatetime read GetRbaDte write SetRbaDte;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TStkfifDat.Create;
begin
  oTable:=DatInit('STKFIF',gPath.StkPath,Self);
end;

constructor TStkfifDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKFIF',pPath,Self);
end;

destructor TStkfifDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkfifDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkfifDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkfifDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkfifDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkfifDat.GetFifNum:longint;
begin
  Result:=oTable.FieldByName('FifNum').AsInteger;
end;

procedure TStkfifDat.SetFifNum(pValue:longint);
begin
  oTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TStkfifDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TStkfifDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkfifDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkfifDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkfifDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkfifDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkfifDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TStkfifDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TStkfifDat.GetIncPrq:double;
begin
  Result:=oTable.FieldByName('IncPrq').AsFloat;
end;

procedure TStkfifDat.SetIncPrq(pValue:double);
begin
  oTable.FieldByName('IncPrq').AsFloat:=pValue;
end;

function TStkfifDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TStkfifDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TStkfifDat.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkfifDat.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkfifDat.GetActSta:Str1;
begin
  Result:=oTable.FieldByName('ActSta').AsString;
end;

procedure TStkfifDat.SetActSta(pValue:Str1);
begin
  oTable.FieldByName('ActSta').AsString:=pValue;
end;

function TStkfifDat.GetIncCpc:double;
begin
  Result:=oTable.FieldByName('IncCpc').AsFloat;
end;

procedure TStkfifDat.SetIncCpc(pValue:double);
begin
  oTable.FieldByName('IncCpc').AsFloat:=pValue;
end;

function TStkfifDat.GetIncCva:double;
begin
  Result:=oTable.FieldByName('IncCva').AsFloat;
end;

procedure TStkfifDat.SetIncCva(pValue:double);
begin
  oTable.FieldByName('IncCva').AsFloat:=pValue;
end;

function TStkfifDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TStkfifDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TStkfifDat.GetIncTyp:Str1;
begin
  Result:=oTable.FieldByName('IncTyp').AsString;
end;

procedure TStkfifDat.SetIncTyp(pValue:Str1);
begin
  oTable.FieldByName('IncTyp').AsString:=pValue;
end;

function TStkfifDat.GetBegSta:Str1;
begin
  Result:=oTable.FieldByName('BegSta').AsString;
end;

procedure TStkfifDat.SetBegSta(pValue:Str1);
begin
  oTable.FieldByName('BegSta').AsString:=pValue;
end;

function TStkfifDat.GetRbaCod:Str30;
begin
  Result:=oTable.FieldByName('RbaCod').AsString;
end;

procedure TStkfifDat.SetRbaCod(pValue:Str30);
begin
  oTable.FieldByName('RbaCod').AsString:=pValue;
end;

function TStkfifDat.GetRbaDte:TDatetime;
begin
  Result:=oTable.FieldByName('RbaDte').AsDateTime;
end;

procedure TStkfifDat.SetRbaDte(pValue:TDatetime);
begin
  oTable.FieldByName('RbaDte').AsDateTime:=pValue;
end;

function TStkfifDat.GetCrtUsr:str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkfifDat.SetCrtUsr(pValue:str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkfifDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkfifDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkfifDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkfifDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkfifDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkfifDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkfifDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkfifDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkfifDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkfifDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkfifDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkfifDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkfifDat.LocSnFn(pStkNum:word;pFifNum:longint):boolean;
begin
  SetIndex(ixSnFn);
  Result:=oTable.FindKey([pStkNum,pFifNum]);
end;

function TStkfifDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TStkfifDat.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TStkfifDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TStkfifDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkfifDat.NearSnFn(pStkNum:word;pFifNum:longint):boolean;
begin
  SetIndex(ixSnFn);
  Result:=oTable.FindNearest([pStkNum,pFifNum]);
end;

function TStkfifDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TStkfifDat.NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TStkfifDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

procedure TStkfifDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkfifDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkfifDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkfifDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkfifDat.Next;
begin
  oTable.Next;
end;

procedure TStkfifDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkfifDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkfifDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkfifDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkfifDat.Post;
begin
  oTable.Post;
end;

procedure TStkfifDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkfifDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkfifDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkfifDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkfifDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkfifDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkfifDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
