unit tPSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixDocNum = 'DocNum';
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixPaCode = 'PaCode';
  ixOcdQnt = 'OcdQnt';

type
  TPsiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPrvInQnt01:double;     procedure WritePrvInQnt01 (pValue:double);
    function  ReadPrvInQnt02:double;     procedure WritePrvInQnt02 (pValue:double);
    function  ReadPrvInQnt03:double;     procedure WritePrvInQnt03 (pValue:double);
    function  ReadPrvInQnt04:double;     procedure WritePrvInQnt04 (pValue:double);
    function  ReadPrvInQnt05:double;     procedure WritePrvInQnt05 (pValue:double);
    function  ReadPrvInQnt06:double;     procedure WritePrvInQnt06 (pValue:double);
    function  ReadPrvInQnt07:double;     procedure WritePrvInQnt07 (pValue:double);
    function  ReadPrvInQnt08:double;     procedure WritePrvInQnt08 (pValue:double);
    function  ReadPrvInQnt09:double;     procedure WritePrvInQnt09 (pValue:double);
    function  ReadPrvInQnt10:double;     procedure WritePrvInQnt10 (pValue:double);
    function  ReadPrvInQnt11:double;     procedure WritePrvInQnt11 (pValue:double);
    function  ReadPrvInQnt12:double;     procedure WritePrvInQnt12 (pValue:double);
    function  ReadActInQnt01:double;     procedure WriteActInQnt01 (pValue:double);
    function  ReadActInQnt02:double;     procedure WriteActInQnt02 (pValue:double);
    function  ReadActInQnt03:double;     procedure WriteActInQnt03 (pValue:double);
    function  ReadActInQnt04:double;     procedure WriteActInQnt04 (pValue:double);
    function  ReadActInQnt05:double;     procedure WriteActInQnt05 (pValue:double);
    function  ReadActInQnt06:double;     procedure WriteActInQnt06 (pValue:double);
    function  ReadActInQnt07:double;     procedure WriteActInQnt07 (pValue:double);
    function  ReadActInQnt08:double;     procedure WriteActInQnt08 (pValue:double);
    function  ReadActInQnt09:double;     procedure WriteActInQnt09 (pValue:double);
    function  ReadActInQnt10:double;     procedure WriteActInQnt10 (pValue:double);
    function  ReadActInQnt11:double;     procedure WriteActInQnt11 (pValue:double);
    function  ReadActInQnt12:double;     procedure WriteActInQnt12 (pValue:double);
    function  ReadYeInQnt4:double;       procedure WriteYeInQnt4 (pValue:double);
    function  ReadYeInQnt3:double;       procedure WriteYeInQnt3 (pValue:double);
    function  ReadYeInQnt2:double;       procedure WriteYeInQnt2 (pValue:double);
    function  ReadYeInQnt1:double;       procedure WriteYeInQnt1 (pValue:double);
    function  ReadYeInQnt0:double;       procedure WriteYeInQnt0 (pValue:double);
    function  ReadInpQnt:double;         procedure WriteInpQnt (pValue:double);
    function  ReadPrvOuQnt01:double;     procedure WritePrvOuQnt01 (pValue:double);
    function  ReadPrvOuQnt02:double;     procedure WritePrvOuQnt02 (pValue:double);
    function  ReadPrvOuQnt03:double;     procedure WritePrvOuQnt03 (pValue:double);
    function  ReadPrvOuQnt04:double;     procedure WritePrvOuQnt04 (pValue:double);
    function  ReadPrvOuQnt05:double;     procedure WritePrvOuQnt05 (pValue:double);
    function  ReadPrvOuQnt06:double;     procedure WritePrvOuQnt06 (pValue:double);
    function  ReadPrvOuQnt07:double;     procedure WritePrvOuQnt07 (pValue:double);
    function  ReadPrvOuQnt08:double;     procedure WritePrvOuQnt08 (pValue:double);
    function  ReadPrvOuQnt09:double;     procedure WritePrvOuQnt09 (pValue:double);
    function  ReadPrvOuQnt10:double;     procedure WritePrvOuQnt10 (pValue:double);
    function  ReadPrvOuQnt11:double;     procedure WritePrvOuQnt11 (pValue:double);
    function  ReadPrvOuQnt12:double;     procedure WritePrvOuQnt12 (pValue:double);
    function  ReadActOuQnt01:double;     procedure WriteActOuQnt01 (pValue:double);
    function  ReadActOuQnt02:double;     procedure WriteActOuQnt02 (pValue:double);
    function  ReadActOuQnt03:double;     procedure WriteActOuQnt03 (pValue:double);
    function  ReadActOuQnt04:double;     procedure WriteActOuQnt04 (pValue:double);
    function  ReadActOuQnt05:double;     procedure WriteActOuQnt05 (pValue:double);
    function  ReadActOuQnt06:double;     procedure WriteActOuQnt06 (pValue:double);
    function  ReadActOuQnt07:double;     procedure WriteActOuQnt07 (pValue:double);
    function  ReadActOuQnt08:double;     procedure WriteActOuQnt08 (pValue:double);
    function  ReadActOuQnt09:double;     procedure WriteActOuQnt09 (pValue:double);
    function  ReadActOuQnt10:double;     procedure WriteActOuQnt10 (pValue:double);
    function  ReadActOuQnt11:double;     procedure WriteActOuQnt11 (pValue:double);
    function  ReadActOuQnt12:double;     procedure WriteActOuQnt12 (pValue:double);
    function  ReadYeOuQnt4:double;       procedure WriteYeOuQnt4 (pValue:double);
    function  ReadYeOuQnt3:double;       procedure WriteYeOuQnt3 (pValue:double);
    function  ReadYeOuQnt2:double;       procedure WriteYeOuQnt2 (pValue:double);
    function  ReadYeOuQnt1:double;       procedure WriteYeOuQnt1 (pValue:double);
    function  ReadYeOuQnt0:double;       procedure WriteYeOuQnt0 (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadStkQnt:double;         procedure WriteStkQnt (pValue:double);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadOfrQnt:double;         procedure WriteOfrQnt (pValue:double);
    function  ReadPckQnt:double;         procedure WritePckQnt (pValue:double);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcDPrice:double;       procedure WriteAcDPrice (pValue:double);
    function  ReadAcCPrice:double;       procedure WriteAcCPrice (pValue:double);
    function  ReadAcEPrice:double;       procedure WriteAcEPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcDscVal:double;       procedure WriteAcDscVal (pValue:double);
    function  ReadAcRndVal:double;       procedure WriteAcRndVal (pValue:double);
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
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadOsdDate:TDatetime;     procedure WriteOsdDate (pValue:TDatetime);
    function  ReadOrdStat:Str1;          procedure WriteOrdStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMarker:byte;           procedure WriteMarker (pValue:byte);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateOcdQnt (pOcdQnt:double):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PrvInQnt01:double read ReadPrvInQnt01 write WritePrvInQnt01;
    property PrvInQnt02:double read ReadPrvInQnt02 write WritePrvInQnt02;
    property PrvInQnt03:double read ReadPrvInQnt03 write WritePrvInQnt03;
    property PrvInQnt04:double read ReadPrvInQnt04 write WritePrvInQnt04;
    property PrvInQnt05:double read ReadPrvInQnt05 write WritePrvInQnt05;
    property PrvInQnt06:double read ReadPrvInQnt06 write WritePrvInQnt06;
    property PrvInQnt07:double read ReadPrvInQnt07 write WritePrvInQnt07;
    property PrvInQnt08:double read ReadPrvInQnt08 write WritePrvInQnt08;
    property PrvInQnt09:double read ReadPrvInQnt09 write WritePrvInQnt09;
    property PrvInQnt10:double read ReadPrvInQnt10 write WritePrvInQnt10;
    property PrvInQnt11:double read ReadPrvInQnt11 write WritePrvInQnt11;
    property PrvInQnt12:double read ReadPrvInQnt12 write WritePrvInQnt12;
    property ActInQnt01:double read ReadActInQnt01 write WriteActInQnt01;
    property ActInQnt02:double read ReadActInQnt02 write WriteActInQnt02;
    property ActInQnt03:double read ReadActInQnt03 write WriteActInQnt03;
    property ActInQnt04:double read ReadActInQnt04 write WriteActInQnt04;
    property ActInQnt05:double read ReadActInQnt05 write WriteActInQnt05;
    property ActInQnt06:double read ReadActInQnt06 write WriteActInQnt06;
    property ActInQnt07:double read ReadActInQnt07 write WriteActInQnt07;
    property ActInQnt08:double read ReadActInQnt08 write WriteActInQnt08;
    property ActInQnt09:double read ReadActInQnt09 write WriteActInQnt09;
    property ActInQnt10:double read ReadActInQnt10 write WriteActInQnt10;
    property ActInQnt11:double read ReadActInQnt11 write WriteActInQnt11;
    property ActInQnt12:double read ReadActInQnt12 write WriteActInQnt12;
    property YeInQnt4:double read ReadYeInQnt4 write WriteYeInQnt4;
    property YeInQnt3:double read ReadYeInQnt3 write WriteYeInQnt3;
    property YeInQnt2:double read ReadYeInQnt2 write WriteYeInQnt2;
    property YeInQnt1:double read ReadYeInQnt1 write WriteYeInQnt1;
    property YeInQnt0:double read ReadYeInQnt0 write WriteYeInQnt0;
    property InpQnt:double read ReadInpQnt write WriteInpQnt;
    property PrvOuQnt01:double read ReadPrvOuQnt01 write WritePrvOuQnt01;
    property PrvOuQnt02:double read ReadPrvOuQnt02 write WritePrvOuQnt02;
    property PrvOuQnt03:double read ReadPrvOuQnt03 write WritePrvOuQnt03;
    property PrvOuQnt04:double read ReadPrvOuQnt04 write WritePrvOuQnt04;
    property PrvOuQnt05:double read ReadPrvOuQnt05 write WritePrvOuQnt05;
    property PrvOuQnt06:double read ReadPrvOuQnt06 write WritePrvOuQnt06;
    property PrvOuQnt07:double read ReadPrvOuQnt07 write WritePrvOuQnt07;
    property PrvOuQnt08:double read ReadPrvOuQnt08 write WritePrvOuQnt08;
    property PrvOuQnt09:double read ReadPrvOuQnt09 write WritePrvOuQnt09;
    property PrvOuQnt10:double read ReadPrvOuQnt10 write WritePrvOuQnt10;
    property PrvOuQnt11:double read ReadPrvOuQnt11 write WritePrvOuQnt11;
    property PrvOuQnt12:double read ReadPrvOuQnt12 write WritePrvOuQnt12;
    property ActOuQnt01:double read ReadActOuQnt01 write WriteActOuQnt01;
    property ActOuQnt02:double read ReadActOuQnt02 write WriteActOuQnt02;
    property ActOuQnt03:double read ReadActOuQnt03 write WriteActOuQnt03;
    property ActOuQnt04:double read ReadActOuQnt04 write WriteActOuQnt04;
    property ActOuQnt05:double read ReadActOuQnt05 write WriteActOuQnt05;
    property ActOuQnt06:double read ReadActOuQnt06 write WriteActOuQnt06;
    property ActOuQnt07:double read ReadActOuQnt07 write WriteActOuQnt07;
    property ActOuQnt08:double read ReadActOuQnt08 write WriteActOuQnt08;
    property ActOuQnt09:double read ReadActOuQnt09 write WriteActOuQnt09;
    property ActOuQnt10:double read ReadActOuQnt10 write WriteActOuQnt10;
    property ActOuQnt11:double read ReadActOuQnt11 write WriteActOuQnt11;
    property ActOuQnt12:double read ReadActOuQnt12 write WriteActOuQnt12;
    property YeOuQnt4:double read ReadYeOuQnt4 write WriteYeOuQnt4;
    property YeOuQnt3:double read ReadYeOuQnt3 write WriteYeOuQnt3;
    property YeOuQnt2:double read ReadYeOuQnt2 write WriteYeOuQnt2;
    property YeOuQnt1:double read ReadYeOuQnt1 write WriteYeOuQnt1;
    property YeOuQnt0:double read ReadYeOuQnt0 write WriteYeOuQnt0;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property StkQnt:double read ReadStkQnt write WriteStkQnt;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property OfrQnt:double read ReadOfrQnt write WriteOfrQnt;
    property PckQnt:double read ReadPckQnt write WritePckQnt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcDPrice:double read ReadAcDPrice write WriteAcDPrice;
    property AcCPrice:double read ReadAcCPrice write WriteAcCPrice;
    property AcEPrice:double read ReadAcEPrice write WriteAcEPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcDscVal:double read ReadAcDscVal write WriteAcDscVal;
    property AcRndVal:double read ReadAcRndVal write WriteAcRndVal;
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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property OsdDate:TDatetime read ReadOsdDate write WriteOsdDate;
    property OrdStat:Str1 read ReadOrdStat write WriteOrdStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Marker:byte read ReadMarker write WriteMarker;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPsiTmp.Create;
begin
  oTmpTable := TmpInit ('PSI',Self);
end;

destructor TPsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPsiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPsiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPsiTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TPsiTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TPsiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPsiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPsiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPsiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPsiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TPsiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPsiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPsiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPsiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TPsiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TPsiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TPsiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TPsiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TPsiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TPsiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TPsiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TPsiTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TPsiTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TPsiTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TPsiTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TPsiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TPsiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPsiTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TPsiTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TPsiTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TPsiTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPsiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TPsiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TPsiTmp.ReadPrvInQnt01:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt01').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt01(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt01').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt02:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt02').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt02(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt02').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt03:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt03').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt03(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt03').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt04:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt04').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt04(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt04').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt05:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt05').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt05(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt05').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt06:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt06').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt06(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt06').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt07:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt07').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt07(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt07').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt08:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt08').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt08(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt08').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt09:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt09').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt09(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt09').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt10:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt10').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt10(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt10').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt11:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt11').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt11(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt11').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvInQnt12:double;
begin
  Result := oTmpTable.FieldByName('PrvInQnt12').AsFloat;
