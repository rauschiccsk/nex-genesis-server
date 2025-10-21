unit tEXDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPnSnWn='';
  ixParNum='ParNum';
  ixParNam_='ParNam_';
  ixSalBva='SalBva';
  ixDvzBva='DvzBva';
  ixPqPn='PqPn';
  ixPgPn='PgPn';
  ixGenSta='GenSta';
  ixBokNum='BokNum';

type
  TExdlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetSpaNum:longint;          procedure SetSpaNum (pValue:longint);
    function GetWpaNum:word;             procedure SetWpaNum (pValue:word);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetRegIno:Str15;            procedure SetRegIno (pValue:Str15);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str30;            procedure SetRegAdr (pValue:Str30);
    function GetRegSta:Str2;             procedure SetRegSta (pValue:Str2);
    function GetRegCty:Str3;             procedure SetRegCty (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetWpaNam:Str60;            procedure SetWpaNam (pValue:Str60);
    function GetWpaAdr:Str30;            procedure SetWpaAdr (pValue:Str30);
    function GetWpaSta:Str2;             procedure SetWpaSta (pValue:Str2);
    function GetWpaCty:Str3;             procedure SetWpaCty (pValue:Str3);
    function GetWpaCtn:Str30;            procedure SetWpaCtn (pValue:Str30);
    function GetWpaZip:Str15;            procedure SetWpaZip (pValue:Str15);
    function GetPayCod:Str1;             procedure SetPayCod (pValue:Str1);
    function GetPayNam:Str20;            procedure SetPayNam (pValue:Str20);
    function GetTrsCod:Str1;             procedure SetTrsCod (pValue:Str1);
    function GetTrsNam:Str20;            procedure SetTrsNam (pValue:Str20);
    function GetProVol:double;           procedure SetProVol (pValue:double);
    function GetProWgh:double;           procedure SetProWgh (pValue:double);
    function GetProAva:double;           procedure SetProAva (pValue:double);
    function GetSrvAva:double;           procedure SetSrvAva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetVatVal:double;           procedure SetVatVal (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetTrsBva:double;           procedure SetTrsBva (pValue:double);
    function GetEndBva:double;           procedure SetEndBva (pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam (pValue:Str3);
    function GetDvzCrs:double;           procedure SetDvzCrs (pValue:double);
    function GetDvzBva:double;           procedure SetDvzBva (pValue:double);
    function GetItmQnt:word;             procedure SetItmQnt (pValue:word);
    function GetCmpQnt:word;             procedure SetCmpQnt (pValue:word);
    function GetProQnt:word;             procedure SetProQnt (pValue:word);
    function GetVatDoc:byte;             procedure SetVatDoc (pValue:byte);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetGenSta:Str1;             procedure SetGenSta (pValue:Str1);
    function GetGenNum:byte;             procedure SetGenNum (pValue:byte);
    function GetBokNum:Str5;             procedure SetBokNum (pValue:Str5);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPnSnWn (pParNum:longint;pSpaNum:longint;pWpaNum:word):boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocSalBva (pSalBva:double):boolean;
    function LocDvzBva (pDvzBva:double):boolean;
    function LocPqPn (pProQnt:word;pProNum:longint):boolean;
    function LocPgPn (pPgrNum:word;pProNum:longint):boolean;
    function LocGenSta (pGenSta:Str1):boolean;
    function LocBokNum (pBokNum:Str5):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property SpaNum:longint read GetSpaNum write SetSpaNum;
    property WpaNum:word read GetWpaNum write SetWpaNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property RegIno:Str15 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str30 read GetRegAdr write SetRegAdr;
    property RegSta:Str2 read GetRegSta write SetRegSta;
    property RegCty:Str3 read GetRegCty write SetRegCty;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property WpaNam:Str60 read GetWpaNam write SetWpaNam;
    property WpaAdr:Str30 read GetWpaAdr write SetWpaAdr;
    property WpaSta:Str2 read GetWpaSta write SetWpaSta;
    property WpaCty:Str3 read GetWpaCty write SetWpaCty;
    property WpaCtn:Str30 read GetWpaCtn write SetWpaCtn;
    property WpaZip:Str15 read GetWpaZip write SetWpaZip;
    property PayCod:Str1 read GetPayCod write SetPayCod;
    property PayNam:Str20 read GetPayNam write SetPayNam;
    property TrsCod:Str1 read GetTrsCod write SetTrsCod;
    property TrsNam:Str20 read GetTrsNam write SetTrsNam;
    property ProVol:double read GetProVol write SetProVol;
    property ProWgh:double read GetProWgh write SetProWgh;
    property ProAva:double read GetProAva write SetProAva;
    property SrvAva:double read GetSrvAva write SetSrvAva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
    property SalAva:double read GetSalAva write SetSalAva;
    property VatVal:double read GetVatVal write SetVatVal;
    property SalBva:double read GetSalBva write SetSalBva;
    property TrsBva:double read GetTrsBva write SetTrsBva;
    property EndBva:double read GetEndBva write SetEndBva;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DvzCrs:double read GetDvzCrs write SetDvzCrs;
    property DvzBva:double read GetDvzBva write SetDvzBva;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property CmpQnt:word read GetCmpQnt write SetCmpQnt;
    property ProQnt:word read GetProQnt write SetProQnt;
    property VatDoc:byte read GetVatDoc write SetVatDoc;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property ProNum:longint read GetProNum write SetProNum;
    property GenSta:Str1 read GetGenSta write SetGenSta;
    property GenNum:byte read GetGenNum write SetGenNum;
    property BokNum:Str5 read GetBokNum write SetBokNum;
  end;

implementation

constructor TExdlstTmp.Create;
begin
  oTmpTable:=TmpInit ('EXDLST',Self);
end;

destructor TExdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TExdlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TExdlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TExdlstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TExdlstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetSpaNum:longint;
begin
  Result:=oTmpTable.FieldByName('SpaNum').AsInteger;
end;

procedure TExdlstTmp.SetSpaNum(pValue:longint);
begin
  oTmpTable.FieldByName('SpaNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetWpaNum:word;
begin
  Result:=oTmpTable.FieldByName('WpaNum').AsInteger;
end;

procedure TExdlstTmp.SetWpaNum(pValue:word);
begin
  oTmpTable.FieldByName('WpaNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TExdlstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TExdlstTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TExdlstTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TExdlstTmp.GetRegIno:Str15;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TExdlstTmp.SetRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TExdlstTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TExdlstTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TExdlstTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TExdlstTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TExdlstTmp.GetRegAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TExdlstTmp.SetRegAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TExdlstTmp.GetRegSta:Str2;
begin
  Result:=oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TExdlstTmp.SetRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString:=pValue;
end;

function TExdlstTmp.GetRegCty:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TExdlstTmp.SetRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString:=pValue;
end;

function TExdlstTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TExdlstTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TExdlstTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TExdlstTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TExdlstTmp.GetWpaNam:Str60;
begin
  Result:=oTmpTable.FieldByName('WpaNam').AsString;
end;

procedure TExdlstTmp.SetWpaNam(pValue:Str60);
begin
  oTmpTable.FieldByName('WpaNam').AsString:=pValue;
end;

function TExdlstTmp.GetWpaAdr:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaAdr').AsString;
end;

procedure TExdlstTmp.SetWpaAdr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAdr').AsString:=pValue;
end;

function TExdlstTmp.GetWpaSta:Str2;
begin
  Result:=oTmpTable.FieldByName('WpaSta').AsString;
end;

procedure TExdlstTmp.SetWpaSta(pValue:Str2);
begin
  oTmpTable.FieldByName('WpaSta').AsString:=pValue;
end;

function TExdlstTmp.GetWpaCty:Str3;
begin
  Result:=oTmpTable.FieldByName('WpaCty').AsString;
end;

procedure TExdlstTmp.SetWpaCty(pValue:Str3);
begin
  oTmpTable.FieldByName('WpaCty').AsString:=pValue;
end;

function TExdlstTmp.GetWpaCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TExdlstTmp.SetWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString:=pValue;
end;

function TExdlstTmp.GetWpaZip:Str15;
begin
  Result:=oTmpTable.FieldByName('WpaZip').AsString;
end;

procedure TExdlstTmp.SetWpaZip(pValue:Str15);
begin
  oTmpTable.FieldByName('WpaZip').AsString:=pValue;
end;

function TExdlstTmp.GetPayCod:Str1;
begin
  Result:=oTmpTable.FieldByName('PayCod').AsString;
end;

procedure TExdlstTmp.SetPayCod(pValue:Str1);
begin
  oTmpTable.FieldByName('PayCod').AsString:=pValue;
end;

function TExdlstTmp.GetPayNam:Str20;
begin
  Result:=oTmpTable.FieldByName('PayNam').AsString;
end;

procedure TExdlstTmp.SetPayNam(pValue:Str20);
begin
  oTmpTable.FieldByName('PayNam').AsString:=pValue;
end;

function TExdlstTmp.GetTrsCod:Str1;
begin
  Result:=oTmpTable.FieldByName('TrsCod').AsString;
end;

procedure TExdlstTmp.SetTrsCod(pValue:Str1);
begin
  oTmpTable.FieldByName('TrsCod').AsString:=pValue;
end;

function TExdlstTmp.GetTrsNam:Str20;
begin
  Result:=oTmpTable.FieldByName('TrsNam').AsString;
end;

procedure TExdlstTmp.SetTrsNam(pValue:Str20);
begin
  oTmpTable.FieldByName('TrsNam').AsString:=pValue;
end;

function TExdlstTmp.GetProVol:double;
begin
  Result:=oTmpTable.FieldByName('ProVol').AsFloat;
end;

procedure TExdlstTmp.SetProVol(pValue:double);
begin
  oTmpTable.FieldByName('ProVol').AsFloat:=pValue;
end;

function TExdlstTmp.GetProWgh:double;
begin
  Result:=oTmpTable.FieldByName('ProWgh').AsFloat;
end;

procedure TExdlstTmp.SetProWgh(pValue:double);
begin
  oTmpTable.FieldByName('ProWgh').AsFloat:=pValue;
end;

function TExdlstTmp.GetProAva:double;
begin
  Result:=oTmpTable.FieldByName('ProAva').AsFloat;
end;

procedure TExdlstTmp.SetProAva(pValue:double);
begin
  oTmpTable.FieldByName('ProAva').AsFloat:=pValue;
end;

function TExdlstTmp.GetSrvAva:double;
begin
  Result:=oTmpTable.FieldByName('SrvAva').AsFloat;
end;

procedure TExdlstTmp.SetSrvAva(pValue:double);
begin
  oTmpTable.FieldByName('SrvAva').AsFloat:=pValue;
end;

function TExdlstTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TExdlstTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TExdlstTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TExdlstTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

function TExdlstTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TExdlstTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TExdlstTmp.GetVatVal:double;
begin
  Result:=oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TExdlstTmp.SetVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat:=pValue;
end;

function TExdlstTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TExdlstTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TExdlstTmp.GetTrsBva:double;
begin
  Result:=oTmpTable.FieldByName('TrsBva').AsFloat;
end;

procedure TExdlstTmp.SetTrsBva(pValue:double);
begin
  oTmpTable.FieldByName('TrsBva').AsFloat:=pValue;
end;

function TExdlstTmp.GetEndBva:double;
begin
  Result:=oTmpTable.FieldByName('EndBva').AsFloat;
end;

procedure TExdlstTmp.SetEndBva(pValue:double);
begin
  oTmpTable.FieldByName('EndBva').AsFloat:=pValue;
end;

function TExdlstTmp.GetDvzNam:Str3;
begin
  Result:=oTmpTable.FieldByName('DvzNam').AsString;
end;

procedure TExdlstTmp.SetDvzNam(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TExdlstTmp.GetDvzCrs:double;
begin
  Result:=oTmpTable.FieldByName('DvzCrs').AsFloat;
end;

procedure TExdlstTmp.SetDvzCrs(pValue:double);
begin
  oTmpTable.FieldByName('DvzCrs').AsFloat:=pValue;
end;

function TExdlstTmp.GetDvzBva:double;
begin
  Result:=oTmpTable.FieldByName('DvzBva').AsFloat;
end;

procedure TExdlstTmp.SetDvzBva(pValue:double);
begin
  oTmpTable.FieldByName('DvzBva').AsFloat:=pValue;
end;

function TExdlstTmp.GetItmQnt:word;
begin
  Result:=oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TExdlstTmp.SetItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TExdlstTmp.GetCmpQnt:word;
begin
  Result:=oTmpTable.FieldByName('CmpQnt').AsInteger;
end;

procedure TExdlstTmp.SetCmpQnt(pValue:word);
begin
  oTmpTable.FieldByName('CmpQnt').AsInteger:=pValue;
end;

function TExdlstTmp.GetProQnt:word;
begin
  Result:=oTmpTable.FieldByName('ProQnt').AsInteger;
end;

procedure TExdlstTmp.SetProQnt(pValue:word);
begin
  oTmpTable.FieldByName('ProQnt').AsInteger:=pValue;
end;

function TExdlstTmp.GetVatDoc:byte;
begin
  Result:=oTmpTable.FieldByName('VatDoc').AsInteger;
end;

procedure TExdlstTmp.SetVatDoc(pValue:byte);
begin
  oTmpTable.FieldByName('VatDoc').AsInteger:=pValue;
end;

function TExdlstTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TExdlstTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TExdlstTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetGenSta:Str1;
begin
  Result:=oTmpTable.FieldByName('GenSta').AsString;
end;

procedure TExdlstTmp.SetGenSta(pValue:Str1);
begin
  oTmpTable.FieldByName('GenSta').AsString:=pValue;
end;

function TExdlstTmp.GetGenNum:byte;
begin
  Result:=oTmpTable.FieldByName('GenNum').AsInteger;
end;

procedure TExdlstTmp.SetGenNum(pValue:byte);
begin
  oTmpTable.FieldByName('GenNum').AsInteger:=pValue;
end;

function TExdlstTmp.GetBokNum:Str5;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TExdlstTmp.SetBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TExdlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TExdlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TExdlstTmp.LocPnSnWn(pParNum:longint;pSpaNum:longint;pWpaNum:word):boolean;
begin
  SetIndex (ixPnSnWn);
  Result:=oTmpTable.FindKey([pParNum,pSpaNum,pWpaNum]);
end;

function TExdlstTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TExdlstTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TExdlstTmp.LocSalBva(pSalBva:double):boolean;
begin
  SetIndex (ixSalBva);
  Result:=oTmpTable.FindKey([pSalBva]);
end;

function TExdlstTmp.LocDvzBva(pDvzBva:double):boolean;
begin
  SetIndex (ixDvzBva);
  Result:=oTmpTable.FindKey([pDvzBva]);
end;

function TExdlstTmp.LocPqPn(pProQnt:word;pProNum:longint):boolean;
begin
  SetIndex (ixPqPn);
  Result:=oTmpTable.FindKey([pProQnt,pProNum]);
end;

function TExdlstTmp.LocPgPn(pPgrNum:word;pProNum:longint):boolean;
begin
  SetIndex (ixPgPn);
  Result:=oTmpTable.FindKey([pPgrNum,pProNum]);
end;

function TExdlstTmp.LocGenSta(pGenSta:Str1):boolean;
begin
  SetIndex (ixGenSta);
  Result:=oTmpTable.FindKey([pGenSta]);
end;

function TExdlstTmp.LocBokNum(pBokNum:Str5):boolean;
begin
  SetIndex (ixBokNum);
  Result:=oTmpTable.FindKey([pBokNum]);
end;

procedure TExdlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TExdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TExdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TExdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TExdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TExdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TExdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TExdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TExdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TExdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TExdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TExdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TExdlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TExdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TExdlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TExdlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TExdlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
