unit tOST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDoItTdTi = 'DoItTdTi';
  ixDoIt = 'DoIt';

type
  TOstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TOstTmp.Create;
begin
  oTmpTable := TmpInit ('OST',Self);
end;

destructor TOstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOstTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TOstTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TOstTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOstTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOstTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOstTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOstTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOstTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TOstTmp.ReadTsdItm:word;
begin
  Result := oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOstTmp.WriteTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TOstTmp.ReadTsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TOstTmp.WriteTsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDate').AsDateTime := pValue;
end;

function TOstTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOstTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOstTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOstTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOstTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOstTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOstTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TOstTmp.LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTsdNum:Str12;pTsdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oTmpTable.FindKey([pDocNum,pItmNum,pTsdNum,pTsdItm]);
end;

function TOstTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TOstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOstTmp.First;
begin
  oTmpTable.First;
end;

procedure TOstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