end;

procedure TPsiTmp.WritePrvInQnt12(pValue:double);
begin
  oTmpTable.FieldByName('PrvInQnt12').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt01:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt01').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt01(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt01').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt02:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt02').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt02(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt02').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt03:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt03').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt03(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt03').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt04:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt04').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt04(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt04').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt05:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt05').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt05(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt05').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt06:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt06').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt06(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt06').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt07:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt07').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt07(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt07').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt08:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt08').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt08(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt08').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt09:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt09').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt09(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt09').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt10:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt10').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt10(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt10').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt11:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt11').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt11(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt11').AsFloat := pValue;
end;

function TPsiTmp.ReadActInQnt12:double;
begin
  Result := oTmpTable.FieldByName('ActInQnt12').AsFloat;
end;

procedure TPsiTmp.WriteActInQnt12(pValue:double);
begin
  oTmpTable.FieldByName('ActInQnt12').AsFloat := pValue;
end;

function TPsiTmp.ReadYeInQnt4:double;
begin
  Result := oTmpTable.FieldByName('YeInQnt4').AsFloat;
end;

procedure TPsiTmp.WriteYeInQnt4(pValue:double);
begin
  oTmpTable.FieldByName('YeInQnt4').AsFloat := pValue;
end;

function TPsiTmp.ReadYeInQnt3:double;
begin
  Result := oTmpTable.FieldByName('YeInQnt3').AsFloat;
