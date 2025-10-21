unit bXRCDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRnCn = 'RnCn';

type
  TXrcdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadColNum:word;           procedure WriteColNum (pValue:word);
    function  ReadPerNum:byte;           procedure WritePerNum (pValue:byte);
    function  ReadValTyp:Str2;           procedure WriteValTyp (pValue:Str2);
    function  ReadIdcTyp:Str2;           procedure WriteIdcTyp (pValue:Str2);
    function  ReadErrNum:word;           procedure WriteErrNum (pValue:word);
    function  ReadErrTxt:Str90;          procedure WriteErrTxt (pValue:Str90);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateRnCn (pRowNum:word;pColNum:word):boolean;
    function NearestRnCn (pRowNum:word;pColNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property ColNum:word read ReadColNum write WriteColNum;
    property PerNum:byte read ReadPerNum write WritePerNum;
    property ValTyp:Str2 read ReadValTyp write WriteValTyp;
    property IdcTyp:Str2 read ReadIdcTyp write WriteIdcTyp;
    property ErrNum:word read ReadErrNum write WriteErrNum;
    property ErrTxt:Str90 read ReadErrTxt write WriteErrTxt;
  end;

implementation

constructor TXrcdefBtr.Create;
begin
  oBtrTable := BtrInit ('XRCDEF',gPath.StkPath,Self);
end;

constructor TXrcdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRCDEF',pPath,Self);
end;

destructor TXrcdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrcdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrcdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrcdefBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TXrcdefBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TXrcdefBtr.ReadColNum:word;
begin
  Result := oBtrTable.FieldByName('ColNum').AsInteger;
end;

procedure TXrcdefBtr.WriteColNum(pValue:word);
begin
  oBtrTable.FieldByName('ColNum').AsInteger := pValue;
end;

function TXrcdefBtr.ReadPerNum:byte;
begin
  Result := oBtrTable.FieldByName('PerNum').AsInteger;
end;

procedure TXrcdefBtr.WritePerNum(pValue:byte);
begin
  oBtrTable.FieldByName('PerNum').AsInteger := pValue;
end;

function TXrcdefBtr.ReadValTyp:Str2;
begin
  Result := oBtrTable.FieldByName('ValTyp').AsString;
end;

procedure TXrcdefBtr.WriteValTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('ValTyp').AsString := pValue;
end;

function TXrcdefBtr.ReadIdcTyp:Str2;
begin
  Result := oBtrTable.FieldByName('IdcTyp').AsString;
end;

procedure TXrcdefBtr.WriteIdcTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('IdcTyp').AsString := pValue;
end;

function TXrcdefBtr.ReadErrNum:word;
begin
  Result := oBtrTable.FieldByName('ErrNum').AsInteger;
end;

procedure TXrcdefBtr.WriteErrNum(pValue:word);
begin
  oBtrTable.FieldByName('ErrNum').AsInteger := pValue;
end;

function TXrcdefBtr.ReadErrTxt:Str90;
begin
  Result := oBtrTable.FieldByName('ErrTxt').AsString;
end;

procedure TXrcdefBtr.WriteErrTxt(pValue:Str90);
begin
  oBtrTable.FieldByName('ErrTxt').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrcdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrcdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrcdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrcdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrcdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrcdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrcdefBtr.LocateRnCn (pRowNum:word;pColNum:word):boolean;
begin
  SetIndex (ixRnCn);
  Result := oBtrTable.FindKey([pRowNum,pColNum]);
end;

function TXrcdefBtr.NearestRnCn (pRowNum:word;pColNum:word):boolean;
begin
  SetIndex (ixRnCn);
  Result := oBtrTable.FindNearest([pRowNum,pColNum]);
end;

procedure TXrcdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrcdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TXrcdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrcdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrcdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrcdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrcdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrcdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrcdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrcdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrcdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrcdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrcdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrcdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrcdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrcdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrcdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
