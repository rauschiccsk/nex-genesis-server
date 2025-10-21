unit tIDI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDoIt = 'DoIt';
  ixItmNum = 'ItmNum';
  ixDocDate = 'DocDate';
  ixSntAnl = 'SntAnl';
  ixPaCode = 'PaCode';

type
  TIdiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadDocNum:str12;          procedure WriteDocNum (pValue:str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadConExt:Str12;          procedure WriteConExt (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadDescribe:str30;        procedure WriteDescribe (pValue:str30);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCrdVal:double;       procedure WriteFgCrdVal (pValue:double);
    function  ReadFgDebVal:double;       procedure WriteFgDebVal (pValue:double);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyPayVal:double;       procedure WritePyPayVal (pValue:double);
    function  ReadStatus:str1;           procedure WriteStatus (pValue:str1);
    function  ReadDocType:byte;          procedure WriteDocType (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadModNum:longint;        procedure WriteModNum (pValue:longint);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateDoIt (pDocNum:str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSntAnl (pAccSnt:str3;pAccAnl:str6):boolean;
    function LocatePaCode (pPaCode:longint):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property DocNum:str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property ConExt:Str12 read ReadConExt write WriteConExt;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property Describe:str30 read ReadDescribe write WriteDescribe;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCrdVal:double read ReadFgCrdVal write WriteFgCrdVal;
    property FgDebVal:double read ReadFgDebVal write WriteFgDebVal;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyPayVal:double read ReadPyPayVal write WritePyPayVal;
    property Status:str1 read ReadStatus write WriteStatus;
    property DocType:byte read ReadDocType write WriteDocType;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ModNum:longint read ReadModNum write WriteModNum;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIdiTmp.Create;
begin
  oTmpTable := TmpInit ('IDI',Self);
end;

destructor TIdiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIdiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIdiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIdiTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TIdiTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIdiTmp.ReadDocNum:str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIdiTmp.WriteDocNum(pValue:str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIdiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIdiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIdiTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TIdiTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIdiTmp.ReadConExt:Str12;
begin
  Result := oTmpTable.FieldByName('ConExt').AsString;
end;

procedure TIdiTmp.WriteConExt(pValue:Str12);
begin
  oTmpTable.FieldByName('ConExt').AsString := pValue;
end;

function TIdiTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIdiTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIdiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIdiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIdiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIdiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIdiTmp.ReadAccSnt:str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIdiTmp.WriteAccSnt(pValue:str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIdiTmp.ReadAccAnl:str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIdiTmp.WriteAccAnl(pValue:str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIdiTmp.ReadDescribe:str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TIdiTmp.WriteDescribe(pValue:str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TIdiTmp.ReadCredVal:double;
begin
  Result := oTmpTable.FieldByName('CredVal').AsFloat;
end;

procedure TIdiTmp.WriteCredVal(pValue:double);
begin
  oTmpTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TIdiTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TIdiTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TIdiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIdiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TIdiTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIdiTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIdiTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIdiTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIdiTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIdiTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIdiTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIdiTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIdiTmp.ReadFgCrdVal:double;
begin
  Result := oTmpTable.FieldByName('FgCrdVal').AsFloat;
end;

procedure TIdiTmp.WriteFgCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('FgCrdVal').AsFloat := pValue;
end;

function TIdiTmp.ReadFgDebVal:double;
begin
  Result := oTmpTable.FieldByName('FgDebVal').AsFloat;
end;

procedure TIdiTmp.WriteFgDebVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDebVal').AsFloat := pValue;
end;

function TIdiTmp.ReadPyCourse:double;
begin
  Result := oTmpTable.FieldByName('PyCourse').AsFloat;
end;

procedure TIdiTmp.WritePyCourse(pValue:double);
begin
  oTmpTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TIdiTmp.ReadPyPayVal:double;
begin
  Result := oTmpTable.FieldByName('PyPayVal').AsFloat;
end;

procedure TIdiTmp.WritePyPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PyPayVal').AsFloat := pValue;
end;

function TIdiTmp.ReadStatus:str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TIdiTmp.WriteStatus(pValue:str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TIdiTmp.ReadDocType:byte;
begin
  Result := oTmpTable.FieldByName('DocType').AsInteger;
end;

procedure TIdiTmp.WriteDocType(pValue:byte);
begin
  oTmpTable.FieldByName('DocType').AsInteger := pValue;
end;

function TIdiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIdiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIdiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIdiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIdiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIdiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIdiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIdiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIdiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIdiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIdiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIdiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIdiTmp.ReadModNum:longint;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIdiTmp.WriteModNum(pValue:longint);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIdiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIdiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIdiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIdiTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TIdiTmp.LocateDoIt (pDocNum:str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TIdiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TIdiTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TIdiTmp.LocateSntAnl (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSntAnl);
  Result := oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

function TIdiTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

procedure TIdiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIdiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIdiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIdiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIdiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIdiTmp.First;
begin
  oTmpTable.First;
end;

procedure TIdiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIdiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIdiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIdiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIdiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIdiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIdiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIdiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIdiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIdiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIdiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
