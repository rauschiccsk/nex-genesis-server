unit bTRDINC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum = 'ExtNum';

type
  TTrdincBtr = class (TComponent)
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
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateExtNum (pExtNum:Str12):boolean;

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
  end;

implementation

constructor TTrdincBtr.Create;
begin
  oBtrTable := BtrInit ('TRDINC',gPath.StkPath,Self);
end;

constructor TTrdincBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TRDINC',pPath,Self);
end;

destructor TTrdincBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTrdincBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTrdincBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTrdincBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTrdincBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTrdincBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTrdincBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTrdincBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTrdincBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrdincBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrdincBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTrdincBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTrdincBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTrdincBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

procedure TTrdincBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTrdincBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTrdincBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTrdincBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTrdincBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTrdincBtr.First;
begin
  oBtrTable.First;
end;

procedure TTrdincBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTrdincBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTrdincBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTrdincBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTrdincBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTrdincBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTrdincBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTrdincBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTrdincBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTrdincBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTrdincBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
