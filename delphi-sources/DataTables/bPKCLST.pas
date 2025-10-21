unit bPKCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSgTg = 'SgTg';
  ixScGsCode = 'ScGsCode';
  ixScGsName = 'ScGsName';
  ixScBarCode = 'ScBarCode';
  ixTgGsCode = 'TgGsCode';
  ixTgGsName = 'TgGsName';
  ixTgBarCode = 'TgBarCode';

type
  TPkclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadScGsCode:longint;      procedure WriteScGsCode (pValue:longint);
    function  ReadScGsName:Str30;        procedure WriteScGsName (pValue:Str30);
    function  ReadScGsName_:Str30;       procedure WriteScGsName_ (pValue:Str30);
    function  ReadScBarCode:Str15;       procedure WriteScBarCode (pValue:Str15);
    function  ReadScGsKfc:double;        procedure WriteScGsKfc (pValue:double);
    function  ReadTgGsCode:longint;      procedure WriteTgGsCode (pValue:longint);
    function  ReadTgGsName:Str30;        procedure WriteTgGsName (pValue:Str30);
    function  ReadTgGsName_:Str30;       procedure WriteTgGsName_ (pValue:Str30);
    function  ReadTgBarCode:Str15;       procedure WriteTgBarCode (pValue:Str15);
    function  ReadTgGsKfc:double;        procedure WriteTgGsKfc (pValue:double);
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
    function LocateSgTg (pScGsCode:longint;pTgGsCode:longint):boolean;
    function LocateScGsCode (pScGsCode:longint):boolean;
    function LocateScGsName (pScGsName:Str30):boolean;
    function LocateScBarCode (pScBarCode:Str15):boolean;
    function LocateTgGsCode (pTgGsCode:longint):boolean;
    function LocateTgGsName (pTgGsName:Str30):boolean;
    function LocateTgBarCode (pTgBarCode:Str15):boolean;
    function NearestSgTg (pScGsCode:longint;pTgGsCode:longint):boolean;
    function NearestScGsCode (pScGsCode:longint):boolean;
    function NearestScGsName (pScGsName:Str30):boolean;
    function NearestScBarCode (pScBarCode:Str15):boolean;
    function NearestTgGsCode (pTgGsCode:longint):boolean;
    function NearestTgGsName (pTgGsName:Str30):boolean;
    function NearestTgBarCode (pTgBarCode:Str15):boolean;

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
    property ScGsCode:longint read ReadScGsCode write WriteScGsCode;
    property ScGsName:Str30 read ReadScGsName write WriteScGsName;
    property ScGsName_:Str30 read ReadScGsName_ write WriteScGsName_;
    property ScBarCode:Str15 read ReadScBarCode write WriteScBarCode;
    property ScGsKfc:double read ReadScGsKfc write WriteScGsKfc;
    property TgGsCode:longint read ReadTgGsCode write WriteTgGsCode;
    property TgGsName:Str30 read ReadTgGsName write WriteTgGsName;
    property TgGsName_:Str30 read ReadTgGsName_ write WriteTgGsName_;
    property TgBarCode:Str15 read ReadTgBarCode write WriteTgBarCode;
    property TgGsKfc:double read ReadTgGsKfc write WriteTgGsKfc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPkclstBtr.Create;
begin
  oBtrTable := BtrInit ('PKCLST',gPath.StkPath,Self);
end;

constructor TPkclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PKCLST',pPath,Self);
end;

destructor TPkclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPkclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPkclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPkclstBtr.ReadScGsCode:longint;
begin
  Result := oBtrTable.FieldByName('ScGsCode').AsInteger;
end;

procedure TPkclstBtr.WriteScGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('ScGsCode').AsInteger := pValue;
end;

function TPkclstBtr.ReadScGsName:Str30;
begin
  Result := oBtrTable.FieldByName('ScGsName').AsString;
end;

procedure TPkclstBtr.WriteScGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('ScGsName').AsString := pValue;
end;

function TPkclstBtr.ReadScGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('ScGsName_').AsString;
end;

procedure TPkclstBtr.WriteScGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('ScGsName_').AsString := pValue;
end;

function TPkclstBtr.ReadScBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('ScBarCode').AsString;
end;

procedure TPkclstBtr.WriteScBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('ScBarCode').AsString := pValue;
end;

function TPkclstBtr.ReadScGsKfc:double;
begin
  Result := oBtrTable.FieldByName('ScGsKfc').AsFloat;
end;

procedure TPkclstBtr.WriteScGsKfc(pValue:double);
begin
  oBtrTable.FieldByName('ScGsKfc').AsFloat := pValue;
