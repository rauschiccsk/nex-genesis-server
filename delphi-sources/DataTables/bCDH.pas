unit bCDH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPdSmCode = 'PdSmCode';
  ixCpSmCode = 'CpSmCode';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixCValue = 'CValue';
  ixOcdNum = 'OcdNum';

type
  TCdhBtr = class (TComponent)
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
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadPdSmCode:word;         procedure WritePdSmCode (pValue:word);
    function  ReadCpSmCode:word;         procedure WriteCpSmCode (pValue:word);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadCpStkNum:word;         procedure WriteCpStkNum (pValue:word);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePdSmCode (pPdSmCode:word):boolean;
    function LocateCpSmCode (pCpSmCode:word):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateOcdNum (pOcdNum:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPdSmCode (pPdSmCode:word):boolean;
    function NearestCpSmCode (pCpSmCode:word):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property PdSmCode:word read ReadPdSmCode write WritePdSmCode;
    property CpSmCode:word read ReadCpSmCode write WriteCpSmCode;
    property CValue:double read ReadCValue write WriteCValue;
    property BValue:double read ReadBValue write WriteBValue;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property CpStkNum:word read ReadCpStkNum write WriteCpStkNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TCdhBtr.Create;
begin
  oBtrTable := BtrInit ('CDH',gPath.StkPath,Self);
end;

constructor TCdhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CDH',pPath,Self);
end;

destructor TCdhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCdhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCdhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCdhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TCdhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TCdhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCdhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TCdhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TCdhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TCdhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TCdhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCdhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TCdhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TCdhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TCdhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TCdhBtr.ReadPdSmCode:word;
begin
  Result := oBtrTable.FieldByName('PdSmCode').AsInteger;
end;

procedure TCdhBtr.WritePdSmCode(pValue:word);
begin
  oBtrTable.FieldByName('PdSmCode').AsInteger := pValue;
end;

function TCdhBtr.ReadCpSmCode:word;
begin
  Result := oBtrTable.FieldByName('CpSmCode').AsInteger;
end;

procedure TCdhBtr.WriteCpSmCode(pValue:word);
begin
  oBtrTable.FieldByName('CpSmCode').AsInteger := pValue;
end;

function TCdhBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TCdhBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCdhBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TCdhBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCdhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCdhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCdhBtr.ReadDstStk:Str1;
begin
  Result := oBtrTable.FieldByName('DstStk').AsString;
end;

procedure TCdhBtr.WriteDstStk(pValue:Str1);
begin
  oBtrTable.FieldByName('DstStk').AsString := pValue;
end;

function TCdhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TCdhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TCdhBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TCdhBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TCdhBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TCdhBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TCdhBtr.ReadCpStkNum:word;
begin
  Result := oBtrTable.FieldByName('CpStkNum').AsInteger;
end;

procedure TCdhBtr.WriteCpStkNum(pValue:word);
begin
  oBtrTable.FieldByName('CpStkNum').AsInteger := pValue;
end;

function TCdhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCdhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCdhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCdhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCdhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCdhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCdhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCdhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCdhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCdhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCdhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCdhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCdhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TCdhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCdhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCdhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCdhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCdhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCdhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCdhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCdhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TCdhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCdhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TCdhBtr.LocatePdSmCode (pPdSmCode:word):boolean;
begin
  SetIndex (ixPdSmCode);
  Result := oBtrTable.FindKey([pPdSmCode]);
end;

function TCdhBtr.LocateCpSmCode (pCpSmCode:word):boolean;
begin
  SetIndex (ixCpSmCode);
  Result := oBtrTable.FindKey([pCpSmCode]);
end;

function TCdhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TCdhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TCdhBtr.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindKey([pCValue]);
end;

function TCdhBtr.LocateOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindKey([pOcdNum]);
end;

function TCdhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TCdhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCdhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TCdhBtr.NearestPdSmCode (pPdSmCode:word):boolean;
begin
  SetIndex (ixPdSmCode);
  Result := oBtrTable.FindNearest([pPdSmCode]);
end;

function TCdhBtr.NearestCpSmCode (pCpSmCode:word):boolean;
begin
  SetIndex (ixCpSmCode);
  Result := oBtrTable.FindNearest([pCpSmCode]);
end;

function TCdhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TCdhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TCdhBtr.NearestCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oBtrTable.FindNearest([pCValue]);
end;

function TCdhBtr.NearestOcdNum (pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oBtrTable.FindNearest([pOcdNum]);
end;

procedure TCdhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCdhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCdhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCdhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCdhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCdhBtr.First;
begin
  oBtrTable.First;
end;

procedure TCdhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCdhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCdhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCdhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCdhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCdhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCdhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCdhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCdhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCdhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCdhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
