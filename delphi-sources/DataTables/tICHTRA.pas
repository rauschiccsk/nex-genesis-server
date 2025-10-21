unit tICHTRA;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnAsAa='';
  ixDocNum='DocNum';
  ixSerNum='SerNum';
  ixExtNum='ExtNum';
  ixDocDate='DocDate';
  ixPaName_='PaName_';
  ixOcdNum='OcdNum';
  ixSndDate='SndDate';
  ixExpDate='ExpDate';
  ixAcBValue='AcBValue';
  ixFgBValue='FgBValue';
  ixFgPayVal='FgPayVal';
  ixFgEndVal='FgEndVal';
  ixPaCode='PaCode';

type
  TIchtraTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetYear:Str2;               procedure SetYear (pValue:Str2);
    function GetSerNum:longint;          procedure SetSerNum (pValue:longint);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetSndDate:TDatetime;       procedure SetSndDate (pValue:TDatetime);
    function GetExpDate:TDatetime;       procedure SetExpDate (pValue:TDatetime);
    function GetVatDate:TDatetime;       procedure SetVatDate (pValue:TDatetime);
    function GetPayDate:TDatetime;       procedure SetPayDate (pValue:TDatetime);
    function GetCsyCode:Str4;            procedure SetCsyCode (pValue:Str4);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetMyConto:Str30;           procedure SetMyConto (pValue:Str30);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetPaName:Str30;            procedure SetPaName (pValue:Str30);
    function GetPaName_:Str30;           procedure SetPaName_ (pValue:Str30);
    function GetRegName:Str60;           procedure SetRegName (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAddr:Str30;           procedure SetRegAddr (pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetRegStn:Str30;            procedure SetRegStn (pValue:Str30);
    function GetRegCty:Str3;             procedure SetRegCty (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetPayMode:byte;            procedure SetPayMode (pValue:byte);
    function GetSpaCode:longint;         procedure SetSpaCode (pValue:longint);
    function GetWpaCode:word;            procedure SetWpaCode (pValue:word);
    function GetWpaName:Str60;           procedure SetWpaName (pValue:Str60);
    function GetWpaAddr:Str30;           procedure SetWpaAddr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaStn:Str30;            procedure SetWpaStn (pValue:Str30);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
    function GetTrsCode:Str3;            procedure SetTrsCode (pValue:Str3);
    function GetTrsName:Str20;           procedure SetTrsName (pValue:Str20);
    function GetRspName:Str20;           procedure SetRspName (pValue:Str20);
    function GetPlsNum:word;             procedure SetPlsNum (pValue:word);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetHdsPrc:double;           procedure SetHdsPrc (pValue:double);
    function GetVatPrc1:byte;            procedure SetVatPrc1 (pValue:byte);
    function GetVatPrc2:byte;            procedure SetVatPrc2 (pValue:byte);
    function GetVatPrc3:byte;            procedure SetVatPrc3 (pValue:byte);
    function GetVatPrc4:byte;            procedure SetVatPrc4 (pValue:byte);
    function GetVatPrc5:byte;            procedure SetVatPrc5 (pValue:byte);
    function GetAcDvzName:Str3;          procedure SetAcDvzName (pValue:Str3);
    function GetAcCValue:double;         procedure SetAcCValue (pValue:double);
    function GetAcDValue:double;         procedure SetAcDValue (pValue:double);
    function GetAcDscVal:double;         procedure SetAcDscVal (pValue:double);
    function GetAcAValue:double;         procedure SetAcAValue (pValue:double);
    function GetAcVatVal:double;         procedure SetAcVatVal (pValue:double);
    function GetAcBValue:double;         procedure SetAcBValue (pValue:double);
    function GetAcPValue:double;         procedure SetAcPValue (pValue:double);
    function GetAcPrvPay:double;         procedure SetAcPrvPay (pValue:double);
    function GetAcPayVal:double;         procedure SetAcPayVal (pValue:double);
    function GetAcApyVal:double;         procedure SetAcApyVal (pValue:double);
    function GetAcEndVal:double;         procedure SetAcEndVal (pValue:double);
    function GetAcAenVal:double;         procedure SetAcAenVal (pValue:double);
    function GetAcAValue1:double;        procedure SetAcAValue1 (pValue:double);
    function GetAcAValue2:double;        procedure SetAcAValue2 (pValue:double);
    function GetAcAValue3:double;        procedure SetAcAValue3 (pValue:double);
    function GetAcAValue4:double;        procedure SetAcAValue4 (pValue:double);
    function GetAcAValue5:double;        procedure SetAcAValue5 (pValue:double);
    function GetAcBValue1:double;        procedure SetAcBValue1 (pValue:double);
    function GetAcBValue2:double;        procedure SetAcBValue2 (pValue:double);
    function GetAcBValue3:double;        procedure SetAcBValue3 (pValue:double);
    function GetAcBValue4:double;        procedure SetAcBValue4 (pValue:double);
    function GetAcBValue5:double;        procedure SetAcBValue5 (pValue:double);
    function GetAcRndVat:double;         procedure SetAcRndVat (pValue:double);
    function GetAcRndVal:double;         procedure SetAcRndVal (pValue:double);
    function GetFgDvzName:Str3;          procedure SetFgDvzName (pValue:Str3);
    function GetFgCourse:double;         procedure SetFgCourse (pValue:double);
    function GetFgCValue:double;         procedure SetFgCValue (pValue:double);
    function GetFgDValue:double;         procedure SetFgDValue (pValue:double);
    function GetFgDBValue:double;        procedure SetFgDBValue (pValue:double);
    function GetFgDscVal:double;         procedure SetFgDscVal (pValue:double);
    function GetFgDscBVal:double;        procedure SetFgDscBVal (pValue:double);
    function GetFgHdsVal:double;         procedure SetFgHdsVal (pValue:double);
    function GetFgAValue:double;         procedure SetFgAValue (pValue:double);
    function GetFgVatVal:double;         procedure SetFgVatVal (pValue:double);
    function GetFgBValue:double;         procedure SetFgBValue (pValue:double);
    function GetFgPValue:double;         procedure SetFgPValue (pValue:double);
    function GetFgPrvPay:double;         procedure SetFgPrvPay (pValue:double);
    function GetFgPayVal:double;         procedure SetFgPayVal (pValue:double);
    function GetFgApyVal:double;         procedure SetFgApyVal (pValue:double);
    function GetFgEndVal:double;         procedure SetFgEndVal (pValue:double);
    function GetFgAValue1:double;        procedure SetFgAValue1 (pValue:double);
    function GetFgAValue2:double;        procedure SetFgAValue2 (pValue:double);
    function GetFgAValue3:double;        procedure SetFgAValue3 (pValue:double);
    function GetFgAValue4:double;        procedure SetFgAValue4 (pValue:double);
    function GetFgAValue5:double;        procedure SetFgAValue5 (pValue:double);
    function GetFgBValue1:double;        procedure SetFgBValue1 (pValue:double);
    function GetFgBValue2:double;        procedure SetFgBValue2 (pValue:double);
    function GetFgBValue3:double;        procedure SetFgBValue3 (pValue:double);
    function GetFgBValue4:double;        procedure SetFgBValue4 (pValue:double);
    function GetFgBValue5:double;        procedure SetFgBValue5 (pValue:double);
    function GetFgVatVal1:double;        procedure SetFgVatVal1 (pValue:double);
    function GetFgVatVal2:double;        procedure SetFgVatVal2 (pValue:double);
    function GetFgVatVal3:double;        procedure SetFgVatVal3 (pValue:double);
    function GetFgVatVal4:double;        procedure SetFgVatVal4 (pValue:double);
    function GetFgVatVal5:double;        procedure SetFgVatVal5 (pValue:double);
    function GetFgRndVat:double;         procedure SetFgRndVat (pValue:double);
    function GetFgRndVal:double;         procedure SetFgRndVal (pValue:double);
    function GetRcvName:Str30;           procedure SetRcvName (pValue:Str30);
    function GetDlrCode:word;            procedure SetDlrCode (pValue:word);
    function GetSteCode:word;            procedure SetSteCode (pValue:word);
    function GetCusCard:Str20;           procedure SetCusCard (pValue:Str20);
    function GetVatDoc:byte;             procedure SetVatDoc (pValue:byte);
    function GetDocSpc:byte;             procedure SetDocSpc (pValue:byte);
    function GetTcdNum:Str15;            procedure SetTcdNum (pValue:Str15);
    function GetPrnCnt:byte;             procedure SetPrnCnt (pValue:byte);
    function GetItmQnt:word;             procedure SetItmQnt (pValue:word);
    function GetDstPair:Str1;            procedure SetDstPair (pValue:Str1);
    function GetDstPay:byte;             procedure SetDstPay (pValue:byte);
    function GetDstLck:byte;             procedure SetDstLck (pValue:byte);
    function GetDstCls:byte;             procedure SetDstCls (pValue:byte);
    function GetDstAcc:Str1;             procedure SetDstAcc (pValue:Str1);
    function GetVatDis:byte;             procedure SetVatDis (pValue:byte);
    function GetSended:boolean;          procedure SetSended (pValue:boolean);
    function GetCrcVal:double;           procedure SetCrcVal (pValue:double);
    function GetCrCard:Str20;            procedure SetCrCard (pValue:Str20);
    function GetSpMark:Str10;            procedure SetSpMark (pValue:Str10);
    function GetBonNum:byte;             procedure SetBonNum (pValue:byte);
    function GetSndNum:word;             procedure SetSndNum (pValue:word);
    function GetWrnNum:byte;             procedure SetWrnNum (pValue:byte);
    function GetWrnDate:TDatetime;       procedure SetWrnDate (pValue:TDatetime);
    function GetCsgNum:Str15;            procedure SetCsgNum (pValue:Str15);
    function GetEmlDate:TDatetime;       procedure SetEmlDate (pValue:TDatetime);
    function GetEmlAddr:Str30;           procedure SetEmlAddr (pValue:Str30);
    function GetSndStat:Str1;            procedure SetSndStat (pValue:Str1);
    function GetPrjCode:Str12;           procedure SetPrjCode (pValue:Str12);
    function GetDlrName:Str30;           procedure SetDlrName (pValue:Str30);
    function GetVolume:double;           procedure SetVolume (pValue:double);
    function GetWeight:double;           procedure SetWeight (pValue:double);
    function GetQntSum:double;           procedure SetQntSum (pValue:double);
    function GetWeightLst:Str200;        procedure SetWeightLst (pValue:Str200);
    function GetPckNote:Str250;          procedure SetPckNote (pValue:Str250);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDnAsAa (pDocNum:Str12):boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocSerNum (pSerNum:longint):boolean;
    function LocExtNum (pExtNum:Str12):boolean;
    function LocDocDate (pDocDate:TDatetime):boolean;
    function LocPaName_ (pPaName_:Str30):boolean;
    function LocOcdNum (pOcdNum:Str12):boolean;
    function LocSndDate (pSndDate:TDatetime):boolean;
    function LocExpDate (pExpDate:TDatetime):boolean;
    function LocAcBValue (pAcBValue:double):boolean;
    function LocFgBValue (pFgBValue:double):boolean;
    function LocFgPayVal (pFgPayVal:double):boolean;
    function LocFgEndVal (pFgEndVal:double):boolean;
    function LocPaCode (pPaCode:longint):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property Year:Str2 read GetYear write SetYear;
    property SerNum:longint read GetSerNum write SetSerNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property SndDate:TDatetime read GetSndDate write SetSndDate;
    property ExpDate:TDatetime read GetExpDate write SetExpDate;
    property VatDate:TDatetime read GetVatDate write SetVatDate;
    property PayDate:TDatetime read GetPayDate write SetPayDate;
    property CsyCode:Str4 read GetCsyCode write SetCsyCode;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property MyConto:Str30 read GetMyConto write SetMyConto;
    property PaCode:longint read GetPaCode write SetPaCode;
    property PaName:Str30 read GetPaName write SetPaName;
    property PaName_:Str30 read GetPaName_ write SetPaName_;
    property RegName:Str60 read GetRegName write SetRegName;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAddr:Str30 read GetRegAddr write SetRegAddr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegStn:Str30 read GetRegStn write SetRegStn;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property PayMode:byte read GetPayMode write SetPayMode;
    property SpaCode:longint read GetSpaCode write SetSpaCode;
    property WpaCode:word read GetWpaCode write SetWpaCode;
    property WpaName:Str60 read GetWpaName write SetWpaName;
    property WpaAddr:Str30 read GetWpaAddr write SetWpaAddr;
    property WpaSta:Str2 read GetWpaSta write SetWpaSta;
    property WpaStn:Str30 read GetWpaStn write SetWpaStn;
    property WpaCty:Str3 read GetWpaCty write SetWpaCty;
    property WpaCtn:Str30 read GetWpaCtn write SetWpaCtn;
    property WpaZip:Str15 read GetWpaZip write SetWpaZip;
    property TrsCode:Str3 read GetTrsCode write SetTrsCode;
    property TrsName:Str20 read GetTrsName write SetTrsName;
    property RspName:Str20 read GetRspName write SetRspName;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property HdsPrc:double read GetHdsPrc write SetHdsPrc;
    property VatPrc1:byte read GetVatPrc1 write SetVatPrc1;
    property VatPrc2:byte read GetVatPrc2 write SetVatPrc2;
    property VatPrc3:byte read GetVatPrc3 write SetVatPrc3;
    property VatPrc4:byte read GetVatPrc4 write SetVatPrc4;
    property VatPrc5:byte read GetVatPrc5 write SetVatPrc5;
    property AcDvzName:Str3 read GetAcDvzName write SetAcDvzName;
    property AcCValue:double read GetAcCValue write SetAcCValue;
    property AcDValue:double read GetAcDValue write SetAcDValue;
    property AcDscVal:double read GetAcDscVal write SetAcDscVal;
    property AcAValue:double read GetAcAValue write SetAcAValue;
    property AcVatVal:double read GetAcVatVal write SetAcVatVal;
    property AcBValue:double read GetAcBValue write SetAcBValue;
    property AcPValue:double read GetAcPValue write SetAcPValue;
    property AcPrvPay:double read GetAcPrvPay write SetAcPrvPay;
    property AcPayVal:double read GetAcPayVal write SetAcPayVal;
    property AcApyVal:double read GetAcApyVal write SetAcApyVal;
    property AcEndVal:double read GetAcEndVal write SetAcEndVal;
    property AcAenVal:double read GetAcAenVal write SetAcAenVal;
    property AcAValue1:double read GetAcAValue1 write SetAcAValue1;
    property AcAValue2:double read GetAcAValue2 write SetAcAValue2;
    property AcAValue3:double read GetAcAValue3 write SetAcAValue3;
    property AcAValue4:double read GetAcAValue4 write SetAcAValue4;
    property AcAValue5:double read GetAcAValue5 write SetAcAValue5;
    property AcBValue1:double read GetAcBValue1 write SetAcBValue1;
    property AcBValue2:double read GetAcBValue2 write SetAcBValue2;
    property AcBValue3:double read GetAcBValue3 write SetAcBValue3;
    property AcBValue4:double read GetAcBValue4 write SetAcBValue4;
    property AcBValue5:double read GetAcBValue5 write SetAcBValue5;
    property AcRndVat:double read GetAcRndVat write SetAcRndVat;
    property AcRndVal:double read GetAcRndVal write SetAcRndVal;
    property FgDvzName:Str3 read GetFgDvzName write SetFgDvzName;
    property FgCourse:double read GetFgCourse write SetFgCourse;
    property FgCValue:double read GetFgCValue write SetFgCValue;
    property FgDValue:double read GetFgDValue write SetFgDValue;
    property FgDBValue:double read GetFgDBValue write SetFgDBValue;
    property FgDscVal:double read GetFgDscVal write SetFgDscVal;
    property FgDscBVal:double read GetFgDscBVal write SetFgDscBVal;
    property FgHdsVal:double read GetFgHdsVal write SetFgHdsVal;
    property FgAValue:double read GetFgAValue write SetFgAValue;
    property FgVatVal:double read GetFgVatVal write SetFgVatVal;
    property FgBValue:double read GetFgBValue write SetFgBValue;
    property FgPValue:double read GetFgPValue write SetFgPValue;
    property FgPrvPay:double read GetFgPrvPay write SetFgPrvPay;
    property FgPayVal:double read GetFgPayVal write SetFgPayVal;
    property FgApyVal:double read GetFgApyVal write SetFgApyVal;
    property FgEndVal:double read GetFgEndVal write SetFgEndVal;
    property FgAValue1:double read GetFgAValue1 write SetFgAValue1;
    property FgAValue2:double read GetFgAValue2 write SetFgAValue2;
    property FgAValue3:double read GetFgAValue3 write SetFgAValue3;
    property FgAValue4:double read GetFgAValue4 write SetFgAValue4;
    property FgAValue5:double read GetFgAValue5 write SetFgAValue5;
    property FgBValue1:double read GetFgBValue1 write SetFgBValue1;
    property FgBValue2:double read GetFgBValue2 write SetFgBValue2;
    property FgBValue3:double read GetFgBValue3 write SetFgBValue3;
    property FgBValue4:double read GetFgBValue4 write SetFgBValue4;
    property FgBValue5:double read GetFgBValue5 write SetFgBValue5;
    property FgVatVal1:double read GetFgVatVal1 write SetFgVatVal1;
    property FgVatVal2:double read GetFgVatVal2 write SetFgVatVal2;
    property FgVatVal3:double read GetFgVatVal3 write SetFgVatVal3;
    property FgVatVal4:double read GetFgVatVal4 write SetFgVatVal4;
    property FgVatVal5:double read GetFgVatVal5 write SetFgVatVal5;
    property FgRndVat:double read GetFgRndVat write SetFgRndVat;
    property FgRndVal:double read GetFgRndVal write SetFgRndVal;
    property RcvName:Str30 read GetRcvName write SetRcvName;
    property DlrCode:word read GetDlrCode write SetDlrCode;
    property SteCode:word read GetSteCode write SetSteCode;
    property CusCard:Str20 read GetCusCard write SetCusCard;
    property VatDoc:byte read GetVatDoc write SetVatDoc;
    property DocSpc:byte read GetDocSpc write SetDocSpc;
    property TcdNum:Str15 read GetTcdNum write SetTcdNum;
    property PrnCnt:byte read GetPrnCnt write SetPrnCnt;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property DstPair:Str1 read GetDstPair write SetDstPair;
    property DstPay:byte read GetDstPay write SetDstPay;
    property DstLck:byte read GetDstLck write SetDstLck;
    property DstCls:byte read GetDstCls write SetDstCls;
    property DstAcc:Str1 read GetDstAcc write SetDstAcc;
    property VatDis:byte read GetVatDis write SetVatDis;
    property Sended:boolean read GetSended write SetSended;
    property CrcVal:double read GetCrcVal write SetCrcVal;
    property CrCard:Str20 read GetCrCard write SetCrCard;
    property SpMark:Str10 read GetSpMark write SetSpMark;
    property BonNum:byte read GetBonNum write SetBonNum;
    property SndNum:word read GetSndNum write SetSndNum;
    property WrnNum:byte read GetWrnNum write SetWrnNum;
    property WrnDate:TDatetime read GetWrnDate write SetWrnDate;
    property CsgNum:Str15 read GetCsgNum write SetCsgNum;
    property EmlDate:TDatetime read GetEmlDate write SetEmlDate;
    property EmlAddr:Str30 read GetEmlAddr write SetEmlAddr;
    property SndStat:Str1 read GetSndStat write SetSndStat;
    property PrjCode:Str12 read GetPrjCode write SetPrjCode;
    property DlrName:Str30 read GetDlrName write SetDlrName;
    property Volume:double read GetVolume write SetVolume;
    property Weight:double read GetWeight write SetWeight;
    property QntSum:double read GetQntSum write SetQntSum;
    property WeightLst:Str200 read GetWeightLst write SetWeightLst;
    property PckNote:Str250 read GetPckNote write SetPckNote;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TIchtraTmp.Create;
begin
  oTmpTable:=TmpInit ('ICHTRA',Self);
end;

destructor TIchtraTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIchtraTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIchtraTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIchtraTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIchtraTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIchtraTmp.GetYear:Str2;
begin
  Result:=oTmpTable.FieldByName('Year').AsString;
end;

procedure TIchtraTmp.SetYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString:=pValue;
end;

function TIchtraTmp.GetSerNum:longint;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TIchtraTmp.SetSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIchtraTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TIchtraTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TIchtraTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TIchtraTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIchtraTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetSndDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('SndDate').AsDateTime;
end;

procedure TIchtraTmp.SetSndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SndDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetExpDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TIchtraTmp.SetExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetVatDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('VatDate').AsDateTime;
end;

procedure TIchtraTmp.SetVatDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('VatDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetPayDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('PayDate').AsDateTime;
end;

procedure TIchtraTmp.SetPayDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('PayDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetCsyCode:Str4;
begin
  Result:=oTmpTable.FieldByName('CsyCode').AsString;
end;

procedure TIchtraTmp.SetCsyCode(pValue:Str4);
begin
  oTmpTable.FieldByName('CsyCode').AsString:=pValue;
end;

function TIchtraTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIchtraTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIchtraTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetMyConto:Str30;
begin
  Result:=oTmpTable.FieldByName('MyConto').AsString;
end;

procedure TIchtraTmp.SetMyConto(pValue:Str30);
begin
  oTmpTable.FieldByName('MyConto').AsString:=pValue;
end;

function TIchtraTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIchtraTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TIchtraTmp.GetPaName:Str30;
begin
  Result:=oTmpTable.FieldByName('PaName').AsString;
end;

procedure TIchtraTmp.SetPaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString:=pValue;
end;

function TIchtraTmp.GetPaName_:Str30;
begin
  Result:=oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TIchtraTmp.SetPaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString:=pValue;
end;

function TIchtraTmp.GetRegName:Str60;
begin
  Result:=oTmpTable.FieldByName('RegName').AsString;
end;

procedure TIchtraTmp.SetRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString:=pValue;
end;

function TIchtraTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TIchtraTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TIchtraTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TIchtraTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TIchtraTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TIchtraTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TIchtraTmp.GetRegAddr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TIchtraTmp.SetRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString:=pValue;
end;

function TIchtraTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TIchtraTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TIchtraTmp.GetRegStn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TIchtraTmp.SetRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString:=pValue;
end;

function TIchtraTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TIchtraTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TIchtraTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TIchtraTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TIchtraTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TIchtraTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TIchtraTmp.GetPayMode:byte;
begin
  Result:=oTmpTable.FieldByName('PayMode').AsInteger;
end;

procedure TIchtraTmp.SetPayMode(pValue:byte);
begin
  oTmpTable.FieldByName('PayMode').AsInteger:=pValue;
end;

function TIchtraTmp.GetSpaCode:longint;
begin
  Result:=oTmpTable.FieldByName('SpaCode').AsInteger;
end;

procedure TIchtraTmp.SetSpaCode(pValue:longint);
begin
  oTmpTable.FieldByName('SpaCode').AsInteger:=pValue;
end;

function TIchtraTmp.GetWpaCode:word;
begin
  Result:=oTmpTable.FieldByName('WpaCode').AsInteger;
end;

procedure TIchtraTmp.SetWpaCode(pValue:word);
begin
  oTmpTable.FieldByName('WpaCode').AsInteger:=pValue;
end;

function TIchtraTmp.GetWpaName:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TIchtraTmp.SetWpaName(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaName').AsString:=pValue;
end;

function TIchtraTmp.GetWpaAddr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TIchtraTmp.SetWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString:=pValue;
end;

function TIchtraTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TIchtraTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TIchtraTmp.GetWpaStn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaStn').AsString;
end;

procedure TIchtraTmp.SetWpaStn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaStn').AsString:=pValue;
end;

function TIchtraTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TIchtraTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TIchtraTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TIchtraTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TIchtraTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TIchtraTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TIchtraTmp.GetTrsCode:Str3;
begin
  Result:=oTmpTable.FieldByName('TrsCode').AsString;
end;

procedure TIchtraTmp.SetTrsCode(pValue:Str3);
begin
  oTmpTable.FieldByName('TrsCode').AsString:=pValue;
end;

function TIchtraTmp.GetTrsName:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsName').AsString;
end;

procedure TIchtraTmp.SetTrsName(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsName').AsString:=pValue;
end;

function TIchtraTmp.GetRspName:Str20;
begin
  Result:=oTmpTable.FieldByName('RspName').AsString;
end;

procedure TIchtraTmp.SetRspName(pValue:Str20);
begin
  oTmpTable.FieldByName('RspName').AsString:=pValue;
end;

function TIchtraTmp.GetPlsNum:word;
begin
  Result:=oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TIchtraTmp.SetPlsNum(pValue:word);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TIchtraTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TIchtraTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIchtraTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIchtraTmp.GetHdsPrc:double;
begin
  Result:=oTmpTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TIchtraTmp.SetHdsPrc(pValue:double);
begin
  oTmpTable.FieldByName('HdsPrc').AsFloat:=pValue;
end;

function TIchtraTmp.GetVatPrc1:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIchtraTmp.SetVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger:=pValue;
end;

function TIchtraTmp.GetVatPrc2:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIchtraTmp.SetVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger:=pValue;
end;

function TIchtraTmp.GetVatPrc3:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIchtraTmp.SetVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger:=pValue;
end;

function TIchtraTmp.GetVatPrc4:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIchtraTmp.SetVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger:=pValue;
end;

function TIchtraTmp.GetVatPrc5:byte;
begin
  Result:=oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIchtraTmp.SetVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger:=pValue;
end;

function TIchtraTmp.GetAcDvzName:Str3;
begin
  Result:=oTmpTable.FieldByName('AcDvzName').AsString;
end;

procedure TIchtraTmp.SetAcDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('AcDvzName').AsString:=pValue;
end;

function TIchtraTmp.GetAcCValue:double;
begin
  Result:=oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIchtraTmp.SetAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcDValue:double;
begin
  Result:=oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIchtraTmp.SetAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcDscVal:double;
begin
  Result:=oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIchtraTmp.SetAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcVatVal:double;
begin
  Result:=oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIchtraTmp.SetAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcPValue:double;
begin
  Result:=oTmpTable.FieldByName('AcPValue').AsFloat;
end;

procedure TIchtraTmp.SetAcPValue(pValue:double);
begin
  oTmpTable.FieldByName('AcPValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcPrvPay:double;
begin
  Result:=oTmpTable.FieldByName('AcPrvPay').AsFloat;
end;

procedure TIchtraTmp.SetAcPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('AcPrvPay').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcPayVal:double;
begin
  Result:=oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TIchtraTmp.SetAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcApyVal:double;
begin
  Result:=oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TIchtraTmp.SetAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcEndVal:double;
begin
  Result:=oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TIchtraTmp.SetAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAenVal:double;
begin
  Result:=oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TIchtraTmp.SetAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue1:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue2:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue3:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue4:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcAValue5:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TIchtraTmp.SetAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue1:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue1').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue1').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue2:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue2').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue2').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue3:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue3').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue3').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue4:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue4').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue4').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcBValue5:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue5').AsFloat;
end;

procedure TIchtraTmp.SetAcBValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue5').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcRndVat:double;
begin
  Result:=oTmpTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TIchtraTmp.SetAcRndVat(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVat').AsFloat:=pValue;
end;

function TIchtraTmp.GetAcRndVal:double;
begin
  Result:=oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TIchtraTmp.SetAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgDvzName:Str3;
begin
  Result:=oTmpTable.FieldByName('FgDvzName').AsString;
end;

procedure TIchtraTmp.SetFgDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('FgDvzName').AsString:=pValue;
end;

function TIchtraTmp.GetFgCourse:double;
begin
  Result:=oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIchtraTmp.SetFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgCValue:double;
begin
  Result:=oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIchtraTmp.SetFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgDValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIchtraTmp.SetFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgDBValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDBValue').AsFloat;
end;

procedure TIchtraTmp.SetFgDBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDBValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgDscVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIchtraTmp.SetFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgDscBVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscBVal').AsFloat;
end;

procedure TIchtraTmp.SetFgDscBVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscBVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgHdsVal:double;
begin
  Result:=oTmpTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TIchtraTmp.SetFgHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHdsVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgPValue:double;
begin
  Result:=oTmpTable.FieldByName('FgPValue').AsFloat;
end;

procedure TIchtraTmp.SetFgPValue(pValue:double);
begin
  oTmpTable.FieldByName('FgPValue').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgPrvPay:double;
begin
  Result:=oTmpTable.FieldByName('FgPrvPay').AsFloat;
end;

procedure TIchtraTmp.SetFgPrvPay(pValue:double);
begin
  oTmpTable.FieldByName('FgPrvPay').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgPayVal:double;
begin
  Result:=oTmpTable.FieldByName('FgPayVal').AsFloat;
end;

procedure TIchtraTmp.SetFgPayVal(pValue:double);
begin
  oTmpTable.FieldByName('FgPayVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgApyVal:double;
begin
  Result:=oTmpTable.FieldByName('FgApyVal').AsFloat;
end;

procedure TIchtraTmp.SetFgApyVal(pValue:double);
begin
  oTmpTable.FieldByName('FgApyVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgEndVal:double;
begin
  Result:=oTmpTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TIchtraTmp.SetFgEndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgEndVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue1:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue1').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue1').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue2:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue2').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue2').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue3:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue3').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue3').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue4:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue4').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue4').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgAValue5:double;
begin
  Result:=oTmpTable.FieldByName('FgAValue5').AsFloat;
end;

procedure TIchtraTmp.SetFgAValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue5').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue1:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue1').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue1(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue1').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue2:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue2').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue2(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue2').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue3:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue3').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue3(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue3').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue4:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue4').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue4(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue4').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgBValue5:double;
begin
  Result:=oTmpTable.FieldByName('FgBValue5').AsFloat;
end;

procedure TIchtraTmp.SetFgBValue5(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue5').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal1:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal1').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal1').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal2:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal2').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal2').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal3:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal3').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal3').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal4:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal4').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal4').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgVatVal5:double;
begin
  Result:=oTmpTable.FieldByName('FgVatVal5').AsFloat;
