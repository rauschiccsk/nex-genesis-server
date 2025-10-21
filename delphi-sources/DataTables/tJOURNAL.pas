unit tJOURNAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixDoIt = 'DoIt';
  ixDocDate = 'DocDate';
  ixDescribe_ = 'Describe_';
  ixSnAn = 'SnAn';
  ixCredVal = 'CredVal';
  ixDebVal = 'DebVal';

type
  TJournalTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOceNum:Str12;          procedure WriteOceNum (pValue:Str12);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadBegRec:byte;           procedure WriteBegRec (pValue:byte);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadSpaCode:longint;       procedure WriteSpaCode (pValue:longint);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDescribe_ (pDescribe_:Str30):boolean;
    function LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OceNum:Str12 read ReadOceNum write WriteOceNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property BegRec:byte read ReadBegRec write WriteBegRec;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property SpaCode:longint read ReadSpaCode write WriteSpaCode;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TJournalTmp.Create;
begin
  oTmpTable := TmpInit ('JOURNAL',Self);
end;

destructor TJournalTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TJournalTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TJournalTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TJournalTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TJournalTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TJournalTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TJournalTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TJournalTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TJournalTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TJournalTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TJournalTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TJournalTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TJournalTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TJournalTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TJournalTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TJournalTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TJournalTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TJournalTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TJournalTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TJournalTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TJournalTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TJournalTmp.ReadDescribe_:Str30;
begin
  Result := oTmpTable.FieldByName('Describe_').AsString;
end;

procedure TJournalTmp.WriteDescribe_(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe_').AsString := pValue;
end;

function TJournalTmp.ReadCredVal:double;
begin
  Result := oTmpTable.FieldByName('CredVal').AsFloat;
end;

procedure TJournalTmp.WriteCredVal(pValue:double);
begin
  oTmpTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TJournalTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TJournalTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TJournalTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TJournalTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TJournalTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TJournalTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TJournalTmp.ReadOceNum:Str12;
begin
  Result := oTmpTable.FieldByName('OceNum').AsString;
end;

procedure TJournalTmp.WriteOceNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OceNum').AsString := pValue;
end;

function TJournalTmp.ReadCentNum:word;
begin
  Result := oTmpTable.FieldByName('CentNum').AsInteger;
end;

procedure TJournalTmp.WriteCentNum(pValue:word);
begin
  oTmpTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TJournalTmp.ReadBegRec:byte;
begin
  Result := oTmpTable.FieldByName('BegRec').AsInteger;
end;

procedure TJournalTmp.WriteBegRec(pValue:byte);
begin
  oTmpTable.FieldByName('BegRec').AsInteger := pValue;
end;

function TJournalTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TJournalTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TJournalTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TJournalTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TJournalTmp.ReadSpaCode:longint;
begin
  Result := oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TJournalTmp.WriteSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger := pValue;
end;

function TJournalTmp.ReadCrtName:Str8;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TJournalTmp.WriteCrtName(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TJournalTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TJournalTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TJournalTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TJournalTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TJournalTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TJournalTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TJournalTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TJournalTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TJournalTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TJournalTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TJournalTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TJournalTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TJournalTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TJournalTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TJournalTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TJournalTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TJournalTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TJournalTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TJournalTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TJournalTmp.LocateDescribe_ (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe_);
  Result := oTmpTable.FindKey([pDescribe_]);
end;

function TJournalTmp.LocateSnAn (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

function TJournalTmp.LocateCredVal (pCredVal:double):boolean;
begin
  SetIndex (ixCredVal);
  Result := oTmpTable.FindKey([pCredVal]);
end;

function TJournalTmp.LocateDebVal (pDebVal:double):boolean;
begin
  SetIndex (ixDebVal);
  Result := oTmpTable.FindKey([pDebVal]);
end;

procedure TJournalTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TJournalTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TJournalTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TJournalTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TJournalTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TJournalTmp.First;
begin
  oTmpTable.First;
end;

procedure TJournalTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TJournalTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TJournalTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TJournalTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TJournalTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TJournalTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TJournalTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TJournalTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TJournalTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TJournalTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TJournalTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
