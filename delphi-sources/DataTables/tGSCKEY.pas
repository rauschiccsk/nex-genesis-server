unit tGSCKEY;

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
  ixOsdCode = 'OsdCode';
  ixSpcCode = 'SpcCode';

type
  TGsckeyTmp = class (TComponent)
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
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadSpcCode:Str30;         procedure WriteSpcCode (pValue:Str30);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadFreQnt:double;         procedure WriteFreQnt (pValue:double);
    function  ReadAction:Str1;           procedure WriteAction (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateOsdCode (pOsdCode:Str15):boolean;
    function LocateSpcCode (pSpcCode:Str30):boolean;

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
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property SpcCode:Str30 read ReadSpcCode write WriteSpcCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property FreQnt:double read ReadFreQnt write WriteFreQnt;
    property Action:Str1 read ReadAction write WriteAction;
  end;

implementation

constructor TGsckeyTmp.Create;
begin
  oTmpTable := TmpInit ('GSCKEY',Self);
end;

destructor TGsckeyTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGsckeyTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGsckeyTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGsckeyTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsckeyTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsckeyTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGsckeyTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGsckeyTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TGsckeyTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TGsckeyTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TGsckeyTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGsckeyTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TGsckeyTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TGsckeyTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TGsckeyTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TGsckeyTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TGsckeyTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TGsckeyTmp.ReadSpcCode:Str30;
begin
  Result := oTmpTable.FieldByName('SpcCode').AsString;
end;

procedure TGsckeyTmp.WriteSpcCode(pValue:Str30);
begin
  oTmpTable.FieldByName('SpcCode').AsString := pValue;
end;

function TGsckeyTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TGsckeyTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TGsckeyTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TGsckeyTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TGsckeyTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TGsckeyTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TGsckeyTmp.ReadActQnt:double;
begin
  Result := oTmpTable.FieldByName('ActQnt').AsFloat;
end;

procedure TGsckeyTmp.WriteActQnt(pValue:double);
begin
  oTmpTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TGsckeyTmp.ReadFreQnt:double;
begin
  Result := oTmpTable.FieldByName('FreQnt').AsFloat;
end;

procedure TGsckeyTmp.WriteFreQnt(pValue:double);
begin
  oTmpTable.FieldByName('FreQnt').AsFloat := pValue;
end;

function TGsckeyTmp.ReadAction:Str1;
begin
  Result := oTmpTable.FieldByName('Action').AsString;
end;

procedure TGsckeyTmp.WriteAction(pValue:Str1);
begin
  oTmpTable.FieldByName('Action').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsckeyTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGsckeyTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGsckeyTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TGsckeyTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TGsckeyTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TGsckeyTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TGsckeyTmp.LocateOsdCode (pOsdCode:Str15):boolean;
begin
  SetIndex (ixOsdCode);
  Result := oTmpTable.FindKey([pOsdCode]);
end;

function TGsckeyTmp.LocateSpcCode (pSpcCode:Str30):boolean;
begin
  SetIndex (ixSpcCode);
  Result := oTmpTable.FindKey([pSpcCode]);
end;

procedure TGsckeyTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGsckeyTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGsckeyTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGsckeyTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGsckeyTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGsckeyTmp.First;
begin
  oTmpTable.First;
end;

procedure TGsckeyTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGsckeyTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGsckeyTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGsckeyTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGsckeyTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGsckeyTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGsckeyTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGsckeyTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGsckeyTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGsckeyTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGsckeyTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1804003}