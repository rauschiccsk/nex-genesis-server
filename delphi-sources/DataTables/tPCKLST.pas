unit tPCKLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPckNum = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';

type
  TPcklstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPckNum:Str5;           procedure WritePckNum (pValue:Str5);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadExDate:TDatetime;      procedure WriteExDate (pValue:TDatetime);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadCsCode:Str15;          procedure WriteCsCode (pValue:Str15);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePckNum (pPckNum:Str5):boolean;
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
    property PckNum:Str5 read ReadPckNum write WritePckNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Weight:double read ReadWeight write WriteWeight;
    property BValue:double read ReadBValue write WriteBValue;
    property ExDate:TDatetime read ReadExDate write WriteExDate;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property CsCode:Str15 read ReadCsCode write WriteCsCode;
  end;

implementation

constructor TPcklstTmp.Create;
begin
  oTmpTable := TmpInit ('PCKLST',Self);
end;

destructor TPcklstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPcklstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPcklstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPcklstTmp.ReadPckNum:Str5;
begin
  Result := oTmpTable.FieldByName('PckNum').AsString;
end;

procedure TPcklstTmp.WritePckNum(pValue:Str5);
begin
  oTmpTable.FieldByName('PckNum').AsString := pValue;
end;

function TPcklstTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPcklstTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPcklstTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TPcklstTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TPcklstTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TPcklstTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TPcklstTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TPcklstTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TPcklstTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TPcklstTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TPcklstTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TPcklstTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPcklstTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TPcklstTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TPcklstTmp.ReadExDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExDate').AsDateTime;
end;

procedure TPcklstTmp.WriteExDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExDate').AsDateTime := pValue;
end;

function TPcklstTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TPcklstTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TPcklstTmp.ReadCsCode:Str15;
begin
  Result := oTmpTable.FieldByName('CsCode').AsString;
end;

procedure TPcklstTmp.WriteCsCode(pValue:Str15);
begin
  oTmpTable.FieldByName('CsCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPcklstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPcklstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPcklstTmp.LocatePckNum (pPckNum:Str5):boolean;
begin
  SetIndex (ixPckNum);
  Result := oTmpTable.FindKey([pPckNum]);
end;

function TPcklstTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TPcklstTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

procedure TPcklstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPcklstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPcklstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPcklstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPcklstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPcklstTmp.First;
begin
  oTmpTable.First;
end;

procedure TPcklstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPcklstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPcklstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPcklstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPcklstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPcklstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPcklstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPcklstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPcklstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPcklstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPcklstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
