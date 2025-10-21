unit bTIO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnOnOi = 'DnOnOi';
  ixDoGc = 'DoGc';

type
  TTioBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadOsdNum:Str12;          procedure WriteOsdNum (pValue:Str12);
    function  ReadOsdItm:word;           procedure WriteOsdItm (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDnOnOi (pDocNum:Str12;pOsdNum:Str12;pOsdItm:word):boolean;
    function LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestDnOnOi (pDocNum:Str12;pOsdNum:Str12;pOsdItm:word):boolean;
    function NearestDoGc (pDocNum:Str12;pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property OsdNum:Str12 read ReadOsdNum write WriteOsdNum;
    property OsdItm:word read ReadOsdItm write WriteOsdItm;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
  end;

implementation

constructor TTioBtr.Create;
begin
  oBtrTable := BtrInit ('TIO',gPath.StkPath,Self);
end;

constructor TTioBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TIO',pPath,Self);
end;

destructor TTioBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTioBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTioBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTioBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTioBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTioBtr.ReadOsdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OsdNum').AsString;
end;

procedure TTioBtr.WriteOsdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OsdNum').AsString := pValue;
end;

function TTioBtr.ReadOsdItm:word;
begin
  Result := oBtrTable.FieldByName('OsdItm').AsInteger;
end;

procedure TTioBtr.WriteOsdItm(pValue:word);
begin
  oBtrTable.FieldByName('OsdItm').AsInteger := pValue;
end;

function TTioBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTioBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTioBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TTioBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TTioBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TTioBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TTioBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TTioBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTioBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTioBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTioBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTioBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTioBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTioBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTioBtr.LocateDnOnOi (pDocNum:Str12;pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixDnOnOi);
  Result := oBtrTable.FindKey([pDocNum,pOsdNum,pOsdItm]);
end;

function TTioBtr.LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TTioBtr.NearestDnOnOi (pDocNum:Str12;pOsdNum:Str12;pOsdItm:word):boolean;
begin
  SetIndex (ixDnOnOi);
  Result := oBtrTable.FindNearest([pDocNum,pOsdNum,pOsdItm]);
end;

function TTioBtr.NearestDoGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

procedure TTioBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTioBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTioBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTioBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTioBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTioBtr.First;
begin
  oBtrTable.First;
end;

procedure TTioBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTioBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTioBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTioBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTioBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTioBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTioBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTioBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTioBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTioBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTioBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1919001}
