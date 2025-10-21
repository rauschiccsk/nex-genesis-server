unit dBWDLST;

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
  ixDocDte='DocDte';
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixEdiUsr='EdiUsr';

type
  TBwdlstDat=class(TComponent)
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
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetCtpNam:Str30;            procedure SetCtpNam(pValue:Str30);
    function GetCtpTel:Str20;            procedure SetCtpTel(pValue:Str20);
    function GetCtpEml:Str30;            procedure SetCtpEml(pValue:Str30);
    function GetProBva:double;           procedure SetProBva(pValue:double);
    function GetBwrAva:double;           procedure SetBwrAva(pValue:double);
    function GetBwrBva:double;           procedure SetBwrBva(pValue:double);
    function GetCauVal:double;           procedure SetCauVal(pValue:double);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetOutQnt:word;             procedure SetOutQnt(pValue:word);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetTcdNum:Str13;            procedure SetTcdNum(pValue:Str13);
    function GetPrnCnt:byte;             procedure SetPrnCnt(pValue:byte);
    function GetPrnUsr:Str15;            procedure SetPrnUsr(pValue:Str15);
    function GetPrnDte:TDatetime;        procedure SetPrnDte(pValue:TDatetime);
    function GetPrnTim:TDatetime;        procedure SetPrnTim(pValue:TDatetime);
    function GetDocDes:Str100;           procedure SetDocDes(pValue:Str100);
    function GetWarNum:byte;             procedure SetWarNum(pValue:byte);
    function GetWarDte:TDatetime;        procedure SetWarDte(pValue:TDatetime);
    function GetEdiUsr:Str15;            procedure SetEdiUsr(pValue:Str15);
    function GetEdiDte:TDatetime;        procedure SetEdiDte(pValue:TDatetime);
    function GetEdiTim:TDatetime;        procedure SetEdiTim(pValue:TDatetime);
    function GetCrtUsr:Str15;            procedure SetCrtUsr(pValue:Str15);
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
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocEdiUsr(pEdiUsr:Str15):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearEdiUsr(pEdiUsr:Str15):boolean;

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
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property CtpNam:Str30 read GetCtpNam write SetCtpNam;
    property CtpTel:Str20 read GetCtpTel write SetCtpTel;
    property CtpEml:Str30 read GetCtpEml write SetCtpEml;
    property ProBva:double read GetProBva write SetProBva;
    property BwrAva:double read GetBwrAva write SetBwrAva;
    property BwrBva:double read GetBwrBva write SetBwrBva;
    property CauVal:double read GetCauVal write SetCauVal;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property ItmNum:word read GetItmNum write SetItmNum;
    property TcdNum:Str13 read GetTcdNum write SetTcdNum;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property PrnUsr:Str15 read GetPrnUsr write SetPrnUsr;
    property PrnDte:TDatetime read GetPrnDte write SetPrnDte;
    property PrnTim:TDatetime read GetPrnTim write SetPrnTim;
    property DocDes:Str100 read GetDocDes write SetDocDes;
    property WarNum:byte read GetWarNum write SetWarNum;
    property WarDte:TDatetime read GetWarDte write SetWarDte;
    property EdiUsr:Str15 read GetEdiUsr write SetEdiUsr;
    property EdiDte:TDatetime read GetEdiDte write SetEdiDte;
    property EdiTim:TDatetime read GetEdiTim write SetEdiTim;
    property CrtUsr:Str15 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TBwdlstDat.Create;
begin
  oTable:=DatInit('BWDLST',gPath.StkPath,Self);
end;

constructor TBwdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BWDLST',pPath,Self);
end;

destructor TBwdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBwdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBwdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBwdlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TBwdlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBwdlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TBwdlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TBwdlstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TBwdlstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TBwdlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TBwdlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBwdlstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TBwdlstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TBwdlstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TBwdlstDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TBwdlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBwdlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TBwdlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TBwdlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TBwdlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TBwdlstDat.GetCtpNam:Str30;
begin
  Result:=oTable.FieldByName('CtpNam').AsString;
end;

procedure TBwdlstDat.SetCtpNam(pValue:Str30);
begin
  oTable.FieldByName('CtpNam').AsString:=pValue;
end;

function TBwdlstDat.GetCtpTel:Str20;
begin
  Result:=oTable.FieldByName('CtpTel').AsString;
end;

procedure TBwdlstDat.SetCtpTel(pValue:Str20);
begin
  oTable.FieldByName('CtpTel').AsString:=pValue;
end;

function TBwdlstDat.GetCtpEml:Str30;
begin
  Result:=oTable.FieldByName('CtpEml').AsString;
end;

procedure TBwdlstDat.SetCtpEml(pValue:Str30);
begin
  oTable.FieldByName('CtpEml').AsString:=pValue;
end;

function TBwdlstDat.GetProBva:double;
begin
  Result:=oTable.FieldByName('ProBva').AsFloat;
end;

procedure TBwdlstDat.SetProBva(pValue:double);
begin
  oTable.FieldByName('ProBva').AsFloat:=pValue;
end;

function TBwdlstDat.GetBwrAva:double;
begin
  Result:=oTable.FieldByName('BwrAva').AsFloat;
