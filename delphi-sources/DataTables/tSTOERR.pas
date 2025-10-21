unit tSTOERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TStoerrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadStkQnt:double;         procedure WriteStkQnt (pValue:double);
    function  ReadStoQnt:double;         procedure WriteStoQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;

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
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property StkQnt:double read ReadStkQnt write WriteStkQnt;
    property StoQnt:double read ReadStoQnt write WriteStoQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
  end;

implementation

constructor TStoerrTmp.Create;
begin
  oTmpTable := TmpInit ('STOERR',Self);
end;

destructor TStoerrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStoerrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStoerrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStoerrTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStoerrTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStoerrTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStoerrTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStoerrTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStoerrTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStoerrTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStoerrTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TStoerrTmp.ReadStkQnt:double;
begin
  Result := oTmpTable.FieldByName('StkQnt').AsFloat;
end;

procedure TStoerrTmp.WriteStkQnt(pValue:double);
begin
  oTmpTable.FieldByName('StkQnt').AsFloat := pValue;
end;

function TStoerrTmp.ReadStoQnt:double;
begin
  Result := oTmpTable.FieldByName('StoQnt').AsFloat;
end;

procedure TStoerrTmp.WriteStoQnt(pValue:double);
begin
  oTmpTable.FieldByName('StoQnt').AsFloat := pValue;
end;

function TStoerrTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStoerrTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStoerrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStoerrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStoerrTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStoerrTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TStoerrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStoerrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStoerrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStoerrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStoerrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStoerrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStoerrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStoerrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStoerrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStoerrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStoerrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStoerrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStoerrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStoerrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStoerrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStoerrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStoerrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
