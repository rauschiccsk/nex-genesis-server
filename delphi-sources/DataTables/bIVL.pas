unit bIVL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';

type
  TIvlBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oIvdNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadSecName:Str30;         procedure WriteSecName (pValue:Str30);
    function  ReadTrmNum1:byte;          procedure WriteTrmNum1 (pValue:byte);
    function  ReadTrmType1:byte;         procedure WriteTrmType1 (pValue:byte);
    function  ReadOpName1:Str30;         procedure WriteOpName1 (pValue:Str30);
    function  ReadAsName1:Str30;         procedure WriteAsName1 (pValue:Str30);
    function  ReadTrmNum2:byte;          procedure WriteTrmNum2 (pValue:byte);
    function  ReadTrmType2:byte;         procedure WriteTrmType2 (pValue:byte);
    function  ReadOpName2:Str30;         procedure WriteOpName2 (pValue:Str30);
    function  ReadAsName2:Str30;         procedure WriteAsName2 (pValue:Str30);
    function  ReadIvFase:byte;           procedure WriteIvFase (pValue:byte);
    function  ReadItmCnt:word;           procedure WriteItmCnt (pValue:word);
    function  ReadDifCnt:word;           procedure WriteDifCnt (pValue:word);
    function  ReadClosed:byte;           procedure WriteClosed (pValue:byte);
    function  ReadQntCnt:double;         procedure WriteQntCnt (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function NearestSerNum (pSerNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pIvdNum:integer);
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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property SecName:Str30 read ReadSecName write WriteSecName;
    property TrmNum1:byte read ReadTrmNum1 write WriteTrmNum1;
    property TrmType1:byte read ReadTrmType1 write WriteTrmType1;
    property OpName1:Str30 read ReadOpName1 write WriteOpName1;
    property AsName1:Str30 read ReadAsName1 write WriteAsName1;
    property TrmNum2:byte read ReadTrmNum2 write WriteTrmNum2;
    property TrmType2:byte read ReadTrmType2 write WriteTrmType2;
    property OpName2:Str30 read ReadOpName2 write WriteOpName2;
    property AsName2:Str30 read ReadAsName2 write WriteAsName2;
    property IvFase:byte read ReadIvFase write WriteIvFase;
    property ItmCnt:word read ReadItmCnt write WriteItmCnt;
    property DifCnt:word read ReadDifCnt write WriteDifCnt;
    property Closed:byte read ReadClosed write WriteClosed;
    property QntCnt:double read ReadQntCnt write WriteQntCnt;
  end;

implementation

constructor TIvlBtr.Create;
begin
  oBtrTable := BtrInit ('IVL',gPath.StkPath,Self);
end;

constructor TIvlBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IVL',pPath,Self);
end;

destructor TIvlBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIvlBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIvlBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIvlBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIvlBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIvlBtr.ReadSecName:Str30;
begin
  Result := oBtrTable.FieldByName('SecName').AsString;
end;

procedure TIvlBtr.WriteSecName(pValue:Str30);
begin
  oBtrTable.FieldByName('SecName').AsString := pValue;
end;

function TIvlBtr.ReadTrmNum1:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum1').AsInteger;
end;

procedure TIvlBtr.WriteTrmNum1(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum1').AsInteger := pValue;
end;

function TIvlBtr.ReadTrmType1:byte;
begin
  Result := oBtrTable.FieldByName('TrmType1').AsInteger;
end;

procedure TIvlBtr.WriteTrmType1(pValue:byte);
begin
  oBtrTable.FieldByName('TrmType1').AsInteger := pValue;
end;

function TIvlBtr.ReadOpName1:Str30;
begin
  Result := oBtrTable.FieldByName('OpName1').AsString;
end;

procedure TIvlBtr.WriteOpName1(pValue:Str30);
begin
  oBtrTable.FieldByName('OpName1').AsString := pValue;
end;

function TIvlBtr.ReadAsName1:Str30;
begin
  Result := oBtrTable.FieldByName('AsName1').AsString;
end;

procedure TIvlBtr.WriteAsName1(pValue:Str30);
begin
  oBtrTable.FieldByName('AsName1').AsString := pValue;
end;

function TIvlBtr.ReadTrmNum2:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum2').AsInteger;
end;

procedure TIvlBtr.WriteTrmNum2(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum2').AsInteger := pValue;
end;

function TIvlBtr.ReadTrmType2:byte;
begin
  Result := oBtrTable.FieldByName('TrmType2').AsInteger;
end;

procedure TIvlBtr.WriteTrmType2(pValue:byte);
begin
  oBtrTable.FieldByName('TrmType2').AsInteger := pValue;
end;

function TIvlBtr.ReadOpName2:Str30;
begin
  Result := oBtrTable.FieldByName('OpName2').AsString;
end;

procedure TIvlBtr.WriteOpName2(pValue:Str30);
begin
  oBtrTable.FieldByName('OpName2').AsString := pValue;
end;

function TIvlBtr.ReadAsName2:Str30;
begin
  Result := oBtrTable.FieldByName('AsName2').AsString;
end;

procedure TIvlBtr.WriteAsName2(pValue:Str30);
begin
  oBtrTable.FieldByName('AsName2').AsString := pValue;
end;

function TIvlBtr.ReadIvFase:byte;
begin
  Result := oBtrTable.FieldByName('IvFase').AsInteger;
end;

procedure TIvlBtr.WriteIvFase(pValue:byte);
begin
  oBtrTable.FieldByName('IvFase').AsInteger := pValue;
end;

function TIvlBtr.ReadItmCnt:word;
begin
  Result := oBtrTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TIvlBtr.WriteItmCnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TIvlBtr.ReadDifCnt:word;
begin
  Result := oBtrTable.FieldByName('DifCnt').AsInteger;
end;

procedure TIvlBtr.WriteDifCnt(pValue:word);
begin
  oBtrTable.FieldByName('DifCnt').AsInteger := pValue;
end;

function TIvlBtr.ReadClosed:byte;
begin
  Result := oBtrTable.FieldByName('Closed').AsInteger;
end;

procedure TIvlBtr.WriteClosed(pValue:byte);
begin
  oBtrTable.FieldByName('Closed').AsInteger := pValue;
end;

function TIvlBtr.ReadQntCnt:double;
begin
  Result := oBtrTable.FieldByName('QntCnt').AsFloat;
end;

procedure TIvlBtr.WriteQntCnt(pValue:double);
begin
  oBtrTable.FieldByName('QntCnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvlBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvlBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIvlBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvlBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIvlBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIvlBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIvlBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TIvlBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

procedure TIvlBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIvlBtr.Open(pIvdNum:integer);
begin
  oIvdNum:=pIvdNum;
  oBtrTable.Open(pIvdNum);
end;

procedure TIvlBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIvlBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIvlBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIvlBtr.First;
begin
  oBtrTable.First;
end;

procedure TIvlBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIvlBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIvlBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIvlBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIvlBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIvlBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIvlBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIvlBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIvlBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIvlBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIvlBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
