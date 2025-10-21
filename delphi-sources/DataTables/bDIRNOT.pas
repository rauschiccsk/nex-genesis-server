unit bDIRNOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnOlLn = 'CnOlLn';
  ixCnOl = 'CnOl';
  ixCntNum = 'CntNum';

type
  TDirnotBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadOwnLog:Str8;           procedure WriteOwnLog (pValue:Str8);
    function  ReadNotType:Str1;          procedure WriteNotType (pValue:Str1);
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
    function LocateCnOlLn (pCntNum:word;pOwnLog:Str8;pLinNum:word):boolean;
    function LocateCnOl (pCntNum:word;pOwnLog:Str8):boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function NearestCnOlLn (pCntNum:word;pOwnLog:Str8;pLinNum:word):boolean;
    function NearestCnOl (pCntNum:word;pOwnLog:Str8):boolean;
    function NearestCntNum (pCntNum:word):boolean;

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
    property CntNum:word read ReadCntNum write WriteCntNum;
    property OwnLog:Str8 read ReadOwnLog write WriteOwnLog;
    property NotType:Str1 read ReadNotType write WriteNotType;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TDirnotBtr.Create;
begin
  oBtrTable := BtrInit ('DIRNOT',gPath.DlsPath,Self);
end;

constructor TDirnotBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRNOT',pPath,Self);
end;

destructor TDirnotBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirnotBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirnotBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirnotBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirnotBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirnotBtr.ReadOwnLog:Str8;
begin
  Result := oBtrTable.FieldByName('OwnLog').AsString;
end;

procedure TDirnotBtr.WriteOwnLog(pValue:Str8);
begin
  oBtrTable.FieldByName('OwnLog').AsString := pValue;
end;

function TDirnotBtr.ReadNotType:Str1;
begin
  Result := oBtrTable.FieldByName('NotType').AsString;
end;

procedure TDirnotBtr.WriteNotType(pValue:Str1);
begin
  oBtrTable.FieldByName('NotType').AsString := pValue;
end;

function TDirnotBtr.ReadLinNum:word;
begin
  Result := oBtrTable.FieldByName('LinNum').AsInteger;
end;

procedure TDirnotBtr.WriteLinNum(pValue:word);
begin
  oBtrTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TDirnotBtr.ReadNotice:Str250;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TDirnotBtr.WriteNotice(pValue:Str250);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirnotBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirnotBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirnotBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirnotBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirnotBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirnotBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirnotBtr.LocateCnOlLn (pCntNum:word;pOwnLog:Str8;pLinNum:word):boolean;
begin
  SetIndex (ixCnOlLn);
  Result := oBtrTable.FindKey([pCntNum,pOwnLog,pLinNum]);
end;

function TDirnotBtr.LocateCnOl (pCntNum:word;pOwnLog:Str8):boolean;
begin
  SetIndex (ixCnOl);
  Result := oBtrTable.FindKey([pCntNum,pOwnLog]);
end;

function TDirnotBtr.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDirnotBtr.NearestCnOlLn (pCntNum:word;pOwnLog:Str8;pLinNum:word):boolean;
begin
  SetIndex (ixCnOlLn);
  Result := oBtrTable.FindNearest([pCntNum,pOwnLog,pLinNum]);
end;

function TDirnotBtr.NearestCnOl (pCntNum:word;pOwnLog:Str8):boolean;
begin
  SetIndex (ixCnOl);
  Result := oBtrTable.FindNearest([pCntNum,pOwnLog]);
end;

function TDirnotBtr.NearestCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDirnotBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirnotBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirnotBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirnotBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirnotBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirnotBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirnotBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirnotBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirnotBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirnotBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirnotBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirnotBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirnotBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirnotBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirnotBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirnotBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirnotBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
