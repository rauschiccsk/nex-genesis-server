unit dSRDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='DnIn';
  ixDocNum='DocNum';
  ixProNum='ProNum';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TSrditmDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetOutWrn:word;             procedure SetOutWrn(pValue:word);
    function GetOutStn:word;             procedure SetOutStn(pValue:word);
    function GetOutSmc:word;             procedure SetOutSmc(pValue:word);
    function GetOutUsr:Str10;            procedure SetOutUsr(pValue:Str10);
    function GetOutUsn:Str30;            procedure SetOutUsn(pValue:Str30);
    function GetOutDte:TDatetime;        procedure SetOutDte(pValue:TDatetime);
    function GetOutTim:TDatetime;        procedure SetOutTim(pValue:TDatetime);
    function GetOutSta:Str1;             procedure SetOutSta(pValue:Str1);
    function GetIncWrn:word;             procedure SetIncWrn(pValue:word);
    function GetIncStn:word;             procedure SetIncStn(pValue:word);
    function GetIncSmc:word;             procedure SetIncSmc(pValue:word);
    function GetIncUsr:Str10;            procedure SetIncUsr(pValue:Str10);
    function GetIncUsn:Str30;            procedure SetIncUsn(pValue:Str30);
    function GetIncDte:TDatetime;        procedure SetIncDte(pValue:TDatetime);
    function GetIncTim:TDatetime;        procedure SetIncTim(pValue:TDatetime);
    function GetIncSta:Str1;             procedure SetIncSta(pValue:Str1);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetFgrNum:word;             procedure SetFgrNum(pValue:word);
    function GetSgrNum:word;             procedure SetSgrNum(pValue:word);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetStkCod:Str15;            procedure SetStkCod(pValue:Str15);
    function GetShpCod:Str30;            procedure SetShpCod(pValue:Str30);
    function GetOrdCod:Str30;            procedure SetOrdCod(pValue:Str30);
    function GetProVol:double;           procedure SetProVol(pValue:double);
    function GetProWgh:double;           procedure SetProWgh(pValue:double);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetMovPrq:double;           procedure SetMovPrq(pValue:double);
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetFifNum:longint;          procedure SetFifNum(pValue:longint);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
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
    function LocProNum(pProNum:longint):boolean;
    function LocBarCod(pBarCod:Str15):boolean;
    function LocStkCod(pStkCod:Str15):boolean;
    function LocShpCod(pShpCod:Str30):boolean;
    function LocOrdCod(pOrdCod:Str30):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearBarCod(pBarCod:Str15):boolean;
    function NearStkCod(pStkCod:Str15):boolean;
    function NearShpCod(pShpCod:Str30):boolean;
    function NearOrdCod(pOrdCod:Str30):boolean;

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
    property OutWrn:word read GetOutWrn write SetOutWrn;
    property OutStn:word read GetOutStn write SetOutStn;
    property OutSmc:word read GetOutSmc write SetOutSmc;
    property OutUsr:Str10 read GetOutUsr write SetOutUsr;
    property OutUsn:Str30 read GetOutUsn write SetOutUsn;
    property OutDte:TDatetime read GetOutDte write SetOutDte;
    property OutTim:TDatetime read GetOutTim write SetOutTim;
    property OutSta:Str1 read GetOutSta write SetOutSta;
    property IncWrn:word read GetIncWrn write SetIncWrn;
    property IncStn:word read GetIncStn write SetIncStn;
    property IncSmc:word read GetIncSmc write SetIncSmc;
    property IncUsr:Str10 read GetIncUsr write SetIncUsr;
    property IncUsn:Str30 read GetIncUsn write SetIncUsn;
    property IncDte:TDatetime read GetIncDte write SetIncDte;
    property IncTim:TDatetime read GetIncTim write SetIncTim;
    property IncSta:Str1 read GetIncSta write SetIncSta;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property FgrNum:word read GetFgrNum write SetFgrNum;
    property SgrNum:word read GetSgrNum write SetSgrNum;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property ShpCod:Str30 read GetShpCod write SetShpCod;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property StkAva:double read GetStkAva write SetStkAva;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property FifNum:longint read GetFifNum write SetFifNum;
    property Notice:Str50 read GetNotice write SetNotice;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property BokNum:Str3 read GetBokNum write SetBokNum;
  end;

implementation

