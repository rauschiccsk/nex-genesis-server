unit tKSDVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';

type
  TKsdverTmp = class (TComponent)
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
    function  ReadKsdQnt:double;         procedure WriteKsdQnt (pValue:double);
    function  ReadKsdVal:double;         procedure WriteKsdVal (pValue:double);
    function  ReadOucQnt:double;         procedure WriteOucQnt (pValue:double);
    function  ReadOucVal:double;         procedure WriteOucVal (pValue:double);
    function  ReadOukQnt:double;         procedure WriteOukQnt (pValue:double);
    function  ReadOukVal:double;         procedure WriteOukVal (pValue:double);
    function  ReadRetQnt:double;         procedure WriteRetQnt (pValue:double);
    function  ReadRetVal:double;         procedure WriteRetVal (pValue:double);
    function  ReadBuyQnt:double;         procedure WriteBuyQnt (pValue:double);
    function  ReadBuyVal:double;         procedure WriteBuyVal (pValue:double);
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
    property KsdQnt:double read ReadKsdQnt write WriteKsdQnt;
    property KsdVal:double read ReadKsdVal write WriteKsdVal;
    property OucQnt:double read ReadOucQnt write WriteOucQnt;
    property OucVal:double read ReadOucVal write WriteOucVal;
    property OukQnt:double read ReadOukQnt write WriteOukQnt;
    property OukVal:double read ReadOukVal write WriteOukVal;
    property RetQnt:double read ReadRetQnt write WriteRetQnt;
    property RetVal:double read ReadRetVal write WriteRetVal;
    property BuyQnt:double read ReadBuyQnt write WriteBuyQnt;
    property BuyVal:double read ReadBuyVal write WriteBuyVal;
  end;

implementation

constructor TKsdverTmp.Create;
begin
  oTmpTable := TmpInit ('KSDVER',Self);
end;

destructor TKsdverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TKsdverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TKsdverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TKsdverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TKsdverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TKsdverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TKsdverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TKsdverTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TKsdverTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TKsdverTmp.ReadKsdQnt:double;
begin
  Result := oTmpTable.FieldByName('KsdQnt').AsFloat;
end;

procedure TKsdverTmp.WriteKsdQnt(pValue:double);
begin
  oTmpTable.FieldByName('KsdQnt').AsFloat := pValue;
end;

function TKsdverTmp.ReadKsdVal:double;
begin
  Result := oTmpTable.FieldByName('KsdVal').AsFloat;
end;

procedure TKsdverTmp.WriteKsdVal(pValue:double);
begin
  oTmpTable.FieldByName('KsdVal').AsFloat := pValue;
end;

function TKsdverTmp.ReadOucQnt:double;
begin
  Result := oTmpTable.FieldByName('OucQnt').AsFloat;
end;

procedure TKsdverTmp.WriteOucQnt(pValue:double);
begin
  oTmpTable.FieldByName('OucQnt').AsFloat := pValue;
end;

function TKsdverTmp.ReadOucVal:double;
begin
  Result := oTmpTable.FieldByName('OucVal').AsFloat;
end;

procedure TKsdverTmp.WriteOucVal(pValue:double);
begin
  oTmpTable.FieldByName('OucVal').AsFloat := pValue;
end;

function TKsdverTmp.ReadOukQnt:double;
begin
  Result := oTmpTable.FieldByName('OukQnt').AsFloat;
end;

procedure TKsdverTmp.WriteOukQnt(pValue:double);
begin
  oTmpTable.FieldByName('OukQnt').AsFloat := pValue;
end;

function TKsdverTmp.ReadOukVal:double;
begin
  Result := oTmpTable.FieldByName('OukVal').AsFloat;
end;

procedure TKsdverTmp.WriteOukVal(pValue:double);
begin
  oTmpTable.FieldByName('OukVal').AsFloat := pValue;
end;

function TKsdverTmp.ReadRetQnt:double;
begin
  Result := oTmpTable.FieldByName('RetQnt').AsFloat;
end;

procedure TKsdverTmp.WriteRetQnt(pValue:double);
begin
  oTmpTable.FieldByName('RetQnt').AsFloat := pValue;
end;

function TKsdverTmp.ReadRetVal:double;
begin
  Result := oTmpTable.FieldByName('RetVal').AsFloat;
end;

procedure TKsdverTmp.WriteRetVal(pValue:double);
begin
  oTmpTable.FieldByName('RetVal').AsFloat := pValue;
end;

function TKsdverTmp.ReadBuyQnt:double;
begin
  Result := oTmpTable.FieldByName('BuyQnt').AsFloat;
end;

procedure TKsdverTmp.WriteBuyQnt(pValue:double);
begin
  oTmpTable.FieldByName('BuyQnt').AsFloat := pValue;
end;

function TKsdverTmp.ReadBuyVal:double;
begin
  Result := oTmpTable.FieldByName('BuyVal').AsFloat;
end;

procedure TKsdverTmp.WriteBuyVal(pValue:double);
begin
  oTmpTable.FieldByName('BuyVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TKsdverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TKsdverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TKsdverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TKsdverTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TKsdverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TKsdverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TKsdverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TKsdverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TKsdverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TKsdverTmp.First;
begin
  oTmpTable.First;
end;

procedure TKsdverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TKsdverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TKsdverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TKsdverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TKsdverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TKsdverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TKsdverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TKsdverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TKsdverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TKsdverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TKsdverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1927001}
