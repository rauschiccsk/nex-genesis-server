unit bBARCODE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixBarCode = 'BarCode';
  ixGsBc = 'GsBc';

type
  TBarcodeBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateGsBc (pGsCode:longint;pBarCode:Str15):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestGsBc (pGsCode:longint;pBarCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TBarcodeBtr.Create;
begin
  oBtrTable := BtrInit ('BARCODE',gPath.StkPath,Self);
end;

constructor TBarcodeBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('BARCODE',pPath,Self);
end;

destructor TBarcodeBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TBarcodeBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TBarcodeBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TBarcodeBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TBarcodeBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TBarcodeBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TBarcodeBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TBarcodeBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TBarcodeBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TBarcodeBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TBarcodeBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TBarcodeBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TBarcodeBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBarcodeBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBarcodeBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TBarcodeBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TBarcodeBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TBarcodeBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TBarcodeBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TBarcodeBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TBarcodeBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TBarcodeBtr.LocateGsBc (pGsCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsBc);
  Result := oBtrTable.FindKey([pGsCode,pBarCode]);
end;

function TBarcodeBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TBarcodeBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TBarcodeBtr.NearestGsBc (pGsCode:longint;pBarCode:Str15):boolean;
begin
  SetIndex (ixGsBc);
  Result := oBtrTable.FindNearest([pGsCode,pBarCode]);
end;

procedure TBarcodeBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TBarcodeBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TBarcodeBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TBarcodeBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TBarcodeBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TBarcodeBtr.First;
begin
  oBtrTable.First;
end;

procedure TBarcodeBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TBarcodeBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TBarcodeBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TBarcodeBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TBarcodeBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TBarcodeBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TBarcodeBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TBarcodeBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TBarcodeBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TBarcodeBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TBarcodeBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
