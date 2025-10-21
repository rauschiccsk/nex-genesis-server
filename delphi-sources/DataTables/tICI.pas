unit tICI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixRowNum = 'RowNum';
  ixMgCode = 'MgCode';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixSpcCode = 'SpcCode';
  ixTnTi = 'TnTi';
  ixSnSi = 'SnSi';
  ixStatus = 'Status';

type
  TIciTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str60;          procedure WriteGsName (pValue:Str60);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadNotice:Str90;          procedure WriteNotice (pValue:Str90);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadGscQnt:double;         procedure WriteGscQnt (pValue:double);
    function  ReadGspQnt:double;         procedure WriteGspQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadHdsPrc:double;         procedure WriteHdsPrc (pValue:double);
    function  ReadAcCPrice:double;       procedure WriteAcCPrice (pValue:double);
    function  ReadAcDPrice:double;       procedure WriteAcDPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
    function  ReadAcRndVat:double;       procedure WriteAcRndVat (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgDPrice:double;       procedure WriteFgDPrice (pValue:double);
    function  ReadFgAPrice:double;       procedure WriteFgAPrice (pValue:double);
    function  ReadFgBPrice:double;       procedure WriteFgBPrice (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgHdsVal:double;       procedure WriteFgHdsVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadFgRndVal:double;       procedure WriteFgRndVal (pValue:double);
    function  ReadFgRndVat:double;       procedure WriteFgRndVat (pValue:double);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadSteCode:word;          procedure WriteSteCode (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadMcdNum:Str12;          procedure WriteMcdNum (pValue:Str12);
    function  ReadMcdItm:word;           procedure WriteMcdItm (pValue:word);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdDate:TDatetime;     procedure WriteTcdDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadScdItm:word;           procedure WriteScdItm (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadDscType:Str1;          procedure WriteDscType (pValue:Str1);
    function  ReadDscGrp:byte;           procedure WriteDscGrp (pValue:byte);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str8;           procedure WriteAccAnl (pValue:Str8);
    function  ReadSpMark:Str10;          procedure WriteSpMark (pValue:Str10);
    function  ReadBonNum:byte;           procedure WriteBonNum (pValue:byte);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadWpaName:Str30;         procedure WriteWpaName (pValue:Str30);
    function  ReadWpaAddr:Str30;         procedure WriteWpaAddr (pValue:Str30);
    function  ReadWpaCtn:Str30;          procedure WriteWpaCtn (pValue:Str30);
    function  ReadCasNum:word;           procedure WriteCasNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspDate:TDatetime;     procedure WriteRspDate (pValue:TDatetime);
    function  ReadRspTime:TDatetime;     procedure WriteRspTime (pValue:TDatetime);
    function  ReadCctvat:byte;           procedure WriteCctvat (pValue:byte);
    function  ReadCctSta:Str1;           procedure WriteCctSta (pValue:Str1);
    function  ReadCctCod:Str10;          procedure WriteCctCod (pValue:Str10);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateSpcCode (pSpcCode:Str30):boolean;
    function LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
    function LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
    function LocateStatus (pStatus:Str1):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str60 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property Notice:Str90 read ReadNotice write WriteNotice;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property GscQnt:double read ReadGscQnt write WriteGscQnt;
    property GspQnt:double read ReadGspQnt write WriteGspQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property HdsPrc:double read ReadHdsPrc write WriteHdsPrc;
    property AcCPrice:double read ReadAcCPrice write WriteAcCPrice;
    property AcDPrice:double read ReadAcDPrice write WriteAcDPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
    property AcRndVat:double read ReadAcRndVat write WriteAcRndVat;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgDPrice:double read ReadFgDPrice write WriteFgDPrice;
    property FgAPrice:double read ReadFgAPrice write WriteFgAPrice;
    property FgBPrice:double read ReadFgBPrice write WriteFgBPrice;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgHdsVal:double read ReadFgHdsVal write WriteFgHdsVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property FgRndVal:double read ReadFgRndVal write WriteFgRndVal;
    property FgRndVat:double read ReadFgRndVat write WriteFgRndVat;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property SteCode:word read ReadSteCode write WriteSteCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property McdNum:Str12 read ReadMcdNum write WriteMcdNum;
    property McdItm:word read ReadMcdItm write WriteMcdItm;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdDate:TDatetime read ReadTcdDate write WriteTcdDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property ScdItm:word read ReadScdItm write WriteScdItm;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Action:Str1 read ReadAction write WriteAction;
    property DscType:Str1 read ReadDscType write WriteDscType;
    property DscGrp:byte read ReadDscGrp write WriteDscGrp;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str8 read ReadAccAnl write WriteAccAnl;
    property SpMark:Str10 read ReadSpMark write WriteSpMark;
    property BonNum:byte read ReadBonNum write WriteBonNum;
    property PaName:Str30 read ReadPaName write WritePaName;
    property WpaName:Str30 read ReadWpaName write WriteWpaName;
    property WpaAddr:Str30 read ReadWpaAddr write WriteWpaAddr;
    property WpaCtn:Str30 read ReadWpaCtn write WriteWpaCtn;
    property CasNum:word read ReadCasNum write WriteCasNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspDate:TDatetime read ReadRspDate write WriteRspDate;
    property RspTime:TDatetime read ReadRspTime write WriteRspTime;
    property Cctvat:byte read ReadCctvat write WriteCctvat;
    property CctSta:Str1 read ReadCctSta write WriteCctSta;
    property CctCod:Str10 read ReadCctCod write WriteCctCod;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIciTmp.Create;
begin
  oTmpTable := TmpInit ('ICI',Self);
end;

destructor TIciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIciTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIciTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIciTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIciTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIciTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIciTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIciTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TIciTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TIciTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TIciTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TIciTmp.ReadMgName:Str30;
begin
  Result := oTmpTable.FieldByName('MgName').AsString;
end;

procedure TIciTmp.WriteMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString := pValue;
end;

function TIciTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TIciTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TIciTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIciTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIciTmp.ReadGsName:Str60;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIciTmp.WriteGsName(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TIciTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TIciTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TIciTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TIciTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TIciTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TIciTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TIciTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TIciTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TIciTmp.ReadNotice:Str90;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TIciTmp.WriteNotice(pValue:Str90);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TIciTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIciTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIciTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TIciTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TIciTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TIciTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TIciTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TIciTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TIciTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TIciTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TIciTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TIciTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TIciTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TIciTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TIciTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TIciTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TIciTmp.ReadGscQnt:double;
begin
  Result := oTmpTable.FieldByName('GscQnt').AsFloat;
end;

procedure TIciTmp.WriteGscQnt(pValue:double);
begin
  oTmpTable.FieldByName('GscQnt').AsFloat := pValue;
end;

function TIciTmp.ReadGspQnt:double;
begin
  Result := oTmpTable.FieldByName('GspQnt').AsFloat;
end;

procedure TIciTmp.WriteGspQnt(pValue:double);
begin
  oTmpTable.FieldByName('GspQnt').AsFloat := pValue;
end;

function TIciTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TIciTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TIciTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TIciTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TIciTmp.ReadHdsPrc:double;
begin
  Result := oTmpTable.FieldByName('HdsPrc').AsFloat;
end;

procedure TIciTmp.WriteHdsPrc(pValue:double);
begin
  oTmpTable.FieldByName('HdsPrc').AsFloat := pValue;
end;

function TIciTmp.ReadAcCPrice:double;
begin
  Result := oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TIciTmp.WriteAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat := pValue;
end;

function TIciTmp.ReadAcDPrice:double;
begin
  Result := oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TIciTmp.WriteAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat := pValue;
end;

function TIciTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TIciTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TIciTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TIciTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TIciTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TIciTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TIciTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TIciTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TIciTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TIciTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TIciTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIciTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIciTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIciTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIciTmp.ReadAcRndVal:double;
begin
  Result := oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TIciTmp.WriteAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TIciTmp.ReadAcRndVat:double;
begin
  Result := oTmpTable.FieldByName('AcRndVat').AsFloat;
end;

procedure TIciTmp.WriteAcRndVat(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVat').AsFloat := pValue;
end;

function TIciTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TIciTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TIciTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TIciTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TIciTmp.ReadFgDPrice:double;
begin
  Result := oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TIciTmp.WriteFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TIciTmp.ReadFgAPrice:double;
begin
  Result := oTmpTable.FieldByName('FgAPrice').AsFloat;
end;

procedure TIciTmp.WriteFgAPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgAPrice').AsFloat := pValue;
end;

function TIciTmp.ReadFgBPrice:double;
begin
  Result := oTmpTable.FieldByName('FgBPrice').AsFloat;
end;

procedure TIciTmp.WriteFgBPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgBPrice').AsFloat := pValue;
end;

function TIciTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TIciTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TIciTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TIciTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TIciTmp.ReadFgHValue:double;
begin
  Result := oTmpTable.FieldByName('FgHValue').AsFloat;
end;

procedure TIciTmp.WriteFgHValue(pValue:double);
begin
  oTmpTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TIciTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TIciTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TIciTmp.ReadFgHdsVal:double;
begin
  Result := oTmpTable.FieldByName('FgHdsVal').AsFloat;
end;

procedure TIciTmp.WriteFgHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('FgHdsVal').AsFloat := pValue;
end;

function TIciTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TIciTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TIciTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TIciTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TIciTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TIciTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TIciTmp.ReadFgRndVat:double;
begin
  Result := oTmpTable.FieldByName('FgRndVat').AsFloat;
end;

procedure TIciTmp.WriteFgRndVat(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVat').AsFloat := pValue;
end;

function TIciTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TIciTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TIciTmp.ReadSteCode:word;
begin
  Result := oTmpTable.FieldByName('SteCode').AsInteger;
end;

procedure TIciTmp.WriteSteCode(pValue:word);
begin
  oTmpTable.FieldByName('SteCode').AsInteger := pValue;
end;

function TIciTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIciTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIciTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TIciTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TIciTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIciTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIciTmp.ReadMcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TIciTmp.WriteMcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('McdNum').AsString := pValue;
end;

function TIciTmp.ReadMcdItm:word;
begin
  Result := oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TIciTmp.WriteMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TIciTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TIciTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TIciTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TIciTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TIciTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TIciTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TIciTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TIciTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TIciTmp.ReadTcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TIciTmp.WriteTcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TIciTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TIciTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TIciTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TIciTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TIciTmp.ReadScdNum:Str12;
begin
  Result := oTmpTable.FieldByName('ScdNum').AsString;
end;

procedure TIciTmp.WriteScdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ScdNum').AsString := pValue;
end;

function TIciTmp.ReadScdItm:word;
begin
  Result := oTmpTable.FieldByName('ScdItm').AsInteger;
end;

procedure TIciTmp.WriteScdItm(pValue:word);
begin
  oTmpTable.FieldByName('ScdItm').AsInteger := pValue;
end;

function TIciTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TIciTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TIciTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TIciTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TIciTmp.ReadDscType:Str1;
begin
  Result := oTmpTable.FieldByName('DscType').AsString;
end;

procedure TIciTmp.WriteDscType(pValue:Str1);
begin
  oTmpTable.FieldByName('DscType').AsString := pValue;
end;

function TIciTmp.ReadDscGrp:byte;
begin
  Result := oTmpTable.FieldByName('DscGrp').AsInteger;
end;

procedure TIciTmp.WriteDscGrp(pValue:byte);
begin
  oTmpTable.FieldByName('DscGrp').AsInteger := pValue;
end;

function TIciTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TIciTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TIciTmp.ReadAccAnl:Str8;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TIciTmp.WriteAccAnl(pValue:Str8);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TIciTmp.ReadSpMark:Str10;
begin
  Result := oTmpTable.FieldByName('SpMark').AsString;
end;

procedure TIciTmp.WriteSpMark(pValue:Str10);
begin
  oTmpTable.FieldByName('SpMark').AsString := pValue;
end;

function TIciTmp.ReadBonNum:byte;
begin
  Result := oTmpTable.FieldByName('BonNum').AsInteger;
end;

procedure TIciTmp.WriteBonNum(pValue:byte);
begin
  oTmpTable.FieldByName('BonNum').AsInteger := pValue;
end;

function TIciTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TIciTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TIciTmp.ReadWpaName:Str30;
begin
  Result := oTmpTable.FieldByName('WpaName').AsString;
end;

procedure TIciTmp.WriteWpaName(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaName').AsString := pValue;
end;

function TIciTmp.ReadWpaAddr:Str30;
begin
  Result := oTmpTable.FieldByName('WpaAddr').AsString;
end;

procedure TIciTmp.WriteWpaAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaAddr').AsString := pValue;
end;

function TIciTmp.ReadWpaCtn:Str30;
begin
  Result := oTmpTable.FieldByName('WpaCtn').AsString;
end;

procedure TIciTmp.WriteWpaCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('WpaCtn').AsString := pValue;
end;

function TIciTmp.ReadCasNum:word;
begin
  Result := oTmpTable.FieldByName('CasNum').AsInteger;
end;

procedure TIciTmp.WriteCasNum(pValue:word);
begin
  oTmpTable.FieldByName('CasNum').AsInteger := pValue;
end;

function TIciTmp.ReadRspUser:Str8;
begin
  Result := oTmpTable.FieldByName('RspUser').AsString;
end;

procedure TIciTmp.WriteRspUser(pValue:Str8);
begin
  oTmpTable.FieldByName('RspUser').AsString := pValue;
end;

function TIciTmp.ReadRspDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RspDate').AsDateTime;
end;

procedure TIciTmp.WriteRspDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RspDate').AsDateTime := pValue;
end;

function TIciTmp.ReadRspTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('RspTime').AsDateTime;
end;

procedure TIciTmp.WriteRspTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RspTime').AsDateTime := pValue;
end;

function TIciTmp.ReadCctvat:byte;
begin
  Result := oTmpTable.FieldByName('Cctvat').AsInteger;
end;

procedure TIciTmp.WriteCctvat(pValue:byte);
begin
  oTmpTable.FieldByName('Cctvat').AsInteger := pValue;
end;

function TIciTmp.ReadCctSta:Str1;
begin
  Result := oTmpTable.FieldByName('CctSta').AsString;
end;

procedure TIciTmp.WriteCctSta(pValue:Str1);
begin
  oTmpTable.FieldByName('CctSta').AsString := pValue;
end;

function TIciTmp.ReadCctCod:Str10;
begin
  Result := oTmpTable.FieldByName('CctCod').AsString;
end;

procedure TIciTmp.WriteCctCod(pValue:Str10);
begin
  oTmpTable.FieldByName('CctCod').AsString := pValue;
end;

function TIciTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIciTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIciTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIciTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIciTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIciTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIciTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIciTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIciTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIciTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIciTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIciTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIciTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIciTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIciTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIciTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIciTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIciTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIciTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TIciTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TIciTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TIciTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TIciTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TIciTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TIciTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TIciTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TIciTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TIciTmp.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oTmpTable.FindKey([pSpcCode]);
end;

function TIciTmp.LocateTnTi (pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixTnTi);
  Result := oTmpTable.FindKey([pTcdNum,pTcdItm]);
end;

function TIciTmp.LocateSnSi (pScdNum:Str12;pScdItm:word):boolean;
begin
  SetIndex (ixSnSi);
  Result := oTmpTable.FindKey([pScdNum,pScdItm]);
end;

function TIciTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TIciTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIciTmp.First;
begin
  oTmpTable.First;
end;

procedure TIciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIciTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIciTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIciTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIciTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
