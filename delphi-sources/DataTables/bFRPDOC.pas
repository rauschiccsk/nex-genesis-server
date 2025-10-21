unit bFRPDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = 'SerNum';

type
  TFrpdocBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadValue01:double;        procedure WriteValue01 (pValue:double);
    function  ReadValue02:double;        procedure WriteValue02 (pValue:double);
    function  ReadValue03:double;        procedure WriteValue03 (pValue:double);
    function  ReadValue04:double;        procedure WriteValue04 (pValue:double);
    function  ReadValue05:double;        procedure WriteValue05 (pValue:double);
    function  ReadValue06:double;        procedure WriteValue06 (pValue:double);
    function  ReadValue07:double;        procedure WriteValue07 (pValue:double);
    function  ReadValue08:double;        procedure WriteValue08 (pValue:double);
    function  ReadValue09:double;        procedure WriteValue09 (pValue:double);
    function  ReadValue10:double;        procedure WriteValue10 (pValue:double);
    function  ReadValue11:double;        procedure WriteValue11 (pValue:double);
    function  ReadValue12:double;        procedure WriteValue12 (pValue:double);
    function  ReadValue13:double;        procedure WriteValue13 (pValue:double);
    function  ReadValue14:double;        procedure WriteValue14 (pValue:double);
    function  ReadValue15:double;        procedure WriteValue15 (pValue:double);
    function  ReadValue16:double;        procedure WriteValue16 (pValue:double);
    function  ReadValue17:double;        procedure WriteValue17 (pValue:double);
    function  ReadValue18:double;        procedure WriteValue18 (pValue:double);
    function  ReadValue19:double;        procedure WriteValue19 (pValue:double);
    function  ReadValue20:double;        procedure WriteValue20 (pValue:double);
    function  ReadValue21:double;        procedure WriteValue21 (pValue:double);
    function  ReadValue22:double;        procedure WriteValue22 (pValue:double);
    function  ReadValue23:double;        procedure WriteValue23 (pValue:double);
    function  ReadValue24:double;        procedure WriteValue24 (pValue:double);
    function  ReadValue25:double;        procedure WriteValue25 (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property Value01:double read ReadValue01 write WriteValue01;
    property Value02:double read ReadValue02 write WriteValue02;
    property Value03:double read ReadValue03 write WriteValue03;
    property Value04:double read ReadValue04 write WriteValue04;
    property Value05:double read ReadValue05 write WriteValue05;
    property Value06:double read ReadValue06 write WriteValue06;
    property Value07:double read ReadValue07 write WriteValue07;
    property Value08:double read ReadValue08 write WriteValue08;
    property Value09:double read ReadValue09 write WriteValue09;
    property Value10:double read ReadValue10 write WriteValue10;
    property Value11:double read ReadValue11 write WriteValue11;
    property Value12:double read ReadValue12 write WriteValue12;
    property Value13:double read ReadValue13 write WriteValue13;
    property Value14:double read ReadValue14 write WriteValue14;
    property Value15:double read ReadValue15 write WriteValue15;
    property Value16:double read ReadValue16 write WriteValue16;
    property Value17:double read ReadValue17 write WriteValue17;
    property Value18:double read ReadValue18 write WriteValue18;
    property Value19:double read ReadValue19 write WriteValue19;
    property Value20:double read ReadValue20 write WriteValue20;
    property Value21:double read ReadValue21 write WriteValue21;
    property Value22:double read ReadValue22 write WriteValue22;
    property Value23:double read ReadValue23 write WriteValue23;
    property Value24:double read ReadValue24 write WriteValue24;
    property Value25:double read ReadValue25 write WriteValue25;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TFrpdocBtr.Create;
begin
  oBtrTable := BtrInit ('FRPDOC',gPath.LdgPath,Self);
end;

constructor TFrpdocBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FRPDOC',pPath,Self);
end;

destructor TFrpdocBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFrpdocBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFrpdocBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFrpdocBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TFrpdocBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFrpdocBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFrpdocBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFrpdocBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TFrpdocBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TFrpdocBtr.ReadValue01:double;
begin
  Result := oBtrTable.FieldByName('Value01').AsFloat;
end;

procedure TFrpdocBtr.WriteValue01(pValue:double);
begin
  oBtrTable.FieldByName('Value01').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue02:double;
begin
  Result := oBtrTable.FieldByName('Value02').AsFloat;
end;

procedure TFrpdocBtr.WriteValue02(pValue:double);
begin
  oBtrTable.FieldByName('Value02').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue03:double;
begin
  Result := oBtrTable.FieldByName('Value03').AsFloat;
end;

procedure TFrpdocBtr.WriteValue03(pValue:double);
begin
  oBtrTable.FieldByName('Value03').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue04:double;
begin
  Result := oBtrTable.FieldByName('Value04').AsFloat;
end;

procedure TFrpdocBtr.WriteValue04(pValue:double);
begin
  oBtrTable.FieldByName('Value04').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue05:double;
begin
  Result := oBtrTable.FieldByName('Value05').AsFloat;
end;

procedure TFrpdocBtr.WriteValue05(pValue:double);
begin
  oBtrTable.FieldByName('Value05').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue06:double;
begin
  Result := oBtrTable.FieldByName('Value06').AsFloat;
end;

procedure TFrpdocBtr.WriteValue06(pValue:double);
begin
  oBtrTable.FieldByName('Value06').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue07:double;
begin
  Result := oBtrTable.FieldByName('Value07').AsFloat;
end;

procedure TFrpdocBtr.WriteValue07(pValue:double);
begin
  oBtrTable.FieldByName('Value07').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue08:double;
begin
  Result := oBtrTable.FieldByName('Value08').AsFloat;
end;

procedure TFrpdocBtr.WriteValue08(pValue:double);
begin
  oBtrTable.FieldByName('Value08').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue09:double;
begin
  Result := oBtrTable.FieldByName('Value09').AsFloat;
end;

procedure TFrpdocBtr.WriteValue09(pValue:double);
begin
  oBtrTable.FieldByName('Value09').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue10:double;
begin
  Result := oBtrTable.FieldByName('Value10').AsFloat;
end;

procedure TFrpdocBtr.WriteValue10(pValue:double);
begin
  oBtrTable.FieldByName('Value10').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue11:double;
begin
  Result := oBtrTable.FieldByName('Value11').AsFloat;
end;

procedure TFrpdocBtr.WriteValue11(pValue:double);
begin
  oBtrTable.FieldByName('Value11').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue12:double;
begin
  Result := oBtrTable.FieldByName('Value12').AsFloat;
end;

procedure TFrpdocBtr.WriteValue12(pValue:double);
begin
  oBtrTable.FieldByName('Value12').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue13:double;
begin
  Result := oBtrTable.FieldByName('Value13').AsFloat;
end;

procedure TFrpdocBtr.WriteValue13(pValue:double);
begin
  oBtrTable.FieldByName('Value13').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue14:double;
begin
  Result := oBtrTable.FieldByName('Value14').AsFloat;
end;

procedure TFrpdocBtr.WriteValue14(pValue:double);
begin
  oBtrTable.FieldByName('Value14').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue15:double;
begin
  Result := oBtrTable.FieldByName('Value15').AsFloat;
end;

procedure TFrpdocBtr.WriteValue15(pValue:double);
begin
  oBtrTable.FieldByName('Value15').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue16:double;
begin
  Result := oBtrTable.FieldByName('Value16').AsFloat;
end;

procedure TFrpdocBtr.WriteValue16(pValue:double);
begin
  oBtrTable.FieldByName('Value16').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue17:double;
begin
  Result := oBtrTable.FieldByName('Value17').AsFloat;
end;

procedure TFrpdocBtr.WriteValue17(pValue:double);
begin
  oBtrTable.FieldByName('Value17').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue18:double;
begin
  Result := oBtrTable.FieldByName('Value18').AsFloat;
end;

procedure TFrpdocBtr.WriteValue18(pValue:double);
begin
  oBtrTable.FieldByName('Value18').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue19:double;
begin
  Result := oBtrTable.FieldByName('Value19').AsFloat;
end;

procedure TFrpdocBtr.WriteValue19(pValue:double);
begin
  oBtrTable.FieldByName('Value19').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue20:double;
begin
  Result := oBtrTable.FieldByName('Value20').AsFloat;
end;

procedure TFrpdocBtr.WriteValue20(pValue:double);
begin
  oBtrTable.FieldByName('Value20').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue21:double;
begin
  Result := oBtrTable.FieldByName('Value21').AsFloat;
end;

procedure TFrpdocBtr.WriteValue21(pValue:double);
begin
  oBtrTable.FieldByName('Value21').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue22:double;
begin
  Result := oBtrTable.FieldByName('Value22').AsFloat;
end;

procedure TFrpdocBtr.WriteValue22(pValue:double);
begin
  oBtrTable.FieldByName('Value22').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue23:double;
begin
  Result := oBtrTable.FieldByName('Value23').AsFloat;
end;

procedure TFrpdocBtr.WriteValue23(pValue:double);
begin
  oBtrTable.FieldByName('Value23').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue24:double;
begin
  Result := oBtrTable.FieldByName('Value24').AsFloat;
end;

procedure TFrpdocBtr.WriteValue24(pValue:double);
begin
  oBtrTable.FieldByName('Value24').AsFloat := pValue;
end;

function TFrpdocBtr.ReadValue25:double;
begin
  Result := oBtrTable.FieldByName('Value25').AsFloat;
end;

procedure TFrpdocBtr.WriteValue25(pValue:double);
begin
  oBtrTable.FieldByName('Value25').AsFloat := pValue;
end;

function TFrpdocBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TFrpdocBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TFrpdocBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFrpdocBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFrpdocBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFrpdocBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFrpdocBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFrpdocBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFrpdocBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFrpdocBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFrpdocBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFrpdocBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFrpdocBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TFrpdocBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

procedure TFrpdocBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFrpdocBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFrpdocBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFrpdocBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFrpdocBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFrpdocBtr.First;
begin
  oBtrTable.First;
end;

procedure TFrpdocBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFrpdocBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFrpdocBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFrpdocBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFrpdocBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFrpdocBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFrpdocBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFrpdocBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFrpdocBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFrpdocBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFrpdocBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
