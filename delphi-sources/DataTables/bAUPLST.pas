unit bAUPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixApCode = 'ApCode';
  ixPaCode = 'PaCode';

type
  TAuplstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadApCode:longint;        procedure WriteApCode (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadApName:Str30;          procedure WriteApName (pValue:Str30);
    function  ReadIdpNum:Str10;          procedure WriteIdpNum (pValue:Str10);
    function  ReadAutType:Str1;          procedure WriteAutType (pValue:Str1);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
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
    function LocateApCode (pApCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestApCode (pApCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

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
    property ApCode:longint read ReadApCode write WriteApCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property ApName:Str30 read ReadApName write WriteApName;
    property IdpNum:Str10 read ReadIdpNum write WriteIdpNum;
    property AutType:Str1 read ReadAutType write WriteAutType;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAuplstBtr.Create;
begin
  oBtrTable := BtrInit ('AUPLST',gPath.DlsPath,Self);
end;

constructor TAuplstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AUPLST',pPath,Self);
end;

destructor TAuplstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAuplstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAuplstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAuplstBtr.ReadApCode:longint;
begin
  Result := oBtrTable.FieldByName('ApCode').AsInteger;
end;

procedure TAuplstBtr.WriteApCode(pValue:longint);
begin
  oBtrTable.FieldByName('ApCode').AsInteger := pValue;
end;

function TAuplstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAuplstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAuplstBtr.ReadApName:Str30;
begin
  Result := oBtrTable.FieldByName('ApName').AsString;
end;

procedure TAuplstBtr.WriteApName(pValue:Str30);
begin
  oBtrTable.FieldByName('ApName').AsString := pValue;
end;

function TAuplstBtr.ReadIdpNum:Str10;
begin
  Result := oBtrTable.FieldByName('IdpNum').AsString;
end;

procedure TAuplstBtr.WriteIdpNum(pValue:Str10);
begin
  oBtrTable.FieldByName('IdpNum').AsString := pValue;
end;

function TAuplstBtr.ReadAutType:Str1;
begin
  Result := oBtrTable.FieldByName('AutType').AsString;
end;

procedure TAuplstBtr.WriteAutType(pValue:Str1);
begin
  oBtrTable.FieldByName('AutType').AsString := pValue;
end;

function TAuplstBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAuplstBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAuplstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAuplstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAuplstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAuplstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAuplstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAuplstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAuplstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAuplstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAuplstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAuplstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAuplstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAuplstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAuplstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAuplstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAuplstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAuplstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAuplstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAuplstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAuplstBtr.LocateApCode (pApCode:longint):boolean;
begin
  SetIndex (ixApCode);
  Result := oBtrTable.FindKey([pApCode]);
end;

function TAuplstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAuplstBtr.NearestApCode (pApCode:longint):boolean;
begin
  SetIndex (ixApCode);
  Result := oBtrTable.FindNearest([pApCode]);
end;

function TAuplstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TAuplstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAuplstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAuplstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAuplstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAuplstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAuplstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAuplstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAuplstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAuplstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAuplstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAuplstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAuplstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAuplstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAuplstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAuplstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAuplstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAuplstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1908001}
