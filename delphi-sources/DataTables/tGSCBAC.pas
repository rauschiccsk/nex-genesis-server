unit tGSCBAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = '';

type
  TGscbacTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsCode2:longint;       procedure WriteGsCode2 (pValue:longint);
    function  ReadGsName2:Str30;         procedure WriteGsName2 (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsCode2:longint read ReadGsCode2 write WriteGsCode2;
    property GsName2:Str30 read ReadGsName2 write WriteGsName2;
  end;

implementation

constructor TGscbacTmp.Create;
begin
  oTmpTable := TmpInit ('GSCBAC',Self);
end;

destructor TGscbacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGscbacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGscbacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGscbacTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TGscbacTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TGscbacTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscbacTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscbacTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGscbacTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGscbacTmp.ReadGsCode2:longint;
begin
  Result := oTmpTable.FieldByName('GsCode2').AsInteger;
end;

procedure TGscbacTmp.WriteGsCode2(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode2').AsInteger := pValue;
end;

function TGscbacTmp.ReadGsName2:Str30;
begin
  Result := oTmpTable.FieldByName('GsName2').AsString;
end;

procedure TGscbacTmp.WriteGsName2(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName2').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscbacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGscbacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGscbacTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TGscbacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGscbacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGscbacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGscbacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGscbacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGscbacTmp.First;
begin
  oTmpTable.First;
end;

procedure TGscbacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGscbacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGscbacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGscbacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGscbacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGscbacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGscbacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGscbacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGscbacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGscbacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGscbacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
