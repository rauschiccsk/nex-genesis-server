unit bPmblst;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';
  ixBookName = 'BookName';

type
  TPmblstBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadBookName_:Str30;       procedure WriteBookName_ (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadResByte:byte;          procedure WriteResByte (pValue:byte);
    function  ReadActPos:word;           procedure WriteActPos (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function LocateBookName (pBookName_:Str30):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property BookName_:Str30 read ReadBookName_ write WriteBookName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Shared:boolean read ReadShared write WriteShared;
    property ResByte:byte read ReadResByte write WriteResByte;
  end;

implementation

constructor TPmblstBtr.Create;
begin
  oBtrTable := BtrInit ('PMBLST',gPath.LdgPath,Self);
end;

destructor TPmblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPmblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPmblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPmblstBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TPmblstBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TPmblstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TPmblstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TPmblstBtr.ReadBookName_:Str30;
begin
  Result := oBtrTable.FieldByName('BookName_').AsString;
end;

procedure TPmblstBtr.WriteBookName_(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName_').AsString := pValue;
end;

function TPmblstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPmblstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPmblstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPmblstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPmblstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPmblstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPmblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPmblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPmblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPmblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPmblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPmblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPmblstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TPmblstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TPmblstBtr.ReadResByte:byte;
begin
  Result := oBtrTable.FieldByName('ResByte').AsInteger;
end;

procedure TPmblstBtr.WriteResByte(pValue:byte);
begin
  oBtrTable.FieldByName('ResByte').AsInteger := pValue;
end;

function TPmblstBtr.ReadActPos:word;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TPmblstBtr.WriteActPos(pValue:word);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPmblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPmblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPmblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPmblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPmblstBtr.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TPmblstBtr.LocateBookName (pBookName_:Str30):boolean;
begin
  SetIndex (ixBookName);
  Result := oBtrTable.FindKey([pBookName_]);
end;

procedure TPmblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPmblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPmblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPmblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPmblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPmblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPmblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPmblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPmblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPmblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPmblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPmblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPmblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPmblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPmblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPmblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPmblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
