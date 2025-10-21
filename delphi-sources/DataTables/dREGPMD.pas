unit dREGPMD;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegNum = 'RegNum';
  ixReIt = 'ReIt';
  ixReItSmPm = 'ReItSmPm';

type
  TRegPmd = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
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
    procedure DeleteReIt (pRegNum:Str12;pItmNum:word);
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateRegNum (pRegNum:Str12):boolean;
    function LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
    function LocateReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
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

constructor TRegPmd.Create;
begin
  oBtrTable := BtrInit ('REGPMD',gPath.CdwPath,Self);
end;

destructor  TRegPmd.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRegPmd.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRegPmd.ReadRegNum:Str12;
begin
  Result := oBtrTable.FieldByName('RegNum').AsString;
end;

procedure TRegPmd.WriteRegNum(pValue:Str12);
begin
  oBtrTable.FieldByName('RegNum').AsString := pValue;
end;

function TRegPmd.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRegPmd.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRegPmd.ReadRegInd:word;
begin
  Result := oBtrTable.FieldByName('RegInd').AsInteger;
end;

procedure TRegPmd.WriteRegInd(pValue:word);
begin
  oBtrTable.FieldByName('RegInd').AsInteger := pValue;
end;

function TRegPmd.ReadSysMark:Str2;
begin
  Result := oBtrTable.FieldByName('SysMark').AsString;
end;

procedure TRegPmd.WriteSysMark(pValue:Str2);
begin
  oBtrTable.FieldByName('SysMark').AsString := pValue;
end;

function TRegPmd.ReadPmdMark:Str3;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TRegPmd.WritePmdMark(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TRegPmd.ReadPmdName:Str40;
begin
  Result := oBtrTable.FieldByName('PmdName').AsString;
end;

procedure TRegPmd.WritePmdName(pValue:Str40);
begin
  oBtrTable.FieldByName('PmdName').AsString := pValue;
end;

function TRegPmd.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRegPmd.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRegPmd.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRegPmd.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRegPmd.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRegPmd.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

procedure TRegPmd.DeleteReIt (pRegNum:Str12;pItmNum:word);
begin
  While LocateReIt (pRegNum,pItmNum) do Delete;
end;

function TRegPmd.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRegPmd.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRegPmd.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRegPmd.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRegPmd.LocateRegNum (pRegNum:Str12):boolean;
begin
  SetIndex (ixRegNum);
  Result := oBtrTable.FindKey([pRegNum]);
end;

function TRegPmd.LocateReIt (pRegNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixReIt);
  Result := oBtrTable.FindKey([pRegNum,pItmNum]);
end;

function TRegPmd.LocateReItSmPm (pRegNum:Str12;pItmNum:word;pSysMark:Str2;pPmdmark:Str3):boolean;
begin
  SetIndex (ixReItSmPm);
  Result := oBtrTable.FindKey([pRegNum,pItmNum,pSysMark,pPmdmark]);
end;

procedure TRegPmd.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRegPmd.Open;
begin
  oBtrTable.Open;
end;

procedure TRegPmd.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRegPmd.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRegPmd.Next;
begin
  oBtrTable.Next;
end;

procedure TRegPmd.First;
begin
  oBtrTable.First;
end;

procedure TRegPmd.Last;
begin
  oBtrTable.Last;
end;

procedure TRegPmd.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRegPmd.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRegPmd.Post;
begin
  oBtrTable.Post;
end;

procedure TRegPmd.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRegPmd.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRegPmd.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

end.
