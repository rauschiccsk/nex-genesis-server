unit dOTPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDySn='DySn';
  ixDocDte='DocDte';
  ixParNum='ParNum';
  ixDocDes='DocDes';
  ixOsdNum='OsdNum';
  ixParNam='ParNam';

type
  TOtplstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum(pValue:longint);
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetDocDes:Str100;           procedure SetDocDes(pValue:Str100);
    function GetDocDes_:Str100;          procedure SetDocDes_(pValue:Str100);
    function GetOsdNum:Str12;            procedure SetOsdNum(pValue:Str12);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetOcdQnt:word;             procedure SetOcdQnt(pValue:word);
    function GetOcdPrq:double;           procedure SetOcdPrq(pValue:double);
    function GetOcdAva:double;           procedure SetOcdAva(pValue:double);
    function GetEqpDst:Str1;             procedure SetEqpDst(pValue:Str1);
    function GetEqpDte:TDatetime;        procedure SetEqpDte(pValue:TDatetime);
    function GetEqpTim:TDatetime;        procedure SetEqpTim(pValue:TDatetime);
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
    function LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocDocDes(pDocDes_:Str100):boolean;
    function LocOsdNum(pOsdNum:Str12):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearDocDes(pDocDes_:Str100):boolean;
    function NearOsdNum(pOsdNum:Str12):boolean;
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
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property SerNum:longint read GetSerNum write SetSerNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property DocDes:Str100 read GetDocDes write SetDocDes;
    property DocDes_:Str100 read GetDocDes_ write SetDocDes_;
    property OsdNum:Str12 read GetOsdNum write SetOsdNum;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property OcdQnt:word read GetOcdQnt write SetOcdQnt;
    property OcdPrq:double read GetOcdPrq write SetOcdPrq;
    property OcdAva:double read GetOcdAva write SetOcdAva;
    property EqpDst:Str1 read GetEqpDst write SetEqpDst;
    property EqpDte:TDatetime read GetEqpDte write SetEqpDte;
    property EqpTim:TDatetime read GetEqpTim write SetEqpTim;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TOtplstDat.Create;
begin
  oTable:=DatInit('OTPLST',gPath.StkPath,Self);
end;

constructor TOtplstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OTPLST',pPath,Self);
end;

destructor TOtplstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOtplstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOtplstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOtplstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TOtplstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TOtplstDat.GetSerNum:longint;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TOtplstDat.SetSerNum(pValue:longint);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TOtplstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOtplstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOtplstDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TOtplstDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TOtplstDat.GetDocDes:Str100;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TOtplstDat.SetDocDes(pValue:Str100);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TOtplstDat.GetDocDes_:Str100;
begin
  Result:=oTable.FieldByName('DocDes_').AsString;
end;

procedure TOtplstDat.SetDocDes_(pValue:Str100);
begin
  oTable.FieldByName('DocDes_').AsString:=pValue;
end;

function TOtplstDat.GetOsdNum:Str12;
begin
  Result:=oTable.FieldByName('OsdNum').AsString;
end;

procedure TOtplstDat.SetOsdNum(pValue:Str12);
begin
  oTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOtplstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TOtplstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TOtplstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TOtplstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TOtplstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TOtplstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TOtplstDat.GetOcdQnt:word;
begin
  Result:=oTable.FieldByName('OcdQnt').AsInteger;
end;

procedure TOtplstDat.SetOcdQnt(pValue:word);
begin
  oTable.FieldByName('OcdQnt').AsInteger:=pValue;
end;

function TOtplstDat.GetOcdPrq:double;
begin
  Result:=oTable.FieldByName('OcdPrq').AsFloat;
end;

procedure TOtplstDat.SetOcdPrq(pValue:double);
begin
  oTable.FieldByName('OcdPrq').AsFloat:=pValue;
end;

function TOtplstDat.GetOcdAva:double;
begin
  Result:=oTable.FieldByName('OcdAva').AsFloat;
end;

procedure TOtplstDat.SetOcdAva(pValue:double);
begin
  oTable.FieldByName('OcdAva').AsFloat:=pValue;
end;

function TOtplstDat.GetEqpDst:Str1;
begin
  Result:=oTable.FieldByName('EqpDst').AsString;
end;

procedure TOtplstDat.SetEqpDst(pValue:Str1);
begin
  oTable.FieldByName('EqpDst').AsString:=pValue;
end;

function TOtplstDat.GetEqpDte:TDatetime;
begin
  Result:=oTable.FieldByName('EqpDte').AsDateTime;
end;

procedure TOtplstDat.SetEqpDte(pValue:TDatetime);
begin
  oTable.FieldByName('EqpDte').AsDateTime:=pValue;
end;

function TOtplstDat.GetEqpTim:TDatetime;
begin
  Result:=oTable.FieldByName('EqpTim').AsDateTime;
end;

procedure TOtplstDat.SetEqpTim(pValue:TDatetime);
begin
  oTable.FieldByName('EqpTim').AsDateTime:=pValue;
end;

function TOtplstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TOtplstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TOtplstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TOtplstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TOtplstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOtplstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOtplstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOtplstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOtplstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOtplstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOtplstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOtplstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOtplstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOtplstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TOtplstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOtplstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOtplstDat.LocDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TOtplstDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TOtplstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TOtplstDat.LocDocDes(pDocDes_:Str100):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindKey([StrToAlias(pDocDes_)]);
end;

function TOtplstDat.LocOsdNum(pOsdNum:Str12):boolean;
begin
  SetIndex(ixOsdNum);
  Result:=oTable.FindKey([pOsdNum]);
end;

function TOtplstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TOtplstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOtplstDat.NearDySn(pDocYer:Str2;pSerNum:longint):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

function TOtplstDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TOtplstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TOtplstDat.NearDocDes(pDocDes_:Str100):boolean;
begin
  SetIndex(ixDocDes);
  Result:=oTable.FindNearest([pDocDes_]);
end;

function TOtplstDat.NearOsdNum(pOsdNum:Str12):boolean;
begin
  SetIndex(ixOsdNum);
  Result:=oTable.FindNearest([pOsdNum]);
end;

function TOtplstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TOtplstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOtplstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOtplstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOtplstDat.Prior;
begin
  oTable.Prior;
end;

procedure TOtplstDat.Next;
begin
  oTable.Next;
end;

procedure TOtplstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOtplstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOtplstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOtplstDat.Edit;
begin
  oTable.Edit;
end;

procedure TOtplstDat.Post;
begin
  oTable.Post;
end;

procedure TOtplstDat.Delete;
begin
  oTable.Delete;
end;

procedure TOtplstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOtplstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOtplstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOtplstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOtplstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOtplstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
