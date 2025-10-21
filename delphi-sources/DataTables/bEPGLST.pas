unit bEPGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpgNum = 'EpgNum';
  ixEpgName = 'EpgName';

type
  TEpglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
    function  ReadEpgName:Str60;         procedure WriteEpgName (pValue:Str60);
    function  ReadEpgName_:Str60;        procedure WriteEpgName_ (pValue:Str60);
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
    function LocateEpgNum (pEpgNum:word):boolean;
    function LocateEpgName (pEpgName_:Str60):boolean;
    function NearestEpgNum (pEpgNum:word):boolean;
    function NearestEpgName (pEpgName_:Str60):boolean;

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
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
    property EpgName:Str60 read ReadEpgName write WriteEpgName;
    property EpgName_:Str60 read ReadEpgName_ write WriteEpgName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TEpglstBtr.Create;
begin
  oBtrTable := BtrInit ('EPGLST',gPath.DlsPath,Self);
end;

constructor TEpglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EPGLST',pPath,Self);
end;

destructor TEpglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEpglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEpglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEpglstBtr.ReadEpgNum:word;
begin
  Result := oBtrTable.FieldByName('EpgNum').AsInteger;
end;

procedure TEpglstBtr.WriteEpgNum(pValue:word);
begin
  oBtrTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TEpglstBtr.ReadEpgName:Str60;
begin
  Result := oBtrTable.FieldByName('EpgName').AsString;
end;

procedure TEpglstBtr.WriteEpgName(pValue:Str60);
begin
  oBtrTable.FieldByName('EpgName').AsString := pValue;
end;

function TEpglstBtr.ReadEpgName_:Str60;
begin
  Result := oBtrTable.FieldByName('EpgName_').AsString;
end;

procedure TEpglstBtr.WriteEpgName_(pValue:Str60);
begin
  oBtrTable.FieldByName('EpgName_').AsString := pValue;
end;

function TEpglstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TEpglstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TEpglstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TEpglstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TEpglstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TEpglstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TEpglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TEpglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TEpglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TEpglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TEpglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TEpglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEpglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEpglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEpglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEpglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEpglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEpglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEpglstBtr.LocateEpgNum (pEpgNum:word):boolean;
begin
  SetIndex (ixEpgNum);
  Result := oBtrTable.FindKey([pEpgNum]);
end;

function TEpglstBtr.LocateEpgName (pEpgName_:Str60):boolean;
begin
  SetIndex (ixEpgName);
  Result := oBtrTable.FindKey([StrToAlias(pEpgName_)]);
end;

function TEpglstBtr.NearestEpgNum (pEpgNum:word):boolean;
begin
  SetIndex (ixEpgNum);
  Result := oBtrTable.FindNearest([pEpgNum]);
end;

function TEpglstBtr.NearestEpgName (pEpgName_:Str60):boolean;
begin
  SetIndex (ixEpgName);
  Result := oBtrTable.FindNearest([pEpgName_]);
end;

procedure TEpglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEpglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEpglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEpglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEpglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEpglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TEpglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEpglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEpglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEpglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEpglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEpglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEpglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEpglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEpglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEpglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEpglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
