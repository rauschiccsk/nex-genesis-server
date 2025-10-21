unit dOSNLST;

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
  TOsnlstDat=class(TComponent)
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

constructor TOsnlstDat.Create;
begin
  oTable:=DatInit('OSNLST',gPath.StkPath,Self);
end;

constructor TOsnlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSNLST',pPath,Self);
end;

destructor TOsnlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsnlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsnlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsnlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOsnlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsnlstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsnlstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsnlstDat.GetNotTyp:Str1;
begin
  Result:=oTable.FieldByName('NotTyp').AsString;
end;

procedure TOsnlstDat.SetNotTyp(pValue:Str1);
begin
  oTable.FieldByName('NotTyp').AsString:=pValue;
end;

function TOsnlstDat.GetLinNum:word;
begin
  Result:=oTable.FieldByName('LinNum').AsInteger;
end;

procedure TOsnlstDat.SetLinNum(pValue:word);
begin
  oTable.FieldByName('LinNum').AsInteger:=pValue;
end;

function TOsnlstDat.GetNotice:Str250;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOsnlstDat.SetNotice(pValue:Str250);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsnlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsnlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsnlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsnlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsnlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsnlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsnlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsnlstDat.LocDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TOsnlstDat.LocDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp]);
end;

function TOsnlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOsnlstDat.NearDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TOsnlstDat.NearDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp]);
end;

function TOsnlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

procedure TOsnlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsnlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOsnlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsnlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsnlstDat.Next;
begin
  oTable.Next;
end;

procedure TOsnlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsnlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsnlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsnlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsnlstDat.Post;
begin
  oTable.Post;
end;

procedure TOsnlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsnlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsnlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsnlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsnlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsnlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsnlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
