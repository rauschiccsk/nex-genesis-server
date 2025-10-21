unit tSTKPOS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPosCod='';

type
  TStkposTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetPosCod:Str15;            procedure SetPosCod (pValue:Str15);
    function GetActPrq:double;           procedure SetActPrq (pValue:double);
    function GetCrtUsr:str10;            procedure SetCrtUsr (pValue:str10);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPosCod (pPosCod:Str15):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property PosCod:Str15 read GetPosCod write SetPosCod;
    property ActPrq:double read GetActPrq write SetActPrq;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStkposTmp.Create;
begin
  oTmpTable:=TmpInit ('STKPOS',Self);
end;

destructor TStkposTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkposTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkposTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkposTmp.GetPosCod:Str15;
begin
  Result:=oTmpTable.FieldByName('PosCod').AsString;
end;

procedure TStkposTmp.SetPosCod(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCod').AsString:=pValue;
end;

function TStkposTmp.GetActPrq:double;
begin
  Result:=oTmpTable.FieldByName('ActPrq').AsFloat;
end;

procedure TStkposTmp.SetActPrq(pValue:double);
begin
  oTmpTable.FieldByName('ActPrq').AsFloat:=pValue;
end;

function TStkposTmp.GetCrtUsr:str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkposTmp.SetCrtUsr(pValue:str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkposTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkposTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkposTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkposTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkposTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkposTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkposTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkposTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkposTmp.LocPosCod(pPosCod:Str15):boolean;
begin
  SetIndex (ixPosCod);
  Result:=oTmpTable.FindKey([pPosCod]);
end;

procedure TStkposTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkposTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkposTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkposTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkposTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkposTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkposTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkposTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkposTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkposTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkposTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkposTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkposTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkposTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkposTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkposTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkposTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
