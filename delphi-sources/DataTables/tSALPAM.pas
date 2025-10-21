unit tSALPAM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaGs = '';
  ixPaMgBa = 'PaMgBa';
  ixGsCode = 'GsCode';
  ixMgCode = 'MgCode';
  ixBarCode = 'BarCode';
  ixGsName_ = 'GsName_';

type
  TSalpamTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMgName:Str30;          procedure WriteMgName (pValue:Str30);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
    function LocatePaMgBa (pPaCode:longint;pMgCode:longint;pBarCode:Str15):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MgName:Str30 read ReadMgName write WriteMgName;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
  end;

implementation

constructor TSalpamTmp.Create;
begin
  oTmpTable := TmpInit ('SALPAM',Self);
end;

destructor TSalpamTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSalpamTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSalpamTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSalpamTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSalpamTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSalpamTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSalpamTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSalpamTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSalpamTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSalpamTmp.ReadMgName:Str30;
begin
  Result := oTmpTable.FieldByName('MgName').AsString;
end;

procedure TSalpamTmp.WriteMgName(pValue:Str30);
begin
  oTmpTable.FieldByName('MgName').AsString := pValue;
end;

function TSalpamTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSalpamTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSalpamTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSalpamTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSalpamTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSalpamTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSalpamTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TSalpamTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TSalpamTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TSalpamTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TSalpamTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSalpamTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSalpamTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSalpamTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSalpamTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSalpamTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSalpamTmp.LocatePaGs (pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixPaGs);
  Result := oTmpTable.FindKey([pPaCode,pGsCode]);
end;

function TSalpamTmp.LocatePaMgBa (pPaCode:longint;pMgCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixPaMgBa);
  Result := oTmpTable.FindKey([pPaCode,pMgCode,pBarCode]);
end;

function TSalpamTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSalpamTmp.LocateMgCode (pMgCode:longint):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TSalpamTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TSalpamTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TSalpamTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSalpamTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSalpamTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSalpamTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSalpamTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSalpamTmp.First;
begin
  oTmpTable.First;
end;

procedure TSalpamTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSalpamTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSalpamTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSalpamTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSalpamTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSalpamTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSalpamTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSalpamTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSalpamTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSalpamTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSalpamTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
