unit pISW;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, hISW, hICW,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable, Forms;

const
  ixWrnNum = '';

type
  TIswTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oIsdNum: Str12;
    oBtrData: TIswHnd;
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function  ReadWrnNum:byte;        procedure WriteWrnNum (pValue:byte);
    function  ReadWrnVal:double;      procedure WriteWrnVal (pValue:double);
    function  ReadWrnDate:TDateTime;  procedure WriteWrnDate (pValue:TDateTime);
    function  ReadRegDate:TDateTime;  procedure WriteRegDate (pValue:TDateTime);
    function  ReadRegUser:Str10;      procedure WriteRegUser (pValue:Str10);
    function  ReadRegName:Str30;      procedure WriteRegName (pValue:Str30);
    function  ReadCrtUser:Str8;       procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDateTime;  procedure WriteCrtDate (pValue:TDateTime);
    function  ReadCrtTime:TDateTime;  procedure WriteCrtTime (pValue:TDateTime);
    function  ReadActPos:longint;     procedure WriteActPos  (pValue:longint);
    // Ostatne specialne metody
  public
    procedure LoadToTmp (pIsdNum:Str12);
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
    property BtrData:TIswHnd read oBtrData write oBtrData;
    property Count:integer read ReadCount;

    property IsdNum:Str12 read oIsdNum write oIsdNum;
    property WrnNum:byte read ReadWrnNum write WriteWrnNum;
    property WrnVal:double read ReadWrnVal write WriteWrnVal;
    property WrnDate:TDateTime read ReadWrnDate write WriteWrnDate;
    property RegDate:TDateTime read ReadRegDate write WriteRegDate;
    property RegUser:Str10 read ReadRegUser write WriteRegUser;
    property RegName:Str30 read ReadRegName write WriteRegName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDateTime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDateTime read ReadCrtTime write WriteCrtTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIswTmp.Create;
begin
  oTmpTable := TmpInit ('ISW',Self);
  oBtrData := TIswHnd.Create;
end;

destructor  TIswTmp.Destroy;
begin
  oBtrData.Close; FreeAndNil (oBtrData);
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIswTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIswTmp.ReadWrnDate:TDateTime;
begin
  Result := oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIswTmp.WriteWrnDate(pValue:TDateTime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime := pValue;
end;

function TIswTmp.ReadRegDate:TDateTime;
begin
  Result := oTmpTable.FieldByName('RegDate').AsDateTime;
end;

procedure TIswTmp.WriteRegDate(pValue:TDateTime);
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

function TIswTmp.ReadWrnVal:double;
begin
  Result := oTmpTable.FieldByName('WrnVal').AsFloat;
end;

procedure TIswTmp.WriteWrnVal(pValue:double);
begin
  oTmpTable.FieldByName('WrnVal').AsFloat := pValue;
end;

function TIswTmp.ReadWrnNum:byte;
begin
  Result := oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIswTmp.WriteWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger := pValue;
end;

function TIswTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIswTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIswTmp.ReadCrtDate:TDateTime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIswTmp.WriteCrtDate(pValue:TDateTime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIswTmp.ReadCrtTime:TDateTime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIswTmp.WriteCrtTime(pValue:TDateTime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIswTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIswTmp.WriteActPos  (pValue:longint);
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

procedure TIswTmp.LoadToTmp (pIsdNum:Str12);
begin
  oIsdNum := pIsdNum;
  If oBtrData.LocateIsdNum (pIsdNum) then begin
    Repeat
      oTmpTable.Insert;
      BTR_To_PX (oBtrData.BtrTable,oTmpTable);
      oTmpTable.Post;
      Application.ProcessMessages;
      oBtrData.Next;
    until oBtrData.Eof or (oBtrData.IsdNum<>pIsdNum);
  end;
end;

procedure TIswTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIswTmp.Open(pBookNum:Str5);
begin
  oTmpTable.Open;
  oBtrData.Open(pBookNum);
end;

procedure TIswTmp.Close;
begin
  oBtrData.Close;
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
  mEdit := (oTmpTable.FieldByName('ActPos').AsInteger<>0) and oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger);
  If mEdit
    then oBtrData.Edit
    else oBtrData.Insert;
  oBtrData.IsdNum := oIsdNum;
  PX_To_BTR (oTmpTable,oBtrData.BtrTable);
  oBtrData.Post;
  // Ulozime udje do TMP databaze
  oTmpTable.FieldByName('ActPos').AsInteger := oBtrData.ActPos;
  oTmpTable.Post;
end;

procedure TIswTmp.Delete;
begin
  If oBtrData.GotoPos(oTmpTable.FieldByName('ActPos').AsInteger) then begin
    If (oBtrData.IsdNum=oIsdNum) and (oBtrData.WrnNum=WrnNum) then oBtrData.Delete;
  end;
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

end.
