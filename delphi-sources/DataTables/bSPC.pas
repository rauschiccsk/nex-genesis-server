unit bSPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPoGs = 'PoGs';
  ixGsCode = 'GsCode';
  ixPoCode = 'PoCode';
  ixActQnt = 'ActQnt';

type
  TSpcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadActQnt:double;         procedure WriteActQnt (pValue:double);
    function  ReadImpDat:TDatetime;      procedure WriteImpDat (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePoGs (pPoCode:Str15;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocatePoCode (pPoCode:Str15):boolean;
    function LocateActQnt (pActQnt:double):boolean;
    function NearestPoGs (pPoCode:Str15;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPoCode (pPoCode:Str15):boolean;
    function NearestActQnt (pActQnt:double):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:longint);
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
    property PoCode:Str15 read ReadPoCode write WritePoCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ActQnt:double read ReadActQnt write WriteActQnt;
    property ImpDat:TDatetime read ReadImpDat write WriteImpDat;
  end;

implementation

constructor TSpcBtr.Create;
begin
  oBtrTable := BtrInit ('SPC',gPath.StkPath,Self);
end;

constructor TSpcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPC',pPath,Self);
end;

destructor TSpcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSpcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSpcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSpcBtr.ReadPoCode:Str15;
begin
  Result := oBtrTable.FieldByName('PoCode').AsString;
end;

procedure TSpcBtr.WritePoCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PoCode').AsString := pValue;
end;

function TSpcBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSpcBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSpcBtr.ReadActQnt:double;
begin
  Result := oBtrTable.FieldByName('ActQnt').AsFloat;
end;

procedure TSpcBtr.WriteActQnt(pValue:double);
begin
  oBtrTable.FieldByName('ActQnt').AsFloat := pValue;
end;

function TSpcBtr.ReadImpDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('ImpDat').AsDateTime;
end;

procedure TSpcBtr.WriteImpDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ImpDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSpcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSpcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSpcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSpcBtr.LocatePoGs (pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixPoGs);
  Result := oBtrTable.FindKey([pPoCode,pGsCode]);
end;

function TSpcBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSpcBtr.LocatePoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oBtrTable.FindKey([pPoCode]);
end;

function TSpcBtr.LocateActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindKey([pActQnt]);
end;

function TSpcBtr.NearestPoGs (pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixPoGs);
  Result := oBtrTable.FindNearest([pPoCode,pGsCode]);
end;

function TSpcBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSpcBtr.NearestPoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oBtrTable.FindNearest([pPoCode]);
end;

function TSpcBtr.NearestActQnt (pActQnt:double):boolean;
begin
  SetIndex (ixActQnt);
  Result := oBtrTable.FindNearest([pActQnt]);
end;

procedure TSpcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSpcBtr.Open(pStkNum:longint);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TSpcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSpcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSpcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSpcBtr.First;
begin
  oBtrTable.First;
end;

procedure TSpcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSpcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSpcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSpcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSpcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSpcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSpcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSpcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSpcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSpcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSpcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
