unit bDLVSUR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = 'DoIt';
  ixDocDate = 'DocDate';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';

type
  TDlvsurBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str50;          procedure WriteGsName (pValue:Str50);
    function  ReadGsName_:Str50;         procedure WriteGsName_ (pValue:Str50);
    function  ReadOrdQnt:double;         procedure WriteOrdQnt (pValue:double);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
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
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str50):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str50):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str50 read ReadGsName write WriteGsName;
    property GsName_:Str50 read ReadGsName_ write WriteGsName_;
    property OrdQnt:double read ReadOrdQnt write WriteOrdQnt;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TDlvsurBtr.Create;
begin
  oBtrTable := BtrInit ('DLVSUR',gPath.StkPath,Self);
end;

constructor TDlvsurBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DLVSUR',pPath,Self);
end;

destructor TDlvsurBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDlvsurBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDlvsurBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDlvsurBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TDlvsurBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TDlvsurBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TDlvsurBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TDlvsurBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TDlvsurBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TDlvsurBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TDlvsurBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TDlvsurBtr.ReadGsName:Str50;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TDlvsurBtr.WriteGsName(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TDlvsurBtr.ReadGsName_:Str50;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TDlvsurBtr.WriteGsName_(pValue:Str50);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TDlvsurBtr.ReadOrdQnt:double;
begin
  Result := oBtrTable.FieldByName('OrdQnt').AsFloat;
end;

procedure TDlvsurBtr.WriteOrdQnt(pValue:double);
begin
  oBtrTable.FieldByName('OrdQnt').AsFloat := pValue;
end;

function TDlvsurBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TDlvsurBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TDlvsurBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDlvsurBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDlvsurBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDlvsurBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDlvsurBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDlvsurBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDlvsurBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlvsurBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDlvsurBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDlvsurBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDlvsurBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDlvsurBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDlvsurBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TDlvsurBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TDlvsurBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TDlvsurBtr.LocateGsName (pGsName_:Str50):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TDlvsurBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TDlvsurBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TDlvsurBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TDlvsurBtr.NearestGsName (pGsName_:Str50):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

procedure TDlvsurBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDlvsurBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDlvsurBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDlvsurBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDlvsurBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDlvsurBtr.First;
begin
  oBtrTable.First;
end;

procedure TDlvsurBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDlvsurBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDlvsurBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDlvsurBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDlvsurBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDlvsurBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDlvsurBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDlvsurBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDlvsurBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDlvsurBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDlvsurBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
