unit bGSCBAS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBaCode = 'BaCode';
  ixSpCode = 'SpCode';

type
  TGscbasBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBaCode:Str15;          procedure WriteBaCode (pValue:Str15);
    function  ReadSpCode:Str30;          procedure WriteSpCode (pValue:Str30);
    function  ReadGsName:Str60;          procedure WriteGsName (pValue:Str60);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsType:Str1;           procedure WriteGsType (pValue:Str1);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadVolume:double;         procedure WriteVolume (pValue:double);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBaCode (pBaCode:Str15):boolean;
    function LocateSpCode (pSpCode:Str30):boolean;
    function NearestBaCode (pBaCode:Str15):boolean;
    function NearestSpCode (pSpCode:Str30):boolean;

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
    property BaCode:Str15 read ReadBaCode write WriteBaCode;
    property SpCode:Str30 read ReadSpCode write WriteSpCode;
    property GsName:Str60 read ReadGsName write WriteGsName;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsType:Str1 read ReadGsType write WriteGsType;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property Volume:double read ReadVolume write WriteVolume;
    property Weight:double read ReadWeight write WriteWeight;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TGscbasBtr.Create;
begin
  oBtrTable := BtrInit ('GSCBAS',gPath.StkPath,Self);
end;

constructor TGscbasBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GSCBAS',pPath,Self);
end;

destructor TGscbasBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGscbasBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGscbasBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGscbasBtr.ReadBaCode:Str15;
begin
  Result := oBtrTable.FieldByName('BaCode').AsString;
end;

procedure TGscbasBtr.WriteBaCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BaCode').AsString := pValue;
end;

function TGscbasBtr.ReadSpCode:Str30;
begin
  Result := oBtrTable.FieldByName('SpCode').AsString;
end;

procedure TGscbasBtr.WriteSpCode(pValue:Str30);
begin
  oBtrTable.FieldByName('SpCode').AsString := pValue;
end;

function TGscbasBtr.ReadGsName:Str60;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TGscbasBtr.WriteGsName(pValue:Str60);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TGscbasBtr.ReadMgCode:longint;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TGscbasBtr.WriteMgCode(pValue:longint);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TGscbasBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TGscbasBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TGscbasBtr.ReadGsType:Str1;
begin
  Result := oBtrTable.FieldByName('GsType').AsString;
end;

procedure TGscbasBtr.WriteGsType(pValue:Str1);
begin
  oBtrTable.FieldByName('GsType').AsString := pValue;
end;

function TGscbasBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TGscbasBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TGscbasBtr.ReadVolume:double;
begin
  Result := oBtrTable.FieldByName('Volume').AsFloat;
end;

procedure TGscbasBtr.WriteVolume(pValue:double);
begin
  oBtrTable.FieldByName('Volume').AsFloat := pValue;
end;

function TGscbasBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TGscbasBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TGscbasBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TGscbasBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGscbasBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGscbasBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGscbasBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGscbasBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGscbasBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscbasBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGscbasBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGscbasBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGscbasBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGscbasBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGscbasBtr.LocateBaCode (pBaCode:Str15):boolean;
begin
  SetIndex (ixBaCode);
  Result := oBtrTable.FindKey([pBaCode]);
end;

function TGscbasBtr.LocateSpCode (pSpCode:Str30):boolean;
begin
  SetIndex (ixSpCode);
  Result := oBtrTable.FindKey([pSpCode]);
end;

function TGscbasBtr.NearestBaCode (pBaCode:Str15):boolean;
begin
  SetIndex (ixBaCode);
  Result := oBtrTable.FindNearest([pBaCode]);
end;

function TGscbasBtr.NearestSpCode (pSpCode:Str30):boolean;
begin
  SetIndex (ixSpCode);
  Result := oBtrTable.FindNearest([pSpCode]);
end;

procedure TGscbasBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGscbasBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGscbasBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGscbasBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGscbasBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGscbasBtr.First;
begin
  oBtrTable.First;
end;

procedure TGscbasBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGscbasBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGscbasBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGscbasBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGscbasBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGscbasBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGscbasBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGscbasBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGscbasBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGscbasBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGscbasBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
