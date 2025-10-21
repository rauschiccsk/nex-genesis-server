unit bGSNOTI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixSended = 'Sended';

type
  TGsnotiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadNotice:Str160;         procedure WriteNotice (pValue:Str160);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestSended (pSended:byte):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property Notice:Str160 read ReadNotice write WriteNotice;
    property Sended:boolean read ReadSended write WriteSended;
  end;

implementation

constructor TGsnotiBtr.Create;
begin
  oBtrTable := BtrInit ('GSNOTI',gPath.StkPath,Self);
end;

constructor TGsnotiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSNOTI',pPath,Self);
end;

destructor TGsnotiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGsnotiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGsnotiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGsnotiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsnotiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsnotiBtr.ReadNotice:Str160;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TGsnotiBtr.WriteNotice(pValue:Str160);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TGsnotiBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TGsnotiBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

// **************************************** PUBLIC ********************************************

function TGsnotiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsnotiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGsnotiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsnotiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGsnotiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGsnotiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGsnotiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGsnotiBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TGsnotiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TGsnotiBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TGsnotiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGsnotiBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGsnotiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGsnotiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGsnotiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGsnotiBtr.First;
begin
  oBtrTable.First;
end;

procedure TGsnotiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGsnotiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGsnotiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGsnotiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGsnotiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGsnotiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGsnotiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGsnotiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGsnotiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGsnotiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGsnotiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
