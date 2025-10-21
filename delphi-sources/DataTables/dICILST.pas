unit dICILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmAdr='ItmAdr';
  ixDocNum='DocNum';
  ixDnIn='DnIn';
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
  TIcilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetItmAdr:longint;          procedure SetItmAdr(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetProVol:double;           procedure SetProVol(pValue:double);
    function GetProWgh:double;           procedure SetProWgh(pValue:double);
    function GetProTyp:Str1;             procedure SetProTyp(pValue:Str1);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva(pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetSalApc:double;           procedure SetSalApc(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetSalBva:double;           procedure SetSalBva(pValue:double);
    function GetSapSrc:Str2;             procedure SetSapSrc(pValue:Str2);
    function GetTrsBva:double;           procedure SetTrsBva(pValue:double);
    function GetEndBva:double;           procedure SetEndBva(pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva(pValue:double);
    function GetMcdNum:Str12;            procedure SetMcdNum(pValue:Str12);
    function GetMcdItm:word;             procedure SetMcdItm(pValue:word);
    function GetOcdNum:Str12;            procedure SetOcdNum(pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm(pValue:word);
    function GetTcdNum:Str12;            procedure SetTcdNum(pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm(pValue:word);
    function GetTcdDte:TDatetime;        procedure SetTcdDte(pValue:TDatetime);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetIccNum:Str12;            procedure SetIccNum(pValue:Str12);
    function GetIccItm:word;             procedure SetIccItm(pValue:word);
    function GetCrtUsr:str15;            procedure SetCrtUsr(pValue:str15);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetSpcMrk:Str10;            procedure SetSpcMrk(pValue:Str10);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetDlrNum:longint;          procedure SetDlrNum(pValue:longint);
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl(pValue:Str6);
    function GetItmFrm:Str10;            procedure SetItmFrm(pValue:Str10);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocItmAdr(pItmAdr:longint):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocMnMi(pMcdNum:Str12;pMcdItm:word):boolean;
    function LocOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
    function LocTnTi(pTcdNum:Str12;pTcdItm:word):boolean;
    function LocDlrNum(pDlrNum:longint):boolean;
    function NearItmAdr(pItmAdr:longint):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearMnMi(pMcdNum:Str12;pMcdItm:word):boolean;
    function NearOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
    function NearTnTi(pTcdNum:Str12;pTcdItm:word):boolean;
    function NearDlrNum(pDlrNum:longint):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
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
    property CrtUsr:str15 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property SpcMrk:Str10 read GetSpcMrk write SetSpcMrk;
    property Notice:Str50 read GetNotice write SetNotice;
    property DlrNum:longint read GetDlrNum write SetDlrNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property ItmFrm:Str10 read GetItmFrm write SetItmFrm;
  end;

implementation

constructor TIcilstDat.Create;
begin
  oTable:=DatInit('ICILST',gPath.LdgPath,Self);
end;

constructor TIcilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ICILST',pPath,Self);
end;

destructor TIcilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIcilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIcilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIcilstDat.GetItmAdr:longint;
begin
  Result:=oTable.FieldByName('ItmAdr').AsInteger;
end;

procedure TIcilstDat.SetItmAdr(pValue:longint);
begin
  oTable.FieldByName('ItmAdr').AsInteger:=pValue;
end;

function TIcilstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIcilstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIcilstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIcilstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIcilstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TIcilstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIcilstDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TIcilstDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIcilstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TIcilstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIcilstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TIcilstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TIcilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TIcilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TIcilstDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TIcilstDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TIcilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TIcilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TIcilstDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TIcilstDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TIcilstDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TIcilstDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TIcilstDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TIcilstDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TIcilstDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TIcilstDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TIcilstDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TIcilstDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TIcilstDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TIcilstDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TIcilstDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TIcilstDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TIcilstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TIcilstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TIcilstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TIcilstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TIcilstDat.GetProTyp:Str1;
begin
  Result:=oTable.FieldByName('ProTyp').AsString;
end;

procedure TIcilstDat.SetProTyp(pValue:Str1);
begin
  oTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TIcilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TIcilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TIcilstDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIcilstDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TIcilstDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TIcilstDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TIcilstDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TIcilstDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TIcilstDat.GetPlsAva:double;
begin
  Result:=oTable.FieldByName('PlsAva').AsFloat;
end;

procedure TIcilstDat.SetPlsAva(pValue:double);
begin
  oTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TIcilstDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIcilstDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIcilstDat.GetSalApc:double;
begin
  Result:=oTable.FieldByName('SalApc').AsFloat;
end;

procedure TIcilstDat.SetSalApc(pValue:double);
begin
  oTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TIcilstDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TIcilstDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TIcilstDat.GetSalBva:double;
begin
  Result:=oTable.FieldByName('SalBva').AsFloat;
end;

procedure TIcilstDat.SetSalBva(pValue:double);
begin
  oTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TIcilstDat.GetSapSrc:Str2;
begin
  Result:=oTable.FieldByName('SapSrc').AsString;
end;

procedure TIcilstDat.SetSapSrc(pValue:Str2);
begin
  oTable.FieldByName('SapSrc').AsString:=pValue;
end;

function TIcilstDat.GetTrsBva:double;
begin
  Result:=oTable.FieldByName('TrsBva').AsFloat;
end;

procedure TIcilstDat.SetTrsBva(pValue:double);
begin
  oTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TIcilstDat.GetEndBva:double;
begin
  Result:=oTable.FieldByName('EndBva').AsFloat;
end;

procedure TIcilstDat.SetEndBva(pValue:double);
begin
  oTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TIcilstDat.GetDvzBva:double;
begin
  Result:=oTable.FieldByName('DvzBva').AsFloat;
end;

procedure TIcilstDat.SetDvzBva(pValue:double);
begin
  oTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TIcilstDat.GetMcdNum:Str12;
begin
  Result:=oTable.FieldByName('McdNum').AsString;
end;

procedure TIcilstDat.SetMcdNum(pValue:Str12);
begin
  oTable.FieldByName('McdNum').AsString:=pValue;
end;

function TIcilstDat.GetMcdItm:word;
begin
  Result:=oTable.FieldByName('McdItm').AsInteger;
end;

procedure TIcilstDat.SetMcdItm(pValue:word);
begin
  oTable.FieldByName('McdItm').AsInteger:=pValue;
end;

function TIcilstDat.GetOcdNum:Str12;
begin
  Result:=oTable.FieldByName('OcdNum').AsString;
end;

procedure TIcilstDat.SetOcdNum(pValue:Str12);
begin
  oTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TIcilstDat.GetOcdItm:word;
begin
  Result:=oTable.FieldByName('OcdItm').AsInteger;
end;

procedure TIcilstDat.SetOcdItm(pValue:word);
begin
  oTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TIcilstDat.GetTcdNum:Str12;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TIcilstDat.SetTcdNum(pValue:Str12);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TIcilstDat.GetTcdItm:word;
begin
  Result:=oTable.FieldByName('TcdItm').AsInteger;
end;

procedure TIcilstDat.SetTcdItm(pValue:word);
begin
  oTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TIcilstDat.GetTcdDte:TDatetime;
begin
  Result:=oTable.FieldByName('TcdDte').AsDateTime;
end;

procedure TIcilstDat.SetTcdDte(pValue:TDatetime);
begin
  oTable.FieldByName('TcdDte').AsDateTime:=pValue;
end;

function TIcilstDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TIcilstDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TIcilstDat.GetIccNum:Str12;
begin
  Result:=oTable.FieldByName('IccNum').AsString;
end;

procedure TIcilstDat.SetIccNum(pValue:Str12);
begin
  oTable.FieldByName('IccNum').AsString:=pValue;
end;

function TIcilstDat.GetIccItm:word;
begin
  Result:=oTable.FieldByName('IccItm').AsInteger;
end;

procedure TIcilstDat.SetIccItm(pValue:word);
begin
  oTable.FieldByName('IccItm').AsInteger:=pValue;
end;

function TIcilstDat.GetCrtUsr:str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIcilstDat.SetCrtUsr(pValue:str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIcilstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIcilstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIcilstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIcilstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIcilstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TIcilstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIcilstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIcilstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIcilstDat.GetSpcMrk:Str10;
begin
  Result:=oTable.FieldByName('SpcMrk').AsString;
end;

procedure TIcilstDat.SetSpcMrk(pValue:Str10);
begin
  oTable.FieldByName('SpcMrk').AsString:=pValue;
end;

function TIcilstDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TIcilstDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TIcilstDat.GetDlrNum:longint;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TIcilstDat.SetDlrNum(pValue:longint);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TIcilstDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TIcilstDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TIcilstDat.GetAccAnl:Str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TIcilstDat.SetAccAnl(pValue:Str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TIcilstDat.GetItmFrm:Str10;
begin
  Result:=oTable.FieldByName('ItmFrm').AsString;
end;

procedure TIcilstDat.SetItmFrm(pValue:Str10);
begin
  oTable.FieldByName('ItmFrm').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIcilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIcilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIcilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIcilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIcilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIcilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIcilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIcilstDat.LocItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindKey([pItmAdr]);
end;

function TIcilstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIcilstDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TIcilstDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TIcilstDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TIcilstDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TIcilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TIcilstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TIcilstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TIcilstDat.LocMnMi(pMcdNum:Str12;pMcdItm:word):boolean;
begin
  SetIndex(ixMnMi);
  Result:=oTable.FindKey([pMcdNum,pMcdItm]);
end;

function TIcilstDat.LocOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex(ixOnOi);
  Result:=oTable.FindKey([pOcdNum,pOcdItm]);
end;

function TIcilstDat.LocTnTi(pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex(ixTnTi);
  Result:=oTable.FindKey([pTcdNum,pTcdItm]);
end;

function TIcilstDat.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TIcilstDat.NearItmAdr(pItmAdr:longint):boolean;
begin
  SetIndex(ixItmAdr);
  Result:=oTable.FindNearest([pItmAdr]);
end;

function TIcilstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIcilstDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TIcilstDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TIcilstDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TIcilstDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TIcilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TIcilstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TIcilstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TIcilstDat.NearMnMi(pMcdNum:Str12;pMcdItm:word):boolean;
begin
  SetIndex(ixMnMi);
  Result:=oTable.FindNearest([pMcdNum,pMcdItm]);
end;

function TIcilstDat.NearOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex(ixOnOi);
  Result:=oTable.FindNearest([pOcdNum,pOcdItm]);
end;

function TIcilstDat.NearTnTi(pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex(ixTnTi);
  Result:=oTable.FindNearest([pTcdNum,pTcdItm]);
end;

function TIcilstDat.NearDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

procedure TIcilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIcilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIcilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIcilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TIcilstDat.Next;
begin
  oTable.Next;
end;

procedure TIcilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIcilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIcilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIcilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TIcilstDat.Post;
begin
  oTable.Post;
end;

procedure TIcilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TIcilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIcilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIcilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIcilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIcilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIcilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
