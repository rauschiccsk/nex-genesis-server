unit bFSATMC;

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
  ixBnBi = 'BnBi';
  ixBnEi = 'BnEi';

type
  TFsatmcBtr = class (TComponent)
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
    function  ReadActPce:double;         procedure WriteActPce (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadActPrv:double;         procedure WriteActPrv (pValue:double);
    function  ReadActPrp:double;         procedure WriteActPrp (pValue:double);
    function  ReadPlnPce:double;         procedure WritePlnPce (pValue:double);
    function  ReadPlnVal:double;         procedure WritePlnVal (pValue:double);
    function  ReadPlnPrv:double;         procedure WritePlnPrv (pValue:double);
    function  ReadPlnPrp:double;         procedure WritePlnPrp (pValue:double);
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
    function LocateBnBi (pBokNum:word;pBegIdc:Str10):boolean;
    function LocateBnEi (pBokNum:word;pEndIdc:Str10):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestSymbol (pSymbol:Str6):boolean;
    function NearestBegIdc (pBegIdc:Str10):boolean;
    function NearestEndIdc (pEndIdc:Str10):boolean;
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
    property ActPce:double read ReadActPce write WriteActPce;
    property ActVal:double read ReadActVal write WriteActVal;
    property ActPrv:double read ReadActPrv write WriteActPrv;
    property ActPrp:double read ReadActPrp write WriteActPrp;
    property PlnPce:double read ReadPlnPce write WritePlnPce;
    property PlnVal:double read ReadPlnVal write WritePlnVal;
    property PlnPrv:double read ReadPlnPrv write WritePlnPrv;
    property PlnPrp:double read ReadPlnPrp write WritePlnPrp;
    property ArcNum:longint read ReadArcNum write WriteArcNum;
  end;

implementation

constructor TFsatmcBtr.Create;
begin
  oBtrTable := BtrInit ('FSATMC',gPath.CdwPath,Self);
end;

constructor TFsatmcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSATMC',pPath,Self);
end;

destructor TFsatmcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsatmcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsatmcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsatmcBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsatmcBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsatmcBtr.ReadSymbol:Str6;
begin
  Result := oBtrTable.FieldByName('Symbol').AsString;
end;

procedure TFsatmcBtr.WriteSymbol(pValue:Str6);
begin
  oBtrTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsatmcBtr.ReadOpnPos:Str1;
begin
  Result := oBtrTable.FieldByName('OpnPos').AsString;
end;

procedure TFsatmcBtr.WriteOpnPos(pValue:Str1);
begin
  oBtrTable.FieldByName('OpnPos').AsString := pValue;
end;

function TFsatmcBtr.ReadActQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsatmcBtr.WriteActQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsatmcBtr.ReadBegIdc:Str10;
begin
  Result := oBtrTable.FieldByName('BegIdc').AsString;
end;

procedure TFsatmcBtr.WriteBegIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('BegIdc').AsString := pValue;
end;

function TFsatmcBtr.ReadBegDir:Str1;
begin
  Result := oBtrTable.FieldByName('BegDir').AsString;
end;

procedure TFsatmcBtr.WriteBegDir(pValue:Str1);
begin
  oBtrTable.FieldByName('BegDir').AsString := pValue;
end;

function TFsatmcBtr.ReadBegPce:double;
begin
  Result := oBtrTable.FieldByName('BegPce').AsFloat;
end;

procedure TFsatmcBtr.WriteBegPce(pValue:double);
begin
  oBtrTable.FieldByName('BegPce').AsFloat := pValue;
end;

function TFsatmcBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TFsatmcBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFsatmcBtr.ReadBegOvr:double;
begin
  Result := oBtrTable.FieldByName('BegOvr').AsFloat;
end;

procedure TFsatmcBtr.WriteBegOvr(pValue:double);
begin
  oBtrTable.FieldByName('BegOvr').AsFloat := pValue;
end;

function TFsatmcBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFsatmcBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFsatmcBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TFsatmcBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TFsatmcBtr.ReadEndIdc:Str10;
begin
  Result := oBtrTable.FieldByName('EndIdc').AsString;
end;

procedure TFsatmcBtr.WriteEndIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('EndIdc').AsString := pValue;
end;

function TFsatmcBtr.ReadEndDir:Str1;
begin
  Result := oBtrTable.FieldByName('EndDir').AsString;
end;

procedure TFsatmcBtr.WriteEndDir(pValue:Str1);
begin
  oBtrTable.FieldByName('EndDir').AsString := pValue;
end;

function TFsatmcBtr.ReadEndPce:double;
begin
  Result := oBtrTable.FieldByName('EndPce').AsFloat;
end;

procedure TFsatmcBtr.WriteEndPce(pValue:double);
begin
  oBtrTable.FieldByName('EndPce').AsFloat := pValue;
end;

function TFsatmcBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TFsatmcBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFsatmcBtr.ReadEndOvr:double;
begin
  Result := oBtrTable.FieldByName('EndOvr').AsFloat;
end;

procedure TFsatmcBtr.WriteEndOvr(pValue:double);
begin
  oBtrTable.FieldByName('EndOvr').AsFloat := pValue;
end;

function TFsatmcBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TFsatmcBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TFsatmcBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TFsatmcBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TFsatmcBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TFsatmcBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TFsatmcBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TFsatmcBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TFsatmcBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TFsatmcBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TFsatmcBtr.ReadDayQnt:word;
begin
  Result := oBtrTable.FieldByName('DayQnt').AsInteger;
end;

procedure TFsatmcBtr.WriteDayQnt(pValue:word);
begin
  oBtrTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TFsatmcBtr.ReadActPce:double;
begin
  Result := oBtrTable.FieldByName('ActPce').AsFloat;
end;

procedure TFsatmcBtr.WriteActPce(pValue:double);
begin
  oBtrTable.FieldByName('ActPce').AsFloat := pValue;
end;

function TFsatmcBtr.ReadActVal:double;
begin
  Result := oBtrTable.FieldByName('ActVal').AsFloat;
end;

procedure TFsatmcBtr.WriteActVal(pValue:double);
begin
  oBtrTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TFsatmcBtr.ReadActPrv:double;
begin
  Result := oBtrTable.FieldByName('ActPrv').AsFloat;
end;

procedure TFsatmcBtr.WriteActPrv(pValue:double);
begin
  oBtrTable.FieldByName('ActPrv').AsFloat := pValue;
end;

function TFsatmcBtr.ReadActPrp:double;
begin
  Result := oBtrTable.FieldByName('ActPrp').AsFloat;
end;

procedure TFsatmcBtr.WriteActPrp(pValue:double);
begin
  oBtrTable.FieldByName('ActPrp').AsFloat := pValue;
end;

function TFsatmcBtr.ReadPlnPce:double;
begin
  Result := oBtrTable.FieldByName('PlnPce').AsFloat;
end;

procedure TFsatmcBtr.WritePlnPce(pValue:double);
begin
  oBtrTable.FieldByName('PlnPce').AsFloat := pValue;
end;

function TFsatmcBtr.ReadPlnVal:double;
begin
  Result := oBtrTable.FieldByName('PlnVal').AsFloat;
end;

procedure TFsatmcBtr.WritePlnVal(pValue:double);
begin
  oBtrTable.FieldByName('PlnVal').AsFloat := pValue;
end;

function TFsatmcBtr.ReadPlnPrv:double;
begin
  Result := oBtrTable.FieldByName('PlnPrv').AsFloat;
end;

procedure TFsatmcBtr.WritePlnPrv(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrv').AsFloat := pValue;
end;

function TFsatmcBtr.ReadPlnPrp:double;
begin
  Result := oBtrTable.FieldByName('PlnPrp').AsFloat;
end;

procedure TFsatmcBtr.WritePlnPrp(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrp').AsFloat := pValue;
end;

function TFsatmcBtr.ReadArcNum:longint;
begin
  Result := oBtrTable.FieldByName('ArcNum').AsInteger;
end;

procedure TFsatmcBtr.WriteArcNum(pValue:longint);
begin
  oBtrTable.FieldByName('ArcNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsatmcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsatmcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsatmcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsatmcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsatmcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsatmcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsatmcBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsatmcBtr.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindKey([pSymbol]);
end;

function TFsatmcBtr.LocateBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindKey([pBegIdc]);
end;

function TFsatmcBtr.LocateEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindKey([pEndIdc]);
end;

function TFsatmcBtr.LocateBnBi (pBokNum:word;pBegIdc:Str10):boolean;
begin
  SetIndex (ixBnBi);
  Result := oBtrTable.FindKey([pBokNum,pBegIdc]);
end;

function TFsatmcBtr.LocateBnEi (pBokNum:word;pEndIdc:Str10):boolean;
begin
  SetIndex (ixBnEi);
  Result := oBtrTable.FindKey([pBokNum,pEndIdc]);
end;

function TFsatmcBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsatmcBtr.NearestSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindNearest([pSymbol]);
end;

function TFsatmcBtr.NearestBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindNearest([pBegIdc]);
end;

function TFsatmcBtr.NearestEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindNearest([pEndIdc]);
end;

function TFsatmcBtr.NearestBnBi (pBokNum:word;pBegIdc:Str10):boolean;
begin
  SetIndex (ixBnBi);
  Result := oBtrTable.FindNearest([pBokNum,pBegIdc]);
end;

function TFsatmcBtr.NearestBnEi (pBokNum:word;pEndIdc:Str10):boolean;
begin
  SetIndex (ixBnEi);
  Result := oBtrTable.FindNearest([pBokNum,pEndIdc]);
end;

procedure TFsatmcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsatmcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsatmcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsatmcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsatmcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsatmcBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsatmcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsatmcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsatmcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsatmcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsatmcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsatmcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsatmcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsatmcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsatmcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsatmcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsatmcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
