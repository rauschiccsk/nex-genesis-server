unit tIVMSHI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum='';
  ixBarCod='BarCod';

type
  TIvmshiTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetStkPrq:double;           procedure SetStkPrq (pValue:double);
    function GetIvqFa1:double;           procedure SetIvqFa1 (pValue:double);
    function GetIvqFa2:double;           procedure SetIvqFa2 (pValue:double);
    function GetIvdPrq:double;           procedure SetIvdPrq (pValue:double);
    function GetDifPrq:double;           procedure SetDifPrq (pValue:double);
    function GetDifSta:Str1;             procedure SetDifSta (pValue:Str1);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetCrtUsr:Str10;            procedure SetCrtUsr (pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr (pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn (pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte (pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocBarCod (pBarCod:Str15):boolean;

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
    property ItmNum:word read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property IvqFa1:double read GetIvqFa1 write SetIvqFa1;
    property IvqFa2:double read GetIvqFa2 write SetIvqFa2;
    property IvdPrq:double read GetIvdPrq write SetIvdPrq;
    property DifPrq:double read GetDifPrq write SetDifPrq;
    property DifSta:Str1 read GetDifSta write SetDifSta;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str10 read GetModUsr write SetModUsr;
    property ModUsn:Str30 read GetModUsn write SetModUsn;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TIvmshiTmp.Create;
begin
  oTmpTable:=TmpInit ('IVMSHI',Self);
end;

destructor TIvmshiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIvmshiTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIvmshiTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIvmshiTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIvmshiTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIvmshiTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TIvmshiTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TIvmshiTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TIvmshiTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TIvmshiTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TIvmshiTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TIvmshiTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TIvmshiTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TIvmshiTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TIvmshiTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TIvmshiTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TIvmshiTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TIvmshiTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TIvmshiTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TIvmshiTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TIvmshiTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TIvmshiTmp.GetStkPrq:double;
begin
  Result:=oTmpTable.FieldByName('StkPrq').AsFloat;
end;

procedure TIvmshiTmp.SetStkPrq(pValue:double);
begin
  oTmpTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TIvmshiTmp.GetIvqFa1:double;
begin
  Result:=oTmpTable.FieldByName('IvqFa1').AsFloat;
end;

procedure TIvmshiTmp.SetIvqFa1(pValue:double);
begin
  oTmpTable.FieldByName('IvqFa1').AsFloat:=pValue;
end;

function TIvmshiTmp.GetIvqFa2:double;
begin
  Result:=oTmpTable.FieldByName('IvqFa2').AsFloat;
end;

procedure TIvmshiTmp.SetIvqFa2(pValue:double);
begin
  oTmpTable.FieldByName('IvqFa2').AsFloat:=pValue;
end;

function TIvmshiTmp.GetIvdPrq:double;
begin
  Result:=oTmpTable.FieldByName('IvdPrq').AsFloat;
end;

procedure TIvmshiTmp.SetIvdPrq(pValue:double);
begin
  oTmpTable.FieldByName('IvdPrq').AsFloat:=pValue;
end;

function TIvmshiTmp.GetDifPrq:double;
begin
  Result:=oTmpTable.FieldByName('DifPrq').AsFloat;
end;

procedure TIvmshiTmp.SetDifPrq(pValue:double);
begin
  oTmpTable.FieldByName('DifPrq').AsFloat:=pValue;
end;

function TIvmshiTmp.GetDifSta:Str1;
begin
  Result:=oTmpTable.FieldByName('DifSta').AsString;
end;

procedure TIvmshiTmp.SetDifSta(pValue:Str1);
begin
  oTmpTable.FieldByName('DifSta').AsString:=pValue;
end;

function TIvmshiTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TIvmshiTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIvmshiTmp.GetCrtUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TIvmshiTmp.SetCrtUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIvmshiTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TIvmshiTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIvmshiTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIvmshiTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIvmshiTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIvmshiTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIvmshiTmp.GetModUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('ModUsr').AsString;
end;

procedure TIvmshiTmp.SetModUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TIvmshiTmp.GetModUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('ModUsn').AsString;
end;

procedure TIvmshiTmp.SetModUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TIvmshiTmp.GetModDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDte').AsDateTime;
end;

procedure TIvmshiTmp.SetModDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TIvmshiTmp.GetModTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTim').AsDateTime;
end;

procedure TIvmshiTmp.SetModTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvmshiTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIvmshiTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIvmshiTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TIvmshiTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

procedure TIvmshiTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIvmshiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIvmshiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIvmshiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIvmshiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIvmshiTmp.First;
begin
  oTmpTable.First;
end;

procedure TIvmshiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIvmshiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIvmshiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIvmshiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIvmshiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIvmshiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIvmshiTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIvmshiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIvmshiTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIvmshiTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIvmshiTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
