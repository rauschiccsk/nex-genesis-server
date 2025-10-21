unit bOPENDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';

type
  TOpendocBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadLastMod:TDatetime;     procedure WriteLastMod (pValue:TDatetime);
    function  ReadUserName:Str30;        procedure WriteUserName (pValue:Str30);
    function  ReadOpenUser:Str8;         procedure WriteOpenUser (pValue:Str8);
    function  ReadOpenDate:TDatetime;    procedure WriteOpenDate (pValue:TDatetime);
    function  ReadOpenTime:TDatetime;    procedure WriteOpenTime (pValue:TDatetime);
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
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property LastMod:TDatetime read ReadLastMod write WriteLastMod;
    property UserName:Str30 read ReadUserName write WriteUserName;
    property OpenUser:Str8 read ReadOpenUser write WriteOpenUser;
    property OpenDate:TDatetime read ReadOpenDate write WriteOpenDate;
    property OpenTime:TDatetime read ReadOpenTime write WriteOpenTime;
  end;

implementation

constructor TOpendocBtr.Create;
begin
  oBtrTable := BtrInit ('OPENDOC',gPath.SysPath,Self);
end;

constructor TOpendocBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OPENDOC',pPath,Self);
end;

destructor TOpendocBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOpendocBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOpendocBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOpendocBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOpendocBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOpendocBtr.ReadLastMod:TDatetime;
begin
  Result := oBtrTable.FieldByName('LastMod').AsDateTime;
end;

procedure TOpendocBtr.WriteLastMod(pValue:TDatetime);
begin
  oBtrTable.FieldByName('LastMod').AsDateTime := pValue;
end;

function TOpendocBtr.ReadUserName:Str30;
begin
  Result := oBtrTable.FieldByName('UserName').AsString;
end;

procedure TOpendocBtr.WriteUserName(pValue:Str30);
begin
  oBtrTable.FieldByName('UserName').AsString := pValue;
end;

function TOpendocBtr.ReadOpenUser:Str8;
begin
  Result := oBtrTable.FieldByName('OpenUser').AsString;
end;

procedure TOpendocBtr.WriteOpenUser(pValue:Str8);
begin
  oBtrTable.FieldByName('OpenUser').AsString := pValue;
end;

function TOpendocBtr.ReadOpenDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OpenDate').AsDateTime;
end;

procedure TOpendocBtr.WriteOpenDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OpenDate').AsDateTime := pValue;
end;

function TOpendocBtr.ReadOpenTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('OpenTime').AsDateTime;
end;

procedure TOpendocBtr.WriteOpenTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OpenTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOpendocBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOpendocBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOpendocBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOpendocBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOpendocBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOpendocBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOpendocBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOpendocBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TOpendocBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOpendocBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TOpendocBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOpendocBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOpendocBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOpendocBtr.First;
begin
  oBtrTable.First;
end;

procedure TOpendocBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOpendocBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOpendocBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOpendocBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOpendocBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOpendocBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOpendocBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOpendocBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOpendocBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOpendocBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOpendocBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
