unit tSTAMGC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMgCode = '';
  ixMgName_ = 'MgName_';

type
  TStamgcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadMgName_:Str30;         procedure WriteMgName_ (pValue:Str30);
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
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateMgName_ (pMgName_:Str30):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property MgName_:Str30 read ReadMgName_ write WriteMgName_;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TStamgcTmp.Create;
begin
  oTmpTable := TmpInit ('STAMGC',Self);
end;

destructor TStamgcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStamgcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStamgcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStamgcTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TStamgcTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TStamgcTmp.ReadMgName:Str30;
begin
  Result := oTmpTable.FieldByName('MgName').AsString;
end;

procedure TStamgcTmp.WriteMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString := pValue;
end;

function TStamgcTmp.ReadMgName_:Str30;
begin
  Result := oTmpTable.FieldByName('MgName_').AsString;
end;

procedure TStamgcTmp.WriteMgName_(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName_').AsString := pValue;
end;

function TStamgcTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TStamgcTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TStamgcTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TStamgcTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TStamgcTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TStamgcTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TStamgcTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TStamgcTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TStamgcTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TStamgcTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TStamgcTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TStamgcTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TStamgcTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TStamgcTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStamgcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStamgcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStamgcTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TStamgcTmp.LocateMgName_ (pMgName_:Str30):boolean;
begin
  SetIndex (ixMgName_);
  Result := oTmpTable.FindKey([pMgName_]);
end;

procedure TStamgcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStamgcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStamgcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStamgcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStamgcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStamgcTmp.First;
begin
  oTmpTable.First;
end;

procedure TStamgcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStamgcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStamgcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStamgcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStamgcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStamgcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStamgcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStamgcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStamgcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStamgcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStamgcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
