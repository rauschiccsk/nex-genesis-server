unit bDIRMOD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCnMn = 'CnMn';
  ixCntNum = 'CntNum';

type
  TDirmodBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:longint;        procedure WriteCntNum (pValue:longint);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDes:Str250;         procedure WriteModDes (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCnMn (pCntNum:longint;pModNum:word):boolean;
    function LocateCntNum (pCntNum:longint):boolean;
    function NearestCnMn (pCntNum:longint;pModNum:word):boolean;
    function NearestCntNum (pCntNum:longint):boolean;

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
    property CntNum:longint read ReadCntNum write WriteCntNum;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDes:Str250 read ReadModDes write WriteModDes;
  end;

implementation

constructor TDirmodBtr.Create;
begin
  oBtrTable := BtrInit ('DIRMOD',gPath.DlsPath,Self);
end;

constructor TDirmodBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIRMOD',pPath,Self);
end;

destructor TDirmodBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirmodBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirmodBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirmodBtr.ReadCntNum:longint;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirmodBtr.WriteCntNum(pValue:longint);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirmodBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TDirmodBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TDirmodBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirmodBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirmodBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirmodBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TDirmodBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirmodBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirmodBtr.ReadModDes:Str250;
begin
  Result := oBtrTable.FieldByName('ModDes').AsString;
end;

procedure TDirmodBtr.WriteModDes(pValue:Str250);
begin
  oBtrTable.FieldByName('ModDes').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirmodBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirmodBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirmodBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirmodBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirmodBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirmodBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirmodBtr.LocateCnMn (pCntNum:longint;pModNum:word):boolean;
begin
  SetIndex (ixCnMn);
  Result := oBtrTable.FindKey([pCntNum,pModNum]);
end;

function TDirmodBtr.LocateCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDirmodBtr.NearestCnMn (pCntNum:longint;pModNum:word):boolean;
begin
  SetIndex (ixCnMn);
  Result := oBtrTable.FindNearest([pCntNum,pModNum]);
end;

function TDirmodBtr.NearestCntNum (pCntNum:longint):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDirmodBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirmodBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirmodBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirmodBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirmodBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirmodBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirmodBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirmodBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirmodBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirmodBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirmodBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirmodBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirmodBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirmodBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirmodBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirmodBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirmodBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
