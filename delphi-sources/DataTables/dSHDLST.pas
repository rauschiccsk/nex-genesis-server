unit dSHDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixCprPrc='CprPrc';
  ixCsaBva='CsaBva';
  ixCdcBva='CdcBva';

type
  TShdlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetFirDte:TDatetime;        procedure SetFirDte(pValue:TDatetime);
    function GetLasDte:TDatetime;        procedure SetLasDte(pValue:TDatetime);
    function GetPstAva:double;           procedure SetPstAva(pValue:double);
    function GetPprAva:double;           procedure SetPprAva(pValue:double);
    function GetPprPrc:double;           procedure SetPprPrc(pValue:double);
    function GetPsaAva:double;           procedure SetPsaAva(pValue:double);
    function GetPsaBva:double;           procedure SetPsaBva(pValue:double);
    function GetPreAva:double;           procedure SetPreAva(pValue:double);
    function GetPreBva:double;           procedure SetPreBva(pValue:double);
    function GetPdcAva:double;           procedure SetPdcAva(pValue:double);
    function GetPdcBva:double;           procedure SetPdcBva(pValue:double);
    function GetAstAva:double;           procedure SetAstAva(pValue:double);
    function GetAprAva:double;           procedure SetAprAva(pValue:double);
    function GetAprPrc:double;           procedure SetAprPrc(pValue:double);
    function GetAsaAva:double;           procedure SetAsaAva(pValue:double);
    function GetAsaBva:double;           procedure SetAsaBva(pValue:double);
    function GetAreAva:double;           procedure SetAreAva(pValue:double);
    function GetAreBva:double;           procedure SetAreBva(pValue:double);
    function GetAdcAva:double;           procedure SetAdcAva(pValue:double);
    function GetAdcBva:double;           procedure SetAdcBva(pValue:double);
    function GetCstAva:double;           procedure SetCstAva(pValue:double);
    function GetCprAva:double;           procedure SetCprAva(pValue:double);
    function GetCprPrc:double;           procedure SetCprPrc(pValue:double);
    function GetCsaAva:double;           procedure SetCsaAva(pValue:double);
    function GetCsaBva:double;           procedure SetCsaBva(pValue:double);
    function GetCreAva:double;           procedure SetCreAva(pValue:double);
    function GetCreBva:double;           procedure SetCreBva(pValue:double);
    function GetCdcAva:double;           procedure SetCdcAva(pValue:double);
    function GetCdcBva:double;           procedure SetCdcBva(pValue:double);
    function GetPncBov:double;           procedure SetPncBov(pValue:double);
    function GetActBov:double;           procedure SetActBov(pValue:double);
    function GetBasBov:double;           procedure SetBasBov(pValue:double);
    function GetBonBov:double;           procedure SetBonBov(pValue:double);
    function GetAncBov:double;           procedure SetAncBov(pValue:double);
    function GetInpBon:integer;          procedure SetInpBon(pValue:integer);
    function GetOutBon:integer;          procedure SetOutBon(pValue:integer);
    function GetActBon:integer;          procedure SetActBon(pValue:integer);
    function GetBonCnv:word;             procedure SetBonCnv(pValue:word);
    function GetBonClc:byte;             procedure SetBonClc(pValue:byte);
    function GetItmQnt:longint;          procedure SetItmQnt(pValue:longint);
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
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocCprPrc(pCprPrc:double):boolean;
    function LocCsaBva(pCsaBva:double):boolean;
    function LocCdcBva(pCdcBva:double):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearCprPrc(pCprPrc:double):boolean;
    function NearCsaBva(pCsaBva:double):boolean;
    function NearCdcBva(pCdcBva:double):boolean;

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
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property FirDte:TDatetime read GetFirDte write SetFirDte;
    property LasDte:TDatetime read GetLasDte write SetLasDte;
    property PstAva:double read GetPstAva write SetPstAva;
    property PprAva:double read GetPprAva write SetPprAva;
    property PprPrc:double read GetPprPrc write SetPprPrc;
    property PsaAva:double read GetPsaAva write SetPsaAva;
    property PsaBva:double read GetPsaBva write SetPsaBva;
    property PreAva:double read GetPreAva write SetPreAva;
    property PreBva:double read GetPreBva write SetPreBva;
    property PdcAva:double read GetPdcAva write SetPdcAva;
    property PdcBva:double read GetPdcBva write SetPdcBva;
    property AstAva:double read GetAstAva write SetAstAva;
    property AprAva:double read GetAprAva write SetAprAva;
    property AprPrc:double read GetAprPrc write SetAprPrc;
    property AsaAva:double read GetAsaAva write SetAsaAva;
    property AsaBva:double read GetAsaBva write SetAsaBva;
    property AreAva:double read GetAreAva write SetAreAva;
    property AreBva:double read GetAreBva write SetAreBva;
    property AdcAva:double read GetAdcAva write SetAdcAva;
    property AdcBva:double read GetAdcBva write SetAdcBva;
    property CstAva:double read GetCstAva write SetCstAva;
    property CprAva:double read GetCprAva write SetCprAva;
    property CprPrc:double read GetCprPrc write SetCprPrc;
    property CsaAva:double read GetCsaAva write SetCsaAva;
    property CsaBva:double read GetCsaBva write SetCsaBva;
    property CreAva:double read GetCreAva write SetCreAva;
    property CreBva:double read GetCreBva write SetCreBva;
    property CdcAva:double read GetCdcAva write SetCdcAva;
    property CdcBva:double read GetCdcBva write SetCdcBva;
    property PncBov:double read GetPncBov write SetPncBov;
    property ActBov:double read GetActBov write SetActBov;
    property BasBov:double read GetBasBov write SetBasBov;
    property BonBov:double read GetBonBov write SetBonBov;
    property AncBov:double read GetAncBov write SetAncBov;
    property InpBon:integer read GetInpBon write SetInpBon;
    property OutBon:integer read GetOutBon write SetOutBon;
    property ActBon:integer read GetActBon write SetActBon;
    property BonCnv:word read GetBonCnv write SetBonCnv;
    property BonClc:byte read GetBonClc write SetBonClc;
    property ItmQnt:longint read GetItmQnt write SetItmQnt;
  end;

