unit tDOCLNK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDocName_ = 'DocName_';

type
  TDoclnkTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:Word;           procedure WriteRowNum (pValue:Word);
    function  ReadDocPath:Str90;         procedure WriteDocPath (pValue:Str90);
    function  ReadDocName:Str90;         procedure WriteDocName (pValue:Str90);
    function  ReadDocName_:Str60;        procedure WriteDocName_ (pValue:Str60);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:Word):boolean;
    function LocateDocName_ (pDocName_:Str60):boolean;

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
    property RowNum:Word read ReadRowNum write WriteRowNum;
    property DocPath:Str90 read ReadDocPath write WriteDocPath;
    property DocName:Str90 read ReadDocName write WriteDocName;
    property DocName_:Str60 read ReadDocName_ write WriteDocName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDoclnkTmp.Create;
begin
  oTmpTable := TmpInit ('DOCLNK',Self);
end;

destructor TDoclnkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDoclnkTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDoclnkTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDoclnkTmp.ReadRowNum:Word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TDoclnkTmp.WriteRowNum(pValue:Word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TDoclnkTmp.ReadDocPath:Str90;
begin
  Result := oTmpTable.FieldByName('DocPath').AsString;
end;

procedure TDoclnkTmp.WriteDocPath(pValue:Str90);
begin
  oTmpTable.FieldByName('DocPath').AsString := pValue;
end;

function TDoclnkTmp.ReadDocName:Str90;
begin
  Result := oTmpTable.FieldByName('DocName').AsString;
end;

procedure TDoclnkTmp.WriteDocName(pValue:Str90);
begin
  oTmpTable.FieldByName('DocName').AsString := pValue;
end;

function TDoclnkTmp.ReadDocName_:Str60;
begin
  Result := oTmpTable.FieldByName('DocName_').AsString;
end;

procedure TDoclnkTmp.WriteDocName_(pValue:Str60);
begin
  oTmpTable.FieldByName('DocName_').AsString := pValue;
end;

function TDoclnkTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDoclnkTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDoclnkTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDoclnkTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDoclnkTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDoclnkTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDoclnkTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDoclnkTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDoclnkTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDoclnkTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDoclnkTmp.LocateRowNum (pRowNum:Word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TDoclnkTmp.LocateDocName_ (pDocName_:Str60):boolean;
begin
  SetIndex (ixDocName_);
  Result := oTmpTable.FindKey([pDocName_]);
end;

procedure TDoclnkTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDoclnkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDoclnkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDoclnkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDoclnkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDoclnkTmp.First;
begin
  oTmpTable.First;
end;

procedure TDoclnkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDoclnkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDoclnkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDoclnkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDoclnkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDoclnkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDoclnkTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDoclnkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDoclnkTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDoclnkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDoclnkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1904013}
