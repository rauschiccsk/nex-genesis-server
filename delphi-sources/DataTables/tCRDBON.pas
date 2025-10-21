unit tCRDBON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixOutDate = 'OutDate';

type
  TCrdbonTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadOutDate:TDatetime;     procedure WriteOutDate (pValue:TDatetime);
    function  ReadOutQnt:word;           procedure WriteOutQnt (pValue:word);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateOutDate (pOutDate:TDatetime):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property OutDate:TDatetime read ReadOutDate write WriteOutDate;
    property OutQnt:word read ReadOutQnt write WriteOutQnt;
    property ActPos:longint read ReadActPos write WriteActPos;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TCrdbonTmp.Create;
begin
  oTmpTable := TmpInit ('CRDBON',Self);
end;

destructor TCrdbonTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdbonTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCrdbonTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCrdbonTmp.ReadSerNum:word;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TCrdbonTmp.WriteSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCrdbonTmp.ReadOutDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OutDate').AsDateTime;
end;

procedure TCrdbonTmp.WriteOutDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutDate').AsDateTime := pValue;
end;

function TCrdbonTmp.ReadOutQnt:word;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsInteger;
end;

procedure TCrdbonTmp.WriteOutQnt(pValue:word);
begin
  oTmpTable.FieldByName('OutQnt').AsInteger := pValue;
end;

function TCrdbonTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TCrdbonTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TCrdbonTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdbonTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdbonTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdbonTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdbonTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdbonTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdbonTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCrdbonTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCrdbonTmp.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TCrdbonTmp.LocateOutDate (pOutDate:TDatetime):boolean;
begin
  SetIndex (ixOutDate);
  Result := oTmpTable.FindKey([pOutDate]);
end;

procedure TCrdbonTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCrdbonTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCrdbonTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCrdbonTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCrdbonTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCrdbonTmp.First;
begin
  oTmpTable.First;
end;

procedure TCrdbonTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCrdbonTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCrdbonTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCrdbonTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCrdbonTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCrdbonTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCrdbonTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCrdbonTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCrdbonTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCrdbonTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCrdbonTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
