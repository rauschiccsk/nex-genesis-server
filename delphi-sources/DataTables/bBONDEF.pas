unit bBONDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEndDat='EndDat';

type
  TBondefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadTrnBon:double;         procedure WriteTrnBon (pValue:double);
    function  ReadDesTxt:Str100;         procedure WriteDesTxt (pValue:Str100);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEndDat (pEndDat:TDatetime):boolean;
    function NearestEndDat (pEndDat:TDatetime):boolean;

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
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property TrnBon:double read ReadTrnBon write WriteTrnBon;
    property DesTxt:Str100 read ReadDesTxt write WriteDesTxt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TBondefBtr.Create;
begin
  oBtrTable := BtrInit ('BONDEF',gPath.StkPath,Self);
end;

constructor TBondefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BONDEF',pPath,Self);
end;

destructor TBondefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBondefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBondefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBondefBtr.ReadEndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat').AsDateTime;
end;

procedure TBondefBtr.WriteEndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TBondefBtr.ReadTrnBon:double;
begin
  Result := oBtrTable.FieldByName('TrnBon').AsFloat;
end;

procedure TBondefBtr.WriteTrnBon(pValue:double);
begin
  oBtrTable.FieldByName('TrnBon').AsFloat := pValue;
end;

function TBondefBtr.ReadDesTxt:Str100;
begin
  Result := oBtrTable.FieldByName('DesTxt').AsString;
end;

procedure TBondefBtr.WriteDesTxt(pValue:Str100);
begin
  oBtrTable.FieldByName('DesTxt').AsString := pValue;
end;

function TBondefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TBondefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBondefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBondefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBondefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBondefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBondefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBondefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBondefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBondefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBondefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBondefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBondefBtr.LocateEndDat (pEndDat:TDatetime):boolean;
begin
  SetIndex (ixEndDat);
  Result := oBtrTable.FindKey([pEndDat]);
end;

function TBondefBtr.NearestEndDat (pEndDat:TDatetime):boolean;
begin
  SetIndex (ixEndDat);
  Result := oBtrTable.FindNearest([pEndDat]);
end;

procedure TBondefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBondefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBondefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBondefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBondefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBondefBtr.First;
begin
  oBtrTable.First;
end;

procedure TBondefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBondefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBondefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBondefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBondefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBondefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBondefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBondefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBondefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBondefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBondefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
