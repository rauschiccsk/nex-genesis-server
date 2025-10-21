unit tRBAITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixGsCode = 'GsCode';

type
  TRbaitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCod:Str15;          procedure WriteBarCod (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadRbaCod:Str30;          procedure WriteRbaCod (pValue:Str30);
    function  ReadRbaDat:TDatetime;      procedure WriteRbaDat (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCod:Str15 read ReadBarCod write WriteBarCod;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property RbaCod:Str30 read ReadRbaCod write WriteRbaCod;
    property RbaDat:TDatetime read ReadRbaDat write WriteRbaDat;
  end;

implementation

constructor TRbaitmTmp.Create;
begin
  oTmpTable := TmpInit ('RBAITM',Self);
end;

destructor TRbaitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRbaitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRbaitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRbaitmTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TRbaitmTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TRbaitmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TRbaitmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TRbaitmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TRbaitmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TRbaitmTmp.ReadBarCod:Str15;
begin
  Result := oTmpTable.FieldByName('BarCod').AsString;
end;

procedure TRbaitmTmp.WriteBarCod(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCod').AsString := pValue;
end;

function TRbaitmTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TRbaitmTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TRbaitmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TRbaitmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TRbaitmTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TRbaitmTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TRbaitmTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TRbaitmTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TRbaitmTmp.ReadRbaCod:Str30;
begin
  Result := oTmpTable.FieldByName('RbaCod').AsString;
end;

procedure TRbaitmTmp.WriteRbaCod(pValue:Str30);
begin
  oTmpTable.FieldByName('RbaCod').AsString := pValue;
end;

function TRbaitmTmp.ReadRbaDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('RbaDat').AsDateTime;
end;

procedure TRbaitmTmp.WriteRbaDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RbaDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRbaitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRbaitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRbaitmTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TRbaitmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TRbaitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRbaitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRbaitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRbaitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRbaitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRbaitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TRbaitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRbaitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRbaitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRbaitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRbaitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRbaitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRbaitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRbaitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRbaitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRbaitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRbaitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
