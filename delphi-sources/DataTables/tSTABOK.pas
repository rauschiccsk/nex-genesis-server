unit tSTABOK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBokNum = '';

type
  TStabokTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:Str5;           procedure WriteBokNum (pValue:Str5);
    function  ReadBokName:Str30;         procedure WriteBokName (pValue:Str30);
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
    function LocateBokNum (pBokNum:Str5):boolean;

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
    property BokNum:Str5 read ReadBokNum write WriteBokNum;
    property BokName:Str30 read ReadBokName write WriteBokName;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStabokTmp.Create;
begin
  oTmpTable := TmpInit ('STABOK',Self);
end;

destructor TStabokTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStabokTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStabokTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStabokTmp.ReadBokNum:Str5;
begin
  Result := oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TStabokTmp.WriteBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString := pValue;
end;

function TStabokTmp.ReadBokName:Str30;
begin
  Result := oTmpTable.FieldByName('BokName').AsString;
end;

procedure TStabokTmp.WriteBokName(pValue:Str30);
begin
  oTmpTable.FieldByName('BokName').AsString := pValue;
end;

function TStabokTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStabokTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStabokTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStabokTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStabokTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStabokTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStabokTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStabokTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStabokTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStabokTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStabokTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStabokTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStabokTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStabokTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStabokTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStabokTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStabokTmp.LocateBokNum (pBokNum:Str5):boolean;
begin
  SetIndex (ixBokNum);
  Result := oTmpTable.FindKey([pBokNum]);
end;

procedure TStabokTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStabokTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStabokTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStabokTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStabokTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStabokTmp.First;
begin
  oTmpTable.First;
end;

procedure TStabokTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStabokTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStabokTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStabokTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStabokTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStabokTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStabokTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStabokTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStabokTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStabokTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStabokTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
