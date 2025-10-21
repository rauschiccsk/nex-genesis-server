unit bREMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnInRn = 'DnInRn';
  ixDnIn = 'DnIn';
  ixDocNum = 'DocNum';

type
  TRemlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
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
    function LocateDnInRn (pDocNum:Str12;pItmNum:word;pRemNum:word):boolean;
    function LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function NearestDnInRn (pDocNum:Str12;pItmNum:word;pRemNum:word):boolean;
    function NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
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

constructor TRemlstBtr.Create;
begin
  oBtrTable := BtrInit ('REMLST',gPath.StkPath,Self);
end;

constructor TRemlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('REMLST',pPath,Self);
end;

destructor TRemlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRemlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRemlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRemlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRemlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRemlstBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRemlstBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRemlstBtr.ReadRemNum:word;
begin
  Result := oBtrTable.FieldByName('RemNum').AsInteger;
end;

procedure TRemlstBtr.WriteRemNum(pValue:word);
begin
  oBtrTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TRemlstBtr.ReadRemTxt:Str90;
begin
  Result := oBtrTable.FieldByName('RemTxt').AsString;
end;

procedure TRemlstBtr.WriteRemTxt(pValue:Str90);
begin
  oBtrTable.FieldByName('RemTxt').AsString := pValue;
end;

function TRemlstBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TRemlstBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TRemlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRemlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRemlstBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TRemlstBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TRemlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRemlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRemlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRemlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRemlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRemlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRemlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRemlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRemlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRemlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRemlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRemlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRemlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRemlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRemlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRemlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRemlstBtr.LocateDnInRn (pDocNum:Str12;pItmNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixDnInRn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pRemNum]);
end;

function TRemlstBtr.LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TRemlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRemlstBtr.NearestDnInRn (pDocNum:Str12;pItmNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixDnInRn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pRemNum]);
end;

function TRemlstBtr.NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TRemlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TRemlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRemlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRemlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRemlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRemlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRemlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TRemlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRemlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRemlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRemlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRemlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRemlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRemlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRemlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRemlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRemlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRemlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1907001}
