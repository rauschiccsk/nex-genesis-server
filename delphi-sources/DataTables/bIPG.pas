unit bIPG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoGn = 'DoGn';
  ixDocNum = 'DocNum';

type
  TIpgBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str50;         procedure WriteGrpName (pValue:Str50);
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
    function LocateDoGn (pDocNum:Str12;pGrpNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDoGn (pDocNum:Str12;pGrpNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str50 read ReadGrpName write WriteGrpName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TIpgBtr.Create;
begin
  oBtrTable := BtrInit ('IPG',gPath.StkPath,Self);
end;

constructor TIpgBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPG',pPath,Self);
end;

destructor TIpgBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpgBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpgBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpgBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIpgBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIpgBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TIpgBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TIpgBtr.ReadGrpName:Str50;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TIpgBtr.WriteGrpName(pValue:Str50);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TIpgBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpgBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpgBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpgBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpgBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpgBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpgBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpgBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpgBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpgBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpgBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpgBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpgBtr.LocateDoGn (pDocNum:Str12;pGrpNum:word):boolean;
begin
  SetIndex (ixDoGn);
  Result := oBtrTable.FindKey([pDocNum,pGrpNum]);
end;

function TIpgBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIpgBtr.NearestDoGn (pDocNum:Str12;pGrpNum:word):boolean;
begin
  SetIndex (ixDoGn);
  Result := oBtrTable.FindNearest([pDocNum,pGrpNum]);
end;

function TIpgBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TIpgBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpgBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIpgBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpgBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpgBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpgBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpgBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpgBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpgBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpgBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpgBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpgBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpgBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpgBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpgBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpgBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpgBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
