unit bIDI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixItmNum = 'ItmNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixSntAnl = 'SntAnl';
  ixPaCode = 'PaCode';

type
  TIdiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadConExt:Str12;          procedure WriteConExt (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadDocType:byte;          procedure WriteDocType (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:longint;        procedure WriteModNum (pValue:longint);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyPayVal:double;       procedure WritePyPayVal (pValue:double);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearestPaCode (pPaCode:longint):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property ConExt:Str12 read ReadConExt write WriteConExt;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property Status:Str1 read ReadStatus write WriteStatus;
    property DocType:byte read ReadDocType write WriteDocType;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:longint read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyPayVal:double read ReadPyPayVal write WritePyPayVal;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property FgCrdVal:double read ReadFgCrdVal write WriteFgCrdVal;
    property FgDebVal:double read ReadFgDebVal write WriteFgDebVal;
  end;

implementation

constructor TIdiBtr.Create;
begin
  oBtrTable := BtrInit ('IDI',gPath.LdgPath,Self);
end;

constructor TIdiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IDI',pPath,Self);
end;

destructor TIdiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIdiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIdiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIdiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIdiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIdiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIdiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIdiBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TIdiBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIdiBtr.ReadConExt:Str12;
begin
  Result := oBtrTable.FieldByName('ConExt').AsString;
end;

procedure TIdiBtr.WriteConExt(pValue:Str12);
begin
  oBtrTable.FieldByName('ConExt').AsString := pValue;
end;

function TIdiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIdiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIdiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIdiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIdiBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TIdiBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIdiBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TIdiBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIdiBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TIdiBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TIdiBtr.ReadCredVal:double;
begin
  Result := oBtrTable.FieldByName('CredVal').AsFloat;
end;

procedure TIdiBtr.WriteCredVal(pValue:double);
begin
  oBtrTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TIdiBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TIdiBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TIdiBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TIdiBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TIdiBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIdiBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIdiBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIdiBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TIdiBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TIdiBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TIdiBtr.ReadDocType:byte;
begin
  Result := oBtrTable.FieldByName('DocType').AsInteger;
end;

procedure TIdiBtr.WriteDocType(pValue:byte);
begin
  oBtrTable.FieldByName('DocType').AsInteger := pValue;
end;

function TIdiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIdiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIdiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIdiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIdiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIdiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIdiBtr.ReadModNum:longint;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIdiBtr.WriteModNum(pValue:longint);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIdiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIdiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIdiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIdiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIdiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIdiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIdiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIdiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TIdiBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIdiBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIdiBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIdiBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIdiBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIdiBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIdiBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TIdiBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TIdiBtr.ReadPyPayVal:double;
begin
  Result := oBtrTable.FieldByName('PyPayVal').AsFloat;
end;

procedure TIdiBtr.WritePyPayVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPayVal').AsFloat := pValue;
end;

function TIdiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIdiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIdiBtr.ReadFgCrdVal:double;
begin
  Result := oBtrTable.FieldByName('FgCrdVal').AsFloat;
end;

procedure TIdiBtr.WriteFgCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('FgCrdVal').AsFloat := pValue;
end;

function TIdiBtr.ReadFgDebVal:double;
begin
  Result := oBtrTable.FieldByName('FgDebVal').AsFloat;
end;

procedure TIdiBtr.WriteFgDebVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDebVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIdiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIdiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIdiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIdiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TIdiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TIdiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIdiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIdiBtr.LocateSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TIdiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TIdiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TIdiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TIdiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIdiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIdiBtr.NearestSntAnl (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TIdiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

procedure TIdiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIdiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIdiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIdiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIdiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIdiBtr.First;
begin
  oBtrTable.First;
end;

procedure TIdiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIdiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIdiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIdiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIdiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIdiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIdiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIdiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIdiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIdiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIdiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