constructor TSrditmDat.Create;
begin
  oTable:=DatInit('SRDITM',gPath.StkPath,Self);
end;

constructor TSrditmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SRDITM',pPath,Self);
end;

destructor TSrditmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TSrditmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TSrditmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TSrditmDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TSrditmDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TSrditmDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSrditmDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TSrditmDat.GetOutWrn:word;
begin
  Result:=oTable.FieldByName('OutWrn').AsInteger;
end;

procedure TSrditmDat.SetOutWrn(pValue:word);
begin
  oTable.FieldByName('OutWrn').AsInteger:=pValue;
end;

function TSrditmDat.GetOutStn:word;
begin
  Result:=oTable.FieldByName('OutStn').AsInteger;
end;

procedure TSrditmDat.SetOutStn(pValue:word);
begin
  oTable.FieldByName('OutStn').AsInteger:=pValue;
end;

function TSrditmDat.GetOutSmc:word;
begin
  Result:=oTable.FieldByName('OutSmc').AsInteger;
end;

procedure TSrditmDat.SetOutSmc(pValue:word);
begin
  oTable.FieldByName('OutSmc').AsInteger:=pValue;
end;

function TSrditmDat.GetOutUsr:Str10;
begin
  Result:=oTable.FieldByName('OutUsr').AsString;
end;

procedure TSrditmDat.SetOutUsr(pValue:Str10);
begin
  oTable.FieldByName('OutUsr').AsString:=pValue;
end;

function TSrditmDat.GetOutUsn:Str30;
begin
  Result:=oTable.FieldByName('OutUsn').AsString;
end;

procedure TSrditmDat.SetOutUsn(pValue:Str30);
begin
  oTable.FieldByName('OutUsn').AsString:=pValue;
end;

function TSrditmDat.GetOutDte:TDatetime;
begin
  Result:=oTable.FieldByName('OutDte').AsDateTime;
end;

procedure TSrditmDat.SetOutDte(pValue:TDatetime);
begin
  oTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TSrditmDat.GetOutTim:TDatetime;
begin
  Result:=oTable.FieldByName('OutTim').AsDateTime;
end;

procedure TSrditmDat.SetOutTim(pValue:TDatetime);
begin
  oTable.FieldByName('OutTim').AsDateTime:=pValue;
end;

function TSrditmDat.GetOutSta:Str1;
begin
  Result:=oTable.FieldByName('OutSta').AsString;
end;

procedure TSrditmDat.SetOutSta(pValue:Str1);
begin
  oTable.FieldByName('OutSta').AsString:=pValue;
end;

function TSrditmDat.GetIncWrn:word;
begin
  Result:=oTable.FieldByName('IncWrn').AsInteger;
end;

procedure TSrditmDat.SetIncWrn(pValue:word);
begin
  oTable.FieldByName('IncWrn').AsInteger:=pValue;
end;

function TSrditmDat.GetIncStn:word;
begin
  Result:=oTable.FieldByName('IncStn').AsInteger;
end;

procedure TSrditmDat.SetIncStn(pValue:word);
begin
  oTable.FieldByName('IncStn').AsInteger:=pValue;
end;

function TSrditmDat.GetIncSmc:word;
begin
  Result:=oTable.FieldByName('IncSmc').AsInteger;
end;

procedure TSrditmDat.SetIncSmc(pValue:word);
begin
  oTable.FieldByName('IncSmc').AsInteger:=pValue;
end;

function TSrditmDat.GetIncUsr:Str10;
begin
  Result:=oTable.FieldByName('IncUsr').AsString;
end;

procedure TSrditmDat.SetIncUsr(pValue:Str10);
begin
  oTable.FieldByName('IncUsr').AsString:=pValue;
end;

function TSrditmDat.GetIncUsn:Str30;
begin
  Result:=oTable.FieldByName('IncUsn').AsString;
end;

procedure TSrditmDat.SetIncUsn(pValue:Str30);
begin
  oTable.FieldByName('IncUsn').AsString:=pValue;
end;

function TSrditmDat.GetIncDte:TDatetime;
begin
  Result:=oTable.FieldByName('IncDte').AsDateTime;
end;

procedure TSrditmDat.SetIncDte(pValue:TDatetime);
begin
  oTable.FieldByName('IncDte').AsDateTime:=pValue;
end;

