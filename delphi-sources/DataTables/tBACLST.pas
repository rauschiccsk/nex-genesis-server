unit tBACLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixContoNum = 'ContoNum';

type
  TBaclstTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadContoNum:Str30;        procedure WriteContoNum (pValue:Str30);
    function  ReadBankCode:Str15;        procedure WriteBankCode (pValue:Str15);
    function  ReadBankName:Str30;        procedure WriteBankName (pValue:Str30);
    function  ReadBankSeat:Str30;        procedure WriteBankSeat (pValue:Str30);
    function  ReadDefault:Str1;          procedure WriteDefault (pValue:Str1);
    function  ReadIbanCode:Str30;        procedure WriteIbanCode (pValue:Str30);
    function  ReadSwftCode:Str10;        procedure WriteSwftCode (pValue:Str10);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;
    function LocateContoNum (pContoNum:Str30):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property ContoNum:Str30 read ReadContoNum write WriteContoNum;
    property BankCode:Str15 read ReadBankCode write WriteBankCode;
    property BankName:Str30 read ReadBankName write WriteBankName;
    property BankSeat:Str30 read ReadBankSeat write WriteBankSeat;
    property Default:Str1 read ReadDefault write WriteDefault;
    property IbanCode:Str30 read ReadIbanCode write WriteIbanCode;
    property SwftCode:Str10 read ReadSwftCode write WriteSwftCode;
  end;

implementation

constructor TBaclstTmp.Create;
begin
  oTmpTable := TmpInit ('BACLST',Self);
end;

destructor TBaclstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TBaclstTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TBaclstTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TBaclstTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TBaclstTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TBaclstTmp.ReadContoNum:Str30;
begin
  Result := oTmpTable.FieldByName('ContoNum').AsString;
end;

procedure TBaclstTmp.WriteContoNum(pValue:Str30);
begin
  oTmpTable.FieldByName('ContoNum').AsString := pValue;
end;

function TBaclstTmp.ReadBankCode:Str15;
begin
  Result := oTmpTable.FieldByName('BankCode').AsString;
end;

procedure TBaclstTmp.WriteBankCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BankCode').AsString := pValue;
end;

function TBaclstTmp.ReadBankName:Str30;
begin
  Result := oTmpTable.FieldByName('BankName').AsString;
end;

procedure TBaclstTmp.WriteBankName(pValue:Str30);
begin
  oTmpTable.FieldByName('BankName').AsString := pValue;
end;

function TBaclstTmp.ReadBankSeat:Str30;
begin
  Result := oTmpTable.FieldByName('BankSeat').AsString;
end;

procedure TBaclstTmp.WriteBankSeat(pValue:Str30);
begin
  oTmpTable.FieldByName('BankSeat').AsString := pValue;
end;

function TBaclstTmp.ReadDefault:Str1;
begin
  Result := oTmpTable.FieldByName('Default').AsString;
end;

procedure TBaclstTmp.WriteDefault(pValue:Str1);
begin
  oTmpTable.FieldByName('Default').AsString := pValue;
end;

function TBaclstTmp.ReadIbanCode:Str30;
begin
  Result := oTmpTable.FieldByName('IbanCode').AsString;
end;

procedure TBaclstTmp.WriteIbanCode(pValue:Str30);
begin
  oTmpTable.FieldByName('IbanCode').AsString := pValue;
end;

function TBaclstTmp.ReadSwftCode:Str10;
begin
  Result := oTmpTable.FieldByName('SwftCode').AsString;
end;

procedure TBaclstTmp.WriteSwftCode(pValue:Str10);
begin
  oTmpTable.FieldByName('SwftCode').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TBaclstTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TBaclstTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TBaclstTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TBaclstTmp.LocateContoNum (pContoNum:Str30):boolean;
begin
  SetIndex (ixContoNum);
  Result := oTmpTable.FindKey([pContoNum]);
end;

procedure TBaclstTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TBaclstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TBaclstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TBaclstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TBaclstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TBaclstTmp.First;
begin
  oTmpTable.First;
end;

procedure TBaclstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TBaclstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TBaclstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TBaclstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TBaclstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TBaclstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TBaclstTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TBaclstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TBaclstTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TBaclstTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TBaclstTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2005001}
