unit bIMPDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnIn = 'SnIn';
  ixSectionName = 'SectionName';

type
  TImpdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSectionName:Str50;     procedure WriteSectionName (pValue:Str50);
    function  ReadIdentName:Str50;       procedure WriteIdentName (pValue:Str50);
    function  ReadKeyValue:Str60;        procedure WriteKeyValue (pValue:Str60);
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
    function LocateSnIn (pSectionName:Str50;pIdentName:Str50):boolean;
    function LocateSectionName (pSectionName:Str50):boolean;
    function NearestSnIn (pSectionName:Str50;pIdentName:Str50):boolean;
    function NearestSectionName (pSectionName:Str50):boolean;

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
    property SectionName:Str50 read ReadSectionName write WriteSectionName;
    property IdentName:Str50 read ReadIdentName write WriteIdentName;
    property KeyValue:Str60 read ReadKeyValue write WriteKeyValue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TImpdefBtr.Create;
begin
  oBtrTable := BtrInit ('IMPDEF',gPath.SysPath,Self);
end;

constructor TImpdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IMPDEF',pPath,Self);
end;

destructor TImpdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TImpdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TImpdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TImpdefBtr.ReadSectionName:Str50;
begin
  Result := oBtrTable.FieldByName('SectionName').AsString;
end;

procedure TImpdefBtr.WriteSectionName(pValue:Str50);
begin
  oBtrTable.FieldByName('SectionName').AsString := pValue;
end;

function TImpdefBtr.ReadIdentName:Str50;
begin
  Result := oBtrTable.FieldByName('IdentName').AsString;
end;

procedure TImpdefBtr.WriteIdentName(pValue:Str50);
begin
  oBtrTable.FieldByName('IdentName').AsString := pValue;
end;

function TImpdefBtr.ReadKeyValue:Str60;
begin
  Result := oBtrTable.FieldByName('KeyValue').AsString;
end;

procedure TImpdefBtr.WriteKeyValue(pValue:Str60);
begin
  oBtrTable.FieldByName('KeyValue').AsString := pValue;
end;

function TImpdefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TImpdefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TImpdefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TImpdefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TImpdefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TImpdefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TImpdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TImpdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TImpdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TImpdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TImpdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TImpdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImpdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImpdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TImpdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImpdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TImpdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TImpdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TImpdefBtr.LocateSnIn (pSectionName:Str50;pIdentName:Str50):boolean;
begin
  SetIndex (ixSnIn);
  Result := oBtrTable.FindKey([pSectionName,pIdentName]);
end;

function TImpdefBtr.LocateSectionName (pSectionName:Str50):boolean;
begin
  SetIndex (ixSectionName);
  Result := oBtrTable.FindKey([pSectionName]);
end;

function TImpdefBtr.NearestSnIn (pSectionName:Str50;pIdentName:Str50):boolean;
begin
  SetIndex (ixSnIn);
  Result := oBtrTable.FindNearest([pSectionName,pIdentName]);
end;

function TImpdefBtr.NearestSectionName (pSectionName:Str50):boolean;
begin
  SetIndex (ixSectionName);
  Result := oBtrTable.FindNearest([pSectionName]);
end;

procedure TImpdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TImpdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TImpdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TImpdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TImpdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TImpdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TImpdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TImpdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TImpdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TImpdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TImpdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TImpdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TImpdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TImpdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TImpdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TImpdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TImpdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
