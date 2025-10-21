unit tATTLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnAn = '';
  ixDocNum = 'DocNum';
  ixAttNum = 'AttNum';
  ixAttFile = 'AttFile';

type
  TAttlstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadAttNum:word;           procedure WriteAttNum (pValue:word);
    function  ReadAttType:byte;          procedure WriteAttType (pValue:byte);
    function  ReadAttPath:Str120;        procedure WriteAttPath (pValue:Str120);
    function  ReadAttFile:Str80;         procedure WriteAttFile (pValue:Str80);
    function  ReadAttProg:Str200;        procedure WriteAttProg (pValue:Str200);
    function  ReadAttSize:longint;       procedure WriteAttSize (pValue:longint);
    function  ReadAttDate:TDatetime;     procedure WriteAttDate (pValue:TDatetime);
    function  ReadAttTime:TDatetime;     procedure WriteAttTime (pValue:TDatetime);
    function  ReadAttAttr:byte;          procedure WriteAttAttr (pValue:byte);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDnAn (pDocNum:Str12;pAttNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateAttNum (pAttNum:word):boolean;
    function LocateAttFile (pAttFile:Str80):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property AttNum:word read ReadAttNum write WriteAttNum;
    property AttType:byte read ReadAttType write WriteAttType;
    property AttPath:Str120 read ReadAttPath write WriteAttPath;
    property AttFile:Str80 read ReadAttFile write WriteAttFile;
    property AttProg:Str200 read ReadAttProg write WriteAttProg;
    property AttSize:longint read ReadAttSize write WriteAttSize;
    property AttDate:TDatetime read ReadAttDate write WriteAttDate;
    property AttTime:TDatetime read ReadAttTime write WriteAttTime;
    property AttAttr:byte read ReadAttAttr write WriteAttAttr;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAttlstTmp.Create;
begin
  oTmpTable := TmpInit ('ATTLST',Self);
end;

destructor TAttlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAttlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAttlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAttlstTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAttlstTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAttlstTmp.ReadAttNum:word;
begin
  Result := oTmpTable.FieldByName('AttNum').AsInteger;
end;

procedure TAttlstTmp.WriteAttNum(pValue:word);
begin
  oTmpTable.FieldByName('AttNum').AsInteger := pValue;
end;

function TAttlstTmp.ReadAttType:byte;
begin
  Result := oTmpTable.FieldByName('AttType').AsInteger;
end;

procedure TAttlstTmp.WriteAttType(pValue:byte);
begin
  oTmpTable.FieldByName('AttType').AsInteger := pValue;
end;

function TAttlstTmp.ReadAttPath:Str120;
begin
  Result := oTmpTable.FieldByName('AttPath').AsString;
end;

procedure TAttlstTmp.WriteAttPath(pValue:Str120);
begin
  oTmpTable.FieldByName('AttPath').AsString := pValue;
end;

function TAttlstTmp.ReadAttFile:Str80;
begin
  Result := oTmpTable.FieldByName('AttFile').AsString;
end;

procedure TAttlstTmp.WriteAttFile(pValue:Str80);
begin
  oTmpTable.FieldByName('AttFile').AsString := pValue;
end;

function TAttlstTmp.ReadAttProg:Str200;
begin
  Result := oTmpTable.FieldByName('AttProg').AsString;
end;

procedure TAttlstTmp.WriteAttProg(pValue:Str200);
begin
  oTmpTable.FieldByName('AttProg').AsString := pValue;
end;

function TAttlstTmp.ReadAttSize:longint;
begin
  Result := oTmpTable.FieldByName('AttSize').AsInteger;
end;

procedure TAttlstTmp.WriteAttSize(pValue:longint);
begin
  oTmpTable.FieldByName('AttSize').AsInteger := pValue;
end;

function TAttlstTmp.ReadAttDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AttDate').AsDateTime;
end;

procedure TAttlstTmp.WriteAttDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AttDate').AsDateTime := pValue;
end;

function TAttlstTmp.ReadAttTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('AttTime').AsDateTime;
end;

procedure TAttlstTmp.WriteAttTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AttTime').AsDateTime := pValue;
end;

function TAttlstTmp.ReadAttAttr:byte;
begin
  Result := oTmpTable.FieldByName('AttAttr').AsInteger;
end;

procedure TAttlstTmp.WriteAttAttr(pValue:byte);
begin
  oTmpTable.FieldByName('AttAttr').AsInteger := pValue;
end;

function TAttlstTmp.ReadCrtName:str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TAttlstTmp.WriteCrtName(pValue:str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TAttlstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAttlstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAttlstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAttlstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAttlstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAttlstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAttlstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAttlstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAttlstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAttlstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAttlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAttlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAttlstTmp.LocateDnAn (pDocNum:Str12;pAttNum:word):boolean;
begin
  SetIndex (ixDnAn);
  Result := oTmpTable.FindKey([pDocNum,pAttNum]);
end;

function TAttlstTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAttlstTmp.LocateAttNum (pAttNum:word):boolean;
begin
  SetIndex (ixAttNum);
  Result := oTmpTable.FindKey([pAttNum]);
end;

function TAttlstTmp.LocateAttFile (pAttFile:Str80):boolean;
begin
  SetIndex (ixAttFile);
  Result := oTmpTable.FindKey([pAttFile]);
end;

procedure TAttlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAttlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAttlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAttlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAttlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAttlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TAttlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAttlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAttlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAttlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAttlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAttlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAttlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAttlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAttlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAttlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAttlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1902010}
