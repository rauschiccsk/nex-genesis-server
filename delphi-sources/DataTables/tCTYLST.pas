unit tCTYLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCtyCod = '';
  ixCcSc = 'CcSc';
  ixZipCod = 'ZipCod';

type
  TCtylstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCtyCod:Str3;           procedure WriteCtyCod (pValue:Str3);
    function  ReadStaCod:Str2;           procedure WriteStaCod (pValue:Str2);
    function  ReadCtyNam:Str30;          procedure WriteCtyNam (pValue:Str30);
    function  ReadZipCod:Str15;          procedure WriteZipCod (pValue:Str15);
    function  ReadCtyTel:Str6;           procedure WriteCtyTel (pValue:Str6);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateCtyCod (pCtyCod:Str3):boolean;
    function LocateCcSc (pCtyCod:Str3;pStaCod:Str2):boolean;
    function LocateZipCod (pZipCod:Str15):boolean;

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
    property CtyCod:Str3 read ReadCtyCod write WriteCtyCod;
    property StaCod:Str2 read ReadStaCod write WriteStaCod;
    property CtyNam:Str30 read ReadCtyNam write WriteCtyNam;
    property ZipCod:Str15 read ReadZipCod write WriteZipCod;
    property CtyTel:Str6 read ReadCtyTel write WriteCtyTel;
  end;

implementation

constructor TCtylstTmp.Create;
begin
  oTmpTable := TmpInit ('CTYLST',Self);
end;

destructor TCtylstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCtylstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCtylstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCtylstTmp.ReadCtyCod:Str3;
begin
  Result := oTmpTable.FieldByName('CtyCod').AsString;
end;

procedure TCtylstTmp.WriteCtyCod(pValue:Str3);
begin
  oTmpTable.FieldByName('CtyCod').AsString := pValue;
end;

function TCtylstTmp.ReadStaCod:Str2;
begin
  Result := oTmpTable.FieldByName('StaCod').AsString;
end;

procedure TCtylstTmp.WriteStaCod(pValue:Str2);
begin
  oTmpTable.FieldByName('StaCod').AsString := pValue;
end;

function TCtylstTmp.ReadCtyNam:Str30;
begin
  Result := oTmpTable.FieldByName('CtyNam').AsString;
end;

procedure TCtylstTmp.WriteCtyNam(pValue:Str30);
begin
  oTmpTable.FieldByName('CtyNam').AsString := pValue;
end;

function TCtylstTmp.ReadZipCod:Str15;
begin
  Result := oTmpTable.FieldByName('ZipCod').AsString;
end;

procedure TCtylstTmp.WriteZipCod(pValue:Str15);
begin
  oTmpTable.FieldByName('ZipCod').AsString := pValue;
end;

function TCtylstTmp.ReadCtyTel:Str6;
begin
  Result := oTmpTable.FieldByName('CtyTel').AsString;
end;

procedure TCtylstTmp.WriteCtyTel(pValue:Str6);
begin
  oTmpTable.FieldByName('CtyTel').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCtylstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCtylstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCtylstTmp.LocateCtyCod (pCtyCod:Str3):boolean;
begin
  SetIndex (ixCtyCod);
  Result := oTmpTable.FindKey([pCtyCod]);
end;

function TCtylstTmp.LocateCcSc (pCtyCod:Str3;pStaCod:Str2):boolean;
begin
  SetIndex (ixCcSc);
  Result := oTmpTable.FindKey([pCtyCod,pStaCod]);
end;

function TCtylstTmp.LocateZipCod (pZipCod:Str15):boolean;
begin
  SetIndex (ixZipCod);
  Result := oTmpTable.FindKey([pZipCod]);
end;

procedure TCtylstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCtylstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCtylstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCtylstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCtylstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCtylstTmp.First;
begin
  oTmpTable.First;
end;

procedure TCtylstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCtylstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCtylstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCtylstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCtylstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCtylstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCtylstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCtylstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCtylstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCtylstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCtylstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1916001}
