unit dOTPOCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnOn='DnOn';
  ixDnOdOi='DnOdOi';
  ixProNum='ProNum';
  ixProNam='ProNam';

type
  TOtpociDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetOcdNum:Str12;            procedure SetOcdNum(pValue:Str12);
    function GetOciNum:word;             procedure SetOciNum(pValue:word);
    function GetOciAdr:longint;          procedure SetOciAdr(pValue:longint);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetReqDte:TDatetime;        procedure SetReqDte(pValue:TDatetime);
    function GetSalPrq:double;           procedure SetSalPrq(pValue:double);
    function GetTcdPrq:double;           procedure SetTcdPrq(pValue:double);
    function GetUndPrq:double;           procedure SetUndPrq(pValue:double);
    function GetRatDte1:TDatetime;       procedure SetRatDte1(pValue:TDatetime);
    function GetReqPrq1:double;          procedure SetReqPrq1(pValue:double);
    function GetRstPrq1:double;          procedure SetRstPrq1(pValue:double);
    function GetRosPrq1:double;          procedure SetRosPrq1(pValue:double);
    function GetRatDte2:TDatetime;       procedure SetRatDte2(pValue:TDatetime);
    function GetReqPrq2:double;          procedure SetReqPrq2(pValue:double);
    function GetRstPrq2:double;          procedure SetRstPrq2(pValue:double);
    function GetRosPrq2:double;          procedure SetRosPrq2(pValue:double);
    function GetNotice:Str60;            procedure SetNotice(pValue:Str60);
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
    function LocDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
    function LocDnOdOi(pDocNum:Str12;pOcdNum:Str12;pOciNum:word):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
    function NearDnOdOi(pDocNum:Str12;pOcdNum:Str12;pOciNum:word):boolean;
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
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OciNum:word read GetOciNum write SetOciNum;
    property OciAdr:longint read GetOciAdr write SetOciAdr;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property TcdPrq:double read GetTcdPrq write SetTcdPrq;
    property UndPrq:double read GetUndPrq write SetUndPrq;
    property RatDte1:TDatetime read GetRatDte1 write SetRatDte1;
    property ReqPrq1:double read GetReqPrq1 write SetReqPrq1;
    property RstPrq1:double read GetRstPrq1 write SetRstPrq1;
    property RosPrq1:double read GetRosPrq1 write SetRosPrq1;
    property RatDte2:TDatetime read GetRatDte2 write SetRatDte2;
    property ReqPrq2:double read GetReqPrq2 write SetReqPrq2;
    property RstPrq2:double read GetRstPrq2 write SetRstPrq2;
    property RosPrq2:double read GetRosPrq2 write SetRosPrq2;
    property Notice:Str60 read GetNotice write SetNotice;
  end;

implementation

constructor TOtpociDat.Create;
begin
  oTable:=DatInit('OTPOCI',gPath.StkPath,Self);
end;

constructor TOtpociDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OTPOCI',pPath,Self);
end;

destructor TOtpociDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOtpociDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOtpociDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOtpociDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOtpociDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOtpociDat.GetOcdNum:Str12;
begin
  Result:=oTable.FieldByName('OcdNum').AsString;
end;

procedure TOtpociDat.SetOcdNum(pValue:Str12);
begin
  oTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TOtpociDat.GetOciNum:word;
begin
  Result:=oTable.FieldByName('OciNum').AsInteger;
end;

procedure TOtpociDat.SetOciNum(pValue:word);
begin
  oTable.FieldByName('OciNum').AsInteger:=pValue;
end;

function TOtpociDat.GetOciAdr:longint;
begin
  Result:=oTable.FieldByName('OciAdr').AsInteger;
end;

procedure TOtpociDat.SetOciAdr(pValue:longint);
begin
  oTable.FieldByName('OciAdr').AsInteger:=pValue;
end;

function TOtpociDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOtpociDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOtpociDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOtpociDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOtpociDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOtpociDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOtpociDat.GetReqDte:TDatetime;
begin
  Result:=oTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOtpociDat.SetReqDte(pValue:TDatetime);
begin
  oTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOtpociDat.GetSalPrq:double;
begin
  Result:=oTable.FieldByName('SalPrq').AsFloat;
end;

procedure TOtpociDat.SetSalPrq(pValue:double);
begin
  oTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TOtpociDat.GetTcdPrq:double;
begin
  Result:=oTable.FieldByName('TcdPrq').AsFloat;
