unit bPSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixDoGs = 'DoGs';
  ixGsCode = 'GsCode';
  ixPaCode = 'PaCode';
  ixOnOi = 'OnOi';
  ixOrdStat = 'OrdStat';

type
  TPsiBtr = class (TComponent)
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
    function LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
    function LocateOrdStat (pOrdStat:Str1):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
    function NearestOrdStat (pOrdStat:Str1):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
  end;

implementation

constructor TPsiBtr.Create;
begin
  oBtrTable := BtrInit ('PSI',gPath.StkPath,Self);
end;

constructor TPsiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PSI',pPath,Self);
end;

destructor TPsiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPsiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPsiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPsiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPsiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPsiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPsiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPsiBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TPsiBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPsiBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPsiBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPsiBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TPsiBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TPsiBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TPsiBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TPsiBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TPsiBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TPsiBtr.ReadNotice:Str30;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TPsiBtr.WriteNotice(pValue:Str30);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TPsiBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TPsiBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPsiBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TPsiBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TPsiBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TPsiBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPsiBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TPsiBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TPsiBtr.ReadPrvInQnt01:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt01').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt01(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt01').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt02:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt02').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt02(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt02').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt03:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt03').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt03(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt03').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt04:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt04').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt04(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt04').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt05:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt05').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt05(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt05').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt06:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt06').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt06(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt06').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt07:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt07').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt07(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt07').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt08:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt08').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt08(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt08').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt09:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt09').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt09(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt09').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt10:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt10').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt10(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt10').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt11:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt11').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt11(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt11').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvInQnt12:double;
begin
  Result := oBtrTable.FieldByName('PrvInQnt12').AsFloat;
end;

procedure TPsiBtr.WritePrvInQnt12(pValue:double);
begin
  oBtrTable.FieldByName('PrvInQnt12').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt01:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt01').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt01(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt01').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt02:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt02').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt02(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt02').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt03:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt03').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt03(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt03').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt04:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt04').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt04(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt04').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt05:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt05').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt05(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt05').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt06:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt06').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt06(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt06').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt07:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt07').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt07(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt07').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt08:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt08').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt08(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt08').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt09:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt09').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt09(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt09').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt10:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt10').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt10(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt10').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt11:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt11').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt11(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt11').AsFloat := pValue;
end;

function TPsiBtr.ReadActInQnt12:double;
begin
  Result := oBtrTable.FieldByName('ActInQnt12').AsFloat;
end;

procedure TPsiBtr.WriteActInQnt12(pValue:double);
begin
  oBtrTable.FieldByName('ActInQnt12').AsFloat := pValue;
end;

function TPsiBtr.ReadYeInQnt4:double;
begin
  Result := oBtrTable.FieldByName('YeInQnt4').AsFloat;
end;

procedure TPsiBtr.WriteYeInQnt4(pValue:double);
begin
  oBtrTable.FieldByName('YeInQnt4').AsFloat := pValue;
end;

function TPsiBtr.ReadYeInQnt3:double;
begin
  Result := oBtrTable.FieldByName('YeInQnt3').AsFloat;
end;

procedure TPsiBtr.WriteYeInQnt3(pValue:double);
begin
  oBtrTable.FieldByName('YeInQnt3').AsFloat := pValue;
end;

function TPsiBtr.ReadYeInQnt2:double;
begin
  Result := oBtrTable.FieldByName('YeInQnt2').AsFloat;
end;

procedure TPsiBtr.WriteYeInQnt2(pValue:double);
begin
  oBtrTable.FieldByName('YeInQnt2').AsFloat := pValue;
end;

function TPsiBtr.ReadYeInQnt1:double;
begin
  Result := oBtrTable.FieldByName('YeInQnt1').AsFloat;
end;

procedure TPsiBtr.WriteYeInQnt1(pValue:double);
begin
  oBtrTable.FieldByName('YeInQnt1').AsFloat := pValue;
end;

function TPsiBtr.ReadYeInQnt0:double;
begin
  Result := oBtrTable.FieldByName('YeInQnt0').AsFloat;
end;

procedure TPsiBtr.WriteYeInQnt0(pValue:double);
begin
  oBtrTable.FieldByName('YeInQnt0').AsFloat := pValue;
end;

function TPsiBtr.ReadInpQnt:double;
begin
  Result := oBtrTable.FieldByName('InpQnt').AsFloat;
end;

