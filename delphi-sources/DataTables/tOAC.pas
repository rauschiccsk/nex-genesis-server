unit tOAC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPrAsAnVp = '';

type
  TOacTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPreced:Str1;           procedure WritePreced (pValue:Str1);
    function  ReadAccSnt:Str3;           procedure WriteAccSnt (pValue:Str3);
    function  ReadAccAnl:Str6;           procedure WriteAccAnl (pValue:Str6);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadVatGrp:byte;           procedure WriteVatGrp (pValue:byte);
    function  ReadMovVal:double;         procedure WriteMovVal (pValue:double);
    function  ReadOldPay:double;         procedure WriteOldPay (pValue:double);
    function  ReadNpyVal:double;         procedure WriteNpyVal (pValue:double);
    function  ReadActPay:double;         procedure WriteActPay (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadAccVal:double;         procedure WriteAccVal (pValue:double);
    function  ReadAccVat:double;         procedure WriteAccVat (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePrAsAnVp (pPreced:Str1;pAccSnt:Str3;pAccAnl:Str6;pVatPrc:byte):boolean;

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
    property Preced:Str1 read ReadPreced write WritePreced;
    property AccSnt:Str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:Str6 read ReadAccAnl write WriteAccAnl;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property VatGrp:byte read ReadVatGrp write WriteVatGrp;
    property MovVal:double read ReadMovVal write WriteMovVal;
    property OldPay:double read ReadOldPay write WriteOldPay;
    property NpyVal:double read ReadNpyVal write WriteNpyVal;
    property ActPay:double read ReadActPay write WriteActPay;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property AccVal:double read ReadAccVal write WriteAccVal;
    property AccVat:double read ReadAccVat write WriteAccVat;
  end;

implementation

constructor TOacTmp.Create;
begin
  oTmpTable := TmpInit ('OAC',Self);
end;

destructor TOacTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOacTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOacTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOacTmp.ReadPreced:Str1;
begin
  Result := oTmpTable.FieldByName('Preced').AsString;
end;

procedure TOacTmp.WritePreced(pValue:Str1);
begin
  oTmpTable.FieldByName('Preced').AsString := pValue;
end;

function TOacTmp.ReadAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TOacTmp.WriteAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TOacTmp.ReadAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TOacTmp.WriteAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TOacTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TOacTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TOacTmp.ReadVatGrp:byte;
begin
  Result := oTmpTable.FieldByName('VatGrp').AsInteger;
end;

procedure TOacTmp.WriteVatGrp(pValue:byte);
begin
  oTmpTable.FieldByName('VatGrp').AsInteger := pValue;
end;

function TOacTmp.ReadMovVal:double;
begin
  Result := oTmpTable.FieldByName('MovVal').AsFloat;
end;

procedure TOacTmp.WriteMovVal(pValue:double);
begin
  oTmpTable.FieldByName('MovVal').AsFloat := pValue;
end;

function TOacTmp.ReadOldPay:double;
begin
  Result := oTmpTable.FieldByName('OldPay').AsFloat;
end;

procedure TOacTmp.WriteOldPay(pValue:double);
begin
  oTmpTable.FieldByName('OldPay').AsFloat := pValue;
end;

function TOacTmp.ReadNpyVal:double;
begin
  Result := oTmpTable.FieldByName('NpyVal').AsFloat;
end;

procedure TOacTmp.WriteNpyVal(pValue:double);
begin
  oTmpTable.FieldByName('NpyVal').AsFloat := pValue;
end;

function TOacTmp.ReadActPay:double;
begin
  Result := oTmpTable.FieldByName('ActPay').AsFloat;
end;

procedure TOacTmp.WriteActPay(pValue:double);
begin
  oTmpTable.FieldByName('ActPay').AsFloat := pValue;
end;

function TOacTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TOacTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TOacTmp.ReadAccVal:double;
begin
  Result := oTmpTable.FieldByName('AccVal').AsFloat;
end;

procedure TOacTmp.WriteAccVal(pValue:double);
begin
  oTmpTable.FieldByName('AccVal').AsFloat := pValue;
end;

function TOacTmp.ReadAccVat:double;
begin
  Result := oTmpTable.FieldByName('AccVat').AsFloat;
end;

procedure TOacTmp.WriteAccVat(pValue:double);
begin
  oTmpTable.FieldByName('AccVat').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOacTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOacTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOacTmp.LocatePrAsAnVp (pPreced:Str1;pAccSnt:Str3;pAccAnl:Str6;pVatPrc:byte):boolean;
begin
  SetIndex (ixPrAsAnVp);
  Result := oTmpTable.FindKey([pPreced,pAccSnt,pAccAnl,pVatPrc]);
end;

procedure TOacTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOacTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOacTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOacTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOacTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOacTmp.First;
begin
  oTmpTable.First;
end;

procedure TOacTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOacTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOacTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOacTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOacTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOacTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOacTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOacTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOacTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOacTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOacTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
