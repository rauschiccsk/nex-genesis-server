unit dXRIDOU;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDySnPn='DySnPn';
  ixDnIn='DnIn';
  ixDocDte='DocDte';

type
  TXridouDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetOutBva:double;           procedure SetOutBva(pValue:double);
    function GetCmpNum:longint;          procedure SetCmpNum(pValue:longint);
    function GetCmpNam:Str60;            procedure SetCmpNam(pValue:Str60);
    function GetCmpCod:Str15;            procedure SetCmpCod(pValue:Str15);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetItmTyp:Str1;             procedure SetItmTyp(pValue:Str1);
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
    function LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;

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
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:word read GetSerNum write SetSerNum;
    property ProNum:longint read GetProNum write SetProNum;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property OutBva:double read GetOutBva write SetOutBva;
    property CmpNum:longint read GetCmpNum write SetCmpNum;
    property CmpNam:Str60 read GetCmpNam write SetCmpNam;
    property CmpCod:Str15 read GetCmpCod write SetCmpCod;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property ItmTyp:Str1 read GetItmTyp write SetItmTyp;
  end;

implementation

constructor TXridouDat.Create;
begin
  oTable:=DatInit('XRIDOU',gPath.StkPath,Self);
end;

constructor TXridouDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('XRIDOU',pPath,Self);
end;

destructor TXridouDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TXridouDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TXridouDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TXridouDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TXridouDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TXridouDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TXridouDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TXridouDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TXridouDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TXridouDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TXridouDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TXridouDat.GetOutBva:double;
begin
  Result:=oTable.FieldByName('OutBva').AsFloat;
end;

procedure TXridouDat.SetOutBva(pValue:double);
begin
  oTable.FieldByName('OutBva').AsFloat:=pValue;
end;

function TXridouDat.GetCmpNum:longint;
begin
  Result:=oTable.FieldByName('CmpNum').AsInteger;
end;

procedure TXridouDat.SetCmpNum(pValue:longint);
begin
  oTable.FieldByName('CmpNum').AsInteger:=pValue;
end;

function TXridouDat.GetCmpNam:Str60;
begin
  Result:=oTable.FieldByName('CmpNam').AsString;
end;

procedure TXridouDat.SetCmpNam(pValue:Str60);
begin
  oTable.FieldByName('CmpNam').AsString:=pValue;
end;

function TXridouDat.GetCmpCod:Str15;
begin
  Result:=oTable.FieldByName('CmpCod').AsString;
end;

procedure TXridouDat.SetCmpCod(pValue:Str15);
begin
  oTable.FieldByName('CmpCod').AsString:=pValue;
end;

function TXridouDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TXridouDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TXridouDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TXridouDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TXridouDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TXridouDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TXridouDat.GetItmTyp:Str1;
begin
  Result:=oTable.FieldByName('ItmTyp').AsString;
end;

procedure TXridouDat.SetItmTyp(pValue:Str1);
begin
  oTable.FieldByName('ItmTyp').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXridouDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TXridouDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TXridouDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TXridouDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TXridouDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TXridouDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TXridouDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TXridouDat.LocDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindKey([pDocYer,pSerNum,pProNum]);
end;

function TXridouDat.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TXridouDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TXridouDat.NearDySnPn(pDocYer:Str2;pSerNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixDySnPn);
  Result:=oTable.FindNearest([pDocYer,pSerNum,pProNum]);
end;

function TXridouDat.NearDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TXridouDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

procedure TXridouDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TXridouDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TXridouDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TXridouDat.Prior;
begin
  oTable.Prior;
end;

procedure TXridouDat.Next;
begin
  oTable.Next;
end;

procedure TXridouDat.First;
begin
  Open;
  oTable.First;
end;

procedure TXridouDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TXridouDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TXridouDat.Edit;
begin
  oTable.Edit;
end;

procedure TXridouDat.Post;
begin
  oTable.Post;
end;

procedure TXridouDat.Delete;
begin
  oTable.Delete;
end;

procedure TXridouDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TXridouDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TXridouDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TXridouDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TXridouDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TXridouDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
