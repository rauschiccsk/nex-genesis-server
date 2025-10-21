unit tSAPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPlsNum = '';

type
  TSaplstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPlsNum:longint;        procedure WritePlsNum (pValue:longint);
    function  ReadPlsName:Str30;         procedure WritePlsName (pValue:Str30);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePlsNum (pPlsNum:longint):boolean;

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
    property PlsNum:longint read ReadPlsNum write WritePlsNum;
    property PlsName:Str30 read ReadPlsName write WritePlsName;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
  end;

implementation

constructor TSaplstTmp.Create;
begin
  oTmpTable := TmpInit ('SAPLST',Self);
end;

destructor TSaplstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSaplstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSaplstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSaplstTmp.ReadPlsNum:longint;
begin
  Result := oTmpTable.FieldByName('PlsNum').AsInteger;
end;

procedure TSaplstTmp.WritePlsNum(pValue:longint);
begin
  oTmpTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TSaplstTmp.ReadPlsName:Str30;
begin
  Result := oTmpTable.FieldByName('PlsName').AsString;
end;

procedure TSaplstTmp.WritePlsName(pValue:Str30);
begin
  oTmpTable.FieldByName('PlsName').AsString := pValue;
end;

function TSaplstTmp.ReadAPrice:double;
begin
  Result := oTmpTable.FieldByName('APrice').AsFloat;
end;

procedure TSaplstTmp.WriteAPrice(pValue:double);
begin
  oTmpTable.FieldByName('APrice').AsFloat := pValue;
end;

function TSaplstTmp.ReadBPrice:double;
begin
  Result := oTmpTable.FieldByName('BPrice').AsFloat;
end;

procedure TSaplstTmp.WriteBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BPrice').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSaplstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSaplstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSaplstTmp.LocatePlsNum (pPlsNum:longint):boolean;
begin
  SetIndex (ixPlsNum);
  Result := oTmpTable.FindKey([pPlsNum]);
end;

procedure TSaplstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSaplstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSaplstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSaplstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSaplstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSaplstTmp.First;
begin
  oTmpTable.First;
end;

procedure TSaplstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSaplstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSaplstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSaplstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSaplstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSaplstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSaplstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSaplstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSaplstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSaplstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSaplstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
