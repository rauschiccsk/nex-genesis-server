unit bGSCIMG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixSended = 'Sended';

type
  TGscimgBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadImgName:Str18;         procedure WriteImgName (pValue:Str18);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ImgName:Str18 read ReadImgName write WriteImgName;
    property Sended:boolean read ReadSended write WriteSended;
  end;

implementation

constructor TGscimgBtr.Create;
begin
  oBtrTable := BtrInit ('GSCIMG',gPath.StkPath,Self);
end;

constructor TGscimgBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSCIMG',pPath,Self);
end;

destructor TGscimgBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGscimgBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGscimgBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGscimgBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TGscimgBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGscimgBtr.ReadImgName:Str18;
begin
  Result := oBtrTable.FieldByName('ImgName').AsString;
end;

procedure TGscimgBtr.WriteImgName(pValue:Str18);
begin
  oBtrTable.FieldByName('ImgName').AsString := pValue;
end;

function TGscimgBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TGscimgBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

// **************************************** PUBLIC ********************************************

function TGscimgBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscimgBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGscimgBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscimgBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGscimgBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGscimgBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGscimgBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TGscimgBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TGscimgBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TGscimgBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TGscimgBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGscimgBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGscimgBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGscimgBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGscimgBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGscimgBtr.First;
begin
  oBtrTable.First;
end;

procedure TGscimgBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGscimgBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGscimgBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGscimgBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGscimgBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGscimgBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGscimgBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGscimgBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGscimgBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGscimgBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGscimgBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
