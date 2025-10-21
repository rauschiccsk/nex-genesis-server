unit tSTMINP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLeDoIt='';

type
  TStminpTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetInpLev:byte;             procedure SetInpLev (pValue:byte);
    function GetInpDoc:Str12;            procedure SetInpDoc (pValue:Str12);
    function GetInpItm:longint;          procedure SetInpItm (pValue:longint);
    function GetInpStk:word;             procedure SetInpStk (pValue:word);
    function GetInpFif:longint;          procedure SetInpFif (pValue:longint);
    function GetInpStm:longint;          procedure SetInpStm (pValue:longint);
    function GetInpPnu:longint;          procedure SetInpPnu (pValue:longint);
    function GetInpPna:Str60;            procedure SetInpPna (pValue:Str60);
    function GetInpPrq:double;           procedure SetInpPrq (pValue:double);
    function GetInpCva:double;           procedure SetInpCva (pValue:double);
    function GetModPrc:double;           procedure SetModPrc (pValue:double);
    function GetModCpc:double;           procedure SetModCpc (pValue:double);
    function GetModCva:double;           procedure SetModCva (pValue:double);
    function GetInpSta:Str1;             procedure SetInpSta (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocLeDoIt (pInpLev:byte;pInpDoc:Str12;pInpItm:longint):boolean;

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
    property InpLev:byte read GetInpLev write SetInpLev;
    property InpDoc:Str12 read GetInpDoc write SetInpDoc;
    property InpItm:longint read GetInpItm write SetInpItm;
    property InpStk:word read GetInpStk write SetInpStk;
    property InpFif:longint read GetInpFif write SetInpFif;
    property InpStm:longint read GetInpStm write SetInpStm;
    property InpPnu:longint read GetInpPnu write SetInpPnu;
    property InpPna:Str60 read GetInpPna write SetInpPna;
    property InpPrq:double read GetInpPrq write SetInpPrq;
    property InpCva:double read GetInpCva write SetInpCva;
    property ModPrc:double read GetModPrc write SetModPrc;
    property ModCpc:double read GetModCpc write SetModCpc;
    property ModCva:double read GetModCva write SetModCva;
    property InpSta:Str1 read GetInpSta write SetInpSta;
  end;

implementation

constructor TStminpTmp.Create;
begin
  oTmpTable:=TmpInit ('STMINP',Self);
end;

destructor TStminpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStminpTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStminpTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStminpTmp.GetInpLev:byte;
begin
  Result:=oTmpTable.FieldByName('InpLev').AsInteger;
end;

procedure TStminpTmp.SetInpLev(pValue:byte);
begin
  oTmpTable.FieldByName('InpLev').AsInteger:=pValue;
end;

function TStminpTmp.GetInpDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TStminpTmp.SetInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString:=pValue;
end;

function TStminpTmp.GetInpItm:longint;
begin
  Result:=oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TStminpTmp.SetInpItm(pValue:longint);
begin
  oTmpTable.FieldByName('InpItm').AsInteger:=pValue;
end;

function TStminpTmp.GetInpStk:word;
begin
  Result:=oTmpTable.FieldByName('InpStk').AsInteger;
end;

procedure TStminpTmp.SetInpStk(pValue:word);
begin
  oTmpTable.FieldByName('InpStk').AsInteger:=pValue;
end;

function TStminpTmp.GetInpFif:longint;
begin
  Result:=oTmpTable.FieldByName('InpFif').AsInteger;
end;

procedure TStminpTmp.SetInpFif(pValue:longint);
begin
  oTmpTable.FieldByName('InpFif').AsInteger:=pValue;
end;

function TStminpTmp.GetInpStm:longint;
begin
  Result:=oTmpTable.FieldByName('InpStm').AsInteger;
end;

procedure TStminpTmp.SetInpStm(pValue:longint);
begin
  oTmpTable.FieldByName('InpStm').AsInteger:=pValue;
end;

function TStminpTmp.GetInpPnu:longint;
begin
  Result:=oTmpTable.FieldByName('InpPnu').AsInteger;
end;

procedure TStminpTmp.SetInpPnu(pValue:longint);
begin
  oTmpTable.FieldByName('InpPnu').AsInteger:=pValue;
end;

function TStminpTmp.GetInpPna:Str60;
begin
  Result:=oTmpTable.FieldByName('InpPna').AsString;
end;

procedure TStminpTmp.SetInpPna(pValue:Str60);
begin
  oTmpTable.FieldByName('InpPna').AsString:=pValue;
end;

function TStminpTmp.GetInpPrq:double;
begin
  Result:=oTmpTable.FieldByName('InpPrq').AsFloat;
end;

procedure TStminpTmp.SetInpPrq(pValue:double);
begin
  oTmpTable.FieldByName('InpPrq').AsFloat:=pValue;
end;

function TStminpTmp.GetInpCva:double;
begin
  Result:=oTmpTable.FieldByName('InpCva').AsFloat;
end;

procedure TStminpTmp.SetInpCva(pValue:double);
begin
  oTmpTable.FieldByName('InpCva').AsFloat:=pValue;
end;

function TStminpTmp.GetModPrc:double;
begin
  Result:=oTmpTable.FieldByName('ModPrc').AsFloat;
end;

procedure TStminpTmp.SetModPrc(pValue:double);
begin
  oTmpTable.FieldByName('ModPrc').AsFloat:=pValue;
end;

function TStminpTmp.GetModCpc:double;
begin
  Result:=oTmpTable.FieldByName('ModCpc').AsFloat;
end;

procedure TStminpTmp.SetModCpc(pValue:double);
begin
  oTmpTable.FieldByName('ModCpc').AsFloat:=pValue;
end;

function TStminpTmp.GetModCva:double;
begin
  Result:=oTmpTable.FieldByName('ModCva').AsFloat;
end;

procedure TStminpTmp.SetModCva(pValue:double);
begin
  oTmpTable.FieldByName('ModCva').AsFloat:=pValue;
end;

function TStminpTmp.GetInpSta:Str1;
begin
  Result:=oTmpTable.FieldByName('InpSta').AsString;
end;

procedure TStminpTmp.SetInpSta(pValue:Str1);
begin
  oTmpTable.FieldByName('InpSta').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStminpTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStminpTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStminpTmp.LocLeDoIt(pInpLev:byte;pInpDoc:Str12;pInpItm:longint):boolean;
begin
  SetIndex (ixLeDoIt);
  Result:=oTmpTable.FindKey([pInpLev,pInpDoc,pInpItm]);
end;

procedure TStminpTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStminpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStminpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStminpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStminpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStminpTmp.First;
begin
  oTmpTable.First;
end;

procedure TStminpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStminpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStminpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStminpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStminpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStminpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStminpTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStminpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStminpTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStminpTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStminpTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
