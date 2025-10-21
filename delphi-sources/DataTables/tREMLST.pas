unit tREMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixInRn = '';

type
  TRemlstTmp = class (TComponent)
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

constructor TRemlstTmp.Create;
begin
  oTmpTable := TmpInit ('REMLST',Self);
end;

destructor TRemlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRemlstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRemlstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRemlstTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TRemlstTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TRemlstTmp.ReadRemNum:word;
begin
  Result := oTmpTable.FieldByName('RemNum').AsInteger;
end;

procedure TRemlstTmp.WriteRemNum(pValue:word);
begin
  oTmpTable.FieldByName('RemNum').AsInteger := pValue;
end;

function TRemlstTmp.ReadRemTxt:Str90;
begin
  Result := oTmpTable.FieldByName('RemTxt').AsString;
end;

procedure TRemlstTmp.WriteRemTxt(pValue:Str90);
begin
  oTmpTable.FieldByName('RemTxt').AsString := pValue;
end;

function TRemlstTmp.ReadUsrLev:byte;
begin
  Result := oTmpTable.FieldByName('UsrLev').AsInteger;
end;

procedure TRemlstTmp.WriteUsrLev(pValue:byte);
begin
  oTmpTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TRemlstTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRemlstTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRemlstTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TRemlstTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TRemlstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRemlstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRemlstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRemlstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRemlstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRemlstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRemlstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRemlstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRemlstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRemlstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRemlstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRemlstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRemlstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRemlstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRemlstTmp.LocateInRn (pItmNum:word;pRemNum:word):boolean;
begin
  SetIndex (ixInRn);
  Result := oTmpTable.FindKey([pItmNum,pRemNum]);
end;

procedure TRemlstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRemlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRemlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRemlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRemlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRemlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TRemlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRemlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRemlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRemlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRemlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRemlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRemlstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRemlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRemlstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRemlstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRemlstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1907001}
