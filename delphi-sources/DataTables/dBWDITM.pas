unit dBWDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='DnIn';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixProNum='ProNum';
  ixProNam='ProNam';

type
  TBwditmDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetProSer:Str20;            procedure SetProSer(pValue:Str20);
    function GetProBva:double;           procedure SetProBva(pValue:double);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetRetDte:TDatetime;        procedure SetRetDte(pValue:TDatetime);
    function GetDayQnt:word;             procedure SetDayQnt(pValue:word);
    function GetBrwBpc:double;           procedure SetBrwBpc(pValue:double);
    function GetBrwBva:double;           procedure SetBrwBva(pValue:double);
    function GetCauVal:double;           procedure SetCauVal(pValue:double);
    function GetTcdNum:Str12;            procedure SetTcdNum(pValue:Str12);
    function GetTcdItm:word;             procedure SetTcdItm(pValue:word);
    function GetCrtUsr:str15;            procedure SetCrtUsr(pValue:str15);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetNotice:Str250;           procedure SetNotice(pValue:Str250);
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
    function LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function LocDocNum(pDocNum:Str12):boolean;
    function LocItmNum(pItmNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearItmNum(pItmNum:word):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;

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
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property ProSer:Str20 read GetProSer write SetProSer;
    property ProBva:double read GetProBva write SetProBva;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property RetDte:TDatetime read GetRetDte write SetRetDte;
    property DayQnt:word read GetDayQnt write SetDayQnt;
    property BrwBpc:double read GetBrwBpc write SetBrwBpc;
    property BrwBva:double read GetBrwBva write SetBrwBva;
    property CauVal:double read GetCauVal write SetCauVal;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TcdItm:word read GetTcdItm write SetTcdItm;
    property CrtUsr:str15 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ParNum:longint read GetParNum write SetParNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property Notice:Str250 read GetNotice write SetNotice;
  end;

implementation

constructor TBwditmDat.Create;
begin
  oTable:=DatInit('BWDITM',gPath.StkPath,Self);
end;

constructor TBwditmDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BWDITM',pPath,Self);
end;

destructor TBwditmDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBwditmDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBwditmDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBwditmDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TBwditmDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TBwditmDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TBwditmDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TBwditmDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TBwditmDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBwditmDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TBwditmDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TBwditmDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TBwditmDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TBwditmDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TBwditmDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TBwditmDat.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCod').AsString;
end;

procedure TBwditmDat.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCod').AsString:=pValue;
end;

function TBwditmDat.GetProSer:Str20;
begin
  Result:=oTable.FieldByName('ProSer').AsString;
end;

procedure TBwditmDat.SetProSer(pValue:Str20);
begin
  oTable.FieldByName('ProSer').AsString:=pValue;
end;

function TBwditmDat.GetProBva:double;
begin
  Result:=oTable.FieldByName('ProBva').AsFloat;
end;

procedure TBwditmDat.SetProBva(pValue:double);
begin
  oTable.FieldByName('ProBva').AsFloat:=pValue;
end;

function TBwditmDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TBwditmDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TBwditmDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TBwditmDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TBwditmDat.GetRetDte:TDatetime;
begin
  Result:=oTable.FieldByName('RetDte').AsDateTime;
end;

procedure TBwditmDat.SetRetDte(pValue:TDatetime);
begin
  oTable.FieldByName('RetDte').AsDateTime:=pValue;
end;

function TBwditmDat.GetDayQnt:word;
begin
  Result:=oTable.FieldByName('DayQnt').AsInteger;
end;

procedure TBwditmDat.SetDayQnt(pValue:word);
begin
  oTable.FieldByName('DayQnt').AsInteger:=pValue;
end;

function TBwditmDat.GetBrwBpc:double;
begin
  Result:=oTable.FieldByName('BrwBpc').AsFloat;
end;

procedure TBwditmDat.SetBrwBpc(pValue:double);
begin
  oTable.FieldByName('BrwBpc').AsFloat:=pValue;
end;

function TBwditmDat.GetBrwBva:double;
begin
  Result:=oTable.FieldByName('BrwBva').AsFloat;
end;

procedure TBwditmDat.SetBrwBva(pValue:double);
begin
  oTable.FieldByName('BrwBva').AsFloat:=pValue;
end;

function TBwditmDat.GetCauVal:double;
begin
  Result:=oTable.FieldByName('CauVal').AsFloat;
end;

procedure TBwditmDat.SetCauVal(pValue:double);
begin
  oTable.FieldByName('CauVal').AsFloat:=pValue;
end;

function TBwditmDat.GetTcdNum:Str12;
begin
  Result:=oTable.FieldByName('TcdNum').AsString;
end;

procedure TBwditmDat.SetTcdNum(pValue:Str12);
begin
  oTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TBwditmDat.GetTcdItm:word;
begin
  Result:=oTable.FieldByName('TcdItm').AsInteger;
end;

procedure TBwditmDat.SetTcdItm(pValue:word);
begin
  oTable.FieldByName('TcdItm').AsInteger:=pValue;
end;

function TBwditmDat.GetCrtUsr:str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBwditmDat.SetCrtUsr(pValue:str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBwditmDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBwditmDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBwditmDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBwditmDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TBwditmDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TBwditmDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TBwditmDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TBwditmDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TBwditmDat.GetNotice:Str250;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TBwditmDat.SetNotice(pValue:Str250);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBwditmDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBwditmDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBwditmDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBwditmDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBwditmDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBwditmDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBwditmDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBwditmDat.LocDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TBwditmDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TBwditmDat.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindKey([pItmNum]);
end;

function TBwditmDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TBwditmDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TBwditmDat.NearDnIn(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDnIn);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TBwditmDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TBwditmDat.NearItmNum(pItmNum:word):boolean;
begin
  SetIndex(ixItmNum);
  Result:=oTable.FindNearest([pItmNum]);
end;

function TBwditmDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TBwditmDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

procedure TBwditmDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBwditmDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBwditmDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBwditmDat.Prior;
begin
  oTable.Prior;
end;

procedure TBwditmDat.Next;
begin
  oTable.Next;
end;

procedure TBwditmDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBwditmDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBwditmDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBwditmDat.Edit;
begin
  oTable.Edit;
end;

procedure TBwditmDat.Post;
begin
  oTable.Post;
end;

procedure TBwditmDat.Delete;
begin
  oTable.Delete;
end;

procedure TBwditmDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBwditmDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBwditmDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBwditmDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBwditmDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBwditmDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
