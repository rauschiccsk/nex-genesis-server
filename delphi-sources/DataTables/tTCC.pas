unit tTCC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixTdTi = 'TdTi';
  ixTcdNum = 'TcdNum';
  ixCpCode = 'CpCode';
  ixStkStat = 'StkStat';

type
  TTccTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTccItm:word;           procedure WriteTccItm (pValue:word);
    function  ReadTcdItm:longint;        procedure WriteTcdItm (pValue:longint);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadRcGsQnt:double;        procedure WriteRcGsQnt (pValue:double);
    function  ReadLosPrc:double;         procedure WriteLosPrc (pValue:double);
    function  ReadCpSeQnt:double;        procedure WriteCpSeQnt (pValue:double);
    function  ReadCpSuQnt:double;        procedure WriteCpSuQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadAcCValue:double;       procedure WriteAcCValue (pValue:double);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadFgCValue:double;       procedure WriteFgCValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
    function  ReadDrbDate:TDatetime;     procedure WriteDrbDate (pValue:TDatetime);
    function  ReadDlvUser:Str8;          procedure WriteDlvUser (pValue:Str8);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (pTcdNum:Str12;pTccItm:word):boolean;
    function LocateTdTi (pTcdNum:Str12;pTcdItm:longint):boolean;
    function LocateTcdNum (pTcdNum:Str12):boolean;
    function LocateCpCode (pCpCode:longint):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;

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
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TccItm:word read ReadTccItm write WriteTccItm;
    property TcdItm:longint read ReadTcdItm write WriteTcdItm;
    property Parent:longint read ReadParent write WriteParent;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property PdCode:longint read ReadPdCode write WritePdCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property RcGsQnt:double read ReadRcGsQnt write WriteRcGsQnt;
    property LosPrc:double read ReadLosPrc write WriteLosPrc;
    property CpSeQnt:double read ReadCpSeQnt write WriteCpSeQnt;
    property CpSuQnt:double read ReadCpSuQnt write WriteCpSuQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property AcCValue:double read ReadAcCValue write WriteAcCValue;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property FgCValue:double read ReadFgCValue write WriteFgCValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property DrbDate:TDatetime read ReadDrbDate write WriteDrbDate;
    property DlvUser:Str8 read ReadDlvUser write WriteDlvUser;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTccTmp.Create;
begin
  oTmpTable := TmpInit ('TCC',Self);
end;

destructor TTccTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTccTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTccTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTccTmp.ReadTcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TTccTmp.WriteTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTccTmp.ReadTccItm:word;
begin
  Result := oTmpTable.FieldByName('TccItm').AsInteger;
end;

procedure TTccTmp.WriteTccItm(pValue:word);
begin
  oTmpTable.FieldByName('TccItm').AsInteger := pValue;
end;

function TTccTmp.ReadTcdItm:longint;
begin
  Result := oTmpTable.FieldByName('TcdItm').AsInteger;
end;

procedure TTccTmp.WriteTcdItm(pValue:longint);
begin
  oTmpTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TTccTmp.ReadParent:longint;
begin
  Result := oTmpTable.FieldByName('Parent').AsInteger;
end;

procedure TTccTmp.WriteParent(pValue:longint);
begin
  oTmpTable.FieldByName('Parent').AsInteger := pValue;
end;

function TTccTmp.ReadCpCode:longint;
begin
  Result := oTmpTable.FieldByName('CpCode').AsInteger;
end;

procedure TTccTmp.WriteCpCode(pValue:longint);
begin
  oTmpTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TTccTmp.ReadStkNum:longint;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TTccTmp.WriteStkNum(pValue:longint);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTccTmp.ReadPdCode:longint;
begin
  Result := oTmpTable.FieldByName('PdCode').AsInteger;
end;

procedure TTccTmp.WritePdCode(pValue:longint);
begin
  oTmpTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TTccTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TTccTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTccTmp.ReadCpName:Str30;
begin
  Result := oTmpTable.FieldByName('CpName').AsString;
end;

procedure TTccTmp.WriteCpName(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName').AsString := pValue;
end;

function TTccTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TTccTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TTccTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTccTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTccTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TTccTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TTccTmp.ReadPdGsQnt:double;
begin
  Result := oTmpTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TTccTmp.WritePdGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TTccTmp.ReadRcGsQnt:double;
begin
  Result := oTmpTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TTccTmp.WriteRcGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TTccTmp.ReadLosPrc:double;
begin
  Result := oTmpTable.FieldByName('LosPrc').AsFloat;
end;

procedure TTccTmp.WriteLosPrc(pValue:double);
begin
  oTmpTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TTccTmp.ReadCpSeQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TTccTmp.WriteCpSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TTccTmp.ReadCpSuQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TTccTmp.WriteCpSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TTccTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TTccTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TTccTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TTccTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TTccTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TTccTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TTccTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TTccTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTccTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TTccTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TTccTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TTccTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTccTmp.ReadAcCValue:double;
begin
  Result := oTmpTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTccTmp.WriteAcCValue(pValue:double);
begin
  oTmpTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTccTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTccTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TTccTmp.ReadFgCValue:double;
begin
  Result := oTmpTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTccTmp.WriteFgCValue(pValue:double);
begin
  oTmpTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTccTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTccTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTccTmp.ReadDlvDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTccTmp.WriteDlvDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTccTmp.ReadDrbDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTccTmp.WriteDrbDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TTccTmp.ReadDlvUser:Str8;
begin
  Result := oTmpTable.FieldByName('DlvUser').AsString;
end;

procedure TTccTmp.WriteDlvUser(pValue:Str8);
begin
  oTmpTable.FieldByName('DlvUser').AsString := pValue;
end;

function TTccTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTccTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTccTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTccTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTccTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTccTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTccTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TTccTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTccTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTccTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTccTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTccTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTccTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTccTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTccTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTccTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTccTmp.Locate (pTcdNum:Str12;pTccItm:word):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pTcdNum,pTccItm]);
end;

function TTccTmp.LocateTdTi (pTcdNum:Str12;pTcdItm:longint):boolean;
begin
  SetIndex (ixTdTi);
  Result := oTmpTable.FindKey([pTcdNum,pTcdItm]);
end;

function TTccTmp.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oTmpTable.FindKey([pTcdNum]);
end;

function TTccTmp.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oTmpTable.FindKey([pCpCode]);
end;

function TTccTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

procedure TTccTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTccTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTccTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTccTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTccTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTccTmp.First;
begin
  oTmpTable.First;
end;

procedure TTccTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTccTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTccTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTccTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTccTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTccTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTccTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTccTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTccTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTccTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTccTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
