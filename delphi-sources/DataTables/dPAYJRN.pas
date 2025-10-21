unit dPAYJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItCn='DoItCn';
  ixDoIt='DoIt';
  ixDocNum='DocNum';
  ixInvDoc='InvDoc';
  ixVarSym='VarSym';
  ixSpcSym='SpcSym';
  ixPayDte='PayDte';
  ixParNam='ParNam';
  ixDocYer='DocYer';

type
  TPayjrnDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetCitNum:word;             procedure SetCitNum(pValue:word);
    function GetVarSym:Str15;            procedure SetVarSym(pValue:Str15);
    function GetSpcSym:Str20;            procedure SetSpcSym(pValue:Str20);
    function GetConSym:Str4;             procedure SetConSym(pValue:Str4);
    function GetPayDte:TDatetime;        procedure SetPayDte(pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetPayIba:Str25;            procedure SetPayIba(pValue:Str25);
    function GetPayCon:Str20;            procedure SetPayCon(pValue:Str20);
    function GetPayDes:Str60;            procedure SetPayDes(pValue:Str60);
    function GetPayDvz:Str3;             procedure SetPayDvz(pValue:Str3);
    function GetPayCrs:double;           procedure SetPayCrs(pValue:double);
    function GetPayCdt:TDatetime;        procedure SetPayCdt(pValue:TDatetime);
    function GetPayVal:double;           procedure SetPayVal(pValue:double);
    function GetPayAcv:double;           procedure SetPayAcv(pValue:double);
    function GetPdvAcv:double;           procedure SetPdvAcv(pValue:double);
    function GetCdvAcv:double;           procedure SetCdvAcv(pValue:double);
    function GetInvDoc:Str12;            procedure SetInvDoc(pValue:Str12);
    function GetInvTyp:Str1;             procedure SetInvTyp(pValue:Str1);
    function GetInvDvz:Str3;             procedure SetInvDvz(pValue:Str3);
    function GetInvVal:double;           procedure SetInvVal(pValue:double);
    function GetInvCrs:double;           procedure SetInvCrs(pValue:double);
    function GetInvAcv:double;           procedure SetInvAcv(pValue:double);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetEcuNum:word;             procedure SetEcuNum(pValue:word);
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
    function LocDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
    function LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocInvDoc(pInvDoc:Str12):boolean;
    function LocVarSym(pVarSym:Str15):boolean;
    function LocSpcSym(pSpcSym:Str20):boolean;
    function LocPayDte(pPayDte:TDatetime):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocDocYer(pDocYer:Str2):boolean;
    function NearDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
    function NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearInvDoc(pInvDoc:Str12):boolean;
    function NearVarSym(pVarSym:Str15):boolean;
    function NearSpcSym(pSpcSym:Str20):boolean;
    function NearPayDte(pPayDte:TDatetime):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearDocYer(pDocYer:Str2):boolean;

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
    property CitNum:word read GetCitNum write SetCitNum;
    property VarSym:Str15 read GetVarSym write SetVarSym;
    property SpcSym:Str20 read GetSpcSym write SetSpcSym;
    property ConSym:Str4 read GetConSym write SetConSym;
    property PayDte:TDatetime read GetPayDte write SetPayDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property PayIba:Str25 read GetPayIba write SetPayIba;
    property PayCon:Str20 read GetPayCon write SetPayCon;
    property PayDes:Str60 read GetPayDes write SetPayDes;
    property PayDvz:Str3 read GetPayDvz write SetPayDvz;
    property PayCrs:double read GetPayCrs write SetPayCrs;
    property PayCdt:TDatetime read GetPayCdt write SetPayCdt;
    property PayVal:double read GetPayVal write SetPayVal;
    property PayAcv:double read GetPayAcv write SetPayAcv;
    property PdvAcv:double read GetPdvAcv write SetPdvAcv;
    property CdvAcv:double read GetCdvAcv write SetCdvAcv;
    property InvDoc:Str12 read GetInvDoc write SetInvDoc;
    property InvTyp:Str1 read GetInvTyp write SetInvTyp;
    property InvDvz:Str3 read GetInvDvz write SetInvDvz;
    property InvVal:double read GetInvVal write SetInvVal;
    property InvCrs:double read GetInvCrs write SetInvCrs;
    property InvAcv:double read GetInvAcv write SetInvAcv;
    property WriNum:word read GetWriNum write SetWriNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property EcuNum:word read GetEcuNum write SetEcuNum;
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

constructor TPayjrnDat.Create;
begin
  oTable:=DatInit('PAYJRN',gPath.LdgPath,Self);
end;

constructor TPayjrnDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('PAYJRN',pPath,Self);
end;

destructor TPayjrnDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TPayjrnDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TPayjrnDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TPayjrnDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TPayjrnDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TPayjrnDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPayjrnDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TPayjrnDat.GetCitNum:word;
begin
  Result:=oTable.FieldByName('CitNum').AsInteger;
end;

procedure TPayjrnDat.SetCitNum(pValue:word);
begin
  oTable.FieldByName('CitNum').AsInteger:=pValue;
end;

function TPayjrnDat.GetVarSym:Str15;
begin
  Result:=oTable.FieldByName('VarSym').AsString;
end;

procedure TPayjrnDat.SetVarSym(pValue:Str15);
begin
  oTable.FieldByName('VarSym').AsString:=pValue;
end;

function TPayjrnDat.GetSpcSym:Str20;
begin
  Result:=oTable.FieldByName('SpcSym').AsString;
end;

procedure TPayjrnDat.SetSpcSym(pValue:Str20);
begin
  oTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TPayjrnDat.GetConSym:Str4;
begin
  Result:=oTable.FieldByName('ConSym').AsString;
end;

procedure TPayjrnDat.SetConSym(pValue:Str4);
begin
  oTable.FieldByName('ConSym').AsString:=pValue;
end;

function TPayjrnDat.GetPayDte:TDatetime;
begin
  Result:=oTable.FieldByName('PayDte').AsDateTime;
end;

procedure TPayjrnDat.SetPayDte(pValue:TDatetime);
begin
  oTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TPayjrnDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TPayjrnDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TPayjrnDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TPayjrnDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TPayjrnDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TPayjrnDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TPayjrnDat.GetPayIba:Str25;
begin
  Result:=oTable.FieldByName('PayIba').AsString;
end;

procedure TPayjrnDat.SetPayIba(pValue:Str25);
begin
  oTable.FieldByName('PayIba').AsString:=pValue;
end;

function TPayjrnDat.GetPayCon:Str20;
begin
  Result:=oTable.FieldByName('PayCon').AsString;
end;

procedure TPayjrnDat.SetPayCon(pValue:Str20);
begin
  oTable.FieldByName('PayCon').AsString:=pValue;
end;

function TPayjrnDat.GetPayDes:Str60;
begin
  Result:=oTable.FieldByName('PayDes').AsString;
end;

procedure TPayjrnDat.SetPayDes(pValue:Str60);
begin
  oTable.FieldByName('PayDes').AsString:=pValue;
end;

function TPayjrnDat.GetPayDvz:Str3;
begin
  Result:=oTable.FieldByName('PayDvz').AsString;
end;

procedure TPayjrnDat.SetPayDvz(pValue:Str3);
begin
  oTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TPayjrnDat.GetPayCrs:double;
begin
  Result:=oTable.FieldByName('PayCrs').AsFloat;
end;

procedure TPayjrnDat.SetPayCrs(pValue:double);
begin
  oTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TPayjrnDat.GetPayCdt:TDatetime;
begin
  Result:=oTable.FieldByName('PayCdt').AsDateTime;
end;

procedure TPayjrnDat.SetPayCdt(pValue:TDatetime);
begin
  oTable.FieldByName('PayCdt').AsDateTime:=pValue;
end;

function TPayjrnDat.GetPayVal:double;
begin
  Result:=oTable.FieldByName('PayVal').AsFloat;
end;

procedure TPayjrnDat.SetPayVal(pValue:double);
begin
  oTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TPayjrnDat.GetPayAcv:double;
begin
  Result:=oTable.FieldByName('PayAcv').AsFloat;
end;

procedure TPayjrnDat.SetPayAcv(pValue:double);
begin
  oTable.FieldByName('PayAcv').AsFloat:=pValue;
end;

function TPayjrnDat.GetPdvAcv:double;
begin
  Result:=oTable.FieldByName('PdvAcv').AsFloat;
end;

procedure TPayjrnDat.SetPdvAcv(pValue:double);
begin
  oTable.FieldByName('PdvAcv').AsFloat:=pValue;
end;

function TPayjrnDat.GetCdvAcv:double;
begin
  Result:=oTable.FieldByName('CdvAcv').AsFloat;
end;

procedure TPayjrnDat.SetCdvAcv(pValue:double);
begin
  oTable.FieldByName('CdvAcv').AsFloat:=pValue;
end;

function TPayjrnDat.GetInvDoc:Str12;
begin
  Result:=oTable.FieldByName('InvDoc').AsString;
end;

procedure TPayjrnDat.SetInvDoc(pValue:Str12);
begin
  oTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TPayjrnDat.GetInvTyp:Str1;
begin
  Result:=oTable.FieldByName('InvTyp').AsString;
end;

procedure TPayjrnDat.SetInvTyp(pValue:Str1);
begin
  oTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TPayjrnDat.GetInvDvz:Str3;
begin
  Result:=oTable.FieldByName('InvDvz').AsString;
end;

procedure TPayjrnDat.SetInvDvz(pValue:Str3);
begin
  oTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TPayjrnDat.GetInvVal:double;
begin
  Result:=oTable.FieldByName('InvVal').AsFloat;
end;

procedure TPayjrnDat.SetInvVal(pValue:double);
begin
  oTable.FieldByName('InvVal').AsFloat:=pValue;
end;

function TPayjrnDat.GetInvCrs:double;
begin
  Result:=oTable.FieldByName('InvCrs').AsFloat;
end;

procedure TPayjrnDat.SetInvCrs(pValue:double);
begin
  oTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TPayjrnDat.GetInvAcv:double;
begin
  Result:=oTable.FieldByName('InvAcv').AsFloat;
end;

procedure TPayjrnDat.SetInvAcv(pValue:double);
begin
  oTable.FieldByName('InvAcv').AsFloat:=pValue;
end;

function TPayjrnDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TPayjrnDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TPayjrnDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TPayjrnDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TPayjrnDat.GetEcuNum:word;
begin
  Result:=oTable.FieldByName('EcuNum').AsInteger;
end;

procedure TPayjrnDat.SetEcuNum(pValue:word);
begin
  oTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TPayjrnDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TPayjrnDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TPayjrnDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TPayjrnDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TPayjrnDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TPayjrnDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TPayjrnDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TPayjrnDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TPayjrnDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TPayjrnDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TPayjrnDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TPayjrnDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TPayjrnDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TPayjrnDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TPayjrnDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TPayjrnDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPayjrnDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TPayjrnDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TPayjrnDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TPayjrnDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TPayjrnDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TPayjrnDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TPayjrnDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TPayjrnDat.LocDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
begin
  SetIndex(ixDoItCn);
  Result:=oTable.FindKey([pDocNum,pItmNum,pCitNum]);
end;

function TPayjrnDat.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TPayjrnDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TPayjrnDat.LocInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex(ixInvDoc);
  Result:=oTable.FindKey([pInvDoc]);
end;

function TPayjrnDat.LocVarSym(pVarSym:Str15):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindKey([pVarSym]);
end;

function TPayjrnDat.LocSpcSym(pSpcSym:Str20):boolean;
begin
  SetIndex(ixSpcSym);
  Result:=oTable.FindKey([pSpcSym]);
end;

function TPayjrnDat.LocPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex(ixPayDte);
  Result:=oTable.FindKey([pPayDte]);
end;

function TPayjrnDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TPayjrnDat.LocDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindKey([pDocYer]);
end;

function TPayjrnDat.NearDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
begin
  SetIndex(ixDoItCn);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pCitNum]);
