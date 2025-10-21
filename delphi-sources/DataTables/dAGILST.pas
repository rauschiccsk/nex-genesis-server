unit dAGILST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaAcPr='PaAcPr';
  ixPaAc='PaAc';
  ixPaPr='PaPr';
  ixParNum='ParNum';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixBarCod='BarCod';
  ixCusPco='CusPco';

type
  TAgilstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetAgcNum:Str30;            procedure SetAgcNum(pValue:Str30);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetAgcApc:double;           procedure SetAgcApc(pValue:double);
    function GetAgcBpc:double;           procedure SetAgcBpc(pValue:double);
    function GetCusPna:Str60;            procedure SetCusPna(pValue:Str60);
    function GetCusPco:Str30;            procedure SetCusPco(pValue:Str30);
    function GetDscTyp:Str1;             procedure SetDscTyp(pValue:Str1);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUse:Str8;             procedure SetModUse(pValue:Str8);
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
    function LocPaAcPr(pParNum:longint;pAgcNum:Str30;pProNum:longint):boolean;
    function LocPaAc(pParNum:longint;pAgcNum:Str30):boolean;
    function LocPaPr(pParNum:longint;pProNum:longint):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocCusPco(pCusPco:Str30):boolean;
    function NearPaAcPr(pParNum:longint;pAgcNum:Str30;pProNum:longint):boolean;
    function NearPaAc(pParNum:longint;pAgcNum:Str30):boolean;
    function NearPaPr(pParNum:longint;pProNum:longint):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearCusPco(pCusPco:Str30):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property AgcNum:Str30 read GetAgcNum write SetAgcNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property AgcApc:double read GetAgcApc write SetAgcApc;
    property AgcBpc:double read GetAgcBpc write SetAgcBpc;
    property CusPna:Str60 read GetCusPna write SetCusPna;
    property CusPco:Str30 read GetCusPco write SetCusPco;
    property DscTyp:Str1 read GetDscTyp write SetDscTyp;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUse:Str8 read GetModUse write SetModUse;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TAgilstDat.Create;
begin
  oTable:=DatInit('AGILST',gPath.StkPath,Self);
end;

constructor TAgilstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('AGILST',pPath,Self);
end;

destructor TAgilstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAgilstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAgilstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAgilstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TAgilstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TAgilstDat.GetAgcNum:Str30;
begin
  Result:=oTable.FieldByName('AgcNum').AsString;
end;

procedure TAgilstDat.SetAgcNum(pValue:Str30);
begin
  oTable.FieldByName('AgcNum').AsString:=pValue;
end;

function TAgilstDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TAgilstDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TAgilstDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TAgilstDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TAgilstDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TAgilstDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TAgilstDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TAgilstDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TAgilstDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TAgilstDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TAgilstDat.GetAgcApc:double;
begin
  Result:=oTable.FieldByName('AgcApc').AsFloat;
end;

procedure TAgilstDat.SetAgcApc(pValue:double);
begin
  oTable.FieldByName('AgcApc').AsFloat:=pValue;
end;

function TAgilstDat.GetAgcBpc:double;
begin
  Result:=oTable.FieldByName('AgcBpc').AsFloat;
end;

procedure TAgilstDat.SetAgcBpc(pValue:double);
begin
  oTable.FieldByName('AgcBpc').AsFloat:=pValue;
end;

function TAgilstDat.GetCusPna:Str60;
begin
  Result:=oTable.FieldByName('CusPna').AsString;
end;

procedure TAgilstDat.SetCusPna(pValue:Str60);
begin
  oTable.FieldByName('CusPna').AsString:=pValue;
end;

function TAgilstDat.GetCusPco:Str30;
begin
  Result:=oTable.FieldByName('CusPco').AsString;
end;

procedure TAgilstDat.SetCusPco(pValue:Str30);
begin
  oTable.FieldByName('CusPco').AsString:=pValue;
end;

function TAgilstDat.GetDscTyp:Str1;
begin
  Result:=oTable.FieldByName('DscTyp').AsString;
end;

procedure TAgilstDat.SetDscTyp(pValue:Str1);
begin
  oTable.FieldByName('DscTyp').AsString:=pValue;
end;

function TAgilstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TAgilstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TAgilstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TAgilstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TAgilstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAgilstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAgilstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAgilstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAgilstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAgilstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAgilstDat.GetModUse:Str8;
begin
  Result:=oTable.FieldByName('ModUse').AsString;
end;

procedure TAgilstDat.SetModUse(pValue:Str8);
begin
  oTable.FieldByName('ModUse').AsString:=pValue;
end;

function TAgilstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TAgilstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TAgilstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TAgilstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgilstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAgilstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAgilstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAgilstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAgilstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAgilstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAgilstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAgilstDat.LocPaAcPr(pParNum:longint;pAgcNum:Str30;pProNum:longint):boolean;
begin
  SetIndex(ixPaAcPr);
  Result:=oTable.FindKey([pParNum,pAgcNum,pProNum]);
end;

function TAgilstDat.LocPaAc(pParNum:longint;pAgcNum:Str30):boolean;
begin
  SetIndex(ixPaAc);
  Result:=oTable.FindKey([pParNum,pAgcNum]);
end;

function TAgilstDat.LocPaPr(pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex(ixPaPr);
  Result:=oTable.FindKey([pParNum,pProNum]);
end;

function TAgilstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TAgilstDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TAgilstDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TAgilstDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TAgilstDat.LocCusPco(pCusPco:Str30):boolean;
begin
  SetIndex(ixCusPco);
  Result:=oTable.FindKey([pCusPco]);
end;

function TAgilstDat.NearPaAcPr(pParNum:longint;pAgcNum:Str30;pProNum:longint):boolean;
begin
  SetIndex(ixPaAcPr);
  Result:=oTable.FindNearest([pParNum,pAgcNum,pProNum]);
end;

function TAgilstDat.NearPaAc(pParNum:longint;pAgcNum:Str30):boolean;
begin
  SetIndex(ixPaAc);
  Result:=oTable.FindNearest([pParNum,pAgcNum]);
end;

function TAgilstDat.NearPaPr(pParNum:longint;pProNum:longint):boolean;
begin
  SetIndex(ixPaPr);
  Result:=oTable.FindNearest([pParNum,pProNum]);
end;

function TAgilstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TAgilstDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TAgilstDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TAgilstDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TAgilstDat.NearCusPco(pCusPco:Str30):boolean;
begin
  SetIndex(ixCusPco);
  Result:=oTable.FindNearest([pCusPco]);
end;

procedure TAgilstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAgilstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAgilstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAgilstDat.Prior;
begin
  oTable.Prior;
end;

procedure TAgilstDat.Next;
begin
  oTable.Next;
end;

procedure TAgilstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAgilstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAgilstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAgilstDat.Edit;
begin
  oTable.Edit;
end;

procedure TAgilstDat.Post;
begin
  oTable.Post;
end;

procedure TAgilstDat.Delete;
begin
  oTable.Delete;
end;

procedure TAgilstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAgilstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAgilstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAgilstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAgilstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAgilstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
