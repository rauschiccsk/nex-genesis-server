unit bDIRSUB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnSf = 'SnSf';
  ixSerNum = 'SerNum';

type
  TDirsubBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadSubFld:Str10;          procedure WriteSubFld (pValue:Str10);
    function  ReadSubDat:Str30;          procedure WriteSubDat (pValue:Str30);
    function  ReadSubNot:Str60;          procedure WriteSubNot (pValue:Str60);
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
    function LocateSnSf (pSerNum:word;pSubFld:Str10):boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function NearestSnSf (pSerNum:word;pSubFld:Str10):boolean;
    function NearestSerNum (pSerNum:word):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property SubFld:Str10 read ReadSubFld write WriteSubFld;
    property SubDat:Str30 read ReadSubDat write WriteSubDat;
    property SubNot:Str60 read ReadSubNot write WriteSubNot;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDirsubBtr.Create;
begin
  oBtrTable := BtrInit ('DIRSUB',gPath.DlsPath,Self);
end;

constructor TDirsubBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRSUB',pPath,Self);
end;

destructor TDirsubBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirsubBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirsubBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirsubBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TDirsubBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TDirsubBtr.ReadSubFld:Str10;
begin
  Result := oBtrTable.FieldByName('SubFld').AsString;
end;

procedure TDirsubBtr.WriteSubFld(pValue:Str10);
begin
  oBtrTable.FieldByName('SubFld').AsString := pValue;
end;

function TDirsubBtr.ReadSubDat:Str30;
begin
  Result := oBtrTable.FieldByName('SubDat').AsString;
end;

procedure TDirsubBtr.WriteSubDat(pValue:Str30);
begin
  oBtrTable.FieldByName('SubDat').AsString := pValue;
end;

function TDirsubBtr.ReadSubNot:Str60;
begin
  Result := oBtrTable.FieldByName('SubNot').AsString;
end;

procedure TDirsubBtr.WriteSubNot(pValue:Str60);
begin
  oBtrTable.FieldByName('SubNot').AsString := pValue;
end;

function TDirsubBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDirsubBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirsubBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirsubBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirsubBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirsubBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirsubBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirsubBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirsubBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirsubBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirsubBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirsubBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirsubBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirsubBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirsubBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirsubBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirsubBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirsubBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirsubBtr.LocateSnSf (pSerNum:word;pSubFld:Str10):boolean;
begin
  SetIndex (ixSnSf);
  Result := oBtrTable.FindKey([pSerNum,pSubFld]);
end;

function TDirsubBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TDirsubBtr.NearestSnSf (pSerNum:word;pSubFld:Str10):boolean;
begin
  SetIndex (ixSnSf);
  Result := oBtrTable.FindNearest([pSerNum,pSubFld]);
end;

function TDirsubBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

procedure TDirsubBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirsubBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirsubBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirsubBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirsubBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirsubBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirsubBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirsubBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirsubBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirsubBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirsubBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirsubBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirsubBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirsubBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirsubBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirsubBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirsubBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
