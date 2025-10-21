unit bOMP;

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
  TOmpBtr = class (TComponent)
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

constructor TOmpBtr.Create;
begin
  oBtrTable := BtrInit ('OMP',gPath.StkPath,Self);
end;

constructor TOmpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OMP',pPath,Self);
end;

destructor TOmpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOmpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOmpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOmpBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOmpBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOmpBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOmpBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOmpBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOmpBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOmpBtr.ReadProdNum:Str30;
begin
  Result := oBtrTable.FieldByName('ProdNum').AsString;
end;

procedure TOmpBtr.WriteProdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ProdNum').AsString := pValue;
end;

function TOmpBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TOmpBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TOmpBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TOmpBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOmpBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TOmpBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TOmpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOmpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOmpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOmpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOmpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOmpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOmpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOmpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOmpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOmpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOmpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOmpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOmpBtr.LocateDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
begin
  SetIndex (ixDoItPn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pProdNum]);
end;

function TOmpBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TOmpBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TOmpBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TOmpBtr.LocateProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindKey([pProdNum]);
end;

function TOmpBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TOmpBtr.NearestDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
begin
  SetIndex (ixDoItPn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pProdNum]);
end;

function TOmpBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TOmpBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TOmpBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TOmpBtr.NearestProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindNearest([pProdNum]);
end;

function TOmpBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TOmpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOmpBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOmpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOmpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOmpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOmpBtr.First;
begin
  oBtrTable.First;
end;

procedure TOmpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOmpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOmpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOmpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOmpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOmpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOmpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOmpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOmpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOmpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOmpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
