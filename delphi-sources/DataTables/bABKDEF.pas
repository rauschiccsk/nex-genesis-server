unit bABKDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrpNum = 'GrpNum';
  ixGrPm = 'GrPm';
  ixGrPmBn = 'GrPmBn';

type
  TAbkdefBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGrpNum:word;           procedure WriteGrpNum (pValue:word);
    function  ReadPmdMark:Str6;          procedure WritePmdMark (pValue:Str6);
    function  ReadBookNum:Str5;          procedure WriteBookNum (pValue:Str5);
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
    function LocateGrpNum (pGrpNum:word):boolean;
    function LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
    function LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
    function NearestGrpNum (pGrpNum:word):boolean;
    function NearestGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
    function NearestGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;

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
    property GrpNum:word read ReadGrpNum write WriteGrpNum;
    property PmdMark:Str6 read ReadPmdMark write WritePmdMark;
    property BookNum:Str5 read ReadBookNum write WriteBookNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAbkdefBtr.Create;
begin
  oBtrTable := BtrInit ('ABKDEF',gPath.SysPath,Self);
end;

constructor TAbkdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ABKDEF',pPath,Self);
end;

destructor TAbkdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAbkdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAbkdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAbkdefBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TAbkdefBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TAbkdefBtr.ReadPmdMark:Str6;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TAbkdefBtr.WritePmdMark(pValue:Str6);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TAbkdefBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TAbkdefBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TAbkdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAbkdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAbkdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAbkdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAbkdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAbkdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAbkdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbkdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAbkdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAbkdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAbkdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAbkdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAbkdefBtr.LocateGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindKey([pGrpNum]);
end;

function TAbkdefBtr.LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindKey([pGrpNum,pPmdMark]);
end;

function TAbkdefBtr.LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  SetIndex (ixGrPmBn);
  Result := oBtrTable.FindKey([pGrpNum,pPmdMark,pBookNum]);
end;

function TAbkdefBtr.NearestGrpNum (pGrpNum:word):boolean;
begin
  SetIndex (ixGrpNum);
  Result := oBtrTable.FindNearest([pGrpNum]);
end;

function TAbkdefBtr.NearestGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindNearest([pGrpNum,pPmdMark]);
end;

function TAbkdefBtr.NearestGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  SetIndex (ixGrPmBn);
  Result := oBtrTable.FindNearest([pGrpNum,pPmdMark,pBookNum]);
end;

procedure TAbkdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAbkdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAbkdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAbkdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAbkdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAbkdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TAbkdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAbkdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAbkdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAbkdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAbkdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAbkdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAbkdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAbkdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAbkdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAbkdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAbkdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
