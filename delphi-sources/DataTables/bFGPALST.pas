unit bFGPALST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixPaIno = 'PaIno';
  ixPaTin = 'PaTin';
  ixSended = 'Sended';

type
  TFgpalstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str20;         procedure WritePaName_ (pValue:Str20);
    function  ReadPaIno:Str15;           procedure WritePaIno (pValue:Str15);
    function  ReadPaTin:Str15;           procedure WritePaTin (pValue:Str15);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str20):boolean;
    function LocatePaIno (pPaIno:Str15):boolean;
    function LocatePaTin (pPaTin:Str15):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str20):boolean;
    function NearestPaIno (pPaIno:Str15):boolean;
    function NearestPaTin (pPaTin:Str15):boolean;
    function NearestSended (pSended:byte):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str20 read ReadPaName_ write WritePaName_;
    property PaIno:Str15 read ReadPaIno write WritePaIno;
    property PaTin:Str15 read ReadPaTin write WritePaTin;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Sended:boolean read ReadSended write WriteSended;
  end;

implementation

constructor TFgpalstBtr.Create;
begin
  oBtrTable := BtrInit ('FGPALST',gPath.StkPath,Self);
end;

constructor TFgpalstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FGPALST',pPath,Self);
end;

destructor TFgpalstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFgpalstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFgpalstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFgpalstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TFgpalstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFgpalstBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TFgpalstBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TFgpalstBtr.ReadPaName_:Str20;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TFgpalstBtr.WritePaName_(pValue:Str20);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TFgpalstBtr.ReadPaIno:Str15;
begin
  Result := oBtrTable.FieldByName('PaIno').AsString;
end;

procedure TFgpalstBtr.WritePaIno(pValue:Str15);
begin
  oBtrTable.FieldByName('PaIno').AsString := pValue;
end;

function TFgpalstBtr.ReadPaTin:Str15;
begin
  Result := oBtrTable.FieldByName('PaTin').AsString;
end;

procedure TFgpalstBtr.WritePaTin(pValue:Str15);
begin
  oBtrTable.FieldByName('PaTin').AsString := pValue;
end;

function TFgpalstBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TFgpalstBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TFgpalstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TFgpalstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

// **************************************** PUBLIC ********************************************

function TFgpalstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFgpalstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFgpalstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFgpalstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFgpalstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFgpalstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFgpalstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TFgpalstBtr.LocatePaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TFgpalstBtr.LocatePaIno (pPaIno:Str15):boolean;
begin
  SetIndex (ixPaIno);
  Result := oBtrTable.FindKey([pPaIno]);
end;

function TFgpalstBtr.LocatePaTin (pPaTin:Str15):boolean;
begin
  SetIndex (ixPaTin);
  Result := oBtrTable.FindKey([pPaTin]);
end;

function TFgpalstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TFgpalstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TFgpalstBtr.NearestPaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TFgpalstBtr.NearestPaIno (pPaIno:Str15):boolean;
begin
  SetIndex (ixPaIno);
  Result := oBtrTable.FindNearest([pPaIno]);
end;

function TFgpalstBtr.NearestPaTin (pPaTin:Str15):boolean;
begin
  SetIndex (ixPaTin);
  Result := oBtrTable.FindNearest([pPaTin]);
end;

function TFgpalstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TFgpalstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFgpalstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFgpalstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFgpalstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFgpalstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFgpalstBtr.First;
begin
  oBtrTable.First;
end;

procedure TFgpalstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFgpalstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFgpalstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFgpalstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFgpalstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFgpalstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFgpalstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFgpalstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFgpalstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFgpalstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFgpalstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
