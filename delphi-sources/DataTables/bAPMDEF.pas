unit bAPMDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';
  ixGrPm = 'GrPm';

type
  TApmdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadPmdMark:Str6;          procedure WritePmdMark (pValue:Str6);
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
    function LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;
    function NearestGrPm (pGrpNum:word;pPmdMark:Str6):boolean;

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
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TApmdefBtr.Create;
begin
  oBtrTable := BtrInit ('APMDEF',gPath.SysPath,Self);
end;

constructor TApmdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APMDEF',pPath,Self);
end;

destructor TApmdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TApmdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TApmdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TApmdefBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TApmdefBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TApmdefBtr.ReadPmdMark:Str6;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TApmdefBtr.WritePmdMark(pValue:Str6);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TApmdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TApmdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TApmdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TApmdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TApmdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TApmdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TApmdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApmdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TApmdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApmdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TApmdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TApmdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TApmdefBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TApmdefBtr.LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindKey([pGrpNum,pPmdMark]);
end;

function TApmdefBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TApmdefBtr.NearestGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindNearest([pGrpNum,pPmdMark]);
end;

procedure TApmdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TApmdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TApmdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TApmdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TApmdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TApmdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TApmdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TApmdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TApmdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TApmdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TApmdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TApmdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TApmdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TApmdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TApmdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TApmdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TApmdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
