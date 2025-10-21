unit tSTADAY;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSalDate = '';

type
  TStadayTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
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
    function LocateSalDate (pSalDate:TDatetime):boolean;

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
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStadayTmp.Create;
begin
  oTmpTable := TmpInit ('STADAY',Self);
end;

destructor TStadayTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStadayTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStadayTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStadayTmp.ReadSalDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('SalDate').AsDateTime;
end;

procedure TStadayTmp.WriteSalDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TStadayTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStadayTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStadayTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStadayTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStadayTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStadayTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStadayTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStadayTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStadayTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStadayTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStadayTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStadayTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStadayTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStadayTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStadayTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStadayTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStadayTmp.LocateSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oTmpTable.FindKey([pSalDate]);
end;

procedure TStadayTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStadayTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStadayTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStadayTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStadayTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStadayTmp.First;
begin
  oTmpTable.First;
end;

procedure TStadayTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStadayTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStadayTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStadayTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStadayTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStadayTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStadayTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStadayTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStadayTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStadayTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStadayTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
