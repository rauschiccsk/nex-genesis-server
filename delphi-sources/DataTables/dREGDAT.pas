unit dREGDAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegCod='RegCod';
  ixRegTyp='RegTyp';
  ixRegDte='RegDte';
  ixLimDte='LimDte';
  ixUpgDte='UpgDte';
  ixCusNum='CusNum';
  ix_CusNam='_CusNam';
  ixCusIno='CusIno';
  ixCusTin='CusTin';
  ixDlrNum='DlrNum';
  ix_DlrNam='_DlrNam';
  ixDlrIno='DlrIno';
  ixDlrTin='DlrTin';

type
  TRegdatDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetRegCod:Str20;            procedure SetRegCod(pValue:Str20);
    function GetRegKey:Str30;            procedure SetRegKey(pValue:Str30);
    function GetRegTyp:Str1;             procedure SetRegTyp(pValue:Str1);
    function GetRegDte:TDatetime;        procedure SetRegDte(pValue:TDatetime);
    function GetLimDte:TDatetime;        procedure SetLimDte(pValue:TDatetime);
    function GetUpgDte:TDatetime;        procedure SetUpgDte(pValue:TDatetime);
    function GetCusNum:longint;          procedure SetCusNum(pValue:longint);
    function GetCusNam:Str60;            procedure SetCusNam(pValue:Str60);
    function GetCusNam_:Str60;           procedure SetCusNam_(pValue:Str60);
    function GetCusIno:Str8;             procedure SetCusIno(pValue:Str8);
    function GetCusTin:Str10;            procedure SetCusTin(pValue:Str10);
    function GetCusVin:Str12;            procedure SetCusVin(pValue:Str12);
    function GetCusAdr:Str30;            procedure SetCusAdr(pValue:Str30);
    function GetCusCty:Str30;            procedure SetCusCty(pValue:Str30);
    function GetCusZip:Str5;             procedure SetCusZip(pValue:Str5);
    function GetCusSta:Str30;            procedure SetCusSta(pValue:Str30);
    function GetCwpAdr:Str30;            procedure SetCwpAdr(pValue:Str30);
    function GetCwpCty:Str30;            procedure SetCwpCty(pValue:Str30);
    function GetCwpZip:Str5;             procedure SetCwpZip(pValue:Str5);
    function GetCwpSta:Str30;            procedure SetCwpSta(pValue:Str30);
    function GetDlrNum:longint;          procedure SetDlrNum(pValue:longint);
    function GetDlrNam:Str60;            procedure SetDlrNam(pValue:Str60);
    function GetDlrNam_:Str60;           procedure SetDlrNam_(pValue:Str60);
    function GetDlrIno:Str8;             procedure SetDlrIno(pValue:Str8);
    function GetDlrTin:Str10;            procedure SetDlrTin(pValue:Str10);
    function GetDlrVin:Str12;            procedure SetDlrVin(pValue:Str12);
    function GetDlrAdr:Str30;            procedure SetDlrAdr(pValue:Str30);
    function GetDlrCty:Str30;            procedure SetDlrCty(pValue:Str30);
    function GetDlrZip:Str5;             procedure SetDlrZip(pValue:Str5);
    function GetDlrSta:Str30;            procedure SetDlrSta(pValue:Str30);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str10;            procedure SetModUsr(pValue:Str10);
    function GetModUsn:Str30;            procedure SetModUsn(pValue:Str30);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocRegCod(pRegCod:Str20):boolean;
    function LocRegTyp(pRegTyp:Str1):boolean;
    function LocRegDte(pRegDte:TDatetime):boolean;
    function LocLimDte(pLimDte:TDatetime):boolean;
    function LocUpgDte(pUpgDte:TDatetime):boolean;
    function LocCusNum(pCusNum:longint):boolean;
    function Loc_CusNam(pCusNam_:Str60):boolean;
    function LocCusIno(pCusIno:Str8):boolean;
    function LocCusTin(pCusTin:Str10):boolean;
    function LocDlrNum(pDlrNum:longint):boolean;
    function Loc_DlrNam(pDlrNam_:Str60):boolean;
    function LocDlrIno(pDlrIno:Str8):boolean;
    function LocDlrTin(pDlrTin:Str10):boolean;
    function NearRegCod(pRegCod:Str20):boolean;
    function NearRegTyp(pRegTyp:Str1):boolean;
    function NearRegDte(pRegDte:TDatetime):boolean;
    function NearLimDte(pLimDte:TDatetime):boolean;
    function NearUpgDte(pUpgDte:TDatetime):boolean;
    function NearCusNum(pCusNum:longint):boolean;
    function Near_CusNam(pCusNam_:Str60):boolean;
    function NearCusIno(pCusIno:Str8):boolean;
    function NearCusTin(pCusTin:Str10):boolean;
    function NearDlrNum(pDlrNum:longint):boolean;
    function Near_DlrNam(pDlrNam_:Str60):boolean;
    function NearDlrIno(pDlrIno:Str8):boolean;
    function NearDlrTin(pDlrTin:Str10):boolean;

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
    property RegCod:Str20 read GetRegCod write SetRegCod;
    property RegKey:Str30 read GetRegKey write SetRegKey;
    property RegTyp:Str1 read GetRegTyp write SetRegTyp;
    property RegDte:TDatetime read GetRegDte write SetRegDte;
    property LimDte:TDatetime read GetLimDte write SetLimDte;
    property UpgDte:TDatetime read GetUpgDte write SetUpgDte;
    property CusNum:longint read GetCusNum write SetCusNum;
    property CusNam:Str60 read GetCusNam write SetCusNam;
    property CusNam_:Str60 read GetCusNam_ write SetCusNam_;
    property CusIno:Str8 read GetCusIno write SetCusIno;
    property CusTin:Str10 read GetCusTin write SetCusTin;
    property CusVin:Str12 read GetCusVin write SetCusVin;
    property CusAdr:Str30 read GetCusAdr write SetCusAdr;
    property CusCty:Str30 read GetCusCty write SetCusCty;
    property CusZip:Str5 read GetCusZip write SetCusZip;
    property CusSta:Str30 read GetCusSta write SetCusSta;
    property CwpAdr:Str30 read GetCwpAdr write SetCwpAdr;
    property CwpCty:Str30 read GetCwpCty write SetCwpCty;
    property CwpZip:Str5 read GetCwpZip write SetCwpZip;
    property CwpSta:Str30 read GetCwpSta write SetCwpSta;
    property DlrNum:longint read GetDlrNum write SetDlrNum;
    property DlrNam:Str60 read GetDlrNam write SetDlrNam;
    property DlrNam_:Str60 read GetDlrNam_ write SetDlrNam_;
    property DlrIno:Str8 read GetDlrIno write SetDlrIno;
    property DlrTin:Str10 read GetDlrTin write SetDlrTin;
    property DlrVin:Str12 read GetDlrVin write SetDlrVin;
    property DlrAdr:Str30 read GetDlrAdr write SetDlrAdr;
    property DlrCty:Str30 read GetDlrCty write SetDlrCty;
    property DlrZip:Str5 read GetDlrZip write SetDlrZip;
    property DlrSta:Str30 read GetDlrSta write SetDlrSta;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str10 read GetModUsr write SetModUsr;
    property ModUsn:Str30 read GetModUsn write SetModUsn;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TRegdatDat.Create;
