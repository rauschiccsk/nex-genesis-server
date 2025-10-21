unit bPAYLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPayCode = 'PayCode';
  ixPayName = 'PayName';

type
  TPaylstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPayCode:Str3;          procedure WritePayCode (pValue:Str3);
    function  ReadPayName:Str20;         procedure WritePayName (pValue:Str20);
    function  ReadPayName_:Str20;        procedure WritePayName_ (pValue:Str20);
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
    function LocatePayCode (pPayCode:Str3):boolean;
    function LocatePayName (pPayName_:Str20):boolean;
    function NearestPayCode (pPayCode:Str3):boolean;
    function NearestPayName (pPayName_:Str20):boolean;

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
    property PayCode:Str3 read ReadPayCode write WritePayCode;
    property PayName:Str20 read ReadPayName write WritePayName;
    property PayName_:Str20 read ReadPayName_ write WritePayName_;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPaylstBtr.Create;
begin
  oBtrTable := BtrInit ('PAYLST',gPath.DlsPath,Self);
end;

constructor TPaylstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PAYLST',pPath,Self);
end;

destructor TPaylstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPaylstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPaylstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPaylstBtr.ReadPayCode:Str3;
begin
  Result := oBtrTable.FieldByName('PayCode').AsString;
end;

procedure TPaylstBtr.WritePayCode(pValue:Str3);
begin
  oBtrTable.FieldByName('PayCode').AsString := pValue;
end;

function TPaylstBtr.ReadPayName:Str20;
begin
  Result := oBtrTable.FieldByName('PayName').AsString;
end;

procedure TPaylstBtr.WritePayName(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName').AsString := pValue;
end;

function TPaylstBtr.ReadPayName_:Str20;
begin
  Result := oBtrTable.FieldByName('PayName_').AsString;
end;

procedure TPaylstBtr.WritePayName_(pValue:Str20);
begin
  oBtrTable.FieldByName('PayName_').AsString := pValue;
end;

function TPaylstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPaylstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPaylstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPaylstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPaylstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPaylstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPaylstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPaylstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPaylstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPaylstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPaylstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPaylstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPaylstBtr.LocatePayCode (pPayCode:Str3):boolean;
begin
  SetIndex (ixPayCode);
  Result := oBtrTable.FindKey([pPayCode]);
end;

function TPaylstBtr.LocatePayName (pPayName_:Str20):boolean;
begin
  SetIndex (ixPayName);
  Result := oBtrTable.FindKey([StrToAlias(pPayName_)]);
end;

function TPaylstBtr.NearestPayCode (pPayCode:Str3):boolean;
begin
  SetIndex (ixPayCode);
  Result := oBtrTable.FindNearest([pPayCode]);
end;

function TPaylstBtr.NearestPayName (pPayName_:Str20):boolean;
begin
  SetIndex (ixPayName);
  Result := oBtrTable.FindNearest([pPayName_]);
end;

procedure TPaylstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPaylstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPaylstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPaylstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPaylstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPaylstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPaylstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPaylstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPaylstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPaylstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPaylstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPaylstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPaylstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPaylstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPaylstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPaylstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPaylstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
