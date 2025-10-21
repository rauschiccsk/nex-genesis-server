unit bRPL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = 'BarCode';
  ixGsName_S = 'GsName_S';
  ixMgCode_S = 'MgCode_S';
  ixCPrice_S = 'CPrice_S';
  ixGscKfc_S = 'GscKfc_S';
  ixPrfKfc_S = 'PrfKfc_S';
  ixGsCode_N = 'GsCode_N';
  ixGsName_N = 'GsName_N';
  ixMgCode_N = 'MgCode_N';
  ixPrfKfc_N = 'PrfKfc_N';
  ixPrfKfc_B = 'PrfKfc_B';
  ixNewGsc = 'NewGsc';
  ixModMgc = 'ModMgc';
  ixExcNum = 'ExcNum';
  ixStkCode = 'StkCode';
  ixProduc = 'Produc';

type
  TRplBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsName_S:Str50;        procedure WriteGsName_S (pValue:Str50);
    function  ReadGsName_S_:Str50;       procedure WriteGsName_S_ (pValue:Str50);
    function  ReadMgCode_S:longint;      procedure WriteMgCode_S (pValue:longint);
    function  ReadCPrice_S:double;       procedure WriteCPrice_S (pValue:double);
    function  ReadGscKfc_S:word;         procedure WriteGscKfc_S (pValue:word);
    function  ReadPrfKfc_S:double;       procedure WritePrfKfc_S (pValue:double);
    function  ReadAPrice_S:double;       procedure WriteAPrice_S (pValue:double);
    function  ReadBPrice_S:double;       procedure WriteBPrice_S (pValue:double);
    function  ReadGsCode_N:longint;      procedure WriteGsCode_N (pValue:longint);
    function  ReadGsName_N:Str50;        procedure WriteGsName_N (pValue:Str50);
    function  ReadGsName_N_:Str50;       procedure WriteGsName_N_ (pValue:Str50);
    function  ReadMgCode_N:longint;      procedure WriteMgCode_N (pValue:longint);
    function  ReadPrfKfc_N:double;       procedure WritePrfKfc_N (pValue:double);
    function  ReadAPrice_N:double;       procedure WriteAPrice_N (pValue:double);
    function  ReadBPrice_N:double;       procedure WriteBPrice_N (pValue:double);
    function  ReadPrfKfc_B:double;       procedure WritePrfKfc_B (pValue:double);
    function  ReadAPrice_B:double;       procedure WriteAPrice_B (pValue:double);
    function  ReadBPrice_B:double;       procedure WriteBPrice_B (pValue:double);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadProduc:Str10;          procedure WriteProduc (pValue:Str10);
    function  ReadNewGsc:Str1;           procedure WriteNewGsc (pValue:Str1);
    function  ReadModMgc:Str1;           procedure WriteModMgc (pValue:Str1);
    function  ReadExcNum:byte;           procedure WriteExcNum (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMinOsq_S:double;       procedure WriteMinOsq_S (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateGsName_S (pGsName_S_:Str50;pBarCode:Str15):boolean;
    function LocateMgCode_S (pMgCode_S:longint;pBarCode:Str15):boolean;
    function LocateCPrice_S (pCPrice_S:double):boolean;
    function LocateGscKfc_S (pGscKfc_S:word;pBarCode:Str15):boolean;
    function LocatePrfKfc_S (pPrfKfc_S:double;pBarCode:Str15):boolean;
    function LocateGsCode_N (pGsCode_N:longint):boolean;
    function LocateGsName_N (pGsName_N_:Str50;pBarCode:Str15):boolean;
    function LocateMgCode_N (pMgCode_N:longint;pBarCode:Str15):boolean;
    function LocatePrfKfc_N (pPrfKfc_N:double;pBarCode:Str15):boolean;
    function LocatePrfKfc_B (pPrfKfc_B:double;pBarCode:Str15):boolean;
    function LocateNewGsc (pNewGsc:Str1):boolean;
    function LocateModMgc (pModMgc:Str1):boolean;
    function LocateExcNum (pExcNum:byte):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateProduc (pProduc:Str10):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestGsName_S (pGsName_S_:Str50;pBarCode:Str15):boolean;
    function NearestMgCode_S (pMgCode_S:longint;pBarCode:Str15):boolean;
    function NearestCPrice_S (pCPrice_S:double):boolean;
    function NearestGscKfc_S (pGscKfc_S:word;pBarCode:Str15):boolean;
    function NearestPrfKfc_S (pPrfKfc_S:double;pBarCode:Str15):boolean;
    function NearestGsCode_N (pGsCode_N:longint):boolean;
    function NearestGsName_N (pGsName_N_:Str50;pBarCode:Str15):boolean;
    function NearestMgCode_N (pMgCode_N:longint;pBarCode:Str15):boolean;
    function NearestPrfKfc_N (pPrfKfc_N:double;pBarCode:Str15):boolean;
    function NearestPrfKfc_B (pPrfKfc_B:double;pBarCode:Str15):boolean;
    function NearestNewGsc (pNewGsc:Str1):boolean;
    function NearestModMgc (pModMgc:Str1):boolean;
    function NearestExcNum (pExcNum:byte):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
    function NearestProduc (pProduc:Str10):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsName_S:Str50 read ReadGsName_S write WriteGsName_S;
    property GsName_S_:Str50 read ReadGsName_S_ write WriteGsName_S_;
    property MgCode_S:longint read ReadMgCode_S write WriteMgCode_S;
    property CPrice_S:double read ReadCPrice_S write WriteCPrice_S;
    property GscKfc_S:word read ReadGscKfc_S write WriteGscKfc_S;
    property PrfKfc_S:double read ReadPrfKfc_S write WritePrfKfc_S;
    property APrice_S:double read ReadAPrice_S write WriteAPrice_S;
    property BPrice_S:double read ReadBPrice_S write WriteBPrice_S;
    property GsCode_N:longint read ReadGsCode_N write WriteGsCode_N;
    property GsName_N:Str50 read ReadGsName_N write WriteGsName_N;
    property GsName_N_:Str50 read ReadGsName_N_ write WriteGsName_N_;
    property MgCode_N:longint read ReadMgCode_N write WriteMgCode_N;
    property PrfKfc_N:double read ReadPrfKfc_N write WritePrfKfc_N;
    property APrice_N:double read ReadAPrice_N write WriteAPrice_N;
    property BPrice_N:double read ReadBPrice_N write WriteBPrice_N;
    property PrfKfc_B:double read ReadPrfKfc_B write WritePrfKfc_B;
    property APrice_B:double read ReadAPrice_B write WriteAPrice_B;
    property BPrice_B:double read ReadBPrice_B write WriteBPrice_B;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Produc:Str10 read ReadProduc write WriteProduc;
    property NewGsc:Str1 read ReadNewGsc write WriteNewGsc;
    property ModMgc:Str1 read ReadModMgc write WriteModMgc;
    property ExcNum:byte read ReadExcNum write WriteExcNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MinOsq_S:double read ReadMinOsq_S write WriteMinOsq_S;
  end;

implementation

constructor TRplBtr.Create;
begin
  oBtrTable := BtrInit ('RPL',gPath.MgdPath,Self);
end;

constructor TRplBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RPL',pPath,Self);
end;

destructor TRplBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRplBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRplBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRplBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TRplBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TRplBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TRplBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TRplBtr.ReadGsName_S:Str50;
begin
  Result := oBtrTable.FieldByName('GsName_S').AsString;
end;

procedure TRplBtr.WriteGsName_S(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName_S').AsString := pValue;
end;

function TRplBtr.ReadGsName_S_:Str50;
begin
  Result := oBtrTable.FieldByName('GsName_S_').AsString;
end;

procedure TRplBtr.WriteGsName_S_(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName_S_').AsString := pValue;
end;

function TRplBtr.ReadMgCode_S:longint;
begin
  Result := oBtrTable.FieldByName('MgCode_S').AsInteger;
end;

procedure TRplBtr.WriteMgCode_S(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode_S').AsInteger := pValue;
end;

function TRplBtr.ReadCPrice_S:double;
begin
  Result := oBtrTable.FieldByName('CPrice_S').AsFloat;
end;

procedure TRplBtr.WriteCPrice_S(pValue:double);
begin
  oBtrTable.FieldByName('CPrice_S').AsFloat := pValue;
end;

function TRplBtr.ReadGscKfc_S:word;
begin
  Result := oBtrTable.FieldByName('GscKfc_S').AsInteger;
end;

procedure TRplBtr.WriteGscKfc_S(pValue:word);
begin
  oBtrTable.FieldByName('GscKfc_S').AsInteger := pValue;
end;

function TRplBtr.ReadPrfKfc_S:double;
begin
  Result := oBtrTable.FieldByName('PrfKfc_S').AsFloat;
end;

procedure TRplBtr.WritePrfKfc_S(pValue:double);
begin
  oBtrTable.FieldByName('PrfKfc_S').AsFloat := pValue;
end;

function TRplBtr.ReadAPrice_S:double;
begin
  Result := oBtrTable.FieldByName('APrice_S').AsFloat;
end;

procedure TRplBtr.WriteAPrice_S(pValue:double);
begin
  oBtrTable.FieldByName('APrice_S').AsFloat := pValue;
end;

function TRplBtr.ReadBPrice_S:double;
begin
  Result := oBtrTable.FieldByName('BPrice_S').AsFloat;
end;

procedure TRplBtr.WriteBPrice_S(pValue:double);
begin
  oBtrTable.FieldByName('BPrice_S').AsFloat := pValue;
end;

function TRplBtr.ReadGsCode_N:longint;
begin
  Result := oBtrTable.FieldByName('GsCode_N').AsInteger;
end;

procedure TRplBtr.WriteGsCode_N(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode_N').AsInteger := pValue;
end;

function TRplBtr.ReadGsName_N:Str50;
begin
  Result := oBtrTable.FieldByName('GsName_N').AsString;
end;

procedure TRplBtr.WriteGsName_N(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName_N').AsString := pValue;
end;

function TRplBtr.ReadGsName_N_:Str50;
begin
  Result := oBtrTable.FieldByName('GsName_N_').AsString;
end;

procedure TRplBtr.WriteGsName_N_(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName_N_').AsString := pValue;
end;

function TRplBtr.ReadMgCode_N:longint;
begin
  Result := oBtrTable.FieldByName('MgCode_N').AsInteger;
end;

procedure TRplBtr.WriteMgCode_N(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode_N').AsInteger := pValue;
end;

function TRplBtr.ReadPrfKfc_N:double;
begin
  Result := oBtrTable.FieldByName('PrfKfc_N').AsFloat;
end;

procedure TRplBtr.WritePrfKfc_N(pValue:double);
begin
  oBtrTable.FieldByName('PrfKfc_N').AsFloat := pValue;
end;

function TRplBtr.ReadAPrice_N:double;
begin
  Result := oBtrTable.FieldByName('APrice_N').AsFloat;
end;

procedure TRplBtr.WriteAPrice_N(pValue:double);
begin
  oBtrTable.FieldByName('APrice_N').AsFloat := pValue;
end;

function TRplBtr.ReadBPrice_N:double;
begin
  Result := oBtrTable.FieldByName('BPrice_N').AsFloat;
end;

procedure TRplBtr.WriteBPrice_N(pValue:double);
begin
  oBtrTable.FieldByName('BPrice_N').AsFloat := pValue;
end;

function TRplBtr.ReadPrfKfc_B:double;
begin
  Result := oBtrTable.FieldByName('PrfKfc_B').AsFloat;
end;

procedure TRplBtr.WritePrfKfc_B(pValue:double);
begin
  oBtrTable.FieldByName('PrfKfc_B').AsFloat := pValue;
end;

function TRplBtr.ReadAPrice_B:double;
begin
  Result := oBtrTable.FieldByName('APrice_B').AsFloat;
end;

procedure TRplBtr.WriteAPrice_B(pValue:double);
begin
  oBtrTable.FieldByName('APrice_B').AsFloat := pValue;
end;

function TRplBtr.ReadBPrice_B:double;
begin
  Result := oBtrTable.FieldByName('BPrice_B').AsFloat;
end;

procedure TRplBtr.WriteBPrice_B(pValue:double);
begin
  oBtrTable.FieldByName('BPrice_B').AsFloat := pValue;
end;

function TRplBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TRplBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TRplBtr.ReadProduc:Str10;
begin
  Result := oBtrTable.FieldByName('Produc').AsString;
end;

procedure TRplBtr.WriteProduc(pValue:Str10);
begin
  oBtrTable.FieldByName('Produc').AsString := pValue;
end;

function TRplBtr.ReadNewGsc:Str1;
begin
  Result := oBtrTable.FieldByName('NewGsc').AsString;
end;

procedure TRplBtr.WriteNewGsc(pValue:Str1);
begin
  oBtrTable.FieldByName('NewGsc').AsString := pValue;
end;

function TRplBtr.ReadModMgc:Str1;
begin
  Result := oBtrTable.FieldByName('ModMgc').AsString;
end;

procedure TRplBtr.WriteModMgc(pValue:Str1);
begin
  oBtrTable.FieldByName('ModMgc').AsString := pValue;
end;

function TRplBtr.ReadExcNum:byte;
begin
  Result := oBtrTable.FieldByName('ExcNum').AsInteger;
end;

procedure TRplBtr.WriteExcNum(pValue:byte);
begin
  oBtrTable.FieldByName('ExcNum').AsInteger := pValue;
end;

function TRplBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRplBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRplBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRplBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRplBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRplBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRplBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRplBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRplBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRplBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRplBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRplBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRplBtr.ReadMinOsq_S:double;
begin
  Result := oBtrTable.FieldByName('MinOsq_S').AsFloat;
end;

procedure TRplBtr.WriteMinOsq_S(pValue:double);
begin
  oBtrTable.FieldByName('MinOsq_S').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRplBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRplBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRplBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRplBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRplBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRplBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRplBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TRplBtr.LocateGsName_S (pGsName_S_:Str50;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsName_S);
  Result := oBtrTable.FindKey([pGsName_S_,pBarCode]);
end;

function TRplBtr.LocateMgCode_S (pMgCode_S:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixMgCode_S);
  Result := oBtrTable.FindKey([pMgCode_S,pBarCode]);
end;

function TRplBtr.LocateCPrice_S (pCPrice_S:double):boolean;
begin
  SetIndex (ixCPrice_S);
  Result := oBtrTable.FindKey([pCPrice_S]);
end;

function TRplBtr.LocateGscKfc_S (pGscKfc_S:word;pBarCode:Str15):boolean;
begin
  SetIndex (ixGscKfc_S);
  Result := oBtrTable.FindKey([pGscKfc_S,pBarCode]);
end;

function TRplBtr.LocatePrfKfc_S (pPrfKfc_S:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_S);
  Result := oBtrTable.FindKey([pPrfKfc_S,pBarCode]);
end;

function TRplBtr.LocateGsCode_N (pGsCode_N:longint):boolean;
begin
  SetIndex (ixGsCode_N);
  Result := oBtrTable.FindKey([pGsCode_N]);
end;

function TRplBtr.LocateGsName_N (pGsName_N_:Str50;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsName_N);
  Result := oBtrTable.FindKey([pGsName_N_,pBarCode]);
end;

function TRplBtr.LocateMgCode_N (pMgCode_N:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixMgCode_N);
  Result := oBtrTable.FindKey([pMgCode_N,pBarCode]);
end;

function TRplBtr.LocatePrfKfc_N (pPrfKfc_N:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_N);
  Result := oBtrTable.FindKey([pPrfKfc_N,pBarCode]);
end;

function TRplBtr.LocatePrfKfc_B (pPrfKfc_B:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_B);
  Result := oBtrTable.FindKey([pPrfKfc_B,pBarCode]);
end;

function TRplBtr.LocateNewGsc (pNewGsc:Str1):boolean;
begin
  SetIndex (ixNewGsc);
  Result := oBtrTable.FindKey([pNewGsc]);
end;

function TRplBtr.LocateModMgc (pModMgc:Str1):boolean;
begin
  SetIndex (ixModMgc);
  Result := oBtrTable.FindKey([pModMgc]);
end;

function TRplBtr.LocateExcNum (pExcNum:byte):boolean;
begin
  SetIndex (ixExcNum);
  Result := oBtrTable.FindKey([pExcNum]);
end;

function TRplBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TRplBtr.LocateProduc (pProduc:Str10):boolean;
begin
  SetIndex (ixProduc);
  Result := oBtrTable.FindKey([pProduc]);
end;

function TRplBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TRplBtr.NearestGsName_S (pGsName_S_:Str50;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsName_S);
  Result := oBtrTable.FindNearest([pGsName_S_,pBarCode]);
end;

function TRplBtr.NearestMgCode_S (pMgCode_S:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixMgCode_S);
  Result := oBtrTable.FindNearest([pMgCode_S,pBarCode]);
end;

function TRplBtr.NearestCPrice_S (pCPrice_S:double):boolean;
begin
  SetIndex (ixCPrice_S);
  Result := oBtrTable.FindNearest([pCPrice_S]);
end;

function TRplBtr.NearestGscKfc_S (pGscKfc_S:word;pBarCode:Str15):boolean;
begin
  SetIndex (ixGscKfc_S);
  Result := oBtrTable.FindNearest([pGscKfc_S,pBarCode]);
end;

function TRplBtr.NearestPrfKfc_S (pPrfKfc_S:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_S);
  Result := oBtrTable.FindNearest([pPrfKfc_S,pBarCode]);
end;

function TRplBtr.NearestGsCode_N (pGsCode_N:longint):boolean;
begin
  SetIndex (ixGsCode_N);
  Result := oBtrTable.FindNearest([pGsCode_N]);
end;

function TRplBtr.NearestGsName_N (pGsName_N_:Str50;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsName_N);
  Result := oBtrTable.FindNearest([pGsName_N_,pBarCode]);
end;

function TRplBtr.NearestMgCode_N (pMgCode_N:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixMgCode_N);
  Result := oBtrTable.FindNearest([pMgCode_N,pBarCode]);
end;

function TRplBtr.NearestPrfKfc_N (pPrfKfc_N:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_N);
  Result := oBtrTable.FindNearest([pPrfKfc_N,pBarCode]);
end;

function TRplBtr.NearestPrfKfc_B (pPrfKfc_B:double;pBarCode:Str15):boolean;
begin
  SetIndex (ixPrfKfc_B);
  Result := oBtrTable.FindNearest([pPrfKfc_B,pBarCode]);
end;

function TRplBtr.NearestNewGsc (pNewGsc:Str1):boolean;
begin
  SetIndex (ixNewGsc);
  Result := oBtrTable.FindNearest([pNewGsc]);
end;

function TRplBtr.NearestModMgc (pModMgc:Str1):boolean;
begin
  SetIndex (ixModMgc);
  Result := oBtrTable.FindNearest([pModMgc]);
end;

function TRplBtr.NearestExcNum (pExcNum:byte):boolean;
begin
  SetIndex (ixExcNum);
  Result := oBtrTable.FindNearest([pExcNum]);
end;

function TRplBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TRplBtr.NearestProduc (pProduc:Str10):boolean;
begin
  SetIndex (ixProduc);
  Result := oBtrTable.FindNearest([pProduc]);
end;

procedure TRplBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRplBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TRplBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRplBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRplBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRplBtr.First;
begin
  oBtrTable.First;
end;

procedure TRplBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRplBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRplBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRplBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRplBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRplBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRplBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRplBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRplBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRplBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRplBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
