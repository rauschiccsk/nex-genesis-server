unit bPABLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';

type
  TPablstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:word;          procedure WriteBookNum (pValue:word);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadSrchHole:byte;         procedure WriteSrchHole (pValue:byte);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
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
    function LocateBookNum (pBookNum:word):boolean;
    function NearestBookNum (pBookNum:word):boolean;

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
    property BookNum:word read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property SrchHole:byte read ReadSrchHole write WriteSrchHole;
    property Shared:boolean read ReadShared write WriteShared;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPablstBtr.Create;
begin
  oBtrTable := BtrInit ('PABLST',gPath.DlsPath,Self);
end;

constructor TPablstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PABLST',pPath,Self);
end;

destructor TPablstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPablstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPablstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPablstBtr.ReadBookNum:word;
begin
  Result := oBtrTable.FieldByName('BookNum').AsInteger;
end;

procedure TPablstBtr.WriteBookNum(pValue:word);
begin
  oBtrTable.FieldByName('BookNum').AsInteger := pValue;
end;

function TPablstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TPablstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TPablstBtr.ReadSrchHole:byte;
begin
  Result := oBtrTable.FieldByName('SrchHole').AsInteger;
end;

procedure TPablstBtr.WriteSrchHole(pValue:byte);
begin
  oBtrTable.FieldByName('SrchHole').AsInteger := pValue;
end;

function TPablstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TPablstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TPablstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPablstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPablstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPablstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPablstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPablstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPablstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPablstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPablstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPablstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPablstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPablstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPablstBtr.LocateBookNum (pBookNum:word):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TPablstBtr.NearestBookNum (pBookNum:word):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindNearest([pBookNum]);
end;

procedure TPablstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPablstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPablstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPablstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPablstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPablstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPablstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPablstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPablstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPablstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPablstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPablstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPablstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPablstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPablstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPablstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPablstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
