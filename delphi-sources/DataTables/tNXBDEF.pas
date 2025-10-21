unit tNXBDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmBn = '';

type
  TNxbdefTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadBookType:Str1;         procedure WriteBookType (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
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
    function LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;

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
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property BookType:Str1 read ReadBookType write WriteBookType;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TNxbdefTmp.Create;
begin
  oTmpTable := TmpInit ('NXBDEF',Self);
end;

destructor TNxbdefTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNxbdefTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNxbdefTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TNxbdefTmp.ReadPmdMark:Str3;
begin
  Result := oTmpTable.FieldByName('PmdMark').AsString;
end;

procedure TNxbdefTmp.WritePmdMark(pValue:Str3);
begin
  oTmpTable.FieldByName('PmdMark').AsString := pValue;
end;

function TNxbdefTmp.ReadBookNum:Str5;
begin
  Result := oTmpTable.FieldByName('BookNum').AsString;
end;

procedure TNxbdefTmp.WriteBookNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BookNum').AsString := pValue;
end;

function TNxbdefTmp.ReadBookName:Str30;
begin
  Result := oTmpTable.FieldByName('BookName').AsString;
end;

procedure TNxbdefTmp.WriteBookName(pValue:Str30);
begin
  oTmpTable.FieldByName('BookName').AsString := pValue;
end;

function TNxbdefTmp.ReadBookType:Str1;
begin
  Result := oTmpTable.FieldByName('BookType').AsString;
end;

procedure TNxbdefTmp.WriteBookType(pValue:Str1);
begin
  oTmpTable.FieldByName('BookType').AsString := pValue;
end;

function TNxbdefTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TNxbdefTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TNxbdefTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TNxbdefTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TNxbdefTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TNxbdefTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TNxbdefTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TNxbdefTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TNxbdefTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TNxbdefTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TNxbdefTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TNxbdefTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TNxbdefTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TNxbdefTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxbdefTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNxbdefTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TNxbdefTmp.LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oTmpTable.FindKey([pPmdMark,pBookNum]);
end;

procedure TNxbdefTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNxbdefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TNxbdefTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TNxbdefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNxbdefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TNxbdefTmp.First;
begin
  oTmpTable.First;
end;

procedure TNxbdefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TNxbdefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNxbdefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNxbdefTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TNxbdefTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TNxbdefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNxbdefTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TNxbdefTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TNxbdefTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TNxbdefTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TNxbdefTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
