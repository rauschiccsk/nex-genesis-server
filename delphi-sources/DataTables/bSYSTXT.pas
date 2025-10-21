unit bSYSTXT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixKeyVal = 'KeyVal';
  ixTxtVal = 'TxtVal';

type
  TSystxtBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadKeyVal:Str20;          procedure WriteKeyVal (pValue:Str20);
    function  ReadTxtVal:Str250;         procedure WriteTxtVal (pValue:Str250);
    function  ReadTxtLen:byte;           procedure WriteTxtLen (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateKeyVal (pKeyVal:Str20):boolean;
    function LocateTxtVal (pTxtVal:Str250):boolean;
    function NearestKeyVal (pKeyVal:Str20):boolean;
    function NearestTxtVal (pTxtVal:Str250):boolean;

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
    property KeyVal:Str20 read ReadKeyVal write WriteKeyVal;
    property TxtVal:Str250 read ReadTxtVal write WriteTxtVal;
    property TxtLen:byte read ReadTxtLen write WriteTxtLen;
  end;

implementation

constructor TSystxtBtr.Create;
begin
  oBtrTable := BtrInit ('SYSTXT',gPath.SysPath,Self);
end;

constructor TSystxtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SYSTXT',pPath,Self);
end;

destructor TSystxtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSystxtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSystxtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSystxtBtr.ReadKeyVal:Str20;
begin
  Result := oBtrTable.FieldByName('KeyVal').AsString;
end;

procedure TSystxtBtr.WriteKeyVal(pValue:Str20);
begin
  oBtrTable.FieldByName('KeyVal').AsString := pValue;
end;

function TSystxtBtr.ReadTxtVal:Str250;
begin
  Result := oBtrTable.FieldByName('TxtVal').AsString;
end;

procedure TSystxtBtr.WriteTxtVal(pValue:Str250);
begin
  oBtrTable.FieldByName('TxtVal').AsString := pValue;
end;

function TSystxtBtr.ReadTxtLen:byte;
begin
  Result := oBtrTable.FieldByName('TxtLen').AsInteger;
end;

procedure TSystxtBtr.WriteTxtLen(pValue:byte);
begin
  oBtrTable.FieldByName('TxtLen').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSystxtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSystxtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSystxtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSystxtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSystxtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSystxtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSystxtBtr.LocateKeyVal (pKeyVal:Str20):boolean;
begin
  SetIndex (ixKeyVal);
  Result := oBtrTable.FindKey([pKeyVal]);
end;

function TSystxtBtr.LocateTxtVal (pTxtVal:Str250):boolean;
begin
  SetIndex (ixTxtVal);
  Result := oBtrTable.FindKey([pTxtVal]);
end;

function TSystxtBtr.NearestKeyVal (pKeyVal:Str20):boolean;
begin
  SetIndex (ixKeyVal);
  Result := oBtrTable.FindNearest([pKeyVal]);
end;

function TSystxtBtr.NearestTxtVal (pTxtVal:Str250):boolean;
begin
  SetIndex (ixTxtVal);
  Result := oBtrTable.FindNearest([pTxtVal]);
end;

procedure TSystxtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSystxtBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSystxtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSystxtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSystxtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSystxtBtr.First;
begin
  oBtrTable.First;
end;

procedure TSystxtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSystxtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSystxtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSystxtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSystxtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSystxtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSystxtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSystxtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSystxtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSystxtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSystxtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1915001}
