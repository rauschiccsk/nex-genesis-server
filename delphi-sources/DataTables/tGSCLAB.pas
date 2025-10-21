unit tGSCLAB;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';

type
  TGsclabTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGaName:Str60;          procedure WriteGaName (pValue:Str60);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property GaName:Str60 read ReadGaName write WriteGaName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
  end;

implementation

constructor TGsclabTmp.Create;
begin
  oTmpTable := TmpInit ('GSCLAB',Self);
end;

destructor TGsclabTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGsclabTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGsclabTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGsclabTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsclabTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsclabTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGsclabTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGsclabTmp.ReadGaName:Str60;
begin
  Result := oTmpTable.FieldByName('GaName').AsString;
end;

procedure TGsclabTmp.WriteGaName(pValue:Str60);
begin
  oTmpTable.FieldByName('GaName').AsString := pValue;
end;

function TGsclabTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TGsclabTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGsclabTmp.ReadMgName:Str30;
begin
  Result := oTmpTable.FieldByName('MgName').AsString;
end;

procedure TGsclabTmp.WriteMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString := pValue;
end;

function TGsclabTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TGsclabTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TGsclabTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TGsclabTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TGsclabTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TGsclabTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsclabTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGsclabTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGsclabTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TGsclabTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGsclabTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGsclabTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGsclabTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGsclabTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGsclabTmp.First;
begin
  oTmpTable.First;
end;

procedure TGsclabTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGsclabTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGsclabTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGsclabTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGsclabTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGsclabTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGsclabTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGsclabTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGsclabTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGsclabTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGsclabTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1901013}
