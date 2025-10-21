unit bCOLITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixColNum = 'ColNum';

type
  TColitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadColNum:word;           procedure WriteColNum (pValue:word);
    function  ReadColName:Str30;         procedure WriteColName (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadTenQnt:word;           procedure WriteTenQnt (pValue:word);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateColNum (pColNum:word):boolean;
    function NearestColNum (pColNum:word):boolean;

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
    property ColNum:word read ReadColNum write WriteColNum;
    property ColName:Str30 read ReadColName write WriteColName;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property TenQnt:word read ReadTenQnt write WriteTenQnt;
  end;

implementation

constructor TColitmBtr.Create;
begin
  oBtrTable := BtrInit ('COLITM',gPath.StkPath,Self);
end;

constructor TColitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('COLITM',pPath,Self);
end;

destructor TColitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TColitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TColitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TColitmBtr.ReadColNum:word;
begin
  Result := oBtrTable.FieldByName('ColNum').AsInteger;
end;

procedure TColitmBtr.WriteColNum(pValue:word);
begin
  oBtrTable.FieldByName('ColNum').AsInteger := pValue;
end;

function TColitmBtr.ReadColName:Str30;
begin
  Result := oBtrTable.FieldByName('ColName').AsString;
end;

procedure TColitmBtr.WriteColName(pValue:Str30);
begin
  oBtrTable.FieldByName('ColName').AsString := pValue;
end;

function TColitmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TColitmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TColitmBtr.ReadDscVal:double;
begin
  Result := oBtrTable.FieldByName('DscVal').AsFloat;
end;

procedure TColitmBtr.WriteDscVal(pValue:double);
begin
  oBtrTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TColitmBtr.ReadDayQnt:word;
begin
  Result := oBtrTable.FieldByName('DayQnt').AsInteger;
end;

procedure TColitmBtr.WriteDayQnt(pValue:word);
begin
  oBtrTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TColitmBtr.ReadTenQnt:word;
begin
  Result := oBtrTable.FieldByName('TenQnt').AsInteger;
end;

procedure TColitmBtr.WriteTenQnt(pValue:word);
begin
  oBtrTable.FieldByName('TenQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TColitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TColitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TColitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TColitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TColitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TColitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TColitmBtr.LocateColNum (pColNum:word):boolean;
begin
  SetIndex (ixColNum);
  Result := oBtrTable.FindKey([pColNum]);
end;

function TColitmBtr.NearestColNum (pColNum:word):boolean;
begin
  SetIndex (ixColNum);
  Result := oBtrTable.FindNearest([pColNum]);
end;

procedure TColitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TColitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TColitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TColitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TColitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TColitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TColitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TColitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TColitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TColitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TColitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TColitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TColitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TColitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TColitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TColitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TColitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