procedure TPsiBtr.WriteInpQnt(pValue:double);
begin
  oBtrTable.FieldByName('InpQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt01:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt01').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt01(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt01').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt02:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt02').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt02(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt02').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt03:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt03').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt03(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt03').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt04:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt04').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt04(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt04').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt05:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt05').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt05(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt05').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt06:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt06').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt06(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt06').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt07:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt07').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt07(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt07').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt08:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt08').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt08(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt08').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt09:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt09').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt09(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt09').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt10:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt10').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt10(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt10').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt11:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt11').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt11(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt11').AsFloat := pValue;
end;

function TPsiBtr.ReadPrvOuQnt12:double;
begin
  Result := oBtrTable.FieldByName('PrvOuQnt12').AsFloat;
end;

procedure TPsiBtr.WritePrvOuQnt12(pValue:double);
begin
  oBtrTable.FieldByName('PrvOuQnt12').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt01:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt01').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt01(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt01').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt02:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt02').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt02(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt02').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt03:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt03').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt03(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt03').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt04:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt04').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt04(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt04').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt05:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt05').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt05(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt05').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt06:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt06').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt06(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt06').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt07:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt07').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt07(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt07').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt08:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt08').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt08(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt08').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt09:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt09').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt09(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt09').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt10:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt10').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt10(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt10').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt11:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt11').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt11(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt11').AsFloat := pValue;
end;

function TPsiBtr.ReadActOuQnt12:double;
begin
  Result := oBtrTable.FieldByName('ActOuQnt12').AsFloat;
end;

procedure TPsiBtr.WriteActOuQnt12(pValue:double);
begin
  oBtrTable.FieldByName('ActOuQnt12').AsFloat := pValue;
end;

function TPsiBtr.ReadYeOuQnt4:double;
begin
  Result := oBtrTable.FieldByName('YeOuQnt4').AsFloat;
end;

procedure TPsiBtr.WriteYeOuQnt4(pValue:double);
begin
  oBtrTable.FieldByName('YeOuQnt4').AsFloat := pValue;
end;

function TPsiBtr.ReadYeOuQnt3:double;
begin
  Result := oBtrTable.FieldByName('YeOuQnt3').AsFloat;
end;

procedure TPsiBtr.WriteYeOuQnt3(pValue:double);
begin
  oBtrTable.FieldByName('YeOuQnt3').AsFloat := pValue;
end;

function TPsiBtr.ReadYeOuQnt2:double;
begin
  Result := oBtrTable.FieldByName('YeOuQnt2').AsFloat;
end;

procedure TPsiBtr.WriteYeOuQnt2(pValue:double);
begin
  oBtrTable.FieldByName('YeOuQnt2').AsFloat := pValue;
end;

function TPsiBtr.ReadYeOuQnt1:double;
begin
  Result := oBtrTable.FieldByName('YeOuQnt1').AsFloat;
end;

procedure TPsiBtr.WriteYeOuQnt1(pValue:double);
begin
  oBtrTable.FieldByName('YeOuQnt1').AsFloat := pValue;
end;

function TPsiBtr.ReadYeOuQnt0:double;
begin
  Result := oBtrTable.FieldByName('YeOuQnt0').AsFloat;
end;

procedure TPsiBtr.WriteYeOuQnt0(pValue:double);
begin
  oBtrTable.FieldByName('YeOuQnt0').AsFloat := pValue;
end;

function TPsiBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TPsiBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadStkQnt:double;
begin
  Result := oBtrTable.FieldByName('StkQnt').AsFloat;
end;

