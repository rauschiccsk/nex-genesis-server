unit bPMDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRegInd = 'RegInd';
  ixPmdMark = 'PmdMark';
  ixPmdName_ = 'PmdName_';

type
  TPmdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRegInd:Str4;           procedure WriteRegInd (pValue:Str4);
    function  ReadSysMark:Str2;          procedure WriteSysMark (pValue:Str2);
    function  ReadPmdMark:Str3;          procedure WritePmdMark (pValue:Str3);
    function  ReadPmdType:Str1;          procedure WritePmdType (pValue:Str1);
    function  ReadPmdName:Str40;         procedure WritePmdName (pValue:Str40);
    function  ReadPmdName_:Str40;        procedure WritePmdName_ (pValue:Str40);
    function  ReadLSystem:Str1;          procedure WriteLSystem (pValue:Str1);
    function  ReadMSystem:Str1;          procedure WriteMSystem (pValue:Str1);
    function  ReadPSystem:Str1;          procedure WritePSystem (pValue:Str1);
    function  ReadLAPrice:double;        procedure WriteLAPrice (pValue:double);
    function  ReadMAPrice:double;        procedure WriteMAPrice (pValue:double);
    function  ReadPAPrice:double;        procedure WritePAPrice (pValue:double);
    function  ReadLActPrc:double;        procedure WriteLActPrc (pValue:double);
    function  ReadMActPrc:double;        procedure WriteMActPrc (pValue:double);
    function  ReadPActPrc:double;        procedure WritePActPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateRegInd (pRegInd:Str4):boolean;
    function LocatePmdMark (pPmdMark:Str3):boolean;
    function LocatePmdName_ (pPmdName_:Str40):boolean;
    function NearestRegInd (pRegInd:Str4):boolean;
    function NearestPmdMark (pPmdMark:Str3):boolean;
    function NearestPmdName_ (pPmdName_:Str40):boolean;

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
    property RegInd:Str4 read ReadRegInd write WriteRegInd;
    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property PmdType:Str1 read ReadPmdType write WritePmdType;
    property PmdName:Str40 read ReadPmdName write WritePmdName;
    property PmdName_:Str40 read ReadPmdName_ write WritePmdName_;
    property LSystem:Str1 read ReadLSystem write WriteLSystem;
    property MSystem:Str1 read ReadMSystem write WriteMSystem;
    property PSystem:Str1 read ReadPSystem write WritePSystem;
    property LAPrice:double read ReadLAPrice write WriteLAPrice;
    property MAPrice:double read ReadMAPrice write WriteMAPrice;
    property PAPrice:double read ReadPAPrice write WritePAPrice;
    property LActPrc:double read ReadLActPrc write WriteLActPrc;
    property MActPrc:double read ReadMActPrc write WriteMActPrc;
    property PActPrc:double read ReadPActPrc write WritePActPrc;
  end;

implementation

constructor TPmdlstBtr.Create;
begin
  oBtrTable := BtrInit ('PMDLST',gPath.CdwPath,Self);
end;

constructor TPmdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PMDLST',pPath,Self);
end;

destructor TPmdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPmdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPmdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPmdlstBtr.ReadRegInd:Str4;
begin
  Result := oBtrTable.FieldByName('RegInd').AsString;
end;

procedure TPmdlstBtr.WriteRegInd(pValue:Str4);
begin
  oBtrTable.FieldByName('RegInd').AsString := pValue;
end;

function TPmdlstBtr.ReadSysMark:Str2;
begin
  Result := oBtrTable.FieldByName('SysMark').AsString;
end;

procedure TPmdlstBtr.WriteSysMark(pValue:Str2);
begin
  oBtrTable.FieldByName('SysMark').AsString := pValue;
end;

function TPmdlstBtr.ReadPmdMark:Str3;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TPmdlstBtr.WritePmdMark(pValue:Str3);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TPmdlstBtr.ReadPmdType:Str1;
begin
  Result := oBtrTable.FieldByName('PmdType').AsString;
end;

procedure TPmdlstBtr.WritePmdType(pValue:Str1);
begin
  oBtrTable.FieldByName('PmdType').AsString := pValue;
end;

function TPmdlstBtr.ReadPmdName:Str40;
begin
  Result := oBtrTable.FieldByName('PmdName').AsString;
end;

procedure TPmdlstBtr.WritePmdName(pValue:Str40);
begin
  oBtrTable.FieldByName('PmdName').AsString := pValue;
end;

