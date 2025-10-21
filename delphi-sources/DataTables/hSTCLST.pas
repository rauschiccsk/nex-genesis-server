unit hSTCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, NexClc,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';
  ixMinMax='MinMax';

type
  PDat=^TDat;
  TDat=record
    rTable:TNexBtrTable;
    rStkNum:word;
  end;
  TStclstHnd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oStkNum:word;
    oTable:TNexBtrTable;
    oLst:TList;
    function GetCount:integer;
    function GetTable(pStkNum:word):TNexBtrTable;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    // Pr�stup k datab�zov�m poliam
    function GetStkNum:word;       procedure SetStkNum(pValue:word);
    function GetProNum:longint;    procedure SetProNum(pValue:longint);
    function GetProNam:Str60;      procedure SetProNam(pValue:Str60);
    function GetPgrNum:longint;    procedure SetPgrNum(pValue:longint);
    function GetFgrNum:longint;    procedure SetFgrNum(pValue:longint);
    function GetBarCod:Str15;      procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;      procedure SetStkCod(pValue:Str15);
    function GetOrdCod:Str30;      procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;      procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;       procedure SetVatPrc(pValue:byte);
    function GetProTyp:Str1;       procedure SetProTyp(pValue:Str1);
    function GetMinMax:Str1;       procedure SetMinMax(pValue:Str1);
    function GetBegPrq:double;     procedure SetBegPrq(pValue:double);
    function GetIncPrq:double;     procedure SetIncPrq(pValue:double);
    function GetOutPrq:double;     procedure SetOutPrq(pValue:double);
    function GetActPrq:double;     procedure SetActPrq(pValue:double);
    function GetFrePrq:double;     procedure SetFrePrq(pValue:double);
    function GetFroPrq:double;     procedure SetFroPrq(pValue:double);
    function GetReqPrq:double;     procedure SetReqPrq(pValue:double);
    function GetRstPrq:double;     procedure SetRstPrq(pValue:double);
    function GetRosPrq:double;     procedure SetRosPrq(pValue:double);
    function GetRsaPrq:double;     procedure SetRsaPrq(pValue:double);
    function GetOsdPrq:double;     procedure SetOsdPrq(pValue:double);
    function GetMinPrq:double;     procedure SetMinPrq(pValue:double);
    function GetMaxPrq:double;     procedure SetMaxPrq(pValue:double);
    function GetOptPrq:double;     procedure SetOptPrq(pValue:double);
    function GetPosPrq:double;     procedure SetPosPrq(pValue:double);
    function GetBegVal:double;     procedure SetBegVal(pValue:double);
    function GetIncVal:double;     procedure SetIncVal(pValue:double);
    function GetOutVal:double;     procedure SetOutVal(pValue:double);
    function GetActVal:double;     procedure SetActVal(pValue:double);
    function GetAvgApc:double;     procedure SetAvgApc(pValue:double);
    function GetLasApc:double;     procedure SetLasApc(pValue:double);
    function GetSalApc:double;
    function GetDisSta:boolean;    procedure SetDisSta(pValue:boolean);
  public
    // Z�kladn� datab�zov� oper�cie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pStkNum:word;pActPos:longint):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocMin(pStkNum:word):boolean;  // N�jde prv� podnormat�vnu polo�ku
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;

    procedure SetIndex(pIndexName:Str20);
    procedure Activate(pIndex:word);
    procedure Open(pStkNum:word);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;

    property Table[pStkNum:word]:TNexBtrTable read GetTable;
  published
    property Count:integer read GetCount;
    // Pr�stup k datab�zov�m poliam
    property StkNum:word read GetStkNum write SetStkNum;      // ��slo skladu
    property ProNum:longint read GetProNum write SetProNum;   // Produktov� ��slo
    property ProNam:Str60 read GetProNam write SetProNam;     // N�zov produktu
    property PgrNum:longint read GetPgrNum write SetPgrNum;   // Produktov� skupina (samostatne pre tovar a pre slu�by)
    property FgrNum:longint read GetFgrNum write SetFgrNum;   // Finan�n� skupny
    property BarCod:Str15 read GetBarCod write SetBarCod;     // Identifika�n� k�d polo�ky
    property StkCod:Str15 read GetStkCod write SetStkCod;     // Skladov� k�d tovaru
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;     // Objedn�vac� k�d hlavn�ho dod�vate�a
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;     // Mern� jednotka
    property VatPrc:byte read GetVatPrc write SetVatPrc;      // Percentu�lna sadzba DPH
    property ProTyp:Str1 read GetProTyp write SetProTyp;      // Typov� ozna�enie produktu  (T-tovar,W-v�hovy tovar,O-obal,S-slu�ba)
    property MinMax:Str1 read GetMinMax write SetMinMax;      // Pr�znak prekro�enia skladov�ch normat�vov  (X-maxim�lny,W-minim�lny)
    property BegPrq:double read GetBegPrq write SetBegPrq;    // Po�iato�n� skladov� z�soba
    property IncPrq:double read GetIncPrq write SetIncPrq;    // Celkov� kumulat�vny pr�jem
    property OutPrq:double read GetOutPrq write SetOutPrq;    // Celkov� kumulat�vny v�daj
    property ActPrq:double read GetActPrq write SetActPrq;    // Aktu�lna skladov� z�soba
    property FrePrq:double read GetFrePrq write SetFrePrq;    // Voln� z�soba na predaj
    property FroPrq:double read GetFroPrq write SetFroPrq;    // Voln� mno�stvo z objedn�vok
    property ReqPrq:double read GetReqPrq write SetReqPrq;    // Po�iadavka na objednanie
    property RstPrq:double read GetRstPrq write SetRstPrq;    // Rezerv�cia z�kazky zo z�sobt
    property RosPrq:double read GetRosPrq write SetRosPrq;    // Rezerv�cia z�kazky z objedn�vky
    property RsaPrq:double read GetRsaPrq write SetRsaPrq;    // Rezerv�cia na hotovostn� predaj (ERP)
    property OsdPrq:double read GetOsdPrq write SetOsdPrq;    // Objednan� mno�stvo od dod�vate�a
    property MinPrq:double read GetMinPrq write SetMinPrq;    // Minim�lne skladov� mno�stvo
    property MaxPrq:double read GetMaxPrq write SetMaxPrq;    // Maxim�lne skladov� mno�stvo
    property OptPrq:double read GetOptPrq write SetOptPrq;    // Optim�ne mno�stvo
    property PosPrq:double read GetPosPrq write SetPosPrq;    // Pozi�n� z�soba - mno�stvo
    property BegVal:double read GetBegVal write SetBegVal;    // Po�iato�n� skladov� z�soba - finan�n� hodnota
    property IncVal:double read GetIncVal write SetIncVal;    // Celkov� kumulat�vny pr�jem - finan�n� hodnota
    property OutVal:double read GetOutVal write SetOutVal;    // Celkov� kumulat�vny v�daj - finan�n� hodnota
    property ActVal:double read GetActVal write SetActVal;    // Aktu�lna skladov� z�soba - finan�n� hodnota
    property AvgApc:double read GetAvgApc write SetAvgApc;    // Priemern� n�kupn� cena
    property LasApc:double read GetLasApc write SetLasApc;    // Posledn� n�kupn� cena
    property SalApc:double read GetSalApc;                    // Predajn� cena za MJ bez DPH
    property DisSta:boolean read GetDisSta write SetDisSta;   // Vyradenie polo�ky (1-vyraden�)
  end;

