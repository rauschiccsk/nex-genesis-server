unit dCRDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCrdNum='CrdNum';
  ixCrdNam='CrdNam';
  ixParNum='ParNum';
  ixParNam='ParNam';
  ixSended='Sended';
  ixCrdGrp='CrdGrp';
  ixCntNum='CntNum';
  ixEmlAdr='EmlAdr';

type
  TCrdlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetCrdNum:Str20;            procedure SetCrdNum(pValue:Str20);
    function GetCrdNam:Str30;            procedure SetCrdNam(pValue:Str30);
    function GetCrdNam_:Str30;           procedure SetCrdNam_(pValue:Str30);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str30;           procedure SetParNam_(pValue:Str30);
    function GetSended:boolean;          procedure SetSended(pValue:boolean);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetCrdTyp:Str1;             procedure SetCrdTyp(pValue:Str1);
    function GetDscTyp:Str5;             procedure SetDscTyp(pValue:Str5);
    function GetDscPrc:double;           procedure SetDscPrc(pValue:double);
    function GetDocVal:double;           procedure SetDocVal(pValue:double);
    function GetBonTrn:double;           procedure SetBonTrn(pValue:double);
    function GetBonVal:double;           procedure SetBonVal(pValue:double);
    function GetBegBon:word;             procedure SetBegBon(pValue:word);
    function GetInpBon:word;             procedure SetInpBon(pValue:word);
    function GetOutBon:word;             procedure SetOutBon(pValue:word);
    function GetCrdGrp:word;             procedure SetCrdGrp(pValue:word);
    function GetIdcNum:Str10;            procedure SetIdcNum(pValue:Str10);
    function GetActBon:word;             procedure SetActBon(pValue:word);
    function GetBegVal:double;           procedure SetBegVal(pValue:double);
    function GetNouVal:double;           procedure SetNouVal(pValue:double);
    function GetNebVal:double;           procedure SetNebVal(pValue:double);
    function GetTrnVal:double;           procedure SetTrnVal(pValue:double);
    function GetCntNum:longint;          procedure SetCntNum(pValue:longint);
    function GetEmlAdr:Str30;            procedure SetEmlAdr(pValue:Str30);
    function GetLasItm:word;             procedure SetLasItm(pValue:word);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
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
    function LocCrdNum(pCrdNum:Str20):boolean;
    function LocCrdNam(pCrdNam_:Str30):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str30):boolean;
    function LocSended(pSended:byte):boolean;
    function LocCrdGrp(pCrdGrp:word):boolean;
    function LocCntNum(pCntNum:longint):boolean;
    function LocEmlAdr(pEmlAdr:Str30):boolean;
    function NearCrdNum(pCrdNum:Str20):boolean;
    function NearCrdNam(pCrdNam_:Str30):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str30):boolean;
    function NearSended(pSended:byte):boolean;
    function NearCrdGrp(pCrdGrp:word):boolean;
    function NearCntNum(pCntNum:longint):boolean;
    function NearEmlAdr(pEmlAdr:Str30):boolean;

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
    property CrdNum:Str20 read GetCrdNum write SetCrdNum;
    property CrdNam:Str30 read GetCrdNam write SetCrdNam;
    property CrdNam_:Str30 read GetCrdNam_ write SetCrdNam_;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str30 read GetParNam_ write SetParNam_;
    property Sended:boolean read GetSended write SetSended;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property CrdTyp:Str1 read GetCrdTyp write SetCrdTyp;
    property DscTyp:Str5 read GetDscTyp write SetDscTyp;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DocVal:double read GetDocVal write SetDocVal;
    property BonTrn:double read GetBonTrn write SetBonTrn;
    property BonVal:double read GetBonVal write SetBonVal;
    property BegBon:word read GetBegBon write SetBegBon;
    property InpBon:word read GetInpBon write SetInpBon;
    property OutBon:word read GetOutBon write SetOutBon;
    property CrdGrp:word read GetCrdGrp write SetCrdGrp;
    property IdcNum:Str10 read GetIdcNum write SetIdcNum;
    property ActBon:word read GetActBon write SetActBon;
    property BegVal:double read GetBegVal write SetBegVal;
    property NouVal:double read GetNouVal write SetNouVal;
    property NebVal:double read GetNebVal write SetNebVal;
    property TrnVal:double read GetTrnVal write SetTrnVal;
    property CntNum:longint read GetCntNum write SetCntNum;
    property EmlAdr:Str30 read GetEmlAdr write SetEmlAdr;
    property LasItm:word read GetLasItm write SetLasItm;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
  end;

implementation

constructor TCrdlstDat.Create;
begin
  oTable:=DatInit('CRDLST',gPath.DlsPath,Self);
end;

constructor TCrdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('CRDLST',pPath,Self);
end;

