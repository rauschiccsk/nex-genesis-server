unit tISI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum='';
  ixDocNum='DocNum';
  ixItmNum='ItmNum';
  ixGsCode='GsCode';
  ixGsName_='GsName_';
  ixBarCode='BarCode';
  ixStkCode='StkCode';
  ixStatus='Status';

type
  TIsiTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:word;             procedure SetItmNum (pValue:word);
    function GetMgCode:word;             procedure SetMgCode (pValue:word);
    function GetGsCode:longint;          procedure SetGsCode (pValue:longint);
    function GetGsName:Str30;            procedure SetGsName (pValue:Str30);
    function GetGsName_:Str30;           procedure SetGsName_ (pValue:Str30);
    function GetBarCode:Str15;           procedure SetBarCode (pValue:Str15);
    function GetStkCode:Str15;           procedure SetStkCode (pValue:Str15);
    function GetNotice:Str30;            procedure SetNotice (pValue:Str30);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetMsName:Str10;            procedure SetMsName (pValue:Str10);
    function GetGsQnt:double;            procedure SetGsQnt (pValue:double);
    function GetVatPrc:double;           procedure SetVatPrc (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetAcDPrice:double;         procedure SetAcDPrice (pValue:double);
    function GetAcCPrice:double;         procedure SetAcCPrice (pValue:double);
    function GetAcEPrice:double;         procedure SetAcEPrice (pValue:double);
    function GetAcAPrice:double;         procedure SetAcAPrice (pValue:double);
    function GetAcBPrice:double;         procedure SetAcBPrice (pValue:double);
    function GetAcDValue:double;         procedure SetAcDValue (pValue:double);
    function GetAcDscVal:double;         procedure SetAcDscVal (pValue:double);
    function GetAcCValue:double;         procedure SetAcCValue (pValue:double);
    function GetAcEValue:double;         procedure SetAcEValue (pValue:double);
    function GetAcAValue:double;         procedure SetAcAValue (pValue:double);
    function GetAcBValue:double;         procedure SetAcBValue (pValue:double);
    function GetFgDPrice:double;         procedure SetFgDPrice (pValue:double);
    function GetFgCPrice:double;         procedure SetFgCPrice (pValue:double);
    function GetFgEPrice:double;         procedure SetFgEPrice (pValue:double);
    function GetFgDValue:double;         procedure SetFgDValue (pValue:double);
    function GetFgDscVal:double;         procedure SetFgDscVal (pValue:double);
    function GetFgCValue:double;         procedure SetFgCValue (pValue:double);
    function GetFgEValue:double;         procedure SetFgEValue (pValue:double);
    function GetDocDate:TDatetime;       procedure SetDocDate (pValue:TDatetime);
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetOsdNum:Str12;            procedure SetOsdNum (pValue:Str12);
    function GetOsdItm:word;             procedure SetOsdItm (pValue:word);
    function GetTsdNum:Str12;            procedure SetTsdNum (pValue:Str12);
    function GetTsdItm:word;             procedure SetTsdItm (pValue:word);
    function GetTsdDate:TDatetime;       procedure SetTsdDate (pValue:TDatetime);
    function GetStatus:Str1;             procedure SetStatus (pValue:Str1);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str8;             procedure SetAccAnl (pValue:Str8);
    function GetCctvat:byte;             procedure SetCctvat (pValue:byte);
    function GetCrtUser:Str8;            procedure SetCrtUser (pValue:Str8);
    function GetCrtDate:TDatetime;       procedure SetCrtDate (pValue:TDatetime);
    function GetCrtTime:TDatetime;       procedure SetCrtTime (pValue:TDatetime);
    function GetModNum:word;             procedure SetModNum (pValue:word);
    function GetModUser:Str8;            procedure SetModUser (pValue:Str8);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocRowNum (pRowNum:word):boolean;
    function LocDocNum (pDocNum:Str12):boolean;
    function LocItmNum (pItmNum:word):boolean;
    function LocGsCode (pGsCode:longint):boolean;
    function LocGsName_ (pGsName_:Str30):boolean;
    function LocBarCode (pBarCode:Str15):boolean;
    function LocStkCode (pStkCode:Str15):boolean;
    function LocStatus (pStatus:Str1):boolean;

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
    property RowNum:word read GetRowNum write SetRowNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:word read GetItmNum write SetItmNum;
    property MgCode:word read GetMgCode write SetMgCode;
    property GsCode:longint read GetGsCode write SetGsCode;
    property GsName:Str30 read GetGsName write SetGsName;
    property GsName_:Str30 read GetGsName_ write SetGsName_;
    property BarCode:Str15 read GetBarCode write SetBarCode;
    property StkCode:Str15 read GetStkCode write SetStkCode;
    property Notice:Str30 read GetNotice write SetNotice;
    property WriNum:word read GetWriNum write SetWriNum;
    property StkNum:word read GetStkNum write SetStkNum;
    property MsName:Str10 read GetMsName write SetMsName;
    property GsQnt:double read GetGsQnt write SetGsQnt;
    property VatPrc:double read GetVatPrc write SetVatPrc;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property AcDPrice:double read GetAcDPrice write SetAcDPrice;
    property AcCPrice:double read GetAcCPrice write SetAcCPrice;
    property AcEPrice:double read GetAcEPrice write SetAcEPrice;
    property AcAPrice:double read GetAcAPrice write SetAcAPrice;
    property AcBPrice:double read GetAcBPrice write SetAcBPrice;
    property AcDValue:double read GetAcDValue write SetAcDValue;
    property AcDscVal:double read GetAcDscVal write SetAcDscVal;
    property AcCValue:double read GetAcCValue write SetAcCValue;
    property AcEValue:double read GetAcEValue write SetAcEValue;
    property AcAValue:double read GetAcAValue write SetAcAValue;
    property AcBValue:double read GetAcBValue write SetAcBValue;
    property FgDPrice:double read GetFgDPrice write SetFgDPrice;
    property FgCPrice:double read GetFgCPrice write SetFgCPrice;
    property FgEPrice:double read GetFgEPrice write SetFgEPrice;
    property FgDValue:double read GetFgDValue write SetFgDValue;
    property FgDscVal:double read GetFgDscVal write SetFgDscVal;
    property FgCValue:double read GetFgCValue write SetFgCValue;
    property FgEValue:double read GetFgEValue write SetFgEValue;
    property DocDate:TDatetime read GetDocDate write SetDocDate;
    property PaCode:longint read GetPaCode write SetPaCode;
    property OsdNum:Str12 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property TsdNum:Str12 read GetTsdNum write SetTsdNum;
    property TsdItm:word read GetTsdItm write SetTsdItm;
    property TsdDate:TDatetime read GetTsdDate write SetTsdDate;
    property Status:Str1 read GetStatus write SetStatus;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str8 read GetAccAnl write SetAccAnl;
    property Cctvat:byte read GetCctvat write SetCctvat;
    property CrtUser:Str8 read GetCrtUser write SetCrtUser;
    property CrtDate:TDatetime read GetCrtDate write SetCrtDate;
    property CrtTime:TDatetime read GetCrtTime write SetCrtTime;
    property ModNum:word read GetModNum write SetModNum;
    property ModUser:Str8 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TIsiTmp.Create;
begin
  oTmpTable:=TmpInit ('ISI',Self);
end;

destructor TIsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIsiTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIsiTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIsiTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TIsiTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TIsiTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIsiTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIsiTmp.GetItmNum:word;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIsiTmp.SetItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TIsiTmp.GetMgCode:word;
begin
  Result:=oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TIsiTmp.SetMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger:=pValue;
end;

function TIsiTmp.GetGsCode:longint;
begin
  Result:=oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIsiTmp.SetGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TIsiTmp.GetGsName:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIsiTmp.SetGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString:=pValue;
end;

function TIsiTmp.GetGsName_:Str30;
begin
  Result:=oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TIsiTmp.SetGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString:=pValue;
end;

function TIsiTmp.GetBarCode:Str15;
begin
  Result:=oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TIsiTmp.SetBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString:=pValue;
end;

function TIsiTmp.GetStkCode:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TIsiTmp.SetStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString:=pValue;
end;

function TIsiTmp.GetNotice:Str30;
begin
  Result:=oTmpTable.FieldByName('Notice').AsString;
end;

procedure TIsiTmp.SetNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString:=pValue;
end;

function TIsiTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIsiTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIsiTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIsiTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TIsiTmp.GetMsName:Str10;
begin
  Result:=oTmpTable.FieldByName('MsName').AsString;
end;

procedure TIsiTmp.SetMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString:=pValue;
end;

function TIsiTmp.GetGsQnt:double;
begin
  Result:=oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TIsiTmp.SetGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat:=pValue;
end;

function TIsiTmp.GetVatPrc:double;
begin
  Result:=oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TIsiTmp.SetVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat:=pValue;
end;

function TIsiTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIsiTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TIsiTmp.GetAcDPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TIsiTmp.SetAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetAcCPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TIsiTmp.SetAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetAcEPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcEPrice').AsFloat;
end;

procedure TIsiTmp.SetAcEPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcEPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetAcAPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TIsiTmp.SetAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetAcBPrice:double;
begin
  Result:=oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TIsiTmp.SetAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetAcDValue:double;
begin
  Result:=oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIsiTmp.SetAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat:=pValue;
end;

function TIsiTmp.GetAcDscVal:double;
begin
  Result:=oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIsiTmp.SetAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat:=pValue;
end;

function TIsiTmp.GetAcCValue:double;
begin
  Result:=oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIsiTmp.SetAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat:=pValue;
end;

function TIsiTmp.GetAcEValue:double;
begin
  Result:=oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TIsiTmp.SetAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat:=pValue;
end;

function TIsiTmp.GetAcAValue:double;
begin
  Result:=oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIsiTmp.SetAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat:=pValue;
end;

function TIsiTmp.GetAcBValue:double;
begin
  Result:=oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIsiTmp.SetAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat:=pValue;
end;

function TIsiTmp.GetFgDPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TIsiTmp.SetFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetFgCPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TIsiTmp.SetFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetFgEPrice:double;
begin
  Result:=oTmpTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TIsiTmp.SetFgEPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgEPrice').AsFloat:=pValue;
end;

function TIsiTmp.GetFgDValue:double;
begin
  Result:=oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIsiTmp.SetFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat:=pValue;
end;

function TIsiTmp.GetFgDscVal:double;
begin
  Result:=oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIsiTmp.SetFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat:=pValue;
end;

function TIsiTmp.GetFgCValue:double;
begin
  Result:=oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIsiTmp.SetFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat:=pValue;
end;

function TIsiTmp.GetFgEValue:double;
begin
  Result:=oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TIsiTmp.SetFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat:=pValue;
end;

function TIsiTmp.GetDocDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIsiTmp.SetDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime:=pValue;
end;

function TIsiTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIsiTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TIsiTmp.GetOsdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TIsiTmp.SetOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TIsiTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TIsiTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TIsiTmp.GetTsdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TIsiTmp.SetTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString:=pValue;
end;

function TIsiTmp.GetTsdItm:word;
begin
  Result:=oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TIsiTmp.SetTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger:=pValue;
end;

function TIsiTmp.GetTsdDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TIsiTmp.SetTsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDate').AsDateTime:=pValue;
end;

function TIsiTmp.GetStatus:Str1;
begin
  Result:=oTmpTable.FieldByName('Status').AsString;
end;

procedure TIsiTmp.SetStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString:=pValue;
end;

function TIsiTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIsiTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TIsiTmp.GetAccAnl:Str8;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIsiTmp.SetAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TIsiTmp.GetCctvat:byte;
begin
  Result:=oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TIsiTmp.SetCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger:=pValue;
end;

function TIsiTmp.GetCrtUser:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIsiTmp.SetCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString:=pValue;
end;

function TIsiTmp.GetCrtDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIsiTmp.SetCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime:=pValue;
end;

function TIsiTmp.GetCrtTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIsiTmp.SetCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime:=pValue;
end;

function TIsiTmp.GetModNum:word;
begin
  Result:=oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIsiTmp.SetModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger:=pValue;
end;

function TIsiTmp.GetModUser:Str8;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIsiTmp.SetModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TIsiTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIsiTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TIsiTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIsiTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TIsiTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIsiTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIsiTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIsiTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIsiTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

function TIsiTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

function TIsiTmp.LocItmNum(pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result:=oTmpTable.FindKey([pItmNum]);
end;

function TIsiTmp.LocGsCode(pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result:=oTmpTable.FindKey([pGsCode]);
end;

function TIsiTmp.LocGsName_(pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result:=oTmpTable.FindKey([pGsName_]);
end;

function TIsiTmp.LocBarCode(pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result:=oTmpTable.FindKey([pBarCode]);
end;

function TIsiTmp.LocStkCode(pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result:=oTmpTable.FindKey([pStkCode]);
end;

function TIsiTmp.LocStatus(pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result:=oTmpTable.FindKey([pStatus]);
end;

procedure TIsiTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TIsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIsiTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIsiTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIsiTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIsiTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
