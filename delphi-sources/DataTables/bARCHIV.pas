unit bARCHIV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixArcNum = 'ArcNum';
  ixArcDat = 'ArcDat';
  ixArcDes = 'ArcDes';
  ixFizNum = 'FizNum';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixExpDat = 'ExpDat';
  ixAccess = 'Access';
  ixAssign = 'Assign';
  ixBok001 = 'Bok001';
  ixBok002 = 'Bok002';
  ixBok003 = 'Bok003';
  ixBok004 = 'Bok004';
  ixBok005 = 'Bok005';
  ixBok006 = 'Bok006';
  ixBok007 = 'Bok007';
  ixBok008 = 'Bok008';
  ixBok009 = 'Bok009';
  ixBok010 = 'Bok010';
  ixBok011 = 'Bok011';
  ixBok012 = 'Bok012';
  ixBok013 = 'Bok013';
  ixBok014 = 'Bok014';
  ixBok015 = 'Bok015';

type
  TArchivBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadArcNum:longint;        procedure WriteArcNum (pValue:longint);
    function  ReadArcDat:TDatetime;      procedure WriteArcDat (pValue:TDatetime);
    function  ReadArcDes:Str200;         procedure WriteArcDes (pValue:Str200);
    function  ReadArcDes_:Str200;        procedure WriteArcDes_ (pValue:Str200);
    function  ReadFizNum:Str10;          procedure WriteFizNum (pValue:Str10);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtnum:Str30;          procedure WriteExtnum (pValue:Str30);
    function  ReadExpDat:TDatetime;      procedure WriteExpDat (pValue:TDatetime);
    function  ReadWebAdr:Str200;         procedure WriteWebAdr (pValue:Str200);
    function  ReadAccess:Str1;           procedure WriteAccess (pValue:Str1);
    function  ReadAssign:Str1;           procedure WriteAssign (pValue:Str1);
    function  ReadAtcNum:word;           procedure WriteAtcNum (pValue:word);
    function  ReadDocTyp:Str1;           procedure WriteDocTyp (pValue:Str1);
    function  ReadBok001:byte;           procedure WriteBok001 (pValue:byte);
    function  ReadBok002:byte;           procedure WriteBok002 (pValue:byte);
    function  ReadBok003:byte;           procedure WriteBok003 (pValue:byte);
    function  ReadBok004:byte;           procedure WriteBok004 (pValue:byte);
    function  ReadBok005:byte;           procedure WriteBok005 (pValue:byte);
    function  ReadBok006:byte;           procedure WriteBok006 (pValue:byte);
    function  ReadBok007:byte;           procedure WriteBok007 (pValue:byte);
    function  ReadBok008:byte;           procedure WriteBok008 (pValue:byte);
    function  ReadBok009:byte;           procedure WriteBok009 (pValue:byte);
    function  ReadBok010:byte;           procedure WriteBok010 (pValue:byte);
    function  ReadBok011:byte;           procedure WriteBok011 (pValue:byte);
    function  ReadBok012:byte;           procedure WriteBok012 (pValue:byte);
    function  ReadBok013:byte;           procedure WriteBok013 (pValue:byte);
    function  ReadBok014:byte;           procedure WriteBok014 (pValue:byte);
    function  ReadBok015:byte;           procedure WriteBok015 (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateArcNum (pArcNum:longint):boolean;
    function LocateArcDat (pArcDat:TDatetime):boolean;
    function LocateArcDes (pArcDes_:Str200):boolean;
    function LocateFizNum (pFizNum:Str10):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str30):boolean;
    function LocateExpDat (pExpDat:TDatetime):boolean;
    function LocateAccess (pAccess:Str1):boolean;
    function LocateAssign (pAssign:Str1):boolean;
    function LocateBok001 (pBok001:byte):boolean;
    function LocateBok002 (pBok002:byte):boolean;
    function LocateBok003 (pBok003:byte):boolean;
    function LocateBok004 (pBok004:byte):boolean;
    function LocateBok005 (pBok005:byte):boolean;
    function LocateBok006 (pBok006:byte):boolean;
    function LocateBok007 (pBok007:byte):boolean;
    function LocateBok008 (pBok008:byte):boolean;
    function LocateBok009 (pBok009:byte):boolean;
    function LocateBok010 (pBok010:byte):boolean;
    function LocateBok011 (pBok011:byte):boolean;
    function LocateBok012 (pBok012:byte):boolean;
    function LocateBok013 (pBok013:byte):boolean;
    function LocateBok014 (pBok014:byte):boolean;
    function LocateBok015 (pBok015:byte):boolean;
    function NearestArcNum (pArcNum:longint):boolean;
    function NearestArcDat (pArcDat:TDatetime):boolean;
    function NearestArcDes (pArcDes_:Str200):boolean;
    function NearestFizNum (pFizNum:Str10):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str30):boolean;
    function NearestExpDat (pExpDat:TDatetime):boolean;
    function NearestAccess (pAccess:Str1):boolean;
    function NearestAssign (pAssign:Str1):boolean;
    function NearestBok001 (pBok001:byte):boolean;
    function NearestBok002 (pBok002:byte):boolean;
    function NearestBok003 (pBok003:byte):boolean;
    function NearestBok004 (pBok004:byte):boolean;
    function NearestBok005 (pBok005:byte):boolean;
    function NearestBok006 (pBok006:byte):boolean;
    function NearestBok007 (pBok007:byte):boolean;
    function NearestBok008 (pBok008:byte):boolean;
    function NearestBok009 (pBok009:byte):boolean;
    function NearestBok010 (pBok010:byte):boolean;
    function NearestBok011 (pBok011:byte):boolean;
    function NearestBok012 (pBok012:byte):boolean;
    function NearestBok013 (pBok013:byte):boolean;
    function NearestBok014 (pBok014:byte):boolean;
    function NearestBok015 (pBok015:byte):boolean;

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
    property ArcNum:longint read ReadArcNum write WriteArcNum;
    property ArcDat:TDatetime read ReadArcDat write WriteArcDat;
    property ArcDes:Str200 read ReadArcDes write WriteArcDes;
    property ArcDes_:Str200 read ReadArcDes_ write WriteArcDes_;
    property FizNum:Str10 read ReadFizNum write WriteFizNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Extnum:Str30 read ReadExtnum write WriteExtnum;
    property ExpDat:TDatetime read ReadExpDat write WriteExpDat;
    property WebAdr:Str200 read ReadWebAdr write WriteWebAdr;
    property Access:Str1 read ReadAccess write WriteAccess;
    property Assign:Str1 read ReadAssign write WriteAssign;
    property AtcNum:word read ReadAtcNum write WriteAtcNum;
    property DocTyp:Str1 read ReadDocTyp write WriteDocTyp;
    property Bok001:byte read ReadBok001 write WriteBok001;
    property Bok002:byte read ReadBok002 write WriteBok002;
    property Bok003:byte read ReadBok003 write WriteBok003;
    property Bok004:byte read ReadBok004 write WriteBok004;
    property Bok005:byte read ReadBok005 write WriteBok005;
    property Bok006:byte read ReadBok006 write WriteBok006;
    property Bok007:byte read ReadBok007 write WriteBok007;
    property Bok008:byte read ReadBok008 write WriteBok008;
    property Bok009:byte read ReadBok009 write WriteBok009;
    property Bok010:byte read ReadBok010 write WriteBok010;
    property Bok011:byte read ReadBok011 write WriteBok011;
    property Bok012:byte read ReadBok012 write WriteBok012;
    property Bok013:byte read ReadBok013 write WriteBok013;
    property Bok014:byte read ReadBok014 write WriteBok014;
    property Bok015:byte read ReadBok015 write WriteBok015;
  end;

