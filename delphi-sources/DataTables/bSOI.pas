unit bSOI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixDocDate = 'DocDate';
  ixContoNum = 'ContoNum';
  ixExtNum = 'ExtNum';
  ixConDoc = 'ConDoc';

type
  TSoiBtr = class (TComponent)
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
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadContoNum:Str20;        procedure WriteContoNum (pValue:Str20);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
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
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateContoNum (pContoNum:Str20):boolean;
    function LocateExtNum (pExtNum:Str10):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestContoNum (pContoNum:Str20):boolean;
    function NearestExtNum (pExtNum:Str10):boolean;
    function NearestConDoc (pConDoc:Str12):boolean;

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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ContoNum:Str20 read ReadContoNum write WriteContoNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
  end;

implementation

constructor TSoiBtr.Create;
begin
  oBtrTable := BtrInit ('SOI',gPath.LdgPath,Self);
end;

constructor TSoiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SOI',pPath,Self);
end;

destructor TSoiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSoiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSoiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSoiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSoiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSoiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSoiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSoiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSoiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSoiBtr.ReadContoNum:Str20;
begin
  Result := oBtrTable.FieldByName('ContoNum').AsString;
end;

procedure TSoiBtr.WriteContoNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ContoNum').AsString := pValue;
end;

function TSoiBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TSoiBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TSoiBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TSoiBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TSoiBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TSoiBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TSoiBtr.ReadPyPayVal:double;
begin
  Result := oBtrTable.FieldByName('PyPayVal').AsFloat;
end;

procedure TSoiBtr.WritePyPayVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPayVal').AsFloat := pValue;
end;

function TSoiBtr.ReadPyPdfVal:double;
begin
  Result := oBtrTable.FieldByName('PyPdfVal').AsFloat;
end;

procedure TSoiBtr.WritePyPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPdfVal').AsFloat := pValue;
end;

function TSoiBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TSoiBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TSoiBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TSoiBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TSoiBtr.ReadAcCrdVal:double;
begin
  Result := oBtrTable.FieldByName('AcCrdVal').AsFloat;
end;

procedure TSoiBtr.WriteAcCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('AcCrdVal').AsFloat := pValue;
end;

function TSoiBtr.ReadAcPdfVal:double;
begin
  Result := oBtrTable.FieldByName('AcPdfVal').AsFloat;
end;

procedure TSoiBtr.WriteAcPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPdfVal').AsFloat := pValue;
end;

function TSoiBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TSoiBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TSoiBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TSoiBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TSoiBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TSoiBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TSoiBtr.ReadFgPdfVal:double;
begin
  Result := oBtrTable.FieldByName('FgPdfVal').AsFloat;
end;

procedure TSoiBtr.WriteFgPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPdfVal').AsFloat := pValue;
end;

function TSoiBtr.ReadExtNum:Str10;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TSoiBtr.WriteExtNum(pValue:Str10);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TSoiBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TSoiBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSoiBtr.ReadCsyCode:Str4;
begin
  Result := oBtrTable.FieldByName('CsyCode').AsString;
end;

procedure TSoiBtr.WriteCsyCode(pValue:Str4);
begin
  oBtrTable.FieldByName('CsyCode').AsString := pValue;
end;

function TSoiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TSoiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TSoiBtr.ReadCentNum:word;
begin
  Result := oBtrTable.FieldByName('CentNum').AsInteger;
end;

procedure TSoiBtr.WriteCentNum(pValue:word);
begin
  oBtrTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TSoiBtr.ReadCrdSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CrdSnt').AsString;
end;

procedure TSoiBtr.WriteCrdSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CrdSnt').AsString := pValue;
end;

function TSoiBtr.ReadCrdAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CrdAnl').AsString;
end;

procedure TSoiBtr.WriteCrdAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CrdAnl').AsString := pValue;
end;

function TSoiBtr.ReadPdfSnt:Str3;
begin
  Result := oBtrTable.FieldByName('PdfSnt').AsString;
end;

procedure TSoiBtr.WritePdfSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('PdfSnt').AsString := pValue;
end;

function TSoiBtr.ReadPdfAnl:Str6;
begin
  Result := oBtrTable.FieldByName('PdfAnl').AsString;
end;

procedure TSoiBtr.WritePdfAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('PdfAnl').AsString := pValue;
end;

function TSoiBtr.ReadDocSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DocSnt').AsString;
end;

procedure TSoiBtr.WriteDocSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DocSnt').AsString := pValue;
end;

function TSoiBtr.ReadDocAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DocAnl').AsString;
end;

procedure TSoiBtr.WriteDocAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DocAnl').AsString := pValue;
end;

function TSoiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSoiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSoiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSoiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSoiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSoiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSoiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSoiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSoiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSoiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSoiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSoiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSoiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSoiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSoiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSoiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSoiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSoiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSoiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSoiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSoiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSoiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSoiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TSoiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSoiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TSoiBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSoiBtr.LocateContoNum (pContoNum:Str20):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindKey([pContoNum]);
end;

function TSoiBtr.LocateExtNum (pExtNum:Str10):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TSoiBtr.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindKey([pConDoc]);
end;

function TSoiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TSoiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSoiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TSoiBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSoiBtr.NearestContoNum (pContoNum:Str20):boolean;
begin
  SetIndex (ixContoNum);
  Result := oBtrTable.FindNearest([pContoNum]);
end;

function TSoiBtr.NearestExtNum (pExtNum:Str10):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TSoiBtr.NearestConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindNearest([pConDoc]);
end;

procedure TSoiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSoiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSoiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSoiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSoiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSoiBtr.First;
begin
  oBtrTable.First;
end;

procedure TSoiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSoiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSoiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSoiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSoiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSoiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSoiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSoiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSoiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSoiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSoiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
