unit tSADCMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixPdName_ = 'PdName_';
  ixCpName_ = 'CpName_';
  ixPdCode = 'PdCode';
  ixCpCode = 'CpCode';
  ixStkStat = 'StkStat';

type
  TSadcmpTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadParent:longint;        procedure WriteParent (pValue:longint);
    function  ReadSacNum:longint;        procedure WriteSacNum (pValue:longint);
    function  ReadPdName:Str30;          procedure WritePdName (pValue:Str30);
    function  ReadCpName:Str30;          procedure WriteCpName (pValue:Str30);
    function  ReadPdName_:Str30;         procedure WritePdName_ (pValue:Str30);
    function  ReadCpName_:Str30;         procedure WriteCpName_ (pValue:Str30);
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCpCode:longint;        procedure WriteCpCode (pValue:longint);
    function  ReadStkNum:Longint;        procedure WriteStkNum (pValue:Longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadSeQnt:double;          procedure WriteSeQnt (pValue:double);
    function  ReadSuQnt:double;          procedure WriteSuQnt (pValue:double);
    function  ReadNsQnt:double;          procedure WriteNsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (pItmNum:longint;pParent:longint;pSacNum:longint):boolean;
    function LocatePdName_ (pPdName_:Str30):boolean;
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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property Parent:longint read ReadParent write WriteParent;
    property SacNum:longint read ReadSacNum write WriteSacNum;
    property PdName:Str30 read ReadPdName write WritePdName;
    property CpName:Str30 read ReadCpName write WriteCpName;
    property PdName_:Str30 read ReadPdName_ write WritePdName_;
    property CpName_:Str30 read ReadCpName_ write WriteCpName_;
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CpCode:longint read ReadCpCode write WriteCpCode;
    property StkNum:Longint read ReadStkNum write WriteStkNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property SeQnt:double read ReadSeQnt write WriteSeQnt;
    property SuQnt:double read ReadSuQnt write WriteSuQnt;
    property NsQnt:double read ReadNsQnt write WriteNsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSadcmpTmp.Create;
begin
  oTmpTable := TmpInit ('SADCMP',Self);
end;

destructor TSadcmpTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSadcmpTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSadcmpTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSadcmpTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TSadcmpTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TSadcmpTmp.ReadParent:longint;
begin
  Result := oTmpTable.FieldByName('Parent').AsInteger;
end;

procedure TSadcmpTmp.WriteParent(pValue:longint);
begin
  oTmpTable.FieldByName('Parent').AsInteger := pValue;
end;

function TSadcmpTmp.ReadSacNum:longint;
begin
  Result := oTmpTable.FieldByName('SacNum').AsInteger;
end;

procedure TSadcmpTmp.WriteSacNum(pValue:longint);
begin
  oTmpTable.FieldByName('SacNum').AsInteger := pValue;
end;

function TSadcmpTmp.ReadPdName:Str30;
begin
  Result := oTmpTable.FieldByName('PdName').AsString;
end;

procedure TSadcmpTmp.WritePdName(pValue:Str30);
begin
  oTmpTable.FieldByName('PdName').AsString := pValue;
end;

function TSadcmpTmp.ReadCpName:Str30;
begin
  Result := oTmpTable.FieldByName('CpName').AsString;
end;

procedure TSadcmpTmp.WriteCpName(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName').AsString := pValue;
end;

function TSadcmpTmp.ReadPdName_:Str30;
begin
  Result := oTmpTable.FieldByName('PdName_').AsString;
end;

procedure TSadcmpTmp.WritePdName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PdName_').AsString := pValue;
end;

function TSadcmpTmp.ReadCpName_:Str30;
begin
  Result := oTmpTable.FieldByName('CpName_').AsString;
end;

procedure TSadcmpTmp.WriteCpName_(pValue:Str30);
begin
  oTmpTable.FieldByName('CpName_').AsString := pValue;
end;

function TSadcmpTmp.ReadPdCode:longint;
begin
  Result := oTmpTable.FieldByName('PdCode').AsInteger;
end;

procedure TSadcmpTmp.WritePdCode(pValue:longint);
begin
  oTmpTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TSadcmpTmp.ReadCpCode:longint;
begin
  Result := oTmpTable.FieldByName('CpCode').AsInteger;
end;

procedure TSadcmpTmp.WriteCpCode(pValue:longint);
begin
  oTmpTable.FieldByName('CpCode').AsInteger := pValue;
end;

function TSadcmpTmp.ReadStkNum:Longint;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSadcmpTmp.WriteStkNum(pValue:Longint);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSadcmpTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSadcmpTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSadcmpTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSadcmpTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSadcmpTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSadcmpTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSadcmpTmp.ReadSeQnt:double;
begin
  Result := oTmpTable.FieldByName('SeQnt').AsFloat;
end;

procedure TSadcmpTmp.WriteSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('SeQnt').AsFloat := pValue;
end;

function TSadcmpTmp.ReadSuQnt:double;
begin
  Result := oTmpTable.FieldByName('SuQnt').AsFloat;
end;

procedure TSadcmpTmp.WriteSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('SuQnt').AsFloat := pValue;
end;

function TSadcmpTmp.ReadNsQnt:double;
begin
  Result := oTmpTable.FieldByName('NsQnt').AsFloat;
end;

procedure TSadcmpTmp.WriteNsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsQnt').AsFloat := pValue;
end;

function TSadcmpTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TSadcmpTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TSadcmpTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TSadcmpTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TSadcmpTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSadcmpTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSadcmpTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TSadcmpTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TSadcmpTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSadcmpTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSadcmpTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TSadcmpTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TSadcmpTmp.ReadItmType:Str1;
begin
  Result := oTmpTable.FieldByName('ItmType').AsString;
end;

procedure TSadcmpTmp.WriteItmType(pValue:Str1);
begin
  oTmpTable.FieldByName('ItmType').AsString := pValue;
end;

function TSadcmpTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSadcmpTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSadcmpTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSadcmpTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSadcmpTmp.Locate (pItmNum:longint;pParent:longint;pSacNum:longint):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pItmNum,pParent,pSacNum]);
end;

function TSadcmpTmp.LocatePdName_ (pPdName_:Str30):boolean;
begin
  SetIndex (ixPdName_);
  Result := oTmpTable.FindKey([pPdName_]);
end;

function TSadcmpTmp.LocateCpName_ (pCpName_:Str30):boolean;
begin
  SetIndex (ixCpName_);
  Result := oTmpTable.FindKey([pCpName_]);
end;

function TSadcmpTmp.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oTmpTable.FindKey([pPdCode]);
end;

function TSadcmpTmp.LocateCpCode (pCpCode:longint):boolean;
begin
  SetIndex (ixCpCode);
  Result := oTmpTable.FindKey([pCpCode]);
end;

function TSadcmpTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

procedure TSadcmpTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSadcmpTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSadcmpTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSadcmpTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSadcmpTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSadcmpTmp.First;
begin
  oTmpTable.First;
end;

procedure TSadcmpTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSadcmpTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSadcmpTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSadcmpTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSadcmpTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSadcmpTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSadcmpTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSadcmpTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSadcmpTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSadcmpTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSadcmpTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1905006}
