unit tIVI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIlGsPo='';
  ixIlIi='IlIi';
  ixGsCode='GsCode';
  ixMgCode='MgCode';
  ixGsName='GsName';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixIvQnt1='IvQnt1';
  ixIvQnt2='IvQnt2';
  ixDifQnt='DifQnt';
  ixDifStat='DifStat';
  ixGsPc='GsPc';

type
  TIviTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetIvlNum:word;             procedure SetIvlNum (pValue:word);
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetPosCode:Str15;           procedure SetPosCode (pValue:Str15);
    function GetIviNum:word;             procedure SetIviNum (pValue:word);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetGsName_:Str30;           procedure SetGsName_ (pValue:Str30);
    function GetMgCode:word;             procedure SetMgCode (pValue:word);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetMsName:Str10;            procedure SetMsName (pValue:Str10);
    function GetIvQnt1:double;           procedure SetIvQnt1 (pValue:double);
    function GetIvQnt2:double;           procedure SetIvQnt2 (pValue:double);
    function GetDifQnt:double;           procedure SetDifQnt (pValue:double);
    function GetIvQnt:double;            procedure SetIvQnt (pValue:double);
    function GetActQnt:double;           procedure SetActQnt (pValue:double);
    function GetStkDif:double;           procedure SetStkDif (pValue:double);
    function GetAvgPrice:double;         procedure SetAvgPrice (pValue:double);
    function GetLastPrice:double;        procedure SetLastPrice (pValue:double);
    function GetBPrice:double;           procedure SetBPrice (pValue:double);
    function GetClosed:byte;             procedure SetClosed (pValue:byte);
    function GetDifStat:Str1;            procedure SetDifStat (pValue:Str1);
    function GetModNum:word;             procedure SetModNum (pValue:word);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocIlGsPo (pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;
    function LocIlIi (pIvlNum:word;pIvinum:word):boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocMgCode (pMgCode:word):boolean;
    function LocGsName (pGsName_:Str30):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocIvQnt1 (pIvQnt1:double):boolean;
    function LocIvQnt2 (pIvQnt2:double):boolean;
    function LocDifQnt (pDifQnt:double):boolean;
    function LocDifStat (pDifStat:Str1):boolean;
    function LocGsPc (pGsCode:longint;pPosCode:Str15):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property IvlNum:word read GetIvlNum write SetIvlNum;
    property GsCode:longint read GetGsCode write SetGsCode;
    property PosCode:Str15 read GetPosCode write SetPosCode;
    property IviNum:word read GetIviNum write SetIviNum;
    property GsName:Str30 read GetGsName write SetGsName;
    property GsName_:Str30 read GetGsName_ write SetGsName_;
    property MgCode:word read GetMgCode write SetMgCode;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property MsName:Str10 read GetMsName write SetMsName;
    property IvQnt1:double read GetIvQnt1 write SetIvQnt1;
    property IvQnt2:double read GetIvQnt2 write SetIvQnt2;
    property DifQnt:double read GetDifQnt write SetDifQnt;
    property IvQnt:double read GetIvQnt write SetIvQnt;
    property ActQnt:double read GetActQnt write SetActQnt;
    property StkDif:double read GetStkDif write SetStkDif;
    property AvgPrice:double read GetAvgPrice write SetAvgPrice;
    property LastPrice:double read GetLastPrice write SetLastPrice;
    property BPrice:double read GetBPrice write SetBPrice;
    property Closed:byte read GetClosed write SetClosed;
    property DifStat:Str1 read GetDifStat write SetDifStat;
    property ModNum:word read GetModNum write SetModNum;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
    property ItmNum:word read GetItmNum write SetItmNum;
  end;

implementation

constructor TIviTmp.Create;
begin
  oTmpTable:=TmpInit ('IVI',Self);
end;

destructor TIviTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIviTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIviTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIviTmp.GetIvlNum:word;
begin
  Result:=oTmpTable.FieldByName('IvlNum').AsInteger;
end;

procedure TIviTmp.SetIvlNum(pValue:word);
begin
  oTmpTable.FieldByName('IvlNum').AsInteger:=pValue;
end;

function TIviTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIviTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TIviTmp.GetPosCode:Str15;
begin
  Result:=oTmpTable.FieldByName('PosCode').AsString;
end;

procedure TIviTmp.SetPosCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PosCode').AsString:=pValue;
end;

function TIviTmp.GetIviNum:word;
begin
  Result:=oTmpTable.FieldByName('IviNum').AsInteger;
end;

procedure TIviTmp.SetIviNum(pValue:word);
begin
  oTmpTable.FieldByName('IviNum').AsInteger:=pValue;
end;

function TIviTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIviTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TIviTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TIviTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TIviTmp.GetMgCode:word;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TIviTmp.SetMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TIviTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TIviTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TIviTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TIviTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TIviTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TIviTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TIviTmp.GetIvQnt1:double;
begin
  Result:=oTmpTable.FieldByName('IvQnt1').AsFloat;
end;

procedure TIviTmp.SetIvQnt1(pValue:double);
begin
  oTmpTable.FieldByName('IvQnt1').AsFloat:=pValue;
end;

function TIviTmp.GetIvQnt2:double;
begin
  Result:=oTmpTable.FieldByName('IvQnt2').AsFloat;
end;

procedure TIviTmp.SetIvQnt2(pValue:double);
begin
  oTmpTable.FieldByName('IvQnt2').AsFloat:=pValue;
end;

function TIviTmp.GetDifQnt:double;
begin
  Result:=oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TIviTmp.SetDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat:=pValue;
end;

function TIviTmp.GetIvQnt:double;
begin
  Result:=oTmpTable.FieldByName('IvQnt').AsFloat;
end;

procedure TIviTmp.SetIvQnt(pValue:double);
begin
  oTmpTable.FieldByName('IvQnt').AsFloat:=pValue;
end;

function TIviTmp.GetActQnt:double;
begin
  Result:=oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TIviTmp.SetActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat:=pValue;
end;

function TIviTmp.GetStkDif:double;
begin
  Result:=oTmpTable.FieldByName('StkDif').AsFloat;
end;

procedure TIviTmp.SetStkDif(pValue:double);
begin
  oTmpTable.FieldByName('StkDif').AsFloat:=pValue;
end;

function TIviTmp.GetAvgPrice:double;
begin
  Result:=oTmpTable.FieldByName('AvgPrice').AsFloat;
end;

procedure TIviTmp.SetAvgPrice(pValue:double);
begin
  oTmpTable.FieldByName('AvgPrice').AsFloat:=pValue;
end;

function TIviTmp.GetLastPrice:double;
begin
  Result:=oTmpTable.FieldByName('LastPrice').AsFloat;
end;

procedure TIviTmp.SetLastPrice(pValue:double);
begin
  oTmpTable.FieldByName('LastPrice').AsFloat:=pValue;
end;

function TIviTmp.GetBPrice:double;
begin
  Result:=oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TIviTmp.SetBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat:=pValue;
end;

function TIviTmp.GetClosed:byte;
begin
  Result:=oTmpTable.FieldByName('Closed').AsInteger;
end;

procedure TIviTmp.SetClosed(pValue:byte);
begin
  oTmpTable.FieldByName('Closed').AsInteger:=pValue;
end;

function TIviTmp.GetDifStat:Str1;
begin
  Result:=oTmpTable.FieldByName('DifStat').AsString;
end;

procedure TIviTmp.SetDifStat(pValue:Str1);
begin
  oTmpTable.FieldByName('DifStat').AsString:=pValue;
end;

function TIviTmp.GetModNum:word;
begin
  Result:=oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIviTmp.SetModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TIviTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIviTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TIviTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIviTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TIviTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIviTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TIviTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIviTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

function TIviTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIviTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIviTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIviTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIviTmp.LocIlGsPo(pIvlNum:word;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixIlGsPo);
  Result:=oTmpTable.FindKey([pIvlNum,pGsCode,pPosCode]);
end;

function TIviTmp.LocIlIi(pIvlNum:word;pIvinum:word):boolean;
begin
  SetIndex (ixIlIi);
  Result:=oTmpTable.FindKey([pIvlNum,pIvinum]);
end;

function TIviTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TIviTmp.LocMgCode(pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result:=oTmpTable.FindKey([pMgCode]);
end;

function TIviTmp.LocGsName(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TIviTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TIviTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TIviTmp.LocIvQnt1(pIvQnt1:double):boolean;
begin
  SetIndex (ixIvQnt1);
  Result:=oTmpTable.FindKey([pIvQnt1]);
end;

function TIviTmp.LocIvQnt2(pIvQnt2:double):boolean;
begin
  SetIndex (ixIvQnt2);
  Result:=oTmpTable.FindKey([pIvQnt2]);
end;

function TIviTmp.LocDifQnt(pDifQnt:double):boolean;
begin
  SetIndex (ixDifQnt);
  Result:=oTmpTable.FindKey([pDifQnt]);
end;

function TIviTmp.LocDifStat(pDifStat:Str1):boolean;
begin
  SetIndex (ixDifStat);
  Result:=oTmpTable.FindKey([pDifStat]);
end;

function TIviTmp.LocGsPc(pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixGsPc);
  Result:=oTmpTable.FindKey([pGsCode,pPosCode]);
end;

procedure TIviTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIviTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIviTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIviTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIviTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIviTmp.First;
begin
  oTmpTable.First;
end;

procedure TIviTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIviTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIviTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIviTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIviTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIviTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIviTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIviTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIviTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIviTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIviTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
