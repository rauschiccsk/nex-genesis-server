unit tOSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixItmNum = 'ItmNum';
  ixDocNum = 'DocNum';
  ixDoBc = 'DoBc';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixPaCode = 'PaCode';
  ixPaDo = 'PaDo';
  ixStkStat = 'StkStat';
  ixDlvMark = 'DlvMark';

type
  TOsiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSupCode:Str15;         procedure WriteSupCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadDlvQnt_a:double;       procedure WriteDlvQnt_a (pValue:double);
    function  ReadEndQnt:double;         procedure WriteEndQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcDPrice:double;       procedure WriteAcDPrice (pValue:double);
    function  ReadAcCPrice:double;       procedure WriteAcCPrice (pValue:double);
    function  ReadAcEPrice:double;       procedure WriteAcEPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgEPrice:double;       procedure WriteFgEPrice (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadFgCPrice_a:double;     procedure WriteFgCPrice_a (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadTsdItm:word;           procedure WriteTsdItm (pValue:word);
    function  ReadTsdDate:TDatetime;     procedure WriteTsdDate (pValue:TDatetime);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadDlvNoti:Str30;         procedure WriteDlvNoti (pValue:Str30);
    function  ReadDlvMark:Str1;          procedure WriteDlvMark (pValue:Str1);
    function  ReadMarker:byte;           procedure WriteMarker (pValue:byte);
    function  ReadFixDate:TDatetime;     procedure WriteFixDate (pValue:TDatetime);
    function  ReadCnfDate:TDatetime;     procedure WriteCnfDate (pValue:TDatetime);
    function  ReadChgDate:TDatetime;     procedure WriteChgDate (pValue:TDatetime);
    function  ReadRatDay:longint;        procedure WriteRatDay (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadSupDate:TDatetime;     procedure WriteSupDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoBc (pDocNum:Str12;pBarCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaDo (pPaCode:longint;pDocNum:Str12):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateDlvMark (pDlvMark:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SupCode:Str15 read ReadSupCode write WriteSupCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property DlvQnt_a:double read ReadDlvQnt_a write WriteDlvQnt_a;
    property EndQnt:double read ReadEndQnt write WriteEndQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcDPrice:double read ReadAcDPrice write WriteAcDPrice;
    property AcCPrice:double read ReadAcCPrice write WriteAcCPrice;
    property AcEPrice:double read ReadAcEPrice write WriteAcEPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgEPrice:double read ReadFgEPrice write WriteFgEPrice;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property FgCPrice_a:double read ReadFgCPrice_a write WriteFgCPrice_a;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property TsdItm:word read ReadTsdItm write WriteTsdItm;
    property TsdDate:TDatetime read ReadTsdDate write WriteTsdDate;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property DlvNoti:Str30 read ReadDlvNoti write WriteDlvNoti;
    property DlvMark:Str1 read ReadDlvMark write WriteDlvMark;
    property Marker:byte read ReadMarker write WriteMarker;
    property FixDate:TDatetime read ReadFixDate write WriteFixDate;
    property CnfDate:TDatetime read ReadCnfDate write WriteCnfDate;
    property ChgDate:TDatetime read ReadChgDate write WriteChgDate;
    property RatDay:longint read ReadRatDay write WriteRatDay;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property SupDate:TDatetime read ReadSupDate write WriteSupDate;
  end;

implementation

constructor TOsiTmp.Create;
begin
  oTmpTable := TmpInit ('OSI',Self);
end;

destructor TOsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOsiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOsiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOsiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TOsiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TOsiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOsiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOsiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TOsiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TOsiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TOsiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOsiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TOsiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TOsiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TOsiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TOsiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TOsiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TOsiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TOsiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TOsiTmp.ReadSupCode:Str15;
begin
  Result := oTmpTable.FieldByName('SupCode').AsString;
end;

procedure TOsiTmp.WriteSupCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SupCode').AsString := pValue;
end;

function TOsiTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TOsiTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TOsiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOsiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOsiTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TOsiTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TOsiTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TOsiTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TOsiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TOsiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TOsiTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TOsiTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOsiTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadDlvQnt_a:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt_a').AsFloat;
end;

procedure TOsiTmp.WriteDlvQnt_a(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt_a').AsFloat := pValue;
end;

function TOsiTmp.ReadEndQnt:double;
begin
  Result := oTmpTable.FieldByName('EndQnt').AsFloat;
end;

procedure TOsiTmp.WriteEndQnt(pValue:double);
begin
  oTmpTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOsiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TOsiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TOsiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TOsiTmp.ReadAcDPrice:double;
begin
  Result := oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TOsiTmp.WriteAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadAcCPrice:double;
begin
  Result := oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TOsiTmp.WriteAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadAcEPrice:double;
begin
  Result := oTmpTable.FieldByName('AcEPrice').AsFloat;
end;

procedure TOsiTmp.WriteAcEPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcEPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TOsiTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TOsiTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TOsiTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TOsiTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TOsiTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TOsiTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TOsiTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TOsiTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TOsiTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TOsiTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TOsiTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TOsiTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TOsiTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TOsiTmp.ReadFgDPrice:double;
begin
  Result := oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TOsiTmp.WriteFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TOsiTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadFgEPrice:double;
begin
  Result := oTmpTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TOsiTmp.WriteFgEPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgEPrice').AsFloat := pValue;
end;

function TOsiTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TOsiTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TOsiTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TOsiTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TOsiTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TOsiTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TOsiTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TOsiTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TOsiTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TOsiTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TOsiTmp.ReadFgCPrice_a:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice_a').AsFloat;
end;

procedure TOsiTmp.WriteFgCPrice_a(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice_a').AsFloat := pValue;
end;

function TOsiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOsiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TOsiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TOsiTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TOsiTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TOsiTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TOsiTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TOsiTmp.ReadTsdItm:word;
begin
  Result := oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TOsiTmp.WriteTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TOsiTmp.ReadTsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TOsiTmp.WriteTsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOsiTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TOsiTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOsiTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TOsiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TOsiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TOsiTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOsiTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadDlvNoti:Str30;
begin
  Result := oTmpTable.FieldByName('DlvNoti').AsString;
end;

procedure TOsiTmp.WriteDlvNoti(pValue:Str30);
begin
  oTmpTable.FieldByName('DlvNoti').AsString := pValue;
end;

function TOsiTmp.ReadDlvMark:Str1;
begin
  Result := oTmpTable.FieldByName('DlvMark').AsString;
end;

procedure TOsiTmp.WriteDlvMark(pValue:Str1);
begin
  oTmpTable.FieldByName('DlvMark').AsString := pValue;
end;

function TOsiTmp.ReadMarker:byte;
begin
  Result := oTmpTable.FieldByName('Marker').AsInteger;
end;

procedure TOsiTmp.WriteMarker(pValue:byte);
begin
  oTmpTable.FieldByName('Marker').AsInteger := pValue;
end;

function TOsiTmp.ReadFixDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('FixDate').AsDateTime;
end;

procedure TOsiTmp.WriteFixDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('FixDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadCnfDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CnfDate').AsDateTime;
end;

procedure TOsiTmp.WriteCnfDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CnfDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadChgDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ChgDate').AsDateTime;
end;

procedure TOsiTmp.WriteChgDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ChgDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadRatDay:longint;
begin
  Result := oTmpTable.FieldByName('RatDay').AsInteger;
end;

procedure TOsiTmp.WriteRatDay(pValue:longint);
begin
  oTmpTable.FieldByName('RatDay').AsInteger := pValue;
end;

function TOsiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TOsiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOsiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOsiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOsiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOsiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TOsiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TOsiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TOsiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TOsiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOsiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOsiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOsiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TOsiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TOsiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TOsiTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TOsiTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadOcdQnt:double;
begin
  Result := oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TOsiTmp.WriteOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TOsiTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TOsiTmp.ReadSupDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SupDate').AsDateTime;
end;

procedure TOsiTmp.WriteSupDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SupDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOsiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOsiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOsiTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TOsiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TOsiTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TOsiTmp.LocateDoBc (pDocNum:Str12;pBarCode:Str15):boolean;
begin
  SetIndex (ixDoBc);
  Result := oTmpTable.FindKey([pDocNum,pBarCode]);
end;

function TOsiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TOsiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TOsiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TOsiTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TOsiTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TOsiTmp.LocatePaDo (pPaCode:longint;pDocNum:Str12):boolean;
begin
  SetIndex (ixPaDo);
  Result := oTmpTable.FindKey([pPaCode,pDocNum]);
end;

function TOsiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TOsiTmp.LocateDlvMark (pDlvMark:Str1):boolean;
begin
  SetIndex (ixDlvMark);
  Result := oTmpTable.FindKey([pDlvMark]);
end;

procedure TOsiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TOsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOsiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOsiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOsiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOsiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
