unit bCRPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrpNam = 'CrpNam';

type
  TCrplstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCrpNam:Str30;          procedure WriteCrpNam (pValue:Str30);
    function  ReadCrpDir:Str30;          procedure WriteCrpDir (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCrpNam (pCrpNam:Str30):boolean;
    function NearestCrpNam (pCrpNam:Str30):boolean;

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
    property CrpNam:Str30 read ReadCrpNam write WriteCrpNam;
    property CrpDir:Str30 read ReadCrpDir write WriteCrpDir;
  end;

implementation

constructor TCrplstBtr.Create;
begin
  oBtrTable := BtrInit ('CRPLST',gPath.SysPath,Self);
end;

constructor TCrplstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRPLST',pPath,Self);
end;

destructor TCrplstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrplstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrplstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrplstBtr.ReadCrpNam:Str30;
begin
  Result := oBtrTable.FieldByName('CrpNam').AsString;
end;

procedure TCrplstBtr.WriteCrpNam(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpNam').AsString := pValue;
end;

function TCrplstBtr.ReadCrpDir:Str30;
begin
  Result := oBtrTable.FieldByName('CrpDir').AsString;
end;

procedure TCrplstBtr.WriteCrpDir(pValue:Str30);
begin
  oBtrTable.FieldByName('CrpDir').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrplstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrplstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrplstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrplstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrplstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrplstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrplstBtr.LocateCrpNam (pCrpNam:Str30):boolean;
begin
  SetIndex (ixCrpNam);
  Result := oBtrTable.FindKey([pCrpNam]);
end;

function TCrplstBtr.NearestCrpNam (pCrpNam:Str30):boolean;
begin
  SetIndex (ixCrpNam);
  Result := oBtrTable.FindNearest([pCrpNam]);
end;

procedure TCrplstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrplstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrplstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrplstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrplstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrplstBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrplstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrplstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrplstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrplstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrplstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrplstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrplstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrplstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrplstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrplstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrplstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1916001}
