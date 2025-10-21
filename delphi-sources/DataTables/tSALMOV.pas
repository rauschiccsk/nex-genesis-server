unit tSALMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode='';

type
  TSalmovTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetBaCode:Str15;            procedure SetBaCode (pValue:Str15);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetMgCode:longint;          procedure SetMgCode (pValue:longint);
    function GetMgName:Str30;            procedure SetMgName (pValue:Str30);
    function GetSalQnt:double;           procedure SetSalQnt (pValue:double);
    function GetBvalue:double;           procedure SetBvalue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocGsCode (pGsCode:longint):boolean;

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
    property GsCode:longint read GetGsCode write SetGsCode;
    property BaCode:Str15 read GetBaCode write SetBaCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property MgCode:longint read GetMgCode write SetMgCode;
    property MgName:Str30 read GetMgName write SetMgName;
    property SalQnt:double read GetSalQnt write SetSalQnt;
    property Bvalue:double read GetBvalue write SetBvalue;
  end;

implementation

constructor TSalmovTmp.Create;
begin
  oTmpTable:=TmpInit ('SALMOV',Self);
end;

destructor TSalmovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSalmovTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TSalmovTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TSalmovTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSalmovTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TSalmovTmp.GetBaCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BaCode').AsString;
end;

procedure TSalmovTmp.SetBaCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BaCode').AsString:=pValue;
end;

function TSalmovTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSalmovTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TSalmovTmp.GetMgCode:longint;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSalmovTmp.SetMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TSalmovTmp.GetMgName:Str30;
begin
  Result:=oTmpTable.FieldByName('MgName').AsString;
end;

procedure TSalmovTmp.SetMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString:=pValue;
end;

function TSalmovTmp.GetSalQnt:double;
begin
  Result:=oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TSalmovTmp.SetSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat:=pValue;
end;

function TSalmovTmp.GetBvalue:double;
begin
  Result:=oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TSalmovTmp.SetBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSalmovTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TSalmovTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TSalmovTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

procedure TSalmovTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TSalmovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSalmovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSalmovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSalmovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSalmovTmp.First;
begin
  oTmpTable.First;
end;

procedure TSalmovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSalmovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSalmovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSalmovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSalmovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSalmovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSalmovTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSalmovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSalmovTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSalmovTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TSalmovTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
