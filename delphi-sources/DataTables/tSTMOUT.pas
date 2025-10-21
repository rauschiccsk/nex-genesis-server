unit tSTMOUT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrimer='';
  ixInpFif='InpFif';

type
  TStmoutTmp=class(TComponent)
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
    function GetInpFif:longint;          procedure SetInpFif (pValue:longint);
    function GetInpStk:word;             procedure SetInpStk (pValue:word);
    function GetOutDoc:Str12;            procedure SetOutDoc (pValue:Str12);
    function GetOutItm:longint;          procedure SetOutItm (pValue:longint);
    function GetOutPnu:longint;          procedure SetOutPnu (pValue:longint);
    function GetOutPna:Str60;            procedure SetOutPna (pValue:Str60);
    function GetOutStm:longint;          procedure SetOutStm (pValue:longint);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetOutCva:double;           procedure SetOutCva (pValue:double);
    function GetModPrc:double;           procedure SetModPrc (pValue:double);
    function GetModCpc:double;           procedure SetModCpc (pValue:double);
    function GetModCva:double;           procedure SetModCva (pValue:double);
    function GetConDoc:Str12;            procedure SetConDoc (pValue:Str12);
    function GetConItm:longint;          procedure SetConItm (pValue:longint);
    function GetConStk:word;             procedure SetConStk (pValue:word);
    function GetConLev:byte;             procedure SetConLev (pValue:byte);
    function GetConSta:Str1;             procedure SetConSta (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPrimer (pInpLev:byte;pInpDoc:Str12;pInpItm:longint;pInpFif:longint;pInpSTk:word;pOutDoc:Str12;pOutItm:longint):boolean;
    function LocInpFif (pInpFif:longint):boolean;

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
    property InpFif:longint read GetInpFif write SetInpFif;
    property InpStk:word read GetInpStk write SetInpStk;
    property OutDoc:Str12 read GetOutDoc write SetOutDoc;
    property OutItm:longint read GetOutItm write SetOutItm;
    property OutPnu:longint read GetOutPnu write SetOutPnu;
    property OutPna:Str60 read GetOutPna write SetOutPna;
    property OutStm:longint read GetOutStm write SetOutStm;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property OutCva:double read GetOutCva write SetOutCva;
    property ModPrc:double read GetModPrc write SetModPrc;
    property ModCpc:double read GetModCpc write SetModCpc;
    property ModCva:double read GetModCva write SetModCva;
    property ConDoc:Str12 read GetConDoc write SetConDoc;
    property ConItm:longint read GetConItm write SetConItm;
    property ConStk:word read GetConStk write SetConStk;
    property ConLev:byte read GetConLev write SetConLev;
    property ConSta:Str1 read GetConSta write SetConSta;
  end;

implementation

constructor TStmoutTmp.Create;
begin
  oTmpTable:=TmpInit ('STMOUT',Self);
end;

destructor TStmoutTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStmoutTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStmoutTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStmoutTmp.GetInpLev:byte;
begin
  Result:=oTmpTable.FieldByName('InpLev').AsInteger;
end;

procedure TStmoutTmp.SetInpLev(pValue:byte);
begin
  oTmpTable.FieldByName('InpLev').AsInteger:=pValue;
end;

function TStmoutTmp.GetInpDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TStmoutTmp.SetInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString:=pValue;
end;

function TStmoutTmp.GetInpItm:longint;
begin
  Result:=oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TStmoutTmp.SetInpItm(pValue:longint);
begin
  oTmpTable.FieldByName('InpItm').AsInteger:=pValue;
end;

function TStmoutTmp.GetInpFif:longint;
begin
  Result:=oTmpTable.FieldByName('InpFif').AsInteger;
end;

procedure TStmoutTmp.SetInpFif(pValue:longint);
begin
  oTmpTable.FieldByName('InpFif').AsInteger:=pValue;
end;

function TStmoutTmp.GetInpStk:word;
begin
  Result:=oTmpTable.FieldByName('InpStk').AsInteger;
end;

procedure TStmoutTmp.SetInpStk(pValue:word);
begin
  oTmpTable.FieldByName('InpStk').AsInteger:=pValue;
end;

function TStmoutTmp.GetOutDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TStmoutTmp.SetOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString:=pValue;
end;

function TStmoutTmp.GetOutItm:longint;
begin
  Result:=oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TStmoutTmp.SetOutItm(pValue:longint);
begin
  oTmpTable.FieldByName('OutItm').AsInteger:=pValue;
end;

function TStmoutTmp.GetOutPnu:longint;
begin
  Result:=oTmpTable.FieldByName('OutPnu').AsInteger;
end;

procedure TStmoutTmp.SetOutPnu(pValue:longint);
begin
  oTmpTable.FieldByName('OutPnu').AsInteger:=pValue;
end;

function TStmoutTmp.GetOutPna:Str60;
begin
  Result:=oTmpTable.FieldByName('OutPna').AsString;
end;

procedure TStmoutTmp.SetOutPna(pValue:Str60);
begin
  oTmpTable.FieldByName('OutPna').AsString:=pValue;
end;

function TStmoutTmp.GetOutStm:longint;
begin
  Result:=oTmpTable.FieldByName('OutStm').AsInteger;
end;

procedure TStmoutTmp.SetOutStm(pValue:longint);
begin
  oTmpTable.FieldByName('OutStm').AsInteger:=pValue;
end;

function TStmoutTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TStmoutTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TStmoutTmp.GetOutCva:double;
begin
  Result:=oTmpTable.FieldByName('OutCva').AsFloat;
end;

procedure TStmoutTmp.SetOutCva(pValue:double);
begin
  oTmpTable.FieldByName('OutCva').AsFloat:=pValue;
end;

function TStmoutTmp.GetModPrc:double;
begin
  Result:=oTmpTable.FieldByName('ModPrc').AsFloat;
end;

procedure TStmoutTmp.SetModPrc(pValue:double);
begin
  oTmpTable.FieldByName('ModPrc').AsFloat:=pValue;
end;

function TStmoutTmp.GetModCpc:double;
begin
  Result:=oTmpTable.FieldByName('ModCpc').AsFloat;
end;

procedure TStmoutTmp.SetModCpc(pValue:double);
begin
  oTmpTable.FieldByName('ModCpc').AsFloat:=pValue;
end;

function TStmoutTmp.GetModCva:double;
begin
  Result:=oTmpTable.FieldByName('ModCva').AsFloat;
end;

procedure TStmoutTmp.SetModCva(pValue:double);
begin
  oTmpTable.FieldByName('ModCva').AsFloat:=pValue;
end;

function TStmoutTmp.GetConDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TStmoutTmp.SetConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString:=pValue;
end;

function TStmoutTmp.GetConItm:longint;
begin
  Result:=oTmpTable.FieldByName('ConItm').AsInteger;
end;

procedure TStmoutTmp.SetConItm(pValue:longint);
begin
  oTmpTable.FieldByName('ConItm').AsInteger:=pValue;
end;

function TStmoutTmp.GetConStk:word;
begin
  Result:=oTmpTable.FieldByName('ConStk').AsInteger;
end;

procedure TStmoutTmp.SetConStk(pValue:word);
begin
  oTmpTable.FieldByName('ConStk').AsInteger:=pValue;
end;

function TStmoutTmp.GetConLev:byte;
begin
  Result:=oTmpTable.FieldByName('ConLev').AsInteger;
end;

procedure TStmoutTmp.SetConLev(pValue:byte);
begin
  oTmpTable.FieldByName('ConLev').AsInteger:=pValue;
end;

function TStmoutTmp.GetConSta:Str1;
begin
  Result:=oTmpTable.FieldByName('ConSta').AsString;
end;

procedure TStmoutTmp.SetConSta(pValue:Str1);
begin
  oTmpTable.FieldByName('ConSta').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStmoutTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStmoutTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStmoutTmp.LocPrimer(pInpLev:byte;pInpDoc:Str12;pInpItm:longint;pInpFif:longint;pInpSTk:word;pOutDoc:Str12;pOutItm:longint):boolean;
begin
  SetIndex (ixPrimer);
  Result:=oTmpTable.FindKey([pInpLev,pInpDoc,pInpItm,pInpFif,pInpSTk,pOutDoc,pOutItm]);
end;

function TStmoutTmp.LocInpFif(pInpFif:longint):boolean;
begin
  SetIndex (ixInpFif);
  Result:=oTmpTable.FindKey([pInpFif]);
end;

procedure TStmoutTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStmoutTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStmoutTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStmoutTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStmoutTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStmoutTmp.First;
begin
  oTmpTable.First;
end;

procedure TStmoutTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStmoutTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStmoutTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStmoutTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStmoutTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStmoutTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStmoutTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStmoutTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStmoutTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStmoutTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStmoutTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
