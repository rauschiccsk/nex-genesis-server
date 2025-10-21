unit bSYSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSysMark = 'SysMark';
  ixSysName_ = 'SysName_';

type
  TSyslstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSysMark:Str2;          procedure WriteSysMark (pValue:Str2);
    function  ReadSysName:Str30;         procedure WriteSysName (pValue:Str30);
    function  ReadSysName_:Str30;        procedure WriteSysName_ (pValue:Str30);
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
    function LocateSysMark (pSysMark:Str2):boolean;
    function LocateSysName_ (pSysName_:Str30):boolean;
    function NearestSysMark (pSysMark:Str2):boolean;
    function NearestSysName_ (pSysName_:Str30):boolean;

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
    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property SysName:Str30 read ReadSysName write WriteSysName;
    property SysName_:Str30 read ReadSysName_ write WriteSysName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSyslstBtr.Create;
begin
  oBtrTable := BtrInit ('SYSLST',gPath.SysPath,Self);
end;

constructor TSyslstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SYSLST',pPath,Self);
end;

destructor TSyslstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSyslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSyslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSyslstBtr.ReadSysMark:Str2;
begin
  Result := oBtrTable.FieldByName('SysMark').AsString;
end;

procedure TSyslstBtr.WriteSysMark(pValue:Str2);
begin
  oBtrTable.FieldByName('SysMark').AsString := pValue;
end;

function TSyslstBtr.ReadSysName:Str30;
begin
  Result := oBtrTable.FieldByName('SysName').AsString;
end;

procedure TSyslstBtr.WriteSysName(pValue:Str30);
begin
  oBtrTable.FieldByName('SysName').AsString := pValue;
end;

function TSyslstBtr.ReadSysName_:Str30;
begin
  Result := oBtrTable.FieldByName('SysName_').AsString;
end;

procedure TSyslstBtr.WriteSysName_(pValue:Str30);
begin
  oBtrTable.FieldByName('SysName_').AsString := pValue;
end;

function TSyslstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSyslstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSyslstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSyslstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSyslstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSyslstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSyslstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSyslstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSyslstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSyslstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSyslstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSyslstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSyslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSyslstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSyslstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSyslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSyslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSyslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSyslstBtr.LocateSysMark (pSysMark:Str2):boolean;
begin
  SetIndex (ixSysMark);
  Result := oBtrTable.FindKey([pSysMark]);
end;

function TSyslstBtr.LocateSysName_ (pSysName_:Str30):boolean;
begin
  SetIndex (ixSysName_);
  Result := oBtrTable.FindKey([StrToAlias(pSysName_)]);
end;

function TSyslstBtr.NearestSysMark (pSysMark:Str2):boolean;
begin
  SetIndex (ixSysMark);
  Result := oBtrTable.FindNearest([pSysMark]);
end;

function TSyslstBtr.NearestSysName_ (pSysName_:Str30):boolean;
begin
  SetIndex (ixSysName_);
  Result := oBtrTable.FindNearest([pSysName_]);
end;

procedure TSyslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSyslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSyslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSyslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSyslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSyslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSyslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSyslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSyslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSyslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSyslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSyslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSyslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSyslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSyslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSyslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSyslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
