unit dEMDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEmdNum='EmdNum';
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixSndSta='SndSta';
  ixAtdNum='AtdNum';
  ixAtdTyp='AtdTyp';

type
  TEmdlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEmdNum:longint;          procedure SetEmdNum(pValue:longint);
    function GetSndNam:Str50;            procedure SetSndNam(pValue:Str50);
    function GetSndAdr:Str50;            procedure SetSndAdr(pValue:Str50);
    function GetTrgAdr:Str50;            procedure SetTrgAdr(pValue:Str50);
    function GetCopAdr:Str50;            procedure SetCopAdr(pValue:Str50);
    function GetHidAdr:Str50;            procedure SetHidAdr(pValue:Str50);
    function GetSubjec:Str100;           procedure SetSubjec(pValue:Str100);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSndDte:TDatetime;        procedure SetSndDte(pValue:TDatetime);
    function GetSndTim:TDatetime;        procedure SetSndTim(pValue:TDatetime);
    function GetSndSta:Str1;             procedure SetSndSta(pValue:Str1);
    function GetSndCnt:byte;             procedure SetSndCnt(pValue:byte);
    function GetDelSta:Str1;             procedure SetDelSta(pValue:Str1);
    function GetAtdTyp:Str2;             procedure SetAtdTyp(pValue:Str2);
    function GetReserv:Str100;           procedure SetReserv(pValue:Str100);
    function GetAtdDoq:byte;             procedure SetAtdDoq(pValue:byte);
    function GetAtdNum:Str12;            procedure SetAtdNum(pValue:Str12);
    function GetAtdCnt:byte;             procedure SetAtdCnt(pValue:byte);
    function GetErrSta:Str1;             procedure SetErrSta(pValue:Str1);
    function GetErrCod:word;             procedure SetErrCod(pValue:word);
    function GetEmlMsk:Str20;            procedure SetEmlMsk(pValue:Str20);
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
    function LocEmdNum(pEmdNum:longint):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocSndSta(pSndSta:Str1):boolean;
    function LocAtdNum(pAtdNum:Str12):boolean;
    function LocAtdTyp(pAtdTyp:Str2):boolean;
    function NearEmdNum(pEmdNum:longint):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearSndSta(pSndSta:Str1):boolean;
    function NearAtdNum(pAtdNum:Str12):boolean;
    function NearAtdTyp(pAtdTyp:Str2):boolean;

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
    property EmdNum:longint read GetEmdNum write SetEmdNum;
    property SndNam:Str50 read GetSndNam write SetSndNam;
    property SndAdr:Str50 read GetSndAdr write SetSndAdr;
    property TrgAdr:Str50 read GetTrgAdr write SetTrgAdr;
    property CopAdr:Str50 read GetCopAdr write SetCopAdr;
    property HidAdr:Str50 read GetHidAdr write SetHidAdr;
    property Subjec:Str100 read GetSubjec write SetSubjec;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SndDte:TDatetime read GetSndDte write SetSndDte;
    property SndTim:TDatetime read GetSndTim write SetSndTim;
    property SndSta:Str1 read GetSndSta write SetSndSta;
    property SndCnt:byte read GetSndCnt write SetSndCnt;
    property DelSta:Str1 read GetDelSta write SetDelSta;
    property AtdTyp:Str2 read GetAtdTyp write SetAtdTyp;
    property Reserv:Str100 read GetReserv write SetReserv;
    property AtdDoq:byte read GetAtdDoq write SetAtdDoq;
    property AtdNum:Str12 read GetAtdNum write SetAtdNum;
    property AtdCnt:byte read GetAtdCnt write SetAtdCnt;
    property ErrSta:Str1 read GetErrSta write SetErrSta;
    property ErrCod:word read GetErrCod write SetErrCod;
    property EmlMsk:Str20 read GetEmlMsk write SetEmlMsk;
  end;

implementation

constructor TEmdlstDat.Create;
begin
  oTable:=DatInit('EMDLST',gPath.SysPath,Self);
end;

constructor TEmdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EMDLST',pPath,Self);
end;