implementation

constructor TArchivBtr.Create;
begin
  oBtrTable := BtrInit ('ARCHIV',gPath.ArcPath,Self);
end;

constructor TArchivBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ARCHIV',pPath,Self);
end;

destructor TArchivBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TArchivBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TArchivBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TArchivBtr.ReadArcNum:longint;
begin
  Result := oBtrTable.FieldByName('ArcNum').AsInteger;
end;

procedure TArchivBtr.WriteArcNum(pValue:longint);
begin
  oBtrTable.FieldByName('ArcNum').AsInteger := pValue;
end;

function TArchivBtr.ReadArcDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ArcDat').AsDateTime;
end;

procedure TArchivBtr.WriteArcDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ArcDat').AsDateTime := pValue;
end;

function TArchivBtr.ReadArcDes:Str200;
begin
  Result := oBtrTable.FieldByName('ArcDes').AsString;
end;

procedure TArchivBtr.WriteArcDes(pValue:Str200);
begin
  oBtrTable.FieldByName('ArcDes').AsString := pValue;
end;

function TArchivBtr.ReadArcDes_:Str200;
begin
  Result := oBtrTable.FieldByName('ArcDes_').AsString;
end;

procedure TArchivBtr.WriteArcDes_(pValue:Str200);
begin
  oBtrTable.FieldByName('ArcDes_').AsString := pValue;