begin
  oTable:=DatInit('REGDAT',gPath.SysPath,Self);
end;

constructor TRegdatDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('REGDAT',pPath,Self);
end;

destructor TRegdatDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TRegdatDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TRegdatDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TRegdatDat.GetRegCod:Str20;
begin
  Result:=oTable.FieldByName('RegCod').AsString;
end;

procedure TRegdatDat.SetRegCod(pValue:Str20);
begin
  oTable.FieldByName('RegCod').AsString:=pValue;
end;

function TRegdatDat.GetRegKey:Str30;
begin
  Result:=oTable.FieldByName('RegKey').AsString;
end;

procedure TRegdatDat.SetRegKey(pValue:Str30);
begin
  oTable.FieldByName('RegKey').AsString:=pValue;
end;

function TRegdatDat.GetRegTyp:Str1;
begin
  Result:=oTable.FieldByName('RegTyp').AsString;
end;

procedure TRegdatDat.SetRegTyp(pValue:Str1);
begin
  oTable.FieldByName('RegTyp').AsString:=pValue;
end;

function TRegdatDat.GetRegDte:TDatetime;
begin
  Result:=oTable.FieldByName('RegDte').AsDateTime;
end;

procedure TRegdatDat.SetRegDte(pValue:TDatetime);
begin
  oTable.FieldByName('RegDte').AsDateTime:=pValue;
end;

function TRegdatDat.GetLimDte:TDatetime;
begin
  Result:=oTable.FieldByName('LimDte').AsDateTime;
end;

procedure TRegdatDat.SetLimDte(pValue:TDatetime);
begin
  oTable.FieldByName('LimDte').AsDateTime:=pValue;
