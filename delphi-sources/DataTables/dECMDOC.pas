unit dECMDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDyDs='DyDs';
  ixDocSer='DocSer';
  ixCasNum='CasNum';
  ixCnDs='CnDs';
  ixParNam='ParNam';
  ixRegIno='RegIno';
  ixRegTin='RegTin';
  ixCusCrd='CusCrd';
  ixDocSta='DocSta';
  ixCrtDte='CrtDte';

type
  TEcmdocDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetDocSer:longint;          procedure SetDocSer(pValue:longint);
    function GetBlkNum:longint;          procedure SetBlkNum(pValue:longint);
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetDocDes:Str60;            procedure SetDocDes(pValue:Str60);
    function GetDocUid:Str50;            procedure SetDocUid(pValue:Str50);
    function GetDocVal:double;           procedure SetDocVal(pValue:double);
    function GetDocSta:byte;             procedure SetDocSta(pValue:byte);
    function GetDocStd:Str60;            procedure SetDocStd(pValue:Str60);
    function GetComLin:Str250;           procedure SetComLin(pValue:Str250);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetRegIno:Str10;            procedure SetRegIno(pValue:Str10);
    function GetRegTin:Str15;            procedure SetRegTin(pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin(pValue:Str15);
    function GetCusCrd:Str20;            procedure SetCusCrd(pValue:Str20);
    function GetSrdDoc:Str12;            procedure SetSrdDoc(pValue:Str12);
    function GetSrdExd:Str12;            procedure SetSrdExd(pValue:Str12);
    function GetSrdDte:TDatetime;        procedure SetSrdDte(pValue:TDatetime);
    function GetSrdVal:double;           procedure SetSrdVal(pValue:double);
    function GetCasNum:word;             procedure SetCasNum(pValue:word);
    function GetCasDte:TDatetime;        procedure SetCasDte(pValue:TDatetime);
    function GetCasTim:TDatetime;        procedure SetCasTim(pValue:TDatetime);
    function GetErrCod:longint;          procedure SetErrCod(pValue:longint);
    function GetErrDes:Str200;           procedure SetErrDes(pValue:Str200);
    function GetPayCsh:double;           procedure SetPayCsh(pValue:double);
    function GetPayCrd:double;           procedure SetPayCrd(pValue:double);
    function GetPayOth:double;           procedure SetPayOth(pValue:double);
    function GetCrtUsr:Str10;            procedure SetCrtUsr(pValue:Str10);
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
    function LocDyDs(pDocYer:Str2;pDocSer:longint):boolean;
    function LocDocSer(pDocSer:longint):boolean;
    function LocCasNum(pCasNum:word):boolean;
    function LocCnDs(pCasNum:word;pDocSta:byte):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function LocRegIno(pRegIno:Str10):boolean;
    function LocRegTin(pRegTin:Str15):boolean;
    function LocCusCrd(pCusCrd:Str20):boolean;
    function LocDocSta(pDocSta:byte):boolean;
    function LocCrtDte(pCrtDte:TDatetime):boolean;
    function NearDyDs(pDocYer:Str2;pDocSer:longint):boolean;
    function NearDocSer(pDocSer:longint):boolean;
    function NearCasNum(pCasNum:word):boolean;
    function NearCnDs(pCasNum:word;pDocSta:byte):boolean;
    function NearParNam(pParNam_:Str60):boolean;
    function NearRegIno(pRegIno:Str10):boolean;
    function NearRegTin(pRegTin:Str15):boolean;
    function NearCusCrd(pCusCrd:Str20):boolean;
    function NearDocSta(pDocSta:byte):boolean;
    function NearCrtDte(pCrtDte:TDatetime):boolean;

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
    property DocSer:longint read GetDocSer write SetDocSer;
    property BlkNum:longint read GetBlkNum write SetBlkNum;
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property DocDes:Str60 read GetDocDes write SetDocDes;
    property DocUid:Str50 read GetDocUid write SetDocUid;
    property DocVal:double read GetDocVal write SetDocVal;
    property DocSta:byte read GetDocSta write SetDocSta;
    property DocStd:Str60 read GetDocStd write SetDocStd;
    property ComLin:Str250 read GetComLin write SetComLin;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property RegIno:Str10 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property CusCrd:Str20 read GetCusCrd write SetCusCrd;
    property SrdDoc:Str12 read GetSrdDoc write SetSrdDoc;
    property SrdExd:Str12 read GetSrdExd write SetSrdExd;
    property SrdDte:TDatetime read GetSrdDte write SetSrdDte;
    property SrdVal:double read GetSrdVal write SetSrdVal;
    property CasNum:word read GetCasNum write SetCasNum;
    property CasDte:TDatetime read GetCasDte write SetCasDte;
    property CasTim:TDatetime read GetCasTim write SetCasTim;
    property ErrCod:longint read GetErrCod write SetErrCod;
    property ErrDes:Str200 read GetErrDes write SetErrDes;
    property PayCsh:double read GetPayCsh write SetPayCsh;
    property PayCrd:double read GetPayCrd write SetPayCrd;
    property PayOth:double read GetPayOth write SetPayOth;
    property CrtUsr:Str10 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TEcmdocDat.Create;
begin
  oTable:=DatInit('ECMDOC',gPath.StkPath,Self);
end;

constructor TEcmdocDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ECMDOC',pPath,Self);
end;

destructor TEcmdocDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEcmdocDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEcmdocDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEcmdocDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TEcmdocDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TEcmdocDat.GetDocSer:longint;
begin
  Result:=oTable.FieldByName('DocSer').AsInteger;
end;

procedure TEcmdocDat.SetDocSer(pValue:longint);
begin
  oTable.FieldByName('DocSer').AsInteger:=pValue;
end;

function TEcmdocDat.GetBlkNum:longint;
begin
  Result:=oTable.FieldByName('BlkNum').AsInteger;
end;

procedure TEcmdocDat.SetBlkNum(pValue:longint);
begin
  oTable.FieldByName('BlkNum').AsInteger:=pValue;
end;

function TEcmdocDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TEcmdocDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TEcmdocDat.GetDocDes:Str60;
begin
  Result:=oTable.FieldByName('DocDes').AsString;
end;

procedure TEcmdocDat.SetDocDes(pValue:Str60);
begin
  oTable.FieldByName('DocDes').AsString:=pValue;
end;

function TEcmdocDat.GetDocUid:Str50;
begin
  Result:=oTable.FieldByName('DocUid').AsString;
end;

procedure TEcmdocDat.SetDocUid(pValue:Str50);
begin
  oTable.FieldByName('DocUid').AsString:=pValue;
end;

function TEcmdocDat.GetDocVal:double;
begin
  Result:=oTable.FieldByName('DocVal').AsFloat;
end;

procedure TEcmdocDat.SetDocVal(pValue:double);
begin
  oTable.FieldByName('DocVal').AsFloat:=pValue;
end;

function TEcmdocDat.GetDocSta:byte;
begin
  Result:=oTable.FieldByName('DocSta').AsInteger;
end;

procedure TEcmdocDat.SetDocSta(pValue:byte);
begin
  oTable.FieldByName('DocSta').AsInteger:=pValue;
end;

function TEcmdocDat.GetDocStd:Str60;
begin
  Result:=oTable.FieldByName('DocStd').AsString;
end;

procedure TEcmdocDat.SetDocStd(pValue:Str60);
begin
  oTable.FieldByName('DocStd').AsString:=pValue;
end;

function TEcmdocDat.GetComLin:Str250;
begin
  Result:=oTable.FieldByName('ComLin').AsString;
end;

procedure TEcmdocDat.SetComLin(pValue:Str250);
begin
  oTable.FieldByName('ComLin').AsString:=pValue;
end;

function TEcmdocDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TEcmdocDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEcmdocDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TEcmdocDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TEcmdocDat.GetRegIno:Str10;
begin
  Result:=oTable.FieldByName('RegIno').AsString;
end;

procedure TEcmdocDat.SetRegIno(pValue:Str10);
begin
  oTable.FieldByName('RegIno').AsString:=pValue;
end;

function TEcmdocDat.GetRegTin:Str15;
begin
  Result:=oTable.FieldByName('RegTin').AsString;
end;

procedure TEcmdocDat.SetRegTin(pValue:Str15);
begin
  oTable.FieldByName('RegTin').AsString:=pValue;
end;

function TEcmdocDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TEcmdocDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TEcmdocDat.GetCusCrd:Str20;
begin
  Result:=oTable.FieldByName('CusCrd').AsString;
end;

procedure TEcmdocDat.SetCusCrd(pValue:Str20);
begin
  oTable.FieldByName('CusCrd').AsString:=pValue;
end;

function TEcmdocDat.GetSrdDoc:Str12;
begin
  Result:=oTable.FieldByName('SrdDoc').AsString;
end;

procedure TEcmdocDat.SetSrdDoc(pValue:Str12);
begin
  oTable.FieldByName('SrdDoc').AsString:=pValue;
end;

function TEcmdocDat.GetSrdExd:Str12;
begin
  Result:=oTable.FieldByName('SrdExd').AsString;
end;

procedure TEcmdocDat.SetSrdExd(pValue:Str12);
begin
  oTable.FieldByName('SrdExd').AsString:=pValue;
end;

function TEcmdocDat.GetSrdDte:TDatetime;
begin
  Result:=oTable.FieldByName('SrdDte').AsDateTime;
end;

procedure TEcmdocDat.SetSrdDte(pValue:TDatetime);
begin
  oTable.FieldByName('SrdDte').AsDateTime:=pValue;
end;

function TEcmdocDat.GetSrdVal:double;
begin
  Result:=oTable.FieldByName('SrdVal').AsFloat;
end;

procedure TEcmdocDat.SetSrdVal(pValue:double);
begin
  oTable.FieldByName('SrdVal').AsFloat:=pValue;
end;

function TEcmdocDat.GetCasNum:word;
begin
  Result:=oTable.FieldByName('CasNum').AsInteger;
end;

procedure TEcmdocDat.SetCasNum(pValue:word);
begin
  oTable.FieldByName('CasNum').AsInteger:=pValue;
end;

function TEcmdocDat.GetCasDte:TDatetime;
begin
  Result:=oTable.FieldByName('CasDte').AsDateTime;
end;

procedure TEcmdocDat.SetCasDte(pValue:TDatetime);
begin
  oTable.FieldByName('CasDte').AsDateTime:=pValue;
end;

function TEcmdocDat.GetCasTim:TDatetime;
begin
  Result:=oTable.FieldByName('CasTim').AsDateTime;
end;

procedure TEcmdocDat.SetCasTim(pValue:TDatetime);
begin
  oTable.FieldByName('CasTim').AsDateTime:=pValue;
end;

function TEcmdocDat.GetErrCod:longint;
begin
  Result:=oTable.FieldByName('ErrCod').AsInteger;
end;

procedure TEcmdocDat.SetErrCod(pValue:longint);
begin
  oTable.FieldByName('ErrCod').AsInteger:=pValue;
end;

function TEcmdocDat.GetErrDes:Str200;
begin
  Result:=oTable.FieldByName('ErrDes').AsString;
end;

procedure TEcmdocDat.SetErrDes(pValue:Str200);
begin
  oTable.FieldByName('ErrDes').AsString:=pValue;
end;

function TEcmdocDat.GetPayCsh:double;
begin
  Result:=oTable.FieldByName('PayCsh').AsFloat;
end;

procedure TEcmdocDat.SetPayCsh(pValue:double);
begin
  oTable.FieldByName('PayCsh').AsFloat:=pValue;
end;

function TEcmdocDat.GetPayCrd:double;
begin
  Result:=oTable.FieldByName('PayCrd').AsFloat;
end;

procedure TEcmdocDat.SetPayCrd(pValue:double);
begin
  oTable.FieldByName('PayCrd').AsFloat:=pValue;
end;

function TEcmdocDat.GetPayOth:double;
begin
  Result:=oTable.FieldByName('PayOth').AsFloat;
end;

procedure TEcmdocDat.SetPayOth(pValue:double);
begin
  oTable.FieldByName('PayOth').AsFloat:=pValue;
end;

function TEcmdocDat.GetCrtUsr:Str10;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TEcmdocDat.SetCrtUsr(pValue:Str10);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TEcmdocDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TEcmdocDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TEcmdocDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TEcmdocDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TEcmdocDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TEcmdocDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEcmdocDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEcmdocDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEcmdocDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEcmdocDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEcmdocDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEcmdocDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEcmdocDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEcmdocDat.LocDyDs(pDocYer:Str2;pDocSer:longint):boolean;
begin
  SetIndex(ixDyDs);
  Result:=oTable.FindKey([pDocYer,pDocSer]);
end;

function TEcmdocDat.LocDocSer(pDocSer:longint):boolean;
begin
  SetIndex(ixDocSer);
  Result:=oTable.FindKey([pDocSer]);
end;

function TEcmdocDat.LocCasNum(pCasNum:word):boolean;
begin
  SetIndex(ixCasNum);
  Result:=oTable.FindKey([pCasNum]);
end;

function TEcmdocDat.LocCnDs(pCasNum:word;pDocSta:byte):boolean;
begin
  SetIndex(ixCnDs);
  Result:=oTable.FindKey([pCasNum,pDocSta]);
end;

function TEcmdocDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TEcmdocDat.LocRegIno(pRegIno:Str10):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindKey([pRegIno]);
end;

function TEcmdocDat.LocRegTin(pRegTin:Str15):boolean;
begin
  SetIndex(ixRegTin);
  Result:=oTable.FindKey([pRegTin]);
end;

function TEcmdocDat.LocCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindKey([pCusCrd]);
end;

function TEcmdocDat.LocDocSta(pDocSta:byte):boolean;
begin
  SetIndex(ixDocSta);
  Result:=oTable.FindKey([pDocSta]);
end;

function TEcmdocDat.LocCrtDte(pCrtDte:TDatetime):boolean;
begin
  SetIndex(ixCrtDte);
  Result:=oTable.FindKey([pCrtDte]);
end;

function TEcmdocDat.NearDyDs(pDocYer:Str2;pDocSer:longint):boolean;
begin
  SetIndex(ixDyDs);
  Result:=oTable.FindNearest([pDocYer,pDocSer]);
end;

function TEcmdocDat.NearDocSer(pDocSer:longint):boolean;
begin
  SetIndex(ixDocSer);
  Result:=oTable.FindNearest([pDocSer]);
end;

function TEcmdocDat.NearCasNum(pCasNum:word):boolean;
begin
  SetIndex(ixCasNum);
  Result:=oTable.FindNearest([pCasNum]);
end;

function TEcmdocDat.NearCnDs(pCasNum:word;pDocSta:byte):boolean;
begin
  SetIndex(ixCnDs);
  Result:=oTable.FindNearest([pCasNum,pDocSta]);
end;

function TEcmdocDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TEcmdocDat.NearRegIno(pRegIno:Str10):boolean;
begin
  SetIndex(ixRegIno);
  Result:=oTable.FindNearest([pRegIno]);
end;

function TEcmdocDat.NearRegTin(pRegTin:Str15):boolean;
begin
  SetIndex(ixRegTin);
  Result:=oTable.FindNearest([pRegTin]);
end;

function TEcmdocDat.NearCusCrd(pCusCrd:Str20):boolean;
begin
  SetIndex(ixCusCrd);
  Result:=oTable.FindNearest([pCusCrd]);
end;

function TEcmdocDat.NearDocSta(pDocSta:byte):boolean;
begin
  SetIndex(ixDocSta);
  Result:=oTable.FindNearest([pDocSta]);
end;

function TEcmdocDat.NearCrtDte(pCrtDte:TDatetime):boolean;
begin
  SetIndex(ixCrtDte);
  Result:=oTable.FindNearest([pCrtDte]);
end;

procedure TEcmdocDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEcmdocDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEcmdocDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEcmdocDat.Prior;
begin
  oTable.Prior;
end;

procedure TEcmdocDat.Next;
begin
  oTable.Next;
end;

procedure TEcmdocDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEcmdocDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEcmdocDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEcmdocDat.Edit;
begin
  oTable.Edit;
end;

procedure TEcmdocDat.Post;
begin
  oTable.Post;
end;

procedure TEcmdocDat.Delete;
begin
  oTable.Delete;
end;

procedure TEcmdocDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEcmdocDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEcmdocDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEcmdocDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEcmdocDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEcmdocDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
