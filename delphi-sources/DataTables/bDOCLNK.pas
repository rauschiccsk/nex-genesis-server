unit bDOCLNK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDnDa = 'DnDa';

type
  TDoclnkBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocPath:Str90;         procedure WriteDocPath (pValue:Str90);
    function  ReadDocName:Str90;         procedure WriteDocName (pValue:Str90);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDnDa (pDocNum:Str12;pDocName:Str90):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDnDa (pDocNum:Str12;pDocName:Str90):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocPath:Str90 read ReadDocPath write WriteDocPath;
    property DocName:Str90 read ReadDocName write WriteDocName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TDoclnkBtr.Create;
begin
  oBtrTable := BtrInit ('DOCLNK',gPath.StkPath,Self);
end;

constructor TDoclnkBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DOCLNK',pPath,Self);
end;

destructor TDoclnkBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDoclnkBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDoclnkBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDoclnkBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TDoclnkBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TDoclnkBtr.ReadDocPath:Str90;
begin
  Result := oBtrTable.FieldByName('DocPath').AsString;
end;

procedure TDoclnkBtr.WriteDocPath(pValue:Str90);
begin
  oBtrTable.FieldByName('DocPath').AsString := pValue;
end;

function TDoclnkBtr.ReadDocName:Str90;
begin
  Result := oBtrTable.FieldByName('DocName').AsString;
end;

procedure TDoclnkBtr.WriteDocName(pValue:Str90);
begin
  oBtrTable.FieldByName('DocName').AsString := pValue;
end;

function TDoclnkBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDoclnkBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDoclnkBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDoclnkBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDoclnkBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDoclnkBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDoclnkBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDoclnkBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDoclnkBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDoclnkBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDoclnkBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDoclnkBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDoclnkBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TDoclnkBtr.LocateDnDa (pDocNum:Str12;pDocName:Str90):boolean;
begin
  SetIndex (ixDnDa);
  Result := oBtrTable.FindKey([pDocNum,pDocName]);
end;

function TDoclnkBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TDoclnkBtr.NearestDnDa (pDocNum:Str12;pDocName:Str90):boolean;
begin
  SetIndex (ixDnDa);
  Result := oBtrTable.FindNearest([pDocNum,pDocName]);
end;

procedure TDoclnkBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDoclnkBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDoclnkBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDoclnkBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDoclnkBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDoclnkBtr.First;
begin
  oBtrTable.First;
end;

procedure TDoclnkBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDoclnkBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDoclnkBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDoclnkBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDoclnkBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDoclnkBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDoclnkBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDoclnkBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDoclnkBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDoclnkBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDoclnkBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1904013}
