unit bFSACLS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBokNum = 'BokNum';
  ixSymbol = 'Symbol';
  ixBegIdc = 'BegIdc';
  ixEndIdc = 'EndIdc';
  ixAccDate = 'AccDate';
  ixBnBi = 'BnBi';
  ixBnEi = 'BnEi';

type
  TFsaclsBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:word;           procedure WriteBokNum (pValue:word);
    function  ReadSymbol:Str6;           procedure WriteSymbol (pValue:Str6);
    function  ReadOpnPos:Str1;           procedure WriteOpnPos (pValue:Str1);
    function  ReadActQnt:longint;        procedure WriteActQnt (pValue:longint);
    function  ReadBegIdc:Str10;          procedure WriteBegIdc (pValue:Str10);
    function  ReadBegDir:Str1;           procedure WriteBegDir (pValue:Str1);
    function  ReadBegPce:double;         procedure WriteBegPce (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadBegOvr:double;         procedure WriteBegOvr (pValue:double);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndIdc:Str10;          procedure WriteEndIdc (pValue:Str10);
    function  ReadEndDir:Str1;           procedure WriteEndDir (pValue:Str1);
    function  ReadEndPce:double;         procedure WriteEndPce (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadEndOvr:double;         procedure WriteEndOvr (pValue:double);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadArcNum:longint;        procedure WriteArcNum (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBokNum (pBokNum:word):boolean;
    function LocateSymbol (pSymbol:Str6):boolean;
    function LocateBegIdc (pBegIdc:Str10):boolean;
    function LocateEndIdc (pEndIdc:Str10):boolean;
    function LocateAccDate (pAccDate:TDatetime):boolean;
    function LocateBnBi (pBokNum:word;pBegIdc:Str10):boolean;
    function LocateBnEi (pBokNum:word;pEndIdc:Str10):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestSymbol (pSymbol:Str6):boolean;
    function NearestBegIdc (pBegIdc:Str10):boolean;
    function NearestEndIdc (pEndIdc:Str10):boolean;
    function NearestAccDate (pAccDate:TDatetime):boolean;
    function NearestBnBi (pBokNum:word;pBegIdc:Str10):boolean;
    function NearestBnEi (pBokNum:word;pEndIdc:Str10):boolean;

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
    property BokNum:word read ReadBokNum write WriteBokNum;
    property Symbol:Str6 read ReadSymbol write WriteSymbol;
    property OpnPos:Str1 read ReadOpnPos write WriteOpnPos;
    property ActQnt:longint read ReadActQnt write WriteActQnt;
    property BegIdc:Str10 read ReadBegIdc write WriteBegIdc;
    property BegDir:Str1 read ReadBegDir write WriteBegDir;
    property BegPce:double read ReadBegPce write WriteBegPce;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property BegOvr:double read ReadBegOvr write WriteBegOvr;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndIdc:Str10 read ReadEndIdc write WriteEndIdc;
    property EndDir:Str1 read ReadEndDir write WriteEndDir;
    property EndPce:double read ReadEndPce write WriteEndPce;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property EndOvr:double read ReadEndOvr write WriteEndOvr;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property ArcNum:longint read ReadArcNum write WriteArcNum;
  end;

implementation

constructor TFsaclsBtr.Create;
begin
  oBtrTable := BtrInit ('FSACLS',gPath.CdwPath,Self);
end;

constructor TFsaclsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSACLS',pPath,Self);
end;

destructor TFsaclsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsaclsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsaclsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsaclsBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsaclsBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsaclsBtr.ReadSymbol:Str6;
begin
  Result := oBtrTable.FieldByName('Symbol').AsString;
end;

procedure TFsaclsBtr.WriteSymbol(pValue:Str6);
begin
  oBtrTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsaclsBtr.ReadOpnPos:Str1;
begin
  Result := oBtrTable.FieldByName('OpnPos').AsString;
end;

procedure TFsaclsBtr.WriteOpnPos(pValue:Str1);
begin
  oBtrTable.FieldByName('OpnPos').AsString := pValue;
end;

function TFsaclsBtr.ReadActQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsaclsBtr.WriteActQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsaclsBtr.ReadBegIdc:Str10;
begin
  Result := oBtrTable.FieldByName('BegIdc').AsString;
end;

procedure TFsaclsBtr.WriteBegIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('BegIdc').AsString := pValue;
end;

function TFsaclsBtr.ReadBegDir:Str1;
begin
  Result := oBtrTable.FieldByName('BegDir').AsString;
end;

procedure TFsaclsBtr.WriteBegDir(pValue:Str1);
begin
  oBtrTable.FieldByName('BegDir').AsString := pValue;
end;

function TFsaclsBtr.ReadBegPce:double;
begin
  Result := oBtrTable.FieldByName('BegPce').AsFloat;
end;

procedure TFsaclsBtr.WriteBegPce(pValue:double);
begin
  oBtrTable.FieldByName('BegPce').AsFloat := pValue;
end;

function TFsaclsBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TFsaclsBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFsaclsBtr.ReadBegOvr:double;
begin
  Result := oBtrTable.FieldByName('BegOvr').AsFloat;
end;

procedure TFsaclsBtr.WriteBegOvr(pValue:double);
begin
  oBtrTable.FieldByName('BegOvr').AsFloat := pValue;
end;

function TFsaclsBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFsaclsBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFsaclsBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TFsaclsBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TFsaclsBtr.ReadEndIdc:Str10;
begin
  Result := oBtrTable.FieldByName('EndIdc').AsString;
end;

procedure TFsaclsBtr.WriteEndIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('EndIdc').AsString := pValue;
end;

function TFsaclsBtr.ReadEndDir:Str1;
begin
  Result := oBtrTable.FieldByName('EndDir').AsString;
end;

procedure TFsaclsBtr.WriteEndDir(pValue:Str1);
begin
  oBtrTable.FieldByName('EndDir').AsString := pValue;
end;

function TFsaclsBtr.ReadEndPce:double;
begin
  Result := oBtrTable.FieldByName('EndPce').AsFloat;
end;

procedure TFsaclsBtr.WriteEndPce(pValue:double);
begin
  oBtrTable.FieldByName('EndPce').AsFloat := pValue;
end;

function TFsaclsBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TFsaclsBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFsaclsBtr.ReadEndOvr:double;
begin
  Result := oBtrTable.FieldByName('EndOvr').AsFloat;
end;

procedure TFsaclsBtr.WriteEndOvr(pValue:double);
begin
  oBtrTable.FieldByName('EndOvr').AsFloat := pValue;
end;

function TFsaclsBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TFsaclsBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TFsaclsBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TFsaclsBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TFsaclsBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TFsaclsBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TFsaclsBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TFsaclsBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TFsaclsBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TFsaclsBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TFsaclsBtr.ReadDayQnt:word;
begin
  Result := oBtrTable.FieldByName('DayQnt').AsInteger;
end;

procedure TFsaclsBtr.WriteDayQnt(pValue:word);
begin
  oBtrTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TFsaclsBtr.ReadArcNum:longint;
begin
  Result := oBtrTable.FieldByName('ArcNum').AsInteger;
end;

procedure TFsaclsBtr.WriteArcNum(pValue:longint);
begin
  oBtrTable.FieldByName('ArcNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsaclsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaclsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsaclsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaclsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsaclsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsaclsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsaclsBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsaclsBtr.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindKey([pSymbol]);
end;

function TFsaclsBtr.LocateBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindKey([pBegIdc]);
end;

function TFsaclsBtr.LocateEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindKey([pEndIdc]);
end;

function TFsaclsBtr.LocateAccDate (pAccDate:TDatetime):boolean;
begin
  SetIndex (ixAccDate);
  Result := oBtrTable.FindKey([pAccDate]);
end;

function TFsaclsBtr.LocateBnBi (pBokNum:word;pBegIdc:Str10):boolean;
begin
  SetIndex (ixBnBi);
  Result := oBtrTable.FindKey([pBokNum,pBegIdc]);
end;

function TFsaclsBtr.LocateBnEi (pBokNum:word;pEndIdc:Str10):boolean;
begin
  SetIndex (ixBnEi);
  Result := oBtrTable.FindKey([pBokNum,pEndIdc]);
end;

function TFsaclsBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsaclsBtr.NearestSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindNearest([pSymbol]);
end;

function TFsaclsBtr.NearestBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindNearest([pBegIdc]);
end;

function TFsaclsBtr.NearestEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindNearest([pEndIdc]);
end;

function TFsaclsBtr.NearestAccDate (pAccDate:TDatetime):boolean;
begin
  SetIndex (ixAccDate);
  Result := oBtrTable.FindNearest([pAccDate]);
end;

function TFsaclsBtr.NearestBnBi (pBokNum:word;pBegIdc:Str10):boolean;
begin
  SetIndex (ixBnBi);
  Result := oBtrTable.FindNearest([pBokNum,pBegIdc]);
end;

function TFsaclsBtr.NearestBnEi (pBokNum:word;pEndIdc:Str10):boolean;
begin
  SetIndex (ixBnEi);
  Result := oBtrTable.FindNearest([pBokNum,pEndIdc]);
end;

procedure TFsaclsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsaclsBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsaclsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsaclsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsaclsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsaclsBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsaclsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsaclsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsaclsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsaclsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsaclsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsaclsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsaclsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsaclsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsaclsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsaclsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsaclsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
