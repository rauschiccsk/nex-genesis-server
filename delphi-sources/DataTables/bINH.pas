unit bINH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMsgDat = 'MsgDat';
  ixMsgDes = 'MsgDes';
  ixWhatis = 'Whatis';
  ixPriori = 'Priori';
  ixPrjCod = 'PrjCod';

type
  TInhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMsgDat:TDatetime;      procedure WriteMsgDat (pValue:TDatetime);
    function  ReadMsgDes:Str200;         procedure WriteMsgDes (pValue:Str200);
    function  ReadMsgDes_:Str50;         procedure WriteMsgDes_ (pValue:Str50);
    function  ReadWhatis:Str1;           procedure WriteWhatis (pValue:Str1);
    function  ReadPriori:Str1;           procedure WritePriori (pValue:Str1);
    function  ReadPrjCod:Str30;          procedure WritePrjCod (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMsgDat (pMsgDat:TDatetime):boolean;
    function LocateMsgDes (pMsgDes_:Str50):boolean;
    function LocateWhatis (pWhatis:Str1):boolean;
    function LocatePriori (pPriori:Str1):boolean;
    function LocatePrjCod (pPrjCod:Str30):boolean;
    function NearestMsgDat (pMsgDat:TDatetime):boolean;
    function NearestMsgDes (pMsgDes_:Str50):boolean;
    function NearestWhatis (pWhatis:Str1):boolean;
    function NearestPriori (pPriori:Str1):boolean;
    function NearestPrjCod (pPrjCod:Str30):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property MsgDat:TDatetime read ReadMsgDat write WriteMsgDat;
    property MsgDes:Str200 read ReadMsgDes write WriteMsgDes;
    property MsgDes_:Str50 read ReadMsgDes_ write WriteMsgDes_;
    property Whatis:Str1 read ReadWhatis write WriteWhatis;
    property Priori:Str1 read ReadPriori write WritePriori;
    property PrjCod:Str30 read ReadPrjCod write WritePrjCod;
  end;

implementation

constructor TInhBtr.Create;
begin
  oBtrTable := BtrInit ('INH',gPath.MgdPath,Self);
end;

constructor TInhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('INH',pPath,Self);
end;

destructor TInhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TInhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TInhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TInhBtr.ReadMsgDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('MsgDat').AsDateTime;
end;

procedure TInhBtr.WriteMsgDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('MsgDat').AsDateTime := pValue;
end;

function TInhBtr.ReadMsgDes:Str200;
begin
  Result := oBtrTable.FieldByName('MsgDes').AsString;
end;

procedure TInhBtr.WriteMsgDes(pValue:Str200);
begin
  oBtrTable.FieldByName('MsgDes').AsString := pValue;
end;

function TInhBtr.ReadMsgDes_:Str50;
begin
  Result := oBtrTable.FieldByName('MsgDes_').AsString;
end;

procedure TInhBtr.WriteMsgDes_(pValue:Str50);
begin
  oBtrTable.FieldByName('MsgDes_').AsString := pValue;
end;

function TInhBtr.ReadWhatis:Str1;
begin
  Result := oBtrTable.FieldByName('Whatis').AsString;
end;

procedure TInhBtr.WriteWhatis(pValue:Str1);
begin
  oBtrTable.FieldByName('Whatis').AsString := pValue;
end;

function TInhBtr.ReadPriori:Str1;
begin
  Result := oBtrTable.FieldByName('Priori').AsString;
end;

procedure TInhBtr.WritePriori(pValue:Str1);
begin
  oBtrTable.FieldByName('Priori').AsString := pValue;
end;

function TInhBtr.ReadPrjCod:Str30;
begin
  Result := oBtrTable.FieldByName('PrjCod').AsString;
end;

procedure TInhBtr.WritePrjCod(pValue:Str30);
begin
  oBtrTable.FieldByName('PrjCod').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TInhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TInhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TInhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TInhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TInhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TInhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TInhBtr.LocateMsgDat (pMsgDat:TDatetime):boolean;
begin
  SetIndex (ixMsgDat);
  Result := oBtrTable.FindKey([pMsgDat]);
end;

function TInhBtr.LocateMsgDes (pMsgDes_:Str50):boolean;
begin
  SetIndex (ixMsgDes);
  Result := oBtrTable.FindKey([StrToAlias(pMsgDes_)]);
end;

function TInhBtr.LocateWhatis (pWhatis:Str1):boolean;
begin
  SetIndex (ixWhatis);
  Result := oBtrTable.FindKey([pWhatis]);
end;

function TInhBtr.LocatePriori (pPriori:Str1):boolean;
begin
  SetIndex (ixPriori);
  Result := oBtrTable.FindKey([pPriori]);
end;

function TInhBtr.LocatePrjCod (pPrjCod:Str30):boolean;
begin
  SetIndex (ixPrjCod);
  Result := oBtrTable.FindKey([pPrjCod]);
end;

function TInhBtr.NearestMsgDat (pMsgDat:TDatetime):boolean;
begin
  SetIndex (ixMsgDat);
  Result := oBtrTable.FindNearest([pMsgDat]);
end;

function TInhBtr.NearestMsgDes (pMsgDes_:Str50):boolean;
begin
  SetIndex (ixMsgDes);
  Result := oBtrTable.FindNearest([pMsgDes_]);
end;

function TInhBtr.NearestWhatis (pWhatis:Str1):boolean;
begin
  SetIndex (ixWhatis);
  Result := oBtrTable.FindNearest([pWhatis]);
end;

function TInhBtr.NearestPriori (pPriori:Str1):boolean;
begin
  SetIndex (ixPriori);
  Result := oBtrTable.FindNearest([pPriori]);
end;

function TInhBtr.NearestPrjCod (pPrjCod:Str30):boolean;
begin
  SetIndex (ixPrjCod);
  Result := oBtrTable.FindNearest([pPrjCod]);
end;

procedure TInhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TInhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TInhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TInhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TInhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TInhBtr.First;
begin
  oBtrTable.First;
end;

procedure TInhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TInhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TInhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TInhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TInhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TInhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TInhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TInhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TInhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TInhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TInhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
