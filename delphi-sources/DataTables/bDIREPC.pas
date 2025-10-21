unit bDIREPC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpcNum = 'EpcNum';
  ixCntNum = 'CntNum';

type
  TDirepcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCntNum:word;           procedure WriteCntNum (pValue:word);
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpcName:Str30;         procedure WriteEpcName (pValue:Str30);
    function  ReadUsrLev:byte;           procedure WriteUsrLev (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
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
    function LocateEpcNum (pCntNum:word;pEpcNum:word):boolean;
    function LocateCntNum (pCntNum:word):boolean;
    function NearestEpcNum (pCntNum:word;pEpcNum:word):boolean;
    function NearestCntNum (pCntNum:word):boolean;

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
    property CntNum:word read ReadCntNum write WriteCntNum;
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpcName:Str30 read ReadEpcName write WriteEpcName;
    property UsrLev:byte read ReadUsrLev write WriteUsrLev;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TDirepcBtr.Create;
begin
  oBtrTable := BtrInit ('DIREPC',gPath.DlsPath,Self);
end;

constructor TDirepcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('DIREPC',pPath,Self);
end;

destructor TDirepcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TDirepcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TDirepcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TDirepcBtr.ReadCntNum:word;
begin
  Result := oBtrTable.FieldByName('CntNum').AsInteger;
end;

procedure TDirepcBtr.WriteCntNum(pValue:word);
begin
  oBtrTable.FieldByName('CntNum').AsInteger := pValue;
end;

function TDirepcBtr.ReadEpcNum:word;
begin
  Result := oBtrTable.FieldByName('EpcNum').AsInteger;
end;

procedure TDirepcBtr.WriteEpcNum(pValue:word);
begin
  oBtrTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TDirepcBtr.ReadEpcName:Str30;
begin
  Result := oBtrTable.FieldByName('EpcName').AsString;
end;

procedure TDirepcBtr.WriteEpcName(pValue:Str30);
begin
  oBtrTable.FieldByName('EpcName').AsString := pValue;
end;

function TDirepcBtr.ReadUsrLev:byte;
begin
  Result := oBtrTable.FieldByName('UsrLev').AsInteger;
end;

procedure TDirepcBtr.WriteUsrLev(pValue:byte);
begin
  oBtrTable.FieldByName('UsrLev').AsInteger := pValue;
end;

function TDirepcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TDirepcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TDirepcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TDirepcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TDirepcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TDirepcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TDirepcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TDirepcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TDirepcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TDirepcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TDirepcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TDirepcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDirepcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirepcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TDirepcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TDirepcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TDirepcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TDirepcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TDirepcBtr.LocateEpcNum (pCntNum:word;pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oBtrTable.FindKey([pCntNum,pEpcNum]);
end;

function TDirepcBtr.LocateCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindKey([pCntNum]);
end;

function TDirepcBtr.NearestEpcNum (pCntNum:word;pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oBtrTable.FindNearest([pCntNum,pEpcNum]);
end;

function TDirepcBtr.NearestCntNum (pCntNum:word):boolean;
begin
  SetIndex (ixCntNum);
  Result := oBtrTable.FindNearest([pCntNum]);
end;

procedure TDirepcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TDirepcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TDirepcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TDirepcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TDirepcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TDirepcBtr.First;
begin
  oBtrTable.First;
end;

procedure TDirepcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TDirepcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TDirepcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TDirepcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TDirepcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TDirepcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TDirepcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TDirepcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TDirepcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TDirepcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TDirepcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
