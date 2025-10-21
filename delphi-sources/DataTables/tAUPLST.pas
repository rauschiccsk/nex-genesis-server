unit tAUPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixApCode = '';

type
  TAuplstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadApCode:longint;        procedure WriteApCode (pValue:longint);
    function  ReadApName:Str30;          procedure WriteApName (pValue:Str30);
    function  ReadIdpNum:Str10;          procedure WriteIdpNum (pValue:Str10);
    function  ReadAutType:Str1;          procedure WriteAutType (pValue:Str1);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
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
    function LocateApCode (pApCode:longint):boolean;

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
    property ApCode:longint read ReadApCode write WriteApCode;
    property ApName:Str30 read ReadApName write WriteApName;
    property IdpNum:Str10 read ReadIdpNum write WriteIdpNum;
    property AutType:Str1 read ReadAutType write WriteAutType;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAuplstTmp.Create;
begin
  oTmpTable := TmpInit ('AUPLST',Self);
end;

destructor TAuplstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAuplstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAuplstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAuplstTmp.ReadApCode:longint;
begin
  Result := oTmpTable.FieldByName('ApCode').AsInteger;
end;

procedure TAuplstTmp.WriteApCode(pValue:longint);
begin
  oTmpTable.FieldByName('ApCode').AsInteger := pValue;
end;

function TAuplstTmp.ReadApName:Str30;
begin
  Result := oTmpTable.FieldByName('ApName').AsString;
end;

procedure TAuplstTmp.WriteApName(pValue:Str30);
begin
  oTmpTable.FieldByName('ApName').AsString := pValue;
end;

function TAuplstTmp.ReadIdpNum:Str10;
begin
  Result := oTmpTable.FieldByName('IdpNum').AsString;
end;

procedure TAuplstTmp.WriteIdpNum(pValue:Str10);
begin
  oTmpTable.FieldByName('IdpNum').AsString := pValue;
end;

function TAuplstTmp.ReadAutType:Str1;
begin
  Result := oTmpTable.FieldByName('AutType').AsString;
end;

procedure TAuplstTmp.WriteAutType(pValue:Str1);
begin
  oTmpTable.FieldByName('AutType').AsString := pValue;
end;

function TAuplstTmp.ReadExpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAuplstTmp.WriteExpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAuplstTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAuplstTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAuplstTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAuplstTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAuplstTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAuplstTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAuplstTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAuplstTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAuplstTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAuplstTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAuplstTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAuplstTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAuplstTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAuplstTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAuplstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAuplstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAuplstTmp.LocateApCode (pApCode:longint):boolean;
begin
  SetIndex (ixApCode);
  Result := oTmpTable.FindKey([pApCode]);
end;

procedure TAuplstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAuplstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAuplstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAuplstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAuplstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAuplstTmp.First;
begin
  oTmpTable.First;
end;

procedure TAuplstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAuplstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAuplstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAuplstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAuplstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAuplstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAuplstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAuplstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAuplstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAuplstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAuplstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1908001}
