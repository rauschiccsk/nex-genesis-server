unit dSRDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDySn='DySn';
  ixDyBn='DyBn';
  ixDyBnSn='DyBnSn';
  ixBokNum='BokNum';
  ixDocDes='DocDes';
  ixDocDte='DocDte';
  ixOutSmc='OutSmc';
  ixOutDte='OutDte';
  ixIncSmc='IncSmc';
  ixIncDte='IncDte';

type
  TSrdlstDat=class(TComponent)
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
    function GetDocDes:Str50;            procedure SetDocDes(pValue:Str50);
    function GetDocDes_:Str50;           procedure SetDocDes_(pValue:Str50);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
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
    function GetIncDst:Str1;             procedure SetIncDst(pValue:Str1);
    function GetProVol:double;           procedure SetProVol(pValue:double);
    function GetProWgh:double;           procedure SetProWgh(pValue:double);
    function GetStkAva:double;           procedure SetStkAva(pValue:double);
    function GetMovPrq:double;           procedure SetMovPrq(pValue:double);
    function GetOutPrq:double;           procedure SetOutPrq(pValue:double);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetPrjNum:Str12;            procedure SetPrjNum(pValue:Str12);
    function GetNotice:Str50;            procedure SetNotice(pValue:Str50);
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
    function LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function LocDyBn(pDocYer:Str2;pBokNum:Str3):boolean;
    function LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function LocBokNum(pBokNum:Str3):boolean;
    function LocDocDes(pDocDes_:Str50):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocOutSmc(pOutSmc:word):boolean;
    function LocOutDte(pOutDte:TDatetime):boolean;
    function LocIncSmc(pIncSmc:word):boolean;
    function LocIncDte(pIncDte:TDatetime):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBn(pDocYer:Str2;pBokNum:Str3):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDocDes(pDocDes_:Str50):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearOutSmc(pOutSmc:word):boolean;
    function NearOutDte(pOutDte:TDatetime):boolean;
    function NearIncSmc(pIncSmc:word):boolean;
    function NearIncDte(pIncDte:TDatetime):boolean;

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
    property DocDes:Str50 read GetDocDes write SetDocDes;
    property DocDes_:Str50 read GetDocDes_ write SetDocDes_;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
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
    property IncDst:Str1 read GetIncDst write SetIncDst;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property StkAva:double read GetStkAva write SetStkAva;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property OutPrq:double read GetOutPrq write SetOutPrq;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property PrjNum:Str12 read GetPrjNum write SetPrjNum;
    property Notice:Str50 read GetNotice write SetNotice;
  end;

implementation

constructor TSrdlstDat.Create;
begin
  oTable:=DatInit('SRDLST',gPath.StkPath,Self);
end;

constructor TSrdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('SRDLST',pPath,Self);
end;

destructor TSrdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TSrdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TSrdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TSrdlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TSrdlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TSrdlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TSrdlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TSrdlstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TSrdlstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TSrdlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TSrdlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TSrdlstDat.GetDocDes:Str50;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TSrdlstDat.SetDocDes(pValue:Str50);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TSrdlstDat.GetDocDes_:Str50;
begin
  Result:=oTable.FieldByName('DocDes_').AsString;
end;

procedure TSrdlstDat.SetDocDes_(pValue:Str50);
begin
  oTable.FieldByName('DocDes_').AsString:=pValue;
end;

function TSrdlstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TSrdlstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TSrdlstDat.GetOutWrn:word;
begin
  Result:=oTable.FieldByName('OutWrn').AsInteger;
end;

procedure TSrdlstDat.SetOutWrn(pValue:word);
begin
  oTable.FieldByName('OutWrn').AsInteger:=pValue;
end;

function TSrdlstDat.GetOutStn:word;
begin
  Result:=oTable.FieldByName('OutStn').AsInteger;
end;

procedure TSrdlstDat.SetOutStn(pValue:word);
begin
  oTable.FieldByName('OutStn').AsInteger:=pValue;
end;

function TSrdlstDat.GetOutSmc:word;
begin
  Result:=oTable.FieldByName('OutSmc').AsInteger;
end;

