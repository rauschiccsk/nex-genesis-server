unit tPOS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPosCode = '';

type
  TPosTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePosCode (pPosCode:Str15):boolean;

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
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPosTmp.Create;
begin
  oTmpTable := TmpInit ('POS',Self);
end;

destructor TPosTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPosTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPosTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPosTmp.ReadPosCode:Str15;
begin
  Result := oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TPosTmp.WritePosCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCode').AsString := pValue;
end;

function TPosTmp.ReadMaxQnt:double;
begin
  Result := oTmpTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TPosTmp.WriteMaxQnt(pValue:double);
begin
  oTmpTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TPosTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TPosTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TPosTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPosTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPosTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPosTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPosTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPosTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPosTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPosTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPosTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPosTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPosTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPosTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPosTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPosTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPosTmp.LocatePosCode (pPosCode:Str15):boolean;
begin
  SetIndex (ixPosCode);
  Result := oTmpTable.FindKey([pPosCode]);
end;

procedure TPosTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPosTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPosTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPosTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPosTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPosTmp.First;
begin
  oTmpTable.First;
end;

procedure TPosTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPosTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPosTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPosTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPosTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPosTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPosTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPosTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPosTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPosTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPosTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
