unit bLBLFRM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLbfCode = 'LbfCode';
  ixLbfName = 'LbfName';

type
  TLblfrmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLbfCode:byte;          procedure WriteLbfCode (pValue:byte);
    function  ReadLbfName:Str30;         procedure WriteLbfName (pValue:Str30);
    function  ReadLbfName_:Str30;        procedure WriteLbfName_ (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateLbfCode (pLbfCode:byte):boolean;
    function LocateLbfName (pLbfName_:Str30):boolean;
    function NearestLbfCode (pLbfCode:byte):boolean;
    function NearestLbfName (pLbfName_:Str30):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property LbfCode:byte read ReadLbfCode write WriteLbfCode;
    property LbfName:Str30 read ReadLbfName write WriteLbfName;
    property LbfName_:Str30 read ReadLbfName_ write WriteLbfName_;
  end;

implementation

constructor TLblfrmBtr.Create;
begin
  oBtrTable := BtrInit ('LBLFRM',gPath.DlsPath,Self);
end;

constructor TLblfrmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('LBLFRM',pPath,Self);
end;

destructor TLblfrmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TLblfrmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TLblfrmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TLblfrmBtr.ReadLbfCode:byte;
begin
  Result := oBtrTable.FieldByName('LbfCode').AsInteger;
end;

procedure TLblfrmBtr.WriteLbfCode(pValue:byte);
begin
  oBtrTable.FieldByName('LbfCode').AsInteger := pValue;
end;

function TLblfrmBtr.ReadLbfName:Str30;
begin
  Result := oBtrTable.FieldByName('LbfName').AsString;
end;

procedure TLblfrmBtr.WriteLbfName(pValue:Str30);
begin
  oBtrTable.FieldByName('LbfName').AsString := pValue;
end;

function TLblfrmBtr.ReadLbfName_:Str30;
begin
  Result := oBtrTable.FieldByName('LbfName_').AsString;
end;

procedure TLblfrmBtr.WriteLbfName_(pValue:Str30);
begin
  oBtrTable.FieldByName('LbfName_').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLblfrmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLblfrmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TLblfrmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLblfrmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TLblfrmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TLblfrmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TLblfrmBtr.LocateLbfCode (pLbfCode:byte):boolean;
begin
  SetIndex (ixLbfCode);
  Result := oBtrTable.FindKey([pLbfCode]);
end;

function TLblfrmBtr.LocateLbfName (pLbfName_:Str30):boolean;
begin
  SetIndex (ixLbfName);
  Result := oBtrTable.FindKey([StrToAlias(pLbfName_)]);
end;

function TLblfrmBtr.NearestLbfCode (pLbfCode:byte):boolean;
begin
  SetIndex (ixLbfCode);
  Result := oBtrTable.FindNearest([pLbfCode]);
end;

function TLblfrmBtr.NearestLbfName (pLbfName_:Str30):boolean;
begin
  SetIndex (ixLbfName);
  Result := oBtrTable.FindNearest([pLbfName_]);
end;

procedure TLblfrmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TLblfrmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TLblfrmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TLblfrmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TLblfrmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TLblfrmBtr.First;
begin
  oBtrTable.First;
end;

procedure TLblfrmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TLblfrmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TLblfrmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TLblfrmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TLblfrmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TLblfrmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TLblfrmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TLblfrmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TLblfrmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TLblfrmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TLblfrmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1903001}
