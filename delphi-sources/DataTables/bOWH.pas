unit bOWH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixBegDate = 'BegDate';
  ixEpName = 'EpName';
  ixAcBValue = 'AcBValue';
  ixAcPayVal = 'AcPayVal';
  ixAcEndVal = 'AcEndVal';
  ixDstAcc = 'DstAcc';

type
  TOwhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadEpCode:longint;        procedure WriteEpCode (pValue:longint);
    function  ReadEpName:Str30;          procedure WriteEpName (pValue:Str30);
    function  ReadEpName_:Str30;         procedure WriteEpName_ (pValue:Str30);
    function  ReadStaName:Str30;         procedure WriteStaName (pValue:Str30);
    function  ReadCtyName:Str30;         procedure WriteCtyName (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcDvzName:Str3;        procedure WriteAcDvzName (pValue:Str3);
    function  ReadAcBValue1:double;      procedure WriteAcBValue1 (pValue:double);
    function  ReadAcBValue2:double;      procedure WriteAcBValue2 (pValue:double);
    function  ReadAcBValue3:double;      procedure WriteAcBValue3 (pValue:double);
    function  ReadAcVatVal1:double;      procedure WriteAcVatVal1 (pValue:double);
    function  ReadAcVatVal2:double;      procedure WriteAcVatVal2 (pValue:double);
    function  ReadAcVatVal3:double;      procedure WriteAcVatVal3 (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPValue:double;       procedure WriteAcPValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadFgDvzName1:Str3;       procedure WriteFgDvzName1 (pValue:Str3);
    function  ReadFgBValue1:double;      procedure WriteFgBValue1 (pValue:double);
    function  ReadFgCourse1:double;      procedure WriteFgCourse1 (pValue:double);
    function  ReadFgPValue1:double;      procedure WriteFgPValue1 (pValue:double);
    function  ReadPfCourse1:double;      procedure WritePfCourse1 (pValue:double);
    function  ReadPfCrdVal1:double;      procedure WritePfCrdVal1 (pValue:double);
    function  ReadFgPayVal1:double;      procedure WriteFgPayVal1 (pValue:double);
    function  ReadPyCourse1:double;      procedure WritePyCourse1 (pValue:double);
    function  ReadPyCrdVal1:double;      procedure WritePyCrdVal1 (pValue:double);
    function  ReadFgEndVal1:double;      procedure WriteFgEndVal1 (pValue:double);
    function  ReadFgDvzName2:Str3;       procedure WriteFgDvzName2 (pValue:Str3);
    function  ReadFgBValue2:double;      procedure WriteFgBValue2 (pValue:double);
    function  ReadFgCourse2:double;      procedure WriteFgCourse2 (pValue:double);
    function  ReadFgPValue2:double;      procedure WriteFgPValue2 (pValue:double);
    function  ReadPfCourse2:double;      procedure WritePfCourse2 (pValue:double);
    function  ReadPfCrdVal2:double;      procedure WritePfCrdVal2 (pValue:double);
    function  ReadFgPayVal2:double;      procedure WriteFgPayVal2 (pValue:double);
    function  ReadPyCourse2:double;      procedure WritePyCourse2 (pValue:double);
    function  ReadPyCrdVal2:double;      procedure WritePyCrdVal2 (pValue:double);
    function  ReadFgEndVal2:double;      procedure WriteFgEndVal2 (pValue:double);
    function  ReadFgDvzName3:Str3;       procedure WriteFgDvzName3 (pValue:Str3);
    function  ReadFgBValue3:double;      procedure WriteFgBValue3 (pValue:double);
    function  ReadFgCourse3:double;      procedure WriteFgCourse3 (pValue:double);
    function  ReadFgPValue3:double;      procedure WriteFgPValue3 (pValue:double);
    function  ReadPfCourse3:double;      procedure WritePfCourse3 (pValue:double);
    function  ReadPfCrdVal3:double;      procedure WritePfCrdVal3 (pValue:double);
    function  ReadFgPayVal3:double;      procedure WriteFgPayVal3 (pValue:double);
    function  ReadPyCourse3:double;      procedure WritePyCourse3 (pValue:double);
    function  ReadPyCrdVal3:double;      procedure WritePyCrdVal3 (pValue:double);
    function  ReadFgEndVal3:double;      procedure WriteFgEndVal3 (pValue:double);
    function  ReadFgDvzName4:Str3;       procedure WriteFgDvzName4 (pValue:Str3);
    function  ReadFgBValue4:double;      procedure WriteFgBValue4 (pValue:double);
    function  ReadFgCourse4:double;      procedure WriteFgCourse4 (pValue:double);
    function  ReadFgPValue4:double;      procedure WriteFgPValue4 (pValue:double);
    function  ReadPfCourse4:double;      procedure WritePfCourse4 (pValue:double);
    function  ReadPfCrdVal4:double;      procedure WritePfCrdVal4 (pValue:double);
    function  ReadFgPayVal4:double;      procedure WriteFgPayVal4 (pValue:double);
    function  ReadPyCourse4:double;      procedure WritePyCourse4 (pValue:double);
    function  ReadPyCrdVal4:double;      procedure WritePyCrdVal4 (pValue:double);
    function  ReadFgEndVal4:double;      procedure WriteFgEndVal4 (pValue:double);
    function  ReadFgDvzName5:Str3;       procedure WriteFgDvzName5 (pValue:Str3);
    function  ReadFgBValue5:double;      procedure WriteFgBValue5 (pValue:double);
    function  ReadFgCourse5:double;      procedure WriteFgCourse5 (pValue:double);
    function  ReadFgPValue5:double;      procedure WriteFgPValue5 (pValue:double);
    function  ReadPfCourse5:double;      procedure WritePfCourse5 (pValue:double);
    function  ReadPfCrdVal5:double;      procedure WritePfCrdVal5 (pValue:double);
    function  ReadFgPayVal5:double;      procedure WriteFgPayVal5 (pValue:double);
    function  ReadPyCourse5:double;      procedure WritePyCourse5 (pValue:double);
    function  ReadPyCrdVal5:double;      procedure WritePyCrdVal5 (pValue:double);
    function  ReadFgEndVal5:double;      procedure WriteFgEndVal5 (pValue:double);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadVatDoc:byte;           procedure WriteVatDoc (pValue:byte);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadTicDay:word;           procedure WriteTicDay (pValue:word);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateBegDate (pBegDate:TDatetime):boolean;
    function LocateEpName (pEpName_:Str30):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateAcPayVal (pAcPayVal:double):boolean;
    function LocateAcEndVal (pAcEndVal:double):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestBegDate (pBegDate:TDatetime):boolean;
    function NearestEpName (pEpName_:Str30):boolean;
    function NearestAcBValue (pAcBValue:double):boolean;
    function NearestAcPayVal (pAcPayVal:double):boolean;
    function NearestAcEndVal (pAcEndVal:double):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property EpCode:longint read ReadEpCode write WriteEpCode;
    property EpName:Str30 read ReadEpName write WriteEpName;
    property EpName_:Str30 read ReadEpName_ write WriteEpName_;
    property StaName:Str30 read ReadStaName write WriteStaName;
    property CtyName:Str30 read ReadCtyName write WriteCtyName;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcDvzName:Str3 read ReadAcDvzName write WriteAcDvzName;
    property AcBValue1:double read ReadAcBValue1 write WriteAcBValue1;
    property AcBValue2:double read ReadAcBValue2 write WriteAcBValue2;
    property AcBValue3:double read ReadAcBValue3 write WriteAcBValue3;
    property AcVatVal1:double read ReadAcVatVal1 write WriteAcVatVal1;
    property AcVatVal2:double read ReadAcVatVal2 write WriteAcVatVal2;
    property AcVatVal3:double read ReadAcVatVal3 write WriteAcVatVal3;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPValue:double read ReadAcPValue write WriteAcPValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property FgDvzName1:Str3 read ReadFgDvzName1 write WriteFgDvzName1;
    property FgBValue1:double read ReadFgBValue1 write WriteFgBValue1;
    property FgCourse1:double read ReadFgCourse1 write WriteFgCourse1;
    property FgPValue1:double read ReadFgPValue1 write WriteFgPValue1;
    property PfCourse1:double read ReadPfCourse1 write WritePfCourse1;
    property PfCrdVal1:double read ReadPfCrdVal1 write WritePfCrdVal1;
    property FgPayVal1:double read ReadFgPayVal1 write WriteFgPayVal1;
    property PyCourse1:double read ReadPyCourse1 write WritePyCourse1;
    property PyCrdVal1:double read ReadPyCrdVal1 write WritePyCrdVal1;
    property FgEndVal1:double read ReadFgEndVal1 write WriteFgEndVal1;
    property FgDvzName2:Str3 read ReadFgDvzName2 write WriteFgDvzName2;
    property FgBValue2:double read ReadFgBValue2 write WriteFgBValue2;
    property FgCourse2:double read ReadFgCourse2 write WriteFgCourse2;
    property FgPValue2:double read ReadFgPValue2 write WriteFgPValue2;
    property PfCourse2:double read ReadPfCourse2 write WritePfCourse2;
    property PfCrdVal2:double read ReadPfCrdVal2 write WritePfCrdVal2;
    property FgPayVal2:double read ReadFgPayVal2 write WriteFgPayVal2;
    property PyCourse2:double read ReadPyCourse2 write WritePyCourse2;
    property PyCrdVal2:double read ReadPyCrdVal2 write WritePyCrdVal2;
    property FgEndVal2:double read ReadFgEndVal2 write WriteFgEndVal2;
    property FgDvzName3:Str3 read ReadFgDvzName3 write WriteFgDvzName3;
    property FgBValue3:double read ReadFgBValue3 write WriteFgBValue3;
    property FgCourse3:double read ReadFgCourse3 write WriteFgCourse3;
    property FgPValue3:double read ReadFgPValue3 write WriteFgPValue3;
    property PfCourse3:double read ReadPfCourse3 write WritePfCourse3;
    property PfCrdVal3:double read ReadPfCrdVal3 write WritePfCrdVal3;
    property FgPayVal3:double read ReadFgPayVal3 write WriteFgPayVal3;
    property PyCourse3:double read ReadPyCourse3 write WritePyCourse3;
    property PyCrdVal3:double read ReadPyCrdVal3 write WritePyCrdVal3;
    property FgEndVal3:double read ReadFgEndVal3 write WriteFgEndVal3;
    property FgDvzName4:Str3 read ReadFgDvzName4 write WriteFgDvzName4;
    property FgBValue4:double read ReadFgBValue4 write WriteFgBValue4;
    property FgCourse4:double read ReadFgCourse4 write WriteFgCourse4;
    property FgPValue4:double read ReadFgPValue4 write WriteFgPValue4;
    property PfCourse4:double read ReadPfCourse4 write WritePfCourse4;
    property PfCrdVal4:double read ReadPfCrdVal4 write WritePfCrdVal4;
    property FgPayVal4:double read ReadFgPayVal4 write WriteFgPayVal4;
    property PyCourse4:double read ReadPyCourse4 write WritePyCourse4;
    property PyCrdVal4:double read ReadPyCrdVal4 write WritePyCrdVal4;
    property FgEndVal4:double read ReadFgEndVal4 write WriteFgEndVal4;
    property FgDvzName5:Str3 read ReadFgDvzName5 write WriteFgDvzName5;
    property FgBValue5:double read ReadFgBValue5 write WriteFgBValue5;
    property FgCourse5:double read ReadFgCourse5 write WriteFgCourse5;
    property FgPValue5:double read ReadFgPValue5 write WriteFgPValue5;
    property PfCourse5:double read ReadPfCourse5 write WritePfCourse5;
    property PfCrdVal5:double read ReadPfCrdVal5 write WritePfCrdVal5;
    property FgPayVal5:double read ReadFgPayVal5 write WriteFgPayVal5;
    property PyCourse5:double read ReadPyCourse5 write WritePyCourse5;
    property PyCrdVal5:double read ReadPyCrdVal5 write WritePyCrdVal5;
    property FgEndVal5:double read ReadFgEndVal5 write WriteFgEndVal5;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property VatDoc:byte read ReadVatDoc write WriteVatDoc;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property TicDay:word read ReadTicDay write WriteTicDay;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TOwhBtr.Create;
begin
  oBtrTable := BtrInit ('OWH',gPath.LdgPath,Self);
end;

constructor TOwhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OWH',pPath,Self);
end;

destructor TOwhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOwhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOwhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOwhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TOwhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TOwhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOwhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOwhBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TOwhBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TOwhBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TOwhBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TOwhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOwhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOwhBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TOwhBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TOwhBtr.ReadEpCode:longint;
begin
  Result := oBtrTable.FieldByName('EpCode').AsInteger;
end;

procedure TOwhBtr.WriteEpCode(pValue:longint);
begin
  oBtrTable.FieldByName('EpCode').AsInteger := pValue;
end;

function TOwhBtr.ReadEpName:Str30;
begin
  Result := oBtrTable.FieldByName('EpName').AsString;
end;

procedure TOwhBtr.WriteEpName(pValue:Str30);
begin
  oBtrTable.FieldByName('EpName').AsString := pValue;
end;

function TOwhBtr.ReadEpName_:Str30;
begin
  Result := oBtrTable.FieldByName('EpName_').AsString;
end;

procedure TOwhBtr.WriteEpName_(pValue:Str30);
begin
  oBtrTable.FieldByName('EpName_').AsString := pValue;
end;

function TOwhBtr.ReadStaName:Str30;
begin
  Result := oBtrTable.FieldByName('StaName').AsString;
end;

procedure TOwhBtr.WriteStaName(pValue:Str30);
begin
  oBtrTable.FieldByName('StaName').AsString := pValue;
end;

function TOwhBtr.ReadCtyName:Str30;
begin
  Result := oBtrTable.FieldByName('CtyName').AsString;
end;

procedure TOwhBtr.WriteCtyName(pValue:Str30);
begin
  oBtrTable.FieldByName('CtyName').AsString := pValue;
end;

function TOwhBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TOwhBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TOwhBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TOwhBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TOwhBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TOwhBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TOwhBtr.ReadAcDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('AcDvzName').AsString;
end;

procedure TOwhBtr.WriteAcDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('AcDvzName').AsString := pValue;
end;

function TOwhBtr.ReadAcBValue1:double;
begin
  Result := oBtrTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TOwhBtr.WriteAcBValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue1').AsFloat := pValue;
end;

function TOwhBtr.ReadAcBValue2:double;
begin
  Result := oBtrTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TOwhBtr.WriteAcBValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue2').AsFloat := pValue;
end;

function TOwhBtr.ReadAcBValue3:double;
begin
  Result := oBtrTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TOwhBtr.WriteAcBValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue3').AsFloat := pValue;
end;

function TOwhBtr.ReadAcVatVal1:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal1').AsFloat;
end;

procedure TOwhBtr.WriteAcVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal1').AsFloat := pValue;
end;

function TOwhBtr.ReadAcVatVal2:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal2').AsFloat;
end;

procedure TOwhBtr.WriteAcVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal2').AsFloat := pValue;
end;

function TOwhBtr.ReadAcVatVal3:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal3').AsFloat;
end;

procedure TOwhBtr.WriteAcVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal3').AsFloat := pValue;
end;

function TOwhBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOwhBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOwhBtr.ReadAcPValue:double;
begin
  Result := oBtrTable.FieldByName('AcPValue').AsFloat;
end;

procedure TOwhBtr.WriteAcPValue(pValue:double);
begin
  oBtrTable.FieldByName('AcPValue').AsFloat := pValue;
end;

function TOwhBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TOwhBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TOwhBtr.ReadAcPayVal:double;
begin
  Result := oBtrTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TOwhBtr.WriteAcPayVal(pValue:double);
begin
  oBtrTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TOwhBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TOwhBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TOwhBtr.ReadFgDvzName1:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName1').AsString;
end;

procedure TOwhBtr.WriteFgDvzName1(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName1').AsString := pValue;
end;

function TOwhBtr.ReadFgBValue1:double;
begin
  Result := oBtrTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TOwhBtr.WriteFgBValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue1').AsFloat := pValue;
end;

function TOwhBtr.ReadFgCourse1:double;
begin
  Result := oBtrTable.FieldByName('FgCourse1').AsFloat;
end;

procedure TOwhBtr.WriteFgCourse1(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse1').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPValue1:double;
begin
  Result := oBtrTable.FieldByName('FgPValue1').AsFloat;
end;

procedure TOwhBtr.WriteFgPValue1(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue1').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCourse1:double;
begin
  Result := oBtrTable.FieldByName('PfCourse1').AsFloat;
end;

procedure TOwhBtr.WritePfCourse1(pValue:double);
begin
  oBtrTable.FieldByName('PfCourse1').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCrdVal1:double;
begin
  Result := oBtrTable.FieldByName('PfCrdVal1').AsFloat;
end;

procedure TOwhBtr.WritePfCrdVal1(pValue:double);
begin
  oBtrTable.FieldByName('PfCrdVal1').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPayVal1:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal1').AsFloat;
end;

procedure TOwhBtr.WriteFgPayVal1(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal1').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCourse1:double;
begin
  Result := oBtrTable.FieldByName('PyCourse1').AsFloat;
end;

procedure TOwhBtr.WritePyCourse1(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse1').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCrdVal1:double;
begin
  Result := oBtrTable.FieldByName('PyCrdVal1').AsFloat;
end;

procedure TOwhBtr.WritePyCrdVal1(pValue:double);
begin
  oBtrTable.FieldByName('PyCrdVal1').AsFloat := pValue;
end;

function TOwhBtr.ReadFgEndVal1:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal1').AsFloat;
end;

procedure TOwhBtr.WriteFgEndVal1(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal1').AsFloat := pValue;
end;

function TOwhBtr.ReadFgDvzName2:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName2').AsString;
end;

procedure TOwhBtr.WriteFgDvzName2(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName2').AsString := pValue;
end;

function TOwhBtr.ReadFgBValue2:double;
begin
  Result := oBtrTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TOwhBtr.WriteFgBValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue2').AsFloat := pValue;
end;

function TOwhBtr.ReadFgCourse2:double;
begin
  Result := oBtrTable.FieldByName('FgCourse2').AsFloat;
end;

procedure TOwhBtr.WriteFgCourse2(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse2').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPValue2:double;
begin
  Result := oBtrTable.FieldByName('FgPValue2').AsFloat;
end;

procedure TOwhBtr.WriteFgPValue2(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue2').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCourse2:double;
begin
  Result := oBtrTable.FieldByName('PfCourse2').AsFloat;
end;

procedure TOwhBtr.WritePfCourse2(pValue:double);
begin
  oBtrTable.FieldByName('PfCourse2').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCrdVal2:double;
begin
  Result := oBtrTable.FieldByName('PfCrdVal2').AsFloat;
end;

procedure TOwhBtr.WritePfCrdVal2(pValue:double);
begin
  oBtrTable.FieldByName('PfCrdVal2').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPayVal2:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal2').AsFloat;
end;

procedure TOwhBtr.WriteFgPayVal2(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal2').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCourse2:double;
begin
  Result := oBtrTable.FieldByName('PyCourse2').AsFloat;
end;

procedure TOwhBtr.WritePyCourse2(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse2').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCrdVal2:double;
begin
  Result := oBtrTable.FieldByName('PyCrdVal2').AsFloat;
end;

procedure TOwhBtr.WritePyCrdVal2(pValue:double);
begin
  oBtrTable.FieldByName('PyCrdVal2').AsFloat := pValue;
end;

function TOwhBtr.ReadFgEndVal2:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal2').AsFloat;
end;

procedure TOwhBtr.WriteFgEndVal2(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal2').AsFloat := pValue;
end;

function TOwhBtr.ReadFgDvzName3:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName3').AsString;
end;

procedure TOwhBtr.WriteFgDvzName3(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName3').AsString := pValue;
end;

function TOwhBtr.ReadFgBValue3:double;
begin
  Result := oBtrTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TOwhBtr.WriteFgBValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue3').AsFloat := pValue;
end;

function TOwhBtr.ReadFgCourse3:double;
begin
  Result := oBtrTable.FieldByName('FgCourse3').AsFloat;
end;

procedure TOwhBtr.WriteFgCourse3(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse3').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPValue3:double;
begin
  Result := oBtrTable.FieldByName('FgPValue3').AsFloat;
end;

procedure TOwhBtr.WriteFgPValue3(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue3').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCourse3:double;
begin
  Result := oBtrTable.FieldByName('PfCourse3').AsFloat;
end;

procedure TOwhBtr.WritePfCourse3(pValue:double);
begin
  oBtrTable.FieldByName('PfCourse3').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCrdVal3:double;
begin
  Result := oBtrTable.FieldByName('PfCrdVal3').AsFloat;
end;

procedure TOwhBtr.WritePfCrdVal3(pValue:double);
begin
  oBtrTable.FieldByName('PfCrdVal3').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPayVal3:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal3').AsFloat;
end;

procedure TOwhBtr.WriteFgPayVal3(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal3').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCourse3:double;
begin
  Result := oBtrTable.FieldByName('PyCourse3').AsFloat;
end;

procedure TOwhBtr.WritePyCourse3(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse3').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCrdVal3:double;
begin
  Result := oBtrTable.FieldByName('PyCrdVal3').AsFloat;
end;

procedure TOwhBtr.WritePyCrdVal3(pValue:double);
begin
  oBtrTable.FieldByName('PyCrdVal3').AsFloat := pValue;
end;

function TOwhBtr.ReadFgEndVal3:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal3').AsFloat;
end;

procedure TOwhBtr.WriteFgEndVal3(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal3').AsFloat := pValue;
end;

function TOwhBtr.ReadFgDvzName4:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName4').AsString;
end;

procedure TOwhBtr.WriteFgDvzName4(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName4').AsString := pValue;
end;

function TOwhBtr.ReadFgBValue4:double;
begin
  Result := oBtrTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TOwhBtr.WriteFgBValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue4').AsFloat := pValue;
end;

function TOwhBtr.ReadFgCourse4:double;
begin
  Result := oBtrTable.FieldByName('FgCourse4').AsFloat;
end;

procedure TOwhBtr.WriteFgCourse4(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse4').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPValue4:double;
begin
  Result := oBtrTable.FieldByName('FgPValue4').AsFloat;
end;

procedure TOwhBtr.WriteFgPValue4(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue4').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCourse4:double;
begin
  Result := oBtrTable.FieldByName('PfCourse4').AsFloat;
end;

procedure TOwhBtr.WritePfCourse4(pValue:double);
begin
  oBtrTable.FieldByName('PfCourse4').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCrdVal4:double;
begin
  Result := oBtrTable.FieldByName('PfCrdVal4').AsFloat;
end;

procedure TOwhBtr.WritePfCrdVal4(pValue:double);
begin
  oBtrTable.FieldByName('PfCrdVal4').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPayVal4:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal4').AsFloat;
end;

procedure TOwhBtr.WriteFgPayVal4(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal4').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCourse4:double;
begin
  Result := oBtrTable.FieldByName('PyCourse4').AsFloat;
end;

procedure TOwhBtr.WritePyCourse4(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse4').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCrdVal4:double;
begin
  Result := oBtrTable.FieldByName('PyCrdVal4').AsFloat;
end;

procedure TOwhBtr.WritePyCrdVal4(pValue:double);
begin
  oBtrTable.FieldByName('PyCrdVal4').AsFloat := pValue;
end;

function TOwhBtr.ReadFgEndVal4:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal4').AsFloat;
end;

procedure TOwhBtr.WriteFgEndVal4(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal4').AsFloat := pValue;
end;

function TOwhBtr.ReadFgDvzName5:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName5').AsString;
end;

procedure TOwhBtr.WriteFgDvzName5(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName5').AsString := pValue;
end;

function TOwhBtr.ReadFgBValue5:double;
begin
  Result := oBtrTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TOwhBtr.WriteFgBValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue5').AsFloat := pValue;
end;

function TOwhBtr.ReadFgCourse5:double;
begin
  Result := oBtrTable.FieldByName('FgCourse5').AsFloat;
end;

procedure TOwhBtr.WriteFgCourse5(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse5').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPValue5:double;
begin
  Result := oBtrTable.FieldByName('FgPValue5').AsFloat;
end;

procedure TOwhBtr.WriteFgPValue5(pValue:double);
begin
  oBtrTable.FieldByName('FgPValue5').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCourse5:double;
begin
  Result := oBtrTable.FieldByName('PfCourse5').AsFloat;
end;

procedure TOwhBtr.WritePfCourse5(pValue:double);
begin
  oBtrTable.FieldByName('PfCourse5').AsFloat := pValue;
end;

function TOwhBtr.ReadPfCrdVal5:double;
begin
  Result := oBtrTable.FieldByName('PfCrdVal5').AsFloat;
end;

procedure TOwhBtr.WritePfCrdVal5(pValue:double);
begin
  oBtrTable.FieldByName('PfCrdVal5').AsFloat := pValue;
end;

function TOwhBtr.ReadFgPayVal5:double;
begin
  Result := oBtrTable.FieldByName('FgPayVal5').AsFloat;
end;

procedure TOwhBtr.WriteFgPayVal5(pValue:double);
begin
  oBtrTable.FieldByName('FgPayVal5').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCourse5:double;
begin
  Result := oBtrTable.FieldByName('PyCourse5').AsFloat;
end;

procedure TOwhBtr.WritePyCourse5(pValue:double);
begin
  oBtrTable.FieldByName('PyCourse5').AsFloat := pValue;
end;

function TOwhBtr.ReadPyCrdVal5:double;
begin
  Result := oBtrTable.FieldByName('PyCrdVal5').AsFloat;
end;

procedure TOwhBtr.WritePyCrdVal5(pValue:double);
begin
  oBtrTable.FieldByName('PyCrdVal5').AsFloat := pValue;
end;

function TOwhBtr.ReadFgEndVal5:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal5').AsFloat;
end;

procedure TOwhBtr.WriteFgEndVal5(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal5').AsFloat := pValue;
end;

function TOwhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TOwhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TOwhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOwhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOwhBtr.ReadVatDoc:byte;
begin
  Result := oBtrTable.FieldByName('VatDoc').AsInteger;
end;

procedure TOwhBtr.WriteVatDoc(pValue:byte);
begin
  oBtrTable.FieldByName('VatDoc').AsInteger := pValue;
end;

function TOwhBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TOwhBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TOwhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TOwhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TOwhBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TOwhBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TOwhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TOwhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOwhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOwhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOwhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOwhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOwhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOwhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOwhBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TOwhBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOwhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOwhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOwhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOwhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOwhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOwhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOwhBtr.ReadTicDay:word;
begin
  Result := oBtrTable.FieldByName('TicDay').AsInteger;
end;

procedure TOwhBtr.WriteTicDay(pValue:word);
begin
  oBtrTable.FieldByName('TicDay').AsInteger := pValue;
end;

function TOwhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TOwhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOwhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOwhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOwhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOwhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOwhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOwhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOwhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TOwhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOwhBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TOwhBtr.LocateBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindKey([pBegDate]);
end;

function TOwhBtr.LocateEpName (pEpName_:Str30):boolean;
begin
  SetIndex (ixEpName);
  Result := oBtrTable.FindKey([StrToAlias(pEpName_)]);
end;

function TOwhBtr.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindKey([pAcBValue]);
end;

function TOwhBtr.LocateAcPayVal (pAcPayVal:double):boolean;
begin
  SetIndex (ixAcPayVal);
  Result := oBtrTable.FindKey([pAcPayVal]);
end;

function TOwhBtr.LocateAcEndVal (pAcEndVal:double):boolean;
begin
  SetIndex (ixAcEndVal);
  Result := oBtrTable.FindKey([pAcEndVal]);
end;

function TOwhBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TOwhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TOwhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOwhBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TOwhBtr.NearestBegDate (pBegDate:TDatetime):boolean;
begin
  SetIndex (ixBegDate);
  Result := oBtrTable.FindNearest([pBegDate]);
end;

function TOwhBtr.NearestEpName (pEpName_:Str30):boolean;
begin
  SetIndex (ixEpName);
  Result := oBtrTable.FindNearest([pEpName_]);
end;

function TOwhBtr.NearestAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oBtrTable.FindNearest([pAcBValue]);
end;

function TOwhBtr.NearestAcPayVal (pAcPayVal:double):boolean;
begin
  SetIndex (ixAcPayVal);
  Result := oBtrTable.FindNearest([pAcPayVal]);
end;

function TOwhBtr.NearestAcEndVal (pAcEndVal:double):boolean;
begin
  SetIndex (ixAcEndVal);
  Result := oBtrTable.FindNearest([pAcEndVal]);
end;

function TOwhBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

procedure TOwhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOwhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOwhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOwhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOwhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOwhBtr.First;
begin
  oBtrTable.First;
end;

procedure TOwhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOwhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOwhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOwhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOwhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOwhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOwhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOwhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOwhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOwhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOwhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
