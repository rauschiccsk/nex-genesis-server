unit tOBGPAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName_ = 'PaName_';
  ixAcEValue = 'AcEValue';
  ixAcPayVal = 'AcPayVal';
  ixAcApyVal = 'AcApyVal';
  ixAcEndVal = 'AcEndVal';
  ixAcAenVal = 'AcAenVal';

type
  TObgpacTmp = class (TComponent)
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
    function  ReadAcEValue:double;       procedure WriteAcEValue (pValue:double);
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
    function LocateAcEValue (pAcEValue:double):boolean;
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
    property AcEValue:double read ReadAcEValue write WriteAcEValue;
    property AcPayVal:double read ReadAcPayVal write WriteAcPayVal;
    property AcApyVal:double read ReadAcApyVal write WriteAcApyVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property AcAenVal:double read ReadAcAenVal write WriteAcAenVal;
  end;

implementation

constructor TObgpacTmp.Create;
begin
  oTmpTable := TmpInit ('OBGPAC',Self);
end;

destructor TObgpacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TObgpacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TObgpacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TObgpacTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TObgpacTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TObgpacTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TObgpacTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TObgpacTmp.ReadPaName_:Str60;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TObgpacTmp.WritePaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TObgpacTmp.ReadAcEValue:double;
begin
  Result := oTmpTable.FieldByName('AcEValue').AsFloat;
end;

procedure TObgpacTmp.WriteAcEValue(pValue:double);
begin
  oTmpTable.FieldByName('AcEValue').AsFloat := pValue;
end;

function TObgpacTmp.ReadAcPayVal:double;
begin
  Result := oTmpTable.FieldByName('AcPayVal').AsFloat;
end;

procedure TObgpacTmp.WriteAcPayVal(pValue:double);
begin
  oTmpTable.FieldByName('AcPayVal').AsFloat := pValue;
end;

function TObgpacTmp.ReadAcApyVal:double;
begin
  Result := oTmpTable.FieldByName('AcApyVal').AsFloat;
end;

procedure TObgpacTmp.WriteAcApyVal(pValue:double);
begin
  oTmpTable.FieldByName('AcApyVal').AsFloat := pValue;
end;

function TObgpacTmp.ReadAcEndVal:double;
begin
  Result := oTmpTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TObgpacTmp.WriteAcEndVal(pValue:double);
begin
  oTmpTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TObgpacTmp.ReadAcAenVal:double;
begin
  Result := oTmpTable.FieldByName('AcAenVal').AsFloat;
end;

procedure TObgpacTmp.WriteAcAenVal(pValue:double);
begin
  oTmpTable.FieldByName('AcAenVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TObgpacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TObgpacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TObgpacTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TObgpacTmp.LocatePaName_ (pPaName_:Str60):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TObgpacTmp.LocateAcEValue (pAcEValue:double):boolean;
begin
  SetIndex (ixAcEValue);
  Result := oTmpTable.FindKey([pAcEValue]);
end;

function TObgpacTmp.LocateAcPayVal (pAcPayVal:double):boolean;
begin
  SetIndex (ixAcPayVal);
  Result := oTmpTable.FindKey([pAcPayVal]);
end;

function TObgpacTmp.LocateAcApyVal (pAcApyVal:double):boolean;
begin
  SetIndex (ixAcApyVal);
  Result := oTmpTable.FindKey([pAcApyVal]);
end;

function TObgpacTmp.LocateAcEndVal (pAcEndVal:double):boolean;
begin
  SetIndex (ixAcEndVal);
  Result := oTmpTable.FindKey([pAcEndVal]);
end;

function TObgpacTmp.LocateAcAenVal (pAcAenVal:double):boolean;
begin
  SetIndex (ixAcAenVal);
  Result := oTmpTable.FindKey([pAcAenVal]);
end;

procedure TObgpacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TObgpacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TObgpacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TObgpacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TObgpacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TObgpacTmp.First;
begin
  oTmpTable.First;
end;

procedure TObgpacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TObgpacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TObgpacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TObgpacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TObgpacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TObgpacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TObgpacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TObgpacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TObgpacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TObgpacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TObgpacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
