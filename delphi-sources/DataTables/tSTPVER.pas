unit tSTPVER;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TStpverTmp = class (TComponent)
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
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadStpQnt:double;         procedure WriteStpQnt (pValue:double);
    function  ReadDifQnt:double;         procedure WriteDifQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property StpQnt:double read ReadStpQnt write WriteStpQnt;
    property DifQnt:double read ReadDifQnt write WriteDifQnt;
  end;

implementation

constructor TStpverTmp.Create;
begin
  oTmpTable := TmpInit ('STPVER',Self);
end;

destructor TStpverTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStpverTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TStpverTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TStpverTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TStpverTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStpverTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TStpverTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TStpverTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TStpverTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TStpverTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TStpverTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TStpverTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TStpverTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TStpverTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TStpverTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TStpverTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TStpverTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TStpverTmp.ReadStpQnt:double;
begin
  Result := oTmpTable.FieldByName('StpQnt').AsFloat;
end;

procedure TStpverTmp.WriteStpQnt(pValue:double);
begin
  oTmpTable.FieldByName('StpQnt').AsFloat := pValue;
end;

function TStpverTmp.ReadDifQnt:double;
begin
  Result := oTmpTable.FieldByName('DifQnt').AsFloat;
end;

procedure TStpverTmp.WriteDifQnt(pValue:double);
begin
  oTmpTable.FieldByName('DifQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStpverTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TStpverTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TStpverTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TStpverTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TStpverTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TStpverTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

procedure TStpverTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TStpverTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStpverTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStpverTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStpverTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStpverTmp.First;
begin
  oTmpTable.First;
end;

procedure TStpverTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStpverTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStpverTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStpverTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStpverTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStpverTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStpverTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStpverTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStpverTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStpverTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TStpverTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1919001}
