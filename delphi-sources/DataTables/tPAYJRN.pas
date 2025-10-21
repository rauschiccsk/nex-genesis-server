unit tPAYJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItCn='';
  ixDoIt='DoIt';
  ixPayDte='PayDte';

type
  TPayjrnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetCitNum:word;             procedure SetCitNum (pValue:word);
    function GetVarSym:Str15;            procedure SetVarSym (pValue:Str15);
    function GetSpcSym:Str20;            procedure SetSpcSym (pValue:Str20);
    function GetConSym:Str4;             procedure SetConSym (pValue:Str4);
    function GetPayDte:TDatetime;        procedure SetPayDte (pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetPayIba:Str25;            procedure SetPayIba (pValue:Str25);
    function GetPayCon:Str20;            procedure SetPayCon (pValue:Str20);
    function GetPayDes:Str60;            procedure SetPayDes (pValue:Str60);
    function GetPayDvz:Str3;             procedure SetPayDvz (pValue:Str3);
    function GetPayCrs:double;           procedure SetPayCrs (pValue:double);
    function GetPayCdt:TDatetime;        procedure SetPayCdt (pValue:TDatetime);
    function GetPayVal:double;           procedure SetPayVal (pValue:double);
    function GetPayAcv:double;           procedure SetPayAcv (pValue:double);
    function GetPdvAcv:double;           procedure SetPdvAcv (pValue:double);
    function GetCdvAcv:double;           procedure SetCdvAcv (pValue:double);
    function GetInvDoc:Str12;            procedure SetInvDoc (pValue:Str12);
    function GetInvTyp:Str1;             procedure SetInvTyp (pValue:Str1);
    function GetInvDvz:Str3;             procedure SetInvDvz (pValue:Str3);
    function GetInvVal:double;           procedure SetInvVal (pValue:double);
    function GetInvCrs:double;           procedure SetInvCrs (pValue:double);
    function GetInvAcv:double;           procedure SetInvAcv (pValue:double);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
    function GetEcuNum:word;             procedure SetEcuNum (pValue:word);
    function GetCrtUsr:Str10;            procedure SetCrtUsr (pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr (pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn (pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte (pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDoItCn (pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
    function LocDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocPayDte (pPayDte:TDatetime):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property CitNum:word read GetCitNum write SetCitNum;
    property VarSym:Str15 read GetVarSym write SetVarSym;
    property SpcSym:Str20 read GetSpcSym write SetSpcSym;
    property ConSym:Str4 read GetConSym write SetConSym;
    property PayDte:TDatetime read GetPayDte write SetPayDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
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

constructor TPayjrnTmp.Create;
begin
  oTmpTable:=TmpInit ('PAYJRN',Self);
end;

destructor TPayjrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPayjrnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TPayjrnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TPayjrnTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPayjrnTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TPayjrnTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPayjrnTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TPayjrnTmp.GetCitNum:word;
begin
  Result:=oTmpTable.FieldByName('CitNum').AsInteger;
end;

procedure TPayjrnTmp.SetCitNum(pValue:word);
begin
  oTmpTable.FieldByName('CitNum').AsInteger:=pValue;
end;

function TPayjrnTmp.GetVarSym:Str15;
begin
  Result:=oTmpTable.FieldByName('VarSym').AsString;
end;

procedure TPayjrnTmp.SetVarSym(pValue:Str15);
begin
  oTmpTable.FieldByName('VarSym').AsString:=pValue;
end;

function TPayjrnTmp.GetSpcSym:Str20;
begin
  Result:=oTmpTable.FieldByName('SpcSym').AsString;
end;

procedure TPayjrnTmp.SetSpcSym(pValue:Str20);
begin
  oTmpTable.FieldByName('SpcSym').AsString:=pValue;
end;

function TPayjrnTmp.GetConSym:Str4;
begin
  Result:=oTmpTable.FieldByName('ConSym').AsString;
end;

procedure TPayjrnTmp.SetConSym(pValue:Str4);
begin
  oTmpTable.FieldByName('ConSym').AsString:=pValue;
end;

function TPayjrnTmp.GetPayDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDte').AsDateTime;
end;

procedure TPayjrnTmp.SetPayDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TPayjrnTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TPayjrnTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TPayjrnTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TPayjrnTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TPayjrnTmp.GetPayIba:Str25;
begin
  Result:=oTmpTable.FieldByName('PayIba').AsString;
end;

procedure TPayjrnTmp.SetPayIba(pValue:Str25);
begin
  oTmpTable.FieldByName('PayIba').AsString:=pValue;
end;

function TPayjrnTmp.GetPayCon:Str20;
begin
  Result:=oTmpTable.FieldByName('PayCon').AsString;
end;

procedure TPayjrnTmp.SetPayCon(pValue:Str20);
begin
  oTmpTable.FieldByName('PayCon').AsString:=pValue;
end;

function TPayjrnTmp.GetPayDes:Str60;
begin
  Result:=oTmpTable.FieldByName('PayDes').AsString;
end;

procedure TPayjrnTmp.SetPayDes(pValue:Str60);
begin
  oTmpTable.FieldByName('PayDes').AsString:=pValue;
end;

function TPayjrnTmp.GetPayDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('PayDvz').AsString;
end;

procedure TPayjrnTmp.SetPayDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TPayjrnTmp.GetPayCrs:double;
begin
  Result:=oTmpTable.FieldByName('PayCrs').AsFloat;
end;

procedure TPayjrnTmp.SetPayCrs(pValue:double);
begin
  oTmpTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TPayjrnTmp.GetPayCdt:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayCdt').AsDateTime;
end;

procedure TPayjrnTmp.SetPayCdt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayCdt').AsDateTime:=pValue;
end;

function TPayjrnTmp.GetPayVal:double;
begin
  Result:=oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TPayjrnTmp.SetPayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat:=pValue;
end;

function TPayjrnTmp.GetPayAcv:double;
begin
  Result:=oTmpTable.FieldByName('PayAcv').AsFloat;
end;

procedure TPayjrnTmp.SetPayAcv(pValue:double);
begin
  oTmpTable.FieldByName('PayAcv').AsFloat:=pValue;
end;

function TPayjrnTmp.GetPdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('PdvAcv').AsFloat;
end;

procedure TPayjrnTmp.SetPdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('PdvAcv').AsFloat:=pValue;
end;

function TPayjrnTmp.GetCdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('CdvAcv').AsFloat;
end;

procedure TPayjrnTmp.SetCdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('CdvAcv').AsFloat:=pValue;
end;

function TPayjrnTmp.GetInvDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InvDoc').AsString;
end;

procedure TPayjrnTmp.SetInvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TPayjrnTmp.GetInvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('InvTyp').AsString;
end;

procedure TPayjrnTmp.SetInvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TPayjrnTmp.GetInvDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('InvDvz').AsString;
end;

procedure TPayjrnTmp.SetInvDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TPayjrnTmp.GetInvVal:double;
begin
  Result:=oTmpTable.FieldByName('InvVal').AsFloat;
end;

procedure TPayjrnTmp.SetInvVal(pValue:double);
begin
  oTmpTable.FieldByName('InvVal').AsFloat:=pValue;
end;

function TPayjrnTmp.GetInvCrs:double;
begin
  Result:=oTmpTable.FieldByName('InvCrs').AsFloat;
end;

procedure TPayjrnTmp.SetInvCrs(pValue:double);
begin
  oTmpTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TPayjrnTmp.GetInvAcv:double;
begin
  Result:=oTmpTable.FieldByName('InvAcv').AsFloat;
end;

procedure TPayjrnTmp.SetInvAcv(pValue:double);
begin
  oTmpTable.FieldByName('InvAcv').AsFloat:=pValue;
end;

function TPayjrnTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TPayjrnTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TPayjrnTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TPayjrnTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TPayjrnTmp.GetEcuNum:word;
begin
  Result:=oTmpTable.FieldByName('EcuNum').AsInteger;
end;

procedure TPayjrnTmp.SetEcuNum(pValue:word);
begin
  oTmpTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TPayjrnTmp.GetCrtUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TPayjrnTmp.SetCrtUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TPayjrnTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TPayjrnTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TPayjrnTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TPayjrnTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TPayjrnTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TPayjrnTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TPayjrnTmp.GetModUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('ModUsr').AsString;
end;

procedure TPayjrnTmp.SetModUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TPayjrnTmp.GetModUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('ModUsn').AsString;
end;

procedure TPayjrnTmp.SetModUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TPayjrnTmp.GetModDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDte').AsDateTime;
end;

procedure TPayjrnTmp.SetModDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TPayjrnTmp.GetModTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTim').AsDateTime;
end;

procedure TPayjrnTmp.SetModTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPayjrnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TPayjrnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TPayjrnTmp.LocDoItCn(pDocNum:Str12;pItmNum:word;pCitNum:word):boolean;
begin
  SetIndex (ixDoItCn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum,pCitNum]);
end;

function TPayjrnTmp.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TPayjrnTmp.LocPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex (ixPayDte);
  Result:=oTmpTable.FindKey([pPayDte]);
end;

procedure TPayjrnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TPayjrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPayjrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPayjrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPayjrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPayjrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TPayjrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPayjrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPayjrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPayjrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPayjrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPayjrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPayjrnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPayjrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPayjrnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPayjrnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TPayjrnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
