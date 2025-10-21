unit bPLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpCod = 'GrpCod';
  ixGrpNam = 'GrpNam';

type
  TPlcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpCod:longint;        procedure WriteGrpCod (pValue:longint);
    function  ReadGrpNam:Str50;          procedure WriteGrpNam (pValue:Str50);
    function  ReadGrpNam_:Str50;         procedure WriteGrpNam_ (pValue:Str50);
    function  ReadGrpTyp:Str1;           procedure WriteGrpTyp (pValue:Str1);
    function  ReadClcPrc:double;         procedure WriteClcPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;              
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGrpCod (pGrpCod:longint):boolean;
    function LocateGrpNam (pGrpNam_:Str50):boolean;
    function NearestGrpCod (pGrpCod:longint):boolean;
    function NearestGrpNam (pGrpNam_:Str50):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pPlsNum:word);
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
    property GrpCod:longint read ReadGrpCod write WriteGrpCod;
    property GrpNam:Str50 read ReadGrpNam write WriteGrpNam;
    property GrpNam_:Str50 read ReadGrpNam_ write WriteGrpNam_;
    property GrpTyp:Str1 read ReadGrpTyp write WriteGrpTyp;
    property ClcPrc:double read ReadClcPrc write WriteClcPrc;
  end;

implementation

constructor TPlcBtr.Create;
begin
  oBtrTable := BtrInit ('PLC',gPath.StkPath,Self);
end;

constructor TPlcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLC',pPath,Self);
end;

destructor TPlcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlcBtr.ReadGrpCod:longint;
begin
  Result := oBtrTable.FieldByName('GrpCod').AsInteger;
end;

procedure TPlcBtr.WriteGrpCod(pValue:longint);
begin
  oBtrTable.FieldByName('GrpCod').AsInteger := pValue;
end;

function TPlcBtr.ReadGrpNam:Str50;
begin
  Result := oBtrTable.FieldByName('GrpNam').AsString;
end;

procedure TPlcBtr.WriteGrpNam(pValue:Str50);
begin
  oBtrTable.FieldByName('GrpNam').AsString := pValue;
end;

function TPlcBtr.ReadGrpNam_:Str50;
begin
  Result := oBtrTable.FieldByName('GrpNam_').AsString;
end;

procedure TPlcBtr.WriteGrpNam_(pValue:Str50);
begin
  oBtrTable.FieldByName('GrpNam_').AsString := pValue;
end;

function TPlcBtr.ReadGrpTyp:Str1;
begin
  Result := oBtrTable.FieldByName('GrpTyp').AsString;
end;

procedure TPlcBtr.WriteGrpTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('GrpTyp').AsString := pValue;
end;

function TPlcBtr.ReadClcPrc:double;
begin
  Result := oBtrTable.FieldByName('ClcPrc').AsFloat;
end;

procedure TPlcBtr.WriteClcPrc(pValue:double);
begin
  oBtrTable.FieldByName('ClcPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPlcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlcBtr.LocateGrpCod (pGrpCod:longint):boolean;
begin
  SetIndex (ixGrpCod);
  Result := oBtrTable.FindKey([pGrpCod]);
end;

function TPlcBtr.LocateGrpNam (pGrpNam_:Str50):boolean;
begin
  SetIndex (ixGrpNam);
  Result := oBtrTable.FindKey([StrToAlias(pGrpNam_)]);
end;

function TPlcBtr.NearestGrpCod (pGrpCod:longint):boolean;
begin
  SetIndex (ixGrpCod);
  Result := oBtrTable.FindNearest([pGrpCod]);
end;

function TPlcBtr.NearestGrpNam (pGrpNam_:Str50):boolean;
begin
  SetIndex (ixGrpNam);
  Result := oBtrTable.FindNearest([pGrpNam_]);
end;

procedure TPlcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlcBtr.Open(pPlsNum:word);
begin
  oBtrTable.Open(pPlsNum);
end;

procedure TPlcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlcBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1925001}
