unit tSOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYnSn = '';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPyBegVal = 'PyBegVal';
  ixPyCredVal = 'PyCredVal';
  ixPyDebVal = 'PyDebVal';
  ixPyEndVal = 'PyEndVal';

type
  TSohTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
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
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateYnSn (pYear:Str2;pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePyBegVal (pPyBegVal:double):boolean;
    function LocatePyCredVal (pPyCredVal:double):boolean;
    function LocatePyDebVal (pPyDebVal:double):boolean;
    function LocatePyEndVal (pPyEndVal:double):boolean;

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
    property Year:Str2 read ReadYear write WriteYear;
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
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
  end;

implementation

constructor TSohTmp.Create;
begin
  oTmpTable := TmpInit ('SOH',Self);
end;

destructor TSohTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSohTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSohTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSohTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TSohTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TSohTmp.ReadSerNum:word;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TSohTmp.WriteSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSohTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSohTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSohTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSohTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSohTmp.ReadPyDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('PyDvzName').AsString;
end;

procedure TSohTmp.WritePyDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('PyDvzName').AsString := pValue;
end;

function TSohTmp.ReadPyCourse:double;
begin
  Result := oTmpTable.FieldByName('PyCourse').AsFloat;
end;

procedure TSohTmp.WritePyCourse(pValue:double);
begin
  oTmpTable.FieldByName('PyCourse').AsFloat := pValue;
end;

function TSohTmp.ReadPyBegVal:double;
begin
  Result := oTmpTable.FieldByName('PyBegVal').AsFloat;
end;

procedure TSohTmp.WritePyBegVal(pValue:double);
begin
  oTmpTable.FieldByName('PyBegVal').AsFloat := pValue;
end;

function TSohTmp.ReadPyCredVal:double;
begin
  Result := oTmpTable.FieldByName('PyCredVal').AsFloat;
end;

procedure TSohTmp.WritePyCredVal(pValue:double);
begin
  oTmpTable.FieldByName('PyCredVal').AsFloat := pValue;
end;

function TSohTmp.ReadPyDebVal:double;
begin
  Result := oTmpTable.FieldByName('PyDebVal').AsFloat;
end;

procedure TSohTmp.WritePyDebVal(pValue:double);
begin
  oTmpTable.FieldByName('PyDebVal').AsFloat := pValue;
end;

function TSohTmp.ReadPyEndVal:double;
begin
  Result := oTmpTable.FieldByName('PyEndVal').AsFloat;
end;

procedure TSohTmp.WritePyEndVal(pValue:double);
begin
  oTmpTable.FieldByName('PyEndVal').AsFloat := pValue;
end;

function TSohTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TSohTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TSohTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSohTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TSohTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TSohTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TSohTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSohTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSohTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSohTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSohTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSohTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSohTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSohTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSohTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSohTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSohTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSohTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSohTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSohTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSohTmp.ReadAcBegVal:double;
begin
  Result := oTmpTable.FieldByName('AcBegVal').AsFloat;
end;

procedure TSohTmp.WriteAcBegVal(pValue:double);
begin
  oTmpTable.FieldByName('AcBegVal').AsFloat := pValue;
end;

function TSohTmp.ReadAcCredVal:double;
begin
  Result := oTmpTable.FieldByName('AcCredVal').AsFloat;
end;

procedure TSohTmp.WriteAcCredVal(pValue:double);
begin
  oTmpTable.FieldByName('AcCredVal').AsFloat := pValue;
end;

function TSohTmp.ReadAcDebVal:double;
begin
  Result := oTmpTable.FieldByName('AcDebVal').AsFloat;
end;

procedure TSohTmp.WriteAcDebVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDebVal').AsFloat := pValue;
end;

function TSohTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TSohTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TSohTmp.ReadPyDifVal:double;
begin
  Result := oTmpTable.FieldByName('PyDifVal').AsFloat;
end;

procedure TSohTmp.WritePyDifVal(pValue:double);
begin
  oTmpTable.FieldByName('PyDifVal').AsFloat := pValue;
end;

function TSohTmp.ReadDstDif:Str1;
begin
  Result := oTmpTable.FieldByName('DstDif').AsString;
end;

procedure TSohTmp.WriteDstDif(pValue:Str1);
begin
  oTmpTable.FieldByName('DstDif').AsString := pValue;
end;

function TSohTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TSohTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSohTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSohTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSohTmp.LocateYnSn (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYnSn);
  Result := oTmpTable.FindKey([pYear,pSerNum]);
end;

function TSohTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSohTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSohTmp.LocatePyBegVal (pPyBegVal:double):boolean;
begin
  SetIndex (ixPyBegVal);
  Result := oTmpTable.FindKey([pPyBegVal]);
end;

function TSohTmp.LocatePyCredVal (pPyCredVal:double):boolean;
begin
  SetIndex (ixPyCredVal);
  Result := oTmpTable.FindKey([pPyCredVal]);
end;

function TSohTmp.LocatePyDebVal (pPyDebVal:double):boolean;
begin
  SetIndex (ixPyDebVal);
  Result := oTmpTable.FindKey([pPyDebVal]);
end;

function TSohTmp.LocatePyEndVal (pPyEndVal:double):boolean;
begin
  SetIndex (ixPyEndVal);
  Result := oTmpTable.FindKey([pPyEndVal]);
end;

procedure TSohTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSohTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSohTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSohTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSohTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSohTmp.First;
begin
  oTmpTable.First;
end;

procedure TSohTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSohTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSohTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSohTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSohTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSohTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSohTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSohTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSohTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSohTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSohTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
