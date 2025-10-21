unit bIMP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItPn = 'DoItPn';
  ixDoIt = 'DoIt';
  ixDocNum = 'DocNum';
  ixGsCode = 'GsCode';
  ixProdNum = 'ProdNum';
  ixSended = 'Sended';

type
  TImpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadProdNum:Str30;         procedure WriteProdNum (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
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
    function LocateDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateProdNum (pProdNum:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestProdNum (pProdNum:Str30):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ProdNum:Str30 read ReadProdNum write WriteProdNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TImpBtr.Create;
begin
  oBtrTable := BtrInit ('IMP',gPath.StkPath,Self);
end;

constructor TImpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IMP',pPath,Self);
end;

destructor TImpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TImpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TImpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TImpBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TImpBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TImpBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TImpBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TImpBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TImpBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImpBtr.ReadProdNum:Str30;
begin
  Result := oBtrTable.FieldByName('ProdNum').AsString;
end;

procedure TImpBtr.WriteProdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ProdNum').AsString := pValue;
end;

function TImpBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TImpBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TImpBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TImpBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TImpBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TImpBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TImpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TImpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TImpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TImpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TImpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TImpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TImpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TImpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TImpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TImpBtr.LocateDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
begin
  SetIndex (ixDoItPn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pProdNum]);
end;

function TImpBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TImpBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TImpBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TImpBtr.LocateProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindKey([pProdNum]);
end;

function TImpBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TImpBtr.NearestDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
begin
  SetIndex (ixDoItPn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pProdNum]);
end;

function TImpBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TImpBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TImpBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TImpBtr.NearestProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindNearest([pProdNum]);
end;

function TImpBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TImpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TImpBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TImpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TImpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TImpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TImpBtr.First;
begin
  oBtrTable.First;
end;

procedure TImpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TImpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TImpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TImpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TImpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TImpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TImpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TImpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TImpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TImpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TImpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
