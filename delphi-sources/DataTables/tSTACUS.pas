unit tSTACUS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName_ = 'PaName_';

type
  TStacusTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadPaName_:Str60;         procedure WritePaName_ (pValue:Str60);
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
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str60):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str60 read ReadPaName write WritePaName;
    property PaName_:Str60 read ReadPaName_ write WritePaName_;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStacusTmp.Create;
begin
  oTmpTable := TmpInit ('STACUS',Self);
end;

destructor TStacusTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStacusTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStacusTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStacusTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStacusTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TStacusTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TStacusTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TStacusTmp.ReadPaName_:Str60;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TStacusTmp.WritePaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TStacusTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStacusTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStacusTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStacusTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStacusTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStacusTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStacusTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStacusTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStacusTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStacusTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStacusTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStacusTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStacusTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStacusTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStacusTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStacusTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStacusTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TStacusTmp.LocatePaName_ (pPaName_:Str60):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

procedure TStacusTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStacusTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStacusTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStacusTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStacusTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStacusTmp.First;
begin
  oTmpTable.First;
end;

procedure TStacusTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStacusTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStacusTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStacusTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStacusTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStacusTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStacusTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStacusTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStacusTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStacusTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStacusTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
