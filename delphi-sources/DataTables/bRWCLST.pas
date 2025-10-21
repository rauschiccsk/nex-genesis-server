unit bRWCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOwIw = 'OwIw';

type
  TRwclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOutWri:word;           procedure WriteOutWri (pValue:word);
    function  ReadIncWri:word;           procedure WriteIncWri (pValue:word);
    function  ReadOmbNum:Str5;           procedure WriteOmbNum (pValue:Str5);
    function  ReadImbNum:Str5;           procedure WriteImbNum (pValue:Str5);
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
    function LocateOwIw (pOutWri:word;pIncWri:word):boolean;
    function NearestOwIw (pOutWri:word;pIncWri:word):boolean;

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
    property OutWri:word read ReadOutWri write WriteOutWri;
    property IncWri:word read ReadIncWri write WriteIncWri;
    property OmbNum:Str5 read ReadOmbNum write WriteOmbNum;
    property ImbNum:Str5 read ReadImbNum write WriteImbNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRwclstBtr.Create;
begin
  oBtrTable := BtrInit ('RWCLST',gPath.StkPath,Self);
end;

constructor TRwclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RWCLST',pPath,Self);
end;

destructor TRwclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRwclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRwclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRwclstBtr.ReadOutWri:word;
begin
  Result := oBtrTable.FieldByName('OutWri').AsInteger;
end;

procedure TRwclstBtr.WriteOutWri(pValue:word);
begin
  oBtrTable.FieldByName('OutWri').AsInteger := pValue;
end;

function TRwclstBtr.ReadIncWri:word;
begin
  Result := oBtrTable.FieldByName('IncWri').AsInteger;
end;

procedure TRwclstBtr.WriteIncWri(pValue:word);
begin
  oBtrTable.FieldByName('IncWri').AsInteger := pValue;
end;

function TRwclstBtr.ReadOmbNum:Str5;
begin
  Result := oBtrTable.FieldByName('OmbNum').AsString;
end;

procedure TRwclstBtr.WriteOmbNum(pValue:Str5);
begin
  oBtrTable.FieldByName('OmbNum').AsString := pValue;
end;

function TRwclstBtr.ReadImbNum:Str5;
begin
  Result := oBtrTable.FieldByName('ImbNum').AsString;
end;

procedure TRwclstBtr.WriteImbNum(pValue:Str5);
begin
  oBtrTable.FieldByName('ImbNum').AsString := pValue;
end;

function TRwclstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRwclstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRwclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRwclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRwclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRwclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRwclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRwclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRwclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRwclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRwclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRwclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRwclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRwclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRwclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRwclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRwclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRwclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRwclstBtr.LocateOwIw (pOutWri:word;pIncWri:word):boolean;
begin
  SetIndex (ixOwIw);
  Result := oBtrTable.FindKey([pOutWri,pIncWri]);
end;

function TRwclstBtr.NearestOwIw (pOutWri:word;pIncWri:word):boolean;
begin
  SetIndex (ixOwIw);
  Result := oBtrTable.FindNearest([pOutWri,pIncWri]);
end;

procedure TRwclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRwclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRwclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRwclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRwclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRwclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TRwclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRwclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRwclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRwclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRwclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRwclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRwclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRwclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRwclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRwclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRwclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
