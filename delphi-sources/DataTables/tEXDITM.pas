unit tEXDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPnSnWnIa='';
  ixPnSnWn='PnSnWn';
  ixOnOi='OnOi';
  ixOcdNum='OcdNum';
  ixProNum='ProNum';
  ixPgrNum='PgrNum';
  ixProNam_='ProNam_';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TExditmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum (pValue:word);
    function GetOciAdr:longint;          procedure SetOciAdr (pValue:longint);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm (pValue:word);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum (pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum (pValue:word);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod (pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod (pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetProVol:double;           procedure SetProVol (pValue:double);
    function GetProWgh:double;           procedure SetProWgh (pValue:double);
    function GetProTyp:Str1;             procedure SetProTyp (pValue:Str1);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetVatPrc:byte;             procedure SetVatPrc (pValue:byte);
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetExpPrq:double;           procedure SetExpPrq (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPlsAva:double;           procedure SetPlsAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPnSnWnIa (pParNum:longint;pSpaNum:longint;pWpaNum:word;pOciAdr:longint):boolean;
    function LocPnSnWn (pParNum:longint;pSpaNum:longint;pWpaNum:word):boolean;
    function LocOnOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function LocOcdNum (pOcdNum:Str12):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocPgrNum (pPgrNum:word):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
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
    property ParNum:longint read GetParNum write SetParNum;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property WpaNum:word read GetWpaNum write SetWpaNum;
    property OciAdr:longint read GetOciAdr write SetOciAdr;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property ProNum:longint read GetProNum write SetProNum;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property ProTyp:Str1 read GetProTyp write SetProTyp;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property Cctvat:byte read GetCctvat write SetCctvat;
    property ExpPrq:double read GetExpPrq write SetExpPrq;
    property StkAva:double read GetStkAva write SetStkAva;
    property PlsAva:double read GetPlsAva write SetPlsAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property Notice:Str50 read GetNotice write SetNotice;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TExditmTmp.Create;
begin
  oTmpTable:=TmpInit ('EXDITM',Self);
end;

destructor TExditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TExditmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TExditmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TExditmTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TExditmTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TExditmTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TExditmTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TExditmTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TExditmTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TExditmTmp.GetOciAdr:longint;
begin
  Result:=oTmpTable.FieldByName('OciAdr').AsInteger;
end;

procedure TExditmTmp.SetOciAdr(pValue:longint);
begin
  oTmpTable.FieldByName('OciAdr').AsInteger:=pValue;
end;

function TExditmTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TExditmTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TExditmTmp.GetOcdItm:word;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TExditmTmp.SetOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TExditmTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TExditmTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TExditmTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TExditmTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TExditmTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TExditmTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TExditmTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TExditmTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TExditmTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TExditmTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TExditmTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TExditmTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TExditmTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TExditmTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TExditmTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TExditmTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TExditmTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TExditmTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TExditmTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TExditmTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TExditmTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TExditmTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TExditmTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TExditmTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TExditmTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TExditmTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TExditmTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TExditmTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TExditmTmp.GetProTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('ProTyp').AsString;
end;

procedure TExditmTmp.SetProTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('ProTyp').AsString:=pValue;
end;

function TExditmTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TExditmTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TExditmTmp.GetVatPrc:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TExditmTmp.SetVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TExditmTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TExditmTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TExditmTmp.GetExpPrq:double;
begin
  Result:=oTmpTable.FieldByName('ExpPrq').AsFloat;
end;

procedure TExditmTmp.SetExpPrq(pValue:double);
begin
  oTmpTable.FieldByName('ExpPrq').AsFloat:=pValue;
end;

function TExditmTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TExditmTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TExditmTmp.GetPlsAva:double;
begin
  Result:=oTmpTable.FieldByName('PlsAva').AsFloat;
end;

procedure TExditmTmp.SetPlsAva(pValue:double);
begin
  oTmpTable.FieldByName('PlsAva').AsFloat:=pValue;
end;

function TExditmTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TExditmTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TExditmTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TExditmTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TExditmTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TExditmTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TExditmTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TExditmTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TExditmTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TExditmTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TExditmTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TExditmTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TExditmTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TExditmTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TExditmTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TExditmTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TExditmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TExditmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TExditmTmp.LocPnSnWnIa(pParNum:longint;pSpaNum:longint;pWpaNum:word;pOciAdr:longint):boolean;
begin
  SetIndex (ixPnSnWnIa);
  Result:=oTmpTable.FindKey([pParNum,pSpaNum,pWpaNum,pOciAdr]);
end;

function TExditmTmp.LocPnSnWn(pParNum:longint;pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex (ixPnSnWn);
  Result:=oTmpTable.FindKey([pParNum,pSpaNum,pWpaNum]);
end;

function TExditmTmp.LocOnOi(pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result:=oTmpTable.FindKey([pOcdNum,pOcdItm]);
end;

function TExditmTmp.LocOcdNum(pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result:=oTmpTable.FindKey([pOcdNum]);
end;

function TExditmTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TExditmTmp.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex (ixPgrNum);
  Result:=oTmpTable.FindKey([pPgrNum]);
end;

function TExditmTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TExditmTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TExditmTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TExditmTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TExditmTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TExditmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TExditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TExditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TExditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TExditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TExditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TExditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TExditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TExditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TExditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TExditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TExditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TExditmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TExditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TExditmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TExditmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TExditmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
