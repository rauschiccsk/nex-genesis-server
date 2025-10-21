unit bFSAARC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBnAn = 'BnAn';
  ixBokNum = 'BokNum';
  ixSymbol = 'Symbol';
  ixTrnIdc = 'TrnIdc';
  ixTrnDate = 'TrnDate';
  ixBnTi = 'BnTi';

type
  TFsaarcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:word;           procedure WriteBokNum (pValue:word);
    function  ReadArcNum:longint;        procedure WriteArcNum (pValue:longint);
    function  ReadSymbol:Str6;           procedure WriteSymbol (pValue:Str6);
    function  ReadActQnt:longint;        procedure WriteActQnt (pValue:longint);
    function  ReadTrnDir:Str1;           procedure WriteTrnDir (pValue:Str1);
    function  ReadTrnDate:TDatetime;     procedure WriteTrnDate (pValue:TDatetime);
    function  ReadTrnTime:TDatetime;     procedure WriteTrnTime (pValue:TDatetime);
    function  ReadTrnPce:double;         procedure WriteTrnPce (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadTrnOvr:double;         procedure WriteTrnOvr (pValue:double);
    function  ReadTrnIdc:Str10;          procedure WriteTrnIdc (pValue:Str10);
    function  ReadUsrIdc:Str20;          procedure WriteUsrIdc (pValue:Str20);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBnAn (pBokNum:word;pArcNum:longint):boolean;
    function LocateBokNum (pBokNum:word):boolean;
    function LocateSymbol (pSymbol:Str6):boolean;
    function LocateTrnIdc (pTrnIdc:Str10):boolean;
    function LocateTrnDate (pTrnDate:TDatetime):boolean;
    function LocateBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
    function NearestBnAn (pBokNum:word;pArcNum:longint):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestSymbol (pSymbol:Str6):boolean;
    function NearestTrnIdc (pTrnIdc:Str10):boolean;
    function NearestTrnDate (pTrnDate:TDatetime):boolean;
    function NearestBnTi (pBokNum:word;pTrnIdc:Str10):boolean;

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
    property ArcNum:longint read ReadArcNum write WriteArcNum;
    property Symbol:Str6 read ReadSymbol write WriteSymbol;
    property ActQnt:longint read ReadActQnt write WriteActQnt;
    property TrnDir:Str1 read ReadTrnDir write WriteTrnDir;
    property TrnDate:TDatetime read ReadTrnDate write WriteTrnDate;
    property TrnTime:TDatetime read ReadTrnTime write WriteTrnTime;
    property TrnPce:double read ReadTrnPce write WriteTrnPce;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property TrnOvr:double read ReadTrnOvr write WriteTrnOvr;
    property TrnIdc:Str10 read ReadTrnIdc write WriteTrnIdc;
    property UsrIdc:Str20 read ReadUsrIdc write WriteUsrIdc;
  end;

implementation

constructor TFsaarcBtr.Create;
begin
  oBtrTable := BtrInit ('FSAARC',gPath.CdwPath,Self);
end;

constructor TFsaarcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSAARC',pPath,Self);
end;

destructor TFsaarcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsaarcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsaarcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsaarcBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsaarcBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsaarcBtr.ReadArcNum:longint;
begin
  Result := oBtrTable.FieldByName('ArcNum').AsInteger;
end;

procedure TFsaarcBtr.WriteArcNum(pValue:longint);
begin
  oBtrTable.FieldByName('ArcNum').AsInteger := pValue;
end;

function TFsaarcBtr.ReadSymbol:Str6;
begin
  Result := oBtrTable.FieldByName('Symbol').AsString;
end;

procedure TFsaarcBtr.WriteSymbol(pValue:Str6);
begin
  oBtrTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsaarcBtr.ReadActQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsaarcBtr.WriteActQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsaarcBtr.ReadTrnDir:Str1;
begin
  Result := oBtrTable.FieldByName('TrnDir').AsString;
end;

procedure TFsaarcBtr.WriteTrnDir(pValue:Str1);
begin
  oBtrTable.FieldByName('TrnDir').AsString := pValue;
end;

function TFsaarcBtr.ReadTrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrnDate').AsDateTime;
end;

procedure TFsaarcBtr.WriteTrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrnDate').AsDateTime := pValue;
end;

function TFsaarcBtr.ReadTrnTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrnTime').AsDateTime;
end;

procedure TFsaarcBtr.WriteTrnTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrnTime').AsDateTime := pValue;
end;

function TFsaarcBtr.ReadTrnPce:double;
begin
  Result := oBtrTable.FieldByName('TrnPce').AsFloat;
end;

procedure TFsaarcBtr.WriteTrnPce(pValue:double);
begin
  oBtrTable.FieldByName('TrnPce').AsFloat := pValue;
end;

function TFsaarcBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TFsaarcBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TFsaarcBtr.ReadTrnOvr:double;
begin
  Result := oBtrTable.FieldByName('TrnOvr').AsFloat;
end;

procedure TFsaarcBtr.WriteTrnOvr(pValue:double);
begin
  oBtrTable.FieldByName('TrnOvr').AsFloat := pValue;
end;

function TFsaarcBtr.ReadTrnIdc:Str10;
begin
  Result := oBtrTable.FieldByName('TrnIdc').AsString;
end;

procedure TFsaarcBtr.WriteTrnIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('TrnIdc').AsString := pValue;
end;

function TFsaarcBtr.ReadUsrIdc:Str20;
begin
  Result := oBtrTable.FieldByName('UsrIdc').AsString;
end;

procedure TFsaarcBtr.WriteUsrIdc(pValue:Str20);
begin
  oBtrTable.FieldByName('UsrIdc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsaarcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaarcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsaarcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsaarcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsaarcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsaarcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsaarcBtr.LocateBnAn (pBokNum:word;pArcNum:longint):boolean;
begin
  SetIndex (ixBnAn);
  Result := oBtrTable.FindKey([pBokNum,pArcNum]);
end;

function TFsaarcBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsaarcBtr.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindKey([pSymbol]);
end;

function TFsaarcBtr.LocateTrnIdc (pTrnIdc:Str10):boolean;
begin
  SetIndex (ixTrnIdc);
  Result := oBtrTable.FindKey([pTrnIdc]);
end;

function TFsaarcBtr.LocateTrnDate (pTrnDate:TDatetime):boolean;
begin
  SetIndex (ixTrnDate);
  Result := oBtrTable.FindKey([pTrnDate]);
end;

function TFsaarcBtr.LocateBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
begin
  SetIndex (ixBnTi);
  Result := oBtrTable.FindKey([pBokNum,pTrnIdc]);
end;

function TFsaarcBtr.NearestBnAn (pBokNum:word;pArcNum:longint):boolean;
begin
  SetIndex (ixBnAn);
  Result := oBtrTable.FindNearest([pBokNum,pArcNum]);
end;

function TFsaarcBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsaarcBtr.NearestSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindNearest([pSymbol]);
end;

function TFsaarcBtr.NearestTrnIdc (pTrnIdc:Str10):boolean;
begin
  SetIndex (ixTrnIdc);
  Result := oBtrTable.FindNearest([pTrnIdc]);
end;

function TFsaarcBtr.NearestTrnDate (pTrnDate:TDatetime):boolean;
begin
  SetIndex (ixTrnDate);
  Result := oBtrTable.FindNearest([pTrnDate]);
end;

function TFsaarcBtr.NearestBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
begin
  SetIndex (ixBnTi);
  Result := oBtrTable.FindNearest([pBokNum,pTrnIdc]);
end;

procedure TFsaarcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsaarcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsaarcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsaarcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsaarcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsaarcBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsaarcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsaarcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsaarcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsaarcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsaarcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsaarcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsaarcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsaarcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsaarcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsaarcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsaarcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
