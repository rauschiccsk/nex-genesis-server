unit bSCI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixPaCode = 'PaCode';
  ixStkStat = 'StkStat';
  ixFinStat = 'FinStat';

type
  TSciBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadCsType:Str1;           procedure WriteCsType (pValue:Str1);
    function  ReadItType:Str1;           procedure WriteItType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcHValue:double;       procedure WriteAcHValue (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgHPrice:double;       procedure WriteFgHPrice (pValue:double);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgHscVal:double;       procedure WriteFgHscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGrtType:Str1;          procedure WriteGrtType (pValue:Str1);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadStdNum:Str12;          procedure WriteStdNum (pValue:Str12);
    function  ReadStdItm:word;           procedure WriteStdItm (pValue:word);
    function  ReadStdDate:TDatetime;     procedure WriteStdDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateFinStat (pFinStat:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestFinStat (pFinStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property CsType:Str1 read ReadCsType write WriteCsType;
    property ItType:Str1 read ReadItType write WriteItType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcHValue:double read ReadAcHValue write WriteAcHValue;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgHPrice:double read ReadFgHPrice write WriteFgHPrice;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgHscVal:double read ReadFgHscVal write WriteFgHscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GrtType:Str1 read ReadGrtType write WriteGrtType;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property StdNum:Str12 read ReadStdNum write WriteStdNum;
    property StdItm:word read ReadStdItm write WriteStdItm;
    property StdDate:TDatetime read ReadStdDate write WriteStdDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property Action:Str1 read ReadAction write WriteAction;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSciBtr.Create;
begin
  oBtrTable := BtrInit ('SCI',gPath.StkPath,Self);
end;

constructor TSciBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SCI',pPath,Self);
end;

destructor TSciBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSciBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSciBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSciBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSciBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSciBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSciBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSciBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSciBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSciBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSciBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSciBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TSciBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TSciBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSciBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSciBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TSciBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TSciBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TSciBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TSciBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TSciBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSciBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TSciBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TSciBtr.ReadPackGs:longint;
begin
  Result := oBtrTable.FieldByName('PackGs').AsInteger;
end;

procedure TSciBtr.WritePackGs(pValue:longint);
begin
  oBtrTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TSciBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TSciBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TSciBtr.ReadCsType:Str1;
begin
  Result := oBtrTable.FieldByName('CsType').AsString;
end;

procedure TSciBtr.WriteCsType(pValue:Str1);
begin
  oBtrTable.FieldByName('CsType').AsString := pValue;
end;

function TSciBtr.ReadItType:Str1;
begin
  Result := oBtrTable.FieldByName('ItType').AsString;
end;

procedure TSciBtr.WriteItType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItType').AsString := pValue;
end;

function TSciBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TSciBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TSciBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TSciBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TSciBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSciBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSciBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TSciBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TSciBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TSciBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TSciBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TSciBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TSciBtr.ReadAcHValue:double;
begin
  Result := oBtrTable.FieldByName('AcHValue').AsFloat;
end;

procedure TSciBtr.WriteAcHValue(pValue:double);
begin
  oBtrTable.FieldByName('AcHValue').AsFloat := pValue;
end;

function TSciBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TSciBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TSciBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TSciBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TSciBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TSciBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TSciBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TSciBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TSciBtr.ReadFgHPrice:double;
begin
  Result := oBtrTable.FieldByName('FgHPrice').AsFloat;
end;

procedure TSciBtr.WriteFgHPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgHPrice').AsFloat := pValue;
end;

function TSciBtr.ReadFgAPrice:double;
begin
  Result := oBtrTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TSciBtr.WriteFgAPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TSciBtr.ReadFgBPrice:double;
begin
  Result := oBtrTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TSciBtr.WriteFgBPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TSciBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TSciBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TSciBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TSciBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TSciBtr.ReadFgHValue:double;
begin
  Result := oBtrTable.FieldByName('FgHValue').AsFloat;
end;

procedure TSciBtr.WriteFgHValue(pValue:double);
begin
  oBtrTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TSciBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TSciBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TSciBtr.ReadFgHscVal:double;
begin
  Result := oBtrTable.FieldByName('FgHscVal').AsFloat;
end;

procedure TSciBtr.WriteFgHscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgHscVal').AsFloat := pValue;
end;

function TSciBtr.ReadFgAValue:double;
begin
  Result := oBtrTable.FieldByName('FgAValue').AsFloat;
end;

procedure TSciBtr.WriteFgAValue(pValue:double);
begin
  oBtrTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TSciBtr.ReadFgBValue:double;
begin
  Result := oBtrTable.FieldByName('FgBValue').AsFloat;
end;

procedure TSciBtr.WriteFgBValue(pValue:double);
begin
  oBtrTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TSciBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TSciBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TSciBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSciBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSciBtr.ReadDscType:Str1;
begin
  Result := oBtrTable.FieldByName('DscType').AsString;
end;

procedure TSciBtr.WriteDscType(pValue:Str1);
begin
  oBtrTable.FieldByName('DscType').AsString := pValue;
end;

function TSciBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSciBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSciBtr.ReadGrtType:Str1;
begin
  Result := oBtrTable.FieldByName('GrtType').AsString;
end;

procedure TSciBtr.WriteGrtType(pValue:Str1);
begin
  oBtrTable.FieldByName('GrtType').AsString := pValue;
end;

function TSciBtr.ReadCasNum:word;
begin
  Result := oBtrTable.FieldByName('CasNum').AsInteger;
end;

procedure TSciBtr.WriteCasNum(pValue:word);
begin
  oBtrTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TSciBtr.ReadStdNum:Str12;
begin
  Result := oBtrTable.FieldByName('StdNum').AsString;
end;

procedure TSciBtr.WriteStdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('StdNum').AsString := pValue;
end;

function TSciBtr.ReadStdItm:word;
begin
  Result := oBtrTable.FieldByName('StdItm').AsInteger;
end;

procedure TSciBtr.WriteStdItm(pValue:word);
begin
  oBtrTable.FieldByName('StdItm').AsInteger := pValue;
end;

function TSciBtr.ReadStdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('StdDate').AsDateTime;
end;

procedure TSciBtr.WriteStdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('StdDate').AsDateTime := pValue;
end;

function TSciBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TSciBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TSciBtr.ReadIcdItm:word;
begin
  Result := oBtrTable.FieldByName('IcdItm').AsInteger;
end;

procedure TSciBtr.WriteIcdItm(pValue:word);
begin
  oBtrTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TSciBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TSciBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TSciBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TSciBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TSciBtr.ReadFinStat:Str1;
begin
  Result := oBtrTable.FieldByName('FinStat').AsString;
end;

procedure TSciBtr.WriteFinStat(pValue:Str1);
begin
  oBtrTable.FieldByName('FinStat').AsString := pValue;
end;

function TSciBtr.ReadAction:Str1;
begin
  Result := oBtrTable.FieldByName('Action').AsString;
end;

procedure TSciBtr.WriteAction(pValue:Str1);
begin
  oBtrTable.FieldByName('Action').AsString := pValue;
end;

function TSciBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSciBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSciBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSciBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSciBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSciBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSciBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSciBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSciBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSciBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSciBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSciBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSciBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSciBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSciBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSciBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSciBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSciBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSciBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TSciBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSciBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSciBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TSciBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TSciBtr.LocateFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindKey([pFinStat]);
end;

function TSciBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TSciBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSciBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSciBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TSciBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TSciBtr.NearestFinStat (pFinStat:Str1):boolean;
begin
  SetIndex (ixFinStat);
  Result := oBtrTable.FindNearest([pFinStat]);
end;

procedure TSciBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSciBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSciBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSciBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSciBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSciBtr.First;
begin
  oBtrTable.First;
end;

procedure TSciBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSciBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSciBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSciBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSciBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSciBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSciBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSciBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSciBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSciBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSciBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
