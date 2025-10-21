unit tPCKREP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ix = '';
  ixDdPcGc = 'DdPcGc';
  ixDdGc = 'DdGc';
  ixPcDdGc = 'PcDdGc';

type
  TPckrepTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadGsName:Str60;          procedure WriteGsName (pValue:Str60);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadOsdCode:Str15;         procedure WriteOsdCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadDdPcGc:Str24;          procedure WriteDdPcGc (pValue:Str24);
    function  ReadDdGc:Str16;            procedure WriteDdGc (pValue:Str16);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function Locate (pSerNum:longint):boolean;
    function LocateDdPcGc (pDocDate:TDatetime;pPaCode:longint;pGsCode:longint):boolean;
    function LocateDdGc (pDocDate:TDatetime;pGsCode:longint):boolean;
    function LocatePcDdGc (pPaCode:longint;pDocDate:TDatetime;pGsCode:longint):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property PaName:Str30 read ReadPaName write WritePaName;
    property GsName:Str60 read ReadGsName write WriteGsName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property OsdCode:Str15 read ReadOsdCode write WriteOsdCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property Weight:double read ReadWeight write WriteWeight;
    property DdPcGc:Str24 read ReadDdPcGc write WriteDdPcGc;
    property DdGc:Str16 read ReadDdGc write WriteDdGc;
  end;

implementation

constructor TPckrepTmp.Create;
begin
  oTmpTable := TmpInit ('PCKREP',Self);
end;

destructor TPckrepTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPckrepTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPckrepTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPckrepTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TPckrepTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPckrepTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPckrepTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPckrepTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TPckrepTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPckrepTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPckrepTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPckrepTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPckrepTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPckrepTmp.ReadExtNum:Str20;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TPckrepTmp.WriteExtNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TPckrepTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TPckrepTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TPckrepTmp.ReadGsName:Str60;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TPckrepTmp.WriteGsName(pValue:Str60);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TPckrepTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TPckrepTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TPckrepTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TPckrepTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TPckrepTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TPckrepTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TPckrepTmp.ReadOsdCode:Str15;
begin
  Result := oTmpTable.FieldByName('OsdCode').AsString;
end;

procedure TPckrepTmp.WriteOsdCode(pValue:Str15);
begin
  oTmpTable.FieldByName('OsdCode').AsString := pValue;
end;

function TPckrepTmp.ReadGsQnt:double;
begin
  Result := oTmpTable.FieldByName('GsQnt').AsFloat;
end;

procedure TPckrepTmp.WriteGsQnt(pValue:double);
begin
  oTmpTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TPckrepTmp.ReadWeight:double;
begin
  Result := oTmpTable.FieldByName('Weight').AsFloat;
end;

procedure TPckrepTmp.WriteWeight(pValue:double);
begin
  oTmpTable.FieldByName('Weight').AsFloat := pValue;
end;

function TPckrepTmp.ReadDdPcGc:Str24;
begin
  Result := oTmpTable.FieldByName('DdPcGc').AsString;
end;

procedure TPckrepTmp.WriteDdPcGc(pValue:Str24);
begin
  oTmpTable.FieldByName('DdPcGc').AsString := pValue;
end;

function TPckrepTmp.ReadDdGc:Str16;
begin
  Result := oTmpTable.FieldByName('DdGc').AsString;
end;

procedure TPckrepTmp.WriteDdGc(pValue:Str16);
begin
  oTmpTable.FieldByName('DdGc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPckrepTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPckrepTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPckrepTmp.Locate (pSerNum:longint):boolean;
begin
  SetIndex (ix);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TPckrepTmp.LocateDdPcGc (pDocDate:TDatetime;pPaCode:longint;pGsCode:longint):boolean;
begin
  SetIndex (ixDdPcGc);
  Result := oTmpTable.FindKey([pDocDate,pPaCode,pGsCode]);
end;

function TPckrepTmp.LocateDdGc (pDocDate:TDatetime;pGsCode:longint):boolean;
begin
  SetIndex (ixDdGc);
  Result := oTmpTable.FindKey([pDocDate,pGsCode]);
end;

function TPckrepTmp.LocatePcDdGc (pPaCode:longint;pDocDate:TDatetime;pGsCode:longint):boolean;
begin
  SetIndex (ixPcDdGc);
  Result := oTmpTable.FindKey([pPaCode,pDocDate,pGsCode]);
end;

procedure TPckrepTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPckrepTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPckrepTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPckrepTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPckrepTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPckrepTmp.First;
begin
  oTmpTable.First;
end;

procedure TPckrepTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPckrepTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPckrepTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPckrepTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPckrepTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPckrepTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPckrepTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPckrepTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPckrepTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPckrepTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPckrepTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
