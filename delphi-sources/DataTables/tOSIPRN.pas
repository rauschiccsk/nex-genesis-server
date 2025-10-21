unit tOSIPRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixItmNum='ItmNum';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TOsiprnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetProVol:double;           procedure SetProVol (pValue:double);
    function GetProWgh:double;           procedure SetProWgh (pValue:double);
    function GetProTyp:Str1;             procedure SetProTyp (pValue:Str1);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam (pProNam:Str60):boolean;
    function LocBarCod (pBarCod:Str15):boolean;
    function LocStkCod (pStkCod:Str15):boolean;
    function LocShpCod (pShpCod:Str30):boolean;
    function LocOrdCod (pOrdCod:Str30):boolean;

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
    property ItmAdr:longint read GetItmAdr write SetItmAdr;
    property ItmNum:word read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property ProTyp:Str1 read GetProTyp write SetProTyp;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property Notice:Str50 read GetNotice write SetNotice;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TOsiprnTmp.Create;
begin
  oTmpTable:=TmpInit ('OSIPRN',Self);
end;

destructor TOsiprnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsiprnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsiprnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsiprnTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOsiprnTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOsiprnTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsiprnTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsiprnTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsiprnTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsiprnTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsiprnTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsiprnTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsiprnTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsiprnTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsiprnTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsiprnTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOsiprnTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOsiprnTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsiprnTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsiprnTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOsiprnTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsiprnTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOsiprnTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOsiprnTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOsiprnTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsiprnTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOsiprnTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOsiprnTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOsiprnTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOsiprnTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOsiprnTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOsiprnTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsiprnTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsiprnTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsiprnTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsiprnTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsiprnTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsiprnTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsiprnTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsiprnTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsiprnTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsiprnTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOsiprnTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOsiprnTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOsiprnTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOsiprnTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOsiprnTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOsiprnTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOsiprnTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TOsiprnTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOsiprnTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsiprnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsiprnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsiprnTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOsiprnTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TOsiprnTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOsiprnTmp.LocProNam(pProNam:Str60):boolean;
begin
  SetIndex (ixProNam);
  Result:=oTmpTable.FindKey([pProNam]);
end;

function TOsiprnTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TOsiprnTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TOsiprnTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TOsiprnTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TOsiprnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsiprnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsiprnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsiprnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsiprnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsiprnTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsiprnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsiprnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsiprnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsiprnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsiprnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsiprnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsiprnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsiprnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsiprnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsiprnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsiprnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
