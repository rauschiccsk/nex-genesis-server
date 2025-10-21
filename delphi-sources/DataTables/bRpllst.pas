unit bRPLLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRplNum = 'RplNum';

type
  TRpllstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRplNum:word;           procedure WriteRplNum (pValue:word);
    function  ReadRplName:Str30;         procedure WriteRplName (pValue:Str30);
    function  ReadDelRpl:boolean;        procedure WriteDelRpl (pValue:boolean);
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
    function LocateRplNum (pRplNum:word):boolean;
    function NearestRplNum (pRplNum:word):boolean;

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
    property RplNum:word read ReadRplNum write WriteRplNum;
    property RplName:Str30 read ReadRplName write WriteRplName;
    property DelRpl:boolean read ReadDelRpl write WriteDelRpl;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRpllstBtr.Create;
begin
  oBtrTable := BtrInit ('RPLLST',gPath.StkPath,Self);
end;

constructor TRpllstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RPLLST',pPath,Self);
end;

destructor TRpllstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRpllstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRpllstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRpllstBtr.ReadRplNum:word;
begin
  Result := oBtrTable.FieldByName('RplNum').AsInteger;
end;

procedure TRpllstBtr.WriteRplNum(pValue:word);
begin
  oBtrTable.FieldByName('RplNum').AsInteger := pValue;
end;

function TRpllstBtr.ReadRplName:Str30;
begin
  Result := oBtrTable.FieldByName('RplName').AsString;
end;

procedure TRpllstBtr.WriteRplName(pValue:Str30);
begin
  oBtrTable.FieldByName('RplName').AsString := pValue;
end;

function TRpllstBtr.ReadDelRpl:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('DelRpl').AsInteger);
end;

procedure TRpllstBtr.WriteDelRpl(pValue:boolean);
begin
  oBtrTable.FieldByName('DelRpl').AsInteger := BoolToByte(pValue);
end;

function TRpllstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRpllstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRpllstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRpllstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRpllstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRpllstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRpllstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRpllstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRpllstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRpllstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRpllstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRpllstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRpllstBtr.LocateRplNum (pRplNum:word):boolean;
begin
  SetIndex (ixRplNum);
  Result := oBtrTable.FindKey([pRplNum]);
end;

function TRpllstBtr.NearestRplNum (pRplNum:word):boolean;
begin
  SetIndex (ixRplNum);
  Result := oBtrTable.FindNearest([pRplNum]);
end;

procedure TRpllstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRpllstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRpllstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRpllstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRpllstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRpllstBtr.First;
begin
  oBtrTable.First;
end;

procedure TRpllstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRpllstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRpllstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRpllstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRpllstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRpllstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRpllstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRpllstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRpllstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRpllstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRpllstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
