unit bREGITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixReIt = 'ReIt';
  ixReSt = 'ReSt';

type
  TRegitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRegNum:Str12;          procedure WriteRegNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadSysVer:byte;           procedure WriteSysVer (pValue:byte);
    function  ReadWrsQnt:word;           procedure WriteWrsQnt (pValue:word);
    function  ReadCasQnt:byte;           procedure WriteCasQnt (pValue:byte);
    function  ReadUsfQnt:byte;           procedure WriteUsfQnt (pValue:byte);
    function  ReadPrsQnt:word;           procedure WritePrsQnt (pValue:word);
    function  ReadCrdQnt:word;           procedure WriteCrdQnt (pValue:word);
    function  ReadRegDate:TDatetime;     procedure WriteRegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
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
    function LocateRegNum (pRegNum:Str12):boolean;
    function LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
    function LocateReSt (pRegNum:Str12;pStatus:Str1):boolean;
    function NearestRegNum (pRegNum:Str12):boolean;
    function NearestReIt (pRegNum:Str12;pItmNum:word):boolean;
    function NearestReSt (pRegNum:Str12;pStatus:Str1):boolean;

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
    property RegNum:Str12 read ReadRegNum write WriteRegNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property SysVer:byte read ReadSysVer write WriteSysVer;
    property WrsQnt:word read ReadWrsQnt write WriteWrsQnt;
    property CasQnt:byte read ReadCasQnt write WriteCasQnt;
    property UsfQnt:byte read ReadUsfQnt write WriteUsfQnt;
    property PrsQnt:word read ReadPrsQnt write WritePrsQnt;
    property CrdQnt:word read ReadCrdQnt write WriteCrdQnt;
    property RegDate:TDatetime read ReadRegDate write WriteRegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRegitmBtr.Create;
begin
  oBtrTable := BtrInit ('REGITM',gPath.CdwPath,Self);
end;

constructor TRegitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('REGITM',pPath,Self);
end;

destructor TRegitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRegitmBtr.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

procedure TRegitmBtr.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

function TRegitmBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRegitmBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRegitmBtr.ReadSysVer:byte;
begin
  Result := oBtrTable.FieldByName('SysVer').AsInteger;
end;

procedure TRegitmBtr.WriteSysVer(pValue:byte);
begin
  oBtrTable.FieldByName('SysVer').AsInteger := pValue;
end;

function TRegitmBtr.ReadWrsQnt:word;
begin
  Result := oBtrTable.FieldByName('WrsQnt').AsInteger;
end;

procedure TRegitmBtr.WriteWrsQnt(pValue:word);
begin
  oBtrTable.FieldByName('WrsQnt').AsInteger := pValue;
end;

function TRegitmBtr.ReadCasQnt:byte;
begin
  Result := oBtrTable.FieldByName('CasQnt').AsInteger;
end;

procedure TRegitmBtr.WriteCasQnt(pValue:byte);
begin
  oBtrTable.FieldByName('CasQnt').AsInteger := pValue;
end;

function TRegitmBtr.ReadUsfQnt:byte;
begin
  Result := oBtrTable.FieldByName('UsfQnt').AsInteger;
end;

procedure TRegitmBtr.WriteUsfQnt(pValue:byte);
begin
  oBtrTable.FieldByName('UsfQnt').AsInteger := pValue;
end;

function TRegitmBtr.ReadPrsQnt:word;
begin
  Result := oBtrTable.FieldByName('PrsQnt').AsInteger;
end;

procedure TRegitmBtr.WritePrsQnt(pValue:word);
begin
  oBtrTable.FieldByName('PrsQnt').AsInteger := pValue;
end;

function TRegitmBtr.ReadCrdQnt:word;
begin
  Result := oBtrTable.FieldByName('CrdQnt').AsInteger;
end;

procedure TRegitmBtr.WriteCrdQnt(pValue:word);
begin
  oBtrTable.FieldByName('CrdQnt').AsInteger := pValue;
end;

function TRegitmBtr.ReadRegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegDate').AsDateTime;
end;

procedure TRegitmBtr.WriteRegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TRegitmBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TRegitmBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TRegitmBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TRegitmBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TRegitmBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TRegitmBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TRegitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRegitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRegitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRegitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRegitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRegitmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRegitmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRegitmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRegitmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRegitmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRegitmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRegitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRegitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRegitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRegitmBtr.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegitmBtr.LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixReIt);
  Result := oBtrTable.FindKey([pRegNum,pItmNum]);
end;

function TRegitmBtr.LocateReSt (pRegNum:Str12;pStatus:Str1):boolean;
begin
  SetIndex (ixReSt);
  Result := oBtrTable.FindKey([pRegNum,pStatus]);
end;

function TRegitmBtr.NearestRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindNearest([pRegNum]);
end;

function TRegitmBtr.NearestReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixReIt);
  Result := oBtrTable.FindNearest([pRegNum,pItmNum]);
end;

function TRegitmBtr.NearestReSt (pRegNum:Str12;pStatus:Str1):boolean;
begin
  SetIndex (ixReSt);
  Result := oBtrTable.FindNearest([pRegNum,pStatus]);
end;

procedure TRegitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRegitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRegitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRegitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TRegitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRegitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRegitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRegitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRegitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRegitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRegitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
