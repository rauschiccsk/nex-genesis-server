unit tSTCVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TStcverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str60;          procedure WriteGsName (pValue:Str60);
    function  ReadGsName_:Str60;         procedure WriteGsName_ (pValue:Str60);
    function  ReadDocQnt:double;         procedure WriteDocQnt (pValue:double);
    function  ReadStmQnt:double;         procedure WriteStmQnt (pValue:double);
    function  ReadFifQnt:double;         procedure WriteFifQnt (pValue:double);
    function  ReadStcQnt:double;         procedure WriteStcQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadStmVal:double;         procedure WriteStmVal (pValue:double);
    function  ReadFifVal:double;         procedure WriteFifVal (pValue:double);
    function  ReadStcVal:double;         procedure WriteStcVal (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str60):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str60 read ReadGsName write WriteGsName;
    property GsName_:Str60 read ReadGsName_ write WriteGsName_;
    property DocQnt:double read ReadDocQnt write WriteDocQnt;
    property StmQnt:double read ReadStmQnt write WriteStmQnt;
    property FifQnt:double read ReadFifQnt write WriteFifQnt;
    property StcQnt:double read ReadStcQnt write WriteStcQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property StmVal:double read ReadStmVal write WriteStmVal;
    property FifVal:double read ReadFifVal write WriteFifVal;
    property StcVal:double read ReadStcVal write WriteStcVal;
    property DifVal:double read ReadDifVal write WriteDifVal;
  end;

implementation

constructor TStcverTmp.Create;
begin
  oTmpTable := TmpInit ('STCVER',Self);
end;

destructor TStcverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStcverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStcverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStcverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStcverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStcverTmp.ReadGsName:Str60;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStcverTmp.WriteGsName(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStcverTmp.ReadGsName_:Str60;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStcverTmp.WriteGsName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStcverTmp.ReadDocQnt:double;
begin
  Result := oTmpTable.FieldByName('DocQnt').AsFloat;
end;

procedure TStcverTmp.WriteDocQnt(pValue:double);
begin
  oTmpTable.FieldByName('DocQnt').AsFloat := pValue;
end;

function TStcverTmp.ReadStmQnt:double;
begin
  Result := oTmpTable.FieldByName('StmQnt').AsFloat;
end;

procedure TStcverTmp.WriteStmQnt(pValue:double);
begin
  oTmpTable.FieldByName('StmQnt').AsFloat := pValue;
end;

function TStcverTmp.ReadFifQnt:double;
begin
  Result := oTmpTable.FieldByName('FifQnt').AsFloat;
end;

procedure TStcverTmp.WriteFifQnt(pValue:double);
begin
  oTmpTable.FieldByName('FifQnt').AsFloat := pValue;
end;

function TStcverTmp.ReadStcQnt:double;
begin
  Result := oTmpTable.FieldByName('StcQnt').AsFloat;
end;

procedure TStcverTmp.WriteStcQnt(pValue:double);
begin
  oTmpTable.FieldByName('StcQnt').AsFloat := pValue;
end;

function TStcverTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStcverTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TStcverTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TStcverTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TStcverTmp.ReadStmVal:double;
begin
  Result := oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TStcverTmp.WriteStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat := pValue;
end;

function TStcverTmp.ReadFifVal:double;
begin
  Result := oTmpTable.FieldByName('FifVal').AsFloat;
end;

procedure TStcverTmp.WriteFifVal(pValue:double);
begin
  oTmpTable.FieldByName('FifVal').AsFloat := pValue;
end;

function TStcverTmp.ReadStcVal:double;
begin
  Result := oTmpTable.FieldByName('StcVal').AsFloat;
end;

procedure TStcverTmp.WriteStcVal(pValue:double);
begin
  oTmpTable.FieldByName('StcVal').AsFloat := pValue;
end;

function TStcverTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TStcverTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStcverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStcverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStcverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStcverTmp.LocateGsName_ (pGsName_:Str60):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TStcverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStcverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStcverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStcverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStcverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStcverTmp.First;
begin
  oTmpTable.First;
end;

procedure TStcverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStcverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStcverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStcverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStcverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStcverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStcverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStcverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStcverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStcverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStcverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
