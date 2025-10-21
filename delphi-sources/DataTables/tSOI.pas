unit tSOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixDocDate = 'DocDate';
  ixContoNum = 'ContoNum';
  ixDescribe_ = 'Describe_';
  ixExtNum = 'ExtNum';
  ixConDoc = 'ConDoc';
  ixAcPayVal = 'AcPayVal';
  ixFgPayVal = 'FgPayVal';

type
  TSoiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadContoNum:Str20;        procedure WriteContoNum (pValue:Str20);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyPayVal:double;       procedure WritePyPayVal (pValue:double);
    function  ReadPyPdfVal:double;       procedure WritePyPdfVal (pValue:double);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcCrdVal:double;       procedure WriteAcCrdVal (pValue:double);
    function  ReadAcPdfVal:double;       procedure WriteAcPdfVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadFgPdfVal:double;       procedure WriteFgPdfVal (pValue:double);
    function  ReadExtNum:Str10;          procedure WriteExtNum (pValue:Str10);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadCsyCode:Str4;          procedure WriteCsyCode (pValue:Str4);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadCrdSnt:Str3;           procedure WriteCrdSnt (pValue:Str3);
    function  ReadCrdAnl:Str6;           procedure WriteCrdAnl (pValue:Str6);
    function  ReadPdfSnt:Str3;           procedure WritePdfSnt (pValue:Str3);
    function  ReadPdfAnl:Str6;           procedure WritePdfAnl (pValue:Str6);
    function  ReadDocSnt:Str3;           procedure WriteDocSnt (pValue:Str3);
    function  ReadDocAnl:Str6;           procedure WriteDocAnl (pValue:Str6);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateContoNum (pContoNum:Str20):boolean;
    function LocateDescribe_ (pDescribe_:Str30):boolean;
    function LocateExtNum (pExtNum:Str10):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateAcPayVal (pAcPayVal:double):boolean;
    function LocateFgPayVal (pFgPayVal:double):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ContoNum:Str20 read ReadContoNum write WriteContoNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyPayVal:double read ReadPyPayVal write WritePyPayVal;
    property PyPdfVal:double read ReadPyPdfVal write WritePyPdfVal;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcCrdVal:double read ReadAcCrdVal write WriteAcCrdVal;
    property AcPdfVal:double read ReadAcPdfVal write WriteAcPdfVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property FgPdfVal:double read ReadFgPdfVal write WriteFgPdfVal;
    property ExtNum:Str10 read ReadExtNum write WriteExtNum;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property CsyCode:Str4 read ReadCsyCode write WriteCsyCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property CrdSnt:Str3 read ReadCrdSnt write WriteCrdSnt;
    property CrdAnl:Str6 read ReadCrdAnl write WriteCrdAnl;
    property PdfSnt:Str3 read ReadPdfSnt write WritePdfSnt;
    property PdfAnl:Str6 read ReadPdfAnl write WritePdfAnl;
    property DocSnt:Str3 read ReadDocSnt write WriteDocSnt;
    property DocAnl:Str6 read ReadDocAnl write WriteDocAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSoiTmp.Create;
begin
  oTmpTable := TmpInit ('SOI',Self);
end;

destructor TSoiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSoiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSoiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSoiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSoiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSoiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSoiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSoiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSoiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSoiTmp.ReadContoNum:Str20;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TSoiTmp.WriteContoNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TSoiTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TSoiTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TSoiTmp.ReadDescribe_:Str30;
begin
  Result := oTmpTable.FieldByName('Describe_').AsString;
end;

