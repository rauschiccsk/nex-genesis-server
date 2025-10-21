unit bTCC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTdTc = 'TdTc';
  ixTdTi = 'TdTi';
  ixTdPa = 'TdPa';
  ixTcdNum = 'TcdNum';
  ixStkStat = 'StkStat';
  ixCpCode = 'CpCode';

type
  TTccBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTccItm:longint;        procedure WriteTccItm (pValue:longint);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
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
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
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
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateTdTc (pTcdNum:Str12;pTccItm:longint):boolean;
    function LocateTdTi (pTcdNum:Str12;pTcditm:word):boolean;
    function LocateTdPa (pTcdNum:Str12;pParent:longint):boolean;
    function LocateTcdNum (pTcdNum:Str12):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateCpCode (pCpCode:longint):boolean;
    function NearestTdTc (pTcdNum:Str12;pTccItm:longint):boolean;
    function NearestTdTi (pTcdNum:Str12;pTcditm:word):boolean;
    function NearestTdPa (pTcdNum:Str12;pParent:longint):boolean;
    function NearestTcdNum (pTcdNum:Str12):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;
    function NearestCpCode (pCpCode:longint):boolean;

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
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TccItm:longint read ReadTccItm write WriteTccItm;
    property Parent:longint read ReadParent write WriteParent;
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
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
    property StkNum:longint read ReadStkNum write WriteStkNum;
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

constructor TTccBtr.Create;
begin
  oBtrTable := BtrInit ('TCC',gPath.StkPath,Self);
end;

constructor TTccBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TCC',pPath,Self);
end;

destructor TTccBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTccBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTccBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTccBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTccBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTccBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TTccBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TTccBtr.ReadTccItm:longint;
begin
  Result := oBtrTable.FieldByName('TccItm').AsInteger;
end;

procedure TTccBtr.WriteTccItm(pValue:longint);
begin
  oBtrTable.FieldByName('TccItm').AsInteger := pValue;
end;

function TTccBtr.ReadParent:longint;
begin
  Result := oBtrTable.FieldByName('Parent').AsInteger;
end;

procedure TTccBtr.WriteParent(pValue:longint);
begin
  oBtrTable.FieldByName('Parent').AsInteger := pValue;
end;

function TTccBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TTccBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TTccBtr.ReadCpCode:longint;
begin
  Result := oBtrTable.FieldByName('CpCode').AsInteger;
end;

procedure TTccBtr.WriteCpCode(pValue:longint);
begin
  oBtrTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TTccBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTccBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTccBtr.ReadCpName:Str30;
begin
  Result := oBtrTable.FieldByName('CpName').AsString;
end;

procedure TTccBtr.WriteCpName(pValue:Str30);
begin
  oBtrTable.FieldByName('CpName').AsString := pValue;
end;

function TTccBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTccBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTccBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTccBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTccBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TTccBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TTccBtr.ReadPdGsQnt:double;
begin
  Result := oBtrTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TTccBtr.WritePdGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TTccBtr.ReadRcGsQnt:double;
begin
  Result := oBtrTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TTccBtr.WriteRcGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TTccBtr.ReadLosPrc:double;
begin
  Result := oBtrTable.FieldByName('LosPrc').AsFloat;
end;

procedure TTccBtr.WriteLosPrc(pValue:double);
begin
  oBtrTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TTccBtr.ReadCpSeQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TTccBtr.WriteCpSeQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TTccBtr.ReadCpSuQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TTccBtr.WriteCpSuQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TTccBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTccBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTccBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TTccBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TTccBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TTccBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TTccBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTccBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTccBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TTccBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TTccBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTccBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTccBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTccBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTccBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTccBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTccBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTccBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TTccBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTccBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTccBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTccBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTccBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTccBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTccBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTccBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TTccBtr.ReadDlvUser:Str8;
begin
  Result := oBtrTable.FieldByName('DlvUser').AsString;
end;

procedure TTccBtr.WriteDlvUser(pValue:Str8);
begin
  oBtrTable.FieldByName('DlvUser').AsString := pValue;
end;

function TTccBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTccBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTccBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTccBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTccBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTccBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTccBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTccBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTccBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTccBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTccBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTccBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTccBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTccBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTccBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTccBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTccBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTccBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTccBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTccBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTccBtr.LocateTdTc (pTcdNum:Str12;pTccItm:longint):boolean;
begin
  SetIndex (ixTdTc);
  Result := oBtrTable.FindKey([pTcdNum,pTccItm]);
end;

function TTccBtr.LocateTdTi (pTcdNum:Str12;pTcditm:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindKey([pTcdNum,pTcditm]);
end;

function TTccBtr.LocateTdPa (pTcdNum:Str12;pParent:longint):boolean;
begin
  SetIndex (ixTdPa);
  Result := oBtrTable.FindKey([pTcdNum,pParent]);
end;

function TTccBtr.LocateTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindKey([pTcdNum]);
end;

function TTccBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TTccBtr.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oBtrTable.FindKey([pCpCode]);
end;

function TTccBtr.NearestTdTc (pTcdNum:Str12;pTccItm:longint):boolean;
begin
  SetIndex (ixTdTc);
  Result := oBtrTable.FindNearest([pTcdNum,pTccItm]);
end;

function TTccBtr.NearestTdTi (pTcdNum:Str12;pTcditm:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindNearest([pTcdNum,pTcditm]);
end;

function TTccBtr.NearestTdPa (pTcdNum:Str12;pParent:longint):boolean;
begin
  SetIndex (ixTdPa);
  Result := oBtrTable.FindNearest([pTcdNum,pParent]);
end;

function TTccBtr.NearestTcdNum (pTcdNum:Str12):boolean;
begin
  SetIndex (ixTcdNum);
  Result := oBtrTable.FindNearest([pTcdNum]);
end;

function TTccBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

function TTccBtr.NearestCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oBtrTable.FindNearest([pCpCode]);
end;

procedure TTccBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTccBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTccBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTccBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTccBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTccBtr.First;
begin
  oBtrTable.First;
end;

procedure TTccBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTccBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTccBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTccBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTccBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTccBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTccBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTccBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTccBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTccBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTccBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
