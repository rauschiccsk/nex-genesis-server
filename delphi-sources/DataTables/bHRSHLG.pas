unit bHRSHLG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixRoomNum = 'RoomNum';
  ixRoomCode = 'RoomCode';
  ixRnPd = 'RnPd';

type
  THrshlgBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
    function  ReadPrcDate:TDatetime;     procedure WritePrcDate (pValue:TDatetime);
    function  ReadPrcTime:TDatetime;     procedure WritePrcTime (pValue:TDatetime);
    function  ReadPrcType:Str1;          procedure WritePrcType (pValue:Str1);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
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
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateRoomCode (pRoomCode:Str15):boolean;
    function LocateRnPd (pRoomNum:longint;pPrcDate:TDatetime):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestRoomNum (pRoomNum:longint):boolean;
    function NearestRoomCode (pRoomCode:Str15):boolean;
    function NearestRnPd (pRoomNum:longint;pPrcDate:TDatetime):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
    property PrcDate:TDatetime read ReadPrcDate write WritePrcDate;
    property PrcTime:TDatetime read ReadPrcTime write WritePrcTime;
    property PrcType:Str1 read ReadPrcType write WritePrcType;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor THrshlgBtr.Create;
begin
  oBtrTable := BtrInit ('HRSHLG',gPath.HtlPath,Self);
end;

constructor THrshlgBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('HRSHLG',pPath,Self);
end;

destructor THrshlgBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function THrshlgBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function THrshlgBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function THrshlgBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure THrshlgBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function THrshlgBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure THrshlgBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function THrshlgBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure THrshlgBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function THrshlgBtr.ReadPrcDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('PrcDate').AsDateTime;
end;

procedure THrshlgBtr.WritePrcDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PrcDate').AsDateTime := pValue;
end;

function THrshlgBtr.ReadPrcTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('PrcTime').AsDateTime;
end;

procedure THrshlgBtr.WritePrcTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('PrcTime').AsDateTime := pValue;
end;

function THrshlgBtr.ReadPrcType:Str1;
begin
  Result := oBtrTable.FieldByName('PrcType').AsString;
end;

procedure THrshlgBtr.WritePrcType(pValue:Str1);
begin
  oBtrTable.FieldByName('PrcType').AsString := pValue;
end;

function THrshlgBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure THrshlgBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function THrshlgBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure THrshlgBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function THrshlgBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure THrshlgBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function THrshlgBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure THrshlgBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function THrshlgBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure THrshlgBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function THrshlgBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure THrshlgBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function THrshlgBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure THrshlgBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function THrshlgBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function THrshlgBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function THrshlgBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function THrshlgBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function THrshlgBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function THrshlgBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function THrshlgBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function THrshlgBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function THrshlgBtr.LocateRoomCode (pRoomCode:Str15):boolean;
begin
  SetIndex (ixRoomCode);
  Result := oBtrTable.FindKey([pRoomCode]);
end;

function THrshlgBtr.LocateRnPd (pRoomNum:longint;pPrcDate:TDatetime):boolean;
begin
  SetIndex (ixRnPd);
  Result := oBtrTable.FindKey([pRoomNum,pPrcDate]);
end;

function THrshlgBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function THrshlgBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function THrshlgBtr.NearestRoomCode (pRoomCode:Str15):boolean;
begin
  SetIndex (ixRoomCode);
  Result := oBtrTable.FindNearest([pRoomCode]);
end;

function THrshlgBtr.NearestRnPd (pRoomNum:longint;pPrcDate:TDatetime):boolean;
begin
  SetIndex (ixRnPd);
  Result := oBtrTable.FindNearest([pRoomNum,pPrcDate]);
end;

procedure THrshlgBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure THrshlgBtr.Open;
begin
  oBtrTable.Open;
end;

procedure THrshlgBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure THrshlgBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure THrshlgBtr.Next;
begin
  oBtrTable.Next;
end;

procedure THrshlgBtr.First;
begin
  oBtrTable.First;
end;

procedure THrshlgBtr.Last;
begin
  oBtrTable.Last;
end;

procedure THrshlgBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure THrshlgBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure THrshlgBtr.Post;
begin
  oBtrTable.Post;
end;

procedure THrshlgBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure THrshlgBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure THrshlgBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure THrshlgBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure THrshlgBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure THrshlgBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure THrshlgBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