destructor TCrdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TCrdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TCrdlstDat.GetCrdNum:Str20;
begin
  Result:=oTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdlstDat.SetCrdNum(pValue:Str20);
begin
  oTable.FieldByName('CrdNum').AsString:=pValue;
end;

function TCrdlstDat.GetCrdNam:Str30;
begin
  Result:=oTable.FieldByName('CrdNam').AsString;
end;

procedure TCrdlstDat.SetCrdNam(pValue:Str30);
begin
  oTable.FieldByName('CrdNam').AsString:=pValue;
end;

function TCrdlstDat.GetCrdNam_:Str30;
begin
  Result:=oTable.FieldByName('CrdNam_').AsString;
end;

procedure TCrdlstDat.SetCrdNam_(pValue:Str30);
begin
  oTable.FieldByName('CrdNam_').AsString:=pValue;
end;

function TCrdlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TCrdlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TCrdlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TCrdlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TCrdlstDat.GetParNam_:Str30;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TCrdlstDat.SetParNam_(pValue:Str30);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TCrdlstDat.GetSended:boolean;
begin
  Result:=ByteToBool(oTable.FieldByName('Sended').AsInteger);
end;

procedure TCrdlstDat.SetSended(pValue:boolean);
begin
  oTable.FieldByName('Sended').AsInteger:=BoolToByte(pValue);
end;

function TCrdlstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TCrdlstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TCrdlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TCrdlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TCrdlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TCrdlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TCrdlstDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TCrdlstDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TCrdlstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TCrdlstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TCrdlstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TCrdlstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

function TCrdlstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TCrdlstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TCrdlstDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TCrdlstDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TCrdlstDat.GetCrdTyp:Str1;
begin
  Result:=oTable.FieldByName('CrdTyp').AsString;
end;

procedure TCrdlstDat.SetCrdTyp(pValue:Str1);
begin
  oTable.FieldByName('CrdTyp').AsString:=pValue;
end;

function TCrdlstDat.GetDscTyp:Str5;
begin
  Result:=oTable.FieldByName('DscTyp').AsString;
end;

procedure TCrdlstDat.SetDscTyp(pValue:Str5);
begin
  oTable.FieldByName('DscTyp').AsString:=pValue;
end;

function TCrdlstDat.GetDscPrc:double;
begin
  Result:=oTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCrdlstDat.SetDscPrc(pValue:double);
begin
  oTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TCrdlstDat.GetDocVal:double;
begin
  Result:=oTable.FieldByName('DocVal').AsFloat;
end;

