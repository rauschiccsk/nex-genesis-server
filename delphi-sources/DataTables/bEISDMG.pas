unit bEISDMG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMgCode = 'MgCode';
  ixMgName = 'MgName';

type
  TEisdmgBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadMgName_:Str15;         procedure WriteMgName_ (pValue:Str15);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDisWeb1:Str1;          procedure WriteDisWeb1 (pValue:Str1);
    function  ReadDisWeb2:Str1;          procedure WriteDisWeb2 (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateMgName (pMgName_:Str15):boolean;
    function NearestMgCode (pMgCode:longint):boolean;
    function NearestMgName (pMgName_:Str15):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property MgName_:Str15 read ReadMgName_ write WriteMgName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DisWeb1:Str1 read ReadDisWeb1 write WriteDisWeb1;
    property DisWeb2:Str1 read ReadDisWeb2 write WriteDisWeb2;
  end;

implementation

constructor TEisdmgBtr.Create;
begin
  oBtrTable := BtrInit ('EISDMG',gPath.StkPath,Self);
end;

constructor TEisdmgBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EISDMG',pPath,Self);
end;

destructor TEisdmgBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEisdmgBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEisdmgBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEisdmgBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TEisdmgBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TEisdmgBtr.ReadMgName:Str30;
begin
  Result := oBtrTable.FieldByName('MgName').AsString;
end;

procedure TEisdmgBtr.WriteMgName(pValue:Str30);
begin
  oBtrTable.FieldByName('MgName').AsString := pValue;
end;

function TEisdmgBtr.ReadMgName_:Str15;
begin
  Result := oBtrTable.FieldByName('MgName_').AsString;
end;

procedure TEisdmgBtr.WriteMgName_(pValue:Str15);
begin
  oBtrTable.FieldByName('MgName_').AsString := pValue;
end;

function TEisdmgBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TEisdmgBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TEisdmgBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TEisdmgBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TEisdmgBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TEisdmgBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TEisdmgBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TEisdmgBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TEisdmgBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TEisdmgBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TEisdmgBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TEisdmgBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TEisdmgBtr.ReadDisWeb1:Str1;
begin
  Result := oBtrTable.FieldByName('DisWeb1').AsString;
end;

procedure TEisdmgBtr.WriteDisWeb1(pValue:Str1);
begin
  oBtrTable.FieldByName('DisWeb1').AsString := pValue;
end;

function TEisdmgBtr.ReadDisWeb2:Str1;
begin
  Result := oBtrTable.FieldByName('DisWeb2').AsString;
end;

procedure TEisdmgBtr.WriteDisWeb2(pValue:Str1);
begin
  oBtrTable.FieldByName('DisWeb2').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEisdmgBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEisdmgBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEisdmgBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEisdmgBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEisdmgBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEisdmgBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEisdmgBtr.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindKey([pMgCode]);
end;

function TEisdmgBtr.LocateMgName (pMgName_:Str15):boolean;
begin
  SetIndex (ixMgName);
  Result := oBtrTable.FindKey([StrToAlias(pMgName_)]);
end;

function TEisdmgBtr.NearestMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oBtrTable.FindNearest([pMgCode]);
end;

function TEisdmgBtr.NearestMgName (pMgName_:Str15):boolean;
begin
  SetIndex (ixMgName);
  Result := oBtrTable.FindNearest([pMgName_]);
end;

procedure TEisdmgBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEisdmgBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEisdmgBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEisdmgBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEisdmgBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEisdmgBtr.First;
begin
  oBtrTable.First;
end;

procedure TEisdmgBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEisdmgBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEisdmgBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEisdmgBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEisdmgBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEisdmgBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEisdmgBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEisdmgBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEisdmgBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEisdmgBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEisdmgBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
