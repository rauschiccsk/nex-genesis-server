unit bFSADAY;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBnAd = 'BnAd';
  ixBokNum = 'BokNum';
  ixAccDate = 'AccDate';

type
  TFsadayBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:word;           procedure WriteBokNum (pValue:word);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadBuyVal:double;         procedure WriteBuyVal (pValue:double);
    function  ReadSalVal:double;         procedure WriteSalVal (pValue:double);
    function  ReadOvrVal:double;         procedure WriteOvrVal (pValue:double);
    function  ReadPrfVal:double;         procedure WritePrfVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBnAd (pBokNum:word;pAccDate:TDatetime):boolean;
    function LocateBokNum (pBokNum:word):boolean;
    function LocateAccDate (pAccDate:TDatetime):boolean;
    function NearestBnAd (pBokNum:word;pAccDate:TDatetime):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestAccDate (pAccDate:TDatetime):boolean;

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
    property BokNum:word read ReadBokNum write WriteBokNum;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property BuyVal:double read ReadBuyVal write WriteBuyVal;
    property SalVal:double read ReadSalVal write WriteSalVal;
    property OvrVal:double read ReadOvrVal write WriteOvrVal;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
  end;

implementation

constructor TFsadayBtr.Create;
begin
  oBtrTable := BtrInit ('FSADAY',gPath.CdwPath,Self);
end;

constructor TFsadayBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSADAY',pPath,Self);
end;

destructor TFsadayBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsadayBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsadayBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsadayBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsadayBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsadayBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TFsadayBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TFsadayBtr.ReadBuyVal:double;
begin
  Result := oBtrTable.FieldByName('BuyVal').AsFloat;
end;

procedure TFsadayBtr.WriteBuyVal(pValue:double);
begin
  oBtrTable.FieldByName('BuyVal').AsFloat := pValue;
end;

function TFsadayBtr.ReadSalVal:double;
begin
  Result := oBtrTable.FieldByName('SalVal').AsFloat;
end;

procedure TFsadayBtr.WriteSalVal(pValue:double);
begin
  oBtrTable.FieldByName('SalVal').AsFloat := pValue;
end;

function TFsadayBtr.ReadOvrVal:double;
begin
  Result := oBtrTable.FieldByName('OvrVal').AsFloat;
end;

procedure TFsadayBtr.WriteOvrVal(pValue:double);
begin
  oBtrTable.FieldByName('OvrVal').AsFloat := pValue;
end;

function TFsadayBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TFsadayBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TFsadayBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TFsadayBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsadayBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsadayBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsadayBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsadayBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsadayBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsadayBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsadayBtr.LocateBnAd (pBokNum:word;pAccDate:TDatetime):boolean;
begin
  SetIndex (ixBnAd);
  Result := oBtrTable.FindKey([pBokNum,pAccDate]);
end;

function TFsadayBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsadayBtr.LocateAccDate (pAccDate:TDatetime):boolean;
begin
  SetIndex (ixAccDate);
  Result := oBtrTable.FindKey([pAccDate]);
end;

function TFsadayBtr.NearestBnAd (pBokNum:word;pAccDate:TDatetime):boolean;
begin
  SetIndex (ixBnAd);
  Result := oBtrTable.FindNearest([pBokNum,pAccDate]);
end;

function TFsadayBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsadayBtr.NearestAccDate (pAccDate:TDatetime):boolean;
begin
  SetIndex (ixAccDate);
  Result := oBtrTable.FindNearest([pAccDate]);
end;

procedure TFsadayBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsadayBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsadayBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsadayBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsadayBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsadayBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsadayBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsadayBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsadayBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsadayBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsadayBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsadayBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsadayBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsadayBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsadayBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsadayBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsadayBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
