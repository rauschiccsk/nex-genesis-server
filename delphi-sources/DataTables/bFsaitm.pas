unit bFSAITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSymbol = 'Symbol';
  ixBegIdc = 'BegIdc';
  ixEndIdc = 'EndIdc';
  ixUsrIdc = 'UsrIdc';

type
  TFsaitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSymbol:Str6;           procedure WriteSymbol (pValue:Str6);
    function  ReadTrnDir:Str1;           procedure WriteTrnDir (pValue:Str1);
    function  ReadOpnPos:Str1;           procedure WriteOpnPos (pValue:Str1);
    function  ReadUsrIdc:Str20;          procedure WriteUsrIdc (pValue:Str20);
    function  ReadActQnt:longint;        procedure WriteActQnt (pValue:longint);
    function  ReadBegIdc:Str10;          procedure WriteBegIdc (pValue:Str10);
    function  ReadBegPce:double;         procedure WriteBegPce (pValue:double);
    function  ReadBegVal:double;         procedure WriteBegVal (pValue:double);
    function  ReadBegOvr:double;         procedure WriteBegOvr (pValue:double);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndIdc:Str10;          procedure WriteEndIdc (pValue:Str10);
    function  ReadEndPce:double;         procedure WriteEndPce (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadEndOvr:double;         procedure WriteEndOvr (pValue:double);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadPlnPce:double;         procedure WritePlnPce (pValue:double);
    function  ReadPlnVal:double;         procedure WritePlnVal (pValue:double);
    function  ReadPlnOvr:double;         procedure WritePlnOvr (pValue:double);
    function  ReadPlnPrv:double;         procedure WritePlnPrv (pValue:double);
    function  ReadPlnPrp:double;         procedure WritePlnPrp (pValue:double);
    function  ReadReaPrv:double;         procedure WriteReaPrv (pValue:double);
    function  ReadReaPrp:double;         procedure WriteReaPrp (pValue:double);
    function  ReadDayQnt:word;           procedure WriteDayQnt (pValue:word);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateSymbol (pSymbol:Str6):boolean;
    function LocateBegIdc (pBegIdc:Str10):boolean;
    function LocateEndIdc (pEndIdc:Str10):boolean;
    function LocateUsrIdc (pUsrIdc:Str20):boolean;
    function NearestSymbol (pSymbol:Str6):boolean;
    function NearestBegIdc (pBegIdc:Str10):boolean;
    function NearestEndIdc (pEndIdc:Str10):boolean;
    function NearestUsrIdc (pUsrIdc:Str20):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property Symbol:Str6 read ReadSymbol write WriteSymbol;
    property TrnDir:Str1 read ReadTrnDir write WriteTrnDir;
    property OpnPos:Str1 read ReadOpnPos write WriteOpnPos;
    property UsrIdc:Str20 read ReadUsrIdc write WriteUsrIdc;
    property ActQnt:longint read ReadActQnt write WriteActQnt;
    property BegIdc:Str10 read ReadBegIdc write WriteBegIdc;
    property BegPce:double read ReadBegPce write WriteBegPce;
    property BegVal:double read ReadBegVal write WriteBegVal;
    property BegOvr:double read ReadBegOvr write WriteBegOvr;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndIdc:Str10 read ReadEndIdc write WriteEndIdc;
    property EndPce:double read ReadEndPce write WriteEndPce;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property EndOvr:double read ReadEndOvr write WriteEndOvr;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property PlnPce:double read ReadPlnPce write WritePlnPce;
    property PlnVal:double read ReadPlnVal write WritePlnVal;
    property PlnOvr:double read ReadPlnOvr write WritePlnOvr;
    property PlnPrv:double read ReadPlnPrv write WritePlnPrv;
    property PlnPrp:double read ReadPlnPrp write WritePlnPrp;
    property ReaPrv:double read ReadReaPrv write WriteReaPrv;
    property ReaPrp:double read ReadReaPrp write WriteReaPrp;
    property DayQnt:word read ReadDayQnt write WriteDayQnt;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
  end;

implementation

constructor TFsaitmBtr.Create;
begin
  oBtrTable := BtrInit ('FSAITM',gPath.CdwPath,Self);
end;

constructor TFsaitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSAITM',pPath,Self);
end;

destructor TFsaitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsaitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsaitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsaitmBtr.ReadSymbol:Str6;
begin
  Result := oBtrTable.FieldByName('Symbol').AsString;
end;

procedure TFsaitmBtr.WriteSymbol(pValue:Str6);
begin
  oBtrTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsaitmBtr.ReadTrnDir:Str1;
begin
  Result := oBtrTable.FieldByName('TrnDir').AsString;
end;

procedure TFsaitmBtr.WriteTrnDir(pValue:Str1);
begin
  oBtrTable.FieldByName('TrnDir').AsString := pValue;
end;

function TFsaitmBtr.ReadOpnPos:Str1;
begin
  Result := oBtrTable.FieldByName('OpnPos').AsString;
end;

procedure TFsaitmBtr.WriteOpnPos(pValue:Str1);
begin
  oBtrTable.FieldByName('OpnPos').AsString := pValue;
end;

function TFsaitmBtr.ReadUsrIdc:Str20;
begin
  Result := oBtrTable.FieldByName('UsrIdc').AsString;
end;

procedure TFsaitmBtr.WriteUsrIdc(pValue:Str20);
begin
  oBtrTable.FieldByName('UsrIdc').AsString := pValue;
end;

function TFsaitmBtr.ReadActQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsaitmBtr.WriteActQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsaitmBtr.ReadBegIdc:Str10;
begin
  Result := oBtrTable.FieldByName('BegIdc').AsString;
end;

procedure TFsaitmBtr.WriteBegIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('BegIdc').AsString := pValue;
end;

function TFsaitmBtr.ReadBegPce:double;
begin
  Result := oBtrTable.FieldByName('BegPce').AsFloat;
end;

procedure TFsaitmBtr.WriteBegPce(pValue:double);
begin
  oBtrTable.FieldByName('BegPce').AsFloat := pValue;
end;

function TFsaitmBtr.ReadBegVal:double;
begin
  Result := oBtrTable.FieldByName('BegVal').AsFloat;
end;

procedure TFsaitmBtr.WriteBegVal(pValue:double);
begin
  oBtrTable.FieldByName('BegVal').AsFloat := pValue;
end;

function TFsaitmBtr.ReadBegOvr:double;
begin
  Result := oBtrTable.FieldByName('BegOvr').AsFloat;
end;

procedure TFsaitmBtr.WriteBegOvr(pValue:double);
begin
  oBtrTable.FieldByName('BegOvr').AsFloat := pValue;
end;

function TFsaitmBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TFsaitmBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TFsaitmBtr.ReadEndIdc:Str10;
begin
  Result := oBtrTable.FieldByName('EndIdc').AsString;
end;

procedure TFsaitmBtr.WriteEndIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('EndIdc').AsString := pValue;
end;

function TFsaitmBtr.ReadEndPce:double;
begin
  Result := oBtrTable.FieldByName('EndPce').AsFloat;
end;

procedure TFsaitmBtr.WriteEndPce(pValue:double);
begin
  oBtrTable.FieldByName('EndPce').AsFloat := pValue;
end;

function TFsaitmBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TFsaitmBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TFsaitmBtr.ReadEndOvr:double;
begin
  Result := oBtrTable.FieldByName('EndOvr').AsFloat;
end;

procedure TFsaitmBtr.WriteEndOvr(pValue:double);
begin
  oBtrTable.FieldByName('EndOvr').AsFloat := pValue;
end;

function TFsaitmBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TFsaitmBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TFsaitmBtr.ReadPlnPce:double;
begin
  Result := oBtrTable.FieldByName('PlnPce').AsFloat;
end;

procedure TFsaitmBtr.WritePlnPce(pValue:double);
begin
  oBtrTable.FieldByName('PlnPce').AsFloat := pValue;
end;

function TFsaitmBtr.ReadPlnVal:double;
begin
  Result := oBtrTable.FieldByName('PlnVal').AsFloat;
end;

procedure TFsaitmBtr.WritePlnVal(pValue:double);
begin
  oBtrTable.FieldByName('PlnVal').AsFloat := pValue;
end;

function TFsaitmBtr.ReadPlnOvr:double;
begin
  Result := oBtrTable.FieldByName('PlnOvr').AsFloat;
end;

procedure TFsaitmBtr.WritePlnOvr(pValue:double);
begin
  oBtrTable.FieldByName('PlnOvr').AsFloat := pValue;
end;

function TFsaitmBtr.ReadPlnPrv:double;
begin
  Result := oBtrTable.FieldByName('PlnPrv').AsFloat;
end;

procedure TFsaitmBtr.WritePlnPrv(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrv').AsFloat := pValue;
end;

function TFsaitmBtr.ReadPlnPrp:double;
begin
  Result := oBtrTable.FieldByName('PlnPrp').AsFloat;
end;

procedure TFsaitmBtr.WritePlnPrp(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrp').AsFloat := pValue;
end;

function TFsaitmBtr.ReadReaPrv:double;
begin
  Result := oBtrTable.FieldByName('ReaPrv').AsFloat;
end;

procedure TFsaitmBtr.WriteReaPrv(pValue:double);
begin
  oBtrTable.FieldByName('ReaPrv').AsFloat := pValue;
end;

function TFsaitmBtr.ReadReaPrp:double;
begin
  Result := oBtrTable.FieldByName('ReaPrp').AsFloat;
end;

procedure TFsaitmBtr.WriteReaPrp(pValue:double);
begin
  oBtrTable.FieldByName('ReaPrp').AsFloat := pValue;
end;

function TFsaitmBtr.ReadDayQnt:word;
begin
  Result := oBtrTable.FieldByName('DayQnt').AsInteger;
end;

procedure TFsaitmBtr.WriteDayQnt(pValue:word);
begin
  oBtrTable.FieldByName('DayQnt').AsInteger := pValue;
end;

function TFsaitmBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TFsaitmBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsaitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsaitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsaitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsaitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsaitmBtr.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindKey([pSymbol]);
end;

function TFsaitmBtr.LocateBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindKey([pBegIdc]);
end;

function TFsaitmBtr.LocateEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindKey([pEndIdc]);
end;

function TFsaitmBtr.LocateUsrIdc (pUsrIdc:Str20):boolean;
begin
  SetIndex (ixUsrIdc);
  Result := oBtrTable.FindKey([pUsrIdc]);
end;

function TFsaitmBtr.NearestSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindNearest([pSymbol]);
end;

function TFsaitmBtr.NearestBegIdc (pBegIdc:Str10):boolean;
begin
  SetIndex (ixBegIdc);
  Result := oBtrTable.FindNearest([pBegIdc]);
end;

function TFsaitmBtr.NearestEndIdc (pEndIdc:Str10):boolean;
begin
  SetIndex (ixEndIdc);
  Result := oBtrTable.FindNearest([pEndIdc]);
end;

function TFsaitmBtr.NearestUsrIdc (pUsrIdc:Str20):boolean;
begin
  SetIndex (ixUsrIdc);
  Result := oBtrTable.FindNearest([pUsrIdc]);
end;

procedure TFsaitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsaitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsaitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsaitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsaitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsaitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsaitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsaitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsaitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsaitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsaitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsaitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsaitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsaitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsaitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsaitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsaitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
