unit bDSKLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDskName = 'DskName';
  ixCuDn = 'CuDn';

type
  TDsklstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDskName:Str20;         procedure WriteDskName (pValue:Str20);
    function  ReadCasUsi:Str20;          procedure WriteCasUsi (pValue:Str20);
    function  ReadDskVal:double;         procedure WriteDskVal (pValue:double);
    function  ReadBlkQnt:word;           procedure WriteBlkQnt (pValue:word);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDskName (pDskName:Str20):boolean;
    function LocateCuDn (pCasUsi:Str20;pDskName:Str20):boolean;
    function NearestDskName (pDskName:Str20):boolean;
    function NearestCuDn (pCasUsi:Str20;pDskName:Str20):boolean;

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
    property DskName:Str20 read ReadDskName write WriteDskName;
    property CasUsi:Str20 read ReadCasUsi write WriteCasUsi;
    property DskVal:double read ReadDskVal write WriteDskVal;
    property BlkQnt:word read ReadBlkQnt write WriteBlkQnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
  end;

implementation

constructor TDsklstBtr.Create;
begin
  oBtrTable := BtrInit ('DSKLST',gPath.StkPath,Self);
end;

constructor TDsklstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DSKLST',pPath,Self);
end;

destructor TDsklstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDsklstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDsklstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDsklstBtr.ReadDskName:Str20;
begin
  Result := oBtrTable.FieldByName('DskName').AsString;
end;

procedure TDsklstBtr.WriteDskName(pValue:Str20);
begin
  oBtrTable.FieldByName('DskName').AsString := pValue;
end;

function TDsklstBtr.ReadCasUsi:Str20;
begin
  Result := oBtrTable.FieldByName('CasUsi').AsString;
end;

procedure TDsklstBtr.WriteCasUsi(pValue:Str20);
begin
  oBtrTable.FieldByName('CasUsi').AsString := pValue;
end;

function TDsklstBtr.ReadDskVal:double;
begin
  Result := oBtrTable.FieldByName('DskVal').AsFloat;
end;

procedure TDsklstBtr.WriteDskVal(pValue:double);
begin
  oBtrTable.FieldByName('DskVal').AsFloat := pValue;
end;

function TDsklstBtr.ReadBlkQnt:word;
begin
  Result := oBtrTable.FieldByName('BlkQnt').AsInteger;
end;

procedure TDsklstBtr.WriteBlkQnt(pValue:word);
begin
  oBtrTable.FieldByName('BlkQnt').AsInteger := pValue;
end;

function TDsklstBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TDsklstBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TDsklstBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TDsklstBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDsklstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDsklstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDsklstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDsklstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDsklstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDsklstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDsklstBtr.LocateDskName (pDskName:Str20):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindKey([pDskName]);
end;

function TDsklstBtr.LocateCuDn (pCasUsi:Str20;pDskName:Str20):boolean;
begin
  SetIndex (ixCuDn);
  Result := oBtrTable.FindKey([pCasUsi,pDskName]);
end;

function TDsklstBtr.NearestDskName (pDskName:Str20):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindNearest([pDskName]);
end;

function TDsklstBtr.NearestCuDn (pCasUsi:Str20;pDskName:Str20):boolean;
begin
  SetIndex (ixCuDn);
  Result := oBtrTable.FindNearest([pCasUsi,pDskName]);
end;

procedure TDsklstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDsklstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDsklstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDsklstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDsklstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDsklstBtr.First;
begin
  oBtrTable.First;
end;

procedure TDsklstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDsklstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDsklstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDsklstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDsklstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDsklstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDsklstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDsklstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDsklstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDsklstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDsklstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
