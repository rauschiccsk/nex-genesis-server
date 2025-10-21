unit tFRPDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';

type
  TFrpdocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadMyPaIno:Str25;         procedure WriteMyPaIno (pValue:Str25);
    function  ReadBegDate:Str25;         procedure WriteBegDate (pValue:Str25);
    function  ReadEndDate:Str20;         procedure WriteEndDate (pValue:Str20);
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
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property MyPaIno:Str25 read ReadMyPaIno write WriteMyPaIno;
    property BegDate:Str25 read ReadBegDate write WriteBegDate;
    property EndDate:Str20 read ReadEndDate write WriteEndDate;
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
  end;

implementation

constructor TFrpdocTmp.Create;
begin
  oTmpTable := TmpInit ('FRPDOC',Self);
end;

destructor TFrpdocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFrpdocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFrpdocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFrpdocTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TFrpdocTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFrpdocTmp.ReadMyPaIno:Str25;
begin
  Result := oTmpTable.FieldByName('MyPaIno').AsString;
end;

procedure TFrpdocTmp.WriteMyPaIno(pValue:Str25);
begin
  oTmpTable.FieldByName('MyPaIno').AsString := pValue;
end;

function TFrpdocTmp.ReadBegDate:Str25;
begin
  Result := oTmpTable.FieldByName('BegDate').AsString;
end;

procedure TFrpdocTmp.WriteBegDate(pValue:Str25);
begin
  oTmpTable.FieldByName('BegDate').AsString := pValue;
end;

function TFrpdocTmp.ReadEndDate:Str20;
begin
  Result := oTmpTable.FieldByName('EndDate').AsString;
end;

procedure TFrpdocTmp.WriteEndDate(pValue:Str20);
begin
  oTmpTable.FieldByName('EndDate').AsString := pValue;
end;

function TFrpdocTmp.ReadValue01:double;
begin
  Result := oTmpTable.FieldByName('Value01').AsFloat;
end;

procedure TFrpdocTmp.WriteValue01(pValue:double);
begin
  oTmpTable.FieldByName('Value01').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue02:double;
begin
  Result := oTmpTable.FieldByName('Value02').AsFloat;
end;

procedure TFrpdocTmp.WriteValue02(pValue:double);
begin
  oTmpTable.FieldByName('Value02').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue03:double;
begin
  Result := oTmpTable.FieldByName('Value03').AsFloat;
end;

procedure TFrpdocTmp.WriteValue03(pValue:double);
begin
  oTmpTable.FieldByName('Value03').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue04:double;
begin
  Result := oTmpTable.FieldByName('Value04').AsFloat;
end;

procedure TFrpdocTmp.WriteValue04(pValue:double);
begin
  oTmpTable.FieldByName('Value04').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue05:double;
begin
  Result := oTmpTable.FieldByName('Value05').AsFloat;
end;

procedure TFrpdocTmp.WriteValue05(pValue:double);
begin
  oTmpTable.FieldByName('Value05').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue06:double;
begin
  Result := oTmpTable.FieldByName('Value06').AsFloat;
end;

procedure TFrpdocTmp.WriteValue06(pValue:double);
begin
  oTmpTable.FieldByName('Value06').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue07:double;
begin
  Result := oTmpTable.FieldByName('Value07').AsFloat;
end;

procedure TFrpdocTmp.WriteValue07(pValue:double);
begin
  oTmpTable.FieldByName('Value07').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue08:double;
begin
  Result := oTmpTable.FieldByName('Value08').AsFloat;
end;

procedure TFrpdocTmp.WriteValue08(pValue:double);
begin
  oTmpTable.FieldByName('Value08').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue09:double;
begin
  Result := oTmpTable.FieldByName('Value09').AsFloat;
end;

procedure TFrpdocTmp.WriteValue09(pValue:double);
begin
  oTmpTable.FieldByName('Value09').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue10:double;
begin
  Result := oTmpTable.FieldByName('Value10').AsFloat;
end;

