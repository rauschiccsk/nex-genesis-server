unit tRPL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = '';
  ixGsName_S_ = 'GsName_S_';
  ixMgCode_S = 'MgCode_S';
  ixCPrice_S = 'CPrice_S';
  ixPrfKfc_S = 'PrfKfc_S';
  ixGsCode_N = 'GsCode_N';
  ixGsName_N_ = 'GsName_N_';
  ixMgCode_N = 'MgCode_N';
  ixPrfKfc_N = 'PrfKfc_N';
  ixNewGsc = 'NewGsc';
  ixModMgc = 'ModMgc';
  ixExcNum = 'ExcNum';

type
  TRplTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateGsName_S_ (pGsName_S_:Str50):boolean;
    function LocateMgCode_S (pMgCode_S:longint):boolean;
    function LocateCPrice_S (pCPrice_S:double):boolean;
    function LocatePrfKfc_S (pPrfKfc_S:double):boolean;
    function LocateGsCode_N (pGsCode_N:longint):boolean;
    function LocateGsName_N_ (pGsName_N_:Str50):boolean;
    function LocateMgCode_N (pMgCode_N:longint):boolean;
    function LocatePrfKfc_N (pPrfKfc_N:double):boolean;
    function LocateNewGsc (pNewGsc:Str1):boolean;
    function LocateModMgc (pModMgc:Str1):boolean;
    function LocateExcNum (pExcNum:byte):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRplTmp.Create;
begin
  oTmpTable := TmpInit ('RPL',Self);
end;

destructor TRplTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRplTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRplTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRplTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TRplTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TRplTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TRplTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TRplTmp.ReadGsName_S:Str50;
begin
  Result := oTmpTable.FieldByName('GsName_S').AsString;
end;

procedure TRplTmp.WriteGsName_S(pValue:Str50);
begin
  oTmpTable.FieldByName('GsName_S').AsString := pValue;
end;

function TRplTmp.ReadGsName_S_:Str50;
begin
  Result := oTmpTable.FieldByName('GsName_S_').AsString;
end;

procedure TRplTmp.WriteGsName_S_(pValue:Str50);
begin
  oTmpTable.FieldByName('GsName_S_').AsString := pValue;
end;

function TRplTmp.ReadMgCode_S:longint;
begin
  Result := oTmpTable.FieldByName('MgCode_S').AsInteger;
end;

