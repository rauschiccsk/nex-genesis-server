unit dBSMITM;

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
  ixPayCon='PayCon';
  ixPayIba='PayIba';

type
  TBsmitmDat=class(TComponent)
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
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetEcuNum:word;             procedure SetEcuNum(pValue:word);
    function GetCdvSnt:Str3;             procedure SetCdvSnt(pValue:Str3);
    function GetCdvAnl:Str6;             procedure SetCdvAnl(pValue:Str6);
    function GetPdvSnt:Str3;             procedure SetPdvSnt(pValue:Str3);
    function GetPdvAnl:Str6;             procedure SetPdvAnl(pValue:Str6);
    function GetItmSnt:Str3;             procedure SetItmSnt(pValue:Str3);
    function GetItmAnl:Str6;             procedure SetItmAnl(pValue:Str6);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetCitQnt:word;             procedure SetCitQnt(pValue:word);
    function GetCitVal:double;           procedure SetCitVal(pValue:double);
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
    function LocPayCon(pPayCon:Str20):boolean;
    function LocPayIba(pPayIba:Str25):boolean;
    function NearDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
    function NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearInvDoc(pInvDoc:Str12):boolean;
    function NearVarSym(pVarSym:Str15):boolean;
    function NearSpcSym(pSpcSym:Str20):boolean;
    function NearPayDte(pPayDte:TDatetime):boolean;
    function NearPayCon(pPayCon:Str20):boolean;
    function NearPayIba(pPayIba:Str25):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property EcuNum:word read GetEcuNum write SetEcuNum;
    property CdvSnt:Str3 read GetCdvSnt write SetCdvSnt;
    property CdvAnl:Str6 read GetCdvAnl write SetCdvAnl;
    property PdvSnt:Str3 read GetPdvSnt write SetPdvSnt;
    property PdvAnl:Str6 read GetPdvAnl write SetPdvAnl;
    property ItmSnt:Str3 read GetItmSnt write SetItmSnt;
    property ItmAnl:Str6 read GetItmAnl write SetItmAnl;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property CitQnt:word read GetCitQnt write SetCitQnt;
    property CitVal:double read GetCitVal write SetCitVal;
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

constructor TBsmitmDat.Create;
begin
  oTable:=DatInit('BSMITM',gPath.LdgPath,Self);
end;

constructor TBsmitmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BSMITM',pPath,Self);
end;

destructor TBsmitmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBsmitmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBsmitmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBsmitmDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TBsmitmDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBsmitmDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBsmitmDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBsmitmDat.GetCitNum:word;
begin
  Result:=oTable.FieldByName('CitNum').AsInteger;
end;

procedure TBsmitmDat.SetCitNum(pValue:word);
begin
  oTable.FieldByName('CitNum').AsInteger:=pValue;
end;

function TBsmitmDat.GetVarSym:Str15;
begin
  Result:=oTable.FieldByName('VarSym').AsString;
end;

procedure TBsmitmDat.SetVarSym(pValue:Str15);
begin
  oTable.FieldByName('VarSym').AsString:=pValue;
end;

function TBsmitmDat.GetSpcSym:Str20;
begin
  Result:=oTable.FieldByName('SpcSym').AsString;
end;

procedure TBsmitmDat.SetSpcSym(pValue:Str20);
begin
  oTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TBsmitmDat.GetConSym:Str4;
begin
  Result:=oTable.FieldByName('ConSym').AsString;
end;

procedure TBsmitmDat.SetConSym(pValue:Str4);
begin
  oTable.FieldByName('ConSym').AsString:=pValue;
end;

function TBsmitmDat.GetPayDte:TDatetime;
begin
  Result:=oTable.FieldByName('PayDte').AsDateTime;
end;

procedure TBsmitmDat.SetPayDte(pValue:TDatetime);
begin
  oTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TBsmitmDat.GetPayIba:Str25;
begin
  Result:=oTable.FieldByName('PayIba').AsString;
end;

procedure TBsmitmDat.SetPayIba(pValue:Str25);
begin
  oTable.FieldByName('PayIba').AsString:=pValue;
end;

function TBsmitmDat.GetPayCon:Str20;
begin
  Result:=oTable.FieldByName('PayCon').AsString;
end;

procedure TBsmitmDat.SetPayCon(pValue:Str20);
begin
  oTable.FieldByName('PayCon').AsString:=pValue;
end;

function TBsmitmDat.GetPayDes:Str60;
begin
  Result:=oTable.FieldByName('PayDes').AsString;
end;

procedure TBsmitmDat.SetPayDes(pValue:Str60);
begin
  oTable.FieldByName('PayDes').AsString:=pValue;
end;

function TBsmitmDat.GetPayDvz:Str3;
begin
  Result:=oTable.FieldByName('PayDvz').AsString;
