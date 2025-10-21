unit dIVMIVI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnPn='DnPn';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixPgrNum='PgrNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';
  ixDifSta='DifSta';
  ixBokNum='BokNum';

type
  TIvmiviDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetNsiPrq:double;           procedure SetNsiPrq(pValue:double);
    function GetOcdPrq:double;           procedure SetOcdPrq(pValue:double);
    function GetStkPrq:double;           procedure SetStkPrq(pValue:double);
    function GetIvdPrq:double;           procedure SetIvdPrq(pValue:double);
    function GetDifPrq:double;           procedure SetDifPrq(pValue:double);
    function GetNsiVal:double;           procedure SetNsiVal(pValue:double);
    function GetStkVal:double;           procedure SetStkVal(pValue:double);
    function GetIvdVal:double;           procedure SetIvdVal(pValue:double);
    function GetDifVal:double;           procedure SetDifVal(pValue:double);
    function GetStkApc:double;           procedure SetStkApc(pValue:double);
    function GetSalApc:double;           procedure SetSalApc(pValue:double);
    function GetSalBpc:double;           procedure SetSalBpc(pValue:double);
    function GetDifSta:Str1;             procedure SetDifSta(pValue:Str1);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr(pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn(pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocDocNum(pDocNum:Str12):boolean;
    function LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocPgrNum(pPgrNum:word):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocStkCod(pStkCod:Str15):boolean;
    function LocShpCod(pShpCod:Str30):boolean;
    function LocOrdCod(pOrdCod:Str30):boolean;
    function LocDifSta(pDifSta:Str1):boolean;
    function LocBokNum(pBokNum:Str3):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearPgrNum(pPgrNum:word):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearStkCod(pStkCod:Str15):boolean;
    function NearShpCod(pShpCod:Str30):boolean;
    function NearOrdCod(pOrdCod:Str30):boolean;
    function NearDifSta(pDifSta:Str1):boolean;
    function NearBokNum(pBokNum:Str3):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property NsiPrq:double read GetNsiPrq write SetNsiPrq;
    property OcdPrq:double read GetOcdPrq write SetOcdPrq;
    property StkPrq:double read GetStkPrq write SetStkPrq;
    property IvdPrq:double read GetIvdPrq write SetIvdPrq;
    property DifPrq:double read GetDifPrq write SetDifPrq;
    property NsiVal:double read GetNsiVal write SetNsiVal;
    property StkVal:double read GetStkVal write SetStkVal;
    property IvdVal:double read GetIvdVal write SetIvdVal;
    property DifVal:double read GetDifVal write SetDifVal;
    property StkApc:double read GetStkApc write SetStkApc;
    property SalApc:double read GetSalApc write SetSalApc;
    property SalBpc:double read GetSalBpc write SetSalBpc;
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

constructor TIvmiviDat.Create;
begin
  oTable:=DatInit('IVMIVI',gPath.StkPath,Self);
end;

constructor TIvmiviDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('IVMIVI',pPath,Self);
end;

destructor TIvmiviDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIvmiviDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIvmiviDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIvmiviDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIvmiviDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIvmiviDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TIvmiviDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TIvmiviDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TIvmiviDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TIvmiviDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TIvmiviDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TIvmiviDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TIvmiviDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TIvmiviDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TIvmiviDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TIvmiviDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TIvmiviDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TIvmiviDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TIvmiviDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TIvmiviDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TIvmiviDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TIvmiviDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TIvmiviDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TIvmiviDat.GetNsiPrq:double;
begin
  Result:=oTable.FieldByName('NsiPrq').AsFloat;
end;

procedure TIvmiviDat.SetNsiPrq(pValue:double);
begin
  oTable.FieldByName('NsiPrq').AsFloat:=pValue;
end;

function TIvmiviDat.GetOcdPrq:double;
begin
  Result:=oTable.FieldByName('OcdPrq').AsFloat;
end;

procedure TIvmiviDat.SetOcdPrq(pValue:double);
begin
  oTable.FieldByName('OcdPrq').AsFloat:=pValue;
end;

function TIvmiviDat.GetStkPrq:double;
begin
  Result:=oTable.FieldByName('StkPrq').AsFloat;
end;

procedure TIvmiviDat.SetStkPrq(pValue:double);
begin
  oTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TIvmiviDat.GetIvdPrq:double;
begin
  Result:=oTable.FieldByName('IvdPrq').AsFloat;
end;

procedure TIvmiviDat.SetIvdPrq(pValue:double);
begin
  oTable.FieldByName('IvdPrq').AsFloat:=pValue;
end;

function TIvmiviDat.GetDifPrq:double;
begin
  Result:=oTable.FieldByName('DifPrq').AsFloat;
end;

procedure TIvmiviDat.SetDifPrq(pValue:double);
begin
  oTable.FieldByName('DifPrq').AsFloat:=pValue;
end;

function TIvmiviDat.GetNsiVal:double;
begin
  Result:=oTable.FieldByName('NsiVal').AsFloat;
end;

procedure TIvmiviDat.SetNsiVal(pValue:double);
begin
  oTable.FieldByName('NsiVal').AsFloat:=pValue;
end;

function TIvmiviDat.GetStkVal:double;
begin
  Result:=oTable.FieldByName('StkVal').AsFloat;
end;

procedure TIvmiviDat.SetStkVal(pValue:double);
begin
  oTable.FieldByName('StkVal').AsFloat:=pValue;
end;

function TIvmiviDat.GetIvdVal:double;
begin
  Result:=oTable.FieldByName('IvdVal').AsFloat;
end;

procedure TIvmiviDat.SetIvdVal(pValue:double);
begin
  oTable.FieldByName('IvdVal').AsFloat:=pValue;
end;

function TIvmiviDat.GetDifVal:double;
begin
  Result:=oTable.FieldByName('DifVal').AsFloat;
end;

procedure TIvmiviDat.SetDifVal(pValue:double);
begin
  oTable.FieldByName('DifVal').AsFloat:=pValue;
end;

function TIvmiviDat.GetStkApc:double;
begin
  Result:=oTable.FieldByName('StkApc').AsFloat;
end;

procedure TIvmiviDat.SetStkApc(pValue:double);
begin
  oTable.FieldByName('StkApc').AsFloat:=pValue;
end;

function TIvmiviDat.GetSalApc:double;
begin
  Result:=oTable.FieldByName('SalApc').AsFloat;
end;

procedure TIvmiviDat.SetSalApc(pValue:double);
begin
  oTable.FieldByName('SalApc').AsFloat:=pValue;
end;

function TIvmiviDat.GetSalBpc:double;
begin
  Result:=oTable.FieldByName('SalBpc').AsFloat;
end;

procedure TIvmiviDat.SetSalBpc(pValue:double);
begin
  oTable.FieldByName('SalBpc').AsFloat:=pValue;
end;

function TIvmiviDat.GetDifSta:Str1;
begin
  Result:=oTable.FieldByName('DifSta').AsString;
end;

procedure TIvmiviDat.SetDifSta(pValue:Str1);
begin
  oTable.FieldByName('DifSta').AsString:=pValue;
end;

function TIvmiviDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TIvmiviDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIvmiviDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIvmiviDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIvmiviDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TIvmiviDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIvmiviDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIvmiviDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIvmiviDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIvmiviDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIvmiviDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TIvmiviDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TIvmiviDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TIvmiviDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TIvmiviDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TIvmiviDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TIvmiviDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TIvmiviDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvmiviDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIvmiviDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIvmiviDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIvmiviDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIvmiviDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIvmiviDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIvmiviDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIvmiviDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIvmiviDat.LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindKey([pDocNum,pProNum]);
end;

function TIvmiviDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TIvmiviDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TIvmiviDat.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindKey([pPgrNum]);
end;

function TIvmiviDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TIvmiviDat.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pStkCod]);
end;