function TPmdlstBtr.ReadPmdName_:Str40;
begin
  Result := oBtrTable.FieldByName('PmdName_').AsString;
end;

procedure TPmdlstBtr.WritePmdName_(pValue:Str40);
begin
  oBtrTable.FieldByName('PmdName_').AsString := pValue;
end;

function TPmdlstBtr.ReadLSystem:Str1;
begin
  Result := oBtrTable.FieldByName('LSystem').AsString;
end;

procedure TPmdlstBtr.WriteLSystem(pValue:Str1);
begin
  oBtrTable.FieldByName('LSystem').AsString := pValue;
end;

function TPmdlstBtr.ReadMSystem:Str1;
begin
  Result := oBtrTable.FieldByName('MSystem').AsString;
end;

procedure TPmdlstBtr.WriteMSystem(pValue:Str1);
begin
  oBtrTable.FieldByName('MSystem').AsString := pValue;
end;

function TPmdlstBtr.ReadPSystem:Str1;
begin
  Result := oBtrTable.FieldByName('PSystem').AsString;
end;

procedure TPmdlstBtr.WritePSystem(pValue:Str1);
begin
  oBtrTable.FieldByName('PSystem').AsString := pValue;
end;

function TPmdlstBtr.ReadLAPrice:double;
begin
  Result := oBtrTable.FieldByName('LAPrice').AsFloat;
end;

procedure TPmdlstBtr.WriteLAPrice(pValue:double);
begin
  oBtrTable.FieldByName('LAPrice').AsFloat := pValue;
end;

function TPmdlstBtr.ReadMAPrice:double;
begin
  Result := oBtrTable.FieldByName('MAPrice').AsFloat;
end;

procedure TPmdlstBtr.WriteMAPrice(pValue:double);
begin
  oBtrTable.FieldByName('MAPrice').AsFloat := pValue;
end;

function TPmdlstBtr.ReadPAPrice:double;
begin
  Result := oBtrTable.FieldByName('PAPrice').AsFloat;
end;

procedure TPmdlstBtr.WritePAPrice(pValue:double);
begin
  oBtrTable.FieldByName('PAPrice').AsFloat := pValue;
end;

function TPmdlstBtr.ReadLActPrc:double;
begin
  Result := oBtrTable.FieldByName('LActPrc').AsFloat;
end;

procedure TPmdlstBtr.WriteLActPrc(pValue:double);
begin
  oBtrTable.FieldByName('LActPrc').AsFloat := pValue;
end;

function TPmdlstBtr.ReadMActPrc:double;
begin
  Result := oBtrTable.FieldByName('MActPrc').AsFloat;
end;

procedure TPmdlstBtr.WriteMActPrc(pValue:double);
begin
  oBtrTable.FieldByName('MActPrc').AsFloat := pValue;
end;

function TPmdlstBtr.ReadPActPrc:double;
begin
  Result := oBtrTable.FieldByName('PActPrc').AsFloat;
end;

procedure TPmdlstBtr.WritePActPrc(pValue:double);
begin
  oBtrTable.FieldByName('PActPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPmdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPmdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPmdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPmdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPmdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPmdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPmdlstBtr.LocateRegInd (pRegInd:Str4):boolean;
begin
  SetIndex (ixRegInd);
  Result := oBtrTable.FindKey([pRegInd]);
end;

function TPmdlstBtr.LocatePmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindKey([pPmdMark]);
end;

function TPmdlstBtr.LocatePmdName_ (pPmdName_:Str40):boolean;
begin
  SetIndex (ixPmdName_);
  Result := oBtrTable.FindKey([StrToAlias(pPmdName_)]);
end;

function TPmdlstBtr.NearestRegInd (pRegInd:Str4):boolean;
begin
  SetIndex (ixRegInd);
  Result := oBtrTable.FindNearest([pRegInd]);
end;

function TPmdlstBtr.NearestPmdMark (pPmdMark:Str3):boolean;
begin
  SetIndex (ixPmdMark);
  Result := oBtrTable.FindNearest([pPmdMark]);
end;

function TPmdlstBtr.NearestPmdName_ (pPmdName_:Str40):boolean;
begin
  SetIndex (ixPmdName_);
  Result := oBtrTable.FindNearest([pPmdName_]);
end;

procedure TPmdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPmdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPmdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPmdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPmdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPmdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPmdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPmdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPmdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPmdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPmdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPmdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPmdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPmdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPmdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPmdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPmdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
