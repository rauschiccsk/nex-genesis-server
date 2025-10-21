unit bOst;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItTdTi = 'DoItTdTi';
  ixDoIt = 'DoIt';

type
  TOstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadTsdItm:word;           procedure WriteTsdItm (pValue:word);
    function  ReadTsdDate:TDatetime;     procedure WriteTsdDate (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property TsdItm:word read ReadTsdItm write WriteTsdItm;
    property TsdDate:TDatetime read ReadTsdDate write WriteTsdDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TOstBtr.Create;
begin
  oBtrTable := BtrInit ('OST',gPath.StkPath,Self);
end;

constructor TOstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OST',pPath,Self);
end;

destructor TOstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOstBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOstBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOstBtr.ReadTsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TsdNum').AsString;
end;

procedure TOstBtr.WriteTsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TsdNum').AsString := pValue;
end;

function TOstBtr.ReadTsdItm:word;
begin
  Result := oBtrTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOstBtr.WriteTsdItm(pValue:word);
begin
  oBtrTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TOstBtr.ReadTsdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TOstBtr.WriteTsdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TsdDate').AsDateTime := pValue;
end;

function TOstBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOstBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOstBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOstBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOstBtr.LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTsdNum,pTsdItm]);
end;

function TOstBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

procedure TOstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOstBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOstBtr.First;
begin
  oBtrTable.First;
end;

procedure TOstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