end;

function TRegdatDat.GetUpgDte:TDatetime;
begin
  Result:=oTable.FieldByName('UpgDte').AsDateTime;
end;

procedure TRegdatDat.SetUpgDte(pValue:TDatetime);
begin
  oTable.FieldByName('UpgDte').AsDateTime:=pValue;
end;

function TRegdatDat.GetCusNum:longint;
begin
  Result:=oTable.FieldByName('CusNum').AsInteger;
end;

procedure TRegdatDat.SetCusNum(pValue:longint);
begin
  oTable.FieldByName('CusNum').AsInteger:=pValue;
end;

function TRegdatDat.GetCusNam:Str60;
begin
  Result:=oTable.FieldByName('CusNam').AsString;
end;

procedure TRegdatDat.SetCusNam(pValue:Str60);
begin
  oTable.FieldByName('CusNam').AsString:=pValue;
end;

function TRegdatDat.GetCusNam_:Str60;
begin
  Result:=oTable.FieldByName('CusNam_').AsString;
end;

procedure TRegdatDat.SetCusNam_(pValue:Str60);
begin
  oTable.FieldByName('CusNam_').AsString:=pValue;
end;

function TRegdatDat.GetCusIno:Str8;
begin
  Result:=oTable.FieldByName('CusIno').AsString;
end;

procedure TRegdatDat.SetCusIno(pValue:Str8);
begin
  oTable.FieldByName('CusIno').AsString:=pValue;
end;

function TRegdatDat.GetCusTin:Str10;
begin
  Result:=oTable.FieldByName('CusTin').AsString;
end;

procedure TRegdatDat.SetCusTin(pValue:Str10);
begin
  oTable.FieldByName('CusTin').AsString:=pValue;
end;

function TRegdatDat.GetCusVin:Str12;
begin
  Result:=oTable.FieldByName('CusVin').AsString;
end;

procedure TRegdatDat.SetCusVin(pValue:Str12);
begin
  oTable.FieldByName('CusVin').AsString:=pValue;
end;

function TRegdatDat.GetCusAdr:Str30;
begin
  Result:=oTable.FieldByName('CusAdr').AsString;
end;

procedure TRegdatDat.SetCusAdr(pValue:Str30);
begin
  oTable.FieldByName('CusAdr').AsString:=pValue;
end;

function TRegdatDat.GetCusCty:Str30;
begin
  Result:=oTable.FieldByName('CusCty').AsString;
end;

procedure TRegdatDat.SetCusCty(pValue:Str30);
begin
  oTable.FieldByName('CusCty').AsString:=pValue;
end;

function TRegdatDat.GetCusZip:Str5;
begin
  Result:=oTable.FieldByName('CusZip').AsString;
end;

procedure TRegdatDat.SetCusZip(pValue:Str5);
begin
  oTable.FieldByName('CusZip').AsString:=pValue;
end;

function TRegdatDat.GetCusSta:Str30;
begin
  Result:=oTable.FieldByName('CusSta').AsString;
end;

procedure TRegdatDat.SetCusSta(pValue:Str30);
begin
  oTable.FieldByName('CusSta').AsString:=pValue;
end;

function TRegdatDat.GetCwpAdr:Str30;
begin
  Result:=oTable.FieldByName('CwpAdr').AsString;
end;

procedure TRegdatDat.SetCwpAdr(pValue:Str30);
begin
  oTable.FieldByName('CwpAdr').AsString:=pValue;
end;

function TRegdatDat.GetCwpCty:Str30;
begin
  Result:=oTable.FieldByName('CwpCty').AsString;
end;

procedure TRegdatDat.SetCwpCty(pValue:Str30);
begin
  oTable.FieldByName('CwpCty').AsString:=pValue;
end;

function TRegdatDat.GetCwpZip:Str5;
begin
  Result:=oTable.FieldByName('CwpZip').AsString;
end;

procedure TRegdatDat.SetCwpZip(pValue:Str5);
begin
  oTable.FieldByName('CwpZip').AsString:=pValue;
end;

function TRegdatDat.GetCwpSta:Str30;
begin
  Result:=oTable.FieldByName('CwpSta').AsString;
end;

procedure TRegdatDat.SetCwpSta(pValue:Str30);
begin
  oTable.FieldByName('CwpSta').AsString:=pValue;
end;

function TRegdatDat.GetDlrNum:longint;
begin
  Result:=oTable.FieldByName('DlrNum').AsInteger;
end;

