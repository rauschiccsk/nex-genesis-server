unit bPOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixTnSn = 'TnSn';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixCusCard = 'CusCard';
  ixBValue = 'BValue';
  ixCadNum = 'CadNum';
  ixTcdNum = 'TcdNum';
  ixIcdNum = 'IcdNum';

type
  TPohBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTrmNum:byte;           procedure WriteTrmNum (pValue:byte);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadAplNum:word;           procedure WriteAplNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadCusCard:Str20;         procedure WriteCusCard (pValue:Str20);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDdsVal:double;         procedure WriteDdsVal (pValue:double);
    function  ReadHdsVal:double;         procedure WriteHdsVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadPayVal0:double;        procedure WritePayVal0 (pValue:double);
    function  ReadPayVal1:double;        procedure WritePayVal1 (pValue:double);
    function  ReadPayVal2:double;        procedure WritePayVal2 (pValue:double);
    function  ReadPayVal3:double;        procedure WritePayVal3 (pValue:double);
    function  ReadCasNum:byte;           procedure WriteCasNum (pValue:byte);
    function  ReadCadNum:Str12;          procedure WriteCadNum (pValue:Str12);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadCsdNum:Str12;          procedure WriteCsdNum (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadTopCnt:word;           procedure WriteTopCnt (pValue:word);
    function  ReadOutCnt:word;           procedure WriteOutCnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
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
    function LocateTnSn (pTrmNum:byte;pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateCusCard (pCusCard:Str20):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateCadNum (pCadNum:Str12):boolean;
    function LocateTcdNum (pTcdNum:Str12):boolean;
    function LocateIcdNum (pIcdNum:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestTnSn (pTrmNum:byte;pSerNum:longint):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestCusCard (pCusCard:Str20):boolean;
    function NearestBValue (pBValue:double):boolean;
    function NearestCadNum (pCadNum:Str12):boolean;
    function NearestTcdNum (pTcdNum:Str12):boolean;
    function NearestIcdNum (pIcdNum:Str12):boolean;

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
    property TrmNum:byte read ReadTrmNum write WriteTrmNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property AplNum:word read ReadAplNum write WriteAplNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property CusCard:Str20 read ReadCusCard write WriteCusCard;
    property CValue:double read ReadCValue write WriteCValue;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DdsVal:double read ReadDdsVal write WriteDdsVal;
    property HdsVal:double read ReadHdsVal write WriteHdsVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property PayVal0:double read ReadPayVal0 write WritePayVal0;
    property PayVal1:double read ReadPayVal1 write WritePayVal1;
    property PayVal2:double read ReadPayVal2 write WritePayVal2;
    property PayVal3:double read ReadPayVal3 write WritePayVal3;
    property CasNum:byte read ReadCasNum write WriteCasNum;
    property CadNum:Str12 read ReadCadNum write WriteCadNum;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property CsdNum:Str12 read ReadCsdNum write WriteCsdNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property TopCnt:word read ReadTopCnt write WriteTopCnt;
    property OutCnt:word read ReadOutCnt write WriteOutCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TPohBtr.Create;
begin
  oBtrTable := BtrInit ('POH',gPath.StkPath,Self);
end;

constructor TPohBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('POH',pPath,Self);
end;

destructor TPohBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPohBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPohBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPohBtr.ReadTrmNum:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TPohBtr.WriteTrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TPohBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPohBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPohBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPohBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPohBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPohBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPohBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TPohBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TPohBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPohBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPohBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TPohBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TPohBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TPohBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TPohBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPohBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPohBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TPohBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TPohBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TPohBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TPohBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TPohBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TPohBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TPohBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TPohBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TPohBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TPohBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TPohBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TPohBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPohBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPohBtr.ReadDdsVal:double;
begin
  Result := oBtrTable.FieldByName('DdsVal').AsFloat;
end;

procedure TPohBtr.WriteDdsVal(pValue:double);
begin
  oBtrTable.FieldByName('DdsVal').AsFloat := pValue;
end;

function TPohBtr.ReadHdsVal:double;
begin
  Result := oBtrTable.FieldByName('HdsVal').AsFloat;
end;

procedure TPohBtr.WriteHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('HdsVal').AsFloat := pValue;
end;

function TPohBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TPohBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TPohBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TPohBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TPohBtr.ReadPayVal0:double;
begin
  Result := oBtrTable.FieldByName('PayVal0').AsFloat;
end;

procedure TPohBtr.WritePayVal0(pValue:double);
begin
  oBtrTable.FieldByName('PayVal0').AsFloat := pValue;
end;

function TPohBtr.ReadPayVal1:double;
begin
  Result := oBtrTable.FieldByName('PayVal1').AsFloat;
end;

procedure TPohBtr.WritePayVal1(pValue:double);
begin
  oBtrTable.FieldByName('PayVal1').AsFloat := pValue;
end;

function TPohBtr.ReadPayVal2:double;
begin
  Result := oBtrTable.FieldByName('PayVal2').AsFloat;
end;

procedure TPohBtr.WritePayVal2(pValue:double);
begin
  oBtrTable.FieldByName('PayVal2').AsFloat := pValue;
end;

function TPohBtr.ReadPayVal3:double;
begin
  Result := oBtrTable.FieldByName('PayVal3').AsFloat;
end;

procedure TPohBtr.WritePayVal3(pValue:double);
begin
  oBtrTable.FieldByName('PayVal3').AsFloat := pValue;
end;

function TPohBtr.ReadCasNum:byte;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TPohBtr.WriteCasNum(pValue:byte);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TPohBtr.ReadCadNum:Str12;
begin
  Result := oBtrTable.FieldByName('CadNum').AsString;
end;

procedure TPohBtr.WriteCadNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CadNum').AsString := pValue;
end;

function TPohBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TPohBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TPohBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TPohBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TPohBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TPohBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TPohBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TPohBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPohBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPohBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPohBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TPohBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TPohBtr.ReadTopCnt:word;
begin
  Result := oBtrTable.FieldByName('TopCnt').AsInteger;
end;

procedure TPohBtr.WriteTopCnt(pValue:word);
begin
  oBtrTable.FieldByName('TopCnt').AsInteger := pValue;
end;

function TPohBtr.ReadOutCnt:word;
begin
  Result := oBtrTable.FieldByName('OutCnt').AsInteger;
end;

procedure TPohBtr.WriteOutCnt(pValue:word);
begin
  oBtrTable.FieldByName('OutCnt').AsInteger := pValue;
end;

function TPohBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TPohBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TPohBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPohBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPohBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPohBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPohBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPohBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPohBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPohBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPohBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPohBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPohBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPohBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPohBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TPohBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPohBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPohBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPohBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPohBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPohBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPohBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPohBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TPohBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPohBtr.LocateTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindKey([pTrmNum,pSerNum]);
end;

function TPohBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TPohBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPohBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TPohBtr.LocateCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindKey([pCusCard]);
end;

function TPohBtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TPohBtr.LocateCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindKey([pCadNum]);
end;

function TPohBtr.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindKey([pTcdNum]);
end;

function TPohBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TPohBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TPohBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPohBtr.NearestTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindNearest([pTrmNum,pSerNum]);
end;

function TPohBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TPohBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TPohBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TPohBtr.NearestCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindNearest([pCusCard]);
end;

function TPohBtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TPohBtr.NearestCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindNearest([pCadNum]);
end;

function TPohBtr.NearestTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindNearest([pTcdNum]);
end;

function TPohBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

procedure TPohBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPohBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPohBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPohBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPohBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPohBtr.First;
begin
  oBtrTable.First;
end;

procedure TPohBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPohBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPohBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPohBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPohBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPohBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPohBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPohBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPohBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPohBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPohBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
