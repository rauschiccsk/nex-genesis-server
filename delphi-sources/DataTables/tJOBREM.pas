unit tJOBREM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixInRn = '';

type
  TJobremTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
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
    function LocateInRn (pItmNum:word;pRemNum:word):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
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

constructor TJobremTmp.Create;
begin
  oTmpTable := TmpInit ('JOBREM',Self);
end;

destructor TJobremTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TJobremTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TJobremTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TJobremTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJobremTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJobremTmp.ReadRemNum:word;
begin
  Result := oTmpTable.FieldByName('RemNum').AsInteger;
end;

procedure TJobremTmp.WriteRemNum(pValue:word);
begin
  oTmpTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TJobremTmp.ReadRemTxt:Str90;
begin
  Result := oTmpTable.FieldByName('RemTxt').AsString;
end;

procedure TJobremTmp.WriteRemTxt(pValue:Str90);
begin
  oTmpTable.FieldByName('RemTxt').AsString := pValue;
end;

function TJobremTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TJobremTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TJobremTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TJobremTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TJobremTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TJobremTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TJobremTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJobremTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJobremTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJobremTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJobremTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TJobremTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TJobremTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJobremTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJobremTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJobremTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJobremTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TJobremTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobremTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TJobremTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TJobremTmp.LocateInRn (pItmNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixInRn);
  Result := oTmpTable.FindKey([pItmNum,pRemNum]);
end;

procedure TJobremTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TJobremTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TJobremTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TJobremTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TJobremTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TJobremTmp.First;
begin
  oTmpTable.First;
end;

procedure TJobremTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TJobremTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TJobremTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TJobremTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TJobremTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TJobremTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TJobremTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TJobremTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TJobremTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TJobremTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TJobremTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