end;

procedure TOtpociDat.SetTcdPrq(pValue:double);
begin
  oTable.FieldByName('TcdPrq').AsFloat:=pValue;
end;

function TOtpociDat.GetUndPrq:double;
begin
  Result:=oTable.FieldByName('UndPrq').AsFloat;
end;

procedure TOtpociDat.SetUndPrq(pValue:double);
begin
  oTable.FieldByName('UndPrq').AsFloat:=pValue;
end;

function TOtpociDat.GetRatDte1:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte1').AsDateTime;
end;

procedure TOtpociDat.SetRatDte1(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte1').AsDateTime:=pValue;
end;

function TOtpociDat.GetReqPrq1:double;
begin
  Result:=oTable.FieldByName('ReqPrq1').AsFloat;
end;

procedure TOtpociDat.SetReqPrq1(pValue:double);
begin
  oTable.FieldByName('ReqPrq1').AsFloat:=pValue;
end;

function TOtpociDat.GetRstPrq1:double;
begin
  Result:=oTable.FieldByName('RstPrq1').AsFloat;
end;

procedure TOtpociDat.SetRstPrq1(pValue:double);
begin
  oTable.FieldByName('RstPrq1').AsFloat:=pValue;
end;

function TOtpociDat.GetRosPrq1:double;
begin
  Result:=oTable.FieldByName('RosPrq1').AsFloat;
end;

procedure TOtpociDat.SetRosPrq1(pValue:double);
begin
  oTable.FieldByName('RosPrq1').AsFloat:=pValue;
end;

function TOtpociDat.GetRatDte2:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte2').AsDateTime;
end;

procedure TOtpociDat.SetRatDte2(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte2').AsDateTime:=pValue;
end;

function TOtpociDat.GetReqPrq2:double;
begin
  Result:=oTable.FieldByName('ReqPrq2').AsFloat;
end;

procedure TOtpociDat.SetReqPrq2(pValue:double);
begin
  oTable.FieldByName('ReqPrq2').AsFloat:=pValue;
end;

function TOtpociDat.GetRstPrq2:double;
begin
  Result:=oTable.FieldByName('RstPrq2').AsFloat;
end;

procedure TOtpociDat.SetRstPrq2(pValue:double);
begin
  oTable.FieldByName('RstPrq2').AsFloat:=pValue;
end;

function TOtpociDat.GetRosPrq2:double;
begin
  Result:=oTable.FieldByName('RosPrq2').AsFloat;
end;

procedure TOtpociDat.SetRosPrq2(pValue:double);
begin
  oTable.FieldByName('RosPrq2').AsFloat:=pValue;
end;

function TOtpociDat.GetNotice:Str60;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TOtpociDat.SetNotice(pValue:Str60);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOtpociDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOtpociDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOtpociDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOtpociDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOtpociDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOtpociDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOtpociDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOtpociDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOtpociDat.LocDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
begin
  SetIndex(ixDnOn);
  Result:=oTable.FindKey([pDocNum,pOcdNum]);
end;

function TOtpociDat.LocDnOdOi(pDocNum:Str12;pOcdNum:Str12;pOciNum:word):boolean;
begin
  SetIndex(ixDnOdOi);
  Result:=oTable.FindKey([pDocNum,pOcdNum,pOciNum]);
end;

function TOtpociDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TOtpociDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TOtpociDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOtpociDat.NearDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
begin
  SetIndex(ixDnOn);
  Result:=oTable.FindNearest([pDocNum,pOcdNum]);
end;

function TOtpociDat.NearDnOdOi(pDocNum:Str12;pOcdNum:Str12;pOciNum:word):boolean;
begin
  SetIndex(ixDnOdOi);
  Result:=oTable.FindNearest([pDocNum,pOcdNum,pOciNum]);
end;

function TOtpociDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TOtpociDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

procedure TOtpociDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOtpociDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOtpociDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOtpociDat.Prior;
begin
  oTable.Prior;
end;

procedure TOtpociDat.Next;
begin
  oTable.Next;
end;

procedure TOtpociDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOtpociDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOtpociDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOtpociDat.Edit;
begin
  oTable.Edit;
end;

procedure TOtpociDat.Post;
begin
  oTable.Post;
end;

procedure TOtpociDat.Delete;
begin
  oTable.Delete;
end;

procedure TOtpociDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOtpociDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOtpociDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOtpociDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOtpociDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOtpociDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
