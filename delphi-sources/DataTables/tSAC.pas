unit tSAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixDnInSt = 'DnInSt';
  ixDnPa = 'DnPa';
  ixDocNum = 'DocNum';
  ixCpName_ = 'CpName_';
  ixPdCode = 'PdCode';
  ixCpCode = 'CpCode';
  ixStkStat = 'StkStat';

type
  TSacTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSacNum:longint;        procedure WriteSacNum (pValue:longint);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadStkNum:Longint;        procedure WriteStkNum (pValue:Longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadCpName_:Str30;         procedure WriteCpName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadRcGsQnt:double;        procedure WriteRcGsQnt (pValue:double);
    function  ReadLosPrc:double;         procedure WriteLosPrc (pValue:double);
    function  ReadCpSeQnt:double;        procedure WriteCpSeQnt (pValue:double);
    function  ReadCpSuQnt:double;        procedure WriteCpSuQnt (pValue:double);
    function  ReadNsQnt:double;          procedure WriteNsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
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
    function Locate (pDocNum:Str12;pSacNum:longint):boolean;
    function LocateDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:Longint):boolean;
    function LocateDnPa (pDocNum:Str12;pParent:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateCpName_ (pCpName_:Str30):boolean;
    function LocatePdCode (pPdCode:longint):boolean;
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SacNum:longint read ReadSacNum write WriteSacNum;
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property Parent:longint read ReadParent write WriteParent;
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property StkNum:Longint read ReadStkNum write WriteStkNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property CpName_:Str30 read ReadCpName_ write WriteCpName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property RcGsQnt:double read ReadRcGsQnt write WriteRcGsQnt;
    property LosPrc:double read ReadLosPrc write WriteLosPrc;
    property CpSeQnt:double read ReadCpSeQnt write WriteCpSeQnt;
    property CpSuQnt:double read ReadCpSuQnt write WriteCpSuQnt;
    property NsQnt:double read ReadNsQnt write WriteNsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property ItmType:Str1 read ReadItmType write WriteItmType;
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

constructor TSacTmp.Create;
begin
  oTmpTable := TmpInit ('SAC',Self);
end;

destructor TSacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSacTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSacTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSacTmp.ReadSacNum:longint;
begin
  Result := oTmpTable.FieldByName('SacNum').AsInteger;
end;

procedure TSacTmp.WriteSacNum(pValue:longint);
begin
  oTmpTable.FieldByName('SacNum').AsInteger := pValue;
end;

function TSacTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSacTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSacTmp.ReadParent:longint;
begin
  Result := oTmpTable.FieldByName('Parent').AsInteger;
end;

procedure TSacTmp.WriteParent(pValue:longint);
begin
  oTmpTable.FieldByName('Parent').AsInteger := pValue;
end;

function TSacTmp.ReadPdCode:longint;
begin
  Result := oTmpTable.FieldByName('PdCode').AsInteger;
end;

procedure TSacTmp.WritePdCode(pValue:longint);
begin
  oTmpTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TSacTmp.ReadCpCode:longint;
begin
  Result := oTmpTable.FieldByName('CpCode').AsInteger;
end;

procedure TSacTmp.WriteCpCode(pValue:longint);
begin
  oTmpTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TSacTmp.ReadStkNum:Longint;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSacTmp.WriteStkNum(pValue:Longint);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSacTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSacTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSacTmp.ReadCpName:Str30;
begin
  Result := oTmpTable.FieldByName('CpName').AsString;
end;

procedure TSacTmp.WriteCpName(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName').AsString := pValue;
end;

function TSacTmp.ReadCpName_:Str30;
begin
  Result := oTmpTable.FieldByName('CpName_').AsString;
end;

procedure TSacTmp.WriteCpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName_').AsString := pValue;
end;

function TSacTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSacTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSacTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSacTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSacTmp.ReadPdGsQnt:double;
begin
  Result := oTmpTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TSacTmp.WritePdGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TSacTmp.ReadRcGsQnt:double;
begin
  Result := oTmpTable.FieldByName('RcGsQnt').AsFloat;
end;

procedure TSacTmp.WriteRcGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('RcGsQnt').AsFloat := pValue;
end;

function TSacTmp.ReadLosPrc:double;
begin
  Result := oTmpTable.FieldByName('LosPrc').AsFloat;
end;

procedure TSacTmp.WriteLosPrc(pValue:double);
begin
  oTmpTable.FieldByName('LosPrc').AsFloat := pValue;
end;

function TSacTmp.ReadCpSeQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TSacTmp.WriteCpSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TSacTmp.ReadCpSuQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TSacTmp.WriteCpSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TSacTmp.ReadNsQnt:double;
begin
  Result := oTmpTable.FieldByName('NsQnt').AsFloat;
end;

procedure TSacTmp.WriteNsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsQnt').AsFloat := pValue;
end;

function TSacTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TSacTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TSacTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TSacTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TSacTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSacTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSacTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSacTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSacTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TSacTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TSacTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TSacTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TSacTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSacTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSacTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSacTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSacTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSacTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSacTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSacTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSacTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSacTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSacTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSacTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSacTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSacTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSacTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSacTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSacTmp.Locate (pDocNum:Str12;pSacNum:longint):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pDocNum,pSacNum]);
end;

function TSacTmp.LocateDnInSt (pDocNum:Str12;pItmNum:longint;pStkNum:Longint):boolean;
begin
  SetIndex (ixDnInSt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum,pStkNum]);
end;

function TSacTmp.LocateDnPa (pDocNum:Str12;pParent:longint):boolean;
begin
  SetIndex (ixDnPa);
  Result := oTmpTable.FindKey([pDocNum,pParent]);
end;

function TSacTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSacTmp.LocateCpName_ (pCpName_:Str30):boolean;
begin
  SetIndex (ixCpName_);
  Result := oTmpTable.FindKey([pCpName_]);
end;

function TSacTmp.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oTmpTable.FindKey([pPdCode]);
end;

function TSacTmp.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oTmpTable.FindKey([pCpCode]);
end;

function TSacTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

procedure TSacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSacTmp.First;
begin
  oTmpTable.First;
end;

procedure TSacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
