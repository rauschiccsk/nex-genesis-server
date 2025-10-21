unit bREGPMD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixReIt = 'ReIt';
  ixReItRi = 'ReItRi';
  ixReItSmPm = 'ReItSmPm';

type
  TRegpmdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRegNum:Str12;          procedure WriteRegNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadRegInd:word;           procedure WriteRegInd (pValue:word);
    function  ReadSysMark:Str2;          procedure WriteSysMark (pValue:Str2);
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadPmdName:Str40;         procedure WritePmdName (pValue:Str40);
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
    function LocateRegNum (pRegNum:Str12):boolean;
    function LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
    function LocateReItRi (pRegNum:Str12;pItmNum:word;pRegInd:word):boolean;
    function LocateReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;
    function NearestRegNum (pRegNum:Str12):boolean;
    function NearestReIt (pRegNum:Str12;pItmNum:word):boolean;
    function NearestReItRi (pRegNum:Str12;pItmNum:word;pRegInd:word):boolean;
    function NearestReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;

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
    property RegInd:word read ReadRegInd write WriteRegInd;
    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property PmdName:Str40 read ReadPmdName write WritePmdName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TRegpmdBtr.Create;
begin
  oBtrTable := BtrInit ('REGPMD',gPath.CdwPath,Self);
end;

constructor TRegpmdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('REGPMD',pPath,Self);
end;

destructor TRegpmdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegpmdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegpmdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRegpmdBtr.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

procedure TRegpmdBtr.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

function TRegpmdBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRegpmdBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRegpmdBtr.ReadRegInd:word;
begin
  Result := oBtrTable.FieldByName('RegInd').AsInteger;
end;

procedure TRegpmdBtr.WriteRegInd(pValue:word);
begin
  oBtrTable.FieldByName('RegInd').AsInteger := pValue;
end;

function TRegpmdBtr.ReadSysMark:Str2;
begin
  Result := oBtrTable.FieldByName('SysMark').AsString;
end;

procedure TRegpmdBtr.WriteSysMark(pValue:Str2);
begin
  oBtrTable.FieldByName('SysMark').AsString := pValue;
end;

function TRegpmdBtr.ReadPmdMark:Str3;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TRegpmdBtr.WritePmdMark(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TRegpmdBtr.ReadPmdName:Str40;
begin
  Result := oBtrTable.FieldByName('PmdName').AsString;
end;

procedure TRegpmdBtr.WritePmdName(pValue:Str40);
begin
  oBtrTable.FieldByName('PmdName').AsString := pValue;
end;

function TRegpmdBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRegpmdBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRegpmdBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRegpmdBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRegpmdBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRegpmdBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegpmdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegpmdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRegpmdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegpmdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRegpmdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRegpmdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRegpmdBtr.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegpmdBtr.LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixReIt);
  Result := oBtrTable.FindKey([pRegNum,pItmNum]);
end;

function TRegpmdBtr.LocateReItRi (pRegNum:Str12;pItmNum:word;pRegInd:word):boolean;
begin
  SetIndex (ixReItRi);
  Result := oBtrTable.FindKey([pRegNum,pItmNum,pRegInd]);
end;

function TRegpmdBtr.LocateReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;
begin
  SetIndex (ixReItSmPm);
  Result := oBtrTable.FindKey([pRegNum,pItmNum,pSysMark,pPmdmark]);
end;

function TRegpmdBtr.NearestRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindNearest([pRegNum]);
end;

function TRegpmdBtr.NearestReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixReIt);
  Result := oBtrTable.FindNearest([pRegNum,pItmNum]);
end;

function TRegpmdBtr.NearestReItRi (pRegNum:Str12;pItmNum:word;pRegInd:word):boolean;
begin
  SetIndex (ixReItRi);
  Result := oBtrTable.FindNearest([pRegNum,pItmNum,pRegInd]);
end;

function TRegpmdBtr.NearestReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;
begin
  SetIndex (ixReItSmPm);
  Result := oBtrTable.FindNearest([pRegNum,pItmNum,pSysMark,pPmdmark]);
end;

procedure TRegpmdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegpmdBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRegpmdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRegpmdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegpmdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRegpmdBtr.First;
begin
  oBtrTable.First;
end;

procedure TRegpmdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRegpmdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegpmdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegpmdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRegpmdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegpmdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegpmdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRegpmdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRegpmdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRegpmdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRegpmdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
