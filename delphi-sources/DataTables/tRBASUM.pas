unit tRBASUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRcGc = '';

type
  TRbasumTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRbaCod:Str30;          procedure WriteRbaCod (pValue:Str30);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCod:Str15;          procedure WriteBarCod (pValue:Str15);
    function  ReadStkCod:Str15;          procedure WriteStkCod (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadRbaDat:TDatetime;      procedure WriteRbaDat (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRcGc (pRbaCod:Str30;pGsCode:longint):boolean;

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
    property RbaCod:Str30 read ReadRbaCod write WriteRbaCod;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCod:Str15 read ReadBarCod write WriteBarCod;
    property StkCod:Str15 read ReadStkCod write WriteStkCod;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property RbaDat:TDatetime read ReadRbaDat write WriteRbaDat;
  end;

implementation

constructor TRbasumTmp.Create;
begin
  oTmpTable := TmpInit ('RBASUM',Self);
end;

destructor TRbasumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRbasumTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRbasumTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRbasumTmp.ReadRbaCod:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCod').AsString;
end;

procedure TRbasumTmp.WriteRbaCod(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCod').AsString := pValue;
end;

function TRbasumTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TRbasumTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRbasumTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TRbasumTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TRbasumTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TRbasumTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TRbasumTmp.ReadBarCod:Str15;
begin
  Result := oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TRbasumTmp.WriteBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString := pValue;
end;

function TRbasumTmp.ReadStkCod:Str15;
begin
  Result := oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TRbasumTmp.WriteStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString := pValue;
end;

function TRbasumTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TRbasumTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TRbasumTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TRbasumTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TRbasumTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TRbasumTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TRbasumTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TRbasumTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TRbasumTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TRbasumTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRbasumTmp.ReadRbaDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDat').AsDateTime;
end;

procedure TRbasumTmp.WriteRbaDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRbasumTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRbasumTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRbasumTmp.LocateRcGc (pRbaCod:Str30;pGsCode:longint):boolean;
begin
  SetIndex (ixRcGc);
  Result := oTmpTable.FindKey([pRbaCod,pGsCode]);
end;

procedure TRbasumTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRbasumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRbasumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRbasumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRbasumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRbasumTmp.First;
begin
  oTmpTable.First;
end;

procedure TRbasumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRbasumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRbasumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRbasumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRbasumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRbasumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRbasumTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRbasumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRbasumTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRbasumTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRbasumTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
