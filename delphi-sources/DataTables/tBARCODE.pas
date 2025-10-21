unit tBARCODE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = '';

type
  TBarcodeTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateBarCode (pBarCode:Str15):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TBarcodeTmp.Create;
begin
  oTmpTable := TmpInit ('BARCODE',Self);
end;

destructor TBarcodeTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBarcodeTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBarcodeTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBarcodeTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TBarcodeTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TBarcodeTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TBarcodeTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TBarcodeTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBarcodeTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBarcodeTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBarcodeTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TBarcodeTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TBarcodeTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBarcodeTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBarcodeTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBarcodeTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

procedure TBarcodeTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBarcodeTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBarcodeTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBarcodeTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBarcodeTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBarcodeTmp.First;
begin
  oTmpTable.First;
end;

procedure TBarcodeTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBarcodeTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBarcodeTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBarcodeTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBarcodeTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBarcodeTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBarcodeTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBarcodeTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBarcodeTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBarcodeTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBarcodeTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1922001}
