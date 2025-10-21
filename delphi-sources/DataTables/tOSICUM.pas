unit tOSICUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='';
  ixProNam='ProNam';

type
  TOsicumTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
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
    function GetOrdPrq:double;           procedure SetOrdPrq (pValue:double);
    function GetRocPrq:double;           procedure SetRocPrq (pValue:double);
    function GetTsdPrq:double;           procedure SetTsdPrq (pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq (pValue:double);
    function GetIsdPrq:double;           procedure SetIsdPrq (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam (pProNam_:Str60):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
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
    property OrdPrq:double read GetOrdPrq write SetOrdPrq;
    property RocPrq:double read GetRocPrq write SetRocPrq;
    property TsdPrq:double read GetTsdPrq write SetTsdPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property IsdPrq:double read GetIsdPrq write SetIsdPrq;
  end;

implementation

constructor TOsicumTmp.Create;
begin
  oTmpTable:=TmpInit ('OSICUM',Self);
end;

destructor TOsicumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsicumTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOsicumTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsicumTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsicumTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsicumTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOsicumTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsicumTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOsicumTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsicumTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TOsicumTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TOsicumTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TOsicumTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TOsicumTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TOsicumTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TOsicumTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TOsicumTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TOsicumTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TOsicumTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TOsicumTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TOsicumTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TOsicumTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TOsicumTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TOsicumTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TOsicumTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TOsicumTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TOsicumTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TOsicumTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TOsicumTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TOsicumTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TOsicumTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TOsicumTmp.GetOrdPrq:double;
begin
  Result:=oTmpTable.FieldByName('OrdPrq').AsFloat;
end;

procedure TOsicumTmp.SetOrdPrq(pValue:double);
begin
  oTmpTable.FieldByName('OrdPrq').AsFloat:=pValue;
end;

function TOsicumTmp.GetRocPrq:double;
begin
  Result:=oTmpTable.FieldByName('RocPrq').AsFloat;
end;

procedure TOsicumTmp.SetRocPrq(pValue:double);
begin
  oTmpTable.FieldByName('RocPrq').AsFloat:=pValue;
end;

function TOsicumTmp.GetTsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TsdPrq').AsFloat;
end;

procedure TOsicumTmp.SetTsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TsdPrq').AsFloat:=pValue;
end;

function TOsicumTmp.GetUndPrq:double;
begin
  Result:=oTmpTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOsicumTmp.SetUndPrq(pValue:double);
begin
  oTmpTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOsicumTmp.GetIsdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IsdPrq').AsFloat;
end;

procedure TOsicumTmp.SetIsdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IsdPrq').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsicumTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOsicumTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOsicumTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOsicumTmp.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TOsicumTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOsicumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsicumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsicumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsicumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsicumTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsicumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsicumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsicumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsicumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsicumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsicumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsicumTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsicumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsicumTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsicumTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOsicumTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
