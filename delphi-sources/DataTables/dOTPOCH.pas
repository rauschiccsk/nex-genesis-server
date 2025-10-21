unit dOTPOCH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnOn='DnOn';
  ixParNum='ParNum';
  ixParNam='ParNam';

type
  TOtpochDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetOcdNum:Str12;            procedure SetOcdNum(pValue:Str12);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetOcdItm:word;             procedure SetOcdItm(pValue:word);
    function GetOcdPrq:double;           procedure SetOcdPrq(pValue:double);
    function GetOcdAva:double;           procedure SetOcdAva(pValue:double);
    function GetEqpUsr:Str8;             procedure SetEqpUsr(pValue:Str8);
    function GetEqpUsn:Str30;            procedure SetEqpUsn(pValue:Str30);
    function GetEqpDst:Str1;             procedure SetEqpDst(pValue:Str1);
    function GetEqpDte:TDatetime;        procedure SetEqpDte(pValue:TDatetime);
    function GetEqpTim:TDatetime;        procedure SetEqpTim(pValue:TDatetime);
    function GetEqpDes:Str60;            procedure SetEqpDes(pValue:Str60);
    function GetEmlDte:TDatetime;        procedure SetEmlDte(pValue:TDatetime);
    function GetEmlTim:TDatetime;        procedure SetEmlTim(pValue:TDatetime);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
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
    function LocDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property OcdPrq:double read GetOcdPrq write SetOcdPrq;
    property OcdAva:double read GetOcdAva write SetOcdAva;
    property EqpUsr:Str8 read GetEqpUsr write SetEqpUsr;
    property EqpUsn:Str30 read GetEqpUsn write SetEqpUsn;
    property EqpDst:Str1 read GetEqpDst write SetEqpDst;
    property EqpDte:TDatetime read GetEqpDte write SetEqpDte;
    property EqpTim:TDatetime read GetEqpTim write SetEqpTim;
    property EqpDes:Str60 read GetEqpDes write SetEqpDes;
    property EmlDte:TDatetime read GetEmlDte write SetEmlDte;
    property EmlTim:TDatetime read GetEmlTim write SetEmlTim;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOtpochDat.Create;
begin
  oTable:=DatInit('OTPOCH',gPath.StkPath,Self);
end;

constructor TOtpochDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OTPOCH',pPath,Self);
end;

destructor TOtpochDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOtpochDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOtpochDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOtpochDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOtpochDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOtpochDat.GetOcdNum:Str12;
begin
  Result:=oTable.FieldByName('OcdNum').AsString;
end;

procedure TOtpochDat.SetOcdNum(pValue:Str12);
begin
  oTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TOtpochDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOtpochDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOtpochDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOtpochDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOtpochDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TOtpochDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOtpochDat.GetOcdItm:word;
begin
  Result:=oTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOtpochDat.SetOcdItm(pValue:word);
begin
  oTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TOtpochDat.GetOcdPrq:double;
begin
  Result:=oTable.FieldByName('OcdPrq').AsFloat;
end;

procedure TOtpochDat.SetOcdPrq(pValue:double);
begin
  oTable.FieldByName('OcdPrq').AsFloat:=pValue;
end;

function TOtpochDat.GetOcdAva:double;
begin
  Result:=oTable.FieldByName('OcdAva').AsFloat;
end;

procedure TOtpochDat.SetOcdAva(pValue:double);
begin
  oTable.FieldByName('OcdAva').AsFloat:=pValue;
end;

function TOtpochDat.GetEqpUsr:Str8;
begin
  Result:=oTable.FieldByName('EqpUsr').AsString;
end;

procedure TOtpochDat.SetEqpUsr(pValue:Str8);
begin
  oTable.FieldByName('EqpUsr').AsString:=pValue;
end;

function TOtpochDat.GetEqpUsn:Str30;
begin
  Result:=oTable.FieldByName('EqpUsn').AsString;
end;

procedure TOtpochDat.SetEqpUsn(pValue:Str30);
begin
  oTable.FieldByName('EqpUsn').AsString:=pValue;
end;

function TOtpochDat.GetEqpDst:Str1;
begin
  Result:=oTable.FieldByName('EqpDst').AsString;
end;

procedure TOtpochDat.SetEqpDst(pValue:Str1);
begin
  oTable.FieldByName('EqpDst').AsString:=pValue;
end;

function TOtpochDat.GetEqpDte:TDatetime;
begin
  Result:=oTable.FieldByName('EqpDte').AsDateTime;
end;

procedure TOtpochDat.SetEqpDte(pValue:TDatetime);
begin
  oTable.FieldByName('EqpDte').AsDateTime:=pValue;
end;

function TOtpochDat.GetEqpTim:TDatetime;
begin
  Result:=oTable.FieldByName('EqpTim').AsDateTime;
end;

procedure TOtpochDat.SetEqpTim(pValue:TDatetime);
begin
  oTable.FieldByName('EqpTim').AsDateTime:=pValue;
end;

function TOtpochDat.GetEqpDes:Str60;
begin
  Result:=oTable.FieldByName('EqpDes').AsString;
end;

procedure TOtpochDat.SetEqpDes(pValue:Str60);
begin
  oTable.FieldByName('EqpDes').AsString:=pValue;
end;

function TOtpochDat.GetEmlDte:TDatetime;
begin
  Result:=oTable.FieldByName('EmlDte').AsDateTime;
end;

procedure TOtpochDat.SetEmlDte(pValue:TDatetime);
begin
  oTable.FieldByName('EmlDte').AsDateTime:=pValue;
end;

function TOtpochDat.GetEmlTim:TDatetime;
begin
  Result:=oTable.FieldByName('EmlTim').AsDateTime;
end;

procedure TOtpochDat.SetEmlTim(pValue:TDatetime);
begin
  oTable.FieldByName('EmlTim').AsDateTime:=pValue;
end;

function TOtpochDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOtpochDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOtpochDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TOtpochDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOtpochDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOtpochDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOtpochDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOtpochDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOtpochDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOtpochDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOtpochDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOtpochDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOtpochDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOtpochDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOtpochDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOtpochDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOtpochDat.LocDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
begin
  SetIndex(ixDnOn);
  Result:=oTable.FindKey([pDocNum,pOcdNum]);
end;

function TOtpochDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOtpochDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TOtpochDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOtpochDat.NearDnOn(pDocNum:Str12;pOcdNum:Str12):boolean;
begin
  SetIndex(ixDnOn);
  Result:=oTable.FindNearest([pDocNum,pOcdNum]);
end;

function TOtpochDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOtpochDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TOtpochDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOtpochDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOtpochDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOtpochDat.Prior;
begin
  oTable.Prior;
end;

procedure TOtpochDat.Next;
begin
  oTable.Next;
end;

procedure TOtpochDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOtpochDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOtpochDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOtpochDat.Edit;
begin
  oTable.Edit;
end;

procedure TOtpochDat.Post;
begin
  oTable.Post;
end;

procedure TOtpochDat.Delete;
begin
  oTable.Delete;
end;

procedure TOtpochDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOtpochDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOtpochDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOtpochDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOtpochDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOtpochDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
