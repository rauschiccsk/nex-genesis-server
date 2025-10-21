unit tFMDITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixGsCode = 'GsCode';
  ixWeight = 'Weight';
  ixFmdNum = 'FmdNum';
  ixGcFn = 'GcFn';

type
  TFmditmTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadFmdNum:word;           procedure WriteFmdNum (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateWeight (pWeight:double):boolean;
    function LocateFmdNum (pFmdNum:word):boolean;
    function LocateGcFn (pGsCode:longint;pFmdNum:word):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Weight:double read ReadWeight write WriteWeight;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property FmdNum:word read ReadFmdNum write WriteFmdNum;
  end;

implementation

constructor TFmditmTmp.Create;
begin
  oTmpTable := TmpInit ('FMDITM',Self);
end;

destructor TFmditmTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFmditmTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFmditmTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFmditmTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TFmditmTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TFmditmTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TFmditmTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TFmditmTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TFmditmTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TFmditmTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TFmditmTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFmditmTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TFmditmTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TFmditmTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TFmditmTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TFmditmTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TFmditmTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TFmditmTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TFmditmTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TFmditmTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TFmditmTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TFmditmTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TFmditmTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TFmditmTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TFmditmTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TFmditmTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TFmditmTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TFmditmTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TFmditmTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TFmditmTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFmditmTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFmditmTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFmditmTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFmditmTmp.ReadFmdNum:word;
begin
  Result := oTmpTable.FieldByName('FmdNum').AsInteger;
end;

procedure TFmditmTmp.WriteFmdNum(pValue:word);
begin
  oTmpTable.FieldByName('FmdNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFmditmTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFmditmTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFmditmTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TFmditmTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TFmditmTmp.LocateWeight (pWeight:double):boolean;
begin
  SetIndex (ixWeight);
  Result := oTmpTable.FindKey([pWeight]);
end;

function TFmditmTmp.LocateFmdNum (pFmdNum:word):boolean;
begin
  SetIndex (ixFmdNum);
  Result := oTmpTable.FindKey([pFmdNum]);
end;

function TFmditmTmp.LocateGcFn (pGsCode:longint;pFmdNum:word):boolean;
begin
  SetIndex (ixGcFn);
  Result := oTmpTable.FindKey([pGsCode,pFmdNum]);
end;

procedure TFmditmTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFmditmTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFmditmTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFmditmTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFmditmTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFmditmTmp.First;
begin
  oTmpTable.First;
end;

procedure TFmditmTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFmditmTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFmditmTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFmditmTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFmditmTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFmditmTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFmditmTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFmditmTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFmditmTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFmditmTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFmditmTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1925001}
