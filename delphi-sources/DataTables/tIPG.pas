unit tIPG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = '';

type
  TIpgTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str50;         procedure WriteGrpName (pValue:Str50);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGrpNum (pGrpNum:word):boolean;

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
    property GrpName:Str50 read ReadGrpName write WriteGrpName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIpgTmp.Create;
begin
  oTmpTable := TmpInit ('IPG',Self);
end;

destructor TIpgTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIpgTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIpgTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIpgTmp.ReadGrpNum:word;
begin
  Result := oTmpTable.FieldByName('GrpNum').AsInteger;
end;

procedure TIpgTmp.WriteGrpNum(pValue:word);
begin
  oTmpTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TIpgTmp.ReadGrpName:Str50;
begin
  Result := oTmpTable.FieldByName('GrpName').AsString;
end;

procedure TIpgTmp.WriteGrpName(pValue:Str50);
begin
  oTmpTable.FieldByName('GrpName').AsString := pValue;
end;

function TIpgTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIpgTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIpgTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIpgTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIpgTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIpgTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIpgTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIpgTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIpgTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIpgTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIpgTmp.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oTmpTable.FindKey([pGrpNum]);
end;

procedure TIpgTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIpgTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIpgTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIpgTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIpgTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIpgTmp.First;
begin
  oTmpTable.First;
end;

procedure TIpgTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIpgTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIpgTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIpgTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIpgTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIpgTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIpgTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIpgTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIpgTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIpgTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIpgTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
