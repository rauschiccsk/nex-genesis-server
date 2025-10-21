unit tCUSGSL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgCode = 'MgCode';
  ixFgCode = 'FgCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';

type
  TCusgslTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadFgName:Str30;          procedure WriteFgName (pValue:Str30);
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
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateFgCode (pFgCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property FgName:Str30 read ReadFgName write WriteFgName;
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
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
  end;

implementation

constructor TCusgslTmp.Create;
begin
  oTmpTable := TmpInit ('CUSGSL',Self);
end;

destructor TCusgslTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCusgslTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCusgslTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCusgslTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TCusgslTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TCusgslTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TCusgslTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TCusgslTmp.ReadMgName:Str30;
begin
  Result := oTmpTable.FieldByName('MgName').AsString;
end;

procedure TCusgslTmp.WriteMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString := pValue;
end;

function TCusgslTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TCusgslTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TCusgslTmp.ReadFgName:Str30;
begin
  Result := oTmpTable.FieldByName('FgName').AsString;
end;

procedure TCusgslTmp.WriteFgName(pValue:Str30);
begin
  oTmpTable.FieldByName('FgName').AsString := pValue;
end;

function TCusgslTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TCusgslTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TCusgslTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TCusgslTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TCusgslTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TCusgslTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TCusgslTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TCusgslTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TCusgslTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TCusgslTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TCusgslTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TCusgslTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TCusgslTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TCusgslTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCusgslTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCusgslTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCusgslTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TCusgslTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCusgslTmp.ReadProfit:double;
begin
  Result := oTmpTable.FieldByName('Profit').AsFloat;
end;

procedure TCusgslTmp.WriteProfit(pValue:double);
begin
  oTmpTable.FieldByName('Profit').AsFloat := pValue;
end;

function TCusgslTmp.ReadItmVal:double;
begin
  Result := oTmpTable.FieldByName('ItmVal').AsFloat;
end;

procedure TCusgslTmp.WriteItmVal(pValue:double);
begin
  oTmpTable.FieldByName('ItmVal').AsFloat := pValue;
end;

function TCusgslTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCusgslTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCusgslTmp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TCusgslTmp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

function TCusgslTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TCusgslTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCusgslTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TCusgslTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCusgslTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCusgslTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCusgslTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TCusgslTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TCusgslTmp.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oTmpTable.FindKey([pFgCode]);
end;

function TCusgslTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TCusgslTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TCusgslTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCusgslTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCusgslTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCusgslTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCusgslTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCusgslTmp.First;
begin
  oTmpTable.First;
end;

procedure TCusgslTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCusgslTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCusgslTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCusgslTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCusgslTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCusgslTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCusgslTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCusgslTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCusgslTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCusgslTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCusgslTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
