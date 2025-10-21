unit bPRILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmCode = 'ItmCode';
  ixItmName = 'ItmName';

type
  TPrilstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmCode:Str15;         procedure WriteItmCode (pValue:Str15);
    function  ReadItmName:Str60;         procedure WriteItmName (pValue:Str60);
    function  ReadItmName_:Str60;        procedure WriteItmName_ (pValue:Str60);
    function  ReadUniQnt:word;           procedure WriteUniQnt (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
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
    function LocateItmCode (pItmCode:Str15):boolean;
    function LocateItmName (pItmName_:Str60):boolean;
    function NearestItmCode (pItmCode:Str15):boolean;
    function NearestItmName (pItmName_:Str60):boolean;

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
    property ItmCode:Str15 read ReadItmCode write WriteItmCode;
    property ItmName:Str60 read ReadItmName write WriteItmName;
    property ItmName_:Str60 read ReadItmName_ write WriteItmName_;
    property UniQnt:word read ReadUniQnt write WriteUniQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPrilstBtr.Create;
begin
  oBtrTable := BtrInit ('PRILST',gPath.DlsPath,Self);
end;

constructor TPrilstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRILST',pPath,Self);
end;

destructor TPrilstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrilstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrilstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrilstBtr.ReadItmCode:Str15;
begin
  Result := oBtrTable.FieldByName('ItmCode').AsString;
end;

procedure TPrilstBtr.WriteItmCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ItmCode').AsString := pValue;
end;

function TPrilstBtr.ReadItmName:Str60;
begin
  Result := oBtrTable.FieldByName('ItmName').AsString;
end;

procedure TPrilstBtr.WriteItmName(pValue:Str60);
begin
  oBtrTable.FieldByName('ItmName').AsString := pValue;
end;

function TPrilstBtr.ReadItmName_:Str60;
begin
  Result := oBtrTable.FieldByName('ItmName_').AsString;
end;

procedure TPrilstBtr.WriteItmName_(pValue:Str60);
begin
  oBtrTable.FieldByName('ItmName_').AsString := pValue;
end;

function TPrilstBtr.ReadUniQnt:word;
begin
  Result := oBtrTable.FieldByName('UniQnt').AsInteger;
end;

procedure TPrilstBtr.WriteUniQnt(pValue:word);
begin
  oBtrTable.FieldByName('UniQnt').AsInteger := pValue;
end;

function TPrilstBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPrilstBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPrilstBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TPrilstBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TPrilstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPrilstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPrilstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPrilstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPrilstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPrilstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPrilstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPrilstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPrilstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPrilstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrilstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrilstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrilstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrilstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrilstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrilstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrilstBtr.LocateItmCode (pItmCode:Str15):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindKey([pItmCode]);
end;

function TPrilstBtr.LocateItmName (pItmName_:Str60):boolean;
begin
  SetIndex (ixItmName);
  Result := oBtrTable.FindKey([StrToAlias(pItmName_)]);
end;

function TPrilstBtr.NearestItmCode (pItmCode:Str15):boolean;
begin
  SetIndex (ixItmCode);
  Result := oBtrTable.FindNearest([pItmCode]);
end;

function TPrilstBtr.NearestItmName (pItmName_:Str60):boolean;
begin
  SetIndex (ixItmName);
  Result := oBtrTable.FindNearest([pItmName_]);
end;

procedure TPrilstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrilstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrilstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrilstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrilstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrilstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrilstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrilstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrilstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrilstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrilstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrilstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrilstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrilstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrilstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrilstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrilstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1810001}
