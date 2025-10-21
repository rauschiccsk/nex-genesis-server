unit bCRDGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';
  ixGrpName = 'GrpName';

type
  TCrdgrpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:longint;        procedure WriteGrpNum (pValue:longint);
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
    function LocateGrpNum (pGrpNum:longint):boolean;
    function LocateGrpName (pGrpName_:Str30):boolean;
    function NearestGrpNum (pGrpNum:longint):boolean;
    function NearestGrpName (pGrpName_:Str30):boolean;

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
    property GrpNum:longint read ReadGrpNum write WriteGrpNum;
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

constructor TCrdgrpBtr.Create;
begin
  oBtrTable := BtrInit ('CRDGRP',gPath.DlsPath,Self);
end;

constructor TCrdgrpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRDGRP',pPath,Self);
end;

destructor TCrdgrpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdgrpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrdgrpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrdgrpBtr.ReadGrpNum:longint;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TCrdgrpBtr.WriteGrpNum(pValue:longint);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TCrdgrpBtr.ReadGrpName:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TCrdgrpBtr.WriteGrpName(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TCrdgrpBtr.ReadGrpName_:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName_').AsString;
end;

procedure TCrdgrpBtr.WriteGrpName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName_').AsString := pValue;
end;

function TCrdgrpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdgrpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdgrpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdgrpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdgrpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdgrpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrdgrpBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCrdgrpBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCrdgrpBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCrdgrpBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCrdgrpBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCrdgrpBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdgrpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdgrpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrdgrpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdgrpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrdgrpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrdgrpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrdgrpBtr.LocateGrpNum (pGrpNum:longint):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TCrdgrpBtr.LocateGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindKey([StrToAlias(pGrpName_)]);
end;

function TCrdgrpBtr.NearestGrpNum (pGrpNum:longint):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TCrdgrpBtr.NearestGrpName (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName);
  Result := oBtrTable.FindNearest([pGrpName_]);
end;

procedure TCrdgrpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrdgrpBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrdgrpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrdgrpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrdgrpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrdgrpBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrdgrpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrdgrpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrdgrpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrdgrpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrdgrpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrdgrpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrdgrpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrdgrpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrdgrpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrdgrpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrdgrpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
