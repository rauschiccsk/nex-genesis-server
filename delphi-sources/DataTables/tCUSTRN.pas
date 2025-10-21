unit tCUSTRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName = 'PaName';
  ixAvalue = 'Avalue';
  ixBvalue = 'Bvalue';

type
  TCustrnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str60;          procedure WritePaName (pValue:Str60);
    function  ReadPaName_:Str60;         procedure WritePaName_ (pValue:Str60);
    function  ReadAvalue:double;         procedure WriteAvalue (pValue:double);
    function  ReadBvalue:double;         procedure WriteBvalue (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str60):boolean;
    function LocateAvalue (pAvalue:double):boolean;
    function LocateBvalue (pBvalue:double):boolean;

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
    property PaName:Str60 read ReadPaName write WritePaName;
    property PaName_:Str60 read ReadPaName_ write WritePaName_;
    property Avalue:double read ReadAvalue write WriteAvalue;
    property Bvalue:double read ReadBvalue write WriteBvalue;
  end;

implementation

constructor TCustrnTmp.Create;
begin
  oTmpTable := TmpInit ('CUSTRN',Self);
end;

destructor TCustrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCustrnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCustrnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCustrnTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TCustrnTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TCustrnTmp.ReadPaName:Str60;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TCustrnTmp.WritePaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TCustrnTmp.ReadPaName_:Str60;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TCustrnTmp.WritePaName_(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TCustrnTmp.ReadAvalue:double;
begin
  Result := oTmpTable.FieldByName('Avalue').AsFloat;
end;

procedure TCustrnTmp.WriteAvalue(pValue:double);
begin
  oTmpTable.FieldByName('Avalue').AsFloat := pValue;
end;

function TCustrnTmp.ReadBvalue:double;
begin
  Result := oTmpTable.FieldByName('Bvalue').AsFloat;
end;

procedure TCustrnTmp.WriteBvalue(pValue:double);
begin
  oTmpTable.FieldByName('Bvalue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCustrnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCustrnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCustrnTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TCustrnTmp.LocatePaName (pPaName_:Str60):boolean;
begin
  SetIndex (ixPaName);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TCustrnTmp.LocateAvalue (pAvalue:double):boolean;
begin
  SetIndex (ixAvalue);
  Result := oTmpTable.FindKey([pAvalue]);
end;

function TCustrnTmp.LocateBvalue (pBvalue:double):boolean;
begin
  SetIndex (ixBvalue);
  Result := oTmpTable.FindKey([pBvalue]);
end;

procedure TCustrnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCustrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCustrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCustrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCustrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCustrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TCustrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCustrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCustrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCustrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCustrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCustrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCustrnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCustrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCustrnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCustrnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCustrnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