end;

procedure TBwdlstDat.SetBwrAva(pValue:double);
begin
  oTable.FieldByName('BwrAva').AsFloat:=pValue;
end;

function TBwdlstDat.GetBwrBva:double;
begin
  Result:=oTable.FieldByName('BwrBva').AsFloat;
end;

procedure TBwdlstDat.SetBwrBva(pValue:double);
begin
  oTable.FieldByName('BwrBva').AsFloat:=pValue;
end;

function TBwdlstDat.GetCauVal:double;
begin
  Result:=oTable.FieldByName('CauVal').AsFloat;
end;

procedure TBwdlstDat.SetCauVal(pValue:double);
begin
  oTable.FieldByName('CauVal').AsFloat:=pValue;
end;

function TBwdlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TBwdlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TBwdlstDat.GetOutQnt:word;
begin
  Result:=oTable.FieldByName('OutQnt').AsInteger;
end;

procedure TBwdlstDat.SetOutQnt(pValue:word);
begin
  oTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TBwdlstDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBwdlstDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBwdlstDat.GetTcdNum:Str13;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TBwdlstDat.SetTcdNum(pValue:Str13);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TBwdlstDat.GetPrnCnt:byte;
begin
  Result:=oTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TBwdlstDat.SetPrnCnt(pValue:byte);
begin
  oTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TBwdlstDat.GetPrnUsr:Str15;
begin
  Result:=oTable.FieldByName('PrnUsr').AsString;
end;

procedure TBwdlstDat.SetPrnUsr(pValue:Str15);
begin
  oTable.FieldByName('PrnUsr').AsString:=pValue;
end;

function TBwdlstDat.GetPrnDte:TDatetime;
begin
  Result:=oTable.FieldByName('PrnDte').AsDateTime;
end;

procedure TBwdlstDat.SetPrnDte(pValue:TDatetime);
begin
  oTable.FieldByName('PrnDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetPrnTim:TDatetime;
begin
  Result:=oTable.FieldByName('PrnTim').AsDateTime;
end;

procedure TBwdlstDat.SetPrnTim(pValue:TDatetime);
begin
  oTable.FieldByName('PrnTim').AsDateTime:=pValue;
end;

function TBwdlstDat.GetDocDes:Str100;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TBwdlstDat.SetDocDes(pValue:Str100);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TBwdlstDat.GetWarNum:byte;
begin
  Result:=oTable.FieldByName('WarNum').AsInteger;
end;

procedure TBwdlstDat.SetWarNum(pValue:byte);
begin
  oTable.FieldByName('WarNum').AsInteger:=pValue;
end;

function TBwdlstDat.GetWarDte:TDatetime;
begin
  Result:=oTable.FieldByName('WarDte').AsDateTime;
end;

procedure TBwdlstDat.SetWarDte(pValue:TDatetime);
begin
  oTable.FieldByName('WarDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetEdiUsr:Str15;
begin
  Result:=oTable.FieldByName('EdiUsr').AsString;
end;

procedure TBwdlstDat.SetEdiUsr(pValue:Str15);
begin
  oTable.FieldByName('EdiUsr').AsString:=pValue;
end;

function TBwdlstDat.GetEdiDte:TDatetime;
begin
  Result:=oTable.FieldByName('EdiDte').AsDateTime;
end;

procedure TBwdlstDat.SetEdiDte(pValue:TDatetime);
begin
  oTable.FieldByName('EdiDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetEdiTim:TDatetime;
begin
  Result:=oTable.FieldByName('EdiTim').AsDateTime;
end;

procedure TBwdlstDat.SetEdiTim(pValue:TDatetime);
begin
  oTable.FieldByName('EdiTim').AsDateTime:=pValue;
end;

function TBwdlstDat.GetCrtUsr:Str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBwdlstDat.SetCrtUsr(pValue:Str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBwdlstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TBwdlstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBwdlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBwdlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBwdlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBwdlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBwdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBwdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBwdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBwdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBwdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBwdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBwdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBwdlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TBwdlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TBwdlstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TBwdlstDat.LocDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindKey([pDocYer,pBokNum,pSerNum]);
end;

function TBwdlstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TBwdlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TBwdlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TBwdlstDat.LocEdiUsr(pEdiUsr:Str15):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindKey([pEdiUsr]);
end;

function TBwdlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TBwdlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TBwdlstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TBwdlstDat.NearDyBnSn(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):boolean;
begin
  SetIndex(ixDyBnSn);
  Result:=oTable.FindNearest([pDocYer,pBokNum,pSerNum]);
end;

function TBwdlstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TBwdlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TBwdlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TBwdlstDat.NearEdiUsr(pEdiUsr:Str15):boolean;
begin
  SetIndex(ixEdiUsr);
  Result:=oTable.FindNearest([pEdiUsr]);
end;

procedure TBwdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBwdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBwdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBwdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TBwdlstDat.Next;
begin
  oTable.Next;
end;

procedure TBwdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBwdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBwdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBwdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TBwdlstDat.Post;
begin
  oTable.Post;
end;

procedure TBwdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TBwdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBwdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBwdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBwdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBwdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBwdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
