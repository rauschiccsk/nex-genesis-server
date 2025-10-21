unit tSCGSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';

type
  TScgstkTmp = class (TComponent)
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
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
  end;

implementation

constructor TScgstkTmp.Create;
begin
  oTmpTable := TmpInit ('SCGSTK',Self);
end;

destructor TScgstkTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TScgstkTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TScgstkTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TScgstkTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TScgstkTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TScgstkTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TScgstkTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TScgstkTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TScgstkTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TScgstkTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TScgstkTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TScgstkTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TScgstkTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TScgstkTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TScgstkTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TScgstkTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TScgstkTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TScgstkTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TScgstkTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TScgstkTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TScgstkTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TScgstkTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TScgstkTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TScgstkTmp.First;
begin
  oTmpTable.First;
end;

procedure TScgstkTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TScgstkTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TScgstkTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TScgstkTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TScgstkTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TScgstkTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TScgstkTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TScgstkTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TScgstkTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TScgstkTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TScgstkTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
