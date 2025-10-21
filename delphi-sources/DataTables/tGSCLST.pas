unit tGSCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgGs = 'MgGs';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixOsdCode = 'OsdCode';
  ixSpcCode = 'SpcCode';
  ixVatPrc = 'VatPrc';
  ixMsName = 'MsName';

type
  TGsclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadPackGs:longint;        procedure WritePackGs (pValue:longint);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadDrbMust:boolean;       procedure WriteDrbMust (pValue:boolean);
    function  ReadDrbDay:word;           procedure WriteDrbDay (pValue:word);
    function  ReadPdnMust:boolean;       procedure WritePdnMust (pValue:boolean);
    function  ReadGrcMth:word;           procedure WriteGrcMth (pValue:word);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadMsuQnt:double;         procedure WriteMsuQnt (pValue:double);
    function  ReadMsuName:Str5;          procedure WriteMsuName (pValue:Str5);
    function  ReadDisFlag:boolean;       procedure WriteDisFlag (pValue:boolean);
    function  ReadLinDate:TDatetime;     procedure WriteLinDate (pValue:TDatetime);
    function  ReadLinPce:double;         procedure WriteLinPce (pValue:double);
    function  ReadLinStk:word;           procedure WriteLinStk (pValue:word);
    function  ReadLinPac:longint;        procedure WriteLinPac (pValue:longint);
    function  ReadSecNum:word;           procedure WriteSecNum (pValue:word);
    function  ReadWgCode:word;           procedure WriteWgCode (pValue:word);
    function  ReadBasGsc:longint;        procedure WriteBasGsc (pValue:longint);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadGspKfc:word;           procedure WriteGspKfc (pValue:word);
    function  ReadQliKfc:double;         procedure WriteQliKfc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateOsdCode (pOsdCode:Str15):boolean;
    function LocateSpcCode (pSpcCode:Str30):boolean;
    function LocateVatPrc (pVatPrc:byte):boolean;
    function LocateMsName (pMsName:Str10):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property PackGs:longint read ReadPackGs write WritePackGs;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property DrbMust:boolean read ReadDrbMust write WriteDrbMust;
    property DrbDay:word read ReadDrbDay write WriteDrbDay;
    property PdnMust:boolean read ReadPdnMust write WritePdnMust;
    property GrcMth:word read ReadGrcMth write WriteGrcMth;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property MsuQnt:double read ReadMsuQnt write WriteMsuQnt;
    property MsuName:Str5 read ReadMsuName write WriteMsuName;
    property DisFlag:boolean read ReadDisFlag write WriteDisFlag;
    property LinDate:TDatetime read ReadLinDate write WriteLinDate;
    property LinPce:double read ReadLinPce write WriteLinPce;
    property LinStk:word read ReadLinStk write WriteLinStk;
    property LinPac:longint read ReadLinPac write WriteLinPac;
    property SecNum:word read ReadSecNum write WriteSecNum;
    property WgCode:word read ReadWgCode write WriteWgCode;
    property BasGsc:longint read ReadBasGsc write WriteBasGsc;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property GspKfc:word read ReadGspKfc write WriteGspKfc;
    property QliKfc:double read ReadQliKfc write WriteQliKfc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property Action:Str1 read ReadAction write WriteAction;
  end;

implementation

constructor TGsclstTmp.Create;
begin
  oTmpTable := TmpInit ('GSCLST',Self);
end;

destructor TGsclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGsclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGsclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGsclstTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsclstTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsclstTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGsclstTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGsclstTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TGsclstTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TGsclstTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TGsclstTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGsclstTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TGsclstTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TGsclstTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TGsclstTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TGsclstTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TGsclstTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TGsclstTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TGsclstTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGsclstTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TGsclstTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGsclstTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TGsclstTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TGsclstTmp.ReadPackGs:longint;
begin
  Result := oTmpTable.FieldByName('PackGs').AsInteger;
end;

procedure TGsclstTmp.WritePackGs(pValue:longint);
begin
  oTmpTable.FieldByName('PackGs').AsInteger := pValue;
end;

function TGsclstTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TGsclstTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TGsclstTmp.ReadDrbMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DrbMust').AsInteger);
end;

procedure TGsclstTmp.WriteDrbMust(pValue:boolean);
begin
  oTmpTable.FieldByName('DrbMust').AsInteger := BoolToByte(pValue);
end;

function TGsclstTmp.ReadDrbDay:word;
begin
  Result := oTmpTable.FieldByName('DrbDay').AsInteger;
end;

procedure TGsclstTmp.WriteDrbDay(pValue:word);
begin
  oTmpTable.FieldByName('DrbDay').AsInteger := pValue;
end;

function TGsclstTmp.ReadPdnMust:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('PdnMust').AsInteger);
end;

procedure TGsclstTmp.WritePdnMust(pValue:boolean);
begin
  oTmpTable.FieldByName('PdnMust').AsInteger := BoolToByte(pValue);
end;

function TGsclstTmp.ReadGrcMth:word;
begin
  Result := oTmpTable.FieldByName('GrcMth').AsInteger;
