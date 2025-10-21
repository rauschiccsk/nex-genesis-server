unit bORDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCuDnOn = 'CuDnOn';
  ixDnOn = 'DnOn';
  ixDskName = 'DskName';
  ixOrdName = 'OrdName';

type
  TOrdlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCasUsi:Str20;          procedure WriteCasUsi (pValue:Str20);
    function  ReadDskName:Str15;         procedure WriteDskName (pValue:Str15);
    function  ReadOrdName:Str15;         procedure WriteOrdName (pValue:Str15);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadCasUsr:Str20;          procedure WriteCasUsr (pValue:Str20);
    function  ReadOrdDesc:Str30;         procedure WriteOrdDesc (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
    function LocateDnOn (pDskname:Str15;pOrdName:Str15):boolean;
    function LocateDskName (pDskName:Str15):boolean;
    function LocateOrdName (pOrdName:Str15):boolean;
    function NearestCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
    function NearestDnOn (pDskname:Str15;pOrdName:Str15):boolean;
    function NearestDskName (pDskName:Str15):boolean;
    function NearestOrdName (pOrdName:Str15):boolean;

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
    property CasUsi:Str20 read ReadCasUsi write WriteCasUsi;
    property DskName:Str15 read ReadDskName write WriteDskName;
    property OrdName:Str15 read ReadOrdName write WriteOrdName;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property CasUsr:Str20 read ReadCasUsr write WriteCasUsr;
    property OrdDesc:Str30 read ReadOrdDesc write WriteOrdDesc;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TOrdlstBtr.Create;
begin
  oBtrTable := BtrInit ('ORDLST',gPath.CabPath,Self);
end;

constructor TOrdlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ORDLST',pPath,Self);
end;

destructor TOrdlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOrdlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOrdlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOrdlstBtr.ReadCasUsi:Str20;
begin
  Result := oBtrTable.FieldByName('CasUsi').AsString;
end;

procedure TOrdlstBtr.WriteCasUsi(pValue:Str20);
begin
  oBtrTable.FieldByName('CasUsi').AsString := pValue;
end;

function TOrdlstBtr.ReadDskName:Str15;
begin
  Result := oBtrTable.FieldByName('DskName').AsString;
end;

procedure TOrdlstBtr.WriteDskName(pValue:Str15);
begin
  oBtrTable.FieldByName('DskName').AsString := pValue;
end;

function TOrdlstBtr.ReadOrdName:Str15;
begin
  Result := oBtrTable.FieldByName('OrdName').AsString;
end;

procedure TOrdlstBtr.WriteOrdName(pValue:Str15);
begin
  oBtrTable.FieldByName('OrdName').AsString := pValue;
end;

function TOrdlstBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TOrdlstBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TOrdlstBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TOrdlstBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TOrdlstBtr.ReadCasUsr:Str20;
begin
  Result := oBtrTable.FieldByName('CasUsr').AsString;
end;

procedure TOrdlstBtr.WriteCasUsr(pValue:Str20);
begin
  oBtrTable.FieldByName('CasUsr').AsString := pValue;
end;

function TOrdlstBtr.ReadOrdDesc:Str30;
begin
  Result := oBtrTable.FieldByName('OrdDesc').AsString;
end;

procedure TOrdlstBtr.WriteOrdDesc(pValue:Str30);
begin
  oBtrTable.FieldByName('OrdDesc').AsString := pValue;
end;

function TOrdlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOrdlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOrdlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOrdlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOrdlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOrdlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TOrdlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TOrdlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TOrdlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TOrdlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TOrdlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TOrdlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOrdlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOrdlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOrdlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOrdlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOrdlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOrdlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOrdlstBtr.LocateCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixCuDnOn);
  Result := oBtrTable.FindKey([pCasUsi,pDskname,pOrdName]);
end;

function TOrdlstBtr.LocateDnOn (pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixDnOn);
  Result := oBtrTable.FindKey([pDskname,pOrdName]);
end;

function TOrdlstBtr.LocateDskName (pDskName:Str15):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindKey([pDskName]);
end;

function TOrdlstBtr.LocateOrdName (pOrdName:Str15):boolean;
begin
  SetIndex (ixOrdName);
  Result := oBtrTable.FindKey([pOrdName]);
end;

function TOrdlstBtr.NearestCuDnOn (pCasUsi:Str20;pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixCuDnOn);
  Result := oBtrTable.FindNearest([pCasUsi,pDskname,pOrdName]);
end;

function TOrdlstBtr.NearestDnOn (pDskname:Str15;pOrdName:Str15):boolean;
begin
  SetIndex (ixDnOn);
  Result := oBtrTable.FindNearest([pDskname,pOrdName]);
end;

function TOrdlstBtr.NearestDskName (pDskName:Str15):boolean;
begin
  SetIndex (ixDskName);
  Result := oBtrTable.FindNearest([pDskName]);
end;

function TOrdlstBtr.NearestOrdName (pOrdName:Str15):boolean;
begin
  SetIndex (ixOrdName);
  Result := oBtrTable.FindNearest([pOrdName]);
end;

procedure TOrdlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOrdlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TOrdlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOrdlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOrdlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOrdlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TOrdlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOrdlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOrdlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOrdlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOrdlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOrdlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOrdlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOrdlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOrdlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOrdlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOrdlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
