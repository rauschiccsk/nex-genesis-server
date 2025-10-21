unit bSOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPyBegVal = 'PyBegVal';
  ixPyCredVal = 'PyCredVal';
  ixPyDebVal = 'PyDebVal';
  ixPyEndVal = 'PyEndVal';

type
  TSohBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyBegVal:double;       procedure WritePyBegVal (pValue:double);
    function  ReadPyCredVal:double;      procedure WritePyCredVal (pValue:double);
    function  ReadPyDebVal:double;       procedure WritePyDebVal (pValue:double);
    function  ReadPyEndVal:double;       procedure WritePyEndVal (pValue:double);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadAcBegVal:double;       procedure WriteAcBegVal (pValue:double);
    function  ReadAcCredVal:double;      procedure WriteAcCredVal (pValue:double);
    function  ReadAcDebVal:double;       procedure WriteAcDebVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadPyDifVal:double;       procedure WritePyDifVal (pValue:double);
    function  ReadDstDif:Str1;           procedure WriteDstDif (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
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
    function LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePyBegVal (pPyBegVal:double):boolean;
    function LocatePyCredVal (pPyCredVal:double):boolean;
    function LocatePyDebVal (pPyDebVal:double):boolean;
    function LocatePyEndVal (pPyEndVal:double):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPyBegVal (pPyBegVal:double):boolean;
    function NearestPyCredVal (pPyCredVal:double):boolean;
    function NearestPyDebVal (pPyDebVal:double):boolean;
    function NearestPyEndVal (pPyEndVal:double):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyBegVal:double read ReadPyBegVal write WritePyBegVal;
    property PyCredVal:double read ReadPyCredVal write WritePyCredVal;
    property PyDebVal:double read ReadPyDebVal write WritePyDebVal;
    property PyEndVal:double read ReadPyEndVal write WritePyEndVal;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property AcBegVal:double read ReadAcBegVal write WriteAcBegVal;
    property AcCredVal:double read ReadAcCredVal write WriteAcCredVal;
    property AcDebVal:double read ReadAcDebVal write WriteAcDebVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property PyDifVal:double read ReadPyDifVal write WritePyDifVal;
    property DstDif:Str1 read ReadDstDif write WriteDstDif;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TSohBtr.Create;
begin
  oBtrTable := BtrInit ('SOH',gPath.LdgPath,Self);
end;

constructor TSohBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SOH',pPath,Self);
end;

destructor TSohBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSohBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSohBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSohBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSohBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSohBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSohBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSohBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSohBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSohBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TSohBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TSohBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TSohBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TSohBtr.ReadPyBegVal:double;
begin
  Result := oBtrTable.FieldByName('PyBegVal').AsFloat;
end;

procedure TSohBtr.WritePyBegVal(pValue:double);
begin
  oBtrTable.FieldByName('PyBegVal').AsFloat := pValue;
end;

function TSohBtr.ReadPyCredVal:double;
begin
  Result := oBtrTable.FieldByName('PyCredVal').AsFloat;
end;

procedure TSohBtr.WritePyCredVal(pValue:double);
begin
  oBtrTable.FieldByName('PyCredVal').AsFloat := pValue;
end;

function TSohBtr.ReadPyDebVal:double;
begin
  Result := oBtrTable.FieldByName('PyDebVal').AsFloat;
end;

procedure TSohBtr.WritePyDebVal(pValue:double);
begin
  oBtrTable.FieldByName('PyDebVal').AsFloat := pValue;
end;

function TSohBtr.ReadPyEndVal:double;
begin
  Result := oBtrTable.FieldByName('PyEndVal').AsFloat;
end;

procedure TSohBtr.WritePyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('PyEndVal').AsFloat := pValue;
end;

function TSohBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSohBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSohBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSohBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TSohBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TSohBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TSohBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSohBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSohBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSohBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSohBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSohBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSohBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSohBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSohBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSohBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSohBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSohBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSohBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSohBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSohBtr.ReadAcBegVal:double;
begin
  Result := oBtrTable.FieldByName('AcBegVal').AsFloat;
end;

procedure TSohBtr.WriteAcBegVal(pValue:double);
begin
  oBtrTable.FieldByName('AcBegVal').AsFloat := pValue;
end;

function TSohBtr.ReadAcCredVal:double;
begin
  Result := oBtrTable.FieldByName('AcCredVal').AsFloat;
end;

procedure TSohBtr.WriteAcCredVal(pValue:double);
begin
  oBtrTable.FieldByName('AcCredVal').AsFloat := pValue;
end;

function TSohBtr.ReadAcDebVal:double;
begin
  Result := oBtrTable.FieldByName('AcDebVal').AsFloat;
end;

procedure TSohBtr.WriteAcDebVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDebVal').AsFloat := pValue;
end;

function TSohBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TSohBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TSohBtr.ReadPyDifVal:double;
begin
  Result := oBtrTable.FieldByName('PyDifVal').AsFloat;
end;

procedure TSohBtr.WritePyDifVal(pValue:double);
begin
  oBtrTable.FieldByName('PyDifVal').AsFloat := pValue;
end;

function TSohBtr.ReadDstDif:Str1;
begin
  Result := oBtrTable.FieldByName('DstDif').AsString;
end;

procedure TSohBtr.WriteDstDif(pValue:Str1);
begin
  oBtrTable.FieldByName('DstDif').AsString := pValue;
end;

function TSohBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TSohBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TSohBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TSohBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TSohBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TSohBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSohBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSohBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSohBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSohBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSohBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSohBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSohBtr.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TSohBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSohBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSohBtr.LocatePyBegVal (pPyBegVal:double):boolean;
begin
  SetIndex (ixPyBegVal);
  Result := oBtrTable.FindKey([pPyBegVal]);
end;

function TSohBtr.LocatePyCredVal (pPyCredVal:double):boolean;
begin
  SetIndex (ixPyCredVal);
  Result := oBtrTable.FindKey([pPyCredVal]);
end;

function TSohBtr.LocatePyDebVal (pPyDebVal:double):boolean;
begin
  SetIndex (ixPyDebVal);
  Result := oBtrTable.FindKey([pPyDebVal]);
end;

function TSohBtr.LocatePyEndVal (pPyEndVal:double):boolean;
begin
  SetIndex (ixPyEndVal);
  Result := oBtrTable.FindKey([pPyEndVal]);
end;

function TSohBtr.NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TSohBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSohBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSohBtr.NearestPyBegVal (pPyBegVal:double):boolean;
begin
  SetIndex (ixPyBegVal);
  Result := oBtrTable.FindNearest([pPyBegVal]);
end;

function TSohBtr.NearestPyCredVal (pPyCredVal:double):boolean;
begin
  SetIndex (ixPyCredVal);
  Result := oBtrTable.FindNearest([pPyCredVal]);
end;

function TSohBtr.NearestPyDebVal (pPyDebVal:double):boolean;
begin
  SetIndex (ixPyDebVal);
  Result := oBtrTable.FindNearest([pPyDebVal]);
end;

function TSohBtr.NearestPyEndVal (pPyEndVal:double):boolean;
begin
  SetIndex (ixPyEndVal);
  Result := oBtrTable.FindNearest([pPyEndVal]);
end;

procedure TSohBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSohBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSohBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSohBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSohBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSohBtr.First;
begin
  oBtrTable.First;
end;

procedure TSohBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSohBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSohBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSohBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSohBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSohBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSohBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSohBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSohBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSohBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSohBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
