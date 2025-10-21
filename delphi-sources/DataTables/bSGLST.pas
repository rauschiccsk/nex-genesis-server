unit bSGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSgCode = 'SgCode';
  ixSgName = 'SgName';

type
  TSglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSgCode:longint;        procedure WriteSgCode (pValue:longint);
    function  ReadSgName:Str50;          procedure WriteSgName (pValue:Str50);
    function  ReadSgName_:Str50;         procedure WriteSgName_ (pValue:Str50);
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
    function LocateSgCode (pSgCode:longint):boolean;
    function LocateSgName (pSgName_:Str50):boolean;
    function NearestSgCode (pSgCode:longint):boolean;
    function NearestSgName (pSgName_:Str50):boolean;

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
    property SgCode:longint read ReadSgCode write WriteSgCode;
    property SgName:Str50 read ReadSgName write WriteSgName;
    property SgName_:Str50 read ReadSgName_ write WriteSgName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSglstBtr.Create;
begin
  oBtrTable := BtrInit ('SGLST',gPath.StkPath,Self);
end;

constructor TSglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SGLST',pPath,Self);
end;

destructor TSglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSglstBtr.ReadSgCode:longint;
begin
  Result := oBtrTable.FieldByName('SgCode').AsInteger;
end;

procedure TSglstBtr.WriteSgCode(pValue:longint);
begin
  oBtrTable.FieldByName('SgCode').AsInteger := pValue;
end;

function TSglstBtr.ReadSgName:Str50;
begin
  Result := oBtrTable.FieldByName('SgName').AsString;
end;

procedure TSglstBtr.WriteSgName(pValue:Str50);
begin
  oBtrTable.FieldByName('SgName').AsString := pValue;
end;

function TSglstBtr.ReadSgName_:Str50;
begin
  Result := oBtrTable.FieldByName('SgName_').AsString;
end;

procedure TSglstBtr.WriteSgName_(pValue:Str50);
begin
  oBtrTable.FieldByName('SgName_').AsString := pValue;
end;

function TSglstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSglstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSglstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSglstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSglstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSglstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSglstBtr.LocateSgCode (pSgCode:longint):boolean;
begin
  SetIndex (ixSgCode);
  Result := oBtrTable.FindKey([pSgCode]);
end;

function TSglstBtr.LocateSgName (pSgName_:Str50):boolean;
begin
  SetIndex (ixSgName);
  Result := oBtrTable.FindKey([StrToAlias(pSgName_)]);
end;

function TSglstBtr.NearestSgCode (pSgCode:longint):boolean;
begin
  SetIndex (ixSgCode);
  Result := oBtrTable.FindNearest([pSgCode]);
end;

function TSglstBtr.NearestSgName (pSgName_:Str50):boolean;
begin
  SetIndex (ixSgName);
  Result := oBtrTable.FindNearest([pSgName_]);
end;

procedure TSglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
