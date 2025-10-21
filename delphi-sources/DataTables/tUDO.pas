unit tUDO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';

type
  TUdoTmp = class (TComponent)
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
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadNotice:Str30;          procedure WriteNotice (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
    function  ReadAcDValue:double;       procedure WriteAcDValue (pValue:double);
    function  ReadAcHValue:double;       procedure WriteAcHValue (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadFgEValue:double;       procedure WriteFgEValue (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgHValue:double;       procedure WriteFgHValue (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadOsdDate:TDatetime;     procedure WriteOsdDate (pValue:TDatetime);
    function  ReadTsdNum:Str12;          procedure WriteTsdNum (pValue:Str12);
    function  ReadTsdItm:word;           procedure WriteTsdItm (pValue:word);
    function  ReadTsdDate:TDatetime;     procedure WriteTsdDate (pValue:TDatetime);
    function  ReadIsdNum:Str12;          procedure WriteIsdNum (pValue:Str12);
    function  ReadIsdItm:word;           procedure WriteIsdItm (pValue:word);
    function  ReadIsdDate:TDatetime;     procedure WriteIsdDate (pValue:TDatetime);
    function  ReadMcdNum:Str12;          procedure WriteMcdNum (pValue:Str12);
    function  ReadMcdItm:word;           procedure WriteMcdItm (pValue:word);
    function  ReadMcdDate:TDatetime;     procedure WriteMcdDate (pValue:TDatetime);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdDate:TDatetime;     procedure WriteTcdDate (pValue:TDatetime);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadIcdItm:word;           procedure WriteIcdItm (pValue:word);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadFinStat:Str1;          procedure WriteFinStat (pValue:Str1);
    function  ReadTgdNum:Str12;          procedure WriteTgdNum (pValue:Str12);
    function  ReadTgdItm:word;           procedure WriteTgdItm (pValue:word);
    function  ReadTgdDate:TDatetime;     procedure WriteTgdDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property Notice:Str30 read ReadNotice write WriteNotice;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property Action:Str1 read ReadAction write WriteAction;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcDValue:double read ReadAcDValue write WriteAcDValue;
    property AcHValue:double read ReadAcHValue write WriteAcHValue;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property FgEValue:double read ReadFgEValue write WriteFgEValue;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgHValue:double read ReadFgHValue write WriteFgHValue;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property OsdDate:TDatetime read ReadOsdDate write WriteOsdDate;
    property TsdNum:Str12 read ReadTsdNum write WriteTsdNum;
    property TsdItm:word read ReadTsdItm write WriteTsdItm;
    property TsdDate:TDatetime read ReadTsdDate write WriteTsdDate;
    property IsdNum:Str12 read ReadIsdNum write WriteIsdNum;
    property IsdItm:word read ReadIsdItm write WriteIsdItm;
    property IsdDate:TDatetime read ReadIsdDate write WriteIsdDate;
    property McdNum:Str12 read ReadMcdNum write WriteMcdNum;
    property McdItm:word read ReadMcdItm write WriteMcdItm;
    property McdDate:TDatetime read ReadMcdDate write WriteMcdDate;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdDate:TDatetime read ReadTcdDate write WriteTcdDate;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property IcdItm:word read ReadIcdItm write WriteIcdItm;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property FinStat:Str1 read ReadFinStat write WriteFinStat;
    property TgdNum:Str12 read ReadTgdNum write WriteTgdNum;
    property TgdItm:word read ReadTgdItm write WriteTgdItm;
    property TgdDate:TDatetime read ReadTgdDate write WriteTgdDate;
  end;

implementation

constructor TUdoTmp.Create;
begin
  oTmpTable := TmpInit ('UDO',Self);
end;

destructor TUdoTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TUdoTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TUdoTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TUdoTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TUdoTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TUdoTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TUdoTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TUdoTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TUdoTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TUdoTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TUdoTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TUdoTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TUdoTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TUdoTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TUdoTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TUdoTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TUdoTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TUdoTmp.ReadNotice:Str30;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TUdoTmp.WriteNotice(pValue:Str30);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

function TUdoTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TUdoTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TUdoTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TUdoTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TUdoTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TUdoTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TUdoTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TUdoTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TUdoTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TUdoTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TUdoTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TUdoTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TUdoTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TUdoTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TUdoTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TUdoTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TUdoTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TUdoTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TUdoTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TUdoTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TUdoTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TUdoTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TUdoTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TUdoTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TUdoTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TUdoTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TUdoTmp.ReadAcDValue:double;
begin
  Result := oTmpTable.FieldByName('AcDValue').AsFloat;
end;

procedure TUdoTmp.WriteAcDValue(pValue:double);
begin
  oTmpTable.FieldByName('AcDValue').AsFloat := pValue;
end;

function TUdoTmp.ReadAcHValue:double;
begin
  Result := oTmpTable.FieldByName('AcHValue').AsFloat;
end;

procedure TUdoTmp.WriteAcHValue(pValue:double);
begin
  oTmpTable.FieldByName('AcHValue').AsFloat := pValue;
end;

function TUdoTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TUdoTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TUdoTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TUdoTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgCourse:double;
begin
  Result := oTmpTable.FieldByName('FgCourse').AsFloat;
end;

procedure TUdoTmp.WriteFgCourse(pValue:double);
begin
  oTmpTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TUdoTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TUdoTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgEValue:double;
begin
  Result := oTmpTable.FieldByName('FgEValue').AsFloat;
end;

procedure TUdoTmp.WriteFgEValue(pValue:double);
begin
  oTmpTable.FieldByName('FgEValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TUdoTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgHValue:double;
begin
  Result := oTmpTable.FieldByName('FgHValue').AsFloat;
end;

procedure TUdoTmp.WriteFgHValue(pValue:double);
begin
  oTmpTable.FieldByName('FgHValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TUdoTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TUdoTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TUdoTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TUdoTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TUdoTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TUdoTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TUdoTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TUdoTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TUdoTmp.ReadOsdItm:word;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TUdoTmp.WriteOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadOsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('OsdDate').AsDateTime;
end;

procedure TUdoTmp.WriteOsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OsdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadTsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TsdNum').AsString;
end;

procedure TUdoTmp.WriteTsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TsdNum').AsString := pValue;
end;

function TUdoTmp.ReadTsdItm:word;
begin
  Result := oTmpTable.FieldByName('TsdItm').AsInteger;
end;

procedure TUdoTmp.WriteTsdItm(pValue:word);
begin
  oTmpTable.FieldByName('TsdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadTsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TsdDate').AsDateTime;
end;

procedure TUdoTmp.WriteTsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TsdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadIsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IsdNum').AsString;
end;

procedure TUdoTmp.WriteIsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IsdNum').AsString := pValue;
end;

function TUdoTmp.ReadIsdItm:word;
begin
  Result := oTmpTable.FieldByName('IsdItm').AsInteger;
end;

procedure TUdoTmp.WriteIsdItm(pValue:word);
begin
  oTmpTable.FieldByName('IsdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadIsdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IsdDate').AsDateTime;
end;

procedure TUdoTmp.WriteIsdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IsdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadMcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('McdNum').AsString;
end;

procedure TUdoTmp.WriteMcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('McdNum').AsString := pValue;
end;

function TUdoTmp.ReadMcdItm:word;
begin
  Result := oTmpTable.FieldByName('McdItm').AsInteger;
end;

procedure TUdoTmp.WriteMcdItm(pValue:word);
begin
  oTmpTable.FieldByName('McdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadMcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('McdDate').AsDateTime;
end;

procedure TUdoTmp.WriteMcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('McdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TUdoTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TUdoTmp.ReadTcdItm:word;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TUdoTmp.WriteTcdItm(pValue:word);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadTcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TUdoTmp.WriteTcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TUdoTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TUdoTmp.ReadIcdItm:word;
begin
  Result := oTmpTable.FieldByName('IcdItm').AsInteger;
end;

procedure TUdoTmp.WriteIcdItm(pValue:word);
begin
  oTmpTable.FieldByName('IcdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TUdoTmp.WriteIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TUdoTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TUdoTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TUdoTmp.ReadFinStat:Str1;
begin
  Result := oTmpTable.FieldByName('FinStat').AsString;
end;

procedure TUdoTmp.WriteFinStat(pValue:Str1);
begin
  oTmpTable.FieldByName('FinStat').AsString := pValue;
end;

function TUdoTmp.ReadTgdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TgdNum').AsString;
end;

procedure TUdoTmp.WriteTgdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TgdNum').AsString := pValue;
end;

function TUdoTmp.ReadTgdItm:word;
begin
  Result := oTmpTable.FieldByName('TgdItm').AsInteger;
end;

procedure TUdoTmp.WriteTgdItm(pValue:word);
begin
  oTmpTable.FieldByName('TgdItm').AsInteger := pValue;
end;

function TUdoTmp.ReadTgdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('TgdDate').AsDateTime;
end;

procedure TUdoTmp.WriteTgdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TgdDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TUdoTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TUdoTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TUdoTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TUdoTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TUdoTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TUdoTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TUdoTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TUdoTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TUdoTmp.First;
begin
  oTmpTable.First;
end;

procedure TUdoTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TUdoTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TUdoTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TUdoTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TUdoTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TUdoTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TUdoTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TUdoTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TUdoTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TUdoTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TUdoTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
