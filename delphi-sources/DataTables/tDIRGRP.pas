unit tDIRGRP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = '';
  ixGrpName_ = 'GrpName_';

type
  TDirgrpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str30;         procedure WriteGrpName (pValue:Str30);
    function  ReadGrpName_:Str30;        procedure WriteGrpName_ (pValue:Str30);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrpName_ (pGrpName_:Str30):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property GrpName_:Str30 read ReadGrpName_ write WriteGrpName_;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TDirgrpTmp.Create;
begin
  oTmpTable := TmpInit ('DIRGRP',Self);
end;

destructor TDirgrpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDirgrpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDirgrpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDirgrpTmp.ReadGrpNum:word;
begin
  Result := oTmpTable.FieldByName('GrpNum').AsInteger;
end;

procedure TDirgrpTmp.WriteGrpNum(pValue:word);
begin
  oTmpTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TDirgrpTmp.ReadGrpName:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName').AsString;
end;

procedure TDirgrpTmp.WriteGrpName(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName').AsString := pValue;
end;

function TDirgrpTmp.ReadGrpName_:Str30;
begin
  Result := oTmpTable.FieldByName('GrpName_').AsString;
end;

procedure TDirgrpTmp.WriteGrpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GrpName_').AsString := pValue;
end;

function TDirgrpTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TDirgrpTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirgrpTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirgrpTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirgrpTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirgrpTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirgrpTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TDirgrpTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirgrpTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirgrpTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirgrpTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirgrpTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirgrpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TDirgrpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirgrpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDirgrpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDirgrpTmp.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oTmpTable.FindKey([pGrpNum]);
end;

function TDirgrpTmp.LocateGrpName_ (pGrpName_:Str30):boolean;
begin
  SetIndex (ixGrpName_);
  Result := oTmpTable.FindKey([pGrpName_]);
end;

procedure TDirgrpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDirgrpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDirgrpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDirgrpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDirgrpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDirgrpTmp.First;
begin
  oTmpTable.First;
end;

procedure TDirgrpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDirgrpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDirgrpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDirgrpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDirgrpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDirgrpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDirgrpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDirgrpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDirgrpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDirgrpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDirgrpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