procedure TRplTmp.WriteMgCode_S(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode_S').AsInteger := pValue;
end;

function TRplTmp.ReadCPrice_S:double;
begin
  Result := oTmpTable.FieldByName('CPrice_S').AsFloat;
end;

procedure TRplTmp.WriteCPrice_S(pValue:double);
begin
  oTmpTable.FieldByName('CPrice_S').AsFloat := pValue;
end;

function TRplTmp.ReadGscKfc_S:word;
begin
  Result := oTmpTable.FieldByName('GscKfc_S').AsInteger;
end;

procedure TRplTmp.WriteGscKfc_S(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc_S').AsInteger := pValue;
end;

function TRplTmp.ReadPrfKfc_S:double;
begin
  Result := oTmpTable.FieldByName('PrfKfc_S').AsFloat;
end;

procedure TRplTmp.WritePrfKfc_S(pValue:double);
begin
  oTmpTable.FieldByName('PrfKfc_S').AsFloat := pValue;
end;

function TRplTmp.ReadAPrice_S:double;
begin
  Result := oTmpTable.FieldByName('APrice_S').AsFloat;
end;

procedure TRplTmp.WriteAPrice_S(pValue:double);
begin
  oTmpTable.FieldByName('APrice_S').AsFloat := pValue;
end;

function TRplTmp.ReadBPrice_S:double;
begin
  Result := oTmpTable.FieldByName('BPrice_S').AsFloat;
end;

procedure TRplTmp.WriteBPrice_S(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_S').AsFloat := pValue;
end;

function TRplTmp.ReadGsCode_N:longint;
begin
  Result := oTmpTable.FieldByName('GsCode_N').AsInteger;
end;

procedure TRplTmp.WriteGsCode_N(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode_N').AsInteger := pValue;
end;

function TRplTmp.ReadGsName_N:Str50;
begin
  Result := oTmpTable.FieldByName('GsName_N').AsString;
end;

procedure TRplTmp.WriteGsName_N(pValue:Str50);
begin
  oTmpTable.FieldByName('GsName_N').AsString := pValue;
end;

function TRplTmp.ReadGsName_N_:Str50;
begin
  Result := oTmpTable.FieldByName('GsName_N_').AsString;
end;

procedure TRplTmp.WriteGsName_N_(pValue:Str50);
begin
  oTmpTable.FieldByName('GsName_N_').AsString := pValue;
end;

function TRplTmp.ReadMgCode_N:longint;
begin
  Result := oTmpTable.FieldByName('MgCode_N').AsInteger;
end;

procedure TRplTmp.WriteMgCode_N(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode_N').AsInteger := pValue;
end;

function TRplTmp.ReadPrfKfc_N:double;
begin
  Result := oTmpTable.FieldByName('PrfKfc_N').AsFloat;
end;

procedure TRplTmp.WritePrfKfc_N(pValue:double);
begin
  oTmpTable.FieldByName('PrfKfc_N').AsFloat := pValue;
end;

function TRplTmp.ReadAPrice_N:double;
begin
  Result := oTmpTable.FieldByName('APrice_N').AsFloat;
end;

procedure TRplTmp.WriteAPrice_N(pValue:double);
begin
  oTmpTable.FieldByName('APrice_N').AsFloat := pValue;
end;

function TRplTmp.ReadBPrice_N:double;
begin
  Result := oTmpTable.FieldByName('BPrice_N').AsFloat;
end;

procedure TRplTmp.WriteBPrice_N(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_N').AsFloat := pValue;
end;

function TRplTmp.ReadPrfKfc_B:double;
begin
  Result := oTmpTable.FieldByName('PrfKfc_B').AsFloat;
end;

procedure TRplTmp.WritePrfKfc_B(pValue:double);
begin
  oTmpTable.FieldByName('PrfKfc_B').AsFloat := pValue;
end;

function TRplTmp.ReadAPrice_B:double;
begin
  Result := oTmpTable.FieldByName('APrice_B').AsFloat;
end;

procedure TRplTmp.WriteAPrice_B(pValue:double);
begin
  oTmpTable.FieldByName('APrice_B').AsFloat := pValue;
end;

function TRplTmp.ReadBPrice_B:double;
begin
  Result := oTmpTable.FieldByName('BPrice_B').AsFloat;
end;

procedure TRplTmp.WriteBPrice_B(pValue:double);
begin
  oTmpTable.FieldByName('BPrice_B').AsFloat := pValue;
end;

function TRplTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TRplTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TRplTmp.ReadProduc:Str10;
begin
  Result := oTmpTable.FieldByName('Produc').AsString;
end;

procedure TRplTmp.WriteProduc(pValue:Str10);
begin
  oTmpTable.FieldByName('Produc').AsString := pValue;
end;

function TRplTmp.ReadNewGsc:Str1;
begin
  Result := oTmpTable.FieldByName('NewGsc').AsString;
end;

procedure TRplTmp.WriteNewGsc(pValue:Str1);
begin
  oTmpTable.FieldByName('NewGsc').AsString := pValue;
end;

function TRplTmp.ReadModMgc:Str1;
begin
  Result := oTmpTable.FieldByName('ModMgc').AsString;
end;

procedure TRplTmp.WriteModMgc(pValue:Str1);
begin
  oTmpTable.FieldByName('ModMgc').AsString := pValue;
end;

function TRplTmp.ReadExcNum:byte;
begin
  Result := oTmpTable.FieldByName('ExcNum').AsInteger;
end;

procedure TRplTmp.WriteExcNum(pValue:byte);
begin
  oTmpTable.FieldByName('ExcNum').AsInteger := pValue;
end;

function TRplTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRplTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRplTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRplTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRplTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRplTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRplTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRplTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRplTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRplTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRplTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRplTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRplTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRplTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRplTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRplTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRplTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TRplTmp.LocateGsName_S_ (pGsName_S_:Str50):boolean;
begin
  SetIndex (ixGsName_S_);
  Result := oTmpTable.FindKey([pGsName_S_]);
end;

function TRplTmp.LocateMgCode_S (pMgCode_S:longint):boolean;
begin
  SetIndex (ixMgCode_S);
  Result := oTmpTable.FindKey([pMgCode_S]);
end;

function TRplTmp.LocateCPrice_S (pCPrice_S:double):boolean;
begin
  SetIndex (ixCPrice_S);
  Result := oTmpTable.FindKey([pCPrice_S]);
end;

function TRplTmp.LocatePrfKfc_S (pPrfKfc_S:double):boolean;
begin
  SetIndex (ixPrfKfc_S);
  Result := oTmpTable.FindKey([pPrfKfc_S]);
end;

function TRplTmp.LocateGsCode_N (pGsCode_N:longint):boolean;
begin
  SetIndex (ixGsCode_N);
  Result := oTmpTable.FindKey([pGsCode_N]);
end;

function TRplTmp.LocateGsName_N_ (pGsName_N_:Str50):boolean;
begin
  SetIndex (ixGsName_N_);
  Result := oTmpTable.FindKey([pGsName_N_]);
end;

function TRplTmp.LocateMgCode_N (pMgCode_N:longint):boolean;
begin
  SetIndex (ixMgCode_N);
  Result := oTmpTable.FindKey([pMgCode_N]);
end;

function TRplTmp.LocatePrfKfc_N (pPrfKfc_N:double):boolean;
begin
  SetIndex (ixPrfKfc_N);
  Result := oTmpTable.FindKey([pPrfKfc_N]);
end;

function TRplTmp.LocateNewGsc (pNewGsc:Str1):boolean;
begin
  SetIndex (ixNewGsc);
  Result := oTmpTable.FindKey([pNewGsc]);
end;

function TRplTmp.LocateModMgc (pModMgc:Str1):boolean;
begin
  SetIndex (ixModMgc);
  Result := oTmpTable.FindKey([pModMgc]);
end;

function TRplTmp.LocateExcNum (pExcNum:byte):boolean;
begin
  SetIndex (ixExcNum);
  Result := oTmpTable.FindKey([pExcNum]);
end;

procedure TRplTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRplTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRplTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRplTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRplTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRplTmp.First;
begin
  oTmpTable.First;
end;

procedure TRplTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRplTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRplTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRplTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRplTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRplTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRplTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRplTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRplTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRplTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRplTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
