unit bISW;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIsdNum = 'IsdNum';
  ixInWn = 'InWn';

type
  TIswBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIsdNum:Str12;          procedure WriteIsdNum (pValue:Str12);
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnVal:double;         procedure WriteWrnVal (pValue:double);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadRegDate:TDatetime;     procedure WriteRegDate (pValue:TDatetime);
    function  ReadRegUser:Str10;         procedure WriteRegUser (pValue:Str10);
    function  ReadRegName:Str30;         procedure WriteRegName (pValue:Str30);
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
    function LocateIsdNum (pIsdNum:Str12):boolean;
    function LocateInWn (pIsdNum:Str12;pWrnNum:byte):boolean;
    function NearestIsdNum (pIsdNum:Str12):boolean;
    function NearestInWn (pIsdNum:Str12;pWrnNum:byte):boolean;

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
    property IsdNum:Str12 read ReadIsdNum write WriteIsdNum;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnVal:double read ReadWrnVal write WriteWrnVal;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property RegDate:TDatetime read ReadRegDate write WriteRegDate;
    property RegUser:Str10 read ReadRegUser write WriteRegUser;
    property RegName:Str30 read ReadRegName write WriteRegName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TIswBtr.Create;
begin
  oBtrTable := BtrInit ('ISW',gPath.LdgPath,Self);
end;

constructor TIswBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ISW',pPath,Self);
end;

destructor TIswBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIswBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIswBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIswBtr.ReadIsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IsdNum').AsString;
end;

procedure TIswBtr.WriteIsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IsdNum').AsString := pValue;
end;

function TIswBtr.ReadWrnNum:byte;
begin
  Result := oBtrTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIswBtr.WriteWrnNum(pValue:byte);
begin
  oBtrTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIswBtr.ReadWrnVal:double;
begin
  Result := oBtrTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIswBtr.WriteWrnVal(pValue:double);
begin
  oBtrTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIswBtr.ReadWrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIswBtr.WriteWrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIswBtr.ReadRegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RegDate').AsDateTime;
end;

procedure TIswBtr.WriteRegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RegDate').AsDateTime := pValue;
end;

function TIswBtr.ReadRegUser:Str10;
begin
  Result := oBtrTable.FieldByName('RegUser').AsString;
end;

procedure TIswBtr.WriteRegUser(pValue:Str10);
begin
  oBtrTable.FieldByName('RegUser').AsString := pValue;
end;

function TIswBtr.ReadRegName:Str30;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TIswBtr.WriteRegName(pValue:Str30);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TIswBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIswBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIswBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIswBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIswBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIswBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIswBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIswBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIswBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIswBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIswBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIswBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIswBtr.LocateIsdNum (pIsdNum:Str12):boolean;
begin
  SetIndex (ixIsdNum);
  Result := oBtrTable.FindKey([pIsdNum]);
end;

function TIswBtr.LocateInWn (pIsdNum:Str12;pWrnNum:byte):boolean;
begin
  SetIndex (ixInWn);
  Result := oBtrTable.FindKey([pIsdNum,pWrnNum]);
end;

function TIswBtr.NearestIsdNum (pIsdNum:Str12):boolean;
begin
  SetIndex (ixIsdNum);
  Result := oBtrTable.FindNearest([pIsdNum]);
end;

function TIswBtr.NearestInWn (pIsdNum:Str12;pWrnNum:byte):boolean;
begin
  SetIndex (ixInWn);
  Result := oBtrTable.FindNearest([pIsdNum,pWrnNum]);
end;

procedure TIswBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIswBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIswBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIswBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIswBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIswBtr.First;
begin
  oBtrTable.First;
end;

procedure TIswBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIswBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIswBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIswBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIswBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIswBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIswBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIswBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIswBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIswBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIswBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
