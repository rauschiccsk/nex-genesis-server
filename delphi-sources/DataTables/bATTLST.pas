unit bATTLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnAn = 'DnAn';
  ixDocNum = 'DocNum';
  ixAttNum = 'AttNum';
  ixAttFile = 'AttFile';

type
  TAttlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadAttNum:word;           procedure WriteAttNum (pValue:word);
    function  ReadAttType:byte;          procedure WriteAttType (pValue:byte);
    function  ReadAttPath:Str120;        procedure WriteAttPath (pValue:Str120);
    function  ReadAttFile:Str80;         procedure WriteAttFile (pValue:Str80);
    function  ReadAttProg:Str200;        procedure WriteAttProg (pValue:Str200);
    function  ReadAttSize:longint;       procedure WriteAttSize (pValue:longint);
    function  ReadAttDate:TDatetime;     procedure WriteAttDate (pValue:TDatetime);
    function  ReadAttTime:TDatetime;     procedure WriteAttTime (pValue:TDatetime);
    function  ReadAttAttr:byte;          procedure WriteAttAttr (pValue:byte);
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
    function LocateDnAn (pDocNum:Str12;pAttNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateAttNum (pAttNum:word):boolean;
    function LocateAttFile (pAttFile:Str80):boolean;
    function NearestDnAn (pDocNum:Str12;pAttNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestAttNum (pAttNum:word):boolean;
    function NearestAttFile (pAttFile:Str80):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property AttNum:word read ReadAttNum write WriteAttNum;
    property AttType:byte read ReadAttType write WriteAttType;
    property AttPath:Str120 read ReadAttPath write WriteAttPath;
    property AttFile:Str80 read ReadAttFile write WriteAttFile;
    property AttProg:Str200 read ReadAttProg write WriteAttProg;
    property AttSize:longint read ReadAttSize write WriteAttSize;
    property AttDate:TDatetime read ReadAttDate write WriteAttDate;
    property AttTime:TDatetime read ReadAttTime write WriteAttTime;
    property AttAttr:byte read ReadAttAttr write WriteAttAttr;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAttlstBtr.Create;
begin
  oBtrTable := BtrInit ('ATTLST',gPath.SysPath,Self);
end;

constructor TAttlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ATTLST',pPath,Self);
end;

destructor TAttlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAttlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAttlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAttlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAttlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAttlstBtr.ReadAttNum:word;
begin
  Result := oBtrTable.FieldByName('AttNum').AsInteger;
end;

procedure TAttlstBtr.WriteAttNum(pValue:word);
begin
  oBtrTable.FieldByName('AttNum').AsInteger := pValue;
end;

function TAttlstBtr.ReadAttType:byte;
begin
  Result := oBtrTable.FieldByName('AttType').AsInteger;
end;

procedure TAttlstBtr.WriteAttType(pValue:byte);
begin
  oBtrTable.FieldByName('AttType').AsInteger := pValue;
end;

function TAttlstBtr.ReadAttPath:Str120;
begin
  Result := oBtrTable.FieldByName('AttPath').AsString;
end;

procedure TAttlstBtr.WriteAttPath(pValue:Str120);
begin
  oBtrTable.FieldByName('AttPath').AsString := pValue;
end;

function TAttlstBtr.ReadAttFile:Str80;
begin
  Result := oBtrTable.FieldByName('AttFile').AsString;
end;

procedure TAttlstBtr.WriteAttFile(pValue:Str80);
begin
  oBtrTable.FieldByName('AttFile').AsString := pValue;
end;

function TAttlstBtr.ReadAttProg:Str200;
begin
  Result := oBtrTable.FieldByName('AttProg').AsString;
end;

procedure TAttlstBtr.WriteAttProg(pValue:Str200);
begin
  oBtrTable.FieldByName('AttProg').AsString := pValue;
end;

function TAttlstBtr.ReadAttSize:longint;
begin
  Result := oBtrTable.FieldByName('AttSize').AsInteger;
end;

procedure TAttlstBtr.WriteAttSize(pValue:longint);
begin
  oBtrTable.FieldByName('AttSize').AsInteger := pValue;
end;

function TAttlstBtr.ReadAttDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AttDate').AsDateTime;
end;

procedure TAttlstBtr.WriteAttDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AttDate').AsDateTime := pValue;
end;

function TAttlstBtr.ReadAttTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('AttTime').AsDateTime;
end;

procedure TAttlstBtr.WriteAttTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AttTime').AsDateTime := pValue;
end;

function TAttlstBtr.ReadAttAttr:byte;
begin
  Result := oBtrTable.FieldByName('AttAttr').AsInteger;
end;

procedure TAttlstBtr.WriteAttAttr(pValue:byte);
begin
  oBtrTable.FieldByName('AttAttr').AsInteger := pValue;
end;

function TAttlstBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TAttlstBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TAttlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAttlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAttlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAttlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAttlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAttlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAttlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAttlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAttlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAttlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAttlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAttlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAttlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAttlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAttlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAttlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAttlstBtr.LocateDnAn (pDocNum:Str12;pAttNum:word):boolean;
begin
  SetIndex (ixDnAn);
  Result := oBtrTable.FindKey([pDocNum,pAttNum]);
end;

function TAttlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAttlstBtr.LocateAttNum (pAttNum:word):boolean;
begin
  SetIndex (ixAttNum);
  Result := oBtrTable.FindKey([pAttNum]);
end;

function TAttlstBtr.LocateAttFile (pAttFile:Str80):boolean;
begin
  SetIndex (ixAttFile);
  Result := oBtrTable.FindKey([pAttFile]);
end;

function TAttlstBtr.NearestDnAn (pDocNum:Str12;pAttNum:word):boolean;
begin
  SetIndex (ixDnAn);
  Result := oBtrTable.FindNearest([pDocNum,pAttNum]);
end;

function TAttlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAttlstBtr.NearestAttNum (pAttNum:word):boolean;
begin
  SetIndex (ixAttNum);
  Result := oBtrTable.FindNearest([pAttNum]);
end;

function TAttlstBtr.NearestAttFile (pAttFile:Str80):boolean;
begin
  SetIndex (ixAttFile);
  Result := oBtrTable.FindNearest([pAttFile]);
end;

procedure TAttlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAttlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAttlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAttlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAttlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAttlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAttlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAttlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAttlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAttlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAttlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAttlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAttlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAttlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAttlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAttlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAttlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1902010}
