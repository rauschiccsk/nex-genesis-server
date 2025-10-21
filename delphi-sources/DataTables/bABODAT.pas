unit bABODAT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAtLn = 'AtLn';

type
  TAbodatBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAboType:Str10;         procedure WriteAboType (pValue:Str10);
    function  ReadLgnName:Str8;          procedure WriteLgnName (pValue:Str8);
    function  ReadUsrName:Str30;         procedure WriteUsrName (pValue:Str30);
    function  ReadUsrName_:Str30;        procedure WriteUsrName_ (pValue:Str30);
    function  ReadClientId:Str20;        procedure WriteClientId (pValue:Str20);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateAtLn (pAboType:Str10;pLgnName:Str8):boolean;
    function NearestAtLn (pAboType:Str10;pLgnName:Str8):boolean;

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
    property AboType:Str10 read ReadAboType write WriteAboType;
    property LgnName:Str8 read ReadLgnName write WriteLgnName;
    property UsrName:Str30 read ReadUsrName write WriteUsrName;
    property UsrName_:Str30 read ReadUsrName_ write WriteUsrName_;
    property ClientId:Str20 read ReadClientId write WriteClientId;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAbodatBtr.Create;
begin
  oBtrTable := BtrInit ('ABODAT',gPath.LdgPath,Self);
end;

constructor TAbodatBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ABODAT',pPath,Self);
end;

destructor TAbodatBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAbodatBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAbodatBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAbodatBtr.ReadAboType:Str10;
begin
  Result := oBtrTable.FieldByName('AboType').AsString;
end;

procedure TAbodatBtr.WriteAboType(pValue:Str10);
begin
  oBtrTable.FieldByName('AboType').AsString := pValue;
end;

function TAbodatBtr.ReadLgnName:Str8;
begin
  Result := oBtrTable.FieldByName('LgnName').AsString;
end;

procedure TAbodatBtr.WriteLgnName(pValue:Str8);
begin
  oBtrTable.FieldByName('LgnName').AsString := pValue;
end;

function TAbodatBtr.ReadUsrName:Str30;
begin
  Result := oBtrTable.FieldByName('UsrName').AsString;
end;

procedure TAbodatBtr.WriteUsrName(pValue:Str30);
begin
  oBtrTable.FieldByName('UsrName').AsString := pValue;
end;

function TAbodatBtr.ReadUsrName_:Str30;
begin
  Result := oBtrTable.FieldByName('UsrName_').AsString;
end;

procedure TAbodatBtr.WriteUsrName_(pValue:Str30);
begin
  oBtrTable.FieldByName('UsrName_').AsString := pValue;
end;

function TAbodatBtr.ReadClientId:Str20;
begin
  Result := oBtrTable.FieldByName('ClientId').AsString;
end;

procedure TAbodatBtr.WriteClientId(pValue:Str20);
begin
  oBtrTable.FieldByName('ClientId').AsString := pValue;
end;

function TAbodatBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAbodatBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAbodatBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAbodatBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAbodatBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAbodatBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAbodatBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAbodatBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAbodatBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAbodatBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAbodatBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAbodatBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAbodatBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAbodatBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAbodatBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbodatBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAbodatBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbodatBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAbodatBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAbodatBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAbodatBtr.LocateAtLn (pAboType:Str10;pLgnName:Str8):boolean;
begin
  SetIndex (ixAtLn);
  Result := oBtrTable.FindKey([pAboType,pLgnName]);
end;

function TAbodatBtr.NearestAtLn (pAboType:Str10;pLgnName:Str8):boolean;
begin
  SetIndex (ixAtLn);
  Result := oBtrTable.FindNearest([pAboType,pLgnName]);
end;

procedure TAbodatBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAbodatBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAbodatBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAbodatBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAbodatBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAbodatBtr.First;
begin
  oBtrTable.First;
end;

procedure TAbodatBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAbodatBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAbodatBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAbodatBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAbodatBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAbodatBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAbodatBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAbodatBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAbodatBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAbodatBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAbodatBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
