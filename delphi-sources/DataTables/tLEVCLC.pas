unit tLEVCLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixSpcCode = 'SpcCode';

type
  TLevclcTmp = class (TComponent)
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
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadAcPrfPrc0:double;      procedure WriteAcPrfPrc0 (pValue:double);
    function  ReadAcAPrice0:double;      procedure WriteAcAPrice0 (pValue:double);
    function  ReadAcBPrice0:double;      procedure WriteAcBPrice0 (pValue:double);
    function  ReadNwPrfPrc0:double;      procedure WriteNwPrfPrc0 (pValue:double);
    function  ReadNwAPrice0:double;      procedure WriteNwAPrice0 (pValue:double);
    function  ReadNwBPrice0:double;      procedure WriteNwBPrice0 (pValue:double);
    function  ReadAcPrfPrc1:double;      procedure WriteAcPrfPrc1 (pValue:double);
    function  ReadAcAPrice1:double;      procedure WriteAcAPrice1 (pValue:double);
    function  ReadAcBPrice1:double;      procedure WriteAcBPrice1 (pValue:double);
    function  ReadNwPrfPrc1:double;      procedure WriteNwPrfPrc1 (pValue:double);
    function  ReadNwAPrice1:double;      procedure WriteNwAPrice1 (pValue:double);
    function  ReadNwBPrice1:double;      procedure WriteNwBPrice1 (pValue:double);
    function  ReadAcPrfPrc2:double;      procedure WriteAcPrfPrc2 (pValue:double);
    function  ReadAcAPrice2:double;      procedure WriteAcAPrice2 (pValue:double);
    function  ReadAcBPrice2:double;      procedure WriteAcBPrice2 (pValue:double);
    function  ReadNwPrfPrc2:double;      procedure WriteNwPrfPrc2 (pValue:double);
    function  ReadNwAPrice2:double;      procedure WriteNwAPrice2 (pValue:double);
    function  ReadNwBPrice2:double;      procedure WriteNwBPrice2 (pValue:double);
    function  ReadAcPrfPrc3:double;      procedure WriteAcPrfPrc3 (pValue:double);
    function  ReadAcAPrice3:double;      procedure WriteAcAPrice3 (pValue:double);
    function  ReadAcBPrice3:double;      procedure WriteAcBPrice3 (pValue:double);
    function  ReadNwPrfPrc3:double;      procedure WriteNwPrfPrc3 (pValue:double);
    function  ReadNwAPrice3:double;      procedure WriteNwAPrice3 (pValue:double);
    function  ReadNwBPrice3:double;      procedure WriteNwBPrice3 (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateSpcCode (pSpcCode:Str30):boolean;

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
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property AcPrfPrc0:double read ReadAcPrfPrc0 write WriteAcPrfPrc0;
    property AcAPrice0:double read ReadAcAPrice0 write WriteAcAPrice0;
    property AcBPrice0:double read ReadAcBPrice0 write WriteAcBPrice0;
    property NwPrfPrc0:double read ReadNwPrfPrc0 write WriteNwPrfPrc0;
    property NwAPrice0:double read ReadNwAPrice0 write WriteNwAPrice0;
    property NwBPrice0:double read ReadNwBPrice0 write WriteNwBPrice0;
    property AcPrfPrc1:double read ReadAcPrfPrc1 write WriteAcPrfPrc1;
    property AcAPrice1:double read ReadAcAPrice1 write WriteAcAPrice1;
    property AcBPrice1:double read ReadAcBPrice1 write WriteAcBPrice1;
    property NwPrfPrc1:double read ReadNwPrfPrc1 write WriteNwPrfPrc1;
    property NwAPrice1:double read ReadNwAPrice1 write WriteNwAPrice1;
    property NwBPrice1:double read ReadNwBPrice1 write WriteNwBPrice1;
    property AcPrfPrc2:double read ReadAcPrfPrc2 write WriteAcPrfPrc2;
    property AcAPrice2:double read ReadAcAPrice2 write WriteAcAPrice2;
    property AcBPrice2:double read ReadAcBPrice2 write WriteAcBPrice2;
    property NwPrfPrc2:double read ReadNwPrfPrc2 write WriteNwPrfPrc2;
    property NwAPrice2:double read ReadNwAPrice2 write WriteNwAPrice2;
    property NwBPrice2:double read ReadNwBPrice2 write WriteNwBPrice2;
    property AcPrfPrc3:double read ReadAcPrfPrc3 write WriteAcPrfPrc3;
    property AcAPrice3:double read ReadAcAPrice3 write WriteAcAPrice3;
    property AcBPrice3:double read ReadAcBPrice3 write WriteAcBPrice3;
    property NwPrfPrc3:double read ReadNwPrfPrc3 write WriteNwPrfPrc3;
    property NwAPrice3:double read ReadNwAPrice3 write WriteNwAPrice3;
    property NwBPrice3:double read ReadNwBPrice3 write WriteNwBPrice3;
  end;

implementation

constructor TLevclcTmp.Create;
begin
  oTmpTable := TmpInit ('LEVCLC',Self);
end;

destructor TLevclcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TLevclcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TLevclcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TLevclcTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TLevclcTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TLevclcTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TLevclcTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TLevclcTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TLevclcTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TLevclcTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TLevclcTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TLevclcTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TLevclcTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TLevclcTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TLevclcTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TLevclcTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TLevclcTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TLevclcTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TLevclcTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TLevclcTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TLevclcTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TLevclcTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TLevclcTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcPrfPrc0:double;
begin
  Result := oTmpTable.FieldByName('AcPrfPrc0').AsFloat;
end;

procedure TLevclcTmp.WriteAcPrfPrc0(pValue:double);
begin
  oTmpTable.FieldByName('AcPrfPrc0').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcAPrice0:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice0').AsFloat;
end;

procedure TLevclcTmp.WriteAcAPrice0(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice0').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcBPrice0:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice0').AsFloat;
end;

procedure TLevclcTmp.WriteAcBPrice0(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice0').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwPrfPrc0:double;
begin
  Result := oTmpTable.FieldByName('NwPrfPrc0').AsFloat;
end;

procedure TLevclcTmp.WriteNwPrfPrc0(pValue:double);
begin
  oTmpTable.FieldByName('NwPrfPrc0').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwAPrice0:double;
begin
  Result := oTmpTable.FieldByName('NwAPrice0').AsFloat;
end;

procedure TLevclcTmp.WriteNwAPrice0(pValue:double);
begin
  oTmpTable.FieldByName('NwAPrice0').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwBPrice0:double;
begin
  Result := oTmpTable.FieldByName('NwBPrice0').AsFloat;
end;

procedure TLevclcTmp.WriteNwBPrice0(pValue:double);
begin
  oTmpTable.FieldByName('NwBPrice0').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcPrfPrc1:double;
begin
  Result := oTmpTable.FieldByName('AcPrfPrc1').AsFloat;
end;

procedure TLevclcTmp.WriteAcPrfPrc1(pValue:double);
begin
  oTmpTable.FieldByName('AcPrfPrc1').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcAPrice1:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice1').AsFloat;
end;

procedure TLevclcTmp.WriteAcAPrice1(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice1').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcBPrice1:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice1').AsFloat;
end;

procedure TLevclcTmp.WriteAcBPrice1(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice1').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwPrfPrc1:double;
begin
  Result := oTmpTable.FieldByName('NwPrfPrc1').AsFloat;
end;

procedure TLevclcTmp.WriteNwPrfPrc1(pValue:double);
begin
  oTmpTable.FieldByName('NwPrfPrc1').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwAPrice1:double;
begin
  Result := oTmpTable.FieldByName('NwAPrice1').AsFloat;
end;

procedure TLevclcTmp.WriteNwAPrice1(pValue:double);
begin
  oTmpTable.FieldByName('NwAPrice1').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwBPrice1:double;
begin
  Result := oTmpTable.FieldByName('NwBPrice1').AsFloat;
end;

procedure TLevclcTmp.WriteNwBPrice1(pValue:double);
begin
  oTmpTable.FieldByName('NwBPrice1').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcPrfPrc2:double;
begin
  Result := oTmpTable.FieldByName('AcPrfPrc2').AsFloat;
end;

procedure TLevclcTmp.WriteAcPrfPrc2(pValue:double);
begin
  oTmpTable.FieldByName('AcPrfPrc2').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcAPrice2:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice2').AsFloat;
end;

procedure TLevclcTmp.WriteAcAPrice2(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice2').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcBPrice2:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice2').AsFloat;
end;

procedure TLevclcTmp.WriteAcBPrice2(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice2').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwPrfPrc2:double;
begin
  Result := oTmpTable.FieldByName('NwPrfPrc2').AsFloat;
end;

procedure TLevclcTmp.WriteNwPrfPrc2(pValue:double);
begin
  oTmpTable.FieldByName('NwPrfPrc2').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwAPrice2:double;
begin
  Result := oTmpTable.FieldByName('NwAPrice2').AsFloat;
end;

procedure TLevclcTmp.WriteNwAPrice2(pValue:double);
begin
  oTmpTable.FieldByName('NwAPrice2').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwBPrice2:double;
begin
  Result := oTmpTable.FieldByName('NwBPrice2').AsFloat;
end;

procedure TLevclcTmp.WriteNwBPrice2(pValue:double);
begin
  oTmpTable.FieldByName('NwBPrice2').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcPrfPrc3:double;
begin
  Result := oTmpTable.FieldByName('AcPrfPrc3').AsFloat;
end;

procedure TLevclcTmp.WriteAcPrfPrc3(pValue:double);
begin
  oTmpTable.FieldByName('AcPrfPrc3').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcAPrice3:double;
begin
  Result := oTmpTable.FieldByName('AcAPrice3').AsFloat;
end;

procedure TLevclcTmp.WriteAcAPrice3(pValue:double);
begin
  oTmpTable.FieldByName('AcAPrice3').AsFloat := pValue;
end;

function TLevclcTmp.ReadAcBPrice3:double;
begin
  Result := oTmpTable.FieldByName('AcBPrice3').AsFloat;
end;

procedure TLevclcTmp.WriteAcBPrice3(pValue:double);
begin
  oTmpTable.FieldByName('AcBPrice3').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwPrfPrc3:double;
begin
  Result := oTmpTable.FieldByName('NwPrfPrc3').AsFloat;
end;

procedure TLevclcTmp.WriteNwPrfPrc3(pValue:double);
begin
  oTmpTable.FieldByName('NwPrfPrc3').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwAPrice3:double;
begin
  Result := oTmpTable.FieldByName('NwAPrice3').AsFloat;
end;

procedure TLevclcTmp.WriteNwAPrice3(pValue:double);
begin
  oTmpTable.FieldByName('NwAPrice3').AsFloat := pValue;
end;

function TLevclcTmp.ReadNwBPrice3:double;
begin
  Result := oTmpTable.FieldByName('NwBPrice3').AsFloat;
end;

procedure TLevclcTmp.WriteNwBPrice3(pValue:double);
begin
  oTmpTable.FieldByName('NwBPrice3').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLevclcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TLevclcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TLevclcTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TLevclcTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TLevclcTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TLevclcTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TLevclcTmp.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oTmpTable.FindKey([pSpcCode]);
end;

procedure TLevclcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TLevclcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TLevclcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TLevclcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TLevclcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TLevclcTmp.First;
begin
  oTmpTable.First;
end;

procedure TLevclcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TLevclcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TLevclcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TLevclcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TLevclcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TLevclcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TLevclcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TLevclcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TLevclcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TLevclcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TLevclcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
