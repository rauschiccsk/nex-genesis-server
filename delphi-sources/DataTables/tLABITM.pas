unit tLABITM;

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

type
  TLabitmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadGaName:Str200;         procedure WriteGaName (pValue:Str200);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadGscKfc:word;           procedure WriteGscKfc (pValue:word);
    function  ReadLabQnt:word;           procedure WriteLabQnt (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property GaName:Str200 read ReadGaName write WriteGaName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property GscKfc:word read ReadGscKfc write WriteGscKfc;
    property LabQnt:word read ReadLabQnt write WriteLabQnt;
  end;

implementation

constructor TLabitmTmp.Create;
begin
  oTmpTable := TmpInit ('LABITM',Self);
end;

destructor TLabitmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TLabitmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TLabitmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TLabitmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TLabitmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TLabitmTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TLabitmTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TLabitmTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TLabitmTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TLabitmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TLabitmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TLabitmTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TLabitmTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TLabitmTmp.ReadGaName:Str200;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TLabitmTmp.WriteGaName(pValue:Str200);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TLabitmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TLabitmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TLabitmTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TLabitmTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TLabitmTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TLabitmTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TLabitmTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TLabitmTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TLabitmTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TLabitmTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TLabitmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TLabitmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TLabitmTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TLabitmTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TLabitmTmp.ReadGscKfc:word;
begin
  Result := oTmpTable.FieldByName('GscKfc').AsInteger;
end;

procedure TLabitmTmp.WriteGscKfc(pValue:word);
begin
  oTmpTable.FieldByName('GscKfc').AsInteger := pValue;
end;

function TLabitmTmp.ReadLabQnt:word;
begin
  Result := oTmpTable.FieldByName('LabQnt').AsInteger;
end;

procedure TLabitmTmp.WriteLabQnt(pValue:word);
begin
  oTmpTable.FieldByName('LabQnt').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLabitmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TLabitmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TLabitmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TLabitmTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TLabitmTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TLabitmTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

procedure TLabitmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TLabitmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TLabitmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TLabitmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TLabitmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TLabitmTmp.First;
begin
  oTmpTable.First;
end;

procedure TLabitmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TLabitmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TLabitmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TLabitmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TLabitmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TLabitmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TLabitmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TLabitmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TLabitmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TLabitmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TLabitmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
