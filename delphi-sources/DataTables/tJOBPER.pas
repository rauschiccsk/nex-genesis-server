unit tJOBPER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpcNum = '';

type
  TJobperTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    property LogName:Str8 read ReadLogName write WriteLogName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TJobperTmp.Create;
begin
  oTmpTable := TmpInit ('JOBPER',Self);
end;

destructor TJobperTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TJobperTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TJobperTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TJobperTmp.ReadEpcNum:word;
begin
  Result := oTmpTable.FieldByName('EpcNum').AsInteger;
end;

procedure TJobperTmp.WriteEpcNum(pValue:word);
begin
  oTmpTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TJobperTmp.ReadLogName:Str8;
begin
  Result := oTmpTable.FieldByName('LogName').AsString;
end;

procedure TJobperTmp.WriteLogName(pValue:Str8);
begin
  oTmpTable.FieldByName('LogName').AsString := pValue;
end;

function TJobperTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TJobperTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

function TJobperTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TJobperTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TJobperTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJobperTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJobperTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJobperTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJobperTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TJobperTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJobperTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TJobperTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TJobperTmp.LocateEpcNum (pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oTmpTable.FindKey([pEpcNum]);
end;

procedure TJobperTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TJobperTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TJobperTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TJobperTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TJobperTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TJobperTmp.First;
begin
  oTmpTable.First;
end;

procedure TJobperTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TJobperTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TJobperTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TJobperTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TJobperTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TJobperTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TJobperTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TJobperTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TJobperTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TJobperTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TJobperTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