end;

procedure TBsmitmDat.SetPayDvz(pValue:Str3);
begin
  oTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TBsmitmDat.GetPayCrs:double;
begin
  Result:=oTable.FieldByName('PayCrs').AsFloat;
end;

procedure TBsmitmDat.SetPayCrs(pValue:double);
begin
  oTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TBsmitmDat.GetPayCdt:TDatetime;
begin
  Result:=oTable.FieldByName('PayCdt').AsDateTime;
end;

procedure TBsmitmDat.SetPayCdt(pValue:TDatetime);
begin
  oTable.FieldByName('PayCdt').AsDateTime:=pValue;
end;

function TBsmitmDat.GetPayVal:double;
begin
  Result:=oTable.FieldByName('PayVal').AsFloat;
end;

procedure TBsmitmDat.SetPayVal(pValue:double);
begin
  oTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TBsmitmDat.GetPayAcv:double;
begin
  Result:=oTable.FieldByName('PayAcv').AsFloat;
end;

procedure TBsmitmDat.SetPayAcv(pValue:double);
begin
  oTable.FieldByName('PayAcv').AsFloat:=pValue;
end;

function TBsmitmDat.GetPdvAcv:double;
begin
  Result:=oTable.FieldByName('PdvAcv').AsFloat;
end;

procedure TBsmitmDat.SetPdvAcv(pValue:double);
begin
  oTable.FieldByName('PdvAcv').AsFloat:=pValue;
end;

function TBsmitmDat.GetCdvAcv:double;
begin
  Result:=oTable.FieldByName('CdvAcv').AsFloat;
end;

procedure TBsmitmDat.SetCdvAcv(pValue:double);
begin
  oTable.FieldByName('CdvAcv').AsFloat:=pValue;
end;

function TBsmitmDat.GetInvDoc:Str12;
begin
  Result:=oTable.FieldByName('InvDoc').AsString;
end;

procedure TBsmitmDat.SetInvDoc(pValue:Str12);
begin
  oTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TBsmitmDat.GetInvTyp:Str1;
begin
  Result:=oTable.FieldByName('InvTyp').AsString;
end;

procedure TBsmitmDat.SetInvTyp(pValue:Str1);
begin
  oTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TBsmitmDat.GetInvDvz:Str3;
begin
  Result:=oTable.FieldByName('InvDvz').AsString;
end;

procedure TBsmitmDat.SetInvDvz(pValue:Str3);
begin
  oTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TBsmitmDat.GetInvVal:double;
begin
  Result:=oTable.FieldByName('InvVal').AsFloat;
end;

procedure TBsmitmDat.SetInvVal(pValue:double);
begin
  oTable.FieldByName('InvVal').AsFloat:=pValue;
end;

function TBsmitmDat.GetInvCrs:double;
begin
  Result:=oTable.FieldByName('InvCrs').AsFloat;
end;

procedure TBsmitmDat.SetInvCrs(pValue:double);
begin
  oTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TBsmitmDat.GetInvAcv:double;
begin
  Result:=oTable.FieldByName('InvAcv').AsFloat;
end;

procedure TBsmitmDat.SetInvAcv(pValue:double);
begin
  oTable.FieldByName('InvAcv').AsFloat:=pValue;
end;

function TBsmitmDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TBsmitmDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBsmitmDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TBsmitmDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TBsmitmDat.GetEcuNum:word;
begin
  Result:=oTable.FieldByName('EcuNum').AsInteger;
end;

procedure TBsmitmDat.SetEcuNum(pValue:word);
begin
  oTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TBsmitmDat.GetCdvSnt:Str3;
begin
  Result:=oTable.FieldByName('CdvSnt').AsString;
end;

procedure TBsmitmDat.SetCdvSnt(pValue:Str3);
begin
  oTable.FieldByName('CdvSnt').AsString:=pValue;
end;

function TBsmitmDat.GetCdvAnl:Str6;
begin
  Result:=oTable.FieldByName('CdvAnl').AsString;
end;

procedure TBsmitmDat.SetCdvAnl(pValue:Str6);
begin
  oTable.FieldByName('CdvAnl').AsString:=pValue;
end;

function TBsmitmDat.GetPdvSnt:Str3;
begin
  Result:=oTable.FieldByName('PdvSnt').AsString;
end;

procedure TBsmitmDat.SetPdvSnt(pValue:Str3);
begin
  oTable.FieldByName('PdvSnt').AsString:=pValue;
end;

function TBsmitmDat.GetPdvAnl:Str6;
begin
  Result:=oTable.FieldByName('PdvAnl').AsString;
end;

procedure TBsmitmDat.SetPdvAnl(pValue:Str6);
begin
  oTable.FieldByName('PdvAnl').AsString:=pValue;
