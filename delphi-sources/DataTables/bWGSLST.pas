unit bWGSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSecNum = 'SecNum';

type
  TWgslstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSecNum:word;           procedure WriteSecNum (pValue:word);
    function  ReadSecName:Str30;         procedure WriteSecName (pValue:Str30);
    function  ReadWghType:byte;          procedure WriteWghType (pValue:byte);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadDelEnab:byte;          procedure WriteDelEnab (pValue:byte);
    function  ReadWgNums:Str80;          procedure WriteWgNums (pValue:Str80);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateSecNum (pSecNum:word):boolean;
    function NearestSecNum (pSecNum:word):boolean;

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
    property SecNum:word read ReadSecNum write WriteSecNum;
    property SecName:Str30 read ReadSecName write WriteSecName;
    property WghType:byte read ReadWghType write WriteWghType;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property DelEnab:byte read ReadDelEnab write WriteDelEnab;
    property WgNums:Str80 read ReadWgNums write WriteWgNums;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TWgslstBtr.Create;
begin
  oBtrTable := BtrInit ('WGSLST',gPath.DlsPath,Self);
end;

constructor TWgslstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WGSLST',pPath,Self);
end;

destructor TWgslstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWgslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWgslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWgslstBtr.ReadSecNum:word;
begin
  Result := oBtrTable.FieldByName('SecNum').AsInteger;
end;

procedure TWgslstBtr.WriteSecNum(pValue:word);
begin
  oBtrTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TWgslstBtr.ReadSecName:Str30;
begin
  Result := oBtrTable.FieldByName('SecName').AsString;
end;

procedure TWgslstBtr.WriteSecName(pValue:Str30);
begin
  oBtrTable.FieldByName('SecName').AsString := pValue;
end;

function TWgslstBtr.ReadWghType:byte;
begin
  Result := oBtrTable.FieldByName('WghType').AsInteger;
end;

procedure TWgslstBtr.WriteWghType(pValue:byte);
begin
  oBtrTable.FieldByName('WghType').AsInteger := pValue;
end;

function TWgslstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TWgslstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TWgslstBtr.ReadDelEnab:byte;
begin
  Result := oBtrTable.FieldByName('DelEnab').AsInteger;
end;

procedure TWgslstBtr.WriteDelEnab(pValue:byte);
begin
  oBtrTable.FieldByName('DelEnab').AsInteger := pValue;
end;

function TWgslstBtr.ReadWgNums:Str80;
begin
  Result := oBtrTable.FieldByName('WgNums').AsString;
end;

procedure TWgslstBtr.WriteWgNums(pValue:Str80);
begin
  oBtrTable.FieldByName('WgNums').AsString := pValue;
end;

function TWgslstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWgslstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWgslstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWgslstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWgslstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWgslstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWgslstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TWgslstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TWgslstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWgslstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWgslstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWgslstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWgslstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWgslstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWgslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgslstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWgslstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWgslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWgslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWgslstBtr.LocateSecNum (pSecNum:word):boolean;
begin
  SetIndex (ixSecNum);
  Result := oBtrTable.FindKey([pSecNum]);
end;

function TWgslstBtr.NearestSecNum (pSecNum:word):boolean;
begin
  SetIndex (ixSecNum);
  Result := oBtrTable.FindNearest([pSecNum]);
end;

procedure TWgslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWgslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TWgslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWgslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWgslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWgslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TWgslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWgslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWgslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWgslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWgslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWgslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWgslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWgslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWgslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWgslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWgslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
