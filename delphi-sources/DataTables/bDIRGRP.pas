unit bDIRGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';
  ixGrpName = 'GrpName';

type
  TDirgrpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str30;         procedure WriteGrpName (pValue:Str30);
    function  ReadGrpName_:Str30;        procedure WriteGrpName_ (pValue:Str30);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrpName (pGrpName_:Str30):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;
    function NearestGrpName (pGrpName_:Str30):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property GrpName_:Str30 read ReadGrpName_ write WriteGrpName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDirgrpBtr.Create;
begin
  oBtrTable := BtrInit ('DIRGRP',gPath.DlsPath,Self);
end;

constructor TDirgrpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRGRP',pPath,Self);
end;

destructor TDirgrpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirgrpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirgrpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirgrpBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TDirgrpBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TDirgrpBtr.ReadGrpName:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TDirgrpBtr.WriteGrpName(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TDirgrpBtr.ReadGrpName_:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName_').AsString;
end;

procedure TDirgrpBtr.WriteGrpName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName_').AsString := pValue;
end;

function TDirgrpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDirgrpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirgrpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirgrpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirgrpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirgrpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirgrpBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirgrpBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirgrpBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirgrpBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirgrpBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirgrpBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirgrpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirgrpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirgrpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirgrpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirgrpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirgrpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirgrpBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TDirgrpBtr.LocateGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindKey([StrToAlias(pGrpName_)]);
end;

function TDirgrpBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TDirgrpBtr.NearestGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindNearest([pGrpName_]);
end;

procedure TDirgrpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirgrpBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirgrpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirgrpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirgrpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirgrpBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirgrpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirgrpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirgrpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirgrpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirgrpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirgrpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirgrpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirgrpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirgrpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirgrpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirgrpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