procedure TSoiTmp.WriteDescribe_(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe_').AsString := pValue;
end;

function TSoiTmp.ReadPyDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('PyDvzName').AsString;
end;

procedure TSoiTmp.WritePyDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TSoiTmp.ReadPyCourse:double;
begin
  Result := oTmpTable.FieldByName('PyCourse').AsFloat;
end;

procedure TSoiTmp.WritePyCourse(pValue:double);
begin
  oTmpTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TSoiTmp.ReadPyPayVal:double;
begin
  Result := oTmpTable.FieldByName('PyPayVal').AsFloat;
end;

procedure TSoiTmp.WritePyPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PyPayVal').AsFloat := pValue;
end;

function TSoiTmp.ReadPyPdfVal:double;
begin
  Result := oTmpTable.FieldByName('PyPdfVal').AsFloat;
end;

procedure TSoiTmp.WritePyPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('PyPdfVal').AsFloat := pValue;
end;

function TSoiTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TSoiTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TSoiTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TSoiTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TSoiTmp.ReadAcCrdVal:double;
begin
  Result := oTmpTable.FieldByName('AcCrdVal').AsFloat;
end;

procedure TSoiTmp.WriteAcCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('AcCrdVal').AsFloat := pValue;
end;

function TSoiTmp.ReadAcPdfVal:double;
begin
  Result := oTmpTable.FieldByName('AcPdfVal').AsFloat;
end;

procedure TSoiTmp.WriteAcPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPdfVal').AsFloat := pValue;
end;

function TSoiTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TSoiTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TSoiTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TSoiTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TSoiTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TSoiTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TSoiTmp.ReadFgPdfVal:double;
begin
  Result := oTmpTable.FieldByName('FgPdfVal').AsFloat;
end;

procedure TSoiTmp.WriteFgPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPdfVal').AsFloat := pValue;
end;

function TSoiTmp.ReadExtNum:Str10;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TSoiTmp.WriteExtNum(pValue:Str10);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TSoiTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TSoiTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSoiTmp.ReadCsyCode:Str4;
begin
  Result := oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TSoiTmp.WriteCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString := pValue;
end;

function TSoiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSoiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSoiTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TSoiTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TSoiTmp.ReadCentNum:word;
begin
  Result := oTmpTable.FieldByName('CentNum').AsInteger;
end;

procedure TSoiTmp.WriteCentNum(pValue:word);
begin
  oTmpTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TSoiTmp.ReadCrdSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CrdSnt').AsString;
end;

procedure TSoiTmp.WriteCrdSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CrdSnt').AsString := pValue;
end;

function TSoiTmp.ReadCrdAnl:Str6;
begin
  Result := oTmpTable.FieldByName('CrdAnl').AsString;
end;

procedure TSoiTmp.WriteCrdAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CrdAnl').AsString := pValue;
end;

function TSoiTmp.ReadPdfSnt:Str3;
begin
  Result := oTmpTable.FieldByName('PdfSnt').AsString;
end;

procedure TSoiTmp.WritePdfSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('PdfSnt').AsString := pValue;
end;

function TSoiTmp.ReadPdfAnl:Str6;
begin
  Result := oTmpTable.FieldByName('PdfAnl').AsString;
end;

procedure TSoiTmp.WritePdfAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('PdfAnl').AsString := pValue;
end;

function TSoiTmp.ReadDocSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TSoiTmp.WriteDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString := pValue;
end;

function TSoiTmp.ReadDocAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TSoiTmp.WriteDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString := pValue;
end;

function TSoiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSoiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSoiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSoiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSoiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSoiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSoiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSoiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSoiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSoiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSoiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSoiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSoiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSoiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSoiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSoiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSoiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSoiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSoiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TSoiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TSoiTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSoiTmp.LocateContoNum (pContoNum:Str20):boolean;
begin
  SetIndex (ixContoNum);
  Result := oTmpTable.FindKey([pContoNum]);
end;

function TSoiTmp.LocateDescribe_ (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe_);
  Result := oTmpTable.FindKey([pDescribe_]);
end;

function TSoiTmp.LocateExtNum (pExtNum:Str10):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TSoiTmp.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oTmpTable.FindKey([pConDoc]);
end;

function TSoiTmp.LocateAcPayVal (pAcPayVal:double):boolean;
begin
  SetIndex (ixAcPayVal);
  Result := oTmpTable.FindKey([pAcPayVal]);
end;

function TSoiTmp.LocateFgPayVal (pFgPayVal:double):boolean;
begin
  SetIndex (ixFgPayVal);
  Result := oTmpTable.FindKey([pFgPayVal]);
end;

procedure TSoiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSoiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSoiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSoiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSoiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSoiTmp.First;
begin
  oTmpTable.First;
end;

procedure TSoiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSoiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSoiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSoiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSoiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSoiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSoiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSoiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSoiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSoiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSoiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
