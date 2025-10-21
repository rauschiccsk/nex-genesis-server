unit bFSABUF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBokNum = 'BokNum';
  ixSymbol = 'Symbol';
  ixTrnIdc = 'TrnIdc';
  ixTrnDate = 'TrnDate';
  ixUsrIdc = 'UsrIdc';
  ixBnTi = 'BnTi';

type
  TFsabufBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:word;           procedure WriteBokNum (pValue:word);
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
    function  ReadActPce:double;         procedure WriteActPce (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadActPrv:double;         procedure WriteActPrv (pValue:double);
    function  ReadActPrp:double;         procedure WriteActPrp (pValue:double);
    function  ReadPlnPce:double;         procedure WritePlnPce (pValue:double);
    function  ReadPlnVal:double;         procedure WritePlnVal (pValue:double);
    function  ReadPlnPrv:double;         procedure WritePlnPrv (pValue:double);
    function  ReadPlnPrp:double;         procedure WritePlnPrp (pValue:double);
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
    function LocateTrnIdc (pTrnIdc:Str10):boolean;
    function LocateTrnDate (pTrnDate:TDatetime):boolean;
    function LocateUsrIdc (pUsrIdc:Str20):boolean;
    function LocateBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestSymbol (pSymbol:Str6):boolean;
    function NearestTrnIdc (pTrnIdc:Str10):boolean;
    function NearestTrnDate (pTrnDate:TDatetime):boolean;
    function NearestUsrIdc (pUsrIdc:Str20):boolean;
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
    property ActPce:double read ReadActPce write WriteActPce;
    property ActVal:double read ReadActVal write WriteActVal;
    property ActPrv:double read ReadActPrv write WriteActPrv;
    property ActPrp:double read ReadActPrp write WriteActPrp;
    property PlnPce:double read ReadPlnPce write WritePlnPce;
    property PlnVal:double read ReadPlnVal write WritePlnVal;
    property PlnPrv:double read ReadPlnPrv write WritePlnPrv;
    property PlnPrp:double read ReadPlnPrp write WritePlnPrp;
  end;

implementation

constructor TFsabufBtr.Create;
begin
  oBtrTable := BtrInit ('FSABUF',gPath.CdwPath,Self);
end;

constructor TFsabufBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSABUF',pPath,Self);
end;

destructor TFsabufBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsabufBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsabufBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsabufBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsabufBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsabufBtr.ReadSymbol:Str6;
begin
  Result := oBtrTable.FieldByName('Symbol').AsString;
end;

procedure TFsabufBtr.WriteSymbol(pValue:Str6);
begin
  oBtrTable.FieldByName('Symbol').AsString := pValue;
end;

function TFsabufBtr.ReadActQnt:longint;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsInteger;
end;

procedure TFsabufBtr.WriteActQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ActQnt').AsInteger := pValue;
end;

function TFsabufBtr.ReadTrnDir:Str1;
begin
  Result := oBtrTable.FieldByName('TrnDir').AsString;
end;

procedure TFsabufBtr.WriteTrnDir(pValue:Str1);
begin
  oBtrTable.FieldByName('TrnDir').AsString := pValue;
end;

function TFsabufBtr.ReadTrnDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrnDate').AsDateTime;
end;

procedure TFsabufBtr.WriteTrnDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrnDate').AsDateTime := pValue;
end;

function TFsabufBtr.ReadTrnTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('TrnTime').AsDateTime;
end;

procedure TFsabufBtr.WriteTrnTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TrnTime').AsDateTime := pValue;
end;

function TFsabufBtr.ReadTrnPce:double;
begin
  Result := oBtrTable.FieldByName('TrnPce').AsFloat;
end;

procedure TFsabufBtr.WriteTrnPce(pValue:double);
begin
  oBtrTable.FieldByName('TrnPce').AsFloat := pValue;
end;

function TFsabufBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TFsabufBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TFsabufBtr.ReadTrnOvr:double;
begin
  Result := oBtrTable.FieldByName('TrnOvr').AsFloat;
end;

procedure TFsabufBtr.WriteTrnOvr(pValue:double);
begin
  oBtrTable.FieldByName('TrnOvr').AsFloat := pValue;
end;

function TFsabufBtr.ReadTrnIdc:Str10;
begin
  Result := oBtrTable.FieldByName('TrnIdc').AsString;
end;

procedure TFsabufBtr.WriteTrnIdc(pValue:Str10);
begin
  oBtrTable.FieldByName('TrnIdc').AsString := pValue;
end;

function TFsabufBtr.ReadUsrIdc:Str20;
begin
  Result := oBtrTable.FieldByName('UsrIdc').AsString;
end;

procedure TFsabufBtr.WriteUsrIdc(pValue:Str20);
begin
  oBtrTable.FieldByName('UsrIdc').AsString := pValue;
end;

function TFsabufBtr.ReadActPce:double;
begin
  Result := oBtrTable.FieldByName('ActPce').AsFloat;
end;

procedure TFsabufBtr.WriteActPce(pValue:double);
begin
  oBtrTable.FieldByName('ActPce').AsFloat := pValue;
end;

function TFsabufBtr.ReadActVal:double;
begin
  Result := oBtrTable.FieldByName('ActVal').AsFloat;
end;

procedure TFsabufBtr.WriteActVal(pValue:double);
begin
  oBtrTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TFsabufBtr.ReadActPrv:double;
begin
  Result := oBtrTable.FieldByName('ActPrv').AsFloat;
end;

procedure TFsabufBtr.WriteActPrv(pValue:double);
begin
  oBtrTable.FieldByName('ActPrv').AsFloat := pValue;
end;

function TFsabufBtr.ReadActPrp:double;
begin
  Result := oBtrTable.FieldByName('ActPrp').AsFloat;
end;

procedure TFsabufBtr.WriteActPrp(pValue:double);
begin
  oBtrTable.FieldByName('ActPrp').AsFloat := pValue;
end;

function TFsabufBtr.ReadPlnPce:double;
begin
  Result := oBtrTable.FieldByName('PlnPce').AsFloat;
end;

procedure TFsabufBtr.WritePlnPce(pValue:double);
begin
  oBtrTable.FieldByName('PlnPce').AsFloat := pValue;
end;

function TFsabufBtr.ReadPlnVal:double;
begin
  Result := oBtrTable.FieldByName('PlnVal').AsFloat;
end;

procedure TFsabufBtr.WritePlnVal(pValue:double);
begin
  oBtrTable.FieldByName('PlnVal').AsFloat := pValue;
end;

function TFsabufBtr.ReadPlnPrv:double;
begin
  Result := oBtrTable.FieldByName('PlnPrv').AsFloat;
end;

procedure TFsabufBtr.WritePlnPrv(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrv').AsFloat := pValue;
end;

function TFsabufBtr.ReadPlnPrp:double;
begin
  Result := oBtrTable.FieldByName('PlnPrp').AsFloat;
end;

procedure TFsabufBtr.WritePlnPrp(pValue:double);
begin
  oBtrTable.FieldByName('PlnPrp').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsabufBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsabufBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsabufBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsabufBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsabufBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsabufBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsabufBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsabufBtr.LocateSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindKey([pSymbol]);
end;

function TFsabufBtr.LocateTrnIdc (pTrnIdc:Str10):boolean;
begin
  SetIndex (ixTrnIdc);
  Result := oBtrTable.FindKey([pTrnIdc]);
end;

function TFsabufBtr.LocateTrnDate (pTrnDate:TDatetime):boolean;
begin
  SetIndex (ixTrnDate);
  Result := oBtrTable.FindKey([pTrnDate]);
end;

function TFsabufBtr.LocateUsrIdc (pUsrIdc:Str20):boolean;
begin
  SetIndex (ixUsrIdc);
  Result := oBtrTable.FindKey([pUsrIdc]);
end;

function TFsabufBtr.LocateBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
begin
  SetIndex (ixBnTi);
  Result := oBtrTable.FindKey([pBokNum,pTrnIdc]);
end;

function TFsabufBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsabufBtr.NearestSymbol (pSymbol:Str6):boolean;
begin
  SetIndex (ixSymbol);
  Result := oBtrTable.FindNearest([pSymbol]);
end;

function TFsabufBtr.NearestTrnIdc (pTrnIdc:Str10):boolean;
begin
  SetIndex (ixTrnIdc);
  Result := oBtrTable.FindNearest([pTrnIdc]);
end;

function TFsabufBtr.NearestTrnDate (pTrnDate:TDatetime):boolean;
begin
  SetIndex (ixTrnDate);
  Result := oBtrTable.FindNearest([pTrnDate]);
end;

function TFsabufBtr.NearestUsrIdc (pUsrIdc:Str20):boolean;
begin
  SetIndex (ixUsrIdc);
  Result := oBtrTable.FindNearest([pUsrIdc]);
end;

function TFsabufBtr.NearestBnTi (pBokNum:word;pTrnIdc:Str10):boolean;
begin
  SetIndex (ixBnTi);
  Result := oBtrTable.FindNearest([pBokNum,pTrnIdc]);
end;

procedure TFsabufBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsabufBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsabufBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsabufBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsabufBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsabufBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsabufBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsabufBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsabufBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsabufBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsabufBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsabufBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsabufBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsabufBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsabufBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsabufBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsabufBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
