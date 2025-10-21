unit dOCNLST;

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
  TOcnlstDat=class(TComponent)
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

constructor TOcnlstDat.Create;
begin
  oTable:=DatInit('OCNLST',gPath.StkPath,Self);
end;

constructor TOcnlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OCNLST',pPath,Self);
end;

destructor TOcnlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOcnlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOcnlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOcnlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOcnlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOcnlstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOcnlstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOcnlstDat.GetNotTyp:Str1;
begin
  Result:=oTable.FieldByName('NotTyp').AsString;
end;

procedure TOcnlstDat.SetNotTyp(pValue:Str1);
begin
  oTable.FieldByName('NotTyp').AsString:=pValue;
end;

function TOcnlstDat.GetLinNum:word;
begin
  Result:=oTable.FieldByName('LinNum').AsInteger;
end;

procedure TOcnlstDat.SetLinNum(pValue:word);
begin
  oTable.FieldByName('LinNum').AsInteger:=pValue;
end;

function TOcnlstDat.GetNotice:Str250;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOcnlstDat.SetNotice(pValue:Str250);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcnlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOcnlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOcnlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOcnlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOcnlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOcnlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOcnlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOcnlstDat.LocDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TOcnlstDat.LocDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindKey([pDocNum,pItmNum,pNotTyp]);
end;

function TOcnlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOcnlstDat.NearDnInNtLn(pDocNum:Str12;pItmNum:word;pNotTyp:Str1;pLinNum:word):boolean;
begin
  SetIndex(ixDnInNtLn);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp,pLinNum]);
end;

function TOcnlstDat.NearDnInNt(pDocNum:Str12;pItmNum:word;pNotTyp:Str1):boolean;
begin
  SetIndex(ixDnInNt);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pNotTyp]);
end;

function TOcnlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

procedure TOcnlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOcnlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
  oTable.Refresh;
end;

procedure TOcnlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOcnlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOcnlstDat.Next;
begin
  oTable.Next;
end;

procedure TOcnlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOcnlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOcnlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOcnlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOcnlstDat.Post;
begin
  oTable.Post;
end;

procedure TOcnlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOcnlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOcnlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOcnlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOcnlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOcnlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOcnlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
