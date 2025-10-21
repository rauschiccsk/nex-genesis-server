unit dPERLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPerNum='PerNum';
  ixPerNam='PerNam';
  ixCrdNum='CrdNum';
  ixIdcNum='IdcNum';
  ixPasNum='PasNum';
  ixBirNum='BirNum';
  ixEmlAdr='EmlAdr';
  ixTelNum='TelNum';
  ixBokNum='BokNum';
  ixDlrSta='DlrSta';
  ixEmpSta='EmpSta';
  ixExtSta='ExtSta';
  ixDirSta='DirSta';
  ixUsrSta='UsrSta';
  ixUsrLog='UsrLog';

type
  TPerlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetPerNum:longint;          procedure SetPerNum(pValue:longint);
    function GetPerNam:Str50;            procedure SetPerNam(pValue:Str50);
    function GetPerNam_:Str50;           procedure SetPerNam_(pValue:Str50);
    function GetRegAdr:Str50;            procedure SetRegAdr(pValue:Str50);
    function GetRegZip:Str6;             procedure SetRegZip(pValue:Str6);
    function GetRegCtn:Str30;            procedure SetRegCtn(pValue:Str30);
    function GetRegSta:Str30;            procedure SetRegSta(pValue:Str30);
    function GetCrdNum:Str30;            procedure SetCrdNum(pValue:Str30);
    function GetIdcNum:Str10;            procedure SetIdcNum(pValue:Str10);
    function GetPasNum:Str10;            procedure SetPasNum(pValue:Str10);
    function GetBirNum:Str12;            procedure SetBirNum(pValue:Str12);
    function GetEmlAdr:Str30;            procedure SetEmlAdr(pValue:Str30);
    function GetTelNum:Str20;            procedure SetTelNum(pValue:Str20);
    function GetPerGrp:word;             procedure SetPerGrp(pValue:word);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetDlrSta:Str1;             procedure SetDlrSta(pValue:Str1);
    function GetEmpSta:Str1;             procedure SetEmpSta(pValue:Str1);
    function GetExtSta:Str1;             procedure SetExtSta(pValue:Str1);
    function GetDirSta:Str1;             procedure SetDirSta(pValue:Str1);
    function GetUsrSta:Str1;             procedure SetUsrSta(pValue:Str1);
    function GetUsrLog:Str15;            procedure SetUsrLog(pValue:Str15);
    function GetUsrPsw:Str20;            procedure SetUsrPsw(pValue:Str20);
    function GetUsrLng:Str2;             procedure SetUsrLng(pValue:Str2);
    function GetUsrGrp:word;             procedure SetUsrGrp(pValue:word);
    function GetUsrLev:byte;             procedure SetUsrLev(pValue:byte);
    function GetUsrSig:Str20;            procedure SetUsrSig(pValue:Str20);
    function GetUsrPin:Str8;             procedure SetUsrPin(pValue:Str8);
    function GetUsrAct:Str1;             procedure SetUsrAct(pValue:Str1);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetFrmNam:Str10;            procedure SetFrmNam(pValue:Str10);
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
    function LocPerNum(pPerNum:longint):boolean;
    function LocPerNam(pPerNam_:Str50):boolean;
    function LocCrdNum(pCrdNum:Str30):boolean;
    function LocIdcNum(pIdcNum:Str10):boolean;
    function LocPasNum(pPasNum:Str10):boolean;
    function LocBirNum(pBirNum:Str12):boolean;
    function LocEmlAdr(pEmlAdr:Str30):boolean;
    function LocTelNum(pTelNum:Str20):boolean;
    function LocBokNum(pBokNum:Str3):boolean;
    function LocDlrSta(pDlrSta:Str1):boolean;
    function LocEmpSta(pEmpSta:Str1):boolean;
    function LocExtSta(pExtSta:Str1):boolean;
    function LocDirSta(pDirSta:Str1):boolean;
    function LocUsrSta(pUsrSta:Str1):boolean;
    function LocUsrLog(pUsrLog:Str15):boolean;
    function NearPerNum(pPerNum:longint):boolean;
    function NearPerNam(pPerNam_:Str50):boolean;
    function NearCrdNum(pCrdNum:Str30):boolean;
    function NearIdcNum(pIdcNum:Str10):boolean;
    function NearPasNum(pPasNum:Str10):boolean;
    function NearBirNum(pBirNum:Str12):boolean;
    function NearEmlAdr(pEmlAdr:Str30):boolean;
    function NearTelNum(pTelNum:Str20):boolean;
    function NearBokNum(pBokNum:Str3):boolean;
    function NearDlrSta(pDlrSta:Str1):boolean;
    function NearEmpSta(pEmpSta:Str1):boolean;
    function NearExtSta(pExtSta:Str1):boolean;
    function NearDirSta(pDirSta:Str1):boolean;
    function NearUsrSta(pUsrSta:Str1):boolean;
    function NearUsrLog(pUsrLog:Str15):boolean;

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
    property PerNum:longint read GetPerNum write SetPerNum;
    property PerNam:Str50 read GetPerNam write SetPerNam;
    property PerNam_:Str50 read GetPerNam_ write SetPerNam_;
    property RegAdr:Str50 read GetRegAdr write SetRegAdr;
    property RegZip:Str6 read GetRegZip write SetRegZip;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegSta:Str30 read GetRegSta write SetRegSta;
    property CrdNum:Str30 read GetCrdNum write SetCrdNum;
    property IdcNum:Str10 read GetIdcNum write SetIdcNum;
    property PasNum:Str10 read GetPasNum write SetPasNum;
    property BirNum:Str12 read GetBirNum write SetBirNum;
    property EmlAdr:Str30 read GetEmlAdr write SetEmlAdr;
    property TelNum:Str20 read GetTelNum write SetTelNum;
    property PerGrp:word read GetPerGrp write SetPerGrp;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property DlrSta:Str1 read GetDlrSta write SetDlrSta;
    property EmpSta:Str1 read GetEmpSta write SetEmpSta;
    property ExtSta:Str1 read GetExtSta write SetExtSta;
    property DirSta:Str1 read GetDirSta write SetDirSta;
    property UsrSta:Str1 read GetUsrSta write SetUsrSta;
    property UsrLog:Str15 read GetUsrLog write SetUsrLog;
    property UsrPsw:Str20 read GetUsrPsw write SetUsrPsw;
    property UsrLng:Str2 read GetUsrLng write SetUsrLng;
    property UsrGrp:word read GetUsrGrp write SetUsrGrp;
    property UsrLev:byte read GetUsrLev write SetUsrLev;
    property UsrSig:Str20 read GetUsrSig write SetUsrSig;
    property UsrPin:Str8 read GetUsrPin write SetUsrPin;
    property UsrAct:Str1 read GetUsrAct write SetUsrAct;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property FrmNam:Str10 read GetFrmNam write SetFrmNam;
  end;

