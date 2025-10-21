unit bXRCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';

type
  TXrclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadColNum:word;           procedure WriteColNum (pValue:word);
    function  ReadPerNum:byte;           procedure WritePerNum (pValue:byte);
    function  ReadValTyp:Str2;           procedure WriteValTyp (pValue:Str2);
    function  ReadIdcTyp:Str2;           procedure WriteIdcTyp (pValue:Str2);
    function  ReadBegDat:TDatetime;      procedure WriteBegDat (pValue:TDatetime);
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadCelVal:double;         procedure WriteCelVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property ColNum:word read ReadColNum write WriteColNum;
    property PerNum:byte read ReadPerNum write WritePerNum;
    property ValTyp:Str2 read ReadValTyp write WriteValTyp;
    property IdcTyp:Str2 read ReadIdcTyp write WriteIdcTyp;
    property BegDat:TDatetime read ReadBegDat write WriteBegDat;
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property CelVal:double read ReadCelVal write WriteCelVal;
  end;

implementation

constructor TXrclstBtr.Create;
begin
  oBtrTable := BtrInit ('XRCLST',gPath.StkPath,Self);
end;

constructor TXrclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRCLST',pPath,Self);
end;

destructor TXrclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrclstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TXrclstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TXrclstBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TXrclstBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TXrclstBtr.ReadColNum:word;
begin
  Result := oBtrTable.FieldByName('ColNum').AsInteger;
end;

procedure TXrclstBtr.WriteColNum(pValue:word);
begin
  oBtrTable.FieldByName('ColNum').AsInteger := pValue;
end;

function TXrclstBtr.ReadPerNum:byte;
begin
  Result := oBtrTable.FieldByName('PerNum').AsInteger;
end;

procedure TXrclstBtr.WritePerNum(pValue:byte);
begin
  oBtrTable.FieldByName('PerNum').AsInteger := pValue;
end;

function TXrclstBtr.ReadValTyp:Str2;
begin
  Result := oBtrTable.FieldByName('ValTyp').AsString;
end;

procedure TXrclstBtr.WriteValTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('ValTyp').AsString := pValue;
end;

function TXrclstBtr.ReadIdcTyp:Str2;
begin
  Result := oBtrTable.FieldByName('IdcTyp').AsString;
end;

procedure TXrclstBtr.WriteIdcTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('IdcTyp').AsString := pValue;
end;

function TXrclstBtr.ReadBegDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat').AsDateTime;
end;

procedure TXrclstBtr.WriteBegDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat').AsDateTime := pValue;
end;

function TXrclstBtr.ReadEndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat').AsDateTime;
end;

procedure TXrclstBtr.WriteEndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TXrclstBtr.ReadCelVal:double;
begin
  Result := oBtrTable.FieldByName('CelVal').AsFloat;
end;

procedure TXrclstBtr.WriteCelVal(pValue:double);
begin
  oBtrTable.FieldByName('CelVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrclstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TXrclstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TXrclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TXrclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
