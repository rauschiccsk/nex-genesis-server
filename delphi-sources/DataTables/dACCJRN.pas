unit dACCJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixExtNum='ExtNum';
  ixDocDte='DocDte';
  ixSnAn='SnAn';
  ixDoWrSnAn='DoWrSnAn';
  ixDoIt='DoIt';
  ixDocDes='DocDes';
  ixCrdAcv='CrdAcv';
  ixDebAcv='DebAcv';

type
  TAccjrnDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetExtNum:Str12;            procedure SetExtNum(pValue:Str12);
    function GetWriNum:word;             procedure SetWriNum(pValue:word);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetAccSnt:Str3;             procedure SetAccSnt(pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl(pValue:Str6);
    function GetDocDes:Str30;            procedure SetDocDes(pValue:Str30);
    function GetDocDes_:Str30;           procedure SetDocDes_(pValue:Str30);
    function GetCrdAcv:double;           procedure SetCrdAcv(pValue:double);
    function GetDebAcv:double;           procedure SetDebAcv(pValue:double);
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetBegRec:byte;             procedure SetBegRec(pValue:byte);
    function GetConDoc:Str12;            procedure SetConDoc(pValue:Str12);
    function GetSmcNum:word;             procedure SetSmcNum(pValue:word);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetOcdNum:Str12;            procedure SetOcdNum(pValue:Str12);
    function GetOceNum:Str12;            procedure SetOceNum(pValue:Str12);
    function GetEcuNum:word;             procedure SetEcuNum(pValue:word);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetSpaNum:longint;          procedure SetSpaNum(pValue:longint);
    function GetDocCrs:double;           procedure SetDocCrs(pValue:double);
    function GetDocFgv:double;           procedure SetDocFgv(pValue:double);
    function GetReserv:double;           procedure SetReserv(pValue:double);
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
    function LocExtNum(pExtNum:Str12):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocDoWrSnAn(pDocNum:Str12;pWriNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function LocDocDes(pDocDes_:Str30):boolean;
    function LocCrdAcv(pCrdAcv:double):boolean;
    function LocDebAcv(pDebAcv:double):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearDoWrSnAn(pDocNum:Str12;pWriNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocDes(pDocDes_:Str30):boolean;
    function NearCrdAcv(pCrdAcv:double):boolean;
    function NearDebAcv(pDebAcv:double):boolean;

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
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property WriNum:word read GetWriNum write SetWriNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property DocDes:Str30 read GetDocDes write SetDocDes;
    property DocDes_:Str30 read GetDocDes_ write SetDocDes_;
    property CrdAcv:double read GetCrdAcv write SetCrdAcv;
    property DebAcv:double read GetDebAcv write SetDebAcv;
    property StkNum:word read GetStkNum write SetStkNum;
    property BegRec:byte read GetBegRec write SetBegRec;
    property ConDoc:Str12 read GetConDoc write SetConDoc;
    property SmcNum:word read GetSmcNum write SetSmcNum;
    property ParNum:longint read GetParNum write SetParNum;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OceNum:Str12 read GetOceNum write SetOceNum;
    property EcuNum:word read GetEcuNum write SetEcuNum;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property DocCrs:double read GetDocCrs write SetDocCrs;
    property DocFgv:double read GetDocFgv write SetDocFgv;
    property Reserv:double read GetReserv write SetReserv;
  end;

implementation

constructor TAccjrnDat.Create;
begin
  oTable:=DatInit('JOURNAL',gPath.LdgPath,Self);
end;

constructor TAccjrnDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('JOURNAL',pPath,Self);
end;

destructor TAccjrnDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAccjrnDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAccjrnDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAccjrnDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TAccjrnDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TAccjrnDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TAccjrnDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TAccjrnDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TAccjrnDat.GetWriNum:word;
begin
  Result:=oTable.FieldByName('WriNum').AsInteger;
end;

procedure TAccjrnDat.SetWriNum(pValue:word);
begin
  oTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TAccjrnDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TAccjrnDat.GetAccSnt:Str3;
begin
  Result:=oTable.FieldByName('AccSnt').AsString;
end;

procedure TAccjrnDat.SetAccSnt(pValue:Str3);
begin
  oTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAccjrnDat.GetAccAnl:Str6;
begin
  Result:=oTable.FieldByName('AccAnl').AsString;
end;

procedure TAccjrnDat.SetAccAnl(pValue:Str6);
begin
  oTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAccjrnDat.GetDocDes:Str30;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TAccjrnDat.SetDocDes(pValue:Str30);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TAccjrnDat.GetDocDes_:Str30;
begin
  Result:=oTable.FieldByName('DocDes_').AsString;
end;

procedure TAccjrnDat.SetDocDes_(pValue:Str30);
begin
  oTable.FieldByName('DocDes_').AsString:=pValue;
end;

function TAccjrnDat.GetCrdAcv:double;
begin
  Result:=oTable.FieldByName('CrdAcv').AsFloat;
end;

procedure TAccjrnDat.SetCrdAcv(pValue:double);
begin
  oTable.FieldByName('CrdAcv').AsFloat:=pValue;
end;

function TAccjrnDat.GetDebAcv:double;
begin
  Result:=oTable.FieldByName('DebAcv').AsFloat;
end;

procedure TAccjrnDat.SetDebAcv(pValue:double);
begin
  oTable.FieldByName('DebAcv').AsFloat:=pValue;
end;

function TAccjrnDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TAccjrnDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetBegRec:byte;
begin
  Result:=oTable.FieldByName('BegRec').AsInteger;
end;

procedure TAccjrnDat.SetBegRec(pValue:byte);
begin
  oTable.FieldByName('BegRec').AsInteger:=pValue;
end;

function TAccjrnDat.GetConDoc:Str12;
begin
  Result:=oTable.FieldByName('ConDoc').AsString;
end;

procedure TAccjrnDat.SetConDoc(pValue:Str12);
begin
  oTable.FieldByName('ConDoc').AsString:=pValue;
end;

function TAccjrnDat.GetSmcNum:word;
begin
  Result:=oTable.FieldByName('SmcNum').AsInteger;
end;

procedure TAccjrnDat.SetSmcNum(pValue:word);
begin
  oTable.FieldByName('SmcNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TAccjrnDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetOcdNum:Str12;
begin
  Result:=oTable.FieldByName('OcdNum').AsString;
end;

procedure TAccjrnDat.SetOcdNum(pValue:Str12);
begin
  oTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TAccjrnDat.GetOceNum:Str12;
begin
  Result:=oTable.FieldByName('OceNum').AsString;
end;

procedure TAccjrnDat.SetOceNum(pValue:Str12);
begin
  oTable.FieldByName('OceNum').AsString:=pValue;
end;

function TAccjrnDat.GetEcuNum:word;
begin
  Result:=oTable.FieldByName('EcuNum').AsInteger;
end;

procedure TAccjrnDat.SetEcuNum(pValue:word);
begin
  oTable.FieldByName('EcuNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAccjrnDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAccjrnDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAccjrnDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAccjrnDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAccjrnDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAccjrnDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TAccjrnDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TAccjrnDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TAccjrnDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TAccjrnDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TAccjrnDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TAccjrnDat.GetSpaNum:longint;
begin
  Result:=oTable.FieldByName('SpaNum').AsInteger;
end;

procedure TAccjrnDat.SetSpaNum(pValue:longint);
begin
  oTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TAccjrnDat.GetDocCrs:double;
begin
  Result:=oTable.FieldByName('DocCrs').AsFloat;
end;

procedure TAccjrnDat.SetDocCrs(pValue:double);
begin
  oTable.FieldByName('DocCrs').AsFloat:=pValue;
end;

function TAccjrnDat.GetDocFgv:double;
begin
  Result:=oTable.FieldByName('DocFgv').AsFloat;
end;

procedure TAccjrnDat.SetDocFgv(pValue:double);
begin
  oTable.FieldByName('DocFgv').AsFloat:=pValue;
end;

function TAccjrnDat.GetReserv:double;
begin
  Result:=oTable.FieldByName('Reserv').AsFloat;
end;

procedure TAccjrnDat.SetReserv(pValue:double);
begin
  oTable.FieldByName('Reserv').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccjrnDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAccjrnDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAccjrnDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAccjrnDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAccjrnDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAccjrnDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAccjrnDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAccjrnDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TAccjrnDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TAccjrnDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TAccjrnDat.LocSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindKey([pAccSnt,pAccAnl]);
end;

function TAccjrnDat.LocDoWrSnAn(pDocNum:Str12;pWriNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixDoWrSnAn);
  Result:=oTable.FindKey([pDocNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TAccjrnDat.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TAccjrnDat.LocDocDes(pDocDes_:Str30):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindKey([StrToAlias(pDocDes_)]);
end;

function TAccjrnDat.LocCrdAcv(pCrdAcv:double):boolean;
begin
  SetIndex(ixCrdAcv);
  Result:=oTable.FindKey([pCrdAcv]);
end;

function TAccjrnDat.LocDebAcv(pDebAcv:double):boolean;
begin
  SetIndex(ixDebAcv);
  Result:=oTable.FindKey([pDebAcv]);
end;

function TAccjrnDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TAccjrnDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TAccjrnDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TAccjrnDat.NearSnAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixSnAn);
  Result:=oTable.FindNearest([pAccSnt,pAccAnl]);
end;

function TAccjrnDat.NearDoWrSnAn(pDocNum:Str12;pWriNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex(ixDoWrSnAn);
  Result:=oTable.FindNearest([pDocNum,pWriNum,pAccSnt,pAccAnl]);
end;

function TAccjrnDat.NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TAccjrnDat.NearDocDes(pDocDes_:Str30):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindNearest([pDocDes_]);
end;

function TAccjrnDat.NearCrdAcv(pCrdAcv:double):boolean;
begin
  SetIndex(ixCrdAcv);
  Result:=oTable.FindNearest([pCrdAcv]);
end;

function TAccjrnDat.NearDebAcv(pDebAcv:double):boolean;
begin
  SetIndex(ixDebAcv);
  Result:=oTable.FindNearest([pDebAcv]);
end;

procedure TAccjrnDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAccjrnDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAccjrnDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAccjrnDat.Prior;
begin
  oTable.Prior;
end;

procedure TAccjrnDat.Next;
begin
  oTable.Next;
end;

procedure TAccjrnDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAccjrnDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAccjrnDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAccjrnDat.Edit;
begin
  oTable.Edit;
end;

procedure TAccjrnDat.Post;
begin
  oTable.Post;
end;

procedure TAccjrnDat.Delete;
begin
  oTable.Delete;
end;

procedure TAccjrnDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAccjrnDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAccjrnDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAccjrnDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAccjrnDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAccjrnDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