implementation

constructor TPerlstDat.Create;
begin
  oTable:=DatInit('PERLST',gPath.DlsPath,Self);
end;

constructor TPerlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('PERLST',pPath,Self);
end;

destructor TPerlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TPerlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TPerlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TPerlstDat.GetPerNum:longint;
begin
  Result:=oTable.FieldByName('PerNum').AsInteger;
end;

procedure TPerlstDat.SetPerNum(pValue:longint);
begin
  oTable.FieldByName('PerNum').AsInteger:=pValue;
end;

function TPerlstDat.GetPerNam:Str50;
begin
  Result:=oTable.FieldByName('PerNam').AsString;
end;

procedure TPerlstDat.SetPerNam(pValue:Str50);
begin
  oTable.FieldByName('PerNam').AsString:=pValue;
end;

function TPerlstDat.GetPerNam_:Str50;
begin
  Result:=oTable.FieldByName('PerNam_').AsString;
end;

procedure TPerlstDat.SetPerNam_(pValue:Str50);
begin
  oTable.FieldByName('PerNam_').AsString:=pValue;
end;

function TPerlstDat.GetRegAdr:Str50;
begin
  Result:=oTable.FieldByName('RegAdr').AsString;
end;

procedure TPerlstDat.SetRegAdr(pValue:Str50);
begin
  oTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TPerlstDat.GetRegZip:Str6;
begin
  Result:=oTable.FieldByName('RegZip').AsString;
end;

