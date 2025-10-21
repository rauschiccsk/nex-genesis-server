unit tCCTLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCctCod='';

type
  TCctlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetCctCod:Str10;            procedure SetCctCod (pValue:Str10);
    function GetCctNam:Str250;           procedure SetCctNam (pValue:Str250);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocCctCod (pCctCod:Str10):boolean;

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
    property CctCod:Str10 read GetCctCod write SetCctCod;
    property CctNam:Str250 read GetCctNam write SetCctNam;
  end;

implementation

constructor TCctlstTmp.Create;
begin
  oTmpTable:=TmpInit ('CCTLST',Self);
end;

destructor TCctlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCctlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TCctlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TCctlstTmp.GetCctCod:Str10;
begin
  Result:=oTmpTable.FieldByName('CctCod').AsString;
end;

procedure TCctlstTmp.SetCctCod(pValue:Str10);
begin
  oTmpTable.FieldByName('CctCod').AsString:=pValue;
end;

function TCctlstTmp.GetCctNam:Str250;
begin
  Result:=oTmpTable.FieldByName('CctNam').AsString;
end;

procedure TCctlstTmp.SetCctNam(pValue:Str250);
begin
  oTmpTable.FieldByName('CctNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCctlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TCctlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TCctlstTmp.LocCctCod(pCctCod:Str10):boolean;
begin
  SetIndex (ixCctCod);
  Result:=oTmpTable.FindKey([pCctCod]);
end;

procedure TCctlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TCctlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCctlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCctlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCctlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCctlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TCctlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCctlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCctlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCctlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCctlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCctlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCctlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCctlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCctlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCctlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TCctlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