end;

procedure TPsiTmp.WriteYeInQnt3(pValue:double);
begin
  oTmpTable.FieldByName('YeInQnt3').AsFloat := pValue;
end;

function TPsiTmp.ReadYeInQnt2:double;
begin
  Result := oTmpTable.FieldByName('YeInQnt2').AsFloat;
end;

procedure TPsiTmp.WriteYeInQnt2(pValue:double);
begin
  oTmpTable.FieldByName('YeInQnt2').AsFloat := pValue;
end;

function TPsiTmp.ReadYeInQnt1:double;
begin
  Result := oTmpTable.FieldByName('YeInQnt1').AsFloat;
end;

procedure TPsiTmp.WriteYeInQnt1(pValue:double);
begin
  oTmpTable.FieldByName('YeInQnt1').AsFloat := pValue;
end;

function TPsiTmp.ReadYeInQnt0:double;
begin
  Result := oTmpTable.FieldByName('YeInQnt0').AsFloat;
end;

procedure TPsiTmp.WriteYeInQnt0(pValue:double);
begin
  oTmpTable.FieldByName('YeInQnt0').AsFloat := pValue;
end;

function TPsiTmp.ReadInpQnt:double;
begin
  Result := oTmpTable.FieldByName('InpQnt').AsFloat;
