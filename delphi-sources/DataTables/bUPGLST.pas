unit bUPGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUpgNum = 'UpgNum';

type
  TUpglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadUpgNum:word;           procedure WriteUpgNum (pValue:word);
    function  ReadOldVers:Str10;         procedure WriteOldVers (pValue:Str10);
    function  ReadNewVers:Str10;         procedure WriteNewVers (pValue:Str10);
    function  ReadStatus:Str2;           procedure WriteStatus (pValue:Str2);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateUpgNum (pUpgNum:word):boolean;
    function NearestUpgNum (pUpgNum:word):boolean;

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
    property UpgNum:word read ReadUpgNum write WriteUpgNum;
    property OldVers:Str10 read ReadOldVers write WriteOldVers;
    property NewVers:Str10 read ReadNewVers write WriteNewVers;
    property Status:Str2 read ReadStatus write WriteStatus;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TUpglstBtr.Create;
begin
  oBtrTable := BtrInit ('UPGLST',gPath.SysPath,Self);
end;

constructor TUpglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('UPGLST',pPath,Self);
end;

destructor TUpglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TUpglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TUpglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TUpglstBtr.ReadUpgNum:word;
begin
  Result := oBtrTable.FieldByName('UpgNum').AsInteger;
end;

procedure TUpglstBtr.WriteUpgNum(pValue:word);
begin
  oBtrTable.FieldByName('UpgNum').AsInteger := pValue;
end;

function TUpglstBtr.ReadOldVers:Str10;
begin
  Result := oBtrTable.FieldByName('OldVers').AsString;
end;

procedure TUpglstBtr.WriteOldVers(pValue:Str10);
begin
  oBtrTable.FieldByName('OldVers').AsString := pValue;
end;

function TUpglstBtr.ReadNewVers:Str10;
begin
  Result := oBtrTable.FieldByName('NewVers').AsString;
end;

procedure TUpglstBtr.WriteNewVers(pValue:Str10);
begin
  oBtrTable.FieldByName('NewVers').AsString := pValue;
end;

function TUpglstBtr.ReadStatus:Str2;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TUpglstBtr.WriteStatus(pValue:Str2);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TUpglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TUpglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TUpglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TUpglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TUpglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TUpglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUpglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUpglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TUpglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TUpglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TUpglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TUpglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TUpglstBtr.LocateUpgNum (pUpgNum:word):boolean;
begin
  SetIndex (ixUpgNum);
  Result := oBtrTable.FindKey([pUpgNum]);
end;

function TUpglstBtr.NearestUpgNum (pUpgNum:word):boolean;
begin
  SetIndex (ixUpgNum);
  Result := oBtrTable.FindNearest([pUpgNum]);
end;

procedure TUpglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TUpglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TUpglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TUpglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TUpglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TUpglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TUpglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TUpglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TUpglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TUpglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TUpglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TUpglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TUpglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TUpglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TUpglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TUpglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TUpglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