function TIvmiviDat.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindKey([pShpCod]);
end;

function TIvmiviDat.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pOrdCod]);
end;

function TIvmiviDat.LocDifSta(pDifSta:Str1):boolean;
begin
  SetIndex(ixDifSta);
  Result:=oTable.FindKey([pDifSta]);
end;

function TIvmiviDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TIvmiviDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIvmiviDat.NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindNearest([pDocNum,pProNum]);
end;

function TIvmiviDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TIvmiviDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TIvmiviDat.NearPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindNearest([pPgrNum]);
end;

function TIvmiviDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TIvmiviDat.NearStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pStkCod]);
end;

function TIvmiviDat.NearShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindNearest([pShpCod]);
end;

function TIvmiviDat.NearOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pOrdCod]);
end;

function TIvmiviDat.NearDifSta(pDifSta:Str1):boolean;
begin
  SetIndex(ixDifSta);
  Result:=oTable.FindNearest([pDifSta]);
end;

function TIvmiviDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

procedure TIvmiviDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIvmiviDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIvmiviDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIvmiviDat.Prior;
begin
  oTable.Prior;
end;

procedure TIvmiviDat.Next;
begin
  oTable.Next;
end;

procedure TIvmiviDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIvmiviDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIvmiviDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIvmiviDat.Edit;
begin
  oTable.Edit;
end;

procedure TIvmiviDat.Post;
begin
  oTable.Post;
end;

procedure TIvmiviDat.Delete;
begin
  oTable.Delete;
end;

procedure TIvmiviDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIvmiviDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIvmiviDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIvmiviDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIvmiviDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIvmiviDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