end;

function TBsmitmDat.GetItmSnt:Str3;
begin
  Result:=oTable.FieldByName('ItmSnt').AsString;
end;

procedure TBsmitmDat.SetItmSnt(pValue:Str3);
begin
  oTable.FieldByName('ItmSnt').AsString:=pValue;
end;

function TBsmitmDat.GetItmAnl:Str6;
begin
  Result:=oTable.FieldByName('ItmAnl').AsString;
end;

procedure TBsmitmDat.SetItmAnl(pValue:Str6);
begin
  oTable.FieldByName('ItmAnl').AsString:=pValue;
end;

function TBsmitmDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TBsmitmDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBsmitmDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TBsmitmDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBsmitmDat.GetCitQnt:word;
begin
  Result:=oTable.FieldByName('CitQnt').AsInteger;
end;

procedure TBsmitmDat.SetCitQnt(pValue:word);
begin
  oTable.FieldByName('CitQnt').AsInteger:=pValue;
end;

function TBsmitmDat.GetCitVal:double;
begin
  Result:=oTable.FieldByName('CitVal').AsFloat;
end;

procedure TBsmitmDat.SetCitVal(pValue:double);
begin
  oTable.FieldByName('CitVal').AsFloat:=pValue;
end;

function TBsmitmDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBsmitmDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBsmitmDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TBsmitmDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBsmitmDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBsmitmDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBsmitmDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBsmitmDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBsmitmDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TBsmitmDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TBsmitmDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TBsmitmDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TBsmitmDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TBsmitmDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TBsmitmDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TBsmitmDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsmitmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBsmitmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBsmitmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBsmitmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBsmitmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBsmitmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBsmitmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBsmitmDat.LocDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
begin
  SetIndex(ixDoItCn);
  Result:=oTable.FindKey([pDocNum,pItmNum,pCitNum]);
end;

function TBsmitmDat.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TBsmitmDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TBsmitmDat.LocInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex(ixInvDoc);
  Result:=oTable.FindKey([pInvDoc]);
end;

function TBsmitmDat.LocVarSym(pVarSym:Str15):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindKey([pVarSym]);
end;

function TBsmitmDat.LocSpcSym(pSpcSym:Str20):boolean;
begin
  SetIndex(ixSpcSym);
  Result:=oTable.FindKey([pSpcSym]);
end;

function TBsmitmDat.LocPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex(ixPayDte);
  Result:=oTable.FindKey([pPayDte]);
end;

function TBsmitmDat.LocPayCon(pPayCon:Str20):boolean;
begin
  SetIndex(ixPayCon);
  Result:=oTable.FindKey([pPayCon]);
end;

function TBsmitmDat.LocPayIba(pPayIba:Str25):boolean;
begin
  SetIndex(ixPayIba);
  Result:=oTable.FindKey([pPayIba]);
end;

function TBsmitmDat.NearDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
begin
  SetIndex(ixDoItCn);
  Result:=oTable.FindNearest([pDocNum,pItmNum,pCitNum]);
end;

function TBsmitmDat.NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TBsmitmDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TBsmitmDat.NearInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex(ixInvDoc);
  Result:=oTable.FindNearest([pInvDoc]);
end;

function TBsmitmDat.NearVarSym(pVarSym:Str15):boolean;
begin
  SetIndex(ixVarSym);
  Result:=oTable.FindNearest([pVarSym]);
end;

function TBsmitmDat.NearSpcSym(pSpcSym:Str20):boolean;
begin
  SetIndex(ixSpcSym);
  Result:=oTable.FindNearest([pSpcSym]);
end;

function TBsmitmDat.NearPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex(ixPayDte);
  Result:=oTable.FindNearest([pPayDte]);
end;

function TBsmitmDat.NearPayCon(pPayCon:Str20):boolean;
begin
  SetIndex(ixPayCon);
  Result:=oTable.FindNearest([pPayCon]);
end;

function TBsmitmDat.NearPayIba(pPayIba:Str25):boolean;
begin
  SetIndex(ixPayIba);
  Result:=oTable.FindNearest([pPayIba]);
end;

procedure TBsmitmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBsmitmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBsmitmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBsmitmDat.Prior;
begin
  oTable.Prior;
end;

procedure TBsmitmDat.Next;
begin
  oTable.Next;
end;

procedure TBsmitmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBsmitmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBsmitmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBsmitmDat.Edit;
begin
  oTable.Edit;
end;

procedure TBsmitmDat.Post;
begin
  oTable.Post;
end;

procedure TBsmitmDat.Delete;
begin
  oTable.Delete;
end;

procedure TBsmitmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBsmitmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBsmitmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBsmitmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBsmitmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBsmitmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
