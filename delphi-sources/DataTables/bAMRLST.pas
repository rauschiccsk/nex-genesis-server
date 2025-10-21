unit bAMRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRefNum = 'RefNum';
  ixRefTxt = 'RefTxt';

type
  TAmrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRefNum:word;           procedure WriteRefNum (pValue:word);
    function  ReadRefTxt:Str30;          procedure WriteRefTxt (pValue:Str30);
    function  ReadRefTxt_:Str30;         procedure WriteRefTxt_ (pValue:Str30);
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
    function LocateRefNum (pRefNum:word):boolean;
    function LocateRefTxt (pRefTxt_:Str30):boolean;
    function NearestRefNum (pRefNum:word):boolean;
    function NearestRefTxt (pRefTxt_:Str30):boolean;

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
    property RefNum:word read ReadRefNum write WriteRefNum;
    property RefTxt:Str30 read ReadRefTxt write WriteRefTxt;
    property RefTxt_:Str30 read ReadRefTxt_ write WriteRefTxt_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAmrlstBtr.Create;
begin
  oBtrTable := BtrInit ('AMRLST',gPath.StkPath,Self);
end;

constructor TAmrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AMRLST',pPath,Self);
end;

destructor TAmrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAmrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAmrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAmrlstBtr.ReadRefNum:word;
begin
  Result := oBtrTable.FieldByName('RefNum').AsInteger;
end;

procedure TAmrlstBtr.WriteRefNum(pValue:word);
begin
  oBtrTable.FieldByName('RefNum').AsInteger := pValue;
end;

function TAmrlstBtr.ReadRefTxt:Str30;
begin
  Result := oBtrTable.FieldByName('RefTxt').AsString;
end;

procedure TAmrlstBtr.WriteRefTxt(pValue:Str30);
begin
  oBtrTable.FieldByName('RefTxt').AsString := pValue;
end;

function TAmrlstBtr.ReadRefTxt_:Str30;
begin
  Result := oBtrTable.FieldByName('RefTxt_').AsString;
end;

procedure TAmrlstBtr.WriteRefTxt_(pValue:Str30);
begin
  oBtrTable.FieldByName('RefTxt_').AsString := pValue;
end;

function TAmrlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAmrlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAmrlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAmrlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAmrlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAmrlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAmrlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAmrlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAmrlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAmrlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAmrlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAmrlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAmrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAmrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAmrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAmrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAmrlstBtr.LocateRefNum (pRefNum:word):boolean;
begin
  SetIndex (ixRefNum);
  Result := oBtrTable.FindKey([pRefNum]);
end;

function TAmrlstBtr.LocateRefTxt (pRefTxt_:Str30):boolean;
begin
  SetIndex (ixRefTxt);
  Result := oBtrTable.FindKey([StrToAlias(pRefTxt_)]);
end;

function TAmrlstBtr.NearestRefNum (pRefNum:word):boolean;
begin
  SetIndex (ixRefNum);
  Result := oBtrTable.FindNearest([pRefNum]);
end;

function TAmrlstBtr.NearestRefTxt (pRefTxt_:Str30):boolean;
begin
  SetIndex (ixRefTxt);
  Result := oBtrTable.FindNearest([pRefTxt_]);
end;

procedure TAmrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAmrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAmrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAmrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAmrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAmrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAmrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAmrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAmrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAmrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAmrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAmrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAmrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAmrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAmrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAmrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAmrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
