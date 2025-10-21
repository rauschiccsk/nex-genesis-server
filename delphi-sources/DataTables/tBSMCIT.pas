unit tBSMCIT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCitNum='';
  ixVarSym='VarSym';
  ixPayDte='PayDte';
  ixInvDoc='InvDoc';

type
  TBsmcitTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetCitNum:word;             procedure SetCitNum (pValue:word);
    function GetVarSym:Str15;            procedure SetVarSym (pValue:Str15);
    function GetPayDte:TDatetime;        procedure SetPayDte (pValue:TDatetime);
    function GetPayDes:Str60;            procedure SetPayDes (pValue:Str60);
    function GetPayDvz:Str3;             procedure SetPayDvz (pValue:Str3);
    function GetPayCrs:double;           procedure SetPayCrs (pValue:double);
    function GetPayCdt:TDatetime;        procedure SetPayCdt (pValue:TDatetime);
    function GetPayFgv:double;           procedure SetPayFgv (pValue:double);
    function GetPayAcv:double;           procedure SetPayAcv (pValue:double);
    function GetPdvAcv:double;           procedure SetPdvAcv (pValue:double);
    function GetCdvAcv:double;           procedure SetCdvAcv (pValue:double);
    function GetInvDoc:Str12;            procedure SetInvDoc (pValue:Str12);
    function GetInvTyp:Str1;             procedure SetInvTyp (pValue:Str1);
    function GetInvDvz:Str3;             procedure SetInvDvz (pValue:Str3);
    function GetInvFgv:double;           procedure SetInvFgv (pValue:double);
    function GetInvCrs:double;           procedure SetInvCrs (pValue:double);
    function GetInvAcv:double;           procedure SetInvAcv (pValue:double);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetEcuNum:word;             procedure SetEcuNum (pValue:word);
    function GetCdvSnt:Str3;             procedure SetCdvSnt (pValue:Str3);
    function GetCdvAnl:Str6;             procedure SetCdvAnl (pValue:Str6);
    function GetPdvSnt:Str3;             procedure SetPdvSnt (pValue:Str3);
    function GetPdvAnl:Str6;             procedure SetPdvAnl (pValue:Str6);
    function GetPaySnt:Str3;             procedure SetPaySnt (pValue:Str3);
    function GetPayAnl:Str6;             procedure SetPayAnl (pValue:Str6);
    function GetBokNum:Str3;             procedure SetBokNum (pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer (pValue:Str2);
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
    function LocCitNum (pCitNum:word):boolean;
    function LocVarSym (pVarSym:Str15):boolean;
    function LocPayDte (pPayDte:TDatetime):boolean;
    function LocInvDoc (pInvDoc:Str12):boolean;

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
    property CitNum:word read GetCitNum write SetCitNum;
    property VarSym:Str15 read GetVarSym write SetVarSym;
    property PayDte:TDatetime read GetPayDte write SetPayDte;
    property PayDes:Str60 read GetPayDes write SetPayDes;
    property PayDvz:Str3 read GetPayDvz write SetPayDvz;
    property PayCrs:double read GetPayCrs write SetPayCrs;
    property PayCdt:TDatetime read GetPayCdt write SetPayCdt;
    property PayFgv:double read GetPayFgv write SetPayFgv;
    property PayAcv:double read GetPayAcv write SetPayAcv;
    property PdvAcv:double read GetPdvAcv write SetPdvAcv;
    property CdvAcv:double read GetCdvAcv write SetCdvAcv;
    property InvDoc:Str12 read GetInvDoc write SetInvDoc;
    property InvTyp:Str1 read GetInvTyp write SetInvTyp;
    property InvDvz:Str3 read GetInvDvz write SetInvDvz;
    property InvFgv:double read GetInvFgv write SetInvFgv;
    property InvCrs:double read GetInvCrs write SetInvCrs;
    property InvAcv:double read GetInvAcv write SetInvAcv;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property WriNum:word read GetWriNum write SetWriNum;
    property EcuNum:word read GetEcuNum write SetEcuNum;
    property CdvSnt:Str3 read GetCdvSnt write SetCdvSnt;
    property CdvAnl:Str6 read GetCdvAnl write SetCdvAnl;
    property PdvSnt:Str3 read GetPdvSnt write SetPdvSnt;
    property PdvAnl:Str6 read GetPdvAnl write SetPdvAnl;
    property PaySnt:Str3 read GetPaySnt write SetPaySnt;
    property PayAnl:Str6 read GetPayAnl write SetPayAnl;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
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

constructor TBsmcitTmp.Create;
begin
  oTmpTable:=TmpInit ('BSMCIT',Self);
end;

destructor TBsmcitTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBsmcitTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TBsmcitTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TBsmcitTmp.GetCitNum:word;
begin
  Result:=oTmpTable.FieldByName('CitNum').AsInteger;
end;

procedure TBsmcitTmp.SetCitNum(pValue:word);
begin
  oTmpTable.FieldByName('CitNum').AsInteger:=pValue;
end;

function TBsmcitTmp.GetVarSym:Str15;
begin
  Result:=oTmpTable.FieldByName('VarSym').AsString;
end;

procedure TBsmcitTmp.SetVarSym(pValue:Str15);
begin
  oTmpTable.FieldByName('VarSym').AsString:=pValue;
end;

function TBsmcitTmp.GetPayDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDte').AsDateTime;
end;

procedure TBsmcitTmp.SetPayDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDte').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetPayDes:Str60;
begin
  Result:=oTmpTable.FieldByName('PayDes').AsString;
end;

procedure TBsmcitTmp.SetPayDes(pValue:Str60);
begin
  oTmpTable.FieldByName('PayDes').AsString:=pValue;
end;

function TBsmcitTmp.GetPayDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('PayDvz').AsString;
end;

procedure TBsmcitTmp.SetPayDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TBsmcitTmp.GetPayCrs:double;
begin
  Result:=oTmpTable.FieldByName('PayCrs').AsFloat;
end;

procedure TBsmcitTmp.SetPayCrs(pValue:double);
begin
  oTmpTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TBsmcitTmp.GetPayCdt:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayCdt').AsDateTime;
end;

procedure TBsmcitTmp.SetPayCdt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayCdt').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetPayFgv:double;
begin
  Result:=oTmpTable.FieldByName('PayFgv').AsFloat;
end;

procedure TBsmcitTmp.SetPayFgv(pValue:double);
begin
  oTmpTable.FieldByName('PayFgv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetPayAcv:double;
begin
  Result:=oTmpTable.FieldByName('PayAcv').AsFloat;
end;

procedure TBsmcitTmp.SetPayAcv(pValue:double);
begin
  oTmpTable.FieldByName('PayAcv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetPdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('PdvAcv').AsFloat;
end;

procedure TBsmcitTmp.SetPdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('PdvAcv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetCdvAcv:double;
begin
  Result:=oTmpTable.FieldByName('CdvAcv').AsFloat;
end;

procedure TBsmcitTmp.SetCdvAcv(pValue:double);
begin
  oTmpTable.FieldByName('CdvAcv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetInvDoc:Str12;
begin
  Result:=oTmpTable.FieldByName('InvDoc').AsString;
end;

procedure TBsmcitTmp.SetInvDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InvDoc').AsString:=pValue;
end;

function TBsmcitTmp.GetInvTyp:Str1;
begin
  Result:=oTmpTable.FieldByName('InvTyp').AsString;
end;

procedure TBsmcitTmp.SetInvTyp(pValue:Str1);
begin
  oTmpTable.FieldByName('InvTyp').AsString:=pValue;
end;

function TBsmcitTmp.GetInvDvz:Str3;
begin
  Result:=oTmpTable.FieldByName('InvDvz').AsString;
end;

procedure TBsmcitTmp.SetInvDvz(pValue:Str3);
begin
  oTmpTable.FieldByName('InvDvz').AsString:=pValue;
end;

function TBsmcitTmp.GetInvFgv:double;
begin
  Result:=oTmpTable.FieldByName('InvFgv').AsFloat;
end;

procedure TBsmcitTmp.SetInvFgv(pValue:double);
begin
  oTmpTable.FieldByName('InvFgv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetInvCrs:double;
begin
  Result:=oTmpTable.FieldByName('InvCrs').AsFloat;
end;

procedure TBsmcitTmp.SetInvCrs(pValue:double);
begin
  oTmpTable.FieldByName('InvCrs').AsFloat:=pValue;
end;

function TBsmcitTmp.GetInvAcv:double;
begin
  Result:=oTmpTable.FieldByName('InvAcv').AsFloat;
end;

procedure TBsmcitTmp.SetInvAcv(pValue:double);
begin
  oTmpTable.FieldByName('InvAcv').AsFloat:=pValue;
end;

function TBsmcitTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TBsmcitTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBsmcitTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TBsmcitTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TBsmcitTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TBsmcitTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TBsmcitTmp.GetEcuNum:word;
begin
  Result:=oTmpTable.FieldByName('EcuNum').AsInteger;
end;

procedure TBsmcitTmp.SetEcuNum(pValue:word);
begin
  oTmpTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TBsmcitTmp.GetCdvSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('CdvSnt').AsString;
end;

procedure TBsmcitTmp.SetCdvSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CdvSnt').AsString:=pValue;
end;

function TBsmcitTmp.GetCdvAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('CdvAnl').AsString;
end;

procedure TBsmcitTmp.SetCdvAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CdvAnl').AsString:=pValue;
end;

function TBsmcitTmp.GetPdvSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('PdvSnt').AsString;
end;

procedure TBsmcitTmp.SetPdvSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('PdvSnt').AsString:=pValue;
end;

function TBsmcitTmp.GetPdvAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('PdvAnl').AsString;
end;

procedure TBsmcitTmp.SetPdvAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('PdvAnl').AsString:=pValue;
end;

function TBsmcitTmp.GetPaySnt:Str3;
begin
  Result:=oTmpTable.FieldByName('PaySnt').AsString;
end;

procedure TBsmcitTmp.SetPaySnt(pValue:Str3);
begin
  oTmpTable.FieldByName('PaySnt').AsString:=pValue;
end;

function TBsmcitTmp.GetPayAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('PayAnl').AsString;
end;

procedure TBsmcitTmp.SetPayAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('PayAnl').AsString:=pValue;
end;

function TBsmcitTmp.GetBokNum:Str3;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TBsmcitTmp.SetBokNum(pValue:Str3);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBsmcitTmp.GetDocYer:Str2;
begin
  Result:=oTmpTable.FieldByName('DocYer').AsString;
end;

procedure TBsmcitTmp.SetDocYer(pValue:Str2);
begin
  oTmpTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBsmcitTmp.GetCrtUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TBsmcitTmp.SetCrtUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBsmcitTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TBsmcitTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBsmcitTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBsmcitTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBsmcitTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetModUsr:Str10;
begin
  Result:=oTmpTable.FieldByName('ModUsr').AsString;
end;

procedure TBsmcitTmp.SetModUsr(pValue:Str10);
begin
  oTmpTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TBsmcitTmp.GetModUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('ModUsn').AsString;
end;

procedure TBsmcitTmp.SetModUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TBsmcitTmp.GetModDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDte').AsDateTime;
end;

procedure TBsmcitTmp.SetModDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetModTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTim').AsDateTime;
end;

procedure TBsmcitTmp.SetModTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TBsmcitTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TBsmcitTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsmcitTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TBsmcitTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TBsmcitTmp.LocCitNum(pCitNum:word):boolean;
begin
  SetIndex (ixCitNum);
  Result:=oTmpTable.FindKey([pCitNum]);
end;

function TBsmcitTmp.LocVarSym(pVarSym:Str15):boolean;
begin
  SetIndex (ixVarSym);
  Result:=oTmpTable.FindKey([pVarSym]);
end;

function TBsmcitTmp.LocPayDte(pPayDte:TDatetime):boolean;
begin
  SetIndex (ixPayDte);
  Result:=oTmpTable.FindKey([pPayDte]);
end;

function TBsmcitTmp.LocInvDoc(pInvDoc:Str12):boolean;
begin
  SetIndex (ixInvDoc);
  Result:=oTmpTable.FindKey([pInvDoc]);
end;

procedure TBsmcitTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TBsmcitTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBsmcitTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBsmcitTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBsmcitTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBsmcitTmp.First;
begin
  oTmpTable.First;
end;

procedure TBsmcitTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBsmcitTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBsmcitTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBsmcitTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBsmcitTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBsmcitTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBsmcitTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBsmcitTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBsmcitTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBsmcitTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TBsmcitTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
