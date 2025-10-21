unit bPANOTI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaLn = 'PaLn';
  ixPaCode = 'PaCode';

type
  TPanotiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadNotice:Str250;         procedure WriteNotice (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaLn (pPaCode:longint;pLinNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestPaLn (pPaCode:longint;pLinNum:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TPanotiBtr.Create;
begin
  oBtrTable := BtrInit ('PANOTI',gPath.DlsPath,Self);
end;

constructor TPanotiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PANOTI',pPath,Self);
end;

destructor TPanotiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPanotiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPanotiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPanotiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPanotiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPanotiBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TPanotiBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TPanotiBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TPanotiBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPanotiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPanotiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPanotiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPanotiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPanotiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPanotiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPanotiBtr.LocatePaLn (pPaCode:longint;pLinNum:word):boolean;
begin
  SetIndex (ixPaLn);
  Result := oBtrTable.FindKey([pPaCode,pLinNum]);
end;

function TPanotiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPanotiBtr.NearestPaLn (pPaCode:longint;pLinNum:word):boolean;
begin
  SetIndex (ixPaLn);
  Result := oBtrTable.FindNearest([pPaCode,pLinNum]);
end;

function TPanotiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TPanotiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPanotiBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPanotiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPanotiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPanotiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPanotiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPanotiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPanotiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPanotiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPanotiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPanotiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPanotiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPanotiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPanotiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPanotiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPanotiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPanotiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2011001}
