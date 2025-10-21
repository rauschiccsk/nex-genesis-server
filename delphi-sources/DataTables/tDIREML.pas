unit tDIREML;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TDiremlTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadEmlSpc:Str1;           procedure WriteEmlSpc (pValue:Str1);
    function  ReadEmlAdr:Str30;          procedure WriteEmlAdr (pValue:Str30);
    function  ReadEmlDes:Str60;          procedure WriteEmlDes (pValue:Str60);
    function  ReadMarker:Str1;           procedure WriteMarker (pValue:Str1);
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
    function LocateRowNum (pRowNum:word):boolean;

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
    property EmlSpc:Str1 read ReadEmlSpc write WriteEmlSpc;
    property EmlAdr:Str30 read ReadEmlAdr write WriteEmlAdr;
    property EmlDes:Str60 read ReadEmlDes write WriteEmlDes;
    property Marker:Str1 read ReadMarker write WriteMarker;
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

constructor TDiremlTmp.Create;
begin
  oTmpTable := TmpInit ('DIREML',Self);
end;

destructor TDiremlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDiremlTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDiremlTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDiremlTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TDiremlTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TDiremlTmp.ReadEmlSpc:Str1;
begin
  Result := oTmpTable.FieldByName('EmlSpc').AsString;
end;

procedure TDiremlTmp.WriteEmlSpc(pValue:Str1);
begin
  oTmpTable.FieldByName('EmlSpc').AsString := pValue;
end;

function TDiremlTmp.ReadEmlAdr:Str30;
begin
  Result := oTmpTable.FieldByName('EmlAdr').AsString;
end;

procedure TDiremlTmp.WriteEmlAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('EmlAdr').AsString := pValue;
end;

function TDiremlTmp.ReadEmlDes:Str60;
begin
  Result := oTmpTable.FieldByName('EmlDes').AsString;
end;

procedure TDiremlTmp.WriteEmlDes(pValue:Str60);
begin
  oTmpTable.FieldByName('EmlDes').AsString := pValue;
end;

function TDiremlTmp.ReadMarker:Str1;
begin
  Result := oTmpTable.FieldByName('Marker').AsString;
end;

procedure TDiremlTmp.WriteMarker(pValue:Str1);
begin
  oTmpTable.FieldByName('Marker').AsString := pValue;
end;

function TDiremlTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDiremlTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDiremlTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDiremlTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDiremlTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDiremlTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDiremlTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDiremlTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDiremlTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDiremlTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDiremlTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDiremlTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDiremlTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDiremlTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDiremlTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDiremlTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDiremlTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDiremlTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDiremlTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TDiremlTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDiremlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDiremlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDiremlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDiremlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDiremlTmp.First;
begin
  oTmpTable.First;
end;

procedure TDiremlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDiremlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDiremlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDiremlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDiremlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDiremlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDiremlTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDiremlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDiremlTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDiremlTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDiremlTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
