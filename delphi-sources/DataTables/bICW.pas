unit bICW;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIcdNum = 'IcdNum';
  ixInWn = 'InWn';

type
  TIcwBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnVal:double;         procedure WriteWrnVal (pValue:double);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadWrnUser:Str10;         procedure WriteWrnUser (pValue:Str10);
    function  ReadWrnName:Str30;         procedure WriteWrnName (pValue:Str30);
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
    function LocateIcdNum (pIcdNum:Str12):boolean;
    function LocateInWn (pIcdNum:Str12;pWrnNum:byte):boolean;
    function NearestIcdNum (pIcdNum:Str12):boolean;
    function NearestInWn (pIcdNum:Str12;pWrnNum:byte):boolean;

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
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnVal:double read ReadWrnVal write WriteWrnVal;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property WrnUser:Str10 read ReadWrnUser write WriteWrnUser;
    property WrnName:Str30 read ReadWrnName write WriteWrnName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TIcwBtr.Create;
begin
  oBtrTable := BtrInit ('ICW',gPath.LdgPath,Self);
end;

constructor TIcwBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ICW',pPath,Self);
end;

destructor TIcwBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIcwBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIcwBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIcwBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TIcwBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TIcwBtr.ReadWrnNum:byte;
begin
  Result := oBtrTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIcwBtr.WriteWrnNum(pValue:byte);
begin
  oBtrTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIcwBtr.ReadWrnVal:double;
begin
  Result := oBtrTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIcwBtr.WriteWrnVal(pValue:double);
begin
  oBtrTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIcwBtr.ReadWrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIcwBtr.WriteWrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIcwBtr.ReadWrnUser:Str10;
begin
  Result := oBtrTable.FieldByName('WrnUser').AsString;
end;

procedure TIcwBtr.WriteWrnUser(pValue:Str10);
begin
  oBtrTable.FieldByName('WrnUser').AsString := pValue;
end;

function TIcwBtr.ReadWrnName:Str30;
begin
  Result := oBtrTable.FieldByName('WrnName').AsString;
end;

procedure TIcwBtr.WriteWrnName(pValue:Str30);
begin
  oBtrTable.FieldByName('WrnName').AsString := pValue;
end;

function TIcwBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIcwBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIcwBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIcwBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIcwBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIcwBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcwBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIcwBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIcwBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIcwBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIcwBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIcwBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIcwBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TIcwBtr.LocateInWn (pIcdNum:Str12;pWrnNum:byte):boolean;
begin
  SetIndex (ixInWn);
  Result := oBtrTable.FindKey([pIcdNum,pWrnNum]);
end;

function TIcwBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

function TIcwBtr.NearestInWn (pIcdNum:Str12;pWrnNum:byte):boolean;
begin
  SetIndex (ixInWn);
  Result := oBtrTable.FindNearest([pIcdNum,pWrnNum]);
end;

procedure TIcwBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIcwBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIcwBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIcwBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIcwBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIcwBtr.First;
begin
  oBtrTable.First;
end;

procedure TIcwBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIcwBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIcwBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIcwBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIcwBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIcwBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIcwBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIcwBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIcwBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIcwBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIcwBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
