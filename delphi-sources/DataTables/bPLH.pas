unit bPlh;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = 'GsCode';
  ixCrtUser = 'CrtUser';
  ixCrtDate = 'CrtDate';
  ixStatus = 'Status';
  ixModPrg = 'ModPrg';

type
  TPlhBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadOProfit:double;        procedure WriteOProfit (pValue:double);
    function  ReadOAPrice:double;        procedure WriteOAPrice (pValue:double);
    function  ReadOBPrice:double;        procedure WriteOBPrice (pValue:double);
    function  ReadNProfit:double;        procedure WriteNProfit (pValue:double);
    function  ReadNAPrice:double;        procedure WriteNAPrice (pValue:double);
    function  ReadNBPrice:double;        procedure WriteNBPrice (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadModPrg:Str3;           procedure WriteModPrg (pValue:Str3);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateCrtUser (pCrtUser:Str8):boolean;
    function LocateCrtDate (pCrtDate:TDatetime):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateModPrg (pModPrg:Str3):boolean;
    function NearestCrtDate (pCrtDate:TDatetime):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open(pPlsNum:word);
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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property OProfit:double read ReadOProfit write WriteOProfit;
    property OAPrice:double read ReadOAPrice write WriteOAPrice;
    property OBPrice:double read ReadOBPrice write WriteOBPrice;
    property NProfit:double read ReadNProfit write WriteNProfit;
    property NAPrice:double read ReadNAPrice write WriteNAPrice;
    property NBPrice:double read ReadNBPrice write WriteNBPrice;
    property Status:Str1 read ReadStatus write WriteStatus;
    property ModPrg:Str3 read ReadModPrg write WriteModPrg;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TPlhBtr.Create;
begin
  oBtrTable := BtrInit ('Plh',gPath.StkPath,Self);
end;

destructor  TPlhBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlhBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlhBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPlhBtr.ReadOProfit:double;
begin
  Result := oBtrTable.FieldByName('OProfit').AsFloat;
end;

procedure TPlhBtr.WriteOProfit(pValue:double);
begin
  oBtrTable.FieldByName('OProfit').AsFloat := pValue;
end;

function TPlhBtr.ReadOAPrice:double;
begin
  Result := oBtrTable.FieldByName('OAPrice').AsFloat;
end;

procedure TPlhBtr.WriteOAPrice(pValue:double);
begin
  oBtrTable.FieldByName('OAPrice').AsFloat := pValue;
end;

function TPlhBtr.ReadOBPrice:double;
begin
  Result := oBtrTable.FieldByName('OBPrice').AsFloat;
end;

procedure TPlhBtr.WriteOBPrice(pValue:double);
begin
  oBtrTable.FieldByName('OBPrice').AsFloat := pValue;
end;

function TPlhBtr.ReadNProfit:double;
begin
  Result := oBtrTable.FieldByName('NProfit').AsFloat;
end;

procedure TPlhBtr.WriteNProfit(pValue:double);
begin
  oBtrTable.FieldByName('NProfit').AsFloat := pValue;
end;

function TPlhBtr.ReadNAPrice:double;
begin
  Result := oBtrTable.FieldByName('NAPrice').AsFloat;
end;

procedure TPlhBtr.WriteNAPrice(pValue:double);
begin
  oBtrTable.FieldByName('NAPrice').AsFloat := pValue;
end;

function TPlhBtr.ReadNBPrice:double;
begin
  Result := oBtrTable.FieldByName('NBPrice').AsFloat;
end;

procedure TPlhBtr.WriteNBPrice(pValue:double);
begin
  oBtrTable.FieldByName('NBPrice').AsFloat := pValue;
end;

function TPlhBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TPlhBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TPlhBtr.ReadModPrg:Str3;
begin
  Result := oBtrTable.FieldByName('ModPrg').AsString;
end;

procedure TPlhBtr.WriteModPrg(pValue:Str3);
begin
  oBtrTable.FieldByName('ModPrg').AsString := pValue;
end;

function TPlhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPlhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPlhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPlhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPlhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPlhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlhBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TPlhBtr.LocateCrtUser (pCrtUser:Str8):boolean;
begin
  SetIndex (ixCrtUser);
  Result := oBtrTable.FindKey([pCrtUser]);
end;

function TPlhBtr.LocateCrtDate (pCrtDate:TDatetime):boolean;
begin
  SetIndex (ixCrtDate);
  Result := oBtrTable.FindKey([pCrtDate]);
end;

function TPlhBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TPlhBtr.LocateModPrg (pModPrg:Str3):boolean;
begin
  SetIndex (ixModPrg);
  Result := oBtrTable.FindKey([pModPrg]);
end;

function TPlhBtr.NearestCrtDate (pCrtDate:TDatetime):boolean;
begin
  SetIndex (ixCrtDate);
  Result := oBtrTable.FindNearest([pCrtDate]);
end;

procedure TPlhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlhBtr.Open(pPlsNum:word);
begin
  oBtrTable.Open(pPlsNum);
end;

procedure TPlhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlhBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
