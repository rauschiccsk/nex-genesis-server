unit bIPD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoRn = 'DoRn';

type
  TIpdBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
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
    function LocateDoRn (pDocNum:Str12;pRowNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoRn (pDocNum:Str12;pRowNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
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

constructor TIpdBtr.Create;
begin
  oBtrTable := BtrInit ('IPD',gPath.MgdPath,Self);
end;

constructor TIpdBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPD',pPath,Self);
end;

destructor TIpdBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpdBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpdBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpdBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIpdBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIpdBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TIpdBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIpdBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TIpdBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIpdBtr.ReadDesTxt:Str60;
begin
  Result := oBtrTable.FieldByName('DesTxt').AsString;
end;

procedure TIpdBtr.WriteDesTxt(pValue:Str60);
begin
  oBtrTable.FieldByName('DesTxt').AsString := pValue;
end;

function TIpdBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpdBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpdBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIpdBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIpdBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpdBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpdBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpdBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpdBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIpdBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIpdBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIpdBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIpdBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIpdBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpdBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpdBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpdBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpdBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpdBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpdBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpdBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIpdBtr.LocateDoRn (pDocNum:Str12;pRowNum:word):boolean;
begin
  SetIndex (ixDoRn);
  Result := oBtrTable.FindKey([pDocNum,pRowNum]);
end;

function TIpdBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIpdBtr.NearestDoRn (pDocNum:Str12;pRowNum:word):boolean;
begin
  SetIndex (ixDoRn);
  Result := oBtrTable.FindNearest([pDocNum,pRowNum]);
end;

procedure TIpdBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpdBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIpdBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpdBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpdBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpdBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpdBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpdBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpdBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpdBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpdBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpdBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpdBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpdBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpdBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpdBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpdBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
