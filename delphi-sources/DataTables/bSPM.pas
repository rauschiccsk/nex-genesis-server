unit bSPM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPoGs = 'PoGs';
  ixGsCode = 'GsCode';
  ixPoCode = 'PoCode';

type
  TSpmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMovQnt:double;         procedure WriteMovQnt (pValue:double);
    function  ReadMovUsr:Str8;           procedure WriteMovUsr (pValue:Str8);
    function  ReadMovDat:TDatetime;      procedure WriteMovDat (pValue:TDatetime);
    function  ReadMovTim:TDatetime;      procedure WriteMovTim (pValue:TDatetime);
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
    function NearestPoGs (pPoCode:Str15;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestPoCode (pPoCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pStkNum:word);
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
    property MovQnt:double read ReadMovQnt write WriteMovQnt;
    property MovUsr:Str8 read ReadMovUsr write WriteMovUsr;
    property MovDat:TDatetime read ReadMovDat write WriteMovDat;
    property MovTim:TDatetime read ReadMovTim write WriteMovTim;
  end;

implementation

constructor TSpmBtr.Create;
begin
  oBtrTable := BtrInit ('SPM',gPath.StkPath,Self);
end;

constructor TSpmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPM',pPath,Self);
end;

destructor TSpmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSpmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSpmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSpmBtr.ReadPoCode:Str15;
begin
  Result := oBtrTable.FieldByName('PoCode').AsString;
end;

procedure TSpmBtr.WritePoCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PoCode').AsString := pValue;
end;

function TSpmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TSpmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TSpmBtr.ReadMovQnt:double;
begin
  Result := oBtrTable.FieldByName('MovQnt').AsFloat;
end;

procedure TSpmBtr.WriteMovQnt(pValue:double);
begin
  oBtrTable.FieldByName('MovQnt').AsFloat := pValue;
end;

function TSpmBtr.ReadMovUsr:Str8;
begin
  Result := oBtrTable.FieldByName('MovUsr').AsString;
end;

procedure TSpmBtr.WriteMovUsr(pValue:Str8);
begin
  oBtrTable.FieldByName('MovUsr').AsString := pValue;
end;

function TSpmBtr.ReadMovDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('MovDat').AsDateTime;
end;

procedure TSpmBtr.WriteMovDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MovDat').AsDateTime := pValue;
end;

function TSpmBtr.ReadMovTim:TDatetime;
begin
  Result := oBtrTable.FieldByName('MovTim').AsDateTime;
end;

procedure TSpmBtr.WriteMovTim(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MovTim').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSpmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSpmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSpmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSpmBtr.LocatePoGs (pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixPoGs);
  Result := oBtrTable.FindKey([pPoCode,pGsCode]);
end;

function TSpmBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TSpmBtr.LocatePoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oBtrTable.FindKey([pPoCode]);
end;

function TSpmBtr.NearestPoGs (pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixPoGs);
  Result := oBtrTable.FindNearest([pPoCode,pGsCode]);
end;

function TSpmBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TSpmBtr.NearestPoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oBtrTable.FindNearest([pPoCode]);
end;

procedure TSpmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSpmBtr.Open(pStkNum:word);
begin
  oBtrTable.Open(pStkNum);
end;

procedure TSpmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSpmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSpmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSpmBtr.First;
begin
  oBtrTable.First;
end;

procedure TSpmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSpmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSpmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSpmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSpmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSpmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSpmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSpmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSpmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSpmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSpmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1918001}
