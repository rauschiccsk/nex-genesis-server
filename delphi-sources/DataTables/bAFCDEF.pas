unit bAFCDEF;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGrPm = 'GrPm';
  ixGrPmBn = 'GrPmBn';

type
  TAfcdefBtr = class (TComponent)
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
    function  ReadAcsCtrl:Str250;        procedure WriteAcsCtrl (pValue:Str250);
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
    function LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
    function LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
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
    property AcsCtrl:Str250 read ReadAcsCtrl write WriteAcsCtrl;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAfcdefBtr.Create;
begin
  oBtrTable := BtrInit ('AFCDEF',gPath.SysPath,Self);
end;

constructor TAfcdefBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AFCDEF',pPath,Self);
end;

destructor TAfcdefBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAfcdefBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAfcdefBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAfcdefBtr.ReadGrpNum:word;
begin
  Result := oBtrTable.FieldByName('GrpNum').AsInteger;
end;

procedure TAfcdefBtr.WriteGrpNum(pValue:word);
begin
  oBtrTable.FieldByName('GrpNum').AsInteger := pValue;
end;

function TAfcdefBtr.ReadPmdMark:Str6;
begin
  Result := oBtrTable.FieldByName('PmdMark').AsString;
end;

procedure TAfcdefBtr.WritePmdMark(pValue:Str6);
begin
  oBtrTable.FieldByName('PmdMark').AsString := pValue;
end;

function TAfcdefBtr.ReadBookNum:Str5;
begin
  Result := oBtrTable.FieldByName('BookNum').AsString;
end;

procedure TAfcdefBtr.WriteBookNum(pValue:Str5);
begin
  oBtrTable.FieldByName('BookNum').AsString := pValue;
end;

function TAfcdefBtr.ReadAcsCtrl:Str250;
begin
  Result := oBtrTable.FieldByName('AcsCtrl').AsString;
end;

procedure TAfcdefBtr.WriteAcsCtrl(pValue:Str250);
begin
  oBtrTable.FieldByName('AcsCtrl').AsString := pValue;
end;

function TAfcdefBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAfcdefBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAfcdefBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAfcdefBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAfcdefBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAfcdefBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAfcdefBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAfcdefBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAfcdefBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAfcdefBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAfcdefBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAfcdefBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAfcdefBtr.LocateGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindKey([pGrpNum,pPmdMark]);
end;

function TAfcdefBtr.LocateGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  SetIndex (ixGrPmBn);
  Result := oBtrTable.FindKey([pGrpNum,pPmdMark,pBookNum]);
end;

function TAfcdefBtr.NearestGrPm (pGrpNum:word;pPmdMark:Str6):boolean;
begin
  SetIndex (ixGrPm);
  Result := oBtrTable.FindNearest([pGrpNum,pPmdMark]);
end;

function TAfcdefBtr.NearestGrPmBn (pGrpNum:word;pPmdMark:Str6;pBookNum:Str5):boolean;
begin
  SetIndex (ixGrPmBn);
  Result := oBtrTable.FindNearest([pGrpNum,pPmdMark,pBookNum]);
end;

procedure TAfcdefBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAfcdefBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAfcdefBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAfcdefBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAfcdefBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAfcdefBtr.First;
begin
  oBtrTable.First;
end;

procedure TAfcdefBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAfcdefBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAfcdefBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAfcdefBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAfcdefBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAfcdefBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAfcdefBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAfcdefBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAfcdefBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAfcdefBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAfcdefBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
