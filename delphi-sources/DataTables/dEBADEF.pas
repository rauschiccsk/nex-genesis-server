unit dEBADEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPoCs='PoCs';

type
  TEbadefDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetPayOpr:Str1;             procedure SetPayOpr(pValue:Str1);
    function GetConSym:Str10;            procedure SetConSym(pValue:Str10);
    function GetItmDes:Str60;            procedure SetItmDes(pValue:Str60);
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl(pValue:Str6);
    function GetCrtUsr:str15;            procedure SetCrtUsr(pValue:str15);
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
    function LocPoCs(pPayOpr:Str1;pConSym:Str10):boolean;
    function NearPoCs(pPayOpr:Str1;pConSym:Str10):boolean;

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
    property PayOpr:Str1 read GetPayOpr write SetPayOpr;
    property ConSym:Str10 read GetConSym write SetConSym;
    property ItmDes:Str60 read GetItmDes write SetItmDes;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property CrtUsr:str15 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TEbadefDat.Create;
begin
  oTable:=DatInit('EBADEF',gPath.LdgPath,Self);
end;

constructor TEbadefDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EBADEF',pPath,Self);
end;

destructor TEbadefDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEbadefDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEbadefDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEbadefDat.GetPayOpr:Str1;
begin
  Result:=oTable.FieldByName('PayOpr').AsString;
end;

procedure TEbadefDat.SetPayOpr(pValue:Str1);
begin
  oTable.FieldByName('PayOpr').AsString:=pValue;
end;

function TEbadefDat.GetConSym:Str10;
begin
  Result:=oTable.FieldByName('ConSym').AsString;
end;

procedure TEbadefDat.SetConSym(pValue:Str10);
begin
  oTable.FieldByName('ConSym').AsString:=pValue;
end;

function TEbadefDat.GetItmDes:Str60;
begin
  Result:=oTable.FieldByName('ItmDes').AsString;
end;

procedure TEbadefDat.SetItmDes(pValue:Str60);
begin
  oTable.FieldByName('ItmDes').AsString:=pValue;
end;

function TEbadefDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TEbadefDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TEbadefDat.GetAccAnl:Str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TEbadefDat.SetAccAnl(pValue:Str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TEbadefDat.GetCrtUsr:str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TEbadefDat.SetCrtUsr(pValue:str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TEbadefDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TEbadefDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TEbadefDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TEbadefDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEbadefDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEbadefDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEbadefDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEbadefDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEbadefDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEbadefDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEbadefDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEbadefDat.LocPoCs(pPayOpr:Str1;pConSym:Str10):boolean;
begin
  SetIndex(ixPoCs);
  Result:=oTable.FindKey([pPayOpr,pConSym]);
end;

function TEbadefDat.NearPoCs(pPayOpr:Str1;pConSym:Str10):boolean;
begin
  SetIndex(ixPoCs);
  Result:=oTable.FindNearest([pPayOpr,pConSym]);
end;

procedure TEbadefDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEbadefDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEbadefDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEbadefDat.Prior;
begin
  oTable.Prior;
end;

procedure TEbadefDat.Next;
begin
  oTable.Next;
end;

procedure TEbadefDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEbadefDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEbadefDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEbadefDat.Edit;
begin
  oTable.Edit;
end;

procedure TEbadefDat.Post;
begin
  oTable.Post;
end;

procedure TEbadefDat.Delete;
begin
  oTable.Delete;
end;

procedure TEbadefDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEbadefDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEbadefDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEbadefDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEbadefDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEbadefDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