end;

function TArchivBtr.ReadFizNum:Str10;
begin
  Result := oBtrTable.FieldByName('FizNum').AsString;
end;

procedure TArchivBtr.WriteFizNum(pValue:Str10);
begin
  oBtrTable.FieldByName('FizNum').AsString := pValue;
end;

function TArchivBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TArchivBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TArchivBtr.ReadExtnum:Str30;
begin
  Result := oBtrTable.FieldByName('Extnum').AsString;
end;

procedure TArchivBtr.WriteExtnum(pValue:Str30);
begin
  oBtrTable.FieldByName('Extnum').AsString := pValue;
end;

function TArchivBtr.ReadExpDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDat').AsDateTime;
end;

procedure TArchivBtr.WriteExpDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDat').AsDateTime := pValue;
end;

function TArchivBtr.ReadWebAdr:Str200;
begin
  Result := oBtrTable.FieldByName('WebAdr').AsString;
end;

procedure TArchivBtr.WriteWebAdr(pValue:Str200);
begin
  oBtrTable.FieldByName('WebAdr').AsString := pValue;
end;

function TArchivBtr.ReadAccess:Str1;
begin
  Result := oBtrTable.FieldByName('Access').AsString;
end;

procedure TArchivBtr.WriteAccess(pValue:Str1);
begin
  oBtrTable.FieldByName('Access').AsString := pValue;
end;

function TArchivBtr.ReadAssign:Str1;
begin
  Result := oBtrTable.FieldByName('Assign').AsString;
end;

procedure TArchivBtr.WriteAssign(pValue:Str1);
begin
  oBtrTable.FieldByName('Assign').AsString := pValue;
end;

function TArchivBtr.ReadAtcNum:word;
begin
  Result := oBtrTable.FieldByName('AtcNum').AsInteger;
end;

procedure TArchivBtr.WriteAtcNum(pValue:word);
begin
  oBtrTable.FieldByName('AtcNum').AsInteger := pValue;
end;

function TArchivBtr.ReadDocTyp:Str1;
begin
  Result := oBtrTable.FieldByName('DocTyp').AsString;
end;

procedure TArchivBtr.WriteDocTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('DocTyp').AsString := pValue;
end;

function TArchivBtr.ReadBok001:byte;
begin
  Result := oBtrTable.FieldByName('Bok001').AsInteger;
end;

procedure TArchivBtr.WriteBok001(pValue:byte);
begin
  oBtrTable.FieldByName('Bok001').AsInteger := pValue;
end;

function TArchivBtr.ReadBok002:byte;
begin
  Result := oBtrTable.FieldByName('Bok002').AsInteger;
end;

procedure TArchivBtr.WriteBok002(pValue:byte);
begin
  oBtrTable.FieldByName('Bok002').AsInteger := pValue;
end;

function TArchivBtr.ReadBok003:byte;
begin
  Result := oBtrTable.FieldByName('Bok003').AsInteger;
end;

procedure TArchivBtr.WriteBok003(pValue:byte);
begin
  oBtrTable.FieldByName('Bok003').AsInteger := pValue;
end;

