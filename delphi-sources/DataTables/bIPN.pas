unit bIPN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';

type
  TIpnBtr = class (TComponent)
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
    function  ReadNotTxt:Str100;         procedure WriteNotTxt (pValue:Str100);
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
    property NotTxt:Str100 read ReadNotTxt write WriteNotTxt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TIpnBtr.Create;
begin
  oBtrTable := BtrInit ('IPN',gPath.MgdPath,Self);
end;

constructor TIpnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IPN',pPath,Self);
end;

destructor TIpnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIpnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIpnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIpnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIpnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIpnBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TIpnBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIpnBtr.ReadNotTxt:Str100;
begin
  Result := oBtrTable.FieldByName('NotTxt').AsString;
end;

procedure TIpnBtr.WriteNotTxt(pValue:Str100);
begin
  oBtrTable.FieldByName('NotTxt').AsString := pValue;
end;

function TIpnBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIpnBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpnBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TIpnBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TIpnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpnBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIpnBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIpnBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIpnBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIpnBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIpnBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIpnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIpnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIpnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIpnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIpnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIpnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TIpnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIpnBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIpnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIpnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIpnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIpnBtr.First;
begin
  oBtrTable.First;
end;

procedure TIpnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIpnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIpnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIpnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIpnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIpnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIpnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIpnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIpnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIpnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIpnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
