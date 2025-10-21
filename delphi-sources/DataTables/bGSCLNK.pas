unit bGSCLNK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsLn = 'GsLn';
  ixGsCode = 'GsCode';
  ixLnkGsc = 'LnkGsc';

type
  TGsclnkBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadLnkGsc:longint;        procedure WriteLnkGsc (pValue:longint);
    function  ReadLnkGsn:Str60;          procedure WriteLnkGsn (pValue:Str60);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadLnkTyp:Str1;           procedure WriteLnkTyp (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsLn (pGsCode:longint;pLnkGsc:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateLnkGsc (pLnkGsc:longint):boolean;
    function NearestGsLn (pGsCode:longint;pLnkGsc:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestLnkGsc (pLnkGsc:longint):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property LnkGsc:longint read ReadLnkGsc write WriteLnkGsc;
    property LnkGsn:Str60 read ReadLnkGsn write WriteLnkGsn;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property LnkTyp:Str1 read ReadLnkTyp write WriteLnkTyp;
  end;

implementation

constructor TGsclnkBtr.Create;
begin
  oBtrTable := BtrInit ('GSCLNK',gPath.StkPath,Self);
end;

constructor TGsclnkBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSCLNK',pPath,Self);
end;

destructor TGsclnkBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGsclnkBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGsclnkBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGsclnkBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGsclnkBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGsclnkBtr.ReadLnkGsc:longint;
begin
  Result := oBtrTable.FieldByName('LnkGsc').AsInteger;
end;

procedure TGsclnkBtr.WriteLnkGsc(pValue:longint);
begin
  oBtrTable.FieldByName('LnkGsc').AsInteger := pValue;
end;

function TGsclnkBtr.ReadLnkGsn:Str60;
begin
  Result := oBtrTable.FieldByName('LnkGsn').AsString;
end;

procedure TGsclnkBtr.WriteLnkGsn(pValue:Str60);
begin
  oBtrTable.FieldByName('LnkGsn').AsString := pValue;
end;

function TGsclnkBtr.ReadMinQnt:double;
begin
  Result := oBtrTable.FieldByName('MinQnt').AsFloat;
end;

procedure TGsclnkBtr.WriteMinQnt(pValue:double);
begin
  oBtrTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TGsclnkBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TGsclnkBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGsclnkBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGsclnkBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGsclnkBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGsclnkBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGsclnkBtr.ReadLnkTyp:Str1;
begin
  Result := oBtrTable.FieldByName('LnkTyp').AsString;
end;

procedure TGsclnkBtr.WriteLnkTyp(pValue:Str1);
begin
  oBtrTable.FieldByName('LnkTyp').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGsclnkBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsclnkBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGsclnkBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGsclnkBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGsclnkBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGsclnkBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGsclnkBtr.LocateGsLn (pGsCode:longint;pLnkGsc:longint):boolean;
begin
  SetIndex (ixGsLn);
  Result := oBtrTable.FindKey([pGsCode,pLnkGsc]);
end;

function TGsclnkBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGsclnkBtr.LocateLnkGsc (pLnkGsc:longint):boolean;
begin
  SetIndex (ixLnkGsc);
  Result := oBtrTable.FindKey([pLnkGsc]);
end;

function TGsclnkBtr.NearestGsLn (pGsCode:longint;pLnkGsc:longint):boolean;
begin
  SetIndex (ixGsLn);
  Result := oBtrTable.FindNearest([pGsCode,pLnkGsc]);
end;

function TGsclnkBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TGsclnkBtr.NearestLnkGsc (pLnkGsc:longint):boolean;
begin
  SetIndex (ixLnkGsc);
  Result := oBtrTable.FindNearest([pLnkGsc]);
end;

procedure TGsclnkBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGsclnkBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGsclnkBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGsclnkBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGsclnkBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGsclnkBtr.First;
begin
  oBtrTable.First;
end;

procedure TGsclnkBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGsclnkBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGsclnkBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGsclnkBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGsclnkBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGsclnkBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGsclnkBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGsclnkBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGsclnkBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGsclnkBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGsclnkBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1903011}

