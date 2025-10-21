unit tSRDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum='';
  ixProNum='ProNum';
  ixProNam_='ProNam_';
  ixBarCod='BarCod';
  ixStkCod='StkCod';
  ixShpCod='ShpCod';
  ixOrdCod='OrdCod';

type
  TSrditmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetOutWrn:word;             procedure SetOutWrn (pValue:word);
    function GetOutStn:word;             procedure SetOutStn (pValue:word);
    function GetOutSmc:word;             procedure SetOutSmc (pValue:word);
    function GetOutUsr:Str10;            procedure SetOutUsr (pValue:Str10);
    function GetOutUsn:Str30;            procedure SetOutUsn (pValue:Str30);
    function GetOutDte:TDatetime;        procedure SetOutDte (pValue:TDatetime);
    function GetOutTim:TDatetime;        procedure SetOutTim (pValue:TDatetime);
    function GetOutSta:Str1;             procedure SetOutSta (pValue:Str1);
    function GetIncWrn:word;             procedure SetIncWrn (pValue:word);
    function GetIncStn:word;             procedure SetIncStn (pValue:word);
    function GetIncSmc:word;             procedure SetIncSmc (pValue:word);
    function GetIncUsr:Str10;            procedure SetIncUsr (pValue:Str10);
    function GetIncUsn:Str30;            procedure SetIncUsn (pValue:Str30);
    function GetIncDte:TDatetime;        procedure SetIncDte (pValue:TDatetime);
    function GetIncTim:TDatetime;        procedure SetIncTim (pValue:TDatetime);
    function GetIncSta:Str1;             procedure SetIncSta (pValue:Str1);
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
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetMovPrq:double;           procedure SetMovPrq (pValue:double);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq (pValue:double);
    function GetFifNum:longint;          procedure SetFifNum (pValue:longint);
    function GetNotice:Str50;            procedure SetNotice (pValue:Str50);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocProNum (pProNum:longint):boolean;
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
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property StkAva:double read GetStkAva write SetStkAva;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property FifNum:longint read GetFifNum write SetFifNum;
    property Notice:Str50 read GetNotice write SetNotice;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TSrditmTmp.Create;
begin
  oTmpTable:=TmpInit ('SRDITM',Self);
end;

destructor TSrditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrditmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TSrditmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrditmTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSrditmTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetOutWrn:word;
begin
  Result:=oTmpTable.FieldByName('OutWrn').AsInteger;
end;

procedure TSrditmTmp.SetOutWrn(pValue:word);
begin
  oTmpTable.FieldByName('OutWrn').AsInteger:=pValue;
end;

function TSrditmTmp.GetOutStn:word;
begin
  Result:=oTmpTable.FieldByName('OutStn').AsInteger;
end;

procedure TSrditmTmp.SetOutStn(pValue:word);
begin
  oTmpTable.FieldByName('OutStn').AsInteger:=pValue;
end;

function TSrditmTmp.GetOutSmc:word;
begin
  Result:=oTmpTable.FieldByName('OutSmc').AsInteger;
end;

procedure TSrditmTmp.SetOutSmc(pValue:word);
begin
  oTmpTable.FieldByName('OutSmc').AsInteger:=pValue;
end;

function TSrditmTmp.GetOutUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('OutUsr').AsString;
end;

procedure TSrditmTmp.SetOutUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('OutUsr').AsString:=pValue;
end;

function TSrditmTmp.GetOutUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('OutUsn').AsString;
end;

procedure TSrditmTmp.SetOutUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('OutUsn').AsString:=pValue;
end;

function TSrditmTmp.GetOutDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OutDte').AsDateTime;
end;

procedure TSrditmTmp.SetOutDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TSrditmTmp.GetOutTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OutTim').AsDateTime;
end;

procedure TSrditmTmp.SetOutTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutTim').AsDateTime:=pValue;
end;

function TSrditmTmp.GetOutSta:Str1;
begin
  Result:=oTmpTable.FieldByName('OutSta').AsString;
end;

procedure TSrditmTmp.SetOutSta(pValue:Str1);
begin
  oTmpTable.FieldByName('OutSta').AsString:=pValue;
end;

function TSrditmTmp.GetIncWrn:word;
begin
  Result:=oTmpTable.FieldByName('IncWrn').AsInteger;
end;

procedure TSrditmTmp.SetIncWrn(pValue:word);
begin
  oTmpTable.FieldByName('IncWrn').AsInteger:=pValue;