end;

function TPayjrnDat.NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TPayjrnDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TPayjrnDat.NearInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex(ixInvDoc);
  Result:=oTable.FindNearest([pInvDoc]);
end;

function TPayjrnDat.NearVarSym(pVarSym:Str15):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindNearest([pVarSym]);
end;

function TPayjrnDat.NearSpcSym(pSpcSym:Str20):boolean;
begin
  SetIndex(ixSpcSym);
  Result:=oTable.FindNearest([pSpcSym]);
end;

function TPayjrnDat.NearPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex(ixPayDte);
  Result:=oTable.FindNearest([pPayDte]);
end;

function TPayjrnDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TPayjrnDat.NearDocYer(pDocYer:Str2):boolean;
begin
  SetIndex(ixDocYer);
  Result:=oTable.FindNearest([pDocYer]);
end;

procedure TPayjrnDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TPayjrnDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TPayjrnDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TPayjrnDat.Prior;
begin
  oTable.Prior;
end;

procedure TPayjrnDat.Next;
begin
  oTable.Next;
end;

procedure TPayjrnDat.First;
begin
  Open;
  oTable.First;
end;

procedure TPayjrnDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TPayjrnDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TPayjrnDat.Edit;
begin
  oTable.Edit;
end;

procedure TPayjrnDat.Post;
begin
  oTable.Post;
end;

procedure TPayjrnDat.Delete;
begin
  oTable.Delete;
end;

procedure TPayjrnDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TPayjrnDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TPayjrnDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TPayjrnDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TPayjrnDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TPayjrnDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
