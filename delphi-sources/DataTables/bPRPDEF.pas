unit bPRPDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmdNam = 'PmdNam';
  ixPnBn = 'PnBn';
  ixPnPn = 'PnPn';
  ixPnBnPn = 'PnBnPn';

type
  TPrpdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPmdNam:Str3;           procedure WritePmdNam (pValue:Str3);
    function  ReadBokNum:Str3;           procedure WriteBokNum (pValue:Str3);
    function  ReadPrpNam:Str6;           procedure WritePrpNam (pValue:Str6);
    function  ReadPrpVal:Str60;          procedure WritePrpVal (pValue:Str60);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePmdNam (pPmdNam:Str3):boolean;
    function LocatePnBn (pPmdNam:Str3;pBokNum:Str3):boolean;
    function LocatePnPn (pPmdNam:Str3;pPrpNam:Str6):boolean;
    function LocatePnBnPn (pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6):boolean;
    function NearestPmdNam (pPmdNam:Str3):boolean;
    function NearestPnBn (pPmdNam:Str3;pBokNum:Str3):boolean;
    function NearestPnPn (pPmdNam:Str3;pPrpNam:Str6):boolean;
    function NearestPnBnPn (pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6):boolean;

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
    property PmdNam:Str3 read ReadPmdNam write WritePmdNam;
    property BokNum:Str3 read ReadBokNum write WriteBokNum;
    property PrpNam:Str6 read ReadPrpNam write WritePrpNam;
    property PrpVal:Str60 read ReadPrpVal write WritePrpVal;
  end;

implementation

constructor TPrpdefBtr.Create;
begin
  oBtrTable := BtrInit ('PRPDEF',gPath.SysPath,Self);
end;

constructor TPrpdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRPDEF',pPath,Self);
end;

destructor TPrpdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrpdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrpdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrpdefBtr.ReadPmdNam:Str3;
begin
  Result := oBtrTable.FieldByName('PmdNam').AsString;
end;

procedure TPrpdefBtr.WritePmdNam(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdNam').AsString := pValue;
end;

function TPrpdefBtr.ReadBokNum:Str3;
begin
  Result := oBtrTable.FieldByName('BokNum').AsString;
end;

procedure TPrpdefBtr.WriteBokNum(pValue:Str3);
begin
  oBtrTable.FieldByName('BokNum').AsString := pValue;
end;

function TPrpdefBtr.ReadPrpNam:Str6;
begin
  Result := oBtrTable.FieldByName('PrpNam').AsString;
end;

procedure TPrpdefBtr.WritePrpNam(pValue:Str6);
begin
  oBtrTable.FieldByName('PrpNam').AsString := pValue;
end;

function TPrpdefBtr.ReadPrpVal:Str60;
begin
  Result := oBtrTable.FieldByName('PrpVal').AsString;
end;

procedure TPrpdefBtr.WritePrpVal(pValue:Str60);
begin
  oBtrTable.FieldByName('PrpVal').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrpdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrpdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrpdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrpdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrpdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrpdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrpdefBtr.LocatePmdNam (pPmdNam:Str3):boolean;
begin
  SetIndex (ixPmdNam);
  Result := oBtrTable.FindKey([pPmdNam]);
end;

function TPrpdefBtr.LocatePnBn (pPmdNam:Str3;pBokNum:Str3):boolean;
begin
  SetIndex (ixPnBn);
  Result := oBtrTable.FindKey([pPmdNam,pBokNum]);
end;

function TPrpdefBtr.LocatePnPn (pPmdNam:Str3;pPrpNam:Str6):boolean;
begin
  SetIndex (ixPnPn);
  Result := oBtrTable.FindKey([pPmdNam,pPrpNam]);
end;

function TPrpdefBtr.LocatePnBnPn (pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6):boolean;
begin
  SetIndex (ixPnBnPn);
  Result := oBtrTable.FindKey([pPmdNam,pBokNum,pPrpNam]);
end;

function TPrpdefBtr.NearestPmdNam (pPmdNam:Str3):boolean;
begin
  SetIndex (ixPmdNam);
  Result := oBtrTable.FindNearest([pPmdNam]);
end;

function TPrpdefBtr.NearestPnBn (pPmdNam:Str3;pBokNum:Str3):boolean;
begin
  SetIndex (ixPnBn);
  Result := oBtrTable.FindNearest([pPmdNam,pBokNum]);
end;

function TPrpdefBtr.NearestPnPn (pPmdNam:Str3;pPrpNam:Str6):boolean;
begin
  SetIndex (ixPnPn);
  Result := oBtrTable.FindNearest([pPmdNam,pPrpNam]);
end;

function TPrpdefBtr.NearestPnBnPn (pPmdNam:Str3;pBokNum:Str3;pPrpNam:Str6):boolean;
begin
  SetIndex (ixPnBnPn);
  Result := oBtrTable.FindNearest([pPmdNam,pBokNum,pPrpNam]);
end;

procedure TPrpdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrpdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrpdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrpdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrpdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrpdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrpdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrpdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrpdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrpdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrpdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrpdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrpdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrpdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrpdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrpdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrpdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2001001}