function TArchivBtr.ReadBok004:byte;
begin
  Result := oBtrTable.FieldByName('Bok004').AsInteger;
end;

procedure TArchivBtr.WriteBok004(pValue:byte);
begin
  oBtrTable.FieldByName('Bok004').AsInteger := pValue;
end;

function TArchivBtr.ReadBok005:byte;
begin
  Result := oBtrTable.FieldByName('Bok005').AsInteger;
end;

procedure TArchivBtr.WriteBok005(pValue:byte);
begin
  oBtrTable.FieldByName('Bok005').AsInteger := pValue;
end;

function TArchivBtr.ReadBok006:byte;
begin
  Result := oBtrTable.FieldByName('Bok006').AsInteger;
end;

procedure TArchivBtr.WriteBok006(pValue:byte);
begin
  oBtrTable.FieldByName('Bok006').AsInteger := pValue;
end;

function TArchivBtr.ReadBok007:byte;
begin
  Result := oBtrTable.FieldByName('Bok007').AsInteger;
end;

procedure TArchivBtr.WriteBok007(pValue:byte);
begin
  oBtrTable.FieldByName('Bok007').AsInteger := pValue;
end;

function TArchivBtr.ReadBok008:byte;
begin
  Result := oBtrTable.FieldByName('Bok008').AsInteger;
end;

procedure TArchivBtr.WriteBok008(pValue:byte);
begin
  oBtrTable.FieldByName('Bok008').AsInteger := pValue;
end;

function TArchivBtr.ReadBok009:byte;
begin
  Result := oBtrTable.FieldByName('Bok009').AsInteger;
end;

procedure TArchivBtr.WriteBok009(pValue:byte);
begin
  oBtrTable.FieldByName('Bok009').AsInteger := pValue;
end;

function TArchivBtr.ReadBok010:byte;
begin
  Result := oBtrTable.FieldByName('Bok010').AsInteger;
end;

procedure TArchivBtr.WriteBok010(pValue:byte);
begin
  oBtrTable.FieldByName('Bok010').AsInteger := pValue;
end;

function TArchivBtr.ReadBok011:byte;
begin
  Result := oBtrTable.FieldByName('Bok011').AsInteger;
end;

procedure TArchivBtr.WriteBok011(pValue:byte);
begin
  oBtrTable.FieldByName('Bok011').AsInteger := pValue;
end;

function TArchivBtr.ReadBok012:byte;
begin
  Result := oBtrTable.FieldByName('Bok012').AsInteger;
end;

procedure TArchivBtr.WriteBok012(pValue:byte);
begin
  oBtrTable.FieldByName('Bok012').AsInteger := pValue;
end;

function TArchivBtr.ReadBok013:byte;
begin
  Result := oBtrTable.FieldByName('Bok013').AsInteger;
end;

procedure TArchivBtr.WriteBok013(pValue:byte);
begin
  oBtrTable.FieldByName('Bok013').AsInteger := pValue;
end;

function TArchivBtr.ReadBok014:byte;
begin
  Result := oBtrTable.FieldByName('Bok014').AsInteger;
end;

procedure TArchivBtr.WriteBok014(pValue:byte);
begin
  oBtrTable.FieldByName('Bok014').AsInteger := pValue;
end;

function TArchivBtr.ReadBok015:byte;
begin
  Result := oBtrTable.FieldByName('Bok015').AsInteger;
end;

procedure TArchivBtr.WriteBok015(pValue:byte);
begin
  oBtrTable.FieldByName('Bok015').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TArchivBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TArchivBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TArchivBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TArchivBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TArchivBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TArchivBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TArchivBtr.LocateArcNum (pArcNum:longint):boolean;
begin
  SetIndex (ixArcNum);
  Result := oBtrTable.FindKey([pArcNum]);
end;

function TArchivBtr.LocateArcDat (pArcDat:TDatetime):boolean;
begin
  SetIndex (ixArcDat);
  Result := oBtrTable.FindKey([pArcDat]);
end;

function TArchivBtr.LocateArcDes (pArcDes_:Str200):boolean;
begin
  SetIndex (ixArcDes);
  Result := oBtrTable.FindKey([StrToAlias(pArcDes_)]);
