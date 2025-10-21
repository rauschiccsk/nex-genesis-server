unit pSALGSP;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixSumQnt = 'SumQnt';
  ixAValue = 'AValue';
  ixBValue = 'BValue';
  ixDscVal = 'DscVal';

type
  TSalgsp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    // Pristup k databazovym poliam
    function ReadPaCode:longint;    procedure WritePaCode (pValue:longint);
    function ReadPaName:Str30;      procedure WritePaName (pValue:Str30);
    function ReadCadQnt:double;     procedure WriteCadQnt (pValue:double);
    function ReadBsdQnt:double;     procedure WriteBsdQnt (pValue:double);
    function ReadSumQnt:double;     
    function ReadAValue:double;     procedure WriteAValue (pValue:double);
    function ReadBValue:double;     procedure WriteBValue (pValue:double);
    function ReadDscVal:double;     procedure WriteDscVal (pValue:double);
  public
    function Eof: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSumQnt (pSumQnt:double):boolean;
    function LocateAValue (pAValue:double):boolean;
    function LocateBValue (pBValue:double):boolean;
    function LocateDscVal (pDscVal:double):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure EnableControls;
    procedure DisableControls;
  published
    property TmpTable:TNexpxTable read oTmpTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property CadQnt:double read ReadCadQnt write WriteCadQnt;
    property BsdQnt:double read ReadBsdQnt write WriteBsdQnt;
    property SumQnt:double read ReadSumQnt;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property DscVal:double read ReadDscVal write WriteDscVal;
  end;

implementation

constructor TSalgsp.Create;
begin
  oTmpTable := TmpInit ('SALGSP',Self);
end;

destructor  TSalgsp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSalgsp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSalgsp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSalgsp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSalgsp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSalgsp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSalgsp.ReadCadQnt:double;
begin
  Result := oTmpTable.FieldByName('CadQnt').AsFloat;
end;

procedure TSalgsp.WriteCadQnt(pValue:double);
begin
  oTmpTable.FieldByName('CadQnt').AsFloat := pValue;
end;

function TSalgsp.ReadBsdQnt:double;
begin
  Result := oTmpTable.FieldByName('BsdQnt').AsFloat;
end;

procedure TSalgsp.WriteBsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('BsdQnt').AsFloat := pValue;
end;

function TSalgsp.ReadSumQnt:double;
begin
  Result := oTmpTable.FieldByName('SumQnt').AsFloat;
end;

function TSalgsp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSalgsp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSalgsp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSalgsp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSalgsp.ReadDscVal:double;
begin
  Result := oTmpTable.FieldByName('DscVal').AsFloat;
end;

procedure TSalgsp.WriteDscVal(pValue:double);
begin
  oTmpTable.FieldByName('DscVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSalgsp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSalgsp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TSalgsp.LocateSumQnt (pSumQnt:double):boolean;
begin
  SetIndex (ixSumQnt);
  Result := oTmpTable.FindKey([pSumQnt]);
end;

function TSalgsp.LocateAValue (pAValue:double):boolean;
begin
  SetIndex (ixAValue);
  Result := oTmpTable.FindKey([pAValue]);
end;

function TSalgsp.LocateBValue (pBValue:double):boolean;
begin
  SetIndex (ixBValue);
  Result := oTmpTable.FindKey([pBValue]);
end;

function TSalgsp.LocateDscVal (pDscVal:double):boolean;
begin
  SetIndex (ixDscVal);
  Result := oTmpTable.FindKey([pDscVal]);
end;

procedure TSalgsp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSalgsp.Open;
begin
  oTmpTable.Open;
end;

procedure TSalgsp.Close;
begin
  oTmpTable.Close;
end;

procedure TSalgsp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSalgsp.Next;
begin
  oTmpTable.Next;
end;

procedure TSalgsp.First;
begin
  oTmpTable.First;
end;

procedure TSalgsp.Last;
begin
  oTmpTable.Last;
end;

procedure TSalgsp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSalgsp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSalgsp.Post;
begin
  oTmpTable.FieldByName('SumQnt').AsFloat := oTmpTable.FieldByName('CadQnt').AsFloat+oTmpTable.FieldByName('BsdQnt').AsFloat;
  oTmpTable.Post;
end;

procedure TSalgsp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSalgsp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSalgsp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSalgsp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSalgsp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
