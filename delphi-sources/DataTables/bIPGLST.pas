unit bIPGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';

type
  TIpglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str50;         procedure WriteGrpName (pValue:Str50);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str50 read ReadGrpName write WriteGrpName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIpglstBtr.Create;
begin
  oBtrTable := BtrInit ('IPGLST',gPath.StkPath,Self);
end;

constructor TIpglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPGLST',pPath,Self);
end;

destructor TIpglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpglstBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TIpglstBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TIpglstBtr.ReadGrpName:Str50;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TIpglstBtr.WriteGrpName(pValue:Str50);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TIpglstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpglstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpglstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpglstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpglstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpglstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIpglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIpglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIpglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIpglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIpglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpglstBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TIpglstBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

procedure TIpglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIpglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
