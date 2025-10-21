unit bIPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';

type
  TIpiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadDesTxt:Str60;          procedure WriteDesTxt (pValue:Str60);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property DesTxt:Str60 read ReadDesTxt write WriteDesTxt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIpiBtr.Create;
begin
  oBtrTable := BtrInit ('IPI',gPath.StkPath,Self);
end;

constructor TIpiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPI',pPath,Self);
end;

destructor TIpiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIpiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIpiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIpiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIpiBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TIpiBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIpiBtr.ReadDesTxt:Str60;
begin
  Result := oBtrTable.FieldByName('DesTxt').AsString;
end;

procedure TIpiBtr.WriteDesTxt(pValue:Str60);
begin
  oBtrTable.FieldByName('DesTxt').AsString := pValue;
end;

function TIpiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpiBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIpiBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIpiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIpiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIpiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIpiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIpiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIpiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIpiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TIpiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIpiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

procedure TIpiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIpiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpiBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
