unit bOSGREM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOutStk = 'OutStk';
  ixIncStk = 'IncStk';
  ixOnOi = 'OnOi';

type
  TOsgremBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOutStk:word;           procedure WriteOutStk (pValue:word);
    function  ReadIncStk:word;           procedure WriteIncStk (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
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
    function LocateOutStk (pOutStk:word):boolean;
    function LocateIncStk (pIncStk:word):boolean;
    function LocateOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
    function NearestOutStk (pOutStk:word):boolean;
    function NearestIncStk (pIncStk:word):boolean;
    function NearestOnOi (pOsdNum:Str12;pOsdItm:word):boolean;

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
    property OutStk:word read ReadOutStk write WriteOutStk;
    property IncStk:word read ReadIncStk write WriteIncStk;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TOsgremBtr.Create;
begin
  oBtrTable := BtrInit ('OSGREM',gPath.StkPath,Self);
end;

constructor TOsgremBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OSGREM',pPath,Self);
end;

destructor TOsgremBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOsgremBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOsgremBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOsgremBtr.ReadOutStk:word;
begin
  Result := oBtrTable.FieldByName('OutStk').AsInteger;
end;

procedure TOsgremBtr.WriteOutStk(pValue:word);
begin
  oBtrTable.FieldByName('OutStk').AsInteger := pValue;
end;

function TOsgremBtr.ReadIncStk:word;
begin
  Result := oBtrTable.FieldByName('IncStk').AsInteger;
end;

procedure TOsgremBtr.WriteIncStk(pValue:word);
begin
  oBtrTable.FieldByName('IncStk').AsInteger := pValue;
end;

function TOsgremBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOsgremBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOsgremBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TOsgremBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TOsgremBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TOsgremBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TOsgremBtr.ReadOsdItm:word;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOsgremBtr.WriteOsdItm(pValue:word);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TOsgremBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOsgremBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOsgremBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOsgremBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOsgremBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOsgremBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsgremBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOsgremBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOsgremBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOsgremBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOsgremBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOsgremBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOsgremBtr.LocateOutStk (pOutStk:word):boolean;
begin
  SetIndex (ixOutStk);
  Result := oBtrTable.FindKey([pOutStk]);
end;

function TOsgremBtr.LocateIncStk (pIncStk:word):boolean;
begin
  SetIndex (ixIncStk);
  Result := oBtrTable.FindKey([pIncStk]);
end;

function TOsgremBtr.LocateOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindKey([pOsdNum,pOsdItm]);
end;

function TOsgremBtr.NearestOutStk (pOutStk:word):boolean;
begin
  SetIndex (ixOutStk);
  Result := oBtrTable.FindNearest([pOutStk]);
end;

function TOsgremBtr.NearestIncStk (pIncStk:word):boolean;
begin
  SetIndex (ixIncStk);
  Result := oBtrTable.FindNearest([pIncStk]);
end;

function TOsgremBtr.NearestOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindNearest([pOsdNum,pOsdItm]);
end;

procedure TOsgremBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOsgremBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TOsgremBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOsgremBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOsgremBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOsgremBtr.First;
begin
  oBtrTable.First;
end;

procedure TOsgremBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOsgremBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOsgremBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOsgremBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOsgremBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOsgremBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOsgremBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOsgremBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOsgremBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOsgremBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOsgremBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