destructor TEmdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEmdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEmdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEmdlstDat.GetEmdNum:longint;
begin
  Result:=oTable.FieldByName('EmdNum').AsInteger;
end;

procedure TEmdlstDat.SetEmdNum(pValue:longint);
begin
  oTable.FieldByName('EmdNum').AsInteger:=pValue;
end;

function TEmdlstDat.GetSndNam:Str50;
begin
  Result:=oTable.FieldByName('SndNam').AsString;
end;

procedure TEmdlstDat.SetSndNam(pValue:Str50);
begin
  oTable.FieldByName('SndNam').AsString:=pValue;
end;

function TEmdlstDat.GetSndAdr:Str50;
begin
  Result:=oTable.FieldByName('SndAdr').AsString;
end;

procedure TEmdlstDat.SetSndAdr(pValue:Str50);
begin
  oTable.FieldByName('SndAdr').AsString:=pValue;
end;

function TEmdlstDat.GetTrgAdr:Str50;
begin
  Result:=oTable.FieldByName('TrgAdr').AsString;
end;

procedure TEmdlstDat.SetTrgAdr(pValue:Str50);
begin
  oTable.FieldByName('TrgAdr').AsString:=pValue;
end;

function TEmdlstDat.GetCopAdr:Str50;
begin
  Result:=oTable.FieldByName('CopAdr').AsString;
end;

procedure TEmdlstDat.SetCopAdr(pValue:Str50);
begin
  oTable.FieldByName('CopAdr').AsString:=pValue;
end;

function TEmdlstDat.GetHidAdr:Str50;
begin
  Result:=oTable.FieldByName('HidAdr').AsString;
end;

procedure TEmdlstDat.SetHidAdr(pValue:Str50);
begin
  oTable.FieldByName('HidAdr').AsString:=pValue;
end;

function TEmdlstDat.GetSubjec:Str100;
begin
  Result:=oTable.FieldByName('Subjec').AsString;
end;

procedure TEmdlstDat.SetSubjec(pValue:Str100);
begin
  oTable.FieldByName('Subjec').AsString:=pValue;
end;

function TEmdlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TEmdlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TEmdlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TEmdlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEmdlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TEmdlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TEmdlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TEmdlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TEmdlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TEmdlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TEmdlstDat.GetSndDte:TDatetime;
begin
  Result:=oTable.FieldByName('SndDte').AsDateTime;
end;

procedure TEmdlstDat.SetSndDte(pValue:TDatetime);
begin
  oTable.FieldByName('SndDte').AsDateTime:=pValue;
end;

function TEmdlstDat.GetSndTim:TDatetime;
begin
  Result:=oTable.FieldByName('SndTim').AsDateTime;
end;

procedure TEmdlstDat.SetSndTim(pValue:TDatetime);
begin
  oTable.FieldByName('SndTim').AsDateTime:=pValue;
end;

function TEmdlstDat.GetSndSta:Str1;
begin
  Result:=oTable.FieldByName('SndSta').AsString;
end;

procedure TEmdlstDat.SetSndSta(pValue:Str1);
begin
  oTable.FieldByName('SndSta').AsString:=pValue;
end;

function TEmdlstDat.GetSndCnt:byte;
begin
  Result:=oTable.FieldByName('SndCnt').AsInteger;
end;

procedure TEmdlstDat.SetSndCnt(pValue:byte);
begin
  oTable.FieldByName('SndCnt').AsInteger:=pValue;
end;

function TEmdlstDat.GetDelSta:Str1;
begin
  Result:=oTable.FieldByName('DelSta').AsString;
end;

procedure TEmdlstDat.SetDelSta(pValue:Str1);
begin
  oTable.FieldByName('DelSta').AsString:=pValue;
end;

function TEmdlstDat.GetAtdTyp:Str2;
begin
  Result:=oTable.FieldByName('AtdTyp').AsString;
end;

procedure TEmdlstDat.SetAtdTyp(pValue:Str2);
begin
  oTable.FieldByName('AtdTyp').AsString:=pValue;
end;

