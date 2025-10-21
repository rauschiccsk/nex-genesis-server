unit bJOBPER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnEn = 'DnEn';
  ixDocNum = 'DocNum';

type
  TJobperBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
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
    function LocateDnEn (pDocNum:Str12;pEpcNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDnEn (pDocNum:Str12;pEpcNum:word):boolean;
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
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TJobperBtr.Create;
begin
  oBtrTable := BtrInit ('JOBPER',gPath.DlsPath,Self);
end;

constructor TJobperBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('JOBPER',pPath,Self);
end;

destructor TJobperBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJobperBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJobperBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TJobperBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJobperBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJobperBtr.ReadEpcNum:word;
begin
  Result := oBtrTable.FieldByName('EpcNum').AsInteger;
end;

procedure TJobperBtr.WriteEpcNum(pValue:word);
begin
  oBtrTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TJobperBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TJobperBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TJobperBtr.ReadUsrName:Str30;
begin
  Result := oBtrTable.FieldByName('UsrName').AsString;
end;

procedure TJobperBtr.WriteUsrName(pValue:Str30);
begin
  oBtrTable.FieldByName('UsrName').AsString := pValue;
end;

function TJobperBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TJobperBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TJobperBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJobperBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJobperBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJobperBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobperBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobperBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TJobperBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJobperBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJobperBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJobperBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJobperBtr.LocateDnEn (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDnEn);
  Result := oBtrTable.FindKey([pDocNum,pEpcNum]);
end;

function TJobperBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJobperBtr.NearestDnEn (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDnEn);
  Result := oBtrTable.FindNearest([pDocNum,pEpcNum]);
end;

function TJobperBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TJobperBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJobperBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TJobperBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJobperBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJobperBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TJobperBtr.First;
begin
  oBtrTable.First;
end;

procedure TJobperBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TJobperBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJobperBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJobperBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TJobperBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJobperBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJobperBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TJobperBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TJobperBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TJobperBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TJobperBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