implementation

constructor TShdlstDat.Create;
begin
  oTable:=DatInit('SHDLST',gPath.CabPath,Self);
end;

constructor TShdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SHDLST',pPath,Self);
end;

destructor TShdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TShdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TShdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TShdlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TShdlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TShdlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TShdlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TShdlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TShdlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TShdlstDat.GetFirDte:TDatetime;
begin
  Result:=oTable.FieldByName('FirDte').AsDateTime;
end;

procedure TShdlstDat.SetFirDte(pValue:TDatetime);
begin
  oTable.FieldByName('FirDte').AsDateTime:=pValue;
end;

function TShdlstDat.GetLasDte:TDatetime;
begin
  Result:=oTable.FieldByName('LasDte').AsDateTime;
end;

procedure TShdlstDat.SetLasDte(pValue:TDatetime);
begin
  oTable.FieldByName('LasDte').AsDateTime:=pValue;
end;

function TShdlstDat.GetPstAva:double;
begin
  Result:=oTable.FieldByName('PstAva').AsFloat;
end;

procedure TShdlstDat.SetPstAva(pValue:double);
begin
  oTable.FieldByName('PstAva').AsFloat:=pValue;
end;

function TShdlstDat.GetPprAva:double;
begin
  Result:=oTable.FieldByName('PprAva').AsFloat;
end;

procedure TShdlstDat.SetPprAva(pValue:double);
begin
  oTable.FieldByName('PprAva').AsFloat:=pValue;
end;

