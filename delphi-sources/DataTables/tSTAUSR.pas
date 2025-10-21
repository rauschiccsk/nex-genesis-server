unit tSTAUSR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixLogName = '';
  ixUsrName_ = 'UsrName_';

type
  TStausrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadUsrName_:Str30;        procedure WriteUsrName_ (pValue:Str30);
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
    function LocateLogName (pLogName:Str8):boolean;
    function LocateUsrName_ (pUsrName_:Str30):boolean;

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
    property LogName:Str8 read ReadLogName write WriteLogName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property UsrName_:Str30 read ReadUsrName_ write WriteUsrName_;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStausrTmp.Create;
begin
  oTmpTable := TmpInit ('STAUSR',Self);
end;

destructor TStausrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStausrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStausrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStausrTmp.ReadLogName:Str8;
begin
  Result := oTmpTable.FieldByName('LogName').AsString;
end;

procedure TStausrTmp.WriteLogName(pValue:Str8);
begin
  oTmpTable.FieldByName('LogName').AsString := pValue;
end;

function TStausrTmp.ReadUsrName:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName').AsString;
end;

procedure TStausrTmp.WriteUsrName(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName').AsString := pValue;
end;

function TStausrTmp.ReadUsrName_:Str30;
begin
  Result := oTmpTable.FieldByName('UsrName_').AsString;
end;

procedure TStausrTmp.WriteUsrName_(pValue:Str30);
begin
  oTmpTable.FieldByName('UsrName_').AsString := pValue;
end;

function TStausrTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStausrTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStausrTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStausrTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStausrTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStausrTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStausrTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStausrTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStausrTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStausrTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStausrTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStausrTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStausrTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStausrTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStausrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStausrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStausrTmp.LocateLogName (pLogName:Str8):boolean;
begin
  SetIndex (ixLogName);
  Result := oTmpTable.FindKey([pLogName]);
end;

function TStausrTmp.LocateUsrName_ (pUsrName_:Str30):boolean;
begin
  SetIndex (ixUsrName_);
  Result := oTmpTable.FindKey([pUsrName_]);
end;

procedure TStausrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStausrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStausrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStausrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStausrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStausrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStausrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStausrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStausrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStausrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStausrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStausrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStausrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStausrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStausrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStausrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStausrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