end;

function TArchivBtr.LocateFizNum (pFizNum:Str10):boolean;
begin
  SetIndex (ixFizNum);
  Result := oBtrTable.FindKey([pFizNum]);
end;

function TArchivBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TArchivBtr.LocateExtNum (pExtNum:Str30):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TArchivBtr.LocateExpDat (pExpDat:TDatetime):boolean;
begin
  SetIndex (ixExpDat);
  Result := oBtrTable.FindKey([pExpDat]);
end;

function TArchivBtr.LocateAccess (pAccess:Str1):boolean;
begin
  SetIndex (ixAccess);
  Result := oBtrTable.FindKey([pAccess]);
end;

function TArchivBtr.LocateAssign (pAssign:Str1):boolean;
begin
  SetIndex (ixAssign);
  Result := oBtrTable.FindKey([pAssign]);
end;

function TArchivBtr.LocateBok001 (pBok001:byte):boolean;
begin
  SetIndex (ixBok001);
  Result := oBtrTable.FindKey([pBok001]);
end;

function TArchivBtr.LocateBok002 (pBok002:byte):boolean;
begin
  SetIndex (ixBok002);
  Result := oBtrTable.FindKey([pBok002]);
end;

function TArchivBtr.LocateBok003 (pBok003:byte):boolean;
begin
  SetIndex (ixBok003);
  Result := oBtrTable.FindKey([pBok003]);
end;

function TArchivBtr.LocateBok004 (pBok004:byte):boolean;
begin
  SetIndex (ixBok004);
  Result := oBtrTable.FindKey([pBok004]);
end;

function TArchivBtr.LocateBok005 (pBok005:byte):boolean;
begin
  SetIndex (ixBok005);
  Result := oBtrTable.FindKey([pBok005]);
end;

function TArchivBtr.LocateBok006 (pBok006:byte):boolean;
begin
  SetIndex (ixBok006);
  Result := oBtrTable.FindKey([pBok006]);
end;

function TArchivBtr.LocateBok007 (pBok007:byte):boolean;
begin
  SetIndex (ixBok007);
  Result := oBtrTable.FindKey([pBok007]);
end;

function TArchivBtr.LocateBok008 (pBok008:byte):boolean;
begin
  SetIndex (ixBok008);
  Result := oBtrTable.FindKey([pBok008]);
end;

function TArchivBtr.LocateBok009 (pBok009:byte):boolean;
begin
  SetIndex (ixBok009);
  Result := oBtrTable.FindKey([pBok009]);
end;

function TArchivBtr.LocateBok010 (pBok010:byte):boolean;
begin
  SetIndex (ixBok010);
  Result := oBtrTable.FindKey([pBok010]);
end;

function TArchivBtr.LocateBok011 (pBok011:byte):boolean;
begin
  SetIndex (ixBok011);
  Result := oBtrTable.FindKey([pBok011]);
end;

function TArchivBtr.LocateBok012 (pBok012:byte):boolean;
begin
  SetIndex (ixBok012);
  Result := oBtrTable.FindKey([pBok012]);
end;

function TArchivBtr.LocateBok013 (pBok013:byte):boolean;
begin
  SetIndex (ixBok013);
  Result := oBtrTable.FindKey([pBok013]);
end;

function TArchivBtr.LocateBok014 (pBok014:byte):boolean;
begin
  SetIndex (ixBok014);
  Result := oBtrTable.FindKey([pBok014]);
end;

function TArchivBtr.LocateBok015 (pBok015:byte):boolean;
begin
  SetIndex (ixBok015);
  Result := oBtrTable.FindKey([pBok015]);
end;

function TArchivBtr.NearestArcNum (pArcNum:longint):boolean;
begin
  SetIndex (ixArcNum);
  Result := oBtrTable.FindNearest([pArcNum]);
end;

function TArchivBtr.NearestArcDat (pArcDat:TDatetime):boolean;
begin
  SetIndex (ixArcDat);
  Result := oBtrTable.FindNearest([pArcDat]);
end;

