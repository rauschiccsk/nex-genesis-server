unit tTNP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixTentNum = 'TentNum';
  ixTnVi = 'TnVi';

type
  TTnpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnVi (pTentNum:longint;pVisNum:longint):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTnpTmp.Create;
begin
  oTmpTable := TmpInit ('TNP',Self);
end;

destructor TTnpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnpTmp.ReadSernum:longint;
begin
  Result := oTmpTable.FieldByName('Sernum').AsInteger;
end;

procedure TTnpTmp.WriteSernum(pValue:longint);
begin
  oTmpTable.FieldByName('Sernum').AsInteger := pValue;
end;

function TTnpTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnpTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnpTmp.ReadVisNum:longint;
begin
  Result := oTmpTable.FieldByName('VisNum').AsInteger;
end;

procedure TTnpTmp.WriteVisNum(pValue:longint);
begin
  oTmpTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTnpTmp.ReadPayType:Str1;
begin
  Result := oTmpTable.FieldByName('PayType').AsString;
end;

procedure TTnpTmp.WritePayType(pValue:Str1);
begin
  oTmpTable.FieldByName('PayType').AsString := pValue;
end;

function TTnpTmp.ReadContoNum:Str20;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TTnpTmp.WriteContoNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TTnpTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TTnpTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTnpTmp.ReadNotice:Str50;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TTnpTmp.WriteNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TTnpTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTnpTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TTnpTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTnpTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTnpTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTnpTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnpTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnpTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnpTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnpTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnpTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTnpTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnpTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnpTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnpTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnpTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnpTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TTnpTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TTnpTmp.LocateTnVi (pTentNum:longint;pVisNum:longint):boolean;
begin
  SetIndex (ixTnVi);
  Result := oTmpTable.FindKey([pTentNum,pVisNum]);
end;

procedure TTnpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnpTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
