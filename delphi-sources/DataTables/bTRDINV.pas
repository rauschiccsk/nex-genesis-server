unit bTrdinv;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum = 'ExtNum';

type
  TTrdinvBtr = class (TComponent)
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

constructor TTrdinvBtr.Create;
begin
  oBtrTable := BtrInit ('TRDINV',gPath.StkPath,Self);
end;

constructor TTrdinvBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TRDINV',pPath,Self);
end;

destructor TTrdinvBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTrdinvBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTrdinvBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTrdinvBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTrdinvBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTrdinvBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTrdinvBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTrdinvBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTrdinvBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrdinvBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrdinvBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTrdinvBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTrdinvBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTrdinvBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

procedure TTrdinvBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTrdinvBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTrdinvBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTrdinvBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTrdinvBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTrdinvBtr.First;
begin
  oBtrTable.First;
end;

procedure TTrdinvBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTrdinvBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTrdinvBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTrdinvBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTrdinvBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTrdinvBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTrdinvBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTrdinvBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTrdinvBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTrdinvBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTrdinvBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
