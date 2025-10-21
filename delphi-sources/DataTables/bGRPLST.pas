unit bGRPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpTyp = 'GrpTyp';
  ixGtGn = 'GtGn';

type
  TGrplstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpTyp:Str3;           procedure WriteGrpTyp (pValue:Str3);
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadGrpName:Str30;         procedure WriteGrpName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
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
    function LocateGrpTyp (pGrpTyp:Str3):boolean;
    function LocateGtGn (pGrpTyp:Str3;pGrpNum:word):boolean;
    function NearestGrpTyp (pGrpTyp:Str3):boolean;
    function NearestGtGn (pGrpTyp:Str3;pGrpNum:word):boolean;

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
    property GrpTyp:Str3 read ReadGrpTyp write WriteGrpTyp;
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property GrpName:Str30 read ReadGrpName write WriteGrpName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TGrplstBtr.Create;
begin
  oBtrTable := BtrInit ('GRPLST',gPath.DlsPath,Self);
end;

constructor TGrplstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('GRPLST',pPath,Self);
end;

destructor TGrplstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TGrplstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TGrplstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TGrplstBtr.ReadGrpTyp:Str3;
begin
  Result := oBtrTable.FieldByName('GrpTyp').AsString;
end;

procedure TGrplstBtr.WriteGrpTyp(pValue:Str3);
begin
  oBtrTable.FieldByName('GrpTyp').AsString := pValue;
end;

function TGrplstBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TGrplstBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TGrplstBtr.ReadGrpName:Str30;
begin
  Result := oBtrTable.FieldByName('GrpName').AsString;
end;

procedure TGrplstBtr.WriteGrpName(pValue:Str30);
begin
  oBtrTable.FieldByName('GrpName').AsString := pValue;
end;

function TGrplstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TGrplstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TGrplstBtr.ReadCrtName:Str30;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TGrplstBtr.WriteCrtName(pValue:Str30);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TGrplstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TGrplstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TGrplstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TGrplstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TGrplstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TGrplstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TGrplstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TGrplstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TGrplstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TGrplstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGrplstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGrplstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TGrplstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TGrplstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TGrplstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TGrplstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TGrplstBtr.LocateGrpTyp (pGrpTyp:Str3):boolean;
begin
  SetIndex (ixGrpTyp);
  Result := oBtrTable.FindKey([pGrpTyp]);
end;

function TGrplstBtr.LocateGtGn (pGrpTyp:Str3;pGrpNum:word):boolean;
begin
  SetIndex (ixGtGn);
  Result := oBtrTable.FindKey([pGrpTyp,pGrpNum]);
end;

function TGrplstBtr.NearestGrpTyp (pGrpTyp:Str3):boolean;
begin
  SetIndex (ixGrpTyp);
  Result := oBtrTable.FindNearest([pGrpTyp]);
end;

function TGrplstBtr.NearestGtGn (pGrpTyp:Str3;pGrpNum:word):boolean;
begin
  SetIndex (ixGtGn);
  Result := oBtrTable.FindNearest([pGrpTyp,pGrpNum]);
end;

procedure TGrplstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TGrplstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TGrplstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TGrplstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TGrplstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TGrplstBtr.First;
begin
  oBtrTable.First;
end;

procedure TGrplstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TGrplstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TGrplstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TGrplstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TGrplstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TGrplstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TGrplstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TGrplstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TGrplstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TGrplstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TGrplstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
