unit pICW;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, hICW,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable, Forms;

const
  ixWrnNum = '';

type
  TIcwTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oIcdNum: Str12;
    oBtrData: TIcwHnd;
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadWrnNum:byte;        procedure WriteWrnNum (pValue:byte);
    function  ReadWrnVal:double;      procedure WriteWrnVal (pValue:double);
    function  ReadWrnDate:TDateTime;  procedure WriteWrnDate (pValue:TDateTime);
    function  ReadWrnUser:Str10;      procedure WriteWrnUser (pValue:Str10);
    function  ReadWrnName:Str30;      procedure WriteWrnName (pValue:Str30);
    function  ReadCrtUser:Str8;       procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDateTime;  procedure WriteCrtDate (pValue:TDateTime);
    function  ReadCrtTime:TDateTime;  procedure WriteCrtTime (pValue:TDateTime);
    function  ReadActPos:longint;     procedure WriteActPos  (pValue:longint);
    // Ostatne specialne metody
  public
    procedure LoadToTmp (pIcdNum:Str12);
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateWrnNum (pWrnNum:byte):boolean;
    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property BtrData:TIcwHnd read oBtrData write oBtrData;
    property Count:integer read ReadCount;

    property IcdNum:Str12 read oIcdNum write oIcdNum;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnVal:double read ReadWrnVal write WriteWrnVal;
    property WrnDate:TDateTime read ReadWrnDate write WriteWrnDate;
    property WrnUser:Str10 read ReadWrnUser write WriteWrnUser;
    property WrnName:Str30 read ReadWrnName write WriteWrnName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDateTime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDateTime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIcwTmp.Create;
begin
  oTmpTable := TmpInit ('ICW',Self);
  oBtrData := TIcwHnd.Create;
end;

destructor  TIcwTmp.Destroy;
begin
  oBtrData.Close; FreeAndNil (oBtrData);
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIcwTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIcwTmp.ReadWrnDate:TDateTime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIcwTmp.WriteWrnDate(pValue:TDateTime);
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

function TIcwTmp.ReadWrnVal:double;
begin
  Result := oTmpTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIcwTmp.WriteWrnVal(pValue:double);
begin
  oTmpTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIcwTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIcwTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIcwTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIcwTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIcwTmp.ReadCrtDate:TDateTime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIcwTmp.WriteCrtDate(pValue:TDateTime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIcwTmp.ReadCrtTime:TDateTime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIcwTmp.WriteCrtTime(pValue:TDateTime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIcwTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIcwTmp.WriteActPos  (pValue:longint);
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

procedure TIcwTmp.LoadToTmp (pIcdNum:Str12);
begin
  oIcdNum := pIcdNum;
  If oBtrData.LocateIcdNum (pIcdNum) then begin
    Repeat
      oTmpTable.Insert;
      BTR_To_PX (oBtrData.BtrTable,oTmpTable);
      oTmpTable.Post;
      Application.ProcessMessages;
      oBtrData.Next;
    until oBtrData.Eof or (oBtrData.IcdNum<>pIcdNum);
  end;
end;

procedure TIcwTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIcwTmp.Open(pBookNum:Str5);
begin
  oTmpTable.Open;
  oBtrData.Open(pBookNum);
end;

procedure TIcwTmp.Close;
begin
  oBtrData.Close;
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
  mEdit := (oTmpTable.FieldByName('ActPos').AsInteger<>0) and oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger);
  If mEdit
    then oBtrData.Edit
    else oBtrData.Insert;
  oBtrData.IcdNum := oIcdNum;
  PX_To_BTR (oTmpTable,oBtrData.BtrTable);
  oBtrData.Post;
  // Ulozime udje do TMP databaze
  oTmpTable.FieldByName('ActPos').AsInteger := oBtrData.ActPos;
  oTmpTable.Post;
end;

procedure TIcwTmp.Delete;
begin
  If oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger) then begin
    If (oBtrData.IcdNum=oIcdNum) and (oBtrData.WrnNum=WrnNum) then oBtrData.Delete;
  end;
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

end.
