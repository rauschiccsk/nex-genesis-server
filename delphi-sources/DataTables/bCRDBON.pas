unit bCRDBON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrdNum = 'CrdNum';
  ixSerNum = 'SerNum';
  ixOutDate = 'OutDate';

type
  TCrdbonBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadOutDate:TDatetime;     procedure WriteOutDate (pValue:TDatetime);
    function  ReadOutQnt:word;           procedure WriteOutQnt (pValue:word);
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
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateOutDate (pOutDate:TDatetime):boolean;
    function NearestCrdNum (pCrdNum:Str20):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestOutDate (pOutDate:TDatetime):boolean;

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
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property OutDate:TDatetime read ReadOutDate write WriteOutDate;
    property OutQnt:word read ReadOutQnt write WriteOutQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TCrdbonBtr.Create;
begin
  oBtrTable := BtrInit ('CRDBON',gPath.DlsPath,Self);
end;

constructor TCrdbonBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRDBON',pPath,Self);
end;

destructor TCrdbonBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdbonBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrdbonBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrdbonBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdbonBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCrdbonBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TCrdbonBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCrdbonBtr.ReadOutDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDate').AsDateTime;
end;

procedure TCrdbonBtr.WriteOutDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDate').AsDateTime := pValue;
end;

function TCrdbonBtr.ReadOutQnt:word;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsInteger;
end;

procedure TCrdbonBtr.WriteOutQnt(pValue:word);
begin
  oBtrTable.FieldByName('OutQnt').AsInteger := pValue;
end;

function TCrdbonBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdbonBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdbonBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdbonBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdbonBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdbonBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdbonBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdbonBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrdbonBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdbonBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrdbonBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrdbonBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrdbonBtr.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindKey([pCrdNum]);
end;

function TCrdbonBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TCrdbonBtr.LocateOutDate (pOutDate:TDatetime):boolean;
begin
  SetIndex (ixOutDate);
  Result := oBtrTable.FindKey([pOutDate]);
end;

function TCrdbonBtr.NearestCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindNearest([pCrdNum]);
end;

function TCrdbonBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TCrdbonBtr.NearestOutDate (pOutDate:TDatetime):boolean;
begin
  SetIndex (ixOutDate);
  Result := oBtrTable.FindNearest([pOutDate]);
end;

procedure TCrdbonBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrdbonBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrdbonBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrdbonBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrdbonBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrdbonBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrdbonBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrdbonBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrdbonBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrdbonBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrdbonBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrdbonBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrdbonBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrdbonBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrdbonBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrdbonBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrdbonBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
