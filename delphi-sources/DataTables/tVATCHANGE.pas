unit tVATCHANGE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgGs = 'MgGs';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixVatPrc = 'VatPrc';

type
  TVatchangeTmp = class (TComponent)
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
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadVatPrc:double;         procedure WriteVatPrc (pValue:double);
    function  ReadNewVatPrc:Str2;        procedure WriteNewVatPrc (pValue:Str2);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateVatPrc (pVatPrc:double):boolean;

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
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property VatPrc:double read ReadVatPrc write WriteVatPrc;
    property NewVatPrc:Str2 read ReadNewVatPrc write WriteNewVatPrc;
  end;

implementation

constructor TVatchangeTmp.Create;
begin
  oTmpTable := TmpInit ('VATCHANGE',Self);
end;

destructor TVatchangeTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TVatchangeTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TVatchangeTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TVatchangeTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TVatchangeTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TVatchangeTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TVatchangeTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TVatchangeTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TVatchangeTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TVatchangeTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TVatchangeTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TVatchangeTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TVatchangeTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TVatchangeTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TVatchangeTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TVatchangeTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TVatchangeTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TVatchangeTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TVatchangeTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TVatchangeTmp.ReadGsType:Str1;
begin
  Result := oTmpTable.FieldByName('GsType').AsString;
end;

procedure TVatchangeTmp.WriteGsType(pValue:Str1);
begin
  oTmpTable.FieldByName('GsType').AsString := pValue;
end;

function TVatchangeTmp.ReadVatPrc:double;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsFloat;
end;

procedure TVatchangeTmp.WriteVatPrc(pValue:double);
begin
  oTmpTable.FieldByName('VatPrc').AsFloat := pValue;
end;

function TVatchangeTmp.ReadNewVatPrc:Str2;
begin
  Result := oTmpTable.FieldByName('NewVatPrc').AsString;
end;

procedure TVatchangeTmp.WriteNewVatPrc(pValue:Str2);
begin
  oTmpTable.FieldByName('NewVatPrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVatchangeTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TVatchangeTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TVatchangeTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TVatchangeTmp.LocateMgGs (pMgCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixMgGs);
  Result := oTmpTable.FindKey([pMgCode,pGsCode]);
end;

function TVatchangeTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TVatchangeTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TVatchangeTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

function TVatchangeTmp.LocateVatPrc (pVatPrc:double):boolean;
begin
  SetIndex (ixVatPrc);
  Result := oTmpTable.FindKey([pVatPrc]);
end;

procedure TVatchangeTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TVatchangeTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TVatchangeTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TVatchangeTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TVatchangeTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TVatchangeTmp.First;
begin
  oTmpTable.First;
end;

procedure TVatchangeTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TVatchangeTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TVatchangeTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TVatchangeTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TVatchangeTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TVatchangeTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TVatchangeTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TVatchangeTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TVatchangeTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TVatchangeTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TVatchangeTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
