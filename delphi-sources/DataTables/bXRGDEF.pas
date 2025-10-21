unit bXRGDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItIv = 'ItIv';

type
  TXrgdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIdcTyp:Str2;           procedure WriteIdcTyp (pValue:Str2);
    function  ReadIdcVal:Str15;          procedure WriteIdcVal (pValue:Str15);
    function  ReadSrcNum:longint;        procedure WriteSrcNum (pValue:longint);
    function  ReadSrcNam:Str60;          procedure WriteSrcNam (pValue:Str60);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateItIv (pIdcTyp:Str2;pIdcVal:Str15):boolean;
    function NearestItIv (pIdcTyp:Str2;pIdcVal:Str15):boolean;

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
    property IdcTyp:Str2 read ReadIdcTyp write WriteIdcTyp;
    property IdcVal:Str15 read ReadIdcVal write WriteIdcVal;
    property SrcNum:longint read ReadSrcNum write WriteSrcNum;
    property SrcNam:Str60 read ReadSrcNam write WriteSrcNam;
  end;

implementation

constructor TXrgdefBtr.Create;
begin
  oBtrTable := BtrInit ('XRGDEF',gPath.StkPath,Self);
end;

constructor TXrgdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRGDEF',pPath,Self);
end;

destructor TXrgdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrgdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrgdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrgdefBtr.ReadIdcTyp:Str2;
begin
  Result := oBtrTable.FieldByName('IdcTyp').AsString;
end;

procedure TXrgdefBtr.WriteIdcTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('IdcTyp').AsString := pValue;
end;

function TXrgdefBtr.ReadIdcVal:Str15;
begin
  Result := oBtrTable.FieldByName('IdcVal').AsString;
end;

procedure TXrgdefBtr.WriteIdcVal(pValue:Str15);
begin
  oBtrTable.FieldByName('IdcVal').AsString := pValue;
end;

function TXrgdefBtr.ReadSrcNum:longint;
begin
  Result := oBtrTable.FieldByName('SrcNum').AsInteger;
end;

procedure TXrgdefBtr.WriteSrcNum(pValue:longint);
begin
  oBtrTable.FieldByName('SrcNum').AsInteger := pValue;
end;

function TXrgdefBtr.ReadSrcNam:Str60;
begin
  Result := oBtrTable.FieldByName('SrcNam').AsString;
end;

procedure TXrgdefBtr.WriteSrcNam(pValue:Str60);
begin
  oBtrTable.FieldByName('SrcNam').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrgdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrgdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrgdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrgdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrgdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrgdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrgdefBtr.LocateItIv (pIdcTyp:Str2;pIdcVal:Str15):boolean;
begin
  SetIndex (ixItIv);
  Result := oBtrTable.FindKey([pIdcTyp,pIdcVal]);
end;

function TXrgdefBtr.NearestItIv (pIdcTyp:Str2;pIdcVal:Str15):boolean;
begin
  SetIndex (ixItIv);
  Result := oBtrTable.FindNearest([pIdcTyp,pIdcVal]);
end;

procedure TXrgdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrgdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TXrgdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrgdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrgdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrgdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrgdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrgdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrgdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrgdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrgdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrgdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrgdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrgdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrgdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrgdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrgdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
