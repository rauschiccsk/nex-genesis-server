unit bPQH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixYearSerNum = 'YearSerNum';
  ixDocDate = 'DocDate';
  ixDocVal = 'DocVal';

type
  TPqhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadAboStat:Str1;          procedure WriteAboStat (pValue:Str1);
    function  ReadAboDate:TDatetime;     procedure WriteAboDate (pValue:TDatetime);
    function  ReadAboTime:TDatetime;     procedure WriteAboTime (pValue:TDatetime);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDocVal (pDocVal:double):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDocVal (pDocVal:double):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property AboStat:Str1 read ReadAboStat write WriteAboStat;
    property AboDate:TDatetime read ReadAboDate write WriteAboDate;
    property AboTime:TDatetime read ReadAboTime write WriteAboTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TPqhBtr.Create;
begin
  oBtrTable := BtrInit ('PQH',gPath.LdgPath,Self);
end;

constructor TPqhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PQH',pPath,Self);
end;

destructor TPqhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPqhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPqhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPqhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPqhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPqhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPqhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPqhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPqhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPqhBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TPqhBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TPqhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPqhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPqhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPqhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPqhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPqhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPqhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPqhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPqhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPqhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPqhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPqhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPqhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPqhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPqhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TPqhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TPqhBtr.ReadAboStat:Str1;
begin
  Result := oBtrTable.FieldByName('AboStat').AsString;
end;

procedure TPqhBtr.WriteAboStat(pValue:Str1);
begin
  oBtrTable.FieldByName('AboStat').AsString := pValue;
end;

function TPqhBtr.ReadAboDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AboDate').AsDateTime;
end;

procedure TPqhBtr.WriteAboDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AboDate').AsDateTime := pValue;
end;

function TPqhBtr.ReadAboTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('AboTime').AsDateTime;
end;

procedure TPqhBtr.WriteAboTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AboTime').AsDateTime := pValue;
end;

function TPqhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TPqhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPqhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPqhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPqhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPqhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPqhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPqhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPqhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPqhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TPqhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPqhBtr.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oBtrTable.FindKey([pDocVal]);
end;

function TPqhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPqhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TPqhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPqhBtr.NearestDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oBtrTable.FindNearest([pDocVal]);
end;

procedure TPqhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPqhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPqhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPqhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPqhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPqhBtr.First;
begin
  oBtrTable.First;
end;

procedure TPqhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPqhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPqhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPqhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPqhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPqhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPqhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPqhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPqhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPqhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPqhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
