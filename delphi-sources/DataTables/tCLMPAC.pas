unit tCLMPAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName_ = 'PaName_';
  ixAcBValue = 'AcBValue';
  ixAcPayVal = 'AcPayVal';
  ixAcApyVal = 'AcApyVal';
  ixAcEndVal = 'AcEndVal';
  ixAcAenVal = 'AcAenVal';

type
  TClmpacTmp = class (TComponent)
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
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadAcPayVal:double;       procedure WriteAcPayVal (pValue:double);
    function  ReadAcApyVal:double;       procedure WriteAcApyVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadAcAenVal:double;       procedure WriteAcAenVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str60):boolean;
    function LocateAcBValue (pAcBValue:double):boolean;
    function LocateAcPayVal (pAcPayVal:double):boolean;
    function LocateAcApyVal (pAcApyVal:double):boolean;
    function LocateAcEndVal (pAcEndVal:double):boolean;
    function LocateAcAenVal (pAcAenVal:double):boolean;

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
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcApyVal:double read ReadAcApyVal write WriteAcApyVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAenVal:double read ReadAcAenVal write WriteAcAenVal;
  end;

implementation

constructor TClmpacTmp.Create;
begin
  oTmpTable := TmpInit ('CLMPAC',Self);
end;

destructor TClmpacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TClmpacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TClmpacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TClmpacTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TClmpacTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TClmpacTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TClmpacTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TClmpacTmp.ReadPaName_:Str60;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TClmpacTmp.WritePaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TClmpacTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TClmpacTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TClmpacTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TClmpacTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TClmpacTmp.ReadAcApyVal:double;
begin
  Result := oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TClmpacTmp.WriteAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat := pValue;
end;

function TClmpacTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TClmpacTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TClmpacTmp.ReadAcAenVal:double;
begin
  Result := oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TClmpacTmp.WriteAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TClmpacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TClmpacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TClmpacTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TClmpacTmp.LocatePaName_ (pPaName_:Str60):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TClmpacTmp.LocateAcBValue (pAcBValue:double):boolean;
begin
  SetIndex (ixAcBValue);
  Result := oTmpTable.FindKey([pAcBValue]);
end;

function TClmpacTmp.LocateAcPayVal (pAcPayVal:double):boolean;
begin
  SetIndex (ixAcPayVal);
  Result := oTmpTable.FindKey([pAcPayVal]);
end;

function TClmpacTmp.LocateAcApyVal (pAcApyVal:double):boolean;
begin
  SetIndex (ixAcApyVal);
  Result := oTmpTable.FindKey([pAcApyVal]);
end;

function TClmpacTmp.LocateAcEndVal (pAcEndVal:double):boolean;
begin
  SetIndex (ixAcEndVal);
  Result := oTmpTable.FindKey([pAcEndVal]);
end;

function TClmpacTmp.LocateAcAenVal (pAcAenVal:double):boolean;
begin
  SetIndex (ixAcAenVal);
  Result := oTmpTable.FindKey([pAcAenVal]);
end;

procedure TClmpacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TClmpacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TClmpacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TClmpacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TClmpacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TClmpacTmp.First;
begin
  oTmpTable.First;
end;

procedure TClmpacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TClmpacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TClmpacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TClmpacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TClmpacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TClmpacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TClmpacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TClmpacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TClmpacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TClmpacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TClmpacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