function TShdlstDat.GetPprPrc:double;
begin
  Result:=oTable.FieldByName('PprPrc').AsFloat;
end;

procedure TShdlstDat.SetPprPrc(pValue:double);
begin
  oTable.FieldByName('PprPrc').AsFloat:=pValue;
end;

function TShdlstDat.GetPsaAva:double;
begin
  Result:=oTable.FieldByName('PsaAva').AsFloat;
end;

procedure TShdlstDat.SetPsaAva(pValue:double);
begin
  oTable.FieldByName('PsaAva').AsFloat:=pValue;
end;

function TShdlstDat.GetPsaBva:double;
begin
  Result:=oTable.FieldByName('PsaBva').AsFloat;
end;

procedure TShdlstDat.SetPsaBva(pValue:double);
begin
  oTable.FieldByName('PsaBva').AsFloat:=pValue;
end;

function TShdlstDat.GetPreAva:double;
begin
  Result:=oTable.FieldByName('PreAva').AsFloat;
end;

procedure TShdlstDat.SetPreAva(pValue:double);
begin
  oTable.FieldByName('PreAva').AsFloat:=pValue;
end;

function TShdlstDat.GetPreBva:double;
begin
  Result:=oTable.FieldByName('PreBva').AsFloat;
end;

procedure TShdlstDat.SetPreBva(pValue:double);
begin
  oTable.FieldByName('PreBva').AsFloat:=pValue;
end;

function TShdlstDat.GetPdcAva:double;
begin
  Result:=oTable.FieldByName('PdcAva').AsFloat;
end;

procedure TShdlstDat.SetPdcAva(pValue:double);
begin
  oTable.FieldByName('PdcAva').AsFloat:=pValue;
end;

function TShdlstDat.GetPdcBva:double;
begin
  Result:=oTable.FieldByName('PdcBva').AsFloat;
end;

procedure TShdlstDat.SetPdcBva(pValue:double);
begin
  oTable.FieldByName('PdcBva').AsFloat:=pValue;
end;

function TShdlstDat.GetAstAva:double;
begin
  Result:=oTable.FieldByName('AstAva').AsFloat;
end;

procedure TShdlstDat.SetAstAva(pValue:double);
begin
  oTable.FieldByName('AstAva').AsFloat:=pValue;
end;

function TShdlstDat.GetAprAva:double;
begin
  Result:=oTable.FieldByName('AprAva').AsFloat;
end;

procedure TShdlstDat.SetAprAva(pValue:double);
begin
  oTable.FieldByName('AprAva').AsFloat:=pValue;
end;

function TShdlstDat.GetAprPrc:double;
begin
  Result:=oTable.FieldByName('AprPrc').AsFloat;
end;

procedure TShdlstDat.SetAprPrc(pValue:double);
begin
  oTable.FieldByName('AprPrc').AsFloat:=pValue;
end;

function TShdlstDat.GetAsaAva:double;
begin
  Result:=oTable.FieldByName('AsaAva').AsFloat;
end;

procedure TShdlstDat.SetAsaAva(pValue:double);
begin
  oTable.FieldByName('AsaAva').AsFloat:=pValue;
end;

function TShdlstDat.GetAsaBva:double;
begin
  Result:=oTable.FieldByName('AsaBva').AsFloat;
end;

procedure TShdlstDat.SetAsaBva(pValue:double);
begin
  oTable.FieldByName('AsaBva').AsFloat:=pValue;
end;

function TShdlstDat.GetAreAva:double;
begin
  Result:=oTable.FieldByName('AreAva').AsFloat;
end;

procedure TShdlstDat.SetAreAva(pValue:double);
begin
  oTable.FieldByName('AreAva').AsFloat:=pValue;
end;

function TShdlstDat.GetAreBva:double;
begin
  Result:=oTable.FieldByName('AreBva').AsFloat;
end;

