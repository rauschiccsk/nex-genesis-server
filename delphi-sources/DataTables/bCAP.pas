unit bCAP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPayNum = 'PayNum';

type
  TCapBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPayNum:byte;           procedure WritePayNum (pValue:byte);
    function  ReadPayName:Str30;         procedure WritePayName (pValue:Str30);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadExpVal:double;         procedure WriteExpVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadChIVal:double;         procedure WriteChIVal (pValue:double);
    function  ReadChEVal:double;         procedure WriteChEVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePayNum (pPayNum:byte):boolean;
    function NearestPayNum (pPayNum:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pCasNum:word);
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
    property PayNum:byte read ReadPayNum write WritePayNum;
    property PayName:Str30 read ReadPayName write WritePayName;
    property PayVal:double read ReadPayVal write WritePayVal;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property ExpVal:double read ReadExpVal write WriteExpVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property ChIVal:double read ReadChIVal write WriteChIVal;
    property ChEVal:double read ReadChEVal write WriteChEVal;
  end;

implementation

constructor TCapBtr.Create;
begin
  oBtrTable := BtrInit ('CAP',gPath.CabPath,Self);
end;

constructor TCapBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CAP',pPath,Self);
end;

destructor TCapBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCapBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCapBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCapBtr.ReadPayNum:byte;
begin
  Result := oBtrTable.FieldByName('PayNum').AsInteger;
end;

procedure TCapBtr.WritePayNum(pValue:byte);
begin
  oBtrTable.FieldByName('PayNum').AsInteger := pValue;
end;

function TCapBtr.ReadPayName:Str30;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TCapBtr.WritePayName(pValue:Str30);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TCapBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TCapBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TCapBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TCapBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TCapBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TCapBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TCapBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TCapBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TCapBtr.ReadExpVal:double;
begin
  Result := oBtrTable.FieldByName('ExpVal').AsFloat;
end;

procedure TCapBtr.WriteExpVal(pValue:double);
begin
  oBtrTable.FieldByName('ExpVal').AsFloat := pValue;
end;

function TCapBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TCapBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TCapBtr.ReadChIVal:double;
begin
  Result := oBtrTable.FieldByName('ChIVal').AsFloat;
end;

procedure TCapBtr.WriteChIVal(pValue:double);
begin
  oBtrTable.FieldByName('ChIVal').AsFloat := pValue;
end;

function TCapBtr.ReadChEVal:double;
begin
  Result := oBtrTable.FieldByName('ChEVal').AsFloat;
end;

procedure TCapBtr.WriteChEVal(pValue:double);
begin
  oBtrTable.FieldByName('ChEVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCapBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCapBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCapBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCapBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCapBtr.LocatePayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindKey([pPayNum]);
end;

function TCapBtr.NearestPayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindNearest([pPayNum]);
end;

procedure TCapBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCapBtr.Open(pCasNum:word);
begin
  oBtrTable.Open(pCasNum);
end;

procedure TCapBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCapBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCapBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCapBtr.First;
begin
  oBtrTable.First;
end;

procedure TCapBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCapBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCapBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCapBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCapBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCapBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCapBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCapBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCapBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCapBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCapBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
