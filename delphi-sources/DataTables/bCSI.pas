unit bCSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixConDoc = 'ConDoc';
  ixItmNum = 'ItmNum';
  ixPaCode = 'PaCode';
  ixDrvCode = 'DrvCode';
  ixCarMark = 'CarMark';

type
  TCsiBtr = class (TComponent)
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
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDocType:Str1;          procedure WriteDocType (pValue:Str1);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPyDvzName:Str3;        procedure WritePyDvzName (pValue:Str3);
    function  ReadPyCourse:double;       procedure WritePyCourse (pValue:double);
    function  ReadPyAValue:double;       procedure WritePyAValue (pValue:double);
    function  ReadPyBValue:double;       procedure WritePyBValue (pValue:double);
    function  ReadPyPdfVal:double;       procedure WritePyPdfVal (pValue:double);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcCrdVal:double;       procedure WriteAcCrdVal (pValue:double);
    function  ReadAcPdfVal:double;       procedure WriteAcPdfVal (pValue:double);
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgPayVal:double;       procedure WriteFgPayVal (pValue:double);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadConExt:Str12;          procedure WriteConExt (pValue:Str12);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadCentNum:word;          procedure WriteCentNum (pValue:word);
    function  ReadCrdSnt:Str3;           procedure WriteCrdSnt (pValue:Str3);
    function  ReadCrdAnl:Str6;           procedure WriteCrdAnl (pValue:Str6);
    function  ReadPdfSnt:Str3;           procedure WritePdfSnt (pValue:Str3);
    function  ReadPdfAnl:Str6;           procedure WritePdfAnl (pValue:Str6);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadDrvCode:word;          procedure WriteDrvCode (pValue:word);
    function  ReadDrvName:Str30;         procedure WriteDrvName (pValue:Str30);
    function  ReadCarMark:Str10;         procedure WriteCarMark (pValue:Str10);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadExcCosPrc:double;      procedure WriteExcCosPrc (pValue:double);
    function  ReadExcCosVal:double;      procedure WriteExcCosVal (pValue:double);
    function  ReadExcVatPrc:double;      procedure WriteExcVatPrc (pValue:double);
    function  ReadExcVatVal:double;      procedure WriteExcVatVal (pValue:double);
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
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateDrvCode (pDrvCode:word):boolean;
    function LocateCarMark (pCarMark:Str10):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestConDoc (pConDoc:Str12):boolean;
    function NearestItmNum (pItmNum:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestDrvCode (pDrvCode:word):boolean;
    function NearestCarMark (pCarMark:Str10):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property DocType:Str1 read ReadDocType write WriteDocType;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PyDvzName:Str3 read ReadPyDvzName write WritePyDvzName;
    property PyCourse:double read ReadPyCourse write WritePyCourse;
    property PyAValue:double read ReadPyAValue write WritePyAValue;
    property PyBValue:double read ReadPyBValue write WritePyBValue;
    property PyPdfVal:double read ReadPyPdfVal write WritePyPdfVal;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcCrdVal:double read ReadAcCrdVal write WriteAcCrdVal;
    property AcPdfVal:double read ReadAcPdfVal write WriteAcPdfVal;
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgPayVal:double read ReadFgPayVal write WriteFgPayVal;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property ConExt:Str12 read ReadConExt write WriteConExt;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property CentNum:word read ReadCentNum write WriteCentNum;
    property CrdSnt:Str3 read ReadCrdSnt write WriteCrdSnt;
    property CrdAnl:Str6 read ReadCrdAnl write WriteCrdAnl;
    property PdfSnt:Str3 read ReadPdfSnt write WritePdfSnt;
    property PdfAnl:Str6 read ReadPdfAnl write WritePdfAnl;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property DrvCode:word read ReadDrvCode write WriteDrvCode;
    property DrvName:Str30 read ReadDrvName write WriteDrvName;
    property CarMark:Str10 read ReadCarMark write WriteCarMark;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ExcCosPrc:double read ReadExcCosPrc write WriteExcCosPrc;
    property ExcCosVal:double read ReadExcCosVal write WriteExcCosVal;
    property ExcVatPrc:double read ReadExcVatPrc write WriteExcVatPrc;
    property ExcVatVal:double read ReadExcVatVal write WriteExcVatVal;
  end;

implementation

constructor TCsiBtr.Create;
begin
  oBtrTable := BtrInit ('CSI',gPath.LdgPath,Self);
end;

constructor TCsiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CSI',pPath,Self);
end;

destructor TCsiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCsiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCsiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCsiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCsiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCsiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCsiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCsiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCsiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCsiBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TCsiBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TCsiBtr.ReadDocType:Str1;
begin
  Result := oBtrTable.FieldByName('DocType').AsString;
end;

procedure TCsiBtr.WriteDocType(pValue:Str1);
begin
  oBtrTable.FieldByName('DocType').AsString := pValue;
end;

function TCsiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCsiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCsiBtr.ReadPyDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('PyDvzName').AsString;
end;

procedure TCsiBtr.WritePyDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TCsiBtr.ReadPyCourse:double;
begin
  Result := oBtrTable.FieldByName('PyCourse').AsFloat;
end;

procedure TCsiBtr.WritePyCourse(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TCsiBtr.ReadPyAValue:double;
begin
  Result := oBtrTable.FieldByName('PyAValue').AsFloat;
end;

procedure TCsiBtr.WritePyAValue(pValue:double);
begin
  oBtrTable.FieldByName('PyAValue').AsFloat := pValue;
end;

function TCsiBtr.ReadPyBValue:double;
begin
  Result := oBtrTable.FieldByName('PyBValue').AsFloat;
end;

procedure TCsiBtr.WritePyBValue(pValue:double);
begin
  oBtrTable.FieldByName('PyBValue').AsFloat := pValue;
end;

function TCsiBtr.ReadPyPdfVal:double;
begin
  Result := oBtrTable.FieldByName('PyPdfVal').AsFloat;
end;

procedure TCsiBtr.WritePyPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('PyPdfVal').AsFloat := pValue;
end;

function TCsiBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TCsiBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TCsiBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TCsiBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TCsiBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TCsiBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TCsiBtr.ReadAcCrdVal:double;
begin
  Result := oBtrTable.FieldByName('AcCrdVal').AsFloat;
end;

procedure TCsiBtr.WriteAcCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('AcCrdVal').AsFloat := pValue;
end;

function TCsiBtr.ReadAcPdfVal:double;
begin
  Result := oBtrTable.FieldByName('AcPdfVal').AsFloat;
end;

procedure TCsiBtr.WriteAcPdfVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPdfVal').AsFloat := pValue;
end;

function TCsiBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TCsiBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TCsiBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TCsiBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TCsiBtr.ReadFgPayVal:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TCsiBtr.WriteFgPayVal(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal').AsFloat := pValue;
end;

function TCsiBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TCsiBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TCsiBtr.ReadConExt:Str12;
begin
  Result := oBtrTable.FieldByName('ConExt').AsString;
end;

procedure TCsiBtr.WriteConExt(pValue:Str12);
begin
  oBtrTable.FieldByName('ConExt').AsString := pValue;
end;

function TCsiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TCsiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCsiBtr.ReadCentNum:word;
begin
  Result := oBtrTable.FieldByName('CentNum').AsInteger;
end;

procedure TCsiBtr.WriteCentNum(pValue:word);
begin
  oBtrTable.FieldByName('CentNum').AsInteger := pValue;
end;

function TCsiBtr.ReadCrdSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CrdSnt').AsString;
end;

procedure TCsiBtr.WriteCrdSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CrdSnt').AsString := pValue;
end;

function TCsiBtr.ReadCrdAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CrdAnl').AsString;
end;

procedure TCsiBtr.WriteCrdAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CrdAnl').AsString := pValue;
end;

function TCsiBtr.ReadPdfSnt:Str3;
begin
  Result := oBtrTable.FieldByName('PdfSnt').AsString;
end;

procedure TCsiBtr.WritePdfSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('PdfSnt').AsString := pValue;
end;

function TCsiBtr.ReadPdfAnl:Str6;
begin
  Result := oBtrTable.FieldByName('PdfAnl').AsString;
end;

procedure TCsiBtr.WritePdfAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('PdfAnl').AsString := pValue;
end;

function TCsiBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TCsiBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TCsiBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TCsiBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TCsiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCsiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCsiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCsiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCsiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCsiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCsiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCsiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCsiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCsiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCsiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCsiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCsiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCsiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCsiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCsiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCsiBtr.ReadDrvCode:word;
begin
  Result := oBtrTable.FieldByName('DrvCode').AsInteger;
end;

procedure TCsiBtr.WriteDrvCode(pValue:word);
begin
  oBtrTable.FieldByName('DrvCode').AsInteger := pValue;
end;

function TCsiBtr.ReadDrvName:Str30;
begin
  Result := oBtrTable.FieldByName('DrvName').AsString;
end;

procedure TCsiBtr.WriteDrvName(pValue:Str30);
begin
  oBtrTable.FieldByName('DrvName').AsString := pValue;
end;

function TCsiBtr.ReadCarMark:Str10;
begin
  Result := oBtrTable.FieldByName('CarMark').AsString;
end;

procedure TCsiBtr.WriteCarMark(pValue:Str10);
begin
  oBtrTable.FieldByName('CarMark').AsString := pValue;
end;

function TCsiBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TCsiBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCsiBtr.ReadExcCosPrc:double;
begin
  Result := oBtrTable.FieldByName('ExcCosPrc').AsFloat;
end;

procedure TCsiBtr.WriteExcCosPrc(pValue:double);
begin
  oBtrTable.FieldByName('ExcCosPrc').AsFloat := pValue;
end;

function TCsiBtr.ReadExcCosVal:double;
begin
  Result := oBtrTable.FieldByName('ExcCosVal').AsFloat;
end;

procedure TCsiBtr.WriteExcCosVal(pValue:double);
begin
  oBtrTable.FieldByName('ExcCosVal').AsFloat := pValue;
end;

function TCsiBtr.ReadExcVatPrc:double;
begin
  Result := oBtrTable.FieldByName('ExcVatPrc').AsFloat;
end;

procedure TCsiBtr.WriteExcVatPrc(pValue:double);
begin
  oBtrTable.FieldByName('ExcVatPrc').AsFloat := pValue;
end;

function TCsiBtr.ReadExcVatVal:double;
begin
  Result := oBtrTable.FieldByName('ExcVatVal').AsFloat;
end;

procedure TCsiBtr.WriteExcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('ExcVatVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCsiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCsiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCsiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCsiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCsiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCsiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TCsiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCsiBtr.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindKey([pConDoc]);
end;

function TCsiBtr.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindKey([pItmNum]);
end;

function TCsiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TCsiBtr.LocateDrvCode (pDrvCode:word):boolean;
begin
  SetIndex (ixDrvCode);
  Result := oBtrTable.FindKey([pDrvCode]);
end;

function TCsiBtr.LocateCarMark (pCarMark:Str10):boolean;
begin
  SetIndex (ixCarMark);
  Result := oBtrTable.FindKey([pCarMark]);
end;

function TCsiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TCsiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCsiBtr.NearestConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindNearest([pConDoc]);
end;

function TCsiBtr.NearestItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oBtrTable.FindNearest([pItmNum]);
end;

function TCsiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TCsiBtr.NearestDrvCode (pDrvCode:word):boolean;
begin
  SetIndex (ixDrvCode);
  Result := oBtrTable.FindNearest([pDrvCode]);
end;

function TCsiBtr.NearestCarMark (pCarMark:Str10):boolean;
begin
  SetIndex (ixCarMark);
  Result := oBtrTable.FindNearest([pCarMark]);
end;

procedure TCsiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCsiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCsiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCsiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCsiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCsiBtr.First;
begin
  oBtrTable.First;
end;

procedure TCsiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCsiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCsiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCsiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCsiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCsiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCsiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCsiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCsiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCsiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCsiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2011001}
