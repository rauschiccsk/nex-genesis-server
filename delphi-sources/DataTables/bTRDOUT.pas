unit bTRDOUT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum = 'ExtNum';

type
  TTrdoutBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
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
    function LocateExtNum (pExtNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;

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
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TTrdoutBtr.Create;
begin
  oBtrTable := BtrInit ('TRDOUT',gPath.StkPath,Self);
end;

constructor TTrdoutBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TRDOUT',pPath,Self);
end;

destructor TTrdoutBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTrdoutBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTrdoutBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTrdoutBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTrdoutBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTrdoutBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTrdoutBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTrdoutBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTrdoutBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTrdoutBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTrdoutBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTrdoutBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTrdoutBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTrdoutBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTrdoutBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrdoutBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrdoutBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTrdoutBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrdoutBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTrdoutBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTrdoutBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTrdoutBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TTrdoutBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

procedure TTrdoutBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTrdoutBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTrdoutBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTrdoutBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTrdoutBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTrdoutBtr.First;
begin
  oBtrTable.First;
end;

procedure TTrdoutBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTrdoutBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTrdoutBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTrdoutBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTrdoutBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTrdoutBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTrdoutBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTrdoutBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTrdoutBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTrdoutBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTrdoutBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
