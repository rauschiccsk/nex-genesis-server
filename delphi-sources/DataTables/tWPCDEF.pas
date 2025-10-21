unit tWPCDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';

type
  TWpcdefTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadWpsCode:word;          procedure WriteWpsCode (pValue:word);
    function  ReadWpsName:Str120;        procedure WriteWpsName (pValue:Str120);
    function  ReadWpsPrc:double;         procedure WriteWpsPrc (pValue:double);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadValType:Str1;          procedure WriteValType (pValue:Str1);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
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
    function LocateItmNum (pItmNum:word):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property WpsCode:word read ReadWpsCode write WriteWpsCode;
    property WpsName:Str120 read ReadWpsName write WriteWpsName;
    property WpsPrc:double read ReadWpsPrc write WriteWpsPrc;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property ValType:Str1 read ReadValType write WriteValType;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TWpcdefTmp.Create;
begin
  oTmpTable := TmpInit ('WPCDEF',Self);
end;

destructor TWpcdefTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TWpcdefTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TWpcdefTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TWpcdefTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TWpcdefTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TWpcdefTmp.ReadWpsCode:word;
begin
  Result := oTmpTable.FieldByName('WpsCode').AsInteger;
end;

procedure TWpcdefTmp.WriteWpsCode(pValue:word);
begin
  oTmpTable.FieldByName('WpsCode').AsInteger := pValue;
end;

function TWpcdefTmp.ReadWpsName:Str120;
begin
  Result := oTmpTable.FieldByName('WpsName').AsString;
end;

procedure TWpcdefTmp.WriteWpsName(pValue:Str120);
begin
  oTmpTable.FieldByName('WpsName').AsString := pValue;
end;

function TWpcdefTmp.ReadWpsPrc:double;
begin
  Result := oTmpTable.FieldByName('WpsPrc').AsFloat;
end;

procedure TWpcdefTmp.WriteWpsPrc(pValue:double);
begin
  oTmpTable.FieldByName('WpsPrc').AsFloat := pValue;
end;

function TWpcdefTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TWpcdefTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TWpcdefTmp.ReadValType:Str1;
begin
  Result := oTmpTable.FieldByName('ValType').AsString;
end;

procedure TWpcdefTmp.WriteValType(pValue:Str1);
begin
  oTmpTable.FieldByName('ValType').AsString := pValue;
end;

function TWpcdefTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TWpcdefTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TWpcdefTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TWpcdefTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWpcdefTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWpcdefTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWpcdefTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWpcdefTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWpcdefTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TWpcdefTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TWpcdefTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWpcdefTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWpcdefTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWpcdefTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWpcdefTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TWpcdefTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWpcdefTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TWpcdefTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TWpcdefTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TWpcdefTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TWpcdefTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TWpcdefTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TWpcdefTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TWpcdefTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TWpcdefTmp.First;
begin
  oTmpTable.First;
end;

procedure TWpcdefTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TWpcdefTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TWpcdefTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TWpcdefTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TWpcdefTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TWpcdefTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TWpcdefTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TWpcdefTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TWpcdefTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TWpcdefTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TWpcdefTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
