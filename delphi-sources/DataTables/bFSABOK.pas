unit bFSABOK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBokNum = 'BokNum';

type
  TFsabokBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:byte;           procedure WriteBokNum (pValue:byte);
    function  ReadBokName:Str30;         procedure WriteBokName (pValue:Str30);
    function  ReadBuyVal:double;         procedure WriteBuyVal (pValue:double);
    function  ReadSalVal:double;         procedure WriteSalVal (pValue:double);
    function  ReadOvrVal:double;         procedure WriteOvrVal (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBokNum (pBokNum:byte):boolean;
    function NearestBokNum (pBokNum:byte):boolean;

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
    property BokNum:byte read ReadBokNum write WriteBokNum;
    property BokName:Str30 read ReadBokName write WriteBokName;
    property BuyVal:double read ReadBuyVal write WriteBuyVal;
    property SalVal:double read ReadSalVal write WriteSalVal;
    property OvrVal:double read ReadOvrVal write WriteOvrVal;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
  end;

implementation

constructor TFsabokBtr.Create;
begin
  oBtrTable := BtrInit ('FSABOK',gPath.CdwPath,Self);
end;

constructor TFsabokBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSABOK',pPath,Self);
end;

destructor TFsabokBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsabokBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsabokBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsabokBtr.ReadBokNum:byte;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsabokBtr.WriteBokNum(pValue:byte);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsabokBtr.ReadBokName:Str30;
begin
  Result := oBtrTable.FieldByName('BokName').AsString;
end;

procedure TFsabokBtr.WriteBokName(pValue:Str30);
begin
  oBtrTable.FieldByName('BokName').AsString := pValue;
end;

function TFsabokBtr.ReadBuyVal:double;
begin
  Result := oBtrTable.FieldByName('BuyVal').AsFloat;
end;

procedure TFsabokBtr.WriteBuyVal(pValue:double);
begin
  oBtrTable.FieldByName('BuyVal').AsFloat := pValue;
end;

function TFsabokBtr.ReadSalVal:double;
begin
  Result := oBtrTable.FieldByName('SalVal').AsFloat;
end;

procedure TFsabokBtr.WriteSalVal(pValue:double);
begin
  oBtrTable.FieldByName('SalVal').AsFloat := pValue;
end;

function TFsabokBtr.ReadOvrVal:double;
begin
  Result := oBtrTable.FieldByName('OvrVal').AsFloat;
end;

procedure TFsabokBtr.WriteOvrVal(pValue:double);
begin
  oBtrTable.FieldByName('OvrVal').AsFloat := pValue;
end;

function TFsabokBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TFsabokBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TFsabokBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TFsabokBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsabokBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsabokBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsabokBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsabokBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsabokBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsabokBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsabokBtr.LocateBokNum (pBokNum:byte):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsabokBtr.NearestBokNum (pBokNum:byte):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

procedure TFsabokBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsabokBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsabokBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsabokBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsabokBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsabokBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsabokBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsabokBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsabokBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsabokBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsabokBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsabokBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsabokBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsabokBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsabokBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsabokBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsabokBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