end;

procedure TPsiTmp.WriteInpQnt(pValue:double);
begin
  oTmpTable.FieldByName('InpQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt01:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt01').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt01(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt01').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt02:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt02').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt02(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt02').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt03:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt03').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt03(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt03').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt04:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt04').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt04(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt04').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt05:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt05').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt05(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt05').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt06:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt06').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt06(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt06').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt07:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt07').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt07(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt07').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt08:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt08').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt08(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt08').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt09:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt09').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt09(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt09').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt10:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt10').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt10(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt10').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt11:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt11').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt11(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt11').AsFloat := pValue;
end;

function TPsiTmp.ReadPrvOuQnt12:double;
begin
  Result := oTmpTable.FieldByName('PrvOuQnt12').AsFloat;
end;

procedure TPsiTmp.WritePrvOuQnt12(pValue:double);
begin
  oTmpTable.FieldByName('PrvOuQnt12').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt01:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt01').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt01(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt01').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt02:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt02').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt02(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt02').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt03:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt03').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt03(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt03').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt04:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt04').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt04(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt04').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt05:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt05').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt05(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt05').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt06:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt06').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt06(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt06').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt07:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt07').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt07(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt07').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt08:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt08').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt08(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt08').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt09:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt09').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt09(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt09').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt10:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt10').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt10(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt10').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt11:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt11').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt11(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt11').AsFloat := pValue;
