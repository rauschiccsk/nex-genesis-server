unit tFGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixFgCode = 'FgCode';

type
  TFglstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadFgName:Str30;          procedure WriteFgName (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateFgCode (pFgCode:longint):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property FgName:Str30 read ReadFgName write WriteFgName;
  end;

implementation

constructor TFglstTmp.Create;
begin
  oTmpTable := TmpInit ('FGLST',Self);
end;

destructor TFglstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFglstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFglstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFglstTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TFglstTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TFglstTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TFglstTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFglstTmp.ReadFgName:Str30;
begin
  Result := oTmpTable.FieldByName('FgName').AsString;
end;

procedure TFglstTmp.WriteFgName(pValue:Str30);
begin
  oTmpTable.FieldByName('FgName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFglstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFglstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFglstTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TFglstTmp.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oTmpTable.FindKey([pFgCode]);
end;

procedure TFglstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFglstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFglstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFglstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFglstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFglstTmp.First;
begin
  oTmpTable.First;
end;

procedure TFglstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFglstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFglstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFglstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFglstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFglstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFglstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFglstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFglstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFglstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFglstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
