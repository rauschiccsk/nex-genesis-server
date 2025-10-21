unit bVTDSPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixVtdSpc = 'VtdSpc';

type
  TVtdspcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadVtdSpc:word;           procedure WriteVtdSpc (pValue:word);
    function  ReadDescribe:Str60;        procedure WriteDescribe (pValue:Str60);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSvtClc:byte;           procedure WriteSvtClc (pValue:byte);
    function  ReadSvtGrp:byte;           procedure WriteSvtGrp (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateVtdSpc (pVtdSpc:word):boolean;
    function NearestVtdSpc (pVtdSpc:word):boolean;

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
    property VtdSpc:word read ReadVtdSpc write WriteVtdSpc;
    property Describe:Str60 read ReadDescribe write WriteDescribe;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property SvtClc:byte read ReadSvtClc write WriteSvtClc;
    property SvtGrp:byte read ReadSvtGrp write WriteSvtGrp;
  end;

implementation

constructor TVtdspcBtr.Create;
begin
  oBtrTable := BtrInit ('VTDSPC',gPath.LdgPath,Self);
end;

constructor TVtdspcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTDSPC',pPath,Self);
end;

destructor TVtdspcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtdspcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtdspcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtdspcBtr.ReadVtdSpc:word;
begin
  Result := oBtrTable.FieldByName('VtdSpc').AsInteger;
end;

procedure TVtdspcBtr.WriteVtdSpc(pValue:word);
begin
  oBtrTable.FieldByName('VtdSpc').AsInteger := pValue;
end;

function TVtdspcBtr.ReadDescribe:Str60;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TVtdspcBtr.WriteDescribe(pValue:Str60);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TVtdspcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVtdspcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtdspcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtdspcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtdspcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtdspcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVtdspcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TVtdspcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TVtdspcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TVtdspcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TVtdspcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TVtdspcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TVtdspcBtr.ReadSvtClc:byte;
begin
  Result := oBtrTable.FieldByName('SvtClc').AsInteger;
end;

procedure TVtdspcBtr.WriteSvtClc(pValue:byte);
begin
  oBtrTable.FieldByName('SvtClc').AsInteger := pValue;
end;

function TVtdspcBtr.ReadSvtGrp:byte;
begin
  Result := oBtrTable.FieldByName('SvtGrp').AsInteger;
end;

procedure TVtdspcBtr.WriteSvtGrp(pValue:byte);
begin
  oBtrTable.FieldByName('SvtGrp').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtdspcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtdspcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtdspcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtdspcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtdspcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtdspcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtdspcBtr.LocateVtdSpc (pVtdSpc:word):boolean;
begin
  SetIndex (ixVtdSpc);
  Result := oBtrTable.FindKey([pVtdSpc]);
end;

function TVtdspcBtr.NearestVtdSpc (pVtdSpc:word):boolean;
begin
  SetIndex (ixVtdSpc);
  Result := oBtrTable.FindNearest([pVtdSpc]);
end;

procedure TVtdspcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtdspcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TVtdspcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtdspcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtdspcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtdspcBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtdspcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtdspcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtdspcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtdspcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtdspcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtdspcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtdspcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtdspcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtdspcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtdspcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtdspcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
