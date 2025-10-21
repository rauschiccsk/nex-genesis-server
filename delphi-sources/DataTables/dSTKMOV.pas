unit dSTKMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum='StkNum';
  ixSnPn='SnPn';
  ixSnSm='SnSm';
  ixStmNum='StmNum';
  ixProNum='ProNum';
  ixPgrNum='PgrNum';

type
  TStkmovDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetStkNum:word;             procedure SetStkNum(pValue:word);
    function GetStmNum:longint;          procedure SetStmNum(pValue:longint);
    function GetSmcNum:longint;          procedure SetSmcNum(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum(pValue:longint);
    function GetPgrNum:word;             procedure SetPgrNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetMovPrq:double;           procedure SetMovPrq(pValue:double);
    function GetMovCva:double;           procedure SetMovCva(pValue:double);
    function GetSalAva:double;           procedure SetSalAva(pValue:double);
    function GetFifNum:longint;          procedure SetFifNum(pValue:longint);
    function GetBpaNum:longint;          procedure SetBpaNum(pValue:longint);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetIncTyp:Str1;             procedure SetIncTyp(pValue:Str1);
    function GetBegSta:Str1;             procedure SetBegSta(pValue:Str1);
    function GetRbaCod:Str30;            procedure SetRbaCod(pValue:Str30);
    function GetRbaDte:TDatetime;        procedure SetRbaDte(pValue:TDatetime);
    function GetRmiStn:word;             procedure SetRmiStn(pValue:word);
    function GetRmoStn:word;             procedure SetRmoStn(pValue:word);
    function GetCrtUsr:str10;            procedure SetCrtUsr(pValue:str10);
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
    function LocStkNum(pStkNum:word):boolean;
    function LocSnPn(pStkNum:word;pProNum:longint):boolean;
    function LocSnSm(pStkNum:word;pSmcNum:longint):boolean;
    function LocStmNum(pStmNum:longint):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocPgrNum(pPgrNum:word):boolean;
    function NearStkNum(pStkNum:word):boolean;
    function NearSnPn(pStkNum:word;pProNum:longint):boolean;
    function NearSnSm(pStkNum:word;pSmcNum:longint):boolean;
    function NearStmNum(pStmNum:longint):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearPgrNum(pPgrNum:word):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property StmNum:longint read GetStmNum write SetStmNum;
    property SmcNum:longint read GetSmcNum write SetSmcNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property ProNum:longint read GetProNum write SetProNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property MovCva:double read GetMovCva write SetMovCva;
    property SalAva:double read GetSalAva write SetSalAva;
    property FifNum:longint read GetFifNum write SetFifNum;
    property BpaNum:longint read GetBpaNum write SetBpaNum;
    property ParNum:longint read GetParNum write SetParNum;
    property IncTyp:Str1 read GetIncTyp write SetIncTyp;
    property BegSta:Str1 read GetBegSta write SetBegSta;
    property RbaCod:Str30 read GetRbaCod write SetRbaCod;
    property RbaDte:TDatetime read GetRbaDte write SetRbaDte;
    property RmiStn:word read GetRmiStn write SetRmiStn;
    property RmoStn:word read GetRmoStn write SetRmoStn;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TStkmovDat.Create;
begin
  oTable:=DatInit('STKMOV',gPath.StkPath,Self);
end;

constructor TStkmovDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('STKMOV',pPath,Self);
end;

destructor TStkmovDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TStkmovDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TStkmovDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TStkmovDat.GetStkNum:word;
begin
  Result:=oTable.FieldByName('StkNum').AsInteger;
end;

procedure TStkmovDat.SetStkNum(pValue:word);
begin
  oTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TStkmovDat.GetStmNum:longint;
begin
  Result:=oTable.FieldByName('StmNum').AsInteger;
end;

procedure TStkmovDat.SetStmNum(pValue:longint);
begin
  oTable.FieldByName('StmNum').AsInteger:=pValue;
end;

function TStkmovDat.GetSmcNum:longint;
begin
  Result:=oTable.FieldByName('SmcNum').AsInteger;
end;

procedure TStkmovDat.SetSmcNum(pValue:longint);
begin
  oTable.FieldByName('SmcNum').AsInteger:=pValue;
end;

function TStkmovDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TStkmovDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkmovDat.GetItmNum:longint;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkmovDat.SetItmNum(pValue:longint);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkmovDat.GetPgrNum:word;
begin
  Result:=oTable.FieldByName('PgrNum').AsInteger;
end;

procedure TStkmovDat.SetPgrNum(pValue:word);
begin
  oTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TStkmovDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TStkmovDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TStkmovDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TStkmovDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TStkmovDat.GetMovPrq:double;
begin
  Result:=oTable.FieldByName('MovPrq').AsFloat;
end;

procedure TStkmovDat.SetMovPrq(pValue:double);
begin
  oTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TStkmovDat.GetMovCva:double;
begin
  Result:=oTable.FieldByName('MovCva').AsFloat;
end;

procedure TStkmovDat.SetMovCva(pValue:double);
begin
  oTable.FieldByName('MovCva').AsFloat:=pValue;
end;

function TStkmovDat.GetSalAva:double;
begin
  Result:=oTable.FieldByName('SalAva').AsFloat;
end;

procedure TStkmovDat.SetSalAva(pValue:double);
begin
  oTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TStkmovDat.GetFifNum:longint;
begin
  Result:=oTable.FieldByName('FifNum').AsInteger;
end;

procedure TStkmovDat.SetFifNum(pValue:longint);
begin
  oTable.FieldByName('FifNum').AsInteger:=pValue;
end;

function TStkmovDat.GetBpaNum:longint;
begin
  Result:=oTable.FieldByName('BpaNum').AsInteger;
end;

procedure TStkmovDat.SetBpaNum(pValue:longint);
begin
  oTable.FieldByName('BpaNum').AsInteger:=pValue;
end;

function TStkmovDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TStkmovDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TStkmovDat.GetIncTyp:Str1;
begin
  Result:=oTable.FieldByName('IncTyp').AsString;
end;

procedure TStkmovDat.SetIncTyp(pValue:Str1);
begin
  oTable.FieldByName('IncTyp').AsString:=pValue;
end;

function TStkmovDat.GetBegSta:Str1;
begin
  Result:=oTable.FieldByName('BegSta').AsString;
end;

procedure TStkmovDat.SetBegSta(pValue:Str1);
begin
  oTable.FieldByName('BegSta').AsString:=pValue;
end;

function TStkmovDat.GetRbaCod:Str30;
begin
  Result:=oTable.FieldByName('RbaCod').AsString;
end;

procedure TStkmovDat.SetRbaCod(pValue:Str30);
begin
  oTable.FieldByName('RbaCod').AsString:=pValue;
end;

function TStkmovDat.GetRbaDte:TDatetime;
begin
  Result:=oTable.FieldByName('RbaDte').AsDateTime;
end;

procedure TStkmovDat.SetRbaDte(pValue:TDatetime);
begin
  oTable.FieldByName('RbaDte').AsDateTime:=pValue;
end;

function TStkmovDat.GetRmiStn:word;
begin
  Result:=oTable.FieldByName('RmiStn').AsInteger;
end;

procedure TStkmovDat.SetRmiStn(pValue:word);
begin
  oTable.FieldByName('RmiStn').AsInteger:=pValue;
end;

function TStkmovDat.GetRmoStn:word;
begin
  Result:=oTable.FieldByName('RmoStn').AsInteger;
end;

procedure TStkmovDat.SetRmoStn(pValue:word);
begin
  oTable.FieldByName('RmoStn').AsInteger:=pValue;
end;

function TStkmovDat.GetCrtUsr:str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkmovDat.SetCrtUsr(pValue:str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkmovDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkmovDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkmovDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkmovDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkmovDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TStkmovDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TStkmovDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TStkmovDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TStkmovDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TStkmovDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TStkmovDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TStkmovDat.LocStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindKey([pStkNum]);
end;

function TStkmovDat.LocSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindKey([pStkNum,pProNum]);
end;

function TStkmovDat.LocSnSm(pStkNum:word;pSmcNum:longint):boolean;
begin
  SetIndex(ixSnSm);
  Result:=oTable.FindKey([pStkNum,pSmcNum]);
end;

function TStkmovDat.LocStmNum(pStmNum:longint):boolean;
begin
  SetIndex(ixStmNum);
  Result:=oTable.FindKey([pStmNum]);
end;

function TStkmovDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TStkmovDat.LocPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindKey([pPgrNum]);
end;

function TStkmovDat.NearStkNum(pStkNum:word):boolean;
begin
  SetIndex(ixStkNum);
  Result:=oTable.FindNearest([pStkNum]);
end;

function TStkmovDat.NearSnPn(pStkNum:word;pProNum:longint):boolean;
begin
  SetIndex(ixSnPn);
  Result:=oTable.FindNearest([pStkNum,pProNum]);
end;

function TStkmovDat.NearSnSm(pStkNum:word;pSmcNum:longint):boolean;
begin
  SetIndex(ixSnSm);
  Result:=oTable.FindNearest([pStkNum,pSmcNum]);
end;

function TStkmovDat.NearStmNum(pStmNum:longint):boolean;
begin
  SetIndex(ixStmNum);
  Result:=oTable.FindNearest([pStmNum]);
end;

function TStkmovDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TStkmovDat.NearPgrNum(pPgrNum:word):boolean;
begin
  SetIndex(ixPgrNum);
  Result:=oTable.FindNearest([pPgrNum]);
end;

procedure TStkmovDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TStkmovDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TStkmovDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TStkmovDat.Prior;
begin
  oTable.Prior;
end;

procedure TStkmovDat.Next;
begin
  oTable.Next;
end;

procedure TStkmovDat.First;
begin
  Open;
  oTable.First;
end;

procedure TStkmovDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TStkmovDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TStkmovDat.Edit;
begin
  oTable.Edit;
end;

procedure TStkmovDat.Post;
begin
  oTable.Post;
end;

procedure TStkmovDat.Delete;
begin
  oTable.Delete;
end;

procedure TStkmovDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TStkmovDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TStkmovDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TStkmovDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TStkmovDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TStkmovDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
