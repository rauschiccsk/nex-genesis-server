unit bFLTDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnIn = 'SnIn';
  ixSectionName = 'SectionName';

type
  TFltdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSectionName:Str60;     procedure WriteSectionName (pValue:Str60);
    function  ReadIdentName:Str60;       procedure WriteIdentName (pValue:Str60);
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
    function LocateSnIn (pSectionName:Str60;pIdentName:Str60):boolean;
    function LocateSectionName (pSectionName:Str60):boolean;
    function NearestSnIn (pSectionName:Str60;pIdentName:Str60):boolean;
    function NearestSectionName (pSectionName:Str60):boolean;

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
    property SectionName:Str60 read ReadSectionName write WriteSectionName;
    property IdentName:Str60 read ReadIdentName write WriteIdentName;
    property KeyValue:Str60 read ReadKeyValue write WriteKeyValue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFltdefBtr.Create;
begin
  oBtrTable := BtrInit ('FLTDEF',gPath.SysPath,Self);
end;

constructor TFltdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FLTDEF',pPath,Self);
end;

destructor TFltdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFltdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFltdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFltdefBtr.ReadSectionName:Str60;
begin
  Result := oBtrTable.FieldByName('SectionName').AsString;
end;

procedure TFltdefBtr.WriteSectionName(pValue:Str60);
begin
  oBtrTable.FieldByName('SectionName').AsString := pValue;
end;

function TFltdefBtr.ReadIdentName:Str60;
begin
  Result := oBtrTable.FieldByName('IdentName').AsString;
end;

procedure TFltdefBtr.WriteIdentName(pValue:Str60);
begin
  oBtrTable.FieldByName('IdentName').AsString := pValue;
end;

function TFltdefBtr.ReadKeyValue:Str60;
begin
  Result := oBtrTable.FieldByName('KeyValue').AsString;
end;

procedure TFltdefBtr.WriteKeyValue(pValue:Str60);
begin
  oBtrTable.FieldByName('KeyValue').AsString := pValue;
end;

function TFltdefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TFltdefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TFltdefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFltdefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFltdefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFltdefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFltdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFltdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFltdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFltdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFltdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFltdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFltdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFltdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFltdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFltdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFltdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFltdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFltdefBtr.LocateSnIn (pSectionName:Str60;pIdentName:Str60):boolean;
begin
  SetIndex (ixSnIn);
  Result := oBtrTable.FindKey([pSectionName,pIdentName]);
end;

function TFltdefBtr.LocateSectionName (pSectionName:Str60):boolean;
begin
  SetIndex (ixSectionName);
  Result := oBtrTable.FindKey([pSectionName]);
end;

function TFltdefBtr.NearestSnIn (pSectionName:Str60;pIdentName:Str60):boolean;
begin
  SetIndex (ixSnIn);
  Result := oBtrTable.FindNearest([pSectionName,pIdentName]);
end;

function TFltdefBtr.NearestSectionName (pSectionName:Str60):boolean;
begin
  SetIndex (ixSectionName);
  Result := oBtrTable.FindNearest([pSectionName]);
end;

procedure TFltdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFltdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFltdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFltdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFltdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFltdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TFltdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFltdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFltdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFltdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFltdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFltdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFltdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFltdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFltdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFltdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFltdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
