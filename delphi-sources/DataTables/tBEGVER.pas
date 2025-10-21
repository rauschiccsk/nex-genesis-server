unit tBEGVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TBegverTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadOldQnt:double;         procedure WriteOldQnt (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
    function  ReadOldVal:double;         procedure WriteOldVal (pValue:double);
    function  ReadActVal:double;         procedure WriteActVal (pValue:double);
    function  ReadDifVal:double;         procedure WriteDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property OldQnt:double read ReadOldQnt write WriteOldQnt;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
    property OldVal:double read ReadOldVal write WriteOldVal;
    property ActVal:double read ReadActVal write WriteActVal;
    property DifVal:double read ReadDifVal write WriteDifVal;
  end;

implementation

constructor TBegverTmp.Create;
begin
  oTmpTable := TmpInit ('BEGVER',Self);
end;

destructor TBegverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBegverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBegverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBegverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TBegverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TBegverTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TBegverTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TBegverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TBegverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TBegverTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TBegverTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TBegverTmp.ReadOldQnt:double;
begin
  Result := oTmpTable.FieldByName('OldQnt').AsFloat;
end;

procedure TBegverTmp.WriteOldQnt(pValue:double);
begin
  oTmpTable.FieldByName('OldQnt').AsFloat := pValue;
end;

function TBegverTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TBegverTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TBegverTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TBegverTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

function TBegverTmp.ReadOldVal:double;
begin
  Result := oTmpTable.FieldByName('OldVal').AsFloat;
end;

procedure TBegverTmp.WriteOldVal(pValue:double);
begin
  oTmpTable.FieldByName('OldVal').AsFloat := pValue;
end;

function TBegverTmp.ReadActVal:double;
begin
  Result := oTmpTable.FieldByName('ActVal').AsFloat;
end;

procedure TBegverTmp.WriteActVal(pValue:double);
begin
  oTmpTable.FieldByName('ActVal').AsFloat := pValue;
end;

function TBegverTmp.ReadDifVal:double;
begin
  Result := oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TBegverTmp.WriteDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBegverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBegverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBegverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TBegverTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TBegverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBegverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBegverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBegverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBegverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBegverTmp.First;
begin
  oTmpTable.First;
end;

procedure TBegverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBegverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBegverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBegverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBegverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBegverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBegverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBegverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBegverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBegverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBegverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
