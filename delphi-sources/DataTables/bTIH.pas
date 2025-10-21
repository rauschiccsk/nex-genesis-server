unit bTIH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixStdNum = 'StdNum';
  ixStatus = 'Status';
  ixPcSt = 'PcSt';

type
  TTihBtr = class (TComponent)
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
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadEValue:double;         procedure WriteEValue (pValue:double);
    function  ReadStdNum:Str12;          procedure WriteStdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadEpsUsrc:Str10;         procedure WriteEpsUsrc (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadReserv:Str7;           procedure WriteReserv (pValue:Str7);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateStdNum (pStdNum:Str12):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocatePcSt (pPaCode:longint;pStatus:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestStdNum (pStdNum:Str12):boolean;
    function NearestStatus (pStatus:Str1):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property CValue:double read ReadCValue write WriteCValue;
    property EValue:double read ReadEValue write WriteEValue;
    property StdNum:Str12 read ReadStdNum write WriteStdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property EpsUsrc:Str10 read ReadEpsUsrc write WriteEpsUsrc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property Reserv:Str7 read ReadReserv write WriteReserv;
    property IntNum:longint read ReadIntNum write WriteIntNum;
  end;

implementation

constructor TTihBtr.Create;
begin
  oBtrTable := BtrInit ('TIH',gPath.StkPath,Self);
end;

constructor TTihBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TIH',pPath,Self);
end;

destructor TTihBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTihBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTihBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTihBtr.ReadTrmNum:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TTihBtr.WriteTrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TTihBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TTihBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TTihBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTihBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTihBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTihBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTihBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTihBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTihBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTihBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTihBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTihBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTihBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TTihBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TTihBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TTihBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TTihBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTihBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTihBtr.ReadEValue:double;
begin
  Result := oBtrTable.FieldByName('EValue').AsFloat;
end;

procedure TTihBtr.WriteEValue(pValue:double);
begin
  oBtrTable.FieldByName('EValue').AsFloat := pValue;
end;

function TTihBtr.ReadStdNum:Str12;
begin
  Result := oBtrTable.FieldByName('StdNum').AsString;
end;

procedure TTihBtr.WriteStdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('StdNum').AsString := pValue;
end;

function TTihBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TTihBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TTihBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTihBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTihBtr.ReadEpsUsrc:Str10;
begin
  Result := oBtrTable.FieldByName('EpsUsrc').AsString;
end;

procedure TTihBtr.WriteEpsUsrc(pValue:Str10);
begin
  oBtrTable.FieldByName('EpsUsrc').AsString := pValue;
end;

function TTihBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTihBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTihBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTihBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTihBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTihBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTihBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTihBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTihBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTihBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTihBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTihBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTihBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTihBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTihBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TTihBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TTihBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTihBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTihBtr.ReadReserv:Str7;
begin
  Result := oBtrTable.FieldByName('Reserv').AsString;
end;

procedure TTihBtr.WriteReserv(pValue:Str7);
begin
  oBtrTable.FieldByName('Reserv').AsString := pValue;
end;

function TTihBtr.ReadIntNum:longint;
begin
  Result := oBtrTable.FieldByName('IntNum').AsInteger;
end;

procedure TTihBtr.WriteIntNum(pValue:longint);
begin
  oBtrTable.FieldByName('IntNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTihBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTihBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTihBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTihBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTihBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTihBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTihBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTihBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TTihBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TTihBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TTihBtr.LocateStdNum (pStdNum:Str12):boolean;
begin
  SetIndex (ixStdNum);
  Result := oBtrTable.FindKey([pStdNum]);
end;

function TTihBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TTihBtr.LocatePcSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPcSt);
  Result := oBtrTable.FindKey([pPaCode,pStatus]);
end;

function TTihBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTihBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TTihBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TTihBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TTihBtr.NearestStdNum (pStdNum:Str12):boolean;
begin
  SetIndex (ixStdNum);
  Result := oBtrTable.FindNearest([pStdNum]);
end;

function TTihBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

function TTihBtr.NearestPcSt (pPaCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixPcSt);
  Result := oBtrTable.FindNearest([pPaCode,pStatus]);
end;

procedure TTihBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTihBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTihBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTihBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTihBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTihBtr.First;
begin
  oBtrTable.First;
end;

procedure TTihBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTihBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTihBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTihBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTihBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTihBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTihBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTihBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTihBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTihBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTihBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
