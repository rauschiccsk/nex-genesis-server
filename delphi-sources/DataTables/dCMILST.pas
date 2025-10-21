unit dCMILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='DnIn';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixSmcNum='SmcNum';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixPrgNum='PrgNum';
  ixStkSta='StkSta';

type
  TCmilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetSmcNum:word;             procedure SetSmcNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetPgrNum:longint;          procedure SetPgrNum(pValue:longint);
    function GetVatPrc:byte;             procedure SetVatPrc(pValue:byte);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetStkCpc:double;           procedure SetStkCpc(pValue:double);
    function GetStkCva:double;           procedure SetStkCva(pValue:double);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetStkSta:Str1;             procedure SetStkSta(pValue:Str1);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetCrtUsr:Str15;            procedure SetCrtUsr(pValue:Str15);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUse:Str15;            procedure SetModUse(pValue:Str15);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetItmTyp:Str1;             procedure SetItmTyp(pValue:Str1);
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
    function LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocSmcNum(pSmcNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocPrgNum(pPrgNum:):boolean;
    function LocStkSta(pStkSta:Str1):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearSmcNum(pSmcNum:word):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearPrgNum(pPrgNum:):boolean;
    function NearStkSta(pStkSta:Str1):boolean;

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
    property ItmNum:word read GetItmNum write SetItmNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property SmcNum:word read GetSmcNum write SetSmcNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property PgrNum:longint read GetPgrNum write SetPgrNum;
    property VatPrc:byte read GetVatPrc write SetVatPrc;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property StkCpc:double read GetStkCpc write SetStkCpc;
    property StkCva:double read GetStkCva write SetStkCva;
    property Notice:Str50 read GetNotice write SetNotice;
    property StkSta:Str1 read GetStkSta write SetStkSta;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property CrtUsr:Str15 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUse:Str15 read GetModUse write SetModUse;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property ItmTyp:Str1 read GetItmTyp write SetItmTyp;
  end;

implementation

constructor TCmilstDat.Create;
begin
  oTable:=DatInit('CMILST',gPath.StkPath,Self);
end;

constructor TCmilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CMILST',pPath,Self);
end;

destructor TCmilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCmilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCmilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCmilstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TCmilstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TCmilstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCmilstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TCmilstDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TCmilstDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TCmilstDat.GetSmcNum:word;
begin
  Result:=oTable.FieldByName('SmcNum').AsInteger;
end;

procedure TCmilstDat.SetSmcNum(pValue:word);
begin
  oTable.FieldByName('SmcNum').AsInteger:=pValue;
end;

function TCmilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TCmilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TCmilstDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TCmilstDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TCmilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TCmilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TCmilstDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TCmilstDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TCmilstDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TCmilstDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TCmilstDat.GetPgrNum:longint;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TCmilstDat.SetPgrNum(pValue:longint);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TCmilstDat.GetVatPrc:byte;
begin
  Result:=oTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCmilstDat.SetVatPrc(pValue:byte);
begin
  oTable.FieldByName('VatPrc').AsInteger:=pValue;
end;

function TCmilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TCmilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TCmilstDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TCmilstDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TCmilstDat.GetStkCpc:double;
begin
  Result:=oTable.FieldByName('StkCpc').AsFloat;
end;

procedure TCmilstDat.SetStkCpc(pValue:double);
begin
  oTable.FieldByName('StkCpc').AsFloat:=pValue;
end;

function TCmilstDat.GetStkCva:double;
begin
  Result:=oTable.FieldByName('StkCva').AsFloat;
end;

procedure TCmilstDat.SetStkCva(pValue:double);
begin
  oTable.FieldByName('StkCva').AsFloat:=pValue;
end;

function TCmilstDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TCmilstDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TCmilstDat.GetStkSta:Str1;
begin
  Result:=oTable.FieldByName('StkSta').AsString;
end;

procedure TCmilstDat.SetStkSta(pValue:Str1);
begin
  oTable.FieldByName('StkSta').AsString:=pValue;
end;

function TCmilstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TCmilstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TCmilstDat.GetCrtUsr:Str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCmilstDat.SetCrtUsr(pValue:Str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCmilstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCmilstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCmilstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCmilstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TCmilstDat.GetModUse:Str15;
begin
  Result:=oTable.FieldByName('ModUse').AsString;
end;

procedure TCmilstDat.SetModUse(pValue:Str15);
begin
  oTable.FieldByName('ModUse').AsString:=pValue;
end;

function TCmilstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TCmilstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TCmilstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TCmilstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TCmilstDat.GetItmTyp:Str1;
begin
  Result:=oTable.FieldByName('ItmTyp').AsString;
end;

procedure TCmilstDat.SetItmTyp(pValue:Str1);
begin
  oTable.FieldByName('ItmTyp').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCmilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCmilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCmilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCmilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCmilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCmilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCmilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCmilstDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TCmilstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TCmilstDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TCmilstDat.LocSmcNum(pSmcNum:word):boolean;
begin
  SetIndex(ixSmcNum);
  Result:=oTable.FindKey([pSmcNum]);
end;

function TCmilstDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TCmilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TCmilstDat.LocPrgNum(pPrgNum:):boolean;
begin
  SetIndex(ixPrgNum);
  Result:=oTable.FindKey([pPrgNum]);
end;

function TCmilstDat.LocStkSta(pStkSta:Str1):boolean;
begin
  SetIndex(ixStkSta);
  Result:=oTable.FindKey([pStkSta]);
end;

function TCmilstDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TCmilstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TCmilstDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TCmilstDat.NearSmcNum(pSmcNum:word):boolean;
begin
  SetIndex(ixSmcNum);
  Result:=oTable.FindNearest([pSmcNum]);
end;

function TCmilstDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TCmilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TCmilstDat.NearPrgNum(pPrgNum:):boolean;
begin
  SetIndex(ixPrgNum);
  Result:=oTable.FindNearest([pPrgNum]);
end;

function TCmilstDat.NearStkSta(pStkSta:Str1):boolean;
begin
  SetIndex(ixStkSta);
  Result:=oTable.FindNearest([pStkSta]);
end;

procedure TCmilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCmilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCmilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCmilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TCmilstDat.Next;
begin
  oTable.Next;
end;

procedure TCmilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCmilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCmilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCmilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TCmilstDat.Post;
begin
  oTable.Post;
end;

procedure TCmilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TCmilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCmilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCmilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCmilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCmilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCmilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
