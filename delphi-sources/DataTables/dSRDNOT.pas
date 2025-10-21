unit dSRDNOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnInNtLn='DnInNtLn';
  ixDnInNt='DnInNt';
  ixDocNum='DocNum';

type
  TSrdnotDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetNotTyp:Str1;             procedure SetNotTyp(pValue:Str1);
    function GetLinNum:word;             procedure SetLinNum(pValue:word);
    function GetNotice:Str250;           procedure SetNotice(pValue:Str250);
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
    function LocDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
    function LocDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function NearDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
    function NearDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property NotTyp:Str1 read GetNotTyp write SetNotTyp;
    property LinNum:word read GetLinNum write SetLinNum;
    property Notice:Str250 read GetNotice write SetNotice;
  end;

implementation

constructor TSrdnotDat.Create;
begin
  oTable:=DatInit('SRDNOT',gPath.StkPath,Self);
end;

constructor TSrdnotDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SRDNOT',pPath,Self);
end;

destructor TSrdnotDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TSrdnotDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TSrdnotDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TSrdnotDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TSrdnotDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TSrdnotDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSrdnotDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TSrdnotDat.GetNotTyp:Str1;
begin
  Result:=oTable.FieldByName('NotTyp').AsString;
end;

procedure TSrdnotDat.SetNotTyp(pValue:Str1);
begin
  oTable.FieldByName('NotTyp').AsString:=pValue;
end;

function TSrdnotDat.GetLinNum:word;
begin
  Result:=oTable.FieldByName('LinNum').AsInteger;
end;

procedure TSrdnotDat.SetLinNum(pValue:word);
begin
  oTable.FieldByName('LinNum').AsInteger:=pValue;
end;

function TSrdnotDat.GetNotice:Str250;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TSrdnotDat.SetNotice(pValue:Str250);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrdnotDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TSrdnotDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TSrdnotDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TSrdnotDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TSrdnotDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TSrdnotDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TSrdnotDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TSrdnotDat.LocDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TSrdnotDat.LocDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp]);
end;

function TSrdnotDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TSrdnotDat.NearDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TSrdnotDat.NearDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp]);
end;

function TSrdnotDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

procedure TSrdnotDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TSrdnotDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TSrdnotDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TSrdnotDat.Prior;
begin
  oTable.Prior;
end;

procedure TSrdnotDat.Next;
begin
  oTable.Next;
end;

procedure TSrdnotDat.First;
begin
  Open;
  oTable.First;
end;

procedure TSrdnotDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TSrdnotDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TSrdnotDat.Edit;
begin
  oTable.Edit;
end;

procedure TSrdnotDat.Post;
begin
  oTable.Post;
end;

procedure TSrdnotDat.Delete;
begin
  oTable.Delete;
end;

procedure TSrdnotDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TSrdnotDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TSrdnotDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TSrdnotDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TSrdnotDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TSrdnotDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
