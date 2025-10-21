unit tSTADLR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDlrCode = '';
  ixDlrName_ = 'DlrName_';

type
  TStadlrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadDlrName:Str30;         procedure WriteDlrName (pValue:Str30);
    function  ReadDlrName_:Str30;        procedure WriteDlrName_ (pValue:Str30);
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
    function LocateDlrCode (pDlrCode:word):boolean;
    function LocateDlrName_ (pDlrName_:Str30):boolean;

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
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property DlrName:Str30 read ReadDlrName write WriteDlrName;
    property DlrName_:Str30 read ReadDlrName_ write WriteDlrName_;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStadlrTmp.Create;
begin
  oTmpTable := TmpInit ('STADLR',Self);
end;

destructor TStadlrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStadlrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStadlrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStadlrTmp.ReadDlrCode:word;
begin
  Result := oTmpTable.FieldByName('DlrCode').AsInteger;
end;

procedure TStadlrTmp.WriteDlrCode(pValue:word);
begin
  oTmpTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TStadlrTmp.ReadDlrName:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName').AsString;
end;

procedure TStadlrTmp.WriteDlrName(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName').AsString := pValue;
end;

function TStadlrTmp.ReadDlrName_:Str30;
begin
  Result := oTmpTable.FieldByName('DlrName_').AsString;
end;

procedure TStadlrTmp.WriteDlrName_(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrName_').AsString := pValue;
end;

function TStadlrTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStadlrTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStadlrTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStadlrTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStadlrTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStadlrTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStadlrTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStadlrTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStadlrTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStadlrTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStadlrTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStadlrTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStadlrTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStadlrTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStadlrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStadlrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStadlrTmp.LocateDlrCode (pDlrCode:word):boolean;
begin
  SetIndex (ixDlrCode);
  Result := oTmpTable.FindKey([pDlrCode]);
end;

function TStadlrTmp.LocateDlrName_ (pDlrName_:Str30):boolean;
begin
  SetIndex (ixDlrName_);
  Result := oTmpTable.FindKey([pDlrName_]);
end;

procedure TStadlrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStadlrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStadlrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStadlrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStadlrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStadlrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStadlrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStadlrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStadlrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStadlrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStadlrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStadlrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStadlrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStadlrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStadlrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStadlrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStadlrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