end;

procedure TIchtraTmp.SetFgVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('FgVatVal5').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgRndVat:double;
begin
  Result:=oTmpTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TIchtraTmp.SetFgRndVat(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVat').AsFloat:=pValue;
end;

function TIchtraTmp.GetFgRndVal:double;
begin
  Result:=oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TIchtraTmp.SetFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetRcvName:Str30;
begin
  Result:=oTmpTable.FieldByName('RcvName').AsString;
end;

procedure TIchtraTmp.SetRcvName(pValue:Str30);
begin
  oTmpTable.FieldByName('RcvName').AsString:=pValue;
end;

function TIchtraTmp.GetDlrCode:word;
begin
  Result:=oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TIchtraTmp.SetDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger:=pValue;
end;

function TIchtraTmp.GetSteCode:word;
begin
  Result:=oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TIchtraTmp.SetSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger:=pValue;
end;

function TIchtraTmp.GetCusCard:Str20;
begin
  Result:=oTmpTable.FieldByName('CusCard').AsString;
end;

procedure TIchtraTmp.SetCusCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CusCard').AsString:=pValue;
end;

function TIchtraTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TIchtraTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TIchtraTmp.GetDocSpc:byte;
begin
  Result:=oTmpTable.FieldByName('DocSpc').AsInteger;
end;

procedure TIchtraTmp.SetDocSpc(pValue:byte);
begin
  oTmpTable.FieldByName('DocSpc').AsInteger:=pValue;
end;

function TIchtraTmp.GetTcdNum:Str15;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TIchtraTmp.SetTcdNum(pValue:Str15);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TIchtraTmp.GetPrnCnt:byte;
begin
  Result:=oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIchtraTmp.SetPrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger:=pValue;
end;

function TIchtraTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIchtraTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TIchtraTmp.GetDstPair:Str1;
begin
  Result:=oTmpTable.FieldByName('DstPair').AsString;
end;

procedure TIchtraTmp.SetDstPair(pValue:Str1);
begin
  oTmpTable.FieldByName('DstPair').AsString:=pValue;
end;

function TIchtraTmp.GetDstPay:byte;
begin
  Result:=oTmpTable.FieldByName('DstPay').AsInteger;
end;

procedure TIchtraTmp.SetDstPay(pValue:byte);
begin
  oTmpTable.FieldByName('DstPay').AsInteger:=pValue;
end;

function TIchtraTmp.GetDstLck:byte;
begin
  Result:=oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TIchtraTmp.SetDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger:=pValue;
end;

function TIchtraTmp.GetDstCls:byte;
begin
  Result:=oTmpTable.FieldByName('DstCls').AsInteger;
end;

procedure TIchtraTmp.SetDstCls(pValue:byte);
begin
  oTmpTable.FieldByName('DstCls').AsInteger:=pValue;
end;

function TIchtraTmp.GetDstAcc:Str1;
begin
  Result:=oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TIchtraTmp.SetDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString:=pValue;
end;

function TIchtraTmp.GetVatDis:byte;
begin
  Result:=oTmpTable.FieldByName('VatDis').AsInteger;
end;

procedure TIchtraTmp.SetVatDis(pValue:byte);
begin
  oTmpTable.FieldByName('VatDis').AsInteger:=pValue;
end;

function TIchtraTmp.GetSended:boolean;
begin
  Result:=ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TIchtraTmp.SetSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger:=BoolToByte(pValue);
end;

function TIchtraTmp.GetCrcVal:double;
begin
  Result:=oTmpTable.FieldByName('CrcVal').AsFloat;
end;

procedure TIchtraTmp.SetCrcVal(pValue:double);
begin
  oTmpTable.FieldByName('CrcVal').AsFloat:=pValue;
end;

function TIchtraTmp.GetCrCard:Str20;
begin
  Result:=oTmpTable.FieldByName('CrCard').AsString;
end;

procedure TIchtraTmp.SetCrCard(pValue:Str20);
begin
  oTmpTable.FieldByName('CrCard').AsString:=pValue;
end;

function TIchtraTmp.GetSpMark:Str10;
begin
  Result:=oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TIchtraTmp.SetSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString:=pValue;
end;

function TIchtraTmp.GetBonNum:byte;
begin
  Result:=oTmpTable.FieldByName('BonNum').AsInteger;
end;

procedure TIchtraTmp.SetBonNum(pValue:byte);
begin
  oTmpTable.FieldByName('BonNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetSndNum:word;
begin
  Result:=oTmpTable.FieldByName('SndNum').AsInteger;
end;

procedure TIchtraTmp.SetSndNum(pValue:word);
begin
  oTmpTable.FieldByName('SndNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetWrnNum:byte;
begin
  Result:=oTmpTable.FieldByName('WrnNum').AsInteger;
end;

procedure TIchtraTmp.SetWrnNum(pValue:byte);
begin
  oTmpTable.FieldByName('WrnNum').AsInteger:=pValue;
end;

function TIchtraTmp.GetWrnDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('WrnDate').AsDateTime;
end;

procedure TIchtraTmp.SetWrnDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('WrnDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetCsgNum:Str15;
begin
  Result:=oTmpTable.FieldByName('CsgNum').AsString;
end;

procedure TIchtraTmp.SetCsgNum(pValue:Str15);
begin
  oTmpTable.FieldByName('CsgNum').AsString:=pValue;
end;

function TIchtraTmp.GetEmlDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EmlDate').AsDateTime;
end;

procedure TIchtraTmp.SetEmlDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmlDate').AsDateTime:=pValue;
end;

function TIchtraTmp.GetEmlAddr:Str30;
begin
  Result:=oTmpTable.FieldByName('EmlAddr').AsString;
end;

procedure TIchtraTmp.SetEmlAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('EmlAddr').AsString:=pValue;
end;

function TIchtraTmp.GetSndStat:Str1;
begin
  Result:=oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TIchtraTmp.SetSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString:=pValue;
end;

function TIchtraTmp.GetPrjCode:Str12;
begin
  Result:=oTmpTable.FieldByName('PrjCode').AsString;
end;

procedure TIchtraTmp.SetPrjCode(pValue:Str12);
begin
  oTmpTable.FieldByName('PrjCode').AsString:=pValue;
end;

function TIchtraTmp.GetDlrName:Str30;
begin
  Result:=oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TIchtraTmp.SetDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString:=pValue;
end;

function TIchtraTmp.GetVolume:double;
begin
  Result:=oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TIchtraTmp.SetVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat:=pValue;
end;

function TIchtraTmp.GetWeight:double;
begin
  Result:=oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TIchtraTmp.SetWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat:=pValue;
end;

function TIchtraTmp.GetQntSum:double;
begin
  Result:=oTmpTable.FieldByName('QntSum').AsFloat;
end;

procedure TIchtraTmp.SetQntSum(pValue:double);
begin
  oTmpTable.FieldByName('QntSum').AsFloat:=pValue;
end;

function TIchtraTmp.GetWeightLst:Str200;
begin
  Result:=oTmpTable.FieldByName('WeightLst').AsString;
end;

procedure TIchtraTmp.SetWeightLst(pValue:Str200);
begin
  oTmpTable.FieldByName('WeightLst').AsString:=pValue;
end;

function TIchtraTmp.GetPckNote:Str250;
begin
  Result:=oTmpTable.FieldByName('PckNote').AsString;
end;

procedure TIchtraTmp.SetPckNote(pValue:Str250);
begin
  oTmpTable.FieldByName('PckNote').AsString:=pValue;
end;

function TIchtraTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIchtraTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIchtraTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIchtraTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIchtraTmp.LocDnAsAa(pDocNum:Str12):boolean;
begin
  SetIndex (ixDnAsAa);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TIchtraTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TIchtraTmp.LocSerNum(pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result:=oTmpTable.FindKey([pSerNum]);
end;

function TIchtraTmp.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result:=oTmpTable.FindKey([pExtNum]);
end;

function TIchtraTmp.LocDocDate(pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result:=oTmpTable.FindKey([pDocDate]);
end;

function TIchtraTmp.LocPaName_(pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result:=oTmpTable.FindKey([pPaName_]);
end;

function TIchtraTmp.LocOcdNum(pOcdNum:Str12):boolean;
begin
  SetIndex (ixOcdNum);
  Result:=oTmpTable.FindKey([pOcdNum]);
end;

function TIchtraTmp.LocSndDate(pSndDate:TDatetime):boolean;
begin
  SetIndex (ixSndDate);
  Result:=oTmpTable.FindKey([pSndDate]);
end;

function TIchtraTmp.LocExpDate(pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result:=oTmpTable.FindKey([pExpDate]);
end;

function TIchtraTmp.LocAcBValue(pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result:=oTmpTable.FindKey([pAcBValue]);
end;

function TIchtraTmp.LocFgBValue(pFgBValue:double):boolean;
begin
  SetIndex (ixFgBValue);
  Result:=oTmpTable.FindKey([pFgBValue]);
end;

function TIchtraTmp.LocFgPayVal(pFgPayVal:double):boolean;
begin
  SetIndex (ixFgPayVal);
  Result:=oTmpTable.FindKey([pFgPayVal]);
end;

function TIchtraTmp.LocFgEndVal(pFgEndVal:double):boolean;
begin
  SetIndex (ixFgEndVal);
  Result:=oTmpTable.FindKey([pFgEndVal]);
end;

function TIchtraTmp.LocPaCode(pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result:=oTmpTable.FindKey([pPaCode]);
end;

procedure TIchtraTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIchtraTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIchtraTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIchtraTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIchtraTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIchtraTmp.First;
begin
  oTmpTable.First;
end;

procedure TIchtraTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIchtraTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIchtraTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIchtraTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIchtraTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIchtraTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIchtraTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIchtraTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIchtraTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIchtraTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIchtraTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
