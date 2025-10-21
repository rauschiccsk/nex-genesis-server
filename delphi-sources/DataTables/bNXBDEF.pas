unit bNXBDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmdMark = 'PmdMark';
  ixPmBn = 'PmBn';

type
  TNxbdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadBookType:Str1;         procedure WriteBookType (pValue:Str1);
    function  ReadReserved:Str2;         procedure WriteReserved (pValue:Str2);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePmdMark (pPmdMark:Str3):boolean;
    function LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
    function NearestPmdMark (pPmdMark:Str3):boolean;
    function NearestPmBn (pPmdMark:Str3;pBookNum:Str5):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property BookType:Str1 read ReadBookType write WriteBookType;
    property Reserved:Str2 read ReadReserved write WriteReserved;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TNxbdefBtr.Create;
begin
  oBtrTable := BtrInit ('NXBDEF',gPath.SysPath,Self);
end;

constructor TNxbdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('NXBDEF',pPath,Self);
end;

destructor TNxbdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TNxbdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TNxbdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TNxbdefBtr.ReadPmdMark:Str3;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TNxbdefBtr.WritePmdMark(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TNxbdefBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TNxbdefBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TNxbdefBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TNxbdefBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TNxbdefBtr.ReadBookType:Str1;
begin
  Result := oBtrTable.FieldByName('BookType').AsString;
end;

procedure TNxbdefBtr.WriteBookType(pValue:Str1);
begin
  oBtrTable.FieldByName('BookType').AsString := pValue;
end;

function TNxbdefBtr.ReadReserved:Str2;
begin
  Result := oBtrTable.FieldByName('Reserved').AsString;
end;

procedure TNxbdefBtr.WriteReserved(pValue:Str2);
begin
  oBtrTable.FieldByName('Reserved').AsString := pValue;
end;

function TNxbdefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TNxbdefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TNxbdefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TNxbdefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TNxbdefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TNxbdefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TNxbdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TNxbdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TNxbdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TNxbdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TNxbdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TNxbdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxbdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TNxbdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TNxbdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TNxbdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TNxbdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TNxbdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TNxbdefBtr.LocatePmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindKey([pPmdMark]);
end;

function TNxbdefBtr.LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oBtrTable.FindKey([pPmdMark,pBookNum]);
end;

function TNxbdefBtr.NearestPmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindNearest([pPmdMark]);
end;

function TNxbdefBtr.NearestPmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oBtrTable.FindNearest([pPmdMark,pBookNum]);
end;

procedure TNxbdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TNxbdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TNxbdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TNxbdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TNxbdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TNxbdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TNxbdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TNxbdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TNxbdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TNxbdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TNxbdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TNxbdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TNxbdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TNxbdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TNxbdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TNxbdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TNxbdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
