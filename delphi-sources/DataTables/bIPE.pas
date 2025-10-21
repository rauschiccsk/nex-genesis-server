unit bIPE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoRn = 'DoRn';
  ixDocNum = 'DocNum';

type
  TIpeBtr = class (TComponent)
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
    function  ReadTxtLin:Str150;         procedure WriteTxtLin (pValue:Str150);
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
    function LocateDoRn (pDocNum:Str12;pRowNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDoRn (pDocNum:Str12;pRowNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property TxtLin:Str150 read ReadTxtLin write WriteTxtLin;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIpeBtr.Create;
begin
  oBtrTable := BtrInit ('IPE',gPath.StkPath,Self);
end;

constructor TIpeBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPE',pPath,Self);
end;

destructor TIpeBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpeBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpeBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpeBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIpeBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIpeBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TIpeBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIpeBtr.ReadTxtLin:Str150;
begin
  Result := oBtrTable.FieldByName('TxtLin').AsString;
end;

procedure TIpeBtr.WriteTxtLin(pValue:Str150);
begin
  oBtrTable.FieldByName('TxtLin').AsString := pValue;
end;

function TIpeBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpeBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpeBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIpeBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIpeBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpeBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpeBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpeBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpeBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIpeBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIpeBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIpeBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIpeBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIpeBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpeBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpeBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpeBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpeBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpeBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpeBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpeBtr.LocateDoRn (pDocNum:Str12;pRowNum:word):boolean;
begin
  SetIndex (ixDoRn);
  Result := oBtrTable.FindKey([pDocNum,pRowNum]);
end;

function TIpeBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIpeBtr.NearestDoRn (pDocNum:Str12;pRowNum:word):boolean;
begin
  SetIndex (ixDoRn);
  Result := oBtrTable.FindNearest([pDocNum,pRowNum]);
end;

function TIpeBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TIpeBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpeBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIpeBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpeBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpeBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpeBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpeBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpeBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpeBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpeBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpeBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpeBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpeBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpeBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpeBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpeBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpeBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
