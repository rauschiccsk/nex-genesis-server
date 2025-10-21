unit tEASDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEtEi='';
  ixEasIdn='EasIdn';

type
  TEasdefTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetEasTyp:Str1;             procedure SetEasTyp (pValue:Str1);
    function GetEasIdn:longint;          procedure SetEasIdn (pValue:longint);
    function GetEasNam:Str30;            procedure SetEasNam (pValue:Str30);
    function GetEmlAdr:Str30;            procedure SetEmlAdr (pValue:Str30);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocEtEi (pEasTyp:Str1;pEasIdn:longint):boolean;
    function LocEasIdn (pEasIdn:longint):boolean;

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
    property EasTyp:Str1 read GetEasTyp write SetEasTyp;
    property EasIdn:longint read GetEasIdn write SetEasIdn;
    property EasNam:Str30 read GetEasNam write SetEasNam;
    property EmlAdr:Str30 read GetEmlAdr write SetEmlAdr;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TEasdefTmp.Create;
begin
  oTmpTable:=TmpInit ('EASDEF',Self);
end;

destructor TEasdefTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEasdefTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TEasdefTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TEasdefTmp.GetEasTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('EasTyp').AsString;
end;

procedure TEasdefTmp.SetEasTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('EasTyp').AsString:=pValue;
end;

function TEasdefTmp.GetEasIdn:longint;
begin
  Result:=oTmpTable.FieldByName('EasIdn').AsInteger;
end;

procedure TEasdefTmp.SetEasIdn(pValue:longint);
begin
  oTmpTable.FieldByName('EasIdn').AsInteger:=pValue;
end;

function TEasdefTmp.GetEasNam:Str30;
begin
  Result:=oTmpTable.FieldByName('EasNam').AsString;
end;

procedure TEasdefTmp.SetEasNam(pValue:Str30);
begin
  oTmpTable.FieldByName('EasNam').AsString:=pValue;
end;

function TEasdefTmp.GetEmlAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('EmlAdr').AsString;
end;

procedure TEasdefTmp.SetEmlAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('EmlAdr').AsString:=pValue;
end;

function TEasdefTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TEasdefTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEasdefTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TEasdefTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TEasdefTmp.LocEtEi(pEasTyp:Str1;pEasIdn:longint):boolean;
begin
  SetIndex (ixEtEi);
  Result:=oTmpTable.FindKey([pEasTyp,pEasIdn]);
end;

function TEasdefTmp.LocEasIdn(pEasIdn:longint):boolean;
begin
  SetIndex (ixEasIdn);
  Result:=oTmpTable.FindKey([pEasIdn]);
end;

procedure TEasdefTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TEasdefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEasdefTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEasdefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEasdefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEasdefTmp.First;
begin
  oTmpTable.First;
end;

procedure TEasdefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEasdefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEasdefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEasdefTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEasdefTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEasdefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEasdefTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEasdefTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEasdefTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEasdefTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TEasdefTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
