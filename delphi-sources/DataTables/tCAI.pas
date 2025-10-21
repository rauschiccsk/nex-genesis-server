unit tCai;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = 'ItmNum';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixAction = 'Action';

type
  TCaiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:word;           procedure WriteFgCode (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadProfit:double;         procedure WriteProfit (pValue:double);
    function  ReadItmVal:double;         procedure WriteItmVal (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscVal:double;         procedure WriteDscVal (pValue:double);
    function  ReadDscType:Str10;         procedure WriteDscType (pValue:Str10);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadProdNum:Str30;         procedure WriteProdNum (pValue:Str30);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
    function  ReadOrdPrn:byte;           procedure WriteOrdPrn (pValue:byte);
    function  ReadPceSrc:Str3;           procedure WritePceSrc (pValue:Str3);
    function  ReadDscSrc:Str3;           procedure WriteDscSrc (pValue:Str3);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateAction (pAction:Str1):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:word read ReadFgCode write WriteFgCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property CValue:double read ReadCValue write WriteCValue;
    property Profit:double read ReadProfit write WriteProfit;
    property ItmVal:double read ReadItmVal write WriteItmVal;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscVal:double read ReadDscVal write WriteDscVal;
    property DscType:Str10 read ReadDscType write WriteDscType;
    property BValue:double read ReadBValue write WriteBValue;
    property ProdNum:Str30 read ReadProdNum write WriteProdNum;
    property Action:Str1 read ReadAction write WriteAction;
    property OrdPrn:byte read ReadOrdPrn write WriteOrdPrn;
    property PceSrc:Str3 read ReadPceSrc write WritePceSrc;
    property DscSrc:Str3 read ReadDscSrc write WriteDscSrc;
  end;

implementation

constructor TCaiTmp.Create;
begin
  oTmpTable := TmpInit ('CAI',Self);
end;

destructor TCaiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCaiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCaiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCaiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TCaiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TCaiTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TCaiTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TCaiTmp.ReadFgCode:word;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TCaiTmp.WriteFgCode(pValue:word);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TCaiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCaiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCaiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCaiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCaiTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TCaiTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TCaiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCaiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCaiTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TCaiTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TCaiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TCaiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TCaiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCaiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCaiTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCaiTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCaiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCaiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCaiTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TCaiTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCaiTmp.ReadProfit:double;
begin
  Result := oTmpTable.FieldByName('Profit').AsFloat;
end;

procedure TCaiTmp.WriteProfit(pValue:double);
begin
  oTmpTable.FieldByName('Profit').AsFloat := pValue;
end;

function TCaiTmp.ReadItmVal:double;
begin
  Result := oTmpTable.FieldByName('ItmVal').AsFloat;
end;

procedure TCaiTmp.WriteItmVal(pValue:double);
begin
  oTmpTable.FieldByName('ItmVal').AsFloat := pValue;
end;

function TCaiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCaiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCaiTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TCaiTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TCaiTmp.ReadDscType:Str10;
begin
  Result := oTmpTable.FieldByName('DscType').AsString;
end;

procedure TCaiTmp.WriteDscType(pValue:Str10);
begin
  oTmpTable.FieldByName('DscType').AsString := pValue;
end;

function TCaiTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCaiTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCaiTmp.ReadProdNum:Str30;
begin
  Result := oTmpTable.FieldByName('ProdNum').AsString;
end;

procedure TCaiTmp.WriteProdNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ProdNum').AsString := pValue;
end;

function TCaiTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TCaiTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

function TCaiTmp.ReadOrdPrn:byte;
begin
  Result := oTmpTable.FieldByName('OrdPrn').AsInteger;
end;

procedure TCaiTmp.WriteOrdPrn(pValue:byte);
begin
  oTmpTable.FieldByName('OrdPrn').AsInteger := pValue;
end;

function TCaiTmp.ReadPceSrc:Str3;
begin
  Result := oTmpTable.FieldByName('PceSrc').AsString;
end;

procedure TCaiTmp.WritePceSrc(pValue:Str3);
begin
  oTmpTable.FieldByName('PceSrc').AsString := pValue;
end;

function TCaiTmp.ReadDscSrc:Str3;
begin
  Result := oTmpTable.FieldByName('DscSrc').AsString;
end;

procedure TCaiTmp.WriteDscSrc(pValue:Str3);
begin
  oTmpTable.FieldByName('DscSrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCaiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCaiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCaiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

function TCaiTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCaiTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TCaiTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TCaiTmp.LocateAction (pAction:Str1):boolean;
begin
  SetIndex (ixAction);
  Result := oTmpTable.FindKey([pAction]);
end;

procedure TCaiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCaiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCaiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCaiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCaiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCaiTmp.First;
begin
  oTmpTable.First;
end;

procedure TCaiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCaiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCaiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCaiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCaiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCaiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCaiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCaiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCaiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCaiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCaiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
