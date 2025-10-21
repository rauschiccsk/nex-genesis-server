unit tSPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPcGc = '';
  ixGcPc = 'GcPc';
  ixSorStr = 'SorStr';

type
  TSpcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadSorStr:Str20;          procedure WriteSorStr (pValue:Str20);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadImpDat:TDatetime;      procedure WriteImpDat (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePcGc (pPoCode:Str15;pGsCode:longint):boolean;
    function LocateGcPc (pGsCode:longint;pPoCode:Str15):boolean;
    function LocateSorStr (pSorStr:Str20):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property PoCode:Str15 read ReadPoCode write WritePoCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property SorStr:Str20 read ReadSorStr write WriteSorStr;
    property ActPos:longint read ReadActPos write WriteActPos;
    property ImpDat:TDatetime read ReadImpDat write WriteImpDat;
  end;

implementation

constructor TSpcTmp.Create;
begin
  oTmpTable := TmpInit ('SPC',Self);
end;

destructor TSpcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpcTmp.ReadPoCode:Str15;
begin
  Result := oTmpTable.FieldByName('PoCode').AsString;
end;

procedure TSpcTmp.WritePoCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PoCode').AsString := pValue;
end;

function TSpcTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSpcTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSpcTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TSpcTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TSpcTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TSpcTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TSpcTmp.ReadSorStr:Str20;
begin
  Result := oTmpTable.FieldByName('SorStr').AsString;
end;

procedure TSpcTmp.WriteSorStr(pValue:Str20);
begin
  oTmpTable.FieldByName('SorStr').AsString := pValue;
end;

function TSpcTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSpcTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TSpcTmp.ReadImpDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('ImpDat').AsDateTime;
end;

procedure TSpcTmp.WriteImpDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ImpDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpcTmp.LocatePcGc (pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixPcGc);
  Result := oTmpTable.FindKey([pPoCode,pGsCode]);
end;

function TSpcTmp.LocateGcPc (pGsCode:longint;pPoCode:Str15):boolean;
begin
  SetIndex (ixGcPc);
  Result := oTmpTable.FindKey([pGsCode,pPoCode]);
end;

function TSpcTmp.LocateSorStr (pSorStr:Str20):boolean;
begin
  SetIndex (ixSorStr);
  Result := oTmpTable.FindKey([pSorStr]);
end;

procedure TSpcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpcTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1919001}
