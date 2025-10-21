unit bWAH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';

type
  TWahBtr = class (TComponent)
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
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadPrmVal:double;         procedure WritePrmVal (pValue:double);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadPenVal:double;         procedure WritePenVal (pValue:double);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
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
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;

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
    property BasVal:double read ReadBasVal write WriteBasVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property PrmVal:double read ReadPrmVal write WritePrmVal;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property PenVal:double read ReadPenVal write WritePenVal;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TWahBtr.Create;
begin
  oBtrTable := BtrInit ('WAH',gPath.LdgPath,Self);
end;

constructor TWahBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WAH',pPath,Self);
end;

destructor TWahBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWahBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWahBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWahBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TWahBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TWahBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TWahBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TWahBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TWahBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TWahBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TWahBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TWahBtr.ReadBasVal:double;
begin
  Result := oBtrTable.FieldByName('BasVal').AsFloat;
end;

procedure TWahBtr.WriteBasVal(pValue:double);
begin
  oBtrTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TWahBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TWahBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TWahBtr.ReadPrmVal:double;
begin
  Result := oBtrTable.FieldByName('PrmVal').AsFloat;
end;

procedure TWahBtr.WritePrmVal(pValue:double);
begin
  oBtrTable.FieldByName('PrmVal').AsFloat := pValue;
end;

function TWahBtr.ReadAddVal:double;
begin
  Result := oBtrTable.FieldByName('AddVal').AsFloat;
end;

procedure TWahBtr.WriteAddVal(pValue:double);
begin
  oBtrTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TWahBtr.ReadPenVal:double;
begin
  Result := oBtrTable.FieldByName('PenVal').AsFloat;
end;

procedure TWahBtr.WritePenVal(pValue:double);
begin
  oBtrTable.FieldByName('PenVal').AsFloat := pValue;
end;

function TWahBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TWahBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TWahBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TWahBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TWahBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWahBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWahBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWahBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWahBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWahBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWahBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWahBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWahBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWahBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWahBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWahBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWahBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TWahBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWahBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWahBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWahBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWahBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWahBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWahBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWahBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TWahBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TWahBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TWahBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

procedure TWahBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWahBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TWahBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWahBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWahBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWahBtr.First;
begin
  oBtrTable.First;
end;

procedure TWahBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWahBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWahBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWahBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWahBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWahBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWahBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWahBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWahBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWahBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWahBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
