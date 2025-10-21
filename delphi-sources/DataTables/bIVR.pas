unit bIVR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixIlPoGs = 'IlPoGs';
  ixGsCode = 'GsCode';

type
  TIvrBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oIvdNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadIvlNum:word;           procedure WriteIvlNum (pValue:word);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadIvFase:byte;           procedure WriteIvFase (pValue:byte);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadSrCode:Str15;          procedure WriteSrCode (pValue:Str15);
    function  ReadBefQnt:double;         procedure WriteBefQnt (pValue:double);
    function  ReadInvQnt:double;         procedure WriteInvQnt (pValue:double);
    function  ReadCrtUser:str8;          procedure WriteCrtUser (pValue:str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function NearestIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pIvdNum:integer);
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
    property IvlNum:word read ReadIvlNum write WriteIvlNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property IvFase:byte read ReadIvFase write WriteIvFase;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property SrCode:Str15 read ReadSrCode write WriteSrCode;
    property BefQnt:double read ReadBefQnt write WriteBefQnt;
    property InvQnt:double read ReadInvQnt write WriteInvQnt;
    property CrtUser:str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property PoCode:Str15 read ReadPoCode write WritePoCode;
  end;

implementation

constructor TIvrBtr.Create;
begin
  oBtrTable := BtrInit ('IVR',gPath.StkPath,Self);
end;

constructor TIvrBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IVR',pPath,Self);
end;

destructor TIvrBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIvrBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIvrBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIvrBtr.ReadIvlNum:word;
begin
  Result := oBtrTable.FieldByName('IvlNum').AsInteger;
end;

procedure TIvrBtr.WriteIvlNum(pValue:word);
begin
  oBtrTable.FieldByName('IvlNum').AsInteger := pValue;
end;

function TIvrBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIvrBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIvrBtr.ReadIvFase:byte;
begin
  Result := oBtrTable.FieldByName('IvFase').AsInteger;
end;

procedure TIvrBtr.WriteIvFase(pValue:byte);
begin
  oBtrTable.FieldByName('IvFase').AsInteger := pValue;
end;

function TIvrBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TIvrBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIvrBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TIvrBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TIvrBtr.ReadSrCode:Str15;
begin
  Result := oBtrTable.FieldByName('SrCode').AsString;
end;

procedure TIvrBtr.WriteSrCode(pValue:Str15);
begin
  oBtrTable.FieldByName('SrCode').AsString := pValue;
end;

function TIvrBtr.ReadBefQnt:double;
begin
  Result := oBtrTable.FieldByName('BefQnt').AsFloat;
end;

procedure TIvrBtr.WriteBefQnt(pValue:double);
begin
  oBtrTable.FieldByName('BefQnt').AsFloat := pValue;
end;

function TIvrBtr.ReadInvQnt:double;
begin
  Result := oBtrTable.FieldByName('InvQnt').AsFloat;
end;

procedure TIvrBtr.WriteInvQnt(pValue:double);
begin
  oBtrTable.FieldByName('InvQnt').AsFloat := pValue;
end;

function TIvrBtr.ReadCrtUser:str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIvrBtr.WriteCrtUser(pValue:str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIvrBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIvrBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIvrBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIvrBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIvrBtr.ReadTrmNum:word;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TIvrBtr.WriteTrmNum(pValue:word);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TIvrBtr.ReadPoCode:Str15;
begin
  Result := oBtrTable.FieldByName('PoCode').AsString;
end;

procedure TIvrBtr.WritePoCode(pValue:Str15);
begin
  oBtrTable.FieldByName('PoCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIvrBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvrBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIvrBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIvrBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIvrBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIvrBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIvrBtr.LocateIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixIlPoGs);
  Result := oBtrTable.FindKey([pIvlNum,pPoCode,pGsCode]);
end;

function TIvrBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TIvrBtr.NearestIlPoGs (pIvlNum:word;pPoCode:Str15;pGsCode:longint):boolean;
begin
  SetIndex (ixIlPoGs);
  Result := oBtrTable.FindNearest([pIvlNum,pPoCode,pGsCode]);
end;

function TIvrBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

procedure TIvrBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIvrBtr.Open(pIvdNum:integer);
begin
  oIvdNum := pIvdNum;
  oBtrTable.Open(pIvdNum);
end;

procedure TIvrBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIvrBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIvrBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIvrBtr.First;
begin
  oBtrTable.First;
end;

procedure TIvrBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIvrBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIvrBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIvrBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIvrBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIvrBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIvrBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIvrBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIvrBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIvrBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIvrBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
