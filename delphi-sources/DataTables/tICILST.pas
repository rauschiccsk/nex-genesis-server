unit tICILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='';
  ixItmNum='ItmNum';
  ixProNum='ProNum';
  ixBarCod='BarCod';
  ixProNam='ProNam';
  ixParNum='ParNum';
  ixDocDte='DocDte';
  ixMnMi='MnMi';
  ixOnOi='OnOi';
  ixTnTi='TnTi';
  ixDlrNum='DlrNum';

type
  TIcilstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmAdr:longint;          procedure SetItmAdr (pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetPrjNum:Str12;            procedure SetPrjNum (pValue:Str12);
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
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc (pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetMcdNum:Str12;            procedure SetMcdNum (pValue:Str12);
    function GetMcdItm:word;             procedure SetMcdItm (pValue:word);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm (pValue:word);
    function GetTcdNum:Str12;            procedure SetTcdNum (pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm (pValue:word);
    function GetTcdDte:TDatetime;        procedure SetTcdDte (pValue:TDatetime);
    function GetTcdPrq:double;           procedure SetTcdPrq (pValue:double);
    function GetIccNum:Str12;            procedure SetIccNum (pValue:Str12);
    function GetIccItm:word;             procedure SetIccItm (pValue:word);
    function GetCrtUsr:str8;             procedure SetCrtUsr (pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk (pValue:Str10);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetDlrNum:longint;          procedure SetDlrNum (pValue:longint);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str8;             procedure SetAccAnl (pValue:Str8);
    function GetItmFrm:Str10;            procedure SetItmFrm (pValue:Str10);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmAdr (pItmAdr:longint):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocBarCod (pBarCod:Str15):boolean;
    function LocProNam (pProNam_:Str60):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocDocDte (pDocDte:TDatetime):boolean;
    function LocMnMi (pMcdNum:Str12;pMcdItm:word):boolean;
    function LocOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function LocTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function LocDlrNum (pDlrNum:longint):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
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
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property StkAva:double read GetStkAva write SetStkAva;
    property PlsAva:double read GetPlsAva write SetPlsAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property SalApc:double read GetSalApc write SetSalApc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property SapSrc:Str2 read GetSapSrc write SetSapSrc;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property McdNum:Str12 read GetMcdNum write SetMcdNum;
    property McdItm:word read GetMcdItm write SetMcdItm;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property TcdDte:TDatetime read GetTcdDte write SetTcdDte;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property IccNum:Str12 read GetIccNum write SetIccNum;
    property IccItm:word read GetIccItm write SetIccItm;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property Notice:Str50 read GetNotice write SetNotice;
    property DlrNum:longint read GetDlrNum write SetDlrNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str8 read GetAccAnl write SetAccAnl;
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
  end;

implementation

constructor TIcilstTmp.Create;
begin
  oTmpTable:=TmpInit ('ICILST',Self);
end;

destructor TIcilstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIcilstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIcilstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIcilstTmp.GetItmAdr:longint;
begin
  Result:=oTmpTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TIcilstTmp.SetItmAdr(pValue:longint);
begin
  oTmpTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TIcilstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIcilstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIcilstTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIcilstTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TIcilstTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIcilstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIcilstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIcilstTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetPrjNum:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjNum').AsString;
end;

procedure TIcilstTmp.SetPrjNum(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TIcilstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TIcilstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TIcilstTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TIcilstTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TIcilstTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TIcilstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TIcilstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TIcilstTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TIcilstTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TIcilstTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TIcilstTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TIcilstTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TIcilstTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TIcilstTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TIcilstTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TIcilstTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TIcilstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TIcilstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TIcilstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TIcilstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TIcilstTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TIcilstTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TIcilstTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TIcilstTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TIcilstTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIcilstTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TIcilstTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TIcilstTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TIcilstTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TIcilstTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TIcilstTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TIcilstTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TIcilstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIcilstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIcilstTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TIcilstTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TIcilstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TIcilstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TIcilstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TIcilstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TIcilstTmp.GetSapSrc:Str2;
begin
  Result:=oTmpTable.FieldByName('SapSrc').AsString;
end;

procedure TIcilstTmp.SetSapSrc(pValue:Str2);
begin
  oTmpTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TIcilstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TIcilstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TIcilstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TIcilstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TIcilstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TIcilstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TIcilstTmp.GetMcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TIcilstTmp.SetMcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('McdNum').AsString:=pValue;
end;

function TIcilstTmp.GetMcdItm:word;
begin
  Result:=oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TIcilstTmp.SetMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TIcilstTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TIcilstTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TIcilstTmp.GetOcdItm:word;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TIcilstTmp.SetOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TIcilstTmp.GetTcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TIcilstTmp.SetTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TIcilstTmp.GetTcdItm:word;
begin
  Result:=oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TIcilstTmp.SetTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TIcilstTmp.GetTcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TIcilstTmp.SetTcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TIcilstTmp.GetTcdPrq:double;
begin
  Result:=oTmpTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TIcilstTmp.SetTcdPrq(pValue:double);
begin
  oTmpTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TIcilstTmp.GetIccNum:Str12;
begin
  Result:=oTmpTable.FieldByName('IccNum').AsString;
end;

procedure TIcilstTmp.SetIccNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IccNum').AsString:=pValue;
end;

function TIcilstTmp.GetIccItm:word;
begin
  Result:=oTmpTable.FieldByName('IccItm').AsInteger;
end;

procedure TIcilstTmp.SetIccItm(pValue:word);
begin
  oTmpTable.FieldByName('IccItm').AsInteger:=pValue;
end;

function TIcilstTmp.GetCrtUsr:str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TIcilstTmp.SetCrtUsr(pValue:str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIcilstTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIcilstTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIcilstTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIcilstTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIcilstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TIcilstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIcilstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIcilstTmp.GetSpcMrk:Str10;
begin
  Result:=oTmpTable.FieldByName('SpcMrk').AsString;
end;

procedure TIcilstTmp.SetSpcMrk(pValue:Str10);
begin
  oTmpTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TIcilstTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TIcilstTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TIcilstTmp.GetDlrNum:longint;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TIcilstTmp.SetDlrNum(pValue:longint);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TIcilstTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIcilstTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TIcilstTmp.GetAccAnl:Str8;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIcilstTmp.SetAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TIcilstTmp.GetItmFrm:Str10;
begin
  Result:=oTmpTable.FieldByName('ItmFrm').AsString;
end;

procedure TIcilstTmp.SetItmFrm(pValue:Str10);
begin
  oTmpTable.FieldByName('ItmFrm').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcilstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIcilstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIcilstTmp.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex (ixItmAdr);
  Result:=oTmpTable.FindKey([pItmAdr]);
end;

function TIcilstTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TIcilstTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TIcilstTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TIcilstTmp.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TIcilstTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TIcilstTmp.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex (ixDocDte);
  Result:=oTmpTable.FindKey([pDocDte]);
end;

function TIcilstTmp.LocMnMi(pMcdNum:Str12;pMcdItm:word):boolean;
begin
  SetIndex (ixMnMi);
  Result:=oTmpTable.FindKey([pMcdNum,pMcdItm]);
end;

function TIcilstTmp.LocOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result:=oTmpTable.FindKey([pOcdNum,pOcdItm]);
end;

function TIcilstTmp.LocTnTi(pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result:=oTmpTable.FindKey([pTcdNum,pTcdItm]);
end;

function TIcilstTmp.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex (ixDlrNum);
  Result:=oTmpTable.FindKey([pDlrNum]);
end;

procedure TIcilstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIcilstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIcilstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIcilstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIcilstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIcilstTmp.First;
begin
  oTmpTable.First;
end;

procedure TIcilstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIcilstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIcilstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIcilstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIcilstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIcilstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIcilstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIcilstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIcilstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIcilstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIcilstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
