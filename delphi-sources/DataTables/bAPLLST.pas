unit bAPLLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAplNum = 'AplNum';

type
  TApllstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAplNum:word;           procedure WriteAplNum (pValue:word);
    function  ReadAplName:Str30;         procedure WriteAplName (pValue:Str30);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadDelete:boolean;        procedure WriteDelete (pValue:boolean);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateAplNum (pAplNum:word):boolean;
    function NearestAplNum (pAplNum:word):boolean;

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
    property AplNum:word read ReadAplNum write WriteAplNum;
    property AplName:Str30 read ReadAplName write WriteAplName;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property Notice:Str60 read ReadNotice write WriteNotice;
//    property Delete:boolean read ReadDelete write WriteDelete;
    property Shared:boolean read ReadShared write WriteShared;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TApllstBtr.Create;
begin
  oBtrTable := BtrInit ('APLLST',gPath.StkPath,Self);
end;

constructor TApllstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APLLST',pPath,Self);
end;

destructor TApllstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TApllstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TApllstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TApllstBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TApllstBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TApllstBtr.ReadAplName:Str30;
begin
  Result := oBtrTable.FieldByName('AplName').AsString;
end;

procedure TApllstBtr.WriteAplName(pValue:Str30);
begin
  oBtrTable.FieldByName('AplName').AsString := pValue;
end;

function TApllstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TApllstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TApllstBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TApllstBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TApllstBtr.ReadNotice:Str60;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TApllstBtr.WriteNotice(pValue:Str60);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TApllstBtr.ReadDelete:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Delete').AsInteger);
end;

procedure TApllstBtr.WriteDelete(pValue:boolean);
begin
  oBtrTable.FieldByName('Delete').AsInteger := BoolToByte(pValue);
end;

function TApllstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TApllstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TApllstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TApllstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TApllstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TApllstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TApllstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TApllstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TApllstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TApllstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TApllstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TApllstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TApllstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TApllstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TApllstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TApllstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TApllstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApllstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TApllstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApllstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TApllstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TApllstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TApllstBtr.LocateAplNum (pAplNum:word):boolean;
begin
  SetIndex (ixAplNum);
  Result := oBtrTable.FindKey([pAplNum]);
end;

function TApllstBtr.NearestAplNum (pAplNum:word):boolean;
begin
  SetIndex (ixAplNum);
  Result := oBtrTable.FindNearest([pAplNum]);
end;

procedure TApllstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TApllstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TApllstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TApllstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TApllstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TApllstBtr.First;
begin
  oBtrTable.First;
end;

procedure TApllstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TApllstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TApllstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TApllstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TApllstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TApllstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TApllstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TApllstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TApllstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TApllstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TApllstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