procedure TRegdatDat.SetDlrNum(pValue:longint);
begin
  oTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TRegdatDat.GetDlrNam:Str60;
begin
  Result:=oTable.FieldByName('DlrNam').AsString;
end;

procedure TRegdatDat.SetDlrNam(pValue:Str60);
begin
  oTable.FieldByName('DlrNam').AsString:=pValue;
end;

function TRegdatDat.GetDlrNam_:Str60;
begin
  Result:=oTable.FieldByName('DlrNam_').AsString;
end;

procedure TRegdatDat.SetDlrNam_(pValue:Str60);
begin
  oTable.FieldByName('DlrNam_').AsString:=pValue;
end;

function TRegdatDat.GetDlrIno:Str8;
begin
  Result:=oTable.FieldByName('DlrIno').AsString;
end;

procedure TRegdatDat.SetDlrIno(pValue:Str8);
begin
  oTable.FieldByName('DlrIno').AsString:=pValue;
end;

function TRegdatDat.GetDlrTin:Str10;
begin
  Result:=oTable.FieldByName('DlrTin').AsString;
end;

procedure TRegdatDat.SetDlrTin(pValue:Str10);
begin
  oTable.FieldByName('DlrTin').AsString:=pValue;
end;

function TRegdatDat.GetDlrVin:Str12;
begin
  Result:=oTable.FieldByName('DlrVin').AsString;
end;

procedure TRegdatDat.SetDlrVin(pValue:Str12);
begin
  oTable.FieldByName('DlrVin').AsString:=pValue;
end;

function TRegdatDat.GetDlrAdr:Str30;
begin
  Result:=oTable.FieldByName('DlrAdr').AsString;
end;

procedure TRegdatDat.SetDlrAdr(pValue:Str30);
begin
  oTable.FieldByName('DlrAdr').AsString:=pValue;
end;

function TRegdatDat.GetDlrCty:Str30;
begin
  Result:=oTable.FieldByName('DlrCty').AsString;
end;

procedure TRegdatDat.SetDlrCty(pValue:Str30);
begin
  oTable.FieldByName('DlrCty').AsString:=pValue;
end;

function TRegdatDat.GetDlrZip:Str5;
begin
  Result:=oTable.FieldByName('DlrZip').AsString;
end;

procedure TRegdatDat.SetDlrZip(pValue:Str5);
begin
  oTable.FieldByName('DlrZip').AsString:=pValue;
end;

function TRegdatDat.GetDlrSta:Str30;
begin
  Result:=oTable.FieldByName('DlrSta').AsString;
end;

procedure TRegdatDat.SetDlrSta(pValue:Str30);
begin
  oTable.FieldByName('DlrSta').AsString:=pValue;
end;

function TRegdatDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TRegdatDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TRegdatDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TRegdatDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TRegdatDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TRegdatDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TRegdatDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TRegdatDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TRegdatDat.GetModUsr:Str10;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TRegdatDat.SetModUsr(pValue:Str10);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TRegdatDat.GetModUsn:Str30;
begin
  Result:=oTable.FieldByName('ModUsn').AsString;
end;

procedure TRegdatDat.SetModUsn(pValue:Str30);
begin
  oTable.FieldByName('ModUsn').AsString:=pValue;
end;

function TRegdatDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TRegdatDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TRegdatDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TRegdatDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TRegdatDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TRegdatDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TRegdatDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TRegdatDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TRegdatDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TRegdatDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TRegdatDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TRegdatDat.LocRegCod(pRegCod:Str20):boolean;
begin
  SetIndex(ixRegCod);
  Result:=oTable.FindKey([pRegCod]);
end;

function TRegdatDat.LocRegTyp(pRegTyp:Str1):boolean;
begin
  SetIndex(ixRegTyp);
  Result:=oTable.FindKey([pRegTyp]);
end;

function TRegdatDat.LocRegDte(pRegDte:TDatetime):boolean;
begin
  SetIndex(ixRegDte);
  Result:=oTable.FindKey([pRegDte]);
end;

function TRegdatDat.LocLimDte(pLimDte:TDatetime):boolean;
begin
  SetIndex(ixLimDte);
  Result:=oTable.FindKey([pLimDte]);
end;

function TRegdatDat.LocUpgDte(pUpgDte:TDatetime):boolean;
begin
  SetIndex(ixUpgDte);
  Result:=oTable.FindKey([pUpgDte]);
end;

function TRegdatDat.LocCusNum(pCusNum:longint):boolean;
begin
  SetIndex(ixCusNum);
  Result:=oTable.FindKey([pCusNum]);
