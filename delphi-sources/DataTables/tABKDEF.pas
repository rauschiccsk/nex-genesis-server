unit tABKDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrPmBn = '';

type
  TAbkdefTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadPmdMark:Str6;          procedure WritePmdMark (pValue:Str6);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAbkdefTmp.Create;
begin
  oTmpTable := TmpInit ('ABKDEF',Self);
end;

destructor TAbkdefTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAbkdefTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAbkdefTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAbkdefTmp.ReadGrpNum:word;
begin
  Result := oTmpTable.FieldByName('GrpNum').AsInteger;
end;

procedure TAbkdefTmp.WriteGrpNum(pValue:word);
begin
  oTmpTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TAbkdefTmp.ReadPmdMark:Str6;
begin
  Result := oTmpTable.FieldByName('PmdMark').AsString;
end;

procedure TAbkdefTmp.WritePmdMark(pValue:Str6);
begin
  oTmpTable.FieldByName('PmdMark').AsString := pValue;
end;

function TAbkdefTmp.ReadBookNum:Str5;
begin
  Result := oTmpTable.FieldByName('BookNum').AsString;
end;

procedure TAbkdefTmp.WriteBookNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BookNum').AsString := pValue;
end;

function TAbkdefTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAbkdefTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAbkdefTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAbkdefTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAbkdefTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAbkdefTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAbkdefTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAbkdefTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAbkdefTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAbkdefTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAbkdefTmp.LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  SetIndex (ixGrPmBn);
  Result := oTmpTable.FindKey([pGrpNum,pPmdMark,pBookNum]);
end;

procedure TAbkdefTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAbkdefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAbkdefTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAbkdefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAbkdefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAbkdefTmp.First;
begin
  oTmpTable.First;
end;

procedure TAbkdefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAbkdefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAbkdefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAbkdefTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAbkdefTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAbkdefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAbkdefTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAbkdefTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAbkdefTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAbkdefTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAbkdefTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
