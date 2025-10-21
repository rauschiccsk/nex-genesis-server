unit dSTKLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixStkNam='StkNam';

type
  TStklstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetStkNam:Str30;            procedure SetStkNam(pValue:Str30);
    function GetStkNam_:Str15;           procedure SetStkNam_(pValue:Str15);
    function GetStkTyp:Str1;             procedure SetStkTyp(pValue:Str1);
    function GetInvDte:TDatetime;        procedure SetInvDte(pValue:TDatetime);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetPlsNum:word;             procedure SetPlsNum(pValue:word);
    function GetShared:boolean;          procedure SetShared(pValue:boolean);
    function GetModNum:word;             procedure SetModNum(pValue:word);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocStkNam(pStkNam_:Str15):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearStkNam(pStkNam_:Str15):boolean;

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
    property StkNam:Str30 read GetStkNam write SetStkNam;
    property StkNam_:Str15 read GetStkNam_ write SetStkNam_;
    property StkTyp:Str1 read GetStkTyp write SetStkTyp;
    property InvDte:TDatetime read GetInvDte write SetInvDte;
    property WriNum:word read GetWriNum write SetWriNum;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property Shared:boolean read GetShared write SetShared;
    property ModNum:word read GetModNum write SetModNum;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TStklstDat.Create;
begin
  oTable:=DatInit('STKLST',gPath.StkPath,Self);
end;

constructor TStklstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKLST',pPath,Self);
end;

destructor TStklstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStklstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStklstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStklstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStklstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStklstDat.GetStkNam:Str30;
begin
  Result:=oTable.FieldByName('StkNam').AsString;
end;

procedure TStklstDat.SetStkNam(pValue:Str30);
begin
  oTable.FieldByName('StkNam').AsString:=pValue;
end;

function TStklstDat.GetStkNam_:Str15;
begin
  Result:=oTable.FieldByName('StkNam_').AsString;
end;

procedure TStklstDat.SetStkNam_(pValue:Str15);
begin
  oTable.FieldByName('StkNam_').AsString:=pValue;
end;

function TStklstDat.GetStkTyp:Str1;
begin
  Result:=oTable.FieldByName('StkTyp').AsString;
end;

procedure TStklstDat.SetStkTyp(pValue:Str1);
begin
  oTable.FieldByName('StkTyp').AsString:=pValue;
end;

function TStklstDat.GetInvDte:TDatetime;
begin
  Result:=oTable.FieldByName('InvDte').AsDateTime;
end;

procedure TStklstDat.SetInvDte(pValue:TDatetime);
begin
  oTable.FieldByName('InvDte').AsDateTime:=pValue;
end;

function TStklstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TStklstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TStklstDat.GetPlsNum:word;
begin
  Result:=oTable.FieldByName('PlsNum').AsInteger;
end;

procedure TStklstDat.SetPlsNum(pValue:word);
begin
  oTable.FieldByName('PlsNum').AsInteger:=pValue;
end;

function TStklstDat.GetShared:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('Shared').AsInteger);
end;

procedure TStklstDat.SetShared(pValue:boolean);
begin
  oTable.FieldByName('Shared').AsInteger:=BoolToByte(pValue);
end;

function TStklstDat.GetModNum:word;
begin
  Result:=oTable.FieldByName('ModNum').AsInteger;
end;

procedure TStklstDat.SetModNum(pValue:word);
begin
  oTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TStklstDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TStklstDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TStklstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TStklstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TStklstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TStklstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStklstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStklstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStklstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStklstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStklstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStklstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TStklstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStklstDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStklstDat.LocStkNam(pStkNam_:Str15):boolean;
begin
  SetIndex(ixStkNam);
  Result:=oTable.FindKey([StrToAlias(pStkNam_)]);
end;

function TStklstDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStklstDat.NearStkNam(pStkNam_:Str15):boolean;
begin
  SetIndex(ixStkNam);
  Result:=oTable.FindNearest([pStkNam_]);
end;

procedure TStklstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStklstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStklstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStklstDat.Prior;
begin
  oTable.Prior;
end;

procedure TStklstDat.Next;
begin
  oTable.Next;
end;

procedure TStklstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStklstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStklstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStklstDat.Edit;
begin
  oTable.Edit;
end;

procedure TStklstDat.Post;
begin
  oTable.Post;
end;

procedure TStklstDat.Delete;
begin
  oTable.Delete;
end;

procedure TStklstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStklstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStklstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStklstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStklstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStklstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
