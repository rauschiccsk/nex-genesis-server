unit tTIP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixDoGc = 'DoGc';
  ixDoPc = 'DoPc';
  ixDoGcPc = 'DoGcPc';

type
  TTipTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
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
    function LocateRowNum (pRowNum:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
    function LocateDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTipTmp.Create;
begin
  oTmpTable := TmpInit ('TIP',Self);
end;

destructor TTipTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTipTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTipTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTipTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TTipTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TTipTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TTipTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TTipTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTipTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTipTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TTipTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTipTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TTipTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TTipTmp.ReadPosCode:Str15;
begin
  Result := oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TTipTmp.WritePosCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCode').AsString := pValue;
end;

function TTipTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTipTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTipTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTipTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTipTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTipTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTipTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTipTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTipTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTipTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTipTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTipTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTipTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTipTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTipTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTipTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTipTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTipTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTipTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TTipTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TTipTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TTipTmp.LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGc);
  Result := oTmpTable.FindKey([pDocNum,pGsCode]);
end;

function TTipTmp.LocateDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoPc);
  Result := oTmpTable.FindKey([pDocNum,pPosCode]);
end;

function TTipTmp.LocateDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoGcPc);
  Result := oTmpTable.FindKey([pDocNum,pGsCode,pPosCode]);
end;

procedure TTipTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTipTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTipTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTipTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTipTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTipTmp.First;
begin
  oTmpTable.First;
end;

procedure TTipTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTipTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTipTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTipTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTipTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTipTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTipTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTipTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTipTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTipTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTipTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
