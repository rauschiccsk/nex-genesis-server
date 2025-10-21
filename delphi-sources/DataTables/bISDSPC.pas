unit bISDSPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocSpc = 'DocSpc';

type
  TIsdspcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocSpc:word;           procedure WriteDocSpc (pValue:word);
    function  ReadSpcName:Str60;         procedure WriteSpcName (pValue:Str60);
    function  ReadVatSpc:byte;           procedure WriteVatSpc (pValue:byte);
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
    function LocateDocSpc (pDocSpc:word):boolean;
    function NearestDocSpc (pDocSpc:word):boolean;

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
    property DocSpc:word read ReadDocSpc write WriteDocSpc;
    property SpcName:Str60 read ReadSpcName write WriteSpcName;
    property VatSpc:byte read ReadVatSpc write WriteVatSpc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIsdspcBtr.Create;
begin
  oBtrTable := BtrInit ('ISDSPC',gPath.LdgPath,Self);
end;

constructor TIsdspcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ISDSPC',pPath,Self);
end;

destructor TIsdspcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIsdspcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIsdspcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIsdspcBtr.ReadDocSpc:word;
begin
  Result := oBtrTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIsdspcBtr.WriteDocSpc(pValue:word);
begin
  oBtrTable.FieldByName('DocSpc').AsInteger := pValue;
end;

function TIsdspcBtr.ReadSpcName:Str60;
begin
  Result := oBtrTable.FieldByName('SpcName').AsString;
end;

procedure TIsdspcBtr.WriteSpcName(pValue:Str60);
begin
  oBtrTable.FieldByName('SpcName').AsString := pValue;
end;

function TIsdspcBtr.ReadVatSpc:byte;
begin
  Result := oBtrTable.FieldByName('VatSpc').AsInteger;
end;

procedure TIsdspcBtr.WriteVatSpc(pValue:byte);
begin
  oBtrTable.FieldByName('VatSpc').AsInteger := pValue;
end;

function TIsdspcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIsdspcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIsdspcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIsdspcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIsdspcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIsdspcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIsdspcBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIsdspcBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIsdspcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIsdspcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIsdspcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIsdspcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIsdspcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIsdspcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIsdspcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIsdspcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIsdspcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIsdspcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIsdspcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIsdspcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIsdspcBtr.LocateDocSpc (pDocSpc:word):boolean;
begin
  SetIndex (ixDocSpc);
  Result := oBtrTable.FindKey([pDocSpc]);
end;

function TIsdspcBtr.NearestDocSpc (pDocSpc:word):boolean;
begin
  SetIndex (ixDocSpc);
  Result := oBtrTable.FindNearest([pDocSpc]);
end;

procedure TIsdspcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIsdspcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIsdspcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIsdspcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIsdspcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIsdspcBtr.First;
begin
  oBtrTable.First;
end;

procedure TIsdspcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIsdspcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIsdspcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIsdspcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIsdspcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIsdspcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIsdspcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIsdspcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIsdspcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIsdspcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIsdspcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
