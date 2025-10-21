unit bALC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixIcdNum = 'IcdNum';

type
  TAlcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadIcBValue:double;       procedure WriteIcBValue (pValue:double);
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
    function LocateIcdNum (pIcdNum:Str12):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestIcdNum (pIcdNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property IcBValue:double read ReadIcBValue write WriteIcBValue;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TAlcBtr.Create;
begin
  oBtrTable := BtrInit ('ALC',gPath.StkPath,Self);
end;

constructor TAlcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ALC',pPath,Self);
end;

destructor TAlcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAlcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAlcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAlcBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAlcBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAlcBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TAlcBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TAlcBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAlcBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAlcBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAlcBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAlcBtr.ReadIcBValue:double;
begin
  Result := oBtrTable.FieldByName('IcBValue').AsFloat;
end;

procedure TAlcBtr.WriteIcBValue(pValue:double);
begin
  oBtrTable.FieldByName('IcBValue').AsFloat := pValue;
end;

function TAlcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAlcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAlcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAlcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAlcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAlcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAlcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAlcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAlcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAlcBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAlcBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TAlcBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAlcBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

procedure TAlcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAlcBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAlcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAlcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAlcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAlcBtr.First;
begin
  oBtrTable.First;
end;

procedure TAlcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAlcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAlcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAlcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAlcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAlcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAlcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAlcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAlcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAlcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAlcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
