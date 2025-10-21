unit bBKUSRG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLnPnBn = 'LnPnBn';

type
  TBkusrgBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadPrgName:Str3;          procedure WritePrgName (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadSetting:Str255;        procedure WriteSetting (pValue:Str255);
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
    function LocateLnPnBn (pLogName:Str8;pPrgName:Str3;pBookNum:Str5):boolean;
    function NearestLnPnBn (pLogName:Str8;pPrgName:Str3;pBookNum:Str5):boolean;

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
    property LogName:Str8 read ReadLogName write WriteLogName;
    property PrgName:Str3 read ReadPrgName write WritePrgName;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property Setting:Str255 read ReadSetting write WriteSetting;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TBkusrgBtr.Create;
begin
  oBtrTable := BtrInit ('BKUSRG',gPath.SysPath,Self);
end;

constructor TBkusrgBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BKUSRG',pPath,Self);
end;

destructor TBkusrgBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBkusrgBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBkusrgBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBkusrgBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TBkusrgBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TBkusrgBtr.ReadPrgName:Str3;
begin
  Result := oBtrTable.FieldByName('PrgName').AsString;
end;

procedure TBkusrgBtr.WritePrgName(pValue:Str3);
begin
  oBtrTable.FieldByName('PrgName').AsString := pValue;
end;

function TBkusrgBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TBkusrgBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TBkusrgBtr.ReadSetting:Str255;
begin
  Result := oBtrTable.FieldByName('Setting').AsString;
end;

procedure TBkusrgBtr.WriteSetting(pValue:Str255);
begin
  oBtrTable.FieldByName('Setting').AsString := pValue;
end;

function TBkusrgBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TBkusrgBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TBkusrgBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TBkusrgBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TBkusrgBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TBkusrgBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TBkusrgBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TBkusrgBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TBkusrgBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBkusrgBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBkusrgBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBkusrgBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBkusrgBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBkusrgBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBkusrgBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBkusrgBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBkusrgBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBkusrgBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBkusrgBtr.LocateLnPnBn (pLogName:Str8;pPrgName:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixLnPnBn);
  Result := oBtrTable.FindKey([pLogName,pPrgName,pBookNum]);
end;

function TBkusrgBtr.NearestLnPnBn (pLogName:Str8;pPrgName:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixLnPnBn);
  Result := oBtrTable.FindNearest([pLogName,pPrgName,pBookNum]);
end;

procedure TBkusrgBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBkusrgBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBkusrgBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBkusrgBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBkusrgBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBkusrgBtr.First;
begin
  oBtrTable.First;
end;

procedure TBkusrgBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBkusrgBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBkusrgBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBkusrgBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBkusrgBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBkusrgBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBkusrgBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBkusrgBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBkusrgBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBkusrgBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBkusrgBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
