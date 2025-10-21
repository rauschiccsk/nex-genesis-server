unit bOcc;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixSended = 'Sended';

type
  TOccBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSpePrc:double;         procedure WriteSpePrc (pValue:double);
    function  ReadSpeDay:word;           procedure WriteSpeDay (pValue:word);
    function  ReadIcdPrc1:double;        procedure WriteIcdPrc1 (pValue:double);
    function  ReadIcdDay1:word;          procedure WriteIcdDay1 (pValue:word);
    function  ReadIcdPrc2:double;        procedure WriteIcdPrc2 (pValue:double);
    function  ReadIcdDay2:word;          procedure WriteIcdDay2 (pValue:word);
    function  ReadSupTrmD:word;          procedure WriteSupTrmD (pValue:word);
    function  ReadSupTrmW:byte;          procedure WriteSupTrmW (pValue:byte);
    function  ReadGrcYear:byte;          procedure WriteGrcYear (pValue:byte);
    function  ReadDescr01:Str200;        procedure WriteDescr01 (pValue:Str200);
    function  ReadDescr02:Str200;        procedure WriteDescr02 (pValue:Str200);
    function  ReadDescr03:Str200;        procedure WriteDescr03 (pValue:Str200);
    function  ReadDescr04:Str200;        procedure WriteDescr04 (pValue:Str200);
    function  ReadDescr05:Str200;        procedure WriteDescr05 (pValue:Str200);
    function  ReadDescr06:Str200;        procedure WriteDescr06 (pValue:Str200);
    function  ReadDescr07:Str200;        procedure WriteDescr07 (pValue:Str200);
    function  ReadDescr08:Str200;        procedure WriteDescr08 (pValue:Str200);
    function  ReadDescr09:Str200;        procedure WriteDescr09 (pValue:Str200);
    function  ReadDescr10:Str200;        procedure WriteDescr10 (pValue:Str200);
    function  ReadSupQnt:byte;           procedure WriteSupQnt (pValue:byte);
    function  ReadCusQnt:byte;           procedure WriteCusQnt (pValue:byte);
    function  ReadOccQnt:byte;           procedure WriteOccQnt (pValue:byte);
    function  ReadOccCty:Str30;          procedure WriteOccCty (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SpePrc:double read ReadSpePrc write WriteSpePrc;
    property SpeDay:word read ReadSpeDay write WriteSpeDay;
    property IcdPrc1:double read ReadIcdPrc1 write WriteIcdPrc1;
    property IcdDay1:word read ReadIcdDay1 write WriteIcdDay1;
    property IcdPrc2:double read ReadIcdPrc2 write WriteIcdPrc2;
    property IcdDay2:word read ReadIcdDay2 write WriteIcdDay2;
    property SupTrmD:word read ReadSupTrmD write WriteSupTrmD;
    property SupTrmW:byte read ReadSupTrmW write WriteSupTrmW;
    property GrcYear:byte read ReadGrcYear write WriteGrcYear;
    property Descr01:Str200 read ReadDescr01 write WriteDescr01;
    property Descr02:Str200 read ReadDescr02 write WriteDescr02;
    property Descr03:Str200 read ReadDescr03 write WriteDescr03;
    property Descr04:Str200 read ReadDescr04 write WriteDescr04;
    property Descr05:Str200 read ReadDescr05 write WriteDescr05;
    property Descr06:Str200 read ReadDescr06 write WriteDescr06;
    property Descr07:Str200 read ReadDescr07 write WriteDescr07;
    property Descr08:Str200 read ReadDescr08 write WriteDescr08;
    property Descr09:Str200 read ReadDescr09 write WriteDescr09;
    property Descr10:Str200 read ReadDescr10 write WriteDescr10;
    property SupQnt:byte read ReadSupQnt write WriteSupQnt;
    property CusQnt:byte read ReadCusQnt write WriteCusQnt;
    property OccQnt:byte read ReadOccQnt write WriteOccQnt;
    property OccCty:Str30 read ReadOccCty write WriteOccCty;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Sended:boolean read ReadSended write WriteSended;
  end;

implementation

constructor TOccBtr.Create;
begin
  oBtrTable := BtrInit ('OCC',gPath.StkPath,Self);
end;

constructor TOccBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OCC',pPath,Self);
end;

destructor TOccBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOccBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOccBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOccBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOccBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOccBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TOccBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOccBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOccBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOccBtr.ReadSpePrc:double;
begin
  Result := oBtrTable.FieldByName('SpePrc').AsFloat;
end;

procedure TOccBtr.WriteSpePrc(pValue:double);
begin
  oBtrTable.FieldByName('SpePrc').AsFloat := pValue;
end;

function TOccBtr.ReadSpeDay:word;
begin
  Result := oBtrTable.FieldByName('SpeDay').AsInteger;
end;

procedure TOccBtr.WriteSpeDay(pValue:word);
begin
  oBtrTable.FieldByName('SpeDay').AsInteger := pValue;
end;

function TOccBtr.ReadIcdPrc1:double;
begin
  Result := oBtrTable.FieldByName('IcdPrc1').AsFloat;
end;

procedure TOccBtr.WriteIcdPrc1(pValue:double);
begin
  oBtrTable.FieldByName('IcdPrc1').AsFloat := pValue;
end;

function TOccBtr.ReadIcdDay1:word;
begin
  Result := oBtrTable.FieldByName('IcdDay1').AsInteger;
end;

procedure TOccBtr.WriteIcdDay1(pValue:word);
begin
  oBtrTable.FieldByName('IcdDay1').AsInteger := pValue;
end;

function TOccBtr.ReadIcdPrc2:double;
begin
  Result := oBtrTable.FieldByName('IcdPrc2').AsFloat;
end;

procedure TOccBtr.WriteIcdPrc2(pValue:double);
begin
  oBtrTable.FieldByName('IcdPrc2').AsFloat := pValue;
end;

function TOccBtr.ReadIcdDay2:word;
begin
  Result := oBtrTable.FieldByName('IcdDay2').AsInteger;
end;

procedure TOccBtr.WriteIcdDay2(pValue:word);
begin
  oBtrTable.FieldByName('IcdDay2').AsInteger := pValue;
end;

function TOccBtr.ReadSupTrmD:word;
begin
  Result := oBtrTable.FieldByName('SupTrmD').AsInteger;
end;

procedure TOccBtr.WriteSupTrmD(pValue:word);
begin
  oBtrTable.FieldByName('SupTrmD').AsInteger := pValue;
end;

function TOccBtr.ReadSupTrmW:byte;
begin
  Result := oBtrTable.FieldByName('SupTrmW').AsInteger;
end;

procedure TOccBtr.WriteSupTrmW(pValue:byte);
begin
  oBtrTable.FieldByName('SupTrmW').AsInteger := pValue;
end;

function TOccBtr.ReadGrcYear:byte;
begin
  Result := oBtrTable.FieldByName('GrcYear').AsInteger;
end;

procedure TOccBtr.WriteGrcYear(pValue:byte);
begin
  oBtrTable.FieldByName('GrcYear').AsInteger := pValue;
end;

function TOccBtr.ReadDescr01:Str200;
begin
  Result := oBtrTable.FieldByName('Descr01').AsString;
end;

procedure TOccBtr.WriteDescr01(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr01').AsString := pValue;
end;

function TOccBtr.ReadDescr02:Str200;
begin
  Result := oBtrTable.FieldByName('Descr02').AsString;
end;

procedure TOccBtr.WriteDescr02(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr02').AsString := pValue;
end;

function TOccBtr.ReadDescr03:Str200;
begin
  Result := oBtrTable.FieldByName('Descr03').AsString;
end;

procedure TOccBtr.WriteDescr03(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr03').AsString := pValue;
end;

function TOccBtr.ReadDescr04:Str200;
begin
  Result := oBtrTable.FieldByName('Descr04').AsString;
end;

procedure TOccBtr.WriteDescr04(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr04').AsString := pValue;
end;

function TOccBtr.ReadDescr05:Str200;
begin
  Result := oBtrTable.FieldByName('Descr05').AsString;
end;

procedure TOccBtr.WriteDescr05(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr05').AsString := pValue;
end;

function TOccBtr.ReadDescr06:Str200;
begin
  Result := oBtrTable.FieldByName('Descr06').AsString;
end;

procedure TOccBtr.WriteDescr06(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr06').AsString := pValue;
end;

function TOccBtr.ReadDescr07:Str200;
begin
  Result := oBtrTable.FieldByName('Descr07').AsString;
end;

procedure TOccBtr.WriteDescr07(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr07').AsString := pValue;
end;

function TOccBtr.ReadDescr08:Str200;
begin
  Result := oBtrTable.FieldByName('Descr08').AsString;
end;

procedure TOccBtr.WriteDescr08(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr08').AsString := pValue;
end;

function TOccBtr.ReadDescr09:Str200;
begin
  Result := oBtrTable.FieldByName('Descr09').AsString;
end;

procedure TOccBtr.WriteDescr09(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr09').AsString := pValue;
end;

function TOccBtr.ReadDescr10:Str200;
begin
  Result := oBtrTable.FieldByName('Descr10').AsString;
end;

procedure TOccBtr.WriteDescr10(pValue:Str200);
begin
  oBtrTable.FieldByName('Descr10').AsString := pValue;
end;

function TOccBtr.ReadSupQnt:byte;
begin
  Result := oBtrTable.FieldByName('SupQnt').AsInteger;
end;

procedure TOccBtr.WriteSupQnt(pValue:byte);
begin
  oBtrTable.FieldByName('SupQnt').AsInteger := pValue;
end;

function TOccBtr.ReadCusQnt:byte;
begin
  Result := oBtrTable.FieldByName('CusQnt').AsInteger;
end;

procedure TOccBtr.WriteCusQnt(pValue:byte);
begin
  oBtrTable.FieldByName('CusQnt').AsInteger := pValue;
end;

function TOccBtr.ReadOccQnt:byte;
begin
  Result := oBtrTable.FieldByName('OccQnt').AsInteger;
end;

procedure TOccBtr.WriteOccQnt(pValue:byte);
begin
  oBtrTable.FieldByName('OccQnt').AsInteger := pValue;
end;

function TOccBtr.ReadOccCty:Str30;
begin
  Result := oBtrTable.FieldByName('OccCty').AsString;
end;

procedure TOccBtr.WriteOccCty(pValue:Str30);
begin
  oBtrTable.FieldByName('OccCty').AsString := pValue;
end;

function TOccBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOccBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOccBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOccBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOccBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOccBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOccBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOccBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOccBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOccBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOccBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOccBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOccBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOccBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOccBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TOccBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

// **************************************** PUBLIC ********************************************

function TOccBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOccBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOccBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOccBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOccBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOccBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TOccBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

procedure TOccBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOccBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOccBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOccBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOccBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOccBtr.First;
begin
  oBtrTable.First;
end;

procedure TOccBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOccBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOccBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOccBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOccBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOccBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOccBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOccBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOccBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOccBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOccBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
