unit tFMDDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFnGcDnIn = '';
  ixFmdNum = 'FmdNum';

type
  TFmddocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFmdNum:word;           procedure WriteFmdNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadAvalue:double;         procedure WriteAvalue (pValue:double);
    function  ReadBvalue:double;         procedure WriteBvalue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateFnGcDnIn (pFmdNum:word;pGsCode:longint;pDocNum:Str12;pItmNum:word):boolean;
    function LocateFmdNum (pFmdNum:word):boolean;

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
    property FmdNum:word read ReadFmdNum write WriteFmdNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property Avalue:double read ReadAvalue write WriteAvalue;
    property Bvalue:double read ReadBvalue write WriteBvalue;
  end;

implementation

constructor TFmddocTmp.Create;
begin
  oTmpTable := TmpInit ('FMDDOC',Self);
end;

destructor TFmddocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFmddocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFmddocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFmddocTmp.ReadFmdNum:word;
begin
  Result := oTmpTable.FieldByName('FmdNum').AsInteger;
end;

procedure TFmddocTmp.WriteFmdNum(pValue:word);
begin
  oTmpTable.FieldByName('FmdNum').AsInteger := pValue;
end;

function TFmddocTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TFmddocTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TFmddocTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TFmddocTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TFmddocTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TFmddocTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TFmddocTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TFmddocTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TFmddocTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TFmddocTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TFmddocTmp.ReadFgCode:longint;
begin
  Result := oTmpTable.FieldByName('FgCode').AsInteger;
end;

procedure TFmddocTmp.WriteFgCode(pValue:longint);
begin
  oTmpTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFmddocTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TFmddocTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TFmddocTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TFmddocTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TFmddocTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TFmddocTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TFmddocTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TFmddocTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TFmddocTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TFmddocTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TFmddocTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TFmddocTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TFmddocTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TFmddocTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TFmddocTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TFmddocTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TFmddocTmp.ReadAvalue:double;
begin
  Result := oTmpTable.FieldByName('Avalue').AsFloat;
end;

procedure TFmddocTmp.WriteAvalue(pValue:double);
begin
  oTmpTable.FieldByName('Avalue').AsFloat := pValue;
end;

function TFmddocTmp.ReadBvalue:double;
begin
  Result := oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TFmddocTmp.WriteBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFmddocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFmddocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFmddocTmp.LocateFnGcDnIn (pFmdNum:word;pGsCode:longint;pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixFnGcDnIn);
  Result := oTmpTable.FindKey([pFmdNum,pGsCode,pDocNum,pItmNum]);
end;

function TFmddocTmp.LocateFmdNum (pFmdNum:word):boolean;
begin
  SetIndex (ixFmdNum);
  Result := oTmpTable.FindKey([pFmdNum]);
end;

procedure TFmddocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFmddocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFmddocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFmddocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFmddocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFmddocTmp.First;
begin
  oTmpTable.First;
end;

procedure TFmddocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFmddocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFmddocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFmddocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFmddocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFmddocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFmddocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFmddocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFmddocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFmddocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFmddocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1925001}