function TSrditmDat.GetIncTim:TDatetime;
begin
  Result:=oTable.FieldByName('IncTim').AsDateTime;
end;

procedure TSrditmDat.SetIncTim(pValue:TDatetime);
begin
  oTable.FieldByName('IncTim').AsDateTime:=pValue;
end;

function TSrditmDat.GetIncSta:Str1;
begin
  Result:=oTable.FieldByName('IncSta').AsString;
end;

procedure TSrditmDat.SetIncSta(pValue:Str1);
begin
  oTable.FieldByName('IncSta').AsString:=pValue;
end;

function TSrditmDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TSrditmDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TSrditmDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TSrditmDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TSrditmDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TSrditmDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TSrditmDat.GetFgrNum:word;
begin
  Result:=oTable.FieldByName('FgrNum').AsInteger;
end;

procedure TSrditmDat.SetFgrNum(pValue:word);
begin
  oTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TSrditmDat.GetSgrNum:word;
begin
  Result:=oTable.FieldByName('SgrNum').AsInteger;
end;

procedure TSrditmDat.SetSgrNum(pValue:word);
begin
  oTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TSrditmDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TSrditmDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TSrditmDat.GetStkCod:Str15;
begin
  Result:=oTable.FieldByName('StkCod').AsString;
end;

procedure TSrditmDat.SetStkCod(pValue:Str15);
begin
  oTable.FieldByName('StkCod').AsString:=pValue;
end;

function TSrditmDat.GetShpCod:Str30;
begin
  Result:=oTable.FieldByName('ShpCod').AsString;
end;

procedure TSrditmDat.SetShpCod(pValue:Str30);
begin
  oTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TSrditmDat.GetOrdCod:Str30;
begin
  Result:=oTable.FieldByName('OrdCod').AsString;
end;

procedure TSrditmDat.SetOrdCod(pValue:Str30);
begin
  oTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TSrditmDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TSrditmDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TSrditmDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TSrditmDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TSrditmDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TSrditmDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TSrditmDat.GetMovPrq:double;
begin
  Result:=oTable.FieldByName('MovPrq').AsFloat;
end;

procedure TSrditmDat.SetMovPrq(pValue:double);
begin
  oTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TSrditmDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TSrditmDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TSrditmDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TSrditmDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TSrditmDat.GetFifNum:longint;
begin
  Result:=oTable.FieldByName('FifNum').AsInteger;
end;

procedure TSrditmDat.SetFifNum(pValue:longint);
begin
  oTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TSrditmDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TSrditmDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TSrditmDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TSrditmDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TSrditmDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TSrditmDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrditmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TSrditmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TSrditmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TSrditmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TSrditmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TSrditmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TSrditmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TSrditmDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TSrditmDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TSrditmDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TSrditmDat.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindKey([pBarCod]);
end;

function TSrditmDat.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindKey([pStkCod]);
end;

function TSrditmDat.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindKey([pShpCod]);
end;

function TSrditmDat.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindKey([pOrdCod]);
end;

function TSrditmDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TSrditmDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TSrditmDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TSrditmDat.NearBarCod(pBarCod:Str15):boolean;
begin
  SetIndex(ixBarCod);
  Result:=oTable.FindNearest([pBarCod]);
end;

function TSrditmDat.NearStkCod(pStkCod:Str15):boolean;
begin
  SetIndex(ixStkCod);
  Result:=oTable.FindNearest([pStkCod]);
end;

function TSrditmDat.NearShpCod(pShpCod:Str30):boolean;
begin
  SetIndex(ixShpCod);
  Result:=oTable.FindNearest([pShpCod]);
end;

function TSrditmDat.NearOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex(ixOrdCod);
  Result:=oTable.FindNearest([pOrdCod]);
end;

procedure TSrditmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TSrditmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TSrditmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TSrditmDat.Prior;
begin
  oTable.Prior;
end;

procedure TSrditmDat.Next;
begin
  oTable.Next;
end;

procedure TSrditmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TSrditmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TSrditmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TSrditmDat.Edit;
begin
  oTable.Edit;
end;

procedure TSrditmDat.Post;
begin
  oTable.Post;
end;

procedure TSrditmDat.Delete;
begin
  oTable.Delete;
end;

procedure TSrditmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TSrditmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TSrditmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TSrditmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TSrditmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TSrditmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
