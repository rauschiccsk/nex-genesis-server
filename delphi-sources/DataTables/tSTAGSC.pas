unit tSTAGSC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGaName_ = 'GaName_';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';

type
  TStagscTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadGaName_:Str60;         procedure WriteGaName_ (pValue:Str60);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadNValue:double;         procedure WriteNValue (pValue:double);
    function  ReadXValue:double;         procedure WriteXValue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGaName_ (pGaName_:Str60):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
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
    property GaName:Str60 read ReadGaName write WriteGaName;
    property GaName_:Str60 read ReadGaName_ write WriteGaName_;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStagscTmp.Create;
begin
  oTmpTable := TmpInit ('STAGSC',Self);
end;

destructor TStagscTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStagscTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStagscTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStagscTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStagscTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStagscTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TStagscTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TStagscTmp.ReadGaName_:Str60;
begin
  Result := oTmpTable.FieldByName('GaName_').AsString;
end;

procedure TStagscTmp.WriteGaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName_').AsString := pValue;
end;

function TStagscTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStagscTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStagscTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TStagscTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TStagscTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStagscTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TStagscTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TStagscTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TStagscTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TStagscTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TStagscTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TStagscTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TStagscTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStagscTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TStagscTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TStagscTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TStagscTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStagscTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStagscTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStagscTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStagscTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStagscTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStagscTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStagscTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStagscTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStagscTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStagscTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStagscTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStagscTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStagscTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStagscTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStagscTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStagscTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStagscTmp.LocateGaName_ (pGaName_:Str60):boolean;
begin
  SetIndex (ixGaName_);
  Result := oTmpTable.FindKey([pGaName_]);
end;

function TStagscTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TStagscTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TStagscTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStagscTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStagscTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStagscTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStagscTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStagscTmp.First;
begin
  oTmpTable.First;
end;

procedure TStagscTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStagscTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStagscTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStagscTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStagscTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStagscTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStagscTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStagscTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStagscTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStagscTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStagscTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
