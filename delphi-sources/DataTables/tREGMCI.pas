unit tREGMCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSysCode = '';

type
  TRegmciTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSysCode:Str15;         procedure WriteSysCode (pValue:Str15);
    function  ReadSysName:Str40;         procedure WriteSysName (pValue:Str40);
    function  ReadSysMark:Str2;          procedure WriteSysMark (pValue:Str2);
    function  ReadSysType:Str1;          procedure WriteSysType (pValue:Str1);
    function  ReadSysVal:double;         procedure WriteSysVal (pValue:double);
    function  ReadActPrc:double;         procedure WriteActPrc (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSysCode (pSysCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property SysCode:Str15 read ReadSysCode write WriteSysCode;
    property SysName:Str40 read ReadSysName write WriteSysName;
    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property SysType:Str1 read ReadSysType write WriteSysType;
    property SysVal:double read ReadSysVal write WriteSysVal;
    property ActPrc:double read ReadActPrc write WriteActPrc;
    property ActVal:double read ReadActVal write WriteActVal;
  end;

implementation

constructor TRegmciTmp.Create;
begin
  oTmpTable := TmpInit ('REGMCI',Self);
end;

destructor TRegmciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRegmciTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRegmciTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRegmciTmp.ReadSysCode:Str15;
begin
  Result := oTmpTable.FieldByName('SysCode').AsString;
end;

procedure TRegmciTmp.WriteSysCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SysCode').AsString := pValue;
end;

function TRegmciTmp.ReadSysName:Str40;
begin
  Result := oTmpTable.FieldByName('SysName').AsString;
end;

procedure TRegmciTmp.WriteSysName(pValue:Str40);
begin
  oTmpTable.FieldByName('SysName').AsString := pValue;
end;

function TRegmciTmp.ReadSysMark:Str2;
begin
  Result := oTmpTable.FieldByName('SysMark').AsString;
end;

procedure TRegmciTmp.WriteSysMark(pValue:Str2);
begin
  oTmpTable.FieldByName('SysMark').AsString := pValue;
end;

function TRegmciTmp.ReadSysType:Str1;
begin
  Result := oTmpTable.FieldByName('SysType').AsString;
end;

procedure TRegmciTmp.WriteSysType(pValue:Str1);
begin
  oTmpTable.FieldByName('SysType').AsString := pValue;
end;

function TRegmciTmp.ReadSysVal:double;
begin
  Result := oTmpTable.FieldByName('SysVal').AsFloat;
end;

procedure TRegmciTmp.WriteSysVal(pValue:double);
begin
  oTmpTable.FieldByName('SysVal').AsFloat := pValue;
end;

function TRegmciTmp.ReadActPrc:double;
begin
  Result := oTmpTable.FieldByName('ActPrc').AsFloat;
end;

procedure TRegmciTmp.WriteActPrc(pValue:double);
begin
  oTmpTable.FieldByName('ActPrc').AsFloat := pValue;
end;

function TRegmciTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TRegmciTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegmciTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRegmciTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRegmciTmp.LocateSysCode (pSysCode:Str15):boolean;
begin
  SetIndex (ixSysCode);
  Result := oTmpTable.FindKey([pSysCode]);
end;

procedure TRegmciTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRegmciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRegmciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRegmciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRegmciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRegmciTmp.First;
begin
  oTmpTable.First;
end;

procedure TRegmciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRegmciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRegmciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRegmciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRegmciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRegmciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRegmciTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRegmciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRegmciTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRegmciTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRegmciTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