procedure TShdlstDat.SetAreBva(pValue:double);
begin
  oTable.FieldByName('AreBva').AsFloat:=pValue;
end;

function TShdlstDat.GetAdcAva:double;
begin
  Result:=oTable.FieldByName('AdcAva').AsFloat;
end;

procedure TShdlstDat.SetAdcAva(pValue:double);
begin
  oTable.FieldByName('AdcAva').AsFloat:=pValue;
end;

function TShdlstDat.GetAdcBva:double;
begin
  Result:=oTable.FieldByName('AdcBva').AsFloat;
end;

procedure TShdlstDat.SetAdcBva(pValue:double);
begin
  oTable.FieldByName('AdcBva').AsFloat:=pValue;
end;

function TShdlstDat.GetCstAva:double;
begin
  Result:=oTable.FieldByName('CstAva').AsFloat;
end;

procedure TShdlstDat.SetCstAva(pValue:double);
begin
  oTable.FieldByName('CstAva').AsFloat:=pValue;
end;

function TShdlstDat.GetCprAva:double;
begin
  Result:=oTable.FieldByName('CprAva').AsFloat;
end;

procedure TShdlstDat.SetCprAva(pValue:double);
begin
  oTable.FieldByName('CprAva').AsFloat:=pValue;
end;

function TShdlstDat.GetCprPrc:double;
begin
  Result:=oTable.FieldByName('CprPrc').AsFloat;
end;

procedure TShdlstDat.SetCprPrc(pValue:double);
begin
  oTable.FieldByName('CprPrc').AsFloat:=pValue;
end;

function TShdlstDat.GetCsaAva:double;
begin
  Result:=oTable.FieldByName('CsaAva').AsFloat;
end;

procedure TShdlstDat.SetCsaAva(pValue:double);
begin
  oTable.FieldByName('CsaAva').AsFloat:=pValue;
end;

function TShdlstDat.GetCsaBva:double;
begin
  Result:=oTable.FieldByName('CsaBva').AsFloat;
end;

procedure TShdlstDat.SetCsaBva(pValue:double);
begin
  oTable.FieldByName('CsaBva').AsFloat:=pValue;
end;

function TShdlstDat.GetCreAva:double;
begin
  Result:=oTable.FieldByName('CreAva').AsFloat;
end;

procedure TShdlstDat.SetCreAva(pValue:double);
begin
  oTable.FieldByName('CreAva').AsFloat:=pValue;
end;

function TShdlstDat.GetCreBva:double;
begin
  Result:=oTable.FieldByName('CreBva').AsFloat;
end;

procedure TShdlstDat.SetCreBva(pValue:double);
begin
  oTable.FieldByName('CreBva').AsFloat:=pValue;
end;

function TShdlstDat.GetCdcAva:double;
begin
  Result:=oTable.FieldByName('CdcAva').AsFloat;
end;

procedure TShdlstDat.SetCdcAva(pValue:double);
begin
  oTable.FieldByName('CdcAva').AsFloat:=pValue;
end;

function TShdlstDat.GetCdcBva:double;
begin
  Result:=oTable.FieldByName('CdcBva').AsFloat;
end;

procedure TShdlstDat.SetCdcBva(pValue:double);
begin
  oTable.FieldByName('CdcBva').AsFloat:=pValue;
end;

function TShdlstDat.GetPncBov:double;
begin
  Result:=oTable.FieldByName('PncBov').AsFloat;
end;

procedure TShdlstDat.SetPncBov(pValue:double);
begin
  oTable.FieldByName('PncBov').AsFloat:=pValue;
end;

function TShdlstDat.GetActBov:double;
begin
  Result:=oTable.FieldByName('ActBov').AsFloat;
end;

procedure TShdlstDat.SetActBov(pValue:double);
begin
  oTable.FieldByName('ActBov').AsFloat:=pValue;
end;

function TShdlstDat.GetBasBov:double;
begin
  Result:=oTable.FieldByName('BasBov').AsFloat;
