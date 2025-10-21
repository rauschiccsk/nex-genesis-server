unit bJOURNAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixDocDate = 'DocDate';
  ixSnAn = 'SnAn';
  ixDoWrSnAn = 'DoWrSnAn';
  ixDoIt = 'DoIt';
  ixDescribe = 'Describe';
  ixCredVal = 'CredVal';
  ixDebVal = 'DebVal';

type
  TJournalBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:str12;          procedure WriteDocNum (pValue:str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadDescribe:str30;        procedure WriteDescribe (pValue:str30);
    function  ReadDescribe_:str30;       procedure WriteDescribe_ (pValue:str30);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadBegRec:byte;           procedure WriteBegRec (pValue:byte);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOceNum:Str12;          procedure WriteOceNum (pValue:Str12);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCrdVal:double;       procedure WriteFgCrdVal (pValue:double);
    function  ReadFgDebVal:double;       procedure WriteFgDebVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
    function LocateDoWrSnAn (pDocNum:str12;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
    function LocateDoIt (pDocNum:str12;pItmNum:word):boolean;
    function LocateDescribe (pDescribe_:str30):boolean;
    function LocateCredVal (pCredVal:double):boolean;
    function LocateDebVal (pDebVal:double):boolean;
    function NearestDocNum (pDocNum:str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
    function NearestDoWrSnAn (pDocNum:str12;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
    function NearestDoIt (pDocNum:str12;pItmNum:word):boolean;
    function NearestDescribe (pDescribe_:str30):boolean;
    function NearestCredVal (pCredVal:double):boolean;
    function NearestDebVal (pDebVal:double):boolean;

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
    property DocNum:str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property Describe:str30 read ReadDescribe write WriteDescribe;
    property Describe_:str30 read ReadDescribe_ write WriteDescribe_;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property BegRec:byte read ReadBegRec write WriteBegRec;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OceNum:Str12 read ReadOceNum write WriteOceNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCrdVal:double read ReadFgCrdVal write WriteFgCrdVal;
    property FgDebVal:double read ReadFgDebVal write WriteFgDebVal;
  end;

implementation

constructor TJournalBtr.Create;
begin
  oBtrTable := BtrInit ('JOURNAL',gPath.LdgPath,Self);
end;

constructor TJournalBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('JOURNAL',pPath,Self);
end;

destructor TJournalBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJournalBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJournalBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TJournalBtr.ReadDocNum:str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJournalBtr.WriteDocNum(pValue:str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJournalBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJournalBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJournalBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TJournalBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TJournalBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TJournalBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TJournalBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TJournalBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TJournalBtr.ReadAccSnt:str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TJournalBtr.WriteAccSnt(pValue:str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TJournalBtr.ReadAccAnl:str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TJournalBtr.WriteAccAnl(pValue:str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TJournalBtr.ReadDescribe:str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TJournalBtr.WriteDescribe(pValue:str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TJournalBtr.ReadDescribe_:str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TJournalBtr.WriteDescribe_(pValue:str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TJournalBtr.ReadCredVal:double;
begin
  Result := oBtrTable.FieldByName('CredVal').AsFloat;
end;

procedure TJournalBtr.WriteCredVal(pValue:double);
begin
  oBtrTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TJournalBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TJournalBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TJournalBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TJournalBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TJournalBtr.ReadBegRec:byte;
begin
  Result := oBtrTable.FieldByName('BegRec').AsInteger;
end;

procedure TJournalBtr.WriteBegRec(pValue:byte);
begin
  oBtrTable.FieldByName('BegRec').AsInteger := pValue;
end;

function TJournalBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TJournalBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TJournalBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TJournalBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TJournalBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TJournalBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TJournalBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TJournalBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TJournalBtr.ReadOceNum:Str12;
begin
  Result := oBtrTable.FieldByName('OceNum').AsString;
end;

procedure TJournalBtr.WriteOceNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OceNum').AsString := pValue;
end;

function TJournalBtr.ReadCentNum:word;
begin
  Result := oBtrTable.FieldByName('CentNum').AsInteger;
end;

procedure TJournalBtr.WriteCentNum(pValue:word);
begin
  oBtrTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TJournalBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TJournalBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TJournalBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJournalBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJournalBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJournalBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJournalBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TJournalBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TJournalBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJournalBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJournalBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJournalBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJournalBtr.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TJournalBtr.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TJournalBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TJournalBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TJournalBtr.ReadFgCrdVal:double;
begin
  Result := oBtrTable.FieldByName('FgCrdVal').AsFloat;
end;

procedure TJournalBtr.WriteFgCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('FgCrdVal').AsFloat := pValue;
end;

function TJournalBtr.ReadFgDebVal:double;
begin
  Result := oBtrTable.FieldByName('FgDebVal').AsFloat;
end;

procedure TJournalBtr.WriteFgDebVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDebVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJournalBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJournalBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TJournalBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJournalBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJournalBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJournalBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJournalBtr.LocateDocNum (pDocNum:str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJournalBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TJournalBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TJournalBtr.LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TJournalBtr.LocateDoWrSnAn (pDocNum:str12;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixDoWrSnAn);
  Result := oBtrTable.FindKey([pDocNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TJournalBtr.LocateDoIt (pDocNum:str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TJournalBtr.LocateDescribe (pDescribe_:str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TJournalBtr.LocateCredVal (pCredVal:double):boolean;
begin
  SetIndex (ixCredVal);
  Result := oBtrTable.FindKey([pCredVal]);
end;

function TJournalBtr.LocateDebVal (pDebVal:double):boolean;
begin
  SetIndex (ixDebVal);
  Result := oBtrTable.FindKey([pDebVal]);
end;

function TJournalBtr.NearestDocNum (pDocNum:str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TJournalBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TJournalBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TJournalBtr.NearestSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TJournalBtr.NearestDoWrSnAn (pDocNum:str12;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixDoWrSnAn);
  Result := oBtrTable.FindNearest([pDocNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TJournalBtr.NearestDoIt (pDocNum:str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TJournalBtr.NearestDescribe (pDescribe_:str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TJournalBtr.NearestCredVal (pCredVal:double):boolean;
begin
  SetIndex (ixCredVal);
  Result := oBtrTable.FindNearest([pCredVal]);
end;

function TJournalBtr.NearestDebVal (pDebVal:double):boolean;
begin
  SetIndex (ixDebVal);
  Result := oBtrTable.FindNearest([pDebVal]);
end;

procedure TJournalBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJournalBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TJournalBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJournalBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJournalBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TJournalBtr.First;
begin
  oBtrTable.First;
end;

procedure TJournalBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TJournalBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJournalBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJournalBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TJournalBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJournalBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJournalBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TJournalBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TJournalBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TJournalBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TJournalBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
