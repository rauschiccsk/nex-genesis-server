unit bCMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixSmCode = 'SmCode';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixCValue = 'CValue';
  ixOcdNum = 'OcdNum';

type
  TCmhBtr = class (TComponent)
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
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSmCode:word;           procedure WriteSmCode (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str20;         procedure WritePaName_ (pValue:Str20);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadRndVal:double;         procedure WriteRndVal (pValue:double);
    function  ReadCmdVal:double;         procedure WriteCmdVal (pValue:double);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateSmCode (pSmCode:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str20):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestSmCode (pSmCode:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str20):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestCValue (pCValue:double):boolean;
    function NearestOcdNum (pOcdNum:Str12):boolean;

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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property SmCode:word read ReadSmCode write WriteSmCode;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str20 read ReadPaName_ write WritePaName_;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property RndVal:double read ReadRndVal write WriteRndVal;
    property CmdVal:double read ReadCmdVal write WriteCmdVal;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Sended:boolean read ReadSended write WriteSended;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TCmhBtr.Create;
begin
  oBtrTable := BtrInit ('CMH',gPath.StkPath,Self);
end;

constructor TCmhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CMH',pPath,Self);
end;

destructor TCmhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCmhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCmhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCmhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TCmhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCmhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCmhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCmhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCmhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCmhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TCmhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TCmhBtr.ReadSmCode:word;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TCmhBtr.WriteSmCode(pValue:word);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TCmhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCmhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCmhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TCmhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TCmhBtr.ReadPaName_:Str20;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TCmhBtr.WritePaName_(pValue:Str20);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TCmhBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TCmhBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCmhBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TCmhBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TCmhBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TCmhBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TCmhBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TCmhBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TCmhBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCmhBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCmhBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TCmhBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TCmhBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TCmhBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TCmhBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCmhBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCmhBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TCmhBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TCmhBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TCmhBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCmhBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TCmhBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCmhBtr.ReadRndVal:double;
begin
  Result := oBtrTable.FieldByName('RndVal').AsFloat;
end;

procedure TCmhBtr.WriteRndVal(pValue:double);
begin
  oBtrTable.FieldByName('RndVal').AsFloat := pValue;
end;

function TCmhBtr.ReadCmdVal:double;
begin
  Result := oBtrTable.FieldByName('CmdVal').AsFloat;
end;

procedure TCmhBtr.WriteCmdVal(pValue:double);
begin
  oBtrTable.FieldByName('CmdVal').AsFloat := pValue;
end;

function TCmhBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TCmhBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCmhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCmhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCmhBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TCmhBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TCmhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCmhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCmhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCmhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCmhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCmhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCmhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCmhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCmhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TCmhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TCmhBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCmhBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCmhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TCmhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TCmhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TCmhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCmhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCmhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCmhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCmhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCmhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCmhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCmhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TCmhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCmhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TCmhBtr.LocateSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindKey([pSmCode]);
end;

function TCmhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TCmhBtr.LocatePaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TCmhBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TCmhBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TCmhBtr.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindKey([pCValue]);
end;

function TCmhBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TCmhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TCmhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCmhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TCmhBtr.NearestSmCode (pSmCode:word):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindNearest([pSmCode]);
end;

function TCmhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TCmhBtr.NearestPaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TCmhBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TCmhBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TCmhBtr.NearestCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindNearest([pCValue]);
end;

function TCmhBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

procedure TCmhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCmhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCmhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCmhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCmhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCmhBtr.First;
begin
  oBtrTable.First;
end;

procedure TCmhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCmhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCmhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCmhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCmhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCmhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCmhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCmhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCmhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCmhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCmhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