procedure TPsiBtr.WriteStkQnt(pValue:double);
begin
  oBtrTable.FieldByName('StkQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadOcdQnt:double;
begin
  Result := oBtrTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TPsiBtr.WriteOcdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadOsdQnt:double;
begin
  Result := oBtrTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TPsiBtr.WriteOsdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadOfrQnt:double;
begin
  Result := oBtrTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TPsiBtr.WriteOfrQnt(pValue:double);
begin
  oBtrTable.FieldByName('OfrQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadPckQnt:double;
begin
  Result := oBtrTable.FieldByName('PckQnt').AsFloat;
end;

procedure TPsiBtr.WritePckQnt(pValue:double);
begin
  oBtrTable.FieldByName('PckQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadMinQnt:double;
begin
  Result := oBtrTable.FieldByName('MinQnt').AsFloat;
end;

procedure TPsiBtr.WriteMinQnt(pValue:double);
begin
  oBtrTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TPsiBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TPsiBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TPsiBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TPsiBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TPsiBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TPsiBtr.ReadAcDValue:double;
begin
  Result := oBtrTable.FieldByName('AcDValue').AsFloat;
end;

procedure TPsiBtr.WriteAcDValue(pValue:double);
begin
  oBtrTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TPsiBtr.ReadAcDscVal:double;
begin
  Result := oBtrTable.FieldByName('AcDscVal').AsFloat;
end;

procedure TPsiBtr.WriteAcDscVal(pValue:double);
begin
  oBtrTable.FieldByName('AcDscVal').AsFloat := pValue;
end;

function TPsiBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TPsiBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TPsiBtr.ReadAcEValue:double;
begin
  Result := oBtrTable.FieldByName('AcEValue').AsFloat;
end;

procedure TPsiBtr.WriteAcEValue(pValue:double);
begin
  oBtrTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TPsiBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TPsiBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TPsiBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TPsiBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TPsiBtr.ReadFgDPrice:double;
begin
  Result := oBtrTable.FieldByName('FgDPrice').AsFloat;
end;

procedure TPsiBtr.WriteFgDPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgDPrice').AsFloat := pValue;
end;

function TPsiBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TPsiBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TPsiBtr.ReadFgEPrice:double;
begin
  Result := oBtrTable.FieldByName('FgEPrice').AsFloat;
end;

procedure TPsiBtr.WriteFgEPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgEPrice').AsFloat := pValue;
end;

function TPsiBtr.ReadFgDValue:double;
begin
  Result := oBtrTable.FieldByName('FgDValue').AsFloat;
end;

procedure TPsiBtr.WriteFgDValue(pValue:double);
begin
  oBtrTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TPsiBtr.ReadFgDscVal:double;
begin
  Result := oBtrTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TPsiBtr.WriteFgDscVal(pValue:double);
begin
  oBtrTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TPsiBtr.ReadFgRndVal:double;
begin
  Result := oBtrTable.FieldByName('FgRndVal').AsFloat;
end;

procedure TPsiBtr.WriteFgRndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgRndVal').AsFloat := pValue;
end;

function TPsiBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TPsiBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TPsiBtr.ReadFgEValue:double;
begin
  Result := oBtrTable.FieldByName('FgEValue').AsFloat;
end;

procedure TPsiBtr.WriteFgEValue(pValue:double);
begin
  oBtrTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TPsiBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPsiBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPsiBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TPsiBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPsiBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TPsiBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TPsiBtr.ReadOsdItm:word;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TPsiBtr.WriteOsdItm(pValue:word);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TPsiBtr.ReadOsdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OsdDate').AsDateTime;
end;

procedure TPsiBtr.WriteOsdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OsdDate').AsDateTime := pValue;
end;

function TPsiBtr.ReadOrdStat:Str1;
begin
  Result := oBtrTable.FieldByName('OrdStat').AsString;
end;

procedure TPsiBtr.WriteOrdStat(pValue:Str1);
begin
  oBtrTable.FieldByName('OrdStat').AsString := pValue;
end;

function TPsiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPsiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPsiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPsiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPsiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPsiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPsiBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TPsiBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TPsiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPsiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPsiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPsiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPsiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPsiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPsiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPsiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPsiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPsiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPsiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPsiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPsiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPsiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPsiBtr.LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TPsiBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPsiBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TPsiBtr.LocateOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindKey([pOsdNum,pOsdItm]);
end;

function TPsiBtr.LocateOrdStat (pOrdStat:Str1):boolean;
begin
  SetIndex (ixOrdStat);
  Result := oBtrTable.FindKey([pOrdStat]);
end;

function TPsiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPsiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPsiBtr.NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

function TPsiBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TPsiBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TPsiBtr.NearestOnOi (pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixOnOi);
  Result := oBtrTable.FindNearest([pOsdNum,pOsdItm]);
end;

function TPsiBtr.NearestOrdStat (pOrdStat:Str1):boolean;
begin
  SetIndex (ixOrdStat);
  Result := oBtrTable.FindNearest([pOrdStat]);
end;

procedure TPsiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPsiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPsiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPsiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPsiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPsiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPsiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPsiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPsiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPsiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPsiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPsiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPsiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPsiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPsiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPsiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPsiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
