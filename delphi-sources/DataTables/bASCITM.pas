unit bASCITM;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';

type
  TAscitmBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocType:Str2;          procedure WriteDocType (pValue:Str2);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadAcValue:double;        procedure WriteAcValue (pValue:double);
    function  ReadFgValue:double;        procedure WriteFgValue (pValue:double);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadExdQnt:integer;        procedure WriteExdQnt (pValue:integer);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocType:Str2 read ReadDocType write WriteDocType;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property AcValue:double read ReadAcValue write WriteAcValue;
    property FgValue:double read ReadFgValue write WriteFgValue;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property ExdQnt:integer read ReadExdQnt write WriteExdQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TAscitmBtr.Create;
begin
  oBtrTable := BtrInit ('ASCITM',gPath.LdgPath,Self);
end;

destructor  TAscitmBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAscitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAscitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAscitmBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAscitmBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAscitmBtr.ReadDocType:Str2;
begin
  Result := oBtrTable.FieldByName('DocType').AsString;
end;

procedure TAscitmBtr.WriteDocType(pValue:Str2);
begin
  oBtrTable.FieldByName('DocType').AsString := pValue;
end;

function TAscitmBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAscitmBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAscitmBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAscitmBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAscitmBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAscitmBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAscitmBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAscitmBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAscitmBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAscitmBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAscitmBtr.ReadAcValue:double;
begin
  Result := oBtrTable.FieldByName('AcValue').AsFloat;
end;

procedure TAscitmBtr.WriteAcValue(pValue:double);
begin
  oBtrTable.FieldByName('AcValue').AsFloat := pValue;
end;

function TAscitmBtr.ReadFgValue:double;
begin
  Result := oBtrTable.FieldByName('FgValue').AsFloat;
end;

procedure TAscitmBtr.WriteFgValue(pValue:double);
begin
  oBtrTable.FieldByName('FgValue').AsFloat := pValue;
end;

function TAscitmBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAscitmBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAscitmBtr.ReadExdQnt:integer;
begin
  Result := oBtrTable.FieldByName('ExdQnt').AsVariant;
end;

procedure TAscitmBtr.WriteExdQnt(pValue:integer);
begin
  oBtrTable.FieldByName('ExdQnt').AsVariant := pValue;
end;

function TAscitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAscitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAscitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAscitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAscitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAscitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAscitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAscitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAscitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAscitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAscitmBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

procedure TAscitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAscitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAscitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAscitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAscitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAscitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TAscitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAscitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAscitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAscitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAscitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAscitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAscitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAscitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAscitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAscitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAscitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