procedure TSrdlstDat.SetOutSmc(pValue:word);
begin
  oTable.FieldByName('OutSmc').AsInteger:=pValue;
end;

function TSrdlstDat.GetOutUsr:Str10;
begin
  Result:=oTable.FieldByName('OutUsr').AsString;
end;

procedure TSrdlstDat.SetOutUsr(pValue:Str10);
begin
  oTable.FieldByName('OutUsr').AsString:=pValue;
end;

function TSrdlstDat.GetOutUsn:Str30;
begin
  Result:=oTable.FieldByName('OutUsn').AsString;
end;

procedure TSrdlstDat.SetOutUsn(pValue:Str30);
begin
  oTable.FieldByName('OutUsn').AsString:=pValue;
end;

function TSrdlstDat.GetOutDte:TDatetime;
begin
  Result:=oTable.FieldByName('OutDte').AsDateTime;
end;

procedure TSrdlstDat.SetOutDte(pValue:TDatetime);
begin
  oTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TSrdlstDat.GetOutTim:TDatetime;
begin
  Result:=oTable.FieldByName('OutTim').AsDateTime;
end;

procedure TSrdlstDat.SetOutTim(pValue:TDatetime);
begin
  oTable.FieldByName('OutTim').AsDateTime:=pValue;
end;

function TSrdlstDat.GetOutSta:Str1;
begin
  Result:=oTable.FieldByName('OutSta').AsString;
end;

procedure TSrdlstDat.SetOutSta(pValue:Str1);
begin
  oTable.FieldByName('OutSta').AsString:=pValue;
end;

function TSrdlstDat.GetIncWrn:word;
begin
  Result:=oTable.FieldByName('IncWrn').AsInteger;
end;

procedure TSrdlstDat.SetIncWrn(pValue:word);
begin
  oTable.FieldByName('IncWrn').AsInteger:=pValue;
end;

function TSrdlstDat.GetIncStn:word;
begin
  Result:=oTable.FieldByName('IncStn').AsInteger;
end;

procedure TSrdlstDat.SetIncStn(pValue:word);
begin
  oTable.FieldByName('IncStn').AsInteger:=pValue;
end;

function TSrdlstDat.GetIncSmc:word;
begin
  Result:=oTable.FieldByName('IncSmc').AsInteger;
end;

procedure TSrdlstDat.SetIncSmc(pValue:word);
begin
  oTable.FieldByName('IncSmc').AsInteger:=pValue;
end;

function TSrdlstDat.GetIncUsr:Str10;
begin
  Result:=oTable.FieldByName('IncUsr').AsString;
end;

procedure TSrdlstDat.SetIncUsr(pValue:Str10);
begin
  oTable.FieldByName('IncUsr').AsString:=pValue;
end;

function TSrdlstDat.GetIncUsn:Str30;
begin
  Result:=oTable.FieldByName('IncUsn').AsString;
end;

procedure TSrdlstDat.SetIncUsn(pValue:Str30);
begin
  oTable.FieldByName('IncUsn').AsString:=pValue;
end;

function TSrdlstDat.GetIncDte:TDatetime;
begin
  Result:=oTable.FieldByName('IncDte').AsDateTime;
end;

procedure TSrdlstDat.SetIncDte(pValue:TDatetime);
begin
  oTable.FieldByName('IncDte').AsDateTime:=pValue;
end;

function TSrdlstDat.GetIncTim:TDatetime;
begin
  Result:=oTable.FieldByName('IncTim').AsDateTime;
end;

procedure TSrdlstDat.SetIncTim(pValue:TDatetime);
begin
  oTable.FieldByName('IncTim').AsDateTime:=pValue;
end;

function TSrdlstDat.GetIncDst:Str1;
begin
  Result:=oTable.FieldByName('IncDst').AsString;
end;

procedure TSrdlstDat.SetIncDst(pValue:Str1);
begin
  oTable.FieldByName('IncDst').AsString:=pValue;
end;

function TSrdlstDat.GetProVol:double;
begin
  Result:=oTable.FieldByName('ProVol').AsFloat;
end;

