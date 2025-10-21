unit bCAPADV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPayNum = 'PayNum';
  ixPnAn = 'PnAn';

type
  TCapadvBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPayNum:byte;           procedure WritePayNum (pValue:byte);
    function  ReadAdvName:Str10;         procedure WriteAdvName (pValue:Str10);
    function  ReadPayName:Str30;         procedure WritePayName (pValue:Str30);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadChgCrs:double;         procedure WriteChgCrs (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadPaySum:double;         procedure WritePaySum (pValue:double);
    function  ReadIncMsu:Str10;          procedure WriteIncMsu (pValue:Str10);
    function  ReadChgMsu:Str10;          procedure WriteChgMsu (pValue:Str10);
    function  ReadPayMsu:Str10;          procedure WritePayMsu (pValue:Str10);
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
    function LocatePnAn (pPayNum:byte;pAdvName:Str10):boolean;
    function NearestPayNum (pPayNum:byte):boolean;
    function NearestPnAn (pPayNum:byte;pAdvName:Str10):boolean;

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
    property PayNum:byte read ReadPayNum write WritePayNum;
    property AdvName:Str10 read ReadAdvName write WriteAdvName;
    property PayName:Str30 read ReadPayName write WritePayName;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property ChgCrs:double read ReadChgCrs write WriteChgCrs;
    property PayVal:double read ReadPayVal write WritePayVal;
    property PaySum:double read ReadPaySum write WritePaySum;
    property IncMsu:Str10 read ReadIncMsu write WriteIncMsu;
    property ChgMsu:Str10 read ReadChgMsu write WriteChgMsu;
    property PayMsu:Str10 read ReadPayMsu write WritePayMsu;
  end;

implementation

constructor TCapadvBtr.Create;
begin
  oBtrTable := BtrInit ('CAPADV',gPath.CabPath,Self);
end;

constructor TCapadvBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CAPADV',pPath,Self);
end;

destructor TCapadvBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCapadvBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCapadvBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCapadvBtr.ReadPayNum:byte;
begin
  Result := oBtrTable.FieldByName('PayNum').AsInteger;
end;

procedure TCapadvBtr.WritePayNum(pValue:byte);
begin
  oBtrTable.FieldByName('PayNum').AsInteger := pValue;
end;

function TCapadvBtr.ReadAdvName:Str10;
begin
  Result := oBtrTable.FieldByName('AdvName').AsString;
end;

procedure TCapadvBtr.WriteAdvName(pValue:Str10);
begin
  oBtrTable.FieldByName('AdvName').AsString := pValue;
end;

function TCapadvBtr.ReadPayName:Str30;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TCapadvBtr.WritePayName(pValue:Str30);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TCapadvBtr.ReadIncVal:double;
begin
  Result := oBtrTable.FieldByName('IncVal').AsFloat;
end;

procedure TCapadvBtr.WriteIncVal(pValue:double);
begin
  oBtrTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TCapadvBtr.ReadChgCrs:double;
begin
  Result := oBtrTable.FieldByName('ChgCrs').AsFloat;
end;

procedure TCapadvBtr.WriteChgCrs(pValue:double);
begin
  oBtrTable.FieldByName('ChgCrs').AsFloat := pValue;
end;

function TCapadvBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TCapadvBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TCapadvBtr.ReadPaySum:double;
begin
  Result := oBtrTable.FieldByName('PaySum').AsFloat;
end;

procedure TCapadvBtr.WritePaySum(pValue:double);
begin
  oBtrTable.FieldByName('PaySum').AsFloat := pValue;
end;

function TCapadvBtr.ReadIncMsu:Str10;
begin
  Result := oBtrTable.FieldByName('IncMsu').AsString;
end;

procedure TCapadvBtr.WriteIncMsu(pValue:Str10);
begin
  oBtrTable.FieldByName('IncMsu').AsString := pValue;
end;

function TCapadvBtr.ReadChgMsu:Str10;
begin
  Result := oBtrTable.FieldByName('ChgMsu').AsString;
end;

procedure TCapadvBtr.WriteChgMsu(pValue:Str10);
begin
  oBtrTable.FieldByName('ChgMsu').AsString := pValue;
end;

function TCapadvBtr.ReadPayMsu:Str10;
begin
  Result := oBtrTable.FieldByName('PayMsu').AsString;
end;

procedure TCapadvBtr.WritePayMsu(pValue:Str10);
begin
  oBtrTable.FieldByName('PayMsu').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCapadvBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapadvBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCapadvBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCapadvBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCapadvBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCapadvBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCapadvBtr.LocatePayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindKey([pPayNum]);
end;

function TCapadvBtr.LocatePnAn (pPayNum:byte;pAdvName:Str10):boolean;
begin
  SetIndex (ixPnAn);
  Result := oBtrTable.FindKey([pPayNum,pAdvName]);
end;

function TCapadvBtr.NearestPayNum (pPayNum:byte):boolean;
begin
  SetIndex (ixPayNum);
  Result := oBtrTable.FindNearest([pPayNum]);
end;

function TCapadvBtr.NearestPnAn (pPayNum:byte;pAdvName:Str10):boolean;
begin
  SetIndex (ixPnAn);
  Result := oBtrTable.FindNearest([pPayNum,pAdvName]);
end;

procedure TCapadvBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCapadvBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCapadvBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCapadvBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCapadvBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCapadvBtr.First;
begin
  oBtrTable.First;
end;

procedure TCapadvBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCapadvBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCapadvBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCapadvBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCapadvBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCapadvBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCapadvBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCapadvBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCapadvBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCapadvBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCapadvBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