end;

function TPkclstBtr.ReadTgGsCode:longint;
begin
  Result := oBtrTable.FieldByName('TgGsCode').AsInteger;
end;

procedure TPkclstBtr.WriteTgGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('TgGsCode').AsInteger := pValue;
end;

function TPkclstBtr.ReadTgGsName:Str30;
begin
  Result := oBtrTable.FieldByName('TgGsName').AsString;
end;

procedure TPkclstBtr.WriteTgGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('TgGsName').AsString := pValue;
end;

function TPkclstBtr.ReadTgGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('TgGsName_').AsString;
end;

procedure TPkclstBtr.WriteTgGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('TgGsName_').AsString := pValue;
end;

function TPkclstBtr.ReadTgBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('TgBarCode').AsString;
end;

procedure TPkclstBtr.WriteTgBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('TgBarCode').AsString := pValue;
end;

function TPkclstBtr.ReadTgGsKfc:double;
begin
  Result := oBtrTable.FieldByName('TgGsKfc').AsFloat;
end;

procedure TPkclstBtr.WriteTgGsKfc(pValue:double);
begin
  oBtrTable.FieldByName('TgGsKfc').AsFloat := pValue;
end;

function TPkclstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPkclstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkclstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPkclstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPkclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPkclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPkclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPkclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPkclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPkclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPkclstBtr.LocateSgTg (pScGsCode:longint;pTgGsCode:longint):boolean;
begin
  SetIndex (ixSgTg);
  Result := oBtrTable.FindKey([pScGsCode,pTgGsCode]);
end;

function TPkclstBtr.LocateScGsCode (pScGsCode:longint):boolean;
begin
  SetIndex (ixScGsCode);
  Result := oBtrTable.FindKey([pScGsCode]);
end;

function TPkclstBtr.LocateScGsName (pScGsName:Str30):boolean;
begin
  SetIndex (ixScGsName);
  Result := oBtrTable.FindKey([pScGsName]);
end;

function TPkclstBtr.LocateScBarCode (pScBarCode:Str15):boolean;
begin
  SetIndex (ixScBarCode);
  Result := oBtrTable.FindKey([pScBarCode]);
end;

function TPkclstBtr.LocateTgGsCode (pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgGsCode);
  Result := oBtrTable.FindKey([pTgGsCode]);
end;

function TPkclstBtr.LocateTgGsName (pTgGsName:Str30):boolean;
begin
  SetIndex (ixTgGsName);
  Result := oBtrTable.FindKey([pTgGsName]);
end;

function TPkclstBtr.LocateTgBarCode (pTgBarCode:Str15):boolean;
begin
  SetIndex (ixTgBarCode);
  Result := oBtrTable.FindKey([pTgBarCode]);
end;

function TPkclstBtr.NearestSgTg (pScGsCode:longint;pTgGsCode:longint):boolean;
begin
  SetIndex (ixSgTg);
  Result := oBtrTable.FindNearest([pScGsCode,pTgGsCode]);
end;

function TPkclstBtr.NearestScGsCode (pScGsCode:longint):boolean;
begin
  SetIndex (ixScGsCode);
  Result := oBtrTable.FindNearest([pScGsCode]);
end;

function TPkclstBtr.NearestScGsName (pScGsName:Str30):boolean;
begin
  SetIndex (ixScGsName);
  Result := oBtrTable.FindNearest([pScGsName]);
end;

function TPkclstBtr.NearestScBarCode (pScBarCode:Str15):boolean;
begin
  SetIndex (ixScBarCode);
  Result := oBtrTable.FindNearest([pScBarCode]);
end;

function TPkclstBtr.NearestTgGsCode (pTgGsCode:longint):boolean;
begin
  SetIndex (ixTgGsCode);
  Result := oBtrTable.FindNearest([pTgGsCode]);
end;

function TPkclstBtr.NearestTgGsName (pTgGsName:Str30):boolean;
begin
  SetIndex (ixTgGsName);
  Result := oBtrTable.FindNearest([pTgGsName]);
end;

function TPkclstBtr.NearestTgBarCode (pTgBarCode:Str15):boolean;
begin
  SetIndex (ixTgBarCode);
  Result := oBtrTable.FindNearest([pTgBarCode]);
end;

procedure TPkclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPkclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPkclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPkclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPkclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPkclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPkclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPkclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPkclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPkclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPkclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPkclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPkclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPkclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPkclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPkclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPkclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
