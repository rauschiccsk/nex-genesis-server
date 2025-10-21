unit bACH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixBegDate = 'BegDate';
  ixEndDate = 'EndDate';
  ixDescribe = 'Describe';

type
  TAchBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadWaiItmQnt:longint;     procedure WriteWaiItmQnt (pValue:longint);
    function  ReadChgItmQnt:longint;     procedure WriteChgItmQnt (pValue:longint);
    function  ReadDocType:Str1;          procedure WriteDocType (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
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
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateBegDate (pBegDate:TDatetime):boolean;
    function LocateEndDate (pEndDate:TDatetime):boolean;
    function LocateDescribe (pDescribe_:Str30):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestBegDate (pBegDate:TDatetime):boolean;
    function NearestEndDate (pEndDate:TDatetime):boolean;
    function NearestDescribe (pDescribe_:Str30):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property WaiItmQnt:longint read ReadWaiItmQnt write WriteWaiItmQnt;
    property ChgItmQnt:longint read ReadChgItmQnt write WriteChgItmQnt;
    property DocType:Str1 read ReadDocType write WriteDocType;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TAchBtr.Create;
begin
  oBtrTable := BtrInit ('ACH',gPath.StkPath,Self);
end;

constructor TAchBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ACH',pPath,Self);
end;

destructor TAchBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAchBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAchBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAchBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAchBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAchBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAchBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAchBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAchBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAchBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAchBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAchBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TAchBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TAchBtr.ReadDescribe_:Str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TAchBtr.WriteDescribe_(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TAchBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAchBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAchBtr.ReadWaiItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('WaiItmQnt').AsInteger;
end;

procedure TAchBtr.WriteWaiItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('WaiItmQnt').AsInteger := pValue;
end;

function TAchBtr.ReadChgItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ChgItmQnt').AsInteger;
end;

procedure TAchBtr.WriteChgItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ChgItmQnt').AsInteger := pValue;
end;

function TAchBtr.ReadDocType:Str1;
begin
  Result := oBtrTable.FieldByName('DocType').AsString;
end;

procedure TAchBtr.WriteDocType(pValue:Str1);
begin
  oBtrTable.FieldByName('DocType').AsString := pValue;
end;

function TAchBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TAchBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAchBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAchBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAchBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAchBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAchBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAchBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAchBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAchBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAchBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAchBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAchBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAchBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAchBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAchBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAchBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TAchBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAchBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAchBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAchBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAchBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAchBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAchBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAchBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TAchBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAchBtr.LocateBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindKey([pBegDate]);
end;

function TAchBtr.LocateEndDate (pEndDate:TDatetime):boolean;
begin
  SetIndex (ixEndDate);
  Result := oBtrTable.FindKey([pEndDate]);
end;

function TAchBtr.LocateDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TAchBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TAchBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAchBtr.NearestBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindNearest([pBegDate]);
end;

function TAchBtr.NearestEndDate (pEndDate:TDatetime):boolean;
begin
  SetIndex (ixEndDate);
  Result := oBtrTable.FindNearest([pEndDate]);
end;

function TAchBtr.NearestDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

procedure TAchBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAchBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAchBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAchBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAchBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAchBtr.First;
begin
  oBtrTable.First;
end;

procedure TAchBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAchBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAchBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAchBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAchBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAchBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAchBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAchBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAchBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAchBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAchBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
