unit tDIRSUB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TDirsubTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadSubFld:Str10;          procedure WriteSubFld (pValue:Str10);
    function  ReadSubDat:Str30;          procedure WriteSubDat (pValue:Str30);
    function  ReadSubNot:Str60;          procedure WriteSubNot (pValue:Str60);
    function  ReadMaiFlg:Str1;           procedure WriteMaiFlg (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;

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
    property SubFld:Str10 read ReadSubFld write WriteSubFld;
    property SubDat:Str30 read ReadSubDat write WriteSubDat;
    property SubNot:Str60 read ReadSubNot write WriteSubNot;
    property MaiFlg:Str1 read ReadMaiFlg write WriteMaiFlg;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirsubTmp.Create;
begin
  oTmpTable := TmpInit ('DIRSUB',Self);
end;

destructor TDirsubTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirsubTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirsubTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirsubTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TDirsubTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TDirsubTmp.ReadSubFld:Str10;
begin
  Result := oTmpTable.FieldByName('SubFld').AsString;
end;

procedure TDirsubTmp.WriteSubFld(pValue:Str10);
begin
  oTmpTable.FieldByName('SubFld').AsString := pValue;
end;

function TDirsubTmp.ReadSubDat:Str30;
begin
  Result := oTmpTable.FieldByName('SubDat').AsString;
end;

procedure TDirsubTmp.WriteSubDat(pValue:Str30);
begin
  oTmpTable.FieldByName('SubDat').AsString := pValue;
end;

function TDirsubTmp.ReadSubNot:Str60;
begin
  Result := oTmpTable.FieldByName('SubNot').AsString;
end;

procedure TDirsubTmp.WriteSubNot(pValue:Str60);
begin
  oTmpTable.FieldByName('SubNot').AsString := pValue;
end;

function TDirsubTmp.ReadMaiFlg:Str1;
begin
  Result := oTmpTable.FieldByName('MaiFlg').AsString;
end;

procedure TDirsubTmp.WriteMaiFlg(pValue:Str1);
begin
  oTmpTable.FieldByName('MaiFlg').AsString := pValue;
end;

function TDirsubTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirsubTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirsubTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirsubTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirsubTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirsubTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirsubTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirsubTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirsubTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirsubTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirsubTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TDirsubTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirsubTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirsubTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirsubTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirsubTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirsubTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirsubTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirsubTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirsubTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirsubTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirsubTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirsubTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirsubTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirsubTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirsubTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirsubTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirsubTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