end;

function TRegdatDat.Loc_CusNam(pCusNam_:Str60):boolean;
begin
  SetIndex(ix_CusNam);
  Result:=oTable.FindKey([StrToAlias(pCusNam_)]);
end;

function TRegdatDat.LocCusIno(pCusIno:Str8):boolean;
begin
  SetIndex(ixCusIno);
  Result:=oTable.FindKey([pCusIno]);
end;

function TRegdatDat.LocCusTin(pCusTin:Str10):boolean;
begin
  SetIndex(ixCusTin);
  Result:=oTable.FindKey([pCusTin]);
end;

function TRegdatDat.LocDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindKey([pDlrNum]);
end;

function TRegdatDat.Loc_DlrNam(pDlrNam_:Str60):boolean;
begin
  SetIndex(ix_DlrNam);
  Result:=oTable.FindKey([StrToAlias(pDlrNam_)]);
end;

function TRegdatDat.LocDlrIno(pDlrIno:Str8):boolean;
begin
  SetIndex(ixDlrIno);
  Result:=oTable.FindKey([pDlrIno]);
end;

function TRegdatDat.LocDlrTin(pDlrTin:Str10):boolean;
begin
  SetIndex(ixDlrTin);
  Result:=oTable.FindKey([pDlrTin]);
end;

function TRegdatDat.NearRegCod(pRegCod:Str20):boolean;
begin
  SetIndex(ixRegCod);
  Result:=oTable.FindNearest([pRegCod]);
end;

function TRegdatDat.NearRegTyp(pRegTyp:Str1):boolean;
begin
  SetIndex(ixRegTyp);
  Result:=oTable.FindNearest([pRegTyp]);
end;

function TRegdatDat.NearRegDte(pRegDte:TDatetime):boolean;
begin
  SetIndex(ixRegDte);
  Result:=oTable.FindNearest([pRegDte]);
end;

function TRegdatDat.NearLimDte(pLimDte:TDatetime):boolean;
begin
  SetIndex(ixLimDte);
  Result:=oTable.FindNearest([pLimDte]);
end;

function TRegdatDat.NearUpgDte(pUpgDte:TDatetime):boolean;
begin
  SetIndex(ixUpgDte);
  Result:=oTable.FindNearest([pUpgDte]);
end;

function TRegdatDat.NearCusNum(pCusNum:longint):boolean;
begin
  SetIndex(ixCusNum);
  Result:=oTable.FindNearest([pCusNum]);
end;

function TRegdatDat.Near_CusNam(pCusNam_:Str60):boolean;
begin
  SetIndex(ix_CusNam);
  Result:=oTable.FindNearest([pCusNam_]);
end;

function TRegdatDat.NearCusIno(pCusIno:Str8):boolean;
begin
  SetIndex(ixCusIno);
  Result:=oTable.FindNearest([pCusIno]);
end;

function TRegdatDat.NearCusTin(pCusTin:Str10):boolean;
begin
  SetIndex(ixCusTin);
  Result:=oTable.FindNearest([pCusTin]);
end;

function TRegdatDat.NearDlrNum(pDlrNum:longint):boolean;
begin
  SetIndex(ixDlrNum);
  Result:=oTable.FindNearest([pDlrNum]);
end;

function TRegdatDat.Near_DlrNam(pDlrNam_:Str60):boolean;
begin
  SetIndex(ix_DlrNam);
  Result:=oTable.FindNearest([pDlrNam_]);
end;

function TRegdatDat.NearDlrIno(pDlrIno:Str8):boolean;
begin
  SetIndex(ixDlrIno);
  Result:=oTable.FindNearest([pDlrIno]);
end;

function TRegdatDat.NearDlrTin(pDlrTin:Str10):boolean;
begin
  SetIndex(ixDlrTin);
  Result:=oTable.FindNearest([pDlrTin]);
end;

procedure TRegdatDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TRegdatDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TRegdatDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TRegdatDat.Prior;
begin
  oTable.Prior;
end;

procedure TRegdatDat.Next;
begin
  oTable.Next;
end;

procedure TRegdatDat.First;
begin
  Open;
  oTable.First;
end;

procedure TRegdatDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TRegdatDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TRegdatDat.Edit;
begin
  oTable.Edit;
end;

procedure TRegdatDat.Post;
begin
  oTable.Post;
end;

procedure TRegdatDat.Delete;
begin
  oTable.Delete;
end;

procedure TRegdatDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TRegdatDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TRegdatDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TRegdatDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TRegdatDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TRegdatDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