procedure TCrdlstDat.SetDocVal(pValue:double);
begin
  oTable.FieldByName('DocVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetBonTrn:double;
begin
  Result:=oTable.FieldByName('BonTrn').AsFloat;
end;

procedure TCrdlstDat.SetBonTrn(pValue:double);
begin
  oTable.FieldByName('BonTrn').AsFloat:=pValue;
end;

function TCrdlstDat.GetBonVal:double;
begin
  Result:=oTable.FieldByName('BonVal').AsFloat;
end;

procedure TCrdlstDat.SetBonVal(pValue:double);
begin
  oTable.FieldByName('BonVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetBegBon:word;
begin
  Result:=oTable.FieldByName('BegBon').AsInteger;
end;

procedure TCrdlstDat.SetBegBon(pValue:word);
begin
  oTable.FieldByName('BegBon').AsInteger:=pValue;
end;

function TCrdlstDat.GetInpBon:word;
begin
  Result:=oTable.FieldByName('InpBon').AsInteger;
end;

procedure TCrdlstDat.SetInpBon(pValue:word);
begin
  oTable.FieldByName('InpBon').AsInteger:=pValue;
end;

function TCrdlstDat.GetOutBon:word;
begin
  Result:=oTable.FieldByName('OutBon').AsInteger;
end;

procedure TCrdlstDat.SetOutBon(pValue:word);
begin
  oTable.FieldByName('OutBon').AsInteger:=pValue;
end;

function TCrdlstDat.GetCrdGrp:word;
begin
  Result:=oTable.FieldByName('CrdGrp').AsInteger;
end;

procedure TCrdlstDat.SetCrdGrp(pValue:word);
begin
  oTable.FieldByName('CrdGrp').AsInteger:=pValue;
end;

function TCrdlstDat.GetIdcNum:Str10;
begin
  Result:=oTable.FieldByName('IdcNum').AsString;
end;

procedure TCrdlstDat.SetIdcNum(pValue:Str10);
begin
  oTable.FieldByName('IdcNum').AsString:=pValue;
end;

function TCrdlstDat.GetActBon:word;
begin
  Result:=oTable.FieldByName('ActBon').AsInteger;
end;

procedure TCrdlstDat.SetActBon(pValue:word);
begin
  oTable.FieldByName('ActBon').AsInteger:=pValue;
end;

function TCrdlstDat.GetBegVal:double;
begin
  Result:=oTable.FieldByName('BegVal').AsFloat;
end;

procedure TCrdlstDat.SetBegVal(pValue:double);
begin
  oTable.FieldByName('BegVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetNouVal:double;
begin
  Result:=oTable.FieldByName('NouVal').AsFloat;
end;

procedure TCrdlstDat.SetNouVal(pValue:double);
begin
  oTable.FieldByName('NouVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetNebVal:double;
begin
  Result:=oTable.FieldByName('NebVal').AsFloat;
end;

procedure TCrdlstDat.SetNebVal(pValue:double);
begin
  oTable.FieldByName('NebVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetTrnVal:double;
begin
  Result:=oTable.FieldByName('TrnVal').AsFloat;
end;

procedure TCrdlstDat.SetTrnVal(pValue:double);
begin
  oTable.FieldByName('TrnVal').AsFloat:=pValue;
end;

function TCrdlstDat.GetCntNum:longint;
begin
  Result:=oTable.FieldByName('CntNum').AsInteger;
end;

procedure TCrdlstDat.SetCntNum(pValue:longint);
begin
  oTable.FieldByName('CntNum').AsInteger:=pValue;
end;

function TCrdlstDat.GetEmlAdr:Str30;
begin
  Result:=oTable.FieldByName('EmlAdr').AsString;
end;

procedure TCrdlstDat.SetEmlAdr(pValue:Str30);
begin
  oTable.FieldByName('EmlAdr').AsString:=pValue;
end;

function TCrdlstDat.GetLasItm:word;
begin
  Result:=oTable.FieldByName('LasItm').AsInteger;
end;

procedure TCrdlstDat.SetLasItm(pValue:word);
begin
  oTable.FieldByName('LasItm').AsInteger:=pValue;
end;

function TCrdlstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCrdlstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TCrdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TCrdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TCrdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TCrdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TCrdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TCrdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TCrdlstDat.LocCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindKey([pCrdNum]);
end;

function TCrdlstDat.LocCrdNam(pCrdNam_:Str30):boolean;
begin
  SetIndex(ixCrdNam);
  Result:=oTable.FindKey([StrToAlias(pCrdNam_)]);
end;

function TCrdlstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TCrdlstDat.LocParNam(pParNam_:Str30):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TCrdlstDat.LocSended(pSended:byte):boolean;
begin
  SetIndex(ixSended);
  Result:=oTable.FindKey([pSended]);
end;

function TCrdlstDat.LocCrdGrp(pCrdGrp:word):boolean;
begin
  SetIndex(ixCrdGrp);
  Result:=oTable.FindKey([pCrdGrp]);
end;

function TCrdlstDat.LocCntNum(pCntNum:longint):boolean;
begin
  SetIndex(ixCntNum);
  Result:=oTable.FindKey([pCntNum]);
end;

function TCrdlstDat.LocEmlAdr(pEmlAdr:Str30):boolean;
begin
  SetIndex(ixEmlAdr);
  Result:=oTable.FindKey([pEmlAdr]);
end;

function TCrdlstDat.NearCrdNum(pCrdNum:Str20):boolean;
begin
  SetIndex(ixCrdNum);
  Result:=oTable.FindNearest([pCrdNum]);
end;

function TCrdlstDat.NearCrdNam(pCrdNam_:Str30):boolean;
begin
  SetIndex(ixCrdNam);
  Result:=oTable.FindNearest([pCrdNam_]);
end;

function TCrdlstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TCrdlstDat.NearParNam(pParNam_:Str30):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

function TCrdlstDat.NearSended(pSended:byte):boolean;
begin
  SetIndex(ixSended);
  Result:=oTable.FindNearest([pSended]);
end;

function TCrdlstDat.NearCrdGrp(pCrdGrp:word):boolean;
begin
  SetIndex(ixCrdGrp);
  Result:=oTable.FindNearest([pCrdGrp]);
end;

function TCrdlstDat.NearCntNum(pCntNum:longint):boolean;
begin
  SetIndex(ixCntNum);
  Result:=oTable.FindNearest([pCntNum]);
end;

function TCrdlstDat.NearEmlAdr(pEmlAdr:Str30):boolean;
begin
  SetIndex(ixEmlAdr);
  Result:=oTable.FindNearest([pEmlAdr]);
end;

procedure TCrdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TCrdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TCrdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TCrdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TCrdlstDat.Next;
begin
  oTable.Next;
end;

procedure TCrdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TCrdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TCrdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TCrdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TCrdlstDat.Post;
begin
  oTable.Post;
end;

procedure TCrdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TCrdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TCrdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TCrdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TCrdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TCrdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TCrdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
