unit bLNGTXT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixKylg = 'Kylg';

type
  TLngtxtBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadKey:Str10;             procedure WriteKey (pValue:Str10);
    function  ReadLng:Str2;              procedure WriteLng (pValue:Str2);
    function  ReadTxt:Str100;            procedure WriteTxt (pValue:Str100);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateKylg (pKey:Str10;pLng:Str2):boolean;
    function NearestKylg (pKey:Str10;pLng:Str2):boolean;

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
    property Key:Str10 read ReadKey write WriteKey;
    property Lng:Str2 read ReadLng write WriteLng;
    property Txt:Str100 read ReadTxt write WriteTxt;
  end;

implementation

constructor TLngtxtBtr.Create;
begin
  oBtrTable := BtrInit ('LNGTXT',gPath.SysPath,Self);
end;

constructor TLngtxtBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('LNGTXT',pPath,Self);
end;

destructor TLngtxtBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TLngtxtBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TLngtxtBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TLngtxtBtr.ReadKey:Str10;
begin
  Result := oBtrTable.FieldByName('Key').AsString;
end;

procedure TLngtxtBtr.WriteKey(pValue:Str10);
begin
  oBtrTable.FieldByName('Key').AsString := pValue;
end;

function TLngtxtBtr.ReadLng:Str2;
begin
  Result := oBtrTable.FieldByName('Lng').AsString;
end;

procedure TLngtxtBtr.WriteLng(pValue:Str2);
begin
  oBtrTable.FieldByName('Lng').AsString := pValue;
end;

function TLngtxtBtr.ReadTxt:Str100;
begin
  Result := oBtrTable.FieldByName('Txt').AsString;
end;

procedure TLngtxtBtr.WriteTxt(pValue:Str100);
begin
  oBtrTable.FieldByName('Txt').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TLngtxtBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLngtxtBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TLngtxtBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TLngtxtBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TLngtxtBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TLngtxtBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TLngtxtBtr.LocateKylg (pKey:Str10;pLng:Str2):boolean;
begin
  SetIndex (ixKylg);
  Result := oBtrTable.FindKey([pKey,pLng]);
end;

function TLngtxtBtr.NearestKylg (pKey:Str10;pLng:Str2):boolean;
begin
  SetIndex (ixKylg);
  Result := oBtrTable.FindNearest([pKey,pLng]);
end;

procedure TLngtxtBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TLngtxtBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TLngtxtBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TLngtxtBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TLngtxtBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TLngtxtBtr.First;
begin
  oBtrTable.First;
end;

procedure TLngtxtBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TLngtxtBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TLngtxtBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TLngtxtBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TLngtxtBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TLngtxtBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TLngtxtBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TLngtxtBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TLngtxtBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TLngtxtBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TLngtxtBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