function TEmdlstDat.GetReserv:Str100;
begin
  Result:=oTable.FieldByName('Reserv').AsString;
end;

procedure TEmdlstDat.SetReserv(pValue:Str100);
begin
  oTable.FieldByName('Reserv').AsString:=pValue;
end;

function TEmdlstDat.GetAtdDoq:byte;
begin
  Result:=oTable.FieldByName('AtdDoq').AsInteger;
end;

procedure TEmdlstDat.SetAtdDoq(pValue:byte);
begin
  oTable.FieldByName('AtdDoq').AsInteger:=pValue;
end;

function TEmdlstDat.GetAtdNum:Str12;
begin
  Result:=oTable.FieldByName('AtdNum').AsString;
end;

procedure TEmdlstDat.SetAtdNum(pValue:Str12);
begin
  oTable.FieldByName('AtdNum').AsString:=pValue;
end;

function TEmdlstDat.GetAtdCnt:byte;
begin
  Result:=oTable.FieldByName('AtdCnt').AsInteger;
end;

procedure TEmdlstDat.SetAtdCnt(pValue:byte);
begin
  oTable.FieldByName('AtdCnt').AsInteger:=pValue;
end;

function TEmdlstDat.GetErrSta:Str1;
begin
  Result:=oTable.FieldByName('ErrSta').AsString;
end;

procedure TEmdlstDat.SetErrSta(pValue:Str1);
begin
  oTable.FieldByName('ErrSta').AsString:=pValue;
end;

function TEmdlstDat.GetErrCod:word;
begin
  Result:=oTable.FieldByName('ErrCod').AsInteger;
end;

procedure TEmdlstDat.SetErrCod(pValue:word);
begin
  oTable.FieldByName('ErrCod').AsInteger:=pValue;
end;

function TEmdlstDat.GetEmlMsk:Str20;
begin
  Result:=oTable.FieldByName('EmlMsk').AsString;
end;

procedure TEmdlstDat.SetEmlMsk(pValue:Str20);
begin
  oTable.FieldByName('EmlMsk').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEmdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEmdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEmdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEmdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEmdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEmdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEmdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEmdlstDat.LocEmdNum(pEmdNum:longint):boolean;
begin
  SetIndex(ixEmdNum);
  Result:=oTable.FindKey([pEmdNum]);
end;

function TEmdlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TEmdlstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TEmdlstDat.LocSndSta(pSndSta:Str1):boolean;
begin
  SetIndex(ixSndSta);
  Result:=oTable.FindKey([pSndSta]);
end;

function TEmdlstDat.LocAtdNum(pAtdNum:Str12):boolean;
begin
  SetIndex(ixAtdNum);
  Result:=oTable.FindKey([pAtdNum]);
end;

function TEmdlstDat.LocAtdTyp(pAtdTyp:Str2):boolean;
begin
  SetIndex(ixAtdTyp);
  Result:=oTable.FindKey([pAtdTyp]);
end;

function TEmdlstDat.NearEmdNum(pEmdNum:longint):boolean;
begin
  SetIndex(ixEmdNum);
  Result:=oTable.FindNearest([pEmdNum]);
end;

function TEmdlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TEmdlstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TEmdlstDat.NearSndSta(pSndSta:Str1):boolean;
begin
  SetIndex(ixSndSta);
  Result:=oTable.FindNearest([pSndSta]);
end;

function TEmdlstDat.NearAtdNum(pAtdNum:Str12):boolean;
begin
  SetIndex(ixAtdNum);
  Result:=oTable.FindNearest([pAtdNum]);
end;

function TEmdlstDat.NearAtdTyp(pAtdTyp:Str2):boolean;
begin
  SetIndex(ixAtdTyp);
  Result:=oTable.FindNearest([pAtdTyp]);
end;

procedure TEmdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEmdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEmdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEmdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TEmdlstDat.Next;
begin
  oTable.Next;
end;

procedure TEmdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEmdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEmdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEmdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TEmdlstDat.Post;
begin
  oTable.Post;
end;

procedure TEmdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TEmdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEmdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEmdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEmdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEmdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEmdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
