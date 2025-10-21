unit tOCIDLV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDdDi='';

type
  TOcidlvTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDlvDoc:Str12;            procedure SetDlvDoc (pValue:Str12);
    function GetDlvItm:longint;          procedure SetDlvItm (pValue:longint);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetDlvPrq:double;           procedure SetDlvPrq (pValue:double);
    function GetDlvDte:TDatetime;        procedure SetDlvDte (pValue:TDatetime);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:longint;          procedure SetOcdItm (pValue:longint);
    function GetExdSta:Str1;             procedure SetExdSta (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDdDi (pDlvDoc:Str12;pDlvItm:longint):boolean;

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
    property DlvDoc:Str12 read GetDlvDoc write SetDlvDoc;
    property DlvItm:longint read GetDlvItm write SetDlvItm;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property DlvPrq:double read GetDlvPrq write SetDlvPrq;
    property DlvDte:TDatetime read GetDlvDte write SetDlvDte;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:longint read GetOcdItm write SetOcdItm;
    property ExdSta:Str1 read GetExdSta write SetExdSta;
  end;

implementation

constructor TOcidlvTmp.Create;
begin
  oTmpTable:=TmpInit ('OCIDLV',Self);
end;

destructor TOcidlvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcidlvTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcidlvTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcidlvTmp.GetDlvDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('DlvDoc').AsString;
end;

procedure TOcidlvTmp.SetDlvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('DlvDoc').AsString:=pValue;
end;

function TOcidlvTmp.GetDlvItm:longint;
begin
  Result:=oTmpTable.FieldByName('DlvItm').AsInteger;
end;

procedure TOcidlvTmp.SetDlvItm(pValue:longint);
begin
  oTmpTable.FieldByName('DlvItm').AsInteger:=pValue;
end;

function TOcidlvTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOcidlvTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOcidlvTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcidlvTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcidlvTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOcidlvTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcidlvTmp.GetDlvPrq:double;
begin
  Result:=oTmpTable.FieldByName('DlvPrq').AsFloat;
end;

procedure TOcidlvTmp.SetDlvPrq(pValue:double);
begin
  oTmpTable.FieldByName('DlvPrq').AsFloat:=pValue;
end;

function TOcidlvTmp.GetDlvDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DlvDte').AsDateTime;
end;

procedure TOcidlvTmp.SetDlvDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDte').AsDateTime:=pValue;
end;

function TOcidlvTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOcidlvTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TOcidlvTmp.GetOcdItm:longint;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOcidlvTmp.SetOcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TOcidlvTmp.GetExdSta:Str1;
begin
  Result:=oTmpTable.FieldByName('ExdSta').AsString;
end;

procedure TOcidlvTmp.SetExdSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ExdSta').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcidlvTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcidlvTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcidlvTmp.LocDdDi(pDlvDoc:Str12;pDlvItm:longint):boolean;
begin
  SetIndex (ixDdDi);
  Result:=oTmpTable.FindKey([pDlvDoc,pDlvItm]);
end;

procedure TOcidlvTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcidlvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcidlvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcidlvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcidlvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcidlvTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcidlvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcidlvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcidlvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcidlvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcidlvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcidlvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcidlvTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcidlvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcidlvTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcidlvTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcidlvTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
