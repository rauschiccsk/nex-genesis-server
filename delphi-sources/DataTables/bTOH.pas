unit bTOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIntNum = 'IntNum';
  ixSerNum = 'SerNum';
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
  ixNcdNum = 'NcdNum';
  ixSndStat = 'SndStat';
  ixPcSt = 'PcSt';

type
  TTohBtr = class (TComponent)
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
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadEpdUsrc:Str10;         procedure WriteEpdUsrc (pValue:Str10);
    function  ReadEpaUsrc:Str10;         procedure WriteEpaUsrc (pValue:Str10);
    function  ReadEptUsrc:Str10;         procedure WriteEptUsrc (pValue:Str10);
    function  ReadEpsUsrc:Str10;         procedure WriteEpsUsrc (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadTopCnt:word;           procedure WriteTopCnt (pValue:word);
    function  ReadOutCnt:word;           procedure WriteOutCnt (pValue:word);
    function  ReadNcdNum:Str12;          procedure WriteNcdNum (pValue:Str12);
    function  ReadIntNum:longint;        procedure WriteIntNum (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateIntNum (pIntNum:longint):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
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
    function LocateNcdNum (pNcdNum:Str12):boolean;
    function LocateSndStat (pSndStat:Str1):boolean;
    function LocatePcSt (pPaCode:longint;pStatus:Str1):boolean;
    function NearestIntNum (pIntNum:longint):boolean;
    function NearestSerNum (pSerNum:longint):boolean;
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
    function NearestNcdNum (pNcdNum:Str12):boolean;
    function NearestSndStat (pSndStat:Str1):boolean;
    function NearestPcSt (pPaCode:longint;pStatus:Str1):boolean;

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
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property EpdUsrc:Str10 read ReadEpdUsrc write WriteEpdUsrc;
    property EpaUsrc:Str10 read ReadEpaUsrc write WriteEpaUsrc;
    property EptUsrc:Str10 read ReadEptUsrc write WriteEptUsrc;
    property EpsUsrc:Str10 read ReadEpsUsrc write WriteEpsUsrc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Status:Str1 read ReadStatus write WriteStatus;
    property TopCnt:word read ReadTopCnt write WriteTopCnt;
    property OutCnt:word read ReadOutCnt write WriteOutCnt;
    property NcdNum:Str12 read ReadNcdNum write WriteNcdNum;
    property IntNum:longint read ReadIntNum write WriteIntNum;
  end;

implementation

constructor TTohBtr.Create;
begin
  oBtrTable := BtrInit ('TOH',gPath.StkPath,Self);
end;

constructor TTohBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TOH',pPath,Self);
end;

destructor TTohBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTohBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTohBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTohBtr.ReadTrmNum:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TTohBtr.WriteTrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TTohBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTohBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTohBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTohBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTohBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTohBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTohBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTohBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTohBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTohBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTohBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTohBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTohBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TTohBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TTohBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTohBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTohBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TTohBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TTohBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TTohBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TTohBtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TTohBtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TTohBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTohBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTohBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TTohBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TTohBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TTohBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TTohBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TTohBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TTohBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TTohBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TTohBtr.ReadPayVal0:double;
begin
  Result := oBtrTable.FieldByName('PayVal0').AsFloat;
end;

procedure TTohBtr.WritePayVal0(pValue:double);
begin
  oBtrTable.FieldByName('PayVal0').AsFloat := pValue;
end;

function TTohBtr.ReadPayVal1:double;
begin
  Result := oBtrTable.FieldByName('PayVal1').AsFloat;
end;

procedure TTohBtr.WritePayVal1(pValue:double);
begin
  oBtrTable.FieldByName('PayVal1').AsFloat := pValue;
end;

function TTohBtr.ReadPayVal2:double;
begin
  Result := oBtrTable.FieldByName('PayVal2').AsFloat;
end;

procedure TTohBtr.WritePayVal2(pValue:double);
begin
  oBtrTable.FieldByName('PayVal2').AsFloat := pValue;
end;

function TTohBtr.ReadPayVal3:double;
begin
  Result := oBtrTable.FieldByName('PayVal3').AsFloat;
end;

procedure TTohBtr.WritePayVal3(pValue:double);
begin
  oBtrTable.FieldByName('PayVal3').AsFloat := pValue;
end;

function TTohBtr.ReadCasNum:byte;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TTohBtr.WriteCasNum(pValue:byte);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TTohBtr.ReadCadNum:Str12;
begin
  Result := oBtrTable.FieldByName('CadNum').AsString;
end;

procedure TTohBtr.WriteCadNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CadNum').AsString := pValue;
end;

function TTohBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTohBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTohBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTohBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTohBtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TTohBtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TTohBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTohBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTohBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTohBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTohBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TTohBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TTohBtr.ReadEpdUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpdUsrc').AsString;
end;

procedure TTohBtr.WriteEpdUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpdUsrc').AsString := pValue;
end;

function TTohBtr.ReadEpaUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpaUsrc').AsString;
end;

procedure TTohBtr.WriteEpaUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpaUsrc').AsString := pValue;
end;

function TTohBtr.ReadEptUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EptUsrc').AsString;
end;

procedure TTohBtr.WriteEptUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EptUsrc').AsString := pValue;
end;

function TTohBtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TTohBtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TTohBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTohBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTohBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTohBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTohBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTohBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTohBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTohBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTohBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTohBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTohBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTohBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTohBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTohBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTohBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTohBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTohBtr.ReadTopCnt:word;
begin
  Result := oBtrTable.FieldByName('TopCnt').AsInteger;
end;

procedure TTohBtr.WriteTopCnt(pValue:word);
begin
  oBtrTable.FieldByName('TopCnt').AsInteger := pValue;
end;

function TTohBtr.ReadOutCnt:word;
begin
  Result := oBtrTable.FieldByName('OutCnt').AsInteger;
end;

procedure TTohBtr.WriteOutCnt(pValue:word);
begin
  oBtrTable.FieldByName('OutCnt').AsInteger := pValue;
end;

function TTohBtr.ReadNcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('NcdNum').AsString;
end;

procedure TTohBtr.WriteNcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('NcdNum').AsString := pValue;
end;

function TTohBtr.ReadIntNum:longint;
begin
  Result := oBtrTable.FieldByName('IntNum').AsInteger;
end;

procedure TTohBtr.WriteIntNum(pValue:longint);
begin
  oBtrTable.FieldByName('IntNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTohBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTohBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTohBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTohBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTohBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTohBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTohBtr.LocateIntNum (pIntNum:longint):boolean;
begin
  SetIndex (ixIntNum);
  Result := oBtrTable.FindKey([pIntNum]);
end;

function TTohBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TTohBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTohBtr.LocateTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindKey([pTrmNum,pSerNum]);
end;

function TTohBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTohBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTohBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TTohBtr.LocateCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindKey([pCusCard]);
end;

function TTohBtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TTohBtr.LocateCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindKey([pCadNum]);
end;

function TTohBtr.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindKey([pTcdNum]);
end;

function TTohBtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TTohBtr.LocateNcdNum (pNcdNum:Str12):boolean;
begin
  SetIndex (ixNcdNum);
  Result := oBtrTable.FindKey([pNcdNum]);
end;

function TTohBtr.LocateSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindKey([pSndStat]);
end;

function TTohBtr.LocatePcSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPcSt);
  Result := oBtrTable.FindKey([pPaCode,pStatus]);
end;

function TTohBtr.NearestIntNum (pIntNum:longint):boolean;
begin
  SetIndex (ixIntNum);
  Result := oBtrTable.FindNearest([pIntNum]);
end;

function TTohBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TTohBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTohBtr.NearestTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindNearest([pTrmNum,pSerNum]);
end;

function TTohBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTohBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTohBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TTohBtr.NearestCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindNearest([pCusCard]);
end;

function TTohBtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TTohBtr.NearestCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindNearest([pCadNum]);
end;

function TTohBtr.NearestTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindNearest([pTcdNum]);
end;

function TTohBtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

function TTohBtr.NearestNcdNum (pNcdNum:Str12):boolean;
begin
  SetIndex (ixNcdNum);
  Result := oBtrTable.FindNearest([pNcdNum]);
end;

function TTohBtr.NearestSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindNearest([pSndStat]);
end;

function TTohBtr.NearestPcSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPcSt);
  Result := oBtrTable.FindNearest([pPaCode,pStatus]);
end;

procedure TTohBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTohBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTohBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTohBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTohBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTohBtr.First;
begin
  oBtrTable.First;
end;

procedure TTohBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTohBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTohBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTohBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTohBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTohBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTohBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTohBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTohBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTohBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTohBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