procedure TPerlstDat.SetRegZip(pValue:Str6);
begin
  oTable.FieldByName('RegZip').AsString:=pValue;
end;

function TPerlstDat.GetRegCtn:Str30;
begin
  Result:=oTable.FieldByName('RegCtn').AsString;
end;

procedure TPerlstDat.SetRegCtn(pValue:Str30);
begin
  oTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TPerlstDat.GetRegSta:Str30;
begin
  Result:=oTable.FieldByName('RegSta').AsString;
end;

procedure TPerlstDat.SetRegSta(pValue:Str30);
begin
  oTable.FieldByName('RegSta').AsString:=pValue;
end;

function TPerlstDat.GetCrdNum:Str30;
begin
  Result:=oTable.FieldByName('CrdNum').AsString;
end;

procedure TPerlstDat.SetCrdNum(pValue:Str30);
begin
  oTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TPerlstDat.GetIdcNum:Str10;
begin
  Result:=oTable.FieldByName('IdcNum').AsString;
end;

procedure TPerlstDat.SetIdcNum(pValue:Str10);
begin
  oTable.FieldByName('IdcNum').AsString:=pValue;
end;

function TPerlstDat.GetPasNum:Str10;
begin
  Result:=oTable.FieldByName('PasNum').AsString;
end;

procedure TPerlstDat.SetPasNum(pValue:Str10);
begin
  oTable.FieldByName('PasNum').AsString:=pValue;
end;

function TPerlstDat.GetBirNum:Str12;
begin
  Result:=oTable.FieldByName('BirNum').AsString;
end;

procedure TPerlstDat.SetBirNum(pValue:Str12);
begin
  oTable.FieldByName('BirNum').AsString:=pValue;
end;

function TPerlstDat.GetEmlAdr:Str30;
begin
  Result:=oTable.FieldByName('EmlAdr').AsString;
end;

procedure TPerlstDat.SetEmlAdr(pValue:Str30);
begin
  oTable.FieldByName('EmlAdr').AsString:=pValue;
end;

function TPerlstDat.GetTelNum:Str20;
begin
  Result:=oTable.FieldByName('TelNum').AsString;
end;

procedure TPerlstDat.SetTelNum(pValue:Str20);
begin
  oTable.FieldByName('TelNum').AsString:=pValue;
end;

function TPerlstDat.GetPerGrp:word;
begin
  Result:=oTable.FieldByName('PerGrp').AsInteger;
end;

procedure TPerlstDat.SetPerGrp(pValue:word);
begin
  oTable.FieldByName('PerGrp').AsInteger:=pValue;
end;

function TPerlstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TPerlstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TPerlstDat.GetDlrSta:Str1;
begin
  Result:=oTable.FieldByName('DlrSta').AsString;
end;

procedure TPerlstDat.SetDlrSta(pValue:Str1);
begin
  oTable.FieldByName('DlrSta').AsString:=pValue;
end;

function TPerlstDat.GetEmpSta:Str1;
begin
  Result:=oTable.FieldByName('EmpSta').AsString;
end;

procedure TPerlstDat.SetEmpSta(pValue:Str1);
begin
  oTable.FieldByName('EmpSta').AsString:=pValue;
end;

function TPerlstDat.GetExtSta:Str1;
begin
  Result:=oTable.FieldByName('ExtSta').AsString;
end;

procedure TPerlstDat.SetExtSta(pValue:Str1);
begin
  oTable.FieldByName('ExtSta').AsString:=pValue;
end;

function TPerlstDat.GetDirSta:Str1;
begin
  Result:=oTable.FieldByName('DirSta').AsString;
end;

procedure TPerlstDat.SetDirSta(pValue:Str1);
begin
  oTable.FieldByName('DirSta').AsString:=pValue;
end;

function TPerlstDat.GetUsrSta:Str1;
begin
  Result:=oTable.FieldByName('UsrSta').AsString;
end;

procedure TPerlstDat.SetUsrSta(pValue:Str1);
begin
  oTable.FieldByName('UsrSta').AsString:=pValue;
end;

function TPerlstDat.GetUsrLog:Str15;
begin
  Result:=oTable.FieldByName('UsrLog').AsString;
end;

procedure TPerlstDat.SetUsrLog(pValue:Str15);
begin
  oTable.FieldByName('UsrLog').AsString:=pValue;
