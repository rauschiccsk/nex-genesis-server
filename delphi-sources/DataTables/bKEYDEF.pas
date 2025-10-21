unit bKEYDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmdMark = 'PmdMark';
  ixPmBn = 'PmBn';
  ixPmBnKn = 'PmBnKn';

type
  TKeydefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadKeyName:Str30;         procedure WriteKeyName (pValue:Str30);
    function  ReadKeyVal:Str200;         procedure WriteKeyVal (pValue:Str200);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
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
    function LocatePmdMark (pPmdMark:Str3):boolean;
    function LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
    function LocatePmBnKn (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;
    function NearestPmdMark (pPmdMark:Str3):boolean;
    function NearestPmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
    function NearestPmBnKn (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property KeyName:Str30 read ReadKeyName write WriteKeyName;
    property KeyVal:Str200 read ReadKeyVal write WriteKeyVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TKeydefBtr.Create;
begin
  oBtrTable := BtrInit ('KEYDEF',gPath.SysPath,Self);
end;

constructor TKeydefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('KEYDEF',pPath,Self);
end;

destructor TKeydefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TKeydefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TKeydefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TKeydefBtr.ReadPmdMark:Str3;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TKeydefBtr.WritePmdMark(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TKeydefBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TKeydefBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TKeydefBtr.ReadKeyName:Str30;
begin
  Result := oBtrTable.FieldByName('KeyName').AsString;
end;

procedure TKeydefBtr.WriteKeyName(pValue:Str30);
begin
  oBtrTable.FieldByName('KeyName').AsString := pValue;
end;

function TKeydefBtr.ReadKeyVal:Str200;
begin
  Result := oBtrTable.FieldByName('KeyVal').AsString;
end;

procedure TKeydefBtr.WriteKeyVal(pValue:Str200);
begin
  oBtrTable.FieldByName('KeyVal').AsString := pValue;
end;

function TKeydefBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TKeydefBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TKeydefBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TKeydefBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TKeydefBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TKeydefBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TKeydefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TKeydefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TKeydefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TKeydefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TKeydefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TKeydefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKeydefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKeydefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TKeydefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TKeydefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TKeydefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TKeydefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TKeydefBtr.LocatePmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindKey([pPmdMark]);
end;

function TKeydefBtr.LocatePmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oBtrTable.FindKey([pPmdMark,pBookNum]);
end;

function TKeydefBtr.LocatePmBnKn (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;
begin
  SetIndex (ixPmBnKn);
  Result := oBtrTable.FindKey([pPmdMark,pBookNum,pKeyName]);
end;

function TKeydefBtr.NearestPmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindNearest([pPmdMark]);
end;

function TKeydefBtr.NearestPmBn (pPmdMark:Str3;pBookNum:Str5):boolean;
begin
  SetIndex (ixPmBn);
  Result := oBtrTable.FindNearest([pPmdMark,pBookNum]);
end;

function TKeydefBtr.NearestPmBnKn (pPmdMark:Str3;pBookNum:Str5;pKeyName:Str30):boolean;
begin
  SetIndex (ixPmBnKn);
  Result := oBtrTable.FindNearest([pPmdMark,pBookNum,pKeyName]);
end;

procedure TKeydefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TKeydefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TKeydefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TKeydefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TKeydefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TKeydefBtr.First;
begin
  oBtrTable.First;
end;

procedure TKeydefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TKeydefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TKeydefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TKeydefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TKeydefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TKeydefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TKeydefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TKeydefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TKeydefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TKeydefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TKeydefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
