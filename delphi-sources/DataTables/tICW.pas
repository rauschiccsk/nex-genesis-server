unit tICW;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWrnNum = '';

type
  TIcwTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadWrnNum:byte;           procedure WriteWrnNum (pValue:byte);
    function  ReadWrnVal:double;         procedure WriteWrnVal (pValue:double);
    function  ReadWrnDate:TDatetime;     procedure WriteWrnDate (pValue:TDatetime);
    function  ReadWrnUser:Str10;         procedure WriteWrnUser (pValue:Str10);
    function  ReadWrnName:Str30;         procedure WriteWrnName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateWrnNum (pWrnNum:byte):boolean;

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
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnVal:double read ReadWrnVal write WriteWrnVal;
    property WrnDate:TDatetime read ReadWrnDate write WriteWrnDate;
    property WrnUser:Str10 read ReadWrnUser write WriteWrnUser;
    property WrnName:Str30 read ReadWrnName write WriteWrnName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIcwTmp.Create;
begin
  oTmpTable := TmpInit ('ICW',Self);
end;

destructor TIcwTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIcwTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIcwTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIcwTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIcwTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIcwTmp.ReadWrnVal:double;
begin
  Result := oTmpTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIcwTmp.WriteWrnVal(pValue:double);
begin
  oTmpTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIcwTmp.ReadWrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIcwTmp.WriteWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIcwTmp.ReadWrnUser:Str10;
begin
  Result := oTmpTable.FieldByName('WrnUser').AsString;
end;

procedure TIcwTmp.WriteWrnUser(pValue:Str10);
begin
  oTmpTable.FieldByName('WrnUser').AsString := pValue;
end;

function TIcwTmp.ReadWrnName:Str30;
begin
  Result := oTmpTable.FieldByName('WrnName').AsString;
end;

procedure TIcwTmp.WriteWrnName(pValue:Str30);
begin
  oTmpTable.FieldByName('WrnName').AsString := pValue;
end;

function TIcwTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIcwTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIcwTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIcwTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIcwTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIcwTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIcwTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIcwTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcwTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIcwTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIcwTmp.LocateWrnNum (pWrnNum:byte):boolean;
begin
  SetIndex (ixWrnNum);
  Result := oTmpTable.FindKey([pWrnNum]);
end;

procedure TIcwTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIcwTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIcwTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIcwTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIcwTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIcwTmp.First;
begin
  oTmpTable.First;
end;

procedure TIcwTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIcwTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIcwTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIcwTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIcwTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIcwTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIcwTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIcwTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIcwTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIcwTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIcwTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