implementation

constructor TStclstHnd.Create;
begin
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TStclstHnd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      oTable.Close;
      FreeAndNil(oTable);
    end;
  end;
  FreeAndNil(oLst);
end;

// *************************************** PRIVATE ********************************************

function TStclstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TStclstHnd.GetTable(pStkNum:word):TNexBtrTable;
begin
  Open(pStkNum);
  Result:=oTable;
end;

function TStclstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TStclstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

// ********************* FIELDS *********************

function TStclstHnd.GetStkNum:word;
begin
  Result:=oStkNum;
end;

procedure TStclstHnd.SetStkNum(pValue:word);
begin
  //
end;

function TStclstHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TStclstHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TStclstHnd.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('GsName').AsString;
end;

procedure TStclstHnd.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('GsName').AsString:=pValue;
  oTable.FieldByName('GaName').AsString:=pValue;
end;


function TStclstHnd.GetPgrNum:longint;
begin
  Result:=oTable.FieldByName('MgCode').AsInteger;
end;

procedure TStclstHnd.SetPgrNum(pValue:longint);
begin
  oTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TStclstHnd.GetFgrNum:longint;
begin
  Result:=oTable.FieldByName('FgCode').AsInteger;
end;

procedure TStclstHnd.SetFgrNum(pValue:longint);
begin
  oTable.FieldByName('FgCode').AsInteger:=pValue;
