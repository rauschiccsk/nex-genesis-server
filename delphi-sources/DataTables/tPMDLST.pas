unit tPMDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSyPc='';
  ixPmdCod='PmdCod';

type
  TPmdlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetSysNum:byte;             procedure SetSysNum (pValue:byte);
    function GetPmdCod:Str3;             procedure SetPmdCod (pValue:Str3);
    function GetPmdNam:Str50;            procedure SetPmdNam (pValue:Str50);
    function GetAccess:Str1;             procedure SetAccess (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSyPc (pSysNum:byte;pPmdCod:Str3):boolean;
    function LocPmdCod (pPmdCod:Str3):boolean;

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
    property SysNum:byte read GetSysNum write SetSysNum;
    property PmdCod:Str3 read GetPmdCod write SetPmdCod;
    property PmdNam:Str50 read GetPmdNam write SetPmdNam;
    property Access:Str1 read GetAccess write SetAccess;
  end;

implementation

constructor TPmdlstTmp.Create;
begin
  oTmpTable:=TmpInit ('PMDLST',Self);
end;

destructor TPmdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPmdlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TPmdlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TPmdlstTmp.GetSysNum:byte;
begin
  Result:=oTmpTable.FieldByName('SysNum').AsInteger;
end;

procedure TPmdlstTmp.SetSysNum(pValue:byte);
begin
  oTmpTable.FieldByName('SysNum').AsInteger:=pValue;
end;

function TPmdlstTmp.GetPmdCod:Str3;
begin
  Result:=oTmpTable.FieldByName('PmdCod').AsString;
end;

procedure TPmdlstTmp.SetPmdCod(pValue:Str3);
begin
  oTmpTable.FieldByName('PmdCod').AsString:=pValue;
end;

function TPmdlstTmp.GetPmdNam:Str50;
begin
  Result:=oTmpTable.FieldByName('PmdNam').AsString;
end;

procedure TPmdlstTmp.SetPmdNam(pValue:Str50);
begin
  oTmpTable.FieldByName('PmdNam').AsString:=pValue;
end;

function TPmdlstTmp.GetAccess:Str1;
begin
  Result:=oTmpTable.FieldByName('Access').AsString;
end;

procedure TPmdlstTmp.SetAccess(pValue:Str1);
begin
  oTmpTable.FieldByName('Access').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPmdlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TPmdlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TPmdlstTmp.LocSyPc(pSysNum:byte;pPmdCod:Str3):boolean;
begin
  SetIndex (ixSyPc);
  Result:=oTmpTable.FindKey([pSysNum,pPmdCod]);
end;

function TPmdlstTmp.LocPmdCod(pPmdCod:Str3):boolean;
begin
  SetIndex (ixPmdCod);
  Result:=oTmpTable.FindKey([pPmdCod]);
end;

procedure TPmdlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TPmdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPmdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPmdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPmdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPmdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TPmdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPmdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPmdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPmdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPmdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPmdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPmdlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPmdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPmdlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPmdlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TPmdlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
