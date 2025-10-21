unit tSPALST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName = 'PaName';

type
  TSpalstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadFgCPrice:double;       procedure WriteFgCPrice (pValue:double);
    function  ReadLaCPrice:double;       procedure WriteLaCPrice (pValue:double);
    function  ReadLaInDate:TDatetime;    procedure WriteLaInDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName:Str30):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property FgCPrice:double read ReadFgCPrice write WriteFgCPrice;
    property LaCPrice:double read ReadLaCPrice write WriteLaCPrice;
    property LaInDate:TDatetime read ReadLaInDate write WriteLaInDate;
  end;

implementation

constructor TSpalstTmp.Create;
begin
  oTmpTable := TmpInit ('SPALST',Self);
end;

destructor TSpalstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpalstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpalstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpalstTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpalstTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpalstTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSpalstTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSpalstTmp.ReadFgCPrice:double;
begin
  Result := oTmpTable.FieldByName('FgCPrice').AsFloat;
end;

procedure TSpalstTmp.WriteFgCPrice(pValue:double);
begin
  oTmpTable.FieldByName('FgCPrice').AsFloat := pValue;
end;

function TSpalstTmp.ReadLaCPrice:double;
begin
  Result := oTmpTable.FieldByName('LaCPrice').AsFloat;
end;

procedure TSpalstTmp.WriteLaCPrice(pValue:double);
begin
  oTmpTable.FieldByName('LaCPrice').AsFloat := pValue;
end;

function TSpalstTmp.ReadLaInDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('LaInDate').AsDateTime;
end;

procedure TSpalstTmp.WriteLaInDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('LaInDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpalstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpalstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpalstTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TSpalstTmp.LocatePaName (pPaName:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oTmpTable.FindKey([pPaName]);
end;

procedure TSpalstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpalstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpalstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpalstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpalstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpalstTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpalstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpalstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpalstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpalstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpalstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpalstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpalstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpalstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpalstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpalstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpalstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
