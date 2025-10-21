unit bXRGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDnRnCN = 'DnRnCN';

type
  TXrglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadColNum:word;           procedure WriteColNum (pValue:word);
    function  ReadBegDat:TDatetime;      procedure WriteBegDat (pValue:TDatetime);
    function  ReadEndDat:TDatetime;      procedure WriteEndDat (pValue:TDatetime);
    function  ReadIdcVal:Str15;          procedure WriteIdcVal (pValue:Str15);
    function  ReadSrcNum:longint;        procedure WriteSrcNum (pValue:longint);
    function  ReadSrcNam:Str60;          procedure WriteSrcNam (pValue:Str60);
    function  ReadValTyp:Str2;           procedure WriteValTyp (pValue:Str2);
    function  ReadClcVal:double;         procedure WriteClcVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDnRnCN (pDocNum:Str12;pRowNum:word;pColNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDnRnCN (pDocNum:Str12;pRowNum:word;pColNum:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property ColNum:word read ReadColNum write WriteColNum;
    property BegDat:TDatetime read ReadBegDat write WriteBegDat;
    property EndDat:TDatetime read ReadEndDat write WriteEndDat;
    property IdcVal:Str15 read ReadIdcVal write WriteIdcVal;
    property SrcNum:longint read ReadSrcNum write WriteSrcNum;
    property SrcNam:Str60 read ReadSrcNam write WriteSrcNam;
    property ValTyp:Str2 read ReadValTyp write WriteValTyp;
    property ClcVal:double read ReadClcVal write WriteClcVal;
  end;

implementation

constructor TXrglstBtr.Create;
begin
  oBtrTable := BtrInit ('XRGLST',gPath.StkPath,Self);
end;

constructor TXrglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('XRGLST',pPath,Self);
end;

destructor TXrglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TXrglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TXrglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TXrglstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TXrglstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TXrglstBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TXrglstBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TXrglstBtr.ReadColNum:word;
begin
  Result := oBtrTable.FieldByName('ColNum').AsInteger;
end;

procedure TXrglstBtr.WriteColNum(pValue:word);
begin
  oBtrTable.FieldByName('ColNum').AsInteger := pValue;
end;

function TXrglstBtr.ReadBegDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDat').AsDateTime;
end;

procedure TXrglstBtr.WriteBegDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDat').AsDateTime := pValue;
end;

function TXrglstBtr.ReadEndDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDat').AsDateTime;
end;

procedure TXrglstBtr.WriteEndDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDat').AsDateTime := pValue;
end;

function TXrglstBtr.ReadIdcVal:Str15;
begin
  Result := oBtrTable.FieldByName('IdcVal').AsString;
end;

procedure TXrglstBtr.WriteIdcVal(pValue:Str15);
begin
  oBtrTable.FieldByName('IdcVal').AsString := pValue;
end;

function TXrglstBtr.ReadSrcNum:longint;
begin
  Result := oBtrTable.FieldByName('SrcNum').AsInteger;
end;

procedure TXrglstBtr.WriteSrcNum(pValue:longint);
begin
  oBtrTable.FieldByName('SrcNum').AsInteger := pValue;
end;

function TXrglstBtr.ReadSrcNam:Str60;
begin
  Result := oBtrTable.FieldByName('SrcNam').AsString;
end;

procedure TXrglstBtr.WriteSrcNam(pValue:Str60);
begin
  oBtrTable.FieldByName('SrcNam').AsString := pValue;
end;

function TXrglstBtr.ReadValTyp:Str2;
begin
  Result := oBtrTable.FieldByName('ValTyp').AsString;
end;

procedure TXrglstBtr.WriteValTyp(pValue:Str2);
begin
  oBtrTable.FieldByName('ValTyp').AsString := pValue;
end;

function TXrglstBtr.ReadClcVal:double;
begin
  Result := oBtrTable.FieldByName('ClcVal').AsFloat;
end;

procedure TXrglstBtr.WriteClcVal(pValue:double);
begin
  oBtrTable.FieldByName('ClcVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TXrglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TXrglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TXrglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TXrglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TXrglstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TXrglstBtr.LocateDnRnCN (pDocNum:Str12;pRowNum:word;pColNum:word):boolean;
begin
  SetIndex (ixDnRnCN);
  Result := oBtrTable.FindKey([pDocNum,pRowNum,pColNum]);
end;

function TXrglstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TXrglstBtr.NearestDnRnCN (pDocNum:Str12;pRowNum:word;pColNum:word):boolean;
begin
  SetIndex (ixDnRnCN);
  Result := oBtrTable.FindNearest([pDocNum,pRowNum,pColNum]);
end;

procedure TXrglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TXrglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TXrglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TXrglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TXrglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TXrglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TXrglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TXrglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TXrglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TXrglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TXrglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TXrglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TXrglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TXrglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TXrglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TXrglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TXrglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1922001}
