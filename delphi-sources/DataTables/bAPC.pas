unit bAPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixCnName = 'CnName';

type
  TApcBtr = class (TComponent)
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
    function  ReadCnName:Str40;          procedure WriteCnName (pValue:Str40);
    function  ReadCnName_:Str40;         procedure WriteCnName_ (pValue:Str40);
    function  ReadWrkFnc:Str30;          procedure WriteWrkFnc (pValue:Str30);
    function  ReadWrkMob:Str20;          procedure WriteWrkMob (pValue:Str20);
    function  ReadWrkTel:Str20;          procedure WriteWrkTel (pValue:Str20);
    function  ReadWrkEml:Str40;          procedure WriteWrkEml (pValue:Str40);
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
    function LocateCnName (pCnName_:Str40):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestCnName (pCnName_:Str40):boolean;

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
    property CnName:Str40 read ReadCnName write WriteCnName;
    property CnName_:Str40 read ReadCnName_ write WriteCnName_;
    property WrkFnc:Str30 read ReadWrkFnc write WriteWrkFnc;
    property WrkMob:Str20 read ReadWrkMob write WriteWrkMob;
    property WrkTel:Str20 read ReadWrkTel write WriteWrkTel;
    property WrkEml:Str40 read ReadWrkEml write WriteWrkEml;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TApcBtr.Create;
begin
  oBtrTable := BtrInit ('APC',gPath.DlsPath,Self);
end;

constructor TApcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APC',pPath,Self);
end;

destructor TApcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TApcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TApcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TApcBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TApcBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TApcBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TApcBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TApcBtr.ReadCnName:Str40;
begin
  Result := oBtrTable.FieldByName('CnName').AsString;
end;

procedure TApcBtr.WriteCnName(pValue:Str40);
begin
  oBtrTable.FieldByName('CnName').AsString := pValue;
end;

function TApcBtr.ReadCnName_:Str40;
begin
  Result := oBtrTable.FieldByName('CnName_').AsString;
end;

procedure TApcBtr.WriteCnName_(pValue:Str40);
begin
  oBtrTable.FieldByName('CnName_').AsString := pValue;
end;

function TApcBtr.ReadWrkFnc:Str30;
begin
  Result := oBtrTable.FieldByName('WrkFnc').AsString;
end;

procedure TApcBtr.WriteWrkFnc(pValue:Str30);
begin
  oBtrTable.FieldByName('WrkFnc').AsString := pValue;
end;

function TApcBtr.ReadWrkMob:Str20;
begin
  Result := oBtrTable.FieldByName('WrkMob').AsString;
end;

procedure TApcBtr.WriteWrkMob(pValue:Str20);
begin
  oBtrTable.FieldByName('WrkMob').AsString := pValue;
end;

function TApcBtr.ReadWrkTel:Str20;
begin
  Result := oBtrTable.FieldByName('WrkTel').AsString;
end;

procedure TApcBtr.WriteWrkTel(pValue:Str20);
begin
  oBtrTable.FieldByName('WrkTel').AsString := pValue;
end;

function TApcBtr.ReadWrkEml:Str40;
begin
  Result := oBtrTable.FieldByName('WrkEml').AsString;
end;

procedure TApcBtr.WriteWrkEml(pValue:Str40);
begin
  oBtrTable.FieldByName('WrkEml').AsString := pValue;
end;

function TApcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TApcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TApcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TApcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TApcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TApcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TApcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TApcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TApcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TApcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TApcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TApcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TApcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TApcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TApcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TApcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TApcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TApcBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TApcBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TApcBtr.LocateCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oBtrTable.FindKey([StrToAlias(pCnName_)]);
end;

function TApcBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TApcBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TApcBtr.NearestCnName (pCnName_:Str40):boolean;
begin
  SetIndex (ixCnName);
  Result := oBtrTable.FindNearest([pCnName_]);
end;

procedure TApcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TApcBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TApcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TApcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TApcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TApcBtr.First;
begin
  oBtrTable.First;
end;

procedure TApcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TApcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TApcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TApcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TApcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TApcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TApcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TApcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TApcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TApcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TApcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