end;

procedure TShdlstDat.SetBasBov(pValue:double);
begin
  oTable.FieldByName('BasBov').AsFloat:=pValue;
end;

function TShdlstDat.GetBonBov:double;
begin
  Result:=oTable.FieldByName('BonBov').AsFloat;
end;

procedure TShdlstDat.SetBonBov(pValue:double);
begin
  oTable.FieldByName('BonBov').AsFloat:=pValue;
end;

function TShdlstDat.GetAncBov:double;
begin
  Result:=oTable.FieldByName('AncBov').AsFloat;
end;

procedure TShdlstDat.SetAncBov(pValue:double);
begin
  oTable.FieldByName('AncBov').AsFloat:=pValue;
end;

function TShdlstDat.GetInpBon:integer;
begin
  Result:=oTable.FieldByName('InpBon').AsVariant;
end;

procedure TShdlstDat.SetInpBon(pValue:integer);
begin
  oTable.FieldByName('InpBon').AsVariant:=pValue;
end;

function TShdlstDat.GetOutBon:integer;
begin
  Result:=oTable.FieldByName('OutBon').AsVariant;
end;

procedure TShdlstDat.SetOutBon(pValue:integer);
begin
  oTable.FieldByName('OutBon').AsVariant:=pValue;
end;

function TShdlstDat.GetActBon:integer;
begin
  Result:=oTable.FieldByName('ActBon').AsVariant;
end;

procedure TShdlstDat.SetActBon(pValue:integer);
begin
  oTable.FieldByName('ActBon').AsVariant:=pValue;
end;

function TShdlstDat.GetBonCnv:word;
begin
  Result:=oTable.FieldByName('BonCnv').AsInteger;
end;

procedure TShdlstDat.SetBonCnv(pValue:word);
begin
  oTable.FieldByName('BonCnv').AsInteger:=pValue;
end;

function TShdlstDat.GetBonClc:byte;
begin
  Result:=oTable.FieldByName('BonClc').AsInteger;
end;

procedure TShdlstDat.SetBonClc(pValue:byte);
begin
  oTable.FieldByName('BonClc').AsInteger:=pValue;
end;

function TShdlstDat.GetItmQnt:longint;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TShdlstDat.SetItmQnt(pValue:longint);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TShdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TShdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TShdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TShdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TShdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TShdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TShdlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TShdlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TShdlstDat.LocCprPrc(pCprPrc:double):boolean;
begin
  SetIndex(ixCprPrc);
  Result:=oTable.FindKey([pCprPrc]);
end;

function TShdlstDat.LocCsaBva(pCsaBva:double):boolean;
begin
  SetIndex(ixCsaBva);
  Result:=oTable.FindKey([pCsaBva]);
end;

function TShdlstDat.LocCdcBva(pCdcBva:double):boolean;
begin
  SetIndex(ixCdcBva);
  Result:=oTable.FindKey([pCdcBva]);
end;

function TShdlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TShdlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TShdlstDat.NearCprPrc(pCprPrc:double):boolean;
begin
  SetIndex(ixCprPrc);
  Result:=oTable.FindNearest([pCprPrc]);
end;

function TShdlstDat.NearCsaBva(pCsaBva:double):boolean;
begin
  SetIndex(ixCsaBva);
  Result:=oTable.FindNearest([pCsaBva]);
end;

function TShdlstDat.NearCdcBva(pCdcBva:double):boolean;
begin
  SetIndex(ixCdcBva);
  Result:=oTable.FindNearest([pCdcBva]);
end;

procedure TShdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TShdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TShdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TShdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TShdlstDat.Next;
begin
  oTable.Next;
end;

procedure TShdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TShdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TShdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TShdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TShdlstDat.Post;
begin
  oTable.Post;
end;

procedure TShdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TShdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TShdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TShdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TShdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TShdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TShdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
