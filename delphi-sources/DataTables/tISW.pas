unit tISW;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixWrnNum = '';

type
  TIswTmp = class (TComponent)
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
    function  ReadRegDate:TDatetime;     procedure WriteRegDate (pValue:TDatetime);
    function  ReadRegUser:Str10;         procedure WriteRegUser (pValue:Str10);
    function  ReadRegName:Str30;         procedure WriteRegName (pValue:Str30);
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
    property RegDate:TDatetime read ReadRegDate write WriteRegDate;
    property RegUser:Str10 read ReadRegUser write WriteRegUser;
    property RegName:Str30 read ReadRegName write WriteRegName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIswTmp.Create;
begin
  oTmpTable := TmpInit ('ISW',Self);
end;

destructor TIswTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIswTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIswTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIswTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIswTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIswTmp.ReadWrnVal:double;
begin
  Result := oTmpTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIswTmp.WriteWrnVal(pValue:double);
begin
  oTmpTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIswTmp.ReadWrnDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIswTmp.WriteWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIswTmp.ReadRegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RegDate').AsDateTime;
end;

procedure TIswTmp.WriteRegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RegDate').AsDateTime := pValue;
end;

function TIswTmp.ReadRegUser:Str10;
begin
  Result := oTmpTable.FieldByName('RegUser').AsString;
end;

procedure TIswTmp.WriteRegUser(pValue:Str10);
begin
  oTmpTable.FieldByName('RegUser').AsString := pValue;
end;

function TIswTmp.ReadRegName:Str30;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TIswTmp.WriteRegName(pValue:Str30);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TIswTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIswTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIswTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIswTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIswTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIswTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIswTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIswTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIswTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIswTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIswTmp.LocateWrnNum (pWrnNum:byte):boolean;
begin
  SetIndex (ixWrnNum);
  Result := oTmpTable.FindKey([pWrnNum]);
end;

procedure TIswTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIswTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIswTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIswTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIswTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIswTmp.First;
begin
  oTmpTable.First;
end;

procedure TIswTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIswTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIswTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIswTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIswTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIswTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIswTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIswTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIswTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIswTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIswTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
