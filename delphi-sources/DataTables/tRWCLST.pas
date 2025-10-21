unit tRWCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOwIw = '';

type
  TRwclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOutWri:word;           procedure WriteOutWri (pValue:word);
    function  ReadIncWri:word;           procedure WriteIncWri (pValue:word);
    function  ReadOutStk:word;           procedure WriteOutStk (pValue:word);
    function  ReadIncStk:word;           procedure WriteIncStk (pValue:word);
    function  ReadOmbNum:Str5;           procedure WriteOmbNum (pValue:Str5);
    function  ReadImbNum:Str5;           procedure WriteImbNum (pValue:Str5);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateOwIw (pOutWri:word;pIncWri:word):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property OutWri:word read ReadOutWri write WriteOutWri;
    property IncWri:word read ReadIncWri write WriteIncWri;
    property OutStk:word read ReadOutStk write WriteOutStk;
    property IncStk:word read ReadIncStk write WriteIncStk;
    property OmbNum:Str5 read ReadOmbNum write WriteOmbNum;
    property ImbNum:Str5 read ReadImbNum write WriteImbNum;
  end;

implementation

constructor TRwclstTmp.Create;
begin
  oTmpTable := TmpInit ('RWCLST',Self);
end;

destructor TRwclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRwclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRwclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRwclstTmp.ReadOutWri:word;
begin
  Result := oTmpTable.FieldByName('OutWri').AsInteger;
end;

procedure TRwclstTmp.WriteOutWri(pValue:word);
begin
  oTmpTable.FieldByName('OutWri').AsInteger := pValue;
end;

function TRwclstTmp.ReadIncWri:word;
begin
  Result := oTmpTable.FieldByName('IncWri').AsInteger;
end;

procedure TRwclstTmp.WriteIncWri(pValue:word);
begin
  oTmpTable.FieldByName('IncWri').AsInteger := pValue;
end;

function TRwclstTmp.ReadOutStk:word;
begin
  Result := oTmpTable.FieldByName('OutStk').AsInteger;
end;

procedure TRwclstTmp.WriteOutStk(pValue:word);
begin
  oTmpTable.FieldByName('OutStk').AsInteger := pValue;
end;

function TRwclstTmp.ReadIncStk:word;
begin
  Result := oTmpTable.FieldByName('IncStk').AsInteger;
end;

procedure TRwclstTmp.WriteIncStk(pValue:word);
begin
  oTmpTable.FieldByName('IncStk').AsInteger := pValue;
end;

function TRwclstTmp.ReadOmbNum:Str5;
begin
  Result := oTmpTable.FieldByName('OmbNum').AsString;
end;

procedure TRwclstTmp.WriteOmbNum(pValue:Str5);
begin
  oTmpTable.FieldByName('OmbNum').AsString := pValue;
end;

function TRwclstTmp.ReadImbNum:Str5;
begin
  Result := oTmpTable.FieldByName('ImbNum').AsString;
end;

procedure TRwclstTmp.WriteImbNum(pValue:Str5);
begin
  oTmpTable.FieldByName('ImbNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRwclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRwclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRwclstTmp.LocateOwIw (pOutWri:word;pIncWri:word):boolean;
begin
  SetIndex (ixOwIw);
  Result := oTmpTable.FindKey([pOutWri,pIncWri]);
end;

procedure TRwclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRwclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRwclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRwclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRwclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRwclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TRwclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRwclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRwclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRwclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRwclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRwclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRwclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRwclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRwclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRwclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRwclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
