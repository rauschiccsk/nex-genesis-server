unit tSRCDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixDocDate = 'DocDate';

type
  TSrcdocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadNValue:double;         procedure WriteNValue (pValue:double);
    function  ReadXValue:double;         procedure WriteXValue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property CValue:double read ReadCValue write WriteCValue;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property NValue:double read ReadNValue write WriteNValue;
    property XValue:double read ReadXValue write WriteXValue;
  end;

implementation

constructor TSrcdocTmp.Create;
begin
  oTmpTable := TmpInit ('SRCDOC',Self);
end;

destructor TSrcdocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrcdocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrcdocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrcdocTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSrcdocTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSrcdocTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSrcdocTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSrcdocTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TSrcdocTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

function TSrcdocTmp.ReadPrfPrc:double;
begin
  Result := oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TSrcdocTmp.WritePrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TSrcdocTmp.ReadPrfVal:double;
begin
  Result := oTmpTable.FieldByName('PrfVal').AsFloat;
end;

procedure TSrcdocTmp.WritePrfVal(pValue:double);
begin
  oTmpTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TSrcdocTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSrcdocTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSrcdocTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSrcdocTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSrcdocTmp.ReadNValue:double;
begin
  Result := oTmpTable.FieldByName('NValue').AsFloat;
end;

procedure TSrcdocTmp.WriteNValue(pValue:double);
begin
  oTmpTable.FieldByName('NValue').AsFloat := pValue;
end;

function TSrcdocTmp.ReadXValue:double;
begin
  Result := oTmpTable.FieldByName('XValue').AsFloat;
end;

procedure TSrcdocTmp.WriteXValue(pValue:double);
begin
  oTmpTable.FieldByName('XValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrcdocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrcdocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrcdocTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSrcdocTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

procedure TSrcdocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrcdocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrcdocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrcdocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrcdocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrcdocTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrcdocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrcdocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrcdocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrcdocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrcdocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrcdocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrcdocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrcdocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrcdocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrcdocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrcdocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
