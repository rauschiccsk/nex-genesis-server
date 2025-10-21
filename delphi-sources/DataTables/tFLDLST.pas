unit tFLDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFldNum = '';

type
  TFldlstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFldNum:word;           procedure WriteFldNum (pValue:word);
    function  ReadFldNam:Str30;          procedure WriteFldNam (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFldNum (pFldNum:word):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property FldNum:word read ReadFldNum write WriteFldNum;
    property FldNam:Str30 read ReadFldNam write WriteFldNam;
  end;

implementation

constructor TFldlstTmp.Create;
begin
  oTmpTable := TmpInit ('FLDLST',Self);
end;

destructor TFldlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFldlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFldlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFldlstTmp.ReadFldNum:word;
begin
  Result := oTmpTable.FieldByName('FldNum').AsInteger;
end;

procedure TFldlstTmp.WriteFldNum(pValue:word);
begin
  oTmpTable.FieldByName('FldNum').AsInteger := pValue;
end;

function TFldlstTmp.ReadFldNam:Str30;
begin
  Result := oTmpTable.FieldByName('FldNam').AsString;
end;

procedure TFldlstTmp.WriteFldNam(pValue:Str30);
begin
  oTmpTable.FieldByName('FldNam').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFldlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFldlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFldlstTmp.LocateFldNum (pFldNum:word):boolean;
begin
  SetIndex (ixFldNum);
  Result := oTmpTable.FindKey([pFldNum]);
end;

procedure TFldlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFldlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFldlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFldlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFldlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFldlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TFldlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFldlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFldlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFldlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFldlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFldlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFldlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFldlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFldlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFldlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFldlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
