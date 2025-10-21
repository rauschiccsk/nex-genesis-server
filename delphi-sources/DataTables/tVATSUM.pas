unit tVATSUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixVatPrc='';

type
  TVatsumTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetAvalue:double;           procedure SetAvalue (pValue:double);
    function GetVatVal:double;           procedure SetVatVal (pValue:double);
    function GetBvalue:double;           procedure SetBvalue (pValue:double);
    function GetDepBva:double;           procedure SetDepBva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocVatPrc (pVatPrc:byte):boolean;

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
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property Avalue:double read GetAvalue write SetAvalue;
    property VatVal:double read GetVatVal write SetVatVal;
    property Bvalue:double read GetBvalue write SetBvalue;
    property DepBva:double read GetDepBva write SetDepBva;
  end;

implementation

constructor TVatsumTmp.Create;
begin
  oTmpTable:=TmpInit ('VATSUM',Self);
end;

destructor TVatsumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TVatsumTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TVatsumTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TVatsumTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TVatsumTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TVatsumTmp.GetAvalue:double;
begin
  Result:=oTmpTable.FieldByName('Avalue').AsFloat;
end;

procedure TVatsumTmp.SetAvalue(pValue:double);
begin
  oTmpTable.FieldByName('Avalue').AsFloat:=pValue;
end;

function TVatsumTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TVatsumTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TVatsumTmp.GetBvalue:double;
begin
  Result:=oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TVatsumTmp.SetBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat:=pValue;
end;

function TVatsumTmp.GetDepBva:double;
begin
  Result:=oTmpTable.FieldByName('DepBva').AsFloat;
end;

procedure TVatsumTmp.SetDepBva(pValue:double);
begin
  oTmpTable.FieldByName('DepBva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TVatsumTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TVatsumTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TVatsumTmp.LocVatPrc(pVatPrc:byte):boolean;
begin
  SetIndex (ixVatPrc);
  Result:=oTmpTable.FindKey([pVatPrc]);
end;

procedure TVatsumTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TVatsumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TVatsumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TVatsumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TVatsumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TVatsumTmp.First;
begin
  oTmpTable.First;
end;

procedure TVatsumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TVatsumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TVatsumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TVatsumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TVatsumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TVatsumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TVatsumTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TVatsumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TVatsumTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TVatsumTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TVatsumTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
