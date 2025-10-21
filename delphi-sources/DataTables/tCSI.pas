unit tCSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixItmNum = 'ItmNum';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixDescribe_ = 'Describe_';
  ixConExt = 'ConExt';
  ixConDoc = 'ConDoc';
  ixPaCode = 'PaCode';

type
  TCsiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadDocType:Str1;          procedure WriteDocType (pValue:Str1);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyAValue:double;       procedure WritePyAValue (pValue:double);
    function  ReadPyBValue:double;       procedure WritePyBValue (pValue:double);
    function  ReadPyVatVal:double;       procedure WritePyVatVal (pValue:double);
    function  ReadPyPdfVal:double;       procedure WritePyPdfVal (pValue:double);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcCrdVal:double;       procedure WriteAcCrdVal (pValue:double);
    function  ReadAcPdfVal:double;       procedure WriteAcPdfVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadDrvCode:word;          procedure WriteDrvCode (pValue:word);
    function  ReadDrvName:Str30;         procedure WriteDrvName (pValue:Str30);
    function  ReadCarMark:Str10;         procedure WriteCarMark (pValue:Str10);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadConExt:Str12;          procedure WriteConExt (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadCrdSnt:Str3;           procedure WriteCrdSnt (pValue:Str3);
    function  ReadCrdAnl:Str6;           procedure WriteCrdAnl (pValue:Str6);
    function  ReadPdfSnt:Str3;           procedure WritePdfSnt (pValue:Str3);
    function  ReadPdfAnl:Str6;           procedure WritePdfAnl (pValue:Str6);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadExcCosPrc:double;      procedure WriteExcCosPrc (pValue:double);
    function  ReadExcCosVal:double;      procedure WriteExcCosVal (pValue:double);
    function  ReadExcVatPrc:double;      procedure WriteExcVatPrc (pValue:double);
    function  ReadExcVatVal:double;      procedure WriteExcVatVal (pValue:double);
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
    function LocateRowNum (pRowNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDescribe_ (pDescribe_:Str30):boolean;
    function LocateConExt (pConExt:Str12):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocatePaCode (pPaCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property DocType:Str1 read ReadDocType write WriteDocType;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyAValue:double read ReadPyAValue write WritePyAValue;
    property PyBValue:double read ReadPyBValue write WritePyBValue;
    property PyVatVal:double read ReadPyVatVal write WritePyVatVal;
    property PyPdfVal:double read ReadPyPdfVal write WritePyPdfVal;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcCrdVal:double read ReadAcCrdVal write WriteAcCrdVal;
    property AcPdfVal:double read ReadAcPdfVal write WriteAcPdfVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property DrvCode:word read ReadDrvCode write WriteDrvCode;
    property DrvName:Str30 read ReadDrvName write WriteDrvName;
    property CarMark:Str10 read ReadCarMark write WriteCarMark;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property ConExt:Str12 read ReadConExt write WriteConExt;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property CrdSnt:Str3 read ReadCrdSnt write WriteCrdSnt;
    property CrdAnl:Str6 read ReadCrdAnl write WriteCrdAnl;
    property PdfSnt:Str3 read ReadPdfSnt write WritePdfSnt;
    property PdfAnl:Str6 read ReadPdfAnl write WritePdfAnl;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property ExcCosPrc:double read ReadExcCosPrc write WriteExcCosPrc;
    property ExcCosVal:double read ReadExcCosVal write WriteExcCosVal;
    property ExcVatPrc:double read ReadExcVatPrc write WriteExcVatPrc;
    property ExcVatVal:double read ReadExcVatVal write WriteExcVatVal;
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

constructor TCsiTmp.Create;
begin
  oTmpTable := TmpInit ('CSI',Self);
end;

destructor TCsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCsiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCsiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCsiTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TCsiTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TCsiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TCsiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TCsiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCsiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCsiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCsiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCsiTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TCsiTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TCsiTmp.ReadDescribe_:Str30;
begin
  Result := oTmpTable.FieldByName('Describe_').AsString;
end;

procedure TCsiTmp.WriteDescribe_(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe_').AsString := pValue;
end;

function TCsiTmp.ReadDocType:Str1;
begin
  Result := oTmpTable.FieldByName('DocType').AsString;
end;

procedure TCsiTmp.WriteDocType(pValue:Str1);
begin
  oTmpTable.FieldByName('DocType').AsString := pValue;
end;

function TCsiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCsiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCsiTmp.ReadPyDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('PyDvzName').AsString;
end;

procedure TCsiTmp.WritePyDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TCsiTmp.ReadPyCourse:double;
begin
  Result := oTmpTable.FieldByName('PyCourse').AsFloat;
end;

procedure TCsiTmp.WritePyCourse(pValue:double);
begin
  oTmpTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TCsiTmp.ReadPyAValue:double;
begin
  Result := oTmpTable.FieldByName('PyAValue').AsFloat;
end;

procedure TCsiTmp.WritePyAValue(pValue:double);
begin
  oTmpTable.FieldByName('PyAValue').AsFloat := pValue;
end;

function TCsiTmp.ReadPyBValue:double;
begin
  Result := oTmpTable.FieldByName('PyBValue').AsFloat;
end;

procedure TCsiTmp.WritePyBValue(pValue:double);
begin
  oTmpTable.FieldByName('PyBValue').AsFloat := pValue;
end;

function TCsiTmp.ReadPyVatVal:double;
begin
  Result := oTmpTable.FieldByName('PyVatVal').AsFloat;
end;

procedure TCsiTmp.WritePyVatVal(pValue:double);
begin
  oTmpTable.FieldByName('PyVatVal').AsFloat := pValue;
end;

function TCsiTmp.ReadPyPdfVal:double;
begin
  Result := oTmpTable.FieldByName('PyPdfVal').AsFloat;
end;

procedure TCsiTmp.WritePyPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('PyPdfVal').AsFloat := pValue;
end;

function TCsiTmp.ReadAcDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TCsiTmp.WriteAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TCsiTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TCsiTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TCsiTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TCsiTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TCsiTmp.ReadAcCrdVal:double;
begin
  Result := oTmpTable.FieldByName('AcCrdVal').AsFloat;
end;

procedure TCsiTmp.WriteAcCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('AcCrdVal').AsFloat := pValue;
end;

function TCsiTmp.ReadAcPdfVal:double;
begin
  Result := oTmpTable.FieldByName('AcPdfVal').AsFloat;
end;

procedure TCsiTmp.WriteAcPdfVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPdfVal').AsFloat := pValue;
end;

function TCsiTmp.ReadFgDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TCsiTmp.WriteFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TCsiTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TCsiTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TCsiTmp.ReadFgPayVal:double;
begin
  Result := oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TCsiTmp.WriteFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TCsiTmp.ReadDrvCode:word;
begin
  Result := oTmpTable.FieldByName('DrvCode').AsInteger;
end;

procedure TCsiTmp.WriteDrvCode(pValue:word);
begin
  oTmpTable.FieldByName('DrvCode').AsInteger := pValue;
end;

function TCsiTmp.ReadDrvName:Str30;
begin
  Result := oTmpTable.FieldByName('DrvName').AsString;
end;

procedure TCsiTmp.WriteDrvName(pValue:Str30);
begin
  oTmpTable.FieldByName('DrvName').AsString := pValue;
end;

function TCsiTmp.ReadCarMark:Str10;
begin
  Result := oTmpTable.FieldByName('CarMark').AsString;
end;

procedure TCsiTmp.WriteCarMark(pValue:Str10);
begin
  oTmpTable.FieldByName('CarMark').AsString := pValue;
end;

function TCsiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCsiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCsiTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TCsiTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TCsiTmp.ReadConExt:Str12;
begin
  Result := oTmpTable.FieldByName('ConExt').AsString;
end;

procedure TCsiTmp.WriteConExt(pValue:Str12);
begin
  oTmpTable.FieldByName('ConExt').AsString := pValue;
end;

function TCsiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TCsiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCsiTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TCsiTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCsiTmp.ReadCentNum:word;
begin
  Result := oTmpTable.FieldByName('CentNum').AsInteger;
end;

procedure TCsiTmp.WriteCentNum(pValue:word);
begin
  oTmpTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TCsiTmp.ReadCrdSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CrdSnt').AsString;
end;

procedure TCsiTmp.WriteCrdSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CrdSnt').AsString := pValue;
end;

function TCsiTmp.ReadCrdAnl:Str6;
begin
  Result := oTmpTable.FieldByName('CrdAnl').AsString;
end;

procedure TCsiTmp.WriteCrdAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CrdAnl').AsString := pValue;
end;

function TCsiTmp.ReadPdfSnt:Str3;
begin
  Result := oTmpTable.FieldByName('PdfSnt').AsString;
end;

procedure TCsiTmp.WritePdfSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('PdfSnt').AsString := pValue;
end;

function TCsiTmp.ReadPdfAnl:Str6;
begin
  Result := oTmpTable.FieldByName('PdfAnl').AsString;
end;

procedure TCsiTmp.WritePdfAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('PdfAnl').AsString := pValue;
end;

function TCsiTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TCsiTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TCsiTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TCsiTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TCsiTmp.ReadExcCosPrc:double;
begin
  Result := oTmpTable.FieldByName('ExcCosPrc').AsFloat;
end;

procedure TCsiTmp.WriteExcCosPrc(pValue:double);
begin
  oTmpTable.FieldByName('ExcCosPrc').AsFloat := pValue;
end;

function TCsiTmp.ReadExcCosVal:double;
begin
  Result := oTmpTable.FieldByName('ExcCosVal').AsFloat;
end;

procedure TCsiTmp.WriteExcCosVal(pValue:double);
begin
  oTmpTable.FieldByName('ExcCosVal').AsFloat := pValue;
end;

function TCsiTmp.ReadExcVatPrc:double;
begin
  Result := oTmpTable.FieldByName('ExcVatPrc').AsFloat;
end;

procedure TCsiTmp.WriteExcVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('ExcVatPrc').AsFloat := pValue;
end;

function TCsiTmp.ReadExcVatVal:double;
begin
  Result := oTmpTable.FieldByName('ExcVatVal').AsFloat;
end;

procedure TCsiTmp.WriteExcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('ExcVatVal').AsFloat := pValue;
end;

function TCsiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TCsiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCsiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCsiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCsiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCsiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCsiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TCsiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCsiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TCsiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TCsiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCsiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCsiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCsiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCsiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TCsiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCsiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCsiTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TCsiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TCsiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TCsiTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TCsiTmp.LocateDescribe_ (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe_);
  Result := oTmpTable.FindKey([pDescribe_]);
end;

function TCsiTmp.LocateConExt (pConExt:Str12):boolean;
begin
  SetIndex (ixConExt);
  Result := oTmpTable.FindKey([pConExt]);
end;

function TCsiTmp.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oTmpTable.FindKey([pConDoc]);
end;

function TCsiTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

procedure TCsiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TCsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCsiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCsiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCsiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCsiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