procedure TSrdlstDat.SetProVol(pValue:double);
begin
  oTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TSrdlstDat.GetProWgh:double;
begin
  Result:=oTable.FieldByName('ProWgh').AsFloat;
end;

procedure TSrdlstDat.SetProWgh(pValue:double);
begin
  oTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TSrdlstDat.GetStkAva:double;
begin
  Result:=oTable.FieldByName('StkAva').AsFloat;
end;

procedure TSrdlstDat.SetStkAva(pValue:double);
begin
  oTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TSrdlstDat.GetMovPrq:double;
begin
  Result:=oTable.FieldByName('MovPrq').AsFloat;
end;

procedure TSrdlstDat.SetMovPrq(pValue:double);
begin
  oTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TSrdlstDat.GetOutPrq:double;
begin
  Result:=oTable.FieldByName('OutPrq').AsFloat;
end;

procedure TSrdlstDat.SetOutPrq(pValue:double);
begin
  oTable.FieldByName('OutPrq').AsFloat:=pValue;
end;

function TSrdlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TSrdlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TSrdlstDat.GetPrjNum:Str12;
begin
  Result:=oTable.FieldByName('PrjNum').AsString;
end;

procedure TSrdlstDat.SetPrjNum(pValue:Str12);
begin
  oTable.FieldByName('PrjNum').AsString:=pValue;
end;

function TSrdlstDat.GetNotice:Str50;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TSrdlstDat.SetNotice(pValue:Str50);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TSrdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TSrdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TSrdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TSrdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TSrdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TSrdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TSrdlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TSrdlstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TSrdlstDat.LocDyBn(pDocYer:Str2;pBokNum:Str3):boolean;
begin
  SetIndex(ixDyBn);
  Result:=oTable.FindKey([pDocYer,pBokNum]);
end;

function TSrdlstDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TSrdlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TSrdlstDat.LocDocDes(pDocDes_:Str50):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindKey([StrToAlias(pDocDes_)]);
end;

function TSrdlstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TSrdlstDat.LocOutSmc(pOutSmc:word):boolean;
begin
  SetIndex(ixOutSmc);
  Result:=oTable.FindKey([pOutSmc]);
end;

function TSrdlstDat.LocOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindKey([pOutDte]);
end;

function TSrdlstDat.LocIncSmc(pIncSmc:word):boolean;
begin
  SetIndex(ixIncSmc);
  Result:=oTable.FindKey([pIncSmc]);
end;

function TSrdlstDat.LocIncDte(pIncDte:TDatetime):boolean;
begin
  SetIndex(ixIncDte);
  Result:=oTable.FindKey([pIncDte]);
end;

function TSrdlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TSrdlstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TSrdlstDat.NearDyBn(pDocYer:Str2;pBokNum:Str3):boolean;
begin
  SetIndex(ixDyBn);
  Result:=oTable.FindNearest([pDocYer,pBokNum]);
end;

function TSrdlstDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TSrdlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TSrdlstDat.NearDocDes(pDocDes_:Str50):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindNearest([pDocDes_]);
end;

function TSrdlstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TSrdlstDat.NearOutSmc(pOutSmc:word):boolean;
begin
  SetIndex(ixOutSmc);
  Result:=oTable.FindNearest([pOutSmc]);
end;

function TSrdlstDat.NearOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex(ixOutDte);
  Result:=oTable.FindNearest([pOutDte]);
end;

function TSrdlstDat.NearIncSmc(pIncSmc:word):boolean;
begin
  SetIndex(ixIncSmc);
  Result:=oTable.FindNearest([pIncSmc]);
end;

function TSrdlstDat.NearIncDte(pIncDte:TDatetime):boolean;
begin
  SetIndex(ixIncDte);
  Result:=oTable.FindNearest([pIncDte]);
end;

procedure TSrdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TSrdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TSrdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TSrdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TSrdlstDat.Next;
begin
  oTable.Next;
end;

procedure TSrdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TSrdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TSrdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TSrdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TSrdlstDat.Post;
begin
  oTable.Post;
end;

procedure TSrdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TSrdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TSrdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TSrdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TSrdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TSrdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TSrdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
