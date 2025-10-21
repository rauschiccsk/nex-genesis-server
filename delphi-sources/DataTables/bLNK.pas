unit bLNK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixDoItLdLi = 'DoItLdLi';
  ixLnkDoc = 'LnkDoc';
  ixLdLi = 'LdLi';

type
  TLnkBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadLnkDoc:Str12;          procedure WriteLnkDoc (pValue:Str12);
    function  ReadLnkItm:longint;        procedure WriteLnkItm (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateDoItLdLi (pDocNum:Str12;pItmNum:longint;pLnkDoc:Str12;pLnkItm:longint):boolean;
    function LocateLnkDoc (pLnkDoc:Str12):boolean;
    function LocateLdLi (pLnkDoc:Str12;pLnkItm:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function NearestDoItLdLi (pDocNum:Str12;pItmNum:longint;pLnkDoc:Str12;pLnkItm:longint):boolean;
    function NearestLnkDoc (pLnkDoc:Str12):boolean;
    function NearestLdLi (pLnkDoc:Str12;pLnkItm:longint):boolean;

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
    property LnkDoc:Str12 read ReadLnkDoc write WriteLnkDoc;
    property LnkItm:longint read ReadLnkItm write WriteLnkItm;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TLnkBtr.Create;
begin
  oBtrTable := BtrInit ('LNK',gPath.SysPath,Self);
end;

constructor TLnkBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('LNK',pPath,Self);
end;

destructor TLnkBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TLnkBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TLnkBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TLnkBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TLnkBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TLnkBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TLnkBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TLnkBtr.ReadLnkDoc:Str12;
begin
  Result := oBtrTable.FieldByName('LnkDoc').AsString;
end;

procedure TLnkBtr.WriteLnkDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('LnkDoc').AsString := pValue;
end;

function TLnkBtr.ReadLnkItm:longint;
begin
  Result := oBtrTable.FieldByName('LnkItm').AsInteger;
end;

procedure TLnkBtr.WriteLnkItm(pValue:longint);
begin
  oBtrTable.FieldByName('LnkItm').AsInteger := pValue;
end;

function TLnkBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TLnkBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TLnkBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TLnkBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TLnkBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TLnkBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLnkBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLnkBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TLnkBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLnkBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TLnkBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TLnkBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TLnkBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TLnkBtr.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TLnkBtr.LocateDoItLdLi (pDocNum:Str12;pItmNum:longint;pLnkDoc:Str12;pLnkItm:longint):boolean;
begin
  SetIndex (ixDoItLdLi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pLnkDoc,pLnkItm]);
end;

function TLnkBtr.LocateLnkDoc (pLnkDoc:Str12):boolean;
begin
  SetIndex (ixLnkDoc);
  Result := oBtrTable.FindKey([pLnkDoc]);
end;

function TLnkBtr.LocateLdLi (pLnkDoc:Str12;pLnkItm:longint):boolean;
begin
  SetIndex (ixLdLi);
  Result := oBtrTable.FindKey([pLnkDoc,pLnkItm]);
end;

function TLnkBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TLnkBtr.NearestDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TLnkBtr.NearestDoItLdLi (pDocNum:Str12;pItmNum:longint;pLnkDoc:Str12;pLnkItm:longint):boolean;
begin
  SetIndex (ixDoItLdLi);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pLnkDoc,pLnkItm]);
end;

function TLnkBtr.NearestLnkDoc (pLnkDoc:Str12):boolean;
begin
  SetIndex (ixLnkDoc);
  Result := oBtrTable.FindNearest([pLnkDoc]);
end;

function TLnkBtr.NearestLdLi (pLnkDoc:Str12;pLnkItm:longint):boolean;
begin
  SetIndex (ixLdLi);
  Result := oBtrTable.FindNearest([pLnkDoc,pLnkItm]);
end;

procedure TLnkBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TLnkBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TLnkBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TLnkBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TLnkBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TLnkBtr.First;
begin
  oBtrTable.First;
end;

procedure TLnkBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TLnkBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TLnkBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TLnkBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TLnkBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TLnkBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TLnkBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TLnkBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TLnkBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TLnkBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TLnkBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
