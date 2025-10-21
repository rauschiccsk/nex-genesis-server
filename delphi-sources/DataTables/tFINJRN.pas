unit tFINJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';
  ixDocDate = 'DocDate';
  ixDoIt = 'DoIt';
  ixCndNum = 'CndNum';

type
  TFinjrnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadCneNum:Str12;          procedure WriteCneNum (pValue:Str12);
    function  ReadAccText:Str30;         procedure WriteAccText (pValue:Str30);
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
    function  ReadValue26:double;        procedure WriteValue26 (pValue:double);
    function  ReadValue27:double;        procedure WriteValue27 (pValue:double);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCndNum:Str12;          procedure WriteCndNum (pValue:Str12);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateCndNum (pCndNum:Str12):boolean;

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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property CneNum:Str12 read ReadCneNum write WriteCneNum;
    property AccText:Str30 read ReadAccText write WriteAccText;
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
    property Value26:double read ReadValue26 write WriteValue26;
    property Value27:double read ReadValue27 write WriteValue27;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CndNum:Str12 read ReadCndNum write WriteCndNum;
  end;

implementation

constructor TFinjrnTmp.Create;
begin
  oTmpTable := TmpInit ('FINJRN',Self);
end;

destructor TFinjrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFinjrnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFinjrnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFinjrnTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TFinjrnTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TFinjrnTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFinjrnTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFinjrnTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFinjrnTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFinjrnTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFinjrnTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFinjrnTmp.ReadCneNum:Str12;
begin
  Result := oTmpTable.FieldByName('CneNum').AsString;
end;

procedure TFinjrnTmp.WriteCneNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CneNum').AsString := pValue;
end;

function TFinjrnTmp.ReadAccText:Str30;
begin
  Result := oTmpTable.FieldByName('AccText').AsString;
end;

procedure TFinjrnTmp.WriteAccText(pValue:Str30);
begin
  oTmpTable.FieldByName('AccText').AsString := pValue;
end;

function TFinjrnTmp.ReadValue01:double;
begin
  Result := oTmpTable.FieldByName('Value01').AsFloat;
end;

procedure TFinjrnTmp.WriteValue01(pValue:double);
begin
  oTmpTable.FieldByName('Value01').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue02:double;
begin
  Result := oTmpTable.FieldByName('Value02').AsFloat;
end;

procedure TFinjrnTmp.WriteValue02(pValue:double);
begin
  oTmpTable.FieldByName('Value02').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue03:double;
begin
  Result := oTmpTable.FieldByName('Value03').AsFloat;
end;

procedure TFinjrnTmp.WriteValue03(pValue:double);
begin
  oTmpTable.FieldByName('Value03').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue04:double;
begin
  Result := oTmpTable.FieldByName('Value04').AsFloat;
end;

procedure TFinjrnTmp.WriteValue04(pValue:double);
begin
  oTmpTable.FieldByName('Value04').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue05:double;
begin
  Result := oTmpTable.FieldByName('Value05').AsFloat;
end;

procedure TFinjrnTmp.WriteValue05(pValue:double);
begin
  oTmpTable.FieldByName('Value05').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue06:double;
begin
  Result := oTmpTable.FieldByName('Value06').AsFloat;
end;

procedure TFinjrnTmp.WriteValue06(pValue:double);
begin
  oTmpTable.FieldByName('Value06').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue07:double;
begin
  Result := oTmpTable.FieldByName('Value07').AsFloat;
end;

procedure TFinjrnTmp.WriteValue07(pValue:double);
begin
  oTmpTable.FieldByName('Value07').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue08:double;
begin
  Result := oTmpTable.FieldByName('Value08').AsFloat;
end;

procedure TFinjrnTmp.WriteValue08(pValue:double);
begin
  oTmpTable.FieldByName('Value08').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue09:double;
begin
  Result := oTmpTable.FieldByName('Value09').AsFloat;
end;

procedure TFinjrnTmp.WriteValue09(pValue:double);
begin
  oTmpTable.FieldByName('Value09').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue10:double;
begin
  Result := oTmpTable.FieldByName('Value10').AsFloat;
end;

procedure TFinjrnTmp.WriteValue10(pValue:double);
begin
  oTmpTable.FieldByName('Value10').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue11:double;
begin
  Result := oTmpTable.FieldByName('Value11').AsFloat;
end;

procedure TFinjrnTmp.WriteValue11(pValue:double);
begin
  oTmpTable.FieldByName('Value11').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue12:double;
