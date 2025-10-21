unit tOSIUND;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixSnPn='SnPn';
  ixRatDte='RatDte';

type
  TOsiundTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq (pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq (pValue:double);
    function GetCncPrq:double;           procedure SetCncPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq (pValue:double);
    function GetOrdApc:double;           procedure SetOrdApc (pValue:double);
    function GetOrdAva:double;           procedure SetOrdAva (pValue:double);
    function GetOrdBva:double;           procedure SetOrdBva (pValue:double);
    function GetOrpSrc:Str2;             procedure SetOrpSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte (pValue:TDatetime);
    function GetSndSta:Str1;             procedure SetSndSta (pValue:Str1);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocSnPn (pStkNum:word;pProNum:longint):boolean;
    function LocRatDte (pRatDte:TDatetime):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property CncPrq:double read GetCncPrq write SetCncPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
    property OrdApc:double read GetOrdApc write SetOrdApc;
    property OrdAva:double read GetOrdAva write SetOrdAva;
    property OrdBva:double read GetOrdBva write SetOrdBva;
    property OrpSrc:Str2 read GetOrpSrc write SetOrpSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property SndSta:Str1 read GetSndSta write SetSndSta;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
  end;

implementation

constructor TOsiundTmp.Create;
begin
  oTmpTable:=TmpInit ('OSIUND',Self);
end;

destructor TOsiundTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsiundTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsiundTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsiundTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TOsiundTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TOsiundTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TOsiundTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TOsiundTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOsiundTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsiundTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsiundTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsiundTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsiundTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TOsiundTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsiundTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsiundTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsiundTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsiundTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsiundTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsiundTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsiundTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsiundTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsiundTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TOsiundTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsiundTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetRocPrq:double;
begin
  Result:=oTmpTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOsiundTmp.SetRocPrq(pValue:double);
begin
  oTmpTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetTsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOsiundTmp.SetTsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetCncPrq:double;
begin
  Result:=oTmpTable.FieldByName('CncPrq').AsFloat;
end;

procedure TOsiundTmp.SetCncPrq(pValue:double);
begin
  oTmpTable.FieldByName('CncPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOsiundTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOsiundTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

function TOsiundTmp.GetOrdApc:double;
begin
  Result:=oTmpTable.FieldByName('OrdApc').AsFloat;
end;

procedure TOsiundTmp.SetOrdApc(pValue:double);
begin
  oTmpTable.FieldByName('OrdApc').AsFloat:=pValue;
end;

function TOsiundTmp.GetOrdAva:double;
begin
  Result:=oTmpTable.FieldByName('OrdAva').AsFloat;
end;

procedure TOsiundTmp.SetOrdAva(pValue:double);
begin
  oTmpTable.FieldByName('OrdAva').AsFloat:=pValue;
end;

function TOsiundTmp.GetOrdBva:double;
begin
  Result:=oTmpTable.FieldByName('OrdBva').AsFloat;
end;

procedure TOsiundTmp.SetOrdBva(pValue:double);
begin
  oTmpTable.FieldByName('OrdBva').AsFloat:=pValue;
end;

function TOsiundTmp.GetOrpSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('OrpSrc').AsString;
end;

procedure TOsiundTmp.SetOrpSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('OrpSrc').AsString:=pValue;
end;

function TOsiundTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TOsiundTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TOsiundTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TOsiundTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TOsiundTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TOsiundTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TOsiundTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TOsiundTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOsiundTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TOsiundTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOsiundTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOsiundTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOsiundTmp.GetSndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDte').AsDateTime;
end;

procedure TOsiundTmp.SetSndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TOsiundTmp.GetSndSta:Str1;
begin
  Result:=oTmpTable.FieldByName('SndSta').AsString;
end;

procedure TOsiundTmp.SetSndSta(pValue:Str1);
begin
  oTmpTable.FieldByName('SndSta').AsString:=pValue;
end;

function TOsiundTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsiundTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsiundTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsiundTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsiundTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TOsiundTmp.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex (ixSnPn);
  Result:=oTmpTable.FindKey([pStkNum,pProNum]);
end;

function TOsiundTmp.LocRatDte(pRatDte:TDatetime):boolean;
begin
  SetIndex (ixRatDte);
  Result:=oTmpTable.FindKey([pRatDte]);
end;

procedure TOsiundTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsiundTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsiundTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsiundTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsiundTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsiundTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsiundTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsiundTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsiundTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsiundTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsiundTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsiundTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsiundTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsiundTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsiundTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsiundTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsiundTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
