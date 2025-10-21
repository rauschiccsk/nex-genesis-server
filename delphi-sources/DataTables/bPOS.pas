unit bPOS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPosCode = 'PosCode';

type
  TPosBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private 
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
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
    function LocatePosCode (pPosCode:Str15):boolean;
    function NearestPosCode (pPosCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:word);
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
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPosBtr.Create;
begin
  oBtrTable := BtrInit ('POS',gPath.StkPath,Self);
end;

constructor TPosBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('POS',pPath,Self);
end;

destructor TPosBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPosBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPosBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPosBtr.ReadPosCode:Str15;
begin
  Result := oBtrTable.FieldByName('PosCode').AsString;
end;

procedure TPosBtr.WritePosCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PosCode').AsString := pValue;
end;

function TPosBtr.ReadMaxQnt:double;
begin
  Result := oBtrTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TPosBtr.WriteMaxQnt(pValue:double);
begin
  oBtrTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TPosBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPosBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPosBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPosBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPosBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPosBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPosBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPosBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPosBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPosBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPosBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPosBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPosBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPosBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPosBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPosBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPosBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPosBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPosBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPosBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPosBtr.LocatePosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oBtrTable.FindKey([pPosCode]);
end;

function TPosBtr.NearestPosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oBtrTable.FindNearest([pPosCode]);
end;

procedure TPosBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPosBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TPosBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPosBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPosBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPosBtr.First;
begin
  oBtrTable.First;
end;

procedure TPosBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPosBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPosBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPosBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPosBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPosBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPosBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPosBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPosBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPosBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPosBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
