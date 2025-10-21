unit tSRITM_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSrCode = '';

type
  TSritm_cTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadTrdShop:Str1;          procedure WriteTrdShop (pValue:Str1);
    function  ReadTrdStor:Str1;          procedure WriteTrdStor (pValue:Str1);
    function  ReadLaQnt:double;          procedure WriteLaQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSrCode (pSrCode:Str15):boolean;

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
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property TrdShop:Str1 read ReadTrdShop write WriteTrdShop;
    property TrdStor:Str1 read ReadTrdStor write WriteTrdStor;
    property LaQnt:double read ReadLaQnt write WriteLaQnt;
  end;

implementation

constructor TSritm_cTmp.Create;
begin
  oTmpTable := TmpInit ('SRITM_C',Self);
end;

destructor TSritm_cTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSritm_cTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSritm_cTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSritm_cTmp.ReadSrCode:Str15;
begin
  Result := oTmpTable.FieldByName('SrCode').AsString;
end;

procedure TSritm_cTmp.WriteSrCode(pValue:Str15);
begin
  oTmpTable.FieldByName('SrCode').AsString := pValue;
end;

function TSritm_cTmp.ReadTrdShop:Str1;
begin
  Result := oTmpTable.FieldByName('TrdShop').AsString;
end;

procedure TSritm_cTmp.WriteTrdShop(pValue:Str1);
begin
  oTmpTable.FieldByName('TrdShop').AsString := pValue;
end;

function TSritm_cTmp.ReadTrdStor:Str1;
begin
  Result := oTmpTable.FieldByName('TrdStor').AsString;
end;

procedure TSritm_cTmp.WriteTrdStor(pValue:Str1);
begin
  oTmpTable.FieldByName('TrdStor').AsString := pValue;
end;

function TSritm_cTmp.ReadLaQnt:double;
begin
  Result := oTmpTable.FieldByName('LaQnt').AsFloat;
end;

procedure TSritm_cTmp.WriteLaQnt(pValue:double);
begin
  oTmpTable.FieldByName('LaQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSritm_cTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSritm_cTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSritm_cTmp.LocateSrCode (pSrCode:Str15):boolean;
begin
  SetIndex (ixSrCode);
  Result := oTmpTable.FindKey([pSrCode]);
end;

procedure TSritm_cTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSritm_cTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSritm_cTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSritm_cTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSritm_cTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSritm_cTmp.First;
begin
  oTmpTable.First;
end;

procedure TSritm_cTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSritm_cTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSritm_cTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSritm_cTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSritm_cTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSritm_cTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSritm_cTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSritm_cTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSritm_cTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSritm_cTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSritm_cTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
