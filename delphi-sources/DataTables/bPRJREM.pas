unit bPRJREM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDnRn = 'DnRn';

type
  TPrjremBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadRemNum:word;           procedure WriteRemNum (pValue:word);
    function  ReadRemTxt:Str90;          procedure WriteRemTxt (pValue:Str90);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDnRn (pDocNum:Str12;pRemNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDnRn (pDocNum:Str12;pRemNum:word):boolean;

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
    property RemNum:word read ReadRemNum write WriteRemNum;
    property RemTxt:Str90 read ReadRemTxt write WriteRemTxt;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPrjremBtr.Create;
begin
  oBtrTable := BtrInit ('PRJREM',gPath.DlsPath,Self);
end;

constructor TPrjremBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRJREM',pPath,Self);
end;

destructor TPrjremBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrjremBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrjremBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrjremBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrjremBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrjremBtr.ReadRemNum:word;
begin
  Result := oBtrTable.FieldByName('RemNum').AsInteger;
end;

procedure TPrjremBtr.WriteRemNum(pValue:word);
begin
  oBtrTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TPrjremBtr.ReadRemTxt:Str90;
begin
  Result := oBtrTable.FieldByName('RemTxt').AsString;
end;

procedure TPrjremBtr.WriteRemTxt(pValue:Str90);
begin
  oBtrTable.FieldByName('RemTxt').AsString := pValue;
end;

function TPrjremBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TPrjremBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TPrjremBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPrjremBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPrjremBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TPrjremBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TPrjremBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPrjremBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPrjremBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPrjremBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPrjremBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPrjremBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPrjremBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPrjremBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPrjremBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPrjremBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrjremBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjremBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrjremBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjremBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrjremBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrjremBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrjremBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrjremBtr.LocateDnRn (pDocNum:Str12;pRemNum:word):boolean;
begin
  SetIndex (ixDnRn);
  Result := oBtrTable.FindKey([pDocNum,pRemNum]);
end;

function TPrjremBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrjremBtr.NearestDnRn (pDocNum:Str12;pRemNum:word):boolean;
begin
  SetIndex (ixDnRn);
  Result := oBtrTable.FindNearest([pDocNum,pRemNum]);
end;

procedure TPrjremBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrjremBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrjremBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrjremBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrjremBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrjremBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrjremBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrjremBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrjremBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrjremBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrjremBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrjremBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrjremBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrjremBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrjremBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrjremBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrjremBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
