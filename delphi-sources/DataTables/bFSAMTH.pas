unit bFSAMTH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBnMn = 'BnMn';
  ixBokNum = 'BokNum';
  ixMthNum = 'MthNum';

type
  TFsamthBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBokNum:word;           procedure WriteBokNum (pValue:word);
    function  ReadMthNum:Str5;           procedure WriteMthNum (pValue:Str5);
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
    function LocateBnMn (pBokNum:word;pMthNum:Str5):boolean;
    function LocateBokNum (pBokNum:word):boolean;
    function LocateMthNum (pMthNum:Str5):boolean;
    function NearestBnMn (pBokNum:word;pMthNum:Str5):boolean;
    function NearestBokNum (pBokNum:word):boolean;
    function NearestMthNum (pMthNum:Str5):boolean;

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
    property MthNum:Str5 read ReadMthNum write WriteMthNum;
    property BuyVal:double read ReadBuyVal write WriteBuyVal;
    property SalVal:double read ReadSalVal write WriteSalVal;
    property OvrVal:double read ReadOvrVal write WriteOvrVal;
    property PrfVal:double read ReadPrfVal write WritePrfVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
  end;

implementation

constructor TFsamthBtr.Create;
begin
  oBtrTable := BtrInit ('FSAMTH',gPath.CdwPath,Self);
end;

constructor TFsamthBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FSAMTH',pPath,Self);
end;

destructor TFsamthBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFsamthBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFsamthBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFsamthBtr.ReadBokNum:word;
begin
  Result := oBtrTable.FieldByName('BokNum').AsInteger;
end;

procedure TFsamthBtr.WriteBokNum(pValue:word);
begin
  oBtrTable.FieldByName('BokNum').AsInteger := pValue;
end;

function TFsamthBtr.ReadMthNum:Str5;
begin
  Result := oBtrTable.FieldByName('MthNum').AsString;
end;

procedure TFsamthBtr.WriteMthNum(pValue:Str5);
begin
  oBtrTable.FieldByName('MthNum').AsString := pValue;
end;

function TFsamthBtr.ReadBuyVal:double;
begin
  Result := oBtrTable.FieldByName('BuyVal').AsFloat;
end;

procedure TFsamthBtr.WriteBuyVal(pValue:double);
begin
  oBtrTable.FieldByName('BuyVal').AsFloat := pValue;
end;

function TFsamthBtr.ReadSalVal:double;
begin
  Result := oBtrTable.FieldByName('SalVal').AsFloat;
end;

procedure TFsamthBtr.WriteSalVal(pValue:double);
begin
  oBtrTable.FieldByName('SalVal').AsFloat := pValue;
end;

function TFsamthBtr.ReadOvrVal:double;
begin
  Result := oBtrTable.FieldByName('OvrVal').AsFloat;
end;

procedure TFsamthBtr.WriteOvrVal(pValue:double);
begin
  oBtrTable.FieldByName('OvrVal').AsFloat := pValue;
end;

function TFsamthBtr.ReadPrfVal:double;
begin
  Result := oBtrTable.FieldByName('PrfVal').AsFloat;
end;

procedure TFsamthBtr.WritePrfVal(pValue:double);
begin
  oBtrTable.FieldByName('PrfVal').AsFloat := pValue;
end;

function TFsamthBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TFsamthBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFsamthBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsamthBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFsamthBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFsamthBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFsamthBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFsamthBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFsamthBtr.LocateBnMn (pBokNum:word;pMthNum:Str5):boolean;
begin
  SetIndex (ixBnMn);
  Result := oBtrTable.FindKey([pBokNum,pMthNum]);
end;

function TFsamthBtr.LocateBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindKey([pBokNum]);
end;

function TFsamthBtr.LocateMthNum (pMthNum:Str5):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindKey([pMthNum]);
end;

function TFsamthBtr.NearestBnMn (pBokNum:word;pMthNum:Str5):boolean;
begin
  SetIndex (ixBnMn);
  Result := oBtrTable.FindNearest([pBokNum,pMthNum]);
end;

function TFsamthBtr.NearestBokNum (pBokNum:word):boolean;
begin
  SetIndex (ixBokNum);
  Result := oBtrTable.FindNearest([pBokNum]);
end;

function TFsamthBtr.NearestMthNum (pMthNum:Str5):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindNearest([pMthNum]);
end;

procedure TFsamthBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFsamthBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFsamthBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFsamthBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFsamthBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFsamthBtr.First;
begin
  oBtrTable.First;
end;

procedure TFsamthBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFsamthBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFsamthBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFsamthBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFsamthBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFsamthBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFsamthBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFsamthBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFsamthBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFsamthBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFsamthBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
