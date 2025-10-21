unit bFINJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixAsAa = 'AsAa';
  ixAccText = 'AccText';
  ixAcValue = 'AcValue';
  ixCndNum = 'CndNum';
  ixCneNum = 'CneNum';

type
  TFinjrnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadAccText:Str30;         procedure WriteAccText (pValue:Str30);
    function  ReadAccText_:Str30;        procedure WriteAccText_ (pValue:Str30);
    function  ReadAcValue:double;        procedure WriteAcValue (pValue:double);
    function  ReadFgValue:double;        procedure WriteFgValue (pValue:double);
    function  ReadCndNum:Str12;          procedure WriteCndNum (pValue:Str12);
    function  ReadCneNum:Str12;          procedure WriteCneNum (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadFjrRow:byte;           procedure WriteFjrRow (pValue:byte);
    function  ReadOpType:Str1;           procedure WriteOpType (pValue:Str1);
    function  ReadStatus:byte;           procedure WriteStatus (pValue:byte);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadDocDes:Str60;          procedure WriteDocDes (pValue:Str60);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocateAccText (pAccText_:Str30):boolean;
    function LocateAcValue (pAcValue:double):boolean;
    function LocateCndNum (pCndNum:Str12):boolean;
    function LocateCneNum (pCneNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearestAccText (pAccText_:Str30):boolean;
    function NearestAcValue (pAcValue:double):boolean;
    function NearestCndNum (pCndNum:Str12):boolean;
    function NearestCneNum (pCneNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property AccText:Str30 read ReadAccText write WriteAccText;
    property AccText_:Str30 read ReadAccText_ write WriteAccText_;
    property AcValue:double read ReadAcValue write WriteAcValue;
    property FgValue:double read ReadFgValue write WriteFgValue;
    property CndNum:Str12 read ReadCndNum write WriteCndNum;
    property CneNum:Str12 read ReadCneNum write WriteCneNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property FjrRow:byte read ReadFjrRow write WriteFjrRow;
    property OpType:Str1 read ReadOpType write WriteOpType;
    property Status:byte read ReadStatus write WriteStatus;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property PaName:Str60 read ReadPaName write WritePaName;
    property DocDes:Str60 read ReadDocDes write WriteDocDes;
  end;

implementation

constructor TFinjrnBtr.Create;
begin
  oBtrTable := BtrInit ('FINJRN',gPath.LdgPath,Self);
end;

constructor TFinjrnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FINJRN',pPath,Self);
end;

destructor TFinjrnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFinjrnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFinjrnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFinjrnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFinjrnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFinjrnBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFinjrnBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFinjrnBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TFinjrnBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TFinjrnBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFinjrnBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFinjrnBtr.ReadAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TFinjrnBtr.WriteAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TFinjrnBtr.ReadAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('AccAnl').AsString;
end;

procedure TFinjrnBtr.WriteAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('AccAnl').AsString := pValue;
end;

function TFinjrnBtr.ReadAccText:Str30;
begin
  Result := oBtrTable.FieldByName('AccText').AsString;
end;

procedure TFinjrnBtr.WriteAccText(pValue:Str30);
begin
  oBtrTable.FieldByName('AccText').AsString := pValue;
end;

function TFinjrnBtr.ReadAccText_:Str30;
begin
  Result := oBtrTable.FieldByName('AccText_').AsString;
end;

procedure TFinjrnBtr.WriteAccText_(pValue:Str30);
begin
  oBtrTable.FieldByName('AccText_').AsString := pValue;
end;

function TFinjrnBtr.ReadAcValue:double;
begin
  Result := oBtrTable.FieldByName('AcValue').AsFloat;
end;

procedure TFinjrnBtr.WriteAcValue(pValue:double);
begin
  oBtrTable.FieldByName('AcValue').AsFloat := pValue;
end;

function TFinjrnBtr.ReadFgValue:double;
begin
  Result := oBtrTable.FieldByName('FgValue').AsFloat;
end;

procedure TFinjrnBtr.WriteFgValue(pValue:double);
begin
  oBtrTable.FieldByName('FgValue').AsFloat := pValue;
end;

function TFinjrnBtr.ReadCndNum:Str12;
begin
  Result := oBtrTable.FieldByName('CndNum').AsString;
end;

procedure TFinjrnBtr.WriteCndNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CndNum').AsString := pValue;
end;

function TFinjrnBtr.ReadCneNum:Str12;
begin
  Result := oBtrTable.FieldByName('CneNum').AsString;
end;

procedure TFinjrnBtr.WriteCneNum(pValue:Str12);
begin
  oBtrTable.FieldByName('CneNum').AsString := pValue;
end;

function TFinjrnBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TFinjrnBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFinjrnBtr.ReadFjrRow:byte;
begin
  Result := oBtrTable.FieldByName('FjrRow').AsInteger;
end;

procedure TFinjrnBtr.WriteFjrRow(pValue:byte);
begin
  oBtrTable.FieldByName('FjrRow').AsInteger := pValue;
end;

function TFinjrnBtr.ReadOpType:Str1;
begin
  Result := oBtrTable.FieldByName('OpType').AsString;
end;

procedure TFinjrnBtr.WriteOpType(pValue:Str1);
begin
  oBtrTable.FieldByName('OpType').AsString := pValue;
end;

function TFinjrnBtr.ReadStatus:byte;
begin
  Result := oBtrTable.FieldByName('Status').AsInteger;
end;

procedure TFinjrnBtr.WriteStatus(pValue:byte);
begin
  oBtrTable.FieldByName('Status').AsInteger := pValue;
end;

function TFinjrnBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFinjrnBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFinjrnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFinjrnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFinjrnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFinjrnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFinjrnBtr.ReadPaName:Str60;
begin
  Result:=oBtrTable.FieldByName('PaName').AsString;
end;

procedure TFinjrnBtr.WritePaName(pValue:Str60);
begin
  oBtrTable.FieldByName('PaName').AsString:=pValue;
end;

function TFinjrnBtr.ReadDocDes:Str60;
begin
  Result:=oBtrTable.FieldByName('DocDes').AsString;
end;

procedure TFinjrnBtr.WriteDocDes(pValue:Str60);
begin
  oBtrTable.FieldByName('DocDes').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TFinjrnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFinjrnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFinjrnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFinjrnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFinjrnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFinjrnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFinjrnBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TFinjrnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFinjrnBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TFinjrnBtr.LocateAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAa);
  Result := oBtrTable.FindKey([pAccSnt,pAccAnl]);
end;

function TFinjrnBtr.LocateAccText (pAccText_:Str30):boolean;
begin
  SetIndex (ixAccText);
  Result := oBtrTable.FindKey([StrToAlias(pAccText_)]);
end;

function TFinjrnBtr.LocateAcValue (pAcValue:double):boolean;
begin
  SetIndex (ixAcValue);
  Result := oBtrTable.FindKey([pAcValue]);
end;

function TFinjrnBtr.LocateCndNum (pCndNum:Str12):boolean;
begin
  SetIndex (ixCndNum);
  Result := oBtrTable.FindKey([pCndNum]);
end;

function TFinjrnBtr.LocateCneNum (pCneNum:Str12):boolean;
begin
  SetIndex (ixCneNum);
  Result := oBtrTable.FindKey([pCneNum]);
end;

function TFinjrnBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TFinjrnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFinjrnBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TFinjrnBtr.NearestAsAa (pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAa);
  Result := oBtrTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TFinjrnBtr.NearestAccText (pAccText_:Str30):boolean;
begin
  SetIndex (ixAccText);
  Result := oBtrTable.FindNearest([pAccText_]);
end;

function TFinjrnBtr.NearestAcValue (pAcValue:double):boolean;
begin
  SetIndex (ixAcValue);
  Result := oBtrTable.FindNearest([pAcValue]);
end;

function TFinjrnBtr.NearestCndNum (pCndNum:Str12):boolean;
begin
  SetIndex (ixCndNum);
  Result := oBtrTable.FindNearest([pCndNum]);
end;

function TFinjrnBtr.NearestCneNum (pCneNum:Str12):boolean;
begin
  SetIndex (ixCneNum);
  Result := oBtrTable.FindNearest([pCneNum]);
end;

procedure TFinjrnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFinjrnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFinjrnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFinjrnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFinjrnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFinjrnBtr.First;
begin
  oBtrTable.First;
end;

procedure TFinjrnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFinjrnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFinjrnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFinjrnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFinjrnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFinjrnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFinjrnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFinjrnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFinjrnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFinjrnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFinjrnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
