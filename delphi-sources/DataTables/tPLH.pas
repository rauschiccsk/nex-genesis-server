unit tPLH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixGsCode = 'GsCode';
  ixCrtUser = 'CrtUser';
  ixCrtDate = 'CrtDate';
  ixStatus = 'Status';
  ixModPrg = 'ModPrg';

type
  TPlhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadOProfit:double;        procedure WriteOProfit (pValue:double);
    function  ReadOAPrice:double;        procedure WriteOAPrice (pValue:double);
    function  ReadOBPrice:double;        procedure WriteOBPrice (pValue:double);
    function  ReadNProfit:double;        procedure WriteNProfit (pValue:double);
    function  ReadNAPrice:double;        procedure WriteNAPrice (pValue:double);
    function  ReadNBPrice:double;        procedure WriteNBPrice (pValue:double);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadModPrg:Str3;           procedure WriteModPrg (pValue:Str3);
    function  ReadCrtName:Str30;         procedure WriteCrtName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateCrtUser (pCrtUser:Str8):boolean;
    function LocateCrtDate (pCrtDate:TDatetime):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateModPrg (pModPrg:Str3):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property OProfit:double read ReadOProfit write WriteOProfit;
    property OAPrice:double read ReadOAPrice write WriteOAPrice;
    property OBPrice:double read ReadOBPrice write WriteOBPrice;
    property NProfit:double read ReadNProfit write WriteNProfit;
    property NAPrice:double read ReadNAPrice write WriteNAPrice;
    property NBPrice:double read ReadNBPrice write WriteNBPrice;
    property Status:Str1 read ReadStatus write WriteStatus;
    property ModPrg:Str3 read ReadModPrg write WriteModPrg;
    property CrtName:Str30 read ReadCrtName write WriteCrtName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TPlhTmp.Create;
begin
  oTmpTable := TmpInit ('PLH',Self);
end;

destructor TPlhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPlhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPlhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPlhTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TPlhTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TPlhTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TPlhTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPlhTmp.ReadOProfit:double;
begin
  Result := oTmpTable.FieldByName('OProfit').AsFloat;
end;

procedure TPlhTmp.WriteOProfit(pValue:double);
begin
  oTmpTable.FieldByName('OProfit').AsFloat := pValue;
end;

function TPlhTmp.ReadOAPrice:double;
begin
  Result := oTmpTable.FieldByName('OAPrice').AsFloat;
end;

procedure TPlhTmp.WriteOAPrice(pValue:double);
begin
  oTmpTable.FieldByName('OAPrice').AsFloat := pValue;
end;

function TPlhTmp.ReadOBPrice:double;
begin
  Result := oTmpTable.FieldByName('OBPrice').AsFloat;
end;

procedure TPlhTmp.WriteOBPrice(pValue:double);
begin
  oTmpTable.FieldByName('OBPrice').AsFloat := pValue;
end;

function TPlhTmp.ReadNProfit:double;
begin
  Result := oTmpTable.FieldByName('NProfit').AsFloat;
end;

procedure TPlhTmp.WriteNProfit(pValue:double);
begin
  oTmpTable.FieldByName('NProfit').AsFloat := pValue;
end;

function TPlhTmp.ReadNAPrice:double;
begin
  Result := oTmpTable.FieldByName('NAPrice').AsFloat;
end;

procedure TPlhTmp.WriteNAPrice(pValue:double);
begin
  oTmpTable.FieldByName('NAPrice').AsFloat := pValue;
end;

function TPlhTmp.ReadNBPrice:double;
begin
  Result := oTmpTable.FieldByName('NBPrice').AsFloat;
end;

procedure TPlhTmp.WriteNBPrice(pValue:double);
begin
  oTmpTable.FieldByName('NBPrice').AsFloat := pValue;
end;

function TPlhTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TPlhTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TPlhTmp.ReadModPrg:Str3;
begin
  Result := oTmpTable.FieldByName('ModPrg').AsString;
end;

procedure TPlhTmp.WriteModPrg(pValue:Str3);
begin
  oTmpTable.FieldByName('ModPrg').AsString := pValue;
end;

function TPlhTmp.ReadCrtName:Str30;
begin
  Result := oTmpTable.FieldByName('CrtName').AsString;
end;

procedure TPlhTmp.WriteCrtName(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtName').AsString := pValue;
end;

function TPlhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPlhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPlhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPlhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPlhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPlhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPlhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPlhTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TPlhTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TPlhTmp.LocateCrtUser (pCrtUser:Str8):boolean;
begin
  SetIndex (ixCrtUser);
  Result := oTmpTable.FindKey([pCrtUser]);
end;

function TPlhTmp.LocateCrtDate (pCrtDate:TDatetime):boolean;
begin
  SetIndex (ixCrtDate);
  Result := oTmpTable.FindKey([pCrtDate]);
end;

function TPlhTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

function TPlhTmp.LocateModPrg (pModPrg:Str3):boolean;
begin
  SetIndex (ixModPrg);
  Result := oTmpTable.FindKey([pModPrg]);
end;

procedure TPlhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPlhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPlhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPlhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPlhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPlhTmp.First;
begin
  oTmpTable.First;
end;

procedure TPlhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPlhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPlhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPlhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPlhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPlhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPlhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPlhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPlhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPlhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPlhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
