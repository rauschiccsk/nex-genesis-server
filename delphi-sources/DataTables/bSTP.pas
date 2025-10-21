unit bSTP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsPn = 'GsPn';
  ixGsCode = 'GsCode';
  ixGsSt = 'GsSt';
  ixProdNum = 'ProdNum';
  ixInDoIt = 'InDoIt';
  ixOutDoIt = 'OutDoIt';
  ixSended = 'Sended';

type
  TStpBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oStkNum: integer;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadProdNum:Str30;         procedure WriteProdNum (pValue:Str30);
    function  ReadInDocDate:TDatetime;   procedure WriteInDocDate (pValue:TDatetime);
    function  ReadInDocNum:Str12;        procedure WriteInDocNum (pValue:Str12);
    function  ReadInItmNum:word;         procedure WriteInItmNum (pValue:word);
    function  ReadInFifNum:longint;      procedure WriteInFifNum (pValue:longint);
    function  ReadOutDocDate:TDatetime;  procedure WriteOutDocDate (pValue:TDatetime);
    function  ReadOutDocNum:Str12;       procedure WriteOutDocNum (pValue:Str12);
    function  ReadOutItmNum:word;        procedure WriteOutItmNum (pValue:word);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
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
    function LocateGsPn (pGsCode:longint;pProdNum:Str30):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function LocateProdNum (pProdNum:Str30):boolean;
    function LocateInDoIt (pInDocNum:Str12;pInItmNum:word):boolean;
    function LocateOutDoIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestGsPn (pGsCode:longint;pProdNum:Str30):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsSt (pGsCode:longint;pStatus:Str1):boolean;
    function NearestProdNum (pProdNum:Str30):boolean;
    function NearestInDoIt (pInDocNum:Str12;pInItmNum:word):boolean;
    function NearestOutDoIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
    function NearestSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pStkNum:integer);
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property ProdNum:Str30 read ReadProdNum write WriteProdNum;
    property InDocDate:TDatetime read ReadInDocDate write WriteInDocDate;
    property InDocNum:Str12 read ReadInDocNum write WriteInDocNum;
    property InItmNum:word read ReadInItmNum write WriteInItmNum;
    property InFifNum:longint read ReadInFifNum write WriteInFifNum;
    property OutDocDate:TDatetime read ReadOutDocDate write WriteOutDocDate;
    property OutDocNum:Str12 read ReadOutDocNum write WriteOutDocNum;
    property OutItmNum:word read ReadOutItmNum write WriteOutItmNum;
    property Status:Str1 read ReadStatus write WriteStatus;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TStpBtr.Create;
begin
  oBtrTable := BtrInit ('STP',gPath.StkPath,Self);
end;

constructor TStpBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STP',pPath,Self);
end;

destructor TStpBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStpBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TStpBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TStpBtr.ReadProdNum:Str30;
begin
  Result := oBtrTable.FieldByName('ProdNum').AsString;
end;

procedure TStpBtr.WriteProdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ProdNum').AsString := pValue;
end;

function TStpBtr.ReadInDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('InDocDate').AsDateTime;
end;

procedure TStpBtr.WriteInDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('InDocDate').AsDateTime := pValue;
end;

function TStpBtr.ReadInDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('InDocNum').AsString;
end;

procedure TStpBtr.WriteInDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('InDocNum').AsString := pValue;
end;

function TStpBtr.ReadInItmNum:word;
begin
  Result := oBtrTable.FieldByName('InItmNum').AsInteger;
end;

procedure TStpBtr.WriteInItmNum(pValue:word);
begin
  oBtrTable.FieldByName('InItmNum').AsInteger := pValue;
end;

function TStpBtr.ReadInFifNum:longint;
begin
  Result := oBtrTable.FieldByName('InFifNum').AsInteger;
end;

procedure TStpBtr.WriteInFifNum(pValue:longint);
begin
  oBtrTable.FieldByName('InFifNum').AsInteger := pValue;
end;

function TStpBtr.ReadOutDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('OutDocDate').AsDateTime;
end;

procedure TStpBtr.WriteOutDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OutDocDate').AsDateTime := pValue;
end;

function TStpBtr.ReadOutDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('OutDocNum').AsString;
end;

procedure TStpBtr.WriteOutDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OutDocNum').AsString := pValue;
end;

function TStpBtr.ReadOutItmNum:word;
begin
  Result := oBtrTable.FieldByName('OutItmNum').AsInteger;
end;

procedure TStpBtr.WriteOutItmNum(pValue:word);
begin
  oBtrTable.FieldByName('OutItmNum').AsInteger := pValue;
end;

function TStpBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TStpBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TStpBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TStpBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TStpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStpBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TStpBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStpBtr.LocateGsPn (pGsCode:longint;pProdNum:Str30):boolean;
begin
  SetIndex (ixGsPn);
  Result := oBtrTable.FindKey([pGsCode,pProdNum]);
end;

function TStpBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TStpBtr.LocateGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oBtrTable.FindKey([pGsCode,pStatus]);
end;

function TStpBtr.LocateProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindKey([pProdNum]);
end;

function TStpBtr.LocateInDoIt (pInDocNum:Str12;pInItmNum:word):boolean;
begin
  SetIndex (ixInDoIt);
  Result := oBtrTable.FindKey([pInDocNum,pInItmNum]);
end;

function TStpBtr.LocateOutDoIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
begin
  SetIndex (ixOutDoIt);
  Result := oBtrTable.FindKey([pOutDocNum,pOutItmNum]);
end;

function TStpBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TStpBtr.NearestGsPn (pGsCode:longint;pProdNum:Str30):boolean;
begin
  SetIndex (ixGsPn);
  Result := oBtrTable.FindNearest([pGsCode,pProdNum]);
end;

function TStpBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TStpBtr.NearestGsSt (pGsCode:longint;pStatus:Str1):boolean;
begin
  SetIndex (ixGsSt);
  Result := oBtrTable.FindNearest([pGsCode,pStatus]);
end;

function TStpBtr.NearestProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindNearest([pProdNum]);
end;

function TStpBtr.NearestInDoIt (pInDocNum:Str12;pInItmNum:word):boolean;
begin
  SetIndex (ixInDoIt);
  Result := oBtrTable.FindNearest([pInDocNum,pInItmNum]);
end;

function TStpBtr.NearestOutDoIt (pOutDocNum:Str12;pOutItmNum:word):boolean;
begin
  SetIndex (ixOutDoIt);
  Result := oBtrTable.FindNearest([pOutDocNum,pOutItmNum]);
end;

function TStpBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TStpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStpBtr.Open(pStkNum:integer);
begin
  oStkNum := pStkNum;
  oBtrTable.Open(pStkNum);
end;

procedure TStpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStpBtr.First;
begin
  oBtrTable.First;
end;

procedure TStpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