function TArchivBtr.NearestArcDes (pArcDes_:Str200):boolean;
begin
  SetIndex (ixArcDes);
  Result := oBtrTable.FindNearest([pArcDes_]);
end;

function TArchivBtr.NearestFizNum (pFizNum:Str10):boolean;
begin
  SetIndex (ixFizNum);
  Result := oBtrTable.FindNearest([pFizNum]);
end;

function TArchivBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TArchivBtr.NearestExtNum (pExtNum:Str30):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TArchivBtr.NearestExpDat (pExpDat:TDatetime):boolean;
begin
  SetIndex (ixExpDat);
  Result := oBtrTable.FindNearest([pExpDat]);
end;

function TArchivBtr.NearestAccess (pAccess:Str1):boolean;
begin
  SetIndex (ixAccess);
  Result := oBtrTable.FindNearest([pAccess]);
end;

function TArchivBtr.NearestAssign (pAssign:Str1):boolean;
begin
  SetIndex (ixAssign);
  Result := oBtrTable.FindNearest([pAssign]);
end;

function TArchivBtr.NearestBok001 (pBok001:byte):boolean;
begin
  SetIndex (ixBok001);
  Result := oBtrTable.FindNearest([pBok001]);
end;

function TArchivBtr.NearestBok002 (pBok002:byte):boolean;
begin
  SetIndex (ixBok002);
  Result := oBtrTable.FindNearest([pBok002]);
end;

function TArchivBtr.NearestBok003 (pBok003:byte):boolean;
begin
  SetIndex (ixBok003);
  Result := oBtrTable.FindNearest([pBok003]);
end;

function TArchivBtr.NearestBok004 (pBok004:byte):boolean;
begin
  SetIndex (ixBok004);
  Result := oBtrTable.FindNearest([pBok004]);
end;

function TArchivBtr.NearestBok005 (pBok005:byte):boolean;
begin
  SetIndex (ixBok005);
  Result := oBtrTable.FindNearest([pBok005]);
end;

function TArchivBtr.NearestBok006 (pBok006:byte):boolean;
begin
  SetIndex (ixBok006);
  Result := oBtrTable.FindNearest([pBok006]);
end;

function TArchivBtr.NearestBok007 (pBok007:byte):boolean;
begin
  SetIndex (ixBok007);
  Result := oBtrTable.FindNearest([pBok007]);
end;

function TArchivBtr.NearestBok008 (pBok008:byte):boolean;
begin
  SetIndex (ixBok008);
  Result := oBtrTable.FindNearest([pBok008]);
end;

function TArchivBtr.NearestBok009 (pBok009:byte):boolean;
begin
  SetIndex (ixBok009);
  Result := oBtrTable.FindNearest([pBok009]);
end;

function TArchivBtr.NearestBok010 (pBok010:byte):boolean;
begin
  SetIndex (ixBok010);
  Result := oBtrTable.FindNearest([pBok010]);
end;

function TArchivBtr.NearestBok011 (pBok011:byte):boolean;
begin
  SetIndex (ixBok011);
  Result := oBtrTable.FindNearest([pBok011]);
end;

function TArchivBtr.NearestBok012 (pBok012:byte):boolean;
begin
  SetIndex (ixBok012);
  Result := oBtrTable.FindNearest([pBok012]);
end;

function TArchivBtr.NearestBok013 (pBok013:byte):boolean;
begin
  SetIndex (ixBok013);
  Result := oBtrTable.FindNearest([pBok013]);
end;

function TArchivBtr.NearestBok014 (pBok014:byte):boolean;
begin
  SetIndex (ixBok014);
  Result := oBtrTable.FindNearest([pBok014]);
end;

function TArchivBtr.NearestBok015 (pBok015:byte):boolean;
begin
  SetIndex (ixBok015);
  Result := oBtrTable.FindNearest([pBok015]);
end;

procedure TArchivBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TArchivBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TArchivBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TArchivBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TArchivBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TArchivBtr.First;
begin
  oBtrTable.First;
end;

procedure TArchivBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TArchivBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TArchivBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TArchivBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TArchivBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TArchivBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TArchivBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TArchivBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TArchivBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TArchivBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TArchivBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
