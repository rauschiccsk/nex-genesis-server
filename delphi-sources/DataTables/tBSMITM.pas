unit tBSMITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum='';
  ixVarSym='VarSym';
  ixSpcSym='SpcSym';
  ixPayDte='PayDte';
  ixPayCon='PayCon';
  ixPayIba='PayIba';
  ixInvDoc='InvDoc';
  ixParNam_='ParNam_';
  ixPayVal='PayVal';

type
  TBsmitmTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetVarSym:Str15;            procedure SetVarSym (pValue:Str15);
    function GetSpcSym:Str20;            procedure SetSpcSym (pValue:Str20);
    function GetConSym:Str4;             procedure SetConSym (pValue:Str4);
    function GetPayDte:TDatetime;        procedure SetPayDte (pValue:TDatetime);
    function GetPayIba:Str25;            procedure SetPayIba (pValue:Str25);
    function GetPayCon:Str20;            procedure SetPayCon (pValue:Str20);
    function GetPayDes:Str60;            procedure SetPayDes (pValue:Str60);
    function GetPayDvz:Str3;             procedure SetPayDvz (pValue:Str3);
    function GetPayCrs:double;           procedure SetPayCrs (pValue:double);
    function GetPayCdt:TDatetime;        procedure SetPayCdt (pValue:TDatetime);
    function GetPayVal:double;           procedure SetPayVal (pValue:double);
    function GetPayAcv:double;           procedure SetPayAcv (pValue:double);
    function GetItmAcv:double;           procedure SetItmAcv (pValue:double);
    function GetPdvAcv:double;           procedure SetPdvAcv (pValue:double);
    function GetCdvAcv:double;           procedure SetCdvAcv (pValue:double);
    function GetInvDoc:Str12;            procedure SetInvDoc (pValue:Str12);
    function GetInvTyp:Str1;             procedure SetInvTyp (pValue:Str1);
    function GetInvDvz:Str3;             procedure SetInvDvz (pValue:Str3);
    function GetInvVal:double;           procedure SetInvVal (pValue:double);
    function GetInvCrs:double;           procedure SetInvCrs (pValue:double);
    function GetInvAcv:double;           procedure SetInvAcv (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetEcuNum:word;             procedure SetEcuNum (pValue:word);
    function GetCdvSnt:Str3;             procedure SetCdvSnt (pValue:Str3);
    function GetCdvAnl:Str6;             procedure SetCdvAnl (pValue:Str6);
    function GetPdvSnt:Str3;             procedure SetPdvSnt (pValue:Str3);
    function GetPdvAnl:Str6;             procedure SetPdvAnl (pValue:Str6);
    function GetItmSnt:Str3;             procedure SetItmSnt (pValue:Str3);
    function GetItmAnl:Str6;             procedure SetItmAnl (pValue:Str6);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
    function GetCitQnt:word;             procedure SetCitQnt (pValue:word);
    function GetCitVal:double;           procedure SetCitVal (pValue:double);
    function GetCrtUsr:Str10;            procedure SetCrtUsr (pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr (pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn (pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte (pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocVarSym (pVarSym:Str15):boolean;
    function LocSpcSym (pSpcSym:Str20):boolean;
    function LocPayDte (pPayDte:TDatetime):boolean;
    function LocPayCon (pPayCon:Str20):boolean;
    function LocPayIba (pPayIba:Str25):boolean;
    function LocInvDoc (pInvDoc:Str12):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocPayVal (pPayVal:double):boolean;

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
    property ItmAcv:double read GetItmAcv write SetItmAcv;
    property PdvAcv:double read GetPdvAcv write SetPdvAcv;
    property CdvAcv:double read GetCdvAcv write SetCdvAcv;
    property InvDoc:Str12 read GetInvDoc write SetInvDoc;
    property InvTyp:Str1 read GetInvTyp write SetInvTyp;
    property InvDvz:Str3 read GetInvDvz write SetInvDvz;
    property InvVal:double read GetInvVal write SetInvVal;
    property InvCrs:double read GetInvCrs write SetInvCrs;
    property InvAcv:double read GetInvAcv write SetInvAcv;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
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
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TBsmitmTmp.Create;
begin
  oTmpTable:=TmpInit ('BSMITM',Self);
end;

destructor TBsmitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBsmitmTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBsmitmTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TBsmitmTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBsmitmTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBsmitmTmp.GetVarSym:Str15;
begin
  Result:=oTmpTable.FieldByName('VarSym').AsString;
end;

procedure TBsmitmTmp.SetVarSym(pValue:Str15);
begin
  oTmpTable.FieldByName('VarSym').AsString:=pValue;
end;

function TBsmitmTmp.GetSpcSym:Str20;
begin
  Result:=oTmpTable.FieldByName('SpcSym').AsString;
end;

procedure TBsmitmTmp.SetSpcSym(pValue:Str20);
begin
  oTmpTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TBsmitmTmp.GetConSym:Str4;
begin
  Result:=oTmpTable.FieldByName('ConSym').AsString;
end;

procedure TBsmitmTmp.SetConSym(pValue:Str4);
begin
  oTmpTable.FieldByName('ConSym').AsString:=pValue;
end;

function TBsmitmTmp.GetPayDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDte').AsDateTime;
end;

procedure TBsmitmTmp.SetPayDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetPayIba:Str25;
begin
  Result:=oTmpTable.FieldByName('PayIba').AsString;
end;

procedure TBsmitmTmp.SetPayIba(pValue:Str25);
begin
  oTmpTable.FieldByName('PayIba').AsString:=pValue;
end;

function TBsmitmTmp.GetPayCon:Str20;
begin
  Result:=oTmpTable.FieldByName('PayCon').AsString;
end;

procedure TBsmitmTmp.SetPayCon(pValue:Str20);
begin
  oTmpTable.FieldByName('PayCon').AsString:=pValue;
end;

function TBsmitmTmp.GetPayDes:Str60;
begin
  Result:=oTmpTable.FieldByName('PayDes').AsString;
end;

procedure TBsmitmTmp.SetPayDes(pValue:Str60);
begin
  oTmpTable.FieldByName('PayDes').AsString:=pValue;
end;

function TBsmitmTmp.GetPayDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('PayDvz').AsString;
end;

procedure TBsmitmTmp.SetPayDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TBsmitmTmp.GetPayCrs:double;
begin
  Result:=oTmpTable.FieldByName('PayCrs').AsFloat;
end;

procedure TBsmitmTmp.SetPayCrs(pValue:double);
begin
  oTmpTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TBsmitmTmp.GetPayCdt:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayCdt').AsDateTime;
end;

procedure TBsmitmTmp.SetPayCdt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayCdt').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetPayVal:double;
begin
  Result:=oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TBsmitmTmp.SetPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TBsmitmTmp.GetPayAcv:double;
begin
  Result:=oTmpTable.FieldByName('PayAcv').AsFloat;
end;

procedure TBsmitmTmp.SetPayAcv(pValue:double);
begin
  oTmpTable.FieldByName('PayAcv').AsFloat:=pValue;
end;

function TBsmitmTmp.GetItmAcv:double;
begin
  Result:=oTmpTable.FieldByName('ItmAcv').AsFloat;
end;

procedure TBsmitmTmp.SetItmAcv(pValue:double);
begin
  oTmpTable.FieldByName('ItmAcv').AsFloat:=pValue;
end;

function TBsmitmTmp.GetPdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('PdvAcv').AsFloat;
end;

procedure TBsmitmTmp.SetPdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('PdvAcv').AsFloat:=pValue;
end;

function TBsmitmTmp.GetCdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('CdvAcv').AsFloat;
end;

procedure TBsmitmTmp.SetCdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('CdvAcv').AsFloat:=pValue;
end;

function TBsmitmTmp.GetInvDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InvDoc').AsString;
end;

procedure TBsmitmTmp.SetInvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TBsmitmTmp.GetInvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('InvTyp').AsString;
end;

procedure TBsmitmTmp.SetInvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TBsmitmTmp.GetInvDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('InvDvz').AsString;
end;

procedure TBsmitmTmp.SetInvDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TBsmitmTmp.GetInvVal:double;
begin
  Result:=oTmpTable.FieldByName('InvVal').AsFloat;
end;

procedure TBsmitmTmp.SetInvVal(pValue:double);
begin
  oTmpTable.FieldByName('InvVal').AsFloat:=pValue;
end;

function TBsmitmTmp.GetInvCrs:double;
begin
  Result:=oTmpTable.FieldByName('InvCrs').AsFloat;
end;

procedure TBsmitmTmp.SetInvCrs(pValue:double);
begin
  oTmpTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TBsmitmTmp.GetInvAcv:double;
begin
  Result:=oTmpTable.FieldByName('InvAcv').AsFloat;
end;

procedure TBsmitmTmp.SetInvAcv(pValue:double);
begin
  oTmpTable.FieldByName('InvAcv').AsFloat:=pValue;
end;

function TBsmitmTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TBsmitmTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBsmitmTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TBsmitmTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TBsmitmTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TBsmitmTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TBsmitmTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TBsmitmTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TBsmitmTmp.GetEcuNum:word;
begin
  Result:=oTmpTable.FieldByName('EcuNum').AsInteger;
end;

procedure TBsmitmTmp.SetEcuNum(pValue:word);
begin
  oTmpTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TBsmitmTmp.GetCdvSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('CdvSnt').AsString;
end;

procedure TBsmitmTmp.SetCdvSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CdvSnt').AsString:=pValue;
end;

function TBsmitmTmp.GetCdvAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('CdvAnl').AsString;
end;

procedure TBsmitmTmp.SetCdvAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CdvAnl').AsString:=pValue;
end;

function TBsmitmTmp.GetPdvSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('PdvSnt').AsString;
end;

procedure TBsmitmTmp.SetPdvSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('PdvSnt').AsString:=pValue;
end;

function TBsmitmTmp.GetPdvAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('PdvAnl').AsString;
end;

procedure TBsmitmTmp.SetPdvAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('PdvAnl').AsString:=pValue;
end;

function TBsmitmTmp.GetItmSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('ItmSnt').AsString;
end;

procedure TBsmitmTmp.SetItmSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('ItmSnt').AsString:=pValue;
end;

function TBsmitmTmp.GetItmAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('ItmAnl').AsString;
end;

procedure TBsmitmTmp.SetItmAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('ItmAnl').AsString:=pValue;
end;

function TBsmitmTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBsmitmTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBsmitmTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TBsmitmTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBsmitmTmp.GetCitQnt:word;
begin
  Result:=oTmpTable.FieldByName('CitQnt').AsInteger;
end;

procedure TBsmitmTmp.SetCitQnt(pValue:word);
begin
  oTmpTable.FieldByName('CitQnt').AsInteger:=pValue;
end;

function TBsmitmTmp.GetCitVal:double;
begin
  Result:=oTmpTable.FieldByName('CitVal').AsFloat;
end;

procedure TBsmitmTmp.SetCitVal(pValue:double);
begin
  oTmpTable.FieldByName('CitVal').AsFloat:=pValue;
end;

function TBsmitmTmp.GetCrtUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TBsmitmTmp.SetCrtUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBsmitmTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TBsmitmTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBsmitmTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBsmitmTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBsmitmTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetModUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('ModUsr').AsString;
end;

procedure TBsmitmTmp.SetModUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TBsmitmTmp.GetModUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('ModUsn').AsString;
end;

procedure TBsmitmTmp.SetModUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TBsmitmTmp.GetModDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDte').AsDateTime;
end;

procedure TBsmitmTmp.SetModDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetModTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTim').AsDateTime;
end;

procedure TBsmitmTmp.SetModTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TBsmitmTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TBsmitmTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsmitmTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBsmitmTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBsmitmTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TBsmitmTmp.LocVarSym(pVarSym:Str15):boolean;
begin
  SetIndex (ixVarSym);
  Result:=oTmpTable.FindKey([pVarSym]);
end;

function TBsmitmTmp.LocSpcSym(pSpcSym:Str20):boolean;
begin
  SetIndex (ixSpcSym);
  Result:=oTmpTable.FindKey([pSpcSym]);
end;

function TBsmitmTmp.LocPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex (ixPayDte);
  Result:=oTmpTable.FindKey([pPayDte]);
end;

function TBsmitmTmp.LocPayCon(pPayCon:Str20):boolean;
begin
  SetIndex (ixPayCon);
  Result:=oTmpTable.FindKey([pPayCon]);
end;

function TBsmitmTmp.LocPayIba(pPayIba:Str25):boolean;
begin
  SetIndex (ixPayIba);
  Result:=oTmpTable.FindKey([pPayIba]);
end;

function TBsmitmTmp.LocInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result:=oTmpTable.FindKey([pInvDoc]);
end;

function TBsmitmTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TBsmitmTmp.LocPayVal(pPayVal:double):boolean;
begin
  SetIndex (ixPayVal);
  Result:=oTmpTable.FindKey([pPayVal]);
end;

procedure TBsmitmTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBsmitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBsmitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBsmitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBsmitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBsmitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TBsmitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBsmitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBsmitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBsmitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBsmitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBsmitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBsmitmTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBsmitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBsmitmTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBsmitmTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TBsmitmTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
