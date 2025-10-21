unit bTcp;

interface

uses
  IcTypes, NexPath, NexGlob,
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
  TTcpBtr = class (TComponent)
    constructor Create;
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
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateProdNum (pProdNum:Str30):boolean;
    function LocateSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
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

constructor TTcpBtr.Create;
begin
  oBtrTable := BtrInit ('Tcp',gPath.StkPath,Self);
end;

destructor  TTcpBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTcpBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTcpBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTcpBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTcpBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTcpBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTcpBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTcpBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTcpBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTcpBtr.ReadProdNum:Str30;
begin
  Result := oBtrTable.FieldByName('ProdNum').AsString;
end;

procedure TTcpBtr.WriteProdNum(pValue:Str30);
begin
  oBtrTable.FieldByName('ProdNum').AsString := pValue;
end;

function TTcpBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TTcpBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TTcpBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTcpBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTcpBtr.ReadSended:boolean;
begin
  Result := oBtrTable.FieldByName('Sended').AsBoolean;
end;

procedure TTcpBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsBoolean := pValue;
end;

function TTcpBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTcpBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTcpBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTcpBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTcpBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTcpBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTcpBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTcpBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTcpBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTcpBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTcpBtr.LocateDoItPn (pDocNum:Str12;pItmNum:word;pProdNum:Str30):boolean;
begin
  SetIndex (ixDoItPn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pProdNum]);
end;

function TTcpBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTcpBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TTcpBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TTcpBtr.LocateProdNum (pProdNum:Str30):boolean;
begin
  SetIndex (ixProdNum);
  Result := oBtrTable.FindKey([pProdNum]);
end;

function TTcpBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

procedure TTcpBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTcpBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTcpBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTcpBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTcpBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTcpBtr.First;
begin
  oBtrTable.First;
end;

procedure TTcpBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTcpBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTcpBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTcpBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTcpBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTcpBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTcpBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTcpBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTcpBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTcpBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTcpBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
