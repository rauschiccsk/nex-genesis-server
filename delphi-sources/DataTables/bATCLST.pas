unit bATCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnInAn = 'DnInAn';
  ixDnIn = 'DnIn';
  ixDocNum = 'DocNum';

type
  TAtclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadAtcNum:word;           procedure WriteAtcNum (pValue:word);
    function  ReadAtcFile:Str250;        procedure WriteAtcFile (pValue:Str250);
    function  ReadAtcSize:longint;       procedure WriteAtcSize (pValue:longint);
    function  ReadAtcDate:TDatetime;     procedure WriteAtcDate (pValue:TDatetime);
    function  ReadAtcTime:TDatetime;     procedure WriteAtcTime (pValue:TDatetime);
    function  ReadAtcAttr:byte;          procedure WriteAtcAttr (pValue:byte);
    function  ReadAttType:byte;          procedure WriteAttType (pValue:byte);
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
    function LocateDnInAn (pDocNum:Str12;pItmNum:longint;pAtcNum:word):boolean;
    function LocateDnIn (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDnInAn (pDocNum:Str12;pItmNum:longint;pAtcNum:word):boolean;
    function NearestDnIn (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property AtcNum:word read ReadAtcNum write WriteAtcNum;
    property AtcFile:Str250 read ReadAtcFile write WriteAtcFile;
    property AtcSize:longint read ReadAtcSize write WriteAtcSize;
    property AtcDate:TDatetime read ReadAtcDate write WriteAtcDate;
    property AtcTime:TDatetime read ReadAtcTime write WriteAtcTime;
    property AtcAttr:byte read ReadAtcAttr write WriteAtcAttr;
    property AttType:byte read ReadAttType write WriteAttType;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAtclstBtr.Create;
begin
  oBtrTable := BtrInit ('ATCLST',gPath.DlsPath,Self);
end;

constructor TAtclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ATCLST',pPath,Self);
end;

destructor TAtclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAtclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAtclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAtclstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAtclstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAtclstBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAtclstBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TAtclstBtr.ReadAtcNum:word;
begin
  Result := oBtrTable.FieldByName('AtcNum').AsInteger;
end;

procedure TAtclstBtr.WriteAtcNum(pValue:word);
begin
  oBtrTable.FieldByName('AtcNum').AsInteger := pValue;
end;

function TAtclstBtr.ReadAtcFile:Str250;
begin
  Result := oBtrTable.FieldByName('AtcFile').AsString;
end;

procedure TAtclstBtr.WriteAtcFile(pValue:Str250);
begin
  oBtrTable.FieldByName('AtcFile').AsString := pValue;
end;

function TAtclstBtr.ReadAtcSize:longint;
begin
  Result := oBtrTable.FieldByName('AtcSize').AsInteger;
end;

procedure TAtclstBtr.WriteAtcSize(pValue:longint);
begin
  oBtrTable.FieldByName('AtcSize').AsInteger := pValue;
end;

function TAtclstBtr.ReadAtcDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AtcDate').AsDateTime;
end;

procedure TAtclstBtr.WriteAtcDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AtcDate').AsDateTime := pValue;
end;

function TAtclstBtr.ReadAtcTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('AtcTime').AsDateTime;
end;

procedure TAtclstBtr.WriteAtcTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AtcTime').AsDateTime := pValue;
end;

function TAtclstBtr.ReadAtcAttr:byte;
begin
  Result := oBtrTable.FieldByName('AtcAttr').AsInteger;
end;

procedure TAtclstBtr.WriteAtcAttr(pValue:byte);
begin
  oBtrTable.FieldByName('AtcAttr').AsInteger := pValue;
end;

function TAtclstBtr.ReadAttType:byte;
begin
  Result := oBtrTable.FieldByName('AttType').AsInteger;
end;

procedure TAtclstBtr.WriteAttType(pValue:byte);
begin
  oBtrTable.FieldByName('AttType').AsInteger := pValue;
end;

function TAtclstBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TAtclstBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TAtclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAtclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAtclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAtclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAtclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAtclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAtclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAtclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAtclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAtclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAtclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAtclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAtclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAtclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAtclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAtclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAtclstBtr.LocateDnInAn (pDocNum:Str12;pItmNum:longint;pAtcNum:word):boolean;
begin
  SetIndex (ixDnInAn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pAtcNum]);
end;

function TAtclstBtr.LocateDnIn (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TAtclstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAtclstBtr.NearestDnInAn (pDocNum:Str12;pItmNum:longint;pAtcNum:word):boolean;
begin
  SetIndex (ixDnInAn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pAtcNum]);
end;

function TAtclstBtr.NearestDnIn (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TAtclstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TAtclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAtclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAtclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAtclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAtclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAtclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAtclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAtclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAtclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAtclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAtclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAtclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAtclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAtclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAtclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAtclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAtclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1907001}