end;

procedure TGsclstTmp.WriteGrcMth(pValue:word);
begin
  oTmpTable.FieldByName('GrcMth').AsInteger := pValue;
end;

function TGsclstTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TGsclstTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TGsclstTmp.ReadVolume:double;
begin
  Result := oTmpTable.FieldByName('Volume').AsFloat;
end;

procedure TGsclstTmp.WriteVolume(pValue:double);
begin
  oTmpTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGsclstTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TGsclstTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGsclstTmp.ReadMsuQnt:double;
begin
  Result := oTmpTable.FieldByName('MsuQnt').AsFloat;
end;

procedure TGsclstTmp.WriteMsuQnt(pValue:double);
begin
  oTmpTable.FieldByName('MsuQnt').AsFloat := pValue;
end;

function TGsclstTmp.ReadMsuName:Str5;
begin
  Result := oTmpTable.FieldByName('MsuName').AsString;
end;

procedure TGsclstTmp.WriteMsuName(pValue:Str5);
begin
  oTmpTable.FieldByName('MsuName').AsString := pValue;
end;

function TGsclstTmp.ReadDisFlag:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('DisFlag').AsInteger);
end;

procedure TGsclstTmp.WriteDisFlag(pValue:boolean);
begin
  oTmpTable.FieldByName('DisFlag').AsInteger := BoolToByte(pValue);
end;

function TGsclstTmp.ReadLinDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LinDate').AsDateTime;
end;

procedure TGsclstTmp.WriteLinDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LinDate').AsDateTime := pValue;
end;

function TGsclstTmp.ReadLinPce:double;
begin
  Result := oTmpTable.FieldByName('LinPce').AsFloat;
end;

procedure TGsclstTmp.WriteLinPce(pValue:double);
begin
  oTmpTable.FieldByName('LinPce').AsFloat := pValue;
end;

function TGsclstTmp.ReadLinStk:word;
begin
  Result := oTmpTable.FieldByName('LinStk').AsInteger;
end;

procedure TGsclstTmp.WriteLinStk(pValue:word);
begin
  oTmpTable.FieldByName('LinStk').AsInteger := pValue;
end;

function TGsclstTmp.ReadLinPac:longint;
begin
  Result := oTmpTable.FieldByName('LinPac').AsInteger;
end;

procedure TGsclstTmp.WriteLinPac(pValue:longint);
begin
  oTmpTable.FieldByName('LinPac').AsInteger := pValue;
end;

function TGsclstTmp.ReadSecNum:word;
begin
  Result := oTmpTable.FieldByName('SecNum').AsInteger;
end;

procedure TGsclstTmp.WriteSecNum(pValue:word);
begin
  oTmpTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TGsclstTmp.ReadWgCode:word;
begin
  Result := oTmpTable.FieldByName('WgCode').AsInteger;
end;

procedure TGsclstTmp.WriteWgCode(pValue:word);
begin
  oTmpTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TGsclstTmp.ReadBasGsc:longint;
begin
  Result := oTmpTable.FieldByName('BasGsc').AsInteger;
end;

procedure TGsclstTmp.WriteBasGsc(pValue:longint);
begin
  oTmpTable.FieldByName('BasGsc').AsInteger := pValue;
end;

function TGsclstTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TGsclstTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TGsclstTmp.ReadGspKfc:word;
begin
  Result := oTmpTable.FieldByName('GspKfc').AsInteger;
end;

procedure TGsclstTmp.WriteGspKfc(pValue:word);
begin
  oTmpTable.FieldByName('GspKfc').AsInteger := pValue;
end;

function TGsclstTmp.ReadQliKfc:double;
begin
  Result := oTmpTable.FieldByName('QliKfc').AsFloat;
end;

procedure TGsclstTmp.WriteQliKfc(pValue:double);
begin
  oTmpTable.FieldByName('QliKfc').AsFloat := pValue;
end;

function TGsclstTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TGsclstTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TGsclstTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TGsclstTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TGsclstTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TGsclstTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TGsclstTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TGsclstTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TGsclstTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TGsclstTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGsclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGsclstTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TGsclstTmp.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oTmpTable.FindKey([pMgCode,pGsCode]);
end;

function TGsclstTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TGsclstTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TGsclstTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TGsclstTmp.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oTmpTable.FindKey([pOsdCode]);
end;

function TGsclstTmp.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oTmpTable.FindKey([pSpcCode]);
end;

function TGsclstTmp.LocateVatPrc (pVatPrc:byte):boolean;
begin
  SetIndex (ixVatPrc);
  Result := oTmpTable.FindKey([pVatPrc]);
end;

function TGsclstTmp.LocateMsName (pMsName:Str10):boolean;
begin
  SetIndex (ixMsName);
  Result := oTmpTable.FindKey([pMsName]);
end;

procedure TGsclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGsclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGsclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGsclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGsclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGsclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TGsclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGsclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGsclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGsclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGsclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGsclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGsclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGsclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGsclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGsclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGsclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
