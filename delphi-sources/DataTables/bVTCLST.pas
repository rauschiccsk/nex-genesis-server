unit bVTCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixVtcNum = 'VtcNum';

type
  TVtclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadVtcNum:word;           procedure WriteVtcNum (pValue:word);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
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
    function LocateVtcNum (pVtcNum:word):boolean;
    function NearestVtcNum (pVtcNum:word):boolean;

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
    property VtcNum:word read ReadVtcNum write WriteVtcNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TVtclstBtr.Create;
begin
  oBtrTable := BtrInit ('VTCLST',gPath.LdgPath,Self);
end;

constructor TVtclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTCLST',pPath,Self);
end;

destructor TVtclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtclstBtr.ReadVtcNum:word;
begin
  Result := oBtrTable.FieldByName('VtcNum').AsInteger;
end;

procedure TVtclstBtr.WriteVtcNum(pValue:word);
begin
  oBtrTable.FieldByName('VtcNum').AsInteger := pValue;
end;

function TVtclstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TVtclstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TVtclstBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TVtclstBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TVtclstBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TVtclstBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TVtclstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVtclstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVtclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TVtclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TVtclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TVtclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TVtclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TVtclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtclstBtr.LocateVtcNum (pVtcNum:word):boolean;
begin
  SetIndex (ixVtcNum);
  Result := oBtrTable.FindKey([pVtcNum]);
end;

function TVtclstBtr.NearestVtcNum (pVtcNum:word):boolean;
begin
  SetIndex (ixVtcNum);
  Result := oBtrTable.FindNearest([pVtcNum]);
end;

procedure TVtclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TVtclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
