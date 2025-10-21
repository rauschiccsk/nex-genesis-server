unit bTOA;

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

type
  TTOABtr = class (TComponent)
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

constructor TTOABtr.Create;
begin
  oBtrTable := BtrInit ('TOA',gPath.StkPath,Self);
end;

constructor TTOABtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TOA',pPath,Self);
end;

destructor TTOABtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTOABtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTOABtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTOABtr.ReadTrmNum:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TTOABtr.WriteTrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TTOABtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTOABtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTOABtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTOABtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTOABtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTOABtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTOABtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTOABtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTOABtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTOABtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTOABtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTOABtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTOABtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TTOABtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TTOABtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTOABtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTOABtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TTOABtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TTOABtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TTOABtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TTOABtr.ReadCusCard:Str20;
begin
  Result := oBtrTable.FieldByName('CusCard').AsString;
end;

procedure TTOABtr.WriteCusCard(pValue:Str20);
begin
  oBtrTable.FieldByName('CusCard').AsString := pValue;
end;

function TTOABtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTOABtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTOABtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TTOABtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TTOABtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TTOABtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TTOABtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TTOABtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TTOABtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TTOABtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TTOABtr.ReadPayVal0:double;
begin
  Result := oBtrTable.FieldByName('PayVal0').AsFloat;
end;

procedure TTOABtr.WritePayVal0(pValue:double);
begin
  oBtrTable.FieldByName('PayVal0').AsFloat := pValue;
end;

function TTOABtr.ReadPayVal1:double;
begin
  Result := oBtrTable.FieldByName('PayVal1').AsFloat;
end;

procedure TTOABtr.WritePayVal1(pValue:double);
begin
  oBtrTable.FieldByName('PayVal1').AsFloat := pValue;
end;

function TTOABtr.ReadPayVal2:double;
begin
  Result := oBtrTable.FieldByName('PayVal2').AsFloat;
end;

procedure TTOABtr.WritePayVal2(pValue:double);
begin
  oBtrTable.FieldByName('PayVal2').AsFloat := pValue;
end;

function TTOABtr.ReadPayVal3:double;
begin
  Result := oBtrTable.FieldByName('PayVal3').AsFloat;
end;

procedure TTOABtr.WritePayVal3(pValue:double);
begin
  oBtrTable.FieldByName('PayVal3').AsFloat := pValue;
end;

function TTOABtr.ReadCasNum:byte;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TTOABtr.WriteCasNum(pValue:byte);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TTOABtr.ReadCadNum:Str12;
begin
  Result := oBtrTable.FieldByName('CadNum').AsString;
end;

procedure TTOABtr.WriteCadNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CadNum').AsString := pValue;
end;

function TTOABtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTOABtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTOABtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTOABtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTOABtr.ReadCsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('CsdNum').AsString;
end;

procedure TTOABtr.WriteCsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CsdNum').AsString := pValue;
end;

function TTOABtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TTOABtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TTOABtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTOABtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTOABtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TTOABtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TTOABtr.ReadEpdUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpdUsrc').AsString;
end;

procedure TTOABtr.WriteEpdUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpdUsrc').AsString := pValue;
end;

function TTOABtr.ReadEpaUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpaUsrc').AsString;
end;

procedure TTOABtr.WriteEpaUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpaUsrc').AsString := pValue;
end;

function TTOABtr.ReadEptUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EptUsrc').AsString;
end;

procedure TTOABtr.WriteEptUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EptUsrc').AsString := pValue;
end;

function TTOABtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TTOABtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TTOABtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTOABtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTOABtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTOABtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTOABtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTOABtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTOABtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTOABtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTOABtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTOABtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTOABtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTOABtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTOABtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTOABtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTOABtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTOABtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTOABtr.ReadTopCnt:word;
begin
  Result := oBtrTable.FieldByName('TopCnt').AsInteger;
end;

procedure TTOABtr.WriteTopCnt(pValue:word);
begin
  oBtrTable.FieldByName('TopCnt').AsInteger := pValue;
end;

function TTOABtr.ReadOutCnt:word;
begin
  Result := oBtrTable.FieldByName('OutCnt').AsInteger;
end;

procedure TTOABtr.WriteOutCnt(pValue:word);
begin
  oBtrTable.FieldByName('OutCnt').AsInteger := pValue;
end;

function TTOABtr.ReadNcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('NcdNum').AsString;
end;

procedure TTOABtr.WriteNcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('NcdNum').AsString := pValue;
end;

function TTOABtr.ReadIntNum:longint;
begin
  Result := oBtrTable.FieldByName('IntNum').AsInteger;
end;

procedure TTOABtr.WriteIntNum(pValue:longint);
begin
  oBtrTable.FieldByName('IntNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTOABtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTOABtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTOABtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTOABtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTOABtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTOABtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTOABtr.LocateIntNum (pIntNum:longint):boolean;
begin
  SetIndex (ixIntNum);
  Result := oBtrTable.FindKey([pIntNum]);
end;

function TTOABtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TTOABtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTOABtr.LocateTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindKey([pTrmNum,pSerNum]);
end;

function TTOABtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTOABtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTOABtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TTOABtr.LocateCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindKey([pCusCard]);
end;

function TTOABtr.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindKey([pBValue]);
end;

function TTOABtr.LocateCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindKey([pCadNum]);
end;

function TTOABtr.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindKey([pTcdNum]);
end;

function TTOABtr.LocateIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindKey([pIcdNum]);
end;

function TTOABtr.LocateNcdNum (pNcdNum:Str12):boolean;
begin
  SetIndex (ixNcdNum);
  Result := oBtrTable.FindKey([pNcdNum]);
end;

function TTOABtr.LocateSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindKey([pSndStat]);
end;

function TTOABtr.NearestIntNum (pIntNum:longint):boolean;
begin
  SetIndex (ixIntNum);
  Result := oBtrTable.FindNearest([pIntNum]);
end;

function TTOABtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TTOABtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTOABtr.NearestTnSn (pTrmNum:byte;pSerNum:longint):boolean;
begin
  SetIndex (ixTnSn);
  Result := oBtrTable.FindNearest([pTrmNum,pSerNum]);
end;

function TTOABtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTOABtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTOABtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TTOABtr.NearestCusCard (pCusCard:Str20):boolean;
begin
  SetIndex (ixCusCard);
  Result := oBtrTable.FindNearest([pCusCard]);
end;

function TTOABtr.NearestBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oBtrTable.FindNearest([pBValue]);
end;

function TTOABtr.NearestCadNum (pCadNum:Str12):boolean;
begin
  SetIndex (ixCadNum);
  Result := oBtrTable.FindNearest([pCadNum]);
end;

function TTOABtr.NearestTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindNearest([pTcdNum]);
end;

function TTOABtr.NearestIcdNum (pIcdNum:Str12):boolean;
begin
  SetIndex (ixIcdNum);
  Result := oBtrTable.FindNearest([pIcdNum]);
end;

function TTOABtr.NearestNcdNum (pNcdNum:Str12):boolean;
begin
  SetIndex (ixNcdNum);
  Result := oBtrTable.FindNearest([pNcdNum]);
end;

function TTOABtr.NearestSndStat (pSndStat:Str1):boolean;
begin
  SetIndex (ixSndStat);
  Result := oBtrTable.FindNearest([pSndStat]);
end;

procedure TTOABtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTOABtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTOABtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTOABtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTOABtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTOABtr.First;
begin
  oBtrTable.First;
end;

procedure TTOABtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTOABtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTOABtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTOABtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTOABtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTOABtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTOABtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTOABtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTOABtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTOABtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTOABtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