end;

function TPerlstDat.GetUsrPsw:Str20;
begin
  Result:=oTable.FieldByName('UsrPsw').AsString;
end;

procedure TPerlstDat.SetUsrPsw(pValue:Str20);
begin
  oTable.FieldByName('UsrPsw').AsString:=pValue;
end;

function TPerlstDat.GetUsrLng:Str2;
begin
  Result:=oTable.FieldByName('UsrLng').AsString;
end;

procedure TPerlstDat.SetUsrLng(pValue:Str2);
begin
  oTable.FieldByName('UsrLng').AsString:=pValue;
end;

function TPerlstDat.GetUsrGrp:word;
begin
  Result:=oTable.FieldByName('UsrGrp').AsInteger;
end;

procedure TPerlstDat.SetUsrGrp(pValue:word);
begin
  oTable.FieldByName('UsrGrp').AsInteger:=pValue;
end;

function TPerlstDat.GetUsrLev:byte;
begin
  Result:=oTable.FieldByName('UsrLev').AsInteger;
end;

procedure TPerlstDat.SetUsrLev(pValue:byte);
begin
  oTable.FieldByName('UsrLev').AsInteger:=pValue;
end;

function TPerlstDat.GetUsrSig:Str20;
begin
  Result:=oTable.FieldByName('UsrSig').AsString;
end;

procedure TPerlstDat.SetUsrSig(pValue:Str20);
begin
  oTable.FieldByName('UsrSig').AsString:=pValue;
end;

function TPerlstDat.GetUsrPin:Str8;
begin
  Result:=oTable.FieldByName('UsrPin').AsString;
end;

procedure TPerlstDat.SetUsrPin(pValue:Str8);
begin
  oTable.FieldByName('UsrPin').AsString:=pValue;
end;

function TPerlstDat.GetUsrAct:Str1;
begin
  Result:=oTable.FieldByName('UsrAct').AsString;
end;

procedure TPerlstDat.SetUsrAct(pValue:Str1);
begin
  oTable.FieldByName('UsrAct').AsString:=pValue;
end;

function TPerlstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TPerlstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TPerlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TPerlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TPerlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TPerlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TPerlstDat.GetFrmNam:Str10;
begin
  Result:=oTable.FieldByName('FrmNam').AsString;
end;

