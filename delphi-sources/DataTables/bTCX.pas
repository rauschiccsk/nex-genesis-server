unit bTCX;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnInCpSn = 'DnInCpSn';
  ixDnIn = 'DnIn';
  ixDocNum = 'DocNum';
  ixStkStat = 'StkStat';

type
  TTcxBtr = class (TComponent)
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
    function LocateDnInCpSn (pDocNum:Str12;pItmNum:word;pCpCode:longint;pStkNum:longint):boolean;
    function LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function NearestDnInCpSn (pDocNum:Str12;pItmNum:word;pCpCode:longint;pStkNum:longint):boolean;
    function NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestStkStat (pStkStat:Str1):boolean;

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

constructor TTcxBtr.Create;
begin
  oBtrTable := BtrInit ('TCX',gPath.StkPath,Self);
end;

constructor TTcxBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TCX',pPath,Self);
end;

destructor TTcxBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTcxBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTcxBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTcxBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTcxBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTcxBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTcxBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTcxBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TTcxBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TTcxBtr.ReadCpCode:longint;
begin
  Result := oBtrTable.FieldByName('CpCode').AsInteger;
end;

procedure TTcxBtr.WriteCpCode(pValue:longint);
begin
  oBtrTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TTcxBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TTcxBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TTcxBtr.ReadCpName:Str30;
begin
  Result := oBtrTable.FieldByName('CpName').AsString;
end;

procedure TTcxBtr.WriteCpName(pValue:Str30);
begin
  oBtrTable.FieldByName('CpName').AsString := pValue;
end;

function TTcxBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TTcxBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TTcxBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TTcxBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TTcxBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TTcxBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TTcxBtr.ReadPdGsQnt:double;
begin
  Result := oBtrTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TTcxBtr.WritePdGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TTcxBtr.ReadRcGsQnt:double;
begin
  Result := oBtrTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TTcxBtr.WriteRcGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TTcxBtr.ReadLosPrc:double;
begin
  Result := oBtrTable.FieldByName('LosPrc').AsFloat;
end;

procedure TTcxBtr.WriteLosPrc(pValue:double);
begin
  oBtrTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TTcxBtr.ReadCpSeQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TTcxBtr.WriteCpSeQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TTcxBtr.ReadCpSuQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TTcxBtr.WriteCpSuQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TTcxBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTcxBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTcxBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TTcxBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TTcxBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TTcxBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TTcxBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TTcxBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TTcxBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TTcxBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TTcxBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTcxBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTcxBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TTcxBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TTcxBtr.ReadAcCValue:double;
begin
  Result := oBtrTable.FieldByName('AcCValue').AsFloat;
end;

procedure TTcxBtr.WriteAcCValue(pValue:double);
begin
  oBtrTable.FieldByName('AcCValue').AsFloat := pValue;
end;

function TTcxBtr.ReadFgCPrice:double;
begin
  Result := oBtrTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TTcxBtr.WriteFgCPrice(pValue:double);
begin
  oBtrTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TTcxBtr.ReadFgCValue:double;
begin
  Result := oBtrTable.FieldByName('FgCValue').AsFloat;
end;

procedure TTcxBtr.WriteFgCValue(pValue:double);
begin
  oBtrTable.FieldByName('FgCValue').AsFloat := pValue;
end;

function TTcxBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTcxBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTcxBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TTcxBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TTcxBtr.ReadDrbDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DrbDate').AsDateTime;
end;

procedure TTcxBtr.WriteDrbDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DrbDate').AsDateTime := pValue;
end;

function TTcxBtr.ReadDlvUser:Str8;
begin
  Result := oBtrTable.FieldByName('DlvUser').AsString;
end;

procedure TTcxBtr.WriteDlvUser(pValue:Str8);
begin
  oBtrTable.FieldByName('DlvUser').AsString := pValue;
end;

function TTcxBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTcxBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTcxBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTcxBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTcxBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTcxBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTcxBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTcxBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTcxBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTcxBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTcxBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTcxBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTcxBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTcxBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTcxBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTcxBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTcxBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTcxBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTcxBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTcxBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTcxBtr.LocateDnInCpSn (pDocNum:Str12;pItmNum:word;pCpCode:longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDnInCpSn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pCpCode,pStkNum]);
end;

function TTcxBtr.LocateDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTcxBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTcxBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TTcxBtr.NearestDnInCpSn (pDocNum:Str12;pItmNum:word;pCpCode:longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDnInCpSn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pCpCode,pStkNum]);
end;

function TTcxBtr.NearestDnIn (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDnIn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTcxBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTcxBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

procedure TTcxBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTcxBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTcxBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTcxBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTcxBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTcxBtr.First;
begin
  oBtrTable.First;
end;

procedure TTcxBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTcxBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTcxBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTcxBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTcxBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTcxBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTcxBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTcxBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTcxBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTcxBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTcxBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
