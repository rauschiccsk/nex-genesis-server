unit dJOURNAL;

interface

uses
  IcTypes, NexPath, NexGlob,
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
  TJournal = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
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
    // Elementarne databazove operacie
    function Eof: boolean;
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

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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

constructor TJournal.Create;
begin
  oBtrTable := BtrInit ('JOURNAL',gPath.LdgPath,Self);
end;

destructor  TJournal.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TJournal.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TJournal.ReadDocNum:str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TJournal.WriteDocNum(pValue:str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TJournal.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJournal.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJournal.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TJournal.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TJournal.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TJournal.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TJournal.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TJournal.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TJournal.ReadAccSnt:str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TJournal.WriteAccSnt(pValue:str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TJournal.ReadAccAnl:str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TJournal.WriteAccAnl(pValue:str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TJournal.ReadDescribe:str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TJournal.WriteDescribe(pValue:str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TJournal.ReadDescribe_:str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TJournal.WriteDescribe_(pValue:str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TJournal.ReadCredVal:double;
begin
  Result := oBtrTable.FieldByName('CredVal').AsFloat;
end;

procedure TJournal.WriteCredVal(pValue:double);
begin
  oBtrTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TJournal.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TJournal.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TJournal.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TJournal.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TJournal.ReadBegRec:byte;
begin
  Result := oBtrTable.FieldByName('BegRec').AsInteger;
end;

procedure TJournal.WriteBegRec(pValue:byte);
begin
  oBtrTable.FieldByName('BegRec').AsInteger := pValue;
end;

function TJournal.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TJournal.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TJournal.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TJournal.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TJournal.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TJournal.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TJournal.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TJournal.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TJournal.ReadOceNum:Str12;
begin
  Result := oBtrTable.FieldByName('OceNum').AsString;
end;

procedure TJournal.WriteOceNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OceNum').AsString := pValue;
end;

function TJournal.ReadCentNum:word;
begin
  Result := oBtrTable.FieldByName('CentNum').AsInteger;
end;

procedure TJournal.WriteCentNum(pValue:word);
begin
  oBtrTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TJournal.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TJournal.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TJournal.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJournal.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJournal.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJournal.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJournal.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TJournal.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TJournal.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJournal.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJournal.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJournal.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJournal.ReadSpaCode:longint;
begin
  Result := oBtrTable.FieldByName('SpaCode').AsInteger;
end;

procedure TJournal.WriteSpaCode(pValue:longint);
begin
  oBtrTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TJournal.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TJournal.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TJournal.ReadFgCrdVal:double;
begin
  Result := oBtrTable.FieldByName('FgCrdVal').AsFloat;
end;

procedure TJournal.WriteFgCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('FgCrdVal').AsFloat := pValue;
end;

function TJournal.ReadFgDebVal:double;
begin
  Result := oBtrTable.FieldByName('FgDebVal').AsFloat;
end;

procedure TJournal.WriteFgDebVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDebVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJournal.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TJournal.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TJournal.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TJournal.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TJournal.LocateDocNum (pDocNum:str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TJournal.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TJournal.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TJournal.LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TJournal.LocateDoWrSnAn (pDocNum:str12;pWriNum:word;pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixDoWrSnAn);
  Result := oBtrTable.FindKey([pDocNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TJournal.LocateDoIt (pDocNum:str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TJournal.LocateDescribe (pDescribe_:str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([pDescribe_]);
end;

function TJournal.LocateCredVal (pCredVal:double):boolean;
begin
  SetIndex (ixCredVal);
  Result := oBtrTable.FindKey([pCredVal]);
end;

function TJournal.LocateDebVal (pDebVal:double):boolean;
begin
  SetIndex (ixDebVal);
  Result := oBtrTable.FindKey([pDebVal]);
end;

procedure TJournal.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TJournal.Open;
begin
  oBtrTable.Open;
end;

procedure TJournal.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TJournal.Prior;
begin
  oBtrTable.Prior;
end;

procedure TJournal.Next;
begin
  oBtrTable.Next;
end;

procedure TJournal.First;
begin
  oBtrTable.First;
end;

procedure TJournal.Last;
begin
  oBtrTable.Last;
end;

procedure TJournal.Insert;
begin
  oBtrTable.Insert;
end;

procedure TJournal.Edit;
begin
  oBtrTable.Edit;
end;

procedure TJournal.Post;
begin
  oBtrTable.Post;
end;

procedure TJournal.Delete;
begin
  oBtrTable.Delete;
end;

procedure TJournal.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TJournal.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

end.
