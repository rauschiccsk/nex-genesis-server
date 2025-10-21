unit bGSCKEY;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSrchKey = 'SrchKey';
  ixGsCode = 'GsCode';
  ixSkGc = 'SkGc';

type
  TGsckeyBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSrchKey:Str30;         procedure WriteSrchKey (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSrchKey (pSrchKey:Str30):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSkGc (pSrchKey:Str30;pGsCode:longint):boolean;
    function NearestSrchKey (pSrchKey:Str30):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestSkGc (pSrchKey:Str30;pGsCode:longint):boolean;

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
    property SrchKey:Str30 read ReadSrchKey write WriteSrchKey;
    property GsCode:longint read ReadGsCode write WriteGsCode;
  end;

implementation

constructor TGsckeyBtr.Create;
begin
  oBtrTable := BtrInit ('GSCKEY',gPath.StkPath,Self);
end;

constructor TGsckeyBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSCKEY',pPath,Self);
end;

destructor TGsckeyBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGsckeyBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGsckeyBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGsckeyBtr.ReadSrchKey:Str30;
begin
  Result := oBtrTable.FieldByName('SrchKey').AsString;
end;

procedure TGsckeyBtr.WriteSrchKey(pValue:Str30);
begin
  oBtrTable.FieldByName('SrchKey').AsString := pValue;
end;

function TGsckeyBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsckeyBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsckeyBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsckeyBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGsckeyBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsckeyBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGsckeyBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGsckeyBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGsckeyBtr.LocateSrchKey (pSrchKey:Str30):boolean;
begin
  SetIndex (ixSrchKey);
  Result := oBtrTable.FindKey([pSrchKey]);
end;

function TGsckeyBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGsckeyBtr.LocateSkGc (pSrchKey:Str30;pGsCode:longint):boolean;
begin
  SetIndex (ixSkGc);
  Result := oBtrTable.FindKey([pSrchKey,pGsCode]);
end;

function TGsckeyBtr.NearestSrchKey (pSrchKey:Str30):boolean;
begin
  SetIndex (ixSrchKey);
  Result := oBtrTable.FindNearest([pSrchKey]);
end;

function TGsckeyBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TGsckeyBtr.NearestSkGc (pSrchKey:Str30;pGsCode:longint):boolean;
begin
  SetIndex (ixSkGc);
  Result := oBtrTable.FindNearest([pSrchKey,pGsCode]);
end;

procedure TGsckeyBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGsckeyBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGsckeyBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGsckeyBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGsckeyBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGsckeyBtr.First;
begin
  oBtrTable.First;
end;

procedure TGsckeyBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGsckeyBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGsckeyBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGsckeyBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGsckeyBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGsckeyBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGsckeyBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGsckeyBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGsckeyBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGsckeyBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGsckeyBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1804003}