begin
  Result := oTmpTable.FieldByName('Value12').AsFloat;
end;

procedure TFinjrnTmp.WriteValue12(pValue:double);
begin
  oTmpTable.FieldByName('Value12').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue13:double;
begin
  Result := oTmpTable.FieldByName('Value13').AsFloat;
end;

procedure TFinjrnTmp.WriteValue13(pValue:double);
begin
  oTmpTable.FieldByName('Value13').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue14:double;
begin
  Result := oTmpTable.FieldByName('Value14').AsFloat;
end;

procedure TFinjrnTmp.WriteValue14(pValue:double);
begin
  oTmpTable.FieldByName('Value14').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue15:double;
begin
  Result := oTmpTable.FieldByName('Value15').AsFloat;
end;

procedure TFinjrnTmp.WriteValue15(pValue:double);
begin
  oTmpTable.FieldByName('Value15').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue16:double;
begin
  Result := oTmpTable.FieldByName('Value16').AsFloat;
end;

procedure TFinjrnTmp.WriteValue16(pValue:double);
begin
  oTmpTable.FieldByName('Value16').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue17:double;
begin
  Result := oTmpTable.FieldByName('Value17').AsFloat;
end;

procedure TFinjrnTmp.WriteValue17(pValue:double);
begin
  oTmpTable.FieldByName('Value17').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue18:double;
begin
  Result := oTmpTable.FieldByName('Value18').AsFloat;
end;

procedure TFinjrnTmp.WriteValue18(pValue:double);
begin
  oTmpTable.FieldByName('Value18').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue19:double;
begin
  Result := oTmpTable.FieldByName('Value19').AsFloat;
end;

procedure TFinjrnTmp.WriteValue19(pValue:double);
begin
  oTmpTable.FieldByName('Value19').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue20:double;
begin
  Result := oTmpTable.FieldByName('Value20').AsFloat;
end;

procedure TFinjrnTmp.WriteValue20(pValue:double);
begin
  oTmpTable.FieldByName('Value20').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue21:double;
begin
  Result := oTmpTable.FieldByName('Value21').AsFloat;
end;

procedure TFinjrnTmp.WriteValue21(pValue:double);
begin
  oTmpTable.FieldByName('Value21').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue22:double;
begin
  Result := oTmpTable.FieldByName('Value22').AsFloat;
end;

procedure TFinjrnTmp.WriteValue22(pValue:double);
begin
  oTmpTable.FieldByName('Value22').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue23:double;
begin
  Result := oTmpTable.FieldByName('Value23').AsFloat;
end;

procedure TFinjrnTmp.WriteValue23(pValue:double);
begin
  oTmpTable.FieldByName('Value23').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue24:double;
begin
  Result := oTmpTable.FieldByName('Value24').AsFloat;
end;

procedure TFinjrnTmp.WriteValue24(pValue:double);
begin
  oTmpTable.FieldByName('Value24').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue25:double;
begin
  Result := oTmpTable.FieldByName('Value25').AsFloat;
end;

procedure TFinjrnTmp.WriteValue25(pValue:double);
begin
  oTmpTable.FieldByName('Value25').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue26:double;
begin
  Result := oTmpTable.FieldByName('Value26').AsFloat;
end;

procedure TFinjrnTmp.WriteValue26(pValue:double);
begin
  oTmpTable.FieldByName('Value26').AsFloat := pValue;
end;

function TFinjrnTmp.ReadValue27:double;
begin
  Result := oTmpTable.FieldByName('Value27').AsFloat;
end;

procedure TFinjrnTmp.WriteValue27(pValue:double);
begin
  oTmpTable.FieldByName('Value27').AsFloat := pValue;
end;

function TFinjrnTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TFinjrnTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFinjrnTmp.ReadCndNum:Str12;
begin
  Result := oTmpTable.FieldByName('CndNum').AsString;
end;

procedure TFinjrnTmp.WriteCndNum(pValue:Str12);
begin
  oTmpTable.FieldByName('CndNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFinjrnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFinjrnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFinjrnTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TFinjrnTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TFinjrnTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TFinjrnTmp.LocateCndNum (pCndNum:Str12):boolean;
begin
  SetIndex (ixCndNum);
  Result := oTmpTable.FindKey([pCndNum]);
end;

procedure TFinjrnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFinjrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFinjrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFinjrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFinjrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFinjrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TFinjrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFinjrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFinjrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFinjrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFinjrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFinjrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFinjrnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFinjrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFinjrnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFinjrnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFinjrnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
