unit bCABLST;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBookNum = 'BookNum';
  ixCasNum = 'CasNum';

type
  TCablstBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
    function  ReadBookName:Str30;        procedure WriteBookName (pValue:Str30);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadCasPath:Str80;         procedure WriteCasPath (pValue:Str80);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCasStk:byte;           procedure WriteCasStk (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBookNum (pBookNum:Str5):boolean;
    function LocateCasNum (pCasNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
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
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property BookName:Str30 read ReadBookName write WriteBookName;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property CasPath:Str80 read ReadCasPath write WriteCasPath;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CasStk:byte read ReadCasStk write WriteCasStk;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TCablstBtr.Create;
begin
  oBtrTable := BtrInit ('CABLST',gPath.CabPath,Self);
end;

destructor  TCablstBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCablstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCablstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCablstBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TCablstBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TCablstBtr.ReadBookName:Str30;
begin
  Result := oBtrTable.FieldByName('BookName').AsString;
end;

procedure TCablstBtr.WriteBookName(pValue:Str30);
begin
  oBtrTable.FieldByName('BookName').AsString := pValue;
end;

function TCablstBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TCablstBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TCablstBtr.ReadCasPath:Str80;
begin
  Result := oBtrTable.FieldByName('CasPath').AsString;
end;

procedure TCablstBtr.WriteCasPath(pValue:Str80);
begin
  oBtrTable.FieldByName('CasPath').AsString := pValue;
end;

function TCablstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TCablstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TCablstBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TCablstBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TCablstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TCablstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCablstBtr.ReadCasStk:byte;
begin
  Result := oBtrTable.FieldByName('CasStk').AsInteger
end;

procedure TCablstBtr.WriteCasStk(pValue:byte);
begin
  oBtrTable.FieldByName('CasStk').AsInteger := pValue;
end;

function TCablstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCablstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCablstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCablstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCablstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCablstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCablstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCablstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCablstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCablstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCablstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCablstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCablstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCablstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCablstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCablstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCablstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCablstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCablstBtr.LocateBookNum (pBookNum:Str5):boolean;
begin
  SetIndex (ixBookNum);
  Result := oBtrTable.FindKey([pBookNum]);
end;

function TCablstBtr.LocateCasNum (pCasNum:word):boolean;
begin
  SetIndex (ixCasNum);
  Result := oBtrTable.FindKey([pCasNum]);
end;

procedure TCablstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCablstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCablstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCablstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCablstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCablstBtr.First;
begin
  oBtrTable.First;
end;

procedure TCablstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCablstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCablstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCablstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCablstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCablstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCablstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCablstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCablstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCablstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCablstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
