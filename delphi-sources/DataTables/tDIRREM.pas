unit tDIRREM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRemNum = '';

type
  TDirremTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRemNum (pRemNum:word):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirremTmp.Create;
begin
  oTmpTable := TmpInit ('DIRREM',Self);
end;

destructor TDirremTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirremTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirremTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirremTmp.ReadRemNum:word;
begin
  Result := oTmpTable.FieldByName('RemNum').AsInteger;
end;

procedure TDirremTmp.WriteRemNum(pValue:word);
begin
  oTmpTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TDirremTmp.ReadRemTxt:Str90;
begin
  Result := oTmpTable.FieldByName('RemTxt').AsString;
end;

procedure TDirremTmp.WriteRemTxt(pValue:Str90);
begin
  oTmpTable.FieldByName('RemTxt').AsString := pValue;
end;

function TDirremTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirremTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirremTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirremTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirremTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TDirremTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TDirremTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirremTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirremTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirremTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirremTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDirremTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirremTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirremTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirremTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirremTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirremTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirremTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirremTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirremTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirremTmp.LocateRemNum (pRemNum:word):boolean;
begin
  SetIndex (ixRemNum);
  Result := oTmpTable.FindKey([pRemNum]);
end;

procedure TDirremTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirremTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirremTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirremTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirremTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirremTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirremTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirremTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirremTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirremTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirremTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirremTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirremTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirremTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirremTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirremTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirremTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
