unit tDIREPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpcNum = '';

type
  TDirepcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpcName:Str30;         procedure WriteEpcName (pValue:Str30);
    function  ReadEpcName_:Str30;        procedure WriteEpcName_ (pValue:Str30);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
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
    function LocateEpcNum (pEpcNum:word):boolean;

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
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpcName:Str30 read ReadEpcName write WriteEpcName;
    property EpcName_:Str30 read ReadEpcName_ write WriteEpcName_;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirepcTmp.Create;
begin
  oTmpTable := TmpInit ('DIREPC',Self);
end;

destructor TDirepcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirepcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirepcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirepcTmp.ReadEpcNum:word;
begin
  Result := oTmpTable.FieldByName('EpcNum').AsInteger;
end;

procedure TDirepcTmp.WriteEpcNum(pValue:word);
begin
  oTmpTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TDirepcTmp.ReadEpcName:Str30;
begin
  Result := oTmpTable.FieldByName('EpcName').AsString;
end;

procedure TDirepcTmp.WriteEpcName(pValue:Str30);
begin
  oTmpTable.FieldByName('EpcName').AsString := pValue;
end;

function TDirepcTmp.ReadEpcName_:Str30;
begin
  Result := oTmpTable.FieldByName('EpcName_').AsString;
end;

procedure TDirepcTmp.WriteEpcName_(pValue:Str30);
begin
  oTmpTable.FieldByName('EpcName_').AsString := pValue;
end;

function TDirepcTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirepcTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirepcTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirepcTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirepcTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirepcTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirepcTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirepcTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirepcTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDirepcTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirepcTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirepcTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirepcTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirepcTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirepcTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirepcTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirepcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirepcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirepcTmp.LocateEpcNum (pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oTmpTable.FindKey([pEpcNum]);
end;

procedure TDirepcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirepcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirepcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirepcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirepcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirepcTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirepcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirepcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirepcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirepcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirepcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirepcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirepcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirepcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirepcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirepcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirepcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
