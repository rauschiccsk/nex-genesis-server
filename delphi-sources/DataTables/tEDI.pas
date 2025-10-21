unit tEDI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';

type
  TEdiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadFgDValue:double;       procedure WriteFgDValue (pValue:double);
    function  ReadFgDscVal:double;       procedure WriteFgDscVal (pValue:double);
    function  ReadFgAValue:double;       procedure WriteFgAValue (pValue:double);
    function  ReadFgBValue:double;       procedure WriteFgBValue (pValue:double);
    function  ReadEuBPrice:double;       procedure WriteEuBPrice (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GaName:Str60 read ReadGaName write WriteGaName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property FgDValue:double read ReadFgDValue write WriteFgDValue;
    property FgDscVal:double read ReadFgDscVal write WriteFgDscVal;
    property FgAValue:double read ReadFgAValue write WriteFgAValue;
    property FgBValue:double read ReadFgBValue write WriteFgBValue;
    property EuBPrice:double read ReadEuBPrice write WriteEuBPrice;
  end;

implementation

constructor TEdiTmp.Create;
begin
  oTmpTable := TmpInit ('EDI',Self);
end;

destructor TEdiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEdiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TEdiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TEdiTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TEdiTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TEdiTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TEdiTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TEdiTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TEdiTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TEdiTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TEdiTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TEdiTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TEdiTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TEdiTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TEdiTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TEdiTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TEdiTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TEdiTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TEdiTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TEdiTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TEdiTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TEdiTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TEdiTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TEdiTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TEdiTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TEdiTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TEdiTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TEdiTmp.ReadFgDValue:double;
begin
  Result := oTmpTable.FieldByName('FgDValue').AsFloat;
end;

procedure TEdiTmp.WriteFgDValue(pValue:double);
begin
  oTmpTable.FieldByName('FgDValue').AsFloat := pValue;
end;

function TEdiTmp.ReadFgDscVal:double;
begin
  Result := oTmpTable.FieldByName('FgDscVal').AsFloat;
end;

procedure TEdiTmp.WriteFgDscVal(pValue:double);
begin
  oTmpTable.FieldByName('FgDscVal').AsFloat := pValue;
end;

function TEdiTmp.ReadFgAValue:double;
begin
  Result := oTmpTable.FieldByName('FgAValue').AsFloat;
end;

procedure TEdiTmp.WriteFgAValue(pValue:double);
begin
  oTmpTable.FieldByName('FgAValue').AsFloat := pValue;
end;

function TEdiTmp.ReadFgBValue:double;
begin
  Result := oTmpTable.FieldByName('FgBValue').AsFloat;
end;

procedure TEdiTmp.WriteFgBValue(pValue:double);
begin
  oTmpTable.FieldByName('FgBValue').AsFloat := pValue;
end;

function TEdiTmp.ReadEuBPrice:double;
begin
  Result := oTmpTable.FieldByName('EuBPrice').AsFloat;
end;

procedure TEdiTmp.WriteEuBPrice(pValue:double);
begin
  oTmpTable.FieldByName('EuBPrice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TEdiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TEdiTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TEdiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TEdiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEdiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEdiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEdiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEdiTmp.First;
begin
  oTmpTable.First;
end;

procedure TEdiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEdiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEdiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEdiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEdiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEdiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEdiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEdiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEdiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEdiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TEdiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
