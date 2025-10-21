unit bTIP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixDoGc = 'DoGc';
  ixDoPc = 'DoPc';
  ixDoGcPc = 'DoGcPc';

type
  TTipBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadPosCode:Str15;         procedure WritePosCode (pValue:Str15);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
    function LocateDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoGc (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
    function NearestDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property PosCode:Str15 read ReadPosCode write WritePosCode;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTipBtr.Create;
begin
  oBtrTable := BtrInit ('TIP',gPath.StkPath,Self);
end;

constructor TTipBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TIP',pPath,Self);
end;

destructor TTipBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTipBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTipBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTipBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTipBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTipBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTipBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTipBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTipBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTipBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TTipBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TTipBtr.ReadPosCode:Str15;
begin
  Result := oBtrTable.FieldByName('PosCode').AsString;
end;

procedure TTipBtr.WritePosCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PosCode').AsString := pValue;
end;

function TTipBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TTipBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TTipBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTipBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTipBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTipBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTipBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTipBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTipBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTipBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTipBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTipBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTipBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTipBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTipBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTipBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTipBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTipBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTipBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTipBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTipBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTipBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTipBtr.LocateDoGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TTipBtr.LocateDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoPc);
  Result := oBtrTable.FindKey([pDocNum,pPosCode]);
end;

function TTipBtr.LocateDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoGcPc);
  Result := oBtrTable.FindKey([pDocNum,pGsCode,pPosCode]);
end;

function TTipBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TTipBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TTipBtr.NearestDoGc (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

function TTipBtr.NearestDoPc (pDocNum:Str12;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoPc);
  Result := oBtrTable.FindNearest([pDocNum,pPosCode]);
end;

function TTipBtr.NearestDoGcPc (pDocNum:Str12;pGsCode:longint;pPosCode:Str15):boolean;
begin
  SetIndex (ixDoGcPc);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode,pPosCode]);
end;

procedure TTipBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTipBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTipBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTipBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTipBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTipBtr.First;
begin
  oBtrTable.First;
end;

procedure TTipBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTipBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTipBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTipBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTipBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTipBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTipBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTipBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTipBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTipBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTipBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
