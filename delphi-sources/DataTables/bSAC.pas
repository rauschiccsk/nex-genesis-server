unit bSAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnSn = 'DnSn';
  ixDnInSt = 'DnInSt';
  ixDnPa = 'DnPa';
  ixDocNum = 'DocNum';
  ixPdCode = 'PdCode';
  ixCpCode = 'CpCode';
  ixStkStat = 'StkStat';

type
  TSacBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadStkNum:longint;        procedure WriteStkNum (pValue:longint);
    function  ReadSacNum:longint;        procedure WriteSacNum (pValue:longint);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadRcGsQnt:double;        procedure WriteRcGsQnt (pValue:double);
    function  ReadLosPrc:double;         procedure WriteLosPrc (pValue:double);
    function  ReadCpSeQnt:double;        procedure WriteCpSeQnt (pValue:double);
    function  ReadCpSuQnt:double;        procedure WriteCpSuQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDnSn (pDocNum:Str12;pSacNum:longint):boolean;
    function LocateDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:longint):boolean;
    function LocateDnPa (pDocNum:Str12;pParent:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocatePdCode (pPdCode:longint):boolean;
    function LocateCpCode (pCpCode:longint):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function NearestDnSn (pDocNum:Str12;pSacNum:longint):boolean;
    function NearestDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:longint):boolean;
    function NearestDnPa (pDocNum:Str12;pParent:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestPdCode (pPdCode:longint):boolean;
    function NearestCpCode (pCpCode:longint):boolean;
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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property StkNum:longint read ReadStkNum write WriteStkNum;
    property SacNum:longint read ReadSacNum write WriteSacNum;
    property Parent:longint read ReadParent write WriteParent;
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property RcGsQnt:double read ReadRcGsQnt write WriteRcGsQnt;
    property LosPrc:double read ReadLosPrc write WriteLosPrc;
    property CpSeQnt:double read ReadCpSeQnt write WriteCpSeQnt;
    property CpSuQnt:double read ReadCpSuQnt write WriteCpSuQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ItmType:Str1 read ReadItmType write WriteItmType;
  end;

implementation

constructor TSacBtr.Create;
begin
  oBtrTable := BtrInit ('SAC',gPath.CabPath,Self);
end;

constructor TSacBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SAC',pPath,Self);
end;

destructor TSacBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSacBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSacBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSacBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSacBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSacBtr.ReadItmNum:longint;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSacBtr.WriteItmNum(pValue:longint);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSacBtr.ReadStkNum:longint;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TSacBtr.WriteStkNum(pValue:longint);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSacBtr.ReadSacNum:longint;
begin
  Result := oBtrTable.FieldByName('SacNum').AsInteger;
end;

procedure TSacBtr.WriteSacNum(pValue:longint);
begin
  oBtrTable.FieldByName('SacNum').AsInteger := pValue;
end;

function TSacBtr.ReadParent:longint;
begin
  Result := oBtrTable.FieldByName('Parent').AsInteger;
end;

procedure TSacBtr.WriteParent(pValue:longint);
begin
  oBtrTable.FieldByName('Parent').AsInteger := pValue;
end;

function TSacBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TSacBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TSacBtr.ReadCpCode:longint;
begin
  Result := oBtrTable.FieldByName('CpCode').AsInteger;
end;

procedure TSacBtr.WriteCpCode(pValue:longint);
begin
  oBtrTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TSacBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TSacBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSacBtr.ReadCpName:Str30;
begin
  Result := oBtrTable.FieldByName('CpName').AsString;
end;

procedure TSacBtr.WriteCpName(pValue:Str30);
begin
  oBtrTable.FieldByName('CpName').AsString := pValue;
end;

function TSacBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TSacBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TSacBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSacBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSacBtr.ReadPdGsQnt:double;
begin
  Result := oBtrTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TSacBtr.WritePdGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TSacBtr.ReadRcGsQnt:double;
begin
  Result := oBtrTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TSacBtr.WriteRcGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TSacBtr.ReadLosPrc:double;
begin
  Result := oBtrTable.FieldByName('LosPrc').AsFloat;
end;

procedure TSacBtr.WriteLosPrc(pValue:double);
begin
  oBtrTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TSacBtr.ReadCpSeQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TSacBtr.WriteCpSeQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TSacBtr.ReadCpSuQnt:double;
begin
  Result := oBtrTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TSacBtr.WriteCpSuQnt(pValue:double);
begin
  oBtrTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TSacBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TSacBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TSacBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TSacBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TSacBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TSacBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSacBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSacBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSacBtr.ReadStkStat:Str1;
begin
  Result := oBtrTable.FieldByName('StkStat').AsString;
end;

procedure TSacBtr.WriteStkStat(pValue:Str1);
begin
  oBtrTable.FieldByName('StkStat').AsString := pValue;
end;

function TSacBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSacBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSacBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSacBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSacBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSacBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSacBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSacBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSacBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSacBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSacBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSacBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSacBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSacBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSacBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TSacBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSacBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSacBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSacBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSacBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSacBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSacBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSacBtr.LocateDnSn (pDocNum:Str12;pSacNum:longint):boolean;
begin
  SetIndex (ixDnSn);
  Result := oBtrTable.FindKey([pDocNum,pSacNum]);
end;

function TSacBtr.LocateDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDnInSt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pStkNum]);
end;

function TSacBtr.LocateDnPa (pDocNum:Str12;pParent:longint):boolean;
begin
  SetIndex (ixDnPa);
  Result := oBtrTable.FindKey([pDocNum,pParent]);
end;

function TSacBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSacBtr.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindKey([pPdCode]);
end;

function TSacBtr.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oBtrTable.FindKey([pCpCode]);
end;

function TSacBtr.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindKey([pStkStat]);
end;

function TSacBtr.NearestDnSn (pDocNum:Str12;pSacNum:longint):boolean;
begin
  SetIndex (ixDnSn);
  Result := oBtrTable.FindNearest([pDocNum,pSacNum]);
end;

function TSacBtr.NearestDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:longint):boolean;
begin
  SetIndex (ixDnInSt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pStkNum]);
end;

function TSacBtr.NearestDnPa (pDocNum:Str12;pParent:longint):boolean;
begin
  SetIndex (ixDnPa);
  Result := oBtrTable.FindNearest([pDocNum,pParent]);
end;

function TSacBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSacBtr.NearestPdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindNearest([pPdCode]);
end;

function TSacBtr.NearestCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oBtrTable.FindNearest([pCpCode]);
end;

function TSacBtr.NearestStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oBtrTable.FindNearest([pStkStat]);
end;

procedure TSacBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSacBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSacBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSacBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSacBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSacBtr.First;
begin
  oBtrTable.First;
end;

procedure TSacBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSacBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSacBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSacBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSacBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSacBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSacBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSacBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSacBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSacBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSacBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
