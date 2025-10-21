unit dOSRHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDoIt='DoIt';
  ixDnAs='DnAs';
  ixProNum='ProNum';
  ixProNam='ProNam';
  ixSndSta='SndSta';
  ixAcpSta='AcpSta';

type
  TOsrhisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum(pValue:word);
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_(pValue:Str60);
    function GetRatPrv:TDatetime;        procedure SetRatPrv(pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte(pValue:TDatetime);
    function GetRatNot:Str50;            procedure SetRatNot(pValue:Str50);
    function GetRatChg:byte;             procedure SetRatChg(pValue:byte);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSndSta:Str1;             procedure SetSndSta(pValue:Str1);
    function GetAcpSta:Str1;             procedure SetAcpSta(pValue:Str1);
    function GetAcpUsr:Str15;            procedure SetAcpUsr(pValue:Str15);
    function GetAcpUsn:Str30;            procedure SetAcpUsn(pValue:Str30);
    function GetAcpDte:TDatetime;        procedure SetAcpDte(pValue:TDatetime);
    function GetAcpTim:TDatetime;        procedure SetAcpTim(pValue:TDatetime);
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
    function LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function LocDnAs(pDocNum:Str12;pAcpSta:Str1):boolean;
    function LocProNum(pProNum:longint):boolean;
    function LocProNam(pProNam_:Str60):boolean;
    function LocSndSta(pSndSta:Str1):boolean;
    function LocAcpSta(pAcpSta:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
    function NearDnAs(pDocNum:Str12;pAcpSta:Str1):boolean;
    function NearProNum(pProNum:longint):boolean;
    function NearProNam(pProNam_:Str60):boolean;
    function NearSndSta(pSndSta:Str1):boolean;
    function NearAcpSta(pAcpSta:Str1):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property RatPrv:TDatetime read GetRatPrv write SetRatPrv;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property RatNot:Str50 read GetRatNot write SetRatNot;
    property RatChg:byte read GetRatChg write SetRatChg;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SndSta:Str1 read GetSndSta write SetSndSta;
    property AcpSta:Str1 read GetAcpSta write SetAcpSta;
    property AcpUsr:Str15 read GetAcpUsr write SetAcpUsr;
    property AcpUsn:Str30 read GetAcpUsn write SetAcpUsn;
    property AcpDte:TDatetime read GetAcpDte write SetAcpDte;
    property AcpTim:TDatetime read GetAcpTim write SetAcpTim;
  end;

implementation

constructor TOsrhisDat.Create;
begin
  oTable:=DatInit('OSRHIS',gPath.StkPath,Self);
end;

constructor TOsrhisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('OSRHIS',pPath,Self);
end;

destructor TOsrhisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TOsrhisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TOsrhisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TOsrhisDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TOsrhisDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TOsrhisDat.GetItmNum:word;
begin
  Result:=oTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsrhisDat.SetItmNum(pValue:word);
begin
  oTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TOsrhisDat.GetProNum:longint;
begin
  Result:=oTable.FieldByName('ProNum').AsInteger;
end;

procedure TOsrhisDat.SetProNum(pValue:longint);
begin
  oTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOsrhisDat.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('ProNam').AsString;
end;

procedure TOsrhisDat.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOsrhisDat.GetProNam_:Str60;
begin
  Result:=oTable.FieldByName('ProNam_').AsString;
end;

procedure TOsrhisDat.SetProNam_(pValue:Str60);
begin
  oTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOsrhisDat.GetRatPrv:TDatetime;
begin
  Result:=oTable.FieldByName('RatPrv').AsDateTime;
end;

procedure TOsrhisDat.SetRatPrv(pValue:TDatetime);
begin
  oTable.FieldByName('RatPrv').AsDateTime:=pValue;
end;

function TOsrhisDat.GetRatDte:TDatetime;
begin
  Result:=oTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOsrhisDat.SetRatDte(pValue:TDatetime);
begin
  oTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOsrhisDat.GetRatNot:Str50;
begin
  Result:=oTable.FieldByName('RatNot').AsString;
end;

procedure TOsrhisDat.SetRatNot(pValue:Str50);
begin
  oTable.FieldByName('RatNot').AsString:=pValue;
end;

function TOsrhisDat.GetRatChg:byte;
begin
  Result:=oTable.FieldByName('RatChg').AsInteger;
end;

procedure TOsrhisDat.SetRatChg(pValue:byte);
begin
  oTable.FieldByName('RatChg').AsInteger:=pValue;
end;

function TOsrhisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TOsrhisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TOsrhisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TOsrhisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TOsrhisDat.GetSndSta:Str1;
begin
  Result:=oTable.FieldByName('SndSta').AsString;
end;

procedure TOsrhisDat.SetSndSta(pValue:Str1);
begin
  oTable.FieldByName('SndSta').AsString:=pValue;
end;

function TOsrhisDat.GetAcpSta:Str1;
begin
  Result:=oTable.FieldByName('AcpSta').AsString;
end;

procedure TOsrhisDat.SetAcpSta(pValue:Str1);
begin
  oTable.FieldByName('AcpSta').AsString:=pValue;
end;

function TOsrhisDat.GetAcpUsr:Str15;
begin
  Result:=oTable.FieldByName('AcpUsr').AsString;
end;

procedure TOsrhisDat.SetAcpUsr(pValue:Str15);
begin
  oTable.FieldByName('AcpUsr').AsString:=pValue;
end;

function TOsrhisDat.GetAcpUsn:Str30;
begin
  Result:=oTable.FieldByName('AcpUsn').AsString;
end;

procedure TOsrhisDat.SetAcpUsn(pValue:Str30);
begin
  oTable.FieldByName('AcpUsn').AsString:=pValue;
end;

function TOsrhisDat.GetAcpDte:TDatetime;
begin
  Result:=oTable.FieldByName('AcpDte').AsDateTime;
end;

procedure TOsrhisDat.SetAcpDte(pValue:TDatetime);
begin
  oTable.FieldByName('AcpDte').AsDateTime:=pValue;
end;

function TOsrhisDat.GetAcpTim:TDatetime;
begin
  Result:=oTable.FieldByName('AcpTim').AsDateTime;
end;

procedure TOsrhisDat.SetAcpTim(pValue:TDatetime);
begin
  oTable.FieldByName('AcpTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsrhisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TOsrhisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TOsrhisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TOsrhisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TOsrhisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TOsrhisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TOsrhisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TOsrhisDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TOsrhisDat.LocDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindKey([pDocNum,pItmNum]);
end;

function TOsrhisDat.LocDnAs(pDocNum:Str12;pAcpSta:Str1):boolean;
begin
  SetIndex(ixDnAs);
  Result:=oTable.FindKey([pDocNum,pAcpSta]);
end;

function TOsrhisDat.LocProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindKey([pProNum]);
end;

function TOsrhisDat.LocProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindKey([StrToAlias(pProNam_)]);
end;

function TOsrhisDat.LocSndSta(pSndSta:Str1):boolean;
begin
  SetIndex(ixSndSta);
  Result:=oTable.FindKey([pSndSta]);
end;

function TOsrhisDat.LocAcpSta(pAcpSta:Str1):boolean;
begin
  SetIndex(ixAcpSta);
  Result:=oTable.FindKey([pAcpSta]);
end;

function TOsrhisDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TOsrhisDat.NearDoIt(pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex(ixDoIt);
  Result:=oTable.FindNearest([pDocNum,pItmNum]);
end;

function TOsrhisDat.NearDnAs(pDocNum:Str12;pAcpSta:Str1):boolean;
begin
  SetIndex(ixDnAs);
  Result:=oTable.FindNearest([pDocNum,pAcpSta]);
end;

function TOsrhisDat.NearProNum(pProNum:longint):boolean;
begin
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

function TOsrhisDat.NearProNam(pProNam_:Str60):boolean;
begin
  SetIndex(ixProNam);
  Result:=oTable.FindNearest([pProNam_]);
end;

function TOsrhisDat.NearSndSta(pSndSta:Str1):boolean;
begin
  SetIndex(ixSndSta);
  Result:=oTable.FindNearest([pSndSta]);
end;

function TOsrhisDat.NearAcpSta(pAcpSta:Str1):boolean;
begin
  SetIndex(ixAcpSta);
  Result:=oTable.FindNearest([pAcpSta]);
end;

procedure TOsrhisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TOsrhisDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TOsrhisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TOsrhisDat.Prior;
begin
  oTable.Prior;
end;

procedure TOsrhisDat.Next;
begin
  oTable.Next;
end;

procedure TOsrhisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TOsrhisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TOsrhisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TOsrhisDat.Edit;
begin
  oTable.Edit;
end;

procedure TOsrhisDat.Post;
begin
  oTable.Post;
end;

procedure TOsrhisDat.Delete;
begin
  oTable.Delete;
end;

procedure TOsrhisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TOsrhisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TOsrhisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TOsrhisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TOsrhisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TOsrhisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
