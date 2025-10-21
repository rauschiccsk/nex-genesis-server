unit tSTBVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TStbverTmp = class (TComponent)
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
    function  ReadPbgQnt:double;         procedure WritePbgQnt (pValue:double);
    function  ReadAbgQnt:double;         procedure WriteAbgQnt (pValue:double);
    function  ReadObgQnt:double;         procedure WriteObgQnt (pValue:double);
    function  ReadDbgQnt:double;         procedure WriteDbgQnt (pValue:double);
    function  ReadAacQnt:double;         procedure WriteAacQnt (pValue:double);
    function  ReadOacQnt:double;         procedure WriteOacQnt (pValue:double);
    function  ReadDacQnt:double;         procedure WriteDacQnt (pValue:double);
    function  ReadPbgVal:double;         procedure WritePbgVal (pValue:double);
    function  ReadAbgVal:double;         procedure WriteAbgVal (pValue:double);
    function  ReadObgVal:double;         procedure WriteObgVal (pValue:double);
    function  ReadDbgVal:double;         procedure WriteDbgVal (pValue:double);
    function  ReadAacVal:double;         procedure WriteAacVal (pValue:double);
    function  ReadOacVal:double;         procedure WriteOacVal (pValue:double);
    function  ReadDacVal:double;         procedure WriteDacVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str60):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
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
    property PbgQnt:double read ReadPbgQnt write WritePbgQnt;
    property AbgQnt:double read ReadAbgQnt write WriteAbgQnt;
    property ObgQnt:double read ReadObgQnt write WriteObgQnt;
    property DbgQnt:double read ReadDbgQnt write WriteDbgQnt;
    property AacQnt:double read ReadAacQnt write WriteAacQnt;
    property OacQnt:double read ReadOacQnt write WriteOacQnt;
    property DacQnt:double read ReadDacQnt write WriteDacQnt;
    property PbgVal:double read ReadPbgVal write WritePbgVal;
    property AbgVal:double read ReadAbgVal write WriteAbgVal;
    property ObgVal:double read ReadObgVal write WriteObgVal;
    property DbgVal:double read ReadDbgVal write WriteDbgVal;
    property AacVal:double read ReadAacVal write WriteAacVal;
    property OacVal:double read ReadOacVal write WriteOacVal;
    property DacVal:double read ReadDacVal write WriteDacVal;
  end;

implementation

constructor TStbverTmp.Create;
begin
  oTmpTable := TmpInit ('STBVER',Self);
end;

destructor TStbverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStbverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStbverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStbverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStbverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStbverTmp.ReadGsName:Str60;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStbverTmp.WriteGsName(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStbverTmp.ReadGsName_:Str60;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStbverTmp.WriteGsName_(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStbverTmp.ReadPbgQnt:double;
begin
  Result := oTmpTable.FieldByName('PbgQnt').AsFloat;
end;

procedure TStbverTmp.WritePbgQnt(pValue:double);
begin
  oTmpTable.FieldByName('PbgQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadAbgQnt:double;
begin
  Result := oTmpTable.FieldByName('AbgQnt').AsFloat;
end;

procedure TStbverTmp.WriteAbgQnt(pValue:double);
begin
  oTmpTable.FieldByName('AbgQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadObgQnt:double;
begin
  Result := oTmpTable.FieldByName('ObgQnt').AsFloat;
end;

procedure TStbverTmp.WriteObgQnt(pValue:double);
begin
  oTmpTable.FieldByName('ObgQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadDbgQnt:double;
begin
  Result := oTmpTable.FieldByName('DbgQnt').AsFloat;
end;

procedure TStbverTmp.WriteDbgQnt(pValue:double);
begin
  oTmpTable.FieldByName('DbgQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadAacQnt:double;
begin
  Result := oTmpTable.FieldByName('AacQnt').AsFloat;
end;

procedure TStbverTmp.WriteAacQnt(pValue:double);
begin
  oTmpTable.FieldByName('AacQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadOacQnt:double;
begin
  Result := oTmpTable.FieldByName('OacQnt').AsFloat;
end;

procedure TStbverTmp.WriteOacQnt(pValue:double);
begin
  oTmpTable.FieldByName('OacQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadDacQnt:double;
begin
  Result := oTmpTable.FieldByName('DacQnt').AsFloat;
end;

procedure TStbverTmp.WriteDacQnt(pValue:double);
begin
  oTmpTable.FieldByName('DacQnt').AsFloat := pValue;
end;

function TStbverTmp.ReadPbgVal:double;
begin
  Result := oTmpTable.FieldByName('PbgVal').AsFloat;
end;

procedure TStbverTmp.WritePbgVal(pValue:double);
begin
  oTmpTable.FieldByName('PbgVal').AsFloat := pValue;
end;

function TStbverTmp.ReadAbgVal:double;
begin
  Result := oTmpTable.FieldByName('AbgVal').AsFloat;
end;

procedure TStbverTmp.WriteAbgVal(pValue:double);
begin
  oTmpTable.FieldByName('AbgVal').AsFloat := pValue;
end;

function TStbverTmp.ReadObgVal:double;
begin
  Result := oTmpTable.FieldByName('ObgVal').AsFloat;
end;

procedure TStbverTmp.WriteObgVal(pValue:double);
begin
  oTmpTable.FieldByName('ObgVal').AsFloat := pValue;
end;

function TStbverTmp.ReadDbgVal:double;
begin
  Result := oTmpTable.FieldByName('DbgVal').AsFloat;
end;

procedure TStbverTmp.WriteDbgVal(pValue:double);
begin
  oTmpTable.FieldByName('DbgVal').AsFloat := pValue;
end;

function TStbverTmp.ReadAacVal:double;
begin
  Result := oTmpTable.FieldByName('AacVal').AsFloat;
end;

procedure TStbverTmp.WriteAacVal(pValue:double);
begin
  oTmpTable.FieldByName('AacVal').AsFloat := pValue;
end;

function TStbverTmp.ReadOacVal:double;
begin
  Result := oTmpTable.FieldByName('OacVal').AsFloat;
end;

procedure TStbverTmp.WriteOacVal(pValue:double);
begin
  oTmpTable.FieldByName('OacVal').AsFloat := pValue;
end;

function TStbverTmp.ReadDacVal:double;
begin
  Result := oTmpTable.FieldByName('DacVal').AsFloat;
end;

procedure TStbverTmp.WriteDacVal(pValue:double);
begin
  oTmpTable.FieldByName('DacVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStbverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStbverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStbverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStbverTmp.LocateGsName_ (pGsName_:Str60):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TStbverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStbverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStbverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStbverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStbverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStbverTmp.First;
begin
  oTmpTable.First;
end;

procedure TStbverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStbverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStbverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStbverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStbverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStbverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStbverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStbverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStbverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStbverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStbverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
