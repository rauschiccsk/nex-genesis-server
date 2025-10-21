unit bTICPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTtBn = 'TtBn';

type
  TTicprnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTicTyp:Str4;           procedure WriteTicTyp (pValue:Str4);
    function  ReadBegNum:longint;        procedure WriteBegNum (pValue:longint);
    function  ReadEndNum:longint;        procedure WriteEndNum (pValue:longint);
    function  ReadRowQnt:byte;           procedure WriteRowQnt (pValue:byte);
    function  ReadLinQnt:byte;           procedure WriteLinQnt (pValue:byte);
    function  ReadTicQnt:longint;        procedure WriteTicQnt (pValue:longint);
    function  ReadPagQnt:word;           procedure WritePagQnt (pValue:word);
    function  ReadTicDes:Str60;          procedure WriteTicDes (pValue:Str60);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
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
    function LocateTtBn (pTicTyp:Str4;pBegNum:longint):boolean;
    function NearestTtBn (pTicTyp:Str4;pBegNum:longint):boolean;

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
    property TicTyp:Str4 read ReadTicTyp write WriteTicTyp;
    property BegNum:longint read ReadBegNum write WriteBegNum;
    property EndNum:longint read ReadEndNum write WriteEndNum;
    property RowQnt:byte read ReadRowQnt write WriteRowQnt;
    property LinQnt:byte read ReadLinQnt write WriteLinQnt;
    property TicQnt:longint read ReadTicQnt write WriteTicQnt;
    property PagQnt:word read ReadPagQnt write WritePagQnt;
    property TicDes:Str60 read ReadTicDes write WriteTicDes;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TTicprnBtr.Create;
begin
  oBtrTable := BtrInit ('TICPRN',gPath.DlsPath,Self);
end;

constructor TTicprnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TICPRN',pPath,Self);
end;

destructor TTicprnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTicprnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTicprnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTicprnBtr.ReadTicTyp:Str4;
begin
  Result := oBtrTable.FieldByName('TicTyp').AsString;
end;

procedure TTicprnBtr.WriteTicTyp(pValue:Str4);
begin
  oBtrTable.FieldByName('TicTyp').AsString := pValue;
end;

function TTicprnBtr.ReadBegNum:longint;
begin
  Result := oBtrTable.FieldByName('BegNum').AsInteger;
end;

procedure TTicprnBtr.WriteBegNum(pValue:longint);
begin
  oBtrTable.FieldByName('BegNum').AsInteger := pValue;
end;

function TTicprnBtr.ReadEndNum:longint;
begin
  Result := oBtrTable.FieldByName('EndNum').AsInteger;
end;

procedure TTicprnBtr.WriteEndNum(pValue:longint);
begin
  oBtrTable.FieldByName('EndNum').AsInteger := pValue;
end;

function TTicprnBtr.ReadRowQnt:byte;
begin
  Result := oBtrTable.FieldByName('RowQnt').AsInteger;
end;

procedure TTicprnBtr.WriteRowQnt(pValue:byte);
begin
  oBtrTable.FieldByName('RowQnt').AsInteger := pValue;
end;

function TTicprnBtr.ReadLinQnt:byte;
begin
  Result := oBtrTable.FieldByName('LinQnt').AsInteger;
end;

procedure TTicprnBtr.WriteLinQnt(pValue:byte);
begin
  oBtrTable.FieldByName('LinQnt').AsInteger := pValue;
end;

function TTicprnBtr.ReadTicQnt:longint;
begin
  Result := oBtrTable.FieldByName('TicQnt').AsInteger;
end;

procedure TTicprnBtr.WriteTicQnt(pValue:longint);
begin
  oBtrTable.FieldByName('TicQnt').AsInteger := pValue;
end;

function TTicprnBtr.ReadPagQnt:word;
begin
  Result := oBtrTable.FieldByName('PagQnt').AsInteger;
end;

procedure TTicprnBtr.WritePagQnt(pValue:word);
begin
  oBtrTable.FieldByName('PagQnt').AsInteger := pValue;
end;

function TTicprnBtr.ReadTicDes:Str60;
begin
  Result := oBtrTable.FieldByName('TicDes').AsString;
end;

procedure TTicprnBtr.WriteTicDes(pValue:Str60);
begin
  oBtrTable.FieldByName('TicDes').AsString := pValue;
end;

function TTicprnBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TTicprnBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TTicprnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTicprnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTicprnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTicprnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTicprnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTicprnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTicprnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTicprnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTicprnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTicprnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTicprnBtr.LocateTtBn (pTicTyp:Str4;pBegNum:longint):boolean;
begin
  SetIndex (ixTtBn);
  Result := oBtrTable.FindKey([pTicTyp,pBegNum]);
end;

function TTicprnBtr.NearestTtBn (pTicTyp:Str4;pBegNum:longint):boolean;
begin
  SetIndex (ixTtBn);
  Result := oBtrTable.FindNearest([pTicTyp,pBegNum]);
end;

procedure TTicprnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTicprnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTicprnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTicprnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTicprnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTicprnBtr.First;
begin
  oBtrTable.First;
end;

procedure TTicprnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTicprnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTicprnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTicprnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTicprnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTicprnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTicprnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTicprnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTicprnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTicprnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTicprnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1808007}
