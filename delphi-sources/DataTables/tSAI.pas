unit tSAI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoGsSt = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';
  ixSeQnt = 'SeQnt';
  ixSuQnt = 'SuQnt';
  ixCValue = 'CValue';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixStkStat = 'StkStat';
  ixSnSsGc = 'SnSsGc';

type
  TSaiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:Longint;        procedure WriteGsCode (pValue:Longint);
    function  ReadStkNum:Longint;        procedure WriteStkNum (pValue:Longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSeQnt:double;          procedure WriteSeQnt (pValue:double);
    function  ReadSuQnt:double;          procedure WriteSuQnt (pValue:double);
    function  ReadNsQnt:double;          procedure WriteNsQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkStat:Str1;          procedure WriteStkStat (pValue:Str1);
    function  ReadCpSeQnt:double;        procedure WriteCpSeQnt (pValue:double);
    function  ReadCpSuQnt:double;        procedure WriteCpSuQnt (pValue:double);
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
    function LocateDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:Longint):boolean;
    function LocateGsCode (pGsCode:Longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSeQnt (pSeQnt:double):boolean;
    function LocateSuQnt (pSuQnt:double):boolean;
    function LocateCValue (pCValue:double):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateStkStat (pStkStat:Str1):boolean;
    function LocateSnSsGc (pStkNum:Longint;pStkStat:Str1;pGsCode:Longint):boolean;

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
    property GsCode:Longint read ReadGsCode write WriteGsCode;
    property StkNum:Longint read ReadStkNum write WriteStkNum;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SeQnt:double read ReadSeQnt write WriteSeQnt;
    property SuQnt:double read ReadSuQnt write WriteSuQnt;
    property NsQnt:double read ReadNsQnt write WriteNsQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkStat:Str1 read ReadStkStat write WriteStkStat;
    property CpSeQnt:double read ReadCpSeQnt write WriteCpSeQnt;
    property CpSuQnt:double read ReadCpSuQnt write WriteCpSuQnt;
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

constructor TSaiTmp.Create;
begin
  oTmpTable := TmpInit ('SAI',Self);
end;

destructor TSaiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSaiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSaiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSaiTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSaiTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSaiTmp.ReadGsCode:Longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSaiTmp.WriteGsCode(pValue:Longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSaiTmp.ReadStkNum:Longint;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TSaiTmp.WriteStkNum(pValue:Longint);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TSaiTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSaiTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSaiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSaiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSaiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSaiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSaiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSaiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSaiTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TSaiTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TSaiTmp.ReadSeQnt:double;
begin
  Result := oTmpTable.FieldByName('SeQnt').AsFloat;
end;

procedure TSaiTmp.WriteSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('SeQnt').AsFloat := pValue;
end;

function TSaiTmp.ReadSuQnt:double;
begin
  Result := oTmpTable.FieldByName('SuQnt').AsFloat;
end;

procedure TSaiTmp.WriteSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('SuQnt').AsFloat := pValue;
end;

function TSaiTmp.ReadNsQnt:double;
begin
  Result := oTmpTable.FieldByName('NsQnt').AsFloat;
end;

procedure TSaiTmp.WriteNsQnt(pValue:double);
begin
  oTmpTable.FieldByName('NsQnt').AsFloat := pValue;
end;

function TSaiTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TSaiTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TSaiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSaiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSaiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TSaiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TSaiTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TSaiTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TSaiTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TSaiTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TSaiTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSaiTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSaiTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TSaiTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TSaiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TSaiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TSaiTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSaiTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSaiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSaiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSaiTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSaiTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSaiTmp.ReadStkStat:Str1;
begin
  Result := oTmpTable.FieldByName('StkStat').AsString;
end;

procedure TSaiTmp.WriteStkStat(pValue:Str1);
begin
  oTmpTable.FieldByName('StkStat').AsString := pValue;
end;

function TSaiTmp.ReadCpSeQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSeQnt').AsFloat;
end;

procedure TSaiTmp.WriteCpSeQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSeQnt').AsFloat := pValue;
end;

function TSaiTmp.ReadCpSuQnt:double;
begin
  Result := oTmpTable.FieldByName('CpSuQnt').AsFloat;
end;

procedure TSaiTmp.WriteCpSuQnt(pValue:double);
begin
  oTmpTable.FieldByName('CpSuQnt').AsFloat := pValue;
end;

function TSaiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TSaiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSaiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSaiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSaiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSaiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSaiTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSaiTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSaiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSaiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSaiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSaiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSaiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSaiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSaiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSaiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSaiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSaiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSaiTmp.LocateDoGsSt (pDocNum:Str12;pGsCode:Longint;pStkNum:Longint):boolean;
begin
  SetIndex (ixDoGsSt);
  Result := oTmpTable.FindKey([pDocNum,pGsCode,pStkNum]);
end;

function TSaiTmp.LocateGsCode (pGsCode:Longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSaiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSaiTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TSaiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TSaiTmp.LocateSeQnt (pSeQnt:double):boolean;
begin
  SetIndex (ixSeQnt);
  Result := oTmpTable.FindKey([pSeQnt]);
end;

function TSaiTmp.LocateSuQnt (pSuQnt:double):boolean;
begin
  SetIndex (ixSuQnt);
  Result := oTmpTable.FindKey([pSuQnt]);
end;

function TSaiTmp.LocateCValue (pCValue:double):boolean;
begin
  SetIndex (ixCValue);
  Result := oTmpTable.FindKey([pCValue]);
end;

function TSaiTmp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TSaiTmp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TSaiTmp.LocateStkStat (pStkStat:Str1):boolean;
begin
  SetIndex (ixStkStat);
  Result := oTmpTable.FindKey([pStkStat]);
end;

function TSaiTmp.LocateSnSsGc (pStkNum:Longint;pStkStat:Str1;pGsCode:Longint):boolean;
begin
  SetIndex (ixSnSsGc);
  Result := oTmpTable.FindKey([pStkNum,pStkStat,pGsCode]);
end;

procedure TSaiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSaiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSaiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSaiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSaiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSaiTmp.First;
begin
  oTmpTable.First;
end;

procedure TSaiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSaiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSaiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSaiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSaiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSaiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSaiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSaiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSaiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSaiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSaiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
