unit tSUPSAL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';
  ixMgCode = 'MgCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSupCode = 'SupCode';
  ixPrfVal = 'PrfVal';
  ixPrfPrc = 'PrfPrc';

type
  TSupsalTmp = class (TComponent)
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
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadSupCode:Str15;         procedure WriteSupCode (pValue:Str15);
    function  ReadSalQnt:double;         procedure WriteSalQnt (pValue:double);
    function  ReadCvalue:double;         procedure WriteCvalue (pValue:double);
    function  ReadAvalue:double;         procedure WriteAvalue (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateMgCode (pMgCode:word):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSupCode (pSupCode:Str15):boolean;
    function LocatePrfVal (pPrfVal:double):boolean;
    function LocatePrfPrc (pPrfPrc:double):boolean;

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
    property MgCode:word read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property SupCode:Str15 read ReadSupCode write WriteSupCode;
    property SalQnt:double read ReadSalQnt write WriteSalQnt;
    property Cvalue:double read ReadCvalue write WriteCvalue;
    property Avalue:double read ReadAvalue write WriteAvalue;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
  end;

implementation

constructor TSupsalTmp.Create;
begin
  oTmpTable := TmpInit ('SUPSAL',Self);
end;

destructor TSupsalTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSupsalTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSupsalTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSupsalTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TSupsalTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSupsalTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TSupsalTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TSupsalTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TSupsalTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TSupsalTmp.ReadMgCode:word;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TSupsalTmp.WriteMgCode(pValue:word);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TSupsalTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TSupsalTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TSupsalTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TSupsalTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TSupsalTmp.ReadSupCode:Str15;
begin
  Result := oTmpTable.FieldByName('SupCode').AsString;
end;

procedure TSupsalTmp.WriteSupCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SupCode').AsString := pValue;
end;

function TSupsalTmp.ReadSalQnt:double;
begin
  Result := oTmpTable.FieldByName('SalQnt').AsFloat;
end;

procedure TSupsalTmp.WriteSalQnt(pValue:double);
begin
  oTmpTable.FieldByName('SalQnt').AsFloat := pValue;
end;

function TSupsalTmp.ReadCvalue:double;
begin
  Result := oTmpTable.FieldByName('Cvalue').AsFloat;
end;

procedure TSupsalTmp.WriteCvalue(pValue:double);
begin
  oTmpTable.FieldByName('Cvalue').AsFloat := pValue;
end;

function TSupsalTmp.ReadAvalue:double;
begin
  Result := oTmpTable.FieldByName('Avalue').AsFloat;
end;

procedure TSupsalTmp.WriteAvalue(pValue:double);
begin
  oTmpTable.FieldByName('Avalue').AsFloat := pValue;
end;

function TSupsalTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSupsalTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSupsalTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TSupsalTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSupsalTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSupsalTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSupsalTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TSupsalTmp.LocateMgCode (pMgCode:word):boolean;
begin
  SetIndex (ixMgCode);
  Result := oTmpTable.FindKey([pMgCode]);
end;

function TSupsalTmp.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TSupsalTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TSupsalTmp.LocateSupCode (pSupCode:Str15):boolean;
begin
  SetIndex (ixSupCode);
  Result := oTmpTable.FindKey([pSupCode]);
end;

function TSupsalTmp.LocatePrfVal (pPrfVal:double):boolean;
begin
  SetIndex (ixPrfVal);
  Result := oTmpTable.FindKey([pPrfVal]);
end;

function TSupsalTmp.LocatePrfPrc (pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result := oTmpTable.FindKey([pPrfPrc]);
end;

procedure TSupsalTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSupsalTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSupsalTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSupsalTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSupsalTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSupsalTmp.First;
begin
  oTmpTable.First;
end;

procedure TSupsalTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSupsalTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSupsalTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSupsalTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSupsalTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSupsalTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSupsalTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSupsalTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSupsalTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSupsalTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSupsalTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