end;

function TPsiTmp.ReadActOuQnt12:double;
begin
  Result := oTmpTable.FieldByName('ActOuQnt12').AsFloat;
end;

procedure TPsiTmp.WriteActOuQnt12(pValue:double);
begin
  oTmpTable.FieldByName('ActOuQnt12').AsFloat := pValue;
end;

function TPsiTmp.ReadYeOuQnt4:double;
begin
  Result := oTmpTable.FieldByName('YeOuQnt4').AsFloat;
end;

procedure TPsiTmp.WriteYeOuQnt4(pValue:double);
begin
  oTmpTable.FieldByName('YeOuQnt4').AsFloat := pValue;
end;

function TPsiTmp.ReadYeOuQnt3:double;
begin
  Result := oTmpTable.FieldByName('YeOuQnt3').AsFloat;
end;

procedure TPsiTmp.WriteYeOuQnt3(pValue:double);
begin
  oTmpTable.FieldByName('YeOuQnt3').AsFloat := pValue;
end;

function TPsiTmp.ReadYeOuQnt2:double;
begin
  Result := oTmpTable.FieldByName('YeOuQnt2').AsFloat;
end;

procedure TPsiTmp.WriteYeOuQnt2(pValue:double);
begin
  oTmpTable.FieldByName('YeOuQnt2').AsFloat := pValue;
end;

function TPsiTmp.ReadYeOuQnt1:double;
begin
  Result := oTmpTable.FieldByName('YeOuQnt1').AsFloat;
end;

procedure TPsiTmp.WriteYeOuQnt1(pValue:double);
begin
  oTmpTable.FieldByName('YeOuQnt1').AsFloat := pValue;
end;

function TPsiTmp.ReadYeOuQnt0:double;
begin
  Result := oTmpTable.FieldByName('YeOuQnt0').AsFloat;
end;

procedure TPsiTmp.WriteYeOuQnt0(pValue:double);
begin
  oTmpTable.FieldByName('YeOuQnt0').AsFloat := pValue;
end;

function TPsiTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TPsiTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadStkQnt:double;
begin
  Result := oTmpTable.FieldByName('StkQnt').AsFloat;