procedure TFrpdocTmp.WriteValue10(pValue:double);
begin
  oTmpTable.FieldByName('Value10').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue11:double;
begin
  Result := oTmpTable.FieldByName('Value11').AsFloat;
end;

procedure TFrpdocTmp.WriteValue11(pValue:double);
begin
  oTmpTable.FieldByName('Value11').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue12:double;
begin
  Result := oTmpTable.FieldByName('Value12').AsFloat;
end;

procedure TFrpdocTmp.WriteValue12(pValue:double);
begin
  oTmpTable.FieldByName('Value12').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue13:double;
begin
  Result := oTmpTable.FieldByName('Value13').AsFloat;
end;

procedure TFrpdocTmp.WriteValue13(pValue:double);
begin
  oTmpTable.FieldByName('Value13').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue14:double;
begin
  Result := oTmpTable.FieldByName('Value14').AsFloat;
end;

procedure TFrpdocTmp.WriteValue14(pValue:double);
begin
  oTmpTable.FieldByName('Value14').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue15:double;
begin
  Result := oTmpTable.FieldByName('Value15').AsFloat;
end;

procedure TFrpdocTmp.WriteValue15(pValue:double);
begin
  oTmpTable.FieldByName('Value15').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue16:double;
begin
  Result := oTmpTable.FieldByName('Value16').AsFloat;
end;

procedure TFrpdocTmp.WriteValue16(pValue:double);
begin
  oTmpTable.FieldByName('Value16').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue17:double;
begin
  Result := oTmpTable.FieldByName('Value17').AsFloat;
end;

procedure TFrpdocTmp.WriteValue17(pValue:double);
begin
  oTmpTable.FieldByName('Value17').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue18:double;
begin
  Result := oTmpTable.FieldByName('Value18').AsFloat;
end;

procedure TFrpdocTmp.WriteValue18(pValue:double);
begin
  oTmpTable.FieldByName('Value18').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue19:double;
begin
  Result := oTmpTable.FieldByName('Value19').AsFloat;
end;

procedure TFrpdocTmp.WriteValue19(pValue:double);
begin
  oTmpTable.FieldByName('Value19').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue20:double;
begin
  Result := oTmpTable.FieldByName('Value20').AsFloat;
end;

procedure TFrpdocTmp.WriteValue20(pValue:double);
begin
  oTmpTable.FieldByName('Value20').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue21:double;
begin
  Result := oTmpTable.FieldByName('Value21').AsFloat;
end;

procedure TFrpdocTmp.WriteValue21(pValue:double);
begin
  oTmpTable.FieldByName('Value21').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue22:double;
begin
  Result := oTmpTable.FieldByName('Value22').AsFloat;
end;

procedure TFrpdocTmp.WriteValue22(pValue:double);
begin
  oTmpTable.FieldByName('Value22').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue23:double;
begin
  Result := oTmpTable.FieldByName('Value23').AsFloat;
end;

procedure TFrpdocTmp.WriteValue23(pValue:double);
begin
  oTmpTable.FieldByName('Value23').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue24:double;
begin
  Result := oTmpTable.FieldByName('Value24').AsFloat;
end;

procedure TFrpdocTmp.WriteValue24(pValue:double);
begin
  oTmpTable.FieldByName('Value24').AsFloat := pValue;
end;

function TFrpdocTmp.ReadValue25:double;
begin
  Result := oTmpTable.FieldByName('Value25').AsFloat;
end;

procedure TFrpdocTmp.WriteValue25(pValue:double);
begin
  oTmpTable.FieldByName('Value25').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFrpdocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFrpdocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFrpdocTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

procedure TFrpdocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFrpdocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFrpdocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFrpdocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFrpdocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFrpdocTmp.First;
begin
  oTmpTable.First;
end;

procedure TFrpdocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFrpdocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFrpdocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFrpdocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFrpdocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFrpdocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFrpdocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFrpdocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFrpdocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFrpdocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFrpdocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
