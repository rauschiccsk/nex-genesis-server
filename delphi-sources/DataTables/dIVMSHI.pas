unit dIVMSHI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnIs='DnIs';
  ixDnPn='DnPn';
  ixDifSta='DifSta';

type
  TIvmshiDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetIvsNum:word;             procedure SetIvsNum(pValue:word);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetStkPrq:double;           procedure SetStkPrq(pValue:double);
    function GetIvqFa1:double;           procedure SetIvqFa1(pValue:double);
    function GetIvqFa2:double;           procedure SetIvqFa2(pValue:double);
    function GetIvdPrq:double;           procedure SetIvdPrq(pValue:double);
    function GetDifPrq:double;           procedure SetDifPrq(pValue:double);
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
    function LocDnIs(pDocNum:Str12;pIvsNum:word):boolean;
    function LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function LocDifSta(pDifSta:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnIs(pDocNum:Str12;pIvsNum:word):boolean;
    function NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
    function NearDifSta(pDifSta:Str1):boolean;

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
    property IvsNum:word read GetIvsNum write SetIvsNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
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

constructor TIvmshiDat.Create;
begin
  oTable:=DatInit('IVMSHI',gPath.StkPath,Self);
end;

constructor TIvmshiDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('IVMSHI',pPath,Self);
end;

destructor TIvmshiDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TIvmshiDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TIvmshiDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TIvmshiDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TIvmshiDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIvmshiDat.GetIvsNum:word;
begin
  Result:=oTable.FieldByName('IvsNum').AsInteger;
end;

procedure TIvmshiDat.SetIvsNum(pValue:word);
begin
  oTable.FieldByName('IvsNum').AsInteger:=pValue;
end;

function TIvmshiDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIvmshiDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIvmshiDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TIvmshiDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TIvmshiDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TIvmshiDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TIvmshiDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TIvmshiDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TIvmshiDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TIvmshiDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TIvmshiDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TIvmshiDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TIvmshiDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TIvmshiDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TIvmshiDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TIvmshiDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TIvmshiDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TIvmshiDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TIvmshiDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TIvmshiDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TIvmshiDat.GetStkPrq:double;
begin
  Result:=oTable.FieldByName('StkPrq').AsFloat;
end;

procedure TIvmshiDat.SetStkPrq(pValue:double);
begin
  oTable.FieldByName('StkPrq').AsFloat:=pValue;
end;

function TIvmshiDat.GetIvqFa1:double;
begin
  Result:=oTable.FieldByName('IvqFa1').AsFloat;
end;

procedure TIvmshiDat.SetIvqFa1(pValue:double);
begin
  oTable.FieldByName('IvqFa1').AsFloat:=pValue;
end;

function TIvmshiDat.GetIvqFa2:double;
begin
  Result:=oTable.FieldByName('IvqFa2').AsFloat;
end;

procedure TIvmshiDat.SetIvqFa2(pValue:double);
begin
  oTable.FieldByName('IvqFa2').AsFloat:=pValue;
end;

function TIvmshiDat.GetIvdPrq:double;
begin
  Result:=oTable.FieldByName('IvdPrq').AsFloat;
end;

procedure TIvmshiDat.SetIvdPrq(pValue:double);
begin
  oTable.FieldByName('IvdPrq').AsFloat:=pValue;
end;

function TIvmshiDat.GetDifPrq:double;
begin
  Result:=oTable.FieldByName('DifPrq').AsFloat;
end;

procedure TIvmshiDat.SetDifPrq(pValue:double);
begin
  oTable.FieldByName('DifPrq').AsFloat:=pValue;
end;

function TIvmshiDat.GetDifSta:Str1;
begin
  Result:=oTable.FieldByName('DifSta').AsString;
end;

procedure TIvmshiDat.SetDifSta(pValue:Str1);
begin
  oTable.FieldByName('DifSta').AsString:=pValue;
end;

function TIvmshiDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TIvmshiDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIvmshiDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TIvmshiDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TIvmshiDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TIvmshiDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TIvmshiDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TIvmshiDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TIvmshiDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TIvmshiDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TIvmshiDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TIvmshiDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TIvmshiDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TIvmshiDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TIvmshiDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TIvmshiDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TIvmshiDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TIvmshiDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvmshiDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TIvmshiDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TIvmshiDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TIvmshiDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TIvmshiDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TIvmshiDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TIvmshiDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TIvmshiDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TIvmshiDat.LocDnIs(pDocNum:Str12;pIvsNum:word):boolean;
begin
  SetIndex(ixDnIs);
  Result:=oTable.FindKey([pDocNum,pIvsNum]);
end;

function TIvmshiDat.LocDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindKey([pDocNum,pProNum]);
end;

function TIvmshiDat.LocDifSta(pDifSta:Str1):boolean;
begin
  SetIndex(ixDifSta);
  Result:=oTable.FindKey([pDifSta]);
end;

function TIvmshiDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TIvmshiDat.NearDnIs(pDocNum:Str12;pIvsNum:word):boolean;
begin
  SetIndex(ixDnIs);
  Result:=oTable.FindNearest([pDocNum,pIvsNum]);
end;

function TIvmshiDat.NearDnPn(pDocNum:Str12;pProNum:longint):boolean;
begin
  SetIndex(ixDnPn);
  Result:=oTable.FindNearest([pDocNum,pProNum]);
end;

function TIvmshiDat.NearDifSta(pDifSta:Str1):boolean;
begin
  SetIndex(ixDifSta);
  Result:=oTable.FindNearest([pDifSta]);
end;

procedure TIvmshiDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TIvmshiDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TIvmshiDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TIvmshiDat.Prior;
begin
  oTable.Prior;
end;

procedure TIvmshiDat.Next;
begin
  oTable.Next;
end;

procedure TIvmshiDat.First;
begin
  Open;
  oTable.First;
end;

procedure TIvmshiDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TIvmshiDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TIvmshiDat.Edit;
begin
  oTable.Edit;
end;

procedure TIvmshiDat.Post;
begin
  oTable.Post;
end;

procedure TIvmshiDat.Delete;
begin
  oTable.Delete;
end;

procedure TIvmshiDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TIvmshiDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TIvmshiDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TIvmshiDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TIvmshiDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TIvmshiDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