procedure TPerlstDat.SetFrmNam(pValue:Str10);
begin
  oTable.FieldByName('FrmNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPerlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TPerlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TPerlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TPerlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TPerlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TPerlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TPerlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TPerlstDat.LocPerNum(pPerNum:longint):boolean;
begin
  SetIndex(ixPerNum);
  Result:=oTable.FindKey([pPerNum]);
end;

function TPerlstDat.LocPerNam(pPerNam_:Str50):boolean;
begin
  SetIndex(ixPerNam);
  Result:=oTable.FindKey([StrToAlias(pPerNam_)]);
end;

function TPerlstDat.LocCrdNum(pCrdNum:Str30):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindKey([pCrdNum]);
end;

function TPerlstDat.LocIdcNum(pIdcNum:Str10):boolean;
begin
  SetIndex(ixIdcNum);
  Result:=oTable.FindKey([pIdcNum]);
end;

function TPerlstDat.LocPasNum(pPasNum:Str10):boolean;
begin
  SetIndex(ixPasNum);
  Result:=oTable.FindKey([pPasNum]);
end;

function TPerlstDat.LocBirNum(pBirNum:Str12):boolean;
begin
  SetIndex(ixBirNum);
  Result:=oTable.FindKey([pBirNum]);
end;

function TPerlstDat.LocEmlAdr(pEmlAdr:Str30):boolean;
begin
  SetIndex(ixEmlAdr);
  Result:=oTable.FindKey([pEmlAdr]);
end;

function TPerlstDat.LocTelNum(pTelNum:Str20):boolean;
begin
  SetIndex(ixTelNum);
  Result:=oTable.FindKey([pTelNum]);
end;

function TPerlstDat.LocBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindKey([pBokNum]);
end;

function TPerlstDat.LocDlrSta(pDlrSta:Str1):boolean;
begin
  SetIndex(ixDlrSta);
  Result:=oTable.FindKey([pDlrSta]);
end;

function TPerlstDat.LocEmpSta(pEmpSta:Str1):boolean;
begin
  SetIndex(ixEmpSta);
  Result:=oTable.FindKey([pEmpSta]);
end;

function TPerlstDat.LocExtSta(pExtSta:Str1):boolean;
begin
  SetIndex(ixExtSta);
  Result:=oTable.FindKey([pExtSta]);
end;

function TPerlstDat.LocDirSta(pDirSta:Str1):boolean;
begin
  SetIndex(ixDirSta);
  Result:=oTable.FindKey([pDirSta]);
end;

function TPerlstDat.LocUsrSta(pUsrSta:Str1):boolean;
begin
  SetIndex(ixUsrSta);
  Result:=oTable.FindKey([pUsrSta]);
end;

function TPerlstDat.LocUsrLog(pUsrLog:Str15):boolean;
begin
  SetIndex(ixUsrLog);
  Result:=oTable.FindKey([pUsrLog]);
end;

function TPerlstDat.NearPerNum(pPerNum:longint):boolean;
begin
  SetIndex(ixPerNum);
  Result:=oTable.FindNearest([pPerNum]);
end;

function TPerlstDat.NearPerNam(pPerNam_:Str50):boolean;
begin
  SetIndex(ixPerNam);
  Result:=oTable.FindNearest([pPerNam_]);
end;

function TPerlstDat.NearCrdNum(pCrdNum:Str30):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindNearest([pCrdNum]);
end;

function TPerlstDat.NearIdcNum(pIdcNum:Str10):boolean;
begin
  SetIndex(ixIdcNum);
  Result:=oTable.FindNearest([pIdcNum]);
end;

function TPerlstDat.NearPasNum(pPasNum:Str10):boolean;
begin
  SetIndex(ixPasNum);
  Result:=oTable.FindNearest([pPasNum]);
end;

function TPerlstDat.NearBirNum(pBirNum:Str12):boolean;
begin
  SetIndex(ixBirNum);
  Result:=oTable.FindNearest([pBirNum]);
end;

function TPerlstDat.NearEmlAdr(pEmlAdr:Str30):boolean;
begin
  SetIndex(ixEmlAdr);
  Result:=oTable.FindNearest([pEmlAdr]);
end;

function TPerlstDat.NearTelNum(pTelNum:Str20):boolean;
begin
  SetIndex(ixTelNum);
  Result:=oTable.FindNearest([pTelNum]);
end;

function TPerlstDat.NearBokNum(pBokNum:Str3):boolean;
begin
  SetIndex(ixBokNum);
  Result:=oTable.FindNearest([pBokNum]);
end;

function TPerlstDat.NearDlrSta(pDlrSta:Str1):boolean;
begin
  SetIndex(ixDlrSta);
  Result:=oTable.FindNearest([pDlrSta]);
end;

function TPerlstDat.NearEmpSta(pEmpSta:Str1):boolean;
begin
  SetIndex(ixEmpSta);
  Result:=oTable.FindNearest([pEmpSta]);
end;

function TPerlstDat.NearExtSta(pExtSta:Str1):boolean;
begin
  SetIndex(ixExtSta);
  Result:=oTable.FindNearest([pExtSta]);
end;

function TPerlstDat.NearDirSta(pDirSta:Str1):boolean;
begin
  SetIndex(ixDirSta);
  Result:=oTable.FindNearest([pDirSta]);
end;

function TPerlstDat.NearUsrSta(pUsrSta:Str1):boolean;
begin
  SetIndex(ixUsrSta);
  Result:=oTable.FindNearest([pUsrSta]);
end;

function TPerlstDat.NearUsrLog(pUsrLog:Str15):boolean;
begin
  SetIndex(ixUsrLog);
  Result:=oTable.FindNearest([pUsrLog]);
end;

procedure TPerlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TPerlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TPerlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TPerlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TPerlstDat.Next;
begin
  oTable.Next;
end;

procedure TPerlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TPerlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TPerlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TPerlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TPerlstDat.Post;
begin
  oTable.Post;
end;

procedure TPerlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TPerlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TPerlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TPerlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TPerlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TPerlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TPerlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
