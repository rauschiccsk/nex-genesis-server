unit bIVDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixSerNum = 'SerNum';

type
  TIvdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadIvDate1:TDatetime;     procedure WriteIvDate1 (pValue:TDatetime);
    function  ReadIvDate2:TDatetime;     procedure WriteIvDate2 (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadCIvVal:double;         procedure WriteCIvVal (pValue:double);
    function  ReadCStVal:double;         procedure WriteCStVal (pValue:double);
    function  ReadCNsVal:double;         procedure WriteCNsVal (pValue:double);
    function  ReadCEvVal:double;         procedure WriteCEvVal (pValue:double);
    function  ReadCPozVal:double;        procedure WriteCPozVal (pValue:double);
    function  ReadCNegVal:double;        procedure WriteCNegVal (pValue:double);
    function  ReadCDifVal:double;        procedure WriteCDifVal (pValue:double);
    function  ReadPIvVal:double;         procedure WritePIvVal (pValue:double);
    function  ReadPStVal:double;         procedure WritePStVal (pValue:double);
    function  ReadPNsVal:double;         procedure WritePNsVal (pValue:double);
    function  ReadPEvVal:double;         procedure WritePEvVal (pValue:double);
    function  ReadPPozVal:double;        procedure WritePPozVal (pValue:double);
    function  ReadPNegVal:double;        procedure WritePNegVal (pValue:double);
    function  ReadPDifVal:double;        procedure WritePDifVal (pValue:double);
    function  ReadIvFase:byte;           procedure WriteIvFase (pValue:byte);
    function  ReadIvFull:byte;           procedure WriteIvFull (pValue:byte);
    function  ReadClosed:byte;           procedure WriteClosed (pValue:byte);
    function  ReadIvdPer:byte;           procedure WriteIvdPer (pValue:byte);
    function  ReadModNum:byte;           procedure WriteModNum (pValue:byte);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadImdNum:Str12;          procedure WriteImdNum (pValue:Str12);
    function  ReadOmdNum:Str12;          procedure WriteOmdNum (pValue:Str12);
    function  ReadMgCodes:Str60;         procedure WriteMgCodes (pValue:Str60);
    function  ReadIvdType:byte;          procedure WriteIvdType (pValue:byte);
    function  ReadPkdNum:Str12;          procedure WritePkdNum (pValue:Str12);
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
    function LocateSerNum (pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestSerNum (pSerNum:word):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property IvDate1:TDatetime read ReadIvDate1 write WriteIvDate1;
    property IvDate2:TDatetime read ReadIvDate2 write WriteIvDate2;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property CIvVal:double read ReadCIvVal write WriteCIvVal;
    property CStVal:double read ReadCStVal write WriteCStVal;
    property CNsVal:double read ReadCNsVal write WriteCNsVal;
    property CEvVal:double read ReadCEvVal write WriteCEvVal;
    property CPozVal:double read ReadCPozVal write WriteCPozVal;
    property CNegVal:double read ReadCNegVal write WriteCNegVal;
    property CDifVal:double read ReadCDifVal write WriteCDifVal;
    property PIvVal:double read ReadPIvVal write WritePIvVal;
    property PStVal:double read ReadPStVal write WritePStVal;
    property PNsVal:double read ReadPNsVal write WritePNsVal;
    property PEvVal:double read ReadPEvVal write WritePEvVal;
    property PPozVal:double read ReadPPozVal write WritePPozVal;
    property PNegVal:double read ReadPNegVal write WritePNegVal;
    property PDifVal:double read ReadPDifVal write WritePDifVal;
    property IvFase:byte read ReadIvFase write WriteIvFase;
    property IvFull:byte read ReadIvFull write WriteIvFull;
    property Closed:byte read ReadClosed write WriteClosed;
    property IvdPer:byte read ReadIvdPer write WriteIvdPer;
    property ModNum:byte read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ImdNum:Str12 read ReadImdNum write WriteImdNum;
    property OmdNum:Str12 read ReadOmdNum write WriteOmdNum;
    property MgCodes:Str60 read ReadMgCodes write WriteMgCodes;
    property IvdType:byte read ReadIvdType write WriteIvdType;
    property PkdNum:Str12 read ReadPkdNum write WritePkdNum;
  end;

implementation

constructor TIvdlstBtr.Create;
begin
  oBtrTable := BtrInit ('IVDLST',gPath.StkPath,Self);
end;

constructor TIvdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IVDLST',pPath,Self);
end;

destructor TIvdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIvdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIvdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIvdlstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIvdlstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIvdlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIvdlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIvdlstBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TIvdlstBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TIvdlstBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TIvdlstBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIvdlstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIvdlstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TIvdlstBtr.ReadIvDate1:TDatetime;
begin
  Result := oBtrTable.FieldByName('IvDate1').AsDateTime;
end;

procedure TIvdlstBtr.WriteIvDate1(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IvDate1').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadIvDate2:TDatetime;
begin
  Result := oBtrTable.FieldByName('IvDate2').AsDateTime;
end;

procedure TIvdlstBtr.WriteIvDate2(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IvDate2').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TIvdlstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TIvdlstBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TIvdlstBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TIvdlstBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadCIvVal:double;
begin
  Result := oBtrTable.FieldByName('CIvVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCIvVal(pValue:double);
begin
  oBtrTable.FieldByName('CIvVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCStVal:double;
begin
  Result := oBtrTable.FieldByName('CStVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCStVal(pValue:double);
begin
  oBtrTable.FieldByName('CStVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCNsVal:double;
begin
  Result := oBtrTable.FieldByName('CNsVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCNsVal(pValue:double);
begin
  oBtrTable.FieldByName('CNsVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCEvVal:double;
begin
  Result := oBtrTable.FieldByName('CEvVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCEvVal(pValue:double);
begin
  oBtrTable.FieldByName('CEvVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCPozVal:double;
begin
  Result := oBtrTable.FieldByName('CPozVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCPozVal(pValue:double);
begin
  oBtrTable.FieldByName('CPozVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCNegVal:double;
begin
  Result := oBtrTable.FieldByName('CNegVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCNegVal(pValue:double);
begin
  oBtrTable.FieldByName('CNegVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadCDifVal:double;
begin
  Result := oBtrTable.FieldByName('CDifVal').AsFloat;
end;

procedure TIvdlstBtr.WriteCDifVal(pValue:double);
begin
  oBtrTable.FieldByName('CDifVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPIvVal:double;
begin
  Result := oBtrTable.FieldByName('PIvVal').AsFloat;
end;

procedure TIvdlstBtr.WritePIvVal(pValue:double);
begin
  oBtrTable.FieldByName('PIvVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPStVal:double;
begin
  Result := oBtrTable.FieldByName('PStVal').AsFloat;
end;

procedure TIvdlstBtr.WritePStVal(pValue:double);
begin
  oBtrTable.FieldByName('PStVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPNsVal:double;
begin
  Result := oBtrTable.FieldByName('PNsVal').AsFloat;
end;

procedure TIvdlstBtr.WritePNsVal(pValue:double);
begin
  oBtrTable.FieldByName('PNsVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPEvVal:double;
begin
  Result := oBtrTable.FieldByName('PEvVal').AsFloat;
end;

procedure TIvdlstBtr.WritePEvVal(pValue:double);
begin
  oBtrTable.FieldByName('PEvVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPPozVal:double;
begin
  Result := oBtrTable.FieldByName('PPozVal').AsFloat;
end;

procedure TIvdlstBtr.WritePPozVal(pValue:double);
begin
  oBtrTable.FieldByName('PPozVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPNegVal:double;
begin
  Result := oBtrTable.FieldByName('PNegVal').AsFloat;
end;

procedure TIvdlstBtr.WritePNegVal(pValue:double);
begin
  oBtrTable.FieldByName('PNegVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadPDifVal:double;
begin
  Result := oBtrTable.FieldByName('PDifVal').AsFloat;
end;

procedure TIvdlstBtr.WritePDifVal(pValue:double);
begin
  oBtrTable.FieldByName('PDifVal').AsFloat := pValue;
end;

function TIvdlstBtr.ReadIvFase:byte;
begin
  Result := oBtrTable.FieldByName('IvFase').AsInteger;
end;

procedure TIvdlstBtr.WriteIvFase(pValue:byte);
begin
  oBtrTable.FieldByName('IvFase').AsInteger := pValue;
end;

function TIvdlstBtr.ReadIvFull:byte;
begin
  Result := oBtrTable.FieldByName('IvFull').AsInteger;
end;

procedure TIvdlstBtr.WriteIvFull(pValue:byte);
begin
  oBtrTable.FieldByName('IvFull').AsInteger := pValue;
end;

function TIvdlstBtr.ReadClosed:byte;
begin
  Result := oBtrTable.FieldByName('Closed').AsInteger;
end;

procedure TIvdlstBtr.WriteClosed(pValue:byte);
begin
  oBtrTable.FieldByName('Closed').AsInteger := pValue;
end;

function TIvdlstBtr.ReadIvdPer:byte;
begin
  Result := oBtrTable.FieldByName('IvdPer').AsInteger;
end;

procedure TIvdlstBtr.WriteIvdPer(pValue:byte);
begin
  oBtrTable.FieldByName('IvdPer').AsInteger := pValue;
end;

function TIvdlstBtr.ReadModNum:byte;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIvdlstBtr.WriteModNum(pValue:byte);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIvdlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIvdlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIvdlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIvdlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIvdlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIvdlstBtr.ReadImdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ImdNum').AsString;
end;

procedure TIvdlstBtr.WriteImdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ImdNum').AsString := pValue;
end;

function TIvdlstBtr.ReadOmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OmdNum').AsString;
end;

procedure TIvdlstBtr.WriteOmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OmdNum').AsString := pValue;
end;

function TIvdlstBtr.ReadMgCodes:Str60;
begin
  Result := oBtrTable.FieldByName('MgCodes').AsString;
end;

procedure TIvdlstBtr.WriteMgCodes(pValue:Str60);
begin
  oBtrTable.FieldByName('MgCodes').AsString := pValue;
end;

function TIvdlstBtr.ReadIvdType:byte;
begin
  Result := oBtrTable.FieldByName('IvdType').AsInteger;
end;

procedure TIvdlstBtr.WriteIvdType(pValue:byte);
begin
  oBtrTable.FieldByName('IvdType').AsInteger := pValue;
end;

function TIvdlstBtr.ReadPkdNum:Str12;
begin
  Result := oBtrTable.FieldByName('PkdNum').AsString;
end;

procedure TIvdlstBtr.WritePkdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('PkdNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIvdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIvdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIvdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIvdlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIvdlstBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TIvdlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIvdlstBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

procedure TIvdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIvdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TIvdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIvdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIvdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIvdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TIvdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIvdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIvdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIvdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIvdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIvdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIvdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIvdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIvdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIvdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIvdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1907001}