end;

procedure TPsiTmp.WriteStkQnt(pValue:double);
begin
  oTmpTable.FieldByName('StkQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadOcdQnt:double;
begin
  Result := oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TPsiTmp.WriteOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadOsdQnt:double;
begin
  Result := oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TPsiTmp.WriteOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadOfrQnt:double;
begin
  Result := oTmpTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TPsiTmp.WriteOfrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OfrQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadPckQnt:double;
begin
  Result := oTmpTable.FieldByName('PckQnt').AsFloat;
end;

procedure TPsiTmp.WritePckQnt(pValue:double);
begin
  oTmpTable.FieldByName('PckQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadMinQnt:double;
begin
  Result := oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TPsiTmp.WriteMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TPsiTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TPsiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPsiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPsiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPsiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPsiTmp.ReadAcDPrice:double;
begin
  Result := oTmpTable.FieldByName('AcDPrice').AsFloat;
end;

procedure TPsiTmp.WriteAcDPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcDPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadAcCPrice:double;
begin
  Result := oTmpTable.FieldByName('AcCPrice').AsFloat;
end;

procedure TPsiTmp.WriteAcCPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcCPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadAcEPrice:double;
begin
  Result := oTmpTable.FieldByName('AcEPrice').AsFloat;
end;

procedure TPsiTmp.WriteAcEPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcEPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadAcAPrice:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TPsiTmp.WriteAcAPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadAcBPrice:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TPsiTmp.WriteAcBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TPsiTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TPsiTmp.ReadAcDscVal:double;
begin
  Result := oTmpTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TPsiTmp.WriteAcDscVal(pValue:double);
begin
  oTmpTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TPsiTmp.ReadAcRndVal:double;
begin
  Result := oTmpTable.FieldByName('AcRndVal').AsFloat;
end;

procedure TPsiTmp.WriteAcRndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcRndVal').AsFloat := pValue;
end;

function TPsiTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TPsiTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TPsiTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TPsiTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TPsiTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TPsiTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TPsiTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TPsiTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TPsiTmp.ReadFgDPrice:double;
begin
  Result := oTmpTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TPsiTmp.WriteFgDPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TPsiTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadFgEPrice:double;
begin
  Result := oTmpTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TPsiTmp.WriteFgEPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgEPrice').AsFloat := pValue;
end;

function TPsiTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TPsiTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TPsiTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TPsiTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TPsiTmp.ReadFgRndVal:double;
begin
  Result := oTmpTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TPsiTmp.WriteFgRndVal(pValue:double);
begin
  oTmpTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TPsiTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TPsiTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TPsiTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TPsiTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TPsiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPsiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPsiTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TPsiTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPsiTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TPsiTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TPsiTmp.ReadOsdItm:word;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TPsiTmp.WriteOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TPsiTmp.ReadOsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdDate').AsDateTime;
end;

procedure TPsiTmp.WriteOsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDate').AsDateTime := pValue;
end;

function TPsiTmp.ReadOrdStat:Str1;
begin
  Result := oTmpTable.FieldByName('OrdStat').AsString;
end;

procedure TPsiTmp.WriteOrdStat(pValue:Str1);
begin
  oTmpTable.FieldByName('OrdStat').AsString := pValue;
end;

function TPsiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPsiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPsiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPsiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPsiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPsiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPsiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TPsiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPsiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPsiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPsiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPsiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPsiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPsiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPsiTmp.ReadMarker:byte;
begin
  Result := oTmpTable.FieldByName('Marker').AsInteger;
end;

procedure TPsiTmp.WriteMarker(pValue:byte);
begin
  oTmpTable.FieldByName('Marker').AsInteger := pValue;
end;

function TPsiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPsiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPsiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPsiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPsiTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TPsiTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TPsiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TPsiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TPsiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TPsiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TPsiTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TPsiTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TPsiTmp.LocateOcdQnt (pOcdQnt:double):boolean;
begin
  SetIndex (ixOcdQnt);
  Result := oTmpTable.FindKey([pOcdQnt]);
end;

procedure TPsiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TPsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPsiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPsiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPsiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPsiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
