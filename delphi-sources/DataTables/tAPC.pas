unit tAPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixItmNum = '';

type
  TApcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateItmNum (pItmNum:word):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TApcTmp.Create;
begin
  oTmpTable := TmpInit ('APC',Self);
end;

destructor TApcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TApcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TApcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TApcTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TApcTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TApcTmp.ReadCnName:Str40;
begin
  Result := oTmpTable.FieldByName('CnName').AsString;
end;

procedure TApcTmp.WriteCnName(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName').AsString := pValue;
end;

function TApcTmp.ReadCnName_:Str40;
begin
  Result := oTmpTable.FieldByName('CnName_').AsString;
end;

procedure TApcTmp.WriteCnName_(pValue:Str40);
begin
  oTmpTable.FieldByName('CnName_').AsString := pValue;
end;

function TApcTmp.ReadWrkFnc:Str30;
begin
  Result := oTmpTable.FieldByName('WrkFnc').AsString;
end;

procedure TApcTmp.WriteWrkFnc(pValue:Str30);
begin
  oTmpTable.FieldByName('WrkFnc').AsString := pValue;
end;

function TApcTmp.ReadWrkMob:Str20;
begin
  Result := oTmpTable.FieldByName('WrkMob').AsString;
end;

procedure TApcTmp.WriteWrkMob(pValue:Str20);
begin
  oTmpTable.FieldByName('WrkMob').AsString := pValue;
end;

function TApcTmp.ReadWrkTel:Str20;
begin
  Result := oTmpTable.FieldByName('WrkTel').AsString;
end;

procedure TApcTmp.WriteWrkTel(pValue:Str20);
begin
  oTmpTable.FieldByName('WrkTel').AsString := pValue;
end;

function TApcTmp.ReadWrkEml:Str40;
begin
  Result := oTmpTable.FieldByName('WrkEml').AsString;
end;

procedure TApcTmp.WriteWrkEml(pValue:Str40);
begin
  oTmpTable.FieldByName('WrkEml').AsString := pValue;
end;

function TApcTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TApcTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TApcTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TApcTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TApcTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TApcTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TApcTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TApcTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TApcTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TApcTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TApcTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TApcTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TApcTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TApcTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TApcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TApcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TApcTmp.LocateItmNum (pItmNum:word):boolean;
begin
  SetIndex (ixItmNum);
  Result := oTmpTable.FindKey([pItmNum]);
end;

procedure TApcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TApcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TApcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TApcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TApcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TApcTmp.First;
begin
  oTmpTable.First;
end;

procedure TApcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TApcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TApcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TApcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TApcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TApcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TApcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TApcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TApcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TApcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TApcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