end;

function TStclstHnd.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

function TStclstHnd.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCode').AsString;
end;

procedure TStclstHnd.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCode').AsString:=pValue;
end;

function TStclstHnd.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OsdCode').AsString;
end;

procedure TStclstHnd.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OsdCode').AsString:=pValue;
end;

function TStclstHnd.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsName').AsString;
end;

procedure TStclstHnd.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsName').AsString:=pValue;
end;

function TStclstHnd.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TStclstHnd.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TStclstHnd.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('GsType').AsString;
end;

procedure TStclstHnd.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('GsType').AsString:=pValue;
end;

function TStclstHnd.GetMinMax:Str1;
begin
  Result:=oTable.FieldByName('MinMax').AsString;
end;

procedure TStclstHnd.SetMinMax(pValue:Str1);
begin
  oTable.FieldByName('MinMax').AsString:=pValue;
end;

procedure TStclstHnd.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

function TStclstHnd.GetBegPrq:double;
begin
  Result:=oTable.FieldByName('BegQnt').AsFloat;
end;

procedure TStclstHnd.SetBegPrq(pValue:double);
begin
  oTable.FieldByName('BegQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetIncPrq:double;
begin
  Result:=oTable.FieldByName('InQnt').AsFloat;
end;

procedure TStclstHnd.SetIncPrq(pValue:double);
begin
  oTable.FieldByName('InQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutQnt').AsFloat;
end;

procedure TStclstHnd.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetActPrq:double;
begin
  Result:=oTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStclstHnd.SetActPrq(pValue:double);
begin
  oTable.FieldByName('ActQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetFrePrq:double;
begin
  Result:=oTable.FieldByName('FreQnt').AsFloat;
end;

procedure TStclstHnd.SetFrePrq(pValue:double);
begin
  oTable.FieldByName('FreQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetFroPrq:double;
begin
  Result:=oTable.FieldByName('FroQnt').AsFloat;
end;

procedure TStclstHnd.SetFroPrq(pValue:double);
begin
  oTable.FieldByName('FroQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetReqPrq:double;
begin
  Result:=oTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStclstHnd.SetReqPrq(pValue:double);
begin
  oTable.FieldByName('NrsQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetRstPrq:double;
begin
  Result:=oTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TStclstHnd.SetRstPrq(pValue:double);
begin
  oTable.FieldByName('OcdQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetRosPrq:double;
begin
  Result:=oTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TStclstHnd.SetRosPrq(pValue:double);
begin
  oTable.FieldByName('OsrQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetRsaPrq:double;
begin
  Result:=oTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStclstHnd.SetRsaPrq(pValue:double);
begin
  oTable.FieldByName('SalQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetOsdPrq:double;
begin
  Result:=oTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TStclstHnd.SetOsdPrq(pValue:double);
begin
  oTable.FieldByName('OsdQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetMinPrq:double;
begin
  Result:=oTable.FieldByName('MinQnt').AsFloat;
end;

procedure TStclstHnd.SetMinPrq(pValue:double);
begin
  oTable.FieldByName('MinQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetMaxPrq:double;
begin
  Result:=oTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TStclstHnd.SetMaxPrq(pValue:double);
begin
  oTable.FieldByName('MaxQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetOptPrq:double;
begin
  Result:=oTable.FieldByName('OptQnt').AsFloat;
end;

procedure TStclstHnd.SetOptPrq(pValue:double);
begin
  oTable.FieldByName('OptQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetPosPrq:double;
begin
  Result:=oTable.FieldByName('PosQnt').AsFloat;
end;

procedure TStclstHnd.SetPosPrq(pValue:double);
begin
  oTable.FieldByName('PosQnt').AsFloat:=pValue;
end;

function TStclstHnd.GetBegVal:double;
begin
  Result:=oTable.FieldByName('BegVal').AsFloat;
end;

procedure TStclstHnd.SetBegVal(pValue:double);
begin
  oTable.FieldByName('BegVal').AsFloat:=pValue;
end;

function TStclstHnd.GetIncVal:double;
begin
  Result:=oTable.FieldByName('InVal').AsFloat;
end;

procedure TStclstHnd.SetIncVal(pValue:double);
begin
  oTable.FieldByName('InVal').AsFloat:=pValue;
end;

function TStclstHnd.GetOutVal:double;
begin
  Result:=oTable.FieldByName('OutVal').AsFloat;
end;

procedure TStclstHnd.SetOutVal(pValue:double);
begin
  oTable.FieldByName('OutVal').AsFloat:=pValue;
end;

function TStclstHnd.GetActVal:double;
begin
  Result:=oTable.FieldByName('ActVal').AsFloat;
end;

procedure TStclstHnd.SetActVal(pValue:double);
begin
  oTable.FieldByName('ActVal').AsFloat:=pValue;
end;

function TStclstHnd.GetAvgApc:double;
begin
  Result:=oTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TStclstHnd.SetAvgApc(pValue:double);
begin
  oTable.FieldByName('AvgPrice').AsFloat:=pValue;
end;

function TStclstHnd.GetLasApc:double;
begin
  Result:=oTable.FieldByName('LastPrice').AsFloat;
end;

procedure TStclstHnd.SetLasApc(pValue:double);
begin
  oTable.FieldByName('LastPrice').AsFloat:=pValue;
end;

function TStclstHnd.GetSalApc:double;
begin
  Result:=ClcAvaVat(oTable.FieldByName('BPrice').AsFloat,oTable.FieldByName('VatPrc').AsInteger);
end;

function TStclstHnd.GetDisSta:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('DisFlag').AsInteger);
end;

procedure TStclstHnd.SetDisSta(pValue:boolean);
begin
  oTable.FieldByName('DisFlag').AsInteger:=BoolToByte(pValue);
end;

// **************************************** PUBLIC ********************************************

function TStclstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStclstHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TStclstHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TStclstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStclstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStclstHnd.GotoPos(pStkNum:word;pActPos:longint): boolean;
begin
  Open(pStkNum);
  Result:=oTable.GotoPos(pActPos);
end;

function TStclstHnd.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  Open(pStkNum);
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TStclstHnd.LocMin(pStkNum:word):boolean; 
begin
  Open(pStkNum);
  SetIndex(ixMinMax);
  Result:=oTable.FindKey(['N']);
end;

function TStclstHnd.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  Open(pStkNum);
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

procedure TStclstHnd.SetIndex(pIndexName:Str20);
begin
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStclstHnd.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  oTable:=mDat.rTable;
  oStkNum:=mDat.rStkNum;
end;

procedure TStclstHnd.Open(pStkNum:word);
var mDat:PDat;  mCnt:byte;  mFind:boolean;
begin
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=oTable.BookNum=StrInt(pStkNum,0);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dan� cenn�k este nie je otvoren� potom otvor�me
    oTable:=BtrInit('STK',gPath.StkPath,Self);
    oTable.Open(pStkNum);
    // Ulo��me objekt do zoznamu
    GetMem(mDat,SizeOf(TDat));
    mDat^.rTable:=oTable;
    mDat^.rStkNum:=pStkNum;
    oLst.Add(mDat);
  end;
end;

procedure TStclstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStclstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TStclstHnd.Next;
begin
  oTable.Next;
end;

procedure TStclstHnd.First;
begin
  oTable.First;
end;

procedure TStclstHnd.Last;
begin
  oTable.Last;
end;

procedure TStclstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TStclstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TStclstHnd.Post;
begin
  oTable.Post;
end;

procedure TStclstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TStclstHnd.SwapIndex;
begin
  oTable.SwapIndex;
end;

procedure TStclstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStclstHnd.SwapStatus;
begin
  oTable.SwapStatus;
end;

procedure TStclstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStclstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStclstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001}
