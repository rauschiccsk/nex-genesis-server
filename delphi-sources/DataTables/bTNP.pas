unit bTNP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';
  ixTentNum = 'TentNum';
  ixTnVi = 'TnVi';

type
  TTnpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSernum:longint;        procedure WriteSernum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadPayType:Str1;          procedure WritePayType (pValue:Str1);
    function  ReadContoNum:Str20;        procedure WriteContoNum (pValue:Str20);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadNotice:Str50;          procedure WriteNotice (pValue:Str50);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnVi (pTentNum:longint;pVisNum:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnVi (pTentNum:longint;pVisNum:longint):boolean;

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
    property Sernum:longint read ReadSernum write WriteSernum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property PayType:Str1 read ReadPayType write WritePayType;
    property ContoNum:Str20 read ReadContoNum write WriteContoNum;
    property PayVal:double read ReadPayVal write WritePayVal;
    property Notice:Str50 read ReadNotice write WriteNotice;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPosM:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTnpBtr.Create;
begin
  oBtrTable := BtrInit ('TNP',gPath.HtlPath,Self);
end;

constructor TTnpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNP',pPath,Self);
end;

destructor TTnpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTnpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTnpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTnpBtr.ReadSernum:longint;
begin
  Result := oBtrTable.FieldByName('Sernum').AsInteger;
end;

procedure TTnpBtr.WriteSernum(pValue:longint);
begin
  oBtrTable.FieldByName('Sernum').AsInteger := pValue;
end;

function TTnpBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnpBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnpBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnpBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnpBtr.ReadPayType:Str1;
begin
  Result := oBtrTable.FieldByName('PayType').AsString;
end;

procedure TTnpBtr.WritePayType(pValue:Str1);
begin
  oBtrTable.FieldByName('PayType').AsString := pValue;
end;

function TTnpBtr.ReadContoNum:Str20;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TTnpBtr.WriteContoNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TTnpBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TTnpBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTnpBtr.ReadNotice:Str50;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TTnpBtr.WriteNotice(pValue:Str50);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TTnpBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTnpBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTnpBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTnpBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTnpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTnpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnpBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTnpBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnpBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnpBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnpBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnpBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnpBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnpBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTnpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTnpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTnpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTnpBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TTnpBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTnpBtr.LocateTnVi (pTentNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnVi);
  Result := oBtrTable.FindKey([pTentNum,pVisNum]);
end;

function TTnpBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TTnpBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTnpBtr.NearestTnVi (pTentNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnVi);
  Result := oBtrTable.FindNearest([pTentNum,pVisNum]);
end;

procedure TTnpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTnpBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTnpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTnpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTnpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTnpBtr.First;
begin
  oBtrTable.First;
end;

procedure TTnpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTnpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTnpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTnpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTnpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTnpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTnpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTnpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTnpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTnpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTnpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
