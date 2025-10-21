unit tATCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAtcNum = '';

type
  TAtclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAtcNum:word;           procedure WriteAtcNum (pValue:word);
    function  ReadAtcFile:Str250;        procedure WriteAtcFile (pValue:Str250);
    function  ReadAtcSize:longint;       procedure WriteAtcSize (pValue:longint);
    function  ReadAtcDate:TDatetime;     procedure WriteAtcDate (pValue:TDatetime);
    function  ReadAtcTime:TDatetime;     procedure WriteAtcTime (pValue:TDatetime);
    function  ReadAtcAttr:byte;          procedure WriteAtcAttr (pValue:byte);
    function  ReadAttType:byte;          procedure WriteAttType (pValue:byte);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateAtcNum (pAtcNum:word):boolean;

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
    property AtcNum:word read ReadAtcNum write WriteAtcNum;
    property AtcFile:Str250 read ReadAtcFile write WriteAtcFile;
    property AtcSize:longint read ReadAtcSize write WriteAtcSize;
    property AtcDate:TDatetime read ReadAtcDate write WriteAtcDate;
    property AtcTime:TDatetime read ReadAtcTime write WriteAtcTime;
    property AtcAttr:byte read ReadAtcAttr write WriteAtcAttr;
    property AttType:byte read ReadAttType write WriteAttType;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAtclstTmp.Create;
begin
  oTmpTable := TmpInit ('ATCLST',Self);
end;

destructor TAtclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAtclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAtclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAtclstTmp.ReadAtcNum:word;
begin
  Result := oTmpTable.FieldByName('AtcNum').AsInteger;
end;

procedure TAtclstTmp.WriteAtcNum(pValue:word);
begin
  oTmpTable.FieldByName('AtcNum').AsInteger := pValue;
end;

function TAtclstTmp.ReadAtcFile:Str250;
begin
  Result := oTmpTable.FieldByName('AtcFile').AsString;
end;

procedure TAtclstTmp.WriteAtcFile(pValue:Str250);
begin
  oTmpTable.FieldByName('AtcFile').AsString := pValue;
end;

function TAtclstTmp.ReadAtcSize:longint;
begin
  Result := oTmpTable.FieldByName('AtcSize').AsInteger;
end;

procedure TAtclstTmp.WriteAtcSize(pValue:longint);
begin
  oTmpTable.FieldByName('AtcSize').AsInteger := pValue;
end;

function TAtclstTmp.ReadAtcDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AtcDate').AsDateTime;
end;

procedure TAtclstTmp.WriteAtcDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AtcDate').AsDateTime := pValue;
end;

function TAtclstTmp.ReadAtcTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('AtcTime').AsDateTime;
end;

procedure TAtclstTmp.WriteAtcTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AtcTime').AsDateTime := pValue;
end;

function TAtclstTmp.ReadAtcAttr:byte;
begin
  Result := oTmpTable.FieldByName('AtcAttr').AsInteger;
end;

procedure TAtclstTmp.WriteAtcAttr(pValue:byte);
begin
  oTmpTable.FieldByName('AtcAttr').AsInteger := pValue;
end;

function TAtclstTmp.ReadAttType:byte;
begin
  Result := oTmpTable.FieldByName('AttType').AsInteger;
end;

procedure TAtclstTmp.WriteAttType(pValue:byte);
begin
  oTmpTable.FieldByName('AttType').AsInteger := pValue;
end;

function TAtclstTmp.ReadCrtName:str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TAtclstTmp.WriteCrtName(pValue:str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TAtclstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAtclstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAtclstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAtclstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAtclstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAtclstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAtclstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAtclstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAtclstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAtclstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAtclstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAtclstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAtclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAtclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAtclstTmp.LocateAtcNum (pAtcNum:word):boolean;
begin
  SetIndex (ixAtcNum);
  Result := oTmpTable.FindKey([pAtcNum]);
end;

procedure TAtclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAtclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAtclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAtclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAtclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAtclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TAtclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAtclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAtclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAtclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAtclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAtclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAtclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAtclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAtclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAtclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAtclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1907001}
