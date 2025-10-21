unit bITGLOG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSdSi = 'SdSi';
  ixTdTi = 'TdTi';
  ixFrmName = 'FrmName';

type
  TItglogBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadScDocNum:Str12;        procedure WriteScDocNum (pValue:Str12);
    function  ReadScItmNum:word;         procedure WriteScItmNum (pValue:word);
    function  ReadTgDocNum:Str12;        procedure WriteTgDocNum (pValue:Str12);
    function  ReadTgItmNum:word;         procedure WriteTgItmNum (pValue:word);
    function  ReadFrmName:Str15;         procedure WriteFrmName (pValue:Str15);
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
    function LocateSdSi (pScDocNum:Str12;pScItmNum:word):boolean;
    function LocateTdTi (pTgDocNum:Str12;pTgItmNum:word):boolean;
    function LocateFrmName (pFrmName:Str15):boolean;
    function NearestSdSi (pScDocNum:Str12;pScItmNum:word):boolean;
    function NearestTdTi (pTgDocNum:Str12;pTgItmNum:word):boolean;
    function NearestFrmName (pFrmName:Str15):boolean;

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
    property ScDocNum:Str12 read ReadScDocNum write WriteScDocNum;
    property ScItmNum:word read ReadScItmNum write WriteScItmNum;
    property TgDocNum:Str12 read ReadTgDocNum write WriteTgDocNum;
    property TgItmNum:word read ReadTgItmNum write WriteTgItmNum;
    property FrmName:Str15 read ReadFrmName write WriteFrmName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TItglogBtr.Create;
begin
  oBtrTable := BtrInit ('ITGLOG',gPath.SysPath,Self);
end;

constructor TItglogBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ITGLOG',pPath,Self);
end;

destructor TItglogBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TItglogBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TItglogBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TItglogBtr.ReadScDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScDocNum').AsString;
end;

procedure TItglogBtr.WriteScDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScDocNum').AsString := pValue;
end;

function TItglogBtr.ReadScItmNum:word;
begin
  Result := oBtrTable.FieldByName('ScItmNum').AsInteger;
end;

procedure TItglogBtr.WriteScItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ScItmNum').AsInteger := pValue;
end;

function TItglogBtr.ReadTgDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('TgDocNum').AsString;
end;

procedure TItglogBtr.WriteTgDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TgDocNum').AsString := pValue;
end;

function TItglogBtr.ReadTgItmNum:word;
begin
  Result := oBtrTable.FieldByName('TgItmNum').AsInteger;
end;

procedure TItglogBtr.WriteTgItmNum(pValue:word);
begin
  oBtrTable.FieldByName('TgItmNum').AsInteger := pValue;
end;

function TItglogBtr.ReadFrmName:Str15;
begin
  Result := oBtrTable.FieldByName('FrmName').AsString;
end;

procedure TItglogBtr.WriteFrmName(pValue:Str15);
begin
  oBtrTable.FieldByName('FrmName').AsString := pValue;
end;

function TItglogBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TItglogBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TItglogBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TItglogBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TItglogBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TItglogBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TItglogBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TItglogBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TItglogBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TItglogBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TItglogBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TItglogBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TItglogBtr.LocateSdSi (pScDocNum:Str12;pScItmNum:word):boolean;
begin
  SetIndex (ixSdSi);
  Result := oBtrTable.FindKey([pScDocNum,pScItmNum]);
end;

function TItglogBtr.LocateTdTi (pTgDocNum:Str12;pTgItmNum:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindKey([pTgDocNum,pTgItmNum]);
end;

function TItglogBtr.LocateFrmName (pFrmName:Str15):boolean;
begin
  SetIndex (ixFrmName);
  Result := oBtrTable.FindKey([pFrmName]);
end;

function TItglogBtr.NearestSdSi (pScDocNum:Str12;pScItmNum:word):boolean;
begin
  SetIndex (ixSdSi);
  Result := oBtrTable.FindNearest([pScDocNum,pScItmNum]);
end;

function TItglogBtr.NearestTdTi (pTgDocNum:Str12;pTgItmNum:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindNearest([pTgDocNum,pTgItmNum]);
end;

function TItglogBtr.NearestFrmName (pFrmName:Str15):boolean;
begin
  SetIndex (ixFrmName);
  Result := oBtrTable.FindNearest([pFrmName]);
end;

procedure TItglogBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TItglogBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TItglogBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TItglogBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TItglogBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TItglogBtr.First;
begin
  oBtrTable.First;
end;

procedure TItglogBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TItglogBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TItglogBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TItglogBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TItglogBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TItglogBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TItglogBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TItglogBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TItglogBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TItglogBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TItglogBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
