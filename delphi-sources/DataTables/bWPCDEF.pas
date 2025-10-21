unit bWPCDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpgNum = 'EpgNum';
  ixEnWc = 'EnWc';

type
  TWpcdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
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
    function  ReadItmSrc:Str2;           procedure WriteItmSrc (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEpgNum (pEpgNum:word):boolean;
    function LocateEnWc (pEpgNum:word;pWpsCode:word):boolean;
    function NearestEpgNum (pEpgNum:word):boolean;
    function NearestEnWc (pEpgNum:word;pWpsCode:word):boolean;

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
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
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
    property ItmSrc:Str2 read ReadItmSrc write WriteItmSrc;
  end;

implementation

constructor TWpcdefBtr.Create;
begin
  oBtrTable := BtrInit ('WPCDEF',gPath.LdgPath,Self);
end;

constructor TWpcdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WPCDEF',pPath,Self);
end;

destructor TWpcdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWpcdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWpcdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWpcdefBtr.ReadEpgNum:word;
begin
  Result := oBtrTable.FieldByName('EpgNum').AsInteger;
end;

procedure TWpcdefBtr.WriteEpgNum(pValue:word);
begin
  oBtrTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TWpcdefBtr.ReadWpsCode:word;
begin
  Result := oBtrTable.FieldByName('WpsCode').AsInteger;
end;

procedure TWpcdefBtr.WriteWpsCode(pValue:word);
begin
  oBtrTable.FieldByName('WpsCode').AsInteger := pValue;
end;

function TWpcdefBtr.ReadWpsName:Str120;
begin
  Result := oBtrTable.FieldByName('WpsName').AsString;
end;

procedure TWpcdefBtr.WriteWpsName(pValue:Str120);
begin
  oBtrTable.FieldByName('WpsName').AsString := pValue;
end;

function TWpcdefBtr.ReadWpsPrc:double;
begin
  Result := oBtrTable.FieldByName('WpsPrc').AsFloat;
end;

procedure TWpcdefBtr.WriteWpsPrc(pValue:double);
begin
  oBtrTable.FieldByName('WpsPrc').AsFloat := pValue;
end;

function TWpcdefBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TWpcdefBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TWpcdefBtr.ReadValType:Str1;
begin
  Result := oBtrTable.FieldByName('ValType').AsString;
end;

procedure TWpcdefBtr.WriteValType(pValue:Str1);
begin
  oBtrTable.FieldByName('ValType').AsString := pValue;
end;

function TWpcdefBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TWpcdefBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TWpcdefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWpcdefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWpcdefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWpcdefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWpcdefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWpcdefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWpcdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWpcdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWpcdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWpcdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWpcdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWpcdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWpcdefBtr.ReadItmSrc:Str2;
begin
  Result := oBtrTable.FieldByName('ItmSrc').AsString;
end;

procedure TWpcdefBtr.WriteItmSrc(pValue:Str2);
begin
  oBtrTable.FieldByName('ItmSrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWpcdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWpcdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWpcdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWpcdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWpcdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWpcdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWpcdefBtr.LocateEpgNum (pEpgNum:word):boolean;
begin
  SetIndex (ixEpgNum);
  Result := oBtrTable.FindKey([pEpgNum]);
end;

function TWpcdefBtr.LocateEnWc (pEpgNum:word;pWpsCode:word):boolean;
begin
  SetIndex (ixEnWc);
  Result := oBtrTable.FindKey([pEpgNum,pWpsCode]);
end;

function TWpcdefBtr.NearestEpgNum (pEpgNum:word):boolean;
begin
  SetIndex (ixEpgNum);
  Result := oBtrTable.FindNearest([pEpgNum]);
end;

function TWpcdefBtr.NearestEnWc (pEpgNum:word;pWpsCode:word):boolean;
begin
  SetIndex (ixEnWc);
  Result := oBtrTable.FindNearest([pEpgNum,pWpsCode]);
end;

procedure TWpcdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWpcdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TWpcdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWpcdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWpcdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWpcdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TWpcdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWpcdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWpcdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWpcdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWpcdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWpcdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWpcdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWpcdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWpcdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWpcdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWpcdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
