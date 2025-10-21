unit bPXI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixPmfCod = 'PmfCod';

type
  TPxiBtr = class (TComponent)
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
    function  ReadPmfCod:Str3;           procedure WritePmfCod (pValue:Str3);
    function  ReadPmfName:Str60;         procedure WritePmfName (pValue:Str60);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
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
    function LocatePmfCod (pPmfCod:Str3):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestPmfCod (pPmfCod:Str3):boolean;

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
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property PmfCod:Str3 read ReadPmfCod write WritePmfCod;
    property PmfName:Str60 read ReadPmfName write WritePmfName;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPxiBtr.Create;
begin
  oBtrTable := BtrInit ('PXI',gPath.DlsPath,Self);
end;

constructor TPxiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PXI',pPath,Self);
end;

destructor TPxiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPxiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPxiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPxiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPxiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPxiBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPxiBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPxiBtr.ReadPmfCod:Str3;
begin
  Result := oBtrTable.FieldByName('PmfCod').AsString;
end;

procedure TPxiBtr.WritePmfCod(pValue:Str3);
begin
  oBtrTable.FieldByName('PmfCod').AsString := pValue;
end;

function TPxiBtr.ReadPmfName:Str60;
begin
  Result := oBtrTable.FieldByName('PmfName').AsString;
end;

procedure TPxiBtr.WritePmfName(pValue:Str60);
begin
  oBtrTable.FieldByName('PmfName').AsString := pValue;
end;

function TPxiBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TPxiBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TPxiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPxiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPxiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPxiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPxiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPxiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPxiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPxiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPxiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPxiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPxiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPxiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPxiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPxiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPxiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPxiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPxiBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPxiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPxiBtr.LocatePmfCod (pPmfCod:Str3):boolean;
begin
  SetIndex (ixPmfCod);
  Result := oBtrTable.FindKey([pPmfCod]);
end;

function TPxiBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TPxiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPxiBtr.NearestPmfCod (pPmfCod:Str3):boolean;
begin
  SetIndex (ixPmfCod);
  Result := oBtrTable.FindNearest([pPmfCod]);
end;

procedure TPxiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPxiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPxiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPxiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPxiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPxiBtr.First;
begin
  oBtrTable.First;
end;

procedure TPxiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPxiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPxiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPxiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPxiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPxiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPxiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPxiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPxiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPxiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPxiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1905014}
