unit tOSGDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='';
  ixParNam_='ParNam_';

type
  TOsgdocTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
  end;

implementation

constructor TOsgdocTmp.Create;
begin
  oTmpTable:=TmpInit ('OSGDOC',Self);
end;

destructor TOsgdocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsgdocTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsgdocTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsgdocTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsgdocTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsgdocTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOsgdocTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsgdocTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TOsgdocTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOsgdocTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsgdocTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsgdocTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsgdocTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsgdocTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsgdocTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsgdocTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsgdocTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsgdocTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TOsgdocTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

procedure TOsgdocTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsgdocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsgdocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsgdocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsgdocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsgdocTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsgdocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsgdocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsgdocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsgdocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsgdocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsgdocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsgdocTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsgdocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsgdocTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsgdocTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsgdocTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
