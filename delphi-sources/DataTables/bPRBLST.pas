unit bPRBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixUsrNum = 'UsrNum';
  ixBokNum = 'BokNum';
  ixParBok = 'ParBok';

type
  TPrblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadUsrNum:word;           procedure WriteUsrNum (pValue:word);
    function  ReadTreLev:byte;           procedure WriteTreLev (pValue:byte);
    function  ReadBokNum:longint;        procedure WriteBokNum (pValue:longint);
    function  ReadBokNam:Str20;          procedure WriteBokNam (pValue:Str20);
    function  ReadParBok:longint;        procedure WriteParBok (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateUsrNum (pUsrNum:word):boolean;
    function LocateBokNum (pBokNum:longint):boolean;
    function LocateParBok (pParBok:longint):boolean;
    function NearestUsrNum (pUsrNum:word):boolean;
    function NearestBokNum (pBokNum:longint):boolean;
    function NearestParBok (pParBok:longint):boolean;

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
    property UsrNum:word read ReadUsrNum write WriteUsrNum;
    property TreLev:byte read ReadTreLev write WriteTreLev;
    property BokNum:longint read ReadBokNum write WriteBokNum;
    property BokNam:Str20 read ReadBokNam write WriteBokNam;
    property ParBok:longint read ReadParBok write WriteParBok;
  end;

implementation

constructor TPrblstBtr.Create;
begin
  oBtrTable := BtrInit ('PRBLST',gPath.MgdPath,Self);
end;

constructor TPrblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRBLST',pPath,Self);
end;

destructor TPrblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrblstBtr.ReadUsrNum:word;
begin
  Result := oBtrTable.FieldByName('UsrNum').AsInteger;
end;

procedure TPrblstBtr.WriteUsrNum(pValue:word);
begin
  oBtrTable.FieldByName('UsrNum').AsInteger := pValue;
end;

function TPrblstBtr.ReadTreLev:byte;
begin
  Result := oBtrTable.FieldByName('TreLev').AsInteger;
end;

procedure TPrblstBtr.WriteTreLev(pValue:byte);
begin
  oBtrTable.FieldByName('TreLev').AsInteger := pValue;
end;

function TPrblstBtr.ReadBokNum:longint;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TPrblstBtr.WriteBokNum(pValue:longint);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TPrblstBtr.ReadBokNam:Str20;
begin
  Result := oBtrTable.FieldByName('BokNam').AsString;
end;

procedure TPrblstBtr.WriteBokNam(pValue:Str20);
begin
  oBtrTable.FieldByName('BokNam').AsString := pValue;
end;

function TPrblstBtr.ReadParBok:longint;
begin
  Result := oBtrTable.FieldByName('ParBok').AsInteger;
end;

procedure TPrblstBtr.WriteParBok(pValue:longint);
begin
  oBtrTable.FieldByName('ParBok').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrblstBtr.LocateUsrNum (pUsrNum:word):boolean;
begin
  SetIndex (ixUsrNum);
  Result := oBtrTable.FindKey([pUsrNum]);
end;

function TPrblstBtr.LocateBokNum (pBokNum:longint):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TPrblstBtr.LocateParBok (pParBok:longint):boolean;
begin
  SetIndex (ixParBok);
  Result := oBtrTable.FindKey([pParBok]);
end;

function TPrblstBtr.NearestUsrNum (pUsrNum:word):boolean;
begin
  SetIndex (ixUsrNum);
  Result := oBtrTable.FindNearest([pUsrNum]);
end;

function TPrblstBtr.NearestBokNum (pBokNum:longint):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TPrblstBtr.NearestParBok (pParBok:longint):boolean;
begin
  SetIndex (ixParBok);
  Result := oBtrTable.FindNearest([pParBok]);
end;

procedure TPrblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
