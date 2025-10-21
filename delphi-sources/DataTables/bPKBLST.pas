unit bPKBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';

type
  TPkblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadBookYear:Str4;         procedure WriteBookYear (pValue:Str4);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadPlsNum:longint;        procedure WritePlsNum (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function NearestBookNum (pBookNum:Str5):boolean;

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
    property BookYear:Str4 read ReadBookYear write WriteBookYear;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Shared:boolean read ReadShared write WriteShared;
    property PlsNum:longint read ReadPlsNum write WritePlsNum;
  end;

implementation

constructor TPkblstBtr.Create;
begin
  oBtrTable := BtrInit ('PKBLST',gPath.StkPath,Self);
end;

constructor TPkblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PKBLST',pPath,Self);
end;

destructor TPkblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPkblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPkblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPkblstBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TPkblstBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TPkblstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TPkblstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TPkblstBtr.ReadBookYear:Str4;
begin
  Result := oBtrTable.FieldByName('BookYear').AsString;
end;

procedure TPkblstBtr.WriteBookYear(pValue:Str4);
begin
  oBtrTable.FieldByName('BookYear').AsString := pValue;
end;

function TPkblstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPkblstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPkblstBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPkblstBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPkblstBtr.ReadScSmCode:word;
begin
  Result := oBtrTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TPkblstBtr.WriteScSmCode(pValue:word);
begin
  oBtrTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TPkblstBtr.ReadTgSmCode:word;
begin
  Result := oBtrTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TPkblstBtr.WriteTgSmCode(pValue:word);
begin
  oBtrTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

function TPkblstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPkblstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkblstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkblstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkblstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkblstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkblstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPkblstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPkblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPkblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPkblstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TPkblstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TPkblstBtr.ReadPlsNum:longint;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TPkblstBtr.WritePlsNum(pValue:longint);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPkblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPkblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPkblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPkblstBtr.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TPkblstBtr.NearestBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindNearest([pBookNum]);
end;

procedure TPkblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPkblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPkblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPkblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPkblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPkblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPkblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPkblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPkblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPkblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPkblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPkblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPkblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPkblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPkblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPkblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPkblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
