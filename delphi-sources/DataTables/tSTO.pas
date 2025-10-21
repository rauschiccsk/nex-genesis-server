unit tSTO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixGsOrSt = 'GsOrSt';
  ixGsCode = 'GsCode';
  ixGsOrStPa = 'GsOrStPa';

type
  TStoTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadOrdType:Str1;          procedure WriteOrdType (pValue:Str1);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadAcqMode:Str1;          procedure WriteAcqMode (pValue:Str1);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadNrsQnt:double;         procedure WriteNrsQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadCnfDate:TDatetime;     procedure WriteCnfDate (pValue:TDatetime);
    function  ReadRqdDate:TDatetime;     procedure WriteRqdDate (pValue:TDatetime);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:longint;        procedure WriteOsdItm (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadOcdQnt:double;         procedure WriteOcdQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadOsdQnt:double;         procedure WriteOsdQnt (pValue:double);
    function  ReadOsrQnt:double;         procedure WriteOsrQnt (pValue:double);
    function  ReadFroQnt:double;         procedure WriteFroQnt (pValue:double);
    function  ReadNsuQnt:double;         procedure WriteNsuQnt (pValue:double);
    function  ReadMaxQnt:double;         procedure WriteMaxQnt (pValue:double);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadMinMax:Str1;           procedure WriteMinMax (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property OrdType:Str1 read ReadOrdType write WriteOrdType;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property AcqMode:Str1 read ReadAcqMode write WriteAcqMode;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property NrsQnt:double read ReadNrsQnt write WriteNrsQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CnfDate:TDatetime read ReadCnfDate write WriteCnfDate;
    property RqdDate:TDatetime read ReadRqdDate write WriteRqdDate;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:longint read ReadOsdItm write WriteOsdItm;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property OcdQnt:double read ReadOcdQnt write WriteOcdQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property OsdQnt:double read ReadOsdQnt write WriteOsdQnt;
    property OsrQnt:double read ReadOsrQnt write WriteOsrQnt;
    property FroQnt:double read ReadFroQnt write WriteFroQnt;
    property NsuQnt:double read ReadNsuQnt write WriteNsuQnt;
    property MaxQnt:double read ReadMaxQnt write WriteMaxQnt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property MinMax:Str1 read ReadMinMax write WriteMinMax;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TStoTmp.Create;
begin
  oTmpTable := TmpInit ('STO',Self);
end;

destructor TStoTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStoTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStoTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStoTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStoTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TStoTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStoTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TStoTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStoTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStoTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TStoTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TStoTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TStoTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TStoTmp.ReadOrdQnt:double;
begin
  Result := oTmpTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TStoTmp.WriteOrdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TStoTmp.ReadOrdType:Str1;
begin
  Result := oTmpTable.FieldByName('OrdType').AsString;
end;

procedure TStoTmp.WriteOrdType(pValue:Str1);
begin
  oTmpTable.FieldByName('OrdType').AsString := pValue;
end;

function TStoTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TStoTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TStoTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TStoTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TStoTmp.ReadAcqMode:Str1;
begin
  Result := oTmpTable.FieldByName('AcqMode').AsString;
end;

procedure TStoTmp.WriteAcqMode(pValue:Str1);
begin
  oTmpTable.FieldByName('AcqMode').AsString := pValue;
end;

function TStoTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TStoTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TStoTmp.ReadNrsQnt:double;
begin
  Result := oTmpTable.FieldByName('NrsQnt').AsFloat;
end;

procedure TStoTmp.WriteNrsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NrsQnt').AsFloat := pValue;
end;

function TStoTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TStoTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TStoTmp.ReadCnfDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CnfDate').AsDateTime;
end;

procedure TStoTmp.WriteCnfDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CnfDate').AsDateTime := pValue;
end;

function TStoTmp.ReadRqdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RqdDate').AsDateTime;
end;

procedure TStoTmp.WriteRqdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RqdDate').AsDateTime := pValue;
end;

function TStoTmp.ReadOsdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TStoTmp.WriteOsdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OsdNum').AsString := pValue;
end;

function TStoTmp.ReadOsdItm:longint;
begin
  Result := oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TStoTmp.WriteOsdItm(pValue:longint);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TStoTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStoTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStoTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStoTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStoTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStoTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStoTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStoTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TStoTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TStoTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TStoTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStoTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TStoTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TStoTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TStoTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStoTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TStoTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TStoTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TStoTmp.ReadOcdQnt:double;
begin
  Result := oTmpTable.FieldByName('OcdQnt').AsFloat;
end;

procedure TStoTmp.WriteOcdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OcdQnt').AsFloat := pValue;
end;

function TStoTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TStoTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TStoTmp.ReadOsdQnt:double;
begin
  Result := oTmpTable.FieldByName('OsdQnt').AsFloat;
end;

procedure TStoTmp.WriteOsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsdQnt').AsFloat := pValue;
end;

function TStoTmp.ReadOsrQnt:double;
begin
  Result := oTmpTable.FieldByName('OsrQnt').AsFloat;
end;

procedure TStoTmp.WriteOsrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OsrQnt').AsFloat := pValue;
end;

function TStoTmp.ReadFroQnt:double;
begin
  Result := oTmpTable.FieldByName('FroQnt').AsFloat;
end;

procedure TStoTmp.WriteFroQnt(pValue:double);
begin
  oTmpTable.FieldByName('FroQnt').AsFloat := pValue;
end;

function TStoTmp.ReadNsuQnt:double;
begin
  Result := oTmpTable.FieldByName('NsuQnt').AsFloat;
end;

procedure TStoTmp.WriteNsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsuQnt').AsFloat := pValue;
end;

function TStoTmp.ReadMaxQnt:double;
begin
  Result := oTmpTable.FieldByName('MaxQnt').AsFloat;
end;

procedure TStoTmp.WriteMaxQnt(pValue:double);
begin
  oTmpTable.FieldByName('MaxQnt').AsFloat := pValue;
end;

function TStoTmp.ReadMinQnt:double;
begin
  Result := oTmpTable.FieldByName('MinQnt').AsFloat;
end;

procedure TStoTmp.WriteMinQnt(pValue:double);
begin
  oTmpTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TStoTmp.ReadMinMax:Str1;
begin
  Result := oTmpTable.FieldByName('MinMax').AsString;
end;

procedure TStoTmp.WriteMinMax(pValue:Str1);
begin
  oTmpTable.FieldByName('MinMax').AsString := pValue;
end;

function TStoTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TStoTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStoTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStoTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStoTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStoTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TStoTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TStoTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TStoTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStoTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStoTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStoTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStoTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStoTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStoTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TStoTmp.LocateGsOrSt (pGsCode:longint;pOrdType:Str1;pStkStat:Str1):boolean;
begin
  SetIndex (ixGsOrSt);
  Result := oTmpTable.FindKey([pGsCode,pOrdType,pStkStat]);
end;

function TStoTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStoTmp.LocateGsOrStPa (pGsCode:longint;pOrdType:Str1;pStkStat:Str1;pPaCode:longint):boolean;
begin
  SetIndex (ixGsOrStPa);
  Result := oTmpTable.FindKey([pGsCode,pOrdType,pStkStat,pPaCode]);
end;

procedure TStoTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStoTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStoTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStoTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStoTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStoTmp.First;
begin
  oTmpTable.First;
end;

procedure TStoTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStoTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStoTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStoTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStoTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStoTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStoTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStoTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStoTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStoTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStoTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