end;

function TSrditmTmp.GetIncStn:word;
begin
  Result:=oTmpTable.FieldByName('IncStn').AsInteger;
end;

procedure TSrditmTmp.SetIncStn(pValue:word);
begin
  oTmpTable.FieldByName('IncStn').AsInteger:=pValue;
end;

function TSrditmTmp.GetIncSmc:word;
begin
  Result:=oTmpTable.FieldByName('IncSmc').AsInteger;
end;

procedure TSrditmTmp.SetIncSmc(pValue:word);
begin
  oTmpTable.FieldByName('IncSmc').AsInteger:=pValue;
end;

function TSrditmTmp.GetIncUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('IncUsr').AsString;
end;

procedure TSrditmTmp.SetIncUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('IncUsr').AsString:=pValue;
end;

function TSrditmTmp.GetIncUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('IncUsn').AsString;
end;

procedure TSrditmTmp.SetIncUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('IncUsn').AsString:=pValue;
end;

function TSrditmTmp.GetIncDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IncDte').AsDateTime;
end;

procedure TSrditmTmp.SetIncDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IncDte').AsDateTime:=pValue;
end;

function TSrditmTmp.GetIncTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('IncTim').AsDateTime;
end;

procedure TSrditmTmp.SetIncTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IncTim').AsDateTime:=pValue;
end;

function TSrditmTmp.GetIncSta:Str1;
begin
  Result:=oTmpTable.FieldByName('IncSta').AsString;
end;

procedure TSrditmTmp.SetIncSta(pValue:Str1);
begin
  oTmpTable.FieldByName('IncSta').AsString:=pValue;
end;

function TSrditmTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TSrditmTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TSrditmTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TSrditmTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TSrditmTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TSrditmTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TSrditmTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetFgrNum:word;
begin
  Result:=oTmpTable.FieldByName('FgrNum').AsInteger;
end;

procedure TSrditmTmp.SetFgrNum(pValue:word);
begin
  oTmpTable.FieldByName('FgrNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetSgrNum:word;
begin
  Result:=oTmpTable.FieldByName('SgrNum').AsInteger;
end;

procedure TSrditmTmp.SetSgrNum(pValue:word);
begin
  oTmpTable.FieldByName('SgrNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetBarCod:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TSrditmTmp.SetBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString:=pValue;
end;

function TSrditmTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TSrditmTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TSrditmTmp.GetShpCod:Str30;
begin
  Result:=oTmpTable.FieldByName('ShpCod').AsString;
end;

procedure TSrditmTmp.SetShpCod(pValue:Str30);
begin
  oTmpTable.FieldByName('ShpCod').AsString:=pValue;
end;

function TSrditmTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TSrditmTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TSrditmTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TSrditmTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TSrditmTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TSrditmTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TSrditmTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TSrditmTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TSrditmTmp.GetMovPrq:double;
begin
  Result:=oTmpTable.FieldByName('MovPrq').AsFloat;
end;

procedure TSrditmTmp.SetMovPrq(pValue:double);
begin
  oTmpTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TSrditmTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TSrditmTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TSrditmTmp.GetOutPrq:double;
begin
  Result:=oTmpTable.FieldByName('OutPrq').AsFloat;
end;

procedure TSrditmTmp.SetOutPrq(pValue:double);
begin
  oTmpTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TSrditmTmp.GetFifNum:longint;
begin
  Result:=oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TSrditmTmp.SetFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TSrditmTmp.GetNotice:Str50;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TSrditmTmp.SetNotice(pValue:Str50);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TSrditmTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TSrditmTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TSrditmTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TSrditmTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TSrditmTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSrditmTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrditmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TSrditmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TSrditmTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TSrditmTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TSrditmTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TSrditmTmp.LocBarCod(pBarCod:Str15):boolean;
begin
  SetIndex (ixBarCod);
  Result:=oTmpTable.FindKey([pBarCod]);
end;

function TSrditmTmp.LocStkCod(pStkCod:Str15):boolean;
begin
  SetIndex (ixStkCod);
  Result:=oTmpTable.FindKey([pStkCod]);
end;

function TSrditmTmp.LocShpCod(pShpCod:Str30):boolean;
begin
  SetIndex (ixShpCod);
  Result:=oTmpTable.FindKey([pShpCod]);
end;

function TSrditmTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TSrditmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TSrditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrditmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrditmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrditmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TSrditmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
