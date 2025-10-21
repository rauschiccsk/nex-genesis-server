unit dBSMDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixBokNum='BokNum';
  ixDySn='DySn';
  ixDyBnSn='DyBnSn';
  ixBegDte='BegDte';
  ixEndDte='EndDte';
  ixDstLck='DstLck';
  ixDstDif='DstDif';
  ixDstAcc='DstAcc';

type
  TBsmdocDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetLasDte:TDatetime;        procedure SetLasDte(pValue:TDatetime);
    function GetPayDvz:Str3;             procedure SetPayDvz(pValue:Str3);
    function GetPayCrs:double;           procedure SetPayCrs(pValue:double);
    function GetPayBeg:double;           procedure SetPayBeg(pValue:double);
    function GetPayCrd:double;           procedure SetPayCrd(pValue:double);
    function GetPayDeb:double;           procedure SetPayDeb(pValue:double);
    function GetPayEnd:double;           procedure SetPayEnd(pValue:double);
    function GetPayDif:double;           procedure SetPayDif(pValue:double);
    function GetAccBeg:double;           procedure SetAccBeg(pValue:double);
    function GetAccCrd:double;           procedure SetAccCrd(pValue:double);
    function GetAccDeb:double;           procedure SetAccDeb(pValue:double);
    function GetAccEnd:double;           procedure SetAccEnd(pValue:double);
    function GetPrnCnt:byte;             procedure SetPrnCnt(pValue:byte);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetCitQnt:word;             procedure SetCitQnt(pValue:word);
    function GetDstLck:Str1;             procedure SetDstLck(pValue:Str1);
    function GetDstDif:Str1;             procedure SetDstDif(pValue:Str1);
    function GetDstAcc:Str1;             procedure SetDstAcc(pValue:Str1);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
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
    function LocBokNum(pBokNum:Str3):boolean;
    function LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function LocBegDte(pBegDte:TDatetime):boolean;
    function LocEndDte(pEndDte:TDatetime):boolean;
    function LocDstLck(pDstLck:Str1):boolean;
    function LocDstDif(pDstDif:Str1):boolean;
    function LocDstAcc(pDstAcc:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearBegDte(pBegDte:TDatetime):boolean;
    function NearEndDte(pEndDte:TDatetime):boolean;
    function NearDstLck(pDstLck:Str1):boolean;
    function NearDstDif(pDstDif:Str1):boolean;
    function NearDstAcc(pDstAcc:Str1):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:longint read GetSerNum write SetSerNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property LasDte:TDatetime read GetLasDte write SetLasDte;
    property PayDvz:Str3 read GetPayDvz write SetPayDvz;
    property PayCrs:double read GetPayCrs write SetPayCrs;
    property PayBeg:double read GetPayBeg write SetPayBeg;
    property PayCrd:double read GetPayCrd write SetPayCrd;
    property PayDeb:double read GetPayDeb write SetPayDeb;
    property PayEnd:double read GetPayEnd write SetPayEnd;
    property PayDif:double read GetPayDif write SetPayDif;
    property AccBeg:double read GetAccBeg write SetAccBeg;
    property AccCrd:double read GetAccCrd write SetAccCrd;
    property AccDeb:double read GetAccDeb write SetAccDeb;
    property AccEnd:double read GetAccEnd write SetAccEnd;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property CitQnt:word read GetCitQnt write SetCitQnt;
    property DstLck:Str1 read GetDstLck write SetDstLck;
    property DstDif:Str1 read GetDstDif write SetDstDif;
    property DstAcc:Str1 read GetDstAcc write SetDstAcc;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TBsmdocDat.Create;
begin
  oTable:=DatInit('BSMDOC',gPath.LdgPath,Self);
end;

constructor TBsmdocDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BSMDOC',pPath,Self);
end;

destructor TBsmdocDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBsmdocDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBsmdocDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBsmdocDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TBsmdocDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBsmdocDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TBsmdocDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBsmdocDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TBsmdocDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TBsmdocDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TBsmdocDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBsmdocDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TBsmdocDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TBsmdocDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TBsmdocDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TBsmdocDat.GetLasDte:TDatetime;
begin
  Result:=oTable.FieldByName('LasDte').AsDateTime;
end;

procedure TBsmdocDat.SetLasDte(pValue:TDatetime);
begin
  oTable.FieldByName('LasDte').AsDateTime:=pValue;
end;

function TBsmdocDat.GetPayDvz:Str3;
begin
  Result:=oTable.FieldByName('PayDvz').AsString;
end;

procedure TBsmdocDat.SetPayDvz(pValue:Str3);
begin
  oTable.FieldByName('PayDvz').AsString:=pValue;
end;

function TBsmdocDat.GetPayCrs:double;
begin
  Result:=oTable.FieldByName('PayCrs').AsFloat;
end;

procedure TBsmdocDat.SetPayCrs(pValue:double);
begin
  oTable.FieldByName('PayCrs').AsFloat:=pValue;
end;

function TBsmdocDat.GetPayBeg:double;
begin
  Result:=oTable.FieldByName('PayBeg').AsFloat;
end;

procedure TBsmdocDat.SetPayBeg(pValue:double);
begin
  oTable.FieldByName('PayBeg').AsFloat:=pValue;
end;

function TBsmdocDat.GetPayCrd:double;
begin
  Result:=oTable.FieldByName('PayCrd').AsFloat;
end;

procedure TBsmdocDat.SetPayCrd(pValue:double);
begin
  oTable.FieldByName('PayCrd').AsFloat:=pValue;
end;

function TBsmdocDat.GetPayDeb:double;
begin
  Result:=oTable.FieldByName('PayDeb').AsFloat;
end;

procedure TBsmdocDat.SetPayDeb(pValue:double);
begin
  oTable.FieldByName('PayDeb').AsFloat:=pValue;
end;

function TBsmdocDat.GetPayEnd:double;
begin
  Result:=oTable.FieldByName('PayEnd').AsFloat;
end;

procedure TBsmdocDat.SetPayEnd(pValue:double);
begin
  oTable.FieldByName('PayEnd').AsFloat:=pValue;
end;

function TBsmdocDat.GetPayDif:double;
begin
  Result:=oTable.FieldByName('PayDif').AsFloat;
end;

procedure TBsmdocDat.SetPayDif(pValue:double);
begin
  oTable.FieldByName('PayDif').AsFloat:=pValue;
end;

function TBsmdocDat.GetAccBeg:double;
begin
  Result:=oTable.FieldByName('AccBeg').AsFloat;
end;

procedure TBsmdocDat.SetAccBeg(pValue:double);
begin
  oTable.FieldByName('AccBeg').AsFloat:=pValue;
end;

function TBsmdocDat.GetAccCrd:double;
begin
  Result:=oTable.FieldByName('AccCrd').AsFloat;
end;

procedure TBsmdocDat.SetAccCrd(pValue:double);
begin
  oTable.FieldByName('AccCrd').AsFloat:=pValue;
end;

function TBsmdocDat.GetAccDeb:double;
begin
  Result:=oTable.FieldByName('AccDeb').AsFloat;
end;

procedure TBsmdocDat.SetAccDeb(pValue:double);
begin
  oTable.FieldByName('AccDeb').AsFloat:=pValue;
end;

function TBsmdocDat.GetAccEnd:double;
begin
  Result:=oTable.FieldByName('AccEnd').AsFloat;
end;

procedure TBsmdocDat.SetAccEnd(pValue:double);
begin
  oTable.FieldByName('AccEnd').AsFloat:=pValue;
end;

function TBsmdocDat.GetPrnCnt:byte;
begin
  Result:=oTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TBsmdocDat.SetPrnCnt(pValue:byte);
begin
  oTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TBsmdocDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TBsmdocDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TBsmdocDat.GetCitQnt:word;
begin
  Result:=oTable.FieldByName('CitQnt').AsInteger;
end;

procedure TBsmdocDat.SetCitQnt(pValue:word);
begin
  oTable.FieldByName('CitQnt').AsInteger:=pValue;
end;

function TBsmdocDat.GetDstLck:Str1;
begin
  Result:=oTable.FieldByName('DstLck').AsString;
end;

procedure TBsmdocDat.SetDstLck(pValue:Str1);
begin
  oTable.FieldByName('DstLck').AsString:=pValue;
end;

function TBsmdocDat.GetDstDif:Str1;
begin
  Result:=oTable.FieldByName('DstDif').AsString;
end;

procedure TBsmdocDat.SetDstDif(pValue:Str1);
begin
  oTable.FieldByName('DstDif').AsString:=pValue;
end;

function TBsmdocDat.GetDstAcc:Str1;
begin
  Result:=oTable.FieldByName('DstAcc').AsString;
end;

procedure TBsmdocDat.SetDstAcc(pValue:Str1);
begin
  oTable.FieldByName('DstAcc').AsString:=pValue;
end;

function TBsmdocDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBsmdocDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBsmdocDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TBsmdocDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBsmdocDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBsmdocDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBsmdocDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBsmdocDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBsmdocDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBsmdocDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBsmdocDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBsmdocDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBsmdocDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBsmdocDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBsmdocDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBsmdocDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TBsmdocDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TBsmdocDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TBsmdocDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TBsmdocDat.LocBegDte(pBegDte:TDatetime):boolean;
begin
  SetIndex(ixBegDte);
  Result:=oTable.FindKey([pBegDte]);
end;

function TBsmdocDat.LocEndDte(pEndDte:TDatetime):boolean;
begin
  SetIndex(ixEndDte);
  Result:=oTable.FindKey([pEndDte]);
end;

function TBsmdocDat.LocDstLck(pDstLck:Str1):boolean;
begin
  SetIndex(ixDstLck);
  Result:=oTable.FindKey([pDstLck]);
end;

function TBsmdocDat.LocDstDif(pDstDif:Str1):boolean;
begin
  SetIndex(ixDstDif);
  Result:=oTable.FindKey([pDstDif]);
end;

function TBsmdocDat.LocDstAcc(pDstAcc:Str1):boolean;
begin
  SetIndex(ixDstAcc);
  Result:=oTable.FindKey([pDstAcc]);
end;

function TBsmdocDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TBsmdocDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TBsmdocDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TBsmdocDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TBsmdocDat.NearBegDte(pBegDte:TDatetime):boolean;
begin
  SetIndex(ixBegDte);
  Result:=oTable.FindNearest([pBegDte]);
end;

function TBsmdocDat.NearEndDte(pEndDte:TDatetime):boolean;
begin
  SetIndex(ixEndDte);
  Result:=oTable.FindNearest([pEndDte]);
end;

function TBsmdocDat.NearDstLck(pDstLck:Str1):boolean;
begin
  SetIndex(ixDstLck);
  Result:=oTable.FindNearest([pDstLck]);
end;

function TBsmdocDat.NearDstDif(pDstDif:Str1):boolean;
begin
  SetIndex(ixDstDif);
  Result:=oTable.FindNearest([pDstDif]);
end;

function TBsmdocDat.NearDstAcc(pDstAcc:Str1):boolean;
begin
  SetIndex(ixDstAcc);
  Result:=oTable.FindNearest([pDstAcc]);
end;

procedure TBsmdocDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBsmdocDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBsmdocDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBsmdocDat.Prior;
begin
  oTable.Refresh;
  oTable.Prior;
end;

procedure TBsmdocDat.Next;
begin
  oTable.Refresh;
  oTable.Next;
end;

procedure TBsmdocDat.First;
begin
  Open;
  oTable.Refresh;
  oTable.First;
end;

procedure TBsmdocDat.Last;
begin
  Open;
  oTable.Refresh;
  oTable.Last;
end;

procedure TBsmdocDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBsmdocDat.Edit;
begin
  oTable.Edit;
end;

procedure TBsmdocDat.Post;
begin
  oTable.Post;
end;

procedure TBsmdocDat.Delete;
begin
  oTable.Delete;
end;

procedure TBsmdocDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBsmdocDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBsmdocDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBsmdocDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBsmdocDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBsmdocDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
